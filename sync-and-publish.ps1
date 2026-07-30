[CmdletBinding()]
param(
    [switch]$NoPush
)

$ErrorActionPreference = 'Stop'
$sourcePath = 'D:\obsidian\note\zzliang\LeetCode'
$projectPath = $PSScriptRoot
$contentPath = Join-Path $projectPath 'content'

$resolvedSource = (Resolve-Path -LiteralPath $sourcePath).Path
$resolvedProject = (Resolve-Path -LiteralPath $projectPath).Path
$resolvedContent = (Resolve-Path -LiteralPath $contentPath).Path

$contentIsInsideProject = $resolvedContent.StartsWith(
    $resolvedProject,
    [System.StringComparison]::OrdinalIgnoreCase
)
if ($resolvedSource -eq $resolvedContent -or -not $contentIsInsideProject) {
    throw 'Safety check failed: content must be a separate directory inside the Quartz project.'
}

& robocopy $resolvedSource $resolvedContent /MIR /XD .obsidian .git private /XF .DS_Store Thumbs.db /R:2 /W:1 /NFL /NDL /NJH /NJS
$robocopyExitCode = $LASTEXITCODE
if ($robocopyExitCode -ge 8) {
    throw "Robocopy failed with exit code $robocopyExitCode."
}

$indexPath = Join-Path $contentPath 'index.md'
if (-not (Test-Path -LiteralPath $indexPath)) {
    Copy-Item -LiteralPath (Join-Path $projectPath 'default-index.md') -Destination $indexPath
}

Push-Location $projectPath
try {
    & git add --all
    & git diff --cached --quiet
    if ($LASTEXITCODE -eq 0) {
        Write-Host 'No changes to publish.'
        exit 0
    }

    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    & git commit -m "docs: sync LeetCode notes $timestamp"
    if ($LASTEXITCODE -ne 0) {
        throw 'Git commit failed. Configure git user.name and user.email first.'
    }

    if (-not $NoPush) {
        $originUrl = (& git remote get-url origin 2>$null)
        if (-not $originUrl -or $originUrl -match 'jackyzha0/quartz') {
            throw 'Your GitHub repository is not configured. A local commit was created but not pushed.'
        }
        & git push origin v5
        if ($LASTEXITCODE -ne 0) {
            throw 'Git push failed. Check GitHub authentication and the remote URL.'
        }
    }
} finally {
    Pop-Location
}
