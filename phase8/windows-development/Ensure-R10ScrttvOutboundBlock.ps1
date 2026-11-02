<#
Batch 3C-03: narrowly scoped scrttv.exe outbound-block firewall configuration.
Default READ ONLY; -Apply opts into one PersistentStore firewall rule for the
VERIFIED disposable R10 binary, with ShouldProcess confirmation.
No SeisComP app/service or network test is ever launched.
Active rule scope DOES NOT prove traffic-level egress or child isolation.
Use -Apply only where the workstation owner/IT permits this firewall change.
#>
[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='High')]
param(
  [Parameter(Mandatory=$true)][string]$Root,
  [switch]$Apply
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
$expectedManifest='83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74'
$ruleName='SeisComP-R10Test-scrttv.exe-OutboundBlock'
$rootItem=Get-Item -LiteralPath $Root -ErrorAction Stop
if (-not $rootItem.PSIsContainer) {throw 'Root must be a directory'}
$installRoot=$rootItem.FullName.TrimEnd('\')
if ($installRoot -notmatch '^[A-Za-z]:\\' -or
    [IO.Path]::GetFileName($installRoot) -ine 'SeisComP-Scconfig-Test-R10') {
  throw 'Only the named disposable R10 test root is allowed'
}
$ancestor=$rootItem
while ($null -ne $ancestor) {
  if (($ancestor.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw 'Refusing test root with reparse-point ancestry'
  }
  $ancestor=$ancestor.Parent
}
$disk=Get-CimInstance Win32_LogicalDisk -Filter ("DeviceID='"+$installRoot.Substring(0,2)+"'")
if ($null -eq $disk -or $disk.DriveType -ne 3 -or $disk.FileSystem -ne 'NTFS') {
  throw 'Disposable root must be local fixed NTFS'
}
$manifestPath=Join-Path $installRoot 'SHA256SUMS.json'
if ((Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256 -ErrorAction Stop).Hash -ine
    $expectedManifest) {throw 'Unexpected disposable R10 manifest'}
$manifest=Get-Content -LiteralPath $manifestPath -Raw -ErrorAction Stop |
  ConvertFrom-Json -ErrorAction Stop
if (@($manifest.PSObject.Properties).Count -ne 856) {throw 'Unexpected manifest entry count'}
$receipt=Get-Content -LiteralPath ($installRoot+'.install-receipt.json') -Raw -ErrorAction Stop |
  ConvertFrom-Json -ErrorAction Stop
if ([string]$receipt.manifest_sha256 -ine $expectedManifest -or
    [string]$receipt.destination -ine $installRoot -or
    [int]$receipt.verified_files -ne 856) {
  throw 'Disposable installation receipt mismatch'
}
$relative='bin\scrttv.exe'
$entries=@($manifest.PSObject.Properties |
  Where-Object {$_.Name.Replace('/','\') -ieq $relative})
if ($entries.Count -ne 1) {throw 'scrttv binary missing from manifest'}
$exe=[IO.Path]::GetFullPath((Join-Path $installRoot $relative))
if (-not $exe.StartsWith($installRoot+'\', [StringComparison]::OrdinalIgnoreCase)) {
  throw 'scrttv binary path escaped test root'
}
$exeItem=Get-Item -LiteralPath $exe -ErrorAction Stop
if ($exeItem.PSIsContainer -or
    ($exeItem.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
  throw 'Not a regular installed scrttv.exe'
}
if ((Get-FileHash -LiteralPath $exe -Algorithm SHA256 -ErrorAction Stop).Hash -ine
    [string]$entries[0].Value) {
  throw 'Installed scrttv binary does not match manifest'
}
$profiles=@(Get-NetFirewallProfile -PolicyStore ActiveStore -ErrorAction Stop)
if ($profiles.Count -ne 3 -or
    @($profiles | Where-Object {$_.Enabled -ne 'True'}).Count -ne 0) {
  throw 'Active Domain, Private, Public firewall profiles must all be enabled'
}
function Assert-ExactRule($rule,[string]$program) {
  if ($null -eq $rule) {throw 'No rule passed to scope verification'}
  $app=@($rule | Get-NetFirewallApplicationFilter -ErrorAction Stop)
  $port=@($rule | Get-NetFirewallPortFilter -ErrorAction Stop)
  $address=@($rule | Get-NetFirewallAddressFilter -ErrorAction Stop)
  $service=@($rule | Get-NetFirewallServiceFilter -ErrorAction Stop)
  if ($rule.Enabled -ne 'True' -or $rule.Direction -ne 'Outbound' -or
      $rule.Action -ne 'Block' -or [string]$rule.Profile -ne 'Any' -or
      $app.Count -ne 1 -or [string]$app[0].Program -ine $program -or
      $port.Count -ne 1 -or [string]$port[0].Protocol -ne 'Any' -or
      [string]$port[0].LocalPort -ne 'Any' -or
      [string]$port[0].RemotePort -ne 'Any' -or
      $address.Count -ne 1 -or [string]$address[0].LocalAddress -ne 'Any' -or
      [string]$address[0].RemoteAddress -ne 'Any' -or
      $service.Count -ne 1 -or [string]$service[0].Service -ne 'Any') {
    throw 'Named scrttv rule exists but scope is not the required exact block'
  }
}
Write-Output '=== BATCH3C SCRTTV OUTBOUND FIREWALL PREPARATION ==='
Write-Output ('VerifiedScrttvExecutable: '+$exe)
Write-Output ('PinnedManifestSHA256: '+$expectedManifest)
Write-Output 'DISPOSABLE_R10_IDENTITY_PASS; ACTIVE_FIREWALL_PROFILES_ENABLED'
$active=@(Get-NetFirewallRule -PolicyStore ActiveStore -Name $ruleName -ErrorAction SilentlyContinue)
$persistent=@(Get-NetFirewallRule -PolicyStore PersistentStore -Name $ruleName -ErrorAction SilentlyContinue)
if ($active.Count -gt 1 -or $persistent.Count -gt 1) {
  throw 'Multiple same-name rules; stop rather than changing policy'
}
if ($active.Count -eq 1) {
  Assert-ExactRule $active[0] $exe
  if ($persistent.Count -eq 1) {Assert-ExactRule $persistent[0] $exe}
  Write-Output 'SCRTTV_ACTIVE_BLOCK_RULE_SCOPE_MATCH'
  Write-Output 'RULE_ALREADY_PRESENT; NO_FIREWALL_CHANGE'
  Write-Output 'NO_GUI_EXECUTED; EGRESS_EFFECTIVENESS_NOT_TESTED; HELPERS_NOT_COVERED'
  return
}
if ($persistent.Count -gt 0) {
  throw 'Persistent named rule exists but not in ActiveStore; do not overwrite'
}
if (-not $Apply) {
  Write-Output 'SCRTTV_EXACT_PATH_OUTBOUND_BLOCK_RULE_MISSING'
  Write-Output 'PREFLIGHT_ONLY; REQUIRES_APPLY_AND_ADMINISTRATOR_APPROVAL'
  Write-Output 'NO_GUI_EXECUTED; NO_FIREWALL_CHANGE'
  return
}
$principal=[Security.Principal.WindowsPrincipal]::new(
  [Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  throw 'Applying the firewall rule requires elevated PowerShell'
}
if (-not $PSCmdlet.ShouldProcess(
    $exe,'Create ONE outbound block rule scoped to verified disposable scrttv.exe')) {
  Write-Output 'RULE_NOT_CREATED: WhatIf or declined confirmation'
  return
}
$options=@{
  PolicyStore='PersistentStore'
  Name=$ruleName
  DisplayName='SeisComP R10 Test - scrttv Outbound Block'
  Program=$exe
  Direction='Outbound'
  Action='Block'
  Enabled='True'
  Profile='Any'
  Protocol='Any'
  LocalAddress='Any'
  RemoteAddress='Any'
  ErrorAction='Stop'
}
New-NetFirewallRule @options | Out-Null
$after=@(Get-NetFirewallRule -PolicyStore ActiveStore -Name $ruleName -ErrorAction Stop)
if ($after.Count -ne 1) {
  throw 'Rule created but no unique matching ActiveStore rule was observed'
}
Assert-ExactRule $after[0] $exe
Write-Output 'SCRTTV_OUTBOUND_BLOCK_RULE_CREATED_AND_ACTIVE_SCOPE_MATCH'
Write-Output 'NO_GUI_EXECUTED; DEFAULT_FIREWALL_POLICY_UNCHANGED'
Write-Output 'RULE_SCOPE_IS_NOT_EGRESS_EFFECTIVENESS_PROOF_OR_HELPER_CONTAINMENT'
