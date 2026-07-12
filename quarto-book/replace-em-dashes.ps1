# Replace em dashes (U+2014) in all chapter files
$ErrorActionPreference = "Stop"
$chapterDir = "$PSScriptRoot/chapters"
$files = Get-ChildItem "$chapterDir/*.qmd"
$totalBefore = 0
$totalAfter = 0
$results = @()

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $before = ([regex]::Matches($content, "\u2014")).Count
    $totalBefore += $before
    
    # Replace spaced em dash with comma (most common case)
    $content = $content -replace " \u2014 ", ", "
    # Replace em dash at start of line with nothing
    $content = $content -replace "(?m)^\u2014 ", ""
    # Replace remaining em dash followed by space with period+space
    $content = $content -replace "\u2014 ", ". "
    # Replace any remaining bare em dashes
    $content = $content -replace "\u2014", ", "
    
    Set-Content $file.FullName -Value $content -Encoding UTF8 -NoNewline
    
    $after = ([regex]::Matches((Get-Content $file.FullName -Raw -Encoding UTF8), "\u2014")).Count
    $totalAfter += $after
    
    $result = "$($file.Name): $before -> $after"
    Write-Output $result
    $results += $result
}

# Also handle index.qmd
$idxPath = "$PSScriptRoot/index.qmd"
if (Test-Path $idxPath) {
    $content = Get-Content $idxPath -Raw -Encoding UTF8
    $before = ([regex]::Matches($content, "\u2014")).Count
    $totalBefore += $before
    
    $content = $content -replace " \u2014 ", ", "
    $content = $content -replace "(?m)^\u2014 ", ""
    $content = $content -replace "\u2014 ", ". "
    $content = $content -replace "\u2014", ", "
    
    Set-Content $idxPath -Value $content -Encoding UTF8 -NoNewline
    
    $after = ([regex]::Matches((Get-Content $idxPath -Raw -Encoding UTF8), "\u2014")).Count
    $totalAfter += $after
    
    $result = "index.qmd: $before -> $after"
    Write-Output $result
    $results += $result
}

Write-Output "============================"
Write-Output "TOTAL: $totalBefore -> $totalAfter"
Write-Output "Files modified: $($files.Count + 1)"
