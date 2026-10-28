# Baseline: abilities review

Recorded before any review branch or source edit. Update the **Current** column only when a release actually lands; do not silently move the baseline.

## Repository baseline

| Item | Baseline value | Current |
|---|---|---|
| Workspace path | `/home/bmoser/OpenBaD/workspaces/heroes-of-legend` | active |
| Backup set | `backups/` | created |
| Book repository | `bruceamoser/heroes-of-legend` | — |
| Book `main` SHA | `9fe404119ddfad90ce52eb15b39e548a4a273bee` | same |
| Book version | `16.4.0` | `16.5.0` (tagged) |
| Book release | `v16.4.0` | `v16.5.0` at `295e858` |
| Foundry repository | `bruceamoser/heroes-of-legend-foundry` | — |
| Foundry `main` SHA | `a4098a66624a166fdfb64dcc46a944f99f395380` | same |
| Foundry version | `2.3.5` | same |
| Foundry source pin | `bdfd18ed535fbd0e1892b9344444abf6da644809` | same |
| Workbook source commit | `9fe404119ddfad90ce52eb15b39e548a4a273bee` | same |
| Workbook generated | 2026-10-23 | — |
| Book epic | — | [#1283](https://github.com/bruceamoser/heroes-of-legend/issues/1283) |
| Foundry tracking issue | — | [#252](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/252) |
| Review release branch | `release/abilities-review` | tagged `v16.5.0` |
| Control-set initial commit | — | `102dd0b` |
| Working book clone | — | `book/` |
| Target book version | TBD | `16.5.0` released |
| Target Foundry version | TBD | pending |

## Book release v16.5.0

- Release: https://github.com/bruceamoser/heroes-of-legend/releases/tag/v16.5.0
- Tag: `v16.5.0`, dereferences to `295e858c1b6fee044a0261bf9f437636efeff2bf`
- Branch: `release/abilities-review`
- Published: 2026-10-28, marked latest
- Assets: Player’s Book (259 pages), DA Guide & Bestiary (311 pages), starter-kit ZIP, manifest, SHA256SUMS
- Source clean: `source_dirty: false`

**Hashes**

```
c03bc3b522b5c5900ffe69d65e60acc125e3b3a40a4c186ef134fde79426bab2  Heroes-of-Legend-Players-Book.pdf
3039b01cd58f1ea6ff9a6c267972dc94d663cf5eab4deae1648a33bad54ce22b  Heroes-of-Legend-DA-Guide-and-Bestiary.pdf
fe3a99fa786105f3e888ae1844b33b285da25953a267670bc781b39a7c563e28  Heroes-of-Legend-Starter-Kit-v16.5.0.zip
357ab45c4183738c6bf25f737dc61ddc4f1452a9a6a134c5c68a451b4dc80294  manifest.json
```

**Verification**

- 354 class fields and 33 ancestry fields checked against the ledger, zero mismatches.
- All ten class pages link nine unique signatures.
- Design audit: 1,092 Markdown files, 419 cards, pass.
- Bestiary audit: 192 creatures, 244 attack choices, 126 monster abilities, 73 player references, pass.
- Bestiary art audit: 192 portraits, 0 errors.
- Repository audit: 1,108 Markdown files, links and source authority pass.
- Player-book audit: 259 pages, 471 ability outcomes checked, 0 errors.
- Rendered PDF spot checks: Earthbreaker, Mark the Quarry, In the Gap, Not Quite Yet, Mend, Step Between and Take the Wound present; Set Your Feet, Soft Landing, Between Them, Defiant Rescue and Gentle Return absent.

## Rollback point

- Previous book release/tag: `v16.4.0`.
- Previous Foundry source pin: `bdfd18ed535fbd0e1892b9344444abf6da644809`.
- Previous Foundry release/tag: record before release.
- Previous Character Workshop deployment: record before release.

## Source-lock facts at baseline

These are the facts the Foundry sync must preserve or deliberately update:

- Source lock covers the book commit above.
- The lock script asserts content counts; any added/removed cards, creatures, summons or templates must update the assertions and tests.
- `scripts/lock-book-sources.mjs` currently hardcodes the commit, previous commit and approval text; it is not a parameter-only pin update.
- `content/source-lock.json`, `content/source-baseline.json` and `docs/rules-authority.md` all carry the pin/authority record.

## Remaining production steps

1. Update the Workshop source pin and content imports; build and test the Workshop.
2. Publish the GitHub Pages site and verify the live ancestries and classes.
3. Update the Foundry source pin and content; run `npm run check`.
4. Verify all 90 signatures and 20 ancestry traits in Foundry.
5. Package and publish the new Foundry version; install/upgrade test.

## Baseline rule

If `main` moves before `release/abilities-review` is created, update this file to the new SHA and note why. After the release branch exists, merge `main` into it rather than recreating the branch.
