# Abilities Review — control set

This folder is the single place to track the abilities review from first decision to release. It is deliberately separate from the generated Excel workbooks: the workbooks are the review view, this folder is the audit trail.

## Workspace path

`/home/bmoser/OpenBaD/workspaces/heroes-of-legend`

## Workspace map

| Path | Role |
|---|---|
| the repository root | The single Git checkout, on `release/abilities-review`. Contains `design/`, `review/abilities/`, `release/` and `scripts/`. |
| `review/abilities/` | This live control set. |
| `review/abilities/workbooks/` | Live review workbooks. |
| `work/` | Parsers, workbook builders and `publish_control_set.py`. |
| `backups/` | Pre-cleanup snapshots and branch patches. |

`review/abilities/` is the published record. `work/publish_control_set.py`
publishes this folder and the workbooks into the repo. The repo directories are the real
project directories; they are not review copies.

## Workspace audit

Confirmed on 2026-10-27: 19 workbooks present, 18 areas tracked, 575 ledger
records (569 approved; 6 Universal proposals deferred), 9 approved area branches consolidated into
`release/abilities-review`. The nine `book-<area>` worktrees were removed after
their changes were committed; patches are in `backups/pre-reorg-20261027-*`.

## Status

- **Review progress:** 4 ancestries (ANC-01 through ANC-04) and 5 classes (CLS-01 through CLS-05) are approved. Last completed: CLS-05 Odd class signatures. Next: CLS-06 Protector.
- **Local preparation:** complete. Stable IDs and Change Log sheets have been added to the 19 workbooks; the control set is in place.
- **Consolidation:** the nine approved area branches were committed and merged locally into `release/abilities-review`; the consolidated review data is at the tip of that branch. No GitHub PRs were opened or pushed by this cleanup, so the tracker's Book PR and Merge SHA columns remain blank until those PRs are created.
- **Repo setup:** complete. Epic #1283, Foundry tracker bruceamoser/heroes-of-legend-foundry#252, `release/abilities-review`, and area branches `codex/1284` through `codex/1293` are created. The published control set and workbooks are under `review/abilities/`.
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
- After every decision, show the complete final text (title, narrative, rules) before moving to the next item.
- Every area needs a **book issue**, a **book branch**, a **book PR**, and an **area row** in `AREA_TRACKER.md`.
- Foundry and Character Workshop are **deferred** until all book areas are landed. Foundry content is pinned to the final book commit.
- Per-area **source audits are required**. Per-area PDF, Foundry and Workshop builds are not.
- Do not edit generated Foundry packs, generated book indexes or the Excel workbooks as if they were source.
- Write permissions, not exclusions: state what an ability does, not what it does not do.
- No em dashes anywhere. Use commas, colons, parentheses or separate sentences.
- Do not change a Stable ID to fix a title. Rename the title; migrate the ID only with an explicit ID-migration change.

## Working files

- Repository: the repository root (the single Git checkout, on `release/abilities-review`)
- Workbooks: `review/abilities/workbooks/` (live; mirrored into the repo by the publish step)
- Control docs: `review/abilities/` (live; mirrored into the repo by the publish step)
- Last completed area brief: `review/abilities/areas/CLS-05.md`; next area from `AREA_TRACKER.md`
- Exported/merged ledger: `review/abilities/CHANGE_LEDGER.csv`
- Per-workbook capture: each workbook's **Change Log** sheet
- Publish live review data to the repo: `python3 work/publish_control_set.py`
- Build scripts: `scripts/`; local helper scripts in `work/` are not committed

## Immediate next actions

1. Continue with CLS-06 Protector from `AREA_TRACKER.md`.
2. Push the nine consolidated area branches and open their book PRs when ready; then fill in Book PR and Merge SHA in the tracker.
3. Edit the live workspace copies first, then publish to the repo after changes.
4. Do not create `book-<area>` worktrees in this workspace; use branches in the main checkout.

## Setup and automation references

- `GITHUB_SETUP.md` — exact commands and access checks for Phase 0.
- `AREAS.csv` — machine-readable area list for setup automation.
- `CHANGE_LEDGER_SCHEMA.md` — column rules and validation checks.
