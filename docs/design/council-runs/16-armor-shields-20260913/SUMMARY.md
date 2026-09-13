# Council run - chapter 16, Armor & Shields

**Run:** `20260913-0322` | **Charter:** hol-rulebook | **Closed:** yes | **Chain:** ok (21 events)
**Source:** `16-armor-shields.qmd` (prints as Chapter XVIII)
**Findings:** 10 over 2 rounds | **Rulings:** 3 sealed (r-001, r-002, r-003) | **Confidence:** 0.72

This was the Wave-2 pass. The Wave-1 pass (run 20260829-2009, PRs #379-#383) had already fixed
15 items; this run reopened the chapter from scratch and contested all three topics to the
blind judge at max rounds.

## Outcome

- **t-01 (convention conformance) - ruled r-001.** The defect is **real but bounded**: exactly two
  armour rows were strictly dominated (Studded Leather, Half Plate), from three dominated pairs.
  The offered three-cell remedy was **not** sealeable as offered: it reached only one of the three
  files that print the changed value, and its own implied per-DR rate reinstated a domination.
- **t-02 (internal consistency) - ruled r-002.** Both registers are operative and the repair happens
  in the **tables'** register: numeric Bane translations out, the Breastplate quoted with the penalty
  its own row prints, both worked examples rebuilt from the class kit's DR 7, the slowed set made
  identical to the heavy set, Shield Block reconciled with its arithmetic.
- **t-03 (cross-chapter canon) - ruled r-003.** Canon is **not clean but narrowly so**: every gear
  value and all three shields agree row for row, but the weight-class vocabulary carries rule weight
  outside the chapter while being registered nowhere. The class is **published, not cut**: a row-level
  marker mirrored in every restatement plus a glossary headword.
- The monster-DR bestiary lead is **withdrawn** (it tracks the Challenge budget, not the armour tables).

## Design call (A) - local consistency

Bruce ruled 2026-09-12. r-001 demands one consistent price per DR step; the printed anchors make that
unsatisfiable literally (the only two pure DR steps are +5 gp and +15 gp; a least-squares fit of the
eight rows to their own attributes leaves residuals of 22 to 98 gp; a flat rate that keeps Padded at
5 gp prices Plate at 95 instead of 300). Option (A) therefore keeps every anchor and satisfies the
clause in the no-inversion + single-drawback-price sense. Repricing the quiet track at the fix's own
rate was rejected because Breastplate at 40 gp re-dominates Half Plate at 60.

## Shipped - PR #514 (issue #513)

| Change | Detail |
|---|---|
| Repair (r-001) | Studded Leather DR 2->3 in **three** files (canon home, equipment summary, reference sheet); Chain Shirt 50->20 gp; Half Plate 150->60 gp |
| Class column (r-003) | Added to all three armour tables: Light / Medium / Heavy |
| Taxonomy (r-002) | Donning line: Medium is now Chain Shirt + Breastplate (5 min); Heavy is Half Plate + Chain Mail + Plate (10 min) |
| Casting register (r-002) | `-3` -> `Triple Bane on spell rolls`; `-1` -> `a Bane on spell rolls` |
| Worked examples (r-002) | Option A DR 7, Option C DR 8, the false "shield costs extra coin" claim removed, the A-vs-B trade stated instead of implying a dominant build |
| Glossary + naming (r-003) | `Armor Weight Class` headword; `Kit Weapons` -> `Kit Gear` with the exemption extended to kit armour and shields; `1 Protection` -> `1 Protection Discipline`; `Armor Disc` -> `Armor Discipline` |

## Measured

- `sweep-armor.py`: **3 dominated pairs / 2 losing rows -> 0 / 0** (before/after both in this dir)
- Drawback now prices uniformly: **Bane 5 gp, speed cut 35 gp**, which reconciles the
  Chain Mail / Breastplate pair exactly (-25 = +15 DR - 5 Bane - 35 slow)
- Build exit 0; native-Typst exit 0; orphaned headings **2 (unchanged)**; TOC folios OK;
  table fidelity OK (107 row tails); **0 em-dashes**
- Rendered PDF: the ch16 armour table still closes on **one printed page** (p243, 366 pages) with the
  new Class column; the ch15 summary (p228) and ch22 sheet (p357) both mirror DR 3 and the classes

## Residual notes

- **Two evidence slips in append-only findings.** Both round-2 findings state the creature chain-shirt
  gap as "four below this chapter's value"; ch16's chain shirt is DR 3, so the gap is **two**. The
  librarian's finding also calls the ch20 plate knight "Challenge 1"; it is **Challenge 3**. Neither
  changes the withdrawal, but the ledger cannot be edited, so the correction is recorded here.
- `08-disciplines.qmd:47` describes the Armor Discipline as "Heavy armor proficiency". Not a
  contradiction of the new classes (rank 3 is Plate, which is Heavy), but it reads stale next to a
  published three-class taxonomy. Not in this change set.
- The callout's `3/6/12 or 4/8/16` ladder is untouched: no ruling covers it, and a Wave-1 finding on
  it was not carried into a ruling.
- `check-table-fidelity.py chapters/15-equipment.qmd` reports `Volatile Reagents (alchemist's fire)`;
  that table is untouched by this diff and the failure reproduces at baseline.
