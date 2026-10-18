# Player’s Book — one-DP ability update proof

Reviewed October 18, 2026 for issue #1273. This working proof covers levels 1–10;
the public v16.1.0 starter-kit release is unchanged. The separate armor PR #1272
is not included in this branch’s 356-ability count.

## Artifact and coverage

- 240 US Letter pages; 94,831,059 bytes.
- 614 included source records, all 356 abilities and 486 outcome lines.
- All 280 wound results; 73 summoned forms; six complete example heroes.
- 153 art assets; 132 unique illustration placements, including 24 open-space
  placements. No duplicate interior illustrations.
- Four printable sheets on pages 230–233.
- 2,063 PDF links and 969 bookmarks.

SHA-256: `838beb818e58d5ff45eaa08e13b9754a661ac2d37052927a1a271e0004c7fb77`.

## Checks performed

Built with Typst 0.15.1. Source and PDF audits pass: printed prices, requirements,
origin grants, source links, ability text, wound cells, artwork and page bounds.
Compression preserves the extracted text and original artwork resolution and
alpha masks. The six approved exceptions cost 1 DP; the 18 free Universal actions
remain separate. All other tier prices retain their normal audit guard.

The initial build was rendered in full and inspected in page overviews. All six
new cards and the ability introduction were inspected enlarged. This caught
nearly empty continuation pages in the character examples and Novice index;
compact spacing removed them without shrinking the type. The final examples,
reference sheets and all indexes were rendered and reviewed again. The book is
two pages longer than the released baseline.

Checked Pip, Oren and Vaelis’s purchase prices and ledger arithmetic. The new
options spend four previously expiring DP across their creation stages without
changing attributes, HP, Speed, Grit, Bulk or coins. Vaelis records Dwarven from
Another Tongue. Both books explain this one-time language grant.

## Boundaries

These are source, arithmetic, transcription and layout checks, not balance
simulations or independent editorial review. The new cards await Bruce’s review.
Creature CV and encounter budgets remain playtest estimates. This digital
playtest PDF is not a printer-certified PDF/X file.

See [README](README.md) for builds and [release instructions](../../release/README.md)
for the combined starter kit. Generated audit reports live under `generated/`.
