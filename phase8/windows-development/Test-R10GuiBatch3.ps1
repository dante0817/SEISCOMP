<#
Phase 8 / Batch 3: all 11 original R10 GUI preflights, no GUI launch.
Read-only. Requires the existing Batch 1 Start-DevelopmentGui.ps1 in the SAME
engineering-tools folder, outside the immutable verified installed package.
Does not run a GUI, execute environment helper, start services or connect to
network endpoints. It is not a runtime or scientific qualification.
#>
[CmdletBinding()]
param(
    [string]$Root = (Join-Path $env:LOCALAPPDATA 'SeisComP-Development-R10'),
    [ValidatePattern('^[A-Fa-f0-9]{64}$')]
    [string]$ExpectedManifestSha256 = '83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74',
    [switch]$IncludeEnvironmentInventory
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$names = @('scconfig','scesv','scheli','scmapcut','scmm','scmv',
           'scmvx','scolv','scqcv','scrttv','scshowevent')
$rootItem = Get-Item -LiteralPath $Root -ErrorAction Stop
if (-not $rootItem.PSIsContainer) { throw 'R10 root is not a directory' }
$rootPath = $rootItem.FullName.TrimEnd('\')
if ($rootPath -notmatch '^[A-Za-z]:\\') { throw 'R10 root is not an absolute Windows drive path' }
if (($rootItem.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw 'R10 root may not be a reparse point'
}
$manifestPath = Join-Path $rootPath 'SHA256SUMS.json'
$actualManifest = (Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256 -ErrorAction Stop).Hash
if ($actualManifest -ine $ExpectedManifestSha256) {
    throw 'Installed R10 manifest identity differs from externally pinned digest'
}
$manifest = Get-Content -LiteralPath $manifestPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
if (@($manifest.PSObject.Properties).Count -ne 856) {
    throw 'Unexpected installed R10 manifest entry count'
}

# The copy installer creates a separate sibling receipt outside the install.
$receiptPath = $rootPath + '.install-receipt.json'
if (-not (Test-Path -LiteralPath $receiptPath -PathType Leaf)) {
    throw 'R10 installation receipt missing'
}
$receipt = Get-Content -LiteralPath $receiptPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
if ([string]$receipt.manifest_sha256 -ine $ExpectedManifestSha256 -or
    [string]$receipt.destination -ine $rootPath -or
    [int]$receipt.verified_files -ne 856) {
    throw 'R10 installation receipt does not match this installation'
}

function Assert-ManifestedFile([string]$Relative) {
    $name = $Relative.Replace('\','/')
    $entryMatches = @($manifest.PSObject.Properties | Where-Object {
        $_.Name.Replace('\','/') -ieq $name
    })
    if ($entryMatches.Count -ne 1) { throw ('Missing/duplicate manifest entry: '+$Relative) }
    $file = [IO.Path]::GetFullPath((Join-Path $rootPath $Relative))
    if (-not $file.StartsWith($rootPath+'\', [StringComparison]::OrdinalIgnoreCase)) {
        throw ('Manifest file escapes installation root: '+$Relative)
    }
    if (-not (Test-Path -LiteralPath $file -PathType Leaf)) {
        throw ('Missing R10 payload: '+$Relative)
    }
    if (((Get-Item -LiteralPath $file).Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw ('R10 payload is a reparse point: '+$Relative)
    }
    $expected = [string]$entryMatches[0].Value
    if ($expected -notmatch '^[a-fA-F0-9]{64}$') { throw ('Bad digest: '+$Relative) }
    if ((Get-FileHash -LiteralPath $file -Algorithm SHA256 -ErrorAction Stop).Hash -ine $expected) {
        throw ('R10 payload SHA-256 mismatch: '+$Relative)
    }
    return $file
}

# Check the R10-specific recovered Qt plugin and catalog before application
# preflights. The original Batch 1 GUI launcher predates R10 packaging.
$qwindows = Assert-ManifestedFile 'bin\qt-plugins\platforms\qwindows.dll'
$qoffscreen = Assert-ManifestedFile 'bin\qt-plugins\platforms\qoffscreen.dll'
$catalogFile = Assert-ManifestedFile 'share\windows\gui-package.json'
$catalog = Get-Content -LiteralPath $catalogFile -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
if ($null -eq $catalog.Qt -or
    $null -eq $catalog.Qt.'qwindows.dll' -or
    $null -eq $catalog.Qt.'qoffscreen.dll') {
    throw 'R10 GUI catalog lacks Qt platform entries'
}
foreach ($qtName in @('qwindows.dll','qoffscreen.dll')) {
    $expectedPath = 'bin/qt-plugins/platforms/' + $qtName
    $entry = $catalog.Qt.$qtName
    if ([string]$entry.path -ine $expectedPath) { throw ('Qt catalog path mismatch: '+$qtName) }
    $file = if ($qtName -eq 'qwindows.dll') { $qwindows } else { $qoffscreen }
    if ((Get-FileHash -LiteralPath $file -Algorithm SHA256 -ErrorAction Stop).Hash -ine [string]$entry.sha256) {
        throw ('Qt catalog hash mismatch: '+$qtName)
    }
}

$launcher = Join-Path $PSScriptRoot 'Start-DevelopmentGui.ps1'
if (-not (Test-Path -LiteralPath $launcher -PathType Leaf)) {
    throw 'Existing Batch 1 guarded GUI launcher missing from this tools directory'
}
if ([IO.Path]::GetFullPath($launcher).StartsWith($rootPath+'\', [StringComparison]::OrdinalIgnoreCase)) {
    throw 'Engineering launch helper must remain OUTSIDE installed R10'
}
if (((Get-Item -LiteralPath $launcher).Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw 'Engineering launcher reparse point rejected'
}

Write-Output '=== BATCH 3 R10 NATIVE GUI INTEGRATION PREFLIGHT ==='
Write-Output ('R10InstalledManifestSHA256: '+$actualManifest)
Write-Output 'InstalledManifestEntries: 856'
Write-Output 'InstallReceipt: VERIFIED'
Write-Output 'QtPlatformPluginsAndCatalog: VERIFIED'
Write-Output 'All GUI checks use preflight mode; no -Run or environment helper is invoked.'

$passed = [System.Collections.Generic.List[string]]::new()
$failed = [System.Collections.Generic.List[string]]::new()
foreach ($name in $names) {
    try {
        $output = @(& $launcher -Root $rootPath -ExpectedManifestSha256 $ExpectedManifestSha256 -Application $name -WarningAction SilentlyContinue)
        if ($output -notcontains ('PREFLIGHT_PASS: '+$name)) {
            throw 'Guarded launcher did not report PREFLIGHT_PASS'
        }
        if (@($output | Where-Object { $_ -like 'NOT_RUN:*' }).Count -eq 0) {
            throw 'Guarded launcher did not report NOT_RUN'
        }
        [void]$passed.Add($name)
        Write-Output ('ENTRYPOINT_PREFLIGHT_PASS: '+$name)
    }
    catch {
        [void]$failed.Add($name)
        Write-Output ('ENTRYPOINT_PREFLIGHT_FAIL: '+$name)
        Write-Output ('  ErrorType: '+$_.Exception.GetType().Name)
        Write-Output ('  Detail: '+$_.Exception.Message)
    }
}
Write-Output ('GUIEntrypointsPassed: '+$passed.Count+'/'+$names.Count)
Write-Output ('GUIEntrypointsFailed: '+$failed.Count)
if ($failed.Count -ne 0) { throw 'BATCH3_R10_GUI_PREFLIGHT_NEEDS_REVIEW' }

if ($IncludeEnvironmentInventory) {
    $readiness = Join-Path $PSScriptRoot 'Get-DevelopmentGuiReadiness.ps1'
    if (-not (Test-Path -LiteralPath $readiness -PathType Leaf)) {
        throw 'Existing Batch 1 environment inventory script missing'
    }
    Write-Output '=== OPTIONAL READ-ONLY HOST ENVIRONMENT INVENTORY ==='
    & $readiness -Root $rootPath -ExpectedManifestSha256 $ExpectedManifestSha256
    # This optional inventory can disclose local PIDs. It does NOT prove isolation.
}
Write-Output 'BATCH3_R10_GUI_PREFLIGHT_PASS'
Write-Output 'GUI_NOT_RUN; NETWORK_ISOLATION_NOT_PROVEN; SCIENTIFIC_NOT_QUALIFIED'
