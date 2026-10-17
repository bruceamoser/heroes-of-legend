# Layout and editorial decisions

## Reference consulted

Pathfinder Second Edition Core Rulebook (2019), local PZO2101E PDF:
printed pp. 2–3 (contents), p. 12 (terminology and two-column prose), p. 86
(class features and compact tables), p. 272 (equipment, table, inset definition).
PDF pages are one greater than printed pages in this file. Inspected page renders.

Borrowed organizational principles: a creation route, consistent headings, concise
entry metadata, repeated table headers, a visible distinction between explanations
and rules, and useful appendices. No Pathfinder text, artwork, trade dress or rules
are reproduced. HOL uses its own system and the approved Great Library visual identity.

## HOL equivalents

- US Letter page, 42 pt outer margins, two columns for ordinary prose/catalogs.
- Quiet pale parchment, forest headings, antique gold rules, ivory callouts.
- Cinzel chapter names, Almendra cover title, EB Garamond body.
- Ability header: numbered tier diamond, name, discipline requirements; action and
  roll immediately beneath. Narrative first; precise rule and full outcomes follow.
- Wide tables use the full page width; table headers repeat across pages.
- Page references and PDF links for named choices, a compact contents page and
  tiered alphabetical ability indexes. Printable sheets have white backgrounds.
- Generated interior illustrations use the approved forest, gold and ivory palette.
  All prompts are saved; original PNGs remain untouched by PDF optimization.
- Ability, equipment, recipe and companion entries have forest headers, gold borders
  and internal rules. Discipline rank numbers overlay illustrated badges.
- Culture, background, equipment and recipe introductions explain the choices before
  their catalogs. Four character paths illustrate contrasting builds.
- Starting coin and summon-selection tables are grouped into compact columns.
- Four white printable sheets cover play, training, belongings and creation.
- A raster inspection of the unadorned layout finds large empty lower-page areas.
  Contextual artwork is placed behind content only in those verified clear regions;
  writing fields and the index are excluded. This placement does not repaginate text.
- Editable Markdown teaching chapters; existing catalog Markdown remains the source.
  Build tools read it and never overwrite it.

## Current source

The approved catalog and teaching prose are the source. Approval metadata and
completed revision histories are not kept as competing rules. Current rule links
are in decision-log.md. The book remains a digital playtest edition; structural
checks do not certify balance or print production.


## October 16 follow-up: deliberate illustration placement

The first illustrated proof reused portraits too aggressively. The follow-up in
issues #1218–#1220 replaces that system: each illustration appears once, while
functional symbols and logos may repeat. A finite set of transparent gear and
magical-object illustrations accompanies class signatures and relevant utility
pages. Landscapes are reserved for suitable wide spaces. There is no fallback
portrait cycle. Class portraits appear on class introductions only.

Ancestry traits, cultures, backgrounds and disciplines now share the bordered
catalog-card styling. The eighteen discipline cards are split evenly across two
pages, with all shared rank and price rules in the introduction. Eighteen simple
gold silhouettes replace ornate badges on ability headers. A high-contrast rank
numeral overlaps the lower edge of the symbol, preserving its main outline.
Illustrations have additional lower spacing; ancestry panels have an explicit
gap before trait cards. See `art-direction.md` for the Pathfinder reference pages
and `art/revision-prompts.json` for the new image prompts.


## October 16: reader-facing references and flow

Class panels show all eighteen disciplines with actual DP costs for ranks 1/2/3.
The full class-by-discipline matrix follows the discipline introduction. Affinity
labels remain authoring data only. HP and coins are adjacent creation pages.

Shared rules belong in catalog introductions; individual exceptions remain on cards.
Four browsing tables use authored, concise effect summaries, while complete cards
retain adjudication text. Four alphabetical end indexes show requirements and pages.
Recipes separate grants, compatible abilities, preparation, materials and completion.

The measured reading-columns compositor preserves ordered paragraph/card blocks and
balances the final page. Short tables stay intact; long tables repeat headers. Its
US Letter geometry matches this template and must be rechecked if page size changes.
See https://typst.app/docs/reference/layout/columns/ for native column behavior.
