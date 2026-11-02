<#
Batch 3B R10 connected-host scconfig launcher. Source-only implementation.
Default is fail-closed preflight, not a GUI launch. Network stays connected.
An explicit authorized -Run still does NOT prove full network isolation.
Do not run from the immutable R10 or a privileged PowerShell account.
#>
[CmdletBinding(SupportsShouldProcess=$true)]
param(
  [Parameter(Mandatory=$true)][string]$Root,
  [ValidatePattern('^[A-Fa-f0-9]{64}$')]
  [string]$ExpectedManifestSha256='83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74',
  [switch]$Run,
  [string]$AuthorizationReference,
  [switch]$ConnectedHostRiskApproved,
  [switch]$UserConfigurationReviewed,
  [switch]$EgressEffectivenessReviewed,
  [string]$EvidenceDirectory
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
$item=Get-Item -LiteralPath $Root -ErrorAction Stop
if (-not $item.PSIsContainer) {throw 'Root must be a disposable test directory'}
$rootPath=$item.FullName.TrimEnd('\')
if ($rootPath -notmatch '^[A-Za-z]:\\' -or
    [IO.Path]::GetFileName($rootPath) -ine 'SeisComP-Scconfig-Test-R10') {
  throw 'Only an absolute, named disposable R10 test root may be used'
}
$ancestor=$item
while ($null -ne $ancestor) {
  if (($ancestor.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw 'Reparse point in test-root ancestry'
  }
  $ancestor=$ancestor.Parent
}
$disk=Get-CimInstance Win32_LogicalDisk -Filter ("DeviceID='"+$rootPath.Substring(0,2)+"'")
if ($null -eq $disk -or $disk.DriveType -ne 3 -or $disk.FileSystem -ne 'NTFS') {
  throw 'Root must be on fixed local NTFS'
}
$manifestPath=Join-Path $rootPath 'SHA256SUMS.json'
$actual=(Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256 -ErrorAction Stop).Hash
if ($actual -ine $ExpectedManifestSha256) {throw 'Test manifest identity mismatch'}
$manifest=Get-Content -LiteralPath $manifestPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
if (@($manifest.PSObject.Properties).Count -ne 856) {throw 'Unexpected R10 file count'}
$receipt=Get-Content -LiteralPath ($rootPath+'.install-receipt.json') -Raw -ErrorAction Stop |
  ConvertFrom-Json -ErrorAction Stop
if ([string]$receipt.manifest_sha256 -ine $ExpectedManifestSha256 -or
    [string]$receipt.destination -ine $rootPath -or [int]$receipt.verified_files -ne 856) {
  throw 'Test-copy receipt mismatch'
}
function Assert-Pinned([string]$rel) {
  $entries=@($manifest.PSObject.Properties | Where-Object {$_.Name.Replace('/','\') -ieq $rel})
  if ($entries.Count -ne 1) {throw ('Missing or ambiguous manifest entry: '+$rel)}
  $file=[IO.Path]::GetFullPath((Join-Path $rootPath $rel))
  if (-not $file.StartsWith($rootPath+'\', [StringComparison]::OrdinalIgnoreCase)) {throw 'Escaping root'}
  if (-not (Test-Path -LiteralPath $file -PathType Leaf)) {throw ('Missing: '+$rel)}
  if (((Get-Item -LiteralPath $file).Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw ('Reparse point: '+$rel)
  }
  if ((Get-FileHash -LiteralPath $file -Algorithm SHA256 -ErrorAction Stop).Hash -ine
      [string]$entries[0].Value) {throw ('Changed: '+$rel)}
  return $file
}
$exe=Assert-Pinned 'bin\scconfig.exe'
$null=Assert-Pinned 'bin\seiscomp.exe'
$null=Assert-Pinned 'bin\qt.conf'
$null=Assert-Pinned 'bin\qt-plugins\platforms\qwindows.dll'
$helper=Assert-Pinned 'share\windows\Use-DevelopmentEnvironment.ps1'
$desc=Join-Path $rootPath 'etc\descriptions'
if (-not (Test-Path -LiteralPath $desc -PathType Container)) {throw 'No XML directory'}
$xmlCount=@(Get-ChildItem -LiteralPath $desc -Filter '*.xml' -File -ErrorAction Stop).Count
if ($xmlCount -le 0) {throw 'No XML module descriptions'}
$check=Join-Path $PSScriptRoot 'Confirm-R10ScconfigFirewallRules.ps1'
$checkHash='96DAF89864C55CE3973FED6B3F4F35F6DD9D7022F5EFCA716041CDC56BF61561'
if ((Get-FileHash -LiteralPath $check -Algorithm SHA256 -ErrorAction Stop).Hash -ine $checkHash) {
  throw 'Firewall admission helper absent or changed'
}
& $check -Root $rootPath
Write-Output '=== BATCH 3B CONNECTED HOST SCCONFIG PREFLIGHT ==='
Write-Output ('Manifest: '+$actual)
Write-Output ('DescriptionXMLCount: '+$xmlCount)
Write-Output 'DisposableReceiptAndRuntimeFiles: VERIFIED'
Write-Output 'FirewallPolicyScope: ACTIVE_STORE_RULES_MATCH'
Write-Output 'NotFullyIsolated: True'
if (-not $Run) {
  Write-Output 'BATCH3B_CONNECTED_HOST_PREFLIGHT_PASS'
  Write-Output 'GUI_NOT_RUN; HELPER_NOT_EXECUTED; FIREWALL_NOT_MODIFIED'
  return
}
if ([string]::IsNullOrWhiteSpace($AuthorizationReference) -or
    -not $ConnectedHostRiskApproved -or
    -not $UserConfigurationReviewed -or -not $EgressEffectivenessReviewed) {
  throw 'Separate documented authorization, user config and egress reviews required'
}
$principal=[Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  throw 'Interactive GUI test must run non-elevated'
}
foreach ($userHomeCandidate in @($env:USERPROFILE,$env:HOME)) {
  if (-not [string]::IsNullOrWhiteSpace($userHomeCandidate) -and
      (Test-Path -LiteralPath (Join-Path $userHomeCandidate '.seiscomp') -PathType Container)) {
    throw 'Inherited user-home SeisComP profile needs independent review'
  }
}
foreach ($name in @('SEISCOMP_ROOT','SEISCOMP_LOCAL_CONFIG','QT_PLUGIN_PATH',
                    'QT_QPA_PLATFORM_PLUGIN_PATH','QT_QPA_PLATFORM')) {
  if (-not [string]::IsNullOrWhiteSpace([Environment]::GetEnvironmentVariable($name,'Process'))) {
    throw ('Inherited environment override: '+$name)
  }
}
if ([string]::IsNullOrWhiteSpace($EvidenceDirectory)) {throw 'EvidenceDirectory is required for a run'}
$evidence=Get-Item -LiteralPath $EvidenceDirectory -ErrorAction Stop
if (-not $evidence.PSIsContainer -or
    ($evidence.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
  throw 'EvidenceDirectory is missing or unsafe'
}
$evidencePath=$evidence.FullName.TrimEnd('\')
if ($evidencePath.StartsWith($rootPath+'\', [StringComparison]::OrdinalIgnoreCase)) {
  throw 'EvidenceDirectory cannot be under the tested installation'
}
$time=[DateTime]::UtcNow.ToString('yyyyMMdd-HHmmss')
$out=Join-Path $evidencePath ('scconfig-'+$time+'.stdout.txt')
$err=Join-Path $evidencePath ('scconfig-'+$time+'.qt-stderr.txt')
if ((Test-Path -LiteralPath $out) -or (Test-Path -LiteralPath $err)) {
  throw 'Evidence output already exists'
}
if (-not $PSCmdlet.ShouldProcess($exe,'Start original scconfig only in separately authorized connected-host test')) {
  Write-Output 'GUI_NOT_RUN: WhatIf or declined confirmation'
  return
}
$vars=@('SEISCOMP_ROOT','SEISCOMP_LOCAL_CONFIG','PATH','QT_PLUGIN_PATH',
        'QT_QPA_PLATFORM','QT_QPA_PLATFORM_PLUGIN_PATH','QT_DEBUG_PLUGINS',
        'TEMP','TMP','PYTHONDONTWRITEBYTECODE')
$prev=@{}
foreach ($name in $vars) {$prev[$name]=[Environment]::GetEnvironmentVariable($name,'Process')}
try {
  . $helper -Root $rootPath -ExpectedManifestSha256 $ExpectedManifestSha256 | Out-Host
  if ($env:SEISCOMP_ROOT -ine $rootPath) {throw 'Helper chose wrong root'}
  $env:QT_QPA_PLATFORM='windows'
  $env:QT_DEBUG_PLUGINS='1'
  Write-Output 'GUI_LAUNCH_REQUESTED: scconfig.exe'
  Write-Output 'If prompted for first start, select No; do not invoke any module/setup action'
  $proc=Start-Process -FilePath $exe -WorkingDirectory $rootPath -PassThru -Wait -RedirectStandardOutput $out -RedirectStandardError $err -ErrorAction Stop
  Write-Output ('GUI_PROCESS_EXIT: '+$proc.ExitCode)
  Write-Output ('STDOUT_EVIDENCE: '+$out)
  Write-Output ('QT_STDERR_EVIDENCE: '+$err)
  Write-Output ('FIRST_START_MARKER_PRESENT: '+(Test-Path -LiteralPath (Join-Path $rootPath 'var\run\seiscomp.init') -PathType Leaf))
  Write-Output 'GUI_FUNCTIONAL_PASS_NOT_AUTOMATIC; MANUAL_OBSERVATION_REQUIRED'
}
finally {
  foreach ($name in $vars) {
    [Environment]::SetEnvironmentVariable($name,$prev[$name],'Process')
  }
}
