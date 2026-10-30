<#
Build a SEPARATE R10 candidate by adding the verified Qt 5.15.18 offscreen plugin.
No SeisComP executables, modules, services, GUI or network access are invoked.
Source R9 remains unchanged. Destination must not already exist.
Use -WhatIf first. This produces an UNQUALIFIED development candidate.
#>
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true)][string]$SourceRoot,
    [Parameter(Mandatory=$true)][string]$OffscreenPlugin,
    [Parameter(Mandatory=$true)][string]$Destination
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$PinnedR9 = '475CF040BAE301822A08A31B32A3D218A75621DAD5EEA314A563221E107DFB57'
$PinnedPlugin = '111CD9A0E512545DCD7E4BCC130E70ABA4EA1B9A1B1068545F5D1B193B0C04A6'
$PluginRel = 'bin\qt-plugins\platforms\qoffscreen.dll'
$CatalogRel = 'share\windows\gui-package.json'
$ManifestName = 'SHA256SUMS.json'

function Assert-NoReparse([string]$Path) {
    $item = Get-Item -LiteralPath $Path -Force -ErrorAction Stop
    if (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw ('Reparse point rejected: '+$item.FullName)
    }
}
function Assert-Hash([string]$Path,[string]$Expected) {
    if ($Expected -notmatch '^[a-fA-F0-9]{64}$') { throw 'Invalid expected SHA-256' }
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { throw ('Missing: '+$Path) }
    Assert-NoReparse $Path
    $value=(Get-FileHash -LiteralPath $Path -Algorithm SHA256 -ErrorAction Stop).Hash
    if ($value -ine $Expected) { throw ('Hash mismatch: '+$Path) }
    return $value
}
function Assert-Amd64Pe([string]$Path) {
    $stream=[IO.File]::OpenRead($Path)
    $reader=New-Object IO.BinaryReader($stream)
    try {
        if ($reader.ReadUInt16() -ne 0x5A4D) { throw 'Not an MZ executable' }
        [void]$stream.Seek(0x3c,[IO.SeekOrigin]::Begin)
        $offset=$reader.ReadInt32()
        if ($offset -lt 0x40 -or ($offset+6) -gt $stream.Length) { throw 'Bad PE header offset' }
        [void]$stream.Seek($offset,[IO.SeekOrigin]::Begin)
        if ($reader.ReadUInt32() -ne 0x00004550) { throw 'Not a PE image' }
        if ($reader.ReadUInt16() -ne 0x8664) { throw 'Not AMD64/x64' }
    }
    finally { $reader.Dispose(); $stream.Dispose() }
}

$source=(Get-Item -LiteralPath $SourceRoot -ErrorAction Stop).FullName.TrimEnd('\')
if (-not (Test-Path -LiteralPath $source -PathType Container)) { throw 'Source is not a directory' }
Assert-NoReparse $source
$plugin=(Get-Item -LiteralPath $OffscreenPlugin -ErrorAction Stop).FullName
[void](Assert-Hash $plugin $PinnedPlugin)
Assert-Amd64Pe $plugin
if ((Get-Item -LiteralPath $plugin).VersionInfo.FileVersion -ne '5.15.18.0') {
    throw 'Source plugin does not report Qt 5.15.18.0'
}
$destinationRoot=[IO.Path]::GetFullPath($Destination).TrimEnd('\')
if ($destinationRoot -notmatch '^[a-zA-Z]:\\' -or $destinationRoot.Length -le 3) {
    throw 'Destination must be an absolute non-root Windows drive path'
}
if (Test-Path -LiteralPath $destinationRoot) { throw 'Destination already exists' }
if ($destinationRoot.StartsWith($source+'\', [StringComparison]::OrdinalIgnoreCase) -or
    $source.StartsWith($destinationRoot+'\', [StringComparison]::OrdinalIgnoreCase)) {
    throw 'Source and destination may not contain one another'
}
$receipt=$destinationRoot+'.r10-build-receipt.json'
if (Test-Path -LiteralPath $receipt) { throw 'Existing receipt detected' }
$parent=Split-Path -Parent $destinationRoot
if (-not (Test-Path -LiteralPath $parent -PathType Container)) { throw 'Destination parent must exist' }
$disk=Get-CimInstance Win32_LogicalDisk -Filter ("DeviceID='"+$destinationRoot.Substring(0,2)+"'") -ErrorAction Stop
if ($null -eq $disk -or $disk.DriveType -ne 3 -or $disk.FileSystem -ne 'NTFS') {
    throw 'Destination must be on a fixed local NTFS volume'
}
$ancestor=Get-Item -LiteralPath $parent
while ($null -ne $ancestor) { Assert-NoReparse $ancestor.FullName; $ancestor=$ancestor.Parent }
$manifestPath=Join-Path $source $ManifestName
[void](Assert-Hash $manifestPath $PinnedR9)
$manifest=Get-Content -LiteralPath $manifestPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
if ($null -eq $manifest) { throw 'Empty source manifest' }

# Verify every R9 manifest-listed file and reject unlisted files or reparse points.
$oldIndex=@{}
foreach ($entry in $manifest.PSObject.Properties) {
    $relative=$entry.Name.Replace('/','\')
    if ([IO.Path]::IsPathRooted($relative) -or $relative -match '(^|\\)\.\.(\\|$)') {
        throw ('Unsafe source manifest entry: '+$entry.Name)
    }
    $absolute=[IO.Path]::GetFullPath((Join-Path $source $relative))
    if (-not $absolute.StartsWith($source+'\', [StringComparison]::OrdinalIgnoreCase)) {
        throw ('Source manifest entry escapes root: '+$entry.Name)
    }
    $key=$relative.ToLowerInvariant()
    if ($oldIndex.ContainsKey($key)) { throw ('Duplicate manifest path: '+$relative) }
    $oldIndex.Add($key,$entry.Name)
    [void](Assert-Hash $absolute ([string]$entry.Value))
}
foreach ($item in @(Get-ChildItem -LiteralPath $source -Recurse -Force -ErrorAction Stop)) {
    if (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw ('Source reparse point: '+$item.FullName)
    }
    if ($item.PSIsContainer) { continue }
    $relative=$item.FullName.Substring($source.Length+1).ToLowerInvariant()
    if ($relative -eq $ManifestName.ToLowerInvariant()) { continue }
    if (-not $oldIndex.ContainsKey($relative)) { throw ('Unmanifested R9 file: '+$relative) }
}
if ($oldIndex.ContainsKey($PluginRel.ToLowerInvariant())) {
    throw 'Source already manifests qoffscreen; no repair needed'
}
$catalogKey=$CatalogRel.ToLowerInvariant()
if (-not $oldIndex.ContainsKey($catalogKey)) { throw 'Source GUI catalog is unmanifested' }
$catalog=Get-Content -LiteralPath (Join-Path $source $CatalogRel) -Raw | ConvertFrom-Json
if ($null -eq $catalog -or $null -eq $catalog.Qt -or $null -eq $catalog.Qt.'qwindows.dll') {
    throw 'Unsupported GUI catalog schema; expected Qt/qwindows.dll'
}
if ($catalog.Qt.PSObject.Properties.Name -contains 'qoffscreen.dll') {
    throw 'Source GUI catalog already contains qoffscreen.dll'
}
$qw=$catalog.Qt.'qwindows.dll'
if ([string]$qw.path -ine 'bin/qt-plugins/platforms/qwindows.dll') {
    throw 'Unexpected qwindows catalog path'
}
$qwPath=Join-Path $source 'bin\qt-plugins\platforms\qwindows.dll'
if ((Get-FileHash -LiteralPath $qwPath -Algorithm SHA256).Hash -ine [string]$qw.sha256) {
    throw 'qwindows GUI catalog SHA-256 inconsistent with source'
}
foreach ($relative in @('bin\Qt5Core.dll','bin\Qt5Gui.dll',
    'bin\qt-plugins\platforms\qwindows.dll')) {
    if ((Get-Item -LiteralPath (Join-Path $source $relative)).VersionInfo.FileVersion -ne '5.15.18.0') {
        throw ('Mismatched Qt provider version: '+$relative)
    }
}
$catalog.Qt | Add-Member -MemberType NoteProperty -Name 'qoffscreen.dll' -Value (
    [pscustomobject][ordered]@{path='bin/qt-plugins/platforms/qoffscreen.dll';sha256=$PinnedPlugin}
)
$catalogJson=$catalog | ConvertTo-Json -Depth 50
$utf8=New-Object System.Text.UTF8Encoding($false)
Write-Output ('SourceManifestSHA256: '+$PinnedR9)
Write-Output ('OffscreenSHA256: '+$PinnedPlugin)
Write-Output ('OriginalManifestEntries: '+$oldIndex.Count)
Write-Output ('NewCandidateDestination: '+$destinationRoot)
Write-Output 'Safety: R9 preserved; no GUI, module, service, database or network execution'

if (-not $PSCmdlet.ShouldProcess($destinationRoot,'Create a new verified R10 candidate (no existing files replaced)')) {
    Write-Output 'R10_CANDIDATE_NOT_CREATED'
    return
}

# Copy only the verified manifest-listed R9 files. Partial failures are retained for diagnosis.
New-Item -ItemType Directory -Path $destinationRoot -ErrorAction Stop | Out-Null
foreach ($entry in $manifest.PSObject.Properties) {
    $relative=$entry.Name.Replace('/','\')
    $target=Join-Path $destinationRoot $relative
    $folder=Split-Path -Parent $target
    if (-not (Test-Path -LiteralPath $folder -PathType Container)) {
        New-Item -ItemType Directory -Path $folder -Force -ErrorAction Stop | Out-Null
    }
    Copy-Item -LiteralPath (Join-Path $source $relative) -Destination $target -ErrorAction Stop
    [void](Assert-Hash $target ([string]$entry.Value))
}
$pluginDest=Join-Path $destinationRoot $PluginRel
New-Item -ItemType Directory -Path (Split-Path -Parent $pluginDest) -Force | Out-Null
Copy-Item -LiteralPath $plugin -Destination $pluginDest -ErrorAction Stop
[void](Assert-Hash $pluginDest $PinnedPlugin)
$catalogDest=Join-Path $destinationRoot $CatalogRel
[IO.File]::WriteAllText($catalogDest,($catalogJson+[Environment]::NewLine),$utf8)
$catalogHash=(Get-FileHash -LiteralPath $catalogDest -Algorithm SHA256).Hash

$newEntries=[ordered]@{}
foreach ($entry in $manifest.PSObject.Properties) {
    $key=$entry.Name.Replace('/','\').ToLowerInvariant()
    $value=if ($key -eq $catalogKey) { $catalogHash } else { [string]$entry.Value }
    $newEntries.Add($entry.Name,$value)
}
$newEntries.Add('bin/qt-plugins/platforms/qoffscreen.dll',$PinnedPlugin)
$newManifest=(Join-Path $destinationRoot $ManifestName)
[IO.File]::WriteAllText($newManifest,(([pscustomobject]$newEntries | ConvertTo-Json -Depth 4)+[Environment]::NewLine),$utf8)
$newManifestHash=(Get-FileHash -LiteralPath $newManifest -Algorithm SHA256).Hash

# Independently read back and verify the complete candidate and catalog.
$readback=Get-Content -LiteralPath $newManifest -Raw | ConvertFrom-Json
$verified=@{}
foreach ($entry in $readback.PSObject.Properties) {
    $relative=$entry.Name.Replace('/','\')
    $key=$relative.ToLowerInvariant()
    if ($verified.ContainsKey($key)) { throw ('Duplicate R10 entry: '+$relative) }
    $target=[IO.Path]::GetFullPath((Join-Path $destinationRoot $relative))
    if (-not $target.StartsWith($destinationRoot+'\', [StringComparison]::OrdinalIgnoreCase)) {
        throw ('R10 manifest path escapes root: '+$relative)
    }
    [void](Assert-Hash $target ([string]$entry.Value))
    $verified.Add($key,$true)
}
if ($verified.Count -ne $oldIndex.Count+1) { throw 'Unexpected R10 manifest count' }
$actual=@(Get-ChildItem -LiteralPath $destinationRoot -Recurse -File -Force)
if ($actual.Count -ne $verified.Count+1) { throw 'Unexpected R10 payload count' }
foreach ($item in $actual) {
    Assert-NoReparse $item.FullName
    $relative=$item.FullName.Substring($destinationRoot.Length+1).ToLowerInvariant()
    if ($relative -eq $ManifestName.ToLowerInvariant()) { continue }
    if (-not $verified.ContainsKey($relative)) { throw ('Unmanifested R10 file: '+$relative) }
}
$readCatalog=Get-Content -LiteralPath $catalogDest -Raw | ConvertFrom-Json
if ($readCatalog.Qt.'qoffscreen.dll'.sha256 -ine $PinnedPlugin) {
    throw 'R10 GUI catalog entry mismatch'
}
$receiptData=[ordered]@{
    kind='R10 Qt offscreen recovery candidate; unqualified for runtime'
    utc=[DateTime]::UtcNow.ToString('o')
    old_manifest_sha256=$PinnedR9
    new_manifest_sha256=$newManifestHash
    qoffscreen_sha256=$PinnedPlugin
    verified_files=$verified.Count
    source_directory=$source
    destination_directory=$destinationRoot
    gui_runtime='NOT_RUN'
    scientific_qualification='NOT_RUN'
}
[IO.File]::WriteAllText($receipt,(($receiptData | ConvertTo-Json -Depth 5)+[Environment]::NewLine),$utf8)
Write-Output ('R10_CANDIDATE_CREATED: '+$destinationRoot)
Write-Output ('R10_MANIFEST_SHA256: '+$newManifestHash)
Write-Output ('R10_VERIFIED_FILES: '+$verified.Count)
Write-Output ('BUILD_RECEIPT: '+$receipt)
Write-Output 'R9_UNCHANGED; GUI_NOT_RUN; NOT_RUNTIME_QUALIFIED'
