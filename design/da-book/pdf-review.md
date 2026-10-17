# DA Guide & Bestiary — v16.1.0 PDF review

Reviewed October 17, 2026. This is the DA half of the two-book starter kit.
The shared rules and catalogs use the current approved baseline; Git history
holds earlier editions. Publication follows review of the cleanup PR.

## Artifact and coverage

- 307 pages; 136,694,722 bytes.
- 192 creatures, 93 monster abilities, 73 summoned forms and 280 wound results.
- 206 distinct interior illustrations and diagrams, including all 192 portraits.
- 418 bookmarks and 2,681 internal links.
- All 358 cards remain on one page; largest creature card: 430.3 pt.
- 73 summon eligibility markers link to the player-facing profiles.

SHA-256: `6a20a2f8059d9ba77295c0ca17e723690ce8b5ae918796fd338c6fbbe40e256d`.

Build and validation instructions are in [README](README.md). Generated files and
PDFs are disposable, ignored outputs. The full audit is `output/pdf-audit.json`.

## Checks performed

Both books were rebuilt with Typst 0.15.1. Assembly, source and artwork hashes,
bookmark coverage, internal destinations, wound text, card geometry and page
bounds pass. Compression preserves extracted text, page count and link count.
No missing portraits, repeated interior illustrations, split cards, unresolved
placeholders or unexpected short pages were reported.

All 307 pages were rendered and compared with the previously reviewed proof.
Only pages 2, 11, 25 and 282 changed; these were inspected enlarged. They contain
the edition information and removal of obsolete proposal labels. Remaining
pages match the prior rendered proof pixel for pixel at the comparison resolution.
The earlier complete visual pass included the cover, prose, maps, diagrams,
creatures, abilities, summons, worksheets, conditions, wounds, languages and indexes.

All creature art retains stable IDs, asset paths, provenance and checksums in the
art manifest for later VTT use. No VTT importer or token pack is included here.
The design ledger remains in internal source notes, outside the reader edition.

## Boundaries

These checks establish assembly and presentation, not encounter balance or an
independent sentence-by-sentence proofread. CV values remain playtest estimates.
No new simulations were run. The language rules approved in PR #1260 are included
in both books. This digital playtest PDF is not a printer-certified PDF/X file;
bleed, CMYK conversion and printer-specific preflight are separate work.
