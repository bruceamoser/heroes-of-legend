# Creature card: approved compact layout

Bruce approved the Goblin Scrapper sample on October 15, 2026. All 84 DA creature
cards use this arrangement. The top is a combat reference; the details below
supply targeting, conditions and exceptions. Design bookkeeping comes last.

```text
NAME
Short description of the creature: body, appearance, nature.
HP | Speed | Size | Armor DR (physical; always print, including 0)
Evasion | Threat | Stability
Weaknesses | Resistances | Immunities

ACTIONS
Damage legend: Weak / Standard / Strong player defense
Main Actions table: name | damage profile
Maneuvers table: name | effect
Reactions table: name | effect

DETAILS
Named attack: target, defense attribute, damage type, outcome riders, limits
Other named abilities: any details too long for the action table
General details: Basic Melee, Defend, opportunity timing
Explicit Stability source, special weaknesses and passives
Healing exceptions | senses | encounter cues | loot | summon reference

DESIGN NOTES — OUTSIDE THE CARD
Stable ID | proposal status | category | role
Creature-roll reference when needed
CV worksheet, rationale and ability-source links
```

## Reading the reference

- **Evasion** modifies player attacks against the creature. **Threat** modifies
  player defense against its attacks. Print “1 Bane” or “2 Boons,” never ambiguous
  signed numbers. “None” means no modifier. An attack-specific exception must be
  printed with that attack.
- **Armor DR** is physical resistance. An asterisk means additional resistance
  types appear in the list below. **Resistances** lists type and value, such as
  Physical (2), Fire (1). The Physical entry repeats Armor DR; never add them.
- **Size** retains the occupied footprint: 1 (medium), 2 (2x2 squares), or
  3 (3x3 squares). This presentation grants no automatic Stability or reach.
- **Stability** always appears, including 0. A nonzero grant names its source in
  Details. Highest source, maximum 3; apply the approved chain rules.
- **Weaknesses** lists existing vulnerabilities. A situational weakness points to
  its explanation below. This layout does not invent a numerical weakness rule.
- **Damage** is always Weak / Standard / Strong **player defense**. A 0/0/0
  profile causes no damage; read its conditions in Details. A healing or other
  nonattack action says “See details” rather than mixing healing outcomes into
  the defense-damage legend.
- Multiple Main Actions are choices within the normal action budget. Basic Melee
  stays in the table because opportunity attacks use it, not specialty attacks.
- Short Maneuver and Reaction rules live in their rows. Longer rules may use a
  concise row and a matching named detail. Keep their triggers, duration and limits
  on this card; the ability library must not be required during play.

Player-controlled summons keep separate attacker-facing references and their
command restrictions. Never give a summon the DA card’s opportunity Reaction or
ask the DA to reverse a summon damage table.

No adventure bands or CV worksheet in the combat reference. Markdown remains the
editable source; final physical card dimensions belong to the later layout phase.
