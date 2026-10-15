# Bandit Bow

*A lightly armored robber with a hunting bow, spare string and clothing chosen to blend into roadside cover. Their confidence depends on distance and a prepared exit.*

**HP:** 10 · **Speed:** Ground 6 · **Footprint:** 1x1

## When attacked

**Evasion:** 0 (no modifier) to player attacks. · **Stability:** 0.

**DR / resistance:** None · **Condition immunities:** None

**Weakness:** None

**Healing:** Living: ordinary HP healing applies.

## On its turn

**Senses:** Ordinary sight and hearing.

### Hunting arrow — Main Action

**Ammunition:** inventory d6. After each use, roll the inventory die; on 1, reduce d6 to d4, or d4 to empty. Cannot use this attack while empty.

**Target:** One visible creature within 8 squares. **Player defense:** Agility. **Threat:** 0 (no modifier) to that defense.

- **Weak defense:** 6 physical damage.
- **Standard defense:** 4 physical damage.
- **Strong defense:** 2 physical damage.

### Stalking Step — Maneuver

Move up to 2 squares, paying terrain costs from that allowance. Provokes normally; no automatic Hidden.

**Defend — Maneuver:** 1 additional Bane on player attacks against it until its next turn; repeated Defend does not stack.

**Basic Melee — Main Action / opportunity Reaction:** one adjacent target, Agility defense, Threat 0; Weak defense 5, Standard 3, Strong 2 physical damage. No specialty riders. An opportunity spends its Reaction before the provoking action resolves; that action continues if capable.

## Encounter cues

**Signs:** Fresh rope marks and cut branches above an ambush site.

**Purpose:** Keep danger far away while companions take the money.

**Tactics and retreat:** Shoot from cover; change position when approached.

**Counterplay and conversation:** Reach the perch or negotiate with the companions below.

**Habitat:** Road; forest · **Communication:** Common

**Rewards:** Ranged weapon; ammunition d6; 4 coins.

**Summoning:** Ineligible.

## Design notes — not needed during play

**ID:** creature-bandit-bow

**Status:** Revised proposal for Bruce’s review; not balance-certified.

**Category:** Mortal · **Role:** Artillery · **CV:** 9

### Creature-roll reference

**Attributes:** Brawn +0; Fortitude +0; Agility +2; Guile +1; Knowledge +0; Reason +0

| Attack | Attribute | Attack modifier | Weak attack | Standard attack | Strong attack |
|---|---|---|---|---|---|
| Hunting arrow | Agility | None | 2 physical damage. | 4 physical damage. | 6 physical damage. |

The incoming attack names the defense attribute; use the six values above. Same targeting, costs and limits apply in either perspective. No opposed second roll.


### CV worksheet

**Difficulty rationale:** No innate attack modifier; armor, cover and chosen actions provide its defenses. Ordinary attack difficulty; riders and positioning carry the threat.

**Reference damage:** 2/4/6

**Reference type:** physical

**Expected targets:** 1

**Utility factor:** 1.1

**Regeneration per turn:** 0

Reference I=5.000, O=3.000. CV uses the [seed worksheet](../encounters.md); action choices, Stability and control are not simulated. Recalibration remains required.

**Ability sources:** [stalking step](../../monster-abilities/stalking-step.md).

[Roster](../roster.md) · [Agreed Stability](../../rules/stability.md)
