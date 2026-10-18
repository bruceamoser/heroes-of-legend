# DA Guide & Bestiary — one-DP ability update proof

Reviewed October 18, 2026 for issue #1273. This is a working proof; the public
v16.1.0 starter-kit release is unchanged.

## Artifact and coverage

- 307 pages; 136,695,445 bytes.
- 192 creatures, 93 monster abilities, 73 summoned forms and 280 wound results.
- 206 distinct interior illustrations and diagrams, including all 192 portraits.
- 418 bookmarks and 2,681 internal links.
- All 358 cards remain on one page; largest creature card: 430.3 pt.
- 73 summon eligibility markers link to the player-facing profiles.

SHA-256: `70f36c8c38b62998dd04a0b6f28d5dbb9af2fae5cff3cde68d0978f58a2c7ebb`.

## Checks performed

Reassembled and rebuilt with Typst 0.15.1 after adding Another Tongue to the
shared language guidance. Assembly, source and artwork hashes, bookmarks,
internal destinations, wound text, card geometry and page bounds pass.
Compression preserves text, page count and links. No missing portraits,
repeated interior illustrations, split cards or unexpected short pages were found.

Compared extracted text page by page against the released v16.1.0 DA book:
only page 19 changes. That page was rendered and inspected enlarged; the new
language-learning paragraph fits beside the existing communication guidance.
The remaining pages retain the previously reviewed presentation.

## Boundaries

This checks the shared language update and presentation, not encounter balance
or an independent editorial review. No new simulations were run. Creature CV
and encounter budgets remain playtest estimates. This digital playtest PDF is
not a printer-certified PDF/X file.

See [README](README.md) for building and `output/pdf-audit.json` for the full audit.
