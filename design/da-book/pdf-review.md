# DA Guide & Bestiary — v16.2.0 release review

Reviewed October 18, 2026. This is the DA half of the user-authorized v16.2.0
starter-kit release. Both books carry edition date 2026-10-18.

## Artifact and coverage

- 307 pages; 136,695,778 bytes.
- 192 creatures, 93 monster abilities, 73 summoned forms and 280 wound results.
- 206 distinct interior illustrations/diagrams, including all 192 portraits.
- 418 bookmarks and 2,681 internal links.
- All 358 cards remain on one page; largest creature card: 430.3 pt.
- 73 summon eligibility markers link to the player-facing profiles.

SHA-256: `cfadd41659473aaa549a8edf4be323ceafb696d5ea79b3b19466eef0aec9fee7`.

## Checks performed

Reassembled and rebuilt with Typst 0.15.1. Assembly, source and artwork hashes,
bookmarks, internal destinations, wound text, card geometry and bounds pass.
Compression preserves text, page count and links. No missing portraits,
repeated interior illustrations, split cards or unexpected short pages were found.

Compared extracted text page by page with the approved one-DP proof: only page 2,
the edition page, changes. Pages 2 and 19 were rendered and inspected enlarged.
Page 19 retains the approved Another Tongue language-learning guidance; the
remaining text matches the prior proof. Relative to v16.1.0, these are the two
changed pages. Creature mechanics and illustrations remain unchanged.

## Boundaries

This verifies release assembly and presentation, not new encounter balance.
No new simulations were run. Creature CV and encounter budgets remain playtest
estimates. This digital playtest PDF is not printer-certified PDF/X.

See [README](README.md) and `output/pdf-audit.json` for validation details.
The release manifest identifies the final clean source commit and PDF hashes.
