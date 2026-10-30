<#
Phase 8 Batch 2 -- read-only GUI package audit for the already verified R9 candidate.
No executable, GUI, module, network request or development environment helper is run.
Runs in Windows PowerShell 5.1+ after normal organizational script trust approval.
#>
[CmdletBinding()]
param(
    [string]$Root = (Join-Path $env:LOCALAPPDATA 'SeisComP-Development-R9'),
    [Parameter(Mandatory=$true)]
    [ValidatePattern('^[0-9a-fA-F]{64}$')]
    [string]$ExpectedManifestSha256
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$guiNames = @(
    'scconfig', 'scesv', 'scheli', 'scmapcut', 'scmm', 'scmv',
    'scmvx', 'scolv', 'scqcv', 'scrttv', 'scshowevent'
)
$rootItem = Get-Item -LiteralPath $Root -ErrorAction Stop
if (-not $rootItem.PSIsContainer) { throw 'Root is not a directory.' }
$rootPath = $rootItem.FullName.TrimEnd('\')
if ($rootPath -notmatch '^[A-Za-z]:\\') { throw 'Root must be an absolute local Windows path.' }
$manifestFile = Join-Path $rootPath 'SHA256SUMS.json'
if (-not (Test-Path -LiteralPath $manifestFile -PathType Leaf)) {
    throw 'Approved package manifest is missing.'
}
$actualManifest = (Get-FileHash -LiteralPath $manifestFile -Algorithm SHA256).Hash
if ($actualManifest -ine $ExpectedManifestSha256) {
    throw 'Approved R9 manifest identity mismatch; no audit performed.'
}
$manifest = Get-Content -LiteralPath $manifestFile -Raw | ConvertFrom-Json
if ($null -eq $manifest) { throw 'Package manifest JSON is empty.' }

# Normalize relative manifest keys only, never follow a path outside the installed copy.
$index = @{}
foreach ($entry in $manifest.PSObject.Properties) {
    $relative = [string]$entry.Name.Replace('/', '\')
    if ([IO.Path]::IsPathRooted($relative) -or $relative -match '(^|\\)\.\.(\\|$)') {
        throw ('Unsafe manifest key: '+$relative)
    }
    $key = $relative.ToLowerInvariant()
    if ($index.ContainsKey($key)) { throw ('Duplicate normalized manifest path: '+$relative) }
    $index.Add($key, [string]$entry.Value)
}

$results = New-Object 'System.Collections.Generic.List[object]'
function Check-Payload([string]$Relative, [string]$Category) {
    $key = $Relative.Replace('/', '\').ToLowerInvariant()
    $path = [IO.Path]::GetFullPath((Join-Path $rootPath $key))
    if (-not $path.StartsWith($rootPath+'\', [StringComparison]::OrdinalIgnoreCase)) {
        throw ('Audited path escapes root: '+$Relative)
    }
    $status = 'PASS'
    $isManifested = $index.ContainsKey($key)
    $isPresent = Test-Path -LiteralPath $path -PathType Leaf
    if (-not $isManifested -and -not $isPresent) {
        $status = 'MISSING_AND_UNMANIFESTED'
    }
    elseif (-not $isManifested) {
        $status = 'PRESENT_BUT_UNMANIFESTED'
    }
    elseif (-not $isPresent) {
        $status = 'MISSING'
    }
    elseif (((Get-Item -LiteralPath $path).Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        $status = 'REPARSE_POINT'
    }
    elseif ($index[$key] -notmatch '^[0-9a-fA-F]{64}$') {
        $status = 'BAD_MANIFEST_HASH'
    }
    else {
        try {
            if ((Get-FileHash -LiteralPath $path -Algorithm SHA256 -ErrorAction Stop).Hash -ine $index[$key]) {
                $status = 'HASH_MISMATCH'
            }
        }
        catch {
            $status = 'READ_ERROR'
        }
    }
    $results.Add([pscustomobject]@{ Category=$Category; RelativePath=$Relative; Status=$status })
}

foreach ($gui in $guiNames) { Check-Payload -Relative ('bin\'+$gui+'.exe') -Category 'GUI_EXE' }
foreach ($required in @('bin\qt.conf', 'bin\seiscomp_qt.dll',
    'bin\Qt5Core.dll', 'bin\Qt5Gui.dll', 'bin\Qt5Widgets.dll',
    'bin\Qt5Network.dll', 'bin\Qt5Svg.dll', 'bin\Qt5PrintSupport.dll',
    'bin\qt-plugins\platforms\qwindows.dll',
    'bin\qt-plugins\platforms\qoffscreen.dll',
    'share\windows\gui-package.json')) {
    Check-Payload -Relative $required -Category 'GUI_REQUIRED'
}

# Audit ALL manifest-listed Qt provider DLLs and ALL manifest-listed Qt plugin files.
foreach ($key in @($index.Keys | Sort-Object)) {
    if ($key -match '^bin\\qt-plugins\\' -or $key -match '^bin\\qt5[^\\]*\.dll$') {
        if (-not @($results | Where-Object { $_.RelativePath -ieq $key }).Count) {
            Check-Payload -Relative $key -Category 'QT_PACKAGED'
        }
    }
}

# Detect unlisted Qt plugin files without adding/changing anything.
$pluginsPath = Join-Path $rootPath 'bin\qt-plugins'
if (Test-Path -LiteralPath $pluginsPath -PathType Container) {
    foreach ($file in @(Get-ChildItem -LiteralPath $pluginsPath -Recurse -File -ErrorAction Stop)) {
        $key = $file.FullName.Substring($rootPath.Length+1).ToLowerInvariant()
        if (-not $index.ContainsKey($key) -and
            -not @($results | Where-Object { $_.RelativePath -ieq $key }).Count) {
            $results.Add([pscustomobject]@{ Category='QT_UNLISTED'; RelativePath=$key; Status='PRESENT_BUT_UNMANIFESTED' })
        }
    }
}

# Check structure and syntax; don't assume unknown gui-package.json schema.
$qtconfPath = Join-Path $rootPath 'bin\qt.conf'
$qtConfPass = $false
if (Test-Path -LiteralPath $qtconfPath -PathType Leaf) {
    $qtconf = Get-Content -LiteralPath $qtconfPath -Raw
    $qtConfPass = [bool]($qtconf -match '(?im)^\s*\[Paths\]\s*$' -and
        $qtconf -match '(?im)^\s*Prefix\s*=\s*\.\s*$' -and
        $qtconf -match '(?im)^\s*Plugins\s*=\s*qt-plugins\s*$')
}
$guiCatalogPath = Join-Path $rootPath 'share\windows\gui-package.json'
$catalogJsonPass = $false
if (Test-Path -LiteralPath $guiCatalogPath -PathType Leaf) {
    try {
        $catalog = Get-Content -LiteralPath $guiCatalogPath -Raw | ConvertFrom-Json -ErrorAction Stop
        $catalogJsonPass = ($null -ne $catalog)
    }
    catch { $catalogJsonPass = $false }
}

Write-Output '=== SEISCOMP NATIVE GUI PACKAGE AUDIT ==='
Write-Output ('ApprovedManifestSHA256: '+$actualManifest)
Write-Output ('GUIExecutableCountExpected: '+$guiNames.Count)
Write-Output ('QtConfigPathsConsistent: '+$qtConfPass)
Write-Output ('GuiCatalogJsonReadable: '+$catalogJsonPass)
$results | Sort-Object Category, RelativePath | Format-Table -AutoSize | Out-Host
$failures = @($results | Where-Object { $_.Status -ne 'PASS' })
Write-Output ('AuditedFiles: '+$results.Count)
Write-Output ('FileFailures: '+$failures.Count)
if ($failures.Count -eq 0 -and $qtConfPass -and $catalogJsonPass) {
    Write-Output 'STATIC_GUI_PACKAGE_AUDIT_PASS'
}
else {
    Write-Output 'STATIC_GUI_PACKAGE_AUDIT_NEEDS_REVIEW'
}
Write-Output 'GUI_NOT_RUN: no SeisComP executable, Qt plugin or controller was executed.'
Write-Output 'RUNTIME_NOT_QUALIFIED: file integrity does not prove DLL loading, startup, GUI functionality or scientific parity.'
