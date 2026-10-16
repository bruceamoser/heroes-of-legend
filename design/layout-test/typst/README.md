# Typst comparison — Great Library

Issue #1199; builds on DesignCraft trial PR #1198. Tested with official Typst
0.15.1 on October 15, 2026.

[Typst PDF](../artifacts/hol-library-typst.pdf) ·
[DesignCraft PDF](../artifacts/hol-library-trial.pdf)

## Fair comparison

Both samples use the same six-page plan, Letter dimensions, Cinzel and EB
Garamond fonts, font sizes, palette, artwork, text, and frame positions.
Only the cover's tool label changes. The final story flows naturally across
two pages in each engine, with different paragraph spacing and page breaks.

To prevent accidental text/design differences, extract-sample.py reads the
frozen DesignCraft document and writes sample.json plus the embedded artwork.
comparison.typ independently typesets that data. This is a controlled rendering
comparison, not a general DesignCraft converter or an established Markdown
publishing pipeline. Neither rules source nor the older Quarto template changed.

The first four pages use positioned Typst blocks, matching the original design.
The last two use normal document flow. The action table deliberately retains
the same frame-based construction; native table behavior is not tested here.
No external Typst packages are required.

## Build

From the repository root, with Typst 0.15.1 on PATH:

```sh
python3 design/layout-test/typst/extract-sample.py
typst compile design/layout-test/typst/comparison.typ design/layout-test/artifacts/hol-library-typst.pdf
typst eval 'query(<frame-check>).map(it => it.value)' --in design/layout-test/typst/comparison.typ
```

The document data and extracted image are committed for a self-contained compile.
The named fonts must be installed. The Library image is retained as a prototype
reference, not selected as the finished HOL cover.

## Verification

- Six Letter pages; all six rendered and visually inspected.
- All first-four-page text frames and every flow-story paragraph found in the
  exported PDF after whitespace normalization.
- Font inspection confirms embedded Cinzel and EB Garamond with Unicode mappings.
- Measured fixed text blocks fit their allotted heights.
- Final story uses normal automatic pagination, without manually dividing its text.
- This is a screen proof. Print standards, accessible reading order, long-book
  performance, navigation and native-table behavior remain untested.

## Assessment

Typst can closely reproduce this visual direction. The old book's appearance is
not evidence of a Typst quality ceiling. DesignCraft's attraction is direct
visual editing; Typst's attraction is repeatable source-driven composition.
This comparison gives no basis to claim DesignCraft's PDF is inherently superior.

The remaining tool choice should be based on revision workflow and demanding
publishing tests, rather than these samples' visual quality alone.
