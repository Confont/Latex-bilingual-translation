param(
    [Parameter(Mandatory = $true)]
    [string]$TexPath
)

$ErrorActionPreference = "Stop"

$resolvedTex = Resolve-Path -LiteralPath $TexPath
$texFile = Get-Item -LiteralPath $resolvedTex
$workDir = $texFile.DirectoryName
$texName = $texFile.Name
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($texName)

Push-Location -LiteralPath $workDir
try {
    latexmk -xelatex -interaction=nonstopmode -halt-on-error $texName

    $auxExts = @(
        ".aux", ".bbl", ".blg", ".fdb_latexmk", ".fls", ".log",
        ".out", ".toc", ".xdv", ".synctex.gz", ".run.xml", ".bcf"
    )

    foreach ($ext in $auxExts) {
        $path = Join-Path $workDir ($baseName + $ext)
        if (Test-Path -LiteralPath $path) {
            Remove-Item -LiteralPath $path -Force
        }
    }

    $pdfPath = Join-Path $workDir ($baseName + ".pdf")
    if (-not (Test-Path -LiteralPath $pdfPath)) {
        throw "Expected PDF was not produced: $pdfPath"
    }
}
finally {
    Pop-Location
}
