# Abilities review — start here

This workspace contains the full review control set for the Heroes of Legend abilities review.

## Current status

- **Workbooks:** 19 `.xlsx` files in `review/abilities/workbooks/` — 18 content workbooks plus an index. Every content workbook now has **Stable ID** columns and a **Change Log** sheet.
- **Process:** revised batch-build SOP in `review/abilities/ABILITIES_REVIEW_SOP.md`.
- **Tracking:** 18 areas in `review/abilities/AREA_TRACKER.md`, ledger in `review/abilities/CHANGE_LEDGER.csv`.
- **Repo setup:** complete. Book epic [#1283](https://github.com/bruceamoser/heroes-of-legend/issues/1283), Foundry tracker [#252](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/252), `release/abilities-review`, Universal issue [#1284](https://github.com/bruceamoser/heroes-of-legend/issues/1284) and `codex/1284-universal` exist. The control set and workbooks are committed at `102dd0b` under `review/abilities/`.

## Read in this order

1. `review/abilities/README.md` — control-set index.
2. `review/abilities/ABILITIES_REVIEW_SOP.md` — the process and gates.
3. `review/abilities/BASELINE.md` — starting SHAs, versions and source pin.
4. `review/abilities/AREA_TRACKER.md` — 18 areas and status.
5. `review/abilities/CHANGE_LEDGER_SCHEMA.md` — how to record a change.
6. `review/abilities/RELEASE_CHECKLIST.md` — the one-time final build/release phase.
7. `review/abilities/workbooks/README.md` — workbook map.

## Build policy

No incremental book, Character Workshop or Foundry builds. Per area: source audits only. After all areas land: build the book, sync Foundry, build the Workshop, package/release Foundry.

## Current area

**Dwarf ancestry (ANC-01)** is in review. The first trait is **Stubborn as Bedrock**. Issue #1285, branch `codex/1285-ancestry-dwarf`.