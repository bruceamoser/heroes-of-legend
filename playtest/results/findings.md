# Working playtest findings

October 11, 2026. Provisional catalog v0.1; no final balance approval implied.

**Retained results:** 462 isolated configurations, 594,000 isolated encounters, plus 39,866 encounters in 4,000 ten-encounter sequences: **633,866 encounters total**. Exploratory runs replaced during corrections are not included. There are 38 character snapshots (27 main, 8 alternative advancement, 3 crafting route), 119 provisional purchased/signature cards (including 81 signature options), and 11 universal references. An additional 240,000 local grappling trials are reported separately from encounters.

## Main finding

The rebuilt rules can produce roughly four-round encounters with the proposed higher ordinary damage. However, damage alone has not brought both healing and non-healing parties into the desired wound ranges in a robust way. Armor, enemy targeting, and support access matter at least as much as the headline damage profile.

The best useful anchor below matches the no-healer goal and duration, but healing is more protective than the suggested 5–15% wound goal. These were explicitly soft goals; the correct response is to show that trade-off, not force a target by assuming poor healing decisions.

## Candidate ordinary encounter anchor

Four enemies, each HP 14, physical resistance 1, damage 5/6/8; spread targeting. Four actual level-1 builds, spare-Maneuver Defend, owned shields, no potions. Player Novice attacks use the working catalog, generally 4/5/7. These are test fixtures, not an approved bestiary.

| Healing policy | Mean rounds | Any party wound | Mean wounds | Mean healing actions | Win |
|---|---|---|---|---|---|
| none | 4.00 | 26.8% | 0.28 | 0.00 | 100.0% |
| one | 4.34 | 1.5% | 0.02 | 2.11 | 100.0% |

At 3,000 trials each, zero observed events does not mean impossible. Worst-case 95% sampling margin is about ±1.8 percentage points; model omissions are larger.

## Ordinary damage and resistance

New ordinary attacks keep Weak damage meaningful, and stronger results can add movement or other effects. The baseline omits those riders, so its duration measures raw-damage contribution only. The proposed 2/3/5 basic attack deals 2 on Strong against resistance 3; resistance 4+ still flattens it. That scope remains a designer decision.

| Novice profile | No-healer rounds | No-healer wound | Healer rounds | Healer wound |
|---|---|---|---|---|
| old | 5.22 | 100.0% | 4.97 | 11.4% |
| flat | 4.61 | 100.0% | 4.55 | 9.5% |
| new | 3.86 | 100.0% | 4.00 | 7.6% |
| high | 3.15 | 98.4% | 3.60 | 7.2% |

Profiles are old 2/4/6, flat 4/4/6, new per-card (usually 4/5/7), high 5/6/8. All other fixture inputs in this table are fixed. These focus-fire cases deliberately expose fragility; they are not the ordinary anchor above.

## Targeting and preparation

Same HP-12, damage-4/5/7 enemies can create radically different pressure. Mixed targeting chooses the lowest-current-HP PC with the listed probability, otherwise a random upright PC. It is an experiment, not a creature intelligence rule.

| Target policy | Healing | Rounds | Any wound |
|---|---|---|---|
| spread | none | 3.34 | 2.6% |
| spread | one | 3.72 | 0.0% |
| mixed 0.25 | none | 3.36 | 18.1% |
| mixed 0.25 | one | 3.85 | 0.2% |
| mixed 0.5 | none | 3.45 | 51.2% |
| mixed 0.5 | one | 3.92 | 0.8% |
| mixed 0.75 | none | 3.63 | 86.7% |
| mixed 0.75 | one | 3.97 | 2.9% |

A real board can protect weaker characters through reach and occupied squares. The range-free model cannot price that protection. Do not set CV assuming every enemy always reaches the weakest PC, or assuming enemies always spread harmlessly.

## Added mechanics: controlled layers

Each layer changes one rule against the same HP-12, damage-4/5/7 focus-fire reference. “One healer” always uses the same actual learned Mend card. Contact assumptions and omitted counter-actions are in [test contract](../tests/README.md).

| Layer | Healing | Rounds | Any wound | Timeout |
|---|---|---|---|---|
| shield_off | none | 3.84 | 100.0% | 0.0% |
| shield_off | one | 4.01 | 8.3% | 0.0% |
| defend_off | none | 3.74 | 100.0% | 0.0% |
| defend_off | one | 4.01 | 25.8% | 0.0% |
| front | none | 3.34 | 51.6% | 0.0% |
| front | one | 3.90 | 0.0% | 0.0% |
| self_heal | none | 3.34 | 100.0% | 0.0% |
| self_heal | one | 3.41 | 99.9% | 0.0% |
| potions | none | 3.37 | 1.0% | 0.0% |
| potions | one | 3.31 | 1.9% | 0.0% |
| oa_damage | none | 3.81 | 100.0% | 0.0% |
| oa_damage | one | 4.00 | 16.5% | 0.0% |
| oa_interrupt | none | 3.96 | 100.0% | 0.0% |
| oa_interrupt | one | 4.26 | 32.7% | 0.0% |
| burn | none | 3.81 | 100.0% | 0.0% |
| burn | one | 4.01 | 31.3% | 0.0% |
| enemy1 | none | 6.64 | 99.9% | 0.9% |
| enemy1 | one | 5.25 | 1.9% | 0.0% |
| enemy2 | none | 26.50 | 100.0% | 17.1% |
| enemy2 | one | 15.35 | 7.3% | 4.2% |
| bane1 | none | 3.75 | 100.0% | 0.0% |
| bane1 | one | 4.01 | 22.5% | 0.0% |
| bane2 | none | 3.75 | 100.0% | 0.0% |
| bane2 | one | 4.04 | 35.6% | 0.0% |

Opportunity damage raises the cost of casting in contact; Strong interruption raises it further. It is not established as necessary. The party may instead Disengage and move before casting, which this contact stress case does not simulate. Burning results assume the party does not spend Main Actions extinguishing during combat.

Enemy healing uses the same half/full/full restoration rather than a weaker NPC-only rule. Multiple enemy healers can still prolong fights and create timeouts. The NPC-death-at-0 rule makes finishing targets an important difference from player recovery.

## Creation and progression

See [complete build summaries](creation.md) and the ordered ledgers in builds.json. All nine classes have legal level-1/3/7 examples. Requirements do not depend on legacy content. The fixed attribute sum gives 1,246 legal labeled arrays; each two-attribute minimum admits 678. That does not establish equal class appeal.

- The accepted mental adjustment gives 7–16 DP at each creation stage: an 18-DP spread across both stages. Physical-heavy and mental-heavy builds now have a real development trade-off.
- The low-Brawn Arcanist has capacity 4. Tools and later acquisitions can cause encumbrance; no item or backpack is exempted to hide this. Players can choose what to carry rather than being forced to carry everything granted.
- Automatic grant deduplication works: compatible attack cards use one 1-Bulk weapon. Crafting grants tools and two provisional ordinary recipes; ingredients remain explicit.
- The working catalog is still small. Large level-7 DP banks reflect a lack of attractive tested purchases as well as deliberate restraint; they do not prove the 8 + level award is too large.
- Most later example builds can afford Mend. Test all-healer parties, because healing access is a build choice rather than a class monopoly.
- Higher-tier signature prototypes now have distinct class-specific effects. Their tactical impact has not been simulated, so these results do not establish full class balance. The following combat table disables signatures and non-damage riders.

| Level | Healing policy | Rounds | Any wound | Healing actions |
|---|---|---|---|---|
| 1 | none | 4.27 | 30.3% | 0.00 |
| 1 | one | 4.93 | 1.7% | 2.57 |
| 1 | all | 5.07 | 0.6% | 2.80 |
| 3 | none | 3.19 | 16.7% | 0.00 |
| 3 | one | 3.89 | 1.2% | 1.79 |
| 3 | all | 3.93 | 0.0% | 1.93 |
| 7 | none | 3.01 | 11.4% | 0.00 |
| 7 | one | 3.34 | 0.9% | 1.41 |
| 7 | all | 3.44 | 0.0% | 1.61 |

This comparison holds enemies at HP 16 and damage 5/6/8. It measures growing offense against the same threat; it is not a recommendation to keep all encounters unchanged as characters advance.

## Attrition

Ten sequential candidate-anchor encounters, full HP breaths, persistent scars/Grit, stop at first terminal PC or failure. Active wound penalties are omitted, so these results understate long-term adversity. Potions are separate supplied d4 bottles; replenishment is explicit.

| Healing | Potions | Resupply | Encounter | Full-party completion | Grit left among reached | Scars among reached |
|---|---|---|---|---|---|---|
| none | False | False | 1 | 99.8% | 7.90 | 0.26 |
| none | False | False | 5 | 98.9% | 7.52 | 1.34 |
| none | False | False | 10 | 96.8% | 7.05 | 2.64 |
| one | False | False | 1 | 99.9% | 7.99 | 0.01 |
| one | False | False | 5 | 99.9% | 7.97 | 0.07 |
| one | False | False | 10 | 99.9% | 7.95 | 0.13 |
| none | True | False | 1 | 100.0% | 8.00 | 0.02 |
| none | True | False | 5 | 100.0% | 7.96 | 0.18 |
| none | True | False | 10 | 99.9% | 7.70 | 0.80 |
| none | True | True | 1 | 100.0% | 8.00 | 0.03 |
| none | True | True | 5 | 99.9% | 7.99 | 0.14 |
| none | True | True | 10 | 99.8% | 7.97 | 0.29 |

No refill of Grit is assumed. A fresh-party encounter rate and survival through ten encounters answer different questions. This campaign sample does not certify the provisional wound table.

## Longer-duration anchors and high-HP healing

These are nearest tested duration matches, not certified difficulty labels. HP, resistance and count alone do not establish hard or extreme difficulty. Fresh level-3/7 characters have their full granted/purchased Grit; they are not assumed campaign survivors with unspent Grit.

| Level | Target rounds | Enemy count × HP | Resistance | Observed rounds | Any wound | Any terminal PC |
|---|---|---|---|---|---|---|
| 1 | 4 | 4 × 12 | 1 | 4.00 | 7.3% | 0.0% |
| 1 | 6 | 6 × 12 | 1 | 6.00 | 89.7% | 1.2% |
| 1 | 10 | 4 × 24 | 3 | 9.98 | 16.7% | 0.0% |
| 3 | 4 | 4 × 12 | 3 | 3.95 | 8.5% | 0.1% |
| 3 | 6 | 4 × 28 | 1 | 6.09 | 13.3% | 0.2% |
| 3 | 10 | 4 × 48 | 1 | 9.87 | 17.1% | 0.3% |
| 7 | 4 | 4 × 20 | 1 | 4.00 | 8.9% | 0.2% |
| 7 | 6 | 4 × 32 | 1 | 5.87 | 11.5% | 0.2% |
| 7 | 10 | 4 × 56 | 1 | 9.81 | 17.8% | 0.3% |


| Level | Solo HP | Healing policy | Rounds | Timeout |
|---|---|---|---|---|
| 1 | 24 | one | 9.93 | 2.0% |
| 1 | 48 | one | 40.00 | 100.0% |
| 1 | 80 | one | 40.00 | 100.0% |
| 3 | 24 | one | 1.35 | 0.0% |
| 3 | 48 | one | 11.01 | 1.3% |
| 3 | 80 | one | 40.00 | 100.0% |
| 7 | 24 | one | 1.01 | 0.0% |
| 7 | 48 | one | 31.70 | 61.2% |
| 7 | 80 | one | 40.00 | 100.0% |

Full-HP restoration on a high-HP creature can still defeat ordinary damage throughput. Counterplay and encounter role must be tested; do not quietly give the creature a different healing formula.

## Typed resistance

The following holds physical resistance at 3 while adding fire resistance. Players select among attacks they actually learned. No unowned damage-type switch is assumed.

| Level | Fire resistance | Rounds | Any wound |
|---|---|---|---|
| 1 | 0 | 6.74 | 0.3% |
| 1 | 2 | 7.87 | 0.5% |
| 1 | 4 | 9.83 | 1.1% |
| 1 | 6 | 10.57 | 1.1% |
| 3 | 0 | 4.35 | 0.0% |
| 3 | 2 | 4.92 | 0.3% |
| 3 | 4 | 5.48 | 0.2% |
| 3 | 6 | 6.21 | 0.3% |
| 7 | 0 | 3.65 | 0.0% |
| 7 | 2 | 3.90 | 0.1% |
| 7 | 4 | 4.31 | 0.0% |
| 7 | 6 | 4.79 | 0.0% |

Magic looking strong against physical-only armor is not evidence of general superiority against all defenses. Creature cards need explicit typed resistance and observable clues.

## Alternating-turn grappling experiment

Local three-round contest, no allies helping the target, continuous contact, neutral Brawn 0 on both sides. Target always chooses Main and uses Force when available; removal reduces oldest contributions first (provisional bookkeeping). Movement after a successful escape is deliberately excluded, making this a contact-pressure test. No narrative critical/fumble riders.

| Grapplers | First side | Restrained round 1 | Restrained by round 3 |
|---|---|---|---|
| 1 | target | 9.7% | 44.2% |
| 1 | grapplers | 8.9% | 43.6% |
| 2 | target | 93.1% | 100.0% |
| 2 | grapplers | 28.2% | 99.9% |
| 3 | target | 100.0% | 100.0% |
| 3 | grapplers | 95.0% | 100.0% |

An intervening Force attempt matters substantially in the first round, but sustained multiple-grappler pressure dominates if the target remains in reach. This supports testing escape movement and ally intervention on a board rather than changing the agreed rating-3 restriction blindly.

## Alternative investments and crafting entry

[Alternative spending plans](variants.md) show eight additional snapshots. A durability-focused Protector reaches 31 HP at level 7 through six paid HP increases rather than automatic level growth. More banked DP in specialist routes reinforces the need for a richer tested catalog before drawing a final DP-budget conclusion.

The [crafting entry route](../crafting.md) pairs Frontier Forest Forage with Apprentice Field Craft. Its three snapshots have actual tools, recipes and material-gathering permission, so crafting can function in a suitable environment without an assumed free supply kit. Physical HP healing also has a provisional Field Dressing card; it is not part of the Mend-only combat comparisons.

## Healing policy sensitivity: the surprising boss result

The level-7 party sometimes took longer than the level-3 party against the same self-healer. Saved turn traces show why: crossing the half-HP trigger more consistently can make the enemy heal every turn, while a lower-damage sequence sometimes leaves it just above the trigger and earns another attack window. This is a property of the chosen policy and turn timing, not a general claim that weaker attacks are better.

| Party level | Enemy heals at HP fraction | Mean rounds | Timeout |
|---|---|---|---|
| 1 | 0.25 | 6.78 | 0.0% |
| 1 | 0.5 | 40.00 | 100.0% |
| 1 | 0.75 | 40.00 | 100.0% |
| 1 | 0.9 | 40.00 | 100.0% |
| 3 | 0.25 | 2.63 | 0.0% |
| 3 | 0.5 | 10.89 | 1.7% |
| 3 | 0.75 | 39.99 | 100.0% |
| 3 | 0.9 | 40.00 | 100.0% |
| 7 | 0.25 | 2.43 | 0.0% |
| 7 | 0.5 | 31.92 | 61.0% |
| 7 | 0.75 | 35.54 | 78.6% |
| 7 | 0.9 | 36.44 | 80.7% |

At level 1 the same HP-48 enemy changes from almost no timeouts at the quarter-HP trigger to all timeouts at the half-HP trigger. This is strong evidence that encounter results cannot be separated from healing policy. [Saved traces](boss-traces.json) retain complete turn HP histories for seed 12 at levels 1/3/7. These are illustrative traces; percentages come from 3,000 encounters per configuration.

## A better first pressure estimate

For the same body-count fixtures, multiplying the summed durability score by **(enemy count + 1) / 5** reduces held-out error in predicted enemy attack opportunities from **5.75 to 1.42 attacks**. Four enemies give multiplier 1. This reflects the additional turns available while several bodies remain alive.

This is a measured lead for the CV algorithm, not an adopted encounter multiplier. It was tested only on these ordinary level-1 bodies with the same damage and resistance. Keep duration and pressure as separate estimates; damage types, healing, control, body blocking and party size still require calibration.

## Combat Value: useful structure, not yet a reliable budget

The provisional durability × threat metric normalizes a reference Skirmisher to CV 10. A linear duration fit trained on counts 2/4/8 and held out counts 3/6 has mean absolute duration error **0.87 rounds** on those held-out configurations. This is a narrow internal check, not broad validation. It does not predict wound probability, healing loops, AoE, or control.

| Count × HP | Total CV | Observed rounds | Predicted rounds | Any wound | Split |
|---|---|---|---|---|---|
| 2 × 8 | 13.33 | 1.20 | 1.51 | 0.0% | train |
| 2 × 12 | 20.00 | 2.00 | 2.27 | 0.0% | train |
| 2 × 16 | 26.67 | 2.11 | 3.02 | 1.0% | train |
| 3 × 8 | 20.00 | 2.00 | 2.27 | 3.9% | holdout |
| 3 × 12 | 30.00 | 2.92 | 3.40 | 54.7% | holdout |
| 3 × 16 | 40.00 | 3.24 | 4.53 | 76.4% | holdout |
| 4 × 8 | 26.67 | 2.36 | 3.02 | 80.6% | train |
| 4 × 12 | 40.00 | 3.85 | 4.53 | 100.0% | train |
| 4 × 16 | 53.33 | 5.02 | 6.05 | 100.0% | train |
| 6 × 8 | 40.00 | 3.55 | 4.53 | 100.0% | holdout |
| 6 × 12 | 60.00 | 5.58 | 6.80 | 100.0% | holdout |
| 6 × 16 | 80.00 | 8.10 | 9.07 | 100.0% | holdout |
| 8 × 8 | 53.33 | 5.00 | 6.05 | 100.0% | train |
| 8 × 12 | 80.00 | 8.56 | 9.07 | 100.0% | train |
| 8 × 16 | 106.67 | 14.26 | 12.09 | 100.0% | train |

Recommendation: retain separate durability, offensive pressure, body count, and special-ability notes alongside any scalar CV. Do not publish hard/very-hard thresholds from this formula yet. Next calibrations should use several party compositions and board layouts, then select encounter anchors at roughly 4/6/10 rounds with acceptable wound rates.

## Priority findings for Bruce

1. **Healing trade-off:** the four-round candidate without healing is near the wound goal; with healing it is safer than the soft goal. Decide whether that is acceptable before adding a universal interruption rule.
2. **Preparation and formation:** armor and access to the weakest PC change the result dramatically. The next physical playtest needs a declared map, starting positions, equipment and potions.
3. **Summon bodies:** unlimited summons plus immediate activation can create fresh blockers every turn and preload a battlefield. Command limits alone do not address that. Preserve unlimited summons while testing duration, placement and fragility.
4. **Control concentration:** multiple grapplers can restrain very reliably without each grappler becoming equally restricted. Test an escape opportunity between applications and a rescued ally, not only a static probability.
5. **Basic damage scope:** Strong 5 achieves 2 damage against resistance 3, not higher resistance. Decide whether that is the intended low-tier boundary.
6. **Catalog quality:** test the higher signatures and expand meaningful high-level utility before reducing DP awards. Starter recipe count remains a provisional two.
7. **Wound detail:** the compact physical/mental table is an explicit proposed replacement. Active penalties need a separate campaign test before assessing lifetime survivability.

## What is and is not completed

The independent working set, creation ledgers, revised-damage sweeps, incremental mechanic checks, advancement fixtures, and first CV experiment are complete for this pass. They tackle steps 1–7 without asserting the game is now balanced. Full map-based tactics, high-level signature balance, broad party-size validation, and a reliable final CV budget remain further iterations. Layout and book construction have not been started.

For individual advanced-mechanic examples, see [tactical cases](tactical-cases.md). For assumptions and reproduction, see [test contract](../tests/README.md).
