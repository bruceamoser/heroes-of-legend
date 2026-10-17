# Heroes of Legend — Player's Book

The level 1–10 player-book manuscript, built in Typst with the approved cover and
Great Library palette. The PDF is `output/heroes-of-legend-players-book.pdf`.

## Edit the book

- `manuscript/`: original player-facing teaching chapters, in editable Markdown.
- `../cards/`, `../classes/`, `../ancestries/`, `../origins/`, `../disciplines/`,
  `../equipment/`, `../recipes/`, `../paths/`, `../characters/`: source catalog entries.
- `../bestiary/summons/`: the player-facing summoned forms, not DA creature stat blocks.
- `../rules/languages.md`: shared language rules and choices, also included in the DA book.
- `../rules/wounds.md`: all five complete wound tables.
- `template.typ`: typography, page furniture, ability headers, tables and callouts.
- `book.typ`, `sheets.typ`, `cover.typ`: assembly, printable sheets and approved cover.
- `art/interior/`: generated illustrations and discipline symbols; full-resolution masters.
- `art/interior-prompts.json` and `art/revision-prompts.json`: saved generation prompts.
- `ability-summaries.json`: authored one-line directory descriptions, keyed by card ID.
- `recipe-presentation.json`: reader-facing grant, crafting and completion text.
- `art/class-cutout-prompts.json` and `art/reference-prompts.json`: latest portrait/reference prompts.
- `fonts/`: bundled open-license typefaces and their OFL notices.
- `build.py`: reads Markdown and creates the disposable `generated/body.typ` and manifest.
  It never rewrites the source catalog. Do not edit generated files by hand.
- `decision-log.md`: navigation to current rules and resolved boundaries.
- `layout-notes.md`: reference consultation and HOL's independent visual design.

## Build

Requires Python 3 with `markdown-it-py` (tested with 3.0.0), Typst **0.15.1**, and
Poppler, Pillow and pypdf for illustrated export and audits. Dependencies are explicit; the build makes no network requests.

```sh
python3 -m pip install -r design/player-book/requirements.txt
TYPST=/path/to/typst python3 design/player-book/build.py --compile
python3 design/player-book/audit.py
```

If `TYPST` is unset, the script uses Typst on PATH, then the local tool-test binary
at `/tmp/hol-typst/typst-x86_64-unknown-linux-musl/typst` if it exists. That temporary
fallback is for this workspace; install/provide Typst for a lasting setup. Fonts are
loaded from the repository, including the italic face used for narrative text.
No external Typst package is required by the player book.

`audit.py` checks named-record coverage, source freshness, extracted PDF ability
outcomes and wound text, origin grants, presentation freshness, class transparency,
retired boilerplate, and page text bounds.
The two-pass export measures unused page areas before placing a finite set of relevant
object illustrations and landscapes. Each scene, portrait or object illustration is
used at most once; functional symbols and logos may repeat. Empty space never
triggers a cycle of repeated portraits. `art-direction.md` records the reference
consultation and placement policy. It then
compresses embedded artwork while preserving its resolution and alpha masks,
selectable text, links and vector rules. Set `PDF_PYTHON` if pypdf is in a separate
Python runtime; the local bundled runtime is a workspace fallback.
Full-resolution source art remains unchanged. It does not certify game balance. The normal design and bestiary audits remain useful:

```sh
python3 design/audit.py
python3 design/bestiary/audit.py
```

## Current baseline and release

Bruce approved the current system through October 17, 2026. Current authored
rules and catalog entries are the authority; Git history holds previous editions.
New mechanics require a new review. CV calibration remains playtest work.

Both books share the language reference. The Player’s Book includes every summoned
form but excludes the full DA bestiary and encounter-construction material.

Generated files and PDFs are ignored build artifacts. Use the
[two-book starter-kit workflow](../../release/README.md) for releases. The release
always includes this book and the Dungeon Architect’s Guide & Bestiary.
See [QA report](qa-report.md) for validation and [current rules](decision-log.md)
for important cross-references. Rendered-page review remains required after layout
changes; this digital playtest edition is not a print-production certification.
