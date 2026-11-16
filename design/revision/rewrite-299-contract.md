# Character progression rewrite — implementation contract

> Implementation update, November 16: the approved nonmagical costs are **1/2/2/3/4/4/5 DP** (21 total). Current canonical sources implement this rewrite; any earlier candidate below records design analysis.

Date: November 15, 2026. Authority: Bruce's discussion after the thirteen trope Build-Offs, including his explicit authorization to begin the books and Workshop rewrite. Tracking: [source #1328](https://github.com/bruceamoser/heroes-of-legend/issues/1328), [delivery #299](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/299). This contract records approved direction and separates authoring choices from settled rules. It is not yet the replacement player manuscript or a claim of implementation.

## Delivery order and protected baseline

Complete the Player's Book, Dungeon Architect's Guide and published Character Workshop before implementing this revision in native Foundry. Shared code/data changes used by the Workshop must not silently update native packs, Actors, migrations, sheets or automation. Revisit the native boundary when the web experience and content have been reviewed.

Source starting revision: `d4d4b79` in the book repository. Published Workshop baseline for the Build-Offs: `27200945e033ca3d2e9eabeed312d9ed0f7911a1`; comparison documents merged at `3a3313ed86b781d9c0387b1ca1110d1ecb2dde8d`. These deliberately differ: the browser already contains later approved creation/resource rules. The rewrite must reconcile those into the authored source instead of importing the older book over the app.

Protect the roll mechanic, always-hit attacks with minimum 1 except immunity, player-only rolls, conditions and decay, action economy, descriptive scars and existing recovery decisions. Preserve tactical interaction between terrain, forced movement and hazards. Encounter/CV calibration remains pending playtesting; this rewrite does not tune creature budgets. Keep both books' forest-green/gold/parchment, two-column format, discipline tokens and two-page spellbook spreads, using existing artwork appropriately.

## Ancestry

A chosen trait expresses a physical, personality, arcane or divine characteristic. Its description carries a useful, generally modest mechanical benefit and, where fitting, a natural drawback or side effect. Low-light eyes that glow and impose a Bane to hiding in darkness are the agreed example. Not every trait needs both a numerical benefit and a penalty. A descriptive trait is not automatically separate from a mechanical trait.

Retain two selections from five traits per ancestry unless a later explicit decision changes that count. Avoid universal hostility or mandatory personality behavior as a numerical balancing payment. Test frequency of benefit and drawback in the same character's actual play. Compare whole ancestry HP/SP/coins/Speed packages as well as individually borrowable traits. A borrowed trait keeps its associated drawback; borrowing does not import the donor ancestry's resources.

## Signatures

Signatures establish class-defining capabilities beyond the value of an ordinary learned ability. Value can be permission, reliability, flexibility or a distinctive play loop, not only damage. They should not render the discipline branches pointless.

One free signature choice at level 1, one at level 3 and one at level 7 remains the total grant schedule. At each later milestone, the player may develop an existing signature or select a new signature appropriate to that milestone. An upgrade consumes that milestone's choice, replaces/improves the selected line as written and does not also award an extra free signature. Earlier-line requirements must be visible; switching a prerequisite must resolve dependent upgrades rather than leaving unusable selections. A detailed retraining implementation belongs in #304, preserving the existing right to switch signatures.

Use the Build-Offs to allocate missing fantasies, rather than introduce thirteen D&D class copies. General unarmed development belongs in shared learning; a protector's healing touch, animal transformation, persistent magical inventions and patron relationships are candidates for signature lines. Existing Mend and other useful mechanics must be considered before creating redundant substitutes. Every magical signature explicitly identifies whether it is a spell, another magical effect or ordinary action, and states its sustain/cancellation interactions.

## Seven-purchase nonmagical branches

| Position | Function | Minimum character level | Atlas shape |
|---|---|---:|---|
| 1 | Establish capability | 1 | Circle |
| 2 | First improvement | 1 | Circle |
| 3 | Second improvement | 1 | Circle |
| 4 | Major branch development | 3 | Triangle |
| 5 | First improvement to that level-3 development | 3 | Triangle |
| 6 | Second improvement to that level-3 development | 3 | Triangle |
| 7 | Mastery | 7 | Diamond |

Learn in order. The first three entries improve one established capability. Entries five and six improve the fourth entry. Each improvement states whether it adds a benefit or replaces an earlier value. Mastery is a substantial expression of that branch, not a generic extra +1. The south branch can vary the ability/improvement pattern, but retains the milestone gates. Gates other than 3 and 7 are not introduced.

The four branches have consistent roles: north primary Main Action; west complementary Maneuver; east Reaction; south wildcard completing the discipline's fantasy. Reactions include social, exploration and crafting responses, not only combat. Each noncombat Reaction specifies an observable trigger, timing, actual result and a usage boundary appropriate to the activity. A fresh six-second round is not an unlimited reset during one long negotiation or work attempt. Work that takes minutes or hours prints its actual time.

The outer advanced ring contains each branch's own entries five through seven, with an unambiguous tail from its level-3 endpoint. Proximity is not a prerequisite. Remove cross-discipline intersection purchases and all two-/three-/four-discipline endpoint qualification requirements. Review the former combined abilities one by one: retain useful concepts by placing them in appropriate masteries, signatures or spells; do not simply erase mixed martial/magical character possibilities.

Magical disciplines retain four themed spellbooks and their separate progression. A themed book may contain Main Action, Maneuver, Reaction and Ritual spells. Spellcraft is mixed: Soul Capacity, Mind Capacity and Recovery are training branches, while Channeling is a spellbook. Do not convert spellbook sections to seven-step martial abilities merely to make the map symmetrical. Exact Spellcraft placement/content follows the mixed layout and must remain understandable in the list and book.

## Price and income contract

Creation is one level-1 process. Two ancestry traits; one discipline choice each from culture, background and class, giving three distinct starting disciplines; one signature. Origin dropdowns show their available disciplines. Starting DP is 8 + Guile + Knowledge + Reason, including negatives and explicit benefits. Later levels award 4 + the new level DP. Class determines the 1/2/3-DP price for an additional discipline. Entry plus useful first learning is the relevant breadth cost, not entry alone.

The [reproducible DP analysis](https://github.com/bruceamoser/heroes-of-legend-foundry/blob/795a926/docs/rewrite-299-dp-budget.md) compares three price curves. The first four branch costs currently are 1/2/2/3 DP. The three advanced costs are an authoring decision to be calculated before application, not an already approved numerical rule. Model affordable deep and broad characters at levels 1/3/7 using legal attributes and all thirteen existing Build-Offs. Include the cheapest and most expensive class entry prices, origin-grant advantages, saved DP, talents and spellbook costs. Retain original Build-Off documents as the historical comparison baseline and create explicit revised fixtures.

The browser's current HP/SP/coin distributions, 2x positive associated mental attribute class SP, +2 maximum SP after level 1, and lifetime Grit schedule must be reconciled with the books. Do not resurrect staged DP pools, flat discipline entry cost, fixed ancestry SP, class SP3, short-rest hit-dice pools or SP maintenance charges.

## Duration, direction and Sustain

A fixed-duration effect continues without a maintenance action. A directed effect can continue in place but names an action to reposition or manipulate it. A sustained effect requires a Maneuver and 0 SP to maintain; retain the current single-sustained-spell limit unless a reviewed specific exception says otherwise. Do not introduce routine concentration saves or a second maintenance subsystem.

Moonbeam is the agreed example of a visible, avoidable hazard: fixed duration, one active beam per caster, Maneuver to move it. Confining terrain and forced movement can make that beam more effective; these are intended tactical opportunities. State damage timing and repeat-trigger limits in the spell. Do not remove those strategies as an incidental balance fix.

Maintained control attached to a creature, such as Hold Person, uses Sustain and gives an explicit escape procedure. The casting attribute is not automatically the escape attribute. Every affected spell names separately:

- casting attribute;
- initial player defense attribute against an NPC caster;
- player-caster attribute when an NPC attempts to escape;
- player-target attribute when that hero attempts to escape.

For example, a spell may be cast with Reason yet require Agility to struggle out of it. The caster's attempt to keep its magical grip is its own explicitly named roll. Do not make an NPC roll, or make the player's caster roll the NPC's Agility. Attribute choices depend on the fiction of each spell; this example does not globally assign Entangle's finished profile.

A conscious held target spends a Main Action to attempt escape. This permission overrides restrictions from the hold itself, not separate unconsciousness. Against a player caster, that player rolls the spell's named resistance-to-escape attribute; Weak releases that target. Against an NPC caster, the player target rolls the named escape attribute; Strong releases that hero. This reactive caster roll costs the caster no action. The effect explicitly permits this attempt despite its restrictions on ordinary actions. Other unused actions remain available when released. One target's escape ends only that target's hold. NPC-only exchanges use the existing DA procedure.

This is a specific spell remedy, not a revision to physical Grappled 3. Sustaining and a target attempting escape are distinct events. Do not demand an escape roll automatically every round or charge the caster SP again.

Shield is intended as a 0-SP Reaction comparable to ordinary shield protection. Final authored coverage, trigger, hand requirement and protection interval must account for the current difference between Shield Block (through next turn) and the spell (one defense plus reduction). Mage Armor is intended as self-only long-duration physical resistance without Sustain. Final duration/number changes are reviewed spell content, not inferred from their names.

## Atlas and compact interface

- Learned nodes: solid gold, with a check/state label as an additional cue.
- Learnable nodes: green outline with thick gold surround.
- Unavailable nodes: green outline; inspector explains the actual requirement.
- Circles/triangles/diamonds communicate level 1/3/7 gates, independently of ownership.
- Preserve the near-full-window atlas popup, deep zoom, mouse panning, list selection and close/return behavior.
- The normal learning view shows purchasable next steps and expands to learned history and future steps. Keep character summary, learned counts and class-priced Add discipline visible.
- Main sheet favorites remain the playable surface; spells and abilities expand inline. Use named attributes and compact roll labels, explicit SP costs and sustain status.

## Acceptance evidence

For each item distinguish authored, imported, tested, reviewed and published status. Compilation is not balance evidence.

1. Source audit finds no obsolete active creation, price, sustain or intersection instructions; cross-links and stable-ID mappings resolve.
2. Both books build with consistent rules and are visually inspected, including the seven-step layouts, class upgrades, spell spreads and DA escape examples.
3. Workshop validates all gates, affordability, signature dependencies, removal/replacement of intersection nodes, explicit casting/escape displays, saved-character repair and resource preservation.
4. Browser testing covers new creation and existing imports, list/atlas parity, all three node shapes/states, deep zoom, traits, signature development and favorite actions at realistic Foundry window sizes.
5. Revised Build-Offs cover all thirteen tropes at level 1; representative depth/breadth and signature development are exercised at levels 3/7. Player tests record identity, decision time, agency and useful action choices, not only damage.
6. Reviewed source PR and Workshop PR link their actual revisions. Publish the two books and GH Pages; only then open native implementation against that accepted revision.
