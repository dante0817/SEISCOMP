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
