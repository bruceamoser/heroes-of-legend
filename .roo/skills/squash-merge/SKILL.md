---
name: squash-merge
description: Squash merge a pull request and clean up. Use when a PR is approved and ready to merge, needing to squash commits into a single clean commit on main, and delete the issue branch.
---

# Squash Merge

## When to Use
- PR has been reviewed and approved
- Ready to merge changes into main
- Need to clean up branches after merge

## Procedure

### 1. VERIFY — Pre-Merge Checklist
- [ ] PR has at least one approval.
- [ ] All review comments resolved.
- [ ] Build succeeds on the PR branch.
- [ ] No merge conflicts with main.
- [ ] CI checks pass (if configured).

### 2. MERGE — Squash and Merge
```bash
# Via gh CLI (preferred):
gh pr merge <PR-NUMBER> --squash --delete-branch

# Or manually:
git checkout main
git pull origin main
git merge --squash issue/<N>-<slug>
git commit -m "feat(#N): concise summary of all changes"
git push origin main
```

The squash merge combines all commits on the branch into a single clean commit on main. The commit message should be a conventional commit summarizing the entire PR.

### 3. CLEANUP — Delete Branch
```bash
# Delete remote branch:
git push origin --delete issue/<N>-<slug>

# Delete local branch:
git branch -d issue/<N>-<slug>
```

### 4. VERIFY — Post-Merge
```bash
git checkout main
git pull origin main
git status    # Should show clean
git log --oneline -5   # Confirm squash commit is there
```

### 5. CLOSE — Update Issue
The PR's `Closes #N` in the description should auto-close the issue. If not:
```bash
gh issue close <N> --comment "Merged in PR #<PR-NUMBER>"
```

## Commit Message for Squash
The squash commit message follows conventional format:

```
<type>(#N): <summary>

<optional body with details>

Closes #N
```

Examples:
```
feat(#42): add Fire spell chain (Firebolt → Fireball → Volcanic Eruption)

Added the complete Fire chain to chapter 11 with Novice/Adept/Master
tiers, Weak/Standard/Strong damage values, and cross-references to
@sec-magic-system and @sec-combat.

Closes #42
```

## Emergency Rollback
If something goes wrong after merge:
```bash
git revert -m 1 <merge-commit-hash>
git push origin main
```
Then create a new issue for the fix.
