# SeisComP Phase 8 — Batch 3C Original Windows GUI Runtime Progression

**Prepared: 2026-11-01. SOURCE/PLAN ONLY. This document grants no runtime authorization.**

## Proven starting checkpoint

- SeisComP 8.0.0 original native `scconfig.exe`: **one supervised Windows first-window/clean-exit smoke PASS** in disposable `SeisComP-Scconfig-Test-R10`. The System panel and original Qt toolbar rendered; `scautoloc` showed Off/not running.
- First smoke session ended with `GUI_PROCESS_EXIT: 0` and created only the expected first-run marker under the disposable root.
- Captured stdout: 0 bytes; Qt stderr: 7,293 bytes. Operator's keyword screening found one `loaded library.*qwindows` match and zero matches for `Cannot load library`, `failed to load`, `error`, `warning`, `crash`. This is a **screening result**, not proof of comprehensive error absence.
- The original 11 GUI entrypoints had previously passed manifest/packaging **preflight**, but only `scconfig` has now been **runtime-smoked**. Thus runtime first-window coverage is **1/11**, with **10/11 pending**.
- The pinned original R10 manifest is `83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74`. Do not alter original installed R9 or verified R10.
- Host internet remains connected. Only `scconfig.exe` and `seiscomp.exe` have observed, matched outbound block rules; traffic effectiveness and child process containment have **not** been established.

## Runtime-test queue and prioritization

The remaining original GUI executable names are:

1. `scrttv.exe` — prioritize waveform/trace viewer startup.
2. `scolv.exe` — prioritize origin/event location interface startup.
3. `scmv.exe` — prioritize geographic map viewer startup.
4. `scmvx.exe` — map-viewer variant startup.
5. `scqcv.exe` — QC viewer startup.
6. `scshowevent.exe` — event display startup.
7. `scesv.exe` — event view startup.
8. `scheli.exe` — helicorder view startup.
9. `scmm.exe` — GUI startup.
10. `scmapcut.exe` — GUI startup.

This is proposed **development/test order**, not a claim that later apps are scientifically supported by the current empty local inventory or live network/data sources. Static packaging preflight is already accepted for 11/11; don't rerun it as a gate without a package change.

## Source-first implementation work before further GUI execution

- Generalize the Batch 3B guarded test launcher for an allowlist of these ten **original manifest-pinned executable names**, preserving default preflight-only behavior, an explicitly required per-application authorization, normal user privilege, an evidence directory outside the runtime root, and process-local Qt logging.
- **Do not reuse or rename the scconfig firewall rule** for another executable. For each proposed app, inventory its actual child-processes, configuration precedence, profile and startup behavior; only after host authorization, arrange a narrowly scoped block rule for the *exact corresponding disposable executable path*. Other helper executable risks must be reviewed independently.
- Maintain the user's no-Sandbox/no-host-disconnection constraint; do not claim full network isolation from ActiveStore rule presence. If rule effectiveness or helper containment cannot be established to the approved level for an app, keep that app in **source/preflight-only** status rather than bypassing a guard.
- Keep manifest/Qt/plugin checks reusable and read-only. Distinguish missing GUI resources, map tiles, network data and scientific correctness from first-window startup failure.
- Implement fixes only for observed concrete faults, using the editable `phase8/native-working-copy` source, with a separate manifest/revision when producing new binaries. The immutable release artifacts must never be patched in place.
- Record for each authorized GUI session: exact binary/source/build identity, risk/authorization reference, Qt platform load result, visible window and screenshot, first page and optional read-only navigation, stdout/stderr file paths, exit status, files changed under disposable root, and whether helper processes or outbound connections occurred.

## Acceptance levels (never collapse them)

- **SOURCE_READY**: implementation changes integrated; no runtime claim.
- **ENTRYPOINT_PREFLIGHT_PASS**: manifest and packaged runtime path checks only.
- **FIRST_WINDOW_SMOKE_PASS**: screenshot/observation proves actual native window rendered and process exit recorded.
- **GUI_FUNCTIONAL_PASS**: intended UI workflows checked without unsafe controls; separate qualification.
- **OPERATIONAL_PASS**: controller/data/permissions/runtime side effects and network behavior qualified in the appropriate supervised environment.
- **SCIENTIFIC_PASS**: seismological outputs validated against trusted datasets and expected results; a GUI launch cannot establish this.

## Next proposed bounded engineering unit

Batch 3C-01: source-only generalized launcher and read-only readiness for `scrttv.exe`. Never run `scrttv` from the connected office host without **new specific runtime authorization** and its own verified egress controls. Do not activate data acquisition, production messaging or SeisComP services just to test the UI. Finish implementation before requesting repeated user reviews, in line with development-first preference.

**Milestone:** `BATCH3B_SCCONFIG_SMOKE_PASS` → `BATCH3C_01_SCRTTV_SOURCE_PREPARATION` (source work only; not yet launched).

## Batch 3C-01 implementation checkpoint (2026-11-01)

Implemented two **new source-only** PowerShell tools in the `phase8/windows-development/` branch without editing the verified R9/R10 installations, firewall policy, or network settings:

1. `Inspect-R10RemainingGuiReadiness.ps1` — manifest/receipt-pinned, read-only inventory of all ten remaining original R10 native Windows GUI executables, verifies each binary and Qt runtime selected file SHA-256, reports whether any corresponding named outbound deny rule is only **observed**, and optionally validates the historical 4,096-byte offline miniSEED input. Source SHA-256: **`DDFA4222037997EB61DA8C549696146D76EAE64716BADB252726F3FE34873614`**, 5,217 ASCII bytes.

2. `Start-R10RemainingGuiConnectedHost.ps1` — reusable allowlist of the ten GUIs. With no `-Run`, verifies a selected original GUI executable/Qt inputs, the disposable root receipt, description inventory and optional fixture, **then stops without execution**. `-Run` is disabled for all except `scrttv`; even for `scrttv` it requires a new explicit `scrttv` authorization reference (previous one-time `scconfig` permission does not apply), pinned 4,096-byte miniSEED fixture, `--offline --no-inventory` mode, non-elevated user context, no inherited SeisComP/Qt overrides or existing `scrttv` process, full exact-path ActiveStore outbound block-rule scope, explicit connected-host/egress/child-process risk review and external evidence directory. Source SHA-256: **`DAD51B837E1E87B0298AAB77E9EA9C5AC4C4212F4650EE89AB1B59174D4B7E8A`**, 10,713 ASCII bytes.

Both files were read back from GitHub and exact source hashes computed after commits; static inspection found no unsafe dynamic expression evaluation, no firewall-rule changes, no read-only automatic `$HOME` variable collision and no non-ASCII characters. **Windows PowerShell syntax parse and actual operator execution have NOT been performed**. Keep status SOURCE_READY, not GUI PASS.

Historical baseline reconciled from `phase8/IMPLEMENTATION_STATUS.md` and `phase8/patch-ledger.md`: native `scrttv.exe` was already successfully linked (P8-WINGUI-02D, SHA-256 `AC4ECD4769FF9207F486D873FA0623CED26D0779C4A0D606977F4DFB6D075052` for the historical staged executable), with source-verified `--offline`, `--no-inventory`, and positional local miniSEED loading; earlier P8-WINGUI-02E refused execution because process isolation was absent. The fixture was previously reported as `data/phase5c1/phase5c1a/NC_NGVB_20s.mseed` (4096 bytes, SHA-256 `995768AC810924BEB6EC4F195A294E966AFD05F2BEEA8428B6688F57586374E6`). **Do not assume the old staged executable hash matches the current R10 copy**; the new script uses the R10 package manifest for current bytes.

Next operator action **when convenient**: put both reviewed scripts beside the existing Batch 3B scripts in the Y: `windows-development` tools folder, verify hashes and PowerShell parser syntax under normal policy; perform `Inspect-R10RemainingGuiReadiness.ps1 -Root <disposable R10>` or the default `Start-R10RemainingGuiConnectedHost.ps1 -Root <disposable R10> -Application scrttv` **without `-Run`**. These are read-only and require no new runtime authorization. Prepare the exact scrttv firewall rules and bounded runtime approval separately **only after** the source checks pass. Do not copy scripts inside verified R10, and do not launch scrttv with the scconfig-only authorization.

**Current state:** `BATCH3C_01_SOURCE_READY / 10_GUI_RUNTIME_SMOKES_NOT_RUN / SCRTTV_EGRESS_RULE_UNVERIFIED / SCRTTV_RUNTIME_NOT_AUTHORIZED`.

## Operator result: Batch 3C-01 scrttv guarded preflight PASS (2026-11-01)

Operator saved both new Batch 3C scripts under the Y: `phase8/windows-development` tool directory, and ran a PowerShell SHA-256 and syntax parse check, reporting:

```text
HASH AND SYNTAX PASS: Start-R10RemainingGuiConnectedHost.ps1
HASH AND SYNTAX PASS: Inspect-R10RemainingGuiReadiness.ps1
BATCH3C_SCRIPT_VERIFICATION_PASS
NO FILES CHANGED OR GUI EXECUTED
```

The initial execution-policy rejection was resolved using reviewed per-file `Unblock-File` on these two scripts, without changing PowerShell execution policy. The operator subsequently ran `Start-R10RemainingGuiConnectedHost.ps1 -Root <disposable R10> -Application scrttv` **without `-Run`**, resulting in:

```text
=== BATCH3C NATIVE GUI PREFLIGHT ===
Application: scrttv
Manifest: 83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74
DisposableReceiptAndQtRuntimeHashes: VERIFIED
DescriptionXMLCount: 131
ScrttvLocalMiniSEEDFixture: NOT_CHECKED
BATCH3C_GUI_ENTRYPOINT_PREFLIGHT_PASS
GUI_NOT_RUN; NO_FIREWALL_CHANGE; NO_NETWORK_PROBE
```

**Interpretation:** First source-to-operator checkout of the new guarded Batch 3C launcher and selected `scrttv` executable identity/Qt package checks **PASS**. There was no `scrttv` execution, data acquisition or service launch. Fixture hash **not checked**; no application-specific outbound deny rule was validated in preflight-only mode. Do **not** treat the observed scconfig/seiscomp rules as scrttv containment; no traffic-level proof, helper-process containment, functional waveform rendering or scientific qualification has been established.

**Next minimal work:** read-only SHA-256/size verification of the historical `data/phase5c1/phase5c1a/NC_NGVB_20s.mseed` (4,096 bytes, SHA-256 `995768AC810924BEB6EC4F195A294E966AFD05F2BEEA8428B6688F57586374E6`), without running GUI. Then review the proposed exact application path outbound firewall rule for the disposable `scrttv.exe` and obtain a separate, explicit connected-host `scrttv` runtime authorization before actually creating an operator-controlled firewall rule or invoking `-Run`. Retain no-Sandbox/no-host-disconnection constraints and original R9/R10 immutability.

**Checkpoint: `BATCH3C_01_SCRTTV_ENTRYPOINT_PREFLIGHT_PASS / LOCAL_MINISEED_FIXTURE_NOT_CHECKED / APP_EGRESS_NOT_VERIFIED / GUI_NOT_RUN`.**

## Batch 3C-02 source preparation: scrttv fixture and egress rule inspection

2026-11-01: Added `Inspect-R10ScrttvOfflineBoundary.ps1`, a **read-only source-only** Windows PowerShell inspector. SHA-256 **`1A6CA1F512AE87C9F228FCC9C4B9863C1BA6987882DE40EE80926B0F1DD200DA`**, 6,697 ASCII bytes, GitHub readback verified. Static lexical bracket checks and a scan for process/firewall mutation primitives passed; **Windows PowerShell parser and operator execution have not been performed**.

This inspector checks the receipt-pinned disposable `SeisComP-Scconfig-Test-R10` manifest, current `scrttv.exe`, `bin/qt.conf` and Windows Qt platform plugin hashes. It searches six **known candidate paths only** under the operator-specified `SeisComP_Phase5A_AI_Coder_Pack` workspace for the historical `NC_NGVB_20s.mseed` fixture and validates its actual size (4,096 bytes) and SHA-256 `995768AC810924BEB6EC4F195A294E966AFD05F2BEEA8428B6688F57586374E6`; if absent it reports NOT_VERIFIED rather than substituting arbitrary data.

The inspector reads Windows Firewall `ActiveStore` status and compares a **specifically named** proposed block rule `SeisComP-R10Test-scrttv.exe-OutboundBlock` against the **exact disposable `bin/scrttv.exe`** path, enabled/outbound/block/Any profile/ports/addresses/service. It reports missing/mismatch/match without making any policy changes. A matching rule would still not establish traffic-level egress effectiveness or helper isolation. No code ever calls the scrttv executable.

Separate runtime authorization for scrttv **not obtained**; no firewall changes or new GUI execution requested. Earlier `scconfig` one-session approval covers only scconfig. Developer/QA next action is operator review of this one read-only script and actual Windows output, then any firewall-rule creation plan and explicit new connected-host approval, still using the user's connected-internet/no-Sandbox restriction.

**State: `BATCH3C_02_SOURCE_READY / SCRTTV_FIXTURE_AND_FIREWALL_NOT_YET_INSPECTED_ON_HOST / SCRTTV_RUNTIME_NOT_AUTHORIZED`.**

## Batch 3C-02 host inspection: miniSEED PASS, scrttv block rule MISSING (2026-11-01)

Operator executed the read-only `Inspect-R10ScrttvOfflineBoundary.ps1` script on the connected Windows host and reported:

```text
=== BATCH3C SCRTTV OFFLINE BOUNDARY INSPECTION ===
CurrentScrttvExe: C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10\bin\scrttv.exe
R10ManifestSHA256: 83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74
DisposableReceiptAndSelectedQtHashes: VERIFIED
FixtureCandidatesFound: 1
SCRTTV_MINISEED_FIXTURE_SHA256_PASS
VerifiedFixturePath: Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\data\phase5c1\phase5c1a\NC_NGVB_20s.mseed
ACTIVE_FIREWALL_PROFILES_ENABLED
SCRTTV_EXACT_PATH_OUTBOUND_BLOCK_RULE_MISSING
READ_ONLY_INSPECTION_COMPLETE; GUI_NOT_RUN; FIREWALL_NOT_CHANGED
ACTIVE_RULE_SCOPE_DOES_NOT_PROVE_TRAFFIC_EGRESS_BLOCKING_OR_HELPER_ISOLATION
```

**Accepted:** the 4,096-byte fixture SHA-256 `995768AC810924BEB6EC4F195A294E966AFD05F2BEEA8428B6688F57586374E6` matches; no need to repeat fixture discovery. The disposable R10 receipt, manifest, scrttv binary and selected Qt hashes passed. All firewall profiles are enabled.

**Remaining admission blocker:** no `ActiveStore` matching rule named `SeisComP-R10Test-scrttv.exe-OutboundBlock` for exactly `C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10\bin\scrttv.exe`. This test was strictly read-only; it did not create a firewall rule or start SeisComP. Existing rules for `scconfig.exe` and `seiscomp.exe` do not cover `scrttv.exe`.

**Proposed next user-controlled action (only if organizational firewall policy permits):** elevated PowerShell, idempotently check for existing same-name rule; reject an existing incompatible rule; create one `Enabled=True`, `Direction=Outbound`, `Action=Block`, `Profile=Any`, `Protocol=Any`, `LocalAddress=Any`, `RemoteAddress=Any` rule scoped to exactly the disposable `scrttv.exe` executable. Do not change default host outbound policy or disconnect the internet. Then re-run the existing read-only inspector to verify strict scope. A correctly configured firewall rule does not prove traffic-level blocking, loopback containment, child process isolation, or scientific safety. Treat this as a *preparation* action, not automatic runtime approval. A new explicit `scrttv`-specific single-session connected-host authorization and reviewed helper/egress risks are still required before `-Run`.

**Checkpoint: `BATCH3C_02_SCRTTV_FIXTURE_PASS / R10_PACKAGE_PASS / OUTBOUND_DENY_RULE_MISSING / SCRTTV_GUI_NOT_RUN`.**

## Batch 3C-03 source implementation: bounded scrttv outbound-block installer

2026-11-01: Following the verified missing `scrttv` exact-program rule, implemented **`Ensure-R10ScrttvOutboundBlock.ps1`** in the GitHub branch. New source SHA-256: **`8DF408C5447B59DC2E697037D5536691D7D7B1AFE6ED10BB8F4174D10B2FC97C`**, 6,956 ASCII bytes. Fetched from GitHub for byte-for-byte verification; lexical balanced-delimiter static check PASS. Host PowerShell syntax parse and invocation NOT yet performed.

The tool defaults to **read-only** inspection. It pins the expected 856-entry disposable R10 SHA-256 manifest and receipt, validates `bin\scrttv.exe` against its manifest entry, refuses reparse-point ancestry, requires local fixed NTFS and all three ActiveStore firewall profiles enabled. It looks for exact stable rule name `SeisComP-R10Test-scrttv.exe-OutboundBlock` in `ActiveStore` and `PersistentStore`, refuses duplicates or incompatible/non-effective rules, and on a matching existing rule returns PASS with **no change**. If absent, default output says MISSING, with no change.

Only explicit `-Apply` in **elevated PowerShell** (plus interactive `ShouldProcess` confirmation) creates one `PersistentStore` outbound/block, enabled, Any-profile/protocol/addresses rule for the exact verified **disposable** `bin\scrttv.exe`. It immediately re-reads ActiveStore and verifies the exact app, port, address and service filters. Any refusal, failure or conflicting rule must be reported; do not bypass. This script does **not** edit default firewall policy, globally disconnect networking, modify the original R9/R10 trees, run `scrttv`, exercise network packets, contain child processes or qualify scientific behavior.

Operational boundary: operator must first download and review the new script, verify its exact SHA-256 and Windows PowerShell syntax, and follow organizational script trust rules. Apply only if office firewall policy permits. Existing verified 4,096-byte miniSEED fixture does not need repeated checks. After applying the named rule, use the existing **read-only** `Inspect-R10ScrttvOfflineBoundary.ps1` to verify independent active scope. A scope match is **not** actual traffic-level egress proof; the previously authorized `scconfig` test does not authorize `scrttv -Run`. Obtain distinct supervised scrttv runtime authorization and review any remaining child-process risk before GUI startup.

**Source checkpoint:** `BATCH3C_03_GUARDED_FIREWALL_TOOL_SOURCE_READY / RULE_CREATION_UNCONFIRMED / SCRTTV_GUI_NOT_RUN`.

## Batch 3C-03 operator local script access denied (2026-11-01)

Operator attempted initial SHA-256 and PowerShell parser verification of `Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\windows-development\Ensure-R10ScrttvOutboundBlock.ps1`. `Get-FileHash` returned **Access to the path is denied** (`FileReadError`). The separately entered `throw 'SCRIPT HASH MISMATCH'` was therefore a follow-on control-flow artifact, **not** evidence that bytes differ. The subsequent `Parser.ParseFile(...)` check reported `SCRIPT SYNTAX FAILED`, but parser errors were not printed and file readability was not established; **not evidence of an actual source syntax defect**. Last command simply echoed `BATCH3C FIREWALL SCRIPT VERIFIED` and cannot certify verification.

**Actual disposition:** `BATCH3C_03_LOCAL_SCRIPT_UNREADABLE / HASH_NOT_VERIFIED / PARSER_NOT_VERIFIED / FIREWALL_RULE_CREATION_NOT_REPORTED / SCRTTV_NOT_RUN`. Do not use `Unblock-File`, permission/ACL bypasses, or `-Apply` while access denied. Read-only compare file metadata, `Get-FileHash -ErrorAction Stop` for both the new and previously readable scripts, and `icacls` of the target path; return error messages. IT-approved restore/re-download only after identifying the cause. Preserve R10 and prior verified fixture evidence.

## Batch 3C-03 file access recovered and hash verified

2026-11-01 operator reran a **read-only** inspection of the previously unreadable `Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\windows-development\Ensure-R10ScrttvOutboundBlock.ps1`. It was readable on this check: **6,956 bytes**, attribute `Archive`, SHA-256 **`8DF408C5447B59DC2E697037D5536691D7D7B1AFE6ED10BB8F4174D10B2FC97C`** matching the committed source. Comparison `Start-R10RemainingGuiConnectedHost.ps1` was readable, 10,713 bytes with expected SHA-256 `DAD51B837E1E87B0298AAB77E9EA9C5AC4C4212F4650EE89AB1B59174D4B7E8A`.

The operator reported matching file owner `AzureAD\dantesoneja`, 4 access rules, with `icacls` showing Administrators `(F)`, SYSTEM `(F)`, Authenticated Users `(M)`, and Users `(RX)` and `Successfully processed 1 files; Failed processing 0 files`. No ACL repair is justified from this evidence. The previous hash failure was caused by a **transient/not yet explained read denial**, not mismatched source bytes. The earlier parser failure remains inconclusive because the file could not then be read; a fresh parser check is still needed now that access succeeds.

**No observed firewall change, scrttv execution, or network effect** in this read-only inspection. Next: run a fail-closed parse check followed by default no-Apply preflight of the verified guarded firewall script. Only if Windows PowerShell syntax and read-only preflight pass, and organizational policy permits, may the operator run the separately confirmed elevated `-Apply` mode. Independently verify resulting ActiveStore rule afterward; application rule scope remains insufficient as packet-level egress or helper process proof.

**Checkpoint: `BATCH3C_03_SCRIPT_READABLE_SHA256_PASS / PARSER_RECHECK_PENDING / RULE_APPLICATION_NOT_CONFIRMED / SCRTTV_GUI_NOT_RUN`.**

## Batch 3C-03 operator verified scrttv firewall rule scope (2026-11-01)

Operator completed file trust and tested the default **non-mutating** `Ensure-R10ScrttvOutboundBlock.ps1 -Root <disposable test R10>` path, with output:

```text
BATCH3C SCRIPT TRUST REVIEW COMPLETED
SCRIPT HASH STILL MATCHES
NO FIREWALL RULE CREATED OR GUI EXECUTED
=== BATCH3C SCRTTV OUTBOUND FIREWALL PREPARATION ===
VerifiedScrttvExecutable: C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10\bin\scrttv.exe
PinnedManifestSHA256: 83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74
DISPOSABLE_R10_IDENTITY_PASS; ACTIVE_FIREWALL_PROFILES_ENABLED
SCRTTV_ACTIVE_BLOCK_RULE_SCOPE_MATCH
RULE_ALREADY_PRESENT; NO_FIREWALL_CHANGE
NO_GUI_EXECUTED; EGRESS_EFFECTIVENESS_NOT_TESTED; HELPERS_NOT_COVERED
```

Interpretation: a unique rule with expected name/exact executable path and ActiveStore filters was verified by the guarded script, but that script **did not create it** in this invocation. An earlier read-only inspection found the named rule missing; its intervening creation mechanism/time is **not observed** here and should not be invented. Current state accepts **ActiveStore policy SCOPE PASS**, not network traffic effectiveness or child-process containment. The original 4,096-byte miniSEED fixture has already passed SHA-256/size verification; avoid re-verifying it unnecessarily.

**Next gate:** obtain a new explicit, specific authorization for **one supervised connected-host offline `scrttv.exe` GUI-only / pinned local miniSEED session**, using `--offline --no-inventory`, only from disposable R10 in normal/non-elevated PowerShell. Clarify accepted residual risk: host online, exact-rule scope verified but packet-level egress and child processes not contained; no live streams, SeedLink messaging, setup, services, or production operations. Existing `Start-R10RemainingGuiConnectedHost.ps1` retains fail-closed runtime switches requiring scrttv authorization reference and acknowledgments. Preserve external stdout/Qt stderr evidence and clean exit; no actual `scrttv` runtime test has yet occurred.

**Checkpoint:** `BATCH3C_03_SCRTTV_FIREWALL_POLICY_SCOPE_PASS / FIXTURE_PASS / GUI_RUNTIME_AUTHORIZATION_PENDING / SCRTTV_NOT_RUN`.

## Operator attempted illustrative scrttv command; executable not started

Operator entered `scrttv.exe --offline --no-inventory "<verified miniSEED file>"` while the shell was in the Y: `phase8/windows-development` directory. PowerShell returned `CommandNotFoundException` (`scrttv.exe` is not recognized). No SeisComP executable was found or launched; the placeholder waveform path was illustrative, not a valid test file. This is a command presentation/operator-location issue, **not a verified scrttv application failure**.

Correct program binary remains the manifest-verified disposable path `C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10\bin\scrttv.exe`, and the already-verified fixture is `Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\data\phase5c1\phase5c1a\NC_NGVB_20s.mseed`. Actual execution must use the guarded `Start-R10RemainingGuiConnectedHost.ps1` with proper `-Root`, `-Application scrttv`, `-ScrttvFixturePath` and separately authorized `-Run` conditions, not the sample program command.

No distinct operator acceptance of residual connected-host `scrttv` runtime risks was recorded before this attempt; previous `scconfig` permission covers only scconfig. Maintain `SCRTTV_NOT_RUN`; obtain new explicit consent for one supervised offline local-waveform smoke before issuing a launch command. No firewall changes or package mutations follow from CommandNotFound.

**Status: `BATCH3C_03_PREPARATION_PASS / DIRECT_COMMAND_NOT_FOUND / SCRTTV_GUI_NOT_RUN / AUTHORIZATION_PENDING`.**

## Batch 3C-04 operator authorization: one supervised offline scrttv session

2026-11-01 operator responded **`i authorize`** to the explicit request to approve **one supervised native Windows `scrttv` GUI-only startup using the verified local miniSEED**, while host internet stays connected, acknowledging the exact-app firewall rule is policy-scope verified but actual egress blocking and helper-process isolation are unproven. This is a distinct permission from the previously approved `scconfig` session.

**Authorized bounded test:** only `Start-R10RemainingGuiConnectedHost.ps1 -Root C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10 -Application scrttv -ScrttvFixturePath Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\data\phase5c1\phase5c1a\NC_NGVB_20s.mseed -Run` with new authorization reference and the script's explicit connected-host, user configuration, egress-limitation and child-process risk acknowledgments; normal non-elevated PowerShell, evidence directory outside test root, `--offline --no-inventory` exclusively. No app/service acquisition, live SeedLink, controller/setup, production messaging or settings changes. Qt stdout/stderr and exit status must be captured; report visually observed waveform (or failure) and close normally.

Last confirmed operator guard evidence: `BATCH3C_GUI_ENTRYPOINT_PREFLIGHT_PASS`; 4,096-byte miniSEED size and pinned SHA-256 PASS; current exact-path `scrttv.exe` ActiveStore outbound block rule reported `SCRTTV_ACTIVE_BLOCK_RULE_SCOPE_MATCH`, `RULE_ALREADY_PRESENT`, `NO_FIREWALL_CHANGE`, `EGRESS_EFFECTIVENESS_NOT_TESTED; HELPERS_NOT_COVERED`. Do not infer traffic containment. The source launcher is previously verified and preflight-ran; its actual `-Run` branch is NOT_YET_RUN.

**Checkpoint:** `BATCH3C_04_ONE_SCRTTV_OFFLINE_GUI_SESSION_OPERATOR_AUTHORIZED / EXECUTION_NOT_YET_REPORTED / CONNECTED_HOST_RESIDUAL_RISK_ACKNOWLEDGED`.

## Batch 3C-04: first observed original native scrttv waveform window

2026-11-01 operator provided a **screenshot** after the separately authorized single-session connected-host offline `scrttv` launch. This is direct visual Windows GUI runtime evidence, not a packaging/preflight claim.

**Observed screenshot:** normal `scrttv` native Windows title bar and menu (`File`, `Edit`, `Mode`, `View`, `Window`, `Settings`, `Help`); visible continuous waveform trace with station/network/channel labels **`NGVB` / `NC` / `EHZ`**, timeline labels around **10:21:45–10:22:00** with date **`2014-08-24`**, a pronounced high-amplitude portion around 10:21:50, and lower UI indicators **`No filter`** and **`Standard mode`**. The window is not blank, and trace/time display rendered. This is consistent with the previously SHA-256-verified `NC_NGVB_20s.mseed` fixture and launcher offline-file mode, but screenshot alone does not independently establish the exact input-file bytes or scientific fidelity.

**Qualified runtime milestone:** `BATCH3C_SCRTTV_NATIVE_GUI_FIRST_WINDOW_WAVEFORM_DISPLAY_PASS`. The previous `scconfig` first-window/exit smoke was PASS. Thus **2 of 11 original GUI entrypoints** have directly observed native Windows first-window evidence; only `scconfig` has confirmed process exit 0. For `scrttv`, post-close `SCRTTV_PROCESS_EXIT`, stdout and Qt stderr log paths/results, any dialog or unexpected network/child process behavior, and explicit clean shutdown **have not yet been reported**. No claim of full offline network containment, station acquisition, correctness of amplitudes or earthquake analysis.

**Safe session closeout:** Do not enable acquisition/connect live data, start SeedLink/controller/services or change production configuration. Close `scrttv` normally with the window X. The guarded `Start-R10RemainingGuiConnectedHost.ps1` waits for closure then emits `SCRTTV_PROCESS_EXIT`, `STDOUT_EVIDENCE` and `QT_STDERR_EVIDENCE`; operator should provide full output and optionally keyword screen of the stderr log. Only after exit/diagnostics review may first-window-and-clean-exit smoke be marked complete. If output is not returned or error appears, record as pending rather than PASS.

**Checkpoint:** `SCRTTV_FIRST_WINDOW_WAVEFORM_RENDER_PASS / SCRTTV_PROCESS_EXIT_PENDING / CONNECTED_EGRESS_AND_SCIENTIFIC_NOT_QUALIFIED`.
