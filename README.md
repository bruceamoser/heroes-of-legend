# Heroes of Legend

**A fantasy tabletop RPG with strategic character development and fast, card-driven play.**

> Grab your swords. Stow your spell books. Adventure awaits.

Build the hero you imagine from ancestry, culture, background, class, disciplines
and shared abilities. At the table, roll 3d6 plus one attribute, apply Boons and
Banes, and read the card’s Weak, Standard or Strong outcome.

## Player’s Book v16.0.0

The new major edition is a **234-page illustrated player book for levels 1–10**,
using the rebuilt system and the Great Library visual style. This is a digital
**playtest edition**, ready for table feedback.

- [Download the Player’s Book (PDF)](https://github.com/bruceamoser/heroes-of-legend/releases/latest/download/Heroes-of-Legend.pdf)
- [v16.0.0 release and notes](https://github.com/bruceamoser/heroes-of-legend/releases/tag/v16.0.0)
- [Editable player-book sources and build instructions](design/player-book/README.md)
- [Validation report](design/player-book/qa-report.md)
- [Editorial decisions and provisional rulings](design/player-book/decision-log.md)

The book includes 4 ancestries, 18 cultures, 32 backgrounds, 10 classes,
18 disciplines, 350 abilities, 43 equipment entries, 10 recipes, 73 summoned
companion profiles, 280 wound results, six worked heroes and four printable sheets.
Class cost tables, ability directories and tiered indexes help players find choices.

The complete 192-creature bestiary and DA encounter-building guidance remain in
[the design workspace](design/), for the separate Dungeon Architect book.

## Current rules and source

The current design lives in `design/` as editable Markdown. Player-facing teaching
chapters and the Typst book layout live in `design/player-book/`. The build reads
catalog entries; it never overwrites them.

The earlier Quarto book and original v15.1 playtest remain historical references.
Their mechanics are superseded by the current design and should not be used to
fill gaps in the new system.

## Build the player book

Follow [the dependency and editing guide](design/player-book/README.md). With
Python dependencies, Typst 0.15.1 and Poppler available:

```sh
python3 -m pip install -r design/player-book/requirements.txt
TYPST=/path/to/typst python3 design/player-book/build.py --compile
python3 design/player-book/audit.py
```

Output: `design/player-book/output/heroes-of-legend-players-book.pdf`.

## Repository layout

- `design/`: current rules, character choices, cards, equipment and bestiary.
- `design/player-book/`: teaching chapters, Typst layout, artwork, PDF and QA.
- `design/layout-test/`: historical layout-tool experiments.
- `quarto-book/`: earlier book source, retained for history.
- `source-doc/`: original playtest reference material.
- `.github/` and `.roo/skills/`: project workflow and editing guidance.

## Workflow and designer

Issue → branch → implementation → PR → review → squash merge → close.
Bruce A. Moser is the lead designer and final authority on rules and publication.
