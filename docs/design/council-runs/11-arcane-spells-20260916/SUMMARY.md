# Council run — 11-arcane-spells (Wave 3, chapter 2 of 25)

- **Run:** `hol-rulebook/20260916-2002` (engine: `/home/bmoser/repos/synod/scripts/council.py`)
- **Chapter:** `quarto-book/chapters/11-arcane-spells.qmd` (68 cards: 15 cantrips + 53 spells), source registered from `origin/main` (30,304 bytes)
- **Voters:** 7 (librarian, contrarian, researcher, game-architect, author, editor-in-chief, layout-expert) — 7 packets rendered, **7 dispatched**
- **Rounds:** 2 (28 findings in round 1, 12 in round 2)
- **Verdict:** `t-02` **rejected** by quorum (7 refutes vs reject quorum 4); `t-01` and `t-03` **ruled** by blind judge, sealing **r-001** and **r-002**
- **Chain:** `verify` → chain ok, 51 events. Recommendations cross-checked against the sealed ids on `close`.
- **Synthesis:** librarian, confidence 0.8. "Publish chapter 11 once r-001's remaining chapter-local conditions land; do not rebuild it."

## Topics

| topic | state | support | refute |
|---|---|---|---|
| t-01 conformance to the locked conventions | ruled (r-001) | 2 | 3 |
| t-02 internal consistency | rejected | 1 | 6 |
| t-03 cross-chapter canon | ruled (r-002) | 5 | 2 |

## Wall discipline

Every finding was pre-screened **before ingest** at both rounds (10-word verbatim lint against
`problem.md` + the registered source, plus the non-empty `quote_or_excerpt` rule):

- round 1: **28/28 clean** (12 wave-1 files split from member arrays, then e-i-c + researcher + layout + librarian)
- round 2: **12/12 clean**
- `judge-brief`: **exit 0, `wall: clean` on first assembly**, no member rewrites, no re-runs

This is the first run on this chapter where no member had to be re-dispatched for a wall leak.

## What shipped (all merged to `main`)

| PR | scope | before → after |
|---|---|---|
| **#638** | round-1 mechanical suite (f-002, f-004, f-005, f-006+f-010, f-015, f-017, f-018, f-019, f-021, f-024) plus the f-007 default | 22 insertions / 22 deletions, 1 file; 68 cards held; build exit 0, 390 pp |
| **#639** | cross-chapter render residue found by the gates | `Chapter N..` doubled crossrefs **3 → 0**; lowercase `Range: touch` **2 → 0**; 4 files, 5 edits |
| **#640** | f-001: the arcane Protection trio renamed (Glass Aegis / Crystal Aegis / Adamant Aegis) on the primal-twin precedent | 4 line-edits; `Bark Skin` 6 → 3 occurrences (ch12's trio + the ch16 example) |
| **#642** | the sealed rulings' outstanding conditions (r-001 #1/#2/#6, r-002 #4) | 9 line-edits, 1 file; build exit 0, 390 pp |

**Carried to other chapters, by ruling** (not chapter 11's to fix): the DR one-source/duration
carve-out conflict and its five named granters (ch16); the divine plant heading (ch12); the
cantrip/Novice-floor crossing clause (ch10); the two missing book-level definitions (ending an
effect by magic; the header mode word).

## Process notes (what this run taught)

1. **The findings directory was contaminated by a previous run.** `/tmp/hol-council/11-arcane-spells/findings/`
   still held four Sep-12 files from an earlier ch11 council, which the lint/ingest path would have
   picked up as today's findings (two of them cited the retired band set). They were quarantined to
   `_stale-20260912/` before any lint ran. **A per-chapter scratch dir reused across runs is a
   contamination channel; the run dir should own its findings, not `/tmp/<chapter>/`.**
2. **`~/.hermes/scripts/council-tools/prescreen.py` was a stale Aug-25 copy without `--all`.** It
   printed `(no file yet)` for every role and exited 0 — the documented false-clean signature. It was
   replaced with the canonical Sep-15 script from the skill, and the `--all` invocation then linted
   all 12 (round 1) and all 12 (round 2) files. **A clean prescreen is only a gate if the invocation
   can fail.**
3. **Members filed JSON arrays where the tooling expects one finding per file.** The dispatch prompt
   said "one JSON array"; the lint tools and `council.py finding` take one object per file. The arrays
   were split mechanically (content byte-identical) into `<role>-r1-<id>.json`. **Wave 2 onward used
   the one-file-per-finding convention and no splitting was needed.**
4. **Two orchestrator probes were the bug, not the chapter.** A crude "first number on the outcome
   line" extractor reported 9 tier-row mismatches; every one was a push distance, a weight, a
   skeleton count, a DR value or a duration. The damage-specific extractor reports **0** off-row
   triples in ch11 and ch12. (Negative control fires; positive control passes.)
5. **The blind judge's isolation was auditable but not airtight**: its tool trace shows one
   `search_files` call against `/tmp/hol-council` before it settled. Its rulings are grounded in the
   assembled brief, but the leak channel exists — dispatch prompts for a blind judge should carry no
   role attribution anywhere on the filesystem it can reach.
6. **Two `delegate_task` fan-outs exceeded the 420 s tool timeout** while their children kept working;
   both waves completed normally and their files were on disk. Treat the timeout as "dispatched and
   running", not as a failure, and reconcile from the findings directory.

## Trail

- `problem.md` — the decision-oriented statement (3 topics, 14 locked conventions, the cleared list)
- `ledger.jsonl` — the append-only hash-chained record (40 findings, 2 rulings, 4 digests)
- `briefs/round-01/`, `briefs/round-02/` — every voter's packet, as rendered
- `judge/` — the assembled brief, the speaker map and the two sealed rulings
- `report.md`, `recommendation.md` — the engine's report and the librarian's synthesis
- `dispatch/` — the exact dispatch prompts each lens received
- `findings/r1/`, `findings/r2/` — the members' own output files
- `sources/11-arcane-spells` — the registered source (chapter 11 as of `origin/main`)
