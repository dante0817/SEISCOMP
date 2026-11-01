<#
Batch 3D-08: prepare a derived SCML 0.14 local event fixture from pinned GFZ QuakeML.
DEFAULT READ ONLY: source/style metadata and XML structure inspection only.
-Convert opts into one new disposable-R10-work file; never runs a GUI or network tool.
XSLT script/document() and external entities/resolvers are disabled, fail closed.
The converter may reject genuine QuakeML if its source stylesheet needs extensions.
#>
[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='High')]
param(
  [Parameter(Mandatory=$true)][string]$Root,
  [Parameter(Mandatory=$true)][string]$WorkspaceRoot,
  [switch]$Convert,
  [string]$ExpectedStylesheetSha256
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
$manifestSha='83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74'
$sourceSha='B81D460B33A6E8A6422742CC7465A2EF85694893F08B3405FF31A74BA32B4EB2'
$sourceBytes=185646
$sourceRelative='data\real-events\gfz2010avtm\event.xml'
$styleRelative='share\xml\0.14\quakeml_1.2__scml_0.14.xsl'
$outputRelative='work\offline-gui-scolv\converted\gfz2010avtm-event-scml014.xml'
$scmlNamespace='http://geofon.gfz.de/ns/seiscomp-schema/0.14'
$xsltNamespace='http://www.w3.org/1999/XSL/Transform'
$rootItem=Get-Item -LiteralPath $Root -ErrorAction Stop
if (-not $rootItem.PSIsContainer) {throw 'Root must be a disposable directory'}
$installRoot=$rootItem.FullName.TrimEnd('\')
if ($installRoot -notmatch '^[A-Za-z]:\\' -or
    [IO.Path]::GetFileName($installRoot) -ine 'SeisComP-Scconfig-Test-R10') {
  throw 'Refusing installation outside disposable R10 test root'
}
$ancestor=$rootItem
while ($null -ne $ancestor) {
  if (($ancestor.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw 'Reparse-point ancestry is not eligible'
  }
  $ancestor=$ancestor.Parent
}
$disk=Get-CimInstance Win32_LogicalDisk -Filter ("DeviceID='"+$installRoot.Substring(0,2)+"'")
if ($null -eq $disk -or $disk.DriveType -ne 3 -or $disk.FileSystem -ne 'NTFS') {
  throw 'Disposable installation must be on local fixed NTFS'
}
if ((Get-FileHash -LiteralPath (Join-Path $installRoot 'SHA256SUMS.json') -Algorithm SHA256 -ErrorAction Stop).Hash -ine
    $manifestSha) {throw 'Unexpected disposable R10 manifest'}
$receipt=Get-Content -LiteralPath ($installRoot+'.install-receipt.json') -Raw -ErrorAction Stop |
  ConvertFrom-Json -ErrorAction Stop
if ([string]$receipt.manifest_sha256 -ine $manifestSha -or
    [string]$receipt.destination -ine $installRoot -or
    [int]$receipt.verified_files -ne 856) {throw 'Unrecognized disposable install receipt'}
$workspace=Get-Item -LiteralPath $WorkspaceRoot -ErrorAction Stop
if (-not $workspace.PSIsContainer) {throw 'WorkspaceRoot is not a directory'}
$workspacePath=$workspace.FullName.TrimEnd('\')
$source=Get-Item -LiteralPath (Join-Path $workspacePath $sourceRelative) -ErrorAction Stop
if ($source.PSIsContainer -or
    ($source.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0 -or
    $source.Length -ne $sourceBytes -or
    (Get-FileHash -LiteralPath $source.FullName -Algorithm SHA256 -ErrorAction Stop).Hash -ine
    $sourceSha) {throw 'GFZ QuakeML source is not pinned event.xml'}
$style=Get-Item -LiteralPath (Join-Path $installRoot $styleRelative) -ErrorAction Stop
if ($style.PSIsContainer -or
    ($style.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0 -or
    $style.Length -le 0 -or $style.Length -gt 2097152) {
  throw 'Invalid stylesheet file, symlink or unbounded size'
}
$styleSha=(Get-FileHash -LiteralPath $style.FullName -Algorithm SHA256 -ErrorAction Stop).Hash
function New-XmlReaderSettings {
  $s=[System.Xml.XmlReaderSettings]::new()
  $s.DtdProcessing=[System.Xml.DtdProcessing]::Prohibit
  $s.XmlResolver=$null
  $s.MaxCharactersInDocument=104857600
  return $s
}
function Inspect-EventXml([string]$path) {
  $r=$null
  $rootName=''
  $rootNs=''
  $count=@{EventParameters=0;event=0;origin=0;pick=0;magnitude=0;arrival=0}
  $origins=@{}
  $picks=@{}
  $preferred=[System.Collections.Generic.List[string]]::new()
  $arrivalPickIds=[System.Collections.Generic.List[string]]::new()
  try {
    $r=[System.Xml.XmlReader]::Create($path,(New-XmlReaderSettings))
    while ($r.Read()) {
      if ($r.NodeType -ne [System.Xml.XmlNodeType]::Element) {continue}
      $name=$r.LocalName
      if ($r.Depth -eq 0) {
        $rootName=$name
        $rootNs=$r.NamespaceURI
      }
      if ($count.ContainsKey($name)) {$count[$name]++}
      if ($name -eq 'origin') {
        $id=$r.GetAttribute('publicID')
        if (-not [string]::IsNullOrWhiteSpace($id)) {$origins[$id]=$true}
      }
      if ($name -eq 'pick') {
        $id=$r.GetAttribute('publicID')
        if (-not [string]::IsNullOrWhiteSpace($id)) {$picks[$id]=$true}
      }
      if ($name -eq 'preferredOriginID') {
        $id=$r.ReadElementContentAsString()
        if (-not [string]::IsNullOrWhiteSpace($id)) {$preferred.Add($id.Trim())}
      }
      if ($name -eq 'pickID') {
        $id=$r.ReadElementContentAsString()
        if (-not [string]::IsNullOrWhiteSpace($id)) {$arrivalPickIds.Add($id.Trim())}
      }
    }
  }
  finally {if ($null -ne $r) {$r.Dispose()}}
  $originMatches=0
  foreach ($id in $preferred) {if ($origins.ContainsKey($id)) {$originMatches++}}
  $pickMatches=0
  foreach ($id in $arrivalPickIds) {if ($picks.ContainsKey($id)) {$pickMatches++}}
  return [pscustomobject]@{
    Root=$rootName;Namespace=$rootNs;
    EventParameters=$count.EventParameters;Events=$count.event;
    Origins=$count.origin;Picks=$count.pick;Magnitudes=$count.magnitude;
    Arrivals=$count.arrival;
    PreferredRefs=$preferred.Count;PreferredMatched=$originMatches;
    ArrivalPickRefs=$arrivalPickIds.Count;ArrivalPickMatched=$pickMatches
  }
}
function Inspect-StylesheetXml([string]$path) {
  $r=$null
  $name=''
  $ns=''
  $imports=0
  $scripts=0
  $documents=0
  try {
    $r=[System.Xml.XmlReader]::Create($path,(New-XmlReaderSettings))
    while ($r.Read()) {
      if ($r.NodeType -ne [System.Xml.XmlNodeType]::Element) {continue}
      if ($r.Depth -eq 0) {$name=$r.LocalName;$ns=$r.NamespaceURI}
      if ($r.NamespaceURI -eq $xsltNamespace -and
          $r.LocalName -in @('include','import')) {$imports++}
      if ($r.LocalName -eq 'script') {$scripts++}
      if ($r.HasAttributes) {
        while ($r.MoveToNextAttribute()) {
          if ($r.Value -match '(?i)\bdocument\s*\(') {$documents++}
        }
        $r.MoveToElement() | Out-Null
      }
    }
  }
  finally {if ($null -ne $r) {$r.Dispose()}}
  return [pscustomobject]@{
    Root=$name;Namespace=$ns;Imports=$imports;
    Scripts=$scripts;DocumentCalls=$documents
  }
}
$in=Inspect-EventXml $source.FullName
$xsl=Inspect-StylesheetXml $style.FullName
if ($in.Root -ne 'quakeml' -or $in.EventParameters -ne 1 -or
    $in.Events -ne 1 -or $in.Origins -ne 1 -or
    $in.Picks -ne 292 -or $in.Magnitudes -ne 6 -or
    $in.PreferredRefs -ne 1 -or $in.PreferredMatched -ne 1) {
  throw 'Pinned source no longer matches reviewed QuakeML event structure'
}
if ($xsl.Root -notin @('stylesheet','transform') -or
    $xsl.Namespace -ne $xsltNamespace) {throw 'Unexpected stylesheet root'}
Write-Output '=== BATCH3D SCOLV QUAKE-TO-SCML PREPARATION ==='
Write-Output ('VerifiedQuakeML: '+$source.FullName)
Write-Output ('QuakeMLSHA256: '+$sourceSha)
Write-Output ('OriginalObjects: events='+$in.Events+' origins='+$in.Origins+
  ' picks='+$in.Picks+' magnitudes='+$in.Magnitudes+
  ' preferredOrigins='+$in.PreferredMatched+'/'+$in.PreferredRefs)
Write-Output ('InstalledStylesheet: '+$style.FullName)
Write-Output ('InstalledStylesheetSHA256: '+$styleSha)
Write-Output ('StylesheetInspection: imports='+$xsl.Imports+' scripts='+$xsl.Scripts+
  ' documentCalls='+$xsl.DocumentCalls)
Write-Output ('ProposedOutput: '+(Join-Path $installRoot $outputRelative))
if (-not $Convert) {
  Write-Output 'BATCH3D_QML_TO_SCML_PREFLIGHT_PASS'
  Write-Output 'PREFLIGHT_ONLY; NO_CONVERSION; NO_FILES_MODIFIED; NO_GUI_OR_NETWORK_EXECUTION'
  return
}
if ([string]::IsNullOrWhiteSpace($ExpectedStylesheetSha256) -or
    $ExpectedStylesheetSha256 -notmatch '^[0-9a-fA-F]{64}$' -or
    $ExpectedStylesheetSha256 -ine $styleSha) {
  throw 'Conversion requires explicit pinned installed XSLT SHA-256'
}
if ($xsl.Imports -ne 0 -or $xsl.Scripts -ne 0 -or $xsl.DocumentCalls -ne 0) {
  throw 'XSLT references external includes/scripts/document(): separate review required'
}
$out=[IO.Path]::GetFullPath((Join-Path $installRoot $outputRelative))
if (-not $out.StartsWith($installRoot+'\work\', [StringComparison]::OrdinalIgnoreCase)) {
  throw 'Conversion target must be inside disposable R10 work'
}
if ((Test-Path -LiteralPath $out) -or (Test-Path -LiteralPath ($out+'.tmp'))) {
  throw 'Output or temporary conversion path already exists; refusing overwrite'
}
if (-not $PSCmdlet.ShouldProcess($out,'Create one local derived test SCML file with offline secure XSLT')) {
  Write-Output 'CONVERSION_NOT_RUN: WhatIf or user declined'
  return
}
$work=Join-Path $installRoot 'work'
$sub=Join-Path $work 'offline-gui-scolv'
$targetDir=[IO.Path]::GetDirectoryName($out)
foreach ($dir in @($work,$sub,$targetDir)) {
  if (Test-Path -LiteralPath $dir) {
    $item=Get-Item -LiteralPath $dir -Force -ErrorAction Stop
    if (-not $item.PSIsContainer -or
        ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
      throw ('Invalid derived-fixture directory: '+$dir)
    }
  }
  else {$null=New-Item -ItemType Directory -Path $dir -ErrorAction Stop}
}
$tmp=$out+'.tmp'
$inputReader=$null
$styleReader=$null
$writer=$null
$createdTmp=$false
try {
  $processor=[System.Xml.Xsl.XslCompiledTransform]::new()
  $styleReader=[System.Xml.XmlReader]::Create($style.FullName,(New-XmlReaderSettings))
  $xsltSettings=[System.Xml.Xsl.XsltSettings]::new($false,$false)
  $processor.Load($styleReader,$xsltSettings,$null)
  $styleReader.Dispose()
  $styleReader=$null
  $inputReader=[System.Xml.XmlReader]::Create($source.FullName,(New-XmlReaderSettings))
  $writerSettings=[System.Xml.XmlWriterSettings]::new()
  $writerSettings.Encoding=[System.Text.UTF8Encoding]::new($false)
  $writerSettings.Indent=$true
  $writerSettings.CloseOutput=$true
  $writer=[System.Xml.XmlWriter]::Create($tmp,$writerSettings)
  $createdTmp=$true
  $processor.Transform($inputReader,$null,$writer,$null)
  $writer.Dispose()
  $writer=$null
  $inputReader.Dispose()
  $inputReader=$null
  $tmpInfo=Get-Item -LiteralPath $tmp -ErrorAction Stop
  if ($tmpInfo.Length -eq 0 -or $tmpInfo.Length -gt 8388608) {
    throw 'Converted test fixture empty or above 8-MiB bound'
  }
  $converted=Inspect-EventXml $tmp
  Write-Output ('ConversionOutputObjects: events='+$converted.Events+
    ' origins='+$converted.Origins+' picks='+$converted.Picks+
    ' magnitudes='+$converted.Magnitudes+
    ' preferredOrigins='+$converted.PreferredMatched+'/'+$converted.PreferredRefs)
  if ($converted.Root -ne 'seiscomp' -or
      $converted.Namespace -ne $scmlNamespace -or
      $converted.EventParameters -ne 1 -or
      $converted.Events -ne 1 -or $converted.Origins -ne 1 -or
      $converted.Picks -ne 292 -or $converted.Magnitudes -ne 6 -or
      $converted.PreferredRefs -ne 1 -or $converted.PreferredMatched -ne 1 -or
      $converted.ArrivalPickMatched -ne $converted.ArrivalPickRefs) {
    throw 'Converted XML object counts/namespace/references not fully preserved; do not use'
  }
  [IO.File]::Move($tmp,$out)
  $createdTmp=$false
  $result=Get-Item -LiteralPath $out -ErrorAction Stop
  Write-Output ('ConvertedSCML: '+$result.FullName)
  Write-Output ('ConvertedSCMLSize: '+$result.Length)
  Write-Output ('ConvertedSCMLSHA256: '+
    (Get-FileHash -LiteralPath $result.FullName -Algorithm SHA256 -ErrorAction Stop).Hash)
  Write-Output 'BATCH3D_GFZ_EVENT_SCML014_CONVERSION_STRUCTURAL_PASS'
  Write-Output 'NO_GUI_EXECUTED; NO_FIREWALL_OR_NETWORK_CHANGE; SCIENTIFIC_FIDELITY_NOT_QUALIFIED'
}
finally {
  if ($null -ne $writer) {$writer.Dispose()}
  if ($null -ne $inputReader) {$inputReader.Dispose()}
  if ($null -ne $styleReader) {$styleReader.Dispose()}
  if ($createdTmp -and (Test-Path -LiteralPath $tmp)) {
    Remove-Item -LiteralPath $tmp -Force -ErrorAction Stop
  }
}
