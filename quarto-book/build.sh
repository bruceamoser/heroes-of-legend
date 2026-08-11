#!/bin/bash
# Heroes of Legend — Core Rulebook Build (Linux/macOS)
# Uses Quarto + Typst to produce PDF from .qmd chapters
set -e

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
OUTPUT_DIR="$REPO_ROOT/_output"
OUTPUT_PDF="$OUTPUT_DIR/heroes-of-legend-core-rules.pdf"

QUARTO=$(which quarto 2>/dev/null || true)

# ── Locate tools ──────────────────────────────────────────────────────────────

if [ -z "$QUARTO" ]; then
    echo "ERROR: quarto not found in PATH."
    echo "Install from: https://quarto.org/docs/get-started/"
    exit 1
fi

echo ""
echo "=== Heroes of Legend — Core Rulebook Build (Quarto + Typst) ==="
echo ""

# ── Clean output ──────────────────────────────────────────────────────────────

rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

# ── Build ─────────────────────────────────────────────────────────────────────

echo "  Building core rulebook with Quarto + Typst..."
quarto render --to typst

if [ -f "$OUTPUT_PDF" ]; then
    echo "         done"
    echo ""
    echo "=== Build complete ==="
    echo "Output: $OUTPUT_PDF"
    ls -lh "$OUTPUT_PDF"
else
    echo ""
    echo "ERROR: PDF was not produced. Check output above for errors."
    exit 1
fi
