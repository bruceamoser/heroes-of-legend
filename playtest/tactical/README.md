# Mapped and free-hand experiments

This experiment adds positions and held equipment to the previously range-free
study. It keeps the accepted damage and healing values. Run from repository root:

```bash
python3 playtest/tactical/test_engine.py
python3 playtest/tactical/run.py
python3 playtest/tactical/report.py
python3 playtest/tactical/verify.py
```

Outputs are separate from `playtest/results/`, which remains the v0.2 historical
range-free study. Do not compare its spread targeting directly with this harness's
reachable-target policy and call the difference a free-hand effect.

## What is agreed

Healing spells and using potions require a free hand. A bow, a two-handed weapon,
or a melee weapon plus shield occupies both hands. Dropping is free; stowing and
picking up cost a Maneuver. Drawing a stowed weapon is included in its attack, but
picking a weapon up from the ground is not drawing it. Maneuver potion use still
works before its inventory check; a d4 empties on 1, or 25% after each use.

Spell healing costs Main and 1/3/7 HP, leaves caster above 0, restores fixed values.
Potion strength is 6 HP here; no reason to weaken it is presumed. All existing rules
for conditions, scars, Grit, typed resistance, movement and the summon tether apply
where the harness supports them.

## Equipment policies under comparison

- **ignore:** deliberately reproduces the missing-hand-check assumption. It is an
  invalid control case, not a legal option.
- **drop_shield:** free a hand by dropping shield first, otherwise weapon. Lose the
  shield's ongoing Boon immediately. Items remain at their square until recovered.
- **drop_weapon:** prefer dropping the weapon. Drinking uses Maneuver; recovering
  the weapon then uses Main converted to Maneuver, preventing an attack that turn.
- **stow:** spend Maneuver to stow shield first, otherwise weapon. Drinking then
  requires Main converted to Maneuver. A healing spell can still use Main after
  stowing if Maneuver was available.
- **prepared:** enter combat holding at most one ordinary melee weapon and keep one
  hand available. No shield/bow is drawn under this policy. This intentionally
  trades defenses/range for access; it is not a free equipment improvement.

A dropped item can only be picked up from the holder's current square in this test.
The policy does not navigate back to recover abandoned items during combat. After
safe victory, parties recover their own dropped equipment before a campaign's next
encounter. Putting a stowed shield back into use costs Maneuver (test convention).
We do not assume that releasing a two-handed grip is free; that exception has not
been established. The two-handed layer changes grip only, not Bulk or attack damage.
Potions in these runs are self-administered. Ally administration remains a future
policy test, including recipient Reaction and the 0-HP exception.

## Boards and movement

Ten columns by seven rows; coordinates start at zero. PC positions are Protector
(3,2), Blade (3,4), Arcanist (1,2), Shepherd (1,4). Four enemies begin at (6,1), (6,2),
(6,4), (6,5). HP 14, resistance 1, attack 5/6/8, Speed 6. PC stats and learned cards
come from the current saved builds.

- **open:** no obstacles.
- **door:** column 4 is wall except the doorway at (4,3).
- **rough:** squares (3,3) through (6,3) are difficult terrain.

Diagonal movement costs 1; no diagonal corner cutting around walls (test geometry
convention). Pathfinding respects occupied squares: standing actors block travel;
Prone actors cost 2 to cross and cannot be an endpoint. Sight/attack paths are
tested with a sampled center-to-center line against walls; intervening creatures do not provide cover in this harness.
Dead NPC bodies are removed from occupancy (test convention). Standing costs 2
movement. Lasting wound Speed penalties affect actual path budgets.

Actors can convert a spare Maneuver to movement. PC unused actions may become
Defend. NPCs do not use spare Maneuvers to Defend, matching the earlier chassis
fixture; they may use Maneuver movement. Enemies choose the shortest reachable
approach, then lower current HP. This is a policy, not a DA intelligence rule.
PC healing prioritizes the lowest HP fraction, then tries to reach that patient;
it does not globally optimize across all possible reachable patients.

Opportunity layer: actual leaving-reach movement and casting in contact provoke
Basic Melee 2/3/5 when the enemy has a Reaction. PCs choose Disengage when available
before leaving reach. No generic Strong interruption. Other provoking activities
(standing, stowing, pickup) are not yet tested; do not treat the opportunity layer
as a complete activity-trigger implementation.

## Incremental effects and limits

- Forced movement into empty squares uses terrain costs and checks tether loss
  after every step. A wall applies remaining budget +1 collision damage. **Occupied
  collision groups are not resolved:** the displacement stops and increments an
  unresolved-group counter. This is a flagged simulation boundary, not a game rule.
  A case with such events is a geometry sensitivity result, not full collision balance.
- Summon tests replace the Arcanist's level-1 Identify Potions purchase with Summon
  Companion at equal 2 DP; the already-granted Summon 1 satisfies prerequisites.
  Place adjacent to controller (a conservative policy within the permitted range 3).
  Main command provides the attack and Maneuver converted to movement. A new summon
  gets that immediate command. Compare retaining one versus repeatedly creating new
  bodies; no count cap. Existing uncommanded bodies remain blockers. No second
  Maneuver command policy is implemented. Enemies can target summons: their hit is
  a fixed 6 physical damage stress fixture, not a resolved general NPC-vs-summon roll.
  Loss of a controller is assumed to end its summons; this is a test convention.
- Wounds use actual sorted-roll entries. Scars, finite Grit, lasting Banes/sensory
  effects, mobility loss, Prone and temporary disabling conditions are applied.
  Frightened assumes a perceptible source. Blindness prevents direct attacks;
  three defense Banes while blind remain a declared stress convention. Broad Banes
  apply by physical/magical activity, not a finished perception system. Damage
  conditions acquired during a tick begin damaging on the following end step.
- Last Words counts as terminal immediately for metrics; speech/reaction abilities
  are not modeled. Postcombat rescue assumes an upright usable helper can eventually
  reach Dying allies before another death choice: optimistic cleanup, not timed
  board rescue. Lasting wound effects remain; temporary conditions clear when safe.
- Five-encounter sequences reset starting positions after full-HP breaths, retain
  scars and Grit, and stop at first terminal PC or failed encounter. Treatment-enabled
  sequences have a safe day between fights, use only learned capabilities, and one
  attempt per wound per day. No free treatment cards or prostheses are supplied.

## Signatures and healing choices

Only the four baseline classes are sampled. When signatures are enabled, all four
have their first level-1 choice except the one being varied. Effects implemented:
Protector Hold the Line/Shelter/Interpose; Blade Footwork/Opening; Arcanist Long
Reach/Sculpt Spark; Shepherd Mercy/Shared Shelter. Hold the Line moves a willing
ally toward the healer; Footwork retreats a square; these are declared policies.
Shelter is assigned when Defend is taken. This does not rank all nine classes.

Blade Poise has no triggering difficult-footing Bane in these fixtures; Arcanist
Insight has no value when the policy already knows resistance; Shepherd Guiding
Voice has no value because this combat policy does not choose Aid. Report these
as **unexercised**, not weak or balanced choices. Higher signatures remain disabled.

At levels 3/7 compare Mend only, highest learned healing tier, and an adaptive choice
maximizing expected effective restoration minus caster cost. Adaptive accounts for
missing HP and self-payment but not future enemy turns or risk aversion. No unlearned
spell is supplied. The healing threshold remains half HP; trigger optimization is
not part of this comparison.

## Statistical and reproducibility boundary

Each isolated configuration uses 500 deterministic trials (worst-case binomial 95%
margin roughly ±4.4 percentage points). Campaigns use 150 sequences per configuration.
Small differences are not evidence of a meaningful balance effect. No timing result
measures real table speed. The source/input and output manifests, exact replays,
state-transition tests and occupancy assertions make assumptions auditable.

Dropped equipment does not reduce the precomputed encumbrance penalty during a fight.
Player opportunity reactions are implemented and regression-tested, but the current
enemy Disengage policy avoids them in aggregate runs; front-line deterrence remains
unmeasured. No encounter here is a calibrated replacement for the earlier CV anchor.
