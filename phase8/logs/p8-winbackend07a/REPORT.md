# P8-WINBACKEND-07A — QC and acquisition backend report

Date: 2026-10-23. Build configuration: existing VS2022/MSVC Release x64 configuration `phase8/build/vs2022-native-after-sqlite-nohypo71`. No SeisComP application, controller, GUI, service, runtime Python extension, or network/data operation was executed.

## Result

No new QC plugin or acquisition executable completed in this batch. The inventory is now 79/120 built, 0 available/unbuilt, 22 Windows-portability blocked, 13 external-dependency blocked, and 6 disabled. The 22 Windows-blocked targets are chain_plugin, echopro_plugin, ewexport_pasv_plugin, ewexport_plugin, locext, locnll, minilogger_plugin, mseedfifo_plugin, mseedscan_plugin, naqs_plugin, q330_plugin, reftek_plugin, scardac, scplot, scream_plugin, scream_plugin_ring, scwfas, scwfparam, serial_plugin, sock_plugin, wave24_plugin, and win_plugin. The 13 external-dependency targets are gdrt_plugin, the ten QC plugin DLLs, scqc, and seiscomp_qcplugin. The ten QC DLLs cannot build before their common `seiscomp_qcplugin` provider, and that original provider is blocked by missing Boost.Signals2 headers. `scardac` reaches one unguarded POSIX `sleep`. The seven other independent SeedLink acquisition helpers each have concrete platform or source-materialization blockers. No algorithm, protocol, or source correction was applied; patch count and patch hash are none.

## QC targets and dependency boundary

The generated projects and source map are in `target-source-project-map.json`; source/CMake locations are recorded in the canonical inventory. The targets are `seiscomp_qcplugin` plus `qcplugin_availability`, `qcplugin_delay`, `qcplugin_gap`, `qcplugin_latency`, `qcplugin_offset`, `qcplugin_outage`, `qcplugin_overlap`, `qcplugin_rms`, `qcplugin_spike`, and `qcplugin_timing`. Each plugin project names the common provider among its generated dependencies.

The provider build exited 1 at `qcplugin.h:29` because `boost/signals2.hpp` is absent. This is independent of the `scqc` executable target but blocks these eleven QC targets through their actual shared headers/project dependencies. No plugin DLL was reported as built. The separate exact version-pinned proposal is `boost-signals2-closure-proposal.md` and `.json`: Boost 1.90.0#1 `boost-signals2` and its missing `boost-parameter` component; remaining transitive ports are installed at 1.90.0. The Signals2 archive checksum already matches its pinned vcpkg recipe (`logs/p8-winbackend05j/dependency-verification.json`); the Parameter archive remains to be retrieved and checksum-verified. Nothing was copied or installed.

## Acquisition attempts

`scardac` failed with MSVC C3861 at `scardac.cpp:746` for unguarded POSIX `sleep`. The prerequisite `seiscomp_daplugin` built as its own target with exit 0 after the known `/p:TrackFileAccess=false` MSBuild FileTracker workaround. No sleep/timing change was applied.

The independent acquisition targets attempted were `ewexport_pasv_plugin`, `scream_plugin`, `scream_plugin_ring`, `serial_plugin`, `sock_plugin`, `wave24_plugin`, and `win_plugin`. Their actual MSVC blockers are logged individually: missing `unistd.h`, `netinet/in.h`, `sys/time.h`, and `sys/socket.h`; the SCREAM snprintf/endianness errors; Wave24 const-correctness errors; and the Windows working copy's shared `plugin.c` path stub compiling as C source. No transport redesign or protocol change was made.

## Provider builds and evidence

The following existing prerequisite targets independently returned exit 0: `seiscomp_client`, `seiscomp_daplugin`, `seedlink_native`, `slplugin`, and `slutils`. The client and data-availability DLLs are AMD64 PE32+ and pass recursive static private DLL import closure through installed dependencies and the Windows/API-set boundary. Their current hashes, import/export logs, dependency graph, and dependency DLL hashes are in `provider-verification.json`; named imports from `seiscomp_core.dll` and `seiscomp_config.dll` match the current provider exports in `provider-symbol-closure.json`. Third-party symbol matching and runtime loading were not checked. The three SeedLink archives contain AMD64 COFF objects and have current hashes there. These provider rebuilds do not count as newly completed inventory targets. Static imports do not verify dynamic plugin loading.

The initial QC attempt's console log ended without an exit record during warning output; it is explicitly marked incomplete. A file-redirected retry captured exit 1 and the exact missing header. All six top-level helper logs, scardac attempts, and the individual successful provider commands preserve output and exit codes.

## Preservation and custody

Before compilation, 207 flat active Release files were archived and hash-verified. Five archived provider outputs changed; their original binaries/import libraries remain in `binary-before/`. The final check confirms those archives, all 1,113 protected prior files, all nine frozen repository snapshots, and the installed dependency status are unchanged. One nested transitive output, `tau_internal.lib`, sat outside the flat archive sweep; its current timestamp predates this batch, but its prebuild hash was not captured, so preservation for that file is not cryptographically asserted. A post-build copy/hash is retained in `dependency-archive-after/`. Prior 06A–06F controller work and GUI/controller staging are unchanged. No staged product was updated. The pre-06C1 configuration DLL custody gap remains INCOMPLETE.

## Remaining work

Next, resolve the version-pinned Boost Signals2/Parameter header closure as a separate dependency decision, then build the QC provider and ten QC plugins. In parallel, prepare narrowly scoped Windows portability changes for `scardac` and independently selected SeedLink helpers while preserving timing, waveform formats, and protocol behavior. After this backend batch, prioritize native database connector closure and core seismic-processing completeness (including currently disabled/external dependencies) before adding controller features.

Runtime, dynamic loading, numerical/scientific validation, and release qualification remain NOT RUN/NOT QUALIFIED.

## Gate register (Phase5A template)

| Gate | State: PASS / FAIL / BLOCKED / NOT_RUN | Evidence file(s) | Exit code and exact command | Limitations |
|---|---|---|---|---|
| A: Source + Phase4C evidence | NOT_RUN | `before.json`, `preservation-after.json` | Not run | Frozen custody checks passed, but Phase4C evidence and full source gate were not repeated. Nested `tau_internal.lib` prebuild hash was not captured. |
| B: Transitive dependency closure | NOT_RUN as full gate | `provider-verification.json`, `provider-symbol-closure.json`, `boost-signals2-closure-proposal.json` | Provider targets exit 0; commands in `provider-*-command.json` | Static closure and SeisComP core/config named imports pass for the two rebuilt DLLs. Boost Signals2 is incomplete; third-party named symbol matching and whole-install closure remain unqualified. |
| C: Linux original Autoloc offline oracle | NOT_RUN | None | Not run | No application, fixture or scientific replay. |
| D: Windows native original Autoloc offline executable | NOT_RUN | None | Not run | No application execution or runtime Python import. |
| E: Replay equivalence and robustness | NOT_RUN | None | Not run | No fixture sequencing, numerical comparisons, sanitizer runs or robustness replay. |

## Pinned source / patch provenance

Frozen superproject `9c395c7f00c788c5fc640363abe97b9ced0b44b0`, main `f63cde995e04151dc816151359a036b8b15f6019`, and common `92d2202a6065aad36ae7d4a9bf960b6fb91222d2` matched expected HEAD/status before and after; all nine frozen source snapshots were checked against the prior hash vector. No source patch was applied, so this batch has no patch SHA-256. Release artifact SHA-256 values and the 207 prebuild archives are recorded in `before.json`, `preservation-after.json`, and `provider-verification.json`. Existing AGPL notices and dependency versions were not modified.

## Build/link inventory

The existing Visual Studio 2022 generator, MSVC 19.44.35225.0, and Release x64 configuration were used. The top-level requested QC/acquisition targets did not link. Five prerequisite targets returned exit 0. `seiscomp_client.dll` and `seiscomp_daplugin.dll` are AMD64 PE32+; recursive private DLL closure passes, and all named imports from SeisComP core/config match their current provider exports. `seedlink_native.lib`, `slplugin.lib`, and `slutils.lib` contain AMD64 COFF objects. Existing MSVC C4251/C4275 interface warnings were retained in raw logs. No dynamic plugin registration or load was verified.

## Linux fixture + result provenance

NOT RUN. No fixture or Linux executable was consumed.

## Windows fixture + result provenance

NOT RUN. No Windows application or fixture was executed; no production contact occurred.

## Numerical difference matrix

| Scenario | Linux origins | Windows origins | Max OT diff (s) | Max epicenter diff (km) | Max depth diff (km) | Arrival/association diff | Result |
|---|---:|---:|---:|---:|---:|---|---|
| Not run | — | — | — | — | — | — | NOT_RUN |

## Evidence gaps, failures and unresolved scientific questions

No scientific or runtime claim is made. All 11 QC targets remain dependency-blocked; `scardac` and seven independent acquisition helpers fail on the Windows source blockers listed above. Recursive static import resolution does not prove dynamic plugin load behavior. The historical pre-06C1 config DLL custody gap remains INCOMPLETE. The nested `tau_internal.lib` prebuild hash is unavailable even though its current modification time predates this batch.

## Final assessed milestone

Phase5A **PARTIAL**. Engineering build evidence is recorded for five prerequisites, while the requested QC/acquisition application targets remain blocked. Gates A–E are not complete; the next minimum work is the exact pinned Boost Signals2/Parameter header closure, followed by QC provider/plugins and scoped Windows fixes for `scardac` and independent acquisition helpers. Continue with database connectors and core seismic-processing dependencies before controller expansion.
