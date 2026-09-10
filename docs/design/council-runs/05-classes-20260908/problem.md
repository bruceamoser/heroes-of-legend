# Problem: Council review of Chapter 5, Classes (quarto-book/chapters/05-classes.qmd)

You are the hol-rulebook council. Audit this chapter as a publishable unit of the Heroes of Legend
TTRPG rulebook and produce a disposition plan. Do NOT fix anything; file findings only.

## Scope
The registered source `05-classes` (the chapter's .qmd). Cross-check against the rest of the book where
a claim is canon-determined (skill roster ch07, core resolution/boon-bane ch06, combat/conditions ch13,
disciplines/ladder/budget ch08, advancement/DP economy ch18, talents ch09, character-creation templates
ch02, spell catalogs ch11/ch12, glossary ch21, reference sheets ch22). The chapter covers: the nine
classes (Protector, Blade, Arcanist, Shepherd, Intellect, Odd, Leader, Unbalanced, Shadow) with L1
disciplines, signatures, favored skills, starting kits, per-class Discipline cost tables; the class
archetype table (four archetypes + Odd); the per-class ability tables (10 abilities each, Novice/Adept/
Master ladder); and the Progression + Costs sections (card costs 2/4/8, Home/Adjacent/Foreign/Opposed
structures, comprehensive cost table).

## Locked conventions the chapter must satisfy (cite the violated convention in every finding)
- **Damage budget = FLAT numbers, on the table, no dice.** Novice 2/4/6, Adept 6/9/12, Master 9/15/21
  (Weak/Standard/Strong). "The table is the law." Every damaging/healing number must be a budget row, an
  explicit Basic-card floor, a damage-TIER bump ("+1 damage tier"), or an on-row conditional rider that
  SUMS to a row. Recurring HoT totals over the stated duration = the row.
- **ZERO flat +N damage riders (weapons rework, 2026-08-19, book-wide).** Any "deals +N damage",
  "+N bonus damage", "gains +N damage" is DEAD anywhere in the book, including class abilities. The
  canonical way to raise damage is "+1 damage tier (one row up on the damage budget)".
- **Ladder discipline:** Novice = 1 disc (or no prereq), Adept = EXACTLY 2, Master = EXACTLY 3 (max 3
  ever; shapes 3 different / 2+1 / 3 same).
- **Level gates (canon, ch18:45):** Adept unlocks at Level 3, Master at Level 7.
- **DP economy (final, #195, ch18):** cards flat 2/4/8 DP; per-level DP awards 3-4 with carry-over
  (ch18:39, PR #385: "Unspent DP carries over to your next level"). Any ch05 text about spending DP must
  not contradict carry-over.
- **Boon/Bane (ch06):** Boon = roll 4d6 keep the highest three; Bane = roll 4d6 keep the lowest three.
- **Conditions vocabulary (ch13 table):** leveled conditions use the "Name X" form (Dazed X, Poisoned X,
  Slowed X, Burning X, Frozen X); binary conditions by name (Frightened, Prone, Restrained, Invisible...).
  Bespoke near-conditions ("rooted", "Fear effect") that duplicate or drift from the table are findings.
- **One-roll principle (ch13, locked):** the hit/attack roll IS the roll; no second roll unless the card
  explicitly invokes the sanctioned 3d6 or boon-bane 4d6 mechanics.
- **Style law: ZERO em-dashes** in prose. No damage dice anywhere (the only sanctioned dice: 3d6
  one-rolls, 4d6 boon/bane, and explicit random-behavior tables such as a class signature's d6 backlash
  table or a 1d4 random-effect table, which are not damage rolls).
- **Cross-references:** @sec-* links must resolve; every ability named in prose (e.g. a signature that
  grants a named ability) must exist in the book's tables; every spell named in an ability effect must
  exist in ch11/ch12.
- **Cost tables:** the nine per-class Discipline cost tables and the comprehensive cost table must agree
  cell-for-cell; every class must have a coherent Home/Adjacent/Foreign/Opposed distribution.

## Findings format (one finding per member this round)
Each finding must be decision-oriented: name the broken value with [05-classes:LINE], the
expected/correct value, the violated convention, and the minimal fix. Cite cross-chapter canon lines where
the expected value is canon-determined. Severity is implicit in the fix size. Do NOT invent defects to
look thorough; a chapter with few real problems is a good outcome.
