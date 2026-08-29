# Council Run — ch16 (Armor & Shields), 2026-08-29

- **Council:** hol-rulebook (Synod engine, 7 voters, quorum 4)
- **Run dir:** `~/.hermes/councils/hol-rulebook/runs/20260829-2009`
- **Source:** `quarto-book/chapters/16-armor-shields.qmd` (label `16-armor-shields`, 130 lines)
- **Verdict:** t-01 **REJECTED**, 7/7 unanimous refutes, 0 supports, 0 rebuttals, 0 sealed rulings. Single round (round 1 hit reject quorum; terminal).
- **Confidence:** 0.9 (librarian).
- **Wall rejections:** 1 pre-ingest leak caught (game-architect, one 10+ word verbatim span in `argument`); single-member rewrite, re-screened clean. 0 `judge-brief` wall rejections (no judge needed).
- **Ledger:** 14 events, `verify` chain ok.

## Findings (round 1)

| id | role | stance | conf | headline |
|----|------|--------|------|----------|
| f-001 | librarian | refute | 0.80 | Shield Block double implementation (reaction vs ch09 card); worked-example min-1 violation, gear contradiction, invented critical; intro says shields don't reduce damage passively but the table grants passive DR |
| f-002 | contrarian | refute | 0.90 | DA rolling for NPCs contradicts the defense model; critical tier + flat +3 bonus off-model; "takes nothing" violates min-1; goblin numbers 3/4 vs bestiary 2/4/6; DR-stacking wall |
| f-003 | researcher | refute | 0.92 | goblin shortsword→scimitar (ch20); Standard 3→4 / Strong 4→6; critical arithmetic broken (7 vs 12); defense-roll framing missing; armor pricing absent |
| f-004 | game-architect | refute | 0.85 | Shield Block name collision canonical-card question (ch09/ch08 vs ch16/ch21/ch22); PV/Protection semantics split; spellcasting penalty verified consistent |
| f-005 | author | refute | 0.85 | Roric buys Breastplate then fights in Chain Mail; voice good but gear contradiction and shield-intro passive-DR contradiction |
| f-006 | editor-in-chief | refute | 0.82 | shield "Protection" number is a dead stat (never explained); worked-example Critical step not in the rule; zero outgoing cross-references; no armor/shield prices anywhere |
| f-007 | layout-expert | refute | 0.86 | chapter layout clean (0 em-dashes, well-formed tables) but the opening figure renders a doubled caption — verified BOOK-WIDE (all 21 chapter opens), routed to decisions-pending #36 |

## Process notes

- **Wall:** game-architect's `argument` carried a 10+ word verbatim quote from the source ("strong damage (4) plus a critical bonus total incoming 7"); caught by pre-ingest prescreen, single-field rewrite (~84s), re-screened clean before ingest.
- **Disposition:** all 5 lenses' refutes decomposed into 5 PRs shipped same session (issue #378 umbrella):
  - #379 — remove duplicate Shield Block card (ch09, old design: 2-Armor Adept flat-rider card) + swap ch08 prereq-example row to Shield Slam. The free reaction in ch16 is canonical (matches ch20 Knight, ch21 glossary, ch22 reaction list, ch13).
  - #380 — PV vocabulary reconciled: ch21 glossary PV = stance bonus (Bastion/Arcane Shield), NOT shields; ch22 shield column header PV → "Protection Req".
  - #381 — ch06 goblin canon fix (rusty shortsword → scimitar; Standard damage 3 → 4 per ch20 2/4/6).
  - #382 — ch16 substantive rewrite (opencode agent, worktree /tmp/wt-378): intro passive-DR fix; Kael example scimitar + Standard 4 → 2 HP; armor Cost column + shield prices; Protection-discipline-requirement sentence + kit exemption; Shield Block combat example rewritten to the defense-roll model (DA never rolls; Roric in Breastplate+Shield DR 6; goblin 2/4/6; orc warchief 6/9/12; invented Critical→Strong + flat +3 removed; "takes nothing" → 3 damage; HP math 13→11 verified); Endurance implied-rule removed; 3 outgoing cross-refs.
  - #383 — ch15 shield line points at the priced armor table.
- **VERIFIED NOT findings (re-checked against the file before acting):** breastplate callout (no stealth penalty) matches the table row; tower-shield plant-as-maneuver uses the registered Maneuver action + ch13 cover rules (cross-ref added, no new rule); DR-stacking (plate 6 + tower 3 = 9) answered by min-1 + volume — the chapter's closing callout already says five goblins wear down plate.
- **Convention routed:** doubled figure captions are book-wide (16 chapters) — decisions-pending #36, NOT a ch16-only edit.
- **Audit discipline:** every PR audited on the branch ref before merge (fileset = chapters/ only; 0 em-dashes added; 0 damage dice — only 3d6 core rolls; 0 flat riders; chain/claim counts verified). Build exit 0 on all 5 PRs.
