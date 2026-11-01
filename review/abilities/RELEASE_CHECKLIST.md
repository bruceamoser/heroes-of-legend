# Release checklist — one build phase

Use this only after every area is landed in `release/abilities-review`. Do not run these steps per area.

## 0. Release gate

- [ ] All 18 areas `Done` in `AREA_TRACKER.md`.
- [ ] `CHANGE_LEDGER.csv` complete and reviewed.
- [ ] No unowned `Unsure` decisions.
- [ ] No Stable ID changes without migration notes.
- [ ] `main` merged into `release/abilities-review`; no unresolved conflicts.
- [ ] Fast source audits pass on the release branch.
- [ ] Target book and Foundry versions confirmed in `BASELINE.md`.
- [ ] Rollback points recorded.

## 1. Book release

- [ ] Open and merge the release PR `release/abilities-review` → `main`.
- [ ] Bump `release/version.json`.
- [ ] Write release notes for the new version.
- [ ] Run full audits:

```bash
python3 design/audit.py
python3 design/player-book/audit.py
python3 design/bestiary/audit.py
python3 design/bestiary/art/audit.py
python3 scripts/audit_repository.py
```

- [ ] Build both books and package the starter kit:

```bash
python3 scripts/build_starter_kit.py --require-clean
```

- [ ] Verify Player's Book PDF.
- [ ] Verify DA Book & Bestiary PDF.
- [ ] Verify manifest and checksums.
- [ ] Tag and publish the book release.
- [ ] Record final book tag/SHA in `BASELINE.md` and `AREA_TRACKER.md`.

## 2. Foundry source sync

- [ ] Create `issue/<n>-abilities-sync` from current Foundry `main`.
- [ ] Edit `scripts/lock-book-sources.mjs`: commit, previousCommit, approval.
- [ ] Run the lock script with `HOL_BOOK_REPOSITORY` pointing at the book checkout.
- [ ] Update `content/source-lock.json`.
- [ ] Update `content/source-baseline.json`.
- [ ] Update `docs/rules-authority.md`.
- [ ] Update count assertions/tests/docs if any card, creature, summon or template count changed.
- [ ] Run required imports and validations for the affected families.
- [ ] Run `npm run check`; paste output in the PR.
- [ ] Open Foundry sync PR with `Closes #<issue>` and book PR/tag/SHA.
- [ ] CI green; author review complete; squash merge.

## 3. Character Workshop

- [ ] Run `npm run build:workshop`.
- [ ] Run `npm run test:workshop-builder-view`.
- [ ] Merge Foundry PR; Pages workflow deploys from `main`.
- [ ] Verify deployed Workshop URL.
- [ ] Record deployment URL/verification in the release issue.

## 4. Foundry release

- [ ] Bump Foundry version.
- [ ] Write Foundry release notes.
- [ ] Run `npm run package:release`.
- [ ] Tag `v<version>`.
- [ ] Run release workflow.
- [ ] Complete install gate on a clean Foundry world.
- [ ] Complete upgrade gate from the previous release/world.
- [ ] Complete gameplay/content smoke gate.
- [ ] Publish release.
- [ ] Record release URL and final pin in `BASELINE.md`.

## 5. Close-out

- [ ] Close all area issues.
- [ ] Close book epic.
- [ ] Close Foundry tracking issue.
- [ ] Archive/finalize `CHANGE_LEDGER.csv`.
- [ ] Update `DECISION_LOG.md` with release decisions.
- [ ] Update `OPEN_QUESTIONS.md`; no open blockers.
- [ ] Announce release with links.

## Evidence log

| Gate | Result | Evidence link/output | Date |
|---|---|---|---|
| Book audits | — | — | — |
| Player's Book PDF | — | — | — |
| DA Book & Bestiary PDF | — | — | — |
| Starter-kit manifest/checksums | — | — | — |
| Foundry lock/baseline | — | — | — |
| Foundry content validations | — | — | — |
| `npm run check` | — | — | — |
| Workshop build/tests | — | — | — |
| Workshop deployment | — | — | — |
| Foundry package/release | — | — | — |
| Install gate | — | — | — |
| Upgrade gate | — | — | — |
| Gameplay smoke gate | — | — | — |

## Rollback

- Previous book tag/SHA: `<...>`
- Previous Foundry source pin: `bdfd18ed535fbd0e1892b9344444abf6da644809`
- Previous Foundry release/tag: `<...>`
- Previous Workshop deployment: `<...>`
- Rollback action: revert release PR/tag, restore Foundry pin, redeploy previous Workshop build. Do not patch generated packs.
