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
