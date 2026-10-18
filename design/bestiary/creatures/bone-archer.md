# Skeleton Archer (CV 7)

*A dry skeleton equipped with a maintained bow and a small bundle of arrows. Its stillness is absolute until an intruder crosses the lane it was ordered to watch.*

**Attributes:** Brawn +0; Fortitude +0; Agility +1; Guile -2; Knowledge -2; Reason +0

**HP:** 8 · **Speed:** 5 · **Size:** 1 (medium) · **Armor DR:** 0

**Evasion:** None · **Threat:** None · **Stability:** 0

**Weaknesses:** None\
**Resistances:** None\
**Immunities:** Bleeding; Poisoned; Asleep

## Actions

Damage and effects are **Weak / Standard / Strong player defense**. Each slash separates one complete outcome. All attacks use the printed Threat unless stated otherwise.

| Main Actions | Defense | Damage |
|---|---|---|
| Basic Melee | Agility | 4/2/1 |
| Dusty arrow | Agility | 5/3/2 |

| Maneuvers | Effect |
|---|---|
| Study the Opening | Next attack this turn: 1 additional Bane on its target’s defense. |
| Defend | +1 Bane |

| Reactions | Effect |
|---|---|
| Fall to Pieces | Before physical attack: Physical resistance 3 for it; become Prone afterward. |
| Opportunity Attack | Basic Melee |

## Details

### Dusty arrow

**Ammunition:** inventory d6. After each use, roll the inventory die; on 1, reduce d6 to d4, or d4 to empty. Cannot use this attack while empty.

**Target:** One visible creature within 8 squares. **Player defense:** Agility. **Damage type:** physical.

### Fall to Pieces

*The skeleton lets its joints collapse, spilling loose bones beneath the passing blow.*

Before a physical attack against this creature is rolled, gain Physical resistance 3 against that attack only. Use the highest matching resistance. After the attack resolves, it becomes Prone if still present, even if it was already Prone. This does not move its occupied footprint or reassemble it; standing costs the normal 2 movement.

### Study the Opening

*It waits for a tell in the stance, then turns its attention to the exposed line.*

Its next attack before the end of this turn imposes 1 additional Bane on player defense, or gains 1 Boon when player-controlled. One attack only; no stacking with itself.

### General details

**Basic Melee:** One adjacent creature; physical damage; Agility defense. Uses the printed Threat. No specialty riders.

**Defend:** Player attacks suffer 1 additional Bane until the start of its next turn. Combines with Evasion through normal Boon/Bane rules. Repeated Defend does not stack.

**Opportunity Attack:** Basic Melee against the provoking creature. Spends its Reaction before the provoking action resolves. That action continues if the creature remains capable.

**Lifeless Body:** does not breathe or eat; only the listed immunities apply.

**Healing:** Healing-harmed: ordinary healing resolves as Life damage instead; no beneficial riders.

**Against offensive healing:** controller defends with Fortitude if this is player-controlled; a player attacking it still rolls only their attack.

**Senses:** Dark sight 6 squares.

**Signs:** Arrows lie in neat bundles beneath an undisturbed layer of dust.

**Purpose:** Deny passage through a marked lane.

**Tactics and retreat:** Shoot from a narrow opening; use Defend if forced into melee.

**Counterplay and conversation:** Approach outside its firing lane or remove the command marker.

**Habitat:** Crypt; fortress · **Communication:** None

**Loot:** Ranged weapon and ammunition d6 if not expended.

**Summoning:** Undead 1 — [player reference](../summons/bone-archer.md).

## Design notes — not needed during play

**ID:** creature-bone-archer


**Category:** Undead · **Role:** Artillery · **CV:** 7

**Difficulty rationale:** No innate attack modifier; armor, cover and chosen actions provide its defenses. Ordinary attack difficulty; riders and positioning carry the threat.

**Reference damage:** 2/3/5

**Reference type:** physical

**Expected targets:** 1

**Utility factor:** 1.15

**Action review (#1279):** U 1 → 1.15: Maneuver allowance +0.05, Reaction allowance +0.1. These are provisional judgments for the changed capabilities, counting the largest increment in each category rather than adding every alternative. Reactions compete for one budget; no measured balance claim.

**Regeneration per turn:** 0

Reference I=5.000, O=2.162. CV uses the [seed worksheet](../encounters.md); action choices, Stability and control are not simulated. Recalibration remains required.

**Ability sources:** [Fall to Pieces](../../monster-abilities/fall-to-pieces.md), [lifeless body](../../monster-abilities/lifeless-body.md), [Study the Opening](../../monster-abilities/watch-the-opening.md).

[Roster](../roster.md) · [Agreed Stability](../../rules/stability.md)
