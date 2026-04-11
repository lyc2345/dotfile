param(
    [ValidateSet("All", "Home", "Config", "Windows")]
    [string[]]$Groups = @("All"),
    [ValidateSet("Junction", "SymbolicLink", "Copy")]
    [string]$LinkMode = "Junction",
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

function Get-NormalizedPath {
    param([Parameter(Mandatory = $true)][string]$Path)

    try {
        return (Resolve-Path -LiteralPath $Path -ErrorAction Stop).Path
    }
    catch {
        return [System.IO.Path]::GetFullPath($Path)
    }
}

function Ensure-UserConfigDirectory {
    $configDir = Join-Path $env:USERPROFILE ".config"
    $configItem = Get-Item -LiteralPath $configDir -Force -ErrorAction SilentlyContinue
    $legacyConfigPath = Join-Path $dotfilesRoot ".config"

    if (-not $configItem) {
        if (-not $WhatIf) {
            New-Item -ItemType Directory -Force -Path $configDir | Out-Null
        }
        return
    }

    if ($configItem.LinkType -in @("Junction", "SymbolicLink")) {
        $targets = @($configItem.Target)
        foreach ($target in $targets) {
            $candidate = [string]$target
            if (-not [System.IO.Path]::IsPathRooted($candidate)) {
                $candidate = Join-Path $configItem.DirectoryName $candidate
            }

            if ([string]::Equals((Get-NormalizedPath $candidate), (Get-NormalizedPath $legacyConfigPath), [System.StringComparison]::OrdinalIgnoreCase)) {
                Write-Host "Replacing legacy .config link with a real directory: $configDir" -ForegroundColor Yellow
                if (-not $WhatIf) {
                    Remove-Item -LiteralPath $configDir -Force
                    New-Item -ItemType Directory -Force -Path $configDir | Out-Null
                }
                return
            }
        }

        Write-Host "Skip replacing linked .config: $configDir" -ForegroundColor Yellow
        return
    }

    if (-not $configItem.PSIsContainer) {
        throw "$configDir exists but is not a directory."
    }
}

function New-Link {
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Target,
        [Parameter(Mandatory = $true)][string]$Kind
    )

    if (-not (Test-Path $Source)) {
        Write-Host "Skip missing source: $Source" -ForegroundColor Yellow
        return
    }

    $targetParent = Split-Path -Parent $Target
    if ($targetParent -and -not (Test-Path $targetParent)) {
        if (-not $WhatIf) {
            New-Item -ItemType Directory -Force -Path $targetParent | Out-Null
        }
    }

    $existingTarget = Get-Item -LiteralPath $Target -Force -ErrorAction SilentlyContinue
    if ($existingTarget) {
        Write-Host "Skip existing target: $Target" -ForegroundColor Yellow
        return
    }

    Write-Host "Link $Target -> $Source"
    if ($WhatIf) {
        return
    }

    if ($LinkMode -eq "Copy") {
        if ($Kind -eq "Directory") {
            Copy-Item -Path $Source -Destination $Target -Recurse
        }
        else {
            Copy-Item -Path $Source -Destination $Target
        }
        return
    }

    if ($LinkMode -eq "SymbolicLink") {
        New-Item -ItemType SymbolicLink -Path $Target -Target $Source | Out-Null
        return
    }

    if ($Kind -eq "Directory") {
        New-Item -ItemType Junction -Path $Target -Target $Source | Out-Null
        return
    }

    New-Item -ItemType HardLink -Path $Target -Target $Source | Out-Null
}

function Install-Links {
    Write-Step "Creating dotfile links"
    foreach ($group in Get-SelectedGroups) {
        if (-not $linkGroups.Contains($group)) {
            throw "Unknown group: $group"
        }

        foreach ($link in $linkGroups[$group]) {
            $source = Join-Path $dotfilesRoot $link.Source
            New-Link -Source $source -Target $link.Target -Kind $link.Kind
        }
    }
}

function Show-Summary {
    Write-Step "Selected dotfile groups"
    foreach ($group in Get-SelectedGroups) {
        Write-Host ("[{0}]" -f $group) -ForegroundColor Green
        foreach ($link in $linkGroups[$group]) {
            Write-Host ("  - {0} -> {1}" -f $link.Source, $link.Target)
        }
    }
}

Show-Summary
Ensure-UserConfigDirectory
Install-Links

Write-Step "Completed"
Write-Host "Default mode uses directory junctions and file hard links."
Write-Host "Use -LinkMode Copy if you want copied files instead of links."
