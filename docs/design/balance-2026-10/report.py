#!/usr/bin/env python3
"""Render the designer summary directly from the saved results."""
import csv
import json
from pathlib import Path

ROOT=Path(__file__).parent
OUT=ROOT/"outputs"


def read(name):
 with (OUT/name).open() as f:return list(csv.DictReader(f))


def pct(x):return "<0.01%" if 0<float(x)<0.0001 else f"{100*float(x):.2f}%"
def num(x):return f"{float(x):.2f}" if x!="" else "—"


def table(rows,cols):
 return "| "+" | ".join(cols)+" |\n|"+"|".join("---" for _ in cols)+"|\n"+"\n".join("| "+" | ".join(map(str,r))+" |" for r in rows)+"\n"


def main():
 combat={r['scenario']:r for r in read('combat.csv')}
 stress={r['scenario']:r for r in read('stress.csv')}
 healing={r['scenario']:r for r in read('enemy_healing.csv')}
 anchors={r['scenario']:r for r in read('calibration.csv')}
 campaigns=read('campaigns.csv')
 sets=[combat,stress,healing,anchors]
 assert {int(r['trials']) for x in sets for r in x.values()}=={2000},"This report requires the documented 2,000-trial runs."
 nconfigs=sum(len(x) for x in sets)
 isolated=sum(int(r['trials']) for x in sets for r in x.values())
 campaign_battles=sum(round(float(r['reached'])*2000) for r in campaigns)
 checks=json.loads((OUT/'validation.json').read_text())['checks_passed']
 manifest=dict(configurations=nconfigs,trials_per_configuration=2000,isolated_encounters=isolated,
   campaign_sequences=16000,campaign_encounters=campaign_battles,total_encounters=isolated+campaign_battles,
   creation_ledgers=10,engine_checks=checks,exact_tables=['dice','damage','inventory','wounds','wound_lifetime','groups','healing_death','progress_tasks','mixed_damage','grapple'])
 (OUT/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
 reference=[]
 for pol,label in [('attack','Attack, no healing'),('healer','One spell healer'),('all_heal','Everyone can spell-heal'),('potion','One d4 potion per character')]:
  r=combat[f'grid_h12_r1_{pol}_focus']
  reference.append([label,num(r['win_rounds_mean']),pct(r['any_wound']),num(r['grit']),num(r['spell_heals']),num(r['potions'])])
 ref_table=table(reference,['Party policy','Mean rounds','Any new wound','Mean Grit spent','Mean spell uses','Mean potion uses'])
 enemy=[]
 for n in [0,1,2,4]:
  r=healing[f'enemyheal_n{n}_f1.0_healer_hunt1']
  enemy.append([n,pct(r['win']),num(r['win_rounds_mean']),pct(r['timeout'])])
 enemy_table=table(enemy,['Enemy healers out of four','Victory','Mean rounds on wins','Still unresolved at round 80'])
 layouts=[]
 for n,hp in [(1,48),(2,24),(4,12),(8,6),(12,4)]:
  r=combat[f'layout_{n}x{hp}_attack']
  layouts.append([f'{n} × {hp} HP',num(r['win_rounds_mean']),num(r['wounds']),pct(r['any_terminal'])])
 layout_table=table(layouts,['Same 48 total enemy HP','Mean rounds','Mean new wounds','Any terminal PC injury'])
 duration=[]
 for label,hp,packet in [('short',10,'2/4/6'),('medium',14,'3/5/7'),('long',24,'4/6/8')]:
  values=[]
  for policy in ['attack','healer','potion']:
   r=anchors[f'anchor_{label}_basic0_{policy}_focus']
   values.append(num(r['win_rounds_mean']))
  duration.append([f'4 × HP {hp}, damage {packet}',*values])
 duration_table=table(duration,['Duration fixture, enemy Resistance 1','Attack only','One spell healer','Potions'])
 survival=[]
 for pol,label in [('attack','Attack only'),('healer','One spell healer'),('potion','d4 bottles, no resupply')]:
  r=next(r for r in campaigns if r['policy']==pol and r['target']=='focus' and r['resupply']=='False' and r['encounter']=='10')
  survival.append([label,pct(r['full_party_completion']),num(r['mean_grit_remaining_among_reached']),num(r['mean_wounds_among_reached'])])
 survival_table=table(survival,['Ten reference fights','Original party completes all ten','Mean party Grit after fight 10 among runs reaching it','Mean accumulated wounds among runs reaching it'])
 dice=read('dice.csv')
 dice_table=table([[r['net_boons'],pct(r['weak']),pct(r['standard']),pct(r['strong']),pct(r['critical']),pct(r['fumble'])] for r in dice if r['attribute']=='0'],['Net Boons, negative means Banes','Weak','Standard','Strong','Critical','Fumble'])
 hard=[]
 for p,label in [('attack','Attack only'),('healer','One spell healer'),('all_heal','All can spell-heal'),('potion','d4 potions')]:
  r=stress[f'stress_n8_h20_d4_{p}']
  hard.append([label,pct(r['win']),num(r['win_rounds_mean']),pct(r['any_terminal'])])
 hard_table=table(hard,['Eight HP-20 enemies','Victory','Mean rounds on wins','Any terminal PC injury'])
 report=f'''# Heroes of Legend balance review

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

- **{nconfigs} encounter configurations × 2,000 trials:** {isolated:,} isolated simulated encounters.
- **16,000 campaign sequences:** {campaign_battles:,} additional encounters, stopping at loss or the first terminal character.
- **{isolated+campaign_battles:,} encounters in the retained results**, not counting exploratory reruns of the same experiments.
- Exact dice, damage, inventory, wound, death-roll, cumulative-progress, group-check, and grappling calculations.
- Ten fully reconciled **illustrative** creation ledgers and level-1–10 affordability calculations.
- {checks} engine checks, independent ordered-dice verification, resource/action bounds, and separate creation and closed-form probability checks.

These are reproducible numerical and desk tests, **not live playtests**. The combat engine has no map, actual class signatures, wound penalties, condition-control cards, AoE, summons, or critical riders. Those receive separate scenario analysis. Immediate contact favors rescue and focus fire. Missing wound penalties make survival optimistic. The full [assumptions and reproduction instructions](assumptions.md) are necessary when interpreting a result.

At 2,000 trials, the worst-case approximate 95% sampling margin for a proportion is ±2.2 percentage points. A zero observed event rate is not proof that an event is impossible. Model uncertainty is much larger than sampling uncertainty in unimplemented parts of the system.

## Player healing supports the intended action trade

Reference: four HP-20 PCs, attack attribute +1, defense attribute 0, Physical Resistance 2, Novice damage 2/4/6. Four enemies each have HP 12, Resistance 1, and one 2/4/6 attack. Spare PC Maneuvers use Defend. Enemies focus low-HP upright PCs; equal-HP ties are randomized. Healers act before endangered allies when possible. These numbers are fixtures, not approved characters or creatures.

{ref_table}
All policies won every trial in this particular comparison. Rounds include the final partial round. Wound probability and resource means cover all trials. Critical benefits and the healing spell's Strong benefit are not assigned invented values.

**Your action-economy argument is supported here.** One healer spends relatively few Main Actions, and healing can preserve enough later attacks to offset those actions. Potions can be even faster because they consume Maneuvers and supply rather than Main Actions. Healing sometimes shortens harder fights by avoiding lost turns.

The issue is not an inevitable stall. It is the enormous difference in permanent injury: an ordinary fight that nearly never wounds the healed party frequently wounds the attack-only party. With allied support denied in a sensitivity test, the one-healer party's wound chance rises sharply. Range, movement, and positioning must therefore be included in the next tabletop test.

Making enemies tougher does not give a single universal correction. Against eight HP-20 enemies with the same 2/4/6 attack:

{hard_table}
Winning with a terminal party member is still counted as an encounter victory. Win-only duration excludes losses, so read it alongside victory and terminal-injury rates. These large encounters are stress tests, not recommended typical fights.

## Enemy healing can create a genuine stall

For this sensitivity test only, some of the four HP-12 creatures have a Main Action restoring full HP to a living ally or themselves. Their side selects a ready healer when someone is at half HP or below. The party includes one spell healer and prioritizes enemy healers as targets.

{enemy_table}
The enemy ability is an explicit fixed-output test fixture, not an adopted rule for resolving NPC healing spells. Reducing it to half HP helps some combinations, but does not automatically solve them. The direct-attack test deliberately excludes control, AoE, free attacks, and unspecified critical effects that could break a loop in a real party.

The solo version exposes the arithmetic clearly. A creature with HP 48 and Resistance 1 can receive at most **20 damage from four ordinary Strong Novice attacks**: four times (6 − 1). Half its HP is 24. If it can heal itself every turn once it reaches half HP, the party cannot cross that remaining-health threshold before its next turn using only these attacks. Increasing HP has made it harder to overcome healing as well as harder to kill.

**Recommended response:** give creature healing explicit values and tactical answers, and flag combinations of support creatures during encounter construction. Do not treat healing as a small damage-equivalent rider in CV. A puzzle encounter that requires disabling a healer can be interesting, but it must be designed and signposted as such, not emerge accidentally from a supposedly ordinary budget.

## Four rounds is attainable but duration is not difficulty

Three draft formations provide useful starting points for a board test. They retain enemy Resistance 1 and four enemies, changing HP and damage:

{duration_table}
These are **duration anchors**, not final typical/hard/extremely-hard budgets. The long fixture takes roughly ten rounds for the one-healer party but much longer without healing and less with potions. Its risk also changes. Two party members relying on basic attacks rather than purchased Novice attacks further extend duration.

The next table test should include an objective and morale behavior. The simulator fights to elimination; real creatures may flee or surrender, which was already agreed to remain DA judgment.

## CV must include action frequency and support

Holding total enemy HP at 48 does not hold the encounter constant. These creatures each retain the same Resistance and one attack; the party uses the attack-only policy:

{layout_table}
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

{survival_table}
These are same-level stress sequences, not a recommended adventuring schedule. The conditional means include runs reaching encounter ten, even if that tenth encounter ends badly. Full-party completion requires all four original characters to survive all ten victories. Reliable potion resupply is a separate control in the raw data.

This shows why **Grit spent alone is insufficient** as an attrition metric. Allies can stabilize or heal someone while permanent wounds continue to accumulate. Conversely, accessible preventive healing can preserve both Grit and wounds for many fights.

## The dice engine is coherent and strong

At attribute 0, exact probabilities are:

{dice_table}
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
'''
 (ROOT/'README.md').write_text(report)
 print(json.dumps(manifest,indent=2))


if __name__=="__main__":main()
