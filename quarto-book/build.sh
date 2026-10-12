#!/bin/bash
# Heroes of Legend — Core Rulebook Build (Linux/macOS)
# Uses Quarto + Typst to produce PDF from .qmd chapters
set -e

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
OUTPUT_DIR="$REPO_ROOT/_output"
OUTPUT_PDF="$OUTPUT_DIR/Heroes-of-Legend.pdf"

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

# ── Structural gate (issue #424, MIGRATION-SPEC acceptance item 4) ────────────
# Runs BEFORE the render, and before _output is wiped, so a structural defect
# fails loudly without destroying the previous PDF. Covers what a successful
# render hides: ch18 (2026-09-14) shipped with its {=typst} block never closed,
# so the PDF printed the chapter as its own source, and the build was green.
# `python3 check-native-typst.py --selftest` proves the gate can fail.

echo "  Checking native-Typst structure..."
python3 "$REPO_ROOT/check-native-typst.py"
echo ""

# ── Discipline vocabulary gate (issue #563, the collapse series) ──────────────
# The collapse series edits one vocabulary across twelve chapters, and the
# failure mode is a partial sweep: three chapters updated, four not. Every mode
# runs here and prints file:line for each survivor of the old weapon-family
# vocabulary, so no vocabulary PR can land without the whole sweep it claims.
# Issue #575 drove the sweep to zero, so this gate is now fatal: any survivor
# of the old weapon-family vocabulary stops the build here.

echo "  Checking Discipline vocabulary..."
python3 "$REPO_ROOT/../docs/check-discipline-vocabulary.py"
echo ""

# ── Requires field gate (issue #586) ──────────────────────────────────────────
# The card field is `Requires:`, not `Kit:`, and the glossary terms Kit and Kit
# Point are retired. Unlike the collapse-series sweep above, this mode is fatal:
# nothing in the book may carry the old field name or either kit term, so any
# reintroduction stops the build here.

echo "  Checking Requires field..."
python3 "$REPO_ROOT/../docs/check-discipline-vocabulary.py" --requires
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
