# Reproducing the version 0.1 tests

**Historical snapshot:** these scripts and results predate the revised wounds,
condition decay, and fixed healing rules. See [revision status](../revision-status.md).
Run at commit `52ff73d` to reproduce the original inputs. Do not refresh result
hashes against revised prose without migrating and rerunning the experiments.

Python standard library only; run from repository root:

```bash
python3 playtest/tests/catalog.py
python3 playtest/tests/builds.py
python3 playtest/tests/combat.py --trials 1000
python3 playtest/tests/features.py
python3 playtest/tests/variants.py
python3 playtest/tests/advanced.py
python3 playtest/tests/timing.py
python3 playtest/tests/refine.py
python3 playtest/tests/report.py
python3 playtest/tests/verify.py --replay
```

Generated Markdown and JSON are committed for review. Catalog.py is the source of
catalog tables; edit it before regenerating to avoid losing manual table changes.
Handwritten rules Markdown is not generated. Legacy chapters are not imported.

## Model contract

- Four actual saved builds (Protector, Blade, Arcanist, Shepherd), with an alternate
  Leader, Unbalanced, Shadow, Intellect party in progression tests. The same party
  is used for healer enabled/disabled comparisons. Healing disabled means choosing
  not to cast it, not silently refunding its DP. Later testing should compare equal-
  DP builds that spend those points differently.
- Actual HP, attributes, acquired armor, shield ownership, learned damage cards,
  and Grit are used. Ranged attacks check a carried d8 ammunition bundle after each use; depleted ammunition prevents further ranged choices until resupplied. Choose the highest expected single-target damage card that
  the build actually knows, with the card's printed attribute and damage type.
- The old/flat/high Novice damage variants override card damage solely for sensitivity
  tests. Higher-tier cards keep their own profiles. New means catalog values.
- Baseline: targets in range, ordinary physical attacks, no map travel/contact cost,
  no signature effects, no cover, no magic item additions, no purchased HP growth.
  These are controlled core tests, not full character-strength certification.
- Healing is Main, half/full/full based on Reason; Strong reduces Burning 1. It
  activates below or at half HP. One-healer party uses its fourth character, who
  actually knows Mend. NPC healers use the same roll and restoration rule with
  Reason +1; they cannot heal dead NPCs. This NPC self-side roll is a provisional
  test resolution where no player is a target, not a general new NPC roll rule.
- PCs use spare Maneuver to stabilize or Defend, and use owned shields when attacked.
  Healing helpers get early turn priority when a valid target needs healing. Equal
  lowest-HP creature targets are randomized. Focus chooses lowest current HP;
  spread picks a random upright PC; front picks one of the front two if upright.
- Potion scenarios explicitly provide each character one d4 bottle (Bulk 1),
  full HP, usable on self/ally as allowed by Reaction. Bottles are not free creation
  grants. Baseline has none. The range-free engine does not turn extra encumbrance
  into a positioning penalty; those cases need board play.
- Wound roll adds permanent scars, cap 5 dice, detects 666. Active wound penalties
  are not modeled. Grit is finite and spent at start of Dying turns; otherwise death
  rolls apply. End-of-fight Dying stabilization resolves through turns, not automatic
  recovery. Routine Burning cleanup assumes a conscious helper and no threat.
- Critical/Fumble select their outcome tiers; unspecified narrative riders are not
  priced. Attack Strong push/reposition and signature benefits are excluded from
  baseline damage measurements. The area/condition/control checks are separate.
- Opportunity variants assume at most one ready creature is assumed adjacent and can react per
  casting attempt, using Basic Melee 2/3/5. All-casters-in-contact is a stress case,
  not a predicted average position. Damage-only and Strong-interrupt variants are
  compared; other provoking actions are not simulated. No purchased Counterspell.
- Burning layer is enemy attacks applying Burning 1 on Standard, 2 on Strong.
  No automatic midfight extinguish policy is implemented, making this a pressure
  upper-bound for a party choosing to continue attacking/healing. Routine postcombat
  extinguishing remains available. Grapple/Dazed/summons/free attacks/forced movement
  use exact or scripted checks, not claimed complete encounter simulations.
- A 40-round cap reports timeout, not loss or win. Durations on wins are separately
  available. Monte Carlo seeds derive from the complete scenario, not process hash.
  At n=1000 worst-case binomial 95% margin is about 3.1 percentage points. Scenario
  assumptions dominate statistical error. Refinements use larger samples.

## Validation limits

Independent brute-force dice enumeration checks the combinatorial probability
implementation. Invalid-build tests check gates and accounting. Feature unit checks
only validate their stated local rule; they do not prove balance of whole encounters.
No independent human/agent review has occurred yet. Draft PRs remain unmerged.
