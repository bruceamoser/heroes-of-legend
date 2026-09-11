# Problem: Council review of Chapter 8, Disciplines (quarto-book/chapters/08-disciplines.qmd)

You are the hol-rulebook council. Audit this chapter as a publishable unit of the Heroes of Legend
TTRPG rulebook and produce a disposition plan. Do NOT fix anything; file findings only.

## Scope
The registered source `08-disciplines` (the chapter's .qmd, 268 lines, native Typst). Chapter 8 is
the AUTHORITATIVE home of the Discipline system: the taxonomy, the acquisition rules, the ladder,
the flat card costs, the per-class rank-cost structures, the prereq shapes, the damage budget, and
one worked build example. Other chapters mirror it (ch05 class cost tables + starting disciplines,
ch02 creation steps and the 8 character templates, ch18 advancement and the DP economy, ch07 for
the skills exemption, ch09/ch11/ch12 for cards keyed to it, ch15 for weapon entry requirements,
ch17 for item-granted ranks, ch21 glossary, ch22 quick reference).

Cross-check only where a claim is canon-determined, against: ch05 (classes, their starting
disciplines and their cost tables), ch02 (creation: ancestry grant, culture grant, the Depth rule,
the 8 templates and the Makeva walkthrough), ch18 (advancement, DP carry-over, level gates), ch06
(core resolution, success tiers, Boon/Bane), ch04 (ancestry + culture Discipline grants), ch07
(skills are exempt from prerequisites), ch09/ch11/ch12 (card tiers and prereq keys), ch15
(weapons' own Discipline entry requirements), ch17 (magic items that grant ranks), ch21/ch22.

## Locked conventions the chapter must satisfy (cite the violated convention in every finding)
- **Zero em-dashes in prose (style law, book-wide).** Also zero doubled cross-reference periods
  (a bare `@sec-...` already renders its own terminal period; an author-typed period after it is a
  render artifact).
- **Damage budget is FLAT numbers, not dice** (ch08 is its stated home, `#label("sec-damage-budget")`):
  Novice 2/4/6, Adept 6/9/12, Master 9/15/21 for Weak/Standard/Strong. Any damage or healing
  expressed as dice anywhere in the chapter is a defect. The only sanctioned dice in the book are
  3d6 checks, 4d6 keep-three for Boon/Bane (potence ladder 4d6/5d6/6d6, cancel one for one), and
  explicit random-effect tables.
- **One-roll principle (locked):** the check roll IS the roll; there is no separate damage roll.
- **Card costs are flat 2/4/8 DP for every class.** Per-class rank costs are the four structures
  1/2/4, 2/4/8, 3/6/12, 4/8/16 for ranks 1/2/3. A card's total = flat card cost + the rank costs of
  any required ranks the buyer does not already hold. Every worked arithmetic line in the chapter
  must recompute exactly, including the "already holds rank 1" case.
- **Prereq shapes (locked):** Novice = exactly 1 rank; Adept = exactly 2 ranks (2 different, or 2
  ranks in one discipline); Master = exactly 3 ranks (3 different, 2 same + 1 different, or 3 same).
  A single discipline caps at 3 ranks, ever. Adept gates at Level 3, Master at Level 7.
- **No-prereq Novice basics** (cantrips, basic utility skills) cost only the flat card price.
- **Attribute-Scaled damage** adds a keyed attribute to a base value, minimum 1 damage; for spells
  and abilities the base is budget minus three (Adept 3/6/9, Master 6/12/18) plus the stated
  attribute. Melee attack cards add Brawn (Agility for Finesse); missile, ammunition and thrown are
  FLAT with no attribute. The chapter's own parenthetical for the Novice base must be consistent
  with both the stated formula and the Basic-card floor used in ch09/ch15.
- **Taxonomy integrity:** the chapter claims a specific number of Disciplines across a specific
  number of categories. That count must equal the actual table rows, and the names and category
  assignments must match ch05, ch21 and ch22. Every Discipline named elsewhere in the chapter (the
  class table, the worked example, the prose) must exist in the taxonomy table under exactly that
  name.
- **Class table integrity:** all nine classes (Arcanist, Blade, Intellect, Leader, Odd, Protector,
  Shadow, Shepherd, Unbalanced) and each class's starting Disciplines must match ch05's class
  entries and ch05's cost tables exactly (discipline names, ranks, and the count of each).
- **Cross-references:** every `@sec-*` link must resolve to a real label in the book.
- **Typst conventions (MIGRATION-SPEC):** exactly one `{=typst}` fence per file with the `# H1`
  line above it; callout bodies in the NAMED `body: [...]` form (the positional form is silently
  dropped by the theme and the build still passes); every `#table(` carries `outlined: false`;
  `#label("sec-...")` sits on the line after its heading. `+` renders as a NUMBERED list and `-`
  as bullets, so a list rendered as 1./2./3. where prose intended bullets is a defect.
- **Vocabulary:** leveled conditions use the "Name X" form (Burning 3, Slowed 5); binary
  conditions by name (Prone, Frightened, Hidden). "Boon"/"Bane" are defined in ch06; the chapter
  must use those exact terms if it uses them at all. Retired vocabulary (spell "chains",
  classifications, multipliers, General disciplines, "Standard+", "armor" as a defense modifier)
  must not appear.
- **Intra-chapter consistency:** the worked build example, the total-cost callout, the class table,
  and the prose rules must agree with one another. Where two sites in this chapter state the same
  fact differently, that is a defect, and the finding should name both line numbers.

## Findings format (one finding per member this round)
Each finding must be decision-oriented: name the broken value with `[08-disciplines:LINE]`, the
expected or correct value, the violated convention, and the minimal fix. Cite cross-chapter canon
lines where the expected value is canon-determined. Prefer a mechanically checkable claim (recompute
it, extract it, count it) over an impression. A finding that cannot state both the broken value and
the expected value is not a finding. Do NOT invent defects to look thorough; a chapter with few real
problems is a good outcome.

## Required output
Signals first, then one consolidated disposition plan tiered as: (a) mechanical, (b) substantive,
(c) design decisions needing Bruce. Every item carries `[08-disciplines:LINE]`, the expected value,
and the minimal fix. State plainly what you verified as CORRECT, so the orchestrator does not
re-investigate it and does not re-flag a deliberate convention.
