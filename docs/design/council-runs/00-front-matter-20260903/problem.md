# HOL Council — ch00 Front Matter

Chapter under review: ch00 (quarto-book/chapters/00-front-matter.qmd), "Front Matter"
(title page, copyright block, cover-art placeholder, Credits, Dedication), 56 lines.
First chapter of the book; the book's title page and legal notice. First pending
chapter of Wave 2 (all of Wave 1 is reviewed and merged).

Task: audit the chapter as a publishable unit and produce a disposition plan.
Each member audits through their own lens (see role card) and files ONE finding:
  stance support = the chapter holds on this lens as written
  stance refute  = the chapter must change; name the fix and its scope
Findings cite [file:line] in 00-front-matter.qmd. Mechanics findings state the broken
value and the expected value. Cross-chapter checks use the authoritative chapters as
the reference, not this chapter:

  license/OGC = ch23 (23-license.qmd): the book publishes its game mechanics as Open
    Game Content under the Open Game License Version 1.0a. The Open Game Content
    Declaration designates "all game mechanics, rules systems, and procedures described
    in Chapters 1 through 22" and all spell mechanics as OGC that "may only be Used under
    and in terms of" the OGL 1.0a. The Product Identity list claims all proper names,
    artwork, storylines, and class names. Audit the front-matter copyright block for
    consistency with this grant: a blanket "all rights reserved / no reproduction"
    statement that carves out no OGC exception contradicts the ch23 grant.
  classes = ch05: the 9-class roster (Protector, Blade, Arcanist, Shepherd, Intellect,
    Odd, Leader, Unbalanced, Shadow).
  opening fiction = ch01b: the title is The Last Ember.

Book conventions every lens applies: zero em-dashes in the book, no stale or retired
vocabulary, placeholder content (TBD, [To be assigned]) is ACCEPTABLE in a draft build
and is NOT a defect to fix now (flag only if a placeholder is wrong or inconsistent,
not merely absent). The cover-art image at line 32 (assets/images/page001-img001.png)
is a real, committed placeholder asset with a correct caption; do not flag its presence.
Typography: the copyright symbol, punctuation, and grammar of the fixed prose lines are
in scope; the TBD placeholders are not.

Disposition tiers the final recommendation must use:
  TIER 1 mechanical — chapter-local, no mechanics change, no content judgment
    (typography, punctuation, grammar, single-cell fixes).
  TIER 2 substantive — content rewrites, cross-chapter reconciliation.
  TIER 3 design-decision — legal or design-authority questions for the lead designer
    (e.g. how the copyright block should express the OGC carve-out).
Also flag any finding that is a BOOK-WIDE convention (visible in sibling chapters),
because a chapter-local fix would make ch00 inconsistent with the book; those route to
a convention decision, not a single-chapter edit.
