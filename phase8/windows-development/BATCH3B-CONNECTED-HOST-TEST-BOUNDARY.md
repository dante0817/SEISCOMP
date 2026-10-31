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

## Source implementation: guarded connected-host scconfig preflight and launcher

2026-10-31: Added two ASCII PowerShell source files in the Batch 3 branch, without running or modifying the host:

| File | Externally pinned SHA-256 | Function |
|---|---|---|
| `Confirm-R10ScconfigFirewallRules.ps1` | `96DAF89864C55CE3973FED6B3F4F35F6DD9D7022F5EFCA716041CDC56BF61561` | Read-only ActiveStore exact-name program-specific deny rule inspection for both disposable `scconfig.exe` and `seiscomp.exe`. Requires 3 enabled firewall profiles, enabled outbound block action, Any profile/protocol/addresses/ports and matching exact binary paths. Fails closed on missing/ambiguous rules. Not a traffic-level containment test. |
| `Start-R10ScconfigConnectedHost.ps1` | `5843C9DFBCE96D21D44279757FCE071C03C10739D71925E587508038D5B33511` | New purpose-built test-copy-only launcher; default **preflight only**, pins the firewall checker SHA and R10 manifest/receipt and the original GUI/Qt files; reports 131-description preflight count if the local copy matches. Existing isolation-gated launcher remains untouched. |

**No execution was performed.** The scripts were authored as ASCII and independently read back from GitHub with exact SHA-256 verification. Windows PowerShell parser and runtime are NOT_RUN. The firewall-creation command was supplied to the operator in an elevated session, but the operator has not posted creation results; therefore the new verifier will correctly fail if active rules are missing.

The new launcher allows `-Run` only with a nonempty authorization reference, `-ConnectedHostRiskApproved`, `-UserConfigurationReviewed`, `-EgressEffectivenessReviewed`, a non-elevated shell, an existing evidence directory outside the test root, no detected inherited SeisComP/Qt overrides, and an exact-match active firewall policy. The flags are operator attestations, **not independent proof**. It dot-sources the manifest-pinned original process-local environment helper only after those checks, starts only `scconfig.exe` without GUI arguments, enables Qt plugin diagnostics and captures stdout/stderr. The first-run prompt must be answered **No**, and module/setup actions must not be used. The helper's runtime work directories and marker may be created **only in the disposable test root**. The script does not grant runtime authorization and cannot contain arbitrary child executables or prove full network isolation.

Operator instructions: download and verify both .ps1 source files in the Y: engineering folder; Windows execution policy/trust review must be followed (no global bypass). Before any `-Run`, verify actual creation and *effective* enforcement of firewall rules, approve the limited connected-host test, and check exact user config state. Run preflight without `-Run` first, then use the separately authorized invocation if appropriate. If the rules do not appear in ActiveStore, return to source-only development; do not weaken the launcher.

**Status: CONNECTED_HOST_LAUNCHER_SOURCE_READY / FIREWALL_RULE_CREATION_NOT_REPORTED / APP_EGRESS_EFFECTIVENESS_NOT_VERIFIED / GUI_RUNTIME_NOT_RUN.**

## Operator reports script hashes and two active firewall block rules passing

2026-11-01 operator reported the read-only terminal verification:

```text
=== SCRIPT VERIFICATION ===
PASS: Confirm-R10ScconfigFirewallRules.ps1
PASS: Start-R10ScconfigConnectedHost.ps1
=== FIREWALL VERIFICATION ===
PASS: scconfig.exe outbound block rule
PASS: seiscomp.exe outbound block rule
READY FOR STRICTER BATCH 3B PREFLIGHT
NO GUI EXECUTED; NO SETTINGS CHANGED
```

**Assessment:** user-observed matching ActiveStore executable block rules and two pinned scripts. This is preliminary policy evidence only; no comprehensive protocol/address/profile firewall scope verification or effective egress traffic test has been reported. The source-only tools have not yet been executed by the operator, and no GUI startup has been shown.

**Next action:** `& (Join-Path $folder 'Start-R10ScconfigConnectedHost.ps1') -Root $root` with no `-Run`, from Y: windows-development and disposable C: root, to run strict policy and installed manifest preflight. Keep full output. Do not circumvent execution policy or claim runtime authorization from the operator's initial block-rule confirmation.

**Checkpoint:** PINNED_SCRIPTS_VERIFIED_BY_OPERATOR / APPLICATION_BLOCK_RULES_OBSERVED / STRICT_PREFLIGHT_PENDING / GUI_NOT_RUN.

## Operator report: strict preflight script rejected by signing policy

2026-11-01 operator attempted to invoke `Start-R10ScconfigConnectedHost.ps1 -Root <disposable R10>` from the Y: `phase8/windows-development` folder without `-Run`. PowerShell rejected the invocation **before executing any script statements**: `SecurityError: file is not digitally signed; cannot run this script on the current system`, `FullyQualifiedErrorId: UnauthorizedAccess`. Exact effective execution policy and file zone not yet inspected. This is an execution-policy/signature boundary, **not an R10 or firewall failure**.

Do not use `-ExecutionPolicy Bypass`, lower machine/user policy, unblock downloaded files without security approval, or invoke the guarded launcher via a different unsanctioned interpreter. Keep signed artifact/organizational policy review separate.

A legitimate read-only alternative is to paste equivalent PowerShell inspection **commands directly into the interactive terminal**, without dot-sourcing or invoking any `.ps1`: `Get-ExecutionPolicy -List`, manifest and receipt digest checks, exact executable and Qt file SHA-256 checks against the manifest, XML count, `Get-NetFirewallProfile -PolicyStore ActiveStore` and strict `Get-NetFirewallRule` plus application/port/address/service filter checks. Such an inline inspection must not create rules, start SeisComP, or claim real traffic containment. A formally signed, reviewed launcher is required if organizational policy prohibits unsigned script execution; runtime `-Run` remains pending separate authorizations.

Status: SCRIPT_HASHES_PASS / RULES_OBSERVED / STRICT_LAUNCHER_BLOCKED_BY_SIGNING_POLICY / GUI_NOT_RUN.

## 2026-11-01 prelaunch trust inspection

Operator confirmed both Batch 3B scripts remain NotSigned with Zone.Identifier=True. SEISCOMP_ROOT, SEISCOMP_LOCAL_CONFIG, QT_PLUGIN_PATH, QT_QPA_PLATFORM_PLUGIN_PATH and QT_QPA_PLATFORM are unset. User .seiscomp directory absent; disposable R10 var/run/seiscomp.init absent. No GUI execution. Next step is security-policy-approved per-file trust handling after digest/source verification, or approved signing, followed by preflight-only execution. No global policy changes.

## Batch 3B operator checkpoint: guarded script preflight PASS (2026-11-01)

The operator has now run the manifest-pinned guarded PowerShell launcher **without** `-Run`, using the disposable R10 test copy. Actual output:

```text
ACTIVE_FIREWALL_POLICY_MATCH: scconfig.exe
ACTIVE_FIREWALL_POLICY_MATCH: seiscomp.exe
BATCH3B_ACTIVE_FIREWALL_SCOPE_PASS
NO_NETWORK_EGRESS_TESTED; HELPERS_NOT_COVERED; NOT_ISOLATED
NO_GUI_EXECUTED; NO_FIREWALL_CONFIGURATION_CHANGED
=== BATCH 3B CONNECTED HOST SCCONFIG PREFLIGHT ===
Manifest: 83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74
DescriptionXMLCount: 131
DisposableReceiptAndRuntimeFiles: VERIFIED
FirewallPolicyScope: ACTIVE_STORE_RULES_MATCH
NotFullyIsolated: True
BATCH3B_CONNECTED_HOST_PREFLIGHT_PASS
GUI_NOT_RUN; HELPER_NOT_EXECUTED; FIREWALL_NOT_MODIFIED
```

Interpretation: **script execution trust/RemoteSigned issue is resolved for preflight**, manifest and receipt are verified, original selected binaries and Qt runtime inputs match, 131 XML descriptions are present (not runtime-parsed), and both named Windows Firewall ActiveStore outbound block-rule scopes match the disposable paths. This does **not** show effective egress containment of actual launched traffic or processes, dynamic Qt loader success, GUI display, setup execution or scientific qualification.

Follow-on development target: first **separately approved** connected-host GUI-only `scconfig.exe` smoke test from the disposable R10 root in a **non-elevated** PowerShell process, with reviewed user configuration, scoped app-block policy, explicit residual-risk acknowledgment for untested egress and helper processes, and evidence directory outside R10. The original verified R10 must remain untouched. `showEvent` writes the first-start state marker before prompt; select **No**, never choose setup or use Ctrl+N. Capture actual GUI/Qt diagnostics and close app; remain explicit that only this bounded test is qualified.

Do not pass the existing `-EgressEffectivenessReviewed` launcher switch as a factual claim until effectiveness has been independently reviewed. **No `-Run` command is issued by this checkpoint**; obtain the required runtime authorization and resolve this admission condition before testing.

**Status: `BATCH3B_CONNECTED_HOST_PREFLIGHT_PASS / GUI_NOT_RUN / EGRESS_EFFECTIVENESS_NOT_PROVEN / SCIENTIFIC_NOT_QUALIFIED`.**
