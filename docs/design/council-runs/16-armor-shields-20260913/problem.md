# Council problem statement — chapter 16, Armor & Shields (`16-armor-shields.qmd`)

Source: `16-armor-shields.qmd` — 147 lines, 8 sections, 2 tables, **0 em-dashes**.
Printed as Chapter XVIII. This is the **canon home for armor and shield DR** — ch15's armor
table is a summary that defers here, and ch22 restates it on the reference sheet.

## Scope

Audit the chapter for **genuine mechanical defects** — rules that contradict themselves, contradict
locked book law, contradict another chapter, or cannot be resolved as printed. Proofreading is out
of scope. Three topics:

- **t-01 — conformance to the locked conventions.** Does the chapter obey the book's standing laws?
- **t-02 — internal procedure consistency.** Do the chapter's own tables, prose and worked examples
  agree with each other, and can a reader execute what is printed?
- **t-03 — cross-chapter canon.** Do armor, shield and DR values here match ch15, ch22, ch06 and
  ch08? A value that differs is only a defect where this chapter is NOT the canon home, or where
  another chapter presents itself as the general rule.

## THE LOCKED CONVENTIONS (current as of 2026-09-13 — carry these inline; do NOT cite a ledger)

1. **Boon/Bane is the ONLY situational layer.** The book permits exactly **three numeric roll
   modifiers**, all belonging to defined subsystems. Everything else that used to be a "+1" or
   "-2" is a **Boon** (roll 4d6 keep highest 3) or a **Bane** (4d6 keep lowest 3). **Multiples are
   legal and are written as prose counts**: "Double Bane", "Triple Bane". A **numeric modifier on a
   roll is a defect**, and so is any translation between a Bane count and a number (a Triple Bane is
   NOT "-3").
2. **Numbers belong to damage.** Escalation changes a damage tier or a dice value, not a roll.
3. **Damage tiers are Weak / Standard / Strong, and the values come from the attacker, not from a
   formula.** Ladders are NOT uniformly doubling: the Goblin is 2/4/6 and the **Orc Warchief is
   6/9/12**. Never infer a middle value from the outer two — read the stat block.
4. **Challenge is the standard resolution for every opposed contest, on any attribute.** The acting
   character rolls `3d6 + attribute + skill - Challenge`; the DA never rolls for the opposition, and
   **the target never rolls**. `Challenge N` is the target's relevant attribute modifier, negated.
   There is no separate "opposed roll" procedure.
5. **Challenge bands:** Weak 1-8, Standard 9-14, Strong 15+ (3d6, mean 10.50).
6. **Cover is two tiers only:** half cover = **1 Bane**, full cover = **triple Bane**. The old
   "three-quarters" tier was removed book-wide.
7. **Weapon properties are a closed set of seven:** Finesse, Light, Reach, Thrown, Versatile,
   Loading, **Two-Handed**. Two-Handed means *must* be held in both hands and takes **2 slots**;
   Versatile means *may* be used two-handed. The Longsword is the only Versatile weapon.
8. **Range is written as two bands.** `60/120 ft` = attack normally inside the first number, at a
   **Bane** between the first and second, and out of reach beyond the second. A single number is one
   band. The longbow's `100/200 ft` is the only load-bearing instance.
9. **Slot-based encumbrance:** `10 + (Brawn x 5)`, floor 5. Most items 1 slot, armor 2-4, Two-Handed
   weapons 2. **Only ONE container at a time exempts its contents, and containers cannot nest.**
10. **Shield Block** (reaction, ch16) reduces an incoming **damage tier** by one step
    (Strong -> Standard -> Weak -> 1 damage) and cannot reduce below 1. This is legal: it consumes a
    reaction and changes damage, not a roll.
11. **The weapon never changes your damage.** Weapons are flavour; the talent/ability card supplies
    the numbers.
12. **No em-dashes in book source text.** Zero, book-wide.

## ALREADY CLEARED — do NOT re-file these as defects

Verified by the orchestrator against source before this run. File only if you can show this
reading is wrong, and say so explicitly.

- **The Shield Block arithmetic is CORRECT.** The example's greataxe is the Orc Warchief's, whose
  printed ladder is **6/9/12** (ch20). So "Strong to Standard, the incoming damage is now 9" and
  "DR 6 soaks 9 down to 3" are right. Do not file this as a ladder error; if you believe 9 is
  wrong, quote the stat block that says otherwise.
- **The three Defense Roll examples are arithmetically correct.** `3d6+2` rolling 11 = 13 (Standard,
  band 9-14); rolling 6 = 8 (Weak, band 1-8); `3d6` rolling 5 = 5 (Weak). The Challenge under the
  worked examples is applied as a subtraction, which is correct under convention 4.
- **Roric's HP ledger is consistent:** 13 max, 1 + 1 taken across two goblin attacks = 11.
- **The DR examples are correct:** `2 - 2 = 0` floored to 1; a Standard 4 hit against DR 2 leaves 2.
- **The shield values are consistent with ch15 and ch22:** Buckler 10 gp / +1 DR / 1 Protection,
  Shield 15 gp / +2 DR / 1 Protection, Tower Shield 40 gp / +3 DR / 2 Protection. ch15 defers shield
  prices to this chapter, and this chapter does not restate ch15's weapon prices.
- **The Challenge usage is correct:** the DA names Challenge 1/1/3 and never rolls; Roric rolls.
- **The `Foreign/Opposed` DP cost is a DIFFERENT SENSE of the word "Opposed"** (a Discipline cost
  category, not a contest). It is not covered by convention 4 and is not a defect on that basis.
  Its tier values (3/6/12 or 4/8/16) are to be checked against ch08, not against convention 4.
- **`War Cry: +1 damage tier`** alters a damage tier, which is legal under convention 2.
- **The Tower Shield's "-5 ft speed"** is a movement change, not a roll modifier, so it is legal.
- **The figure/table numbering offset** (a figure numbered 17.x inside the equipment chapter) is a
  whole-book convention already documented. Do not file it.

## OPEN LEADS (orchestrator suspects — verify or kill, do not merely restate)

- **Casting penalties stated as numbers.** The spellcasting table gives *Bane / Double Bane /
  Triple Bane on spell rolls*, but the callout beneath it says Plate casts "at -3" and calls a
  Breastplate "only -1 to casting". Under convention 1 a Triple Bane is not "-3". Check whether
  these are unconverted numeric modifiers, whether they contradict the table printed directly
  above them, and whether the same defect appears anywhere else in the chapter or book.
- **The armor table has no slot column**, though ch15's armor table now carries one
  (Padded/Leather/Studded/Chain Shirt 2, Breastplate/Half Plate 3, Chain Mail/Plate 4) and this
  chapter is the canon home. Relatedly, the table has no weight-class column, yet the Donning &
  Doffing section divides the same eight armors into light/medium/heavy.
- **The two worked examples agree with each other**, but check whether either contradicts the
  chapter's own procedure text, and whether the "Choosing Your Armor" DP arithmetic (Home 1/2/4
  against Foreign/Opposed 3/6/12) matches ch08's published cost table.

## Cross-check chapters

`15-equipment.qmd` (armor summary + the Slots column, shields), `22-reference-sheets.qmd` (armor
and shield reference tables), `06-core-resolution.qmd` (Defense Roll, armor does not add to the
roll, Challenge), `08-disciplines.qmd` (Discipline cost tiers, tier shapes), `13-combat.qmd`
(cover), `20-bestiary.qmd` (monster damage ladders and DR).

## Evidence rules

- Cite the registered source **label** exactly as registered, or another chapter filename, or
  `reasoning`.
- **WALL DISCIPLINE:** never quote 10+ consecutive words from the source or this problem statement
  in `argument` or any `evidence[].claim`. Verbatim excerpts belong ONLY in `quote_or_excerpt`, and
  must stay under ~12 words.
- Every `quote_or_excerpt` must be non-empty, including `reasoning`-sourced items.
- A cleared claim is a result: report it as such rather than filing around it.
