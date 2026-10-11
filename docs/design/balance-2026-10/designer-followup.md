# Balance review: designer follow-up

October 11, 2026. Tracks #1119; follows the [balance study](README.md) and
[creation review](creation-review.md). This is a design record, not a replacement
for the canonical chapters. Decisions here supersede conflicting study inputs
for future tests; saved results retain their original assumptions.

## Combat decisions and hypotheses

**Accepted:** A player AoE uses one roll with the worst applicable Boon/Bane
situation among its affected targets. Apply that outcome to all affected targets;
resolve their individual resistances separately. An NPC AoE gives each affected
player their own defense roll. Example: targets in the open, partial cover, and
heavy cover mean the player uses the heavy-cover situation for the shared roll.

**Designer goals, not requirements:** In an even, typical four-round encounter,
the reasonably prepared party's chance of at least one new wound should be about
20–30% without a healer and 5–15% with one. Baseline preparation still needs to be
specified, including potion access and positioning.

**Accepted direction:** Player and enemy healing use the same rules. Test the
underlying damage/healing relationship before solving enemy healing with a
separate restriction. Casting beside an enemy should provoke an opportunity
attack; Bruce also identified standing, stowing, and retrieving items as
provoking actions. The complete trigger list, precise reach/timing language,
and whether a hit interrupts an action remain unresolved. Reaction Counterspell
is an idea for discussion, not an adopted card.

**Damage hypothesis:** Ordinary damage after resistance may be too small relative
to HP and repeatable healing. Raising only Strong damage may not address ordinary
combat pressure. Better outcomes can add damage, conditions, push, pull, prone,
throw, repositioning, or other card-defined effects. These are not limited to
ongoing conditions. There need not be one damage progression for every attack.
This direction is under discussion; replacement damage numbers are not approved.

Bruce's illustrative Burning Hands: 3/3/5 damage, Standard also Burning 1,
Strong also Burning 2. This is explicitly not a designed card. Against fire
resistance 2, immediate damage is 1/1/3; either initial Burning rating deals 1
damage per tick under the current resistance/minimum rules. Healing does not
remove Burning. Effects can consume actions or change positioning even when
their immediate damage is small. Requiring bookkeeping on every attack is not
the goal; simple damage attacks should remain viable.

Bruce wants basic attacks capable of at least 2 damage on Strong against the
armor concern raised in the study. Assistant suggestion 1/2/5 achieves this
against resistance 3, but is **not approved** and does not ensure 2 against every
resistance. The scope of that floor remains open.

Next baseline tests exclude Grapple, Dazed, summons, and free-attack cards.
Isolate revised damage first; test casting opportunity attacks separately.
Higher damage may restore pressure, but could also increase healer dependence
or sudden knockdowns. Measure wounds with and without a healer, not duration
alone. No new simulation results are claimed by this document.

## Character creation: accepted directions

- **Design mantra:** Crunchy, strategic character creation and development;
  simple gameplay at the table. Suggested builds and shopping lists assist
  players without limiting their choices.
- **Catalog reset:** Archive the legacy catalogs as historical material and
  rebuild from the agreed foundations. Do not treat old origin pairs, traits,
  classes, signatures, disciplines, or cards as validated content. This decision
  is recorded here; physical archival and replacement of chapter content are
  separate implementation work, not completed by this note.
- **Equipment:** An ability requiring and granting an ordinary melee weapon
  does not grant another if the character already owns the required basic item.
  Apply the same principle to ranged weapons and later training acquisitions.
  Several attack cards can reference one physical weapon; count that item once.
  After creation, describe its appearance. Specialty requirements may require
  different equipment. Ordinary appearance adds no combat mechanics.
- **Crafting:** Purchasing a crafting card grants a choice of recipes from its
  applicable recipe list. Number and eligible recipes remain to be designed.
- **Presentation:** Cards have types and a separate action designation: Main
  Action, Maneuver, Reaction, Movement, or Passive. Multiple types are possible.
  Actual type vocabulary remains to be agreed. All learned cards remain usable.
- **Development cheat sheet:** Show level-0 grants, 10 DP, duplicate compensation,
  expenditure and expiry; then level-1 class grants/pricing, 10 DP, expenditure
  and expiry. Explicitly prohibit buying disciplines at level 0. Show banked DP
  only from subsequent advancement. Any attribute-based DP rule must be added
  only after its timing and formula are agreed.

Equipment example: three acquired cards each require/grant a melee weapon. With
one ordinary melee weapon already owned, later cards grant no extra weapon.
All three may use that item if compatible. **Accepted clarification:** an ordinary
melee weapon is 1 Bulk and an ordinary ranged weapon is 1 Bulk. Count each
physical item once, regardless of how many compatible cards use it. Attack
cards do not assign conflicting bulk values to the same ordinary weapon.
Bruce expects very few bulk-2 items and currently identifies no equipment
example requiring that category; do not invent heavy-weapon exceptions.
No repeat acquisition grant is implied if the item is later sold or lost.

Recipe proposal, **not adopted**: each crafting card grants two compatible
ordinary recipes at acquisition. They should be usable with attainable tools
and materials, and should not automatically grant rare or magical recipes.
Exact recipes depend on the rebuilt catalog. Recipe access alone does not grant
materials or tools unless the card explicitly says so.

Presentation proposal, **not adopted**: organize learned cards by primary
function—Attack, Defense, Recovery, Control, Exploration, Social, Crafting—and
use Magic and equipment-related descriptors as additional tags. Keep the
action designation independent. A magical healing card could be Recovery +
Magic, Main Action. Filter first by available action at the table; keep a small
universal-action reference separate from the full catalog. Test vocabulary
against actual cards before fixing categories.

## Mental attributes and DP: next decision

Bruce proposes DP bonuses from Knowledge, Reason, and Guile, because physical
attributes already supply HP, movement, capacity, and common combat rolls.
Class attribute minimums are another suggestion, not an adopted restriction.
The need to make mental attributes valuable is accepted; the DP formula and
award timing are not settled.

Mental attributes must also matter when using cards and defending against
appropriate threats. A caster rolling Knowledge, Reason, or Guile already has
a reason to invest in that attribute. The catalog must make those uses explicit
and well distributed. DP alone could otherwise reward a mentally gifted
warrior while leaving a caster's actual spells indifferent to mental ability.

**Assistant proposal for discussion:** At level 1, add
max(0, Knowledge + Reason + Guile) DP, using permanent creation attributes.
Apply once, with the normal level-1 spend-or-lose rule; retain level-0 10 DP
and later 8 + level awards. This is a bounded starting experiment, not approval
of a permanent advancement advantage. Temporary items and curses would not
alter the calculation under this proposal.

| Mental attributes | Sum | Proposed extra level-1 DP |
|---|---:|---:|
| Knowledge −1, Reason −1, Guile −1 | −3 | 0 |
| Knowledge +2, Reason 0, Guile 0 | 2 | 2 |
| Knowledge +1, Reason +1, Guile +1 | 3 | 3 |
| Knowledge +2, Reason +2, Guile +2 | 6 | 6 |

With six attributes totaling +3, physical +2/+2/+2 requires mental sum −3.
Conversely, mental +2/+2/+2 requires physical sum −3. A +6 recurring bonus over
levels 2–10 would add 54 DP beyond the existing 126 DP—about 43% more. A one-time
bonus creates less divergence. Summing before flooring also avoids ignoring
negative mental attributes. Whether that treatment matches Bruce's intent is
still a design question. No class minimums are proposed for adoption until the
card attributes and these incentives have been reviewed.

## Provisional HP and Speed fixtures

Bruce authorized initial values for testing, subject to revision. These are
HOL design choices, not claims that Tolkien supplied numerical game statistics.
The literary starting points are the peoples of *The Hobbit* and *The Lord of
the Rings*: sturdy dwarves, capable elves, humans as a reference, and small but
resilient halflings. Avoid equating small stature with helplessness or making
elves automatically frail. The Tolkien Estate's
[overview of The Hobbit](https://www.tolkienestate.com/writing/john-d-rateliff-the-hobbit/)
provides literary context, not mechanical justification for these numbers.

Use **base HP 12** plus ancestry, class, Fortitude, and any chosen trait/card.

| Ancestry | HP contribution | Base Speed (squares) |
|---|---:|---:|
| Human | +2 | 6 |
| Elf | +2 | 6 |
| Dwarf | +4 | 5 |
| Halfling | +1 | 5 |

| Sample class | HP contribution |
|---|---:|
| Protector | +6 |
| Blade | +4 |
| Arcanist | +2 |

Examples before traits: dwarf Protector with Fortitude +2 has 24 HP; human
Blade with Fortitude +1 has 19 HP; halfling Arcanist with Fortitude −1 has
14 HP. This gives a 10-HP spread without level-based HP growth. Final Speed
remains ancestry base + Agility − encumbrance, minimum 0. An elf with Agility +1
and no encumbrance has Speed 7; a dwarf with Agility 0 has Speed 5.

These fixtures do not establish class or ancestry balance. Trait benefits,
signature cards, required equipment bulk, and mental-attribute incentives remain
to be tested. In particular, full-HP healing restores more HP on the durable
character, and increasing enemy damage could disproportionately endanger the
14-HP character. Include both in the next damage tests.

## Work still required

1. Agree DP bonus timing/formula, then decide whether class minimums are needed.
2. Apply the fixed 1-Bulk weapon rule and define recipe grants in actual crafting cards.
3. Inventory and archive the old catalogs with a manifest; rebuild a small
   starting catalog, not hundreds of inherited cards.
4. Build creation/development references and action/type card views against
   that catalog; audit each starting build's capacity and usable grants.
5. Run the revised damage tests using these HP/Speed fixtures and agreed DP.

The original creation ledgers remain illustrative historical tests. They have
not been rebuilt or certified under the proposals in this follow-up.
