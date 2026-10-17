# Creature card: approved compact layout

Bruce’s October 17 Adder review refines the earlier Goblin Scrapper layout. The
DA PDF presents all 192 creatures with the structure below. Authored Markdown
retains complete source data for audits and alternate exports; the book renderer
moves shared rules to the introduction and presents each unique rule once.

```text
NAME (CV value)                          SUMMON MARKER, if eligible
Short description of the creature: body, appearance, nature.

LEFT STAT COLUMN                        RIGHT DEFENSE COLUMN
Brawn, Fortitude, Agility,               Weaknesses
Guile, Knowledge, Reason                Resistances
HP, Speed, Size, Armor DR                Immunities
Evasion, Threat, Stability

UNIQUE ACTIONS
Main Actions: name | defense | damage type | Weak / Standard / Strong defense
Maneuvers: name | effect
Reactions: name | effect
Omit empty tables and universal actions.

UNIQUE DETAILS
Named action: narrative, target, and limits not already in its table
Other named abilities: remaining triggers, duration and restrictions
Explicit Stability source, special weaknesses and passives

IN THE WORLD — TWO COLUMNS
Healing and exceptions, senses, signs, purpose, tactics and retreat,
counterplay/conversation, habitat, communication, loot

INTERNAL DESIGN NOTES — NOT PRINTED IN THE BOOK
Stable ID, status, category, role, creature-roll reference where needed,
CV worksheet, rationale and ability-source links
```

## Reading the reference

- All six **Attributes** appear before HP, using the creature’s existing values.
- **Armor DR** always appears, including 0. It is physical resistance. An asterisk
  points to additional resistance types in the right column. The Physical entry
  repeats Armor DR; never add them together.
- **Evasion** modifies player attacks; **Threat** modifies player defense. Print
  **0** for no modifier, otherwise “1 Bane” or “2 Boons.” Keep attack-specific
  exceptions with the attack. Existing source “None” values render as 0.
- **Size** retains its footprint. Size alone grants no reach or Stability.
- **Stability** always appears, including 0. A nonzero grant identifies its source
  in the unique details. Highest source, maximum 3; approved chain rules apply.
- **Weaknesses**, **Resistances** and **Immunities** remain explicit, even when None.
  Situational weaknesses retain their explanation below.
- **Defense** names the player’s attribute; a harmful use of healing specifies
  Fortitude. **Damage type** is a separate column.
- Each slash separates a complete **Weak / Standard / Strong player defense**
  outcome, including all conditions and movement. Do not repeat those outcomes,
  defense attributes or damage types below the table. Retain targets, narrative
  and limits that the table does not supply. Healing outcomes stay distinct from
  harmful defense outcomes.
- Main Actions are choices within the normal budget. **Basic Melee**, **Defend**
  and **Opportunity Attack** are explained once in the bestiary introduction.
  Its Basic Melee damage reference preserves all three existing creature profiles;
  removing the rows does not standardize or change their damage.
- A Maneuver or Reaction’s effect appears once in its row. Narrative and remaining
  restrictions appear under the matching name. Triggers and limits must remain
  available on the card; do not require a monster-ability appendix lookup.
- The **ring-and-spark summon marker** occupies the upper-right title corner.
  A compact category/level label such as **Animal 1** preserves eligibility and
  links to the separate player profile. No marker means ineligible. Omit the
  redundant Summoning line from the lower section.

Player-controlled summons keep separate attacker-facing profiles and command
restrictions. The marker does not grant the DA card’s independent Reactions.

The CV in the title is still an estimate. Its worksheet stays in our working notes and is
excluded from the DA book. No adventure bands appear on the card.
