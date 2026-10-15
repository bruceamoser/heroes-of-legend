# Category summons and command-only activity

**Issue #1164.** Replace creature-specific summon profiles with bestiary selection.
Bruce approved the category approach and complete inactivity without commands.
Tier eligibility, unified one-scene duration, requirements and one creature per
casting are proposed implementations awaiting review.

## Catalog

| Category | Level 1 | Level 3 | Level 7 |
|---|---|---|---|
| Animal | [Novice](../cards/call-the-faithful-hound.md) | [Adept](../cards/call-the-hunting-cat.md) | [Master](../cards/call-the-elder-stag.md) |
| Spirit | [Novice](../cards/call-a-burrower.md) | [Adept](../cards/call-a-sentinel.md) | [Master](../cards/the-ancestors-stand.md) |
| Undead | [Novice](../cards/the-bones-rise.md) | [Adept](../cards/summon-undead-adept.md) | [Master](../cards/procession-of-the-quiet.md) |
| Fey | [Novice](../cards/a-friend-beneath-the-door.md) | [Adept](../cards/summon-fey-adept.md) | [Master](../cards/summon-fey-master.md) |
| Elemental | [Novice](../cards/summon-elemental-novice.md) | [Adept](../cards/summon-elemental-adept.md) | [Master](../cards/call-a-tempest-beast.md) |
| Construct | [Novice](../cards/summon-construct-novice.md) | [Adept](../cards/the-walking-toolbox.md) | [Master](../cards/summon-construct-master.md) |

Eleven existing creature-specific cards are rewritten; seven cards fill missing
category/tier combinations. The tiny scout becomes Novice Fey, the walking toolbox
becomes Adept Construct, and the ancestor shades become Master Spirit. Each card
summons one explicitly eligible creature. Animal, Spirit, Fey, Undead, Elemental
and Construct remain separate bestiary tags; dual eligibility must be explicit.

Stable existing IDs and file paths are retained to preserve links. Titles and
active link labels now name categories. The old creature names in those identifiers
are historical, not selection restrictions. Earlier review ledgers/hashes describe
the old versions and are not evidence of current creature balance.

## Deliberate changes to review

- All cards use Calling 1/2/3 at levels 1/3/7 and standard 2/4/8 DP prices. Former
  Burrower Wilderness and Toolbox Craft requirements are removed; category summon
  access is now consistent. No previous ability is required.
- The former two-porters and three-shades cards now summon one eligible higher-tier
  creature. This is a proposed simplification, not a newly imposed total summon cap.
- Durations become one scene rather than mixing combat/ten-minute/scene timers.
- No summon supplies permanent gear, corpses or consumables. Bestiary anatomy and
  profile determine carrying, senses, healing compatibility and interactions.
- Embedded HP, attacks and movement profiles are removed, not treated as finalized
  bestiary entries. No creature is made eligible simply by having a matching name.

## Commands

[Command a Summon](../cards/command-a-summon.md) and the
[shared reference](../rules/summoning.md) preserve paid action packages, downward
conversion, one command per summon per controller turn, the immediate new-summon
command, tether and no summon chains. Uncommanded summons do not follow, watch,
alert, attack or work. Effects already in play can expire or tick, and resistance
still applies; neither creates new activity.

Attack, guard, follow, hide, watch, aid, fetch and track are plain-language examples
of intent. Each needs the chosen creature’s actual capability and sufficient
commanded actions. A Move-and-Hide order cannot silently invent a hiding action.
An uncommanded wall of bodies can still occupy space: command limits prevent an
army of active attackers, not every possible blocking strategy. That remains a
bestiary/encounter test concern, especially with unlimited repeated summons.

**Worked timing:** Spend Main to summon. Its immediate Main command can convert its
Maneuver to movement, then attack. You cannot spend your remaining Maneuver to
command that same summon again; you could command a different existing summon.
On the next turn, leaving it uncommanded means it stays still and takes no new
activity, even if its old instruction was “follow me.”

## Remaining dependency

The bestiary must approve category/tier eligibility and supply playable summon
profiles, including action costs, controller rolls, defenses, senses and limits.
No provisional CV ceiling is invented. These cards are structurally complete but
cannot support finalized creature selection or simulations until that work is done.
The wider NPC-versus-summon defense and controller-incapacitation decisions remain
explicitly open. Pure visual spells such as A Company of Reflections are not
creatures and retain their existing effects.

## Validation

Catalog audit and whitespace checks pass: 350 cards. All eighteen category cards
contain the command-only rule, tether, tier requirements and selection limits;
none retains an embedded creature stat block. Origin grant and path tier checks
pass. Historical simulation results are unchanged and were not rerun.
