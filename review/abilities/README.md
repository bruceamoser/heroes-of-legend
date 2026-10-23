# Abilities Review — control set

This folder is the single place to track the abilities review from first decision to release. It is deliberately separate from the generated Excel workbooks: the workbooks are the review view, this folder is the audit trail.

## Status

- **Local preparation:** complete. Stable IDs and Change Log sheets have been added to the 19 workbooks; the control set is in place.
- **Repo setup:** complete. Epic #1283, Foundry tracker bruceamoser/heroes-of-legend-foundry#252, `release/abilities-review`, Universal issue #1284 and `codex/1284-universal` are created. The control set is committed at `102dd0b` under `review/abilities/abilities/` in the book repo.
- **Build policy:** no incremental book, Workshop or Foundry builds. Source audits run per area; the full build phase runs once after every area is landed.

## Read in this order

1. `ABILITIES_REVIEW_SOP.md` — the process, branch model, gates and responsibilities.
2. `BASELINE.md` — the exact starting commits, versions and source pin.
3. `AREA_TRACKER.md` — the 18 areas, owners, issues, branches and status.
4. `CHANGE_LEDGER.csv` — the authoritative change record. One row per change.
5. `CHANGE_LEDGER_SCHEMA.md` — column rules, example row and validation checks.
6. `templates/` — epic, area issue, release PR and Foundry PR bodies.
7. `RELEASE_CHECKLIST.md` — the one-time final build and release phase.
8. `DECISION_LOG.md` — decisions already made and why.
9. `OPEN_QUESTIONS.md` — anything still blocking or awaiting a decision.
10. `WORKBOOK_MANIFEST.csv` — what each workbook contains and how it is used.
11. `GITHUB_SETUP.md` — Phase 0 access checks and issue/branch commands.
12. `AREAS.csv` — machine-readable area list.

## Ground rules

- The **book Markdown is authoritative**. The Excel workbooks and this folder are review artifacts, not a rules source.
- Every change must be traceable by **Stable ID**, not only by title. Workbook **Change Log** sheets are capture views; `CHANGE_LEDGER.csv` is authoritative.
- Every area needs a **book issue**, a **book branch**, a **book PR**, and an **area row** in `AREA_TRACKER.md`.
- Foundry and Character Workshop are **deferred** until all book areas are landed. Foundry content is pinned to the final book commit.
- Per-area **source audits are required**. Per-area PDF, Foundry and Workshop builds are not.
- Do not edit generated Foundry packs, generated book indexes or the Excel workbooks as if they were source.
- Do not change a Stable ID to fix a title. Rename the title; migrate the ID only with an explicit ID-migration change.

## Working files

- Workbooks: `review/abilities/workbooks/`
- Control docs: `review/abilities/`
- Exported/merged ledger: `review/abilities/CHANGE_LEDGER.csv`
- Per-workbook capture: each workbook's **Change Log** sheet
- Build scripts: `work/` (local generation/validation only)

## Immediate next actions

1. Approve the release branch model and grant write access to both repos.
2. Create the book epic and Foundry tracking issue from the templates.
3. Create `release/abilities-review` in the book repo.
4. Fill in issue numbers and branch names in `AREA_TRACKER.md`.
5. Start with the first area (recommended: Universal, then one tier at a time).

## Setup and automation references

- `GITHUB_SETUP.md` — exact commands and access checks for Phase 0.
- `AREAS.csv` — machine-readable area list for setup automation.
- `CHANGE_LEDGER_SCHEMA.md` — column rules and validation checks.
