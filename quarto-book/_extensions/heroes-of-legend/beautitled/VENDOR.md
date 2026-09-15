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

## The local patch (#552, current)

**File:** `src/lib.typ` — `chapter()` (the internal heading) and `beautitled-init` (the
level-1 heading interception).

Typst steps `counter(heading)` for every heading **element**, including the source heading
the package intercepts *and* the `_btl-internal` heading it emits in the show rule's
replacement content. Upstream compensates by undoing one of the two increments.

The undo's position is what matters, and it was wrong twice:

| Attempt | Effect |
|---|---|
| Upstream: undo **before** `chapter()` | labels read one chapter LOW (#467) |
| #467: undo **after** `chapter()` | labels correct, but the counter at the internal heading's own position read one chapter HIGH, and orange-book's `my-outline.typ` prints an entry number whenever the heading element has a numbering setting, so every row of the printed Contents carried a stray number one greater than the chapter (#552) |
| **#552 (current): no increment to undo** | the internal heading is stamped `numbering: none` |

```typst
// chapter(), from-init branch (and the place(hide[...]) branch below it)
[#heading(level: outline-level, outlined: true, bookmarked: true,
          numbering: none, outline-title) <_btl-internal>]
```

A heading carrying `numbering: none` **does not step `counter(heading)`** (verified in a
standalone `.typ` before the patch: the counter read the same value before and after such a
heading). So the internal heading contributes no increment at all and the level-1 undo in
`beautitled-init` is no longer emitted. Net effect on the running chapter count is unchanged
(the source heading's own step alone).

Two consequences, both wanted:

- The counter at the internal heading's position now reads the chapter's real number, so any
  consumer that reads it there (orange-book's outline) sees the right value.
- `my-outline.typ` renders an entry number only when `it.element.numbering != none`, so
  Contents rows now show exactly one number: the `Chapter N:` prefix the title already
  carries. The heading element itself stays `outlined: true` and `bookmarked: true`, so the
  entry, its page target and the PDF bookmark are unaffected.

Verified after the change: `check-toc-folios.py` 203/203 references correct; every
`Chapter N.` crossref in the body renders in range 1..25 with no `Chapter 0.`/`26.` tokens;
page count unchanged; chapter ornaments still read `Chapter XIII` (roman, from beautitled's
own `chapter-counter`, never touched by this).

## The local patch (#467 — SUPERSEDED, kept for the record)

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
**first**, every chapter label read **one chapter low**. Chapter ornaments and figure
prefixes were unaffected (they read beautitled's own `chapter-counter`), so the book
printed two different numberings for the same chapter:

| Indicator | Before | After |
|---|---|---|
| Chapter ornament | `Chapter VIII` | `Chapter VIII` |
| Figure prefix | `Figure 8.1` | `Figure 8.1` |
| `@sec-chapter-*` crossref | **`Chapter 7`** | **`Chapter 8`** |

That patch moved the undo to run *after* the `chapter()`/`part()` call. It fixed the
crossrefs but is the cause of #552 above, so #552 removed the undo and the increment it
compensated for. Note that the "table of contents was unaffected" claim in the original
version of this document was **wrong**: the Contents prints the title (`Chapter 8:`, from
beautitled's `chapter-counter`) *and* a separate number column, and it is that column that
comes from `counter(heading)`. Issue #552.

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
