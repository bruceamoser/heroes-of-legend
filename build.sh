#!/bin/bash
# Heroes of Legend — Core Rulebook Build (Linux/macOS)
# Assembles AsciiDoc chapters and produces a single PDF via asciidoctor-pdf
set -e

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
STARTER_KIT="$REPO_ROOT/starter-kit"
THEMES_DIR="$REPO_ROOT/docs/themes"

ASCIIDOCTOR_PDF=$(which asciidoctor-pdf 2>/dev/null || true)

# ── Locate tools ──────────────────────────────────────────────────────────────

if [ -z "$ASCIIDOCTOR_PDF" ]; then
    echo "ERROR: asciidoctor-pdf not found. Install via: gem install asciidoctor-pdf"
    exit 1
fi

# ── Prepare output folder ────────────────────────────────────────────────────

rm -rf "$STARTER_KIT"
mkdir -p "$STARTER_KIT"

echo ""
echo "=== Heroes of Legend — Core Rulebook Build ==="
echo ""

# ── 1. Core Rulebook PDF ─────────────────────────────────────────────────────

echo "  Building core rulebook..."
asciidoctor-pdf \
    -a pdf-fontsdir="$THEMES_DIR/fonts" \
    -o "$STARTER_KIT/heroes-of-legend-core-rules.pdf" \
    "$REPO_ROOT/docs/heroes-of-legend.adoc" 2>&1 | grep -v "^$" || true
echo "         done"

echo ""
echo "=== Build complete ==="
echo "Output: $STARTER_KIT/heroes-of-legend-core-rules.pdf"
ls -lh "$STARTER_KIT/heroes-of-legend-core-rules.pdf" 2>/dev/null || echo "(PDF not produced — check for errors above)"
