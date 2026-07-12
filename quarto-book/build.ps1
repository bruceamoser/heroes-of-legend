# Heroes of Legend — Core Rulebook Build (Windows PowerShell)
# Uses Quarto + Typst to produce PDF from .qmd chapters

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$OutputDir = Join-Path $RepoRoot "_output"
$OutputPdf = Join-Path $OutputDir "heroes-of-legend-core-rules.pdf"

# ── Locate Quarto ────────────────────────────────────────────────────────────

$Quarto = Get-Command quarto -ErrorAction SilentlyContinue

if (-not $Quarto) {
    # Try known install location
    $QuartoPath = "C:\Program Files\quarto\bin\quarto.exe"
    if (Test-Path $QuartoPath) {
        $Quarto = $QuartoPath
    } else {
        Write-Host "ERROR: quarto not found. Install from: https://quarto.org/docs/get-started/" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "=== Heroes of Legend — Core Rulebook Build (Quarto + Typst) ===" -ForegroundColor Green
Write-Host ""

# ── Clean output ──────────────────────────────────────────────────────────────

Push-Location $RepoRoot
try {
    if (Test-Path $OutputDir) { Remove-Item -Recurse -Force $OutputDir }
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null

    # ── Build ─────────────────────────────────────────────────────────────────

    Write-Host "  Building core rulebook with Quarto + Typst..." -ForegroundColor Yellow
    & $Quarto render --to typst

    if (Test-Path $OutputPdf) {
        Write-Host "         done" -ForegroundColor Green
        Write-Host ""
        Write-Host "=== Build complete ===" -ForegroundColor Green
        Write-Host "Output: $OutputPdf"
        $size = (Get-Item $OutputPdf).Length
        Write-Host "Size: $([math]::Round($size/1KB, 1)) KB"
    } else {
        Write-Host ""
        Write-Host "ERROR: PDF was not produced. Check output above for errors." -ForegroundColor Red
        exit 1
    }
} finally {
    Pop-Location
}
