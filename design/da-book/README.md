# Dungeon Architect’s Guide & Bestiary

The world-agnostic companion for levels 1–10 is part of the Heroes of Legend
starter kit alongside the Player’s Book. Both books use current Markdown sources
and the Great Library visual style.

## Source and editing

- `manuscript/`: practical DA guidance, the rescue adventure, hazards and worksheets.
- `source-manifest.json`: chapter order and shared catalog sources.
- `../bestiary/creatures/`: all 192 creature entries.
- `../monster-abilities/`: 126 separate monster abilities.
- `../bestiary/summons/`: 73 player-facing summoned forms.
- `../rules/languages.md`: shared language reference; `manuscript/04a-languages.md` adds worldbuilding guidance.
- `../rules/conditions.md` and `../rules/wounds.md`: table references and 280 wound results.
- `../bestiary/art/manifest.json`: unique portraits for all creatures, with stable VTT references.
- `book.typ`, `template.typ`, `cover.typ`: title pages, layout and cover.
- `draw_diagrams.py`, `art/`: five editable adventure maps and rules diagrams.

Creature cards keep defenses together and show player-defense outcomes, damage
types and unique actions. Summon eligibility appears in linked header markers.
The internal CV ledger stays in the Markdown assembly, outside the reader PDF.

## Build and validate

See [starter-kit build instructions](../../release/README.md) for the complete
two-book workflow. For this book alone, from the repository root:

```sh
python3 design/da-book/assemble.py
python3 design/bestiary/art/audit.py
python3 design/da-book/draw_diagrams.py
TYPST=/path/to/typst PDF_PYTHON=/path/to/python-with-pypdf-and-pillow \
  python3 design/da-book/build_pdf.py --compile
/path/to/python-with-pypdf-and-pillow design/da-book/audit_pdf.py
```

Use Typst 0.15.1, Python dependencies from `design/player-book/requirements.txt`,
and Poppler. Fonts and licenses are bundled in the Player’s Book directory.

The PDF is `output/heroes-of-legend-da-guide-bestiary.pdf`. `generated/` and
`output/` are ignored build products. Builders read authored Markdown; they never
rewrite the catalog. The PDF audit checks source/art hashes, links, coverage,
intact cards, unique portraits and text bounds. It also confirms that image
compression preserves text, page count and links.

Review rendered pages as well as automated checks. See [PDF review record](pdf-review.md),
[art direction](art-plan.md) and [research references](references.md). Structural
checks do not certify encounter balance. CV and encounter budgets are playtest
estimates. This is a digital playtest edition, not a printer-certified PDF/X file.
