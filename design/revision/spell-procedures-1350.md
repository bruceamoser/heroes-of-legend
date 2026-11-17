# Spell procedure review #1350

Follow-up to the contextual editorial review #1349, requested after Bruce found
Goodberry omitted its healing. Downstream: bruceamoser/heroes-of-legend-foundry#323.

## Method

Read all 319 spell effects across 29 books and their action, target/range and
duration fields. Compare consequential effects with shared magic, recovery,
objectives, commands, item use and Craft repair procedures. Ask what the player
spends, what changes immediately, how later activity happens and when it ends.
A familiar spell name is not a substitute for a rule. An accurate answer, a new
sense, a doorway or a repaired object can be a concrete benefit without a Boon.
This is a procedure review, not proof of balance or exhaustive interaction testing.

## Decisions and corrections

- **Goodberry:** Bruce explicitly requests 1 HP healing. Each berry restores 1 HP
  when consumed with a Maneuver; feeding another uses the existing healing-potion
  recipient/Reaction rules. Six berries, 1 SP, one-minute ritual, one meal each and
  24-hour expiry stay. Consumed berries are counted individually, not inventory
  dice. Magical healing and first aid remain separate.
- **Plant Growth:** Bruce requests an immediate effect and specifically the
  difficult-terrain mechanic. Change the ten-minute Ritual to a Main Action. Keep
  3 SP, the 6-by-6 patch, range 6 and 24-hour duration; allow clear squares/paths.
  Remove vague harvest improvement. The proposed harvest doubling and separate
  four-movement cost were not accepted and are not rules.
- **Mending:** state the existing DA-set repair HP procedure for items that track
  HP, before casting. Ordinary small clean breaks recover function as printed;
  no universal object HP or extra repair bonus is invented.
- **Fabricate:** a ritual contributes its stated progress; the item becomes ready
  at objective completion, rather than apparently appearing before the roll.
- **Shapechange:** its natural attack uses a Main Action against one adjacent
  creature; retain Brawn/Agility and 3/5/7 physical damage.
- **Rune Mastery / Rune Mastery — Seal:** use the stored spell’s printed attribute
  with the original caster’s value; the rune ritual itself has Attribute: None.

D&D reference consulted for Plant Growth's immediate overgrowth concept:
https://www.dndbeyond.com/spells/2618869-plant-growth . HoL uses its own difficult
terrain rule as explicitly directed, not D&D's separate movement multiplier.

## Book-by-book coverage

| Book | Spells | Resolution review |
|---|---:|---|
| air | 11 | Damage, movement, safe descent and repeated storm actions are explicit; weather supplies ordinary environmental conditions. |
| animation | 11 | Forms use printed HP, command procedures and the spell attribute; intelligent items explicitly lend a fixed Knowledge score. |
| binding | 11 | Conditions, escape, boundaries, damage and prison release are explicit; negotiated service remains a social agreement. |
| calling | 11 | Energy forms name usable profiles and commands; independent allies negotiate service using actual capabilities. |
| channeling | 11 | Transfers state donor loss, recipient capacity, costs, consent and subsequent actions. |
| decay | 11 | Damage, healing, conditions and treatment/removal procedures are explicit. |
| detection | 11 | Each result gives named information, targeting permission or objective progress; accurate information needs no invented bonus. |
| dreams | 11 | Dream communication specifies content; hostile effects, plan benefit and projection activities have procedures. |
| earth | 11 | Movement, cover, HP, resistance, demolition progress and petrification remedies are stated. |
| echoes | 11 | Information is bounded by question, event, time window and result band; memory playback names its action. |
| emotion | 11 | Social progress uses attainable objectives; conditions and target choices are stated. |
| farseeing | 11 | Senses, ranges and observation/direction actions are explicit; information is the benefit. |
| flame | 11 | Attacks and ongoing triggers have numbers; Boil Liquid heats an unattended liquid for ordinary use, not an unstated attack. |
| growth | 11 | Goodberry now restores 1 HP with consumption timing. Plant Growth now uses a Main Action and existing difficult terrain, removing vague harvest improvement. |
| imbuement | 11 | Rune Mastery now identifies the stored spell’s attribute and original caster’s value, rather than the ritual’s None field. |
| passage | 11 | Destinations, passengers, obstruction outcomes and gate operation are explicit. |
| perception | 11 | Images and deception use the shared illusion examination; repeat directing actions and invisibility endings are explicit. |
| portents | 11 | Information, Boons, rerolls and shared limits are explicit. |
| protection | 11 | Defense, resistance, damage reduction/transfer and one-use effects are quantified. |
| restoration | 11 | HP, condition reductions, remedies and resurrection limits are explicit. |
| sanctuary | 11 | Shelter and warnings have stated functions; wards, movement, resistance and structure HP are explicit. |
| seals | 11 | Rune Mastery — Seal now identifies the stored spell’s attribute and original caster’s value. Locks and cancellation use shared objectives. |
| shaping | 11 | Fabricate now makes completion contingent on the crafting objective. Mending explicitly uses the established repair-objective procedure for HP-bearing items. |
| spirits | 11 | Spirit information, attacks, death intervention, summoned profiles and resurrection use stated procedures. |
| telekinesis | 11 | Movement, damage and object/force-barrier limits are explicit. |
| thought | 11 | Communication and information have scope; borrowed knowledge supplies a Boon and language, not unspecified stolen abilities. |
| transformation | 11 | Shapechange now explicitly names a Main Action and adjacent target for its natural attack. Other forms use the named Basic Unarmed procedure. |
| unraveling | 11 | Cancellation targets, progress, costs and partial-result behavior are explicit. |
| water | 11 | Water quantities, movement effects, damage and barriers are specified. |

## Validation

Both books rebuilt successfully through the complete starter-kit audit pipeline.
The spell-spread audit passes all 29 facing spreads, 319 intact blocks and 29
single-spell masteries with their art and discipline tokens. Visually inspected
Growth (112–113), Transformation (116–117), Imbuement (144–145), Shaping (146–147)
and Seals (154–155); all revised blocks fit. Reviewed the final source diff for
scope, existing mechanics and Bruce’s difficult-terrain correction. No Workshop
deployment or native Foundry implementation is included.
