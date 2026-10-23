# [<Area>] abilities review — <area>

## Context

- Epic: #<epic>
- Workbook: `review/abilities/workbooks/<workbook>.xlsx`
- SOP: `review/abilities/ABILITIES_REVIEW_SOP.md`
- Area tracker: `review/abilities/AREA_TRACKER.md` row `<AREA-ID>`

## Scope

- Review every row in the workbook: `<count>` decisions.
- Record every change in the workbook Change Log and merge it into `review/abilities/CHANGE_LEDGER.csv`.
- Apply only approved changes to the book Markdown.
- Run the fast source audits; do not build the PDF, Foundry content or Workshop.

## Out of scope

- Foundry source pin/content sync.
- Character Workshop build/deploy.
- Foundry package/release.
- Unrelated rewrites or opportunistic cleanup.

## Acceptance criteria

- [ ] Every row has a final decision; no unowned `Unsure`.
- [ ] Every approved source edit has a change-ledger row.
- [ ] Stable IDs are preserved; any ID change is an explicit migration.
- [ ] Generated indexes/summaries are updated.
- [ ] Fast source audits pass.
- [ ] Book PR merged into `release/abilities-review`.
- [ ] Area tracker updated with PR and merge SHA.

## Downstream impact

- Foundry content families affected: `<choices / inventory / creatures / summons / item packs / web journals / native journals / none>`
- Existing-world migration required: `<yes/no; notes>`
- Workshop impact: `<yes/no; notes>`

## Evidence

Paste audit output, ledger summary and PR link here when complete.
