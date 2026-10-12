# HOL council — ROUND 2 (rebuttal round), lens: contrarian

Round 1 is complete: **28 findings from all seven voters**. The engine reports:

| topic | state | support | refute | un-rebutted refutes |
|---|---|---|---|---|
| t-01 conformance to the locked conventions | contested | 1 | 3 | f-005, f-006, f-009, f-010, f-021 |
| t-02 internal consistency | **rejected** (terminal, 6 >= reject quorum 4) | 1 | 6 | f-002, f-004, f-007, f-011, f-013, f-014, f-018, f-019, f-023, f-024 |
| t-03 cross-chapter canon | contested | 5 | 2 | f-001, f-003, f-008, f-015, f-017 |

## Your job in this round

This is a **rebuttal round**: you test the LEDGER, you do not re-derive the chapter from scratch.

- Read your **round-2 packet**: `/home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/briefs/round-02/contrarian.json`
  It carries every round-1 finding with its ledger id, the problem statement and the source.
- The **TWO terminal states still open are `t-01` and `t-03`.** `t-02` is already rejected and is
  closed: do not spend a finding on it unless you can show a t-02 refute is wrong.
- **Cite the round-1 ids you are addressing in `rebutting`.** A refute that is rebutted stops
  blocking its topic; that is the only mechanism that can resolve t-01 and t-03. Your `stance`
  is scoped to the **topic**, your `rebutting` array to the **findings** — they routinely point
  opposite ways, and that is expected.
- File your finding(s) at `/tmp/hol-council/11-arcane-spells/findings/r2/contrarian-r2-<id>.json`,
  **one finding object per file**, keys exactly:
  `id`, `round` (=2), `role`, `topic`, `stance`, `argument`, `evidence`, `confidence`, `rebutting`.
  Each `evidence` item: exactly `source`, `claim`, `quote_or_excerpt` (non-empty).
- **WALL**: `argument` and every `evidence[].claim` must share NO run of 10+ consecutive words with
  the problem statement or the chapter text. Verbatim only inside `quote_or_excerpt` (<= ~12 words).

## Ground truth the orchestrator has already established (treat as settled unless you can BREAK it)

1. **`f-008` is REFUTED.** The chapter that owns DR states that sources do not add and that the
   highest single source governs (`16-armor-shields.qmd:23`), and its worked example at
   `16-armor-shields.qmd:33` uses the middle ward of this very ladder by name and takes the larger
   single number. This chapter's Protection preamble agrees with it. The run's own `f-012` reached
   the same conclusion. The live residual question is a different one: `16-armor-shields.qmd:29`
   says DR from an ability with a stated duration DOES add, and a ward has a stated duration.
   **If you can break this refutation, do it and say so; if you cannot, rebut `f-008` explicitly.**
2. **`f-009` is REFUTED as a budget defect.** `12-divine-spells.qmd:63` prints the same shape (a
   1-point rider on a spell card), so a small persistent rider is house practice, not an off-row
   figure. Verify that comparand yourself and rebut or break it.
3. **`f-003`'s headline over-reaches.** A book-wide census of all 196 `Keywords:` fields yields 68
   distinct tags; chapter-private tags are normal (ch12 has 14, ch09 about 20). The defensible
   residue is narrower: tags used exactly once book-wide, `Utility` naming a category, `Ward`
   colliding with the DR meaning, and inconsistent tag order.
4. **`f-013` is refuted by the owning chapter**: `19-gm-guidance.qmd` documents the `Requires`
   field as one many published cards omit.
5. **Already implemented and merged to main** (PR #638, commit de58925), so a t-01/t-03 refute
   that rests on the pre-fix text no longer describes the book: `f-004`, `f-005`, `f-006`+`f-010`,
   `f-015`, `f-017`, `f-018`, `f-019`, `f-021`, `f-024`, and `f-002` (tags struck). `f-007` was
   implemented as a veto-revertible default (one lasting cantrip working at a time).
   **A rebuttal that says "this is already fixed" must say so with the merged text as its
   evidence** — that is a legitimate way to clear a refute.

## Your lens duties this round

- **LIBRARIAN**: corroborate the t-03 and t-01 refutes against canon. For each, say whether the
  refute should stand or fall, and name the terminal state the topic deserves.
- **CONTRARIAN**: attack the load-bearing reasoning. Recompute the arithmetic behind `f-005`
  (Ember Lance's halves) and `f-018` (both duration ladders) yourself, and test whether the
  refutations in 1-4 above are sound or whether the orchestrator has made an error. Nothing passes
  on vibes; a broken refutation is a result.
- **RESEARCHER**: independently recompute the numbers the two contested topics rest on (band rows,
  the ward ladder's ranks-equal-grant relation, the two duration ladders) and the numbers behind
  `f-009` and `f-012`. Cite each computation's output in the evidence.

## Self-audit before you reply

For each file: re-parse it (one object, exact key set, `round: 2`, non-empty `quote_or_excerpt`),
run
```
python3 /home/bmoser/.hermes/skills/autonomous-ai-agents/synod-council-ops/scripts/member-selfcheck.py \
  <your file> /home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/sources/11-arcane-spells \
  /home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/problem.md
```
and your own 10-gram overlap check. Zero overlap required.

## DONE line

File paths; one line per finding (`id [topic] stance — headline — rebutting [ids]`); selfcheck and
overlap results; and every observation you did NOT file, with the reason. Work autonomously.


**Your role card:** `/home/bmoser/repos/synod/references/roles/contrarian.md`
