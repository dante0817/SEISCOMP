<#
Batch 3D-05: fail-closed original native Windows scolv offline GUI smoke.
DEFAULT READ-ONLY: only -Run enables local fixture staging and a GUI launch.
Separate specific operator authorization is required. The host remains connected:
exact program rule scope does NOT prove actual egress blocking or helper isolation.
The three pinned XML inputs were operator-inspected but are not science-qualified.
#>
[CmdletBinding(SupportsShouldProcess=$true)]
param(
  [Parameter(Mandatory=$true)][string]$Root,
  [Parameter(Mandatory=$true)][string]$WorkspaceRoot,
  [switch]$Run,
  [string]$AuthorizationReference,
  [switch]$ConnectedHostRiskApproved,
  [switch]$UserConfigurationReviewed,
  [switch]$EgressLimitationsReviewed,
  [switch]$ChildProcessRiskReviewed,
  [switch]$OfflineDatabaseBehaviorReviewed,
  [string]$EvidenceDirectory
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
$expectedManifest='83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74'
$ruleName='SeisComP-R10Test-scolv.exe-OutboundBlock'
$inputs=@(
  @{Name='inventory';Relative='data\phase5b6\gfz2010avtm\inputs\inventory-expanded.xml';
    Bytes=196426;Hash='FE208FA1BD82F8FC87B6461453139FB21985DD1A20E9CCE3F12D162E5A4D0010';
    Stage='inventory-expanded.xml'},
  @{Name='config';Relative='data\phase5b6\gfz2010avtm\inputs\config-expanded.xml';
    Bytes=13309;Hash='98E56386BFB3DB4C58AAF89026DA31B1272153535B836FF73BEC1C8CF35556CD';
    Stage='config-expanded.xml'},
  @{Name='event';Relative='data\real-events\gfz2010avtm\event.xml';
    Bytes=185646;Hash='B81D460B33A6E8A6422742CC7465A2EF85694893F08B3405FF31A74BA32B4EB2';
    Stage='event.xml'}
)
$rootItem=Get-Item -LiteralPath $Root -ErrorAction Stop
if (-not $rootItem.PSIsContainer) {throw 'Test root must be directory'}
$installRoot=$rootItem.FullName.TrimEnd('\')
if ($installRoot -notmatch '^[A-Za-z]:\\' -or
    [IO.Path]::GetFileName($installRoot) -ine 'SeisComP-Scconfig-Test-R10') {
  throw 'Only fixed disposable R10 test root is eligible'
}
$ancestor=$rootItem
while ($null -ne $ancestor) {
  if (($ancestor.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw 'Reparse-point installation ancestry is refused'
  }
  $ancestor=$ancestor.Parent
}
$disk=Get-CimInstance Win32_LogicalDisk -Filter ("DeviceID='"+$installRoot.Substring(0,2)+"'")
if ($null -eq $disk -or $disk.DriveType -ne 3 -or $disk.FileSystem -ne 'NTFS') {
  throw 'Disposable root must be local fixed NTFS'
}
$workspace=Get-Item -LiteralPath $WorkspaceRoot -ErrorAction Stop
if (-not $workspace.PSIsContainer) {throw 'WorkspaceRoot is not a directory'}
$workspacePath=$workspace.FullName.TrimEnd('\')
$manifestPath=Join-Path $installRoot 'SHA256SUMS.json'
if ((Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256 -ErrorAction Stop).Hash -ine
    $expectedManifest) {throw 'Unexpected R10 manifest'}
$manifest=Get-Content -LiteralPath $manifestPath -Raw -ErrorAction Stop |
  ConvertFrom-Json -ErrorAction Stop
if (@($manifest.PSObject.Properties).Count -ne 856) {throw 'Unexpected R10 file count'}
$receipt=Get-Content -LiteralPath ($installRoot+'.install-receipt.json') -Raw -ErrorAction Stop |
  ConvertFrom-Json -ErrorAction Stop
if ([string]$receipt.manifest_sha256 -ine $expectedManifest -or
    [string]$receipt.destination -ine $installRoot -or
    [int]$receipt.verified_files -ne 856) {throw 'Disposable installation receipt mismatch'}
function Assert-Pinned([string]$relative) {
  $found=@($manifest.PSObject.Properties |
    Where-Object {$_.Name.Replace('/','\') -ieq $relative})
  if ($found.Count -ne 1) {throw ('R10 manifest entry missing: '+$relative)}
  $path=[IO.Path]::GetFullPath((Join-Path $installRoot $relative))
  if (-not $path.StartsWith($installRoot+'\', [StringComparison]::OrdinalIgnoreCase)) {
    throw 'Manifest relative path escaped install root'
  }
  $item=Get-Item -LiteralPath $path -ErrorAction Stop
  if ($item.PSIsContainer -or
      ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw ('Invalid installed runtime file: '+$relative)
  }
  if ((Get-FileHash -LiteralPath $path -Algorithm SHA256 -ErrorAction Stop).Hash -ine
      [string]$found[0].Value) {throw ('R10 file differs from manifest: '+$relative)}
  return $item.FullName
}
$exe=Assert-Pinned 'bin\scolv.exe'
$null=Assert-Pinned 'bin\qt.conf'
$null=Assert-Pinned 'bin\qt-plugins\platforms\qwindows.dll'
$helper=Assert-Pinned 'share\windows\Use-DevelopmentEnvironment.ps1'
$descriptions=Join-Path $installRoot 'etc\descriptions'
$xmlCount=@(Get-ChildItem -LiteralPath $descriptions -File -Filter '*.xml' -ErrorAction Stop).Count
if ($xmlCount -ne 131) {throw 'Unexpected GUI module description count'}
$verifiedSources=@{}
foreach ($input in $inputs) {
  $path=Join-Path $workspacePath $input.Relative
  $source=Get-Item -LiteralPath $path -ErrorAction Stop
  if ($source.PSIsContainer -or
      ($source.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw ('Unsupported source file type: '+$input.Name)
  }
  if ($source.Length -ne $input.Bytes -or
      (Get-FileHash -LiteralPath $source.FullName -Algorithm SHA256 -ErrorAction Stop).Hash -ine
      $input.Hash) {throw ('Pinned source hash/size mismatch: '+$input.Name)}
  $verifiedSources[$input.Name]=$source.FullName
}
Write-Output '=== BATCH3D SCOLV NATIVE OFFLINE GUI PREFLIGHT ==='
Write-Output ('Executable: '+$exe)
Write-Output ('Manifest: '+$expectedManifest)
Write-Output 'DISPOSABLE_RECEIPT_AND_QT_RUNTIME_HASHES_PASS'
Write-Output ('DescriptionXMLCount: '+$xmlCount)
Write-Output 'GFZ2010AVTM_INVENTORY_CONFIG_EVENT_SHA256_AND_SIZE_PASS'
if (-not $Run) {
  Write-Output 'BATCH3D_SCOLV_OFFLINE_GUI_SOURCE_PREFLIGHT_PASS'
  Write-Output 'GUI_NOT_RUN; FIREWALL_NOT_CHANGED; NO_NETWORK_PROBE; NO_FIXTURE_COPIES_CREATED'
  Write-Output 'RUNTIME_REQUIRES_SEPARATE_SCOLV_AUTHORIZATION_AND_CONNECTED_HOST_REVIEW'
  return
}
if ([string]::IsNullOrWhiteSpace($AuthorizationReference) -or
    $AuthorizationReference -notmatch '(?i)scolv' -or
    -not $ConnectedHostRiskApproved -or
    -not $UserConfigurationReviewed -or
    -not $EgressLimitationsReviewed -or
    -not $ChildProcessRiskReviewed -or
    -not $OfflineDatabaseBehaviorReviewed) {
  throw 'New scolv-specific authorization and connected-host/database risk acknowledgments required'
}
$principal=[Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  throw 'scolv GUI must be run from non-elevated PowerShell'
}
foreach ($userHomeCandidate in @($env:USERPROFILE,$env:HOME)) {
  if (-not [string]::IsNullOrWhiteSpace($userHomeCandidate) -and
      (Test-Path -LiteralPath (Join-Path $userHomeCandidate '.seiscomp') -PathType Container)) {
    throw 'Existing user-home SeisComP configuration needs separate review'
  }
}
foreach ($name in @('SEISCOMP_ROOT','SEISCOMP_LOCAL_CONFIG','QT_PLUGIN_PATH',
                    'QT_QPA_PLATFORM_PLUGIN_PATH','QT_QPA_PLATFORM')) {
  if (-not [string]::IsNullOrWhiteSpace([Environment]::GetEnvironmentVariable($name,'Process'))) {
    throw ('Inherited process environment variable is not clean: '+$name)
  }
}
if (@(Get-Process -Name scolv -ErrorAction SilentlyContinue).Count -gt 0) {
  throw 'An existing scolv process was found'
}
$profiles=@(Get-NetFirewallProfile -PolicyStore ActiveStore -ErrorAction Stop)
if ($profiles.Count -ne 3 -or @($profiles | Where-Object {$_.Enabled -ne 'True'}).Count -gt 0) {
  throw 'Active firewall profiles must all be enabled'
}
$rules=@(Get-NetFirewallRule -Name $ruleName -PolicyStore ActiveStore -ErrorAction SilentlyContinue)
if ($rules.Count -ne 1) {throw 'SCOLV_ACTIVE_OUTBOUND_BLOCK_RULE_NOT_UNIQUE'}
$rule=$rules[0]
$app=@($rule | Get-NetFirewallApplicationFilter -ErrorAction Stop)
$port=@($rule | Get-NetFirewallPortFilter -ErrorAction Stop)
$address=@($rule | Get-NetFirewallAddressFilter -ErrorAction Stop)
$service=@($rule | Get-NetFirewallServiceFilter -ErrorAction Stop)
if ($rule.Enabled -ne 'True' -or $rule.Direction -ne 'Outbound' -or
    $rule.Action -ne 'Block' -or [string]$rule.Profile -ne 'Any' -or
    $app.Count -ne 1 -or [string]$app[0].Program -ine $exe -or
    $port.Count -ne 1 -or [string]$port[0].Protocol -ne 'Any' -or
    [string]$port[0].LocalPort -ne 'Any' -or
    [string]$port[0].RemotePort -ne 'Any' -or
    $address.Count -ne 1 -or [string]$address[0].LocalAddress -ne 'Any' -or
    [string]$address[0].RemoteAddress -ne 'Any' -or
    $service.Count -ne 1 -or [string]$service[0].Service -ne 'Any') {
  throw 'SCOLV_ACTIVE_OUTBOUND_BLOCK_RULE_SCOPE_MISMATCH'
}
Write-Output 'SCOLV_ACTIVE_BLOCK_RULE_SCOPE_PASS'
Write-Output 'REAL_EGRESS_NOT_TESTED; HELPER_PROCESSES_NOT_CONTAINED; HOST_STILL_CONNECTED'
if ([string]::IsNullOrWhiteSpace($EvidenceDirectory)) {
  throw 'External existing evidence directory is required'
}
$evidence=Get-Item -LiteralPath $EvidenceDirectory -ErrorAction Stop
if (-not $evidence.PSIsContainer -or
    ($evidence.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
  throw 'Evidence directory must exist, must be regular'
}
$evidenceRoot=$evidence.FullName.TrimEnd('\')
if ($evidenceRoot.StartsWith($installRoot+'\', [StringComparison]::OrdinalIgnoreCase)) {
  throw 'Evidence directory cannot be inside disposable R10 install root'
}
$timestamp=[DateTime]::UtcNow.ToString('yyyyMMdd-HHmmss')
$stdout=Join-Path $evidenceRoot ('scolv-'+$timestamp+'.stdout.txt')
$stderr=Join-Path $evidenceRoot ('scolv-'+$timestamp+'.qt-stderr.txt')
if ((Test-Path -LiteralPath $stdout) -or (Test-Path -LiteralPath $stderr)) {
  throw 'Evidence log name already exists'
}
if (-not $PSCmdlet.ShouldProcess($exe,'Run separately authorized offline local-XML scolv GUI smoke')) {
  Write-Output 'SCOLV_GUI_NOT_RUN: WhatIf or confirmation declined'
  return
}
function Ensure-TestDirectory([string]$path) {
  if (-not $path.StartsWith($installRoot+'\work\', [StringComparison]::OrdinalIgnoreCase)) {
    throw 'Test staging directory outside disposable R10 work'
  }
  $parts=@()
  $cursor=$path
  while ($cursor.Length -gt $installRoot.Length) {
    $parts+= $cursor
    $cursor=[IO.Path]::GetDirectoryName($cursor)
  }
  for ($i=$parts.Count-1;$i -ge 0;$i--) {
    $candidate=$parts[$i]
    if (Test-Path -LiteralPath $candidate) {
      $item=Get-Item -LiteralPath $candidate -Force -ErrorAction Stop
      if (-not $item.PSIsContainer -or
          ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw ('Invalid test staging directory: '+$candidate)
      }
    } else {
      $null=New-Item -ItemType Directory -Path $candidate -ErrorAction Stop
    }
  }
}
$stageRoot=Join-Path $installRoot 'work\offline-gui-scolv'
$inputRoot=Join-Path $stageRoot 'inputs\gfz2010avtm'
$homeDir=Join-Path $stageRoot 'home'
$appDataDir=Join-Path $stageRoot 'appdata'
$localAppDataDir=Join-Path $stageRoot 'localappdata'
foreach ($dir in @($inputRoot,$homeDir,$appDataDir,$localAppDataDir)) {
  Ensure-TestDirectory $dir
}
$staged=@{}
foreach ($input in $inputs) {
  $destination=Join-Path $inputRoot $input.Stage
  if (Test-Path -LiteralPath $destination) {
    $existing=Get-Item -LiteralPath $destination -Force -ErrorAction Stop
    if ($existing.PSIsContainer -or
        ($existing.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
      throw ('Invalid existing local fixture: '+$input.Name)
    }
    if ($existing.Length -ne $input.Bytes -or
        (Get-FileHash -LiteralPath $destination -Algorithm SHA256 -ErrorAction Stop).Hash -ine
        $input.Hash) {throw ('Existing local fixture differs: '+$input.Name)}
  }
  else {
    Copy-Item -LiteralPath $verifiedSources[$input.Name] -Destination $destination -ErrorAction Stop
    if ((Get-Item -LiteralPath $destination -ErrorAction Stop).Length -ne $input.Bytes -or
        (Get-FileHash -LiteralPath $destination -Algorithm SHA256 -ErrorAction Stop).Hash -ine
        $input.Hash) {throw ('New local fixture verification failed: '+$input.Name)}
  }
  $staged[$input.Name]=$destination
}
Write-Output 'SCOLV_THREE_INPUTS_STAGED_LOCAL_NTFS_WITH_VERIFIED_HASHES'
$vars=@('SEISCOMP_ROOT','SEISCOMP_LOCAL_CONFIG','PATH','QT_PLUGIN_PATH',
        'QT_QPA_PLATFORM','QT_QPA_PLATFORM_PLUGIN_PATH','QT_DEBUG_PLUGINS',
        'TEMP','TMP','PYTHONDONTWRITEBYTECODE','USERPROFILE','HOME',
        'APPDATA','LOCALAPPDATA')
$previous=@{}
foreach ($name in $vars) {
  $previous[$name]=[Environment]::GetEnvironmentVariable($name,'Process')
}
try {
  $env:USERPROFILE=$homeDir
  $env:HOME=$homeDir
  $env:APPDATA=$appDataDir
  $env:LOCALAPPDATA=$localAppDataDir
  . $helper -Root $installRoot -ExpectedManifestSha256 $expectedManifest | Out-Host
  if ($env:SEISCOMP_ROOT -ine $installRoot) {throw 'SeisComP development root mismatch'}
  $env:QT_QPA_PLATFORM='windows'
  $env:QT_DEBUG_PLUGINS='1'
  foreach ($path in $staged.Values) {
    if ($path.Contains('"')) {throw 'Input filename contains unsupported quotes'}
  }
  $argsList=@('--offline',
    '--inventory-db',('"'+$staged['inventory']+'"'),
    '--config-db',('"'+$staged['config']+'"'),
    '--input-file',('"'+$staged['event']+'"'))
  Write-Output 'SCOLV_LAUNCH_REQUESTED: --offline --inventory-db <pinned XML> --config-db <pinned XML> --input-file <pinned XML>'
  Write-Output 'DO_NOT_ENABLE_LIVE_ACQUISITION_MESSAGING_DATABASES_OR_SERVICES'
  $proc=Start-Process -FilePath $exe -ArgumentList $argsList -WorkingDirectory $installRoot -PassThru -Wait -RedirectStandardOutput $stdout -RedirectStandardError $stderr -ErrorAction Stop
  Write-Output ('SCOLV_PROCESS_EXIT: '+$proc.ExitCode)
  Write-Output ('STDOUT_EVIDENCE: '+$stdout)
  Write-Output ('QT_STDERR_EVIDENCE: '+$stderr)
  Write-Output 'SCOLV_GUI_FUNCTIONAL_AND_SCIENTIFIC_PASS_NOT_AUTOMATIC'
}
finally {
  foreach ($name in $vars) {
    [Environment]::SetEnvironmentVariable($name,$previous[$name],'Process')
  }
}
