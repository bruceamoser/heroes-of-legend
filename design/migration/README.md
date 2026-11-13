# November book integration

Source issue: https://github.com/bruceamoser/heroes-of-legend/issues/1313
Downstream implementation: https://github.com/bruceamoser/heroes-of-legend-foundry/issues/272

The Player’s Book now assembles the canonical discipline sources in its normal two-column layout: 11 nonmagical disciplines, seven magical disciplines plus Spellcraft, 29 spellbooks (319 spell entries), and 41 combined abilities. All 2/3/4-discipline combinations require level 7 and 3/4/5 DP respectively. Each names every required endpoint. Nine combinations mix magical and nonmagical disciplines; eleven further entries carry the magical atlas combinations into complete first-pass procedures.

The original playtest requests are represented as follows:

| Request | Book status | Further work |
|---|---|---|
| Slower HP growth | Integrated | Test encounter length and ancestry/class spread |
| Death rolls and descriptive scars | Integrated | Test repeated damage at 0 and stabilization |
| Fewer abilities with incremental improvements | Integrated | Test decisions and cumulative effects at the table |
| Discipline paths and linked advanced combinations | Integrated | Test DP pacing and endpoint opportunity costs |
| Combat and utility magic | Atlas, learning, SP and combined workings integrated | All 319 casting profiles authored; review and test utility limits and martial parity |
| Social objectives and learned improvements | Integrated in both books | Test attainable concessions, group contributions and DA targets |

Core resolution, always-hit minimum damage 1, player-only rolls, ancestry/culture/background/class, the action economy and condition decay remain in place. Healing uses time, SP and supplies rather than a Hit Dice pool. Grit remains three lifetime grants at levels 1/3/7. Bruce approved automatic +2 maximum SP each level after level 1 during this integration; learned capacity adds to that growth.

## Migration and review

`origin-grants.json` records the former origin choices mapped to current access and first entries. `learning-redirects.json` preserves old ability IDs as redirects rather than leaving their rules active. `character-ledgers.json` records the rewritten examples; the independent example audit reads the authored Markdown and checks it against current rules instead of trusting that record.

Creation keeps separate level-0 and level-1 pools. Class grants supply two access choices and a milestone signature. Signature cards now say Class choice instead of printing a DP purchase price. Training grants no equipment unless explicit. Equipment, recipes and examples have been reconciled where they depended on retired cards. Clearing Tonic carries its administration procedure on the item; smoke is a single-use flask, as required by the new Craft branch.

Review the origin mappings, signature acquisition restriction, recipe permissions, and eleven newly completed magical combination procedures as integration choices. The full spell profiles are now authored for table testing; balance and the new shared casting procedures still require review. Foundry implementation is tracked separately and has not been changed by the book integration.

## Production

Markdown remains the editable rules source. Python assembles Typst with the existing fonts, illustrations, two-column flow, internal links and page references. Both PDFs receive source coverage and layout audits; representative pages are rendered for visual inspection. PDFCraft CLI is a useful additional post-build check and PDF inspection tool. It should not replace source edits: changes made only in a finished PDF disappear on the next rebuild.


## Spell blocks and action chapters

The spellbook tables link directly to 319 authored blocks with action, SP,
attribute or automatic resolution, target/range, duration and complete effect.
Longer castings are Rituals, including the eight long-casting magical combined
abilities. The shared section costs and page grants appear once. Each list keeps
its colored sections and named endpoint.

Basic Actions contains the 18 universal actions. The six 1-DP talents now appear
in character creation and explicitly permit level-0 learning. Corrected four
basic-attack summaries that described the wrong attack; their printed mechanics
are unchanged. True Strike explicitly uses adjacent melee or 8-square ranged
reach, consistent with the basic attacks.

New procedures needing design review include sustained magic (one spell,
Maneuver plus 1 SP upkeep), cancellation progress (target 2 plus printed SP),
illusion inspection, the shared lifetime resurrection limit, and transfers of
existing SP bounded by donor supply and recipient capacity. Rituals state their
casting time and follow any printed daily schedule. These are authored playtest
rules, not a claim that utility reach or resource costs have been balanced.

Foundry will need linked spell records, action/trigger/ritual-time fields,
section-to-page grants, durations and sustain tracking, cancellation progress,
and bounded SP transfers. This source revision remains under review in PR #1314;
Foundry issue #272 tracks implementation separately.
