# Forge spellbook print study

Review artifact for #1308; downstream tracking: bruceamoser/heroes-of-legend-foundry#270.
This isolated study does not replace the current book's rank/card chapter. It establishes
print presentation before the broader progression rewrite and completed spell profiles.

Build from repository root:

```sh
typst compile design/player-book/forge-proof/proof.typ output/pdf/forge-spellbook-layout.pdf
```

The four-page folio contains a progression introduction, a two-page Elements spread
with four actual spell lists, and its outgoing confluence requirements. Purchase bands
preserve sequential prerequisites. Advanced pages sit inside the same capstone panel,
so the layout cannot imply three additional purchases. DP and SP occupy different
visual locations. Color supports the hierarchy but borders, arrows and labels carry it.

`catalog.json` is a review snapshot of the existing local Magic Forge prototype's
`dist/catalog.mjs` exports (November 12, 2026), not a second canonical spell catalog.
Spell names, costs, node IDs and contacts are retained. Do not author spell rules here.
The completed book needs full casting profiles and generated cross-references from each
list row. Current folio page references are specific to this four-page artifact.

Four Lanterns Deep reference: `src/core/forge-catalog.mjs`, node construction and
`contact()`/intersection construction. Branch nodes require their predecessor; contacts
resolve to exact branch endpoints. HOL intentionally uses Bruce's new level-3 capstones
and level-7 confluences instead of the game's rank investment and tier-II level-3 rules.
New magic taxonomy uses the existing Magic Forge connections, not invented FLD spell links.

Validation: Typst 0.15.1 compile, four letter-size pages; visual inspection of all four
rendered pages. Existing book builds are unaffected because neither consumes this study.
The separate health rewrite PR #1307 remains untouched. No claim of spell balance or
completed casting mechanics is made by this layout proof.
