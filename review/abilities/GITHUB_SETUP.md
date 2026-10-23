# GitHub setup — scaffold commands

## Status: completed 2026-10-23

The scaffold was created with the `bruceamoser` account:

- Book epic: #1283
- Foundry tracking issue: bruceamoser/heroes-of-legend-foundry#252
- Release branch: `release/abilities-review`
- First area issue: #1284 (`Universal`)
- First area branch: `codex/1284-universal`

The commands below are retained for future areas and for rebuilding the scaffold if needed.

## Pre-switch access check

Before the switch, the active account was `bmoser-pssolutions` and both repos reported:

```json
{"permissions":{"admin":false,"maintain":false,"pull":true,"push":false,"triage":false}}
```

That was read-only. Phase 0 required an account with `push: true` on both repos. Check with:

```bash
gh auth status
gh api repos/bruceamoser/heroes-of-legend --jq '.permissions.push'
gh api repos/bruceamoser/heroes-of-legend-foundry --jq '.permissions.push'
```

If the correct account is `bruceamoser`, switch with `gh auth switch --user bruceamoser` (or authenticate that account) and re-check. Do not create issues or branches until both checks return `true`.

## 1. Create labels

Create these labels in both repos (adjust colors as desired):

```text
area:universal, area:novice, area:adept, area:master,
area:ancestry, area:class, downstream:foundry,
needs-review, needs-playtest, release:16.x, blocked
```

## 2. Create the book epic

```bash
BOOK_EPIC_URL=$(gh issue create \
  --repo bruceamoser/heroes-of-legend \
  --title "[EPIC] Abilities review — <release>" \
  --body-file review/abilities/templates/book-epic.md)
BOOK_EPIC_NUM=${BOOK_EPIC_URL##*/}
echo "$BOOK_EPIC_URL"
```

Record the number in `review/abilities/BASELINE.md` and at the top of `review/abilities/AREA_TRACKER.md`.

## 3. Create the Foundry tracking issue

```bash
sed "s/#<book-epic>/#$BOOK_EPIC_NUM/g" \
  review/abilities/templates/foundry-sync-issue.md > /tmp/foundry-tracking.md

gh issue create \
  --repo bruceamoser/heroes-of-legend-foundry \
  --title "[Downstream] Abilities review — Foundry + Character Workshop sync" \
  --body-file /tmp/foundry-tracking.md
```

Record the Foundry issue number in `review/abilities/AREA_TRACKER.md` and `review/abilities/BASELINE.md`.

## 4. Create the book release branch

```bash
BOOK_MAIN_SHA=$(gh api repos/bruceamoser/heroes-of-legend/git/ref/heads/main --jq '.object.sha')
gh api --method POST repos/bruceamoser/heroes-of-legend/git/refs \
  -f ref=refs/heads/release/abilities-review \
  -f sha="$BOOK_MAIN_SHA"
```

Confirm it exists:

```bash
gh api repos/bruceamoser/heroes-of-legend/branches/release/abilities-review --jq '.name'
```

## 5. Create area issues

`review/abilities/AREAS.csv` is the machine-readable area list. To preview the commands without creating anything:

```bash
tail -n +2 review/abilities/AREAS.csv | while IFS=, read -r area_id category area_name workbook; do
  echo "gh issue create --repo bruceamoser/heroes-of-legend --title \"[$area_name] abilities review\" --body-file <rendered template>"
done
```

When ready, render `review/abilities/templates/book-area-issue.md` for each row, replacing:

- `<Area>` and `<area>` with the area name
- `<epic>` with `$BOOK_EPIC_NUM`
- `<workbook>` with the workbook filename
- `<AREA-ID>` with the area ID
- `<count>` with the review row count

Create one issue at a time and immediately fill the issue number and branch name in `review/abilities/AREA_TRACKER.md`. Do not batch-create 18 issues and leave the tracker blank.

## 6. Create the first area branch

Only after the area issue exists:

```bash
git fetch origin
git checkout release/abilities-review
git pull --ff-only origin release/abilities-review
git checkout -b codex/<issue>-<area>
```

## Write-access rule

If the permission check still returns `false`, stop. Record the blocker in `OPEN_QUESTIONS.md` and ask for access. Never create issues/branches from a read-only account or against a repo you do not own.
