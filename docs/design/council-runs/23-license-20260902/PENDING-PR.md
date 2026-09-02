# PENDING PR — ch23 license disposition (open when a GitHub credential is available)

Status: branch `fix/council-ch23-20260902` is committed locally, build green (exit 0), rebased on
the latest local main. Diff vs main = ONLY `quarto-book/chapters/23-license.qmd`.

To open the PR (next session, with valid `gh`/git auth):
    cd ~/repos/heroes-of-legend
    git push origin main                      # pushes the process files + audit trail
    git push -u origin fix/council-ch23-20260902
    gh pr create --head fix/council-ch23-20260902 \
        --title "council ch23 (rejected 7-0): license disposition - single pagebreak, Shadow in PI list, OGC OGL-1.0a notice" \
        --body-file docs/design/council-runs/23-license-20260902/PENDING-PR-BODY.md
    # then: Winston audit (chapters/ only, 0 em-dashes, 0 damage dice, build exit 0),
    #       gh pr merge <n> --squash --delete-branch, git worktree/branch cleanup.

## PR title
council ch23 (rejected 7-0): license disposition - single pagebreak, Shadow in PI list, OGC OGL-1.0a notice

## PR body
Council ch23 (License) disposition, from the hol-rulebook Synod run 20260902-2006 (REJECTED 7-0).

Three chapter-local edits to quarto-book/chapters/23-license.qmd only:

1. (mechanical, layout) Remove one of the two back-to-back `{{< pagebreak >}}` directives before the OGL heading. The double break produced a wholly blank sheet: in the prior build, printed p.369 held only the running header and folio and the OGL heading was pushed to p.370. Sibling chapters (ch20, ch22) sit intro text between their two breaks, so this is chapter-local, not a book-wide convention. Verified in the rebuilt PDF: the blank sheet is gone (376 -> 375 pages) and the OGL heading now opens printed p.369 directly.
2. (mechanical, canon) Add the ninth class name Shadow to the Product Identity class enumeration (line 69), which named only eight of the book's nine classes (ch05). A core class name was left unclaimed as Product Identity.
3. (legal default, veto to revert) The Open Game Content Declaration now states the designated material "may only be Used under and in terms of the Open Game License Version 1.0a set out above". OGL section 2 requires that notice on OGC and the section 4 grant only activates with it; the prior designation was a bare label. Standard OGL 1.0a designation phrasing. Logged in decisions-pending.md as an implemented default (#66).

Audit (branch ref, not self-report):
- Files changed: quarto-book/chapters/23-license.qmd only.
- Em-dashes in added lines: 0.
- Damage dice: 0 (the single d-pattern hit is the pre-existing "3d6 core resolution system" in the OGC list, not a damage die).
- Build: cd quarto-book && ./build.sh -> exit 0; PDF produced.
