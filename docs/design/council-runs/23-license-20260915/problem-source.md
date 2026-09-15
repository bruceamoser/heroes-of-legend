# Council problem statement — Chapter 23, License

**Source:** `23-license.qmd` (104 lines, 10,247 bytes, 5 sections: Open Game License
Version 1.0a `:13-51` with its definitions and 15 numbered sections `:17-51`; Product
Identity Declaration `:57-68`; Open Game Content Declaration `:72-81`; Third-Party
Attributions `:85-92`; Contact & Rights Inquiries `:96-102`). It prints as **Chapter 25**,
occupying printed pages 379-386.

**Question for the council:** is this chapter publishable as it stands?

**What this chapter is.** It is the book's LEGAL FACE. Unlike every other chapter it makes
no game rule: it states what a reader may legally do with the other 22 chapters. That
changes what a defect is here. A wrong number in this file is not a balance question; it is
the designation pointing a licensee at the wrong material, or failing to license material it
appears to license, or shipping third-party components with no attribution. Three failure
classes are native to it and should be your targets:

1. **A mis-citation of the book's own structure.** The license text names chapters ("Chapters
   1 through 22", "Chapters 11 and 12", "Chapter 20"). Any chapter number a reader cannot
   resolve to the intended material is a defect of the designation, not a typo.
2. **An incomplete or over-broad designation.** Material the book ships that is not covered
   where a reader would expect it to be, or material claimed as licensed that the book never
   releases, or a third-party component shipped without the attribution its own licence
   requires.
3. **A reproduction that is not faithful.** The text of Open Game License 1.0a is a FIXED
   document. The book reproduces it; the reproduction must match the canonical text. Do NOT
   propose rewording the licence body: it is to be reproduced, not authored. Only a
   divergence from the canonical wording is a defect, and only a MISSING piece or a divergent
   word is actionable.

**Why this chapter is live.** Its own Wave-1 review (PR #391, 2026-09-03) fixed three items:
the double pagebreak, the Shadow omission from the Product Identity class list, and a missing
section-2 designation notice. It was reviewed again in the 2026-09-02/03 pass. Since then the
book has been rebuilt (`#523` currency removed, `#532` damage bands renumbered, `#537/#538`
the one-card law, the DR and Challenge rulings) and, decisively, **the printed chapter
numbering itself was corrected on 2026-09-10/11** (the crossref off-by-one fix, `#467`/`#476`).
**This file has not been re-read since the numbering settled.** Every hand-typed chapter
number in it, and the same phrasing in `00-front-matter.qmd:19`, was written against a
different numbering than the one the book now prints.

## Topics

- **t-01** designation integrity: does every chapter number, range and reference in this file
  (and its twin in `00-front-matter`) resolve, as printed, to the material the designation
  intends? Is anything designated that the book does not release, or released that is not
  designated?
- **t-02** reproduction and convention conformance: the OGL 1.0a body against the canonical
  text (divergences only, and completeness of the copy), the book's own conventions in the
  authored sections (zero em-dashes, house emphasis, crossref law), and internal consistency
  of the three declarations with each other and with `00-front-matter.qmd:19-21`.
- **t-03** attribution and publication readiness: completeness of the Third-Party
  Attributions section against what the book actually ships and embeds, the contact section,
  placeholder state, structure, heading hierarchy, and the render.

Every finding MUST set `topic` to exactly `t-01`, `t-02`, or `t-03`. One finding carries one
defect; name any others in your reply.

## Locked conventions (current as of 2026-09-14 — these ARE the law this run tests against)

1. **Printed chapter numbering carries a +2 offset from source order.** Source file `NN` prints
   as Chapter NN+2. This file is source 23, so it prints as **Chapter 25**. Concretely, as the
   reader sees it: source `01-introduction` = Chapter 2, `01b-opening-fiction` = Chapter 3,
   `02-character-creation` = Chapter 4, `09-talents-abilities` = Chapter 11, `10-magic-system`
   = Chapter 12, `11-arcane-spells` = **Chapter 13**, `12-divine-spells` = **Chapter 14**,
   `13-combat` = Chapter 15, `20-bestiary` = **Chapter 22**, `21-glossary` = Chapter 23,
   `22-reference-sheets` = Chapter 24. The printed table of contents is the source of record
   for these numbers; the running heads, the part ornaments and the resolved `@sec-`
   cross-references all agree with it (the off-by-one was fixed on 2026-09-10/11).
2. **`@sec-` cross-references resolve to the PRINTED number**, so any hand-typed "Chapter N"
   in prose is a claim about the printed number and must match it. The book's own precedent
   is to use a live `@sec-` reference where the target is a chapter; a hand-typed number is
   the weaker form and owes the reader the correct printed number.
3. **Zero em-dashes** anywhere in the source.
4. **House emphasis in body text is Typst italic (`*word*`), never markdown bold.**
5. **Crossref law:** a cross-reference renders with its own trailing period, so nothing is
   typed after a bare sentence-final ref or after a closing parenthesis carrying one.
6. **A licence reproduction is fixed text.** Open Game License Version 1.0a is reproduced,
   not authored. Its section list, its definitions and its copyright notices are to match the
   canonical document; do not recommend rewording the licence itself.
7. **`Figure 25.1` and the line `_Placeholder for final art._` are the book-wide figure
   convention** (per-chapter figure numbering, art placeholder retained as the art pass's
   grep target). The `#label("sec-chapter-license")` line inside the Typst fence duplicating
   the H1's label is also the book's pattern. **None of these are defects.**
8. **Book-wide publishing state, not a defect:** cover art, final art and any remaining
   placeholder markers are draft-state artifacts of a v0.1.0 draft. A placeholder that is
   *filesystem or build-instruction metadata* (`Use placeholder-section.svg dimensions:
   400x300`) IS a defect; a `_Placeholder for final art._` marker is NOT.
9. **The book is an original system.** It is not a derivative of any published game's text
   that this council can identify from the sources: 3d6 resolution, Weak/Standard/Strong
   bands, 24 Disciplines, its own class roster. Treat any claim that it does or does not
   incorporate third-party Open Game Content as a question of law for the author, not a
   finding to fix; report it and let the disposition route it.

## Already checked by the orchestrator and CLEARED — do NOT file these

- **Zero em-dashes** in the file (grep: 0). The chapter is mechanically clean on the book's
  house laws, which means the round is hunting deeper than the obvious.
- **The repo-side structural gate passes**: `python3 quarto-book/check-native-typst.py` exits
  0 (one closed `{=typst}` fence, `# H1` above it, no markdown remnants, all tables
  `outlined: false`, all callout bodies named).
- **`Figure 25.1` / `_Placeholder for final art._` / the duplicate `#label(...)`** are book
  conventions (convention 7).
- **The Product Identity class list at `:65` is now the complete nine** (Protector, Blade,
  Arcanist, Shepherd, Intellect, Odd, Leader, Unbalanced, Shadow), matching `05-classes.qmd`.
  Fixed in PR #391; do not re-file it.
- **The OGC declaration at `:74` carries the section-2 licence-only-use notice** ("may only
  be Used under and in terms of the Open Game License Version 1.0a set out above"). Fixed in
  PR #391; do not re-file it.
- **The copyright holder line at `:51`** ("Heroes of Legend Core Rulebook Copyright
  2024-2026, Bruce A. Moser") matches `00-front-matter.qmd`'s copyright block. The contact
  address at `:98` matches the ruling in `docs/design/decisions-pending.md` row 69.
- **The Product Identity voice line at `:68`** naming both "Battle-Scarred Mentor" and
  "Veteran Adventurer" is the deliberate decision recorded as row 67 (kept as-is). Do not
  re-file it.
- **The OGL body is a faithful reproduction in the passages checked**: the §1(e) lowercase
  "Product identity" spelling, the definitions' clause structure, and the 15 sections are as
  the canonical document prints them. Do not treat the licence's own phrasing as the book's
  prose.

## Worked leads — verify or REFUTE these, do not simply restate them

Your own independent audit is the deliverable. **A ballot that only rules on this list is a
wasted ballot.** A lead you clear is a result; report it as one.

- **`:76` "described in Chapters 1 through 22", `:77` "presented in Chapters 11 and 12",
  `:78` "presented in Chapter 20", and `:76`'s parenthetical "Chapter 01b".** Read each
  against convention 1 and decide what a READER of the printed book resolves it to. The
  three numbered references are the load-bearing ones: the spell chapters, the bestiary, and
  the range bound. Say for each whether it resolves to the intended material, and if not,
  what the correct printed number is and what range a reader would need to be covered for the
  designation to say what it plainly intends.
- **`00-front-matter.qmd:19`** says the mechanics "presented in Chapters 1 through 22 are
  Open Game Content ... set out in Chapter 23". Check both numbers against convention 1 and
  against this file's own designation. Decide whether the two files disagree, and which is
  the outlier.
- **`:92` "Full license texts for open-source components are available in the source
  repository."** The book is distributed as a PDF. Decide whether a reader can act on this
  sentence: is there a source repository a reader of this book can reach, and does the
  sentence discharge whatever attribution duty the components' licences impose?
- **`:87-92`'s Third-Party Attributions section lists exactly two components: Quarto and
  Typst.** Establish what the book ACTUALLY ships and embeds: `pdffonts` on the built PDF
  names every embedded font family, and the source tree vendors a third-party Typst package
  under `quarto-book/_extensions/heroes-of-legend/beautitled/` (read its `VENDOR.md` and
  `LICENSE`). For each component you can identify, decide whether its own licence requires an
  attribution the book does not give, and whether that is a finding against this section or a
  scope choice. Name the licence of each component you cite.
- **`:49`'s COPYRIGHT NOTICE lists "System Reference Document 5.1"** as a contributor.
  Consider what a reader or licensee concludes from that line about the origin of the book's
  mechanics, and whether it is verifiable against anything else in the book. Report it as the
  finding you can substantiate (an in-book consistency question) and leave the question of
  whether the book actually incorporates that material to the author, per convention 9.
- **`:15` and `:47`** print the Wizards of the Coast entity as "LLC". Compare with the
  canonical OGL 1.0a text as you know it and decide whether that is a divergence to correct
  or the correct modern form. If you cannot establish a divergence, say you cleared it.
- **`:96-102`'s Contact & Rights Inquiries section** and the disclaimer at `:102`: check the
  contact line renders as intended in the built PDF (the file escapes the `@` and wraps it in
  a mailto link, because a bare `@` is a build breaker in this book's Typst layer), and decide
  whether anything a reader needs is missing.
- **Read the file for what a LICENSE chapter owes a reader that this one does not have:**
  whether the designation covers the sections a reader would look for, whether the two
  declarations contradict each other or `00-front-matter`, and whether any section's heading
  level or order is inconsistent with the book's convention.

## Cross-check chapters

`00-front-matter` (its OGC carve-out at `:19-21` is the twin of this file's designation),
`05-classes` (the nine class names claimed as Product Identity), `23-license` is otherwise
self-contained. **Do not audit another chapter in its own right**; name the owning file and
line in your evidence so the disposition can reach both sides where the owner is also wrong.

## Citation rule

Every `evidence[].source` must cite the registered source label `23-license`, another
chapter's filename, a repository path, `pdffonts`, or the literal `reasoning`. Quotes go in
`quote_or_excerpt` only, under about 12 words. `argument` and `evidence[].claim` are
wall-linted against this statement and the source: never place 10 or more consecutive words
from either into them.
