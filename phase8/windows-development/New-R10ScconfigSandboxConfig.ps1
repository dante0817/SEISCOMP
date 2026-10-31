<#
SeisComP Phase 8 Batch 3B - Windows Sandbox configuration PREPARATION ONLY.
Reads the previously verified disposable R10 test installation on local NTFS.
Writes a .wsb configuration into an existing engineering workspace (prefer Y:).
NO application launch, helper execution, virtualization enablement, host changes
or network activity. Windows Sandbox availability is NOT assumed.
The host test directory is mapped READ-ONLY inside a guest; the original
installation is never mapped. A separately approved operator must verify
the guest isolation and copy the input to a guest-local writable directory
before any supervised scconfig execution. No LogonCommand is generated.
#>
[CmdletBinding()]
param(
    [string]$Source = (Join-Path $env:LOCALAPPDATA 'SeisComP-Scconfig-Test-R10'),
    [Parameter(Mandatory=$true)][string]$OutputPath,
    [ValidatePattern('^[A-Fa-f0-9]{64}$')]
    [string]$ExpectedManifestSha256 = '83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74'
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$sourceItem = Get-Item -LiteralPath $Source -ErrorAction Stop
if (-not $sourceItem.PSIsContainer) { throw 'Source must be the disposable R10 directory' }
$root = $sourceItem.FullName.TrimEnd('\')
if ($root -notmatch '^[A-Za-z]:\\') { throw 'Source must use a local absolute drive path' }
if ($root -match '(?i)\\SeisComP-Development-R10$') {
    throw 'Refusing immutable original development installation as Sandbox source'
}
$disk=Get-CimInstance Win32_LogicalDisk -Filter ("DeviceID='"+$root.Substring(0,2)+"'")
if ($null -eq $disk -or $disk.DriveType -ne 3 -or $disk.FileSystem -ne 'NTFS') {
    throw 'Source must be on a local fixed NTFS drive'
}
$ancestor=$sourceItem
while ($null -ne $ancestor) {
    if (($ancestor.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw ('Source ancestor is a reparse point: '+$ancestor.FullName)
    }
    $ancestor=$ancestor.Parent
}
$manifestPath=Join-Path $root 'SHA256SUMS.json'
if ((Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256 -ErrorAction Stop).Hash -ine $ExpectedManifestSha256) {
    throw 'Disposable R10 manifest identity mismatch'
}
$manifest=Get-Content -LiteralPath $manifestPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
if (@($manifest.PSObject.Properties).Count -ne 856) { throw 'Unexpected manifest entry count' }
$receiptPath=$root+'.install-receipt.json'
$receipt=Get-Content -LiteralPath $receiptPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
if ([string]$receipt.manifest_sha256 -ine $ExpectedManifestSha256 -or
    [string]$receipt.destination -ine $root -or [int]$receipt.verified_files -ne 856) {
    throw 'Disposable R10 installation receipt mismatch'
}

# Bound the most relevant checks to original manifested payload. The verified
# copy installer already checked all 856 files at the time of installation.
foreach ($relative in @('bin\scconfig.exe','bin\qt.conf',
                        'bin\qt-plugins\platforms\qwindows.dll','bin\seiscomp.exe')) {
    $entries=@($manifest.PSObject.Properties | Where-Object {
        $_.Name.Replace('/','\') -ieq $relative
    })
    if ($entries.Count -ne 1) { throw ('Required R10 manifest entry missing: '+$relative) }
    $candidate=Join-Path $root $relative
    if (-not (Test-Path -LiteralPath $candidate -PathType Leaf)) {
        throw ('Required R10 file missing: '+$relative)
    }
    if (((Get-Item -LiteralPath $candidate).Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw ('Reparse-point R10 file: '+$relative)
    }
    $actual=(Get-FileHash -LiteralPath $candidate -Algorithm SHA256 -ErrorAction Stop).Hash
    if ($actual -ine [string]$entries[0].Value) { throw ('Changed R10 file: '+$relative) }
}
if (Test-Path -LiteralPath (Join-Path $root 'var\run\seiscomp.init')) {
    throw 'Disposable copy already has a first-start marker: review and choose a new test copy'
}

$fullOutput = [IO.Path]::GetFullPath($OutputPath)
if ([IO.Path]::GetExtension($fullOutput) -ine '.wsb') { throw 'Output must have .wsb extension' }
if (Test-Path -LiteralPath $fullOutput) {
    throw ('Output exists: preserve it and select a new filename: '+$fullOutput)
}
$outputDir=Split-Path -Path $fullOutput -Parent
if (-not (Test-Path -LiteralPath $outputDir -PathType Container)) {
    throw 'Output parent must already exist (use the Y: engineering-tools folder)'
}
if ($fullOutput.StartsWith($root+'\', [StringComparison]::OrdinalIgnoreCase)) {
    throw 'Refusing output inside mapped test root'
}
$xmlHostFolder=[Security.SecurityElement]::Escape($root)
$wsb=@"
<Configuration>
  <VGpu>Disable</VGpu>
  <Networking>Disable</Networking>
  <AudioInput>Disable</AudioInput>
  <VideoInput>Disable</VideoInput>
  <PrinterRedirection>Disable</PrinterRedirection>
  <ClipboardRedirection>Disable</ClipboardRedirection>
  <MappedFolders>
    <MappedFolder>
      <HostFolder>$xmlHostFolder</HostFolder>
      <SandboxFolder>C:\SeisComP-Input</SandboxFolder>
      <ReadOnly>true</ReadOnly>
    </MappedFolder>
  </MappedFolders>
</Configuration>
"@
$parsed = [xml]$wsb
if ($parsed.Configuration.Networking -ne 'Disable' -or
    $parsed.Configuration.ClipboardRedirection -ne 'Disable' -or
    $parsed.Configuration.MappedFolders.MappedFolder.ReadOnly -ne 'true' -or
    $null -ne $parsed.Configuration.LogonCommand) {
    throw 'Generated Sandbox configuration failed its safety check'
}
[IO.File]::WriteAllText($fullOutput,$wsb,(New-Object Text.UTF8Encoding($false)))
Write-Output 'BATCH3B_R10_SANDBOX_CONFIG_PREPARED'
Write-Output ('WSBPath: '+$fullOutput)
Write-Output 'NetworkDisabledInConfiguration: True'
Write-Output 'InputHostFolderMappedReadOnly: True'
Write-Output 'ClipboardDisabledInConfiguration: True'
Write-Output 'AutomaticApplicationLaunch: False'
Write-Output 'ORIGINAL_R10_NOT_MAPPED; NO_APP_EXECUTED; ISOLATION_NOT_INDEPENDENTLY_PROVEN'
Write-Warning 'Never run scconfig from C:\SeisComP-Input (read-only mapping). Approved guest-only startup requires a writable guest-local copy.'
