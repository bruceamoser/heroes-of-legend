---
name: squash-merge
description: Merge approved work for Heroes of Legend.
---

# Merge approved work

Verify independent approval, current head, clean checks and no conflicts. Bruce’s explicit chat approval counts. Squash merge with gh pr merge --squash --delete-branch --match-head-commit <reviewed-sha>. Fetch main, verify the resulting commit and linked issue closure. Preserve Git history. Do not use git revert -m for a squash commit; a squash is an ordinary single-parent commit.

Follow [project instructions](../../../.github/copilot-instructions.md).
