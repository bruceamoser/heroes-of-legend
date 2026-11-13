# Health rewrite verification — November 12, 2026

Source issue: #1306. Foundry follow-up: bruceamoser/heroes-of-legend-foundry#269.
The first health/recovery implementation is based on main fc85158 (v16.9.0).
The published release is unchanged. Independent review is required before merge.

## Checked

- `python3 design/audit.py`: pass; current catalog fields, links, prices and grants.
- `python3 design/bestiary/audit.py`: pass; all 192 creatures, 126 monster abilities,
  73 summon references, attack/defense parity and existing CV arithmetic.
- `python3 scripts/audit_repository.py`: pass; current source links and authority.
- `python3 scripts/audit_health_revision.py`: pass; all ten ancestry and class HP
  contributions, six worked HP/SP/Grit examples, level arithmetic, identical shared
  recovery teaching, treatment limits and removal of contradictory procedures.
- Both Typst books compiled and both PDF audits passed with zero errors.
- Player book: 268 pages, 427 abilities, 45 equipment records, eight scar prompts,
  four consecutive printable sheets (258–261), no missing names/outcomes/art.
- DA book: 304 pages, 391 intact cards, 206 distinct interior assets, no text-bound
  findings; image compression preserves text, page count and links.

## Rendered review

Inspected player pages 9 (HP reference), 74–75 (full survival/recovery chapter),
241 (scars), and 260 (revised inventory/SP/first-aid/scar sheet). Inspected DA pages
31–32 (campaign survival and recovery) and 288 (scar prompts). Tables, examples,
page furniture and sheet fields are readable, unclipped and non-overlapping.
The sheet overflow found during editing is fixed. Old 280-result wound appendix
requirements are replaced by scar-reference coverage checks.

## Boundaries

These checks establish source consistency and document rendering, not combat or
resource balance. Existing discipline action-coverage observations are unchanged
and belong to the next Forge branch pass. The present catalog still uses the old
development structure outside the health-dependent changes. Full spellbook,
Spellcraft, martial branch and social encounter integration remains in
[the rewrite plan](rewrite-plan.md); do not represent it as implemented here.
No Hit Dice pool is introduced. Bruce explicitly approved writing first-playtest
numbers as direct rules without provisional labels in the player-facing text.
