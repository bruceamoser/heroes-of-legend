# CLS-01 — Arcanist class signature review

**Status:** In review  
**Book issue:** [#1289](https://github.com/bruceamoser/heroes-of-legend/issues/1289)  
**Branch:** `codex/1289-class-arcanist`  
**Workbook:** `review/abilities/workbooks/20_Class_Arcanist.xlsx`  
**Scope:** nine signatures, three at levels 1, 3 and 7.

## Signature decisions

| Level | Signature | Status | Decision |
|---|---|---|---|
| 1 | Bent Trajectory | Approved | Spell attacks may originate from a visible, unoccupied square within 6 squares; cover/path from there, range from you, target location known, roll normally. |
| 1 | Deliberate Spark | Approved | Maneuver; choose a corner of your square; creatures in the four squares sharing it are pushed 2 squares away from the corner, including you. Spark does not provoke. |
| 1 | Study the Pattern | Approved | One ongoing effect you are aware of: learn origin, purpose, sustainer, duration and how to end it, then gain 1 Boon using that information. |
| 3 | Arcane Deflection | Approved | Self-only Reaction; take no spell damage; 1 square of push per point of raw damage to the four squares around the impact corner, including you. |
| 3 | Siphon Cast | Approved | Take 1 Bane on a Main Action spell with a roll; vanish as it resolves; rematerialize up to 4 squares away at the start of your next turn. Untargetable, but no further actions or reactions. |
| 3 | Create a Window | Approved | Reaction: connect two visible squares within 6; an ally can use them once during their turn to move through or attack through; they vanish at the end of the turn. |
| 7 | Choose the Edge | Approved | Reaction on a single-target spell with a roll: take 2 Banes on defense until next turn, choose two different targets or directions, resolve the spell twice with separate rolls, pay the cost once. |
| 7 | Folded Aegis | Approved | Main Action, once per day for 2 hours: magical heavy armor with resistance 3 to physical, fire and cold. Highest matching resistance, normal cap 3, weightless and no training needed. |
| 7 | Open the Circle | Approved | 1 Boon to spell defenses and Stability 2 for self and nearby allies until the start of your next turn. Reapplying replaces the ward. |

## Change record

- `CHG-CLS-001` — Change Bent Trajectory target/range to a visible, unoccupied square within 6 squares.
- `CHG-CLS-002` — Rewrite Bent Trajectory for spell attacks, cover/path from the origin, known target location, and normal spell attack roll.
- `CHG-CLS-003` to `CHG-CLS-008` — Replace Deliberate Spark with the corner 2x2 Maneuver spark.
- `CHG-CLS-009` / `CHG-CLS-010` — Expand and positively word Study the Pattern.
- `CHG-CLS-011` — Remove the visible-only target restriction from Study the Pattern.
- `CHG-CLS-012` to `CHG-CLS-014` — Replace Arcane Deflection with the self-only raw-damage-to-push conversion.
- `CHG-CLS-015` to `CHG-CLS-019` — Replace Cast and Scatter with Siphon Cast.
- `CHG-CLS-020` to `CHG-CLS-027` — Replace Leave a Window with Create a Window.
- `CHG-CLS-028` to `CHG-CLS-034` — Replace Choose the Edge with the double-casting nova.
- `CHG-CLS-035` to `CHG-CLS-043` — Replace Fold the Distance with Folded Aegis.
- `CHG-CLS-044` to `CHG-CLS-047` — Simplify and positively word Open the Circle.

## Notes

The signature keeps `signature-arcanist-bent-trajectory`. It is intentionally strong at 6 squares but requires a visible origin, so it bends around cover rather than through walls.
