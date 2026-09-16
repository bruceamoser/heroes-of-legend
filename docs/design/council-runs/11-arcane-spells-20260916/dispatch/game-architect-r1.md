# HOL council — round 1 dispatch (common block)

You are a **VOTING MEMBER** of the `hol-rulebook` Synod council, sitting as the lens named at the
bottom of this file. You audit one chapter of a TTRPG rulebook and file findings that the engine
weighs into a publish/don't-publish verdict.

## Read these first (absolute paths)

1. **Your role card** (your duties and your authority): the path is given below.
2. **Your round-1 packet**: `/home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/briefs/round-01/game-architect.json`
   It carries the problem statement, the registered source, the three topics, the 14 locked
   conventions, the orchestrator's cleared list and the worked leads.
3. **The source under review**: `/home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/sources/11-arcane-spells`
   (that file IS chapter 11 exactly as it stands on `origin/main`; line numbers cited in findings are
   1-based into it).
4. **The problem statement** (same text as in the packet, plain file):
   `/home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/problem.md`

**Reading any OTHER chapter of the book.** The local checkout at `/home/bmoser/repos/heroes-of-legend`
is parked on an old branch with uncommitted edits, so a working-tree read returns a manuscript nobody
is shipping. ALWAYS read the live book:

```
cd /home/bmoser/repos/heroes-of-legend && git show origin/main:quarto-book/chapters/<file>.qmd
git grep -nE '<pattern>' origin/main -- quarto-book/chapters/     # book-wide sweep
```

## Deliverable

File **2 to 4 findings** as ONE JSON ARRAY in ONE file at:

```
/tmp/hol-council/11-arcane-spells/findings/game-architect-r1.json
```

The file must **BE** the array (`[ {...}, {...} ]`), never an object wrapping one.

Each finding object carries EXACTLY these keys (`additionalProperties: false`):

| key | value |
|---|---|
| `id` | `f-901`, `f-902`, ... (a placeholder; the engine re-stamps on ingest, collisions are fine) |
| `round` | `1` |
| `role` | the exact role slug given below |
| `topic` | exactly one of `t-01`, `t-02`, `t-03` |
| `stance` | `"refute"` = your finding shows the chapter FAILS that topic; `"support"` = your finding establishes something is SOUND |
| `argument` | >= 20 chars of plain prose, your position, PARAPHRASED |
| `evidence` | array of objects with EXACTLY `source`, `claim`, `quote_or_excerpt` (all three required, `quote_or_excerpt` minLength 1) |
| `confidence` | 0..1 |
| `rebutting` | optional; use `[]` in round 1 |

- **topic must be a `t-NN` id.** Never a descriptive name, and never `problem-scoping` (that topic
  cannot be sealed and would stall the run).
- **`evidence[].source`** is either the registered source label `11-arcane-spells`, another chapter's
  filename (`16-armor-shields.qmd`, `12-divine-spells.qmd`), or the literal `reasoning`.
- **`quote_or_excerpt`** is a short verbatim excerpt (<= ~12 words) or, for `reasoning`, your worked
  computation. It must never be empty strings.
- **Every claim about the chapter carries a line number**, written as `11-arcane-spells:NNN` inside
  `argument` or `claim`. A finding without a line reference is not auditable and will be discounted.

## WALL DISCIPLINE (load-bearing)

The blind judge never sees the source; it sees only your paraphrased `argument` and every
`evidence[].claim`. Those two fields are wall-linted: **no span of 10 or more consecutive words may
be shared with the problem statement or the chapter text.** Verbatim is allowed ONLY inside
`quote_or_excerpt`. Never paste a sentence from the chapter or the brief into `argument` or `claim`.

## SCOPE LAW (absence claims)

Anything you claim does NOT exist anywhere must be shown by a command actually run **book-wide**
(`git grep -rn ... origin/main -- quarto-book/chapters/`), not merely against this chapter. A
conclusion you could not test is reported as **untested**, never as **absent**.

## Self-audit BEFORE you reply (a leak caught before ingest is free; one caught at the judge brief costs a whole-council re-run)

1. Re-parse your own JSON file; assert each object's key set is exactly the allowed set.
2. Assert every `quote_or_excerpt` is non-empty.
3. Run the member self-check and fix anything it reports:
   ```
   python3 /home/bmoser/.hermes/skills/autonomous-ai-agents/synod-council-ops/scripts/member-selfcheck.py \
     /tmp/hol-council/11-arcane-spells/findings/game-architect-r1.json \
     /home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/sources/11-arcane-spells \
     /home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/problem.md
   ```
4. Run your OWN 10-gram overlap check of `argument` + every `evidence[].claim` against the source and
   the problem statement. Zero shared spans required.

## Your final message (DONE line) must contain

- the count of findings filed;
- one line per finding: `f-NNN [topic] headline — 11-arcane-spells:LINE`;
- the selfcheck exit status and your 10-gram overlap result;
- **every observation you made but did NOT file, and why.** A withheld observation is a real result:
  list it explicitly, including anything you checked and found clean.

You cannot ask questions. Work autonomously and file the file.


## YOUR LENS — game-architect

**Your role card:** `/home/bmoser/repos/synod/references/roles/hol/game-architect.md`

You are the MECHANICS lens. Recompute every number you doubt yourself; never accept a printed row on inspection. Aim hardest at: (a) the DR law as it now stands in `16-armor-shields.qmd:21-33` against this chapter's ward ladder and its "does not stack" lines, including whether the ladder can exceed the ceiling and whether each ward satisfies the ranks-equal-DR rule; (b) the three cards the orchestrator flagged as possibly off-row or missing a figure (Tilt :325-333, Turn the Air :473-481, Ward of Iron :491-500); (c) the `Requires:` tags and the `1/2/3 Protection` keys against the 23-Discipline taxonomy at `08-disciplines.qmd:29-68`; (d) whether the eight Master cards are costed and gated consistently with the one-card law. State, for each finding, the exact arithmetic you ran.
