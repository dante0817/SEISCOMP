<#
Batch 3C-02. READ ONLY. Verify historical offline miniSEED fixture candidates,
current disposable R10 scrttv binary, and exact-path ActiveStore firewall scope.
This is not a firewall effectiveness test and does not launch any process.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$Root,
  [Parameter(Mandatory=$true)][string]$WorkspaceRoot
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
$manifestSha='83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74'
$fixtureSha='995768AC810924BEB6EC4F195A294E966AFD05F2BEEA8428B6688F57586374E6'
$ruleName='SeisComP-R10Test-scrttv.exe-OutboundBlock'
$rootItem=Get-Item -LiteralPath $Root -ErrorAction Stop
if (-not $rootItem.PSIsContainer) {throw 'R10 test root must be a directory'}
$installRoot=$rootItem.FullName.TrimEnd('\')
if ($installRoot -notmatch '^[A-Za-z]:\\' -or
    [IO.Path]::GetFileName($installRoot) -ine 'SeisComP-Scconfig-Test-R10') {
  throw 'Only the disposable native Windows R10 test installation is eligible'
}
$ancestor=$rootItem
while ($null -ne $ancestor) {
  if (($ancestor.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw 'Reparse-point test root or ancestor refused'
  }
  $ancestor=$ancestor.Parent
}
$disk=Get-CimInstance Win32_LogicalDisk -Filter ("DeviceID='"+$installRoot.Substring(0,2)+"'")
if ($null -eq $disk -or $disk.DriveType -ne 3 -or $disk.FileSystem -ne 'NTFS') {
  throw 'R10 test root must be on fixed local NTFS'
}
$workspace=Get-Item -LiteralPath $WorkspaceRoot -ErrorAction Stop
if (-not $workspace.PSIsContainer) {throw 'WorkspaceRoot must be a directory'}
$workspacePath=$workspace.FullName.TrimEnd('\')
$manifestPath=Join-Path $installRoot 'SHA256SUMS.json'
if ((Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256 -ErrorAction Stop).Hash -ine $manifestSha) {
  throw 'Unexpected R10 manifest SHA-256'
}
$manifest=Get-Content -LiteralPath $manifestPath -Raw -ErrorAction Stop |
  ConvertFrom-Json -ErrorAction Stop
if (@($manifest.PSObject.Properties).Count -ne 856) {throw 'Unexpected R10 manifest entry count'}
$receipt=Get-Content -LiteralPath ($installRoot+'.install-receipt.json') -Raw -ErrorAction Stop |
  ConvertFrom-Json -ErrorAction Stop
if ([string]$receipt.manifest_sha256 -ine $manifestSha -or
    [string]$receipt.destination -ine $installRoot -or
    [int]$receipt.verified_files -ne 856) {throw 'Disposable R10 receipt mismatch'}
function Assert-InstalledFile([string]$relative) {
  $entries=@($manifest.PSObject.Properties |
    Where-Object {$_.Name.Replace('/','\') -ieq $relative})
  if ($entries.Count -ne 1) {throw ('Missing manifest file: '+$relative)}
  $path=[IO.Path]::GetFullPath((Join-Path $installRoot $relative))
  if (-not $path.StartsWith($installRoot+'\', [StringComparison]::OrdinalIgnoreCase)) {
    throw 'Manifest file escapes test root'
  }
  $info=Get-Item -LiteralPath $path -ErrorAction Stop
  if ($info.PSIsContainer -or
      ($info.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw ('Invalid installed file: '+$relative)
  }
  if ((Get-FileHash -LiteralPath $path -Algorithm SHA256 -ErrorAction Stop).Hash -ine
      [string]$entries[0].Value) {throw ('File hash mismatch: '+$relative)}
  return $path
}
$exe=Assert-InstalledFile 'bin\scrttv.exe'
$null=Assert-InstalledFile 'bin\qt.conf'
$null=Assert-InstalledFile 'bin\qt-plugins\platforms\qwindows.dll'

$relatives=@(
  'phase8\data\phase5c1\phase5c1a\NC_NGVB_20s.mseed',
  'data\phase5c1\phase5c1a\NC_NGVB_20s.mseed',
  'phase8\staging\scrttv-offline\NC_NGVB_20s.mseed',
  'phase8\staging\scrttv-offline\data\NC_NGVB_20s.mseed',
  'phase8\staging\scrttv-offline\fixtures\NC_NGVB_20s.mseed',
  'phase8\staging\scrttv-offline\data\phase5c1\phase5c1a\NC_NGVB_20s.mseed'
)
$verifiedFixture=$null
$fixtureCandidates=0
foreach ($relative in $relatives) {
  $path=Join-Path $workspacePath $relative
  if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {continue}
  $fixtureCandidates++
  $info=Get-Item -LiteralPath $path -ErrorAction Stop
  if (($info.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {continue}
  if ($info.Length -ne 4096) {continue}
  if ((Get-FileHash -LiteralPath $path -Algorithm SHA256 -ErrorAction Stop).Hash -ine
      $fixtureSha) {continue}
  $verifiedFixture=$info.FullName
  break
}
Write-Output '=== BATCH3C SCRTTV OFFLINE BOUNDARY INSPECTION ==='
Write-Output ('CurrentScrttvExe: '+$exe)
Write-Output ('R10ManifestSHA256: '+$manifestSha)
Write-Output 'DisposableReceiptAndSelectedQtHashes: VERIFIED'
Write-Output ('FixtureCandidatesFound: '+$fixtureCandidates)
if ($null -ne $verifiedFixture) {
  Write-Output 'SCRTTV_MINISEED_FIXTURE_SHA256_PASS'
  Write-Output ('VerifiedFixturePath: '+$verifiedFixture)
}
else {
  Write-Output 'SCRTTV_MINISEED_FIXTURE_NOT_VERIFIED'
  Write-Output 'Check additional historical local fixture locations; do not substitute arbitrary waveform data'
}
$profileStates=@(Get-NetFirewallProfile -PolicyStore ActiveStore -ErrorAction Stop)
if ($profileStates.Count -ne 3 -or
    @($profileStates | Where-Object {$_.Enabled -ne 'True'}).Count -ne 0) {
  Write-Output 'FIREWALL_PROFILES_NOT_ALL_ENABLED'
}
else {
  Write-Output 'ACTIVE_FIREWALL_PROFILES_ENABLED'
}
$rules=@(Get-NetFirewallRule -PolicyStore ActiveStore -Name $ruleName -ErrorAction SilentlyContinue)
if ($rules.Count -eq 0) {
  Write-Output 'SCRTTV_EXACT_PATH_OUTBOUND_BLOCK_RULE_MISSING'
}
elseif ($rules.Count -ne 1) {
  Write-Output 'SCRTTV_EXACT_PATH_OUTBOUND_BLOCK_RULE_AMBIGUOUS'
}
else {
  $rule=$rules[0]
  $apps=@($rule | Get-NetFirewallApplicationFilter -ErrorAction Stop)
  $ports=@($rule | Get-NetFirewallPortFilter -ErrorAction Stop)
  $addrs=@($rule | Get-NetFirewallAddressFilter -ErrorAction Stop)
  $services=@($rule | Get-NetFirewallServiceFilter -ErrorAction Stop)
  if ($rule.Enabled -eq 'True' -and $rule.Direction -eq 'Outbound' -and
      $rule.Action -eq 'Block' -and [string]$rule.Profile -eq 'Any' -and
      $apps.Count -eq 1 -and [string]$apps[0].Program -ieq $exe -and
      $ports.Count -eq 1 -and [string]$ports[0].Protocol -eq 'Any' -and
      [string]$ports[0].LocalPort -eq 'Any' -and
      [string]$ports[0].RemotePort -eq 'Any' -and
      $addrs.Count -eq 1 -and [string]$addrs[0].LocalAddress -eq 'Any' -and
      [string]$addrs[0].RemoteAddress -eq 'Any' -and
      $services.Count -eq 1 -and [string]$services[0].Service -eq 'Any') {
    Write-Output 'SCRTTV_ACTIVE_BLOCK_RULE_SCOPE_MATCH'
  }
  else {
    Write-Output 'SCRTTV_ACTIVE_BLOCK_RULE_SCOPE_MISMATCH'
  }
}
Write-Output 'READ_ONLY_INSPECTION_COMPLETE; GUI_NOT_RUN; FIREWALL_NOT_CHANGED'
Write-Output 'ACTIVE_RULE_SCOPE_DOES_NOT_PROVE_TRAFFIC_EGRESS_BLOCKING_OR_HELPER_ISOLATION'
