# Compact creature-card migration — October 15, 2026

Bruce approved the Goblin Scrapper sample and requested the same layout for the
entire roster. Issue #1182 applies it to **all 84 DA creature cards**.

## Table use

Every card starts with HP, Speed, Size and physical Armor DR, followed by explicit
Evasion/Threat Boons or Banes, Stability, weaknesses, resistances and immunities.
Armor DR always prints, including zero; its asterisk flags additional resistance
types. The resistance list repeats physical protection without adding to it.

Main Actions use compact damage profiles. Maneuvers and Reactions have their own
tables. Named Details supply targets, defense attributes, damage types, conditions,
limits and longer special rules. A single defense-order legend covers the table.
Zero-damage control attacks retain their conditions. Healing actions point to their
own details so healing outcomes are not mistaken for player defense outcomes.

Basic Melee, Defend and Opportunity Attack remain visible. Stability sources,
passives, healing exceptions, senses and encounter cues are retained below. Design
notes and CV worksheets remain at the end, outside the combat reference.

## Mechanics preserved

All 112 specialty attack choices retain their damage and outcome effects. All
43 player-controlled summon references remain linked and retain their separate
attacker-facing rules. Main Action costs, targeting, ammunition, spell provocation,
breath limits, grapple burdens and defensive reactions were preserved.

The only intentional ability change is the approved Goblin Scrapper **Roll Away**,
replacing Stalking Step with straight-line movement of up to 2 squares that does
not provoke. It has a separate monster ability entry, bringing that library to 50.
No other creature received Roll Away as part of this layout migration.

## Verification

- Compared the pre-migration cards with the new files: 1,066 preservation checks
  cover unchanged fields, targeting, nonattack abilities, limits, ammunition,
  spell flags, Basic Melee damage, reactions and passives. Goblin’s approved
  maneuver change is explicitly excluded from preservation.
- Updated the read-only bestiary audit to parse the compact tables and named
  details. All 112 attack outcomes match their inverse player references,
  including condition riders and zero-damage attacks.
- Checked physical Armor DR against its resistance entry, the extra-resistance
  asterisk, Stability grants, summon coverage, links and unchanged CV arithmetic.
- Reviewed representative simple, multiattack, shield, healing, grappling,
  zero-damage control, ammunition and special-weakness cards for table use.
- The design catalog audit and whitespace check pass. No balance simulation or
  final book rendering is claimed by this Markdown layout change.

Useful review samples: [Goblin Scrapper](creatures/goblin-scrapper.md),
[Red Dragon](creatures/red-dragon.md), [Shield Soldier](creatures/shield-soldier.md),
[Moon Hart](creatures/moon-hart.md), [Giant Spider](creatures/giant-spider.md),
[Crystal Ooze](creatures/crystal-ooze.md) and [Emberling](creatures/emberling.md).

The unresolved design questions from the [earlier review](review.md), including
collision damage timing and refreshed summon healing pools, remain unresolved.
This migration does not silently decide them or recalibrate CV.
