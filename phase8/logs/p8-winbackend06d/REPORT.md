# P8-WINBACKEND-06D — native Windows controller deployment

**Agent:** Codex. **Date/OS/compiler:** 23 October 2026, Windows x64, MSVC 19.44.35225.0 / MSBuild 17.14.40, CMake 3.31, Visual Studio 2022 Release x64, installed Windows SDK 10.0.28000.0. No dependency upgrades.

**Assessed milestone: Phase5A PARTIAL.** Restricted controller ABI/binding/frontend/staging engineering work is complete. Full controller functionality remains incomplete where the matrix identifies adapters, contracts or command semantics. No controller/application/extension was executed/imported; runtime, numerical and scientific validation NOT RUN, release NOT QUALIFIED.

## Gate register

| Gate | State | Evidence | Exit / exact command | Limitations |
|---|---|---|---|---|
| A: Source + Phase4C evidence | NOT_RUN as full gate | before.json, preservation.json, linux-frozen-{initial,final}.log | batch.py before/after: 0; read-only WSL git/status/hash: 0 | Focused custody PASS; Phase4C audit not repeated; no promotion of earlier full-gate status. |
| B: Transitive dependency closure | NOT_RUN as full gate | artifact-evidence.json, artifacts/*, deployment.json | stage.py: 0; raw dumpbin commands /headers /imports /exports /dependents | Focused static native closure PASS to Windows/API-set/installed VC-runtime boundary; full algorithm/plugin closure unchanged. |
| C: Linux original Autoloc offline oracle | NOT_RUN | No new fixture/output | No application command | No Linux oracle executed. |
| D: Windows native original Autoloc offline executable | NOT_RUN | Existing 06C1 scautoloc evidence retained | No application command | Native linking/deployment does not validate offline or live behavior. |
| E: Replay equivalence and robustness | NOT_RUN | No new replay/output | No application command | No numerical, scientific, concurrency or lifecycle tests. |

## Python ABI correction and original binding

WindowsPython310.cmake bridges modern FindPython to every legacy wrapper include/library/interpreter variable, with exact CPython 3.10.11 selection. Configure records interpreter identity, PE AMD64/PE32+ executable/runtime, header PY_VERSION, AMD64 COFF import library targeting python310.dll, file hashes and a Release compile/link-only probe. A forced-include header rejects wrong version, non-x64 and Debug CRT compilation. Identity and compile/link logs are WindowsPython310-*.json/.log. No generated probe executable ran.

configure.log and configure.exit_code.txt show exit 0. The dedicated negative-project supplies Python 3.10.11 with actual 3.14 include/library paths; negative-cmake-configure.log records actual configure exit 1 at FindPython Development discovery. negative-cmake-verified.json accepts that intended rejection; negative-abi.log also records helper rejection of mixed versions. No system Python installation changed. Non-Windows discovery/source projections are unchanged (source-checks.json; qualify-reviewed.log, exit 0).

Original SWIG 4.4.1 config_python_wrap.cxx and config.py match frozen source hashes. New narrow SC_WINDOWS_CONTROLLER_ONLY=ON enters only the system _config directory; general Python and NumPy wrappers remain OFF. Windows creates configuration-aware lib/python/Release/seiscomp/_config.pyd and copies source files without .so links, POSIX py-compile or symlinks. The plain _config.pyd filename is Python's untagged Windows extension form; the interpreter-reported ABI suffix .cp310-win_amd64.pyd is recorded in identity. No SWIG regeneration or scientific source edits.

| New target | Actual build exit | SHA-256 | Raw build log |
|---|---:|---|---|
| _config | 0 | 1F79EAF3610E2D3B1AFA32504DE93CC1DA6BB88B0329CAAB893FCD157235318A | [_config.log](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06d/_config.log) |
| seiscomp_controller | 0 | 4C932A6A3CB7D503A7612089F5E0797837B24889AF8E9260FE8B1461E464E4BE | [seiscomp_controller.log](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06d/seiscomp_controller.log) |
| seiscomp_python | 0 | E8194A3D9F63BD337D8F16FE2B47F749705C90057D217FC92C8F51C1EA9F07FF | [seiscomp_python.log](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06d/seiscomp_python.log) |

All three are AMD64 PE32+. _config exports PyInit__config and imports python310.dll plus matching seiscomp_config.dll. All named imports between inspected private binaries are satisfied by provider exports; recursive closure and per-file raw PE dumps are in artifact-evidence.json and artifacts/. No Linux/POSIX runtime dependency was found in the inspected closure. Optional dynamically loaded plugins remain outside this claim. Compiler warnings (retained without suppression) are counted in warnings.json; _config has existing C4251/C4275 DLL-interface diagnostics. Frontend builds contain no compiler warnings; no linker errors occurred.

## Native controller frontend and command qualification

Native seiscomp.exe and seiscomp-python.exe host the selected CPython through PyConfig and wide argv directly, without a new process-control wrapper or shell quoting. C++ derives root from installed bin, retains caller cwd until original Environment.chroot/chback, selects the established Python home/executable, sets DLL directories, and preserves the Python process exit code. The bootstrap establishes SEISCOMP_ROOT, SEISCOMP_WRAP, PATH/PYTHONPATH, package path and DLL-directory handles before runpy loads original controller dispatch. It does not source Unix host environment scripts. The companion accepts normal Python flags; execution of either frontend remains NOT RUN.

Windows print env produces escaped PowerShell assignments. check validates module names, skips already-running processes and reports restart failures; missing exec arguments return failure. setup/update-config explicitly reject unqualified module configuration paths, alias rejects undefined native alias mapping, print crontab rejects unimplemented scheduling, and print variables rejects the missing _system binding. Existing reload failure and scautoloc-only STOP remain unchanged. Original Unix frontend/CMake and Linux Python AST projections pass. 06A locks, 06B launch/ownership/receipts/Job Objects and 06C1 STOP source postimages are preserved; dispatch functions remain identical.

The full matrix in capabilities.md/.json classifies all 17 commands and reuses the original 15-handler inventory. One explicit scmaster database-helper supplement records its from-import of system and shell-based database helpers; the prior pattern inventory omitted it. Available means implementation present within the stated module scope, never operational qualification. enable/disable/status still need aggregate error semantics; setup/update-config require common SDK/schema/DB and module-specific adapters; scheduler, aliases and broader STOP/reload need defined native contracts. FDSNWS/Twisted, acquisition supervisors, broker, Qt, ew2sc and non-opted Clients are not enrolled in restricted STOP.

## Isolated staging / build and dependency manifest

[controller-06d-native](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/staging/controller-06d-native) contains the native frontends, original Python sources, _config.pyd, matching config provider, python310.dll, original defaults/descriptions/data paths, identity and capability/dependency manifests. Component-only CMake install ran with exit 0 (install-command.json/install.log); it never used the default Program Files installation. stage.py records and rechecks 20 staged PE imports, copies exact current 06C1 scautoloc and provider files, and preserves original licenses/notices. share/controller/deployment.json records sources/hashes/package ownership, Windows/VC runtime boundary and pinned external Python requirements. SHA256SUMS.txt covers all stage files except itself.

Only kernel (config-only) and the original scautoloc default handler are registered in etc/init. Other reviewed handlers are reference copies under share/controller/handler-sources; no .auto/run/PID markers enable modules. etc/defaults, etc/descriptions, etc/key, etc/env/by-hostname, var/log, var/run, sbin and share paths exist. Original example grid/station files are included, with no assertion of observed metadata, science-ready configuration, full locator/plugin data closure or database profile.

The external configured Python310 installation supplies Lib, DLLs and python.exe; the stage is not a relocatable Python distribution. Installed Microsoft VC/UCRT runtimes and Windows API contracts remain explicit prerequisites. Full GUI/plugin/application packaging is not claimed. stale-gui-providers.json records exact old/current hashes for 11 of 11 existing GUI stages; all 11 are unchanged and need synchronized provider packaging later. Licensing files are retained; distribution review is still open.

## Pinned source / patch provenance and custody

Approved scope: user P8-WINBACKEND-06D attachment; build files/frontends/Windows controller branches only in the independent native working copy. Ten files comprise the batch-only patch; source before/after hashes and reverse-check command exit 0 are in applied-patches.json. Exact patch SHA-256: **01C75D67DFF8F7CBC86D76D62746887E3EDBFB861AD63D9C5E933A48A72FC49F**. Patch: [P8-WINBACKEND-06D-native-controller.patch](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/patches/P8-WINBACKEND-06D-native-controller.patch). Source preimages are under preimages/; no copied algorithm code changed.

Nine frozen snapshots retain exact pre-batch HEAD/status/file hashes. Source originals checked read-only through Ubuntu-24.04 remain clean at superproject 9c395c7f00c788c5fc640363abe97b9ced0b44b0, main f63cde995e04151dc816151359a036b8b15f6019 and common 92d2202a6065aad36ae7d4a9bf960b6fb91222d2. Initial/final original checks match exactly; Windows snapshot custody was recorded before modifications, while the original WSL checks were taken during this batch and after completion. preservation.log/json (exit 0) verifies 824 protected files, 13 exact 06C1 source postimages, dependency status and 204 current Release binary/import-library preimages archived before configuring. No existing Release product changed, including current config/core/client/scautoloc. ew2sc send-deadline proposal stays unapplied; no Phase7 changes.

**Historical exception remains INCOMPLETE:** unavailable pre-06C1 seiscomp_config.dll SHA-256 1F3364FDDFEFC5F3EB4E72FFD8C3F21BAC26C27788684CE5B12B077237C824F8 was not recovered. Current verified config DLL SHA-256 62D55F2FA42D19A0730D37E2CE5056B4ACF9E31F7451A769B7A721831749D77F is archived for this batch and unchanged. Current-batch custody PASS does not repair or overwrite the historical gap.

## Inventory and remaining blockers

Backend/support **76/117 built**, 19 available/unbuilt, 14 Windows portability blocked, 2 external dependency blocked, 6 disabled. Original inventory remains **73/114**; three real controller targets were added to the denominator, with zero new completions among the old 114. GUI remains 11/11 built. Canonical backend JSON/CSV and P8-WINBACKEND-06D-control-status.json, IMPLEMENTATION_STATUS.md, PHASE5A_REPORT.md and patch-ledger.md are updated.

Remaining functionality includes common Python SDK/configuration model closure, module setup/update-config adapters, command failure aggregation, native aliases/scheduling, platform-specific supervisors/reload/STOP, runtime-loaded plugins/data profiles, dependency-blocked targets and broader release qualification. Build success does not resolve them.

## Linux fixture + result provenance

No fixture consumed and no Linux oracle executed. WSL was used only for frozen-source git/status/hash inspection. No operational installation or production system was used.

## Windows fixture + result provenance

No controller/application/GUI/service/extension run or import, no runtime preflight, DB/network access or scientific replay. Only stdlib Python identity/file tools, CMake configure/compiler/linker tools, file installation and dumpbin were executed. No network-isolation preflight was repeated.

## Numerical difference matrix

| Scenario | Linux origins | Windows origins | OT / distance / depth / association differences | Result |
|---|---:|---:|---|---|
| 06D build/staging batch | Not generated | Not generated | Not measured | NOT_RUN |

## Evidence gaps, failures and unresolved scientific questions

No missing or skipped runtime/science evidence is PASS. No observed-event station data or authenticated oracle is introduced. Existing Phase4C bias/outlier, precision, lifetime and sanitizer questions are unchanged. Retained harness failures: qualify.log initially found a new condition whose platform-only meaning was not recognized by the projection checker (made explicitly os.name dependent); qualify-attempt2.log exposed a reused harness path variable (corrected). Final reviewed source check passes. negative-cmake.log records an overly narrow diagnostic assertion even though the actual negative configure correctly failed; negative-cmake-verified.json documents the reassessment without rerunning it. No compiler/linker build failure was hidden, and all original failed logs/exits remain.

## Reproduction and next development phase

Exact compiler/configuration/install argument arrays are in *-command.json. From the phase-pack root, with the established Python310 interpreter: batch.py before; batch.py configure; batch.py build _config seiscomp_controller seiscomp_python; qualify.py; stage.py; batch.py patches; batch.py after. These custody/stage commands refuse to overwrite existing baseline/stage/logs; use a fresh batch/stage for reproduction. negative-cmake.py is a dedicated configure-only probe. finalize.py writes the report/inventory and verifies all staged file hashes. Evidence manifests preserve logs, patches, inputs and final outputs.

Recommended **06E development**: close explicitly selected common _core/_system configuration-binding dependencies, map pure module configuration helpers and correct enable/disable/status error aggregation. Keep DB/scheduler/alias and wider STOP/reload contracts separately scoped. Then obtain separate authorization for isolated import/frontend and scautoloc lifecycle integration with a defined offline boundary; do not repeat the blocked broad network preflight or assume operational approval.

**Final assessed milestone: Phase5A PARTIAL. Engineering ABI/build/static staging milestone complete within the restricted profile; controller runtime and scientific certification remain NOT RUN; release NOT QUALIFIED.**
