# Council Run — ch02 (Character Creation), 2026-09-05

- **Council:** hol-rulebook (Synod engine, 7 voters, quorum 4)
- **Run dir:** `~/.hermes/councils/hol-rulebook/runs/20260905-2056`
- **Source:** `quarto-book/chapters/02-character-creation.qmd` (label `02-character-creation`)
- **Verdict:** t-01 **REJECTED 7-0** (all seven voters refute, 0 supports, 0 rebuttals, 0 sealed rulings). Single round (round 1 hit reject quorum; terminal `rejected`, no judge).
- **Confidence:** 0.9 (librarian).
- **Wall rejections:** 0. All 7 findings passed the pre-ingest wall lint clean on first screen; no `judge-brief` wall rejections (no judge needed).
- **Ledger:** 13 events, `verify` chain ok (re-verified 2026-09-06 before implementation).

## Findings (round 1)
| id | role | stance | headline |
|----|------|--------|----------|
| f-001 | librarian | refute | Makeva Movement 30 ft vs 25 ft canon; Sera missing Versatile +1 DP; free-grant duplication hole |
| f-002 | contrarian | refute | retired "+4 bonus damage" rider on Corwin's Edge of Chaos; free-grant duplication as the one genuine rules question |
| f-003 | researcher | refute | Edge of Chaos rider contradicts 05-classes canon (PR #331, weapons rework); tagline truncations |
| f-004 | game-architect | refute | Edge of Chaos rider (flat +4 dead book-wide under the zero-rider law); Makeva Movement |
| f-005 | author | refute | two truncated Vibe-column taglines in Table 2.2 (Blade, Unbalanced) vs ch05 epigraphs |
| f-006 | editor-in-chief | refute | Makeva walkthrough omits Riverfolk's granted Disciplines (table line 89 vs Step 4), irreproducible flagship example |
| f-007 | layout-expert | refute | build-verified (built PDF pages 45/47/49/51): intra-pair bare rules strand second-template headings at page feet; fix = pagebreak before each of the 8 templates |

## Disposition (all implemented, PR #395)
- **TIER 1 mechanical:** (1) Makeva Movement 30 ft -> 25 ft (halfling), matching Table 2.3, ch03:68, sibling Pip template. (2) Four bare intra-pair rules (before Mage: Intellect, Priest: Leader, Thief: Shadow, Fighter: Unbalanced) -> `{{< pagebreak >}}`; all 8 templates now start a fresh page.
- **TIER 2 substantive:** (3) Corwin Edge of Chaos: "+4 bonus damage" -> "+1 damage tier (one row up on the damage budget) but roll on the d6 Backlash Table" (canon ch05, weapons rework). (4) Restored full Blade/Unbalanced taglines in Table 2.2. (5) Sera honors Versatile +1 DP: 8+Know2=10 +1 = 11, all spent (five Novice skills 2 DP + Earth rank 1 Home 1 DP) — an odd pool can only fully spend via a Home rank-1 buy, so 11 = 10+1 is the unique all-spent resolution. (6) Makeva Step 4 records Riverfolk's Blades + Archery per the chapter's own culture table.
- **TIER 3 design decision (implemented default, veto to revert):** (7) free fixed-grant duplicates resolve as **explicit waste** (no rank up, no extra DP) — written at the canonical home (ch08:83), replacing the "distinct disciplines" sentence that contradicted all 8 ch02 templates (Gorma Axes x2, Sera Fire x2/Energy x2, Makeva Blades x3) and ch08's own Sera example. Interlocked with the ch02 Makeva walkthrough, so it shipped in the same PR. Logged in `decisions-pending.md` as implemented default.

## Process notes
- **Resumed run:** the 2026-09-05 16:00 walkthrough convened this run (round 1 closed 7-0, `close` + `verify` both landed) but the session was interrupted mid-implementation: a branch with 5 uncommitted edits existed and the run dir was not yet committed. The 2026-09-06 run re-verified the ledger (chain ok), completed the remaining 4 disposition items, shipped PR #395, and committed this audit trail.
- **Verify-before-trust (orchestrator):** all 7 items re-grepped against the branch before merge; build exit 0 on the final commit; added-line em-dash count 0; the single dice-pattern hit is "d6 Backlash Table" (allowed non-damage exception, identical to ch05's own Edge of Chaos wording); Sera's 11 DP spend re-summed to 2+2+2+2+2+1 = 11.
- **Not re-flagged:** em-dash law, heading hierarchy, template block coverage, and the layout lens's other checks all passed on the first pass (layout-expert confirmed zero).
