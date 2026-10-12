# Heroes of Legend balance review

Prepared for Bruce on October 10, 2026. This is a review of the revised specification, not a change to the rulebook.

**The core is ready for a focused tabletop prototype, but it is not yet numerically balanced.** Repeatable player healing worked better than initially feared in ordinary simulated fights: it usually kept characters active without causing a stall. The largest problems are enemy healing loops, the difference between healed and unhealed parties' lasting injuries, armor flattening attack outcomes, and control or summons whose value cannot be priced from damage alone.

## Start with these decisions

1. **Enemy healing needs an explicit design boundary.** Multiple healers and high-HP self-healing solos can defeat the assumed damage budget. Preserve repeatable player healing; do not casually copy percentage healing onto every creature.
2. **Define the acceptable wound rate for a typical encounter.** Winning in four rounds does not establish safety or the desired campaign lifespan. Wounds remain dangerous even when Grit is unspent.
3. **Test armor and basic attacks together.** Resistance 3 makes ordinary basic damage 1/1/1. Decide whether that is acceptable for their opportunity/free-attack role.
4. **Prototype control and summons before fixing CV.** Guaranteed minimum condition contributions, occupied squares, and free initial summon commands can dominate fights without high direct damage.
5. **Validate three real starter characters.** The 10/10 DP budget appears sufficient. Inventory, recipe access, actual prerequisites, and choice load are the immediate creation risks.

All proposed responses remain for discussion. In particular, this review does **not** add healing-use limits, attunement, summon caps, attribute growth, or a new exhaustion system.

## What was tested

- **544 encounter configurations × 2,000 trials:** 1,088,000 isolated simulated encounters.
- **16,000 campaign sequences:** 159,054 additional encounters, stopping at loss or the first terminal character.
- **1,247,054 encounters in the retained results**, not counting exploratory reruns of the same experiments.
- Exact dice, damage, inventory, wound, death-roll, cumulative-progress, group-check, and grappling calculations.
- Ten fully reconciled **illustrative** creation ledgers and level-1–10 affordability calculations.
- 685 engine checks, independent ordered-dice verification, resource/action bounds, and separate creation and closed-form probability checks.

These are reproducible numerical and desk tests, **not live playtests**. The combat engine has no map, actual class signatures, wound penalties, condition-control cards, AoE, summons, or critical riders. Those receive separate scenario analysis. Immediate contact favors rescue and focus fire. Missing wound penalties make survival optimistic. The full [assumptions and reproduction instructions](assumptions.md) are necessary when interpreting a result.

At 2,000 trials, the worst-case approximate 95% sampling margin for a proportion is ±2.2 percentage points. A zero observed event rate is not proof that an event is impossible. Model uncertainty is much larger than sampling uncertainty in unimplemented parts of the system.

## Player healing supports the intended action trade

Reference: four HP-20 PCs, attack attribute +1, defense attribute 0, Physical Resistance 2, Novice damage 2/4/6. Four enemies each have HP 12, Resistance 1, and one 2/4/6 attack. Spare PC Maneuvers use Defend. Enemies focus low-HP upright PCs; equal-HP ties are randomized. Healers act before endangered allies when possible. These numbers are fixtures, not approved characters or creatures.

| Party policy | Mean rounds | Any new wound | Mean Grit spent | Mean spell uses | Mean potion uses |
|---|---|---|---|---|---|
| Attack, no healing | 4.97 | 84.95% | 0.27 | 0.00 | 0.00 |
| One spell healer | 5.24 | 0.05% | 0.00 | 1.96 | 0.00 |
| Everyone can spell-heal | 5.25 | 0.00% | 0.00 | 2.12 | 0.00 |
| One d4 potion per character | 4.76 | 0.00% | 0.00 | 0.00 | 1.90 |

All policies won every trial in this particular comparison. Rounds include the final partial round. Wound probability and resource means cover all trials. Critical benefits and the healing spell's Strong benefit are not assigned invented values.

**Your action-economy argument is supported here.** One healer spends relatively few Main Actions, and healing can preserve enough later attacks to offset those actions. Potions can be even faster because they consume Maneuvers and supply rather than Main Actions. Healing sometimes shortens harder fights by avoiding lost turns.

The issue is not an inevitable stall. It is the enormous difference in permanent injury: an ordinary fight that nearly never wounds the healed party frequently wounds the attack-only party. With allied support denied in a sensitivity test, the one-healer party's wound chance rises sharply. Range, movement, and positioning must therefore be included in the next tabletop test.

Making enemies tougher does not give a single universal correction. Against eight HP-20 enemies with the same 2/4/6 attack:

| Eight HP-20 enemies | Victory | Mean rounds on wins | Any terminal PC injury |
|---|---|---|---|
| Attack only | 41.50% | 28.32 | 71.30% |
| One spell healer | 100.00% | 17.41 | 0.65% |
| All can spell-heal | 100.00% | 17.91 | 0.05% |
| d4 potions | 100.00% | 14.66 | 0.15% |

Winning with a terminal party member is still counted as an encounter victory. Win-only duration excludes losses, so read it alongside victory and terminal-injury rates. These large encounters are stress tests, not recommended typical fights.

## Enemy healing can create a genuine stall

For this sensitivity test only, some of the four HP-12 creatures have a Main Action restoring full HP to a living ally or themselves. Their side selects a ready healer when someone is at half HP or below. The party includes one spell healer and prioritizes enemy healers as targets.

| Enemy healers out of four | Victory | Mean rounds on wins | Still unresolved at round 80 |
|---|---|---|---|
| 0 | 100.00% | 5.23 | 0.00% |
| 1 | 100.00% | 8.10 | 0.00% |
| 2 | 0.00% | — | 100.00% |
| 4 | 0.00% | — | 100.00% |

The enemy ability is an explicit fixed-output test fixture, not an adopted rule for resolving NPC healing spells. Reducing it to half HP helps some combinations, but does not automatically solve them. The direct-attack test deliberately excludes control, AoE, free attacks, and unspecified critical effects that could break a loop in a real party.

The solo version exposes the arithmetic clearly. A creature with HP 48 and Resistance 1 can receive at most **20 damage from four ordinary Strong Novice attacks**: four times (6 − 1). Half its HP is 24. If it can heal itself every turn once it reaches half HP, the party cannot cross that remaining-health threshold before its next turn using only these attacks. Increasing HP has made it harder to overcome healing as well as harder to kill.

**Recommended response:** give creature healing explicit values and tactical answers, and flag combinations of support creatures during encounter construction. Do not treat healing as a small damage-equivalent rider in CV. A puzzle encounter that requires disabling a healer can be interesting, but it must be designed and signposted as such, not emerge accidentally from a supposedly ordinary budget.

## Four rounds is attainable but duration is not difficulty

Three draft formations provide useful starting points for a board test. They retain enemy Resistance 1 and four enemies, changing HP and damage:

| Duration fixture, enemy Resistance 1 | Attack only | One spell healer | Potions |
|---|---|---|---|
| 4 × HP 10, damage 2/4/6 | 4.20 | 4.54 | 4.13 |
| 4 × HP 14, damage 3/5/7 | 6.24 | 6.22 | 5.43 |
| 4 × HP 24, damage 4/6/8 | 14.79 | 10.69 | 8.78 |

These are **duration anchors**, not final typical/hard/extremely-hard budgets. The long fixture takes roughly ten rounds for the one-healer party but much longer without healing and less with potions. Its risk also changes. Two party members relying on basic attacks rather than purchased Novice attacks further extend duration.

The next table test should include an objective and morale behavior. The simulator fights to elimination; real creatures may flee or surrender, which was already agreed to remain DA judgment.

## CV must include action frequency and support

Holding total enemy HP at 48 does not hold the encounter constant. These creatures each retain the same Resistance and one attack; the party uses the attack-only policy:

| Same 48 total enemy HP | Mean rounds | Mean new wounds | Any terminal PC injury |
|---|---|---|---|
| 1 × 48 HP | 4.42 | 0.00 | 0.00% |
| 2 × 24 HP | 4.56 | 0.03 | 0.05% |
| 4 × 12 HP | 4.97 | 0.83 | 0.60% |
| 8 × 6 HP | 5.82 | 2.05 | 0.75% |
| 12 × 4 HP | 6.51 | 3.60 | 2.50% |

More bodies make more attacks while alive and exploit damage floors. Overkill and the order in which bodies disappear also matter. This supports your plan to derive CV from observed patterns rather than announce a formula first.

For the next CV prototype, measure three quantities separately:

1. **Effective durability:** expected player actions required to remove the creature under a fixed reference attack mix, including Resistance and defense Banes.
2. **Offensive pressure:** damage and condition threat per activation, including extra and between-turn actions.
3. **Support and control:** healing, denied player actions, summoned bodies, granted attacks, and effects on allied creatures.

Fit a fixed per-creature CV against several party fixtures, then sum printed CV for the base encounter and inspect the residual errors for swarms, support combinations, and party size. Keep the agreed linear party-size budget as a provisional starting point. A fitted scalar or level-3/7 budget would be premature while those actual cards and creatures are undefined. This review supplies measurements and failure cases, **not a falsely precise final CV**.

## Permanent consequences are doing substantial work

The wound-roll cap produces these exact terminal-wound probabilities:

| Wound being received | Dice | Chance of 666 |
|---|---:|---:|
| First | 3 | 0.46% |
| Second | 4 | 1.62% |
| Third and later | 5 | 3.55% |

Across a hypothetical sequence of ten wounds, the chance of at least one terminal result is **26.66%**; across twenty it is **48.90%**. Healing wound conditions does not change these odds. Death marks add further risk.

Ten successive reference encounters, with no level-up Grit or active wound penalties, produced:

| Ten reference fights | Original party completes all ten | Mean party Grit after fight 10 among runs reaching it | Mean accumulated wounds among runs reaching it |
|---|---|---|---|
| Attack only | 86.60% | 5.56 | 8.32 |
| One spell healer | 100.00% | 7.99 | 0.02 |
| d4 bottles, no resupply | 98.15% | 7.46 | 1.84 |

These are same-level stress sequences, not a recommended adventuring schedule. The conditional means include runs reaching encounter ten, even if that tenth encounter ends badly. Full-party completion requires all four original characters to survive all ten victories. Reliable potion resupply is a separate control in the raw data.

This shows why **Grit spent alone is insufficient** as an attrition metric. Allies can stabilize or heal someone while permanent wounds continue to accumulate. Conversely, accessible preventive healing can preserve both Grit and wounds for many fights.

## The dice engine is coherent and strong

At attribute 0, exact probabilities are:

| Net Boons, negative means Banes | Weak | Standard | Strong | Critical | Fumble |
|---|---|---|---|---|---|
| -3 | 78.16% | 21.62% | 0.23% | <0.01% | 6.23% |
| -2 | 66.13% | 33.08% | 0.80% | 0.01% | 3.55% |
| -1 | 48.77% | 48.46% | 2.78% | 0.08% | 1.62% |
| 0 | 25.93% | 64.81% | 9.26% | 0.46% | 0.46% |
| 1 | 10.49% | 66.36% | 23.15% | 1.62% | 0.08% |
| 2 | 4.14% | 58.15% | 37.71% | 3.55% | 0.01% |
| 3 | 1.63% | 47.44% | 50.93% | 6.23% | <0.01% |

Criticals are included in Strong and fumbles in Weak; they are not additional outcome tiers.

Boons are valuable without arithmetic modifiers. However, a three-Bane roll fumbles about 6.23% of the time, and a three-Boon roll critically succeeds about 6.23%. Those riders need modest, explicit budgets; they are not always one-in-216 events.

Player attack and reversed player defense do not have identical expected damage. At attribute 0 and neutral dice, 2/4/6 averages 3.67 as a player attack and 4.33 as an NPC attack before Resistance. This is expected from the asymmetric outcome bands, not a coding error. Calibrate creature offense separately.

## Character creation is affordable but needs a real starter catalog

The ten ledgers end with **11–13 learned cards including the signature**, plus 11 universal cards, two ancestry traits, and equipment. All meet their illustrative prerequisites and spend the correct stage DP. Details and each transaction are in the [creation review](creation-review.md).

The key concerns are four-slot capacity at Brawn −2, large differences in the effective value of origin-granted Disciplines, recipe access for starting crafters, and the amount of choosing and reading. Later DP can buy five to nine Novice cards per level once prerequisites are owned; the intended two-to-four purchases is not a built-in limit. These are reasons to test actual card menus and presentation before changing the budget.

## Discussion agenda and next practical test

When Bruce returns, address these one at a time:

1. What chance of at least one new wound should a typical four-round encounter have for a reasonably prepared party? What preparation should the baseline assume?
2. How should enemy healing be expressed and countered without limiting player healing?
3. Is Resistance 3 flattening basic attacks to one damage an acceptable role boundary?
4. Which actual Grapple, Dazed, summon, and free-attack cards belong in the first test kit?
5. What are the first three ancestry/class HP contributions, Speed bases, and starter recipe grants?
6. How should target-specific Boons/Banes work on a single player AoE roll?

Then run a board session with four draft characters, the short and medium formations above, one healing-support encounter, and one solo with explicit between-turn actions. Record round count, elapsed table time, decisions, healing actions, zero-HP entries, new wounds, Grit, and unspent options. Include a low-Brawn inventory setup and one caster with utility purchases. This will answer the positioning and choice-load questions that Monte Carlo cannot.

## Supporting material

- [Thirty rules-interaction findings and worked examples](interactions-review.md), including control, summons, free attacks, conditions, crafting, inventory, and forced movement.
- [Ten creation routes and progression analysis](creation-review.md).
- [Assumptions, omissions, and reproduction commands](assumptions.md).
- [Combat results](outputs/combat.csv), [stress tests](outputs/stress.csv), [enemy healing](outputs/enemy_healing.csv), [duration anchors](outputs/calibration.csv), and [campaigns](outputs/campaigns.csv).
- [Exact probabilities](outputs/dice.csv), [inventory](outputs/inventory.csv), [wound lifetime risk](outputs/wound_lifetime.csv), [death and healing](outputs/healing_death.csv), and [progress tasks](outputs/progress_tasks.csv).
- [Run manifest](outputs/manifest.json). No canonical chapter was edited.
