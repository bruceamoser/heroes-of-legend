# Battle Chaplain

*A field healer with a plain staff, practical vestments and a pouch of bandages. Exhaustion and old bloodstains show how much keeping others alive has already cost.*

**HP:** 18 · **Speed:** Ground 6 · **Footprint:** 1x1

## When attacked

**Evasion:** 0 (no modifier) to player attacks. · **Stability:** 0.

**DR / resistance:** None · **Condition immunities:** None

**Weakness:** None

**Healing:** Living: ordinary HP healing applies.

## On its turn

**Senses:** Ordinary sight and hearing.

### Staff — Main Action

**Target:** One adjacent creature. **Player defense:** Agility. **Threat:** 0 (no modifier) to that defense.

- **Weak defense:** 5 physical damage.
- **Standard defense:** 3 physical damage.
- **Strong defense:** 2 physical damage.

### Battle Mending — Main Action

One adjacent living ally; free hand. Pay 1 HP first, bypass resistance, and remain above 0. A player rolls this creature’s Reason: Weak heals 3, Standard 6, Strong 9 HP. Life resistance reduces healing, minimum 1. This spell provokes. Against a healing-harmed target instead, use Fortitude defense: Weak takes 9, Standard 6, Strong 3 Life damage. Same cost; no healing riders.

**Defend — Maneuver:** 1 additional Bane on player attacks against it until its next turn; repeated Defend does not stack.

**Basic Melee — Main Action / opportunity Reaction:** one adjacent target, Agility defense, Threat 0; Weak defense 5, Standard 3, Strong 2 physical damage. No specialty riders. An opportunity spends its Reaction before the provoking action resolves; that action continues if capable.

## Encounter cues

**Signs:** Used bandages hang beside a small field shrine.

**Purpose:** Keep the people under their care alive.

**Tactics and retreat:** Heal an ally before trading staff blows; withdraw with wounded companions when life costs become dangerous.

**Counterplay and conversation:** Pressure the healer’s position, separate them from patients, or negotiate safe evacuation.

**Habitat:** Camp; temple · **Communication:** Common

**Rewards:** Staff, shrine token and 12 coins.

**Summoning:** Ineligible.

## Design notes — not needed during play

**ID:** creature-battle-chaplain

**Status:** Revised proposal for Bruce’s review; not balance-certified.

**Category:** Mortal · **Role:** Healer · **CV:** 13

### Creature-roll reference

**Attributes:** Brawn +0; Fortitude +1; Agility +0; Guile +1; Knowledge +1; Reason +2

| Attack | Attribute | Attack modifier | Weak attack | Standard attack | Strong attack |
|---|---|---|---|---|---|
| Staff | Brawn | None | 2 physical damage. | 3 physical damage. | 5 physical damage. |

The incoming attack names the defense attribute; use the six values above. Same targeting, costs and limits apply in either perspective. No opposed second roll.


### CV worksheet

**Difficulty rationale:** No innate attack modifier; armor, cover and chosen actions provide its defenses. Ordinary attack difficulty; riders and positioning carry the threat.

**Reference damage:** 2/3/5

**Reference type:** physical

**Expected targets:** 1

**Utility factor:** 1.5

**Regeneration per turn:** 0

Reference I=5.000, O=2.162. CV uses the [seed worksheet](../encounters.md); action choices, Stability and control are not simulated. Recalibration remains required.

**Ability sources:** [battle mending](../../monster-abilities/battle-mending.md).

[Roster](../roster.md) · [Agreed Stability](../../rules/stability.md)
