# Heroes of Legend — Layout Guidelines

> **Purpose:** This is the single source of truth for all Quarto Markdown and Typst
> layout conventions used in the Heroes of Legend rulebook. The Layout Formatter
> agent consults this file when formatting content. When conventions change,
> update this file — do NOT bake formatting rules into agent instructions.
>
> **Last updated:** 2026-07-12
> **Typst version:** 0.15.x
> **Quarto version:** 1.4+

---

## How to Use This File

1. **Consult first.** Before formatting any content, read the relevant section below.
2. **Follow conventions.** The "Currently Used" sections describe our active style.
3. **Know what's available.** The "Available Features" sections list everything
   Quarto + Typst can do — even if we're not using it yet. When a new layout
   need arises, check here first before inventing a custom solution.
4. **Update when conventions change.** If Bruce decides to change a style (e.g.,
   callout appearance, table format, heading colors), update this file. The
   agent reads it fresh each time.

---

## 1. Typst Theme Overview

Our theme is "Battle-Scarred Tome" — aged parchment, dark brown ink, red-brown
headings, antique gold accents. Defined in:

| File | Role |
|------|------|
| `quarto-book/_extensions/heroes-of-legend/style.typ` | Active style sheet (injected via `include-before-body`) |
| `quarto-book/_extensions/heroes-of-legend/template.typ` | Reference/fallback template |
| `quarto-book/_quarto.yml` | Book structure, chapter ordering, format settings |

### Color Palette

```
Page bg:      #f4e4c1 (aged parchment)
Body text:    #3d2b1f (dark brown ink)
Headings:     #8b0000 (deep red-brown)
Gold accent:  #c9a84c (antique gold)
Gold dim:     #8a6a2a (warm brown gold)
Muted:        #7a6e5e (muted brown, footnotes/page numbers)
Table border: #5c4033 (medium brown)
Table header: #5c4033 (medium brown bg)
Table stripe: #faf3e0 (lighter parchment, alternating rows)
Sidebar bg:   #faf3e0 (lighter parchment)
Code bg:      #fdfaf0 (very light parchment)
Note bg:      #fef9e7 (pale amber — NOTE callout)
Tip bg:       #f0f7e6 (pale green — TIP callout)
Warning bg:   #fdf0ed (pale red — WARNING callout)
Note border:  #8a6a2a (warm brown)
Tip border:   #4a7c3f (forest green)
Warning border: #8b0000 (deep red-brown)
Link color:   #8a6a2a (warm brown)
```

### Fonts

| Role | Font Stack |
|------|-----------|
| Body | Crimson Text, Libertinus Serif, Georgia |
| Headings | IM Fell English, Crimson Text, Libertinus Serif |
| Mono/Code | Libertinus Mono, Cascadia Code, Consolas |
| Tables | Crimson Text, Libertinus Serif |

Fonts must be installed system-wide or placed in `quarto-book/fonts/`.

---

## 2. Page & Document Structure

### Currently Used

```yaml
# _quarto.yml
format:
  typst:
    papersize: us-letter
    margin: { top: 25mm, bottom: 28mm, left: 22mm, right: 22mm }
    font-size: 10.5pt
    toc: true
    toc-depth: 2
    number-sections: true
```

- **Header:** "Heroes of Legend" smallcaps left, page number right, thin gold rule beneath.
- **Footer:** Centered `— N —` page number with em-dashes.
- **Part pages:** Full-bleed title with triple gold rule divider.
- **Chapter titles (H1):** IM Fell English 26pt, red-brown, with thick+thin gold rules beneath, weak pagebreak before.

### Available Features (not yet used)

| Feature | How | Example |
|---------|-----|---------|
| Columns | `#set columns(2)` or `#columns(2)[...]` in raw Typst | Two-column layouts for sidebars |
| Page size variants | `papersize: a4` | A4 for European distribution |
| Landscape pages | `#set page(flipped: true)` in raw Typst | Wide tables, maps |
| Different margin per page | `margin: (inside: 25mm, outside: 20mm)` | Book-style inner/outer margins |
| Custom page numbering | `numbering: "I"` for front matter | Roman numeral front matter |
| Bleed/trim | `bleed: 3mm` | For print-ready PDFs |

---

## 3. Headings

### Currently Used

| Level | Font | Size | Color | Style |
|-------|------|------|-------|-------|
| H1 (#) | IM Fell English | 26pt | #8b0000 | Bold, with gold rules beneath |
| H2 (##) | IM Fell English | 15pt | #8b0000 | Bold |
| H3 (###) | Crimson Text | 12pt | #3d2b1f | Bold |
| H4 (####) | Crimson Text | 11pt | #3d2b1f | Bold italic |

### Available Features (not yet used)

| Feature | How |
|---------|-----|
| H5 (#####) | Would render as body-font bold, 10.5pt by default |
| H6 (######) | Would render as body-font bold italic, 10pt by default |
| Unnumbered headings | `{-}` suffix: `## My Section {-}` |
| Custom heading numbering | Via `numbering:` in `_quarto.yml` |
| Labeled headings for xref | `## Section Name {#sec-custom-id}` |

---

## 4. Tables

### Currently Used — Standard Pipe Table

```markdown
| Column A | Column B | Column C |
|----------|----------|----------|
| Value    | Value    | Value    |
```

Album alignment:
```markdown
| Right | Left | Default | Center |
|------:|:-----|---------|:------:|
```

Typst styling (via `style.typ`):
- Dark brown header row with parchment-colored text (bold, 9.5pt)
- Alternating row stripes: header → stripe → parchment → stripe...
- Body cells: 9pt Crimson Text
- 0.4pt medium brown borders
- 7pt horizontal / 5pt vertical cell padding

### Available Features (not yet used)

| Feature | How |
|---------|-----|
| Captioned tables | `: My Caption {#tbl-mytable}` below the table |
| Cross-reference tables | `@tbl-mytable` after adding label |
| Grid tables | Pandoc grid table syntax (use `=` and `+`) |
| Multi-column cells | Grid table syntax supports colspan |
| Column widths | `{width="50%"}` attribute on grid tables |
| CSV data tables | ```` ```{.csv file="data.csv"} ```` |
| Raw Typst tables | ```` ```{=typst} #table(...) ```` for complex layouts |
| Table footnotes | Inline footnotes within table cells |

---

## 5. Callout Blocks (Admonitions)

### Currently Used

Five callout types, all with `appearance="simple"` (thick left border, pale bg, icon):

```markdown
:::{.callout-note}
## Optional Title Here
Content here. If no heading, uses type label (NOTE, TIP, etc.).
:::
```

| Type | Class | Icon | Border | Background | Use For |
|------|-------|------|--------|------------|---------|
| Note | `.callout-note` | 📝 | #8a6a2a | #fef9e7 | Rules clarifications, designer notes |
| Tip | `.callout-tip` | 💡 | #4a7c3f | #f0f7e6 | Player advice, GM tips |
| Warning | `.callout-warning` | ⚠ | #8b0000 | #fdf0ed | Important warnings, gotchas |
| Important | `.callout-important` | ❗ | #8b0000 | #fdf0ed | Critical rules, must-read |
| Caution | `.callout-caution` | ⚠ | #8b0000 | #fdf0ed | Dangerous content, edge cases |

### Available Features (not yet used)

| Feature | How |
|---------|-----|
| `appearance="default"` | Colored header background + icon |
| `appearance="minimal"` | Borders only, no header bg or icon |
| `icon=false` | Suppress the callout icon |
| `collapse="true"` | Collapsible callout (HTML/PDF, not all formats) |
| `collapse="false"` | Expandable, expanded by default |
| Callout title via attribute | `title="My Title"` instead of `## Heading` |
| Cross-reference callouts | `{#nte-mynote}` → `@nte-mynote` (prefixes: nte-, tip-, wrn-, imp-, cau-) |
| Custom callout classes | Via Typst `#show` rules in `style.typ` |
| Nested callouts | Callout inside another callout |

---

## 6. Cross-References

### Currently Used

```markdown
See @sec-chapter-combat for combat rules.
See @sec-magic-system for how spellcasting works.
```

Chapter IDs are defined in `quarto-book/_quarto.yml` under `crossref: chapters: true`.
Each chapter file declares its ID:
```markdown
# Chapter Title {#sec-chapter-identifier}
```

### Available Features (not yet used)

| Feature | How |
|---------|-----|
| Section references | `@sec-section-name` |
| Figure references | `@fig-myfigure` |
| Table references | `@tbl-mytable` |
| Equation references | `@eq-myequation` |
| Callout references | `@nte-mynote`, `@tip-mytip`, etc. |
| Custom reference text | `@sec-id [custom text]` |
| Reference with page number | Typst `@sec-id` auto-includes page in PDF |
| Bibliography citations | `[@citekey]` with `.bib` file |

### Chapter ID Reference (from `_quarto.yml`)

| ID | Chapter |
|----|---------|
| `sec-chapter-introduction` | 01 — Introduction |
| `sec-chapter-opening-fiction` | 01b — Opening Fiction |
| `sec-chapter-character-creation` | 02 — Character Creation |
| `sec-chapter-attributes` | 03 — Attributes |
| `sec-chapter-ancestries-cultures` | 04 — Ancestries & Cultures |
| `sec-chapter-classes` | 05 — Classes |
| `sec-chapter-core-resolution` | 06 — Core Resolution |
| `sec-chapter-skills` | 07 — Skills |
| `sec-chapter-disciplines` | 08 — Disciplines |
| `sec-chapter-talents-abilities` | 09 — Talents & Abilities |
| `sec-magic-system` | 10 — Magic System |
| `sec-chapter-arcane-spells` | 11 — Arcane Spells |
| `sec-chapter-divine-spells` | 12 — Divine Spells |
| `sec-chapter-combat` | 13 — Combat |
| `sec-chapter-social-conflict` | 14 — Social Conflict |
| `sec-chapter-equipment` | 15 — Equipment |
| `sec-chapter-armor-shields` | 16 — Armor & Shields |
| `sec-chapter-magic-items` | 17 — Magic Items |
| `sec-chapter-advancement` | 18 — Advancement |
| `sec-chapter-gm-guidance` | 19 — GM Guidance |
| `sec-chapter-bestiary` | 20 — Bestiary |
| `sec-chapter-glossary` | 21 — Glossary |
| `sec-chapter-reference-sheets` | 22 — Reference Sheets |
| `sec-chapter-license` | 23 — License |

---

## 7. Text Formatting

### Currently Used

| Format | Markdown | Typst Equivalent |
|--------|----------|-----------------|
| Italic | `*text*` | `#emph[text]` |
| Bold | `**text**` | `#strong[text]` |
| Bold italic | `***text***` | `#strong[#emph[text]]` |
| Small caps | `[text]{.smallcaps}` | `#smallcaps[text]` |
| Inline code | `` `code` `` | `#raw(lang: "", "code")` |
| Strikethrough | `~~text~~` | `#strike[text]` |
| Superscript | `text^2^` | `#super[2]` |
| Subscript | `text~2~` | `#sub[2]` |
| Hard line break | `line 1\` | `#linebreak()` |

### Available Features (not yet used)

| Feature | How |
|---------|-----|
| Highlight | `[text]{.mark}` — yellow highlight (Pandoc, format-dependent) |
| Underline | `[text]{.underline}` — underline (format-dependent) |
| Overline | Raw Typst: `#overline[text]` |
| Custom text color | Raw Typst: `#text(fill: red)[text]` |
| Custom font size inline | Raw Typst: `#text(size: 12pt)[text]` |
| Smart quotes | Typst auto-converts `"` to `"` |
| Non-breaking space | `~` in Typst raw |
| Ligature control | `#set text(ligatures: false)` in Typst |

### Em Dash Convention

The project uses `smart: false` in `_quarto.yml`, which disables automatic conversion of `--` to em dash and `---` to em dash. This means:

- **Use literal Unicode em dashes:** Type `—` (U+2014, Windows: `Alt+0151`, Mac: `Shift+Option+-`)
- **Do NOT use `---`:** In markdown with `smart: false`, three hyphens render as three literal hyphens, not an em dash
- **`---` is reserved** for YAML frontmatter delimiters and horizontal rules

The em dash is used extensively for:
- Parenthetical asides ("The door opens — as the guard rouses from his nap.")
- Dramatic pauses ("This is not a spell — it's a verdict.")
- Dialogue attribution in fiction

**Style guidance:** Use em dashes for conversational, mentor-like asides. Avoid overuse — if a sentence has more than two em dashes, consider restructuring. Chapters 21 (Glossary), 22 (Reference), and 23 (License) use formal punctuation without em dashes — follow their convention for reference/legal content.

---

## 8. Lists

### Currently Used

```markdown
- Unordered item
- Another item
  - Nested item (4-space indent)

1. Ordered item
2. Another item

Term
: Definition (definition list)
```

Typst styling: 1.5em indent, 0.5em body indent.

### Available Features (not yet used)

| Feature | How |
|---------|-----|
| Task lists | `- [ ] Todo` / `- [x] Done` |
| Custom bullet | Raw Typst: `#set list(marker: [→])` |
| Custom numbering | `(@)` style: `(@) First` → continues after breaks |
| Lettered sub-lists | `a) Item` produces a), b), c) |
| Romannumeral lists | `i) Item` → i, ii, iii |
| Continued lists | `(@)` style preserves numbering across interruptions |
| Separate list blocks | `:::` div wrappers around lists |

---

## 9. Figures & Images

### Available Features (currently unused — no art placed yet)

| Feature | How |
|---------|-----|
| Basic image | `![Caption](path/to/image.png)` |
| Figure with caption | `![Caption](image.png){#fig-myfig}` |
| Cross-reference figure | `@fig-myfig` |
| Image sizing | `{width="50%"}` or `{height="200px"}` |
| Alt text | `{fig-alt="Description for accessibility"}` |
| Clickable image | `[![Caption](image.png)](url)` |
| Typst image control | Raw Typst: `#image("file.png", width: 80%)` |
| Figure placement | `fig-pos: "htbp"` in YAML (LaTeX-style) |
| SVG support | Typst natively renders SVG |
| Art directory | `assets/images/` — see `IMAGE-CATALOG.md` |

---

## 10. Block Quotes

### Currently Used

```markdown
> Blockquoted text.
> Multiple lines.
```

Typst styling: Italic body text, warm sidebar background (#faf3e0), thick left border
(4pt red-brown #8b0000), 2pt radius, 15pt left / 8pt right / 8pt top-bottom inset.

### Available Features (not yet used)

| Feature | How |
|---------|-----|
| Attribution | Pandoc: `> Quote\n> — Author` |
| Nested blockquotes | `> > Nested` |
| Blockquote in callout | Combine callout + blockquote |
| Custom Typst quote | Raw Typst: `#quote(attribution: [Author])[text]` |

---

## 11. Code Blocks & Stat Blocks

### Currently Used

````markdown
```default
Stat block or code content
```
````

Typst styling: Very light parchment bg (#fdfaf0), 0.5pt brown border, 3pt radius,
8pt inset, 9pt Libertinus Mono.

Inline code: `` `text` `` → box with code-bg fill, 0.3pt border, 2pt radius.

### Available Features (not yet used)

| Feature | How |
|---------|-----|
| Syntax highlighting | ```` ```python ```` — 140+ languages supported |
| Line numbers | ```` ```{.python .numberLines} ```` |
| Code filename | ```` ```{.python filename="run.py"} ```` |
| Raw Typst blocks | ```` ```{=typst} ... ```` for direct Typst code |
| Raw LaTeX blocks | ```` ```{=latex} ... ```` (legacy) |
| Custom code block styling | Via `#show raw.where(block: true)` in `style.typ` |

---

## 12. Blockquotes, Divs & Spans

### Available Features (not yet used)

| Feature | How |
|---------|-----|
| Generic div | `::: {.classname} Content :::` |
| Nested divs | `::::: {#outer} ::: {#inner} Content ::: :::::` |
| Div with ID | `::: {#myid} Content :::` |
| Span with class | `[text]{.classname}` |
| Span with attributes | `[text]{.class key="val"}` |
| Inline Typst | `#rect[text]` in raw Typst |
| Hidden content | `::: {.hidden} ... :::` — renders in output but hidden visually |

---

## 13. Math & Equations

### Currently Used

Inline: `$E = mc^2$`
Display: `$$E = mc^2$$`

### Available Features (not yet used)

Full Typst math engine — supports LaTeX-compatible syntax:
- Fractions: `$\frac{a}{b}$`
- Matrices: `$\begin{matrix} a & b \\ c & d \end{matrix}$`
- Custom macros: `::: {.hidden} $$ \def\RR{{\bf R}} $$ :::`

For probability tables in mechanics design, use inline math `$P(X \geq n)$`.

---

## 14. Page Breaks

### Currently Used

```markdown
{{< pagebreak >}}
```

### Available Features (not yet used)

| Feature | How |
|---------|-----|
| Typst pagebreak | Raw Typst: `#pagebreak()` |
| Weak pagebreak | Raw Typst: `#pagebreak(weak: true)` — only breaks if needed |
| Column break | Raw Typst: `#colbreak()` |

---

## 15. Typst Raw Blocks (Advanced)

For layout needs beyond Quarto Markdown, use raw Typst blocks:

````markdown
```{=typst}
#block(
  fill: rgb("#faf3e0"),
  stroke: (left: 4pt + rgb("#8b0000")),
  inset: 12pt,
  radius: 3pt,
  [Your content here]
)
```
````

### Typst Layout Functions Available

| Function | Purpose |
|----------|---------|
| `#block()` | Block-level container with fill, stroke, inset, radius |
| `#box()` | Inline container that sizes to content |
| `#grid(columns: N, rows: M, ...)` | Grid layout |
| `#stack(dir: ttb, ...)` | Stack elements vertically or horizontally |
| `#columns(N)[...]` | Multi-column layout |
| `#align(center)[...]` / `#align(left)[...]` | Horizontal alignment |
| `#v(N)` / `#h(N)` | Vertical/horizontal spacing |
| `#pad(x: N, y: N, ...)[...]` | Padding around content |
| `#place(top+left, ...)[...]` | Absolute placement |
| `#move(dx: N, dy: N)[...]` | Offset without affecting layout |
| `#rotate(N)[...]` | Rotation (watermarks, etc.) |
| `#scale(x: N%, y: N%)[...]` | Scale content |
| `#hide[...]` | Hide content without affecting layout |
| `#repeat[...]` | Repeat content (watermarks, patterns) |

### Typst Visualize Functions Available

| Function | Purpose |
|----------|---------|
| `#rect(width: N, height: N, fill: color, stroke: N)` | Rectangle |
| `#square(size: N, ...)` | Square |
| `#circle(radius: N, ...)` | Circle |
| `#ellipse(width: N, height: N, ...)` | Ellipse |
| `#line(start: (x,y), end: (x,y), stroke: N)` | Decorative lines |
| `#line()` with `#place()` | Chapter dividers, ornaments |

---

## 16. Spell Stat Blocks (Canonical Format)

```markdown
### Spell Name (Novice)
**Discipline:** [Required Discipline]
**Range:** [Distance]
**Duration:** [Time]
**Description:** [One evocative sentence, then clear mechanical description.]

| Outcome | Effect |
|---------|--------|
| Weak (1–6) | [What happens on Weak success] |
| Standard (7–12) | [What happens on Standard success] |
| Strong (13–18+) | [What happens on Strong success] |
```

Repeat for Adept and Master tiers. Add chain header:

```markdown
## [Chain Name] Chain
**Disciplines:** [Primary Discipline]
*[One-sentence description of the chain's theme.]*

*See @sec-magic-system for how spellcasting works.*
```

---

## 17. Monster Stat Blocks (Canonical Format)

```markdown
### Monster Name
**Challenge:** [Low/Medium/High/Epic]
**Description:** [2–3 sentences of flavor.]

| Attribute | Modifier |
|-----------|----------|
| Brawn | +X |
| Fortitude | +X |
| Agility | +X |
| Guile | +X |
| Knowledge | +X |
| Reason | +X |

**Skills:** [Skill] +X, [Skill] +X

**Abilities:**
- **[Ability Name]:** [Description and mechanical effect.]

**Attacks:**

| Attack | Weak (1–6) | Standard (7–12) | Strong (13–18+) |
|--------|------------|-----------------|-----------------|
| [Name] | XdY damage | XdY damage | XdY + [effect] |
```

---

## 18. Equipment Stat Blocks (Canonical Format)

```markdown
### Item Name
**Type:** [Weapon/Armor/Gear/Magic Item]
**Cost:** [GP value]
**Properties:** [Special rules]

| Outcome | Damage |
|---------|--------|
| Weak | XdY |
| Standard | XdY |
| Strong | XdY |
```

---

## 19. Quarto Features Reference (Quick Lookup)

| Feature | Syntax | Notes |
|---------|--------|-------|
| **Footnotes** | `^[inline note]` or `[^ref]` + `[^ref]: note` | IDs must be unique across chapters |
| **Diagrams** | ```` ```{mermaid} ... ``` ```` | Mermaid, Graphviz |
| **Videos** | `{{< video url >}}` | YouTube, Vimeo, MP4 |
| **Keyboard shortcuts** | `{{< kbd Ctrl-C >}}` | OS-aware |
| **Definition lists** | `Term\n: Definition` | Good for glossary |
| **Line blocks** | `\| Line 1\n\| Line 2` | Preserves whitespace |
| **Horizontal rule** | `---` (on its own line) | Thematic break |
| **Escaping** | `\*not italic\*` | Backslash escape |
| **Non-breaking space** | `\ ` (backslash space) | Prevents line break |
| **Smart typography** | `--` → –, `---` → —, `...` → … | Enabled by default (we disable via `smart: false`) |
| **Raw inline** | `` `code` `` | Monospace |
| **Comment** | `<!-- comment -->` | Not rendered |
| **Emoji** | `:smile:` (HTML) or direct unicode | Typst supports unicode emoji |

---

## 20. Typst Format-Specific Settings

From `_quarto.yml`:

```yaml
format:
  typst:
    toc: true              # Table of contents
    toc-depth: 2           # Show H1 and H2 in TOC
    number-sections: true   # Auto-number H1-H3
    papersize: us-letter    # Letter paper
    smart: false            # Disabled — we handle quotes manually
    font-family: "Crimson Text"
    font-size: 10.5pt
    include-before-body: _extensions/heroes-of-legend/style.typ
```

Other available `format: typst:` settings (not currently used):

| Setting | Values | Purpose |
|---------|--------|---------|
| `papersize` | `a4`, `a5`, `us-letter`, custom | Paper size |
| `columns` | `2` | Two-column layout |
| `fig-width` / `fig-height` | e.g., `6` (inches) | Default figure size |
| `fig-format` | `svg`, `png` | Figure output format |
| `cap-location` | `top`, `bottom` | Caption placement |
| `cap-style` | `default` | Caption style |

---

## 21. How to Change a Convention

When a layout convention needs to change:

1. **Identify the change** — What style is changing? Why?
2. **Update this file** — Edit the relevant section, note the date.
3. **Update `style.typ` if needed** — Typst show/set rules may need changes.
4. **Update `_quarto.yml` if needed** — Quarto-level settings may need changes.
5. **Build and verify** — `cd quarto-book && ./build.sh`
6. **Spot-check affected chapters** — Verify the change renders correctly.

### Template: Adding a New Convention
```markdown
### Convention Name
**Status:** Active as of YYYY-MM-DD
**Applies to:** [which content types / chapters]
**Rule:** [what to do]
**Example:** [code snippet]
**Typst backing:** [which line in style.typ implements this]
```

### Template: Changing an Existing Convention
```markdown
### Convention Name
**Status:** Changed YYYY-MM-DD (was: [old rule])
**Applies to:** [which content types / chapters]
**Rule:** [new rule]
**Migration notes:** [what to change in existing chapters]
```
