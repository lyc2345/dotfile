param(
    [ValidateSet("All", "Home", "Config", "Windows")]
    [string[]]$Groups = @("All"),
    [switch]$WhatIf
)

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $scriptDir "windows-links.ps1")

$dotfilesRoot = Get-DotfilesRoot
$linkGroups = Get-DotfileLinkGroups

function Write-Step {
    param([string]$Message)
    Write-Host ""
    Write-Host "==> $Message" -ForegroundColor Cyan
}

function Get-SelectedGroups {
    if ($Groups -contains "All") {
        return @($linkGroups.Keys)
    }

    return $Groups
}

function Test-HardLinkToSource {
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Target
    )

    if (-not (Test-Path $Source) -or -not (Test-Path $Target)) {
        return $false
    }

    $sourceFullName = (Get-Item -LiteralPath $Source -Force).FullName
    $links = & fsutil hardlink list $Target 2>$null
    if ($LASTEXITCODE -ne 0) {
        return $false
    }

    foreach ($link in $links) {
        if ([string]::IsNullOrWhiteSpace($link)) {
            continue
        }

        $candidate = $link.Trim()
        if (-not [System.IO.Path]::IsPathRooted($candidate)) {
            $candidate = Join-Path (Split-Path -Qualifier $sourceFullName) $candidate.TrimStart("\")
        }

        if ([string]::Equals($candidate, $sourceFullName, [System.StringComparison]::OrdinalIgnoreCase)) {
            return $true
        }
    }

    return $false
}

function Remove-DotfileLink {
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Target,
        [Parameter(Mandatory = $true)][string]$Kind
    )

    $targetItem = Get-Item -LiteralPath $Target -Force -ErrorAction SilentlyContinue
    if (-not $targetItem) {
        Write-Host "Skip missing target: $Target" -ForegroundColor DarkGray
        return
    }

    $isLink = $targetItem.LinkType -in @("Junction", "SymbolicLink")
    $isManagedHardLink = $false

    if (-not $isLink -and $Kind -eq "File") {
        $isManagedHardLink = Test-HardLinkToSource -Source $Source -Target $Target
    }

    if (-not $isLink -and -not $isManagedHardLink) {
        Write-Host "Skip non-managed target: $Target" -ForegroundColor Yellow
        return
    }

    Write-Host "Remove $Target"
    if ($WhatIf) {
        return
    }

    Remove-Item -LiteralPath $Target -Force
}

function Uninstall-Links {
    Write-Step "Removing dotfile links"
    foreach ($group in Get-SelectedGroups) {
        if (-not $linkGroups.Contains($group)) {
            throw "Unknown group: $group"
        }

        foreach ($link in $linkGroups[$group]) {
            $source = Join-Path $dotfilesRoot $link.Source
            Remove-DotfileLink -Source $source -Target $link.Target -Kind $link.Kind
        }
    }
}

Write-Step "Selected dotfile groups"
foreach ($group in Get-SelectedGroups) {
    Write-Host ("[{0}]" -f $group) -ForegroundColor Green
    foreach ($link in $linkGroups[$group]) {
        Write-Host ("  - {0}" -f $link.Target)
    }
}

Uninstall-Links

Write-Step "Completed"
Write-Host "Only junctions, symbolic links, and hard links pointing back to this repo are removed."
