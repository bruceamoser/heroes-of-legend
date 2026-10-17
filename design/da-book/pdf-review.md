# DA Guide & Bestiary: PDF review record

Review proof completed October 17, 2026, from the approved manuscript and current
shared Markdown catalogs. This is the digital review edition for Bruce, not a new
published release. The released Player’s Book is unchanged.

## Final artifact

Build with the commands in [README](README.md). The local result is
`output/heroes-of-legend-da-guide-bestiary.pdf`; generated files are not committed.

| Measure | Final proof |
|---|---:|
| Pages | 307 |
| File size | 136,694,603 bytes |
| Shared source files | 377 |
| Creature entries | 192 |
| Monster ability entries | 93 |
| Summoned form profiles | 73 |
| Wound results | 280 |
| Unique interior illustrations and diagrams | 206 |
| Bookmarks | 418 |
| Internal links | 2,681 |
| Cards kept intact on one page | 358 |

SHA256 of this reviewed PDF:
`cbd4c3a4461a4a601dbf76b6dfca5e9b24ad2910d8fae7a4bb5cdffe7a8a4c33`.

The book includes ten chapters, the adaptable rescue adventure and three maps,
four appendices, writeable worksheets, conditions and wounds, five creature
indexes, and shared language rules with additional DA worldbuilding guidance.
Creature cards use player defense outcomes; summoned profiles retain attacker
outcomes. The Creature Design Ledger remains in internal Markdown notes only.

## Validation performed

- Built with Typst 0.15.1 and the existing Player’s Book fonts. Source Markdown
  remains authoritative; generation does not rewrite catalog files.
- Checked all source, artwork and build-input hashes against the final build.
  Verified every creature, ability and summon bookmark exactly once, and all
  280 wound rows in the reference section.
- Verified start/end page metadata for all 358 cards. The largest creature card
  is 430.3 points tall; no creature, monster ability or summon card splits pages.
- Checked internal destinations and extracted word bounds throughout the PDF.
  No invalid destinations, out-of-bounds words, replacement glyphs or unexpected
  nearly-empty pages were reported.
- Verified all 206 selected interior assets appear once, including a unique
  portrait for each of the 192 creatures. The portrait catalog contains 73
  existing illustrations and 119 new images generated with the built-in image
  tool. The art manifest records stable creature IDs, paths, provenance and
  checksums for later VTT use. Cover assets are separate from this interior count.
- Verified all 73 summonable creatures carry linked eligibility markers in their
  headers. Neutral Threat and Evasion display as 0; universal actions appear in
  the chapter introduction instead of repeating on every creature.
- Compared the compressed PDF against the raw proof: identical extracted text,
  page count and link count. Compression changes embedded RGB art only; original
  pixel dimensions, transparency masks and vector text are retained.
- Reviewed every page layout in rendered contact sheets across the final passes.
  Re-rendered every DA page after the final portrait-size adjustment.
  Inspected representative pages at full size: cover, prose, all maps, Stability
  and summon diagrams, dense and short creature cards, monster abilities, summons,
  worksheets, conditions, wound tables, language guidance and indexes.
- Ran the shared-source assembly check, design audit and bestiary audit, plus
  Python syntax and whitespace checks. See `output/pdf-audit.json` for the
  reproducible PDF audit’s detailed result.

Visual corrections included keeping cards together, increasing creature text
size, balancing prose columns, giving worksheets writing space, moving shared
ability boilerplate to its introduction, grouping defenses into two columns,
removing repeated universal action text, showing damage types and keeping the
design ledger out of the reader edition. Maps use
editable vector labels and distinguish schematic routes from square grids.

## Review boundaries

This pass verifies assembly, navigation and rendered layout. It is not an
independent editorial proofread of every sentence or an encounter balance test.
CV values remain estimates pending encounter calibration; no new simulations
were run for this layout pass.

Every creature has art. No art placeholders remain in the review PDF. The
existing illustrations are reused from the project once per image within this
book; the five diagrams are new. Artwork references are ready for a future VTT
export, but this pass does not implement a VTT importer or token pack.

The Player’s Book review build also includes the shared language reference,
concrete choices for all six example heroes and a language field on its sheet.
New starting-language defaults are proposals tracked in issue #1265. Neither
review build replaces a published release.

This is a screen-readable review PDF, not a printer-certified PDF/X deliverable.
CMYK conversion, bleed and printer-specific preflight remain publication work.
Bruce’s review and any resulting corrections precede release.
