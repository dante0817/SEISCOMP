<#
SeisComP native Windows Phase 8, Batch 1: read-only runtime-readiness inventory.
Does not launch an application, execute a helper, create directories, alter settings,
probe remote endpoints, or independently establish network isolation.
Do not treat output as an authorization to run SeisComP.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$Root,
    [Parameter(Mandatory=$true)]
    [ValidatePattern('^[A-Fa-f0-9]{64}$')]
    [string]$ExpectedManifestSha256
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$rootItem = Get-Item -LiteralPath $Root -ErrorAction Stop
if (-not $rootItem.PSIsContainer) { throw 'The development Root must be a directory.' }
$rootPath = $rootItem.FullName.TrimEnd('\')
if ($rootPath -notmatch '^[A-Za-z]:\\') { throw 'The development Root must be an absolute Windows path.' }
$manifestPath = Join-Path $rootPath 'SHA256SUMS.json'
if (-not (Test-Path -LiteralPath $manifestPath -PathType Leaf)) {
    throw 'The development manifest was not found.'
}
$actual = (Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256).Hash
if ($actual -ine $ExpectedManifestSha256) {
    throw 'The installed development manifest does not match the externally verified identity.'
}
$scconfigPath = Join-Path $rootPath 'bin\scconfig.exe'
if (-not (Test-Path -LiteralPath $scconfigPath -PathType Leaf)) {
    throw 'scconfig.exe was not found in the selected development installation.'
}
$descriptions = Join-Path $rootPath 'etc\descriptions'
$xmlCount = 0
if (Test-Path -LiteralPath $descriptions -PathType Container) {
    $xmlCount = @(Get-ChildItem -LiteralPath $descriptions -File -Filter '*.xml' -ErrorAction Stop).Count
}

Write-Output 'SEISCOMP_GUI_READINESS_INVENTORY'
Write-Output ('ManifestIdentity: PASS ('+$actual+')')
Write-Output ('ScconfigPresent: True')
Write-Output ('ModuleDescriptionXMLCount: '+$xmlCount)
$activeRoot = [Environment]::GetEnvironmentVariable('SEISCOMP_ROOT','Process')
$activeConfig = [Environment]::GetEnvironmentVariable('SEISCOMP_LOCAL_CONFIG','Process')
Write-Output ('CurrentSessionRoot: '+$(if ([string]::IsNullOrWhiteSpace($activeRoot)) {'UNSET'} elseif ($activeRoot -ieq $rootPath) {'MATCHES_R9'} else {'DIFFERENT_ROOT'}))
Write-Output ('CurrentSessionLocalConfig: '+$(if ([string]::IsNullOrWhiteSpace($activeConfig)) {'UNSET'} else {'SET; REVIEW_EFFECTIVE_PRECEDENCE'}))

# These are a small set of known possible override locations, not an exhaustive
# SeisComP configuration resolver. No configuration values are printed.
$configCandidates = @()
foreach ($baseDir in @($env:USERPROFILE, $env:HOME)) {
    if (-not [string]::IsNullOrWhiteSpace($baseDir)) {
        $configCandidates += (Join-Path $baseDir '.seiscomp')
    }
}
if (-not [string]::IsNullOrWhiteSpace($env:APPDATA)) {
    $configCandidates += (Join-Path $env:APPDATA 'SeisComP')
}
$configCandidates += (Join-Path $rootPath 'work\config')
$configCandidates = @($configCandidates | Select-Object -Unique)
$existingConfig = @($configCandidates | Where-Object { Test-Path -LiteralPath $_ -PathType Container })
Write-Output ('CandidateConfigDirsPresent: '+$existingConfig.Count)
foreach ($candidateDir in $existingConfig) {
    $candidateFiles = @(Get-ChildItem -LiteralPath $candidateDir -File -Recurse -ErrorAction Stop)
    $kind = if ($candidateDir -ieq (Join-Path $rootPath 'work\config')) { 'R9_LOCAL_CONFIG' } else { 'USER_PROFILE_POSSIBLE_OVERRIDE' }
    Write-Output ('  '+$kind+': Files='+$candidateFiles.Count)
}

# Only query process metadata; do not signal, stop, or inspect command lines.
$names = @('scmaster.exe','seedlink.exe','scconfig.exe','scrttv.exe','scolv.exe',
           'scautopick.exe','scautoloc.exe','scamp.exe','scmag.exe','scevent.exe',
           'scdb.exe','scqc.exe','scevtls.exe')
try {
    $processes = @(Get-CimInstance Win32_Process -ErrorAction Stop | Where-Object {
        $names -contains $_.Name
    } | Sort-Object Name, ProcessId)
    Write-Output ('KnownSeisComPProcesses: '+$processes.Count)
    foreach ($proc in $processes) {
        Write-Output ('  '+$proc.Name+' PID='+$proc.ProcessId)
    }
} catch {
    Write-Output 'KnownSeisComPProcesses: UNKNOWN (process inventory unavailable)'
}

# This reads the local socket table. It does NOT connect to any endpoint.
$watchPorts = @(18000,18001,18180,18181,18182,18183,3306,5432)
try {
    if (Get-Command 'Get-NetTCPConnection' -ErrorAction SilentlyContinue) {
        $listeners = @(Get-NetTCPConnection -State Listen -ErrorAction Stop |
            Where-Object { $watchPorts -contains [int]$_.LocalPort } |
            Sort-Object LocalPort, OwningProcess -Unique)
        Write-Output ('WatchedLocalListeners: '+$listeners.Count)
        foreach ($listener in $listeners) {
            Write-Output ('  Port='+$listener.LocalPort+' PID='+$listener.OwningProcess)
        }
    } else {
        Write-Output 'WatchedLocalListeners: UNKNOWN (Get-NetTCPConnection unavailable)'
    }
} catch {
    Write-Output 'WatchedLocalListeners: UNKNOWN (socket inventory inaccessible)'
}

try {
    if (Get-Command 'Get-NetAdapter' -ErrorAction SilentlyContinue) {
        $up = @(Get-NetAdapter -ErrorAction Stop | Where-Object { $_.Status -eq 'Up' })
        Write-Output ('AdaptersReportedUp: '+$up.Count)
        Write-Output 'AdapterStatus: INDICATOR_ONLY; not proof of network or loopback isolation'
    } else {
        Write-Output 'AdaptersReportedUp: UNKNOWN (Get-NetAdapter unavailable)'
    }
} catch {
    Write-Output 'AdaptersReportedUp: UNKNOWN (adapter inventory inaccessible)'
}

Write-Output 'GUI_NOT_RUN: inventory only; no application, helper, service or remote connection was started.'
Write-Output 'RUNTIME_ISOLATION_NOT_ESTABLISHED: requires separately reviewed and verified test boundary.'
Write-Output 'RUNTIME_AUTHORIZATION_NOT_ESTABLISHED: explicit approval for scoped launch remains separate.'
