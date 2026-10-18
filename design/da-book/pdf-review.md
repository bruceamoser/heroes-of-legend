# DA Guide & Bestiary — discipline expansion regression check

Reviewed October 18, 2026 for issue #1277. This is a local review proof, not a new
release. The published v16.2.0 assets are unchanged.

## Artifact and coverage

- 307 pages; 136,695,778 bytes.
- 192 creatures, 93 monster abilities, 73 summoned forms and 280 wound results.
- 206 distinct interior illustrations/diagrams, including all 192 portraits.
- 418 bookmarks and 2,681 internal links.
- All 358 cards remain on one page; largest creature card: 430.3 pt.
- 73 summon eligibility markers link to the player-facing profiles.

SHA-256: `6b2336d7e170e0cd20bc9389d9093375e7b28283f57e891dafde5572e8049f6c`.

## Checks performed

Reassembled and rebuilt with Typst 0.15.1 after the player catalog expansion.
Assembly, source and artwork hashes, bookmarks, internal destinations, wound text,
card geometry and bounds pass. Compression preserves text, page count and links.
No missing portraits, repeated illustrations, split cards or unexpected short
pages were found. Extracted text is identical to the published v16.2.0 DA book.
Rendered and inspected page 19 as a regression spot check; its language guidance
and two-column layout remain intact. No DA rules or creature statistics changed.

## Boundaries

This verifies assembly and presentation, not new encounter balance. The new player
abilities need table testing; creature CV and encounter budgets remain estimates.
This digital playtest PDF is not printer-certified PDF/X.

See [README](README.md) and `output/pdf-audit.json` for validation details.
