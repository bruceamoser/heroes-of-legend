# Reproducing the v0.2 tests

Python standard library only; run from repository root:

```bash
python3 playtest/tests/catalog.py
python3 playtest/tests/builds.py
python3 playtest/tests/variants.py
python3 playtest/tests/test_revision.py
python3 playtest/tests/features.py
python3 playtest/tests/combat.py --trials 1000
python3 playtest/tests/advanced.py
python3 playtest/tests/timing.py
python3 playtest/tests/refine.py
python3 playtest/tests/revision.py
python3 playtest/tests/report.py
python3 playtest/tests/verify.py --replay
```

Generate the report only after all experiment jobs finish. The manifest hashes the
actual rule/catalog/test inputs and retained output JSON. Never regenerate hashes
merely to hide a stale result. The [v0.1 archive](../history/v0.1.tar.gz) preserves
the complete original playtest directory; extract elsewhere to reproduce history.
Catalog.py generates Markdown and catalog.json. Handwritten rules are separate.

## Model contract

- Four actual saved builds: Protector, Blade, Arcanist, Shepherd; an alternate
  Leader/Unbalanced/Shadow/Intellect party appears in progression tests. Healer
  enabled/disabled comparisons retain identical purchases; no DP refund is assumed.
- Actual attributes, HP, purchased cards, equipment, Grit and ammo are used.
  Choose highest expected learned ordinary damage; Basic Melee/Ranged are candidates,
  with Unarmed fallback. Ranged consumes an actual d8 supply ladder after each attack.
- Ordinary low-tier profile overrides (old/flat/high) are sensitivity cases, not
  automatic catalog changes. Basic 2/3/5 versus 3/4/6 is a separate experiment.
- Baseline has **no map**, no travel/contact cost, **no signature** effects, no cover,
  no damage riders or magic items. Level-3/7 results are chassis/ordinary-card tests,
  not full class balance. Enemy spare Maneuvers are unused.
- Mend heals 3/6/9 and costs 1 HP, must leave the caster above 0. No extra Strong
  benefit. Explicit higher-tier runs use 5/10/15 at cost 3 or 8/16/24 at cost 7 only
  if learned; otherwise fall back to Mend. The Shepherd progression buys these
  cards and their ranks. The policy uses the requested tier rather than optimizing
  between tiers, which can expose inefficient higher-tier purchases.
- Healing is chosen at/below a scenario HP fraction, usually half. The fourth PC is
  the one-healer policy; all-healer permits anyone who actually knows Mend. Select
  the lowest HP fraction patient, including self. Helpers receive early side choice.
  NPC support rolls use Reason +1 (provisional), identical restoration and cost,
  and only living NPC patients. NPCs die at 0; PCs use Dying.
- Life resistance reduces healing minimum 1; all resistance caps at 3. Cost bypasses
  resistance. Affordability is rechecked after an opportunity attack; no payment or
  effect if unaffordable then. This ordering remains an opportunity timing fixture.
- Potions supply one d4 bottle per character (Bulk 1), independently of strength.
  Restore 6, or explicitly tested 10/16; Maneuver, receiver Reaction unless at 0.
  Inventory check occurs after use. No ordinary starting supply is assumed. Extra
  Bulk's effect on movement cannot be measured in this range-free model.
- PCs spend spare Maneuver to stabilize or Defend; owned shields consume Reaction.
  Target policies are focus (lowest HP), spread (random upright), front, or explicit
  mixed probabilities. Reach all/self is a declared support-access approximation.
- Wound roll uses actual highest three sorted dice, cap 5, adding permanent scars;
  666/three death marks count as terminal immediately for combat metrics. Last Words
  speech timing and reacting abilities are not simulated. Grit is finite; resolve
  Dying through turns after enemies fall. Full-HP breath follows safe resolution.
- **Active wound penalties** are off in baseline. Explicit overlays select real
  entries, apply temporary conditions, starred sensory effects and broad activity
  Banes. Physical Banes affect physical attacks and defense/death rolls; mental
  Banes affect spell attacks and healing. This is a declared DA applicability fixture.
  Frightened assumes its source stays perceptible during combat. Blind PCs cannot
  directly attack; defense while blind takes three Banes as a stress convention,
  not a new approved perception rule. Hearing is tracked but no hearing-triggered
  abilities operate in the baseline. Temporary conditions clear after safe recovery.
- Dazed retains Main first, Maneuver second, Reaction third. Paralyzed blocks all
  three and movement. Conditions tick at turn end then decay. Wound conditions
  arising within that end step first tick next end step, a test ordering convention.
  No autonomous extinguishing during battle: the pressure layer continues offense
  or healing. Appropriate Main removal is separately checked; safe help clears
  residual Bleeding/Burning/Freezing after opposition ends.
- Wound **movement penalties, Prone travel costs, pushes, pulls, collision follow-
  through, lost limbs and prostheses have no positional effect in this model**.
  The overlay is partial, not complete wound balance. Mixed starred/temporary
  contributions use additive ratings in this fixture with only the temporary part
  decaying; the core tracking choice remains open and needs sensitivity tests.
- Wound campaigns permit one safe day of treatment after each encounter only when
  enabled and only with learned capabilities. No new cards, materials or artificial
  limbs are granted. Treatment rolls omit healer wound penalties (optimistic).
  Scars/Grit persist; sequences stop at first terminal PC or failed encounter.
- Opportunity layers assume at most one ready enemy adjacent per casting attempt,
  Basic Melee 2/3/5. Damage-only and Strong-interrupt variants remain comparisons.
  Disengage/real geometry, other provoking actions and Counterspell are not modeled.
- Summon tether, condition state rules, recipe gates, grapple vulnerability and
  forced movement use local checks/walkthroughs. Grapple trials assume continuous
  contact, no escape movement/allied rescue; they do not claim full encounters.
- Unspecified critical/fumble riders are omitted. Forty rounds is a timeout, not a
  victory. Deterministic seeds include the full scenario plus v0.2. n=1000 gives
  worst-case binomial 95% margin ±3.1 points; n=3000 ±1.8. Model assumptions dominate.

## Validation and next steps

Brute-force dice enumeration checks outcome probabilities independently. Creation
checks enforce gates/ledgers. Revision regression tests cover healing costs, caps,
condition decay, all wound entries, daily treatment, recipe gates and summon tether.
Saved deterministic replays and source/output hashes detect drift.

The archived CV fit is not recalibrated or adopted here. The next tactical work is
level-1 signatures and mapped control/forced movement, then higher-tier class
choices. No independent review of this new PR has occurred yet; merge requires it.
