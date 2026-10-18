# Player’s Book — armor correction review

Reviewed October 18, 2026 for issue #1270. This working proof contains the proposed
armor correction; it does not replace the published v16.1.0 release.

## Artifact and coverage

- 238 US Letter pages; 94,313,147 bytes.
- 610 included source records, 351 abilities, 44 equipment entries.
- All 486 rolled outcome lines and all 280 wound results retained.
- 73 summoned forms; 50 culture/background pairs; six example heroes.
- 131 unique illustration placements, including 24 open-space placements.
- Four printable sheets on pages 228–231.
- 2,044 PDF links with valid destinations; 964 bookmarks.

SHA-256: `4c4bd45497c6b71141faf3ffdae18c79c7fb60a3aeec7bb626b0712c8e814eec`.

## Armor correction

Wear Light Armor is Novice, Armor 1, 2 DP and physical resistance 1. Medium moves
to Adept, Armor 2, 4 DP; heavy moves to Master, Armor 3, 8 DP. Light equipment is
10 coins; medium/heavy remain 40/90. All are Bulk 1. The 10-coin price and complete
progression are explicit in issue #1270 for review, not recovered historical rules.
Walled Communities grants light training and its absent-item grant. Borin’s
resistance is 1 while wearing that armor; his spending and other derived values
remain unchanged. The Guard/Shielding Step alternative is preserved.

## Validation

Design, bestiary and repository audits pass. Direct checks cover all three
trainings’ ranks, tiers, costs, resistance, equipment, prices and origin grants.
The shared Passive count is 15. Catalog/index links and book coverage counts are
updated. No NPC defenses or creature loot values were changed.

Built both books with Typst 0.15.1. The player audit passes source freshness,
outcome/wound transcription, origin grants, artwork and text bounds. Compression
preserves extracted text. All 238 player pages were rendered and compared with
the reviewed baseline; 21 changed pages were inspected in overview, with origin,
training cards, market, equipment reference and Borin’s pages inspected enlarged.
No split armor cards, clipped text or broken table layouts were found.

These are content and presentation checks, not new encounter-balance simulations
or independent review. The Foundry source pin and armor integration must follow
the reviewed canonical correction. The public release assets remain unchanged.

See [README](README.md) for builds. Detailed generated audits live in `generated/`.
