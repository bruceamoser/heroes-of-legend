# Vendored: beautitled 0.2.7

This directory is a **verbatim copy** of the `beautitled` Typst package, plus one local
patch. It is vendored rather than pulled from Typst Universe so the patch cannot be lost
when Quarto re-resolves packages into `.quarto/typst/packages/` (a cache).

| | |
|---|---|
| Package | beautitled 0.2.7 |
| Author | Nathan Scheinmann |
| License | MIT (see `LICENSE`) |
| Upstream | https://github.com/nathan-ed/typst-package-beautitled |
| Entrypoint | `src/lib.typ` |
| Imported from | `_extensions/heroes-of-legend/style.typ` |

## The local patch

**File:** `src/lib.typ`, in `beautitled-init` (the level-1 heading interception).

The package intercepts each level-1 heading so a chapter is not numbered twice: it
**undoes** Typst's automatic `counter(heading)` increment on the source heading, then
emits its own `_btl-internal` heading which does the real counting.

```typst
// upstream order
counter(heading).update((..args) => { ... -1 ... })   // undo
context { chapter(it.body, from-init: true) }         // internal heading, +1
```

A label attached to a heading resolves the counter at that label's position, and the
label ends up sitting on the show rule's replacement content. Because the undo ran
**first**, every chapter label read **one chapter low**. Chapter ornaments and the table
of contents were unaffected (they read beautitled's own `chapter-counter`), so the book
printed two different numberings for the same chapter:

| Indicator | Before | After |
|---|---|---|
| Chapter ornament | `Chapter VIII` | `Chapter VIII` |
| Table of contents | `Chapter 8` | `Chapter 8` |
| Figure prefix | `Figure 8.1` | `Figure 8.1` |
| `@sec-chapter-*` crossref | **`Chapter 7`** | **`Chapter 8`** |

**The patch** moves the undo to run *after* the `chapter()`/`part()` call, so the label
resolves before the undo and reads the chapter's real number. The net effect on the
running counter is unchanged (the original heading's +1, the internal heading's +1, and
the undo's -1 still total +1 per chapter).

Passing the label into `chapter(label:)` instead does **not** work: the heading's own
label persists through the show rule, producing
`error: label <sec-chapter-x> occurs multiple times in the document`.

## Re-vendoring on upgrade

If beautitled is upgraded, re-copy the new version over this directory and re-apply the
patch above, **or** drop the vendored copy and restore the `@preview/beautitled:<ver>`
import in `style.typ` if upstream has fixed it. Track upstream:
https://github.com/nathan-ed/typst-package-beautitled

Import path is relative to the Quarto compile root (`quarto-book/`), not to `style.typ`:

```typst
#import "_extensions/heroes-of-legend/beautitled/src/lib.typ": *
```
