# Free hands and mapped tactics: first pass

**52,691 encounter trials:** 97 configurations × 500 isolated trials, plus 4,191 encounters across 900 five-encounter sequences. Same approved base damage/healing; [precise model contract](../README.md).

## Findings to review first

The mapped baseline with one healer and no potions takes 4.94 rounds in open ground, but 93.8% of parties suffer a new wound. At the doorway it takes 4.72 rounds with 0.0% observed wounds. These scenarios do not meet a common danger target merely because their round counts are similar. Enemy approach/target choice, patient reach and party placement must be varied before prescribing CV.

Potions substantially reduce wounds in the open-board fixture, but the five hand policies with a healer and potions cluster around 45–50% wounds. This run does not establish a large independent hand-access penalty; individual state tests establish the actual action costs. The largest differences here come from positioning.

At level 7 on open ground, choosing healing by useful restoration gives 8.4% wounds versus 24.6% when always choosing the highest tier and 65.0% with Novice only. That supports preserving meaningful spell choice; it does not establish these encounter stats as a level-7 budget.

The opportunity layer produced no player opportunity attacks in the aggregate fixtures: enemies can generally Disengage. A direct regression test exercises the reaction, but these trials cannot establish the value of a front line threatening opportunities. Add an enemy movement policy that must trade its Maneuver against another useful action.

The earlier range-free study omitted free-hand access. Its potion result is not evidence that potions need weakening. This pass compares explicit equipment choices on the same boards. Differences from the previous spread-targeting anchor also include reach, approach policy, walls and turn choices, so they cannot all be attributed to hands.

## Hand-access comparison

Each row has the same enemy stats and reachable-target policy. “Ignore” is an intentionally illegal control. “Prepared” keeps one hand free and gives up bow/shield use; it does not grant free equipment switching. Other policies start weapon-ready. Potions are self-administered Lesser bottles: 6 HP, d4 supply.

| Board | Hands | Potions | Healing | Rounds | Any wound | Potion uses | Drops | Stows | Timeout |
|---|---|---|---|---|---|---|---|---|---|
| open | ignore | False | none | 4.42 | 100.0% | 0.00 | 0.00 | 0.00 | 0.0% |
| open | ignore | False | one | 4.92 | 94.6% | 0.00 | 0.00 | 0.00 | 0.0% |
| open | ignore | True | none | 4.38 | 100.0% | 1.04 | 0.00 | 0.00 | 0.0% |
| open | ignore | True | one | 4.90 | 45.0% | 1.94 | 0.00 | 0.00 | 0.0% |
| open | drop_shield | False | none | 4.42 | 100.0% | 0.00 | 0.00 | 0.00 | 0.0% |
| open | drop_shield | False | one | 4.90 | 94.8% | 0.00 | 4.34 | 0.00 | 0.0% |
| open | drop_shield | True | none | 4.38 | 99.8% | 0.91 | 0.68 | 0.00 | 0.0% |
| open | drop_shield | True | one | 4.89 | 46.6% | 1.91 | 5.25 | 0.00 | 0.0% |
| open | drop_weapon | False | none | 4.41 | 100.0% | 0.00 | 0.00 | 0.00 | 0.0% |
| open | drop_weapon | False | one | 4.94 | 95.2% | 0.00 | 1.00 | 0.00 | 0.0% |
| open | drop_weapon | True | none | 4.46 | 99.8% | 1.05 | 0.98 | 0.00 | 0.0% |
| open | drop_weapon | True | one | 4.88 | 46.0% | 1.88 | 1.96 | 0.00 | 0.0% |
| open | stow | False | none | 4.43 | 100.0% | 0.00 | 0.00 | 0.00 | 0.0% |
| open | stow | False | one | 4.94 | 93.2% | 0.00 | 0.00 | 2.49 | 0.0% |
| open | stow | True | none | 4.58 | 100.0% | 1.13 | 0.00 | 0.77 | 0.0% |
| open | stow | True | one | 5.12 | 50.2% | 2.02 | 0.00 | 3.51 | 0.0% |
| open | prepared | False | none | 4.46 | 100.0% | 0.00 | 0.00 | 0.00 | 0.0% |
| open | prepared | False | one | 4.90 | 92.4% | 0.00 | 0.00 | 0.00 | 0.0% |
| open | prepared | True | none | 4.39 | 100.0% | 1.18 | 0.00 | 0.00 | 0.0% |
| open | prepared | True | one | 4.87 | 47.8% | 1.85 | 0.00 | 0.00 | 0.0% |
| door | ignore | False | none | 4.47 | 17.2% | 0.00 | 0.00 | 0.00 | 0.0% |
| door | ignore | False | one | 4.75 | 0.0% | 0.00 | 0.00 | 0.00 | 0.0% |
| door | ignore | True | none | 4.44 | 2.2% | 1.19 | 0.00 | 0.00 | 0.0% |
| door | ignore | True | one | 4.43 | 0.0% | 0.67 | 0.00 | 0.00 | 0.0% |
| door | drop_shield | False | none | 4.51 | 19.6% | 0.00 | 0.00 | 0.00 | 0.0% |
| door | drop_shield | False | one | 4.72 | 0.0% | 0.00 | 1.65 | 0.00 | 0.0% |
| door | drop_shield | True | none | 4.46 | 3.2% | 1.17 | 0.99 | 0.00 | 0.0% |
| door | drop_shield | True | one | 4.45 | 0.0% | 0.68 | 1.32 | 0.00 | 0.0% |
| door | drop_weapon | False | none | 4.45 | 18.4% | 0.00 | 0.00 | 0.00 | 0.0% |
| door | drop_weapon | False | one | 4.74 | 0.0% | 0.00 | 1.00 | 0.00 | 0.0% |
| door | drop_weapon | True | none | 4.68 | 3.0% | 1.27 | 1.21 | 0.00 | 0.0% |
| door | drop_weapon | True | one | 4.78 | 0.2% | 0.81 | 1.30 | 0.00 | 0.0% |
| door | stow | False | none | 4.48 | 18.0% | 0.00 | 0.00 | 0.00 | 0.0% |
| door | stow | False | one | 4.74 | 0.0% | 0.00 | 0.00 | 1.20 | 0.0% |
| door | stow | True | none | 4.79 | 2.6% | 1.38 | 0.00 | 1.01 | 0.0% |
| door | stow | True | one | 4.69 | 0.4% | 0.83 | 0.00 | 1.15 | 0.0% |
| door | prepared | False | none | 5.25 | 82.4% | 0.00 | 0.00 | 0.00 | 0.0% |
| door | prepared | False | one | 5.73 | 8.2% | 0.00 | 0.00 | 0.00 | 0.0% |
| door | prepared | True | none | 5.11 | 18.2% | 1.76 | 0.00 | 0.00 | 0.0% |
| door | prepared | True | one | 5.50 | 5.0% | 1.31 | 0.00 | 0.00 | 0.0% |

At 500 trials, a worst-case binomial 95% margin is ±4.4 percentage points. Small policy differences are noise-sensitive. Hand availability changes actions and protection; it is not a fixed numeric penalty that can be subtracted from every healing result.

## Two-handed grip

This layer uses the same damage profile, with ordinary melee weapons held in two hands. It is a hand-occupancy test, not a new weapon damage category.

| Board | Policy | Rounds | Any wound | Potion uses | Pickups |
|---|---|---|---|---|---|
| open | drop_weapon | 5.19 | 47.0% | 2.05 | 1.05 |
| open | stow | 5.26 | 48.6% | 2.12 | 0.00 |
| door | drop_weapon | 4.70 | 0.2% | 0.77 | 0.72 |
| door | stow | 4.67 | 0.0% | 0.71 | 0.00 |


## Incremental positioning layers

Default hand policy drops shield first. Opportunity attacks work both ways, cost Reactions and use Basic Melee. Casters can Disengage before leaving reach. The layer includes spell attacks and healing casts, but not standing/stow/pickup triggers.

| Board | Layer | Rounds | Any wound | Player OAs | Enemy OAs | Forced squares | Unresolved group collisions |
|---|---|---|---|---|---|---|---|
| open | opportunity | 4.93 | 94.4% | 0.00 | 1.45 | 0.00 | 0.00 |
| open | riders | 4.89 | 92.2% | 0.00 | 0.00 | 0.37 | 0.01 |
| open | enemy_push | 4.94 | 86.8% | 0.00 | 0.00 | 0.81 | 0.06 |
| open | wounds | 5.01 | 93.2% | 0.00 | 0.00 | 0.20 | 0.26 |
| door | opportunity | 4.70 | 2.6% | 0.00 | 1.19 | 0.00 | 0.00 |
| door | riders | 4.73 | 0.2% | 0.00 | 0.00 | 0.17 | 0.00 |
| door | enemy_push | 4.74 | 0.0% | 0.00 | 0.00 | 0.18 | 0.10 |
| door | wounds | 4.70 | 0.0% | 0.00 | 0.00 | 0.00 | 0.00 |
| open | baseline | 4.94 | 93.8% | 0.00 | 0.00 | 0.00 | 0.00 |
| door | baseline | 4.72 | 0.0% | 0.00 | 0.00 | 0.00 | 0.00 |
| rough | baseline | 4.95 | 76.8% | 0.00 | 0.00 | 0.00 | 0.00 |

Occupied collision groups are flagged and not fully resolved. Do not use rows with unresolved collisions to certify pinball damage or crowd-control balance. Single-body wall impacts and tether distances are exercised directly.

## Level-1 signature samples

Only the four baseline classes are included. All other members keep their first signature choice. These are scripted tactical policies, not optimal play or a ranking of all classes.

| Board | Changed class | Choice index | Rounds | Any wound | Interposes | Forced squares |
|---|---|---|---|---|---|---|
| open | Protector | 0 | 4.94 | 93.6% | 0.00 | 0.00 |
| open | Protector | 1 | 4.93 | 93.8% | 0.00 | 0.00 |
| open | Protector | 2 | 4.93 | 69.2% | 1.83 | 0.00 |
| open | Blade | 0 | 4.93 | 93.4% | 0.00 | 0.00 |
| open | Blade | 1 | 4.95 | 93.8% | 0.00 | 0.00 |
| open | Blade | 2 | 4.92 | 93.6% | 0.00 | 0.00 |
| open | Arcanist | 0 | 4.89 | 94.0% | 0.00 | 0.00 |
| open | Arcanist | 1 | 4.93 | 94.8% | 0.00 | 0.00 |
| open | Arcanist | 2 | 4.90 | 94.6% | 0.00 | 0.00 |
| open | Shepherd | 0 | 4.92 | 95.2% | 0.00 | 0.00 |
| open | Shepherd | 1 | 4.90 | 95.8% | 0.00 | 0.00 |
| open | Shepherd | 2 | 4.83 | 92.0% | 0.00 | 0.00 |
| door | Protector | 0 | 4.68 | 0.2% | 0.00 | 0.00 |
| door | Protector | 1 | 4.74 | 0.2% | 0.00 | 0.00 |
| door | Protector | 2 | 4.48 | 0.0% | 1.38 | 0.00 |
| door | Blade | 0 | 4.74 | 0.0% | 0.00 | 0.00 |
| door | Blade | 1 | 4.77 | 0.0% | 0.00 | 0.00 |
| door | Blade | 2 | 4.75 | 0.0% | 0.00 | 0.00 |
| door | Arcanist | 0 | 4.73 | 0.0% | 0.00 | 0.00 |
| door | Arcanist | 1 | 4.74 | 0.0% | 0.00 | 0.00 |
| door | Arcanist | 2 | 4.70 | 0.2% | 0.00 | 0.00 |
| door | Shepherd | 0 | 4.69 | 0.0% | 0.00 | 0.00 |
| door | Shepherd | 1 | 4.77 | 0.2% | 0.00 | 0.00 |
| door | Shepherd | 2 | 5.15 | 1.4% | 0.00 | 0.00 |

**Unexercised choices:** Blade Poise has no footing Bane here; Arcanist Insight cannot improve an omniscient damage-choice policy; Shepherd Guiding Voice has no Aid policy. Equal outputs do not establish that these cards are weak or balanced. The remaining five classes and higher signatures still need their own tactical fixtures.

## Summons and tether

The Arcanist legally swaps a 2-DP level-1 utility purchase for Summon Companion, retaining its granted Summon 1. No count cap. Main commands attack and convert Maneuver to movement; repeated summoning creates fresh bodies. Other commands and general NPC-vs-summon defense remain declared fixture limitations.

| Board | Replace each turn | Rounds | Any wound | Bodies summoned | Summon attacks | Tether losses |
|---|---|---|---|---|---|---|
| open | False | 5.31 | 46.2% | 3.36 | 4.95 | 0.00 |
| open | True | 5.31 | 45.2% | 4.96 | 4.96 | 0.00 |
| door | False | 6.29 | 35.6% | 3.56 | 3.03 | 0.00 |
| door | True | 7.08 | 40.8% | 6.74 | 2.36 | 0.00 |

Low observed tether losses do not make the tether irrelevant: these policies stay close. Exact boundary tests force a summon across square 6→7; controller and summon positions are checked after movement. A dedicated enemy strategy targeting the controller’s position remains future work.

## Choose healing rather than force a tier

“Adaptive” selects the learned spell with greatest expected effective healing minus caster cost, including missing HP and self-payment. It does not predict enemy future turns. Larger spell ownership does not force its use.

| Board | Level | Policy | Rounds | Any wound | Heals | Caster HP | Novice/Adept/Master casts |
|---|---|---|---|---|---|---|---|
| open | 3 | novice | 4.01 | 76.6% | 3.49 | 3.49 | 3.49 / 0.00 / 0.00 |
| open | 3 | highest | 3.99 | 12.6% | 3.55 | 10.64 | 0.01 / 3.54 / 0.00 |
| open | 3 | adaptive | 3.99 | 13.2% | 3.60 | 10.81 | 0.00 / 3.60 / 0.00 |
| open | 7 | novice | 3.78 | 65.0% | 3.35 | 3.35 | 3.35 / 0.00 / 0.00 |
| open | 7 | highest | 3.60 | 24.6% | 2.92 | 16.66 | 0.08 / 0.82 / 2.02 |
| open | 7 | adaptive | 3.73 | 8.4% | 3.33 | 12.81 | 0.02 / 2.60 / 0.71 |
| door | 3 | novice | 4.21 | 0.0% | 1.21 | 1.21 | 1.21 / 0.00 / 0.00 |
| door | 3 | highest | 4.22 | 0.2% | 1.15 | 3.43 | 0.00 / 1.14 / 0.00 |
| door | 3 | adaptive | 4.26 | 0.0% | 1.15 | 3.44 | 0.00 / 1.15 / 0.00 |
| door | 7 | novice | 3.37 | 0.0% | 1.05 | 1.05 | 1.05 / 0.00 / 0.00 |
| door | 7 | highest | 3.40 | 0.2% | 0.98 | 5.13 | 0.00 / 0.43 / 0.55 |
| door | 7 | adaptive | 3.33 | 0.0% | 0.97 | 3.64 | 0.01 / 0.78 / 0.19 |


## Wounds and treatment over five encounters

Scars/Grit persist; full HP and recovered dropped equipment between encounters. Treatment-enabled cases receive one safe day between fights and only the party’s learned capabilities. These physical-damage encounters do not exercise every Mental/Elemental/Radiant/Life table result. Cleanup assumes safe assistance reaches Dying PCs before another death choice, so this is optimistic rescue.

| Board | Wounds active | Treatment | Encounter | Full-party completion | Mean scars | Grit left | Treatments | Unresolved collisions |
|---|---|---|---|---|---|---|---|---|
| open | False | False | 1 | 96.7% | 2.22 | 7.67 | 0 | 0 |
| open | False | False | 5 | 66.0% | 12.05 | 6.43 | 0 | 0 |
| open | True | False | 1 | 95.3% | 2.25 | 7.73 | 0 | 38 |
| open | True | False | 5 | 51.3% | 15.34 | 5.46 | 0 | 63 |
| open | True | True | 1 | 97.3% | 2.21 | 7.63 | 149 | 34 |
| open | True | True | 5 | 55.3% | 16.08 | 5.56 | 322 | 63 |
| door | False | False | 1 | 100.0% | 0.00 | 8.00 | 0 | 0 |
| door | False | False | 5 | 100.0% | 0.03 | 7.97 | 0 | 0 |
| door | True | False | 1 | 100.0% | 0.00 | 8.00 | 0 | 0 |
| door | True | False | 5 | 100.0% | 0.11 | 7.89 | 0 | 0 |
| door | True | True | 1 | 100.0% | 0.00 | 8.00 | 0 | 0 |
| door | True | True | 5 | 100.0% | 0.14 | 7.89 | 7 | 2 |


## Grapple vulnerability: local calculation

This is an exact expected-damage comparison, not a grapple encounter simulation. Attacks gain Boons for the actual target rating; a grappler’s own contribution determines their vulnerability.

| Target Grappled | Net Boons | Basic 2/3/5 expected damage versus resistance 2 |
|---|---|---|
| 0 | 0 | 1.19 |
| 1 | 1 | 1.46 |
| 2 | 2 | 1.75 |
| 3 | 3 | 2.02 |

Full ally rescue, Force escape followed by movement, and grappler action choices still need encounter policies. The existing no-escape grappling trials are not relabeled as those tests.

## What this pass can support

Keep the baseline numbers steady while reviewing access and positioning. Potions remain intentionally powerful, but using one is not free when both hands are occupied. Maps and policies can change danger more than a one-point damage adjustment. Do not tune against the open-board result as if every DA used this target policy.

Remaining priorities: resolve occupied moving-group geometry; test ally potion delivery and pickup/standing opportunity triggers; add the remaining classes and meaningful Aid/observation policies; test hostile forced movement deliberately breaking summon tethers. These are explicit remaining features, not implied results of the current run.
