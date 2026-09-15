# Council run — Heroes of Legend chapter 19, Dungeon Architect's Guide

**Run:** `~/.hermes/councils/hol-rulebook/runs/20260915-0120`
**Engine:** Synod `hol-rulebook` (7 voting members, quorum 4, max_rounds 2)
**Source:** `19-gm-guidance.qmd` (639 lines, sha256 as registered, 49,647 bytes)
**Outcome:** t-03 closed **rejected** on four refutes (terminal); t-01 and t-02 reached the round cap and were ruled by a blind judge, sealing **r-001** and **r-002**. Recommendation confidence 0.84, `chain: ok`, 21 ledger events.
**Implementation:** PR #548 (merged, main `755200e`) — 4 files. Issues #545 (this disposition), #546 (band residue + the Brimstone tier), #547 (card shape).

## Telemetry

| Item | Count |
|---|---|
| Findings | 10 (round 1: 7, round 2: 3) |
| Topics | 3 — t-03 rejected on 4 refutes; t-01 (2 refutes) and t-02 (3 refutes) contested to the judge |
| Rulings | 2 sealed (r-001 t-01, r-002 t-02) |
| Wall rejections | **0** — 10/10 pre-ingest prescreens clean, judge brief wall-clean on first assembly |
| Member rewrites needed | 0 |
| Ledger events | 21 |
| Voters dispatched | all 7 in round 1 (3+3+1 waves), 3 rebuttal lenses in round 2 |

## Findings and disposition

| Id | Lens | Topic | Defect | Disposition |
|---|---|---|---|---|
| f-001 | game-architect | t-01 | `19:600` prints an Adept ability's Strong result as 12 against the live Adept 11; also at `05:635`, `05:637`, `05:659` | MECHANICAL — value class swept (5 figures incl. a Master line printing 21) |
| f-002 | editor-in-chief | t-03 | the long-rest list never restored Grit, though `13:347` restores it on that night's sleep and `21:231` routes readers here | MECHANICAL — bullet added, camping summary mirrored |
| f-003 | layout-expert | t-02 | the ability and gift examples are pipe rows inside `#quote`, so the bars print as literal punctuation (only 2 such sites in the book) | MECHANICAL — reprinted as the owning chapters' row shapes |
| f-004 | contrarian | t-03 | `19:178` makes starvation a rolling check capped at one Bane; `15:298`/`:311` set an escalating ladder ending in death | MECHANICAL — rewritten to the gear chapter's ladder with a pointer |
| f-005 | researcher | t-01 | four commerce phrasings survive the currency removal (`19:79`, `:89`, `:371`, `:509`) | MECHANICAL — rewritten in grant vocabulary |
| f-006 | author | t-03 | the card-format spec omits the Kit field (63 headers carry it) and the Primal Spell kind (9 cards), and over-claims its closed set | MECHANICAL — Kit documented, Primal listed, claim re-scoped |
| f-007 | librarian | t-03 | the Brimstone Burst example asserts a tier the defining chapter denies | MECHANICAL — tier label struck; the card's tier filed as #546 |
| f-008 | researcher | t-01 (round 2) | recomputation corroborated the off-band Strong figures and widened the population to five, naming the two superseded source tables | recorded; drove r-001's sweep condition |
| f-009 | contrarian | t-02 (round 2) | attacked f-003's diagnosis: the bar is the documented separator, and each example instantiates its own format line | recorded; judge exonerated the notation and upheld the rendering defect |
| f-010 | librarian | t-02 (round 2) | canon adjudication: the notation is deliberate, the examples still print a template where a card belongs | recorded; drove r-002 |

**Dissent recorded (1, verbatim in the recommendation):** contrarian on t-02 — the bar-joined examples are the correct published shape for those two formats and the repair direction is wrong.

## Sealed rulings

- **r-001 (t-01)** — the refute position stands: 12 must be reprinted as 11 at `19:600` and at the three matching class-ability lines; the defect is a value class of five tiered Strong figures, not a typo; the two superseded tables that originate it (`22-reference-sheets.qmd`, `06-core-resolution.qmd`) are reconciled in the same repair.
- **r-002 (t-02)** — the bar notation is exonerated and the format lines and field tables stand, but the two examples must be reprinted in the published row shapes their owning chapters use; the section's worked-example count is four.

## Verification

- native-Typst gate `OK - 26 files` (exit 0); build exit 0, 386 pages
- render assertions on the rebuilt PDF: literal pipe rows 0 (negative control: the same probe finds 1 on the pre-change dump), corrected figures and the Grit bullet present, doubled crossref periods 0
- 0 em-dashes in added lines; no retired row left in the four touched files
- the value class was swept as a class and both originating tables reconciled, per r-001 conditions 1-5

## Process notes

1. **The council's disposition plan omitted nothing but chose a repair for the Brimstone label that would have created a new contradiction.** Changing the label to "Adept" while the example prints the Novice row would have contradicted `19:559`'s own table nine lines above. The example's tier label was struck instead (the librarian's own recorded alternative), because the card's tier is genuinely split across chapters and the documented spell format carries no tier field. Logged as implemented default #121; the reconciliation is #546.
2. **The value class was bigger than the ledger's own count, and the judge said so.** Round 1 recorded four sites; the round-2 researcher found five (adding a Master line printing 21), and the corroborating finding is what carried the sweep condition into r-001.
3. **One dispatched wave timed out at the transport layer while its members finished their work.** All three round-2 findings were on disk when the dispatch call returned an error; the wave was recovered by inspecting the findings directory rather than by re-dispatching, which would have duplicated three members' work.
4. **A lead handed to wave 1 was killed by the lens that tested it**, and the refutation is on the record: the two unreferenced `#label()` anchors in this chapter are not a defect, because 23 of the book's 45 labels are likewise unreferenced.
5. **Two same-class defects were found by the orchestrator while reproducing the ledger's findings** (two numeric roll penalties left in a chapter that uses Banes for exactly that), and are disclosed in the PR body rather than passed off as council findings.
6. Recovered file hygiene: no stray files inside the run dir; the councils root carries no litter. One member wrote a validation scratch file to `/tmp` (outside the run dir, harmless).
