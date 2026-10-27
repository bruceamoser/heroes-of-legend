# Area tracker

**Book epic:** [#1283](https://github.com/bruceamoser/heroes-of-legend/issues/1283)  
**Foundry tracking issue:** [#252](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/252)  
**Release branch:** `release/abilities-review`

One row per review area. Update this file in the same PR as the area change, or immediately after the area PR merges.

## Status key

| Status | Meaning |
|---|---|
| `Not started` | No review work begun. |
| `Deferred` | Parked in favor of another area. |
| `In review` | Workbook decisions in progress. |
| `Approved` | All decisions approved; source edits not yet merged. |
| `Book PR` | Book PR open. |
| `Book merged` | Book PR squash-merged into `release/abilities-review`. |
| `Blocked` | Waiting on a decision or dependency. |
| `Done` | Area complete and included in the release gate. |

## Areas

| Area ID | Category | Workbook | Book issue | Branch | Owner | Status | Decisions | Change rows | Book PR | Merge SHA | Foundry issue | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| UNI-01 | Universal | `30_Universal_Abilities.xlsx` | [#1284](https://github.com/bruceamoser/heroes-of-legend/issues/1284) | `codex/1284-universal` | Bruce | Deferred | 0 / 18 | 6 proposed | — | — | [#252](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/252) | Parked; ancestries first. |
| NOV-01 | Novice | `31_Novice_Abilities.xlsx` | — | — | Bruce | Not started | 0 / 133 | 0 | — | — | — | Shared cards only. |
| ADE-01 | Adept | `32_Adept_Abilities.xlsx` | — | — | Bruce | Not started | 0 / 91 | 0 | — | — | — | Shared cards only. |
| MAS-01 | Master | `33_Master_Abilities.xlsx` | — | — | Bruce | Not started | 0 / 87 | 0 | — | — | — | Shared cards only. |
| ANC-01 | Ancestry | `10_Ancestry_Dwarf.xlsx` | [#1285](https://github.com/bruceamoser/heroes-of-legend/issues/1285) | `codex/1285-ancestry-dwarf` | Bruce | Approved | 5 / 5 | 10 approved | — | — | [#252](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/252) | Traits complete; positive-wording pass done; pairs reference-only. |
| ANC-02 | Ancestry | `11_Ancestry_Elf.xlsx` | [#1286](https://github.com/bruceamoser/heroes-of-legend/issues/1286) | `codex/1286-ancestry-elf` | Bruce | Approved | 5 / 5 | 8 approved | — | — | [#252](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/252) | Traits complete; positive-wording pass done; pairs reference-only. |
| ANC-03 | Ancestry | `12_Ancestry_Halfling.xlsx` | [#1287](https://github.com/bruceamoser/heroes-of-legend/issues/1287) | `codex/1287-ancestry-halfling` | Bruce | Approved | 5 / 5 | 11 approved | — | — | [#252](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/252) | Traits complete; positive-wording pass done; Size Small, token 0.5 × 0.5. |
| ANC-04 | Ancestry | `13_Ancestry_Human.xlsx` | [#1288](https://github.com/bruceamoser/heroes-of-legend/issues/1288) | `codex/1288-ancestry-human` | Bruce | Approved | 5 / 5 | 10 approved | — | — | [#252](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/252) | Traits complete; pairs not separately reviewed. |
| CLS-01 | Class | `20_Class_Arcanist.xlsx` | [#1289](https://github.com/bruceamoser/heroes-of-legend/issues/1289) | `codex/1289-class-arcanist` | Bruce | Approved | 9 / 9 | 47 approved | — | — | [#252](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/252) | All nine signatures approved. |
| CLS-02 | Class | `21_Class_Blade.xlsx` | [#1290](https://github.com/bruceamoser/heroes-of-legend/issues/1290) | `codex/1290-class-blade` | Bruce | Approved | 9 / 9 | 53 approved | TBD | TBD | [#252](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/252) | All nine Blade signatures approved. |
| CLS-03 | Class | `22_Class_Intellect.xlsx` | [#1291](https://github.com/bruceamoser/heroes-of-legend/issues/1291) | `codex/1291-class-intellect` | Bruce | Approved | 9 / 9 | 55 approved | TBD | TBD | [#252](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/252) | All nine Intellect signatures approved. |
| CLS-04 | Class | `23_Class_Leader.xlsx` | [#1292](https://github.com/bruceamoser/heroes-of-legend/issues/1292) | `codex/1292-class-leader` | Bruce | Approved | 9 / 9 | 34 approved | TBD | TBD | [#252](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/252) | All nine Leader signatures approved. |
| CLS-05 | Class | `24_Class_Odd.xlsx` | [#1293](https://github.com/bruceamoser/heroes-of-legend/issues/1293) | `codex/1293-class-odd` | Bruce | Approved | 9 / 9 | 71 approved | TBD | TBD | [#252](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/252) | All nine signatures approved. |
| CLS-06 | Class | `25_Class_Protector.xlsx` | — | — | Bruce | Not started | 0 / 9 | 0 | — | — | — | 3 signatures × 3 tiers. |
| CLS-07 | Class | `26_Class_Shadow.xlsx` | — | — | Bruce | Not started | 0 / 9 | 0 | — | — | — | 3 signatures × 3 tiers. |
| CLS-08 | Class | `27_Class_Shepherd.xlsx` | — | — | Bruce | Not started | 0 / 9 | 0 | — | — | — | 3 signatures × 3 tiers. |
| CLS-09 | Class | `28_Class_Unbalanced.xlsx` | — | — | Bruce | Not started | 0 / 9 | 0 | — | — | — | 3 signatures × 3 tiers. |
| CLS-10 | Class | `29_Class_Warden.xlsx` | — | — | Bruce | Not started | 0 / 9 | 0 | — | — | — | 3 signatures × 3 tiers. |

## Release gate

- [ ] All areas `Done`.
- [ ] All change rows exported to `CHANGE_LEDGER.csv`.
- [ ] All fast book audits pass on `release/abilities-review`.
- [ ] Release PR opened to `main` and merged.
- [ ] Book built and published.
- [ ] Foundry synced and released.
- [ ] Character Workshop deployed and verified.
