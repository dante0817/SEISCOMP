<# Dot-source in an approved local development session. Sets this process only; launches nothing. #>
[CmdletBinding(SupportsShouldProcess=$true)]
param(
    [Parameter(Mandatory=$true)][string]$Root,
    [Parameter(Mandatory=$true)][ValidatePattern('^[A-Fa-f0-9]{64}$')][string]$ExpectedManifestSha256
)
$ErrorActionPreference='Stop'
$installRoot=(Get-Item -LiteralPath $Root).FullName.TrimEnd('\')
if ($installRoot -notmatch '^[A-Za-z]:\\') { throw 'Use a local Windows installation path' }
$disk=Get-CimInstance Win32_LogicalDisk -Filter ("DeviceID='"+$installRoot.Substring(0,2)+"'")
if ($null -eq $disk -or $disk.DriveType -ne 3 -or $disk.FileSystem -ne 'NTFS') { throw 'Use a fixed local NTFS installation' }
if ((Get-FileHash -LiteralPath (Join-Path $installRoot 'SHA256SUMS.json') -Algorithm SHA256).Hash -ne $ExpectedManifestSha256) { throw 'Installation manifest identity differs' }
$localConfig=Join-Path $installRoot 'work\config'
$temporary=Join-Path $installRoot 'work\temp'
if ($PSCmdlet.ShouldProcess($installRoot,'Prepare process-local SeisComP/Qt environment; no application launch')) {
    foreach ($directory in @($localConfig,$temporary)) {
        if (-not (Test-Path -LiteralPath $directory)) { New-Item -ItemType Directory -Path $directory | Out-Null }
    }
    $env:SEISCOMP_ROOT=$installRoot
    $env:SEISCOMP_LOCAL_CONFIG=$localConfig
    $env:PATH=(Join-Path $installRoot 'bin')+';'+$env:SystemRoot+'\System32'
    $env:QT_PLUGIN_PATH=Join-Path $installRoot 'bin\qt-plugins'
    $env:TEMP=$temporary
    $env:TMP=$temporary
    $env:PYTHONDONTWRITEBYTECODE='1'
    Write-Output 'Process-local environment prepared. This is not network isolation or execution authorization.'
}
