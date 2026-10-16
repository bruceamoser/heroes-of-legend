# Illustrated player-book QA — October 16, 2026

## Deliverable

232-page US Letter player book for levels 1–10, with the approved cover, editable
Markdown teaching chapters, source-driven catalogs and Typst layout. Final PDF:
85,097,445 bytes (81.2 MiB). SHA-256: `9e012d11b319af7d74aeb0dea5fb0ad19386fa26d902cb39d0cdca847b0c6ad7`.

## Coverage

607 source records include 350 abilities (90 signatures, 18 universal actions and
242 shared abilities), 4 ancestries and 20 traits, 18 cultures, 32 backgrounds,
10 classes, 18 disciplines, 4 selected character paths, 43 equipment entries,
10 recipes, 73 player summon profiles, 280 wound rows and 6 worked heroes.
The four printable sheets occupy pages 224–227; the ability index follows.
The complete 192-creature DA bestiary remains outside this player book.

## Requested presentation revisions

- Added culture, background, equipment and recipe introductions, with early discipline links.
- Removed per-class multiclassing repetition; retained global creation, class-introduction and glossary references.
- Selected Thinking Fighter, Green Healer, Spellblade and Light-Fingered Adventurer as the four paths.
- Added compact forest-and-gold card headers, borders and separators to abilities, equipment, recipes and companions; removed redundant Rules headings and empty bullets.
- Reorganized starting-coin and summon-selection tables into grouped columns.
- Rebuilt four printable sheets for play, training, belongings/wounds and creation accounting.
- Generated and inspected 121 original interior assets, including 18 discipline badges with text rank overlays. Prompts and full-resolution PNGs are preserved.
- Filled clear areas with contextual illustrations, accounting for existing image rectangles and avoiding duplicate images on the same page. Writing fields and the index are excluded.

## Verification

- Typst 0.15.1 compilation succeeds; bundled fonts are embedded with Unicode mappings.
- The player-book audit passes: unique source labels and hashes, all 350 ability names,
  486 labeled outcome lines, and the descriptive/effect/remedy cells of all 280 wound rows.
- No missing planned images, no illustration placeholders and no text outside checked bounds.
- All 350 ability blocks fit together; largest measured block is approximately 391.1 pt,
  below the 675 pt split threshold.
- Final PDF contains 1,538 links with valid page targets and 943 bookmarks.
- Extracted text is byte-for-byte identical before and after PDF image compression.
  Embedded RGB image streams alone are compressed; original dimensions, alpha masks,
  fonts, text and source art remain intact. A Ghostscript export that damaged ligature
  extraction was rejected and replaced.
- Source audit passes for 990 Markdown files and 350 cards. Bestiary audit passes for
  192 creatures, 244 attack choices, 93 monster abilities and 73 player profiles.
- Every page inspected in overview, with enlarged checks of introductions, card headers,
  grouped tables, companion profiles, wound tables and all printable sheets. Final art
  placement corrections were rendered and checked again.

## Review boundaries

This is author QA, not independent approval or balance certification. It is a digital
playtest edition; print production, publication notices and professional copy editing
remain separate. The existing decision-log.md still records the previously identified
rule boundaries. No new game mechanics or legacy catalog content were introduced.
