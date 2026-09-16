# STAGE 4 — LIBRARIAN SYNTHESIS (the closing recommendation)

You are the **librarian** closing a Synod council run. Read your role card first:
`/home/bmoser/repos/synod/references/roles/librarian.md`

## Inputs (absolute paths — read all of these)

- Problem statement: `/home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/problem.md`
- The ledger: `/home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/ledger.jsonl`
  (49 events: 1 charter, 1 problem, 1 source, 4 digests, 40 findings, 2 rulings)
- The sealed rulings: `/home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/judge/rulings.json`
- The registered source: `/home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/sources/11-arcane-spells`
  (chapter 11 of the book, i.e. `quarto-book/chapters/11-arcane-spells.qmd` on `origin/main`, 1-based lines)
- Output schema: `/home/bmoser/repos/synod/references/schemas/recommendation.schema.json`

**Do NOT read** `judge/speaker_map.json` (it sits beside the files you need and maps speakers back to
roles) or `judge/brief.json`. **Write only ONE file**, the one named below. Never edit
`ledger.jsonl`: a synthesis is an artifact beside the ledger, not an event in it.

## What the run decided (do not re-litigate it)

- `t-02` (internal consistency) is **rejected** — 7 refutes against the reject quorum of 4.
- `t-01` and `t-03` are **ruled** by a blind judge. Two rulings are sealed: **`r-001`** (t-01) and
  **`r-002`** (t-03). Your recommendation must work *within* those rulings.

## Output — exactly these six keys

Write to `/tmp/hol-council/recommendation.json`:

```json
{
  "recommendation": "<one paragraph: the council's closing position on chapter 11>",
  "rationale": "<a paragraph on how the rounds resolved, what was implemented, and what is carried>",
  "resolved": [ {"topic": "t-01", "outcome": "..."}, {"topic": "t-02", "outcome": "..."}, {"topic": "t-03", "outcome": "..."} ],
  "rulings_applied": ["r-001", "r-002"],
  "dissent": [ {"role": "...", "topic": "...", "position": "..."} ],
  "confidence": 0.0
}
```

- **`resolved`**: one entry per topic, each object carrying EXACTLY `topic` and `outcome`
  (`outcome` >= 5 chars). Three entries: t-01, t-02, t-03.
- **`rulings_applied`**: MUST list EVERY sealed ruling id — `["r-001", "r-002"]`. The engine refuses
  the close otherwise.
- **`dissent`**: the surviving minority positions, preserved VERBATIM from the ledger, recorded
  rather than re-litigated. Each object carries EXACTLY `role`, `topic`, `position`
  (`position` >= 5 chars, and quote the member's own wording where you can). An empty array is
  acceptable only if no minority position survived both rounds.
- **`confidence`**: a number 0..1.
- `additionalProperties` is `false` at every level: no extra keys anywhere.

## Context you should carry into `recommendation` and `rationale`

The orchestrator has already implemented and merged the round-1 findings that the rulings confirm
(PR #638 mechanical suite, PR #640 the arcane trio rename) and has a further set of ruling
conditions still to implement post-close (the two off-row figures, the tag-order residue, the
unused header modifiers, the coin-keyed cantrip). Say plainly which items are implemented, which
are the ruling's outstanding conditions, and which are carried to other chapters rather than to
chapter 11 (the DR carve-out paragraph, the divine plant heading, the magic-system cantrip clause,
and the two missing book-level definitions).

## Validate before you report DONE

```bash
python3 -c "
import json, jsonschema
d=json.load(open('/tmp/hol-council/recommendation.json'))
s=json.load(open('/home/bmoser/repos/synod/references/schemas/recommendation.schema.json'))
jsonschema.validate(d,s)
assert set(d)=={'recommendation','rationale','resolved','rulings_applied','dissent','confidence'}, set(d)
assert set(d['rulings_applied'])=={'r-001','r-002'}
assert {r['topic'] for r in d['resolved']}=={'t-01','t-02','t-03'}
print('OK: schema valid, rulings_applied complete, three topics resolved')
"
```

## DONE line

The output path, the exact validation output, and one line per resolved topic. Work autonomously.
