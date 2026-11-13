# Heroes of Legend — Player's Book

The level 1–10 player-book manuscript, built in Typst with the approved cover and
Great Library palette. The PDF is `output/heroes-of-legend-players-book.pdf`.

## Edit the book

- `manuscript/`: original player-facing teaching chapters, in editable Markdown.
- `../cards/`, `../classes/`, `../ancestries/`, `../origins/`, `../disciplines/`,
  `../equipment/`, `../recipes/`, `../paths/`, `../characters/`: source catalog entries.
- `../bestiary/summons/`: the player-facing summoned forms, not DA creature stat blocks.
- `../rules/languages.md`: shared language rules and choices, also included in the DA book.
- `../rules/wounds.md`: descriptive scar prompts.
- `template.typ`: typography, page furniture, ability headers, tables and callouts.
- `book.typ`, `sheets.typ`, `cover.typ`: assembly, printable sheets and approved cover.
- `art/interior/`: generated illustrations and discipline symbols; full-resolution masters.
- `art/interior-prompts.json` and `art/revision-prompts.json`: saved generation prompts.
- `ability-summaries.json`: authored one-line directory descriptions, keyed by card ID.
- `../spellbooks/`, `../combined-abilities.md`, `../rules/learning.md` and `../rules/magic.md`: canonical learning and casting chapters.
- `integrate_learning.py`: assembles learned paths, linked spell tables, individual casting blocks and exact-endpoint combinations into the book’s two-column layout. Recipes render directly from their Markdown sources.
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
python3 scripts/audit_spellbooks.py
python3 scripts/audit_spellbook_spreads.py
```

If `TYPST` is unset, the script uses Typst on PATH, then the local tool-test binary
at `/tmp/hol-typst/typst-x86_64-unknown-linux-musl/typst` if it exists. That temporary
fallback is for this workspace; install/provide Typst for a lasting setup. Fonts are
loaded from the repository, including the italic face used for narrative text.
No external Typst package is required by the player book.

`audit.py` checks named-record coverage, source freshness, extracted PDF ability
outcomes and recovery text, origin grants, presentation freshness, class transparency,
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

The November playtest revision integrates health, sequential learning, spellbook pages and combined disciplines. Current authored
rules and catalog entries are the authority; Git history holds previous editions.
The 29 spellbooks contain 319 casting blocks: 169 Main Actions, 22 Maneuvers,
12 Reactions with triggers, and 116 Rituals with casting times. Shared casting,
sustain, cancellation and SP-transfer procedures are in `design/rules/magic.md`.
Basic Actions contains the 18 universal actions; the six small talents appear
in character creation. New mechanics require review. CV calibration remains
playtest work.

Both books share the language reference. The Player’s Book includes every summoned
form but excludes the full DA bestiary and encounter-construction material.

Generated files and PDFs are ignored build artifacts. Use the
[two-book starter-kit workflow](../../release/README.md) for releases. The release
always includes this book and the Dungeon Architect’s Guide & Bestiary.
See [QA report](qa-report.md) for validation and [current rules](decision-log.md)
for important cross-references. Rendered-page review remains required after layout
changes; this digital playtest edition is not a print-production certification.


Each of the 29 spellbooks occupies one even/odd facing spread. The colored list
and eleven intact spell blocks share that spread, with consistent text sizing
and the discipline token on every card. `spellbook-spreads.typ` measures cards
and partitions them into four columns; a failed fit stops the build.
`spellbook-art.json` assigns one unique illustration per book. Seven existing
painted assets and 22 detailed generated fantasy illustrations fill the available
space. All 22 replacements preserve their transparent alpha backgrounds. New magical-discipline tokens live in `art/tokens/`; Life retains its
existing token. `audit_spellbook_spreads.py` checks facing-page alignment,
complete spell text, illustration placement and token coverage.
