# Heroes of Legend — workspace start here

This is the review workspace for the Heroes of Legend abilities review. The Git
repository is the repository root; `review/abilities/`, `review/abilities/workbooks/` and `work/` are the working layer
around it. There is exactly one repository checkout.

Workspace root: `/home/bmoser/OpenBaD/workspaces/heroes-of-legend`.
The old path `/home/bmoser/OpenBaD/Heroes-of-legend/Heroes of Legend` is a
symlink to this directory, so both paths show the same files.

## Where current review information is stored

| Path | What it is |
|---|---|
| `review/abilities/` | Live review control set: SOP, area tracker, change ledger, area briefs, issue drafts and ideas. Start with `review/abilities/README.md`. |
| `review/abilities/workbooks/` | Live review workbooks: 19 `.xlsx` files (18 content workbooks plus an index). |
| the repository root | The single Git checkout, on `release/abilities-review`. `design/` is the only design source tree. `review/abilities/` is the published copy of the control set and workbooks. |
| `work/` | Parsers, workbook builders, audit helpers and `publish_control_set.py`, which publishes the live control set and workbooks into the repo. |
| `backups/` | Pre-cleanup snapshots, branch patches and archives. |

The repo's `design/`, `scripts/` and `release/` directories are the real project
directories and live only in the repository root. They are not review copies.

## Current status

- **Review progress:** 4 ancestries (ANC-01 through ANC-04) and 5 classes
  (CLS-01 through CLS-05) are approved. The last completed area is **CLS-05 Odd
  class signatures**; all nine signatures are final and `review/abilities/workbooks/24_Class_Odd.xlsx`
  has been refreshed.
- **Next area:** CLS-06 Protector. Pick it from `review/abilities/AREA_TRACKER.md`.
- **Tracking:** 18 areas, 19 workbooks, 305 ledger records: 299 approved and 6 deferred Universal proposals.
- **Consolidation:** the nine approved area branches were committed and merged
  locally into `release/abilities-review`; the consolidated review data is at
  commit `1e245a1`. No GitHub PRs were opened or pushed by this cleanup, so the
  tracker's Book PR and Merge SHA columns remain blank until those PRs are created.
- **Repo setup:** book epic [#1283](https://github.com/bruceamoser/heroes-of-legend/issues/1283),
  Foundry tracker [#252](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/252),
  release branch `release/abilities-review`, and area branches `codex/1285`
  through `codex/1293`.
- **Published record:** `review/abilities/` contains the current control set
  and workbooks. Publish updates with `python3 work/publish_control_set.py`.

## Read in this order

1. `review/abilities/README.md` — control-set index and workspace rules.
2. `review/abilities/ABILITIES_REVIEW_SOP.md` — the process and gates.
3. `review/abilities/BASELINE.md` — starting SHAs, versions and source pin.
4. `review/abilities/AREA_TRACKER.md` — 18 areas and status.
5. `review/abilities/CHANGE_LEDGER_SCHEMA.md` — how to record a change.
6. `review/abilities/RELEASE_CHECKLIST.md` — the one-time final build and release phase.
7. `review/abilities/workbooks/README.md` — workbook map.

## Build policy

No incremental book, Character Workshop or Foundry builds. Per area: source audits
only. After all areas land: build the book, sync Foundry, build the Workshop, and
package and release Foundry.

## Workspace hygiene

- Do not create `book-<area>` worktrees. They are full repository checkouts and
  duplicate the entire `design/` tree (about 640 MB each). Use branches in the
  main checkout; if parallel checkouts are unavoidable, put them outside this workspace.
- the repository root is the only design source tree. The Markdown under `design/` is
  authoritative; `review/abilities/` and `review/abilities/workbooks/` are review artifacts.
