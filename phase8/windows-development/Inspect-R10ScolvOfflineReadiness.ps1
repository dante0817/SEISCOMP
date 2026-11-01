<#
Batch 3D-01. Read-only scolv native Windows offline-input readiness.
No application launch, firewall modification, network probe or service setup.
Do not equate local XML parse with safe scolv runtime or scientific validation.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$Root,
    [Parameter(Mandatory=$true)][string]$WorkspaceRoot
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'

$expectedManifest='83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74'
$ruleName='SeisComP-R10Test-scolv.exe-OutboundBlock'
$rootItem=Get-Item -LiteralPath $Root -ErrorAction Stop
if (-not $rootItem.PSIsContainer) {throw 'Test root is not a directory'}
$installRoot=$rootItem.FullName.TrimEnd('\')
if ($installRoot -notmatch '^[A-Za-z]:\\' -or
    [IO.Path]::GetFileName($installRoot) -ine 'SeisComP-Scconfig-Test-R10') {
    throw 'Only the disposable R10 test installation is eligible'
}
$ancestor=$rootItem
while ($null -ne $ancestor) {
    if (($ancestor.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw 'Reparse point in installation ancestry'
    }
    $ancestor=$ancestor.Parent
}
$disk=Get-CimInstance Win32_LogicalDisk -Filter ("DeviceID='"+$installRoot.Substring(0,2)+"'")
if ($null -eq $disk -or $disk.DriveType -ne 3 -or $disk.FileSystem -ne 'NTFS') {
    throw 'Test installation must be on fixed local NTFS'
}
$workspace=Get-Item -LiteralPath $WorkspaceRoot -ErrorAction Stop
if (-not $workspace.PSIsContainer) {throw 'WorkspaceRoot must be a directory'}
$workspacePath=$workspace.FullName.TrimEnd('\')
$manifestPath=Join-Path $installRoot 'SHA256SUMS.json'
if ((Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256 -ErrorAction Stop).Hash -ine
    $expectedManifest) {throw 'Manifest identity mismatch'}
$manifest=Get-Content -LiteralPath $manifestPath -Raw -ErrorAction Stop |
    ConvertFrom-Json -ErrorAction Stop
if (@($manifest.PSObject.Properties).Count -ne 856) {throw 'Unexpected manifest entry count'}
$receipt=Get-Content -LiteralPath ($installRoot+'.install-receipt.json') -Raw -ErrorAction Stop |
    ConvertFrom-Json -ErrorAction Stop
if ([string]$receipt.manifest_sha256 -ine $expectedManifest -or
    [string]$receipt.destination -ine $installRoot -or
    [int]$receipt.verified_files -ne 856) {throw 'Disposable R10 receipt mismatch'}
function Assert-PinnedFile([string]$relative) {
    $entries=@($manifest.PSObject.Properties |
        Where-Object {$_.Name.Replace('/','\') -ieq $relative})
    if ($entries.Count -ne 1) {throw ('Missing manifest entry: '+$relative)}
    $path=[IO.Path]::GetFullPath((Join-Path $installRoot $relative))
    if (-not $path.StartsWith($installRoot+'\', [StringComparison]::OrdinalIgnoreCase)) {
        throw 'Manifest path escaped the R10 installation'
    }
    $item=Get-Item -LiteralPath $path -ErrorAction Stop
    if ($item.PSIsContainer -or
        ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw ('Invalid packaged runtime file: '+$relative)
    }
    if ((Get-FileHash -LiteralPath $path -Algorithm SHA256 -ErrorAction Stop).Hash -ine
        [string]$entries[0].Value) {throw ('Runtime file hash mismatch: '+$relative)}
    return $item.FullName
}
$exe=Assert-PinnedFile 'bin\scolv.exe'
$null=Assert-PinnedFile 'bin\qt.conf'
$null=Assert-PinnedFile 'bin\qt-plugins\platforms\qwindows.dll'
$null=Assert-PinnedFile 'share\windows\Use-DevelopmentEnvironment.ps1'
$descriptions=Join-Path $installRoot 'etc\descriptions'
$xmlCount=@(Get-ChildItem -LiteralPath $descriptions -File -Filter '*.xml' -ErrorAction Stop).Count

function Inspect-Scml([string]$fileName) {
    $relatives=@(
        ('data\phase5b6\gfz2010avtm\inputs\'+$fileName),
        ('phase8\data\phase5b6\gfz2010avtm\inputs\'+$fileName)
    )
    $found=@()
    foreach ($relative in $relatives) {
        $path=Join-Path $workspacePath $relative
        if (Test-Path -LiteralPath $path -PathType Leaf) {$found+= $path}
    }
    if ($found.Count -eq 0) {
        Write-Output ($fileName+': NOT_FOUND_IN_KNOWN_LOCATIONS')
        return
    }
    foreach ($path in $found) {
        $info=Get-Item -LiteralPath $path -ErrorAction Stop
        if (($info.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
            Write-Output ($fileName+': REPARSE_POINT_REFUSED: '+$path)
            continue
        }
        if ($info.Length -le 0 -or $info.Length -gt 52428800) {
            Write-Output ($fileName+': EMPTY_OR_OVER_50MB_UNREVIEWED: '+$path)
            continue
        }
        $hash=(Get-FileHash -LiteralPath $info.FullName -Algorithm SHA256 -ErrorAction Stop).Hash
        $settings=[System.Xml.XmlReaderSettings]::new()
        $settings.DtdProcessing=[System.Xml.DtdProcessing]::Prohibit
        $settings.XmlResolver=$null
        $settings.MaxCharactersInDocument=104857600
        $reader=$null
        $rootElement=$null
        try {
            $reader=[System.Xml.XmlReader]::Create($info.FullName,$settings)
            while ($reader.Read()) {
                if ($null -eq $rootElement -and
                    $reader.NodeType -eq [System.Xml.XmlNodeType]::Element) {
                    $rootElement=$reader.LocalName
                }
            }
            $state='XML_WELL_FORMED'
            if ($rootElement -ne 'seiscomp') {$state='XML_WELL_FORMED_UNEXPECTED_ROOT'}
            Write-Output ($fileName+': '+$state)
        }
        catch {
            Write-Output ($fileName+': XML_PARSE_FAILED: '+$_.Exception.Message)
        }
        finally {
            if ($null -ne $reader) {$reader.Dispose()}
        }
        Write-Output ($fileName+' Path: '+$info.FullName)
        Write-Output ($fileName+' SizeBytes: '+$info.Length)
        Write-Output ($fileName+' SHA256: '+$hash)
    }
}
Write-Output '=== BATCH3D SCOLV OFFLINE INPUT READINESS ==='
Write-Output ('VerifiedExecutable: '+$exe)
Write-Output ('Manifest: '+$expectedManifest)
Write-Output 'DisposableReceiptAndQtRuntimeFiles: VERIFIED'
Write-Output ('DescriptionXMLCount: '+$xmlCount)
Inspect-Scml 'inventory-expanded.xml'
Inspect-Scml 'config-expanded.xml'
$profiles=@(Get-NetFirewallProfile -PolicyStore ActiveStore -ErrorAction Stop)
if ($profiles.Count -eq 3 -and
    @($profiles | Where-Object {$_.Enabled -ne 'True'}).Count -eq 0) {
    Write-Output 'FIREWALL_PROFILES_ENABLED'
}
else {
    Write-Output 'FIREWALL_PROFILES_NOT_ALL_ENABLED'
}
$rules=@(Get-NetFirewallRule -PolicyStore ActiveStore -Name $ruleName -ErrorAction SilentlyContinue)
if ($rules.Count -eq 0) {
    Write-Output 'SCOLV_OUTBOUND_BLOCK_RULE_MISSING'
}
elseif ($rules.Count -ne 1) {
    Write-Output 'SCOLV_OUTBOUND_BLOCK_RULE_AMBIGUOUS'
}
else {
    $r=$rules[0]
    $app=@($r | Get-NetFirewallApplicationFilter -ErrorAction Stop)
    $ports=@($r | Get-NetFirewallPortFilter -ErrorAction Stop)
    $addresses=@($r | Get-NetFirewallAddressFilter -ErrorAction Stop)
    $services=@($r | Get-NetFirewallServiceFilter -ErrorAction Stop)
    if ($r.Enabled -eq 'True' -and $r.Direction -eq 'Outbound' -and
        $r.Action -eq 'Block' -and [string]$r.Profile -eq 'Any' -and
        $app.Count -eq 1 -and [string]$app[0].Program -ieq $exe -and
        $ports.Count -eq 1 -and [string]$ports[0].Protocol -eq 'Any' -and
        [string]$ports[0].LocalPort -eq 'Any' -and
        [string]$ports[0].RemotePort -eq 'Any' -and
        $addresses.Count -eq 1 -and [string]$addresses[0].LocalAddress -eq 'Any' -and
        [string]$addresses[0].RemoteAddress -eq 'Any' -and
        $services.Count -eq 1 -and [string]$services[0].Service -eq 'Any') {
        Write-Output 'SCOLV_OUTBOUND_BLOCK_RULE_SCOPE_MATCH'
    }
    else {
        Write-Output 'SCOLV_OUTBOUND_BLOCK_RULE_SCOPE_MISMATCH'
    }
}
Write-Output 'SCOLV_OFFLINE_EVENT_INPUT: NOT_SELECTED'
Write-Output 'SCOLV_GUI: NOT_RUN; NEW_RUNTIME_AUTHORIZATION_REQUIRED'
Write-Output 'BATCH3D_READ_ONLY_INSPECTION_COMPLETE'
Write-Output 'NO_GUI_EXECUTED; NO_FIREWALL_CHANGE; NO_NETWORK_PROBE'
Write-Output 'ACTIVE_RULE_MATCH_WOULD_NOT_PROVE_TRAFFIC_EGRESS_OR_HELPER_CONTAINMENT'
