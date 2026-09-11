# Problem: Council review of Chapter 9, Talents & Abilities (quarto-book/chapters/09-talents-abilities.qmd)

You are the hol-rulebook council. Audit this chapter as a publishable unit of the Heroes of Legend
TTRPG rulebook and produce a disposition plan. Do NOT fix anything; file findings only.

## Scope
The registered source `09-talents` (the chapter's .qmd). This chapter is the source of record for
three card families: 21 Talents, 4 Basic Attacks, and 17 Weapon Maneuvers (42 cards, no tables).
Other chapters depend on it and mirror it: ch15 (equipment, "weapons follow the cards"), ch05
(class ability tables), ch13 (combat, conditions, the crit/fumble tables), ch16 (armor and shields),
ch22 (reference sheets), ch19 (GM guidance). Cross-check against the authoritative chapters only
where a claim is canon-determined: attributes ch03, disciplines/ladder/budget ch08, advancement
and the DP economy ch18, core resolution/tiers/difficulty/Boon-Bane ch06, combat and the condition
table ch13, social ch14, armor ch16, equipment ch15, spells ch11 and ch12, class abilities ch05,
glossary ch21.

## Locked conventions the chapter must satisfy (cite the violated convention in every finding)
- **Damage budget is FLAT.** Novice 2/4/6, Adept 6/9/12, Master 9/15/21 on Weak/Standard/Strong.
  No damage dice anywhere; the only sanctioned dice are 3d6 one-roll checks, 4d6 for Boon/Bane
  (keep highest or lowest three), and explicit random-effect tables (d6 criticals and fumbles).
- **One-roll principle:** the attack or casting roll IS the damage roll. Zero separate damage rolls.
- **Two printed damage expressions, and their bases are fixed.** FLAT uses the row as listed.
  ATTRIBUTE-SCALED adds the card's stated attribute to a base value: Novice cards use the
  Basic-card floor 1/2/3 (ch08:248, ch09's own basic attacks, ch15:60), Adept and Master cards use
  the row minus 3 (3/6/9 and 6/12/18). Melee adds Brawn (Finesse may substitute Agility); missile
  and thrown attacks are FLAT with no attribute added. Minimum 1 damage.
- **Card costs are flat 2/4/8 DP at Novice/Adept/Master for every class.** Gates: Adept at Level 3,
  Master at Level 7.
- **Prerequisite shapes:** a card's tier equals the number of Disciple ranks it requires. Novice = 1
  rank, Adept = EXACTLY 2 ranks, Master = EXACTLY 3 ranks (3 different, 2+1, or 3 same). Maximum 3
  ranks in any one Discipline. Weapon cards gate on the weapon Disciplines (Blades, Axes, Polearms,
  Archery, Heavy Weapon, Unarmed).
- **ZERO flat +N damage riders (book-wide law, weapons rework 2026-08-19).** No card anywhere may add
  a flat damage number. The ONLY sanctioned damage booster is the tier bump, always phrased "+1
  damage tier" (use the row one step above on the budget), the Overchannel convention. A card whose
  base hit also deals damage cannot then stack a recurring damage rider on an off-table sum: base hit
  plus rider must land on a budget row or the rider must gate on the WEAK result (for example a
  Novice Weak 2 plus a 2 rider = 4 is on the row; gating the same rider on Strong is not).
- **ZERO numeric roll modifiers (Boon/Bane law).** A situational bonus or penalty to a ROLL is Boon
  or Bane, never +N or −N. Numbers are reserved for damage, HP, DR, DP, ranges and durations, plus
  three named exceptions: attributes and skill tiers (Novice +1, Adept +2, Master +3), the DA's
  difficulty dial, and a Challenge penalty. Boons and Banes cancel one for one, and the potence
  ladder is Boon/Bane 1 = 4d6 keep three, 2 = 5d6, 3 = 6d6, capped at three.
- **Leveled condition vocabulary.** Conditions use the leveled form (Burning 3, Slowed 5, Dazed 1,
  Asleep 2, Frozen X) as ch13's condition table defines them, or the binary name exactly (Prone,
  Frightened, Restrained, Blinded, Dazed, Hidden). Bespoke paraphrases ("take 2 ongoing fire
  damage", "slowed for 1 round" with no level, "Frozen in place") are defects.
- **Card Template v2.** A card is `Name (type)`, then a header line carrying Disciplines per tier,
  Action, Range or Area, Duration and Keywords, then body paragraphs. PASSIVE cards (talents,
  Action: Passive) are the exception: they list Novice/Adept/Master only, where Novice carries the
  full effect (Strong) and Adept and Master are strict supersets. Every card states its damage
  expression (Flat or Attribute-Scaled) in its damage line.
- **Zero em-dashes in book text (style law, book-wide).**
- **Cross-references:** every @sec-* / @tbl-* link must resolve to a real label, and no typed period
  may follow a cross-reference (the engine renders its own, so `@sec-x.` prints a doubled stop).
- **Typst conventions (MIGRATION-SPEC):** exactly one `{=typst}` fence per file with the `# H1` line
  kept above it; callout bodies in the NAMED `body: [...]` form (the positional form is silently
  dropped by the theme); every `#table(` carries `outlined: false`; `#label("sec-...")` on the line
  after its heading.
- **Phantom cards.** Any card named in this chapter must exist under exactly that name wherever else
  it is referenced, and any card this chapter references must exist somewhere in the book. A name
  that collides with a different card's name in another chapter is a defect.

## Findings format (one finding per member this round)
Each finding must be decision-oriented: name the broken value with [09-talents-abilities:LINE], the
expected or correct value, the violated convention, and the minimal fix. Cite cross-chapter canon
lines where the expected value is canon-determined. Recompute every number you check; a card's
damage line, its tier, its Discipline count and its cost must all agree with each other and with the
chapters that mirror them. A finding that cannot state the broken value and the expected value is
not a finding. Do NOT invent defects to look thorough; a chapter with few real problems is a good
outcome.
