# Council Run Summary — ch04 (Ancestries & Cultures) — 2026-09-07

- **Council:** hol-rulebook (7 voters, quorum 4, max 2 rounds)
- **Run dir:** `20260907-2103`
- **Source:** `04-ancestries-cultures` (quarto-book/chapters/04-ancestries-cultures.qmd, 194 lines)
- **Rounds:** 1 (no impasse; round 1 reached reject quorum)
- **Findings:** 7 (all stance=refute)
- **Verdict:** topic t-01 **REJECTED 7-0**, action=recommend
- **Rulings:** none (no impasse, blind judge not convened)
- **Wall rejections:** 1 pre-ingest leak caught (librarian f-001 argument echoed "1 damage tier one row up on the damage budget" from the problem statement) → single-member rewrite (58s) → re-prescreen clean. No judge-brief wall rejection, no re-run.

## Findings (all on t-01)

| id | role | defect | line |
|----|------|--------|------|
| f-001 | librarian | Forge-Trained flat +6 damage rider (ZERO-rider law) + Lucky "extra d6" boon gloss + gift tables lack prereq column | 181 / 92 / 148-193 |
| f-002 | contrarian | Forge-Trained +6 rider breaches budget (9+6=15 off row) and the 04:146 gift ceiling rule | 181 |
| f-003 | researcher | Forge-Trained +6 rider (only surviving flat rider book-wide) + Lucky "extra d6" gloss; flagged ch21:27 companion | 181 / 92 |
| f-004 | game-architect | Forge-Trained +6 rider off-budget (12/15/18 match no row) | 181 |
| f-005 | author | "boon" carries two mechanics in-chapter (Lucky extra-d6 vs 4 gift keywords); noted Second Wind name collision | 92 / 157 |
| f-006 | editor-in-chief | Lucky "extra d6" gloss teaches retired mechanic (ch06:45) | 92 |
| f-007 | layout-expert | figure pinned between two pagebreaks → near-blank PDF p.67 | 96/102 |

## Disposition (librarian synthesis, verified by orchestrator)

**TIER 1 (mechanical) — SHIPPED in PR #397 (merged 2026-09-07):**
- Forge-Trained `+6 damage (flat)` → `deals one damage tier higher` (sanctioned tier-bump convention).
- Lucky `(an extra d6)` parenthetical deleted; boon resolves to ch06:45 (4d6 keep highest three).
- Second Wind (Human gift, 04:157) → **Second Breath** (collision with ch06:145 Critical bonus result; 04:157 is the only ref, clean rename).
- Figure pagebreak: dropped the first of the two pagebreaks flanking the mid-chapter figure; figure now flows with the Halfling text (p.66), p.67 carries Cultures. Verified non-blank in rebuilt PDF (pdftotext).
- **Companion (same vocabulary convention, same glossary):** ch21:27 Boon + ch21:28 Bane "extra d6" glosses removed (Boon self-contradicted on the line).

**TIER 2 (substantive):** none (all fixes chapter-local).

**TIER 3 (design-authority) — OPEN, decisions-pending #78:** the four gift tables (04:148-193) have no Discipline-prerequisite column, but 04:144 says gifts follow the class-ability card format and ch08's ladder requires Adept=2/Master=3 prereqs. Adding 14 prereq cells is a design call (innate gifts may be exempt, but that is unruled). Logged for Bruce.

## Process notes / learnings

- **Harness timeout is expected, not a failure:** `delegate_task` fan-outs of 3 timed out at the 420s tool limit every round, but the subagents kept running to completion. Recovery = `list` to confirm spawn, then poll the findings dir. Dispatched in waves of 3 (respecting the cap) rather than one 7-way call.
- **Verify the counter, not the claim (ch04-specific):** the game-architect reported "gift counts 3/4/3/4" and "Adept/Master prereq shapes verified (exactly 2/exactly 3)" — BOTH were counting artifacts. Actual gift counts are 5/5/5/5, and the gift tables have **no prereq column at all** (so no shape could be verified). The librarian's "missing prereq column" finding was the real one. The orchestrator re-grepped the actual table rows and confirmed before disposition.
- **One defect, two homes:** the "extra d6" boon gloss lived in ch04:92 AND ch21:27 (glossary), and the ch21 Boon line contradicted itself on the same line (claimed extra d6, then said 4d6 keep three). The ch21 Bane line (one below) carried the identical stale gloss. Fixed all in the same PR as the council's vocabulary ruling applied to its mirror.
- **Pagebreak findings need a PDF check:** the layout-expert cited p.67; verified with pdftotext before and after the fix (p.67 went from near-blank to the Cultures section).
- **Two chapters in one run** (pace ruling 2026-08-23): ch03 finished ~16:30 ET with budget to spare, so ch04 was started and completed in the same run. Hard cap = 2; not exceeded.
