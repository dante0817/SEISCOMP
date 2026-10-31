<#
Phase 8 Batch 3B - READ ONLY ActiveStore firewall policy admission.
No firewall changes; no GUI launch; no networking probes. Prints a conservative
policy-scope result, NOT a guarantee that all network egress is contained.
Use only with the previously approved and separately installed disposable R10.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$Root
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'

$item=Get-Item -LiteralPath $Root -ErrorAction Stop
if (-not $item.PSIsContainer) { throw 'Selected test root is not a directory' }
$rootPath=$item.FullName.TrimEnd('\')
if ($rootPath -notmatch '^[A-Za-z]:\\') { throw 'Expected absolute local Windows drive path' }
if ([IO.Path]::GetFileName($rootPath) -ine 'SeisComP-Scconfig-Test-R10') {
    throw 'Refusing a non-disposable R10 root'
}
if (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw 'Test root is a reparse point'
}
$expected='83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74'
$manifest=Join-Path $rootPath 'SHA256SUMS.json'
if ((Get-FileHash -LiteralPath $manifest -Algorithm SHA256 -ErrorAction Stop).Hash -ine $expected) {
    throw 'R10 manifest hash mismatch'
}

$profiles=@(Get-NetFirewallProfile -PolicyStore ActiveStore -ErrorAction Stop)
if ($profiles.Count -ne 3 -or @($profiles | Where-Object {$_.Enabled -ne 'True'}).Count -gt 0) {
    throw 'Not all three active firewall profiles are enabled'
}

$targetNames=@('scconfig.exe','seiscomp.exe')
foreach ($name in $targetNames) {
    $exe=Join-Path $rootPath ('bin\'+$name)
    if (-not (Test-Path -LiteralPath $exe -PathType Leaf)) {
        throw ('Required disposable executable missing: '+$name)
    }
    $ruleName='SeisComP-R10Test-'+$name+'-OutboundBlock'
    $rules=@(Get-NetFirewallRule -Name $ruleName -PolicyStore ActiveStore -ErrorAction SilentlyContinue)
    if ($rules.Count -ne 1) {
        throw ('ACTIVE_BLOCK_RULE_ABSENT_OR_AMBIGUOUS: '+$name+' count='+$rules.Count)
    }
    $rule=$rules[0]
    if ($rule.Action -ne 'Block' -or $rule.Direction -ne 'Outbound' -or
        $rule.Enabled -ne 'True' -or [string]$rule.Profile -ne 'Any') {
        throw ('ACTIVE_BLOCK_RULE_SCOPE_WRONG: '+$name)
    }
    $appFilters=@($rule | Get-NetFirewallApplicationFilter -ErrorAction Stop)
    if ($appFilters.Count -ne 1 -or
        [string]$appFilters[0].Program -ine $exe) {
        throw ('ACTIVE_BLOCK_PROGRAM_PATH_WRONG: '+$name)
    }
    $portFilters=@($rule | Get-NetFirewallPortFilter -ErrorAction Stop)
    if ($portFilters.Count -ne 1 -or
        [string]$portFilters[0].Protocol -ne 'Any' -or
        [string]$portFilters[0].LocalPort -ne 'Any' -or
        [string]$portFilters[0].RemotePort -ne 'Any') {
        throw ('ACTIVE_BLOCK_PORT_SCOPE_WRONG: '+$name)
    }
    $addressFilters=@($rule | Get-NetFirewallAddressFilter -ErrorAction Stop)
    if ($addressFilters.Count -ne 1 -or
        [string]$addressFilters[0].RemoteAddress -ne 'Any' -or
        [string]$addressFilters[0].LocalAddress -ne 'Any') {
        throw ('ACTIVE_BLOCK_ADDRESS_SCOPE_WRONG: '+$name)
    }
    $serviceFilters=@($rule | Get-NetFirewallServiceFilter -ErrorAction Stop)
    if ($serviceFilters.Count -ne 1 -or
        [string]$serviceFilters[0].Service -ne 'Any') {
        throw ('ACTIVE_BLOCK_SERVICE_SCOPE_WRONG: '+$name)
    }
    Write-Output ('ACTIVE_FIREWALL_POLICY_MATCH: '+$name)
}
Write-Output 'BATCH3B_ACTIVE_FIREWALL_SCOPE_PASS'
Write-Output 'NO_NETWORK_EGRESS_TESTED; HELPERS_NOT_COVERED; NOT_ISOLATED'
Write-Output 'NO_GUI_EXECUTED; NO_FIREWALL_CONFIGURATION_CHANGED'
