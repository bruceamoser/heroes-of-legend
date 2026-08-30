# Council Run SUMMARY — ch17 (17-magic-items)

- **Run:** 20260830-2022 · **Council:** hol-rulebook (Synod engine, 7 voters, quorum 4, max_rounds 2)
- **Verdict:** REJECTED as written, round 1, **6 refute / 1 support** (reject quorum 4 exceeded; no rebuttals; no impasse; no judge)
- **Findings:** 7 (librarian, contrarian, researcher, game-architect, author, editor-in-chief, layout-expert)
- **Wall rejections:** 0 (pre-ingest lint clean on all 7 findings)

## Positions
| Voter | Stance | Confidence |
|---|---|---|
| librarian | refute | 0.85 |
| contrarian | refute | 0.85 |
| researcher | refute | 0.90 |
| game-architect | refute | 0.78 |
| author | refute | 0.80 |
| editor-in-chief | refute | 0.87 |
| layout-expert | support | 0.93 |

## Consensus findings (multiple lenses converged)
- Locket attitude arithmetic self-contradictory vs ch14 ladder (4 lenses)
- Sunbow off-budget 0/2/6 + Dazzled condition-name misuse with flat -1 (5 lenses)
- Immovable Rod nonexistent "Strong 17-20" band (3 lenses)
- Titan's Girdle +3 Brawn above the -2..+2 ceiling (3 lenses)
- Six items impose target checks = second rolls, violating locked one-roll principle (contrarian flagship; un-rebutted)
- "Artifacts" referenced but undefined (3 lenses)
- Cloak of Elvenkind strictly dominated by Veilwalker's Shroud (3 lenses)
- Finding Magic Items W/S/S band contradicts the chapter's own potions (2 lenses)
- Reading guide omits Type/Disciplines card fields (2 lenses)
- ch08 "Rare… permanent" discipline-item gate conflicts with ch17's Uncommon temporary items (contrarian)
- Layout layer clean (layout-expert support, scoped to presentation only)

## Verified compliant (deliberately not re-flagged)
- Chalice flat 2 HP totals 2/4/6 across recipients (Weak you=2, Standard you+ally=4, Strong you+2 allies=6) — per-target compliant pattern (contrarian counter-check)
- All item rows flat on budget; "+1 damage tier" = permitted bump; zero em-dashes; figure-caption doubling = book-wide #36 (excluded per scope)

## Disposition shipped
- **One PR: #384** (branch fix/council-17-20260830, 3 files, +31/-29) — all mechanical + implemented-default items in a single atomic change: budget/one-roll/vocabulary/consistency fixes + ch08/ch21 single-cell reconciliations.
- **Design-flavored implemented defaults (veto-revertible, logged in decisions-pending.md):** Titan's Girdle Boon conversion; one-roll rider conversion (6 items); Artifact defined; Cloak differentiation; Rope inanimate destinations; Deck once-per-session; Spellguard encounter-aligned cooldown; Discipline Items lost-prereq rule + ch08 gate reconciliation.
- **Build:** `cd quarto-book && ./build.sh` exit 0 after merge.

## Process notes
- All 7 briefs rendered before dispatch; 3+3+1 wave dispatch; rendered-vs-dispatched reconciled before closing the round.
- dissent field in recommendation JSON requires object entries (role/topic/position), not bare role strings — schema exit 4 on first attempt; corrected.
