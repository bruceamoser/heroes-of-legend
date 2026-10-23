# <Area> abilities review

## Summary

- Area: `<area>`
- Issue: #<issue>
- Workbook: `review/abilities/workbooks/<workbook>.xlsx`
- Decisions: `<n>`
- Change rows: `<n>`

## Changes

- [ ] Source cards/traits updated.
- [ ] Generated indexes/summaries regenerated.
- [ ] Class/ancestry links updated where titles changed.
- [ ] No Stable ID changes, or ID migration documented.

## Checks

```text
python3 design/audit.py
python3 design/player-book/audit.py
python3 design/bestiary/audit.py
python3 design/bestiary/art/audit.py
python3 scripts/audit_repository.py
```

Paste results here:

```text
<audit output>
```

## Ledger

- [ ] Workbook Change Log rows exported/merged to `review/abilities/CHANGE_LEDGER.csv`.
- [ ] Every approved source edit has a matching ledger row.

## Downstream note

- Foundry families affected: `<...>`
- Character Workshop impact: `<...>`
- This PR does **not** update the Foundry source pin; that happens in the release phase.

## Rollback

Revert this PR; no generated packs or release artifacts are affected.
