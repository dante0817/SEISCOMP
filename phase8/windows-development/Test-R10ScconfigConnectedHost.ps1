<#
SeisComP Phase 8 Batch 3B: CONNECTED HOST native scconfig readiness inventory.
READ ONLY. The host remains connected to the network. This is NOT an isolation
or runtime approval certificate and launches no SeisComP, GUI or helper.
No network probes, firewall changes, privilege escalation or configuration edits.
Use only the disposable R10 scconfig test installation, never immutable R10.
#>
[CmdletBinding()]
param(
  [string]$Root = (Join-Path $env:LOCALAPPDATA 'SeisComP-Scconfig-Test-R10'),
  [ValidatePattern('^[0-9a-fA-F]{64}$')]
  [string]$ExpectedManifestSha256 = '83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74'
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$rootItem = Get-Item -LiteralPath $Root -ErrorAction Stop
if (-not $rootItem.PSIsContainer) { throw 'Test root must be a directory' }
$rootPath = $rootItem.FullName.TrimEnd('\')
if ($rootPath -notmatch '^[A-Za-z]:\\') { throw 'Test root must be a local absolute path' }
if ($rootPath -match '(?i)\\SeisComP-Development-R10$') { throw 'Refusing immutable installed R10 root' }
$testName = [IO.Path]::GetFileName($rootPath)
if ($testName -ine 'SeisComP-Scconfig-Test-R10') { throw 'Only the verified disposable R10 test copy is allowed' }
$sourceRoot = (Join-Path $env:LOCALAPPDATA 'SeisComP-Development-R10')
if ($rootPath -ieq $sourceRoot) { throw 'Refusing immutable installed R10 root' }
$drive = Get-CimInstance Win32_LogicalDisk -Filter ("DeviceID='"+$rootPath.Substring(0,2)+"'")
if ($null -eq $drive -or $drive.DriveType -ne 3 -or $drive.FileSystem -ne 'NTFS') {
    throw 'Test root requires local fixed NTFS'
}
$ancestor = $rootItem
while ($null -ne $ancestor) {
    if (($ancestor.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw 'Test root or an ancestor is a reparse point'
    }
    $ancestor = $ancestor.Parent
}
$manifestPath = Join-Path $rootPath 'SHA256SUMS.json'
$observed = (Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256 -ErrorAction Stop).Hash
if ($observed -ine $ExpectedManifestSha256) { throw 'Disposable R10 manifest SHA-256 mismatch' }
$manifest = Get-Content -LiteralPath $manifestPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
if (@($manifest.PSObject.Properties).Count -ne 856) { throw 'Unexpected R10 manifest entry count' }
$receipt = Get-Content -LiteralPath ($rootPath+'.install-receipt.json') -Raw -ErrorAction Stop |
    ConvertFrom-Json -ErrorAction Stop
if ([string]$receipt.manifest_sha256 -ine $ExpectedManifestSha256 -or
    [string]$receipt.destination -ine $rootPath -or
    [int]$receipt.verified_files -ne 856) {
    throw 'Disposable R10 installation receipt mismatch'
}
function Assert-File([string]$Relative) {
    $entries = @($manifest.PSObject.Properties | Where-Object {
        $_.Name.Replace('/','\') -ieq $Relative
    })
    if ($entries.Count -ne 1) { throw ('Manifest entry missing: '+$Relative) }
    $path = Join-Path $rootPath $Relative
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw ('File missing: '+$Relative) }
    if (((Get-Item -LiteralPath $path).Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw ('Reparse point refused: '+$Relative)
    }
    if ((Get-FileHash -LiteralPath $path -Algorithm SHA256 -ErrorAction Stop).Hash -ine
        [string]$entries[0].Value) { throw ('File hash mismatch: '+$Relative) }
    return $path
}
$scconfig = Assert-File 'bin\scconfig.exe'
$seiscomp = Assert-File 'bin\seiscomp.exe'
$null = Assert-File 'bin\qt.conf'
$null = Assert-File 'bin\qt-plugins\platforms\qwindows.dll'
$null = Assert-File 'share\windows\Use-DevelopmentEnvironment.ps1'

Write-Output '=== BATCH 3B CONNECTED HOST READINESS (READ ONLY) ==='
Write-Output ('R10TestManifest: '+$observed)
Write-Output 'DisposableReceipt: VERIFIED'
Write-Output 'ScconfigAndController: MANIFEST_VERIFIED'
Write-Output ('FirstStartMarkerExists: '+(Test-Path -LiteralPath (Join-Path $rootPath 'var\run\seiscomp.init') -PathType Leaf))
Write-Output ('OriginalR10UntouchedByThisProbe: True')
Write-Output 'HostNetwork: LEFT_CONNECTED'
Write-Output 'GuiLaunched: False'

$firewallAvailable = [bool]((Get-Command Get-NetFirewallRule -ErrorAction SilentlyContinue) -and
                            (Get-Command Get-NetFirewallApplicationFilter -ErrorAction SilentlyContinue) -and
                            (Get-Command Get-NetFirewallProfile -ErrorAction SilentlyContinue))
Write-Output ('FirewallReadApiAvailable: '+$firewallAvailable)
if ($firewallAvailable) {
    try {
        $profiles = @(Get-NetFirewallProfile -PolicyStore ActiveStore -ErrorAction Stop)
        $enabled = @($profiles | Where-Object { $_.Enabled -eq $true })
        Write-Output ('ActiveFirewallProfilesEnabled: '+$enabled.Count+'/'+$profiles.Count)
        # Match exact executable path for active outbound deny rules. An observed
        # rule alone is NOT proof of effective egress prevention.
        $rules = @(Get-NetFirewallRule -PolicyStore ActiveStore -Direction Outbound -Action Block -Enabled True -ErrorAction Stop)
        foreach ($candidate in @($scconfig,$seiscomp)) {
            $found = 0
            foreach ($rule in $rules) {
                $filters = @($rule | Get-NetFirewallApplicationFilter -ErrorAction Stop)
                foreach ($filter in $filters) {
                    if ([string]$filter.Program -ieq $candidate) {
                        $found++
                    }
                }
            }
            Write-Output ('ObservedOutboundBlockRuleFor_'+[IO.Path]::GetFileName($candidate)+': '+($found -gt 0))
        }
        Write-Output 'ActiveStoreFirewallRules: OBSERVED_NOT_EFFECTIVENESS_TESTED'
    } catch {
        Write-Output 'FirewallInspection: INCOMPLETE_OR_POLICY_RESTRICTED'
        Write-Output 'ActiveStoreFirewallRules: NOT_VERIFIED'
    }
} else {
    Write-Output 'ActiveStoreFirewallRules: NOT_AVAILABLE'
}
Write-Output 'CONNECTED_HOST_READINESS_INSPECTION_COMPLETE'
Write-Output 'NO_FIREWALL_CHANGE; NO_GUI_EXECUTED; NO_NETWORK_PROBE'
Write-Output 'NO_EGRESS_CONTAINMENT_PROVEN; DO_NOT_INFER_RUNTIME_AUTHORIZATION'
