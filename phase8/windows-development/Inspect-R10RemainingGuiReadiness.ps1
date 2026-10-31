<#
Batch 3C-01 - READ ONLY inventory for the ten original native Windows GUIs
remaining after the completed scconfig smoke test. No GUI, network probe,
firewall change, setup helper or service is executed.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$Root,
  [string]$ScrttvFixturePath
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
$expectedManifest='83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74'
$expectedFixture='995768AC810924BEB6EC4F195A294E966AFD05F2BEEA8428B6688F57586374E6'
$appNames=@('scrttv','scolv','scmv','scmvx','scqcv','scshowevent',
            'scesv','scheli','scmm','scmapcut')

$rootItem=Get-Item -LiteralPath $Root -ErrorAction Stop
if (-not $rootItem.PSIsContainer) { throw 'Root must be a directory' }
$installRoot=$rootItem.FullName.TrimEnd('\')
if ($installRoot -notmatch '^[A-Za-z]:\\' -or
    [IO.Path]::GetFileName($installRoot) -ine 'SeisComP-Scconfig-Test-R10') {
  throw 'Inspect only the disposable local SeisComP-Scconfig-Test-R10 copy'
}
$ancestor=$rootItem
while ($null -ne $ancestor) {
  if (($ancestor.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw ('Reparse-point path refused: '+$ancestor.FullName)
  }
  $ancestor=$ancestor.Parent
}
$disk=Get-CimInstance Win32_LogicalDisk -Filter ("DeviceID='"+$installRoot.Substring(0,2)+"'")
if ($null -eq $disk -or $disk.DriveType -ne 3 -or $disk.FileSystem -ne 'NTFS') {
  throw 'Disposable root must be local fixed NTFS'
}
$manifestPath=Join-Path $installRoot 'SHA256SUMS.json'
if ((Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256 -ErrorAction Stop).Hash -ine
    $expectedManifest) { throw 'Unexpected R10 manifest identity' }
$manifest=Get-Content -LiteralPath $manifestPath -Raw -ErrorAction Stop |
  ConvertFrom-Json -ErrorAction Stop
if (@($manifest.PSObject.Properties).Count -ne 856) { throw 'Unexpected manifest entry count' }
$receipt=Get-Content -LiteralPath ($installRoot+'.install-receipt.json') -Raw -ErrorAction Stop |
  ConvertFrom-Json -ErrorAction Stop
if ([string]$receipt.manifest_sha256 -ine $expectedManifest -or
    [string]$receipt.destination -ine $installRoot -or
    [int]$receipt.verified_files -ne 856) {
  throw 'Unverified disposable installation receipt'
}
function Assert-ManifestFile([string]$relative) {
  $entries=@($manifest.PSObject.Properties |
    Where-Object { $_.Name.Replace('/','\') -ieq $relative })
  if ($entries.Count -ne 1) { throw ('Missing manifest entry: '+$relative) }
  $path=[IO.Path]::GetFullPath((Join-Path $installRoot $relative))
  if (-not $path.StartsWith($installRoot+'\', [StringComparison]::OrdinalIgnoreCase)) {
    throw 'Manifest path escapes disposable root'
  }
  $item=Get-Item -LiteralPath $path -ErrorAction Stop
  if ($item.PSIsContainer -or
      ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw ('Invalid installed file: '+$relative)
  }
  if ((Get-FileHash -LiteralPath $path -Algorithm SHA256 -ErrorAction Stop).Hash -ine
      [string]$entries[0].Value) {
    throw ('Installed file changed: '+$relative)
  }
  return $path
}
$null=Assert-ManifestFile 'bin\qt.conf'
$null=Assert-ManifestFile 'bin\qt-plugins\platforms\qwindows.dll'
$null=Assert-ManifestFile 'share\windows\Use-DevelopmentEnvironment.ps1'
$rows=@()
foreach ($app in $appNames) {
  $relative='bin\'+$app+'.exe'
  $exe=Assert-ManifestFile $relative
  $ruleName='SeisComP-R10Test-'+$app+'.exe-OutboundBlock'
  $matches=@(Get-NetFirewallRule -PolicyStore ActiveStore -Name $ruleName -ErrorAction SilentlyContinue)
  $firewallStatus='NOT_VERIFIED'
  if ($matches.Count -eq 1) {
    $rule=$matches[0]
    $filters=@($rule | Get-NetFirewallApplicationFilter -ErrorAction Stop)
    if ($filters.Count -eq 1 -and [string]$filters[0].Program -ieq $exe -and
        $rule.Direction -eq 'Outbound' -and $rule.Action -eq 'Block' -and
        $rule.Enabled -eq 'True') {
      $firewallStatus='RULE_OBSERVED_ONLY'
    }
  }
  $rows+= [pscustomobject]@{
    Application=$app
    Binary='MANIFEST_SHA256_PASS'
    EgressRule=$firewallStatus
    Runtime='NOT_RUN_IN_BATCH3C'
  }
}
Write-Output '=== BATCH 3C ORIGINAL WINDOWS GUI READINESS ==='
$rows | Format-Table -AutoSize | Out-Host
Write-Output ('ManifestSHA256: '+$expectedManifest)
Write-Output ('ManifestedRemainingGuiBinaries: '+$rows.Count+'/10')
if (-not [string]::IsNullOrWhiteSpace($ScrttvFixturePath)) {
  $fixture=Get-Item -LiteralPath $ScrttvFixturePath -ErrorAction Stop
  if ($fixture.PSIsContainer -or
      ($fixture.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw 'Offline fixture is not a regular file'
  }
  if ($fixture.Length -ne 4096) { throw 'scrttv offline miniSEED fixture size differs' }
  if ((Get-FileHash -LiteralPath $fixture.FullName -Algorithm SHA256 -ErrorAction Stop).Hash -ine
      $expectedFixture) { throw 'scrttv fixture SHA-256 mismatch' }
  Write-Output 'ScrttvOfflineMiniSEEDFixture: SHA256_AND_SIZE_PASS'
}
else {
  Write-Output 'ScrttvOfflineMiniSEEDFixture: NOT_REQUESTED'
}
Write-Output 'BATCH3C_10_GUI_ENTRYPOINT_READINESS_PASS'
Write-Output 'NO_GUI_EXECUTED; NO_FIREWALL_CHANGE; NO_NETWORK_PROBE'
Write-Output 'FIREWALL_RULE_OBSERVATION_IS_NOT_EGRESS_EFFECTIVENESS'
