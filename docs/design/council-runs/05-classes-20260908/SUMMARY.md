# Synod run 20260908-2007 — hol-rulebook, 05-classes (Wave 2, chapter 7)

**Verdict:** REJECTED 6-1 (single round; six un-rebutted refutes vs the librarian's support; no judge).
**Chain:** verify → ok (13 events). **Wall rejections:** 0. **Process notes below.**

## Telemetry
- 7 voters, quorum 4, 1 round. All 7 briefs rendered, all 7 dispatched (2 waves of 3 + 1), all 7 findings filed clean on first prescreen (no single-member rewrites).
- Single model (config default) for all roles; decorrelation untested (Q4 caveat, machine-readable in report.md).
- Concluded 2026-09-08 00:25 local; the implementing session was interrupted before shipping anything (an empty branch `fix/council-05-20260908` + worktree were left behind).

## Implementation (completed 2026-09-09, PR #431, issue #430)
The 09-09 walkthrough verified the chain, re-verified every finding against current main (run source byte-identical to the chapter at close time), implemented the full disposition, and merged.
- **TIER 1 (mechanical):** DP carry-over (ch18:39, decision #45); Fear→Frightened ×3; rooted→self-contained; 4 interior pagebreaks removed + 8 class labels → `####` headings (372→368 pages).
- **TIER 2 (substantive):** Swift Blade self-contained (Precise Stab phantom removed, ch02 reconciled); Unmake self-contained (Disintegrate ref removed); archetype-table stale Ability Pool column dropped.
- **TIER 3 (implemented defaults, veto-able):** #79 Turn Unholy→Unholy Word, #80 Fade→Phantom Step, #81 Immovable→Unshakeable (all 0-collision renames; ch02:373 template mirror included).
- Build exit 0; 0 em-dashes / 0 damage dice / 0 flat riders added; 8 non-Odd classes × exactly 10 rows.

## Open items routed out (not ch05-local)
- **#84 (book-wide theme):** heading-before-table orphaning — the theme's unbreakable table wrap defeats heading keep-with-next; pre-existing on main, 25 candidates book-wide. Theme-level decision for Bruce (three directions in decisions-pending #84).
- **#82 / #83 (book-wide vocabulary):** "Standard+" and "concealment" used but undefined anywhere.
- **VERIFIED NOT finding:** EIC's "demote mindset callouts ## → ###" is a book-wide convention (8 in ch01, 10 in ch19, 25+ in ch15) — not shipped.

## Known limitations
- Single-model homogeneity (Q4).
- The layout lens's pdftotext page refs (p92/p94/...) are from the 09-08 build; the 09-09 build reflows them (labels at p92/94/96/98/100/102/104/106, cost-table heading p112) — same defect, shifted pages.
