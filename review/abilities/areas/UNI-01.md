> **Working name:** Basic abilities (`BAS-01`). The `UNI-01` code and `CHG-UNI-*` IDs are retained for historical continuity. Use **Universal** only for learned abilities that require no discipline rank.

# UNI-01: Basic abilities review (legacy code)

**Status:** In review  
**Book issue:** [#1284](https://github.com/bruceamoser/heroes-of-legend/issues/1284)  
**Branch:** `codex/1284-universal`  
**Workbook:** `review/abilities/workbooks/30_Universal_Abilities.xlsx`  
**Scope:** 18 universal actions and basic attacks.

## Batch 1 — clear copy fixes

These are wording/clarity fixes only; no mechanics change. Recommend approving as one batch.

| Change ID | Stable ID | Field | Current | Proposed | Why |
|---|---|---|---|---|---|
| CHG-UNI-001 | `force` | Rules — Standard | `2 progress, grapple reduction, or squares of push.` | `2 progress, grapple reduction, or 2 squares of push.` | Missing push numeral. |
| CHG-UNI-002 | `force` | Rules — Strong | `3 progress, grapple reduction, or squares of push.` | `3 progress, grapple reduction, or 3 squares of push.` | Missing push numeral. |
| CHG-UNI-003 | `aid` | Rules | `Proposal: the ally gains 1 Boon to that task’s next roll...` | `The ally gains 1 Boon to that task’s next roll...` | Removes draft-stage language from an approved card. |
| CHG-UNI-004 | `stabilize` | Rules | `Stabilize at 0 HP and clear death marks.` | `Stabilize a Dying character at 0 HP and clear death marks.` | Adds the missing object; says who is stabilized. |
| CHG-UNI-005 | `command-a-summon` | Target | `One of your summons within its tether.` | `One of your summons within 6 squares of you (its tether).` | “Its tether” is ambiguous; the summoning rules use 6 squares. |
| CHG-UNI-006 | `opportunity-attack` | Attribute | `None — no separate roll; resolve Basic Melee using Brawn` | `Brawn (no separate roll)` | Keeps the Attribute column to an attribute while preserving the rule in the text. |

## Batch 2 — decisions needed

These are not in Batch 1 because they affect taxonomy or card format.

### D-UNI-A — Universal DP value

All 18 universal cards currently store `**DP:** Not purchased`. The workbook normalizes this to `0`, but the source column is mixed text/number. Options:

1. Set `**DP:** 0` on all universal cards.
2. Leave DP blank and add an explicit availability field.
3. Keep `Not purchased` and document it as non-numeric.

Recommendation: **option 1** — numeric DP 0, with `Tier / minimum level: Universal` carrying availability.

### D-UNI-B — Type taxonomy

The four basic attacks are `Type: Attack`; the other fourteen are `Type: Universal`. A `Type = Universal` filter returns 14, not 18. Options:

1. Keep functional Type on all cards and add a `Universal` tag.
2. Change the fourteen to functional types (Utility, Movement, Defense, Recovery).
3. Document that `Universal` is a Type for non-attacks and accept the split.

Recommendation: **option 1** — Type stays functional; add a `Universal` tag to all 18. This is a small, consistent taxonomy change.

### D-UNI-C — Nonstandard action labels

Three cards use labels outside the five standard labels:

- `Command a Summon` — `Main Action or Maneuver`
- `Convert an Action` — `Action conversion`
- `Handle an Item` — `Varies`

Options:

1. Add an `Action detail` secondary field and keep the standard primary label.
2. Standardize the primary label and move the compound cost into Rules.
3. Update card-conventions to recognize these labels.

Recommendation: **option 1** for Command/Handle; move `Convert an Action` to the combat rules as a procedure rather than a card.

### D-UNI-D — Basic attack baseline note

Unarmed is 1/2/4, Throw/Ranged are 2/3/5, Melee is 2/4/6. This appears intentional. Recommendation: no mechanics change; add a short designer's note to the Universal overview and combat chapter.

## Decisions

- [ ] Approve Batch 1 as written.
- [ ] Approve Batch 1 with edits (list them).
- [ ] Decide D-UNI-A: option 1 / 2 / 3.
- [ ] Decide D-UNI-B: option 1 / 2 / 3.
- [ ] Decide D-UNI-C: option 1 / 2 / 3.
- [ ] Decide D-UNI-D: add note / no change.
