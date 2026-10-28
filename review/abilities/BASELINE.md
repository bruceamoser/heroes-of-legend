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
| Foundry `main` SHA | `a4098a66624a166fdfb64dcc46a944f99f395380` | `314d3754b3758ff3ab3b1eecabb774df8bc5a566` |
| Foundry version | `2.3.5` | `2.5.0` (tagged) |
| Foundry source pin | `bdfd18ed535fbd0e1892b9344444abf6da644809` | `295e858c1b6fee044a0261bf9f437636efeff2bf` |
| Workbook source commit | `9fe404119ddfad90ce52eb15b39e548a4a273bee` | same |
| Workbook generated | 2026-10-23 | — |
| Book epic | — | [#1283](https://github.com/bruceamoser/heroes-of-legend/issues/1283) |
| Foundry tracking issue | — | [#252](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/252) |
| Review release branch | `release/abilities-review` | tagged `v16.5.0` |
| Control-set initial commit | — | `102dd0b` |
| Working book clone | — | `book/` |
| Target book version | TBD | `16.5.0` released |
| Target Foundry version | TBD | `2.5.0` released |

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

## Workshop and Foundry sync

- Foundry/Workshop PR: [#253](https://github.com/bruceamoser/heroes-of-legend-foundry/pull/253), squash-merged to `main` at `2f80951417f8827dff90f5cbc54b0ffd06626c4f`.
- Workshop Pages: https://bruceamoser.github.io/heroes-of-legend-foundry/ deployed from `2f80951`.
- Live `choices.json`: 521 records at `295e858`; Earthbreaker and Mend present.
- Character mancer catalogs: all 45 changed class signatures and all ancestry traits present; `npm run check` 709/709.
- Native journals: 1,018 pages at `295e858`; Protector, Shadow, Shepherd, Unbalanced, Warden and ancestry pages present; Earthbreaker, Mark the Quarry, Not My Flock, Mend and In the Gap in journal bodies.
- Runtime gates still need a live isolated Foundry world: character mancer creation/advancement/signature tests, native journal parity, landing, and install/upgrade.


## Foundry release v2.5.0

- Release: https://github.com/bruceamoser/heroes-of-legend-foundry/releases/tag/v2.5.0
- Tag: `v2.5.0`, dereferences to `314d3754b3758ff3ab3b1eecabb774df8bc5a566`
- Main after the release merge: `314d3754b3758ff3ab3b1eecabb774df8bc5a566`
- Assets: `heroes-of-legend.zip` (47609888 bytes), `system.json`, `SHA256SUMS`
- Checksums:

```
95da066b8ad60f517fa8fde40783ca55bf3ce58cf81a9c90b46cadf0630d62fe  system.json
eb80a18acb1287c3ee17e16a84d1a6dabc3d68ed4cb94848204a1df07fe50234  heroes-of-legend.zip
```

- Removed the `summon` Actor type, `SummonData`, `SummonSheet` and the 73-Actor `packs/summons` compendium. A summon is a standard `creature` Actor with `flags.heroes-of-legend.summon`; the creature sheet toggles **Use as summon** / **Return to creature**. The 73 profiles remain in `static/data/summons.json` and ship as `data/summons.json`.
- Authored content packs are now 656 files (419 abilities, 44 equipment, 192 creatures and the index). The release package is 510 files.
- The packaged zip was installed on Foundry 14.367. The Adder toggle smoke passed: standard `creature`, profile `summon-adder`, attacker outcomes, HP maximum 5, flag cleared, no page errors.
- `test:signature-choice` and `test:landing` remain green; the comprehensive `test:charactermancer`, `test:creation`, `test:advancement`, `test:creation-commit` and `test:native-parity` suites still need selector/fixture maintenance.

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

## Remaining follow-up work

1. Update the stale comprehensive runtime test selectors and fixtures (`test:charactermancer`, `test:creation`, `test:advancement`, `test:creation-commit`, `test:native-parity`).
2. Run those suites against the isolated Foundry 14.367 world and record the evidence.
3. Keep the Foundry host details and start/tunnel procedure in `WORKSPACE_REFERENCE.md`.

## Baseline rule

If `main` moves before `release/abilities-review` is created, update this file to the new SHA and note why. After the release branch exists, merge `main` into it rather than recreating the branch.
