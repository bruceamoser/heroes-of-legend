# Rewrite 299 — book proof checks

> Signature composition is superseded by [independent signature choices (#1354)](independent-signatures-1354.md). Earlier foundation bundling and line replacement are historical, not current rules.

This record concerns transcription, arithmetic and layout. It is not a claim that the new combat numbers have been balanced through playtesting.

## Worked examples

The six original named heroes now use one level-1 creation process. The authored `design/characters/examples.json` records their explicit choices for the Workshop importer; their Markdown chapters carry the same learning ledgers and paid equipment. Purchases were chosen by hand to support each hero's role.

The independent Python audit reads canonical discipline, spellbook, ancestry, origin, class and equipment Markdown. It checks attribute allocations and class minima, two legal ancestry traits, three distinct granted disciplines, a legal level-1 signature, sequential affordable purchases, current level gates, maximum HP and SP, coin totals, equipment Bulk, held hands and armor training. It compares the resulting resource and purchase totals with the printed examples. Result: 272 checks pass across six heroes.

Lira now buys a sword as well as her bow and ammunition; her example explains that Measured Guard requires switching to the sword. Vaelis pays for capacity training that brings maximum SP to 13. Borin learns light-armor training and buys his armor and shield. Pip's Fade Behind is correctly described as a Maneuver.

## Transcription and regression checks

- All 319 existing spells retain their IDs and their eleven-entry spellbooks. All 20 additional mastery spells belong to one named book and cost 4 DP at level 7.
- Each of the 29 spellbooks retains exactly two contiguous facing pages, with its complete spell effects, list, discipline token and unique illustration. Masteries are complete in separate folios.
- Seven-step nonmagical paths retain their full mechanics in the two-column design, with explicit level-3 and level-7 requirements.
- Upgraded signatures repeat the complete foundation and include any conditional level-3 improvement. The renderer now preserves each later procedure's Action and Attribute line, rather than stripping all such lines after promoting the first procedure to the card header.
- Entry-local PDF verification uses each source card's named PDF destination. Internal headings repeating a foundation's name are not mistaken for the next card. Every repeated action, attribute, target and duration is checked, as well as complete rules paragraphs.
- The six small talents are level 1, priced at 1 DP. They have their own index and do not appear among class signatures.

## Visual inspection

The first complete proof's player pages 9, 18, 51, 77–78, 138, 164, 272 and 289 were rendered and inspected: Starting SP, ancestry traits, long signature cards, both Arms pages, Hold Person and its explicit control attributes, mastery folios, a worked example and the creation ledger. The DA's pages 31, 33 and 35 were also inspected for advancement, recovery, learning and magic procedures. Borders, text, tables and illustrations remained within the page area; no visible clipping was found in those samples. The final proof’s page 51 was re-rendered after restoring action lines: both the level-3 Reaction and the level-7 one-minute procedure are visible, including the conditional level-3 Reaction, with no clipping.

Local preview images in `tmp/pdfs/rewrite-review/` are intermediate QA files, not release artifacts. Final release checks must use the latest canonical source and regenerate source hashes after any rule edits.

## Final local proof result

The complete audit-and-package pass finished successfully against the current working sources. Player’s Book: 294 pages; DA Guide: 310 pages. Player source coverage, links, outcomes and geometry checks passed. DA checks passed with zero word-bound findings and zero short pages. Entry-local transcription passed all 115 ability cards and 50 ancestry traits: 2,360 fields/procedures present, with 25 documented shared-procedure omissions and no missing entries. The separate spell-spread audit also passed after the final player rebuild.

A local v17.0.0 proof bundle was generated with `source_dirty: true`; it is not the final clean release package. After the source commit, run clean release packaging so its provenance identifies that commit. Source edits after this check require a fresh affected-book build and audit.
