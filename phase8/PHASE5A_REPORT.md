# PHASE 5A VERIFICATION REPORT — WORK IN PROGRESS

**Agent / engine / version:** Codex GPT-6, Windows workspace session  
**Date / OS / compiler versions:** 2026-10-20; Windows x64; MSVC 19.44.35225.0; CMake Visual Studio 17 2022 generator  
**Frozen revisions and git status BEFORE/AFTER:** superproject `9c395c7f00c788c5fc640363abe97b9ced0b44b0`; main `f63cde995e04151dc816151359a036b8b15f6019`; common `92d2202a6065aad36ae7d4a9bf960b6fb91222d2`. Frozen main/common source snapshots report clean status after inspection. Only `phase8/native-working-copy` is modified.  
**Input fixture hashes / license state:** No Autoloc fixture was replayed in this turn. Local approved WinFlexBison and SQLite dependencies and licenses/hashes are recorded in `phase8/tools/DEPENDENCIES.md`. Original AGPL notices are preserved.

## Gate register (do not remove rows)

| Gate | State: PASS / FAIL / BLOCKED / NOT_RUN | Evidence file(s) | Exit code and exact command | Limitations |
|---|---|---|---|---|
| A: Source + Phase4C evidence | BLOCKED | `evidence/phase4c_raw_evidence_review.md`, `evidence/phase4c_raw_evidence.json`, `phase8/source-snapshot/main`, `phase8/source-snapshot/common` | Frozen revision/status inspection completed. No new test command. | Prior dossier records a raw audit and the Phase 4C report is reviewed. The original NDJSON/CTest/build logs are not all present in this Windows work pack for independent re-hashing here. Keep “bit-for-bit” claim withdrawn; dossier records a 3e-9 km exploratory difference. |
| B: Transitive dependency closure | BLOCKED | `phase8/inventory/scautoloc/inventory.{md,json}`, `phase8/inventory/dependency_graph.md`, `phase8/inventory/portability_issues.md`, `phase8/inventory/licenses.md` | Static source review only. | Inventory remains partial; the static source registration path is now traced, but CMake target/link closure, generated-source closure, Linux ELF/compile-command map, and runtime `LocatorInterface::Create("LOCSAT")` instantiation are not complete. |
| C: Linux original Autoloc offline oracle | BLOCKED | Existing evidence is indexed under `phase6p/` and `results/`; no new replay artifacts in this report | NOT RUN in this implementation turn. | No current replay was proven here to use the unmodified original `Processing::Autoloc` path, admissible fixture provenance, and registered LOCSAT locator. Do not treat mock-labelled artifacts as scientific evidence. |
| D: Windows native original Autoloc offline executable | BLOCKED | `phase8/logs/p8-wincore01-final-core-check11.log`, `phase8/logs/p8-wincore01-client-after-zlib.log`, `phase8/logs/p8-wincore01-reconfigure-zlib.log`, `phase8/inventory/P8-WINCORE-01-root-causes.md` | `cmake --build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target seiscomp_core -- /m` — exit 0; `cmake --build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target seiscomp_client -- /m` — exit 1 (LNK1120). | Native `seiscomp_core.dll` links x64. The approved ZLIB target resolves to the local x64 vcpkg library; client C++ compilation succeeds, then linking fails with 58 unique unresolved externals (LNK1120). No Autoloc PE or parity evidence exists; GUI compilation is not reached. Socket width and reactor runtime remain unresolved. |
| E: Replay equivalence and robustness | NOT_RUN | None for a native original Autoloc executable | No command run. | No same-fixture Linux/native-Windows Autoloc replay was performed in this turn. |

## Pinned source / patch provenance

Frozen snapshots remained at the expected commits with clean status. Canonical SHA-256 hashes for 6,971 tracked blobs across the nine-repository source vector are recorded in `phase8/logs/source-snapshot-sha256.json`; the earlier revision/status baseline is in `phase8/inventory/source-revisions.csv`. Changes are isolated in `phase8/native-working-copy` and exported by repository into `phase8/patches/`. Patch hashes and compile log hashes are recorded in `phase8/logs/final-evidence.sha256.json`; layout-check hashes are also in `phase8/logs/layout-compile-check.sha256.json`.

Applied isolated engineering changes:

- P8-CMAKE-001: explicit CMake asset source paths.
- P8-WIN-REACTOR-001: initial Winsock/WSAPoll reactor and socket/file-descriptor branches. Runtime semantics, non-socket waiting, and TLS `SOCKET` width remain unresolved.
- P8-CORE-PORT-001: MSVC C++17 selection and Windows config path/current-directory adjustments.
- P8-COMMON-MSVC-001: MSVC compile adjustments, scoped format-struct packing, fixed-width Steim types, and 17/64-byte compile-time size assertions.
- P8-WINCORE-01: core Windows compatibility shims, native link dependencies, core-first Hypo71 option, Tau file reader compatibility, and Boost intrusive pointer lookup; grouped compiler analysis and current Autoloc blocker are in `phase8/inventory/P8-WINCORE-01-root-causes.md`.

User approvals recorded in this conversation: project-local WinFlexBison; project-local SQLite; layout-only MSVC packing changes preserving binary size and field order; mechanical MSVC VLA storage changes in `processing/amplitudes/a5_2.cpp` and `sbsnr.cpp`, plus double-precision `std::fabs` qualification in `sbsnr.cpp`, preserving formulas and control flow. No source from the frozen snapshots was changed. No live service, DB, production messaging, or installed application was used.

## Build/link inventory

- Native Windows x64, MSVC 19.44, Visual Studio 2022 generator. No Linux runtime or POSIX emulation was used.
- Full configure with Hypo71 enabled is blocked at the Fortran compiler probe; `devenv.com` reports the Visual Studio evaluation period has ended. Diagnostic configuration with `SC_IPGP_HYPO71=OFF` exits 0 but omits a product-scope module.
- Local SQLite resolves `scevent`'s CMake dependency; it does not establish the common DB plugin or full database product closure.
- P8-WINCORE-01 now compiles and links the native x64 `seiscomp_core.dll` (exit 0). The focused client build now resolves ZLIB and compiles messaging/WebSocket, then fails to link on the unresolved client/core symbol closure; details and cascading-error analysis are in `phase8/inventory/P8-WINCORE-01-root-causes.md`.
- The reactor object harness and the SeedLink/MiniSEED layout object harness compile under MSVC x64. The latter enforces 17-byte SeedLink header and 64-byte Steim1/Steim2 frame sizes. P8-WINCORE-01 also builds `seiscomp_core.dll`; `dumpbin /headers` confirms PE32+ x64 (`8664 machine`). These do not qualify Autoloc, socket/TLS runtime, or scientific behavior.
- No full application link, PE machine-type inspection, imports audit, runtime network-access check, or test-suite run was performed in this turn.

## Linux fixture + result provenance

No fixture was admitted or replayed in this turn. Prior phase outputs require source-path, input-provenance, executable-identity, and locator-registration audit before reuse. Synthetic Phase 4C LOCSAT engineering results are not Autoloc science evidence.

## Windows fixture + result provenance

No native original-Autoloc executable or Windows fixture result exists from this turn. No attempt was made to contact network services. Compile-only builds used local sources and dependencies.

## Numerical difference matrix

| Scenario | Linux origins | Windows origins | Max OT diff (s) | Max epicenter diff (km) | Max depth diff (km) | Arrival/association diff | Result |
|---|---:|---:|---:|---:|---:|---|---|
| No Phase 5A original-Autoloc replay | N/A | N/A | N/A | N/A | N/A | N/A | NOT_RUN |

## Evidence gaps, failures and unresolved scientific questions

- Full native product scope still has unresolved Fortran, Winsock socket-width/reactor runtime, process lifecycle, database adapter, application portability, and amplitude-source build blockers.
- The common core now compiles and links as a native DLL. The Autoloc build has passed client C++ compilation, including the amplitude and WebSocket/messaging sources; the current linker blocker is LNK1120 with 58 unique unresolved symbols.
- Native Hypo71 remains in scope; the successful diagnostic configure with it disabled is not a full-scope pass.
- Required fixture provenance, original Linux oracle identity, runtime locator factory registration, and native parity evidence are not established by this report. The inspected LOCSAT source says no particular license was attached to the origin code; redistribution rights need review.
- Phase 4C engineering results remain “within reported tolerances,” not bit-for-bit identical or independently scientifically validated.

## Final assessed milestone

Phase5A **BLOCKED**. Engineering progress: approved local dependencies, source-grounded inventories, isolated native build patches, and narrow MSVC compile-only checks. Gates B–D need closure before an original offline Autoloc executable can be qualified; gate E requires the same admissible fixtures and a successfully built native original-algorithm executable. No full SeisComP Windows conversion or scientific parity is claimed.







## P8-WINGUI-04C scconfig stdout fix — 22 October 2026

Patch application PASS: exact approved SHA-256 9BBFCA3F3C89242B51AD19DED40B79342B39AA60789626F96DB53386537E2445, two files/five identifier renames; postimages verified. git apply check/apply/reverse-check exit 0: logs/p8-wingui04c-stdout/{check,apply,reverse-check}.json.

scconfig focused MSVC Release x64 build FAIL, actual exit 1. Both modified translation units compile. Independent link root: SC_GUI_API FlowLayout header declares DLL imports, but scconfig compiles flowlayout.cpp locally and links core only. LNK2019 imports: __imp_??_7FlowLayout@Gui@Seiscomp@@6BQObject@@@ and __imp_??_7FlowLayout@Gui@Seiscomp@@6BQLayoutItem@@@; LNK1120: 2. Existing seiscomp_qt.dll exports both exact vtables (logs/p8-wingui04c-stdout/qt-exports.log). Smallest clean proposed correction: Windows-only omit local flowlayout.cpp compilation and link existing internal qt alongside core. NOT APPLIED; separate authorization required.

Raw build/warnings: logs/p8-wingui04c-stdout-scconfig.log; actual exit: corresponding .exit_code.txt. Command: VS-bundled cmake --build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target scconfig -- /m:1. Analysis: logs/p8-wingui04c-stdout/linker-errors.json. Successful scconfig executable architecture/SHA-256 unavailable; recursive DLL closure NOT CHECKED; staging BLOCKED (not prepared).

Final Qt inventory 10/11 built, milestone incomplete: logs/p8-wingui04c-stdout/final-gui-build-inventory.json and .csv; ten existing executable hashes/stage existence reverified. Frozen pinned HEAD/status/tracked-file hashes unchanged; protected prior executables/staging/patches unchanged: logs/p8-wingui04c-stdout/preservation.json and frozen-before/after.json. No further source changes, dependency upgrades, application/service execution or runtime preflight.

Engineering only; numerical/scientific/runtime/release evidence NOT RUN, Phase5A gates unchanged. Broader confirmed blockers remain runtime network isolation, socket/TLS correctness, Hypo71 native Fortran configuration, database/release closure and scientific parity.


## P8-WINGUI-04D — GUI/Qt executable build milestone complete — 22 October 2026

FlowLayout ownership PASS: matching DLL exports and import-library symbols (constructors, destructor, both vtables and methods); same implementation/header, no local MOC conflict. Raw evidence: logs/p8-wingui04d/ownership.json, qt-dll-exports.log, qt-lib-symbols.log. Windows-only CMake correction PASS: exclude local flowlayout.cpp and link internal qt; non-Windows retains original source. Exact patch: patches/P8-WINGUI-04D-scconfig-flowlayout.patch, SHA-256 `E106CFA7FEE235BBFB7722B4B3A572C28E39BA73A2230AB25D92714D0102F24D`; full diff below. Patch check/application exit 0. Generated scconfig project has no flowlayout.cpp and links seiscomp_qt.lib (generated-ownership.json).

scconfig build PASS, actual exit 0, MSVC Release x64. Existing VS-bundled cmake --build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target scconfig -- /m:1 automatically regenerates existing cache/project files. Raw configuration/build/warnings: logs/p8-wingui04d-scconfig.log; actual exit: logs/p8-wingui04d-scconfig.exit_code.txt. No dependency upgrades, no additional source corrections, no /FORCE or error suppression.

Executable architecture: AMD64 PE32+ (machine 0x8664, optional-header 0x20B); SHA-256 `3B8A33D6D1A216552BDFACCBD25E561BE56F4703ED8584B005A65207E9194CA7`. Recursive static private DLL closure PASS at Windows/API-set boundary. Staging READY for binaries only: staging/scconfig-offline, 31 PE binaries, matching Qt 5.15.18.0 qwindows plugin; local qt.conf and SHA256SUMS.txt. Per-file import/header logs, package provenance, hashes, Qt versions and OS dependencies: logs/p8-wingui04d/scconfig/deployment.json and adjacent raw dumpbin logs. Runtime-loaded optional plugins/data not validated.

Final Qt executable inventory **11/11 built**: logs/p8-wingui04d/final-gui-build-inventory.json and .csv; all executable hashes and stage existence verified. The identified Phase 8 GUI/Qt executable **build milestone is complete**. Frozen pinned HEAD/status/file hashes and protected successful baselines unchanged (logs/p8-wingui04d/preservation.json, frozen-before/after.json). No applications/services executed; no blocked runtime preflight repeated or operational access performed.

No remaining confirmed compiler/linker blocker in this 11-target inventory. Broader runtime network isolation, socket/TLS correctness, native Hypo71 Fortran route, database/release closure and scientific parity remain open as previously recorded. Engineering build evidence only; numerical/scientific/runtime/release validation NOT RUN. Phase5A gate register unchanged; no full SeisComP completion claim.


## P8-WINBACKEND-01 — backend inventory and first build — 22 October 2026

Completed source/generated-solution inventory: 107 active native backend/support targets (62 executables, 40 DLL targets, 5 static libraries), excluding 11 completed GUI executable targets; six additional source targets disabled. Current classifications: **7 already built, 97 available unbuilt, 3 Windows/configuration blocked, 6 disabled**. Built baselines: scautoloc, seiscomp_core/client/config/qt/mvx, tau_internal. Backend executable subset: 1 built, 59 available unbuilt, 2 blocked; disabled Hypo71PC additional. Existing artifact presence is not runtime validation. Exact names, source units and project dependencies: logs/p8-winbackend01/backend-target-inventory.json/.csv/.md. Stale projects excluded from current SeisComP.sln membership (including stale hypo71 project).

First priority build **scmaster FAIL**, actual exit **1**; compilation reaches seiscomp_broker, then LNK2019 on Wired::toString(Socket::IPAddress const&), LNK1120: 1. Exact symbol, source/object provenance and raw provider checks in logs/p8-winbackend01/proposal.json, core-socket-object.log, core-exports.log, core-import-library.log, linker-errors.json. Function is defined in core socket.cpp object but absent from DLL exports/import library; header socket.h:366 lacks SC_SYSTEM_CORE_API. No algorithm defect or replacement implementation required. Raw build/warnings/exits: logs/p8-winbackend01-scmaster.log and .exit_code.txt. Exact invocation: existing VS-bundled cmake --build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target scmaster -- /m:1. No new successful backend executable/DLL, architecture/hash/recursive closure for new products NOT AVAILABLE/NOT CHECKED. No further target builds after independent blocker.

Prepared **unapplied**, one-line header export proposal: native-working-copy/phase8-proposals/P8-WINBACKEND-01-wired-toString-export-proposed.patch, SHA-256 `54FF3D32B9992084624AF4A7C694A515E0DEDC681EA69FBF56555B14529D7267`; git apply --check exit 0. Requires separate operator source-change authorization. No actual source changes applied.

OpenSSL audit: 85 active generated Release link sections inspected. scmaster/broker/core use C:/vcpkg/installed/x64-windows/lib/libssl.lib and libcrypto.lib; prior actual core linker command confirms these paths (core-last-link-command.txt). Failed broker command tlog is empty; generated broker Release link paths are the available evidence. **One real mismatch: caps_plugin Release links C:/vcpkg/installed/x64-windows/debug/lib/libcrypto.lib and libssl.lib**, through raw CRYPTO/SSL variables. Configuration-wide debug discovery messages do not establish every target's Release linkage. See openssl-release-linkage.json and openssl-summary.json. Separate unapplied CMake proposal replaces the two raw variables with existing OpenSSL::Crypto/OpenSSL::SSL targets, preserving installed versions: native-working-copy/phase8-proposals/P8-WINBACKEND-01-caps-openssl-targets-proposed.patch, SHA-256 `8CC6483AB8D20C6EB669770EFDD4593ACBE44ED3EEBDB5A9AFAE6DA100E05863`, check exit 0. No dependency or CMake source change applied.

Disabled: dbmysql/dbpostgresql/dbsqlite3; Hypo71PC/hypo71 (SC_IPGP_HYPO71=OFF; native Fortran route external blocker); iloc (OFF; LAPACK unqualified). SQLite event-ID cache in scevent is enabled with project-local native sqlite3.lib and is separate from disabled DB adapter. MySQL client dev dependency absent in prior discovery; PostgreSQL client/server not qualified. Additional acquisition/external locator POSIX paths and existing socket-width/TLS limitations remain unqualified, not newly failed builds.

Recommended next implementation batch: approve the single core export, build scmaster then its dbstore/dbg-delay plugins; separately approve CAPS imported-target correction, then seedlink/slarchive/slinktool/caps_plugin; proceed to scautopick/scamp/scmag/scevent and inventory/configuration tools, stopping at first new independent portability error. Keep native Fortran/LAPACK/database adapter closure as separate dependency decisions.

Preservation evidence: logs/p8-winbackend01/preservation.json and frozen-before/after.json; all prior successful GUI/backend baselines, patches/manifests/staging and vcpkg package status unchanged, no working-copy tracked diff changes. No applications/services executed, runtime preflights or operational connections. GUI milestone remains 11/11. Engineering inventory/build evidence only; numerical/scientific/runtime/release evidence NOT RUN, full SeisComP completion not claimed; Phase5A gates unchanged.


## P8-WINBACKEND-02 — messaging/acquisition batch — 22 October 2026

Applied only the exact approved patches after SHA-256, exact file/line scope, git apply --check, application, reverse-check and expected postimage verification:

| Approved patch | SHA-256 | Changed file |
|---|---|---|
| Wired helper export | 54FF3D32B9992084624AF4A7C694A515E0DEDC681EA69FBF56555B14529D7267 | common/libs/seiscomp/wired/devices/socket.h (one export annotation) |
| CAPS imported targets | 8CC6483AB8D20C6EB669770EFDD4593ACBE44ED3EEBDB5A9AFAE6DA100E05863 | seedlink/plugins/caps_plugin/CMakeLists.txt (two link inputs) |

Patch provenance/check/application records: logs/p8-winbackend02/{common,seedlink}-{check,apply,reverse-check,patch}.json. Exact applied patch copies: patches/P8-WINBACKEND-02-approved-{wired-export,caps-openssl}.patch.

| Target | Result | Evidence / independent root |
|---|---|---|
| seiscomp_broker | PASS, focused exit 0; **one newly completed target** | seiscomp_broker.log/.exit_code.txt; original broker build success also in scmaster.log |
| scmaster | FAIL, exit 1 | scmaster.log/.exit_code.txt; LNK1120: 8, missing Wired interfaces and application-local ServerStatistics destructor/vtable incorrectly imported from broker DLL |
| dbstore | FAIL, exit 1 | dbstore.log/.exit_code.txt; getConfig<bool> and getConfig<std::string> missing from core DLL imports |
| dbg-delay | FAIL, exit 1 | dbg-delay.log/.exit_code.txt; unistd.h missing; source uses POSIX usleep |
| caps_plugin | BLOCKED, configure/generate exit 1 | configure.log/.exit_code.txt; OpenSSL::Crypto target not created in CAPS directory scope by legacy FindOpenSSL.cmake |
| seedlink | BLOCKED / executable NOT BUILT | seedlink-dependency-block.json; slplugin failed; independently inspected slutils also failed |
| slarchive, slinktool | BLOCKED / executables NOT BUILT | corresponding dependency-block.json; shared slink failed |
| slplugin | FAIL, exit 1 | slplugin.log/.exit_code.txt; plugin.c:17 unistd.h missing |
| slink | FAIL, exit 1 | slink.log/.exit_code.txt; D8021: GNU -Wno-incompatible-pointer-types passed to MSVC |
| slutils | FAIL, exit 1 | slutils.log/.exit_code.txt; utils.cc/conf_xml.cc unistd.h, utils.h sys/time.h, generated scanner FlexLexer.h |

No new executable completed; one new support DLL (broker) completed. Existing core DLL rebuilt as required by the approved export; it is not counted as a new target.

Broker: AMD64 PE32+, SHA-256 `44ED78346E48127A234A3794C17BA0BB114BF7DF56EABDBCE338EFA2262E69A3`; recursive static private DLL closure PASS at Windows/API-set boundary. Rebuilt core: AMD64 PE32+, SHA-256 `AD01A1EF3DE078AAAC3350DE448FD0A2F4481F95341DA518B1641AC45A0436B9`, same static closure PASS. Raw dumpbin headers/dependents and recursive records: logs/p8-winbackend02/artifacts/{seiscomp_broker,seiscomp_core}/. Runtime NOT RUN; optional runtime-loaded plugins are outside static closure.

Release OpenSSL verification for CAPS **BLOCKED**, not PASS. The reviewed two-line patch depends on imported targets that the local legacy module does not define. Fresh regeneration failed; caps-release-linkage.json preserves generated link fields but they are not accepted as valid inputs. Configuration remains generation-blocked pending the proposed Windows CONFIG-discovery correction. No debug dependency silently accepted; no dependency upgrade. Existing core/broker Release artifacts were built before this CAPS generation failure with Release OpenSSL paths as previously audited.

After the unrelated CAPS generation failure, independent acquisition prerequisites were built directly through existing VS Release x64 projects with BuildProjectReferences=false. Their actual project dependencies were explicitly scheduled in order; global ZERO_CHECK regeneration alone was omitted. This is recorded in *-command.json. No compiler or linker errors were suppressed, no /FORCE, and no missing prerequisite was treated as successful. SeedLink/archive executable targets were stopped at failed prerequisites. Broker's focused exit-0 record uses the same existing-project route with its successfully built dependencies.

Follow-up **unapplied** proposals (all exact file scopes and git apply --check exit 0 in proposals.json):

- `P8-WINBACKEND-02-scmaster-linkage-proposed.patch` — SHA-256 `66F5D0727427E46145966C3B0CB37251AA866FCE693D7117F5CE4E39C4AB9F80`. Export five currently unresolved Wired interfaces from their core provider; remove broker dllimport annotation from application-local ServerStatistics. No algorithm changes.
- `P8-WINBACKEND-02-settings-exports-proposed.patch` — SHA-256 `464D14492917BD3901B8D878D107442FDBBC960D86FC3527B8062CEFAB4056F3`. Declare existing int/bool/string getConfig specializations as exported/imported. dbstore currently needs bool/string; dbg-delay fields use int. Existing implementations preserved.
- `P8-WINBACKEND-02-dbg-delay-msleep-proposed.patch` — SHA-256 `3C5D312A828C2C167D1BD97B0AB519EE8441D5E781477B47F4647F8EA06FBF70`. Use existing exported Core::msleep in milliseconds on Windows; retain POSIX code elsewhere.
- `P8-WINBACKEND-02-acquisition-cmake-proposed.patch` — SHA-256 `E6BBA67F8EB0506723BFB0E66E29D79E4C61078011ED82BED839E898BCFC0E15`. Create OpenSSL imported targets in CAPS scope using existing Windows CONFIG discovery pattern; limit GNU/Clang-specific C flag to supported compilers. No library/version changes.
- `P8-WINBACKEND-02-slutils-flex-header-proposed.patch` — SHA-256 `68703BA74247828CE1A7D597166C1E5DFB0EA88BA1431A85163B0F2D62EAB0A9`. Expose the already approved project-local FlexLexer.h beside configured win_flex.exe; no new dependency.
- `P8-WINBACKEND-02-slplugin-crt-write-proposed.patch` — SHA-256 `0BD601A349495CE6DC4CD647208E3C24CD223EB11C0E2C5502FE008BC27EBD43`. Windows native CRT _write for the same bounded packet descriptor writes; explicit int32_t and signed byte-count types. Retain POSIX path. Does not implement parent/child FD 63 inheritance or validate packet ABI.

slutils additionally requires a native descriptor/timeout design: CRT file/pipe descriptors cannot be passed to Winsock select. Replacing sys/time.h with Winsock or adding a success stub would not preserve semantics. slutils-native-port-proposal.md records source-backed boundaries for read/write, timed pipe writes, wall-clock Timer, XML file descriptors and syslog. The Flex header proposal fixes only its independent include-path problem. Native parent/child FD 63 inheritance and packet ABI are unvalidated.

Next implementation batch: approve the acquisition CMake discovery/compiler-flag correction to restore generation; approve grouped messaging export/ownership, settings specializations and dbg-delay sleep patches; rebuild messaging and plugins. Then approve/implement native acquisition descriptor transport and Flex include correction; retry acquisition prerequisites before dependent executables.

Preservation: all nine frozen repos match pinned HEAD/status and full tracked-file SHA-256 before/after. Prior GUI executables/staging/manifests/patches and vcpkg status unchanged. Original Release binaries/libraries copied and hash-verified in phase8/baselines/p8-winbackend02-before before the required core rebuild. Only the two approved tracked source files changed. Evidence: frozen-before/after.json, archived-build-baselines.json, protected-before.json, working-source-before.json, preservation.json. No application/service execution, networking, production connection, GUI runtime preflight or scientific-algorithm modification.

Engineering evidence only. Numerical/scientific/runtime/release evidence NOT RUN; Phase5A gates unchanged. GUI executable build milestone remains 11/11. Full SeisComP installation/completion is not claimed.

Updated non-GUI inventory totals (native applications, DLLs and static support targets plus six disabled source entries): {"Blocked by Windows portability": 10, "Already built": 8, "Available but unbuilt": 89, "Disabled by CMake configuration": 6}. Exact rows: logs/p8-winbackend02/backend-target-inventory.json and .csv.


## P8-WINBACKEND-03 — messaging recovery and acquisition portability — 22 October 2026

CMake configure/generate **PASS**, actual exit **0**, existing VS2022 Release x64 build configuration. Raw log and command: configure.log, configure.exit_code.txt, configure-command.json. CAPS generated Release linker inputs **PASS**: C:/vcpkg/installed/x64-windows/lib/libcrypto.lib and libssl.lib; no debug OpenSSL paths (caps-release-linkage.json, caps-release-linkage-final.json). Later CMake regeneration during the slinktool build also succeeds. CAPS executable itself is NOT BUILT because prerequisites remain blocked.

All six exact operator-approved patches applied after independent SHA-256, numstat/file-scope and git apply --check verification. Reverse checks exit 0. Symbol ownership verified against existing core definitions (IPACL/BindAddress/IPAddress and getConfig specializations), application-owned ServerStatistics implementation, exported Core::msleep, native CRT packet writes, and existing Windows OpenSSL CONFIG discovery pattern. No replacement algorithms. Patch scope and before/after file hashes: applied.json; raw check/application/reverse-check records 1-6-*.json. Original notices retained.

| Patch | Exact SHA-256 | Changed files relative to component repository |
|---|---|---|
| P8-WINBACKEND-02-acquisition-cmake-proposed.patch | `E6BBA67F8EB0506723BFB0E66E29D79E4C61078011ED82BED839E898BCFC0E15` | plugins/caps_plugin/CMakeLists.txt, CMakeLists.txt |
| P8-WINBACKEND-02-scmaster-linkage-proposed.patch | `66F5D0727427E46145966C3B0CB37251AA866FCE693D7117F5CE4E39C4AB9F80` | libs/seiscomp/wired/ipacl.h, libs/seiscomp/wired/server.h, libs/seiscomp/wired/devices/socket.h, apps/messaging/scmaster/statistics/statistics.h |
| P8-WINBACKEND-02-settings-exports-proposed.patch | `464D14492917BD3901B8D878D107442FDBBC960D86FC3527B8062CEFAB4056F3` | libs/seiscomp/system/settings.h |
| P8-WINBACKEND-02-dbg-delay-msleep-proposed.patch | `3C5D312A828C2C167D1BD97B0AB519EE8441D5E781477B47F4647F8EA06FBF70` | apps/messaging/scmaster/plugins/dbg-delay/dbg-delay.cpp |
| P8-WINBACKEND-02-slutils-flex-header-proposed.patch | `68703BA74247828CE1A7D597166C1E5DFB0EA88BA1431A85163B0F2D62EAB0A9` | libs/slutils/CMakeLists.txt |
| P8-WINBACKEND-02-slplugin-crt-write-proposed.patch | `0BD601A349495CE6DC4CD647208E3C24CD223EB11C0E2C5502FE008BC27EBD43` | libs/plugin/plugin.c, libs/plugin/plugin.h |
| P8-WINBACKEND-03-slinktool-access-mode.patch | `6CF7BC5DED092330C0DF2C4A0983F614A7F775184C40C2907C7C4D2AD10DF5F1` | apps/3rd-party/slinktool/src/dsarchive.c |
| P8-WINBACKEND-03-libslink-native-link.patch | `E31526691F793618CBD4337AE49B91561E7CF7FE0A249D2A841E0F49C46E37ED` | libs/3rd-party/libslink/CMakeLists.txt, libs/3rd-party/libslink/statefile.c |

The last two patches are additional low-risk self-contained Windows corrections authorized by the current operator instruction: F_OK=0 for the existing access existence check; transitive ws2_32 linkage and CRT _chsize(fd,0) for the existing truncate-to-zero state-file operation. No dependency upgrade or protocol/scientific algorithm change. All exact diffs are retained in phase8/patches and hashes above.

| Target | Build | Architecture / closure |
|---|---|---|
| scmaster | PASS, exit 0 | AMD64 PE32+, recursive static DLL closure PASS |
| dbstore | PASS, exit 0 | AMD64 PE32+, recursive static DLL closure PASS |
| dbg-delay | PASS, exit 0 | AMD64 PE32+, recursive static DLL closure PASS |
| slinktool | PASS, final exit 0 | AMD64 PE32+, recursive static DLL closure PASS |
| slink | PASS, exit 0 (also rebuilt for slinktool) | AMD64 COFF static archive |
| mseed | PASS, exit 0 | AMD64 COFF static archive |
| slplugin | FAIL, exit 1 | approved C-only packet writer portability advances, C++ plugin_channel still includes blocked shared slutils/time interfaces |
| slutils | FAIL, exit 1 | unistd.h/sys/time.h still unavailable; FlexLexer include problem cleared |
| slarchive | FAIL, exit 1 | sys/resource.h and dirent.h; real glob/resource/directory usages confirmed |
| caps_plugin / seedlink | BLOCKED / NOT BUILT | actual slplugin/slutils prerequisites unavailable |

All focused build commands are *-command.json; actual outputs and exit codes are <target>.log and <target>.exit_code.txt. New executable/DLL header/import dumpbin logs and complete recursive resolution are artifacts/<target>/. Static archives have <target>-coff-headers.log and <target>-artifact.json. Closure PASS means static private import recursion with Windows/API-set boundary, not optional runtime-loaded plugin or application configuration closure.

Newly completed **6 targets: 2 executables, 2 DLL plugins, 2 static libraries**. Core and broker rebuilds are existing targets and are not counted as newly completed. No GUI executable target rebuilt. Binary hashes:

- scmaster: `E89E87E29DCF264DB024047B38D7C810F4938EAF2405D8DF21F9FCD40CB90384`
- dbstore: `8C06B8BC1D66174DF97450D4FA6DC7B12FA29776B70912195FCAC1780D6BBF9C`
- dbg-delay: `17BFB96F315BDE6888AFAED3E91D52243F00B7DF7B72C5F06A99314E383DE096`
- slinktool: `860E48CC2B507C49384DA1C6FB888C55C1E519EB9D01455A861C29C7C8BAAA82`
- slink: `F6B70A9950B20D9EF0EE1DF7FB7ABF22693322923F642FA27F7F600C8ACF5FC5`
- mseed: `B37F561BD32E32D9022868D43744A897D0E2CD5AD4FC6E56A8EBBB7F368A27D0`

Remaining implementation blockers:

1. slutils/slplugin: actual file/pipe/time utilities and mixed readiness. Native Winsock select cannot consume CRT file/pipe descriptors. No fake header, no-op transport or success stub introduced. Native-acquisition-transport-proposal.md is a coherent source-backed architecture proposal for separate approval: typed CRT/HANDLE/SOCKET endpoints, overlapped byte pipes, process/handle whitelisting, child-local FD63 bootstrap in binary mode, partial frames/byte counts, timeout cancellation/error mapping, wall-clock vs wait-clock separation, cooperative stop/escalation and ownership/EOF lifetime. Existing source hashes: transport-source-provenance.json. This design is NOT applied and NOT runtime tested. It includes chain_plugin timed-write call sites, not only SeedLink's main pipe.
2. Confirmed libslink width defect remains: SOCKET is a Windows typedef, but #ifndef SOCKET currently shadows it with int. The separately checked one-line source patch is intentionally UNAPPLIED because it changes the public socket/SLCD ABI and requires architecture approval and all-consumer rebuild. A successfully linked x64 slinktool is not proof of correct socket-width behavior.
3. slarchive: source-backed filesystem/resource/OpenSSL proposal in slarchive-portability-proposal.md. Preserve certificate verification and archive ordering; do not substitute empty directory/glob results. An existing pointer-from-globfree lifetime concern is documented as static inspection, not a runtime/sanitizer result.

Socket-width proposal: `P8-WINBACKEND-03-libslink-socket-width-proposed.patch`, SHA-256 `1220DD0B86AA8ED49EA35F8E7E3025F38A7158985EADE5924C5521E99106B4A2`; git apply --check exit 0, not applied.

Next recommended batch: review/approve the typed acquisition transport and socket-width source patch; implement native slutils/child launch/FD63/readiness/timeout paths as a coherent series and rebuild all acquisition consumers. Independently implement the source-backed slarchive filesystem/resource/OpenSSL group. Then complete slplugin/slutils before CAPS/SeedLink. No messaging source blocker remains in the three requested targets.

Evidence limitation: the first slinktool F_OK failure's complete raw log was overwritten by the next focused build before per-attempt archiving was enabled. Its exact initial compiler diagnostic is retained in initial-slinktool-diagnostic.txt and the tool transcript, not presented as a full log. Subsequent failed link output is preserved in attempts/, and the successful final build has its complete raw log/exit. All build warnings are otherwise retained; no warning/error was suppressed.

Preservation: nine frozen repositories match pinned HEAD/status and tracked-file hashes before/after; protected GUI binaries/staging/manifests/patches and package status unchanged. Original build binaries/libraries were archived with hashes in phase8/baselines/p8-winbackend03-before before rebuilding providers. Exact modified source scope is accounted for by applied.json and preservation.json. No application/service execution, live data, networking, production system access, GUI runtime preflight or scientific-algorithm modification. Engineering build evidence only; numerical/scientific/runtime/release evidence NOT RUN; existing Phase5A gate register remains unchanged. GUI milestone remains 11/11; full native SeisComP installation is not complete.

Updated backend/support inventory totals: {"Already built": 14, "Available but unbuilt": 88, "Blocked by Windows portability": 5, "Disabled by CMake configuration": 6}. Exact rows in backend-target-inventory.json/.csv.

## P8-WINBACKEND-04 — native acquisition implementation/build progress — 22 October 2026

Nine newly completed targets: six executables (seedlink, caps_plugin, fs_plugin, slarchive, load_timetable, scautopick), three static libraries (seedlink_native, slutils, slplugin); no new DLL. slink/slinktool rebuilt after the exact approved SOCKET-width patch. Focused Release x64 builds and recursive static PE DLL closure PASS for successful executables; raw logs, architectures and hashes: logs/p8-winbackend04/REPORT.md. CMake generation and actual CAPS Release OpenSSL linkage PASS; no debug OpenSSL libraries or dependency upgrades.

Windows typed transport, CreateProcessW/FD63 bootstrap, cancellation-safe byte-pipe I/O, cooperative-stop/job escalation, CAPS and FS child adapters, server readiness and slarchive native filesystem/resource paths implemented. Linux branches and scientific algorithms preserved. Acquisition portability remains PARTIAL: chain workers/extensions and mseedfifo external transport need the documented separate contract proposal; 6/8 socket-ABI consumers build. scamp/scmag fmt mode and scevent local-DLL/macro errors have narrow unapplied proposals.

Backend/support inventory 23/114 built, 80 available/unbuilt, 5 Windows-blocked, 6 disabled (new denominator includes seedlink_native). GUI 11/11 preserved. Nine frozen sources, 468 protected files and original build archives verified unchanged. No applications/services/network/runtime preflights executed; build success is not runtime, scientific or release validation. Details, 53-file scope, patch hashes and next batch: logs/p8-winbackend04/{REPORT.md,applied.json,backend-target-inventory.json,follow-up-proposals.json,remaining-contract-proposal.json,preservation.json}.


Detailed template-aligned engineering/custody/build/limitation evidence: phase8/logs/p8-winbackend04/REPORT.md. Phase5A gate states remain unchanged; runtime, numerical, scientific and release qualification are NOT RUN. Earlier chronological build-failure prose is superseded only by the concrete engineering records in this update.


## P8-WINBACKEND-06C — conditional STOP qualification — 23 October 2026

Cooperative STOP **BLOCKED / NOT IMPLEMENTED** under the operator's Section B
stop-and-amend instruction. Source verification found no common main-loop STOP
dispatcher across Client, Qt, broker and ew2sc; worker broadcast would not marshal
callbacks, Client queue insertion may block, and endpoint security/publication/
lifetime remain unimplemented. A concrete restricted Client-loop contract
amendment is prepared; no native patch, build, application/service execution or
forced-termination policy was applied. All 06A/06B sources/build products preserved.

06D scope records CPython 3.10.11 x64 interpreter versus legacy 3.14.2 header/lib
cache conflict, Windows .pyd packaging, native frontend/DLL search and module
qualification work. Preserve configured 3.10 ABI; no dependency upgrade.
15 handler/base/template sources inventoried statically; no deployment/runtime PASS.

Inventory remains **73/114 backend/support built; 19 available, 14 Windows-blocked,
2 dependency-blocked, 6 disabled; GUI 11/11**. New/rebuilt targets zero. Current
control/deployment inventory: phase8/inventory/P8-WINBACKEND-06C-control-status.json.
Nine frozen Windows snapshots, original pinned Ubuntu-24.04 sources, 813 protected
files and 204 Release products verified unchanged. Report, amendment hashes,
source evidence, raw audit logs/exits and 06D scope: phase8/logs/p8-winbackend06c/.
Phase5A PARTIAL; numerical/scientific/runtime NOT RUN; release NOT QUALIFIED.


## P8-WINBACKEND-06C1 — approved restricted Client STOP — 23 October 2026

Implemented explicit Windows Client-loop opt-in and first scautoloc entrypoint
enrollment, protected same-user/session event endpoints with receipt/process/
creation/lock/token/ACL verification, bounded nonblocking queue commit/cancel,
owner-thread original termination dispatch, queued-only acknowledgement and
same-handle actual exit observation. Listener is cancelled/joined before queue
destruction. No forced termination, generic reload or Application layout change.
06A/06B launch/locks/Job Objects and Linux source projections preserved.

seiscomp_core, seiscomp_client and scautoloc focused MSVC Release x64 builds exit 0;
AMD64 PE32+, recursive static DLL closure and named provider import/export checks
PASS with raw evidence. Source/build integration complete; runtime NOT RUN.
Only scautoloc is enrolled. Qt, broker, ew2sc, generic System, acquisition and
Python/Twisted remain unsupported. Metadata cleanup now checks actual verified
process exit even after early PID-lock release.

Inventory unchanged: **73/114 backend/support built, 19 available, 14 Windows-blocked,
2 dependency-blocked, 6 disabled; GUI 11/11**. Four existing rows refreshed, including
the rebuilt config prerequisite; new targets zero.
Frozen originals/snapshots, protected archives/staging, dependency
status, ew2sc proposal and 06D scope preserved. One custody exception: the prior
active seiscomp_config.dll was not copied before its transitive rebuild and exact
archive recovery failed; before/after hashes are recorded and active-build
preimage custody is INCOMPLETE. Seven other changed products are archived.
Python wrappers remain OFF;
mixed 3.10/3.14 ABI discovery remains 06D work. No application/service/operational
test executed. Phase5A PARTIAL; numerical/scientific/runtime NOT RUN; release
NOT QUALIFIED. Details, exact source/patch/build hashes and logs:
phase8/logs/p8-winbackend06c1/REPORT.md and 06c1-batch-evidence.json.

## P8-WINBACKEND-06D — native controller development stage — 23 October 2026

Windows-only CPython 3.10.11 x64 Release compatibility bridge aligns legacy headers/import libraries with the established interpreter. Interpreter/header/import-library architecture and version checks plus a Release compile/link probe pass; an isolated mixed-ABI CMake configuration is rejected. General SDK and NumPy wrappers remain OFF. Original SWIG 4.4.1 _config source and config.py are unchanged.

Three new focused targets build with exit 0: _config.pyd, seiscomp_controller (seiscomp.exe) and seiscomp_python (seiscomp-python.exe). AMD64 PE32+, PyInit__config/python310.dll imports and recursive private DLL closure PASS with raw evidence. Native wide-argument CPython embedding sets root, Python home, package paths and DLL directories before loading the original controller; original CreateProcessW/locks/receipts/Job Objects/restricted STOP remain unchanged. Windows setup/update-config/aliases/reload/scheduling have explicit limitations; print env emits PowerShell assignments. Non-Windows source/AST projections and scientific sources preserved.

Isolated stage: phase8/staging/controller-06d-native; 20 PE files, original Python package, verified current providers, existing scautoloc binary, original defaults/example data, Python identity, dependency/file manifests and capability matrix. Only config-only kernel and original scautoloc init handlers are registered; no auto/run/PID markers. The pinned external Python310 standard library/DLLs/executable remain required; this is not a relocatable or operational installation. Matrix covers 17 commands, the existing 15 handlers and one explicit scmaster DB-helper supplement omitted by the prior pattern inventory.

Inventory **76/117 built: original 73/114 unchanged plus 3 newly enumerated controller targets**; 19 available, 14 Windows-blocked, 2 dependency-blocked, 6 disabled. GUI remains 11/11. Stale GUI providers recorded for synchronized future packaging; existing 11 stages unchanged.

All 204 current pre-build Release products archived/hash-verified; no old Release product changed. Nine frozen snapshots, 824 protected files, 13 exact 06C1 source postimages, vcpkg status and ew2sc proposal preserved. Historical 06C1 config-DLL preimage custody gap remains INCOMPLETE/unresolved. No application/controller/extension import, service, GUI, network, DB or scientific execution. Runtime/numerical/scientific NOT RUN; release NOT QUALIFIED; Phase5A PARTIAL.

Exact patch SHA-256: `01C75D67DFF8F7CBC86D76D62746887E3EDBFB861AD63D9C5E933A48A72FC49F`. Evidence: phase8/logs/p8-winbackend06d/{REPORT.md,applied-patches.json,artifact-evidence.json,deployment.json,capabilities.md,preservation.json,stale-gui-providers.json}. Recommended next development: scoped common Python configuration bindings/adapters and command error aggregation; separately authorized isolated frontend/import/lifecycle integration afterward. Broader STOP/reload contracts remain separate.

## P8-WINBACKEND-06E — controller commands and binding blockers — 23 October 2026

Windows enable/disable/status now validate selections, aggregate failures/exceptions, verify marker postconditions and report required-but-stopped status as failure. Existing check/print env and launch/STOP/restart are preserved. Python/C++ user config selection is aligned through explicit SEISCOMP_LOCAL_CONFIG. Narrow original _core/_logging/_system CMake targets implemented; all three builds FAIL (exit 1): five missing core exports, unavailable SyslogOutput wrappers, five missing SchemaStructExtent exports respectively. No new binding built; no placeholder implementation or provider/algorithm changes. Exact symbols and focused UNAPPLIED follow-up requirements: logs/p8-winbackend06e/binding-blockers.json and follow-up-contracts.md.

Separate controller-06e-native stage preserves all 20 original PE products and adds corrected controller source/capabilities/manifests. No additional handlers activated or runtime qualification. Inventory 76/120 built (original 73/114 plus three completed 06D targets; three newly enumerated 06E blocked targets), 19 available, 17 Windows-blocked, 2 dependency-blocked, 6 disabled; GUI 11/11 unchanged. All 207 active Release preimages archived/hash-verified; no existing Release product changed. Frozen/protected/06C1 source preservation PASS. Historical config DLL custody remains INCOMPLETE. External Python310 required; runtime/science NOT RUN; release NOT QUALIFIED. Patch SHA-256 1FA5820AE435BB5F2C372ED08A5BF9B1760185800BED7117FC846CD1E3B3DB6F. Evidence: phase8/logs/p8-winbackend06e/REPORT.md. Phase5A PARTIAL.

## P8-WINBACKEND-06E1 — original Python binding recovery — 23 October 2026

_core, _system and _logging build PASS (actual exit 0), AMD64 PE32+, correct PyInit exports/python310.dll imports, matching provider exports/imports and recursive private DLL closure. Existing Time ostream declaration/SchemaStructExtent export annotations and explicit original NumericArray TypeInfo instantiations repair ten missing exports. All former core exports preserved. Windows-only SyslogOutput exclusions align generated C++/Python bindings to the original native provider; original POSIX code preserved, no SWIG regeneration, stub or destination mapping. No algorithm/type/layout/serialization change.

Separate controller-06e1-native stage uses 06E baseline, three original extensions/Python sources and matching refreshed core DLL. Existing controller/frontend/_config/launch/locking/restricted STOP unchanged. No modules activated or controller guards lifted. Inventory 79/120 built (original backend 73/114; six completed controller targets), 19 available, 14 Windows-blocked, 2 dependency-blocked, 6 disabled; GUI 11/11 unchanged. All 207 pre-build Release products archived before build; changed provider products recorded in preservation.json. Historical config DLL preimage custody remains INCOMPLETE. Runtime/science NOT RUN; release NOT QUALIFIED. Exact patch SHA-256 4D401EF2087070E0C57CAC083ACD3ADE06B098E12338C1F5382F4946575BAEFE. Details: phase8/logs/p8-winbackend06e1/REPORT.md.

## P8-WINBACKEND-06F — configuration integration — 23 October 2026

Original print variables path enabled through recovered System bindings. Explicit --stdin setup kernel now uses the original filesystem-only kernel setup handler, validates selection before any action, propagates read/parse/write failures and does not mark the entire installation initialized. Original Config parsing/key/removal behavior retained. No interactive/kernel schema fabricated; setup all/mixed/service handlers and update-config remain explicitly guarded with exact dependency reasons. Kernel description metadata added unchanged. Original installation root, local-config override and six-stage C++ configuration precedence are preserved. Management aggregation/launch/ownership/Job Objects/restricted STOP unchanged.

New controller-06f-native stage preserves 23 matching 06E1 PE products, package/configuration/data paths and pinned external Python3.10 prerequisite, with current source graph/capabilities/dependency/SHA manifests. No binary compilation required; inventory remains 79/120, GUI 11/11. All 207 active Release providers/import libraries archived and unchanged; frozen/protected baselines preserved. Historical config-DLL custody INCOMPLETE. Patch SHA-256 41082DCD396568940445F27A65AFCFF38A453E8372CA96A1702F282222A49D4F. Runtime/scientific NOT RUN; release NOT QUALIFIED. Report: phase8/logs/p8-winbackend06f/REPORT.md. Next work should move to backend acquisition/quality-control/database closure, not indefinite controller expansion.

## P8-WINBACKEND-07B — original native database adapters — 23 October 2026

Two new targets, dbsqlite3 and dbpostgresql, build exit 0 in the isolated VS2022 Release x64 database tree using original target definitions/macros and existing imported core. SQLite reuses approved 3.54.1 /MD/threadsafe static archive; PostgreSQL uses installed 18.1 native client SDK. Both are AMD64 PE32+, export createSCPlugin with original factory registrations, and pass recursive static private DLL closure and named import/export checks. Shared PostgreSQL/SeisComP DLL names explicitly select the existing SeisComP providers; no stage/PATH/dependency installation changes. Runtime loading, schema and persistence NOT_RUN.

Windows-only PostgreSQL uint64 scan width correction preserves Linux branch; source patch SHA-256 23B0813DD88EA7780C1AF5BFE4A30562B0A8CD3913C8C38D42715778AD568F18. Build-harness patch SHA-256 AB1D466F3AC5C81010B84EE7FC0D0FE38CEB149442FF438BD81CF15C8BFC498D. MySQL SDK unqualified; exact requirements/plan recorded without provisioning. Inventory: 81/120 built, 22 Windows-blocked, 13 dependency-blocked, 4 disabled; GUI 11/11. All 237 prebuild Release outputs including nested Tau/SQLite and protected baseline files unchanged. Historical config custody INCOMPLETE and prior 07A Tau exception retained. Report/evidence: logs/p8-winbackend07b/REPORT.md.

## P8-WINBACKEND-07C — database qualification prepared; scardac built — 23 October 2026

New database-07c-native stage contains 20 uniquely selected private DLLs, matching original 07B adapters, original schemas, native qualification harness and input hashes/loader/run plans. Harness compiles exit0; dynamic loading, SQLite/transactions/DataModel tests and PostgreSQL connections NOT_RUN. Prepared path uses original factories/interfaces/archive, with future loaded-module identity checks. PostgreSQL disposable VM profile prepared; compiled driver has no PostgreSQL connection mode. Runtime requires separate authorization; no production/GUI/server/application execution.

Independent scardac Windows wait correction built exit0, AMD64 PE32+, named-provider/static DLL closure PASS; Linux branch unchanged. Inventory82/120 built,21 Windows-blocked,13 dependency-blocked,4 disabled; GUI11/11. Source patch 70D9ADA6F34D4D7D390169295B4D98F5007AF5A700A64494B8101368E759B354; harness patch 23D55C330B4CD8907C09A0AF72220AF41DC587701FEB257A2838D9A938B3F0EF. All243 prebuild outputs including nested Tau/SQLite/07B products and prior stages preserved. Historical config custody INCOMPLETE and 07A Tau exception retained. Evidence: logs/p8-winbackend07c/REPORT.md.

