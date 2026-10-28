# Abilities Review — Standard Operating Procedure

**Version:** 1.0  
**Date:** 2026-10-23  
**Owner:** Bruce  
**Repos:** `bruceamoser/heroes-of-legend` (book, authoritative) and `bruceamoser/heroes-of-legend-foundry` (Foundry system + Character Workshop)

---

## 1. Purpose and scope

Review and revise the six ability categories through the 18 content workbooks (plus the index workbook):

1. Universal abilities
2. Novice abilities
3. Adept abilities
4. Master abilities
5. Ancestries — Dwarf, Elf, Halfling, Human
6. Classes — Arcanist, Blade, Intellect, Leader, Odd, Protector, Shadow, Shepherd, Unbalanced, Warden

The review covers 419 cards, 20 ancestry traits, 90 class signatures and the shared ability catalog. It produces:

- Approved book Markdown changes.
- One book area PR per area.
- One final book release integration.
- One Foundry sync PR after the book is landed.
- A rebuilt book, Character Workshop and Foundry release.

## 2. Non-negotiable rules

1. **The book Markdown is authoritative.** The Excel workbooks and `review/abilities/` are review artifacts, not a rules source.
2. **No incremental builds.** Do not build the PDF, Foundry content or Character Workshop per area. Run fast source audits only.
3. **One area at a time.** Finish and merge an area before starting the next.
4. **Stable IDs are the contract.** Rename titles freely; never change a Stable ID without an explicit ID migration and migration notes.
5. **Every change is logged.** No source edit without a matching row in `CHANGE_LEDGER.csv`.
6. **The book lands first.** Foundry content is pinned to the final book commit. Do not update Foundry content before the book release merge.
7. **No generated pack edits.** Generated Foundry packs, generated book indexes and generated workbook content are not authoring sources.
8. **Main stays releasable.** Area work merges into `release/abilities-review`, not directly into `main`.
9. **Write permissions, not exclusions.** State what an ability does. Avoid “does not…” clauses; they can imply that unmentioned actions are allowed.
10. **No em dashes.** Use commas, colons, parentheses or separate sentences. This applies to all new and edited text.

## 3. Roles

| Role | Responsibility |
|---|---|
| **Bruce — final approver** | Approves rules changes, policy exceptions, version bump and release. |
| **Area reviewer** | Works the workbook, proposes changes, records decisions and evidence. |
| **Book implementer** | Applies approved changes to book Markdown, regenerates indexes, runs audits, opens the book PR. |
| **Foundry implementer** | Updates the source pin, regenerates content, runs Foundry checks, opens the Foundry PR. |
| **Release owner** | Runs the final build/release checklist and publishes. |

Supporting records: `AREA_TRACKER.md` (status), `BASELINE.md` (SHAs/versions/pin), `DECISION_LOG.md` (process decisions), `OPEN_QUESTIONS.md` (blockers), `WORKBOOK_MANIFEST.csv` (file map).

One person may hold several roles. The approver must be explicit for every mechanical change.

## 4. Branch and release model

```text
book main
  └── release/abilities-review
        ├── codex/<book-issue>-universal
        ├── codex/<book-issue>-novice
        ├── codex/<book-issue>-adept
        ├── codex/<book-issue>-master
        ├── codex/<book-issue>-ancestry-<name>
        └── codex/<book-issue>-class-<name>
              ↓ area PRs reviewed and merged
        release/abilities-review
              ↓ one release PR after all areas land
        book main
              ↓ build book + release
        Foundry source pin
              ↓ one Foundry sync PR
        Foundry main
              ↓ build Workshop + package/release Foundry
```

- Book area branches: `codex/<issue>-<area>`.
- Foundry branch: `issue/<issue>-abilities-sync`.
- Do **not** create branches off other feature branches. Area branches come from `release/abilities-review`.
- Merge `main` into `release/abilities-review` regularly so the release branch does not drift.
- Delete area branches after merge.

## 5. Phase 0 — setup, once

1. Confirm write access to both repos and GitHub issue/branch permissions. See `GITHUB_SETUP.md` for the exact checks and commands.
2. Create the book **epic issue** from `templates/book-epic.md`. Include scope, target versions, links to all 18 content workbooks, definition of done and a link to this SOP.
3. Create the Foundry **tracking issue** from `templates/foundry-sync-issue.md`. It references the book epic and stays open until the Foundry release.
4. Create `release/abilities-review` from current book `main`.
5. Record the baseline in `BASELINE.md`: book SHA, Foundry SHA, versions and source pin.
6. Fill in the area rows in `AREA_TRACKER.md` with issue numbers and branch names as they are created.
7. Confirm the release version numbers and write them in `BASELINE.md`.

## 6. Phase 1 — area cycle

Recommended order: Universal → Novice → Adept → Master → ancestries → classes. Shared abilities inform the class and ancestry review.

### 6.1 Create the area issue and branch

1. Create the book area issue from `templates/book-area-issue.md`.
2. Add labels: `area:<category>`, `tier:<tier>` where relevant, `needs-review`, `release:<version>`.
3. Create `codex/<issue>-<area>` from `release/abilities-review`.
4. Add the row to `AREA_TRACKER.md` with owner and status `In review`.

### 6.2 Review the workbook

1. Work through every row. Use `Decision` (`Keep`, `Revise`, `Cut`, `Unsure`).
2. For every `Revise` or `Cut` decision, add a change row to the workbook's **Change Log** sheet.
3. Record: Stable ID, source file, field, original, revised, change type, reason, decision and approver.
4. Mechanical changes require explicit Bruce approval. The whole system is in playtesting, so no per-change playtest status is recorded.
5. Export or merge the area rows into `review/abilities/CHANGE_LEDGER.csv` before opening the PR.
6. **Before moving to the next row, show the complete final text** — title, narrative and rules — for confirmation. Record the decision, then move on.
7. Record each approved signature immediately in the area file, the workbook row and Change Log, and `CHANGE_LEDGER.csv`. Do not defer recording to the end of the class.

### 6.3 Apply the book changes

Apply only approved changes to the book Markdown. Then regenerate/inspect the affected generated artifacts:

- `python3 design/index.py` — catalog and discipline/equipment/recipe indexes. Required when titles, DP, requirements or card membership change.
- Update `design/player-book/ability-summaries.json` when a card's one-line summary changes.
- Update class/ancestry link text when a card title changes.
- Run the fast source audits:

```bash
python3 design/audit.py
python3 design/player-book/audit.py
python3 design/bestiary/audit.py
python3 design/bestiary/art/audit.py
python3 scripts/audit_repository.py
```

Do **not** run the full PDF build, Foundry imports, Character Workshop build or Foundry package in this phase. Those are release-phase actions.

### 6.4 Open and merge the book PR

1. Commit with the area name and Stable IDs in the message.
2. Open the PR into `release/abilities-review` using `templates/book-area-pr.md`.
3. Paste audit output and the `CHANGE_LEDGER.csv` filter/summary into the PR.
4. The book repo requires independent review. Resolve comments and squash merge.
5. Record the merge SHA in `AREA_TRACKER.md`.
6. Update the book issue with the PR link, merge SHA, audit evidence and any deferred items.

### 6.5 Move on

Do not start the next area until the previous area is merged into `release/abilities-review`. Keep Foundry untouched until Phase 3.

## 7. Phase 2 — release gate

All of the following must be true before the release PR:

- [ ] All 18 areas are `Done` in `AREA_TRACKER.md`.
- [ ] Every workbook row has a final decision; no unowned `Unsure`.
- [ ] `CHANGE_LEDGER.csv` is complete and exported.
- [ ] All area PRs are merged into `release/abilities-review`.
- [ ] `main` has been merged into the release branch; no unresolved conflicts.
- [ ] Fast source audits pass on the release branch.
- [ ] No Stable ID changes without migration notes.
- [ ] Release version and release notes are drafted.
- [ ] Rollback point (previous book tag/SHA and Foundry source pin) is recorded.

Then open the **release PR** from `release/abilities-review` to `main`. This is an integration PR, not a re-review of every card. Link all area PRs and the completed ledger.

## 8. Phase 3 — build and release, once

### 8.1 Book

1. Merge the release PR to `main`.
2. Bump `release/version.json` and write `release/notes.md` (or the current release-note file).
3. Run the full book audit/build:

```bash
python3 design/audit.py
python3 design/player-book/audit.py
python3 design/bestiary/audit.py
python3 design/bestiary/art/audit.py
python3 scripts/audit_repository.py
python3 scripts/build_starter_kit.py --require-clean
```

4. Verify **both** the Player's Book and the DA Book & Bestiary, the starter-kit manifest and checksums.
5. Tag and publish the book release. Record the final book SHA/tag in `BASELINE.md` and `AREA_TRACKER.md`.

### 8.2 Foundry source sync

1. Create `issue/<n>-abilities-sync` from current Foundry `main`.
2. Edit `scripts/lock-book-sources.mjs`:
   - `commit` = final book merge SHA
   - `previousCommit` = previous pin
   - `approval` = the new release/approval note
3. Run:

```bash
HOL_BOOK_REPOSITORY=/path/to/heroes-of-legend node scripts/lock-book-sources.mjs
```

4. Update `content/source-lock.json`, `content/source-baseline.json` and `docs/rules-authority.md` to the new pin.
5. Update count assertions/tests/docs if cards, creatures, summons or templates changed.
6. Run the content imports/validations required by the changed families. At minimum for card/text changes:

```bash
npm run import:choices
npm run validate:choices
npm run import:inventory
npm run validate:inventory
npm run import:web-journals
npm run import:native-journals
```

Add creature, summon, item-pack and creature-pack imports/validations if those families changed.

7. Run the full Foundry gate:

```bash
npm run check
```

This includes the build, content validations and the full test suite. Do not proceed on red.

8. Open the Foundry PR with `templates/foundry-sync-pr.md`, including `Closes #<tracking-issue>`, the book PR/tag/SHA and the source-lock diff.
9. Author review is acceptable in the Foundry repo per its `AGENTS.md`; CI must still be green. Squash merge.

### 8.3 Character Workshop (web app)

1. Run the Workshop build and tests:

```bash
npm run build:workshop
npm run test:workshop-builder-view
```

2. Merge the Foundry PR. The Pages workflow deploys the Workshop from `main`.
3. Verify the deployed site and record the URL/verification in the release issue.

### 8.4 Foundry release

1. Bump the Foundry version and write release notes.
2. Run:

```bash
npm run package:release
```

3. Tag `v<version>` and run the release workflow.
4. Complete the documented install, upgrade and gameplay gates against the draft release.
5. Publish. Record the release URL and final pin in `BASELINE.md`.

## 9. Change ledger protocol

`review/abilities/CHANGE_LEDGER.csv` is authoritative. The workbook **Change Log** sheets are capture views. Column rules and validation checks are in `review/abilities/CHANGE_LEDGER_SCHEMA.md`.

Required columns:

`change_id, area, stable_id, ability_or_trait, source_file, field, original, revised, change_type, reason, decision, approved_by, book_issue, foundry_issue, commit_sha, date, notes`

Rules:

- One row per field-level change. A card with three fields changed gets three rows.
- Use the Stable ID, not only the title.
- `change_type`: Editorial, Wording, Mechanical, Rename, Add, Remove, Tier / DP, ID migration.
- `decision`: Proposed, Approved, Rejected, Deferred.
- Mechanical changes cannot be `Approved` without an explicit approver.
- Before the area PR, merge the workbook rows into the CSV and validate that every approved source edit has a row.

## 10. Definition of done

### Area done

- All workbook rows decided.
- Change ledger complete for the area.
- Approved changes applied to book Markdown.
- Generated indexes/summaries updated.
- Fast source audits pass.
- Book PR reviewed and squash-merged into `release/abilities-review`.
- Book issue updated with PR/SHA/evidence.
- Area tracker status `Book merged`.

### Release done

- All areas done.
- Release PR merged to `main`.
- Book built, both PDFs verified, versioned, tagged and published.
- Foundry source pin updated, lock/baseline/docs updated.
- Foundry content imports/validations pass.
- `npm run check` passes.
- Workshop builds, tests and deploys.
- Foundry package, release workflow and install/upgrade/gameplay gates pass.
- Epics closed; final SHAs, versions and URLs recorded in `BASELINE.md`.

## 11. Risk controls

| Risk | Control |
|---|---|
| Long-lived release branch drifts | Merge `main` into `release/abilities-review` regularly; rerun audits before release PR. |
| Foundry sync reveals many failures at once | Reserve a stabilization window; run Foundry checks early in Phase 3; split the sync PR into logical commits. |
| Stable ID accidentally changed | Require an explicit ID-migration change row and Foundry UUID check. |
| Excel edits diverge from source | CSV ledger is authoritative; export before each area PR; regenerate workbooks from source. |
| Book and Foundry disagree | Foundry is pinned; never update Foundry before the book merge. |
| Generated artifacts overwritten | Treat `design/index.py` outputs and Foundry packs as generated; do not hand-edit. |
| Existing worlds break | Test upgrade from the previous release; document migration/compatibility in release notes. |

## 12. Rollback

- Record the previous book tag/SHA and Foundry source pin in `BASELINE.md` before the release.
- If Foundry validation fails, revert or re-pin the Foundry PR; do not patch generated packs.
- If the book release is bad, revert the release PR/tag and restore the previous Foundry pin.
- Do not rewrite history on `main` or a published release.

## 13. Source references

- Book workflow and branch naming: `heroes-of-legend/AGENTS.md`, `.github/copilot-instructions.md`
- Book build/release: `design/player-book/README.md`, `release/README.md`
- Foundry workflow: `heroes-of-legend-foundry/AGENTS.md`
- Source pin: `content/source-lock.json`, `docs/rules-authority.md`, `scripts/lock-book-sources.mjs`
- Character Workshop: `scripts/build-workshop.mjs`, `.github/workflows/pages.yml`, package scripts `build:workshop` and `test:workshop-builder-view`
- Foundry validation: `.github/workflows/validate.yml`, `npm run check`
- Foundry release: `.github/workflows/release.yml`, `npm run package:release`


## 14. Revision history

| Version | Date | Change |
|---|---|---|
| 1.0 | 2026-10-23 | Initial batch-build SOP: release branch, area audits, one final book/Foundry/Workshop build phase. |
