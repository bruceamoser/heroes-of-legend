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

## Named-tome revision

Bruce requested continuous Spell Law-style lists rather than purchase panels. The
preferred visual sample is now `tomes.typ`: four named tomes on one letter-size page,
with row colors keyed to named Forge abilities. Roman numerals preserve the mapping
in monochrome. Titles and early-node names are newly proposed flavor; existing spell
selections, costs and capstone names are unchanged. The earlier folio remains a
progression/confluence reference, not the preferred list layout.

```sh
typst compile design/player-book/forge-proof/tomes.typ output/pdf/forge-named-tomes.pdf
```

Validation: one page compiled and visually inspected; 44 spell rows. This change
adds presentation names only and does not change prerequisites or spell mechanics.

Player-facing terminology correction: use **Learned Sections**, not “Forge purchases.”
Refer to learning sections in order and label the row mapping “Sect.” The Forge is
internal design terminology, not the voice of the printed learning reference.
The revised single-page PDF was rebuilt and visually checked after this correction.

## Nonmagical learned abilities

`arms.typ` extends the same color/number scheme to four technique paths. Each row
names what is learned or improved; the closing summary collects cumulative effects
and distinguishes the additional level-3 ability. Examples are proposed for layout
review, not complete rules or replacements for canonical Arms cards. Bladework,
Impact, Disruption and Dueling draw structural inspiration from Four Lanterns Deep's
Arms paths, adapted to the requested four-step pattern. No confluence links are
invented for these newly proposed endpoints; named advanced connections must be
specified during actual discipline authoring.

Build: `typst compile design/player-book/forge-proof/arms.typ output/pdf/arms-learned-abilities.pdf`.
Validated: one letter-size page, all four paths visually reviewed without clipping.

Nonmagical revision: the player reference now prints actionable mechanics directly
in each entry, including action, attribute, range, outcome damage, condition ratings
and durations. Removed the repeated learning/progression labels and closing summaries.
Numeric Arms profiles are newly authored examples for Bruce's review, not a balance
claim or canonical card migration. Rebuilt and visually checked the single-page PDF.

Naming convention approved by Bruce: use the base ability name with I, II and III
for its successive improvements; reserve a distinct name for the additional final
ability (e.g. Measured Cut I/II/III, then Sweeping Blade). These numerals identify
learning steps, not character levels. Removed redundant leading numerals in the
layout. Applied to all four Arms paths and visually verified the rebuilt page.

Damage invariant reaffirmed by Bruce: all damage has a minimum of 1; every attack
hits for at least 1 after reductions. Corrected Blade Ward's erroneous zero floor
and stated the shared attack floor on the Arms sheet. Future defensive abilities
must preserve this invariant. Rebuilt and visually checked the single-page sample.
