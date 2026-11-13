---
name: squash-merge
description: Merge reviewed book PRs for Heroes of Legend.
---

# Merge reviewed work

Verify the current head matches the reviewed commit, checks pass, findings are resolved and GitHub allows the merge. Bruce’s standing authorization covers this merge. Ask Bruce if a decision or unresolved concern requires his judgment. Squash merge with `gh pr merge --squash --delete-branch --match-head-commit <reviewed-sha>`. Fetch `main`, verify the resulting commit and confirm linked issue closure. Preserve Git history. Revert a squash commit as an ordinary single-parent commit if a rollback is needed.

Follow [project instructions](../../../.github/copilot-instructions.md).
