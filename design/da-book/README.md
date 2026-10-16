# Dungeon Architect’s Guide & Bestiary

Construction plan approved by Bruce; source map established October 16, 2026.
This is a world-agnostic companion to the Player’s Book, for running adventures
from levels 1–10. The immediate goal is useful guidance and complete table
references, followed by a readable Typst book in the established Great Library
style. This directory is the authoring workspace, not a finished manuscript.

## Reading order and source inventory

| Chapter | What the DA needs | Existing source / writing required |
|---|---|---|
| 1. Becoming the Dungeon Architect | Prepare a first session, agree on tone, share the spotlight, understand HOL’s rhythm. | New practical prose grounded in [foundations](../rules/foundations.md). |
| 2. Running the Game | Decide when to roll, establish consequences, interpret outcomes, run exploration and social scenes, enter and leave turns. | [Session resolution](../rules/session-resolution.md), [foundations](../rules/foundations.md), [conditions](../rules/conditions.md), [Stability](../rules/stability.md). Author worked examples. |
| 3. Building Adventures | Turn motives, places, clues and consequences into playable situations. | New guidance and a short adaptable adventure with several approaches; no required setting. |
| 4. Places and People | Build a settlement, routes, ruins, factions and memorable NPCs. | New prompts, examples and worksheets. Present worldbuilding choices without prescribing a cosmology or pantheon. |
| 5. Building Encounters | Use party size, level, CV, roles, terrain and objectives; judge danger and escape routes. | [Encounter rules](../rules/encounters.md), [bestiary encounter guidance](../bestiary/encounters.md). Author worked encounters, including mixed levels and parties other than four. |
| 6. Hazards, Traps and Environmental Challenges | Show warning signs, triggers, consequences and ways to intervene. | Existing actions and conditions; new hazard entries and examples. Use established rolls/progress rather than a separate resolution system. |
| 7. Treasure and Rewards | Choose useful rewards, explain availability, trade, resale, special equipment, recipes and curses. | [Market](../market.md) and its linked equipment/recipe catalogs. Author reward-placement guidance without asserting an untested wealth progression. |
| 8. Campaigns and Lasting Consequences | Handle milestones, safe places, downtime, wounds, Grit, Last Words and replacement heroes. | [Recovery](../rules/recovery.md), [wounds](../rules/wounds.md), [foundations](../rules/foundations.md). Author campaign examples; no prescribed encounters per day. |
| 9. Using the Bestiary | Read a creature at a glance, run its actions, reveal information, distinguish ordinary creatures from summoned forms. | [Procedure](../bestiary/procedure.md), [card layout](../bestiary/card-layout.md), [summoning](../rules/summoning.md). Add an annotated card. |
| 10. Bestiary | Find and run any of the 192 creatures. | [Roster](../bestiary/roster.md), [families](../bestiary/families.md), authored creature files. Alphabetical families with variants together; index every creature individually. |

## Appendices

- **Creating and adapting creatures:** the CV estimate, its assumptions, monster
  ability selection and validation. Keep design worksheets away from combat cards.
- **Monster abilities:** all 93 entries from the separate
  [monster catalog](../monster-abilities/README.md). Creature cards retain complete
  usable effects; the appendix must not become a required mid-turn lookup.
- **Table references:** encounter, NPC, location and session worksheets; conditions;
  indexes by creature name, CV, family, habitat and role.
- **Summon reference:** link all 73 approved profiles to their bestiary entries and
  explain their differences from ordinary creatures. Summoned energy forms cannot
  be healed and disappear at 0 HP.

## Rules authority and publication boundaries

Use current authored Markdown under `design/`, not legacy Quarto cards or old
simulation catalogs. The [construction decision log](../player-book/decision-log.md)
records the rulings settled before this book. Its resolved items are rules, not new
questions. Older “proposal” banners do not override Bruce’s approval of the catalog.

CV remains an estimate awaiting encounter calibration. Describe budgets as playtest
guidance; do not promise a four-round encounter or a particular wound probability.
The encounter-duration and wound-rate targets are design goals, not guarantees.
New examples illustrate the rules and do not silently add mechanics.

The released Player’s Book v16.0.0 remains intact. Its next revision needs the
approved clarifications synchronized with this book. Share source data wherever
possible, rather than maintain a second editable creature or ability catalog.

## Layout commitments

Use forest-green headers, gold rules and parchment pages, with compact bordered
cards. Put shared explanations in section introductions once. Give each chapter a
short introduction that explains how its tools help the DA.

Keep a creature’s combat information on one page or facing spread. Group attributes,
HP, Speed, Size, Armor DR, Evasion, Threat, Stability and damage defenses together.
Show defense attributes and every outcome’s damage and conditions in action tables.
Creature names include CV. Put descriptive text before statistics and design notes
in the appendix. Small creatures can share a page; complex creatures need room.

Keep short tables together, balance ending columns, and leave padding after art.
Use diagrams where positioning needs explanation. Mix unique landscapes, lairs,
objects, symbols and transparent character cutouts; do not repeat an illustration
within this book. Art supports the page’s subject, not just its empty area.

## Construction sequence

1. Draft chapters 1–4 and the adaptable adventure; verify all examples against rules.
2. Draft encounters, hazards, rewards and campaign guidance with worked examples.
3. Build the annotated creature introduction and assemble the full catalog directly
   from its Markdown sources, including ability and summon references.
4. Adapt the Player’s Book Typst design; add navigation, indexes and worksheets.
5. Inspect rendered pages for card/table breaks, density, repeated prose, art fit
   and usable references. Run design and bestiary audits, then book-specific checks.

Each stage uses focused issues and reviewable PRs. Encounter simulations are a
separate validation task; compiling the book does not establish balance.

## Reference approach

Pathfinder Core Rulebook, Gamemastery Guide and Bestiary inform organization:
practical running advice before construction tools, an introduction to creature
statistics, families with variants, and useful indexes. HOL’s prose, examples,
mechanics and setting assumptions remain its own. See the existing
[bestiary research](../bestiary/references.md) for creature reference work.
