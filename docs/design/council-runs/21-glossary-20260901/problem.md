# HOL Council — ch21 Glossary

Chapter under review: ch21 (quarto-book/chapters/21-glossary.qmd), "Glossary", 201 lines.

Task: audit the chapter as a publishable unit and produce a disposition plan.
Each member audits through their own lens (see role card) and files a finding:
  stance support = the chapter holds on this lens as written
  stance refute  = the chapter must change; name the fix and its scope
Findings cite [file:line] in the chapter (21-glossary.qmd). Mechanics
findings state the broken value and the expected value.

The glossary's promise (21-glossary.qmd:11): "Every mechanical term used in
this book, defined in one place." The core audit tests:
  (a) ACCURACY — every definition must match the authoritative chapter. The
      glossary is a SUMMARY, never the source of a rule: it must not invent
      mechanics, reference rules/abilities that exist nowhere else in the
      book, or contradict the chapter it summarizes. A definition that
      disagrees with its source chapter is a defect, not a new ruling.
  (b) COMPLETENESS — mechanical terms the book actually uses as vocabulary
      should be present. Missing entries are defects when the term is load-
      bearing across multiple chapters (e.g. short/long rest, Recharge,
      conditions that appear in ch13's table). Judgement is allowed: not
      every noun needs an entry; the promise is the yardstick.
  (c) CONVENTION — zero em-dashes, no stale vocabulary ("chain" is DEAD:
      ch10/11/12 use the growing-card model, "There are no spell chains"
      per the glossary itself at 21-glossary.qmd:171), en-dash for prose
      ranges (ch19: "3–4 hours"), flat damage budgets.

Cross-chapter checks use the authoritative chapters as the reference, not
this chapter:
  creation = ch02 (HP 10 + Fortitude + Knowledge at L1; HP/level +Fortitude
    min 1; Background DP 8 + Knowledge + Fortitude; "Level 0" is the
    background phase)
  ancestries/cultures = ch04 (Lucky = add one Boon to any roll once per
    session; Versatile +1 DP at Level 0; culture grants +1 skill bonus and
    two specific Disciplines or one free Discipline)
  classes = ch05 (nine classes: Protector, Blade, Arcanist, Shepherd,
    Intellect, Odd, Leader, Unbalanced, Shadow; Eccentric Spellcasting at
    ch05:250; starting kits carry arcane focus / holy symbol / focus pouch)
  core resolution = ch06 (Boon = 4d6 keep highest 3; Bane = 4d6 keep lowest
    3; success tiers Weak 1-8 / Standard 9-14 / Strong 15-18+; difficulty
    Trivial +4 ... Nearly Impossible -6; Critical = three natural 6s, ~1 in
    216)
  skills = ch07 (skill bonus +1 Novice / +2 Adept / +3 Master; difficulty
    modifiers Trivial +4 / Easy +2 / Standard +0 / Hard -2 / Nearly
    Impossible -6; a "check" = 3d6 + attribute + skill + difficulty)
  disciplines = ch08 (23 disciplines in 9 categories; rank 1-3; Novice 1 /
    Adept 2 / Master 3; attribute-scaled damage formula at ch08:195: "base
    is budget − 3 (Novice 1/2/3, Adept 3/6/9, Master 6/12/18), plus the
    card's stated attribute, minimum 1 damage; melee weapons add Brawn
    (Finesse weapons use Agility); Missile weapons and ammunition are flat")
  talents/abilities = ch09 (Tough +2/+4/+6 max HP; Fortune's Favor Novice =
    once per session reroll one natural 1, 2, or 3; Basic Archery/Basic
    Thrown are flat 1/2/3 with no attribute; Throw = +1 damage tier)
  magic = ch10 (concentration: "You can only maintain one concentration
    spell at a time. If you take damage while concentrating, make a
    Fortitude check to hold the spell together" — NO talent grants a second
    concentration anywhere in ch09/ch10/ch11/ch12)
  combat = ch13 (21-row condition table incl. Dazzled and Petrified; 13
    damage types: Physical Slashing/Piercing/Bludgeoning, Elemental
    Fire/Cold/Lightning/Acid/Poison/Thunder, Magical Force/Radiant/Necrotic/
    Psychic; Surprised = acts first in the opening round + −2 on first
    roll; Cover half −1 / three-quarters −3 / full cannot be targeted;
    Initiative 3d6 + Agility; Morale Check 3d6 no modifiers; Non-Lethal
    melee only; Dying = 3d6 no modifiers each round; wounds heal 1 per long
    rest + 1 additional with a Standard Medicine check)
  equipment = ch15 (Finesse = use Agility instead of Brawn; "Missile and
    thrown attacks are flat, no attribute added" at ch15:52)
  magic items = ch17 (found, not bought)
  advancement = ch18 (attribute increases at levels 4 and 8; ~52 career DP)
  GM guidance = ch19 (short rest = 1 hour, no default mechanical effect;
    long rest = 8 hours, HP per level, wounds, once per 24h; Recharge 5-6
    usage on Kelvath's Tidal Surge)
  bestiary = ch20 (stat blocks tag abilities "(Recharge)" — the term is
    used but NEVER defined anywhere in the book; ch20's Reading a Stat
    Block table has no frequency/Recharge row)
  reference sheets = ch22

Disposition classes (for the librarian's synthesis):
  mechanical    - safe to implement as a micro-PR (headings, tables, wording,
                  em-dashes, single-cell refs, vocabulary swaps, definition
                  alignment, adding a single glossary entry)
  substantive   - needs a dispatched implementation pass (multi-file, new
                  content, worked-example rewrite requiring new narrative)
  design-decision - needs Bruce's ruling; implement the recommended default,
                  flagged veto-revertible in decisions-pending.md

Standing book conventions are in force: zero em-dashes in book text; damage
budgets flat at Novice 2/4/6, Adept 6/9/12, Master 9/15/21; card costs
2/4/8 DP; Adept prereqs exactly 2 ranks, Master exactly 3; L3/L7 gates;
no flat +N damage riders anywhere in the book (a damage bonus must be a
budget row, a Basic-card floor of 1/2/3 + attribute, or a "+1 damage tier"
bump); one-roll principle; damage dice are dead outside the allowed
random-table exceptions; ZERO "save" vocabulary (resistance = attribute
CHECKS); leveled conditions carry a number (Burning X, Slowed X); "chain"
vocabulary is retired (growing-card model); prose ranges use en-dashes.
