<#
Phase 8 Batch 3B - read-only native scconfig C++ startup source inspection.
The active editable sources and pinned reference snapshots are local to the
operator's Windows workstation. This script ONLY reads files; no CMake, builds,
executables, configuration helpers, services, GUI, network or source changes.
Place this script in the engineering-tools folder OUTSIDE the source tree.
Windows PowerShell 5.1+; no WSL required.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$Phase8Root,
    [ValidateRange(1,25)][int]$MaxMatchesPerFile = 14
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$root = (Get-Item -LiteralPath $Phase8Root -ErrorAction Stop).FullName.TrimEnd('\')
if (-not (Test-Path -LiteralPath $root -PathType Container)) { throw 'Phase 8 root must be an existing directory' }
$native = Join-Path $root 'native-working-copy\src\base\common\apps\tools\scconfig'
$snapshot = Join-Path $root 'source-snapshot\common\apps\tools\scconfig'

function Assert-Source([string]$Relative, [string]$ExpectedSha256, [string]$RootPath) {
    $full = Join-Path $RootPath $Relative
    if (-not (Test-Path -LiteralPath $full -PathType Leaf)) { throw ('Source file missing: '+$full) }
    if (((Get-Item -LiteralPath $full -Force).Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw ('Source reparse point refused: '+$full)
    }
    $actual = (Get-FileHash -LiteralPath $full -Algorithm SHA256 -ErrorAction Stop).Hash
    if ($actual -ine $ExpectedSha256) {
        throw ('Source identity mismatch: '+$full+' SHA256='+$actual)
    }
    return $full
}

$mainSha='B60C6478E0721CDCA0A6776CC37C29278E6D85BAFC3DF16D4EBE9C87FADCECDD'
$nativeCmakeSha='B17CDA78A808DF738E6D15AE0656B3D09041FAF26A23417635337077EA918EC9'
$snapshotCmakeSha='292DB70804A1AA1FF79BC4F35908DFD446B2A767FFE4437900C7CF947F24F57A'
$null = Assert-Source 'main.cpp' $mainSha $native
$null = Assert-Source 'main.cpp' $mainSha $snapshot
$nativeCmake = Assert-Source 'CMakeLists.txt' $nativeCmakeSha $native
$null = Assert-Source 'CMakeLists.txt' $snapshotCmakeSha $snapshot

Write-Output '=== BATCH 3B SCCONFIG NATIVE C++ SOURCE INSPECTION ==='
Write-Output 'NativeMainSourceSHA256: VERIFIED'
Write-Output 'SnapshotMainSourceSHA256: VERIFIED'
Write-Output 'NativeWindowsCMakeSHA256: VERIFIED'
Write-Output 'SnapshotCMakeSHA256: VERIFIED'
Write-Output 'CMakeDiffersFromSnapshot: True'
Write-Output 'SourceOnly: no GUI, service, build, database or network executed'

$cmakeText=Get-Content -LiteralPath $nativeCmake -Raw -ErrorAction Stop
$winGuard = [bool]($cmakeText -match '(?i)IF\s*\(\s*NOT\s+WIN32\s*\).*flowlayout\.cpp' -or
    ($cmakeText -match '(?i)IF\s*\(\s*NOT\s+WIN32\s*\)' -and
     $cmakeText -match '(?i)LIST\s*\(\s*APPEND\s+SCCONFIG_SOURCES.*flowlayout\.cpp'))
$qtLink = [bool]($cmakeText -match '(?i)SC_LINK_LIBRARIES_INTERNAL\s*\(\s*\$\{SCCONFIG_TARGET\}\s+qt\s*\)')
Write-Output ('CMAKE_Win32FlowLayoutOwnershipGuardPresent: '+$winGuard)
Write-Output ('CMAKE_InternalQtLinkPresent: '+$qtLink)
if (-not $winGuard -or -not $qtLink) {
    throw 'Native scconfig CMake guard/link not detected; preserve files and inspect'
}

$specs=@(
    [pscustomobject]@{
        Name='main.cpp'
        Pattern='(?i)QApplication|QCoreApplication|QGuiApplication|SEISCOMP_ROOT|seiscomp\.init|wizard|setup|init|QProcess|QSettings|config'
    },
    [pscustomobject]@{
        Name='wizard.cpp'
        Pattern='(?i)seiscomp\.init|wizard|setup|configure|module|database|process|init|root'
    },
    [pscustomobject]@{
        Name='configurator.cpp'
        Pattern='(?i)SEISCOMP_ROOT|seiscomp\.init|QProcess|QSettings|QFile|config|module'
    },
    [pscustomobject]@{
        Name='gui.h'
        Pattern='(?i)QApplication|QMainWindow|setup|wizard|config|process|signal'
    },
    [pscustomobject]@{
        Name='http.cpp'
        Pattern='(?i)QNetwork|QHttp|QUrl|http|https|request|connect|download'
    },
    [pscustomobject]@{
        Name='CMakeLists.txt'
        Pattern='(?i)flowlayout|WIN32|SC_LINK_LIBRARIES_INTERNAL|Qt5::|SC_ADD_EXECUTABLE'
    }
)
foreach ($spec in $specs) {
    $file=Join-Path $native $spec.Name
    if (-not (Test-Path -LiteralPath $file -PathType Leaf)) {
        throw ('Native source file missing: '+$spec.Name)
    }
    if (((Get-Item -LiteralPath $file).Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw ('Native source reparse point: '+$spec.Name)
    }
    $digest=(Get-FileHash -LiteralPath $file -Algorithm SHA256 -ErrorAction Stop).Hash
    $hits=@(Select-String -LiteralPath $file -Pattern $spec.Pattern -ErrorAction Stop |
        Select-Object -First $MaxMatchesPerFile)
    Write-Output ('SOURCE_FILE: '+$spec.Name+' SHA256='+$digest+' SampleHits='+$hits.Count)
    foreach ($hit in $hits) {
        $line=$hit.Line.Trim()
        if ($line.Length -gt 180) { $line=$line.Substring(0,180)+' [truncated]' }
        Write-Output ('  L'+$hit.LineNumber+': '+$line)
    }
}
Write-Output 'BATCH3B_NATIVE_SOURCE_INSPECTION_COMPLETE'
Write-Output 'NO_SOURCE_EDIT; NO_BUILD; NO_GUI_EXECUTED; NO_NETWORK_ISOLATION_CLAIM'
