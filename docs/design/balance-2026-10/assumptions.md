# Balance study assumptions

This study tests the October 10, 2026 conversation specification. It does not implement that specification in the rulebook. The current chapters and older design reviews contain superseded rules and cannot serve as a complete test fixture. Issues #1115, #1116, and #1117 track the study under #940.

## Rules used as agreed

- Roll 3d6 plus one attribute. Weak is 8 or less, Standard 9–14, Strong 15 or more. Natural retained triple 6 and triple 1 determine criticals and fumbles. Boons and Banes cancel before the net cap of three; extra dice retain the highest or lowest three.
- Player attacks roll once; NPC attacks use a player defense roll, reversing the damage outcome. Attacks always inflict at least one total damage after matching typed Resistance. Attribute modifies the roll, not damage.
- The provisional basic attack is 1/2/4. The provisional straightforward Novice attack is 2/4/6. Neither is a finalized damage budget.
- Twenty HP at Fortitude 0 is a provisional representative **total**, not the base term in the creation formula. No automatic HP or attribute growth.
- Main Action, Maneuver, movement, Reaction. Main can convert to Maneuver, Maneuver to movement. Defend uses a Maneuver and grants a defense Boon until the next turn. Shield uses a Reaction before a blockable attack and grants a defense Boon for that same duration. Defense itself is not an action.
- Initiative is one unmodified 3d6: players first on 12+, creatures otherwise. Alternate individual turns; the winning side starts each round; sides choose their next member. This gives players first turn in 37.5% of encounters, not 50%.
- Spell healing takes a Main Action, usable each turn, restores half maximum HP (rounded up) / full HP / full HP plus an unspecified benefit. Potions restore full HP with a Maneuver and an inventory check. Administering one uses the recipient's Reaction unless at 0 HP. There is no extra retrieval action for accessible potions.
- HP restoration is additive up to maximum. Wounds and spent Grit remain. After danger and urgent conditions are resolved, about one minute taking a breath restores HP.
- Entering Dying inflicts a permanent wound. At the start of a dying character's turn, spend Grit to restore full HP or roll for death, with no later change of mind that turn. Healing clears death marks; stabilization clears marks and leaves 0 HP. Damage while stabilized re-enters Dying and causes a new wound; damage while already Dying adds one death mark per event.
- Death roll uses Fortitude: Weak adds one death mark, Standard no change, Strong stabilizes, critical stabilizes at 1 HP, fumble adds two marks. Three death marks or wound result 666 causes terminal Last Words. PCs begin with two nonrenewable Grit; gain one at levels 3 and 7. Only PCs use these survival procedures.
- Wound roll: 3d6 plus one die per prior wound, cap five dice; keep highest three. Treatment can relieve active effects but never remove the scar count.
- Universal stabilization costs a Maneuver; no roll. Characters defend with three Banes when helpless. Overlapping helpless conditions impose this penalty only once.
- Inventory decreases on a 1, after the current use succeeds: d20 → d12 → d10 → d8 → d6 → d4 → out. Bottles/bundles never merge; each has its own bulk. A d8 has 18 expected uses, not eight.
- Matching Resistance, attribute bonuses, and numbered Weakness use the largest source. Different damage types coexist; matching Resistance and Weakness offset. Rated conditions accumulate. Boons and Banes stack by their own rules.
- Creation attributes total +3, each −2 through +2. Level 0 and 1 grant 10 DP each, expiring at the end of their respective stage. Level 0 cannot buy Disciplines. Cards cost 2/4/8; class-priced Discipline rank increments are Home 1/2/4, Adjacent 2/4/8, Foreign 3/6/12, Opposed 4/8/16. Rank purchases are sequential.
- Culture and background each grant one supported rank-1/card pair; class grants two chosen rank-1 Disciplines and a signature. Creation duplicate Discipline/card grants compensate one DP each for that stage. Level 2 onward awards 8 + new level DP, saved if desired. Class signatures at 1/3/7 are exceptions to DP-only development.
- Carrying capacity is 10 + 3 × Brawn slots. Each excess slot reduces Speed by one. Speed is ancestry base + Agility − encumbrance, minimum zero. Most items/bundles occupy one slot, few occupy two, incidental possessions zero. Worn armor still has bulk; learned cards do not.

## Numerical simulation assumptions

The combat simulator is an open-field, immediate-contact attrition model. Its outcomes are **not** a prediction for a finished HOL party, a complete card catalog, or a published monster. It answers how sensitive the core loop is to inputs before adding more content.

| Input | Reference assumption |
|---|---|
| Party | Four identical HP-20 characters, with policy variants |
| Attacks | Attribute +1, Novice 2/4/6; utility-party variants substitute basic attacks |
| Defense | Attribute 0, Physical Resistance 2 |
| Creature formation | Four creatures, each HP 12 and Physical Resistance 1 |
| Creature attack | Physical 2/4/6, one attack per Main Action, no difficulty Banes |
| Other creature actions | No useful Maneuver or Reaction; these are deliberately plain attackers |
| Spell healer | Attribute +1, assumed eligible learned card, can target self or ally |
| Potion party | Every character owns one d4 bottle; d6/d8 sensitivity cases also included |
| Healing threshold | Act when a target is at or below half HP; quarter/three-quarter thresholds tested |
| Defend | Use spare Maneuvers after potion use or stabilization; shield absent unless specified |
| Player targeting | Focus the lowest-HP living enemy; random-target sensitivity cases included |
| Creature targeting | Focus the lowest-HP upright PC, otherwise a nonterminal PC; equal-HP ties randomized. Spread and finishing-downs variants included |
| Party turn choice | Ready healers first when healing is urgent; otherwise lowest HP first. Fixed order also tested |
| Range | Every required attack, potion, and stabilization can reach its target without sacrificing the modeled action |

Each ability is a **test fixture**, not an approved catalog card. All-healer and all-potion scenarios intentionally test accessible system strategies; they are not presented as conventional party composition. The baseline's identical characters isolate policy effects; the separate creation study examines varied builds. Homogeneous parties do not establish that class signatures or combinations are balanced.

The second stress pass raises encounter sizes and damage, tests inaccessible ally support, and repeats encounters with depleted Grit or existing scars. Its censor is 80 rounds. The `support=self` variant permits only self-healing and disables ally stabilization; it is a sensitivity bound, not a substitute for a grid. Duration-anchor cases vary enemy HP and damage together and are not assigned difficulty labels.

The enemy-healing pass adds a **hypothetical creature Main Action** restoring either half or full maximum HP to a living creature. It has no outcome roll, can be repeated each turn, cannot resurrect a creature killed at 0 HP, and replaces that creature's attack. This is a fixed-output creature ability fixture, **not an adopted rule for how NPC spellcasting resolves**. The last N creatures have the ability; their side prioritizes an unacted healer when any living creature is at or below half HP. Alternate player policies prioritize those healers or simply focus low HP. The source of NPC non-hostile outcome rolls remains an open rule question. No area attack, control, critical rider, or granted free attack breaks this deliberately narrow direct-attack test.

No numerical costs are added for unmodeled fictional complications. Critical/fumble tiers are respected, but their unspecified riders and the healing spell's Strong benefit are omitted. These omissions may undervalue or overvalue a strategy depending on future card text. Do not interpret a small numerical difference as conclusive.

### Deliberate omissions and their direction

- No board geometry, terrain, cover, travel-to-contact, opportunity attacks, area attacks, forced movement, summons, or detailed control in the combat engine. These receive separate calculations and scenario walkthroughs. Immediate adjacency favors rescue and focus fire; no claim of tactical tabletop validation follows.
- No wound active penalties, only accumulating wound count and terminal 666 risk. Reported survival is optimistic relative to a debilitating wound table. Exact wound severity distribution cannot be updated until the new table exists.
- Last Words is counted as an irreversible character loss at onset. Its two speaking turns and possible exceptional reactions are not modeled. These turns do not restore ordinary actions under the agreed rules.
- The death-roll Fortitude proxy equals the scenario's defense attribute. The reference uses zero; exact death tables separately vary Fortitude. Final stat blocks need explicit defense attributes per attack.
- After all enemies are defeated, Dying still resolves in turn order. Available allies explicitly spend Maneuvers on stabilization (including conversion of an unused Main); a dying PC whose turn arrives still chooses Grit or a death roll. Only after no unresolved Dying remains do survivors take a breath. Additional cleanup rounds are recorded separately from rounds to defeat the enemies. These scenarios contain no ongoing damaging conditions. Terminal PCs do not recover.
- No morale flight shortens simulated battles. Simulations use elimination objectives, allowing duration comparison without an invented morale policy.
- No magic equipment, signatures, extra Grit card, permanent HP cards, or ancestry traits in the baseline. These could materially change the results.
- No price assumptions enter combat. A potion party is not evidence that bottles are affordable or available; acquisition and recipe times are unresolved.
- No universal healing limit is introduced. The potion inventory die can empty a bottle; spells can heal every turn.
- Enemy multiple-attack solo fixtures execute their attacks on their own turn. They do not emulate between-player-turn solo actions; those need specified timing and a board test.

### Experiment interpretation

Isolated encounters use 2,000 trials per scenario, deterministic seeds from scenario names, and a 40-round censor. Victory means every enemy is defeated, not that every PC survives. Report both victory and any terminal injury. Duration includes the final partial round; win-only and all-result statistics are separate. Timeouts are not wins and are not silently discarded from all-result averages. At 2,000 trials, the worst-case approximate 95% Monte Carlo margin for a proportion is ±2.2 percentage points. This does not cover model error.

Campaign experiments repeat the same level-1 fixture up to ten times, retaining Grit, wounds, and potion dice. They stop at a defeat, timeout, or first terminal PC. HP resets between successful encounters. A separate potion-resupply control replaces each bottle before each encounter. No level-up Grit or wound treatment is inserted. These are stress tests, not a proposed adventure day.

Exact probability tables enumerate all unordered dice combinations with multiplicities. Validation independently enumerates ordered dice for selected pools. Tests also check probability normalization, typed-damage arithmetic, resource bounds, seeded repeatability, and a one-hit encounter.

## Character creation scope

Creation run-throughs use illustrative rank-1 shared cards, ancestry contributions, and class choices because the revised catalog does not exist. They prove arithmetic and expose requirements, not legality under a finished catalog. Existing named classes are conceptual labels; the illustrative discipline affinities are not adopted class price lists. Starting coins and ancestry/class HP allocations remain unresolved; the report does not pretend to validate them.

## Reproduction

From the repository root:

```bash
python3 docs/design/balance-2026-10/study.py --trials 2000
python3 docs/design/balance-2026-10/creation.py
python3 docs/design/balance-2026-10/interactions.py
python3 docs/design/balance-2026-10/stress.py
python3 docs/design/balance-2026-10/calibration.py
python3 docs/design/balance-2026-10/enemy_healing.py
python3 docs/design/balance-2026-10/report.py
python3 docs/design/balance-2026-10/verify_outputs.py
```

Scripts require only Python's standard library. CSV and JSON outputs are committed for inspection without running code. Changing a script or assumption requires regenerating its outputs; recorded results are not a promise that future rule changes preserve them.
