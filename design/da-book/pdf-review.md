# DA Guide & Bestiary — creature action review proof

Reviewed October 18, 2026 for issue #1279. This proof includes proposed creature
Maneuvers and Reactions; it is not a new release. Published v16.3.0 is unchanged.

## Artifact and coverage

- 311 pages; 137,317,630 bytes; 410 current sources.
- 192 creatures, 126 monster abilities, 73 summoned forms and 280 wound results.
- 206 unique interior illustrations/diagrams, including all 192 creature portraits.
- 451 bookmarks and 2,681 internal links.
- All 391 reference/creature cards stay on one page; largest creature card 511.3 pt.
- All 73 summon markers link to their separate player profiles.

SHA-256: `bb06bef78060eb316916030062216aedf42e24ca2277125a0ee587c1093f5644`.

## Checks performed

Source, action-coverage, complete template rules, defense/attacker perspective,
provisional CV arithmetic, roster, encounter totals, artwork and source-link audits
pass. All 192 original Main Action tables and base statistics were compared with
the approved v16.3.0 source and remain intact. Both books compile with Typst 0.15.1.

PDF checks pass source/build freshness, all creature/ability/summon bookmarks,
internal destinations, card boundaries, wound text, page-safe bounds and unique
art placements. Image-only optimization preserves text, pages and links. No split
cards, missing portraits, replacement glyphs or unexpected short pages were found.

Inspected a contact set spanning DA pages 63, 92, 137, 204, 205, 230–233 and 296:
dragon, wolf, goblin, plant, skeleton, ability appendix and creature indexes.
Enlarged the final Thorn Lurker and Winter Wolf pages after target/effect sentence
clarifications, and checked the template reference at readable size. Their tables
state the effect, details retain limits, and illustrations fit below complete cards.
The appendix omits repeated ownership/action-budget boilerplate.

## Rules and boundaries

Reactions compete with opportunities; no new turns or reaction budget are granted.
Normal player rolls, condition decay, resistance, Stability and no-chain rules
remain. Retaliatory slowing/fear/deafening uses rating 2 to survive the attacker's
end-of-turn decay. Summon Maneuver rules have complete perspective/timing checks;
no DA Reaction is copied into a summon profile.

Coverage is not encounter-balance evidence. Utility/CV increments are explicit
estimates; clustered retaliation and disabling combinations need table tests.
See the [complete review](../bestiary/action-coverage.md) and
[Foundry #175](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/175).
