# BAS-01 first pass: Basic abilities

**Status:** First-pass proposal. Not approved. No book or ledger changes yet.

**Goal:** Redesign the 18 Basic entries to the class-signature standard: a clear
fantasy promise, a fast table procedure, and one meaningful choice where it earns
its place. Basic abilities are the shared verbs of adventure. They must stay
simple, reliable and available to every hero, while class signatures keep the
spotlight.


## Nomenclature

- **Basic ability:** every hero gets it by default. No DP, no discipline, no level.
- **Universal ability:** learned with DP, but requires no discipline rank.
- **Discipline ability:** requires a printed discipline rank.
- **Signature ability:** class-exclusive; requires the class and level only.
- **Ancestry trait:** granted by ancestry, not purchased.

### Discipline tiers

| Tier | Discipline rank | DP | Minimum level |
|---|---|---|---|
| Novice | 1 | 2 | 1 |
| Adept | 2 | 4 | 3 |
| Master | 3 | 8 | 7 |

Universal abilities may use the same Novice, Adept and Master bands when they
have a minimum level, but they do not require a discipline rank. The six 1-DP
shared exceptions are Novice Universal abilities. Signatures remain class and
level choices rather than discipline purchases.

This pass covers **Basic abilities**. The control-set code `UNI-01` is the legacy
name for this set. Use `BAS-01` in new working notes and keep `CHG-UNI-*` as
historical change IDs. The six 1-DP shared Novice exceptions are **Universal
abilities**, not Basic abilities.

## Design goals

1. Every hero can attempt it. No class tax and no hidden prerequisite.
2. Resolve in one roll or no roll. No nested bookkeeping and no extra resource.
3. Open with a concrete fantasy moment, then a distinct Rules section.
4. Give a real choice where it matters. A flat +1 Boon is not a design by itself.
5. Keep the ceiling below signatures. These are the reliable baseline verbs.
6. Use functional Type plus the Basic tag. Set DP to 0 and Tier to Universal.
7. Avoid em dashes in new text. Use commas, semicolons or parentheses.

## Structural call

Four entries are procedures, not abilities: **Move**, **Stand**, **Convert an
Action** and **Handle an Item**. Recommend moving them into the combat rules and
removing them from the ability catalog. That leaves 14 Universal abilities and
resolves the compound action-label problem for Convert an Action and Handle an
Item. If they stay as cards, give them functional Types and the Universal tag.

This is the first set-level decision to confirm.

## The 18 first-pass directions

| # | ID | Fantasy promise | First-pass direction |
|---|---|---|---|
| 1 | `basic-melee` | Hold the line with steel. | Keep 2/3/5. If you moved 0 squares this turn, a Strong result also pushes the target 1 square. |
| 2 | `basic-ranged` | The patient shot. | Keep 2/3/5. You may spend a Maneuver to Aim before the attack for 1 Boon; no Aim if you moved this turn. |
| 3 | `basic-throw` | Anything is a weapon. | Keep 2/3/5. Add an object mode: throw at an unattended lever, rope or object within range; the DA sets the check and the object lands where it can. |
| 4 | `basic-unarmed` | The close fight. | Keep 1/2/4. Choose nonlethal. On a Strong result, you may grapple instead of dealing 1 damage. |
| 5 | `aid` | Lend a hand. | Remove the draft word Proposal. Keep 1 Boon and the outside-combat group-roll clause. |
| 6 | `command-a-summon` | The sharp whistle. | Keep the command economy. Update the tether to 6 squares and align the wording with standard creature summons. |
| 7 | `convert-an-action` | The extra effort. | Move to the combat rules as a procedure. If kept, Type Utility, Tags Universal. |
| 8 | `defend` | The guarded stance. | Choose Guard for 1 Boon to defense, or Brace for 1 Boon to Stability and defense against forced movement. |
| 9 | `disengage` | The careful step. | Move up to half Speed without provoking. You can still act. Trade distance for safety. |
| 10 | `force` | Put your back into it. | Fix the missing push numerals. Keep the choose-before-rolling structure. |
| 11 | `handle-an-item` | Ready hands. | Move to the combat rules as a procedure. If kept, Type Utility, Tags Universal. |
| 12 | `move` | The long stride. | Move to the combat rules as a procedure. If kept, Type Movement, Tags Universal. |
| 13 | `opportunity-attack` | The opening. | Keep Basic Melee as a Reaction. Clarify the triggering actions and the interrupt timing. |
| 14 | `reduce-a-condition` | Put out the fire. | Reduce Bleeding, Burning or Freezing by 1. Add a plausible DA-approved remedy for another condition. |
| 15 | `shield-block` | The shield wall. | Keep the 1 Boon Reaction. You may shield an adjacent ally instead of yourself, but then you are not protected. |
| 16 | `stabilize` | Keep them with you. | Keep the no-roll stabilization. Add that the patient can speak a word or give a clue. |
| 17 | `stand` | Back on your feet. | Move to the combat rules as a procedure. If kept, Type Movement, Tags Universal. |
| 18 | `use-a-healing-potion` | The last draught. | Keep the fixed healing and the giver/recipient action rule. Clarify the free-hand requirement. |

## First ability to review: Basic Melee

### Current text

# Basic Melee

*You set your feet and bring your weapon around in a practiced strike.*

**Action:** Main Action · **Attribute:** Brawn

**Target / range / shape:** One adjacent creature

Choose your target and make the attack.

- **Weak:** 2 physical damage.
- **Standard:** 3 physical damage.
- **Strong:** 5 physical damage.

**Duration:** Instant

**Equipment / acquisition:** Requires a melee weapon, Bulk 1; this reference grants none.

**Tier / minimum level:** Universal · **DP:** Not purchased · **Requirements to learn:** None

**Type:** Attack

**Limits:** Repeatable; pay the action and any stated costs each use.

**ID:** basic-melee

### Proposed final text

# Basic Melee

*You set your feet, let the shield line close around you, and bring your weapon around in a practiced strike.*

## Rules

**Action:** Main Action · **Attribute:** Brawn

**Target / range / shape:** One adjacent creature

Choose your target and make the attack. If you moved 0 squares this turn, a Strong result also pushes the target 1 square.

- **Weak:** 2 physical damage.
- **Standard:** 3 physical damage.
- **Strong:** 5 physical damage.

**Duration:** Instant

**Equipment / acquisition:** Requires a melee weapon, Bulk 1; this reference grants none.

---

**Tier / minimum level:** Universal · **DP:** 0 · **Requirements to learn:** None

**Type:** Attack

**Tags:** Basic / Melee

**Limits:** Repeatable; pay the action and any stated costs each use.

**ID:** basic-melee

[Card conventions](../card-conventions.md) · [Catalog](../catalog.md)

### Why this change

The current ability is a damage number with no table identity. The new rider gives
Basic Melee a clear fantasy: planted feet, a shield line, and a strike that makes
the enemy give ground. It rewards standing your ground without adding a new roll or
a new resource. It also stays below Force, which is the dedicated push ability.

## Open question

Start the row-by-row pass with Basic Melee as proposed, or revise the set direction
first?
