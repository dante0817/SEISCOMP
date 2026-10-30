<#
SeisComP Phase 8 development GUI preflight / explicitly gated launcher.
SOURCE ONLY. Do not place this file inside the immutable R9 candidate or its
verified per-user installation. It is separate tooling, not a release launcher.
Default: validate package identity and report planned launch; run NOTHING.
-RUN requires a separately approved, isolated and reviewed runtime procedure.
This script does not itself enforce a network isolation boundary.
#>
[CmdletBinding(SupportsShouldProcess=$true)]
param(
    [Parameter(Mandatory=$true)][string]$Root,
    [Parameter(Mandatory=$true)][ValidatePattern('^[A-Fa-f0-9]{64}$')][string]$ExpectedManifestSha256,
    [Parameter(Mandatory=$true)]
    [ValidateSet('scconfig','scesv','scheli','scmapcut','scmm','scmv','scmvx','scolv','scqcv','scrttv','scshowevent')]
    [string]$Application,
    [string[]]$ApplicationArgs=@(),
    [switch]$Run,
    [string]$AuthorizationReference,
    [switch]$IsolatedProfileReviewed,
    [switch]$UserConfigurationReviewed
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'

function Assert-ManifestedFile {
    param([object]$Manifest,[string]$InstallRoot,[string]$RelativePath)
    $entries=@($Manifest.PSObject.Properties | Where-Object {
        $_.Name.Replace('/','\') -ieq $RelativePath
    })
    if ($entries.Count -ne 1) { throw ('Expected exactly one manifest entry: '+$RelativePath) }
    $relative=$entries[0].Name.Replace('/','\')
    if ([IO.Path]::IsPathRooted($relative) -or $relative.StartsWith('..\')) {
        throw ('Invalid manifest path: '+$relative)
    }
    $file=[IO.Path]::GetFullPath((Join-Path $InstallRoot $relative))
    if (-not $file.StartsWith($InstallRoot+'\',[StringComparison]::OrdinalIgnoreCase)) {
        throw ('Manifest entry escapes development installation: '+$relative)
    }
    if (-not (Test-Path -LiteralPath $file -PathType Leaf)) {
        throw ('Required installed file missing: '+$relative)
    }
    if (((Get-Item -LiteralPath $file).Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw ('Required file is a reparse point: '+$relative)
    }
    $expected=[string]$entries[0].Value
    if ($expected -notmatch '^[A-Fa-f0-9]{64}$') { throw ('Invalid file digest: '+$relative) }
    $actual=(Get-FileHash -LiteralPath $file -Algorithm SHA256).Hash
    if ($actual -ine $expected) { throw ('Installed file digest mismatch: '+$relative) }
    return $file
}

$installItem=Get-Item -LiteralPath $Root -ErrorAction Stop
if (-not $installItem.PSIsContainer) { throw 'Root must be an installed directory' }
$installRoot=$installItem.FullName.TrimEnd('\')
if ($installRoot -notmatch '^[A-Za-z]:\\') { throw 'Use an absolute local Windows installation path' }
$disk=Get-CimInstance Win32_LogicalDisk -Filter ("DeviceID='"+$installRoot.Substring(0,2)+"'")
if ($null -eq $disk -or $disk.DriveType -ne 3 -or $disk.FileSystem -ne 'NTFS') {
    throw 'Use a local fixed NTFS installation (no network share)'
}
$ancestor=$installItem
while ($null -ne $ancestor) {
    if (($ancestor.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw ('Reparse-point installation ancestor is not supported: '+$ancestor.FullName)
    }
    $ancestor=$ancestor.Parent
}
$manifestPath=Join-Path $installRoot 'SHA256SUMS.json'
if (-not (Test-Path -LiteralPath $manifestPath -PathType Leaf)) { throw 'Installed manifest is missing' }
if ((Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256).Hash -ine $ExpectedManifestSha256) {
    throw 'Installed manifest does not match the externally approved SHA-256'
}
$manifest=Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
$exe=Assert-ManifestedFile -Manifest $manifest -InstallRoot $installRoot -RelativePath ('bin\'+$Application+'.exe')
$environmentScript=Assert-ManifestedFile -Manifest $manifest -InstallRoot $installRoot -RelativePath 'share\windows\Use-DevelopmentEnvironment.ps1'
$null=Assert-ManifestedFile -Manifest $manifest -InstallRoot $installRoot -RelativePath 'bin\qt.conf'
$descriptionPath=Join-Path $installRoot 'etc\descriptions'
$descriptionCount=0
if (Test-Path -LiteralPath $descriptionPath -PathType Container) {
    $descriptionCount=@(Get-ChildItem -LiteralPath $descriptionPath -Filter '*.xml' -File).Count
}
if ($Application -eq 'scconfig' -and $descriptionCount -eq 0) {
    throw 'scconfig cannot start: no installed module-description XML files found'
}

# Presence of user-level configuration requires deliberate review; these paths
# are indicators, NOT an exhaustive SeisComP configuration-precedence audit.
$homeCandidates=@()
foreach ($home in @($env:USERPROFILE,$env:HOME)) {
    if (-not [string]::IsNullOrWhiteSpace($home)) {
        $homeCandidates += (Join-Path $home '.seiscomp')
    }
}
$userConfigDirs=@($homeCandidates | Select-Object -Unique | Where-Object {
    Test-Path -LiteralPath $_ -PathType Container
})

Write-Output ('PREFLIGHT_PASS: '+$Application)
Write-Output ('  InstallRoot: '+$installRoot)
Write-Output ('  ApprovedManifestSHA256: '+$ExpectedManifestSha256.ToUpperInvariant())
Write-Output ('  VerifiedGUI: '+$exe)
Write-Output ('  VerifiedEnvironmentScript: '+$environmentScript)
Write-Output ('  XMLDescriptionCount: '+$descriptionCount)
Write-Output ('  UserConfigDirsObserved: '+$userConfigDirs.Count)
foreach ($dir in $userConfigDirs) { Write-Output ('    '+$dir) }
Write-Warning 'Preflight checks do not prove network isolation, complete DLL closure, or GUI functionality.'

if (-not $Run) {
    Write-Output 'NOT_RUN: omit -Run for inspection only; no SeisComP application or environment script was executed.'
    return
}
if ([string]::IsNullOrWhiteSpace($AuthorizationReference) -or -not $IsolatedProfileReviewed -or -not $UserConfigurationReviewed) {
    throw 'Launch refused: supply an explicit authorization reference and attest to independent isolation and user-config review.'
}
if (-not $PSCmdlet.ShouldProcess($exe,'Run the selected SeisComP GUI in the already-authorized isolated development session')) {
    Write-Output 'NOT_RUN: launch suppressed by -WhatIf or declined confirmation.'
    return
}

# Use the exact manifest-verified installed helper without modifying the
# frozen candidate. Restore this PowerShell process environment afterward.
$names=@('SEISCOMP_ROOT','SEISCOMP_LOCAL_CONFIG','PATH','QT_PLUGIN_PATH','TEMP','TMP','PYTHONDONTWRITEBYTECODE')
$previous=@{}
foreach ($name in $names) { $previous[$name]=[Environment]::GetEnvironmentVariable($name,'Process') }
try {
    . $environmentScript -Root $installRoot -ExpectedManifestSha256 $ExpectedManifestSha256 | Out-Host
    if ($env:SEISCOMP_ROOT -ine $installRoot) { throw 'Environment initialization selected a different root' }
    Write-Output ('LAUNCHING_APPROVED_GUI: '+$Application)
    # Direct native invocation: no Invoke-Expression, cmd.exe or shell interpolation.
    & $exe @ApplicationArgs
    $nativeExit=$LASTEXITCODE
    Write-Output ('GUI_PROCESS_EXIT: '+$nativeExit)
}
finally {
    foreach ($name in $names) {
        [Environment]::SetEnvironmentVariable($name,$previous[$name],'Process')
    }
}
