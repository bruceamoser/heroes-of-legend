# Native Typst Migration — Conversion Spec (v1)

**Goal:** Every chapter of the rulebook becomes a `.qmd` file whose body is ONE raw
` ```{=typst} ` block of native Typst. Quarto stays the orchestrator (book structure,
parts, TOC, template) but there is ZERO markdown content left for pandoc to convert.
End state: no markdown tables, no `:::` divs, no `{{< pagebreak >}}`, no `**bold**`,
no `![]()` image syntax, no `: caption` lines, no `@label` Quarto crossrefs in content.

**Reference implementation:** `quarto-book/chapters/06-core-resolution.qmd` on `main`
(merged as PR #398). It is the worked example and the diff oracle.
Read it before writing anything (it is in your worktree).

## File shape

```
# <Chapter Title> {#sec-chapter-<slug>}     <- ONE line of markdown: the H1. Required (Quarto
                                              chapter structure + TOC depend on it).

```{=typst}
#label("sec-chapter-<slug>")
... entire chapter body in native Typst ...
```
```

Rules:
- The H1 line stays markdown EXACTLY as in the source (title + `{#label}`). Do not change it.
- Everything after the H1 goes inside ONE ` ```{=typst} ` fence. No other markdown anywhere.
- Keep the file name and path unchanged (`chapters/NN-name.qmd`).
- Do NOT add YAML front matter.

## Construct map (markdown source -> native Typst)

| Source | Native | Notes |
|---|---|---|
| `{{< pagebreak >}}` | `#pagebreak()` | |
| `**text**` | `*text*` | |
| `*text*` (italic) | `_text_` | |
| `*text*` as LIST BULLET | `+ text` | context decides: a line starting `* ` that is a list item becomes `+ `; a line that is inline emphasis is italic |
| `- item` (bullet list) | `+ item` | |
| `1. item` (ordered list) | `#enum(numbering: "1.")[` ... `+ item` ... `]` | EVERY item line starts with `+ ` |
| `> quote` | `#quote[ ... ]` | multi-line: one `#quote[` block |
| `<!-- html comment -->` | `// html comment` | Rationale comments become `//` |
| `![](../assets/images/x.png){width=80%}` | `#figure(image("assets/images/x.png", width: 80%), caption: [ALT TEXT])` | **path is relative to `quarto-book/` root** (no `../`); width: `80%` -> `80%` (strip quotes, drop the `{}`); the alt text becomes the figure caption EXACTLY as written |
| `![alt](path){width=100%}` (no caption wanted) | `#figure(image("assets/...", width: 100%), caption: [alt])` | same rule; the book's convention is that alt text IS the caption |
| Pipe table (no caption) | see Table rules below | |
| `: Table N.M: Title {#tbl-xxx}` + pipe table | see Table rules below | |
| `::: {.callout-note}` ... `:::` (with `## Title` first line) | `#callout(type: "note", title: "Title", body: [ ... ])` | **MUST use named `body:` — a positional `[...]` body is silently dropped by the theme's `..rest` param.** Types: note/tip/warning/important (from the class). The `## Title` line becomes `title:`. Body = remaining content, converted per this map. |
| `@sec-xxx` / `@tbl-xxx` (Quarto crossref) | `@sec-xxx` / `@tbl-xxx` | Typst's native `@label` ref renders identically (supplement "Chapter"/"Section"/"Table"). Labels must exist via `#label("...")`. |
| `{#sec-xxx}` after an H2/H3 | `#label("sec-xxx")` on the line after the heading | |
| Existing ` ```{=typst} ` blocks (`#label(...)`, `#horizontalrule`) | keep as-is | already native |
| `---` (horizontal rule) | `#horizontalrule` | the theme's function |
| `\newpage` | `#pagebreak()` | |
| `{{< include ... >}}` (index.qmd) | keep as-is | Quarto orchestration, not content |
| `{{< meta date >}}` (00-front-matter) | keep as-is | verified 2026-09-09: Quarto processes template vars even inside raw blocks (probe rendered the date) |

## Table rules (the heart of it)

Labeled table (source form):
```
: Table 2.1: Ancestries {#tbl-ancestries}

| Ancestry | Discipline | Trait |
|:---------|:-----------|:------|
| **Human** | Any one | **Versatile:** +1 DP at Level 0 |
```
Becomes:
```typst
#figure(
  align(center)[#table(
    columns: (26.92%, 23.08%, 50%),
    align: (auto, auto, auto,),
    table.header([Ancestry], [Discipline], [Trait],),
    [*Human*], [Any one], [*Versatile:* +1 DP at Level 0],
  )],
  caption: [Table 2.1: Ancestries],
  kind: table,
  numbering: none,
  outlined: false,
)
#label("tbl-ancestries")
```

- **`numbering: none`** — the book hard-codes "Table N.M" in the caption (author-controlled).
  This kills the doubled-caption defect ("Table 8.1: Table 6.1:").
- **`outlined: false`** — REQUIRED. A table figure with `numbering: none` crashes
  orange-book's list-of-tables outline (`type none has no method at`). Every unnumbered
  table figure must carry it.
- **`columns: (w1%, w2%, ...)`** — compute from the source's dash counts the way pandoc does
  (column width = dash-run length / total dash-run length, in percent, two decimals).
  If the source has no meaningful dash runs (all equal), use equal percentages.
- **`align:`** — from the source alignment markers: `:---` left, `---:` right, `:--:` center,
  `---` auto. One per column, trailing comma.
- **`table.header([...], ...)`** — first row, each cell a `[...]`.
- **Cells** — each cell in `[...]`, inner markdown converted per the map
  (`**X**` -> `*X*`, etc.). Empty cell -> `[]`.
- **Unlabeled table with a `: Caption` line** (no `{#label}`): same form but
  `caption: [Caption]` and NO `#label` line after.
- **Unlabeled table with no caption at all**: wrap in `#figure(align(center)[#table(...)], kind: table, numbering: none, outlined: false)` with NO caption argument.
- **Do NOT use `table.hline()`** — the theme draws booktabs rules via `#show table`.

## Text fidelity (non-negotiable)

- **Copy text byte-for-byte from the source.** Do not retype. The book uses non-ASCII
  characters that must survive: `−` (U+2212 minus, not hyphen), `’` (right single quote),
  `“` `”` (curly doubles), `≈`, `×`, `·`, `©`, `§`, `→`, `📝`/emoji. If you see them in the
  source, they must appear unchanged in the native form.
- **Em-dash law:** ADDED lines must contain zero `—` (U+2014). Pre-existing em-dashes in
  source text stay (you are copying, not rewriting).
- No content is added, removed, or reworded. This is a format migration, not an edit.
  The ONLY content changes allowed are the defect fixes the native form makes
  (doubled captions, dropped captions, glued headings).

## Five silent-failure traps (each breaks the build or the content with NO warning)

1. **`#callout(...)[positional body]` silently drops the body.** The theme's `callout()`
   has a `..rest` parameter that swallows the positional argument. ALWAYS use the named
   form: `#callout(type: "note", title: "T", body: [ ... ])`.
2. **Table figures need `outlined: false`** (with `numbering: none`) or the build dies
   with `error: type none has no method at` in orange-book's outline.
3. **Image paths are `quarto-book/`-relative.** In a raw block pandoc does NOT rewrite
   `../assets/...`. Use `assets/images/x.png` (the assets dir is at `quarto-book/assets/`).
   A `../assets/` path in a raw block fails with `path would escape the project root`.
4. **`#enum` items each need a leading `+ `.** Bare lines inside `#enum(numbering: "1.")[...]`
   merge into one paragraph.
5. **A chapter's H1 must stay the markdown line at the top of the `.qmd`.** If the H1
   goes inside the raw block, Quarto emits an empty `= ` heading and the book's TOC/outline
   crashes (`type none has no method at`).

## Acceptance gate (the agent verifies, Winston re-verifies)

1. `cd quarto-book && ./build.sh` -> **exit 0**, no NEW typst errors (the `consolas`/
   `libertinus mono` font warnings are pre-existing and fine).
2. `pdftotext _output/Heroes-of-Legend.pdf -` -> extract your chapter's text region and
   diff against the same region of the pre-migration PDF. **Prose must be 1:1.** Only
   allowed deltas: doubled-caption fix, dropped-caption restore, glued-heading fix,
   callout icon change (note keeps pencil, tip becomes lightbulb per theme), smart-quote
   normalization (Quarto applies to both).
3. `git diff` must touch ONLY your one `.qmd` file.
