# Council Run — ch15 (Equipment), 2026-08-28

- **Council:** hol-rulebook (Synod engine, 7 voters, quorum 4)
- **Run dir:** `~/.hermes/councils/hol-rulebook/runs/20260828-2006`
- **Source:** `quarto-book/chapters/15-equipment.qmd` (label `15-equipment`, 240 lines)
- **Verdict:** t-01 **REJECTED**, 6/6 unanimous refutes, 0 supports, 0 rebuttals, 0 sealed rulings. Single round (round 1 hit reject quorum; terminal).
- **Confidence:** 0.9 (librarian).
- **Wall rejections:** 1 pre-ingest leak caught (game-architect, 3 spans in `argument`); single-member rewrite, re-screened clean. 0 `judge-brief` wall rejections (no judge needed).
- **Ledger:** 12 events, `verify` chain ok.

## Findings (round 1)
| id | role | stance | conf | headline |
|----|------|--------|------|----------|
| f-001 | game-architect | refute | 0.88 | Charge `Strong + 3` flat rider; improvised 1/1/2 off-ladder; missile/thrown attribute note contradicts ch08 |
| f-002 | researcher | refute | 0.90 | 16/17 weapon cost cells empty; oil/reagents bypass Burning X; chase 1d6 contest unresolvable |
| f-003 | contrarian | refute | 0.86 | charge implemented as two independent rules; stacking exploit (land Charge + flat 3 + Battle Cry = 13+); chase stalls forever |
| f-004 | author | refute | 0.80 | name/notation collisions (improvised weapon vs attack, Charge Attack vs bare charge), stale full-rest vocabulary, voice gaps |
| f-005 | editor-in-chief | refute | 0.82 | contradicts ch08 curve deferral; missing ranges; heading/pagination flow; no encumbrance example |
| f-006 | layout-expert | refute | 0.85 | empty Cost column; non-numeric vehicle Speed cells; Encumbrance pagebreak-isolated (verified in built PDF) |

## Process notes
- Conflict resolution: editor's heading-demotion claim dropped in favor of layout-expert's verified build check (callout `##` titles inside callout divs do not pollute the TOC; book-wide convention, not a ch15 defect).
- The librarian flagged interlock (charge rule + improvised rule + vehicle Speed column) → disposition implemented as ONE atomic PR (#377), not micro-PRs.
- Disposition tiers: 12 mechanical / 4 substantive / 4 design (+1 barding flag). All implemented same session; design items logged in `decisions-pending.md` as implemented defaults (veto to revert).
- PR #377 (issue #376): 3 files, build exit 0, zero em-dashes, zero flat riders, zero stale vocabulary (verified on branch ref before merge).
