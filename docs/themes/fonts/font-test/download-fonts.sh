#!/bin/bash
# Download recommended fonts from Google Fonts GitHub
set -e
BASE="https://raw.githubusercontent.com/google/fonts/main"

# EB Garamond — classic literary serif
echo "=== EB Garamond ==="
for f in EBGaramond-Regular.ttf EBGaramond-Bold.ttf EBGaramond-Italic.ttf EBGaramond-BoldItalic.ttf; do
  wget -q "$BASE/ofl/ebgaramond/static/$f" -O "$f" 2>/dev/null && echo "  ✓ $f" || echo "  ✗ $f"
done

# Crimson Pro — elegant modernized Garamond
echo "=== Crimson Pro ==="
for f in CrimsonPro-Regular.ttf CrimsonPro-Bold.ttf CrimsonPro-Italic.ttf CrimsonPro-BoldItalic.ttf; do
  wget -q "$BASE/ofl/crimsonpro/static/$f" -O "$f" 2>/dev/null && echo "  ✓ $f" || echo "  ✗ $f"
done

# Alegreya — humanist, medieval character
echo "=== Alegreya ==="
for f in Alegreya-Regular.ttf Alegreya-Bold.ttf Alegreya-Italic.ttf Alegreya-BoldItalic.ttf; do
  wget -q "$BASE/ofl/alegreya/static/$f" -O "$f" 2>/dev/null && echo "  ✓ $f" || echo "  ✗ $f"
done

# Cardo — classical scholarship
echo "=== Cardo ==="
for f in Cardo-Regular.ttf Cardo-Bold.ttf Cardo-Italic.ttf Cardo-BoldItalic.ttf; do
  wget -q "$BASE/ofl/cardo/static/$f" -O "$f" 2>/dev/null && echo "  ✓ $f" || echo "  ✗ $f"
done

# Pirata One — gothic/blackletter display
echo "=== Pirata One ==="
wget -q "$BASE/ofl/pirataone/PirataOne-Regular.ttf" -O PirataOne-Regular.ttf 2>/dev/null && echo "  ✓ PirataOne-Regular.ttf" || echo "  ✗ PirataOne-Regular.ttf"

# Almendra — fantasy display serif
echo "=== Almendra ==="
for f in Almendra-Regular.ttf Almendra-Bold.ttf Almendra-Italic.ttf Almendra-BoldItalic.ttf; do
  wget -q "$BASE/ofl/almendra/static/$f" -O "$f" 2>/dev/null && echo "  ✓ $f" || echo "  ✗ $f"
done

echo "=== Done ==="
ls -la *.ttf 2>/dev/null | wc -l
echo "font files downloaded"
