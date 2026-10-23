# Decision log

Append a row for every process or rules decision that future work depends on. Do not rewrite history; supersede an entry with a new one.

| ID | Date | Decision | Rationale | Owner | Status |
|---|---|---|---|---|---|
| D-001 | 2026-10-23 | Character Workshop is the web app. | It is built from the Foundry repo and deployed by the Pages workflow. | Bruce | Approved |
| D-002 | 2026-10-23 | Batch the build/release phase; do not build incrementally. | Avoid repeated PDF, Foundry and Workshop builds while the catalog is in flux. | Bruce | Approved |
| D-003 | 2026-10-23 | Use `release/abilities-review` in the book repo and merge area PRs into it. | Keeps `main` releasable while allowing area-by-area review. | Bruce | Approved |
| D-004 | 2026-10-23 | The CSV change ledger is authoritative; workbook Change Log sheets are capture views. | Excel binaries are not reviewable or merge-friendly. | Bruce | Approved |
| D-005 | 2026-10-23 | Stable IDs are required on every review row and every change. | Foundry UUIDs, web references and existing worlds depend on stable IDs. | Bruce | Approved |
| D-006 | 2026-10-23 | One Foundry sync PR after the final book release merge. | Foundry content is pinned to a book commit and cannot be updated earlier. | Bruce | Approved |
| D-007 | 2026-10-23 | Fast source audits still run per area; full builds do not. | Avoids accumulating broken links/IDs without doing incremental builds. | Bruce | Approved |
| D-008 | 2026-10-23 | Added Stable ID columns and a Change Log sheet to every content workbook. | Makes every review row traceable to a source card/trait and a field-level change. | Bruce | Implemented |
| D-009 | 2026-10-23 | The control set lives in `review/abilities/`, with `REVIEW_START_HERE.md` at the workspace root. | Keeps SOP, tracker, ledger, templates, baseline and release checklist together. | Bruce | Implemented |
| D-010 | 2026-10-23 | Created the GitHub scaffold: book epic #1283, Foundry tracker bruceamoser/heroes-of-legend-foundry#252, `release/abilities-review`, Universal issue #1284 and `codex/1284-universal`. | Establishes the reviewed release branch and first area without touching `main`. | Bruce | Implemented |

## Superseding a decision

Add a new row with a new ID, reference the old ID in the rationale, and mark the old row `Superseded by D-XXX`.
