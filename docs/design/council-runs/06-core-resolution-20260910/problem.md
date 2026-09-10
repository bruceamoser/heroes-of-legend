# Problem: Council review of Chapter 6, Core Resolution Mechanics (quarto-book/chapters/06-core-resolution.qmd)

You are the hol-rulebook council. Audit this chapter as a publishable unit of the Heroes of Legend
TTRPG rulebook and produce a disposition plan. Do NOT fix anything; file findings only.

## Scope
The registered source `06-core-resolution` (the chapter's .qmd, native Typst). Cross-check against the
rest of the book wherever a claim is canon-determined: character-creation examples and the Kael/Lyra/
Roric/Makeva templates (ch02), skill rank bonuses and the skill roster (ch07), the damage budget and
Basic-card damage floor (ch08 @sec-damage-budget), conditions vocabulary (ch13), armor/DR canon (ch16),
monster damage bands per Challenge (ch20), glossary/term definitions (ch21), reference sheets (ch22).
The chapter covers: the core roll (3d6 + attribute + skill + difficulty), the success-tier table
(Weak 1-8 / Standard 9-14 / Strong 15-18+), totals of zero or less, Boons and Banes (4d6 keep three
highest / lowest), opposed rolls, attack rolls and the always-hit principle, DR, the players-roll-all
convention, Defense Rolls (formula, reading the result, worked examples), Critical Hits (three natural
6s + d6 table), Fumbles (three natural 1s + d6 table), Difficulty Modifiers, and four Worked Examples.

## Locked conventions the chapter must satisfy (cite the violated convention in every finding)
- **Damage budget = FLAT numbers, on the table, no dice.** Novice 2/4/6, Adept 6/9/12, Master 9/15/21
  (Weak/Standard/Strong). Basic-card floor is 1/2/3 + attribute modifier. Every damage/healing number in
  this chapter (examples, crit table, fumble table) must be on a budget row, an explicit Basic-card floor,
  or a damage-TIER bump ("+1 damage tier"). "The table is the law."
- **ZERO flat +N damage riders** anywhere in the book (weapons rework 2026-08-19). The canonical way to
  raise damage is "+1 damage tier".
- **One-roll principle (locked):** the attack/hit roll IS the damage roll; no separate roll. The only
  sanctioned dice in the book are 3d6 rolls, 4d6 boon/bane keep-three, and explicit d6/1d4 RANDOM TABLES
  (the Critical Effect d6 table at ch06:155 and the Fumble Complication d6 table at ch06:183 are exactly
  that: sanctioned random tables, NOT damage rolls). Flag any other dice.
- **DR canon (ch16):** DR subtracts from incoming damage; minimum 1 damage from any hit; armor and shields
  grant DR and never add to the Defense Roll. Verify every DR number used in the chapter's examples against
  the ch16 armor table and against the ch20 stat blocks it names (goblin, Knight of the Iron Circle).
- **Monster damage bands (ch20, locked):** C1-2 = 2/4/6, C3-6 = 6/9/12, C7+ = 9/15/21; a secondary attack
  is at most one tier lower. Any monster damage value quoted in this chapter's examples must match the
  stat block in ch20 AND sit on its challenge band.
- **Condition vocabulary (ch13):** leveled conditions use "Name X" (Burning X, Slowed X, Frightened X...),
  binary conditions by name (Prone, Stunned, Restrained). Bespoke near-conditions and retired vocabulary
  are findings.
- **Cross-references:** every @sec-* link must resolve to a real label; every chapter/section named in
  prose must exist; cross-chapter claims (skill bonuses, weapon/item names, conditions) must match canon.
- **Style law: ZERO em-dashes** in prose (added lines included). No "Standard+" style undefined degrees.
- **Native-Typst migration conventions (MIGRATION-SPEC, binding):** exactly ONE `{=typst}` fence per file
  with the `# H1` line kept above it; callout bodies in the NAMED `body: [...]` form (positional is
  silently dropped); every `#table(` carrying `outlined: false`; `#label("sec-...")` on the line after its
  heading.

## Known defect class in this chapter (verify, quantify, and rule on disposition)
The markdown-to-Typst migration had two list-rendering regressions, both observable in the built PDF
(quarto-book/_output/Heroes-of-Legend.pdf) and both mechanical to fix:
1. **Collapsed enum.** ch06:91 `#enum(numbering: "1.")[ ... ]` holds three hard-wrapped formula lines in
   one `[ ]` body. Typst joins newlines inside `[...]` into a single paragraph, so the PDF renders ONE
   run-on item: "1. No defensive skill: 3d6 + Agility modifier - Challenge Dodge: 3d6 + Agility modifier +
   Dodge rank - Challenge Parry: 3d6 + Brawn modifier + Parry rank - Challenge". The three formulas must be
   three list items. Five other chapters carry the same `#enum(numbering: "1.")[` multi-line shape
   (01-introduction:108, 02-character-creation:26, 19-gm-guidance:339, 20-bestiary:667,
   22-reference-sheets:239) and need the same check.
2. **Bullets became numbers.** ch06:97-101 were a markdown BULLET list (`- **Agility** ...`) and are now a
   Typst `+ ` enumeration, so the PDF numbers them 1..5. The same `+ `-for-bullet substitution is
   book-wide (197 `+ ` items across 11 chapters; the pre-migration sources used `- `).
Rule on scope: is each of these a ch06-local fix or a book-wide sweep? The orchestrator will implement
whatever the council recommends; say explicitly which.

## Findings format (one finding per member this round)
Each finding must be decision-oriented: name the broken value with [06-core-resolution:LINE], the
expected/correct value, the violated convention, and the minimal fix. Cite cross-chapter canon lines where
the expected value is canon-determined. Severity is implicit in the fix size. Do NOT invent defects to
look thorough; a chapter with few real problems is a good outcome.
