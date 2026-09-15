# Council run — 23-license (Wave 2, chapter 25 of 25)

Run `hol-rulebook/20260915-0250`. Council `hol-rulebook`, 7 voters, quorum 4, max 2 rounds.
Engine `/home/bmoser/repos/synod/scripts/council.py`, chain `ok`, 21 events.

**Verdict:** all three topics contested to the round cap → blind judge, which sealed
**r-001 (t-01, sustained)**, **r-002 (t-02, sustained)** and **r-003 (t-03, claim rejected,
defect carried forward)**.

## Open source

| Topic | Question | Outcome |
|---|---|---|
| t-01 | Does every chapter number in the designation resolve, as printed, to the material it means to release? | **defect live.** Spell clause pointed at printed 11/12 (Talents, Magic System) instead of printed 13/14; bestiary clause at printed 20 (Advancement) instead of 22; the range 1-22 stopped two chapters short of the glossary and reference sheets; `Chapter 01b` is a source-file token a reader cannot resolve; the front-matter twin pointed at printed 23 (Glossary) for the licence, printed 25. |
| t-02 | Does the reservation list fail to claim the category its own grant withholds? | **defect live.** The grant withholds "spell names and flavor text"; the flavour half is claimed in the reservation list, the name half was not. |
| t-03 | Do the unlisted typefaces and the vendored package breach an attribution duty? | **no duty breached** (the typefaces are not shipped as software; the vendored package carries its own tracked licence). Carried forward: the lead-in advertised a font inventory the section never gave, and the closing line promised licence texts the tracked tree does not hold. |

## Findings (10)

Round 1 (7): f-001 librarian t-01 refute, f-002 contrarian t-01 refute, f-003 researcher t-03
refute, f-004 game-architect t-01 **support** (enumeration axis cleared), f-005 author t-02
refute, f-006 editor-in-chief t-02 refute, f-007 layout-expert t-02 **support** (render clean,
measured).

Round 2 (3): f-008 librarian t-01 refute (the class is ONE defect with six instances, two
repair kinds), f-009 contrarian t-03 support (attacks both attribution premises), f-010
researcher t-01 refute (re-derived the source-to-print map).

## Process notes

- **7/7 briefs rendered and 7/7 dispatched** (waves of 3 + 3 + 1); `ls briefs/round-NN` reconciled
  against dispatched roles before each round closed.
- **10/10 pre-ingest wall lints clean.** No member rewrite was needed at any point, and
  `judge-brief` was wall-clean on first assembly.
- **One orchestrator error, caught by a lens:** the wave-2 researcher dispatch asked it to
  verify that `:76-78` sits on folio 381. It does not (the Open Game Content Declaration opens
  folio 384) and the researcher refuted the claim. The orchestrator's folio was invented rather
  than measured; the lens was right to reject it.
- **A stale probe, caught by the render:** a heading/folio spot check first reported "MISSING"
  for every chapter because it looked for the Arabic form the Contents uses. Chapter ornaments
  print **roman** (`Chapter XIII`), so the probe was wrong, not the book. Corrected by reading
  the actual page text.
- **Not a defect, do not re-file:** the nine-class reservation list (fixed PR #391), the OGC
  section-2 notice (PR #391), the contact address (row #69), the PI voice line naming both
  descriptors (row #67), `Figure 25.1` with the placeholder-art marker and the duplicate
  `#label(...)` (book conventions), and the resumed licence body, whose fifteen sections and
  eight definition letters the editor-in-chief counted complete.
- Model provenance: single model (charter default, no override), so the run validates the
  pipeline and not model decorrelation.

## Disposition (implemented the same session)

**PR #551** (merged, main `8e5ec48`), 2 files, 7 replacements:

- `23-license`: spell clause → Chapters 13 and 14; bestiary clause → Chapter 22; fiction
  carve-out → Chapter 3; grant range → Chapters 2 through 24 (printed numbering).
- `23-license`: spell names reserved by their own Product Identity item.
- `23-license`: attributions lead-in no longer promises a font inventory; the closing line now
  matches what the tree holds.
- `00-front-matter`: same range, and the licence pointer corrected to Chapter 25.

Build exit 0, native-Typst gate exit 0, 0 em-dashes in added lines, 0 damage dice,
render-verified on folios 379-386.

## Defect found by the run and fixed separately

**PR #553** (merged, main after #551) closes **issue #552**: the printed Contents page carried a
number column one greater than the chapter number on all 25 rows. The researcher lens surfaced
it while re-deriving the printed numbering. Verified as a regression against the
`draft-2026-08-19` release PDF (25 rows, 0 mismatched there). Cause: the #467 counter-undo moved
after the `chapter()` call, which left `counter(heading)` at the internal heading's own position
one high, and orange-book's `my-outline.typ` prints an entry number whenever the heading element
carries a numbering setting. Fixed by stamping `numbering: none` on the internal heading, which
stops the counter step, so the undo could be removed altogether. `check-toc-folios.py` 203/203,
all rendered crossref numbers remain in 1..25, page count unchanged at 386.
