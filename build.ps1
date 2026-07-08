# Heroes of Legend — Core Rulebook Build (Windows PowerShell)
# Mirrors build.sh — produces PDF from AsciiDoc chapters

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$StarterKit = Join-Path $RepoRoot "starter-kit"
$ThemesDir = Join-Path $RepoRoot "docs/themes"

# ── Locate asciidoctor-pdf ───────────────────────────────────────────────────

$AsciidoctorPdf = Get-Command asciidoctor-pdf -ErrorAction SilentlyContinue

if (-not $AsciidoctorPdf) {
    Write-Host "ERROR: asciidoctor-pdf not found. Install via: gem install asciidoctor-pdf" -ForegroundColor Red
    exit 1
}

# ── Prepare output folder ────────────────────────────────────────────────────

if (Test-Path $StarterKit) { Remove-Item -Recurse -Force $StarterKit }
New-Item -ItemType Directory -Path $StarterKit -Force | Out-Null

Write-Host ""
Write-Host "=== Heroes of Legend — Core Rulebook Build ===" -ForegroundColor Green
Write-Host ""

# ── 1. Core Rulebook PDF ─────────────────────────────────────────────────────

Write-Host "  Building core rulebook..." -ForegroundColor Yellow
$MasterDoc = Join-Path $RepoRoot "docs/heroes-of-legend.adoc"
$OutputPdf = Join-Path $StarterKit "heroes-of-legend-core-rules.pdf"

& asciidoctor-pdf `
    -a pdf-fontsdir="$ThemesDir/fonts" `
    -o "$OutputPdf" `
    "$MasterDoc"

Write-Host "         done" -ForegroundColor Green

Write-Host ""
Write-Host "=== Build complete ===" -ForegroundColor Green
Write-Host "Output: $OutputPdf"

if (Test-Path $OutputPdf) {
    $size = (Get-Item $OutputPdf).Length
    Write-Host "Size: $([math]::Round($size/1KB, 1)) KB"
} else {
    Write-Host "(PDF not produced — check for errors above)" -ForegroundColor Red
}
