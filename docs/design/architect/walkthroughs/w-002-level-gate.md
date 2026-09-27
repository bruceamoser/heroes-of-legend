# W-002 — the level walkthrough (creation and progression)

**Date:** 2026-09-26 (architect cycle 7). **Method:** `references/architect-role.md` walkthrough 2
("for each class at each gate: is there something worth buying, and can the DP actually be spent?").
**Corpus:** `origin/main` at `303a5fe`, re-read after #665. Every number below is computed from the
printed tables: `02:115` (Background DP), `02:204` (Class DP), `02:214` (HP), `02:47` (attributes),
`08:144-147` (tier prices), `08:162` (rank costs), `08:99` (rank ceiling), `18:66-90` and `22:258-269`
(the level table).

## The walk, level by level

| Level | DP gained | Cumulative | Newly legal this level | Is there something worth buying? |
|---|---|---|---|---|
| 1 | 4 (+ Background 8+K+F, Class 8) | 16-24 at start | Novice cards (2 DP) and rank 1 of any Discipline | Yes, and more than the pool covers: Energy alone lists 11 Novice cards |
| 2 | 3 | 7 | nothing new | Yes (Novice cards, skills), but nothing *new* - level 2 is the flattest rung |
| 3 | 3 | 10 | **Adept cards (4 DP)**, + 1 Discipline rank | Yes, but only in the single Discipline the rank pick deepens to 2 |
| 4 | 3 | 13 | +1 attribute (cap +2) | Yes |
| 5 | 4 | 17 | nothing new (a DP windfall) | Yes |
| 6 | 3 | 20 | +1 Discipline rank | Yes; rank 3 is reachable if both picks (3 and 6) went to one Discipline |
| 7 | 3 | 23 | **Master cards (8 DP)** | Yes, if rank 3 is held: 8 DP + the rank cost |
| 8 | 3 | 26 | +1 attribute | Yes |
| 9 | 3 | 29 | +1 Discipline rank (the last) | Yes |
| 10 | 3 | 32 | nothing new | Yes |

## What the walk shows

1. **No dead level.** The sink is never empty because skills use the same 2/4/8 tiers and gate nothing:
   23 skills x 3 tiers is 322 DP of legal sink against a 44-52 DP career. The failure mode this
   walkthrough was looking for does not exist in this book.
2. **The gate is ranks, not DP.** The card shelf is wide (11 Novice / 7 Adept / 3 Master at Energy,
   down to 1/0/0 at Tactics, Animal, Lore and Sleight) but the hero's ranks are three picks, so after
   level 3 the binding constraint is the rank ceiling, not the pool. Adept unlocks at level 3 and the
   *first* deepen is available exactly then, so the gate and the supply coincide; Master's 8 DP card
   needs rank 3, which takes the picks at 3 and 6 on the same Discipline (or rank 2 bought at creation
   with Background DP, 2 DP at Home rates).
3. **Every level leaves a 1 DP remainder** (awards of 3 or 4 against costs of 2/4/8). It is not
   stranded: unspent DP carries over (`18:70`) and the remainder is spendable as a new rank 1 at a
   Home-priced Discipline (`08:162`). Worth knowing, not worth fixing.
4. **The one number the walkthrough could not verify from creation is the level-1 pool itself.**
   `18:66` grants 4 DP at level 1 and `22:272` counts it in the printed 44-52 DP career, but creation's
   steps and its nine printed builds assign only Background (8+K+F) and Class (8). A hero built by the
   canonical path is 4 DP behind the book's own total. Ledger row 169.

## Derived quantities this walkthrough rests on

- Background DP = 8 + Knowledge + Fortitude, reachable **4-12** (5-13 with Human's Versatile).
- HP = 10 + Fortitude + Knowledge, reachable **6-14** (8-16 with Dwarf's Sturdy).
- Career DP = 32 advancement + 8 class + (8+K+F) = **44-52**.
- Discipline ranks in a career = 1 (granted) to **3** (three picks, one at each of levels 3/6/9).
- All nine printed builds' HP, Initiative and Carry re-derive exactly from their printed attributes:
  **9 of 9**.
