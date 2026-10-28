# Move to Production SOP

**Purpose:** turn an approved review record into a shipped book, web app and Foundry release. Use this for ancestries and class signatures now, and repeat it for each general-ability area as those reviews complete.

**Authority:** an explicit decision in the conversation, then `review/abilities/CHANGE_LEDGER.csv`, then the area briefs. Workbooks, trackers and summaries are derived reports. If they disagree with the ledger, correct them; do not trust them.

**Scope of this pass:** ANC-01 through ANC-04 and CLS-01 through CLS-10. General abilities (Universal, Novice, Adept, Master) are separate later passes.

---

## 0. Preflight and rollback point

1. Confirm every area in scope is `Approved` or `Done`, with no open `Unsure`.
2. Confirm the ledger has one approved row per changed field, and that the area brief matches it.
3. Confirm the repository root is clean on `release/abilities-review`.
4. Record the rollback point:
   - book commit and last release tag;
   - Foundry commit and current source pin;
   - Workshop deployment URL and commit.
5. Record the target version. A content release is a minor bump unless the rules break compatibility.
6. Do not edit book, Foundry or Workshop in parallel with the review record.

**Gate:** clean tree, known rollback point, version chosen, scope fixed.

---

## 1. Apply the approved changes to the book

1. Apply only fields recorded as `Approved` in `CHANGE_LEDGER.csv`.
2. Preserve Stable IDs and card filenames. Rename titles, not IDs.
3. Update:
   - `design/cards/*.md` for class signatures;
   - `design/ancestries/*.md` for traits;
   - `design/classes/*.md` for signature bullet lists and identity text;
   - `design/catalog.md` via `python3 design/index.py`;
   - `design/player-book/ability-summaries.json` for every renamed or re-summarized card.
4. Do not hand-edit generated indexes, PDFs, Foundry packs or Workshop build output.
5. Use book-facing wording: write “ability”, not “card”. No em dashes.

**Gate:** every approved row has a corresponding source edit; no unapproved edit exists.

---

## 2. Verify the book source against the record

Run a field-by-field check, not a spot check:

- For every `Approved` ledger row, confirm the current book card field equals the latest approved `revised` value for that `(stable_id, field)`.
- Confirm every Stable ID in the ledger exists in the book and in the class or ancestry page.
- Confirm each class page links all nine signatures and each ancestry page links all five traits.
- Confirm `catalog.md` contains every current title and no retired title.
- Run the fast audits:

```sh
python3 design/audit.py
python3 design/player-book/audit.py
python3 design/bestiary/audit.py
python3 design/bestiary/art/audit.py
python3 scripts/audit_repository.py
```

**Gate:** zero field mismatches, zero missing IDs, zero broken links, all audits pass.

---

## 3. Commit and build the book and starter kit

1. Bump `release/version.json` and write `release/notes.md`.
2. Commit the source, version and notes on `release/abilities-review`; merge the release PR to `main` when the full review is ready. For an area pass, commit on the release branch and keep the release PR gated.
3. Build both books and the starter kit:

```sh
TYPST=/path/to/typst python3 scripts/build_starter_kit.py
```

4. Inspect rendered pages; verify both PDFs, page counts, manifest, `SHA256SUMS.txt` and the starter-kit ZIP.
5. Tag `v<version>` and publish the GitHub Release with both PDFs, the ZIP, `manifest.json` and `SHA256SUMS.txt`.

**Gate:** build exits 0, both PDFs present, checksums match, release assets complete, rendered pages inspected.

---

## 4. Apply the same changes to the web app (Character Workshop)

1. In the Foundry repo, update the book pin:
   - `content/source-lock.json`;
   - `content/source-baseline.json`;
   - `docs/rules-authority.md`.
2. Run the content imports the change needs. At minimum for card text:

```sh
npm run import:choices
npm run validate:choices
npm run import:inventory
npm run validate:inventory
npm run import:web-journals
```

3. Build and test the Workshop:

```sh
npm run build:workshop
npm run test:workshop-builder-view
```

4. Spot-check each changed ancestry and class in the local Workshop: titles, IDs, requirements, rules text.

**Gate:** imports and validations pass, Workshop build and test pass, spot checks match the book.

---

## 5. Publish the GitHub Pages web app

1. Merge the Foundry PR to `main`; the Pages workflow deploys the Workshop.
2. Verify the deployed URL: all four ancestries, all ten classes, every signature and trait.
3. Record the deployment URL and commit SHA in `review/abilities/BASELINE.md`.

**Gate:** Pages deployment green, live site matches the local build, no broken links.

---

## 6. Apply the same changes to the Foundry system

1. Create the sync branch from current Foundry `main`.
2. Update the source pin with `scripts/lock-book-sources.mjs`.
3. Update `content/source-lock.json`, `content/source-baseline.json` and `docs/rules-authority.md`.
4. Run the content imports and validations for the changed families:

```sh
npm run import:choices && npm run validate:choices
npm run import:inventory && npm run validate:inventory
npm run import:web-journals
npm run import:native-journals
npm run import:wounds && npm run validate:wounds
```

5. Run the full gate:

```sh
npm run check
```

**Gate:** `npm run check` green; no missing or duplicate content; source pin equals the book release commit.

---

## 7. Verify every change landed in Foundry

1. Compare counts and IDs against the book: 90 class signatures and 20 ancestry traits in scope for this pass.
2. For each class, confirm all nine signatures exist with the current title, Stable ID, level, DP, requirements and rules text.
3. For each ancestry, confirm all five traits exist with the current title, Stable ID and rules text.
4. Confirm no retired title or old rules text remains.
5. Confirm existing actors and worlds still resolve their UUID links.
6. Record the verification output in the Foundry PR and `review/abilities/BASELINE.md`.

**Gate:** automated comparison clean, manual class/ancestry checklist complete, no orphan or duplicate items.

---

## 8. Publish a new Foundry version

1. Bump the Foundry version and write release notes.
2. Run:

```sh
npm run package:release
```

3. Tag `v<version>` and run the release workflow.
4. Run the documented install, upgrade and gameplay gates against the draft release.
5. Publish the release and record the URL and final source pin in `review/abilities/BASELINE.md`.

**Gate:** draft release installs, upgrades an existing world, all class/ancestry content resolves, release assets complete.

---

## Rollback

- **Book:** revert the release PR/tag and restore the previous tag; do not rewrite published history.
- **Workshop:** redeploy the previous Pages build from the previous Foundry commit.
- **Foundry:** re-pin the previous source commit and revert the release branch; do not patch generated packs by hand.

## Repeat rule

Run this SOP once per approved area or batch. Do not start general abilities until the current batch has passed steps 2, 3, 6 and 7. The review record is not “done” until the book, Workshop and Foundry all agree with it.
