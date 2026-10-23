<# Per-user copy installation only. No executable, controller, service or dependency installer is started. #>
[CmdletBinding(SupportsShouldProcess=$true)]
param(
    [Parameter(Mandatory=$true)][string]$Source,
    [Parameter(Mandatory=$true)][ValidatePattern('^[A-Fa-f0-9]{64}$')][string]$ExpectedManifestSha256,
    [Parameter(Mandatory=$true)][string]$Destination
)
$ErrorActionPreference='Stop'
$sourceRoot=(Get-Item -LiteralPath $Source).FullName.TrimEnd('\')
if (-not (Test-Path -LiteralPath $sourceRoot -PathType Container)) { throw 'Source must be a candidate directory' }
if ($Destination -notmatch '^[A-Za-z]:\\') { throw 'Destination must be an absolute Windows drive path' }
$destinationRoot=[IO.Path]::GetFullPath($Destination).TrimEnd('\')
if ($destinationRoot.Length -le 3 -or (Test-Path -LiteralPath $destinationRoot)) { throw 'Destination must be a new non-root directory' }
if ($destinationRoot.StartsWith($sourceRoot+'\',[StringComparison]::OrdinalIgnoreCase)) { throw 'Destination cannot be inside the candidate' }
$parent=Split-Path -Parent $destinationRoot
if (-not (Test-Path -LiteralPath $parent -PathType Container)) { throw 'Destination parent must already exist' }
$drive=$destinationRoot.Substring(0,2)
$disk=Get-CimInstance Win32_LogicalDisk -Filter ("DeviceID='"+$drive+"'")
if ($null -eq $disk -or $disk.DriveType -ne 3 -or $disk.FileSystem -ne 'NTFS') { throw 'Destination must be a local fixed NTFS volume' }
foreach ($item in @((Get-Item -LiteralPath $sourceRoot)) + @(Get-ChildItem -LiteralPath $sourceRoot -Recurse -Force)) {
    if (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) { throw ('Source reparse point rejected: '+$item.FullName) }
}
# Check existing destination ancestors without changing their ACLs or system settings.
$ancestor=Get-Item -LiteralPath $parent
while ($null -ne $ancestor) {
    if (($ancestor.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) { throw ('Destination ancestor reparse point rejected: '+$ancestor.FullName) }
    $ancestor=$ancestor.Parent
}
$manifestPath=Join-Path $sourceRoot 'SHA256SUMS.json'
$manifestHash=(Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256).Hash
if ($manifestHash -ne $ExpectedManifestSha256) { throw 'Candidate manifest differs from the supplied external identity' }
$manifest=Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
$files=@($manifest.PSObject.Properties)
$relativePaths=@{}
foreach ($file in $files) {
    $relative=$file.Name.Replace('/','\')
    if ([IO.Path]::IsPathRooted($relative)) { throw ('Rooted manifest entry: '+$relative) }
    $absolute=[IO.Path]::GetFullPath((Join-Path $sourceRoot $relative))
    if (-not $absolute.StartsWith($sourceRoot+'\',[StringComparison]::OrdinalIgnoreCase)) { throw ('Manifest path escapes candidate: '+$relative) }
    if ($relativePaths.ContainsKey($relative.ToLowerInvariant())) { throw ('Duplicate manifest path: '+$relative) }
    $relativePaths[$relative.ToLowerInvariant()]=$true
    if ((Get-FileHash -LiteralPath $absolute -Algorithm SHA256).Hash -ne $file.Value) { throw ('Source hash differs: '+$relative) }
}
$actual=@(Get-ChildItem -LiteralPath $sourceRoot -Recurse -File -Force | Where-Object { $_.FullName -ne $manifestPath })
if ($actual.Count -ne $files.Count) { throw 'Candidate contains missing or unmanifested files' }
foreach ($file in $actual) {
    $relative=$file.FullName.Substring($sourceRoot.Length+1).ToLowerInvariant()
    if (-not $relativePaths.ContainsKey($relative)) { throw ('Unmanifested file: '+$relative) }
}
$receiptPath=$destinationRoot+'.install-receipt.json'
if (Test-Path -LiteralPath $receiptPath) { throw 'Installation receipt already exists' }
if ($PSCmdlet.ShouldProcess($destinationRoot,('Copy '+$files.Count+' verified candidate files; no application launch'))) {
    New-Item -ItemType Directory -Path $destinationRoot -ErrorAction Stop | Out-Null
    foreach ($file in $files) {
        $relative=$file.Name.Replace('/','\')
        $destinationFile=Join-Path $destinationRoot $relative
        $directory=Split-Path -Parent $destinationFile
        if (-not (Test-Path -LiteralPath $directory)) { New-Item -ItemType Directory -Path $directory | Out-Null }
        Copy-Item -LiteralPath (Join-Path $sourceRoot $relative) -Destination $destinationFile -ErrorAction Stop
        if ((Get-FileHash -LiteralPath $destinationFile -Algorithm SHA256).Hash -ne $file.Value) { throw ('Installed hash differs: '+$relative) }
    }
    Copy-Item -LiteralPath $manifestPath -Destination (Join-Path $destinationRoot 'SHA256SUMS.json')
    if ((Get-FileHash -LiteralPath (Join-Path $destinationRoot 'SHA256SUMS.json') -Algorithm SHA256).Hash -ne $manifestHash) { throw 'Installed manifest differs' }
    [ordered]@{utc=[DateTime]::UtcNow.ToString('o');source=$sourceRoot;destination=$destinationRoot;manifest_sha256=$manifestHash;
        verified_files=$files.Count;application_execution='NOT_RUN';kind='development copy; no runtime or release qualification'} |
        ConvertTo-Json | Set-Content -LiteralPath $receiptPath -Encoding utf8
    Write-Output ('Verified development copy: '+$destinationRoot)
} else {
    Write-Output ('Prepared copy plan: '+$files.Count+' files; destination unchanged: '+$destinationRoot)
}
