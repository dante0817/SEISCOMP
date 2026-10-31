# SeisComP Batch 3B: Connected-host GUI test boundary

**Status: proposed / NOT applied / GUI NOT RUN (2026-10-31).**

Operator requirement: leave Windows Sandbox unused and the workstation's ordinary internet connection online. R9 and the receipt-verified R10 development installation remain unchanged. Only the disposable `%LOCALAPPDATA%\SeisComP-Scconfig-Test-R10` is eligible for local GUI qualification.

## Observed baseline (operator, Windows PowerShell)

- Disposable `bin\scconfig.exe`: present.
- Disposable `bin\seiscomp.exe`: present.
- Domain, Private and Public Windows Firewall profiles: **enabled**.
- DefaultOutboundAction: **Allow** for all three profiles.
- Shell elevated: **False**.
- No firewall setting was changed and no SeisComP GUI or service was executed.

The default outbound policy does not answer whether existing program-specific rules are effective. Additional inspection is required. An enabled firewall is not equivalent to application egress containment.

## Proposed narrow controls (requires organization/host approval)

Before any connected-host launch, a host-authorized administrator/IT operator should approve, create, and verify outbound **block** rules bound to the *exact absolute paths* of the two disposable test executables, for every profile and all protocols/remote addresses:

- `%LOCALAPPDATA%\SeisComP-Scconfig-Test-R10\bin\scconfig.exe`
- `%LOCALAPPDATA%\SeisComP-Scconfig-Test-R10\bin\seiscomp.exe`

Suggested rule names are `SeisComP-R10Test-scconfig-OutboundBlock` and `SeisComP-R10Test-seiscomp-OutboundBlock`. Never use wildcard/global block rules, disable a firewall profile, change the machine's default outbound policy, disconnect the NIC, elevate to bypass policy, or overwrite another administrator's existing rules. **Do not run the creation commands without explicit workstation/organizational approval.**

Microsoft supports a program-scoped outbound block rule with `-Program`, `-Direction Outbound`, `-Action Block`, `-Profile Any`, `-PolicyStore PersistentStore`. New rules may be suppressed by organizational policy or an ineffective active-rule merge, and may require administrator privileges.

A read-only active-store inspection must be followed by a genuine *authorized* effectiveness test. Merely finding the rule is insufficient. The rules do not confine arbitrary helper processes, external browsers or inherited credentials: review actual child-process pathways and choose **No** at the initial setup question. The known original `WizardWidget::finish()` would run `<root>/bin/seiscomp --stdin setup`; do not use it in the first GUI smoke test. When no independently verified app egress protection can be established, do not claim that the connected workstation is isolated.

## First qualified GUI session (not authorized by this document)

1. Confirm test-copy receipt and immutable manifest hash `83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74` still match; review active user/profile overrides and test settings; make sure no production controllers/services are targeted.
2. Confirm the approved test-copy path, no unreviewed helper auto-start, and operator's separate runtime authorization reference. The old `Start-DevelopmentGui.ps1` requires proof of isolation; **do not misrepresent connected-host application-only blocking as a fully isolated session** or fabricate its `-IsolatedProfileReviewed` flag.
3. Arrange a purpose-built, guarded **connected-host** one-application launch procedure only after app-level egress controls are independently verified and allowed by local policy. A run must not automatically invoke configuration/setup.
4. Capture visual startup, 131 description-file load outcome, expected first-start prompt, Qt platform plugin diagnostics, child process evidence, and close behavior. Select **No** at the first-start question. The original code will attempt to create `var/run/seiscomp.init` **before** that prompt; this must be written only to the disposable test copy.
5. Preserve logs and restore only specifically authorized, uniquely named test firewall rules after the test; do not alter other security settings. A pass qualifies that bounded startup only, not full scientific correctness or operational safety.

## Next operator action

Use the existing read-only `Test-R10ScconfigConnectedHost.ps1` or inspect ActiveStore application filters to discover existing exact-path outbound block rules and whether local firewall rule modification is permitted. No elevated modification or GUI execution is implied.

References:

- Microsoft: https://learn.microsoft.com/en-us/windows/security/operating-system-security/network-security/windows-firewall/configure
- New-NetFirewallRule: https://learn.microsoft.com/en-us/powershell/module/netsecurity/new-netfirewallrule
