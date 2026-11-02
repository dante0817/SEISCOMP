<#
Batch 3C: allowlist for remaining ten original Windows GUIs.
DEFAULT PREFLIGHT ONLY: never launches a GUI without -Run.
Only scrttv is eligible for a separately authorized local miniSEED offline run.
All other apps are preflight-only until individual source/risk review.
This is a connected host: Windows application rules do NOT prove isolation.
#>
[CmdletBinding(SupportsShouldProcess=$true)]
param(
  [Parameter(Mandatory=$true)][string]$Root,
  [Parameter(Mandatory=$true)]
  [ValidateSet('scrttv','scolv','scmv','scmvx','scqcv','scshowevent','scesv','scheli','scmm','scmapcut')]
  [string]$Application,
  [string]$ScrttvFixturePath,
  [switch]$Run,
  [string]$AuthorizationReference,
  [switch]$ConnectedHostRiskApproved,
  [switch]$UserConfigurationReviewed,
  [switch]$EgressLimitationsReviewed,
  [switch]$ChildProcessRiskReviewed,
  [string]$EvidenceDirectory
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
$expectedManifest='83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74'
$expectedFixture='995768AC810924BEB6EC4F195A294E966AFD05F2BEEA8428B6688F57586374E6'
$rootItem=Get-Item -LiteralPath $Root -ErrorAction Stop
if (-not $rootItem.PSIsContainer) { throw 'Root must be a test directory' }
$installRoot=$rootItem.FullName.TrimEnd('\')
if ($installRoot -notmatch '^[A-Za-z]:\\' -or
    [IO.Path]::GetFileName($installRoot) -ine 'SeisComP-Scconfig-Test-R10') {
  throw 'Only disposable local R10 test root may be inspected'
}
$ancestor=$rootItem
while ($null -ne $ancestor) {
  if (($ancestor.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw 'Reparse-point install root or ancestor refused'
  }
  $ancestor=$ancestor.Parent
}
$disk=Get-CimInstance Win32_LogicalDisk -Filter ("DeviceID='"+$installRoot.Substring(0,2)+"'")
if ($null -eq $disk -or $disk.DriveType -ne 3 -or $disk.FileSystem -ne 'NTFS') {
  throw 'Root requires local fixed NTFS'
}
$manifestPath=Join-Path $installRoot 'SHA256SUMS.json'
if ((Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256 -ErrorAction Stop).Hash -ine $expectedManifest) {
  throw 'Unrecognized R10 manifest'
}
$manifest=Get-Content -LiteralPath $manifestPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
if (@($manifest.PSObject.Properties).Count -ne 856) { throw 'Unexpected manifest entry count' }
$receipt=Get-Content -LiteralPath ($installRoot+'.install-receipt.json') -Raw -ErrorAction Stop |
  ConvertFrom-Json -ErrorAction Stop
if ([string]$receipt.manifest_sha256 -ine $expectedManifest -or
    [string]$receipt.destination -ine $installRoot -or [int]$receipt.verified_files -ne 856) {
  throw 'Disposable receipt mismatch'
}
function Assert-Pinned([string]$relative) {
  $entries=@($manifest.PSObject.Properties | Where-Object {$_.Name.Replace('/','\') -ieq $relative})
  if ($entries.Count -ne 1) { throw ('Manifest entry missing: '+$relative) }
  $file=[IO.Path]::GetFullPath((Join-Path $installRoot $relative))
  if (-not $file.StartsWith($installRoot+'\', [StringComparison]::OrdinalIgnoreCase)) {
    throw 'Manifest path outside test root'
  }
  $info=Get-Item -LiteralPath $file -ErrorAction Stop
  if ($info.PSIsContainer -or ($info.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw ('Invalid installed file: '+$relative)
  }
  if ((Get-FileHash -LiteralPath $file -Algorithm SHA256 -ErrorAction Stop).Hash -ine
      [string]$entries[0].Value) { throw ('Installed file differs: '+$relative) }
  return $file
}
$exe=Assert-Pinned ('bin\'+$Application+'.exe')
$null=Assert-Pinned 'bin\qt.conf'
$null=Assert-Pinned 'bin\qt-plugins\platforms\qwindows.dll'
$helper=Assert-Pinned 'share\windows\Use-DevelopmentEnvironment.ps1'
$descPath=Join-Path $installRoot 'etc\descriptions'
if (-not (Test-Path -LiteralPath $descPath -PathType Container)) {
  throw 'Description directory missing'
}
$xmlCount=@(Get-ChildItem -LiteralPath $descPath -Filter '*.xml' -File -ErrorAction Stop).Count
$fixture=$null
if (-not [string]::IsNullOrWhiteSpace($ScrttvFixturePath)) {
  if ($Application -ne 'scrttv') { throw 'miniSEED fixture only supported for scrttv' }
  $fixture=Get-Item -LiteralPath $ScrttvFixturePath -ErrorAction Stop
  if ($fixture.PSIsContainer -or
      ($fixture.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw 'Expected regular miniSEED file'
  }
  if ($fixture.Length -ne 4096 -or
      (Get-FileHash -LiteralPath $fixture.FullName -Algorithm SHA256 -ErrorAction Stop).Hash -ine
      $expectedFixture) {
    throw 'Offline miniSEED fixture size or hash mismatch'
  }
}
Write-Output '=== BATCH3C NATIVE GUI PREFLIGHT ==='
Write-Output ('Application: '+$Application)
Write-Output ('Manifest: '+$expectedManifest)
Write-Output 'DisposableReceiptAndQtRuntimeHashes: VERIFIED'
Write-Output ('DescriptionXMLCount: '+$xmlCount)
if ($null -ne $fixture) {
  Write-Output 'ScrttvLocalMiniSEEDFixture: SHA256_AND_SIZE_PASS'
}
else {
  Write-Output 'ScrttvLocalMiniSEEDFixture: NOT_CHECKED'
}
if (-not $Run) {
  Write-Output 'BATCH3C_GUI_ENTRYPOINT_PREFLIGHT_PASS'
  Write-Output 'GUI_NOT_RUN; NO_FIREWALL_CHANGE; NO_NETWORK_PROBE'
  return
}
if ($Application -ne 'scrttv') { throw 'RUNTIME_DISABLED_FOR_THIS_GUI: requires separate source and risk review' }
if ($null -eq $fixture) { throw 'scrttv runtime requires verified local offline miniSEED fixture' }
if ([string]::IsNullOrWhiteSpace($AuthorizationReference) -or
    $AuthorizationReference -notmatch '(?i)scrttv' -or
    -not $ConnectedHostRiskApproved -or
    -not $UserConfigurationReviewed -or
    -not $EgressLimitationsReviewed -or
    -not $ChildProcessRiskReviewed) {
  throw 'New scrttv-specific authorization and connected-host reviews required'
}
$principal=[Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  throw 'GUI launch requires non-administrator PowerShell'
}
foreach ($userHomeCandidate in @($env:USERPROFILE,$env:HOME)) {
  if (-not [string]::IsNullOrWhiteSpace($userHomeCandidate) -and
      (Test-Path -LiteralPath (Join-Path $userHomeCandidate '.seiscomp') -PathType Container)) {
    throw 'Existing user-home SeisComP config requires separate review'
  }
}
foreach ($varName in @('SEISCOMP_ROOT','SEISCOMP_LOCAL_CONFIG','QT_PLUGIN_PATH',
                       'QT_QPA_PLATFORM_PLUGIN_PATH','QT_QPA_PLATFORM')) {
  if (-not [string]::IsNullOrWhiteSpace([Environment]::GetEnvironmentVariable($varName,'Process'))) {
    throw ('Inherited process variable: '+$varName)
  }
}
if (@(Get-Process -Name scrttv -ErrorAction SilentlyContinue).Count -gt 0) {
  throw 'Existing scrttv process found'
}
$profiles=@(Get-NetFirewallProfile -PolicyStore ActiveStore -ErrorAction Stop)
if ($profiles.Count -ne 3 -or @($profiles | Where-Object {$_.Enabled -ne 'True'}).Count -gt 0) {
  throw 'Active firewall profiles not all enabled'
}
$ruleName='SeisComP-R10Test-scrttv.exe-OutboundBlock'
$rules=@(Get-NetFirewallRule -Name $ruleName -PolicyStore ActiveStore -ErrorAction SilentlyContinue)
if ($rules.Count -ne 1) { throw 'SCRTTV_ACTIVE_OUTBOUND_BLOCK_RULE_MISSING' }
$rule=$rules[0]
$appFilters=@($rule | Get-NetFirewallApplicationFilter -ErrorAction Stop)
$portFilters=@($rule | Get-NetFirewallPortFilter -ErrorAction Stop)
$addrFilters=@($rule | Get-NetFirewallAddressFilter -ErrorAction Stop)
$svcFilters=@($rule | Get-NetFirewallServiceFilter -ErrorAction Stop)
if ($rule.Action -ne 'Block' -or $rule.Direction -ne 'Outbound' -or
    $rule.Enabled -ne 'True' -or [string]$rule.Profile -ne 'Any' -or
    $appFilters.Count -ne 1 -or [string]$appFilters[0].Program -ine $exe -or
    $portFilters.Count -ne 1 -or [string]$portFilters[0].Protocol -ne 'Any' -or
    [string]$portFilters[0].LocalPort -ne 'Any' -or [string]$portFilters[0].RemotePort -ne 'Any' -or
    $addrFilters.Count -ne 1 -or [string]$addrFilters[0].LocalAddress -ne 'Any' -or
    [string]$addrFilters[0].RemoteAddress -ne 'Any' -or
    $svcFilters.Count -ne 1 -or [string]$svcFilters[0].Service -ne 'Any') {
  throw 'SCRTTV_ACTIVE_OUTBOUND_BLOCK_RULE_SCOPE_FAILED'
}
Write-Output 'SCRTTV_ACTIVE_BLOCK_RULE_SCOPE_PASS'
Write-Output 'REAL_NETWORK_EGRESS_NOT_TESTED; HELPER_PROCESSES_NOT_CONTAINED; NOT_ISOLATED'
if ([string]::IsNullOrWhiteSpace($EvidenceDirectory)) { throw 'External existing evidence directory required' }
$evidence=Get-Item -LiteralPath $EvidenceDirectory -ErrorAction Stop
if (-not $evidence.PSIsContainer -or
    ($evidence.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
  throw 'Evidence directory is invalid or a reparse point'
}
$evidenceRoot=$evidence.FullName.TrimEnd('\')
if ($evidenceRoot.StartsWith($installRoot+'\', [StringComparison]::OrdinalIgnoreCase)) {
  throw 'Evidence directory cannot be within the test installation'
}
$timestamp=[DateTime]::UtcNow.ToString('yyyyMMdd-HHmmss')
$stdout=Join-Path $evidenceRoot ('scrttv-'+$timestamp+'.stdout.txt')
$stderr=Join-Path $evidenceRoot ('scrttv-'+$timestamp+'.qt-stderr.txt')
if ((Test-Path -LiteralPath $stdout) -or (Test-Path -LiteralPath $stderr)) {
  throw 'Evidence filename already exists'
}
if (-not $PSCmdlet.ShouldProcess($exe,'Run separately authorized offline local-miniSEED scrttv GUI smoke test')) {
  Write-Output 'GUI_NOT_RUN: WhatIf or confirmation declined'
  return
}
$vars=@('SEISCOMP_ROOT','SEISCOMP_LOCAL_CONFIG','PATH','QT_PLUGIN_PATH',
        'QT_QPA_PLATFORM','QT_QPA_PLATFORM_PLUGIN_PATH','QT_DEBUG_PLUGINS',
        'TEMP','TMP','PYTHONDONTWRITEBYTECODE')
$previous=@{}
foreach ($varName in $vars) {
  $previous[$varName]=[Environment]::GetEnvironmentVariable($varName,'Process')
}
try {
  . $helper -Root $installRoot -ExpectedManifestSha256 $expectedManifest | Out-Host
  if ($env:SEISCOMP_ROOT -ine $installRoot) { throw 'Wrong environment root' }
  $env:QT_QPA_PLATFORM='windows'
  $env:QT_DEBUG_PLUGINS='1'
  if ($fixture.FullName.Contains('"')) { throw 'Unsupported filename quote' }
  $argsList=@('--offline','--no-inventory',('"'+$fixture.FullName+'"'))
  Write-Output 'GUI_LAUNCH_REQUESTED: scrttv.exe --offline --no-inventory <pinned miniSEED>'
  Write-Output 'DO_NOT_ENABLE_ACQUISITION_OR_START_SERVICES'
  $proc=Start-Process -FilePath $exe -ArgumentList $argsList -WorkingDirectory $installRoot -PassThru -Wait -RedirectStandardOutput $stdout -RedirectStandardError $stderr -ErrorAction Stop
  Write-Output ('SCRTTV_PROCESS_EXIT: '+$proc.ExitCode)
  Write-Output ('STDOUT_EVIDENCE: '+$stdout)
  Write-Output ('QT_STDERR_EVIDENCE: '+$stderr)
  Write-Output 'GUI_FUNCTIONAL_AND_SCIENTIFIC_PASS_NOT_AUTOMATIC'
}
finally {
  foreach ($varName in $vars) {
    [Environment]::SetEnvironmentVariable($varName,$previous[$varName],'Process')
  }
}
