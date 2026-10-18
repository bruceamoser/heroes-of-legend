# Heroes of Legend

**Strategic character development. Fast, card-driven fantasy adventure.**

Build your hero from ancestry, culture, background, class, disciplines and shared
abilities. At the table, roll 3d6 plus one attribute, apply Boons and Banes, and
read the card’s Weak, Standard or Strong outcome.

## Starter kit — two books

The starter kit covers **levels 1–10** and includes:

- **Player’s Book:** rules, 4 ancestries, 18 cultures, 32 backgrounds, 10 classes,
  18 disciplines, 356 abilities, equipment, recipes, languages, wound tables,
  73 summoned forms, six example heroes and printable sheets.
- **Dungeon Architect’s Guide & Bestiary:** running and building adventures,
  encounter guidance, hazards, a rescue adventure with maps, campaign tools,
  192 illustrated creatures, 93 monster abilities and table references.

[Published releases](https://github.com/bruceamoser/heroes-of-legend/releases) ·
[Next release notes](release/notes.md) · [Build both books](release/README.md)

Version **16.1.0** is prepared here for review. Published downloads remain on the
Releases page until this revision is approved and released. This is a digital
playtest edition; creature CV and encounter budgets remain estimates.

## One current source

The approved system lives in [design/](design/README.md) as editable Markdown.
[Player teaching and layout](design/player-book/README.md) and
[DA teaching and layout](design/da-book/README.md) use Typst. Builders read the
catalog; they never overwrite authored entries.

Git history is the archive. Superseded rules, engines, simulation catalogs, source
PDFs and layout experiments are removed from the current tree. Do not consult an
older edition to fill a gap in the current rules.

## Build

With Python dependencies, Typst 0.15.1 and Poppler installed:

```sh
python3 -m pip install -r design/player-book/requirements.txt
TYPST=/path/to/typst python3 scripts/build_starter_kit.py
```

Both audited PDFs and the starter-kit ZIP are written under `dist/v16.1.0/`.
See [release instructions](release/README.md) for visual review and publication.
Generated PDFs and build outputs are not editable sources or tracked archives.

## Working on the game

Issue → branch → implementation → PR → independent review → squash merge.
Bruce A. Moser is the lead designer and final authority. See
[project instructions](.github/copilot-instructions.md), the [current catalog](design/catalog.md)
and [further playtest work](design/open-decisions.md).
