# Contextual editorial review of both books

Book issue #1349 continues the narrower #1347 pass. Workshop/Foundry follow-up is
bruceamoser/heroes-of-legend-foundry#322. This review changes reader guidance and
placement, not the approved progression or encounter-balance numbers.

## Editorial test

Read a passage in its surrounding section and identify the reader's question.
Does it help someone imagine a hero, choose an option, resolve an action, prepare
a session or find a rule? If it explains how the catalog was constructed or why a
revision was made, translate its useful content into an instruction or example.
If no reader guidance remains, remove it. Move useful procedures to the chapter
where readers will need them. Prices and prerequisites stay beside choices.

Negative wording is not an automatic failure. Restrictions on targets, action
costs, repeated benefits, resurrection, resource transfers and player agency are
necessary rules. Fiction, character prompts and useful DA adaptation advice stay.
Searches locate candidates; they do not replace reading context.

## Coverage and dispositions

| Material reviewed | Disposition |
|---|---|
| Player chapters 1–2 and starting HP/SP/coin references | Rewrote the welcome's design promise as player choices. Retained creation arithmetic and local requirements. Recast the purse explanation around departure savings and gifts. |
| Ancestry, culture and background introductions and catalog narrative | Retained descriptive identity and character prompts. Repaired the introduction's obsolete level-0/paired-grant instructions to match chapter 2 and corrected the language reference's obsolete pair wording. |
| All ten class introductions and signature/basic-action narrative | Retained roles, concrete scenes and prompts. Kept selection rules and specific action limitations. |
| Learning, all discipline introductions and generated chapter/directory text | Recast armor progression using actual ability names; rewrote Athletics, Craft, Scholarship and Subterfuge guidance. Retained local prices and level gates. Removed Markdown link syntax from the plain-text learning renderer. |
| All 29 spellbooks' 319 effect paragraphs and shared magic chapter | Most already describe casting and effects. Removed Power Shock's book-construction aside and Detection's vague reference to stronger pages. Recast Hold/Escape explanation and zone entry guidance as instructions. The editorial pass preserved spell numbers and actions; the subsequent user-requested mechanics review #1350 is recorded separately in spell-procedures-1350.md. |
| Player chapters 6–9 and condition reference | Clarified longer work times. Moved objectives/social progress into Beyond the Battlefield before group checks. Kept recovery in Harm and Recovery. Retained action, immunity, condition and survival limits. |
| Player equipment/recipe chapters, market and item/recipe introductions | Replaced revision history and repeated “no ability granted” table wording with purchasing guidance. Recast recipe reuse and first-aid supplies positively. Kept inventory, price, resale and crafting restrictions. |
| Player summon chapter, selection reference and summon narrative | Rewrote the opening around choosing a permitted companion and using its profile. Retained command, tether, healing and disappearance rules. |
| Player examples, reference pages, captions and generated introductions | Retained ready-to-play and lookup content. Recast the ancestry lineup caption as an invitation to picture the hero. |
| DA chapters 1–4 and language guidance | Recast the game's strategic design statement as advice for presenting useful situations. Integrated objectives/social progress in Running the Game. Kept adventure preparation, motives, clues and campaign-language choices. |
| DA chapters 5–8 | Replaced “seed,” “test,” certification and manuscript-status prose with encounter preparation and reward guidance. Kept CV estimates and the numerical budget. Replaced the Recovery number sequence with the learned ability's instructions. Explicitly stated level HP/SP gains where an absent “above” reference had been used. |
| DA chapters 9–10 | Recast family taxonomy as advice to read the chosen creature. Corrected collision-example arithmetic to the existing zero-damage rule. |
| Bestiary narrative and encounter/loot guidance across all 192 creatures | Retained signs, motives, tactics and adventure hooks. Rewrote repeated loot boilerplate as preparation instructions, removed Black Pudding's future-card aside, and recast two hoard proposals as encounter loot suggestions. Stats and CV ledgers unchanged. |
| DA appendices A–D, monster-ability and summoned-profile introductions | Kept practical creature adaptation and CV calculation because the DA can use them. Rewrote the template-construction introduction into outcome-conversion instructions, summon selection into a usable procedure, and the worksheet's “next test” prompt into next-encounter preparation. Removed Breaking Roar's design-rationale sentence while preserving its one-target limit. |

## Representative decisions

- “This pass preserves those existing values” tells a reader about editing. The
  market now explains d4 healing supplies, their differing potency and when to
  check the die.
- “Standard CV seed” becomes an initial encounter budget. The budget is still an
  estimate; no calibration or balance conclusion was added.
- “What it does not supply” in the reward table becomes “Prepare for play,” with
  the concrete information the DA should give for each reward.
- “Third step/fourth step” in the Armor introduction becomes Light Armor III and
  Heavy Armor I. The actual requirements and resistance values remain visible.
- “1/2/3/4/6/8/12 SP across the seven steps” in campaign prose becomes using the
  hero's learned Recovery ability. The ability entries retain every value.
- One-target, command and resource restrictions remain where they answer a real
  resolution question. Their presence does not make a passage design exposition.

## Objectives placement

`design/rules/objectives.md` is the shared canonical procedure. The Player's Book
includes it within chapter 7. The DA guide includes it within chapter 2. Both keep
one complete social procedure and example, replacing the shorter overlapping
summaries. Learning points readers to play and recovery procedures instead of
interrupting discipline selection with those chapters. Both PDF audits check every
shared objective paragraph. The DA source manifest records the inline placement.

## Validation

Passed the complete two-book starter-kit pipeline: catalog, bestiary, artwork,
repository-link and 272 worked-example checks; DA assembly consistency; both PDF
coverage/link/layout audits; PDF entry checks. Shared objectives are complete in
both PDFs. Compared all 87 edited creature records: numbers/stat fields unchanged;
all edited discipline entry bodies unchanged. Visually inspected Player creation,
learning, adventure, market and summon pages, plus DA objectives, turn procedure,
treasure, advancement and a representative creature page. No clipped or overlapping
content found in the inspected pages. Final spell spread validation is in #1350's
review record. `git diff --check` passes.

Generated PDFs are local proofs; this task does not update a public release or
deploy the Workshop. The old standalone health-revision audit has a stale class
schema check and was not used as evidence; the required current pipeline passed.
