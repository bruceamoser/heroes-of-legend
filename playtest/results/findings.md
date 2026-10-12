# Revised working playtest findings — v0.2

October 12, 2026. Test catalog refresh for issues #1127 and #1128. Results are measured under the [model contract](../tests/README.md), not a declaration that HOL is balanced.

**869,843 encounter trials:** 532 isolated configurations (804,000 encounters), plus 65,843 encounters in 7,000 sequences. Separately: 240,000 local grapple trials. 38 saved character snapshots; 126 purchased/signature prototypes; 11 universal references.

## Same anchor, revised rules

Four level-1 PCs versus four HP-14 enemies, Physical resistance 1, damage 5/6/8, spread targeting. Owned armor/shields and spare-Maneuver Defend; no potions or active wound overlay. This is the original anchor, not a newly tuned encounter.

| Version | Healing | Rounds | Any party wound | Healing actions | Caster HP spent | Timeout |
|---|---|---|---|---|---|---|
| v0.1 | none | 4.00 | 26.8% | 0.00 | 0.00 | 0.0% |
| v0.1 | one | 4.34 | 1.5% | 2.11 | 0.00 | 0.0% |
| v0.2 | none | 4.01 | 27.8% | 0.00 | 0.00 | 0.0% |
| v0.2 | one | 4.48 | 4.7% | 2.87 | 2.87 | 0.0% |

The comparison changes the approved rules together, including Protector HP. It does not isolate healing alone. Soft targets remain about four rounds and 20–30% party wound chance without a healer, 5–15% with one. At 3,000 trials, the worst-case 95% sampling margin is ±1.8 percentage points; model omissions matter more.

## Takeaways for the next discussion

- The original anchor now gives **4.01 rounds / 27.8% wound chance without healing**, and **4.48 rounds / 4.7% with one healer**. The healer result is close to the lower edge of the soft target; this does not require immediate retuning.
- Fixed healing removes the old unlimited full-HP restoration loop in the tested solo-healer fixtures. This is evidence for the new model, not proof that no future card can create a loop.
- Even Lesser potions strongly reduce wounds because their Maneuver cost preserves offense. Supply, access and price deserve attention before increasing healing numbers.
- Forcing higher-tier healing at the same half-HP trigger can increase wounds: extra caster cost and over-healing can outweigh restoration. Prefer testing additional benefits or smarter tier choice over assuming bigger raw numbers are sufficient.
- Higher basic damage helps basic-only stress fights, but has little effect when purchased attacks dominate. Test its opportunity/free-attack role before adopting a universal increase.

## Basic attacks: do higher values matter?

“Basic only” voluntarily suppresses purchased attacks; it is a stress test, not an optimal build. “Full catalog” chooses the best ordinary learned damage card. Free attacks and opportunity damage are not multiplied in this comparison.

| Profile | Resistance | Basic only | Healing | Rounds | Any wound |
|---|---|---|---|---|---|
| [2, 3, 5] | 1 | False | none | 3.99 | 25.0% |
| [2, 3, 5] | 1 | False | one | 4.49 | 4.7% |
| [2, 3, 5] | 1 | True | none | 9.65 | 99.5% |
| [2, 3, 5] | 1 | True | one | 10.39 | 83.4% |
| [2, 3, 5] | 3 | False | none | 6.04 | 74.1% |
| [2, 3, 5] | 3 | False | one | 6.39 | 24.4% |
| [2, 3, 5] | 3 | True | none | 24.53 | 100.0% |
| [2, 3, 5] | 3 | True | one | 20.27 | 100.0% |
| [3, 4, 6] | 1 | False | none | 4.00 | 27.7% |
| [3, 4, 6] | 1 | False | one | 4.49 | 5.1% |
| [3, 4, 6] | 1 | True | none | 6.52 | 86.0% |
| [3, 4, 6] | 1 | True | one | 7.71 | 40.2% |
| [3, 4, 6] | 3 | False | none | 6.04 | 72.0% |
| [3, 4, 6] | 3 | False | one | 6.37 | 23.2% |
| [3, 4, 6] | 3 | True | none | 19.66 | 100.0% |
| [3, 4, 6] | 3 | True | one | 17.21 | 99.9% |

Against resistance 3, 2/3/5 becomes 1/1/2 and 3/4/6 becomes 1/1/3. If the full-catalog result barely changes, that means characters chose purchased attacks; it does not prove basic damage is irrelevant to opportunity/free-attack abilities.

## Life resistance and potions

Life resistance protects against damage but also reduces restoration, minimum 1. Caster cost is never reduced. All-healer means every PC who actually learned Mend may choose it; it does not grant free cards.

| Life resistance | Healing policy | Rounds | Any wound | Heals | Caster HP cost |
|---|---|---|---|---|---|
| 0 | none | 4.00 | 25.3% | 0.00 | 0.00 |
| 1 | none | 4.00 | 25.9% | 0.00 | 0.00 |
| 2 | none | 4.00 | 26.4% | 0.00 | 0.00 |
| 3 | none | 4.00 | 25.2% | 0.00 | 0.00 |
| 0 | one | 4.47 | 4.6% | 2.80 | 2.80 |
| 1 | one | 4.51 | 7.1% | 2.95 | 2.95 |
| 2 | one | 4.52 | 9.8% | 3.01 | 3.01 |
| 3 | one | 4.52 | 14.3% | 3.05 | 3.05 |
| 0 | all | 4.99 | 0.9% | 4.28 | 4.28 |
| 1 | all | 5.18 | 1.4% | 5.13 | 5.13 |
| 2 | all | 5.43 | 4.8% | 6.44 | 6.44 |
| 3 | all | 5.66 | 9.4% | 7.55 | 7.55 |


| Potion HP | Healing policy | Rounds | Any wound | Potion uses |
|---|---|---|---|---|
| 6 | none | 3.96 | 3.0% | 2.44 |
| 6 | one | 4.01 | 2.5% | 2.30 |
| 10 | none | 3.97 | 2.8% | 1.95 |
| 10 | one | 3.99 | 2.9% | 1.93 |
| 16 | none | 3.97 | 2.6% | 1.93 |
| 16 | one | 3.98 | 2.6% | 1.87 |

Each potion scenario supplies one d4 bottle per PC. Strength and supply are separate. These are explicitly supplied consumables, not starting grants or an economic recommendation.

## Healing tiers and enemy healing

Greater Mend and Deep Restoration are actual purchasable prototypes. The Shepherd progression buys the discipline ranks and cards. Requested higher-tier healing falls back to Mend if not learned. The enemy tier tests explicitly supply the indicated healing ability; NPC support roll Reason +1 remains a test convention.

| Party level | Requested tier | Rounds | Any wound | Heals | HP cost |
|---|---|---|---|---|---|
| 3 | 1 | 3.56 | 2.6% | 1.98 | 1.98 |
| 3 | 3 | 3.54 | 4.7% | 1.82 | 5.47 |
| 7 | 1 | 2.87 | 1.2% | 1.23 | 1.23 |
| 7 | 3 | 2.88 | 1.6% | 1.18 | 3.54 |
| 7 | 7 | 2.85 | 6.6% | 0.84 | 5.91 |


| Enemy healing tier | Rounds | Timeout | Enemy heals | Enemy HP cost |
|---|---|---|---|---|
| 1 | 3.85 | 0.0% | 2.60 | 2.60 |
| 3 | 4.25 | 0.0% | 2.82 | 8.45 |
| 7 | 4.73 | 0.0% | 2.98 | 20.86 |

A higher casting cost is not assumed to make a card better. Actual net healing, over-healing and opportunity costs must justify purchase. Higher signatures remain disabled in these encounters.

## Original one-feature layers, rerun

Same HP-12 focus-fire fixture as the first pass, not the spread-targeting anchor. Opportunity attacks assume contact; no map movement or Disengage policy is modeled. Strong-interrupt is still an experimental alternative, not adopted canon.

| Layer | Healing | Rounds | Any wound | Timeout |
|---|---|---|---|---|
| shield_off | none | 3.83 | 100.0% | 0.0% |
| shield_off | one | 4.01 | 45.6% | 0.0% |
| defend_off | none | 3.73 | 100.0% | 0.0% |
| defend_off | one | 4.02 | 75.8% | 0.0% |
| front | none | 3.33 | 64.2% | 0.0% |
| front | one | 3.99 | 0.5% | 0.0% |
| self_heal | none | 3.32 | 100.0% | 0.0% |
| self_heal | one | 3.40 | 99.9% | 0.0% |
| potions | none | 3.32 | 8.4% | 0.0% |
| potions | one | 3.36 | 8.0% | 0.0% |
| oa_damage | none | 3.86 | 100.0% | 0.0% |
| oa_damage | one | 4.10 | 77.9% | 0.0% |
| oa_interrupt | none | 3.96 | 100.0% | 0.0% |
| oa_interrupt | one | 4.38 | 87.2% | 0.0% |
| burn | none | 3.85 | 100.0% | 0.0% |
| burn | one | 4.01 | 93.7% | 0.0% |
| enemy1 | none | 4.31 | 99.1% | 0.0% |
| enemy1 | one | 4.73 | 21.7% | 0.0% |
| enemy2 | none | 5.10 | 94.6% | 0.0% |
| enemy2 | one | 5.59 | 15.0% | 0.0% |
| bane1 | none | 3.75 | 100.0% | 0.0% |
| bane1 | one | 4.03 | 75.5% | 0.0% |
| bane2 | none | 3.76 | 100.0% | 0.0% |
| bane2 | one | 4.04 | 93.6% | 0.0% |

Burning now ticks then decays. The ordinary pressure layer does not choose to extinguish during combat. End-of-fight assistance remains explicit.

## Wound effects: bounded overlay, not a board simulation

These runs select real wound entries and apply temporary disabling conditions, ongoing damage, persistent sensory conditions and broad activity Banes. Immediate forced movement, Prone movement cost, and lasting Speed penalties are recorded/described but cannot affect positioning in this no-map engine. Consequently these are partial wound tests. Different damage types bypass different armor; compare overlay off/on within a type, not types as if armor were equal.

| Damage type | Overlay | Healing | Rounds | Any wound | Any terminal PC | Disabled turns |
|---|---|---|---|---|---|---|
| physical | False | none | 4.01 | 25.9% | 0.2% | 0.00 |
| physical | True | none | 4.01 | 24.2% | 0.1% | 0.00 |
| physical | False | one | 4.49 | 4.7% | 0.0% | 0.00 |
| physical | True | one | 4.49 | 3.9% | 0.0% | 0.00 |
| fire | False | none | 4.23 | 89.4% | 0.6% | 0.00 |
| fire | True | none | 4.25 | 89.8% | 0.9% | 0.01 |
| fire | False | one | 4.75 | 79.2% | 0.7% | 0.00 |
| fire | True | one | 4.75 | 77.9% | 1.0% | 0.02 |
| cold | False | none | 4.24 | 90.1% | 0.9% | 0.00 |
| cold | True | none | 4.25 | 88.5% | 0.9% | 0.01 |
| cold | False | one | 4.75 | 77.7% | 0.9% | 0.00 |
| cold | True | one | 4.76 | 77.3% | 1.0% | 0.02 |
| mental | False | none | 4.23 | 89.7% | 0.8% | 0.00 |
| mental | True | none | 4.29 | 89.8% | 0.7% | 0.10 |
| mental | False | one | 4.75 | 77.4% | 0.8% | 0.00 |
| mental | True | one | 4.83 | 76.7% | 0.9% | 0.18 |
| radiant | False | none | 4.22 | 88.7% | 0.5% | 0.00 |
| radiant | True | none | 4.27 | 89.4% | 0.9% | 0.04 |
| radiant | False | one | 4.73 | 77.9% | 1.0% | 0.00 |
| radiant | True | one | 4.84 | 77.5% | 1.1% | 0.08 |
| life | False | none | 4.24 | 90.2% | 0.6% | 0.00 |
| life | True | none | 4.25 | 88.7% | 0.4% | 0.05 |
| life | False | one | 4.73 | 77.0% | 0.8% | 0.00 |
| life | True | one | 4.79 | 77.6% | 0.7% | 0.10 |

Duration-only blindness prevents direct attack targeting in the overlay. Defense while blind uses three Banes as a declared stress convention; DA visibility rulings are not a completed perception system. Frightened assumes the source stays perceptible while combat lasts.

## Ten-encounter sequences

Full-HP breaths, no Grit refill, permanent scars, stop at first terminal PC or failed encounter. First table leaves active wound penalties off for historical comparison.

| Healing | Potions | Resupply | Encounter | Full-party completion | Grit remaining | Scars |
|---|---|---|---|---|---|---|
| none | False | False | 5 | 98.5% | 7.52 | 1.32 |
| none | False | False | 10 | 96.6% | 7.06 | 2.63 |
| one | False | False | 5 | 99.8% | 7.91 | 0.23 |
| one | False | False | 10 | 99.6% | 7.84 | 0.49 |
| none | True | False | 5 | 100.0% | 7.93 | 0.25 |
| none | True | False | 10 | 99.7% | 7.58 | 1.10 |
| none | True | True | 5 | 99.7% | 7.98 | 0.17 |
| none | True | True | 10 | 99.6% | 7.96 | 0.33 |


The second table includes the bounded wound overlay. Treatment means a safe day after each encounter, only with capabilities the party actually purchased. The field is permission to attempt treatment, not a guarantee that the party knows the needed card.

| Damage type | Treatment allowed | Encounter | Completion | Scars | Untreated lasting wounds | Treatment attempts |
|---|---|---|---|---|---|---|
| physical | False | 5 | 100.0% | 0.29 | 0.15 | 0 |
| physical | False | 10 | 99.4% | 0.56 | 0.29 | 0 |
| physical | True | 5 | 99.8% | 0.29 | 0.07 | 22 |
| physical | True | 10 | 99.8% | 0.59 | 0.13 | 27 |
| mental | False | 5 | 80.2% | 8.17 | 2.48 | 0 |
| mental | False | 10 | 34.4% | 16.12 | 4.84 | 0 |
| mental | True | 5 | 81.0% | 8.60 | 1.33 | 550 |
| mental | True | 10 | 37.2% | 16.19 | 1.76 | 293 |
| fire | False | 5 | 82.0% | 8.27 | 5.50 | 0 |
| fire | False | 10 | 43.4% | 18.79 | 13.26 | 0 |
| fire | True | 5 | 80.8% | 8.87 | 5.80 | 0 |
| fire | True | 10 | 45.0% | 18.96 | 13.42 | 0 |

Treatment rolls currently omit injury penalties on the healer: these are optimistic downtime results. They are not full campaign survival forecasts, particularly because mobility and collision effects remain unmodeled.

## Catalog and rule cleanup

- Protector HP is +5; all class HP contributions are approved fixtures. Creation, acquisition deduplication, stage expiry and rank gates were rerun. See [creation](creation.md) and [variants](variants.md).
- Six treatment capabilities now have prototype cards. Their Life 1 requirement, attributes, one-hour interval and shared Novice price are explicit assumptions, not approved final card balance.
- Ordinary Recipes is repeatable at 2 DP for two new compatible recipes. The small four-recipe kit allows only one extra purchase after Field Craft until more recipes are added; the rule itself has no purchase-count limit.
- Field Dressing no longer provides an uncosted percentage heal. It is a provisional nonmagical Bleeding-removal ability, excluded from baseline encounters.
- Resistance caps at 3. Wall of Iron and Last Bastion were capped accordingly; this makes their resistance benefit redundant for some heavy-armor users. They need redesign before higher-tier signature certification. No substitute power was silently invented.
- Summon tether and grapple attack Boons are in card text and local checks. Unlimited nearby bodies, actual forced movement and rescue tactics still need mapped play.
- No separate observation roll was introduced. Careful Observer is a Reason-based card; perception/detection remains an open core discussion.

## What follows from this pass

Use the anchor and sensitivity tables to choose the next numerical adjustment; do not infer difficulty from round count alone. Next test level-1 signature choices on declared boards, then grapple/tether/forced movement interactions. Extend treatment access and higher-tier cards after seeing those results. Encounter CV remains provisional; the old CV fit has not been relabeled as current. Layout is still deferred.
