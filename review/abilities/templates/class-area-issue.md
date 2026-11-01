# [<Class>] class signature review — <Class>

## Context

- Epic: #<epic>
- Workbook: `review/abilities/workbooks/<workbook>.xlsx`
- SOP: `review/abilities/ABILITIES_REVIEW_SOP.md`
- Area tracker: `review/abilities/AREA_TRACKER.md` row `<AREA-ID>`

## Scope

- Review all nine class signatures: three at level 1, three at level 3, three at level 7.
- Review one ability at a time; show the complete final title, narrative and rules before moving to the next.
- Record every approved change in the workbook Change Log and merge it into `review/abilities/CHANGE_LEDGER.csv`.
- Apply only approved changes to the class and card source.
- Run the fast source audits; do not build the PDF, Foundry content or Workshop.

## Acceptance criteria

- [ ] All nine signatures have a final decision.
- [ ] Every approved source edit has a change-ledger row.
- [ ] Stable IDs are preserved.
- [ ] Generated indexes/summaries are updated if needed.
- [ ] Fast source audits pass.
- [ ] Book PR merged into `release/abilities-review`.

## Downstream impact

- Foundry content families affected: choices / inventory / web journals / native journals
- Existing-world migration required: TBD
- Workshop impact: TBD
