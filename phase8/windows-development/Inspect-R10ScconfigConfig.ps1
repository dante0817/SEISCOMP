<#
Phase 8 Batch 3B — scconfig configuration/source-of-settings inventory.
READ ONLY: does not launch scconfig, seiscomp, Python, services, Qt or network.
Prints counts and provenance categories, NEVER configuration parameter values,
credentials or endpoint addresses. This is not an effective-config resolver and
does not prove isolation, startup, or scientific behavior.
Uses the original SeisComP configuration-precedence model (defaults, system,
local override). Installed R10 remains immutable.
#>
[CmdletBinding()]
param(
    [string]$Root = (Join-Path $env:LOCALAPPDATA 'SeisComP-Development-R10'),
    [ValidatePattern('^[0-9A-Fa-f]{64}$')]
    [string]$ExpectedManifestSha256 = '83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74'
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$rootItem = Get-Item -LiteralPath $Root -ErrorAction Stop
if (-not $rootItem.PSIsContainer) { throw 'R10 root is not a directory' }
$rootPath = $rootItem.FullName.TrimEnd('\')
if ($rootPath -notmatch '^[A-Za-z]:\\') { throw 'R10 root must be an absolute local drive path' }
if (($rootItem.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw 'R10 root must not be a reparse point'
}
$drive = [IO.DriveInfo]::new($rootPath.Substring(0,3))
if (-not $drive.IsReady -or $drive.DriveType -ne [IO.DriveType]::Fixed -or
    $drive.DriveFormat -ne 'NTFS') {
    throw 'R10 root requires a fixed local NTFS drive'
}

$manifestPath = Join-Path $rootPath 'SHA256SUMS.json'
$actualManifest = (Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256 -ErrorAction Stop).Hash
if ($actualManifest -ine $ExpectedManifestSha256) {
    throw 'R10 manifest hash not equal to independently verified digest'
}
$manifest = Get-Content -LiteralPath $manifestPath -Raw -ErrorAction Stop |
    ConvertFrom-Json -ErrorAction Stop
if (@($manifest.PSObject.Properties).Count -ne 856) {
    throw 'Unexpected R10 manifest entry count'
}
$receiptPath = $rootPath + '.install-receipt.json'
$receipt = Get-Content -LiteralPath $receiptPath -Raw -ErrorAction Stop |
    ConvertFrom-Json -ErrorAction Stop
if ([string]$receipt.manifest_sha256 -ine $ExpectedManifestSha256 -or
    [string]$receipt.destination -ine $rootPath -or
    [int]$receipt.verified_files -ne 856) {
    throw 'R10 installation receipt does not match the selected copy'
}

function Assert-Manifested([string]$Relative) {
    $normalized = $Relative.Replace('\','/')
    $entries = @($manifest.PSObject.Properties | Where-Object {
        $_.Name.Replace('\','/') -ieq $normalized
    })
    if ($entries.Count -ne 1) { throw ('Missing/ambiguous file in manifest: '+$Relative) }
    $path = [IO.Path]::GetFullPath((Join-Path $rootPath $Relative))
    if (-not $path.StartsWith($rootPath+'\', [StringComparison]::OrdinalIgnoreCase)) {
        throw ('Path outside R10 root: '+$Relative)
    }
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw ('Missing manifest file: '+$Relative)
    }
    if (((Get-Item -LiteralPath $path).Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw ('Reparse point in R10: '+$Relative)
    }
    $expected = [string]$entries[0].Value
    if ($expected -notmatch '^[a-fA-F0-9]{64}$') { throw 'Bad stored file hash' }
    if ((Get-FileHash -LiteralPath $path -Algorithm SHA256 -ErrorAction Stop).Hash -ine $expected) {
        throw ('Manifest-listed file changed: '+$Relative)
    }
    return $path
}

$null = Assert-Manifested 'bin\scconfig.exe'
$qtConfPath = Assert-Manifested 'bin\qt.conf'
$null = Assert-Manifested 'share\windows\Use-DevelopmentEnvironment.ps1'
$null = Assert-Manifested 'bin\qt-plugins\platforms\qwindows.dll'
$qtText = Get-Content -LiteralPath $qtConfPath -Raw -ErrorAction Stop
if ($qtText -notmatch '(?im)^\s*Plugins\s*=\s*qt-plugins\s*$') {
    throw 'R10 qt.conf plugin location differs from verified layout'
}

# Reading settings is necessary to count them, but NEVER print lines, values,
# or secrets. Treat comments, sections and non-assignment lines as non-keys.
function Get-ConfigCounts([string]$Path) {
    $count = 0
    $risk = 0
    if (Test-Path -LiteralPath $Path -PathType Leaf) {
        if (((Get-Item -LiteralPath $Path).Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
            throw 'Config file reparse point rejected'
        }
        foreach ($line in @(Get-Content -LiteralPath $Path -ErrorAction Stop)) {
            if ($line -match '^\s*[A-Za-z_][A-Za-z0-9_.-]*\s*=') {
                $count++
                $key = [regex]::Match($line,'^\s*([A-Za-z_][A-Za-z0-9_.-]*)\s*=').Groups[1].Value
                if ($key -match '(?i)(^|\.)(connection|database|messaging|recordstream|seedlink|server|host|port|uri|url)(\.|$)') {
                    $risk++
                }
            }
        }
        return [pscustomobject]@{ Exists=$true; Count=$count; EndpointKeyIndicators=$risk }
    }
    return [pscustomobject]@{ Exists=$false; Count=0; EndpointKeyIndicators=0 }
}

# Candidate config directories: the true effective runtime configuration must
# still be checked against the actual pinned SeisComP original source.
$localConfig = Join-Path $rootPath 'work\config'
$userRoots = [System.Collections.Generic.List[string]]::new()
foreach ($userHome in @($env:USERPROFILE, $env:HOME)) {
    if (-not [string]::IsNullOrWhiteSpace($userHome)) {
        $candidate = Join-Path $userHome '.seiscomp'
        if (-not $userRoots.Contains($candidate)) { [void]$userRoots.Add($candidate) }
    }
}
$observedOverrideDirs = @($userRoots | Where-Object {
    Test-Path -LiteralPath $_ -PathType Container
})

Write-Output '=== BATCH 3B R10 SCCONFIG CONFIGURATION INVENTORY ==='
Write-Output ('R10Manifest: '+$actualManifest)
Write-Output 'R10InstallReceipt: VERIFIED'
Write-Output 'ScconfigAndQtConf: VERIFIED'
$descDir = Join-Path $rootPath 'etc\descriptions'
$xmlCount = if (Test-Path -LiteralPath $descDir -PathType Container) {
    @(Get-ChildItem -LiteralPath $descDir -Filter '*.xml' -File -ErrorAction Stop).Count
} else { 0 }
Write-Output ('DescriptionXMLCount: '+$xmlCount)
if ($xmlCount -eq 0) { throw 'No module descriptions found for scconfig' }

$locations = @(
    [pscustomobject]@{ Name='DEFAULT_GLOBAL'; Path=(Join-Path $rootPath 'etc\defaults\global.cfg') },
    [pscustomobject]@{ Name='DEFAULT_SCCONFIG'; Path=(Join-Path $rootPath 'etc\defaults\scconfig.cfg') },
    [pscustomobject]@{ Name='SYSTEM_GLOBAL'; Path=(Join-Path $rootPath 'etc\global.cfg') },
    [pscustomobject]@{ Name='SYSTEM_SCCONFIG'; Path=(Join-Path $rootPath 'etc\scconfig.cfg') },
    [pscustomobject]@{ Name='HELPER_LOCAL_GLOBAL'; Path=(Join-Path $localConfig 'global.cfg') },
    [pscustomobject]@{ Name='HELPER_LOCAL_SCCONFIG'; Path=(Join-Path $localConfig 'scconfig.cfg') }
)
foreach ($config in $locations) {
    $count = Get-ConfigCounts $config.Path
    Write-Output ('CONFIG_SOURCE: '+$config.Name+' Present='+$count.Exists+
        ' Keys='+$count.Count+' EndpointKeyIndicators='+$count.EndpointKeyIndicators)
}
Write-Output ('UserHomeSeiscompOverrideDirsPresent: '+$observedOverrideDirs.Count)
foreach ($configName in @('global.cfg','scconfig.cfg')) {
    $present = 0
    foreach ($userDir in $observedOverrideDirs) {
        if (Test-Path -LiteralPath (Join-Path $userDir $configName) -PathType Leaf) {
            $present++
        }
    }
    Write-Output ('USER_HOME_OVERRIDE_FILE: '+$configName+' PresentInDirs='+$present)
}
foreach ($name in @('SEISCOMP_ROOT','SEISCOMP_LOCAL_CONFIG','QT_PLUGIN_PATH',
                    'QT_QPA_PLATFORM_PLUGIN_PATH','QT_QPA_PLATFORM')) {
    $value = [Environment]::GetEnvironmentVariable($name,'Process')
    $state = if ([string]::IsNullOrWhiteSpace($value)) { 'UNSET' }
             elseif ($name -eq 'SEISCOMP_ROOT' -and $value -ieq $rootPath) { 'MATCHES_R10' }
             elseif ($name -eq 'SEISCOMP_LOCAL_CONFIG' -and $value -ieq $localConfig) { 'MATCHES_R10_HELPER' }
             else { 'SET_REVIEW_REQUIRED' }
    Write-Output ('SESSION_ENV: '+$name+' '+$state)
}
Write-Output 'SCONFIG_CONFIG_INVENTORY_COMPLETE'
Write-Output 'VALUES_NOT_DISPLAYED; EFFECTIVE_PRECEDENCE_NOT_PROVEN'
Write-Output 'NO_GUI_EXECUTED; NO_NETWORK_ISOLATION_PROVEN; NOT_RUNTIME_QUALIFIED'
