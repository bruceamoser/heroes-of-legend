# Recommendation — hol-rulebook

**Verdict:** VERDICT: REJECTED 5-2. Five voters (librarian, contrarian, researcher, author, layout-expert) refuted topic t-01, two (game-architect, editor-in-chief) supported, none rebutted, no impasse, no judge sat. ch00 (quarto-book/chapters/00-front-matter.qmd) does not publish as written: its blanket all-rights-reserved copyright notice carries no exception for the game mechanics the book licenses away under the OGL. Execute this TIERED DISPOSITION PLAN, built on dispositions I independently verified against the book chapters and the built PDF (source of record). TIER 1 (mechanical, chapter-local, no mechanics change, no content judgment) - ship as one micro-PR on quarto-book/chapters/00-front-matter.qmd only: (1) Replace the ASCII '(c)' at line 20 with the real copyright glyph U+00A9 so the notice renders typeset, matching the real typographic glyphs elsewhere in the front matter. (2) Add the colon the other five credit labels carry, so line 9 reads 'Written by:' not 'Written by'. (3) Repair the comma splice at line 50 in the Special Thanks closing sentence, which strands the subject 'every player' in a relative clause that never receives a verb before a comma butts in the new clause 'you're why this book exists'; give the subject its own verb (close with 'instead?' is why this book exists) with no em-dash. (4) Remove the explicit title block at lines 2-3 (the bold 'Heroes of Legend' and 'Core Rules, First Edition'): the front matter is included inside Chapter I, and index.qmd already sets the book title and subtitle that the chapter ornament renders higher on the same page, so the block is word-for-word duplicate (verified in the built PDF, printed p.9). TIER 3 (legal/design-authority, implement the recommended default anchored on OGL 1.0a standard practice and log each in decisions-pending.md as 'implemented default 2026-09-03, veto to revert'): (5) Add an Open Game Content carve-out to the copyright block so it no longer flatly contradicts ch23. ch23 line 78 designates all game mechanics, rules systems, and procedures in Chapters 1 through 22 as Open Game Content usable only under OGL 1.0a, and OGL section 2 (ch23 line 19) forbids attaching additional terms to OGC; the front-matter blanket no-reproduction notice (line 22) is exactly such an extra restriction. Add a sentence stating the game mechanics are Open Game Content governed by the OGL in Chapter 23, with all other material remaining all-rights-reserved. TIER 2 (substantive / cross-chapter reconciliation): (6) Verify the copyright year range and holder against ch23 (both '2024-2026 Bruce A. Moser', confirmed matching) and confirm the cover-art asset at line 32 is a committed valid PNG (1308x1693, matches caption, commit 894e4b9, clean tree - confirmed). No further action beyond the TIER 1 fixes. game-architect and editor-in-chief found the mechanics and structure sound as written, so no TIER 2 rewrite is required.

**Confidence:** 0.9

## Per-topic outcomes

- t-01: rejected

## Resolved (per the librarian)
- t-01: rejected 5-2 - chapter does not publish as written; execute the tiered disposition plan (4 TIER 1 chapter-local fixes in one micro-PR, 1 TIER 3 OGC carve-out implemented as default and logged in decisions-pending.md, 1 TIER 2 cross-chapter reconciliation closed on verification)

## Dissenting views

- game-architect on t-01: supported - a full numeric and vocabulary sweep finds no damage row, card cost, level gate, class name, or core-roll remnant in the front matter; the mechanics stand clean as written, so the refute is driven by the legal/typography items, not by any mechanic.
- editor-in-chief on t-01: supported - the title page is structurally complete with all standard front-matter elements in conventional order, the two H2 sections sit at the correct depth for an included file, and the contents listing is build-generated, so nothing is missing; the refute is driven by the legal carve-out and typography, not by completeness.

## Rulings applied

- none
