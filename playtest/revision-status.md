# Working revision v0.2

Issues #1127–1128 migrate the catalog and rerun experiments after the reviewed
wound/condition pass. Catalog generation, rules, creation ledgers and simulator now
use fixed healing and costs, resistance cap 3, condition decay, class HP values,
recipe acquisition, grapple vulnerability and the summon tether where modeled.

## Agreed rules versus prototypes

The six treatment capabilities have [prototype cards](abilities.md). Their Life 1
requirement, attributes and one-hour treatment interval remain provisional. The
wound RVs, correct capability requirement, one attempt per wound per day, and 1/2/3
progress are agreed. Field Dressing is a provisional Bleeding-removal card, replacing
an obsolete uncosted percentage heal; it is not in the baseline combat policy.

Higher-tier healing prototypes use 5/10/15 at 3 HP and 8/16/24 at 7 HP. Cards may
supply different benefits. Baseline policies still use learned Mend; tier-sensitive
runs are explicit. All class HP contributions, including Protector +5, are applied.
Ordinary Recipes costs 2 DP for two compatible new recipes and is repeatable.

The resistance cap makes some high-tier Protector signatures redundant with heavy
armor. They are capped, flagged for redesign, and not silently compensated with a
new ability. Higher signatures are not validated by chassis-only combat runs.

## Reproducibility

The complete original playtest tree from commit 52ff73d is preserved in
[history/v0.1.tar.gz](history/v0.1.tar.gz), including source, assumptions and results.
Extract outside the repository if reproducing it. Current results and their input
hash manifest are newly generated; historical figures are never relabeled as v0.2.
The previous CV fit is historical, not a newly calibrated encounter budget.

## Current model boundary

See [test contract](tests/README.md) for the precise boundary. Ordinary encounters
have no board. Added wound overlays model disabling/sensory conditions and activity
Banes, but not displacement, collision follow-through, lost movement, or artificial
limbs. Treatment sequences use explicitly purchased capabilities and safe downtime.
Summon tether, recipe purchase and condition mechanics have local checks, not a
claim of full tactical simulation. Level-1 signature board tests remain next.

Perception/detection, mixed starred/temporary condition tracking, crowded forced
movement geometry, and exact opportunity-interruption rules remain separate design
questions. Tests declare assumptions rather than importing legacy rules.

## Subsequent hand-access correction (issues #1130–1131)

The catalog now explicitly requires free hands for spell/potion healing. The v0.2
range-free simulator did not enforce that rule, so its potion and healer-access
results are historical controls, not current access predictions. Its full source
and results are preserved at commit fc700c1 and [history/v0.2.tar.gz](history/v0.2.tar.gz).
The old input-hash verifier will correctly detect changed rules in this checkout;
use the archived tree to reproduce that study rather than overwriting its hashes.

Current hand/position findings and their separate provenance are under
[tactical](tactical/README.md). That model does not certify every tactical rule;
its contract lists unresolved collision groups and other limitations explicitly.
