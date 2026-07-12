# Fix Unicode corruption (U+FFFD replacement characters) in all chapter files.
# Root cause: the replace-em-dashes.ps1 script appears to have corrupted
# en dashes, multiplication signs, fractions, and other special characters.
#
# Strategy: Replace � (U+FFFD) based on surrounding context.
# More specific patterns are applied first to avoid conflicts.

$ErrorActionPreference = "Stop"
$chapterDir = "$PSScriptRoot/chapters"
$files = Get-ChildItem "$chapterDir/*.qmd"
$totalFixed = 0
$results = @()

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $beforeCount = ([regex]::Matches($content, "\uFFFD")).Count
    if ($beforeCount -eq 0) { continue }
    
    $original = $content
    
    # ── Phase 1: Specific multi-word patterns ─────────────────────────────
    # These must be applied BEFORE generic patterns to avoid conflicts.
    
    # Copyright line in 00-front-matter
    $content = $content -replace "\uFFFD 2024\uFFFD2026", "(c) 2024-2026"
    
    # Monster building formula
    $content = $content -replace "d6\uFFFDChallenge\uFFFD2", "d6 x Challenge x 2"
    $content = $content -replace "2d6 \uFFFD 10", "2d6 x 10"
    
    # ── Phase 2: Specific word patterns ───────────────────────────────────
    
    # Challenge rating 1/2
    $content = $content -replace "Challenge \uFFFD", "Challenge 1/2"
    $content = $content -replace "\bC\uFFFD\b", "C1/2"
    
    # resumé → resume
    $content = $content -replace "resum\uFFFD", "resume"
    
    # ── Phase 3: Multiplication patterns (before range patterns) ──────────
    
    # 1.5x multiplier
    $content = $content -replace "1\.5\uFFFD", "1.5x"
    
    # Brawn formula: "Brawn � 5" → "Brawn x 5"
    $content = $content -replace "(Brawn) \uFFFD (\d)", '$1 x $2'
    
    # Standalone multiplier: digit(s) followed by � then space/end/paren/newline
    # Example: "2�" as in "1.5�" (already handled above) or "2�" at end of line
    # Must come AFTER 1.5x pattern to avoid double-matching
    $content = $content -replace "(\d)\uFFFD(?=\s|$|\)|\.)", '$1x'
    
    # ── Phase 4: Numeric range patterns (most common case) ────────────────
    # "1�8" → "1-8", "9�14" → "9-14", etc.
    $content = $content -replace "(\d)\uFFFD(\d)", '$1-$2'
    
    # ── Phase 5: Footnote markers ─────────────────────────────────────────
    # In 05-classes.qmd: Odd^�^ and Unbalanced^�^ headers and ^�^ footnotes
    # Use asterisk as safe ASCII footnote marker
    $content = $content -replace "\^\uFFFD\^", "^*^"
    
    # ── Phase 6: Bare � in table cells (em dash meaning "varies" or "N/A")
    # "| � |" → "| -- |"
    $content = $content -replace "\|\s*\uFFFD\s*\|", "| -- |"
    
    # ── Phase 7: Any remaining bare � → double-hyphen (safest fallback)
    $content = $content -replace "\uFFFD", "-"
    
    # ── Validate and write ────────────────────────────────────────────────
    $afterCount = ([regex]::Matches($content, "\uFFFD")).Count
    $fixed = $beforeCount - $afterCount
    
    if ($content -ne $original) {
        Set-Content $file.FullName -Value $content -Encoding UTF8 -NoNewline
    }
    
    $result = "$($file.Name): $beforeCount corruptions → $afterCount remaining ($fixed fixed)"
    Write-Output $result
    $results += $result
    $totalFixed += $fixed
}

# Also handle index.qmd
$idxPath = "$PSScriptRoot/index.qmd"
if (Test-Path $idxPath) {
    $content = Get-Content $idxPath -Raw -Encoding UTF8
    $beforeCount = ([regex]::Matches($content, "\uFFFD")).Count
    if ($beforeCount -gt 0) {
        $content = $content -replace "\uFFFD", "-"
        Set-Content $idxPath -Value $content -Encoding UTF8 -NoNewline
        $afterCount = ([regex]::Matches((Get-Content $idxPath -Raw -Encoding UTF8), "\uFFFD")).Count
        $fixed = $beforeCount - $afterCount
        $result = "index.qmd: $beforeCount corruptions → $afterCount remaining ($fixed fixed)"
        Write-Output $result
        $results += $result
        $totalFixed += $fixed
    }
}

Write-Output "============================"
Write-Output "TOTAL FIXED: $totalFixed corruption(s)"
Write-Output "Files processed: $($files.Count + 1)"
