# Goblin Scrapper

*A small, wiry goblin salvager with keen eyes, patched work clothes and pockets full of useful scraps. Quick hands and knowledge of the ruins compensate for modest reach.*

**HP:** 8 · **Speed:** Ground 7 · **Footprint:** 1x1

## When attacked

**Evasion:** 1 Bane to player attacks. · **Stability:** 0.

**DR / resistance:** None · **Condition immunities:** None

**Weakness:** None

**Healing:** Living: ordinary HP healing applies.

## On its turn

**Senses:** Ordinary sight and hearing.

### Scrap knife — Main Action

**Target:** One adjacent creature. **Player defense:** Agility. **Threat:** 0 (no modifier) to that defense.

- **Weak defense:** 5 physical damage.
- **Standard defense:** 3 physical damage.
- **Strong defense:** 2 physical damage.

### Stalking Step — Maneuver

Move up to 2 squares, paying terrain costs from that allowance. Provokes normally; no automatic Hidden.

**Defend — Maneuver:** 1 additional Bane on player attacks against it until its next turn; repeated Defend does not stack.

**Basic Melee — Main Action / opportunity Reaction:** one adjacent target, Agility defense, Threat 0; Weak defense 4, Standard 2, Strong 1 physical damage. No specialty riders. An opportunity spends its Reaction before the provoking action resolves; that action continues if capable.

## Encounter cues

**Signs:** Bright scraps are tied to trip-free routes through the rubble.

**Purpose:** Protect a salvage claim and avoid being cheated.

**Tactics and retreat:** Stalking Step between cover and a distracted opponent; bargain when cornered.

**Counterplay and conversation:** Recognize the salvage claim or trade a useful tool.

**Habitat:** Ruin; roadside · **Communication:** Common and Goblin

**Rewards:** Melee weapon, tool scraps and 3 coins.

**Summoning:** Ineligible.

## Design notes — not needed during play

**ID:** creature-goblin-scrapper

**Status:** Revised proposal for Bruce’s review; not balance-certified.

**Category:** Mortal · **Role:** Scavenger · **CV:** 7

### Creature-roll reference

**Attributes:** Brawn +0; Fortitude +0; Agility +2; Guile +1; Knowledge +0; Reason +0

| Attack | Attribute | Attack modifier | Weak attack | Standard attack | Strong attack |
|---|---|---|---|---|---|
| Scrap knife | Agility | None | 2 physical damage. | 3 physical damage. | 5 physical damage. |

The incoming attack names the defense attribute; use the six values above. Same targeting, costs and limits apply in either perspective. No opposed second roll.


### CV worksheet

**Difficulty rationale:** An agile or elusive body warrants attack Banes. Ordinary attack difficulty; riders and positioning carry the threat.

**Reference damage:** 2/3/5

**Reference type:** physical

**Expected targets:** 1

**Utility factor:** 1.1

**Regeneration per turn:** 0

Reference I=4.404, O=2.162. CV uses the [seed worksheet](../encounters.md); action choices, Stability and control are not simulated. Recalibration remains required.

**Ability sources:** [stalking step](../../monster-abilities/stalking-step.md).

[Roster](../roster.md) · [Agreed Stability](../../rules/stability.md)
