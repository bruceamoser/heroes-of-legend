# Change ledger schema

`CHANGE_LEDGER.csv` is the authoritative change record. The **Change Log** sheet in each workbook is a capture view; merge its rows into the CSV before opening the area PR.

## Columns

| Column | Required | Rule |
|---|---|---|
| `change_id` | Yes | `CHG-<AREA>-<NNN>`; never reuse an ID. |
| `area` | Yes | Area ID from `AREA_TRACKER.md`, e.g. `NOV-01` or `CLS-02`. |
| `stable_id` | Yes | Card/trait Stable ID. Never use a title in place of an ID. |
| `ability_or_trait` | Yes | Human-readable name at time of review. |
| `source_file` | Yes | Book path, e.g. `design/cards/conditioned-body.md`. |
| `field` | Yes | `Title`, `Rules`, `DP`, `Requirements`, `Tags`, `Action`, `Attribute`, `Target`, `Duration`, `Limits`, `Type`, `Narrative`, `Trait effect`, etc. |
| `original` | Yes | Exact source text before the change. Preserve punctuation. |
| `revised` | Yes | Exact proposed text after the change. |
| `change_type` | Yes | `Editorial`, `Wording`, `Mechanical`, `Rename`, `Add`, `Remove`, `Tier / DP`, `ID migration`. |
| `reason` | Yes | The problem being solved and the evidence. Link the issue/comment if useful. |
| `decision` | Yes | `Proposed`, `Approved`, `Rejected`, `Deferred`. |
| `approved_by` | Yes for Approved | Person who approved the change. |
| `playtest_status` | Yes | `Not needed`, `Pending`, `Passed`, `Failed`, `N/A`. Mechanical changes cannot be Approved without an explicit status. |
| `book_issue` | Yes | `#<number>` for the area book issue. |
| `foundry_issue` | When known | `#<number>` for the downstream Foundry tracking issue. |
| `commit_sha` | At merge | Book merge SHA. Leave blank until merged. |
| `date` | Yes | ISO `YYYY-MM-DD`. |
| `notes` | Optional | Migration, compatibility or follow-up notes. |

## Example row

```csv
CHG-NOV-001,NOV-01,conditioned-body,Conditioned Body,design/cards/conditioned-body.md,Limits,"At most one purchase at each level; missed purchases cannot be banked.","Maximum three purchases; each purchase costs 2 DP.",Mechanical,"Unbounded +1 max HP and a use-it-or-lose-it level tax.",Approved,Bruce,Pending,#1234,#5678,,2026-10-23,"Cap agreed; playtest at levels 5 and 7."
```

## One row per field

A title change and a rules change are two rows. A DP change and a requirement change are two rows. This keeps the diff reviewable and lets the release notes group changes by type.

## Merge procedure

1. Complete the workbook **Change Log** sheet for the area.
2. Export those rows (or copy them) into `CHANGE_LEDGER.csv`.
3. Check every approved source edit has a row and every row has a Stable ID.
4. Open the book area PR with the ledger filter/summary.
5. After merge, fill `commit_sha`.
6. After the Foundry sync, fill `foundry_issue`.

## Validation checks

- No duplicate `change_id`.
- No `Approved` row without `approved_by`.
- No `Mechanical` row without `playtest_status`.
- No `Rename` row without both original and revised titles.
- No `ID migration` row without migration notes in `notes`.
- Every `stable_id` resolves to a current source card/trait.
- Every `source_file` exists at the merge commit.
