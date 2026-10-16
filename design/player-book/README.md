# Heroes of Legend — Player's Book

The level 1–10 player-book manuscript, built in Typst with the approved cover and
Great Library palette. The PDF is `output/heroes-of-legend-players-book.pdf`.

## Edit the book

- `manuscript/`: original player-facing teaching chapters, in editable Markdown.
- `../cards/`, `../classes/`, `../ancestries/`, `../origins/`, `../disciplines/`,
  `../equipment/`, `../recipes/`, `../paths/`, `../characters/`: source catalog entries.
- `../bestiary/summons/`: the player-facing summoned forms, not DA creature stat blocks.
- `../rules/wounds.md`: all five complete wound tables.
- `template.typ`: typography, page furniture, ability headers, tables and callouts.
- `book.typ`, `sheets.typ`, `cover.typ`: assembly, printable sheets and approved cover.
- `art/interior/`: generated illustrations and discipline symbols; full-resolution masters.
- `art/interior-prompts.json` and `art/revision-prompts.json`: saved generation prompts.
- `ability-summaries.json`: authored one-line directory descriptions, keyed by card ID.
- `recipe-presentation.json`: reader-facing grant, crafting and completion text.
- `art/class-cutout-prompts.json` and `art/reference-prompts.json`: latest portrait/reference prompts.
- `icons/`: historical SVG symbol names; the book uses the simplified generated PNG silhouettes.
- `fonts/`: bundled open-license typefaces and their OFL notices.
- `build.py`: reads Markdown and creates the disposable `generated/body.typ` and manifest.
  It never rewrites the source catalog. Do not edit generated files by hand.
- `decision-log.md`: newly found editorial conflicts and unresolved boundaries.
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

## Approval and editorial policy

Bruce approved the cover and all active open design proposals on October 15, 2026.
Old proposal/status badges are suppressed in the reader edition; their historical
source text is retained. Withdrawn proposals are not revived. New edge-case rulings
are explicitly marked in the book and logged for review.

The book intentionally excludes the complete DA bestiary, CV design worksheets,
encounter construction, historical reviews and old Quarto mechanics. Every player
summon profile is included so the summoning catalog is usable independently.

All interior placeholders have generated illustrations. The book includes 18 simple gold
discipline symbols with high-contrast rank numerals and four printable character sheets. This digital
playtest proof is not a printer-ready release: final art resolution, bleed,
production color and release notices belong to the later publication pass.

## Current proof

234 pages, approximately 89 MiB. See [QA report](qa-report.md) for verified coverage and limits, and
[construction decisions](decision-log.md) for the small number of review items.
