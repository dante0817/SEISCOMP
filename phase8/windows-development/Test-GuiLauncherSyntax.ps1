<# Parser-only test on Windows PowerShell; does NOT execute the launcher. #>
[CmdletBinding()]
param([string]$ScriptPath=(Join-Path $PSScriptRoot 'Start-DevelopmentGui.ps1'))
$ErrorActionPreference='Stop'
if (-not (Test-Path -LiteralPath $ScriptPath -PathType Leaf)) { throw 'Launcher source missing' }
$tokens=$null
$parseErrors=$null
$ast=[System.Management.Automation.Language.Parser]::ParseFile($ScriptPath,[ref]$tokens,[ref]$parseErrors)
if ($null -eq $ast -or $parseErrors.Count -gt 0) {
    foreach ($entry in $parseErrors) { Write-Error $entry.Message }
    throw 'GUI launcher PowerShell syntax FAILED'
}
$source=Get-Content -LiteralPath $ScriptPath -Raw
if ($source -match '(?i)foreach\s*\(\s*\$home\s+in\b') {
    throw 'FAIL: launcher uses reserved read-only $HOME as a foreach variable'
}
Write-Output ('PASS: PowerShell parser and HOME-variable guard accepted '+$ScriptPath+' (no application executed)')
