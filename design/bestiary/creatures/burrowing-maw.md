# Burrowing Maw

*A plated burrowing predator with powerful digging limbs and broad crushing mandibles. Its segmented body is adapted to soft earth, not to tunneling through solid rock.*

**HP:** 25 · **Speed:** Ground 5; burrow 4 · **Footprint:** 2x2

## When attacked

**Evasion:** 0 (no modifier) to player attacks. · **Stability:** 1 (Heavy Frame, passive grant; not derived from size).

**DR / resistance:** Physical 2 · **Condition immunities:** None

**Weakness:** None

**Healing:** Living: ordinary HP healing applies.

## On its turn

**Senses:** Ground vibration 6 squares on connected ground; must emerge and see a target to attack.

### Plated jaws — Main Action

*A coil or grasping limb closes around the target and braces against its struggling weight.*

**Target:** One adjacent creature. **Player defense:** Agility. **Threat:** 1 Bane to that defense.

- **Weak defense:** 7 physical damage. Grappled 2.
- **Standard defense:** 5 physical damage. Grappled 1.
- **Strong defense:** 3 physical damage.

**Limit:** The holder suffers its own Grappled contribution. A new result replaces its lower contribution, not adds to it. Release freely; separation beyond reach, unconsciousness or death ends the hold.

### Closing jaws — Main Action

*The mouth opens wide enough to swallow the light behind its prey.*

**Target:** One adjacent 1x1 creature already Grappled by this creature. **Player defense:** Fortitude. **Threat:** 1 Bane to that defense.

- **Weak defense:** 7 physical damage; Blinded 1.
- **Standard defense:** 5 physical damage.
- **Strong defense:** 3 physical damage.

**Limit:** Victim stays in its square; holder keeps its Grappled restrictions. No extra damage tick or off-map stomach.

**Defend — Maneuver:** 1 additional Bane on player attacks against it until its next turn; repeated Defend does not stack.

**Basic Melee — Main Action / opportunity Reaction:** one adjacent target, Agility defense, Threat 1 Bane; Weak defense 5, Standard 3, Strong 2 physical damage. No specialty riders. An opportunity spends its Reaction before the provoking action resolves; that action continues if capable.

## Encounter cues

**Signs:** Long ridges cross the field overnight.

**Purpose:** Feed beneath soft ground without exposing its body.

**Tactics and retreat:** Emerge to bite, then spend movement to withdraw underground on a later opening.

**Counterplay and conversation:** Stand on rock and watch the moving furrows; no attacks pass through solid earth.

**Habitat:** Field; sandy valley · **Communication:** None

**Rewards:** A swallowed pack; burrowing does not generate a usable tunnel.

**Summoning:** Ineligible.

## Design notes — not needed during play

**ID:** creature-burrowing-maw

**Status:** Revised proposal for Bruce’s review; not balance-certified.

**Category:** Beast · **Role:** Ambush burrower · **CV:** 26

### Creature-roll reference

**Attributes:** Brawn +2; Fortitude +2; Agility +0; Guile -2; Knowledge -2; Reason +0

| Attack | Attribute | Attack modifier | Weak attack | Standard attack | Strong attack |
|---|---|---|---|---|---|
| Plated jaws | Brawn | 1 Boon | 3 physical damage. | 5 physical damage. Grappled 1. | 7 physical damage. Grappled 2. |
| Closing jaws | Brawn | 1 Boon | 3 physical damage. | 5 physical damage. | 7 physical damage; Blinded 1. |

The incoming attack names the defense attribute; use the six values above. Same targeting, costs and limits apply in either perspective. No opposed second roll.


### CV worksheet

**Difficulty rationale:** No innate attack modifier; armor, cover and chosen actions provide its defenses. Its dangerous attack imposes defense Banes.

**Reference damage:** 3/5/7

**Reference type:** physical

**Expected targets:** 1

**Utility factor:** 1.4

**Regeneration per turn:** 0

Reference I=3.000, O=4.596. CV uses the [seed worksheet](../encounters.md); action choices, Stability and control are not simulated. Recalibration remains required.

**Ability sources:** [seizing limbs](../../monster-abilities/seizing-limbs.md), [swallow threat](../../monster-abilities/swallow-threat.md).

[Roster](../roster.md) · [Agreed Stability](../../rules/stability.md)
