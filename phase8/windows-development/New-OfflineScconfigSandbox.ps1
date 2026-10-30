<#
SeisComP P8 Batch 1: prepare an isolated Windows Sandbox CONFIGURATION only.
No Windows Sandbox or SeisComP executable is launched.
The .wsb file maps the verified R9 development directory read-only and disables
networking, clipboard, vGPU, audio, video and printer redirection.
#>
[CmdletBinding()]
param(
    [string]$Root = (Join-Path $env:LOCALAPPDATA 'SeisComP-Development-R9'),
    [Parameter(Mandatory=$true)]
    [ValidatePattern('^[0-9a-fA-F]{64}$')]
    [string]$ExpectedManifestSha256,
    [string]$OutputPath = (Join-Path $env:TEMP 'SeisComP-R9-Offline-GUI.wsb')
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$rootItem = Get-Item -LiteralPath $Root -ErrorAction Stop
if (-not $rootItem.PSIsContainer) { throw 'R9 root must be a directory.' }
$rootPath = $rootItem.FullName.TrimEnd('\')
if ($rootPath -notmatch '^[A-Za-z]:\\') { throw 'R9 root must be a local Windows path.' }
foreach ($relativePath in @('SHA256SUMS.json', 'bin\scconfig.exe', 'share\windows\Use-DevelopmentEnvironment.ps1')) {
    if (-not (Test-Path -LiteralPath (Join-Path $rootPath $relativePath) -PathType Leaf)) {
        throw ('Missing R9 file: ' + $relativePath)
    }
}
$manifestHash = (Get-FileHash -LiteralPath (Join-Path $rootPath 'SHA256SUMS.json') -Algorithm SHA256).Hash
if ($manifestHash -ine $ExpectedManifestSha256) {
    throw 'Installed R9 manifest SHA-256 mismatch. No sandbox configuration written.'
}
if ([IO.Path]::GetExtension($OutputPath) -ine '.wsb') {
    throw 'OutputPath must end in .wsb'
}
$outputFullPath = [IO.Path]::GetFullPath($OutputPath)
if (Test-Path -LiteralPath $outputFullPath) {
    throw ('Output already exists; preserve it and select a new filename: '+$outputFullPath)
}
$outputParent = Split-Path -Path $outputFullPath -Parent
if (-not (Test-Path -LiteralPath $outputParent -PathType Container)) {
    throw 'Output directory must already exist.'
}

$escapedHostFolder=[Security.SecurityElement]::Escape($rootPath)
$wsb=@"
<Configuration>
  <Networking>Disable</Networking>
  <VGpu>Disable</VGpu>
  <AudioInput>Disable</AudioInput>
  <VideoInput>Disable</VideoInput>
  <PrinterRedirection>Disable</PrinterRedirection>
  <ClipboardRedirection>Disable</ClipboardRedirection>
  <MappedFolders>
    <MappedFolder>
      <HostFolder>$escapedHostFolder</HostFolder>
      <SandboxFolder>C:\SeisComP-Input</SandboxFolder>
      <ReadOnly>true</ReadOnly>
    </MappedFolder>
  </MappedFolders>
</Configuration>
"@
$parsed = [xml]$wsb
if ($parsed.Configuration.Networking -ne 'Disable' -or
    $parsed.Configuration.MappedFolders.MappedFolder.ReadOnly -ne 'true') {
    throw 'Internal sandbox configuration validation failed.'
}
[IO.File]::WriteAllText($outputFullPath,$wsb,(New-Object Text.UTF8Encoding($false)))
Write-Output ('SANDBOX_CONFIG_CREATED: '+$outputFullPath)
Write-Output ('VerifiedR9Manifest: '+$manifestHash)
Write-Output 'SandboxNetworking: DISABLED_IN_CONFIG'
Write-Output 'SandboxClipboard: DISABLED_IN_CONFIG'
Write-Output 'HostFolder: READ_ONLY_MAPPING_IN_CONFIG'
Write-Output 'NOT_LAUNCHED: creating .wsb does not start Windows Sandbox or SeisComP.'
Write-Warning 'Host-to-sandbox mapped folders allow read access to the selected R9 directory; review its contents before launch.'
Write-Warning 'Only an approved and independently reviewed isolated session should launch unqualified SeisComP executables.'
