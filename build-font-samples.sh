#!/bin/bash
set -e
OUTDIR="starter-kit/font-pages"
rm -rf "$OUTDIR"
mkdir -p "$OUTDIR"

FONTS=(
  "lib-serif|Liberation Serif (Baseline)|fonts/LiberationSerif-Regular.ttf|fonts/LiberationSerif-Bold.ttf|fonts/LiberationSerif-Italic.ttf|fonts/LiberationSerif-BoldItalic.ttf"
  "eb-garamond|EB Garamond|fonts/font-test/EBGaramond-Regular.ttf|fonts/font-test/EBGaramond-Bold.ttf|fonts/font-test/EBGaramond-Italic.ttf|fonts/font-test/EBGaramond-Bold.ttf"
  "cardo|Cardo|fonts/font-test/Cardo-Regular.ttf|fonts/font-test/Cardo-Bold.ttf|fonts/font-test/Cardo-Italic.ttf|fonts/font-test/Cardo-Bold.ttf"
  "linux-libertine|Linux Libertine|fonts/font-test/LinLibertine-Regular.otf|fonts/font-test/LinLibertine-Bold.otf|fonts/font-test/LinLibertine-Italic.otf|fonts/font-test/LinLibertine-BoldItalic.otf"
  "almendra|Almendra|fonts/font-test/Almendra-Regular.ttf|fonts/font-test/Almendra-Bold.ttf|fonts/font-test/Almendra-Italic.ttf|fonts/font-test/Almendra-BoldItalic.ttf"
  "pirata|Pirata One|fonts/font-test/PirataOne-Regular.ttf|fonts/font-test/PirataOne-Regular.ttf|fonts/font-test/PirataOne-Regular.ttf|fonts/font-test/PirataOne-Regular.ttf"
)

for font_def in "${FONTS[@]}"; do
  IFS='|' read -r slug name reg bold ita bi <<< "$font_def"
  echo "Building: $name..."
  
  cat > "docs/themes/_font-${slug}-theme.yml" << THEME
extends: default
font:
  catalog:
    TestFont:
      normal: ${reg}
      bold: ${bold}
      italic: ${ita}
      bold_italic: ${bi}
base:
  font-color: '#3a2a1a'
  background-color: '#f4e4c1'
  font-family: TestFont
  font-size: 10
  line-height: 1.6
page:
  background-color: '#f4e4c1'
  margin: [18mm, 18mm, 22mm, 18mm]
  size: LETTER
heading:
  h1-font-size: 22
  h1-font-color: '#5a1a0a'
  h2-font-size: 16
  h2-font-color: '#4a2a1a'
  h3-font-size: 12
  h3-font-color: '#3a2a1a'
footer:
  height: 14mm
  recto:
    center-content: 'Rendered in *${name}*'
  verso:
    center-content: 'Rendered in *${name}*'
table:
  font-size: 9
  head-background-color: '#5a3a1a'
  head-font-color: '#f4e4c1'
  body-background-color: '#faf6ec'
  body-stripe-background-color: '#f0e8d0'
  border-color: '#8a7a5a'
  border-width: 0.5
  cell-padding: [2, 5, 2, 5]
quote:
  font-style: italic
  border-left-color: '#8b4513'
  border-left-width: 2
  background-color: '#efe0c8'
THEME

  cat > "docs/themes/_font-${slug}-sample.adoc" << ADOC
= ${name}
:doctype: article
:pdf-theme: docs/themes/_font-${slug}-theme.yml
:showtitle:
:notitle:

== ${name}

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur.

*Bold: The hero swings her longsword at the goblin, rolling 3d6 + Brawn. The
blade always finds its mark — the goblin shrieks as the damage registers.*

_Italic: The goblin crumples to the ground, its crude blade clattering away
across the stone floor. The hero surveys the chamber, torchlight flickering
across ancient runes carved into the walls._

*Firebolt — Novice (1 DP)*::
*Prerequisites:* 1 Fire Discipline. Make a 3d6 + Knowledge attack roll. +
*Weak:* 2 fire damage. *Standard:* 3 fire damage. *Strong:* 5 fire damage.

[NOTE]
====
*Always-Hit Rule:* Attacks always deal damage. The success tier determines which
damage value to use — not whether you hit.
====

.Sample Weapon Table (${name})
|===
| Weapon | Disciplines | Weak | Standard | Strong
| Longsword | 1 Blade, 1 Heavy Weapon | 2 | 3 | 5
| Shortbow | 1 Archery | 2 | 3 | 4
| Firebolt | 1 Fire Discipline | 2 | 3 | 5
|===

[quote]
____
"The difference between a hero and a corpse is not whether you get hit —
it's whether you get up again."
____

=== Heading 3 — The quick brown fox

The quick brown fox jumps over the lazy dog. 0123456789 +
THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG.
ADOC

  asciidoctor-pdf "docs/themes/_font-${slug}-sample.adoc" -o "${OUTDIR}/${slug}.pdf" 2>&1 || echo "FAILED: $name"
  echo "  ✓ ${OUTDIR}/${slug}.pdf"
done

echo "Concatenating..."
pdfunite "${OUTDIR}"/*.pdf starter-kit/font-comparison.pdf 2>/dev/null && echo "Combined PDF created!" || {
  echo "pdfunite not available, leaving individual PDFs in ${OUTDIR}/"
}

rm -f docs/themes/_font-*-theme.yml docs/themes/_font-*-sample.adoc
echo "=== Done ==="
ls -la starter-kit/font-comparison.pdf 2>/dev/null
