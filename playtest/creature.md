# Creatures and encounter fixtures

All entries provisional. Creatures use compact stats rather than player DP builds.
All have one Main, one Maneuver, one movement allowance, one Reaction unless stated.
Dead at 0 HP. Ordinary attacks use player Agility defense and physical damage.
Resistance is physical unless otherwise specified. No creature-only power is implied
by its name. Tests disable spare creature Maneuvers in the baseline; adding Defend
or Aid must be a separate experiment rather than a hidden difficulty increase.

| Creature | HP | Resistance | Speed | Main attack, adjacent | Notes |
|---|---:|---:|---:|---|---|
| Skirmisher | 12 | 1 | 6 | 4/5/7 | Reference body; no added rider |
| Stalwart | 16 | 1 | 5 | 3/4/6 | Durable low-pressure comparison |
| Bruiser | 16 | 1 | 5 | 5/6/8 | Higher incoming-damage comparison |
| Armored Guard | 12 | 3 | 5 | 4/5/7 | Test physical resistance vs magic |
| Field Healer | 12 | 1 | 5 | 4/5/7 or Mend | Reason +1, same healing card; no resurrection |
| Ember Beast | 12 | 1 | 6 | 4/5/7 | Standard Burning 1, Strong Burning 2 |

Sweep fixtures may vary HP/damage/count independently; they are explicitly labeled
numerical variants of these bodies, not finished bestiary entries. Focus fire is
an adversarial policy, spread fire a random policy, front targeting an assumed
formation. None is automatically the universal behavior of creatures.

## Provisional CV method

A scalar cannot yet substitute for a full stat block. The test report fits duration
and wound pressure separately. Use two intermediate measurements:

- **Durability:** HP divided by expected damage of the reference party's legal
  attacks, including physical/fire resistance and attack Banes.
- **Threat per active turn:** expected damage against that party's actual defenses,
  including defensive Boons, resistance, and target policy.

A provisional creature CV is 10 × durability × threat, normalized to the reference
Skirmisher. Sum creature CV for an encounter, then retain creature count and special
abilities as explicit warnings. The report checks predictive error rather than
assuming this formula succeeds. Healing, control, AoE, free attacks, and off-turn
activity need measured adjustments and cannot be assigned an invented flat premium.

Budget anchors should be empirical by level and party size; four is the reference
party. Approximate other sizes by multiplying by party size / 4 only until tested.
No certified CV budget is claimed when the target wound/duration combination fails.

## Body-count correction experiment

For the four-PC ordinary-creature fixtures, a pressure-only correction of
(enemy count + 1) / 5 improves prediction of total enemy attack opportunities.
The report compares training counts 2/4/8 against held-out counts 3/6. This is
not yet an adopted rule or a proven party-size formula. Keep the raw summed CV
and this experimental adjusted pressure separate, and never use the correction
to hide special powers in an otherwise ordinary stat block.
