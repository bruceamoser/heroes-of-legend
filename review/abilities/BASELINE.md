# Baseline — abilities review

Recorded before any review branch or source edit. Update the **Current** column only when a release actually lands; do not silently move the baseline.

## Repository baseline

| Item | Baseline value | Current |
|---|---|---|
| Book repository | `bruceamoser/heroes-of-legend` | — |
| Book `main` SHA | `9fe404119ddfad90ce52eb15b39e548a4a273bee` | same |
| Book version | `16.4.0` | same |
| Foundry repository | `bruceamoser/heroes-of-legend-foundry` | — |
| Foundry `main` SHA | `a4098a66624a166fdfb64dcc46a944f99f395380` | same |
| Foundry version | `2.3.5` | same |
| Foundry source pin | `bdfd18ed535fbd0e1892b9344444abf6da644809` | same |
| Workbook source commit | `9fe404119ddfad90ce52eb15b39e548a4a273bee` | same |
| Workbook generated | 2026-10-23 | — |
| Review release branch | `release/abilities-review` | not created |
| Target book version | TBD | — |
| Target Foundry version | TBD | — |

## Rollback point

- Previous book release/tag: record before release.
- Previous Foundry source pin: `bdfd18ed535fbd0e1892b9344444abf6da644809`.
- Previous Foundry release/tag: record before release.
- Previous Character Workshop deployment: record before release.

## Source-lock facts at baseline

These are the facts the Foundry sync must preserve or deliberately update:

- Source lock covers the book commit above.
- The lock script asserts content counts; any added/removed cards, creatures, summons or templates must update the assertions and tests.
- `scripts/lock-book-sources.mjs` currently hardcodes the commit, previous commit and approval text; it is not a parameter-only pin update.
- `content/source-lock.json`, `content/source-baseline.json` and `docs/rules-authority.md` all carry the pin/authority record.

## Baseline rule

If `main` moves before `release/abilities-review` is created, update this file to the new SHA and note why. After the release branch exists, merge `main` into it rather than recreating the branch.
