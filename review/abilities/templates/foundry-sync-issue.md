# [Downstream] Abilities review — Foundry and Character Workshop sync

## Context

- Book epic: #<book-epic>
- Book release PR/tag/SHA: `<...>`
- SOP: `review/abilities/ABILITIES_REVIEW_SOP.md`
- Baseline pin: `review/abilities/BASELINE.md`

This issue is the downstream tracking issue for the final Foundry sync. It stays open until the Foundry release and Workshop deployment are verified.

## Scope

- Update the Foundry source pin to the final book release SHA.
- Regenerate `content/source-lock.json` and `content/source-baseline.json`.
- Update `docs/rules-authority.md`.
- Update count assertions/tests/docs if card/creature/summon/template counts changed.
- Run the affected content imports/validations.
- Run the full `npm run check`.
- Build/test the Character Workshop.
- Package and release Foundry.

## Content families affected

- [ ] Choices / abilities
- [ ] Inventory
- [ ] Creatures
- [ ] Summons
- [ ] Item packs
- [ ] Creature packs
- [ ] Web journals
- [ ] Native journals
- [ ] Nothing imported (book-only change)

## Acceptance criteria

- [ ] Source pin updated in `scripts/lock-book-sources.mjs`, lock and baseline.
- [ ] `docs/rules-authority.md` updated.
- [ ] Content imports/validations pass.
- [ ] `npm run check` passes.
- [ ] Workshop build/tests pass.
- [ ] Foundry package/release workflow passes.
- [ ] Install/upgrade/gameplay gates pass against the draft release.
- [ ] Workshop deployment verified.
- [ ] Final versions/SHAs/URLs recorded in `review/abilities/BASELINE.md`.

## Migration / compatibility

- Existing worlds affected: `<yes/no>`
- Migration notes: `<...>`
- Rollback pin: `<previous pin>`
