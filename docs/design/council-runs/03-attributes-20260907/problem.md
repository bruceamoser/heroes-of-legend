# Problem: Council review of Chapter 3, Attributes (quarto-book/chapters/03-attributes.qmd)

You are the hol-rulebook council. Audit this chapter as a publishable unit of the
Heroes of Legend TTRPG rulebook. The source registered in this run IS the chapter file;
its label is `03-attributes`. Cite findings as `03-attributes.qmd:LINE`.

## Disposition plan format (librarian, final synthesis)
Classify every finding into exactly one tier:
- **mechanical**: chapter-local, zero mechanics change, no content judgment (heading
  levels, table rows, wording, captions, cross-refs, stale vocabulary, math typos,
  pagebreaks, em-dashes).
- **substantive**: new content, multi-file, or cross-chapter reconciliation.
- **design-decision**: touches budget/prereqs/new rules/canon/balance; needs Bruce's veto.

## Locked conventions (the law)
- One-roll principle: the 3d6 attack/casting/check roll IS the outcome roll. No damage
  dice, no second roll. Tiers: Weak 1-8, Standard 9-14, Strong 15-18+ (ch06).
- Damage budget (flat, not dice): Novice 2/4/6, Adept 6/9/12, Master 9/15/21. No flat
  +N damage riders anywhere (the riders-die law; "+1 damage tier" is the only bump).
- Card costs flat 2/4/8 DP. Prereq shapes: Adept = exactly 2 ranks, Master = exactly 3.
  Level gates: Adept L3, Master L7.
- Zero em-dashes in book text. No dice in damage/healing.
- Condition vocabulary is leveled (Burning X, Poisoned X, Slowed X, Frozen X).
  Bespoke phrasing that duplicates a condition is a residual to convert.
- Melee attack = 3d6 + Brawn; Finesse weapons use Agility. Melee attacks ADD your
  Brawn (or Agility if Finesse) to the damage row. Missiles/thrown are flat, no
  attribute added. (ch06, ch13, ch15)
- Skills key to attributes (ch07 roster, 22 skills): Athletics/Brawn, Acrobatics/Agility,
  History/Knowledge, Religion/Knowledge, Persuasion/Guile, Deception/Guile,
  Intimidation/Brawn, Thievery/Agility, Sleight of Hand/Agility.
- Divine spells roll 3d6 + Reason + relevant skill; arcane spells roll 3d6 + Knowledge
  + relevant skill (ch10).
- Attribute canon: scores -2..+2, spread totals exactly +3, increases at levels 4 and 8
  (ch18). Starting HP = 10 + Fortitude + Knowledge; +Fortitude (min 1) per level after
  L1. Initiative = 3d6 + Agility. Carry slots = 10 + (Brawn x 5). (ch02 Table 2.3, ch21)
- Dwarf ancestry gift Sturdy = +2 maximum HP (ch04).
- Canon party (ch13 worked examples): Kael = dwarf Blade, Brawn +1, Agility +2;
  Roric = dwarf Protector, Brawn +2; Lyra = halfling Odd; Ser Aldric = party Leader,
  Guile +1 (ch14:96 uses Guile +1 + Persuasion Adept +2).

## Verified context (recon already done; trust this, but re-verify any claim you
plan to act on against the chapter text itself)
- The chapter is 164 lines, 7 sections, 6 worked examples, 0 em-dashes, 0 damage dice.
- Intimidation is keyed to BRAWN in ch07:139 and ch22:175 (added to the roster 2026-08-27,
  decision #29), but the chapter's Guile description may still claim Guile covers
  intimidation. ch03 predates the Intimidation addition.
- ch03:64 dwarf HP example: 10 + FO 2 + KN 0 + Sturdy 2 = 14. Sturdy is real (ch04:45).
  Verify the arithmetic and the wording.
- ch03:158-162 Zara example: "Zara, the Unbalanced" (canon per PR #394, decision #74),
  rolls "3d6 + Reason (+2) + Religion Novice (+1)". Religion is keyed to Knowledge in
  ch07, BUT divine spells roll 3d6 + Reason + relevant skill per ch10. Decide whether
  the example reads as a divine spell roll (compliant) or a skill check (wrong attribute).
- ch03:120 "The Poisoned condition kicks in, Bane on all attacks" vs ch13's leveled
  condition "Poisoned X: takes X poison damage per round and attacks at Bane".

## Your job
Each member: audit through your lens, file findings with severity (HIGH/MEDIUM/LOW),
exact file:line, what is wrong, and the concrete fix. Report findings as JSON per the
packet schema. Do not invent problems; verify against the chapter text before claiming.
The librarian synthesizes the disposition plan (tiered, atomicity noted where fixes
interlock) and writes the final recommendation.
