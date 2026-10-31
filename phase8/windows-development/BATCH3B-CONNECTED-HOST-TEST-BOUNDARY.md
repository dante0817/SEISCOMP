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

## Operator firewall rule inspection result

2026-10-31: Operator queried ActiveStore outbound, enabled, Block firewall application filters. Results: `scconfig.exe: 0 matching outbound block rule(s)`; `seiscomp.exe: 0 matching outbound block rule(s)`. Read-only firewall inspection completed; no change made.

Combined with earlier `DefaultOutboundAction=Allow` for all active profiles, **the disposable test executables are NOT known to be egress-blocked**. Do not interpret this as safe to run the GUI on the connected workstation, and do not use the original isolated-launch attestation falsely.

Next authorized action: host owner/IT review and approval for narrowly scoped outbound rules on only the disposable test binaries, with verification that local firewall rules are merged into policy (a domain-managed host may ignore local rules). Application-only block rules cannot guarantee containment of unknown child executables. If approval or effective enforcement cannot be established, continue source-level implementation and defer runtime GUI launch. Normal workstation internet remains on throughout.

## Operator result: firewall creation denied

2026-10-31: After reading zero matching active outbound block rules, operator attempted the **proposed** two test-executable firewall rules. The first `New-NetFirewallRule` call returned `Access is denied` / Windows System Error 5. The script was configured with `$ErrorActionPreference = 'Stop'` and terminated before its `RULE CREATED` message. Earlier elevated status was `False`. **This attempt did not establish the required rules**; permissions are the leading explanation, but managed policy restrictions cannot be excluded.

Never represent firewall containment as active or approve the existing guarded `Start-DevelopmentGui.ps1 -Run` mode by falsely setting its isolation flags. Do not retry with firewall disabled, an altered global policy, UAC bypass or host-wide internet disconnection. Independently verify whether any partial test rule exists read-only, and ask an authorized host IT/admin operator for path-exact two-program outbound blocking if connected-host runtime is approved.

If administrator authorization is unavailable, continue **development-first source and static integration** in `phase8/native-working-copy`/GitHub, including Qt and first-run wizard safety work, without launching uncontained SeisComP on the office-connected network. The user prefers keeping the network active and no Windows Sandbox, and those constraints remain respected.

Status: `OUTBOUND_RULE_CREATE_ACCESS_DENIED / EFFECTIVE_APP_EGRESS_NOT_PROVEN / GUI_RUNTIME_NOT_RUN`.

## Operator follow-up: administrative shell now elevated

2026-10-31 user opened another PowerShell session and explicitly checked the current Windows principal's Administrator role: `PowerShell elevated: True`. This supersedes the previous **shell privilege observation**, but it does not establish that host/organizational policy permits firewall changes, that either active rule exists, or that isolation is effective. Neither firewall-rule creation nor SeisComP execution was shown in the latest output.

Next: run the scoped two-executable outbound rule creation under authorized workstation policy, using the **exact** original user's disposable root rather than an administrator account's possibly different `%LOCALAPPDATA%`. Validate source manifest and executable checksums; fail on pre-existing conflicting rules; verify ActiveStore exact program paths/profiles/direction/action after creation. A persistent rule may fail to merge into ActiveStore under corporate policy. Preserve evidence and do not mark GUI runtime as tested.