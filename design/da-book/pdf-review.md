# DA Guide & Bestiary: PDF review record

Review proof completed October 17, 2026, from the approved manuscript and current
shared Markdown catalogs. This is the digital review edition for Bruce, not a new
published release. The released Player’s Book is unchanged.

## Final artifact

Build with the commands in [README](README.md). The local result is
`output/heroes-of-legend-da-guide-bestiary.pdf`; generated files are not committed.

| Measure | Final proof |
|---|---:|
| Pages | 371 |
| File size | 74,146,614 bytes |
| Shared source files | 375 |
| Creature entries | 192 |
| Monster ability entries | 93 |
| Summoned form profiles | 73 |
| Wound results | 280 |
| Unique interior illustrations and diagrams | 100 |
| Bookmarks | 417 |
| Internal links | 3,451 |
| Cards kept intact on one page | 358 |

SHA256 of this reviewed PDF:
`a772156dc230e9736f689bcf1f50073b3cb66b5b9e728a94840a7f7c4d146fc0`.

The book includes ten chapters, the adaptable rescue adventure and three maps,
four appendices, writeable worksheets, conditions and wounds, five creature
indexes, and the full creature design ledger at the end. Creature cards use
player defense outcomes; summoned profiles retain attacker outcomes. Ledger
entries link back to their creature cards.

## Validation performed

- Built with Typst 0.15.1 and the existing Player’s Book fonts. Source Markdown
  remains authoritative; generation does not rewrite catalog files.
- Checked all source, artwork and build-input hashes against the final build.
  Verified every creature, ability and summon bookmark exactly once, and all
  280 wound rows in the reference section.
- Verified start/end page metadata for all 358 cards. The largest creature card
  is 506 points tall; no creature, monster ability or summon card splits pages.
- Checked internal destinations and extracted word bounds throughout the PDF.
  No invalid destinations, out-of-bounds words, replacement glyphs or unexpected
  nearly-empty pages were reported.
- Verified all 100 selected interior assets appear once. The book uses 95
  existing approved illustrations and five original vector diagrams. Cover
  assets are separate from this interior count.
- Compared the compressed PDF against the raw proof: identical extracted text,
  page count and link count. Compression changes embedded RGB art only; original
  pixel dimensions, transparency masks and vector text are retained.
- Reviewed every page layout in rendered contact sheets across the final passes.
  Re-rendered and inspected all pages affected by the last appendix changes.
  Inspected representative pages at full size: cover, prose, all maps, Stability
  and summon diagrams, dense and short creature cards, monster abilities, summons,
  worksheets, conditions, wound tables, indexes and the design ledger.
- Ran the shared-source assembly check, design audit and bestiary audit, plus
  Python syntax and whitespace checks. See `output/pdf-audit.json` for the
  reproducible PDF audit’s detailed result.

Visual corrections included keeping cards together, increasing creature text
size, balancing prose columns, giving worksheets writing space, moving shared
ability boilerplate to its introduction, and replacing ledger references to
statistics “above” with links and references to the creature card. Maps use
editable vector labels and distinguish schematic routes from square grids.

## Review boundaries

This pass verifies assembly, navigation and rendered layout. It is not an
independent editorial proofread of every sentence or an encounter balance test.
CV values remain estimates pending encounter calibration; no new simulations
were run for this layout pass.

Some creature pages intentionally remain unillustrated where suitable unique art
was unavailable. Existing approved art is reused from the project, once per image
within this book; the five diagrams are new. No art placeholders remain in the
review PDF.

This is a screen-readable review PDF, not a printer-certified PDF/X deliverable.
CMYK conversion, bleed and printer-specific preflight remain publication work.
Bruce’s review and any resulting corrections precede release.
