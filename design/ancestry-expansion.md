# Ancestry Expansion — Review Draft

**Status:** Drafting authorized November 3, 2026. Exact wording, statistics, traits and images await Bruce’s review. Nothing here records approval to release or implement downstream.

Book tracking: [issue #1299](https://github.com/bruceamoser/heroes-of-legend/issues/1299). Downstream tracking: [Foundry #259](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/259). Branch: `codex/1299-ancestry-review`.

## Creative direction from Bruce

Wood and High Elves are fundamentally separate ancestries. Similar ears and facial structures cause outsiders to group them as elves. Wood Elves are shorter, dark-haired, nimble, rash and impulsive. High Elves are tall, strong, stoic, long-lived, thoughtful and sometimes arrogant. These are descriptive tendencies, not compulsory personalities.

Dwarves diverged long ago. Surface people made mountain halls; others went deeper. Deep Dwarves are now grey-skinned, shorter, slighter, large-eyed and naturally shy. Gnomes are fey, smaller than halflings, long-lived, extraordinarily intelligent inventors and tinkers. Stories disagree whether they left fairie or were expelled. Goblins escaped orc enslavement; their inherited reputation obscures capable people seeking opportunity and a place in the world. The book gives free-born goblins room for their own lives as well.

Tallfolk and Oath-Bound continue from the initial proposal; their invented details remain especially open to review. Orcs remain excluded as playable ancestry by Bruce’s earlier direction. No bestiary, class, Path, culture or background content is changed.

## Proposed roster

| Ancestry | HP | Speed | Comparison size | Coins |
|---|---:|---:|---|---:|
| Human | +2 | 6 | Medium | +1 |
| High Elf | +3 | 6 | Medium | +2 |
| Wood Elf | +2 | 6 | Medium | +2 |
| Hill Dwarf | +4 | 5 | Medium | +2 |
| Deep Dwarf | +2 | 5 | Medium | +2 |
| Halfling | +1 | 5 | Small | +0 |
| Tallfolk | +5 | 6 | Medium | +1 |
| Gnome | +1 | 6 | Small | +1 |
| Goblin | +1 | 6 | Small | +0 |
| Oath-Bound | +2 | 6 | Medium | +1 |

High Elf +3 and Deep Dwarf +2 are new proposals expressing their contrasting builds. All six new ancestry coin contributions are provisional carryovers from the initial draft. Existing ancestry coin values remain unchanged; no economic derivation is claimed. The comparison-size paragraph is a narrowly scoped proposal to make Under Their Noses usable across the roster, not a new set of reach, damage, equipment or encumbrance modifiers.

## Source and presentation

The ten linked entries in [the index](ancestry.md) and their linked traits are the exact draft text for review. Ten introductions and fifty traits are included. Human and Halfling gain narrative expansion only. Existing dwarf trait mechanics remain unchanged. Existing elf trait mechanics remain unchanged; Grace of the Elder Folk replaces the descriptive example “long strides” with “quick footwork.” All twenty existing trait IDs remain stable. Existing approval does not imply approval of the thirty new traits.

High Elves now express strength, concentration, precise work, low-light sight and personal memory. Deep Dwarves express bounded dark sight, contact-based vibration sensing, orientation, breathing endurance and narrow-space movement. Gnomes have actual invention and repair permissions plus a fey perception trait. Goblins emphasize salvage, teamwork, escape, negotiation and reactive footwork. Mechanical overlap is permitted when fiction and use differ; the earlier absolute ownership contract is retired as a draft constraint, not retained as an approved rule.

Tallfolk reach is bounded to one Main Action melee attack per turn; interception uses a Reaction before the roll. Small Target supports player defense rolls and the player-versus-player exception. Oath-Bound inheritance is visible and voluntary; it grants no compulsory allegiance or universal social rejection. Its cost exchange has an immediate HP payment so an unused promised Bane is not free power. Daily abilities use the existing once-per-day convention.

Each ancestry receives one complete page with its narrative, illustration, starting values and all five traits. New art uses transparent groups of three adult individuals to make ancestry morphology visible without assigning a compulsory class. Original scenic ancestry art and old cutouts are preserved. Exact new prompts and output paths are saved in `player-book/art/ancestry-expansion-prompts.json`. Bruce additionally requested the shared ten-person comparison illustration at the opening of the section; its prompt and left-to-right key are in `player-book/art/ancestry-lineup-prompt.json`. Prompt heights are art-direction proportions, not proposed numerical height restrictions for characters.

## Review questions and limits

- Hill Dwarf versus Mountain Dwarf remains a naming choice; Hill Dwarf is retained provisionally.
- Confirm the starting values, especially High Elf, Deep Dwarf and Tallfolk, and the provisional new coin values.
- Confirm the stature comparison; no broad Size subsystem is introduced.
- All new trait strength, range, action timing and frequency remain playtest estimates. Successful builds do not establish balance.
- Confirm Tallfolk and Oath-Bound identity and their artwork; their details have less direct creative guidance than the other additions.
- Elf/Dwarf ancestry label and file mappings require downstream migration before any release. Existing trait IDs are preserved, but that alone does not migrate ancestry documents.
- Foundry/Workshop compendia, automation and release are not part of this draft. Use the final approved source revision for later work.

Validation and rendered-page evidence are recorded below after the build.

## Validation — November 3, 2026

- Player’s Book built with Typst 0.15.1: 263 pages, 10 ancestry entries, 50 traits, 427 abilities. Player PDF audit passes with no errors: all fifty complete trait rule texts present, source hashes current, no missing art, no duplicate illustrations and no out-of-bounds words.
- DA companion assembled and built: 311 pages. Its PDF audit passes with no errors, 192 creatures, 126 monster abilities, 73 summons and 280 wound rows. No DA source content was changed.
- Scoped ancestry source checks pass: ten entries each link exactly five unique traits; all fifty IDs and backlinks resolve; all twenty pre-existing trait IDs remain unchanged. Comparing existing trait rule bodies finds only the documented Grace of the Elder Folk descriptive example change.
- Visual review: all twelve ancestry-section pages inspected as a contact sheet; full-size checks of the opening lineup and the dense Gnome and Oath-Bound pages. Narratives, illustrations and complete traits fit on each ancestry page. Final exported opening and final ancestry page inspected again after PDF optimization.
- All nine new images have real alpha transparency. Original scenic ancestry illustrations and existing cutouts remain preserved. Built-in image generation used; exact prompts and destinations are in the two art manifests above.
- `git diff --check` passes. No corpus-wide review, balance simulation, deferred UNI-01 work, Foundry implementation or release performed.

### Local review copies

`design/player-book/output/Heroes-of-Legend-Ancestry-Review-Draft.pdf` is the twelve-page excerpt, corresponding to full-book PDF pages 11–22. `design/player-book/output/Heroes-of-Legend-Players-Book-Ancestry-Review-Draft.pdf` is the full 263-page review book. Generated PDFs are ignored build outputs; rebuild from this branch to reproduce them. The draft title page and ancestry opening both identify review status. Release version remains unchanged.

## Vision direction — November 3, 2026

Bruce established [vision rules](rules/vision.md) during review of Starlight Eyes: complete darkness prevents sight for everyone; low light imposes 1–3 Banes on observation and vision-dependent actions; Low-Light Vision ratings ignore that many low-light Banes. Starlight Eyes is revised to Low-Light Vision 1, awaiting review of the revised full trait. The earlier unlimited dim-light benefit and Deep Dwarf darkness sight are superseded proposals.

Bruce also specified an optional mountain-dwarf trait granting Low-Light Vision 1 and an optional Deep Dwarf trait granting Low-Light Vision 2. Queue those changes for their own trait review. The five-choice surface-dwarf roster currently has no vision trait, so its replacement/addition remains open. “Mountain dwarf” does not by itself settle the pending Hill/Mountain naming decision.

Nonvisual perception categories identified: sonar, seismic, thermal and spiritual. Proposed additional categories for discussion: scent and magical perception, with electrical sensing a possible specialist creature sense. These suggestions are not approved abilities. Scope, range and targeting permissions need individual wording. Include the new shared rule in book teaching and check conflicting draft vision grants at the review checkpoint. Current review PDFs predate this decision.

### Seismic Vision revision under review

During trait 7/30, Bruce requested simplifying The Stone Tells You to a Seismic Vision grant with a range of 6 squares. The revised trait proposes Passive timing. A shared Seismic Vision definition still needs review of what it detects, how contact works and how the information supports targeting. The old three-square Maneuver/stationary/turn-end text is superseded draft material, not an approved shared definition. Exact revised trait remains proposed until Bruce’s final decision.

## Required checkpoint — vision rules in both books

Bruce explicitly requested this plan during trait 7/30: abilities should reference the rules, and vision rules must reach both rule books during this process. Complete this checkpoint before generating the next review PDFs and before declaring the ancestry pass complete.

- [ ] Finish the shared reader-facing definitions in `design/rules/vision.md`: complete darkness, 1–3 low-light Banes, Low-Light Vision ratings, and Seismic Vision. Bring unresolved Seismic Vision detection/contact/targeting details back to Bruce for review. Other senses used by this pass need an approved definition before their abilities are finalized. Additional suggested sense categories remain proposals.
- [ ] Include the shared source in the Player’s Book’s Playing the Game material, with a registered source label and working references. Use the existing builder’s shared-reference pattern; remove design-review metadata from reader-facing rendering.
- [ ] Include the same shared source in the DA book through `design/da-book/source-manifest.json` shared sections, alongside hazards/environment guidance. Keep one canonical rule definition rather than separately authored versions.
- [ ] Ancestry traits and abilities state the sense grant and its rating/range, referencing the common rules. Shared detection, targeting and light behavior belong in the shared rule. Add a short usage example in the rule section.
- [ ] Check the affected ancestry text and related sense references for contradictions with the approved rules. Show any new mechanics requiring decisions; no silent bestiary rebalance or unrelated ability review.
- [ ] Build both books, verify shared-rule text and links in both PDFs, inspect rendered rule and ancestry pages, and regenerate the full review book and ancestry excerpt. Record completion in this plan and `review/NEXT_ACTION.md`.

This is a required deliverable, not a postponed downstream task. Foundry implementation and release remain outside authorization.
