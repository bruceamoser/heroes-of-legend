# Heroes of Legend — current system

This Markdown workspace is the approved source for the game and both starter-kit
books. Bruce confirmed this baseline on October 17, 2026. Earlier editions,
simulation fixtures and completed revision histories are available through Git
history; they are not alternate rules sources.

Character development offers strategic choices. At the table, use the card, one
attribute and Boons/Banes. Flavor should make players want to try an ability;
precise rules should make it easy to resolve.

## Find the current material

- [Design intent](design-intent.md), [foundations](rules/foundations.md), [development](development.md).
- [Ancestries](ancestry.md), [cultures and backgrounds](culture-background.md), [classes](class.md), [disciplines](disciplines.md).
- [Abilities](catalog.md), [card conventions](card-conventions.md), [fantasy paths](fantasy-paths.md).
- [Discipline/action coverage review](discipline-coverage.md): the current expansion and origin-access comparison.
- [Equipment](equipment.md), [recipes](recipes.md), [market](market.md), [starting coins](starting-coins.md).
- [Six complete heroes](characters/README.md), [example scenes](example-scenes.md).
- [Languages](rules/languages.md), [conditions](rules/conditions.md), [recovery](rules/recovery.md), [wounds](rules/wounds.md).
- [Creature action review](bestiary/action-coverage.md): distinctive Maneuvers, Reactions and complete roster decisions.
- [Bestiary](bestiary/README.md), [monster abilities](monster-abilities/README.md), [summoning](rules/summoning.md).
- [Player’s Book](player-book/README.md), [Dungeon Architect’s Guide & Bestiary](da-book/README.md).
- [Further work](open-decisions.md), [research references](references.md).

## Editing and validation

Edit authored Markdown directly. Stable IDs identify records even when names
change. Both book builders read these records; neither rewrites them.

Run `python3 design/index.py` to refresh navigation after catalog edits, then
`python3 design/audit.py` and `python3 design/bestiary/audit.py`. Book-specific build
and audit commands are in each book’s README. Generated files and PDFs are local
build outputs; the starter-kit release packages both books.

`python3 design/discipline_coverage.py --check` shows shared options by discipline,
tier and action, separates single-discipline choices, and checks culture/background
access. These checks also run in the main authoring audit; they do not measure power.

The catalog is approved for playtesting. Structural validation does not certify
balance. Creature CV and encounter budgets remain estimates pending table evidence.
