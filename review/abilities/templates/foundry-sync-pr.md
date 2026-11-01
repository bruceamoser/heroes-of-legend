# Sync Foundry to book <version>

## Summary

- Book release PR/tag/SHA: `<...>`
- Foundry issue: #<issue>
- Source pin: `<old>` → `<new>`
- Content families: `<...>`

Closes #<issue>

## Pin and lock

- [ ] `scripts/lock-book-sources.mjs` commit/previousCommit/approval updated.
- [ ] `content/source-lock.json` regenerated.
- [ ] `content/source-baseline.json` updated.
- [ ] `docs/rules-authority.md` updated.
- [ ] Count assertions/tests/docs updated where needed.

## Content and checks

- [ ] Required imports run.
- [ ] Required validations pass.
- [ ] `npm run check` passes.
- [ ] Workshop build/tests pass.
- [ ] No generated pack hand-edits.

Paste check output here:

```text
<output>
```

## Release

- [ ] Version and release notes updated.
- [ ] `npm run package:release` passes.
- [ ] Release workflow/tag gates pass.
- [ ] Install/upgrade/gameplay gates pass.

## Rollback

Revert this PR or re-pin to `<old>`; do not patch generated packs.
