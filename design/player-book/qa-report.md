# Player’s Book — creature action synchronization proof

Reviewed October 18, 2026 for issue #1279. This is a review proof beyond the
published v16.3.0 starter kit; no new release is published by this work.

## Artifact and coverage

- 259 US Letter pages; 94,769,221 bytes.
- 678 source records, all 419 player abilities, 44 equipment entries and 73 summons.
- All 498 rolled outcome lines and 280 wound results remain present.
- Six complete example heroes; four printable character sheets on pages 249–252.
- 153 art assets and 131 unique illustration placements, including 24 open-space placements.

SHA-256: `daacfda4006a3e147808bb216887e6ca80aeaecd74ff46b3923cdb8cf99dc403`.

## Checks performed

Rebuilt with Typst 0.15.1 after the creature action review. The authoring and PDF
audits pass source freshness, names, summaries, outcomes, wound text, origin grants,
internal links, art and bounds. Export optimization preserves extracted text,
source artwork resolution and alpha masks.

55 summon profiles changed: 37 content/organization changes and 18 CV/title-only
updates. Reviewed Maneuvers use their explicit command package and controller-turn
expiry. Shared movement techniques retain the correct movement mode, terrain and
occupancy limits and protect only against their named opportunity source.
Summons retain no Reactions, opportunities, independent activity or healing.

The complete-rule parity check caught missing Shambling Advance setup in the
Crypt Ghoul and Zombie Shambler profiles. Both now grant the printed 1 attack Boon
when their Main command permits the approach and attack in the same controller
turn. It does not grant another attack or command. The check now compares full
reviewed Maneuver rules with player-facing Boons and controller timing, not names.

Inspected final player pages 166, 180, 190 and 222: ghoul, spider, lantern guide and
zombie profiles. Also checked ancestor and mammoth examples during layout review.
Narrative, targets, effects and limits fit their reference cards without clipping.

## Boundaries

The player ability catalog and learned-card indexes remain at 419. Creature CV
identifies the DA entry; it does not rate a commanded form without its Reactions.
These checks verify content and presentation, not new encounter balance.

See the [complete review](../bestiary/action-coverage.md) and
[Foundry #175](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/175).
