# Abilities review — release integration

## Summary

Integrates all completed abilities-review areas into `main` for the single build/release phase.

- Epic: #<epic>
- Areas: 18/18
- Change ledger: `review/abilities/CHANGE_LEDGER.csv`
- Release version: `<version>`

## Verification

- [ ] All areas `Done` in `review/abilities/AREA_TRACKER.md`.
- [ ] No unowned `Unsure` decisions.
- [ ] Change ledger complete.
- [ ] Fast source audits pass.
- [ ] `main` merged into `release/abilities-review`; no unresolved conflicts.
- [ ] No Stable ID changes without migration notes.
- [ ] Rollback point recorded in `review/abilities/BASELINE.md`.

## Build/release plan

This PR does not publish. After merge:

1. Bump book version and write release notes.
2. Build both books with `scripts/build_starter_kit.py --require-clean`.
3. Sync Foundry to the final book SHA.
4. Build/test/deploy Character Workshop.
5. Package and release Foundry.

## Area PRs

- [ ] Universal #
- [ ] Novice #
- [ ] Adept #
- [ ] Master #
- [ ] Dwarf #
- [ ] Elf #
- [ ] Halfling #
- [ ] Human #
- [ ] Arcanist #
- [ ] Blade #
- [ ] Intellect #
- [ ] Leader #
- [ ] Odd #
- [ ] Protector #
- [ ] Shadow #
- [ ] Shepherd #
- [ ] Unbalanced #
- [ ] Warden #
