# Working revision and historical test boundary

Issue #1125 consolidates Bruce's reviewed wound tables and condition rules from the
October 12 discussion. It does not rerun combat or certify catalog balance.

## Current reference

- [Conditions](conditions.md): end-of-turn effect then decay; numbered Paralysis;
  duration-only blindness/deafness; starred persistence; Main Action removes 1 from
  an appropriate condition on self/adjacent; Grappled remains maintained.
- [Wounds](wounds.md): five complete tables, broad physical/mental activity Banes,
  explicit treatment/remedies, permanent scars and elemental clothing consequences.
- [Recovery](recovery.md): linked wound procedure and current fixed healing rules.

Physical/Elemental references to single-turn Dazed or Paralysis now use their
ratings and ordinary decay. Lasting eye injuries use Blinded 1*, because Blinded 1
no longer means partial blindness. Temporary sensory effects decay normally.

## Historical material — do not use as current rules

The generated catalog, existing test scripts, board fixtures, and saved results
remain the **version 0.1 experiment snapshot**. They include old condition removal,
sensory severity, and healing assumptions. They have not been migrated to this
revision. The source of generated catalog files is still tests/catalog.py; manual
changes to those generated tables would be overwritten.

The results manifest retains the original input hashes. The old verify.py source
hash check is expected to report changed inputs after these rule edits. Do not
regenerate report.py merely to replace those hashes: that would misrepresent which
rules produced the saved results. Run that experiment suite at the parent commit
52ff73d when reproducing its historical inputs. A new experiment revision must
update catalog/engine fixtures and produce fresh results with explicit assumptions.

## Other agreed follow-ups awaiting catalog/test migration

These decisions are retained here so the old fixtures cannot silently override them:

- Universal resistance cap 3; basic attacks 2/3/5 for next test, compare higher values.
- Summons disappear immediately beyond 6 squares from their controller, including
  forced movement of either. Forced movement should be common across the catalog.
- Attacks gain one Boon per target Grappled rating, including grapplers.
- Crafting acquisition grants two compatible ordinary recipes. Ordinary Recipes
  costs 2 DP for two additional compatible recipes; repeatable, requires appropriate
  crafting capability. Exceptional recipes remain discoveries/derivation.
- Class HP contributions: Protector 5, Blade 4, Arcanist 2, Shepherd 3, Intellect 2,
  Leader 4, Unbalanced 6, Shadow 3, Odd 3. Test level-1 signatures before level 3/7.
- Fixed spell and potion healing, casting costs, and Life resistance are recorded
  in recovery.md; percentage healing in historical cards is superseded.

## Remaining boundaries

The six treatment capabilities are a card-development list, not finished cards.
Their roll attributes and purchase requirements remain to be defined. Perception
and detection also remain a separate discussion. Mixed starred and temporary
contributions need a tracking rule. None of these gaps authorizes importing legacy
rules or inventing unapproved mechanics.
