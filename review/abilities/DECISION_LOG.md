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
| D-011 | 2026-10-23 | Do not record a per-change playtest status. | The entire system is in playtesting; a per-change status is noise. | Bruce | Approved |
| D-012 | 2026-10-23 | Do not separately review ancestry trait pairs. | If the individual traits are well designed, the pairs work; the Pairs sheet remains reference guidance. | Bruce | Approved |
| D-013 | 2026-10-23 | After every item decision, show the complete final text before moving on. | Prevents advancing before the final wording has been reviewed and recorded. | Bruce | Approved |
| D-014 | 2026-10-23 | Halflings are Size Small with a 0.5 × 0.5 Foundry token footprint. | Needed for size-relative hiding and correct VTT token scaling; other ancestries are Medium. | Bruce | Approved |
| D-015 | 2026-10-23 | State what an ability does, not what it does not do. | Negative exclusions can imply that unmentioned actions are allowed. | Bruce | Approved |
| D-016 | 2026-10-23 | Ancestry review complete: all 20 traits approved; pairs are reference-only. | Traits are the design gate; pairs follow from well-designed traits. | Bruce | Approved |
| D-017 | 2026-10-23 | Positive-wording pass completed on six ancestry traits. | Implements D-015; final text states permissions rather than exclusions. | Bruce | Implemented |
| D-018 | 2026-10-23 | No em dashes anywhere. | Use commas, colons, parentheses or separate sentences. | Bruce | Approved |
| D-019 | 2026-10-23 | Blade review reset to baseline. | The backstab concept belongs to Shadow. Prior local Blade changes were discarded before commit. | Bruce | Implemented |
| D-020 | 2026-10-24 | Workspace moved to the new machine; Git worktrees repaired and patch backups created. | The worktrees pointed at the old `/home/bruce/...` path. All changes were preserved and backed up under `backups/`. | Bruce | Implemented |
| D-021 | 2026-10-24 | Blade signature review complete. | All nine Blade signatures approved locally. | Bruce | Approved |
| D-022 | 2026-10-24 | Intellect signature review complete. | All nine Intellect signatures approved locally. | Bruce | Approved |
| D-023 | 2026-10-24 | Leader signature review complete. | All nine Leader signatures approved locally. | Bruce | Approved |
| D-024 | 2026-10-27 | Moved the project into `/home/bmoser/OpenBaD/workspaces/heroes-of-legend`. | Keeps the project inside the OpenBaD workspaces tree; all worktrees were repaired and uncommitted changes preserved. The old path is a compatibility symlink. | Bruce | Implemented |
| D-025 | 2026-10-27 | Odd signature review complete. | All nine Odd signatures approved locally; 71 field-level change records. | Bruce | Approved |
| D-026 | 2026-10-27 | Book-facing text says "ability", never "card". | "Card" is design and production vocabulary; players read abilities. | Bruce | Approved |
| D-027 | 2026-10-27 | Record each approved signature immediately. | The area file, workbook and ledger must reflect a decision before the next signature is discussed; batching at the end of a class loses decisions. | Bruce | Approved |
| D-028 | 2026-10-27 | Protector signature review complete. | All nine Protector signatures approved locally; 62 field-level change records. | Bruce | Approved |
| D-029 | 2026-10-27 | Shadow signature review complete. | All nine Shadow signatures approved locally; 66 field-level change records. | Bruce | Approved |

## Superseding a decision

Add a new row with a new ID, reference the old ID in the rationale, and mark the old row `Superseded by D-XXX`.
