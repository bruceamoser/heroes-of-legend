# November playtest rewrite

Bruce authorized these changes in the design conversation on November 12, 2026.
Write numerical choices as playable rules, without provisional labels. Catalog
replacement and book layout must be reviewed before a new starter-kit release.

## 1. Health and survival — source issue #1306

First implementation: HP growth; death rolls on damage at 0; descriptive scars;
Grit grants at 1/3/7 with permanent expenditure for half HP; stabilization conscious
at 0 but unable to fight; overnight HP/SP recovery; limited first aid; SP-funded
healing. Both book sources, affected cards, examples, sheets and builders change
together. Foundry tracking: bruceamoser/heroes-of-legend-foundry#269.

First numerical package: base HP 10, fixed Fortitude, ancestry/class contributions
1–3 each per level; 2/4/6 basic first aid; 3/5/7 learned treatment; SP contributions
1 ancestry + 1 culture + 1 background + 3 class; healing costs 1/2/4 SP by tier.
These are explicit first-playtest choices, not claims of measured balance.

## 2. Forge development and print presentation

Retain ancestry, culture, background, class, level 0 and level 1. Both creation
stages spend DP in the Forge. Replace broad card shopping with four branches per
discipline: basic ability, minor improvement, minor improvement, better ability.
Improvements are additive and predictable, not a new choice on every hit. Branch
endpoints require level 3. Tier II/III/IV confluences require level 7 plus all
specifically connected endpoints. Select exact branch costs and DP awards with
worked level-0/1/3/7 builds, then rebuild origin grants and examples.

Print each discipline as an overview and four readable purchase tracks; show
previous node, cost, level gate and the actual change at each step. Put confluence
prerequisites in an explicit table and cross-reference them from endpoints.
Prototype one complete discipline spread in Typst before expanding the catalog.
The full atlas is a reference spread; readers must not need the website to build.

## 3. Spellbooks and Spellcraft

Use the Magic Forge prototype as the approved architectural reference, not as
completed numerical spell profiles. Elements, Life, Mentalism, Divination,
Invocation, Force and Wards each open four spellbooks. Buying a discipline grants
no spells. Connected purchases add pages 1–2, 3–4, 5–6, then 7–8 plus all three
advanced pages immediately. Each book's page 1 costs 0 SP. Each casting discipline
has an attack cantrip. Spellcraft has Soul Capacity, Mind Capacity, Recovery and
Channeling; both capacity branches increase one shared pool. Channeling draws on
Rolemaster's willing PP transfer/spell relay and labelled HOL adaptations for
unwilling transfer. Keep source notes outside concise player spell procedures.
Integrate the remaining SP advancement and spell profiles in this slice.

## 4. Martial, exploration and social branches

Study Four Lanterns Deep's actual connected prerequisites; do not copy its choices
wholesale. Favor recognizable fantasy capabilities with useful applications,
fewer active buttons and persistent improvements. Retain basic melee/ranged access
outside discipline purchase. Develop social branches alongside the encounter rules.
The DA sets the objective/progress target and decides what approaches can work;
players roll the existing HOL system for effects/progress. No separate social dice
engine or roll that dictates player-character choices.

## Completion criteria

Cross-reference audit; no contradictory old wound or development instructions;
worked character purchases; both books built and visually reviewed; readable
branch diagrams at print size; source PR and downstream Foundry issues; independent
review before merge. Do not describe unfinished slices as converted. Preserve the
existing release until the whole rewrite is ready for publication.

Bruce confirmed no Hit Dice pool. Recovery resources are time/daily treatment and SP; existing inventory supplies remain ordinary equipment, not a second personal healing reserve.
