# Rewrite impact and integration order

Inventory taken from current book main `d4d4b79` and the published Workshop Forge catalog. Tracking: source #1328; Workshop #299 and children #300–#305.

## Authored scope

| Family | Current size / location | Required treatment |
|---|---|---|
| Ancestries | 10 packages, 50 traits in `design/ancestries/` | Trait-by-trait characteristic, benefit and natural drawback review; preserve package resources unless explicitly changed |
| Classes | 10 classes, 90 signature cards | Three evolving identity lines or equivalent reviewed milestone choices; late entry/dependencies explicit |
| Nonmagical disciplines | 11 disciplines, 44 branches | Reassign directional roles; seven entries each yields 308 entries, replacing 176 current entries |
| Spellcraft | Three training branches plus one spellbook | Explicit mixed layout; training can extend without treating Channeling as a martial branch |
| Spellbooks | 29 books, 319 spells | Review duration/action/sustain/control; keep all learned spells and their mechanics on their book's two-page spread |
| Combined abilities | 41 entries | Map each concept to a mastery, signature, spell or documented retirement; remove intersection purchasing |
| Character creation | `development.md`, `rules/learning.md`, classes, origins, player chapter 02 | Reconcile single-stage creation, three disciplines, class prices, new DP income and current SP |
| Play procedures | `rules/magic.md`, recovery/conditions/session-resolution and both teaching manuscripts | Explicit player-caster/player-target escape examples; no routine NPC saving rolls; preserve condition-specific exceptions |
| Reader references | player chapter 14, DA tables, printable sheets, indices and linked references | Remove obsolete diagrams/terms and show current resources and actions |

The scope numbers do not certify coverage. Record each authored identity and destination so an item cannot disappear through bulk generation or naming changes.

## Current source discrepancies already identified

- `design/development.md` and player creation still describe level-0 and level-1 DP pools, two class disciplines and later income 8 + new level. The Workshop uses a single creation pool, one class discipline and later income 4 + new level.
- Source magic/learning prose still uses flat 1-DP discipline entry. The Workshop uses the complete class 1/2/3 matrix.
- Source SP prose still uses ancestry/culture/background1 and class3, rather than current ancestry contributions and twice the positive class-associated mental attribute.
- Source sustained magic still charges 1 SP per turn. The Workshop already uses a Maneuver and 0 SP.
- `design/player-book/build.py` embeds class selection prose and source-parsing expressions. Updating Markdown alone will leave two-class-discipline teaching and mismatched starting-SP text in the PDF.
- `design/player-book/nonmagical/` and `integrate_learning.py` assume compact four-step branches and include combined abilities. Seven-step branches need intentional pagination, not automatic shrinking.
- DA source assembly includes shared files, but teaching passages still need an independent sweep; sharing a rules file does not prove every example agrees.

## Integration sequence

1. Finish and review the contract, DP analysis and concrete identity/branch allocation maps.
2. Author complete content families in the book checkout. Preserve stable IDs or record an explicit old-to-new disposition. Keep authoring proposals out of assembled reader chapters until the family is coherent.
3. Update both manuscripts, class/ancestry tables and layout builders. Build both books and inspect representative dense pages, progression explanations, signature developments and spell spreads. Extend inspection when a failure reveals a systemic layout problem.
4. Import an immutable reviewed book revision into the Workshop Forge data. The source importer currently assumes four-step nonmagical branches and combined endpoints; update parsing and invariants before regenerating.
5. Reconcile `src/rules/forge-playtest-catalog.mjs` overrides with newly authored values. Avoid overriding new source effects with old browser patch text.
6. Implement list/atlas/signature/character persistence changes. All prerequisite and cost decisions must come from the shared engine, not separate list and map logic.
7. Validate revised builds, then publish both books and web. Keep native source locks, generated packs and world Actors unchanged until their own authorized implementation phase.

## Required reader-facing evidence

- A novice can identify what can be learned now, its total entry cost, its action and effect, and its next development.
- A level-3 triangle is distinct from a level-7 diamond in grayscale as well as color.
- A player knows which attribute to roll when escaping and which to roll when an enemy struggles against their spell.
- A player using a positional hazard retains the value of corridors, blocking and forced movement; spell limits are explicit rather than improvised after a successful strategy.
- A selected signature's later development works without an unchosen earlier signature. Switching choices either produces a valid dependent selection or clearly identifies what must be reselected.
- The book and Workshop agree on the same build's resources, learning costs, known capabilities and limitations.
