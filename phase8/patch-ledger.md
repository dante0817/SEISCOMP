# Native Windows Port Patch Ledger

## P8-WINBACKEND-03 — approved patch application and native messaging recovery

Six exact approved patches verified and applied (checks/application/reverse-checks exit 0). Two additional low-risk Windows corrections applied under this batch authorization. No architecture-changing transport patch applied.

| Patch | SHA-256 | Scope |
|---|---|---|
| P8-WINBACKEND-02-acquisition-cmake-proposed.patch | `E6BBA67F8EB0506723BFB0E66E29D79E4C61078011ED82BED839E898BCFC0E15` | plugins/caps_plugin/CMakeLists.txt, CMakeLists.txt |
| P8-WINBACKEND-02-scmaster-linkage-proposed.patch | `66F5D0727427E46145966C3B0CB37251AA866FCE693D7117F5CE4E39C4AB9F80` | libs/seiscomp/wired/ipacl.h, libs/seiscomp/wired/server.h, libs/seiscomp/wired/devices/socket.h, apps/messaging/scmaster/statistics/statistics.h |
| P8-WINBACKEND-02-settings-exports-proposed.patch | `464D14492917BD3901B8D878D107442FDBBC960D86FC3527B8062CEFAB4056F3` | libs/seiscomp/system/settings.h |
| P8-WINBACKEND-02-dbg-delay-msleep-proposed.patch | `3C5D312A828C2C167D1BD97B0AB519EE8441D5E781477B47F4647F8EA06FBF70` | apps/messaging/scmaster/plugins/dbg-delay/dbg-delay.cpp |
| P8-WINBACKEND-02-slutils-flex-header-proposed.patch | `68703BA74247828CE1A7D597166C1E5DFB0EA88BA1431A85163B0F2D62EAB0A9` | libs/slutils/CMakeLists.txt |
| P8-WINBACKEND-02-slplugin-crt-write-proposed.patch | `0BD601A349495CE6DC4CD647208E3C24CD223EB11C0E2C5502FE008BC27EBD43` | libs/plugin/plugin.c, libs/plugin/plugin.h |
| P8-WINBACKEND-03-slinktool-access-mode.patch | `6CF7BC5DED092330C0DF2C4A0983F614A7F775184C40C2907C7C4D2AD10DF5F1` | apps/3rd-party/slinktool/src/dsarchive.c |
| P8-WINBACKEND-03-libslink-native-link.patch | `E31526691F793618CBD4337AE49B91561E7CF7FE0A249D2A841E0F49C46E37ED` | libs/3rd-party/libslink/CMakeLists.txt, libs/3rd-party/libslink/statefile.c |

CMake generation and CAPS generated Release OpenSSL inputs PASS. scmaster/dbstore/dbg-delay/slinktool build PASS; slink/mseed static libraries PASS. Six new targets (2 EXE, 2 DLL, 2 static libraries). Full raw evidence, before/after hashes and source rationale: logs/p8-winbackend03/applied.json and REPORT.md. Remaining slplugin/slutils/slarchive failures and CAPS/SeedLink dependency blocks remain recorded. Native transport design and checked SOCKET-width ABI proposal require separate approval. Source snapshots/protected successful baselines preserved; no applications run. Initial slinktool failure full-log exception is explicitly recorded in REPORT.md.


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


## P8-WINBACKEND-01 — backend inventory and first build — 22 October 2026

Completed source/generated-solution inventory: 107 active native backend/support targets (62 executables, 40 DLL targets, 5 static libraries), excluding 11 completed GUI executable targets; six additional source targets disabled. Current classifications: **7 already built, 97 available unbuilt, 3 Windows/configuration blocked, 6 disabled**. Built baselines: scautoloc, seiscomp_core/client/config/qt/mvx, tau_internal. Backend executable subset: 1 built, 59 available unbuilt, 2 blocked; disabled Hypo71PC additional. Existing artifact presence is not runtime validation. Exact names, source units and project dependencies: logs/p8-winbackend01/backend-target-inventory.json/.csv/.md. Stale projects excluded from current SeisComP.sln membership (including stale hypo71 project).

First priority build **scmaster FAIL**, actual exit **1**; compilation reaches seiscomp_broker, then LNK2019 on Wired::toString(Socket::IPAddress const&), LNK1120: 1. Exact symbol, source/object provenance and raw provider checks in logs/p8-winbackend01/proposal.json, core-socket-object.log, core-exports.log, core-import-library.log, linker-errors.json. Function is defined in core socket.cpp object but absent from DLL exports/import library; header socket.h:366 lacks SC_SYSTEM_CORE_API. No algorithm defect or replacement implementation required. Raw build/warnings/exits: logs/p8-winbackend01-scmaster.log and .exit_code.txt. Exact invocation: existing VS-bundled cmake --build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target scmaster -- /m:1. No new successful backend executable/DLL, architecture/hash/recursive closure for new products NOT AVAILABLE/NOT CHECKED. No further target builds after independent blocker.

Prepared **unapplied**, one-line header export proposal: native-working-copy/phase8-proposals/P8-WINBACKEND-01-wired-toString-export-proposed.patch, SHA-256 `54FF3D32B9992084624AF4A7C694A515E0DEDC681EA69FBF56555B14529D7267`; git apply --check exit 0. Requires separate operator source-change authorization. No actual source changes applied.

OpenSSL audit: 85 active generated Release link sections inspected. scmaster/broker/core use C:/vcpkg/installed/x64-windows/lib/libssl.lib and libcrypto.lib; prior actual core linker command confirms these paths (core-last-link-command.txt). Failed broker command tlog is empty; generated broker Release link paths are the available evidence. **One real mismatch: caps_plugin Release links C:/vcpkg/installed/x64-windows/debug/lib/libcrypto.lib and libssl.lib**, through raw CRYPTO/SSL variables. Configuration-wide debug discovery messages do not establish every target's Release linkage. See openssl-release-linkage.json and openssl-summary.json. Separate unapplied CMake proposal replaces the two raw variables with existing OpenSSL::Crypto/OpenSSL::SSL targets, preserving installed versions: native-working-copy/phase8-proposals/P8-WINBACKEND-01-caps-openssl-targets-proposed.patch, SHA-256 `8CC6483AB8D20C6EB669770EFDD4593ACBE44ED3EEBDB5A9AFAE6DA100E05863`, check exit 0. No dependency or CMake source change applied.

Disabled: dbmysql/dbpostgresql/dbsqlite3; Hypo71PC/hypo71 (SC_IPGP_HYPO71=OFF; native Fortran route external blocker); iloc (OFF; LAPACK unqualified). SQLite event-ID cache in scevent is enabled with project-local native sqlite3.lib and is separate from disabled DB adapter. MySQL client dev dependency absent in prior discovery; PostgreSQL client/server not qualified. Additional acquisition/external locator POSIX paths and existing socket-width/TLS limitations remain unqualified, not newly failed builds.

Recommended next implementation batch: approve the single core export, build scmaster then its dbstore/dbg-delay plugins; separately approve CAPS imported-target correction, then seedlink/slarchive/slinktool/caps_plugin; proceed to scautopick/scamp/scmag/scevent and inventory/configuration tools, stopping at first new independent portability error. Keep native Fortran/LAPACK/database adapter closure as separate dependency decisions.

Preservation evidence: logs/p8-winbackend01/preservation.json and frozen-before/after.json; all prior successful GUI/backend baselines, patches/manifests/staging and vcpkg package status unchanged, no working-copy tracked diff changes. No applications/services executed, runtime preflights or operational connections. GUI milestone remains 11/11. Engineering inventory/build evidence only; numerical/scientific/runtime/release evidence NOT RUN, full SeisComP completion not claimed; Phase5A gates unchanged.


## P8-WINGUI-04D — GUI/Qt executable build milestone complete — 22 October 2026

FlowLayout ownership PASS: matching DLL exports and import-library symbols (constructors, destructor, both vtables and methods); same implementation/header, no local MOC conflict. Raw evidence: logs/p8-wingui04d/ownership.json, qt-dll-exports.log, qt-lib-symbols.log. Windows-only CMake correction PASS: exclude local flowlayout.cpp and link internal qt; non-Windows retains original source. Exact patch: patches/P8-WINGUI-04D-scconfig-flowlayout.patch, SHA-256 `E106CFA7FEE235BBFB7722B4B3A572C28E39BA73A2230AB25D92714D0102F24D`; full diff below. Patch check/application exit 0. Generated scconfig project has no flowlayout.cpp and links seiscomp_qt.lib (generated-ownership.json).

scconfig build PASS, actual exit 0, MSVC Release x64. Existing VS-bundled cmake --build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target scconfig -- /m:1 automatically regenerates existing cache/project files. Raw configuration/build/warnings: logs/p8-wingui04d-scconfig.log; actual exit: logs/p8-wingui04d-scconfig.exit_code.txt. No dependency upgrades, no additional source corrections, no /FORCE or error suppression.

Executable architecture: AMD64 PE32+ (machine 0x8664, optional-header 0x20B); SHA-256 `3B8A33D6D1A216552BDFACCBD25E561BE56F4703ED8584B005A65207E9194CA7`. Recursive static private DLL closure PASS at Windows/API-set boundary. Staging READY for binaries only: staging/scconfig-offline, 31 PE binaries, matching Qt 5.15.18.0 qwindows plugin; local qt.conf and SHA256SUMS.txt. Per-file import/header logs, package provenance, hashes, Qt versions and OS dependencies: logs/p8-wingui04d/scconfig/deployment.json and adjacent raw dumpbin logs. Runtime-loaded optional plugins/data not validated.

Final Qt executable inventory **11/11 built**: logs/p8-wingui04d/final-gui-build-inventory.json and .csv; all executable hashes and stage existence verified. The identified Phase 8 GUI/Qt executable **build milestone is complete**. Frozen pinned HEAD/status/file hashes and protected successful baselines unchanged (logs/p8-wingui04d/preservation.json, frozen-before/after.json). No applications/services executed; no blocked runtime preflight repeated or operational access performed.

No remaining confirmed compiler/linker blocker in this 11-target inventory. Broader runtime network isolation, socket/TLS correctness, native Hypo71 Fortran route, database/release closure and scientific parity remain open as previously recorded. Engineering build evidence only; numerical/scientific/runtime/release validation NOT RUN. Phase5A gate register unchanged; no full SeisComP completion claim.

```diff
--- a/apps/tools/scconfig/CMakeLists.txt
+++ b/apps/tools/scconfig/CMakeLists.txt
@@ -86,7 +86,6 @@
 			icon.cpp
 			searchwidget.cpp
 			wizard.cpp
-			${SC3_PACKAGE_SOURCE_DIR}/libs/seiscomp/gui/core/flowlayout.cpp
 			dialogs/importfdsnws.cpp
 			panels/inspector.cpp
 			panels/bindings.cpp
@@ -101,8 +100,15 @@
 	)
 
 
+	IF (NOT WIN32)
+		LIST(APPEND SCCONFIG_SOURCES ${SC3_PACKAGE_SOURCE_DIR}/libs/seiscomp/gui/core/flowlayout.cpp)
+	ENDIF ()
+
 	SC_ADD_EXECUTABLE(SCCONFIG ${SCCONFIG_TARGET})
 	SC_LINK_LIBRARIES_INTERNAL(${SCCONFIG_TARGET} core)
+	IF (WIN32)
+		SC_LINK_LIBRARIES_INTERNAL(${SCCONFIG_TARGET} qt)
+	ENDIF ()
 
 	IF (SC_GLOBAL_GUI_QT5)
 		SC_LINK_LIBRARIES(${SCCONFIG_TARGET} Qt5::Widgets Qt5::Network Qt5::Svg)
```


## P8-WINGUI-04C scconfig stdout fix — 22 October 2026

Patch application PASS: exact approved SHA-256 9BBFCA3F3C89242B51AD19DED40B79342B39AA60789626F96DB53386537E2445, two files/five identifier renames; postimages verified. git apply check/apply/reverse-check exit 0: logs/p8-wingui04c-stdout/{check,apply,reverse-check}.json.

scconfig focused MSVC Release x64 build FAIL, actual exit 1. Both modified translation units compile. Independent link root: SC_GUI_API FlowLayout header declares DLL imports, but scconfig compiles flowlayout.cpp locally and links core only. LNK2019 imports: __imp_??_7FlowLayout@Gui@Seiscomp@@6BQObject@@@ and __imp_??_7FlowLayout@Gui@Seiscomp@@6BQLayoutItem@@@; LNK1120: 2. Existing seiscomp_qt.dll exports both exact vtables (logs/p8-wingui04c-stdout/qt-exports.log). Smallest clean proposed correction: Windows-only omit local flowlayout.cpp compilation and link existing internal qt alongside core. NOT APPLIED; separate authorization required.

Raw build/warnings: logs/p8-wingui04c-stdout-scconfig.log; actual exit: corresponding .exit_code.txt. Command: VS-bundled cmake --build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target scconfig -- /m:1. Analysis: logs/p8-wingui04c-stdout/linker-errors.json. Successful scconfig executable architecture/SHA-256 unavailable; recursive DLL closure NOT CHECKED; staging BLOCKED (not prepared).

Final Qt inventory 10/11 built, milestone incomplete: logs/p8-wingui04c-stdout/final-gui-build-inventory.json and .csv; ten existing executable hashes/stage existence reverified. Frozen pinned HEAD/status/tracked-file hashes unchanged; protected prior executables/staging/patches unchanged: logs/p8-wingui04c-stdout/preservation.json and frozen-before/after.json. No further source changes, dependency upgrades, application/service execution or runtime preflight.

Engineering only; numerical/scientific/runtime/release evidence NOT RUN, Phase5A gates unchanged. Broader confirmed blockers remain runtime network isolation, socket/TLS correctness, Hypo71 native Fortran configuration, database/release closure and scientific parity.


## Approved P8-WINGUI-04C Qt DLL export correction — 21 October 2026

Applied exact patch SHA-256 `18CB22AFD593C7F6136FB81236103B7A58BEBDE26DED649718E06D68D039CF48`: only gui/core/icon.h (three required function overload exports), gui/map/annotations.h (AnnotationItem), gui/core/vruler.h (VRuler). No function body or algorithm changes. Check/application/reverse-check exits 0; hashes in `logs/p8-wingui04c-exports/application.json`. Six expected symbols verified in rebuilt seiscomp_qt.dll exports and .lib. scmvx Release x64 exits **0**, AMD64 PE32+, SHA-256 `DF3F96F3EA262D3380F64176BC7FAD45481557B30B8C0B3FEDA4292A9CBD0D08`; static DLL closure PASS, isolated staging READY for binaries only with 32 PE files and Qt 5.15.18 Windows plugin. Raw build/exits and all manifests: `logs/p8-wingui04c-exports-{scmvx,scconfig}.*`, `logs/p8-wingui04c-exports/`.

scconfig exits **1**, first root MSVC stdout macro collides with local QString/QByteArray variables in panels/inventory.cpp:860 and panels/system.cpp:371, cascading to :475. Prepared only `native-working-copy/phase8-proposals/P8-WINGUI-04C-scconfig-stdout-proposed.patch`, renaming five local identifier occurrences to standardOutput; hash in next-proposal.json, check exit 0, NOT APPLIED pending approval. No successful scconfig executable/staging claimed. Final GUI inventory: ten PASS/staged, scconfig FAIL; detailed JSON/CSV retained. All previous successful binaries/staging, frozen/dependency custody preserved; no runtime execution or blocked preflight repeated.

## Approved P8-WINGUI-04C mainx GetMessage correction — 21 October 2026

Applied only approved apps/gui-qt/scmvx/mainwindow.cpp guard after all includes in pinned mainx `c0f56ffea74c8ff119703553456708362537744f`. Patch SHA-256 `190992781A159E1734995A8D354EE02983C3A57318B0D7FD8342C31E6597704E`; no intentional Win32 GetMessage calls. Check/apply/reverse-check exit 0; exact source hashes in `logs/p8-wingui04c-approved/application.json`. Release x64 scmvx now compiles but link exits **1** with six missing exports. Core root is not scientific code: icon overload, two pixmap overloads, AnnotationItem destructor, VRuler constructor/setAnnotation are defined in Qt icon.obj/annotations.obj/vruler.obj but absent from seiscomp_qt export/import tables. Raw build/exit: `logs/p8-wingui04c-approved-scmvx.log`, `.exit_code.txt`; exact symbols and provider dumpbin evidence under `logs/p8-wingui04c-approved/`.

Prepared only `native-working-copy/phase8-proposals/P8-WINGUI-04C-scmvx-qt-exports-proposed.patch`, five SC_GUI_API annotations across gui/core/icon.h, gui/map/annotations.h and gui/core/vruler.h; hash in next-proposal.json, check exit 0, NOT APPLIED pending approval. scconfig NOT RUN; no successful new executable/staging claimed. Current full GUI build inventory JSON/CSV records nine prior PASS targets, scmvx FAIL and scconfig NOT RUN with artifact paths/hashes. Prior baselines, frozen/dependency custody unchanged. No application/service execution or blocked runtime preflight.

## P8-WINGUI-04C — focused continuation builds, 21 October 2026

No upstream patch/dependency change. Operator continuation advanced configured targets in recorded order. scmm and scmapcut Release x64 both exit **0**, AMD64 PE32+, recursive private DLL closure PASS; separate staging READY for binaries only with Qt 5.15.18 plugins. scmm SHA-256 `9BB3B0C05FC0D4A5DADD8B1C3A551510F28D468E61F0FA5A30D0C3360BD7552E`; scmapcut SHA-256 `F87020EE570AE5B37B4E5FF93D3BA6BBDDD99EA527D80D2BBFDD5E8BCBFEC75A`. Static staging helper reused with target/evidence prefix selected in memory; scmapcut also receives required qoffscreen.dll because original source selects Tty. Both retain qwindows.dll. No runtime startup configuration validated.

scmvx exits **1**, root GetMessage macro collision in mainx/apps/gui-qt/scmvx/mainwindow.cpp:1157. scconfig NOT RUN per stop condition. Prepared only `native-working-copy/phase8-proposals/P8-WINGUI-04C-scmvx-getmessage-proposed.patch`, hash and clean pinned mainx provenance in `logs/p8-wingui04c/proposal.json`, check exit 0, NOT APPLIED. Raw logs/actual exits: `logs/p8-wingui04c-{scmm,scmapcut,scmvx}.*`; manifests/versions/errors/protected-artifact custody and evidence manifest: `logs/p8-wingui04c/`. Previous successful baselines, frozen trees and dependencies unchanged. No application/service execution or blocked runtime preflight.

## Approved P8-WINGUI-04B scqcv guard; batch completed — 21 October 2026

Applied only approved `apps/gui-qt/scqcv/mainframe.cpp` GetMessage guard after all includes; patch SHA-256 `ADB46F497DCE373D382221C9D02B1C3EFBB9A9D8E2AB12DAD83579B739164636`. No intentional Win32 GetMessage calls; exact resulting bytes verified. Check/application/reverse-check exit 0. scqcv and scheli Release x64 both build with actual exit **0**, AMD64 PE32+. Static recursive private DLL closure passes; target staging READY for binaries only with Qt 5.15.18 qwindows plugin. Executable hashes: scqcv `C845484CB6DBA7708BC675E4899A85DE151B181EEC211BE3B936E30CE298B9F6`; scheli `75E4F17B31BD0BDAFFAE73A5ED7DA95DB4CFD61678D9E5E04631D1A09D1EED41`. Logs/exits: `logs/p8-wingui04b-scqcv-approved-{scqcv,scheli}.*`; manifests, source hashes, custody and complete raw dependency evidence: `logs/p8-wingui04b-scqcv-approved/`. Staging reused the static helper with only evidence-prefix selection changed in memory; no further upstream code changed. Previous successful artifacts, frozen trees and packages unchanged. No runtime launch. Next configured targets: scmm, scmapcut, scmvx, scconfig.

## Approved P8-WINGUI-04B map DLL exports — 21 October 2026

Applied exact patch `native-working-copy/phase8-proposals/P8-WINGUI-04B-scmv-map-exports-proposed.patch`, SHA-256 `F7F78AA5BC38FCACCA2E68D05F7FF98550D647B13AF920245AA79B72645396A6`: gui/map/annotations.h includes gui/qt.h and exports Annotations; gui/map/layers/annotationlayer.h exports AnnotationLayer; gui/datamodel/eventlayer.h exports EventLegend. No other source changed. Check/application/reverse-check exit 0. Four expected symbols verified in rebuilt seiscomp_qt.dll and .lib. scmv Release x64 build exits **0**, AMD64 PE32+, SHA-256 `2B0ACAE44A2EFA2324ECFCD1EC5B79E48A5B88706CCE768576D9CE82A0C01348`. Static DLL closure passes; staging/scmv-offline READY for binaries only, 31 PE files including matching Qt 5.15.18 Windows plugin. Raw logs/hashes/manifests/custody: `logs/p8-wingui04b-mapexports/`, adjacent scmv/scqcv build logs and actual exit files. Static staging helper: `tools/stage-phase8-gui-batch.py` (never runs SeisComP).

scqcv subsequently exits **1**, root GetMessage macro collision at mainframe.cpp:514; scheli NOT RUN. Prepared only `native-working-copy/phase8-proposals/P8-WINGUI-04B-scqcv-getmessage-proposed.patch` (Windows-only undef after all includes), check exit 0; hash in `next-proposal.json`, NOT APPLIED pending approval. No new successful scqcv artifact/staging. Previously successful binaries/staging, frozen trees and dependencies preserved. No runtime execution, scientific test or blocked preflight repeated.

## Approved P8-WINGUI-04B stationdatahandler guard — 21 October 2026

Applied only approved follow-up patch SHA-256 `521DBDF1B6E8EF11BA4E8D78B5C00DEA382DA46BF7FB25624E1C1F9FDF24F28D`, adding ERROR undef after all includes in `apps/gui-qt/scmv/stationdatahandler.cpp`. Exact source hashes and check/application/reverse-check exit 0 recorded in `logs/p8-wingui04b-followup/`. Focused Release x64 scmv now compiles successfully but link exits **1** with four unresolved Qt exports: Annotations constructor/add, AnnotationLayer constructor, EventLegend constructor. Provider definitions present in annotations.obj, annotationlayer.obj and eventlayer.obj, absent in DLL export/import tables. Evidence: `linker-analysis.json`, `linker-provider-dumpbin.log`, `logs/p8-wingui04b-followup-scmv.log`, `.exit_code.txt`. scqcv/scheli NOT RUN; no successful new executable/staging claimed.

Prepared only `native-working-copy/phase8-proposals/P8-WINGUI-04B-scmv-map-exports-proposed.patch`, three GUI header class export annotations with direct qt.h include in annotations.h; hash/check in `export-proposal.json`, check exit 0, NOT APPLIED. No implementation changes. Prior artifact/source/frozen/dependency custody preserved. No application/service execution or blocked runtime preflight repeated.

## Approved P8-WINGUI-04B guard applied; sequence stopped — 21 October 2026

Applied only approved `apps/gui-qt/scmv/types.h` guard from patch SHA-256 `414FB400DDB70C32FE4692AF9754F444A5A81A5779FE182615336141E80B730C`; exact source bytes verified, check/application/reverse-check exit 0. All ERROR identifiers inspected refer to application StationGlyphs/QCStatus members, not intentional Win32 ERROR use. scmv Release x64 exits **1**: header errors resolved, ERROR reintroduced by later includes in stationdatahandler.cpp causes C2589/C2062 at :499,:509. scqcv/scheli NOT RUN. No successful new executable, hash or staging claimed. Evidence: `logs/p8-wingui04b-approved-scmv.log`, `.exit_code.txt`, `logs/p8-wingui04b-approved/`.

Prepared only `native-working-copy/phase8-proposals/P8-WINGUI-04B-stationdatahandler-error-proposed.patch`: same `_WIN32 && defined(ERROR)` guard after all includes in stationdatahandler.cpp; check exits 0, NOT APPLIED pending separate approval. No additional source changes. Existing binaries/patches/staging, frozen/dependency custody preserved. No application or service execution.

## P8-WINGUI-04B — stopped at scmv compiler root, 21 October 2026

No upstream/dependency patch applied. Established focused Release x64 scmv build exits **1** (`logs/p8-wingui04b-scmv.log`, `.exit_code.txt`). Root: Windows ERROR=0 macro breaks StationGlyphs::ERROR and QCStatus::ERROR in `apps/gui-qt/scmv/types.h:27,:100`, producing declaration and consumer cascades. scqcv/scheli NOT RUN per sequence stop condition. No successful artifacts or new staging. Prepared only `native-working-copy/phase8-proposals/P8-WINGUI-04B-scmv-error-macro-proposed.patch`, SHA-256 `414FB400DDB70C32FE4692AF9754F444A5A81A5779FE182615336141E80B730C`, adding `_WIN32 && defined(ERROR)` undef after types.h includes; check exit 0, NOT APPLIED pending approval. Source and prior protected artifact custody unchanged; exact errors, proposal hashes and evidence manifest in `logs/p8-wingui04b/`. No application/service execution or runtime preflight.

## P8-WINGUI-04A — focused scesv build, 21 October 2026

No upstream patch, dependency change or unrelated build. Original scesv configured target built using established VS bundled CMake, Release x64, `/m:2 /v:minimal`; exit **0**. Raw build/exit: `logs/p8-wingui04a-scesv.log`, `.exit_code.txt`. Executable SHA-256 `F665F3180338FC3F4BDF56F02904E03C4829B26FC575D038E3DA19FB31C3981E`, AMD64 PE32+. Static recursive DLL closure passes; separate binary staging `staging/scesv-offline/` READY, including matching Qt 5.15.18 qwindows.dll and local qt.conf. No default offline invocation validated: original scesv startup uses messaging/database and provides no explicit offline CLI switch. No execution claimed.

All requested GUI projects/source are present, including mainx scmvx plus its mvx provider and common scconfig; additional Qt utility scmapcut is configured. Target inventory and remaining order `scmv, scqcv, scheli, scmm, scmapcut, scmvx, scconfig`: `logs/p8-wingui04a/gui-target-inventory.json`, `result.json`. Full staged manifest/versions/dependencies: `deployment.json`; prior binary/patch/staging/manifest protection and source/frozen custody verified unchanged. No runtime preflight, network-isolation change or service interaction.

## Approved P8-WINGUI-03A sleep patch applied — 21 October 2026

Verified SHA-256 `18FD7A489AD023766EF1CDE7A1AB3ECCE4A3C0651159E5BD0D159EFBD6ADD441` and applied exact `native-working-copy/phase8-proposals/P8-WINGUI-03A-scolv-sleep-proposed.patch`: only `apps/gui-qt/scolv/mainframe.cpp`, `sleep(1)` to `Seiscomp::Core::sleep(1)`. Existing included declaration and seconds-based Windows/Linux implementation confirmed. Check/apply/reverse-check exit 0; hashes in `logs/p8-wingui03a-approved/application.json`. Focused existing VS bundled CMake Release x64 scolv build exits **0**. Raw log/exit: `logs/p8-wingui03a-approved-scolv.log`, `.exit_code.txt`.

Executable AMD64 PE32+, SHA-256 `4B310F845CCEC761F46D51527D1C37E3E95FE8DA26FCFC7EC90899EC4840F8CB`. Recursive private DLL closure passes (Windows/API-set OS boundary); staging READY with 31 verified binaries and Qt 5.15.18 qwindows.dll at `staging/scolv-offline/`. Proposed offline command references existing local SCML inventory/config and does not preselect an event. Staged hashes, dependency/package/version inspections, input hashes, custody and evidence manifest: `logs/p8-wingui03a-approved/` and staged `SHA256SUMS.txt`. scrttv executable, staging, fixture and evidence unchanged; frozen/dependency custody preserved. No source beyond the approved line changed. No application executed or network-isolation change; P8-WINGUI-02E remains BLOCKED_NETWORK_ISOLATION. No remaining build blocker; runtime behavior untested.

## P8-WINGUI-03A — scolv build and unapplied proposal, 21 October 2026

No upstream source or dependency changes. Target scolv exists; established Release x64 focused build exits **1**, C3861 `sleep` at mainframe.cpp:1757 (one-second delay after export process starts). Raw log and actual exit: `logs/p8-wingui03a-scolv.log`, `.exit_code.txt`. Prepared `native-working-copy/phase8-proposals/P8-WINGUI-03A-scolv-sleep-proposed.patch`, SHA-256 `18FD7A489AD023766EF1CDE7A1AB3ECCE4A3C0651159E5BD0D159EFBD6ADD441`: only `apps/gui-qt/scolv/mainframe.cpp`, replace `sleep(1)` with existing portable `Seiscomp::Core::sleep(1)`. Header already included; core helper export and import entries verified. `git apply --check` exits 0; proposal NOT APPLIED pending separate approval. No executable hash, closure PASS or ready staging claimed. Offline option review/template, full custody and scrttv preservation hashes: `logs/p8-wingui03a/`. P8-WINGUI-02E remains BLOCKED_NETWORK_ISOLATION without repeating preflight. No SeisComP execution or network-isolation changes.

## P8-WINGUI-02E — launch preflight only, 21 October 2026

No patch, build, application launch or firewall change. Confirmed seven-header approval/patch integrity and all staged hashes. Launch stopped at required network-isolation gate: non-elevated token, no executable-scoped firewall filter, Windows Sandbox unavailable. GUI startup/Qt initialization NOT RUN; waveform acceptance/rendering INCONCLUSIVE. No test process created; no screenshot. Raw structured preflight and custody: `logs/p8-wingui02e/`. Operator must establish verified process-specific network isolation before the authorized smoke launch proceeds.

## P8-WINGUI-02D — scrttv export/type interfaces, 21 October 2026

User authorized implementation of the seven-header plan. Changed only common-library `core/datetime.h` (TimeSpan stream export), `core/strings.h` (two parsing-specialization exports), `gui/core/icon.h` (one icon overload export), `gui/core/recordwidget.h` (RecordWidgetDecorator export), `gui/core/spectrogramsettings.h` (SpectrogramSettings export), `gui/core/mainwindow.h` and `messaging/packet.h` (consistent struct Packet forward declaration with existing Ptr/CPtr aliases). Direct `gui/qt.h` includes in icon and spectrogramsettings provide their export macro. No implementation body, algorithm or type layout changed. Exact patch: `native-working-copy/phase8-proposals/P8-WINGUI-02D-scrttv-link-interfaces.patch`, SHA-256 `F2ECC98EF1F63FB5B29713F645117AFBB6C1F80E6B8FEA47F01176836FBCB4B3`; check/application/reverse-check exit 0, source hashes in `logs/p8-wingui02d/application.json`.

Focused `cmake --build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target scrttv -- /m:2 /v:minimal` using the established VS bundled CMake exits **0**. Core/client/Qt dependencies rebuild and link; scrttv links. Ten previously missing symbols are present in owning DLL exports/import libraries; mainwindow/moc object signatures match struct Packet. Evidence: `logs/p8-wingui02d/interface-verification.json`, raw dumpbin logs; build warnings and exit in `logs/p8-wingui02d-scrttv.log`, `.exit_code.txt`. Artifact hashes: `logs/p8-wingui02d/build-artifacts.json`. Executable SHA-256 `AC4ECD4769FF9207F486D873FA0623CED26D0779C4A0D606977F4DFB6D075052`, AMD64 PE32+.

Static recursive private DLL closure passes, with Windows/API sets as OS boundary. Separate staging `staging/scrttv-offline/` contains 31 verified binaries including matching Qt 5.15.18 Windows plugin, local qt.conf, fixture copy and prepared offline invocation. Reproducible inspection/copy helper: `tools/stage-scrttv-offline.py`; versions, package ownership, identical duplicate candidates, staged hashes and dependency logs: `logs/p8-wingui02d/deployment.json` and raw logs. Frozen revisions/status/sample hashes, installed dependency custody, prior staging and original miniSEED/invocation remain unchanged. Evidence manifest: `logs/p8-wingui02d/evidence.sha256`. No application/service execution. No remaining build blocker; runtime GUI validation awaits separate launch authorization.

## P8-WINGUI-02C — approved scrttv macro guards, 21 October 2026

Changed only `src/base/trunk/apps/gui-qt/scrttv/associator.cpp` and `mainwindow.cpp`, adding `#if defined(_WIN32) && defined(GetMessage)` / `#undef GetMessage` / `#endif` after all includes. Confirmed neither file intentionally calls Win32 GetMessage. Incremental patch: `native-working-copy/phase8-proposals/P8-WINGUI-02C-scrttv-getmessage.patch`, SHA-256 `7B55A33379A80650A1CB8897AB2576476C81F5E23F5CD19E700027E48BE683D1`; source hashes and reverse-check exit 0 in `logs/p8-wingui02c/`. Focused Release x64 scrttv build exits **1**, no compiler errors, **11 unique unresolved linker symbols**. First is Core TimeSpan stream operator; other independent signatures are retained in `unresolved-symbols.json`. Raw build/actual exit: `logs/p8-wingui02c-scrttv.log`, `.exit_code.txt`. No further source correction applied; separate approval required. DLL closure NOT CHECKED; staging BLOCKED; no successful executable hash claimed. Existing library binaries, prior staging, fixture/invocation, pinned frozen trees and dependency custody remain unchanged. No application/service execution.

## P8-WINGUI-02B — focused scrttv build, 21 October 2026

No source/dependency changes. Existing Release x64 `scrttv` target build exits **1** (`logs/p8-wingui02b-scrttv.log`, `.exit_code.txt`). Root: Win32 `GetMessage` macro collision on `Notifier::GetMessage` in `src/base/trunk/apps/gui-qt/scrttv/associator.cpp:1050` and `mainwindow.cpp:1526`; C2660/C2440 are cascading. No executable/hash or closure PASS claimed; staging BLOCKED. Separate source approval is needed for the two translation-unit macro guards before repeating the focused build. Verified original GuiClient/offline/no-inventory/local-file source paths, existing 4 KiB historical miniSEED fixture and proposed invocation are recorded in `logs/p8-wingui02b/result.json` and `offline-invocation.txt`. Before/after custody matches; prior staging remains byte-identical. No application executed.

## P8-WINGUI-02A — isolated deployment preparation, 21 October 2026

No upstream patch, build or dependency installation. Copied 32 verified AMD64 Release application/private binaries into `staging/scshowevent-offline/`, with matching Qt 5.15.18 Windows and offscreen platform plugins plus local `qt.conf`. Recursive private import closure has no missing/conflicting DLLs; Windows/MSVC dependencies remain in System32. Matching windeployqt is absent; dry-run NOT RUN. Manifests, source package ownership, versions, duplicate candidates, raw dumpbin logs and unchanged protected-artifact/source/package custody: `logs/p8-wingui02a/`; staged hashes: `staging/scshowevent-offline/SHA256SUMS.txt`. Original scshowevent is a Tty messaging/database command sender and forces Qt offscreen; a standalone visible GUI launch is not its behavior. An offline command/config needs review before separate launch authorization. No SeisComP binary/library was executed or loaded.

## Approved GUI export patch applied and linked — 21 October 2026

Applied the exact operator-approved `native-working-copy/phase8-proposals/P8-WINGUI-01-export-declarations-proposed.patch`, SHA-256 `D30FB1889BE404F294B1E3DA7D30DD8A983ECBA9FFF6607AB0128F543EC8CE97`. Verification confirmed 12 declaration changes in exactly eight headers: `utils/misc.h`, `io/recordfilter/spectralizer.h`, `seismology/locatorinterface.h`, `math/conversions.h`, `seismology/firstmotion.h`, `processing/amplitudeprocessor.h`, `geo/coordinate.h`, and `geo/formats/geojson.h`. Provider object inspection confirmed core ownership for 11 symbols and client ownership for four SignalTime symbols. Check, application and reverse-check all exit 0; resulting header hashes match the reviewed proposed bytes. No implementation bodies changed. Application evidence: `logs/p8-wingui-export-application.json`.

Using the existing VS bundled CMake and Release x64 configuration, `seiscomp_qt` build exits **0** and rebuilds/links `seiscomp_core`, `seiscomp_client`, and `seiscomp_qt`; subsequent `scshowevent` build exits **0**. Commands use `--build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target <target> -- /m:2 /v:minimal`. Raw warnings/output and actual exits: `logs/p8-wingui-export-seiscomp-qt.log`, `.exit_code.txt`, `logs/p8-wingui-export-scshowevent.log`, `.exit_code.txt`. All 15 expected decorated symbols are present in owning DLL export tables and import libraries; raw dumpbin logs and `logs/p8-wingui-export-symbol-verification.json` retain evidence. No compiler/linker blocker remains in these targets.

All four binaries are AMD64 (`0x8664`) PE32+ (`0x20B`). Artifact paths, SHA-256 hashes, import-library hashes and direct dependency lists: `logs/p8-wingui-export-artifacts.json`; raw headers/dependents logs and all evidence hashes: `logs/p8-wingui-export-evidence.sha256`. DLL hashes: core `262AEED1C57E902BCD31F71084B66201E20FA3AF4A3B0879B35AC04A5D482EB9`, client `51B886B296EFF4CDE88E74296A7AFED49B3EA49724C2083A17F46D81D1FB5691`, qt `129788D8D490AFB675F02FC9D5BF57A08C7BE5614EC09E1DD4C352B8F4733A14`; executable `bin/Release/scshowevent.exe` hash `0FBBB8B7D766FD6727BEA96675DD0601ACCE92780D443EBE96D2114FD0B2323F` under the build directory. Imports include native SeisComP, Qt5, Boost and MSVC/Windows components; no WSL/Cygwin/MSYS runtime appears in the inspected tables. Frozen HEAD/status/sample hashes, existing Boost library hashes and version header remain unchanged (`p8-wingui-export-custody-before.json`, `...-after.json`). No application/service was launched. Engineering link milestone only; runtime behavior remains untested. Next smallest task: static runtime dependency and Qt platform-plugin deployment audit for an isolated offline GUI launch package.

## GUI export declarations — proposal only, 21 October 2026

Prepared `native-working-copy/phase8-proposals/P8-WINGUI-01-export-declarations-proposed.patch`, SHA-256 `D30FB1889BE404F294B1E3DA7D30DD8A983ECBA9FFF6607AB0128F543EC8CE97`. It changes 12 declaration lines in eight common-library headers: `utils/misc.h`, `io/recordfilter/spectralizer.h`, `seismology/locatorinterface.h`, `math/conversions.h`, `seismology/firstmotion.h`, `processing/amplitudeprocessor.h`, `geo/coordinate.h`, and `geo/formats/geojson.h`. The proposal exports existing core symbols and client `SignalTime`, including correcting the ignored macro placement on `FMInversionConfig`; it targets the 15 unresolved symbols documented in `inventory/P8-WINGUI-01D-export-analysis.json`. No implementation bodies change. `git apply --check` against the common working repository exits 0. Patch is NOT APPLIED and no build was performed. Source hashes, frozen custody and tracked working-source diffs remain unchanged; verification record: `inventory/P8-WINGUI-01-export-proposal-verification.json`. Applying the patch and running the focused GUI build await operator approval.

## P8-WINGUI-01D — Focused GUI build, 21 October 2026

No source or dependency patch was applied. Executed Visual Studio bundled CMake 3.31.6: `cmake --build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target seiscomp_qt -- /m:2 /v:minimal`. Actual exit **1**; GUI compilation reaches link with the Boost 1.90.0 header overlay, then fails with **15 unique unresolved externals**. `scshowevent` **NOT RUN**. Raw output: `logs/p8-wingui01d-seiscomp-qt.log`, SHA-256 `076F3F4A2D26668721D67EA6F9631F835CBE93EFC33427687458F2F327A3DEF4`; exit in `.exit_code.txt`. Parsed symbol inventory: `logs/p8-wingui01d-unresolved-symbols.json`, SHA-256 `14C92CF290B9F7062A2E3A04B19A0EE6D4E9E49BBF6795636D6EB47C43BE7167`.

First independent root: `application.obj` references `?HEXCHARS@Util@Seiscomp@@3PADA`. The declaration `utils/misc.h:89` is `extern char HEXCHARS[]` without the core API annotation; definition is `utils/misc.cpp:28`. The core Release project compiles that provider source, and the GUI Release link includes `seiscomp_core.lib`. Static `dumpbin` inspections exit 0: `p8-wingui01d-core-misc-symbols.log` shows the defined external, while `p8-wingui01d-core-exports.log` and `p8-wingui01d-core-import-members.log` contain no `HEXCHARS` entry. Next smallest source correction requires separate approval: export the existing array through `SC_SYSTEM_CORE_API` without changing its type/value, then address the remaining unresolved signatures. Other missing signatures cover Spectralizer Options, arrival flags, nodal-plane conversion, focal-mechanism configuration, SignalTime, and geometry/GeoJSON functions; these are independent unresolved symbols, not consequences of HEXCHARS. Repeated `contains` references share one signature; LNK1120 is a summary.

Before/after custody JSON records are identical (`logs/p8-wingui01d-custody-before.json`, `...-after.json`): pinned frozen trees remain clean, tracked working-source diffs are preserved, and all 44 existing Boost library hashes are unchanged. No successful GUI binary, runtime-dependency validation, or execution is claimed. The rejected Toolhelp proposal remains unapplied.

## P8-WINGUI-01C — Authorized local Boost headers, 21 October 2026

Provisioned only `boost-assign`, `boost-ptr-container`, and `boost-circular-buffer`, each **1.90.0#1**, under `phase8/tools/boost-1.90.0-gui-headers/`. All official `boostorg` archives match SHA-512 in registry `1e199d32ad53aab1defda61ce41c380302e3f95c`; exact URLs, archive hashes and BSL-1.0 notices are in `tools/DEPENDENCIES.md` and `logs/p8-wingui01c/modules.json`. All 65 staged headers retain original paths and archive bytes; conflict checks found no overlapping installed Boost paths. Header manifest SHA-256: `1E64BBCAB3D91D607D37E6FBAEF31E15C9CDBE004A98A42C6302AE1B49AABF04`.

Configuration change: existing build cache `CMAKE_PROJECT_TOP_LEVEL_INCLUDES:FILEPATH` points to the local `phase8-cmake-hook.cmake`, SHA-256 `F7BF5BF7791398D7841C2824B0EF447572D08BADA765782B9BC4A0FA91EFE7E2`. A target-conditioned private include produces an overlay path in **only** `seiscomp_qt.vcxproj`; no upstream C++ or CMake source was edited. The first root-DEFER hook attempt failed because legacy SUBDIRS had not created the target yet (`p8-wingui01c-cmake-configure.log`, exit 1). The corrected hook configured with PATH CMake 4.3 (v2, exit 0); final regeneration restored the original VS bundled CMake 3.31.6 (v3, exit 0). All raw attempts are retained. Final cache comparison preserves package/toolchain/SC options and records the intended hook plus removal of temporary `src_in` compiler-detection cache data.

The one offline MSVC x64 Release object probe compiles with exit 0 (`logs/p8-wingui01c-probe-compile.log`, SHA-256 `F1FBC746E5CCEDF40DEB2520E8F44F00D435FFDDBFCFDEB7DC2CFE7568D49D33`); `dumpbin` confirms `8664` x64. Compiler evidence resolves 35 overlay and 357 installed Boost headers, with Boost 1.90.0 asserted. Final integrity and configuration inspection both exit 0 (`p8-wingui01c-integrity-final.*`, `p8-wingui01c-configuration-verification-final.*`). The 44 existing Boost `.lib`/`.dll` hashes, version header, pinned frozen repositories, and tracked working-copy diffs are unchanged; identical before/after manifest SHA-256 is `A0A526AF77B4FA0912900A6EF44CE1C7848E591666B545B4CC0D8A35D398C0FD`. No `seiscomp_qt`/`scshowevent` rebuild or application execution occurred. Header provisioning is verified; full GUI dependency/link status awaits a separately authorized focused build.

## P8-WINGUI-01A application / P8-WINGUI-01B build — 21 October 2026

The exact approved unsupported-pause/resume patch (`0BD1A38BF94B2F22343E7654D4D72974AE2C6647F4FBAE49DFE3EEE4202E93DF`) was applied in P8-WINGUI-01A only to `libs/seiscomp/gui/core/processmanager.cpp`. Resulting Git blob: `ff7dd8be566ef6e1cd299f46d4cfc71b9603a8e2`; source SHA-256: `0432CB74BFCD5B464C57EFF1247A3873C3CE2E96CE7B40940C777CE175F176BD`. The applied diff matches the approved hunks; Git displays longer blob abbreviations. The historical Toolhelp proposal remains unapplied.

P8-WINGUI-01B makes no additional source changes. Established command: `cmake --build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target seiscomp_qt -- /m:2 /v:minimal`. `seiscomp_qt` **FAIL**, exit 1; `scshowevent` **NOT RUN**. First root: `libs/seiscomp/gui/core/utils.cpp:33` C1083 missing `boost/assign.hpp`; its `boost::assign::map_list_of` uses are at lines 220 and 255. The x64 vcpkg include tree lacks this header/directory, and installed package status has no `boost-assign` entry. Repeated C1083 is a duplicate root, not a separate cascade. Log: `logs/p8-wingui01b-seiscomp-qt.log`, SHA-256 `141BC7630385A295844DFE63348D78C28EB4D2E475C7FB9ED6A1AFD7FA1475C8`; actual exit: `logs/p8-wingui01b-seiscomp-qt.exit_code.txt`. No GUI DLL/executable link, architecture, dependency, or runtime result is claimed. Frozen custody logs: `logs/p8-wingui01b-custody-before.log` and `logs/p8-wingui01b-custody-after.log`. Next action is separately approved Boost.Assign dependency closure, followed by the same focused build.

## P8-WINGUI-01 ProcessManager replacement proposal — 21 October 2026

Operator rejected the Toolhelp/`SuspendThread`/`ResumeThread` proposal in its current form. Its original design and patch remain under `phase8/native-working-copy/phase8-proposals/` as historical evidence; they were never applied. A new **unapplied** one-file proposal is `phase8/native-working-copy/phase8-proposals/P8-WINGUI-01-processmanager-unsupported-proposed.patch` (SHA-256 `0BD1A38BF94B2F22343E7654D4D72974AE2C6647F4FBAE49DFE3EEE4202E93DF`). `git apply --check` against the isolated `common` working copy exits 0. `libs/seiscomp/gui/core/processmanager.cpp` remains unchanged, SHA-256 `F55FD1601AD35B2982283BFC9B1131AFDD96B487312EA1BF3A150AC8B66A6D2B`.

Proposed Windows branch: guard the POSIX `unistd.h` include; log unsupported pause/resume requests and return `false` without setting `item->stopped` or changing `stopDuration`; label and keep `btnStop`/`btnContinue` disabled in `updateControls()`. POSIX signal code, process launch, monitoring, natural exit, terminate, and kill paths remain unchanged. No Toolhelp, thread suspension, handles, source build, GUI link, or runtime result is claimed. **Operator approval is pending before application.** Reliable native Windows pause/resume is a separate backlog item requiring cooperative child-process control and lifecycle design.

## P8-WINGUI-01 — 20 October 2026

Operator approval in this chat covered only the limited GUI portability patch. Modified files in `phase8/native-working-copy/src/base/common`: `libs/seiscomp/gui/core/application.cpp` (Windows `_putenv_s`, Linux `setenv` retained), `libs/seiscomp/gui/datamodel/eventlistview.cpp` (local Win32 `GetMessage` macro undef after includes), and `libs/seiscomp/gui/datamodel/pickerview.cpp` (Windows `_stricmp`, Linux `strcasecmp` retained). No other upstream source was edited in this batch. File SHA-256 respectively: `E95A085AD18E65A299C85732A73BA3486A2D30487027988350833E863D3B1901`, `5EE62E53DEC505A2BD74F8B14738B5DE35892DA0BA5028A8FA28AE77A8067D4B`, `84E2B05F6756646F3C95C1358402B97D391FE010E3A39EBDFA4648CC912669A2`. Incremental diff: `patches/P8-WINGUI-01-common.patch`, SHA-256 `EEBB5C4BFFE005BF77AB1E5B3B8DB7633C48FAFC6EBEABD69B72D7E129FDE0A7`.

Focused command: `cmake --build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target seiscomp_qt -- /m:2 /v:minimal`. Exit 1. Raw log: `logs/p8-wingui01-qtgui-focused.log`, SHA-256 `D13D15A44AB1DAF92796BE06BA9E2CC281B9587B0EE59B3BEC64A98F903DB066`; actual exit code: `logs/p8-wingui01-qtgui-focused.exit_code.txt`. The three targeted compiler roots are absent. Remaining roots: `processmanager.cpp` POSIX include and `SIGSTOP`/`SIGCONT` process behavior; `io/recordfilter/iirfilter.h` C2491 exported template definition; `advancedoriginsymbol.cpp` `sincos` numerical portability; `pickerview.cpp` four ambiguous `TimeQuantity` assignments. These are outside the approval. No `scshowevent.exe` link or runtime result is claimed.

### Approved `RecordIIRFilter` ABI follow-up

Separate operator approval in this chat covered only moving the unchanged `RecordIIRFilter<T>::lastError()` body from `libs/seiscomp/io/recordfilter/iirfilter.h` to `iirfilter.cpp` before the existing float/double explicit instantiations. Working-copy SHA-256: header `73BDDB146AD99C9B1643D590F44DC0E744C2222579D7B29EBBAE521BDBD4BD72`, implementation `0B9F2CE0CB16BC6B5C2DF2E045BF0F5797F0246A502D303C99F39C3100B03BBF`. Incremental diff: `patches/P8-WINGUI-01-iir-abi.patch`, SHA-256 `F2EDB5EBAEA0703C0693122D6C942ABF0ADCB3BBD8146BD574D35A13786CD9F9`.

The same focused Release x64 `seiscomp_qt` command exits 1; raw `logs/p8-wingui01-iir-abi-focused.log` SHA-256 `8D7C323C52A968DA08B61445F704B0895F41C0222458BA9E256B05C235D9BE7A`, exit code in `.exit_code.txt`. C2491 no longer appears. `seiscomp_core.dll` rebuilt (SHA-256 `667FAE6AC6E2B1C06ED0131AE20CE2D5A521C5658A16726BB3A54F716703A981`); `dumpbin /linkermember:2` shows float and double `lastError` imports in its `.lib`. GUI link and runtime are still untested because compilation stops on the three remaining source roots.

### Approved `Core::Time` assignment follow-up

Separate operator approval in this chat covered four explicit `Core::Time` conversions at `libs/seiscomp/gui/datamodel/pickerview.cpp` assignments, matching the adjacent comparison conversions. Working-copy SHA-256: `F2D7B5539BDDED05EE050CBAC2D21D86C18B034EC897FE4F5F81EF7F723325A1`. Cumulative `pickerview.cpp` diff, including the earlier approved `_stricmp` change: `patches/P8-WINGUI-01-pickerview-cumulative.patch`, SHA-256 `1CCA876ED2CFE493ADAD0F4F68D2DE667566F9DAFF8A518C4C92583909C1EC56`. The same focused Release x64 `seiscomp_qt` command exits 1; raw `logs/p8-wingui01-time-conversion-focused.log` SHA-256 `4E8360573692CEA7F1A0CE01813E4B9CB4FFCB66AD86558A585A57B6B0ECEFDC`, exit code in `.exit_code.txt`. C2593 at the four assignments no longer appears. Only `processmanager.cpp` POSIX process control and `advancedoriginsymbol.cpp` `sincos` remain as observed compiler roots. No GUI link or runtime result is claimed.

### Approved confidence-ellipse trigonometric follow-up

Separate operator approval in this chat covered the four `sincos` calls in `libs/seiscomp/gui/datamodel/advancedoriginsymbol.cpp`. A file-local helper uses `std::sin` and `std::cos` on Windows with the same input angle and preserves original Linux `sincos`. Working-copy SHA-256: `57E1CC906BBF34EE002A203BD8FD34DF6E45CA8889E584CC43374D27F92B1AB4`; patch: `patches/P8-WINGUI-01-sincos.patch`, SHA-256 `6C44FD941B4252F56E9B555EBDEEF9434410117044CCB8FF863E295117729751`. Focused Release x64 `seiscomp_qt` build exits 1 with only `processmanager.cpp` C1083 observed; `advancedoriginsymbol.cpp` compiles. Raw build log SHA-256 `225375B3F5A98C553A5FF9C6701B1DBE5A93A811DDA953325CF0084BECDBD09B`, exit code in `logs/p8-wingui01-sincos-focused.exit_code.txt`. The offline nine-angle scalar analytic smoke exits 0 with max reference error `2.4492935982947064e-16` and max unit-circle error `2.220446049250313e-16` under `2e-15`; raw `logs/p8-wingui01-sincos-numeric-smoke.log` SHA-256 `DA604F345C01A83DEA9F38213105BF0558844E5ACD1E0D4311243B6F42CF0A24`, exit code in `.exit_code.txt`. This smoke does not establish GNU `sincos` equivalence or rendered GUI behavior.

**Working copy:** `phase8/native-working-copy`  
**Frozen source snapshots:** `phase8/source-snapshot` (read-only)  
**Date:** 20 October 2026

| Patch | Repository and base | File | Change | Evidence/status |
|---|---|---|---|---|
| P8-CMAKE-001 | `common` at `92d2202a6065aad36ae7d4a9bf960b6fb91222d2` | `apps/messaging/scmaster/share/CMakeLists.txt` | Use `${CMAKE_CURRENT_SOURCE_DIR}/fonts/` and `${CMAKE_CURRENT_SOURCE_DIR}/assets/` as the install sources so CMake resolves the directories from the source directory on Windows. | Applied in the independent working copy. A core-first diagnostic configure confirmed the asset-path error is gone. Full install output remains unbuilt. Export: `phase8/patches/P8-CMAKE-001.patch`, SHA-256 `1994AAD150FDC5157CF1E194DD1E2A3B726768993828B96729756B33F5CC08D6`. |
| P8-WIN-REACTOR-001 | `common` at `92d2202a6065aad36ae7d4a9bf960b6fb91222d2` | `CMakeLists.txt`; `libs/seiscomp/{CMakeLists.txt,core/platform.h.in,wired/**}` | Add initial native Windows `WSAPoll` reactor, Winsock wake sockets/timers, pointer-sized socket handles, and Win32 socket/file-descriptor branches; retain POSIX implementation. Aggregate includes P8-CMAKE-001. | Reactor/socket/file-descriptor/endpoint object-library compile check exited 0. No executable link or runtime qualification. `WSAPoll` non-socket handling and OpenSSL `SSL_set_fd(int)` narrowing remain blockers. Export: `phase8/patches/P8-WIN-REACTOR-001.patch`, SHA-256 `8B6B91D0161651189B15E022258B8FAFD5CA593926D16EF347AC49BB08C07DB5`. |
| P8-CORE-PORT-001 | superproject `9c395c7f00c788c5fc640363abe97b9ced0b44b0` | `CMakeLists.txt`; `src/system/libs/seiscomp/config/config.cpp` | Enable C++17 for MSVC, guard POSIX include, map `getcwd`/`chdir` to Windows CRT, use `USERPROFILE`, and read file data through mutable storage compatible with MSVC. | Applied in independent working copy. Later P8-WINCORE-01 evidence supersedes the earlier build failure: native `seiscomp_core.dll` now compiles and links; Autoloc remains blocked in the amplitude source. Export: `phase8/patches/P8-CORE-PORT-001.patch`, SHA-256 `F5820AE0D9C135E5D42621FBA4B2B2AFC9DE1E9CD6851182F269613F376B3244`. |
| P8-COMMON-MSVC-001 | `common` at `92d2202a6065aad36ae7d4a9bf960b6fb91222d2` | `core/strings.*`, `logging/**`, SeedLink4 and MiniSEED Steim frame declarations, `wired/device.h` | Fix MSVC template export placement; replace alternative tokens with `&&`; guard POSIX logging headers and use CRT remove/rename; put Winsock2 first; apply scoped pack(1) to SeedLink4 and Steim wire structs, preserve GNU attributes, use fixed-width Steim types, and assert sizes 17/64/64. | Narrow native MSVC x64 layout harness compiled `seedlink4.cpp` and Steim header assertions, exit 0. No runtime or data-parity claim. `phase8/logs/layout-compile-check-*`; patch SHA-256 `94B7690180BE32107808CFE3DB9AEBA4E8E6814C1855CC42C004096D6EDCDCEE`; export `phase8/patches/P8-COMMON-MSVC-001.patch`. |

## Current configure blocker

Approved local SQLite 3.54.1 clears the `scevent` dependency. Full-scope Visual Studio-generator configuration still exits 1 at Hypo71PC Fortran enablement: CMake cannot use the existing native GNU Fortran compiler in this generator, and the try-compile invokes `devenv.com`, which reports the VS evaluation period has ended. Diagnostic configuration with `SC_IPGP_HYPO71=OFF` exits 0 but omits a product-scope module. Logs are in `phase8/logs/vs2022-native-after-sqlite/` and `phase8/logs/vs2022-native-after-sqlite-nohypo71/`.

## Source custody

All edits described here are in the independent working copy. Frozen source snapshots remain read-only and clean at their expected revisions. No full application or service has been built or run. Preserve each repository patch and SHA-256 evidence separately.

## P8-WINCORE-01 — 20 October 2026

| Patch | Repository and base | File | Change | Evidence/status |
|---|---|---|---|---|
| P8-WINCORE-01 | Superproject `9c395c7f00c788c5fc640363abe97b9ced0b44b0`; common `92d2202a6065aad36ae7d4a9bf960b6fb91222d2`; IPGP `139ee4cb6dd7325078d4298b9d16de61992f62ed`; system-side CMake files are tracked by the superproject at `9c395c7f00c788c5fc640363abe97b9ced0b44b0` | Shared Windows compatibility header, core/socket/HTTP/logging/environment/date/SeedLink paths, native CMake link/config paths, Tau model input reader, Hypo71 CMake option, WaveformOperator intrusive pointer lookup | Add centralized Windows SDK/Winsock compatibility declarations and targeted Windows branches; keep POSIX branches; use native CMake build metadata; avoid GNU private headers; guard POSIX link libraries and use `ZLIB::ZLIB`; make Hypo71 explicitly optional for core-first configurations while preserving all source/target definitions; add native dynamic line reader to Tau model parsing; make intentionally unsupported GeoFeatureSet copy assignment explicitly deleted; add ADL hooks that forward WaveformOperator intrusive pointers to BaseObject. No scientific formula or behavior changes in this batch. User-approved mechanical MSVC changes in `a5_2.cpp` and `sbsnr.cpp` replace runtime-sized local arrays with same-extent `std::unique_ptr<T[]>` storage initialized by `new T[count]`, preserving element types, extents, and uninitialized storage semantics. `sbsnr.cpp` also qualifies the two double absolute-value calls as `std::fabs`; formulas, loops, constants, comparisons, and control flow are unchanged. The isolated `sbsnr.cpp` SHA-256 is `400308A75D3AC14C6698D20C83A5431CFD4B6C6E8DFA663784868D47111A1F0D`. The targeted client ZLIB CMake edit changes `SC_LIB_LINK_LIBRARIES(client zlib psapi)` to `SC_LIB_LINK_LIBRARIES(client ZLIB::ZLIB psapi)`; `find_package(ZLIB REQUIRED)` was already configured above this target. `libs/seiscomp/CMakeLists.txt` SHA-256: `E0E85409B6BA0F83B40B2FFD3AB397116FCBFA1693B47FCF370D1BD4A7A29F37`. | Core-first configure exit 0 with Qt5 enabled and `SC_IPGP_HYPO71=OFF`. Native `seiscomp_core.dll` Release x64 compile/link exit 0 (`logs/p8-wincore01-final-core-check11.log`). `scautoloc` dependency build currently exits 1 in `seiscomp_client`. User approval also allowed the mechanical `sbsnr.cpp` VLA and `std::fabs` changes. The approved client ZLIB correction reconfigures successfully; the generated Release project links `C:\vcpkg\installed\x64-windows\lib\zlib.lib` using triplet `x64-windows`; `dumpbin /headers` confirms COFF machine `8664` (x64). This is the existing vcpkg package, not a system-wide change; ZLIB archive SHA-256: `4DD17F5987D6BEC3CDD52AC6BCA8354F73B4DEA91AD95B707AA25A90F6F175F4`. Client C++ compilation succeeds, then linking fails with 58 unique unresolved externals (315 repeated diagnostics) across logging/core exports, Wired SSL/WebSocket, math response/restitution, and Boost.Iostreams LZ4. Evidence: `p8-wincore01-client-after-zlib.log`, `p8-wincore01-reconfigure-zlib.log`, and `p8-wincore01-core-export-table.log`, and `p8-wincore01-zlib-x64-headers.log`. Socket width/runtime issues remain. Grouped analysis: `inventory/P8-WINCORE-01-root-causes.md`. |

Batch logs and exit-code files are under `phase8/logs/`, including the ZLIB reconfigure, client link, core export table, and verbose MSBuild linker diagnostics. `p8-wincore01-client-link-diagnostics.log` SHA-256 is `F26CC2690E042C990F70D87752370B3EA2D51F8D1CCF781C6970BD281185530A`; it captures the generated Release linker inputs and LNK1120 result. The latest core build is `final-core-check11`; the latest client build is `client-link-diagnostics` (exit 1, 58 unique unresolved symbols). The ZLIB CMake source change remains the single targeted dependency correction described above; no follow-on source fixes were made.

### Patch exports and hashes

- `phase8/patches/P8-WINCORE-01-superproject.patch` — SHA-256 `8071D027F11BEE54BC964254679D4B32F3F28E1A0A22C4146E6C604990CAB878`; includes superproject CMake and system config changes.
- `phase8/patches/P8-WINCORE-01-common.patch` — SHA-256 `C962FCB206698A7403F30BCCFE78E508C01B7E05C6C8C475EB9D8B16234D7EDB`; cumulative common working diff, including prior P8 patches and the new Windows platform header.
- `phase8/patches/P8-WINCORE-01-ipgp.patch` — SHA-256 `D12BCDB431F957EFF53456AD36EADEE698A8AD0E795C8A7F5176CA26D588A6B1`.

### Source custody and hashes

All new edits are in the isolated working copy. Frozen `main` and `common` snapshots were not modified. Update patch hashes from the exports below after each later code change. Do not treat the successful common-core DLL link as Autoloc executable or runtime evidence.


Patch export hashes (SHA-256):
- `P8-WINCORE-01-common.patch` — `C962FCB206698A7403F30BCCFE78E508C01B7E05C6C8C475EB9D8B16234D7EDB`
- `P8-WINCORE-01-ipgp.patch` — `D12BCDB431F957EFF53456AD36EADEE698A8AD0E795C8A7F5176CA26D588A6B1`
- `P8-WINCORE-01-superproject.patch` — `8071D027F11BEE54BC964254679D4B32F3F28E1A0A22C4146E6C604990CAB878`


## P8-WINLINK-01 — 20 October 2026

| Patch | Repository/base | File | Confirmed change | Build/evidence |
|---|---|---|---|---|
| P8-WINLINK-01 | common `92d2202a6065aad36ae7d4a9bf960b6fb91222d2`; isolated trunk repo | `libs/seiscomp/core/typedarray.h`, `core/typedarray.cpp`, `logging/publishloc.h`, `apps/processing/scautoloc/stationconfig.cpp` | Added `extern template class SC_SYSTEM_CORE_API` declarations for the eight existing explicit `TypedArray` DLL instantiations, preserving the `ArrayType` data values; exported the two existing `Logging::Publish` implementations; guarded the unused POSIX `unistd.h` include in `stationconfig.cpp` on Windows. No scientific algorithm or data layout changes. | `seiscomp_client` Release x64 compile/link exit 0; all 58 unique prior unresolved symbols resolved. `scautoloc.exe` Release x64 compile/link exit 0. Both were inspected as PE32+ machine 8664. No executable was run. GUI probe `scshowevent` exits 1 with downstream Qt source blockers below. |

Source file SHA-256: `typedarray.h` `73DE9014117565D05198DA0EADD0C2721E3A499BCB74C7B189487807C03CCB3C`; `typedarray.cpp` `4D32A1910B24871B8376937A3D980F92D695A0E8911FD177C3D826AF1D1F2366`; `publishloc.h` `E6885CCFDE07B0B33E3676A7391B41CB5494A9FFE0705CD24C12292C74F2A13D`; `stationconfig.cpp` `4DA1E1B6470EAD84BFA37782BD7A6D7F482376F67FE7CA6774D43E66E2DF8C21`. Incremental source diffs: `patches/P8-WINLINK-01-common.patch` SHA-256 `9D0CA056FC992FF9C25F48905FE4B4BBB0ED938918478617D3749A2274A43840`; `patches/P8-WINLINK-01-trunk.patch` SHA-256 `C4E500E1CDCC79AECB16B8BA64F6FC967980234FA0DD670E55EDF57FA016D172`.

Artifacts: `seiscomp_core.dll` SHA-256 `44CBF99652E824D625BEEF048325CF565E9BBF20F9D81EC29D27820257064BB0`; `seiscomp_client.dll` SHA-256 `B52E645C0A34E146FB232AFBEEC525F498D354D0C63CF278D66ECB23A80C3027`; `scautoloc.exe` SHA-256 `FD58AFE5A9F0AEC45BBB060844CA37D796F65870C346B80AA3FDEAFE211BF5E3`. `logs/p8-winlink01-artifacts.log` records the PE checks, confirmed `Logging::Publish` and `TypedArray<double>::ArrayType` exports, and generated linker inputs. Release OpenSSL metadata resolves to `C:\vcpkg\installed\x64-windows\lib\libssl.lib` and `libcrypto.lib`; Debug configuration uses the matching `debug\lib` paths. Client ZLIB metadata resolves to `C:\vcpkg\installed\x64-windows\lib\zlib.lib`.

Raw focused logs and exit codes: `p8-winlink01-client-arraytype-import-v2.log` (0), `p8-winlink01-scautoloc-next-target.log` (1, initial `unistd.h` blocker), `p8-winlink01-scautoloc-stationconfig.log` (1, missing `Logging::Publish` export), `p8-winlink01-scautoloc-publish-export.log` (0), `p8-winlink01-scshowevent-qtgui.log` (1). SHA-256 values are recorded in `logs/p8-wincore01-evidence.sha256`.

The Qt5 x64 configuration and GUI projects exist. The `scshowevent` build reaches `seiscomp_qt` but is blocked by POSIX `setenv` and `unistd.h`, GNU `sincos`, the Windows `GetMessage` macro rewriting `Notifier::GetMessage` (with cascading type-conversion diagnostics), missing `strcasecmp`, `RecordIIRFilter<T>::lastError` C2491 DLL import/definition conflict, and ambiguous assignment expressions in `gui/datamodel/pickerview.cpp`. These are the next GUI source-porting roots; the GUI was not launched.

Exact per-symbol decorated names, provider sources, importing object files, owner target, and resolution details: `inventory/P8-WINLINK-01-symbol-map.csv` (58 unique records).

The exact unresolved symbol inventory has SHA-256 `70048FAD553CC35F59F967743D14302AAE038DA6465CF5957A7462D385A9EFA8`. dumpbin /linkermember:2 evidence confirms 58 of 58 decorated imports exist in the final core import library; raw log SHA-256 `07BED2CFC8450B57C4217F22A1E0B110E91CA849DFAF2BFF93423D4D4A94838A`.

## P8-WINBACKEND-04 — scoped native acquisition implementation — 22 October 2026

Operator authorized Windows transport/archive implementation in the Phase 8 native working copy. Exact reviewed SOCKET patch hash/scope/checks verified before application. Further implementation exported as batch-only diffs with hash-verified preimages and final reverse-checks; no frozen source/dependency version changes.

| Group | Exact patch | SHA-256 | Files |
|---|---|---|---|
| socket-width | P8-WINBACKEND-04-socket-width.patch | `1220DD0B86AA8ED49EA35F8E7E3025F38A7158985EADE5924C5521E99106B4A2` | 1 |
| native-transport | P8-WINBACKEND-04-native-transport.patch | `C71D31959C40585F7D59911A72F3AEEBD3A23B4537D25C9E9B869237DCBE5C12` | 32 |
| caps | P8-WINBACKEND-04-caps.patch | `B8010AC9179B56F78D09320886C7E7A342ADD347268B077465464F77B469815B` | 8 |
| archive | P8-WINBACKEND-04-archive.patch | `D0CF71B29253D43647DC130E9BC7D2E1EF994BC6FC8817A6DEDE8B0AE1EF9ACD` | 4 |
| consumers | P8-WINBACKEND-04-consumers.patch | `CD367DF2DA707C5FE3703C3C185FAB331FE5730BAA49AF2AE2F85027D798EB72` | 8 |

All patch paths are phase8/patches/. Exact file lists/preimage/postimage hashes: logs/p8-winbackend04/{source-change-manifest.json,applied.json}. 41 modified and 12 added files including native sources, original Boost license and transport documentation. Boost POSIX API is a byte-identical existing-version source copy; provenance/license hashes in boost-posix-provenance.json. Linux branches, original packet declarations and scientific algorithms retained.

Focused build results: seedlink_native/slutils/slplugin/slink/seedlink/caps_plugin/fs_plugin/slarchive/load_timetable/slinktool/scautopick exit 0. chain_plugin/mseedfifo_plugin/scamp/scmag/scevent exit 1; raw logs/commands/exits and attempts retained. Three narrowly scoped follow-up patches pass git apply --check but are NOT APPLIED; hashes in follow-up-proposals.json. Chain/FIFO contract proposal is NOT APPLIED and linked from remaining-contract-proposal.json. 9 new targets (6 EXE/0 DLL/3 static); 23/114 backend/support built; GUI 11/11 preserved. No application/runtime/scientific validation. Preservation PASS in preservation.json. Full implementation/limitations: logs/p8-winbackend04/REPORT.md.


## P8-WINBACKEND-05A — processing and backend tool builds

The P8-WINBACKEND-04 prepared processing fixes were already applied in the working copy; prior apply records and current reverse checks match exactly:

| Patch | SHA-256 | Scope | Current result |
|---|---|---|---|
| `P8-WINBACKEND-04-processing-fmt-proposed.patch` | `D095BA42FBF00B783891DF92687F63BA1BEE875BFD48CA8B0A71C38B8F4E1A72` | `scamp/CMakeLists.txt`, `scmag/CMakeLists.txt` | Verified applied; `scamp` and `scmag` Release x64 builds PASS. |
| `P8-WINBACKEND-04-scevent-local-messages-proposed.patch` | `869D6525ED40B3873FB4316C084D2034DB063471BFCB6011CEBDC87F1431B4F7` | `scevent/eventtool.cpp` | Verified applied; prior GetMessage/C2201 issues cleared; later provider-export link failures remain. |
| `P8-WINBACKEND-05A-export-fixes-proposed.patch` | `25714462321B6007284FA018DB73A00DA678DC9DA0D55A33965A9804637E7756` | `core/strings.h`, `core/timewindow.h`, `wired/protocols/http.h` | Prepared only; exact 3-file scope, `git apply --check` PASS. Adds export annotations for existing provider implementations; not applied. |

Five new executables built and passed static architecture/import-closure inspection. Three targets remain blocked by missing exports: `scevent` (`fromString<std::string>`, `URLOptions::next/nameEquals`), `scinv` (`operator<<(TimeWindow)`), `scxmldump` (`fromString<std::string>`). Evidence: `phase8/logs/p8-winbackend05a/`; current inventory: `phase8/inventory/backend-target-inventory.csv` and `.json`.


## P8-WINBACKEND-05C — 22 October 2026

| Patch | SHA-256 | Scope / result |
|---|---|---|
| `P8-WINBACKEND-05A-export-fixes-proposed.patch` | `25714462321B6007284FA018DB73A00DA678DC9DA0D55A33965A9804637E7756` | Applied after exact scope/signature/provider ownership and clean-check verification. Export annotations only in `core/strings.h`, `core/timewindow.h`, and `wired/protocols/http.h`; common provider rebuilt. |
| `P8-WINBACKEND-05C-scdispatch-sleep-proposed.patch` | `BC09B69FAA9534515B6A33173A1A9ABE458EAAC8B5C22A08A8308728E6D5EA02` | Prepared only; one file `apps/tools/scdispatch/main.cpp`; platform-specific sleep helper; `git apply --check` PASS. |
| `P8-WINBACKEND-05C-stdloc-string-headers-proposed.patch` | `213064245B7C8DA64BC659DB790A9B6EAE7996A9C12B69846C0EDF824D97AFB3` | Prepared only; `<string>` includes in `lsmr.h` and `lsqr.h`; `git apply --check` PASS. |
| `P8-WINBACKEND-05C-fdsnxml-provider-exports-proposed.patch` | `6FE14275000B0B47A05A3DBB5CBDF8CA712F86447B2025B451B0DEBC85F4AB93` | Prepared only; export annotations for existing `double2frac`, `PropertyHandler`, and nested `TypeMap::Tag` APIs; `git apply --check` PASS. |

Native Release x64 focused outcomes and artifact hashes/recursive closure are recorded in `inventory/backend-target-inventory.json` and `logs/p8-winbackend05c/batch-evidence.json`. Five executables succeeded; three independent blockers remain (`scdispatch`, `stdloc`, `fdsnxml`). Backend inventory is 33/114 built. All 119 pre-build binary hashes validate in `baselines/p8-winbackend05c-before/`. No applications or services were executed.


## P8-WINBACKEND-05D — 22 October 2026

Applied the three authorized P8-WINBACKEND-05C proposals after hash, scope, semantics/provider ownership and clean apply checks:

| Patch | SHA-256 | Scope / result |
|---|---|---|
| `P8-WINBACKEND-05C-scdispatch-sleep-proposed.patch` | `BC09B69FAA9534515B6A33173A1A9ABE458EAAC8B5C22A08A8308728E6D5EA02` | Applied; one-second sleep retained on POSIX and implemented with `Core::msleep` on Windows. |
| `P8-WINBACKEND-05C-stdloc-string-headers-proposed.patch` | `213064245B7C8DA64BC659DB790A9B6EAE7996A9C12B69846C0EDF824D97AFB3` | Applied; direct `<string>` includes in `lsmr.h` and `lsqr.h`. |
| `P8-WINBACKEND-05C-fdsnxml-provider-exports-proposed.patch` | `6FE14275000B0B47A05A3DBB5CBDF8CA712F86447B2025B451B0DEBC85F4AB93` | Applied; export annotations in `math.h` and `io/xml/handler.h` for existing provider-owned APIs. |

`seiscomp_core` rebuild passed. `stdloc`, `fdsnxml`, `dlsv2inv`, `fdsnxml2inv`, `invextr`, `scorg2nll`, and `screloc` passed Release x64 builds and static recursive DLL closure checks. `scdispatch` reaches link but lacks exports for `Diff2` constructor, destructor and `diff`; proposal `P8-WINBACKEND-05D-diff2-export-proposed.patch` SHA-256 `F6B84A9218897635DE95A6C554B14D59832B298F125B2D0D5A2AA0704BB3D730` is prepared only and passes `git apply --check`. Inventory is 40/114. Full logs and artifact hashes: `logs/p8-winbackend05c/05d-batch-evidence.json`.


## P8-WINBACKEND-05E — 22 October 2026

| Change | SHA-256 | Scope / result |
|---|---|---|
| `P8-WINBACKEND-05D-diff2-export-proposed.patch` | `F6B84A9218897635DE95A6C554B14D59832B298F125B2D0D5A2AA0704BB3D730` | Applied after hash, one-header scope, provider ownership/signature and clean apply checks; `seiscomp_core` and `scdispatch` pass; Diff2 exports confirmed. |
| `P8-WINBACKEND-05E-mlr-unused-unistd.patch` | `08FFEF533F306DF6DF7508BE0C6C1AE133F36A7D881DC3E4F11E9F39207F0AE8` | Applied in `contrib-gns`; removed an unused POSIX header; `mlr` Release build passes. |
| `P8-WINBACKEND-05E-mlh-unused-unistd.patch` | `46D47A1548CD3264BAE063F61F244CA4F07E5C8197D2BD4B23379761C3A80643` | Applied in `contrib-sed`; removed an unused POSIX header; `mlh` Release build passes. |
| `P8-WINBACKEND-05E-md-unused-unistd.patch` | `7108E30DF777A38F0B77819DC9319DCE238FDFA190EC650812EBDA55A2AC99F3` | Applied in `contrib-ipgp`; removed an unused POSIX header; subsequent build reaches the L4C_1Hz_Filter dllimport ownership errors. |
| `P8-WINBACKEND-05E-core-provider-exports-proposed.patch` | `5E1909444BB93AD18094627304FCFCB59154611B74C8DAC9D5628B09F7B4437B` | Prepared only; exports existing bool conversion, NotifierCreator and GeoCoordinate stream-format APIs. Clean apply check passes. |
| `P8-WINBACKEND-05E-md-filter-ownership-proposed.patch` | `06D207F02646A4AAB2C3A900CA1F08707A0C8E57D694A8B3D8A1E2117FDA5329` | Prepared only; removes inappropriate core-DLL import annotations from plugin-local L4C filter implementation. Clean apply check passes. |

The 15-target batch produced six successes; `mlr` and `mlh` then passed after the unused-header fixes. Together with `scdispatch`, nine targets were newly built. `seiscomp_datamodel_sm` blocks `scwfparam`/`scsmdump` on two provider exports; `locrouter` needs the GeoCoordinate stream-format export. `locnll` needs a Windows directory enumeration preserving its wildcard/sort behavior; `locext` requires native process/pipe lifecycle work. These latter ports remain unapplied. Full hashes, logs, closures and target results are in `logs/p8-winbackend05e/05e-batch-evidence.json`. Inventory: 49/114 built; 50 available; 9 portability blocked; 6 disabled. Provider DLLs `seiscomp_core` and `seiscomp_client` changed, so staged GUI bundles may need matching updated dependencies.

## P8-WINBACKEND-05F — 22 October 2026

| Patch | SHA-256 | Scope / result |
|---|---|---|
| P8-WINBACKEND-05E-core-provider-exports-proposed.patch | 5E1909444BB93AD18094627304FCFCB59154611B74C8DAC9D5628B09F7B4437B | Applied after exact hash/scope/signature/ownership and clean apply checks. Exports existing bool conversion, NotifierCreator and GeoCoordinate stream-format symbols. Core export table confirms symbols. |
| P8-WINBACKEND-05E-md-filter-ownership-proposed.patch | 06D207F02646A4AAB2C3A900CA1F08707A0C8E57D694A8B3D8A1E2117FDA5329 | Applied after exact hash/scope and plugin source ownership checks. L4C implementation is plugin-local; its import-annotation compile error is resolved. |
| P8-WINBACKEND-05F-tau-math-library-proposed.patch | 7178B8A7E6E30ECE260EF869C71B8896B22B9BCC84BC025482C5F073AFFF7875 | Prepared only; removes MSVC -lm linkage while preserving POSIX math-library linkage. git apply --check PASS. |

Release x64 successes: seiscomp_datamodel_sm, locrouter, dmsm, sczip; provider rebuilds seiscomp_core and seiscomp_client also passed. Six of eight independent extra targets failed at exact roots in the evidence. md now exposes separate plugin-local processor import annotations; scwfparam needs native process launch/wait support; scsmdump has unresolved fmt v10 symbols. locnll and locext architecture work remains unmodified. Evidence: logs/p8-winbackend05f/05f-batch-evidence.json; runtime NOT RUN.

## P8-WINBACKEND-05G — 22 October 2026

| Change | Patch SHA-256 | Scope / source hashes / outcome |
|---|---|---|
| Approved tau library linkage patch | 7178B8A7E6E30ECE260EF869C71B8896B22B9BCC84BC025482C5F073AFFF7875 | Applied in libs/3rd-party/tau/libtau/CMakeLists.txt; Windows omits m while non-MSVC retains m. Both executable targets still fail because tau/bin/CMakeLists.txt separately links m. |
| Plugin-local md class ownership | 60F260ADC980CEEDA869DF91D7F5C9A6F296EF35EA7151CC8E9A13382FCFA880 | md.h only; preimage SHA-256 F762971D9B605470E3C7DF99A23762053F80D7CA84601395737A20446196CD0E; postimage CD1C3E9F1F83B98C81935C1D31FE667377102369FEEC9C76D72D2C49A813B97B. md Release build PASS. |
| fmt provider export configuration | 8D42286CBCD9FF3B5BEAED8F04446679DC6A6AE5220A762534CAC92056A9922D | config CMake: provider compiles existing fmt v10 sources with export semantics under MSVC. |
| fmt consumer linkage | 48604AB8CE6614DA2D2D920FC217DB96CACFD67020075529317670E319132485 | scsmdump CMake: imports fmt from config and explicitly links the provider. Export table and scsmdump build PASS. |
| tau executable follow-up proposal | 815FC24947F8741622B744C26F192B9EBB6AEEDB32DDE74ABDAF62454EC3F410 | Prepared only for tau/bin/CMakeLists.txt; clean apply-check PASS. |

New successes: md, scsmdump, sccnv, seiscomp_mplugin, scimport. Independent blockers: tau_remodl/tau_setbrn still request m.lib; seiscomp_daplugin C2676 at sds.cpp:276; scimex has three SCDM051 unresolved constructors; scqc lacks Boost 1.90.0 Signals2 headers in installed and approved-overlay paths. Full evidence: logs/p8-winbackend05g/05g-batch-evidence.json. Inventory: 58/114. Runtime NOT RUN.


## P8-WINBACKEND-05H — 2026-10-22

- Applied the exact recorded tau proposal after SHA-256 and one-file scope verification: `P8-WINBACKEND-05G-tau-executables-math-proposed.patch` `815FC24947F8741622B744C26F192B9EBB6AEEDB32DDE74ABDAF62454EC3F410`. Actual applied diff: `logs/p8-winbackend05h/P8-WINBACKEND-05H-tau-bin-math.patch`, SHA-256 `9B634F9E3BD566C7FF013CBDD76ED16190A1715CF01508D12FCDD6D5203F38E5`. Windows omits `m`; non-Windows retains it.
- Added provider exports to the three SCDM051 classes without changing definitions or layout. Diff `logs/p8-winbackend05h/P8-WINBACKEND-05H-scdm051-exports.patch`, SHA-256 `5CE26BF76A54B72F16F8E1E492553C3B58B483D7B740A310BC24A27A9579510F`; source pre/post SHA-256 `AC43154FF499B401FB1E1967A095EF3675126DA327CB8738DCFBC383BB5F2D2B` / `668B1DFD7C6C480BC55EC06E7648DEE4DC8250B320A24B1C8994B0DDD1BD0534`.
- Replaced narrow-string separator concatenation with filesystem path joining in the SDS collector, and used the pre-existing narrow filename for the warning diagnostic. Diff `logs/p8-winbackend05h/P8-WINBACKEND-05H-daplugin-path.patch`, SHA-256 `A98DDC855EED4810ED93C4DBA62D3A5E6D72C11A2644E1BD56784B504CA4326A`; source pre/post SHA-256 `EBFFCF97172EDB15BEF43373E46E6717CDCEEC332D96B6374B223B17F154D13E` / `4C86CABDEB6BFC64AABAFDBF9885F917860EC9E4078A68C1FBA5E9B812EB47D9`. Source compile passed; link remains blocked by the generated relative tau library input.
- `tau_remodl`, `tau_setbrn`, `scimex`: build exit 0; AMD64 PE32+; recursive static DLL closure PASS. Executable SHA-256: `96F3C8621DE492080ABBEF34A37E3CC2BE633B908CB582F0B4A109DC2C52F2EA`, `E0DBA60B30C0ED3E8A8216897E8105C97ED38F9FDB44BA8673EB0D2D94668A67`, `3E20BDD39CF3619F2667D47414CBA2601766CB01ADD0E59F52B2395AC9B97E2A`. Logs and artifact inspection JSON are in `logs/p8-winbackend05h/`.
- Independent failures and exact roots: `ew2sc` missing `netdb.h`; `ql2sc` anonymous-namespace exported vftable and missing `usleep`; `scm` missing `Client::Status::parse`; lock utilities missing `unistd.h`. Logs/exit codes accompany each. `gmsexample` stopped before completion during a Qt dependency rebuild; it is not counted.
- Boost.Signals2 remains absent at installed Boost 1.90.0 and in the approved overlay. No install/provisioning performed. Proposed dependency source is the existing vcpkg `boost-signals2` port metadata at 1.90.0#1; provision its exact headers into the local overlay and scope includes to scqc after dependency approval.
- Rebuilt provider DLL hashes and static closure: `seiscomp_core` `F85BDF0C5607A3F0F03B03587EBBAAE2745AC56E5B74C5B7F698EFFF06D66687`; `seiscomp_client` `304187503D9BD14265B6D5689B9FB670F4BB52EFD2F583B4C4863BBDECA1F03C`; `seiscomp_config` `1F3364FDDFEFC5F3EB4E72FFD8C3F21BAC26C27788684CE5B12B077237C824F8`. All 11 staged GUI bundles listed in status have stale copies and require matching provider refresh.
- Frozen repositories: all nine required HEADs and clean statuses verified; evidence `logs/p8-winbackend05h/05h-batch-evidence.json`. Updated inventory counts: 61 built / 30 available / 16 Windows blocked / 1 dependency blocked / 6 disabled (114 total). Runtime NOT RUN.

## P8-WINBACKEND-05I — dependency and Windows portability recovery

| Applied correction | Scope / verification | Source SHA-256 |
|---|---|---|
| `seiscomp_daplugin` target-based Tau ownership | `src/base/common/libs/seiscomp/CMakeLists.txt`; preserve the existing public dependency set and link `tau_internal` privately to `seiscomp_core`. CMake generation PASS; generated Release plugin project has no `tau_internal.lib`; build PASS. | `07A181C5989EBE9C9C145CF809A52E91ACE92D23837C9E2EB32AAC4CDEE841CC` |
| `scm` provider export | `src/base/common/libs/seiscomp/messaging/status.h`; export the existing provider-owned `Status::parse` declaration, no signature or behavior change. Build PASS. | `F1CC55E282EF63CA8B3981A88E4802B58E63CA996ADC635E0E46CFC142D33A23` |
| `ql2sc` local ownership and sleep | `apps/tools/ql2sc/app.cpp`, `app.h`, `quakelink.cpp`; remove mistaken core DLL annotations from app-local cache classes and use existing 100 ms `Core::msleep` helper. | `9A85A62C4AA10E82793B6A5D1620A700967A75B779F566D3C586DC9655BF00E8`; `B0E3CBDB0A2EB1B134ACDD73C69D8BD761FDE70270A82F71050BAA73CF71546D`; `CDC63397C42CFAEF86D6E39F902AE0CB350FA1B2C9642B4543623DB71A7D3DFE` |
| `ql2sc` provider ownership | `io/quakelink/connection.h`, `datamodel/diff.h`, `client/application.cpp`; export existing provider-owned methods/data and the `ThreadedQueue<Notification>` specialization. Definitions and build membership verified; no layout or method changes. | `53577FD926CC2306F3C6BF6C6DC850122754EE2509FBA8730033D0B4781EE013`; `B39A693D8B08BF99973B71CB1254282A6120208EC0073FFBFA3C2305F03E0CF5`; `E8E661CD029DCA42B518399677AD0ED008A510BD4A2F5E0394F01C7A06F60EA6` |

`seiscomp_daplugin`, `scm`, `ql2sc`, and `gmsexample`: build exit 0; AMD64 PE32+; recursive static DLL closure PASS. Artifact hashes are in the CSV/JSON inventory and `logs/p8-winbackend05i/artifacts/`. `gmsexample` uses the archived matching `seiscomp_qt.dll` and the current core export superset; project-reference builds were disabled for this target only to avoid rebuilding its valid Qt provider. `scqc` was attempted and remains blocked by missing `boost/signals2.hpp`; exact `boost-signals2` 1.90.0#1 metadata and SHA-512 are recorded in `logs/p8-winbackend05i/05i-prepared-proposals.md`, with no provisioning. `run_with_lock`, `timeout`, `trylock`, and `waitlock` each fail at `unistd.h`; native API proposal prepared. `ew2sc` still fails at `netdb.h`; Winsock proposal prepared. No application/runtime tests were run.

CMake regeneration and complete logs, source hashes, provider exports, closures, frozen snapshot HEAD/status, staging staleness and inventory counts are recorded in `logs/p8-winbackend05i/05i-batch-evidence.json` (SHA-256 `D069CED07FEB47F28E615ACDFF54C1D1E1810B61C60F0054A6E1B23157AC7F75`). Inventory now: **65 built / 29 available / 13 Windows-blocked / 1 dependency-blocked / 6 disabled (114 total)**. All 11 staged GUI bundles require provider synchronization after core/client stabilization.

## P8-WINBACKEND-05J — Boost dependency audit and independent builds — 22 October 2026

Boost.Signals2 archive identity and official vcpkg recipe SHA-512 verified: archive checksum matches `boost-signals2` 1.90.0#1 (`boostorg/signals2`, tag `boost-1.90.0`, BSL-1.0). Provisioning was **not performed** because the required 1.90.0 dependency closure is incomplete: `boost-parameter` is absent from installed headers/status (and that component requires `boost-fusion`, `boost-mp11`, and `boost-utility`). No overlay/license/config changes; scqc remains dependency blocked. Evidence: `logs/p8-winbackend05j/dependency-verification.json`; downloaded verification archive retained there.

Three targets newly built with MSVC Release x64: `test_mn_amplitudes`, `memailplugin`, `mtextplugin`. All are AMD64 PE32+, SHA-256 and recursive static private DLL closure PASS; raw logs/exits and inspections are in `logs/p8-winbackend05j/`. Seven focused builds failed and were classified from exact roots: six Windows portability (`echopro_plugin`, `ewexport_plugin`, `minilogger_plugin`, `naqs_plugin`, `q330_plugin`, `reftek_plugin`) and one external dependency (`gdrt_plugin`, absent `boost/asio.hpp`). No source fixes were authorized by existing patches, so no changes applied.

Inventory: **68 built / 19 available / 19 Windows-portability blocked / 2 external-dependency blocked / 6 disabled (114 total)**; GUI stays 11/11. Four lock utility ownership/lifetime and ew2sc Winsock mappings are documented in `logs/p8-winbackend05j/05j-portability-proposal.md`. Runtime NOT RUN; no application/service or operational endpoint executed. All 11 staged GUI bundles still have stale provider dependencies; defer refresh as requested. Frozen SeisComP and vcpkg HEAD/status verified unchanged.

## P8-WINBACKEND-06A — native locks and ew2sc — 22 October 2026

Authorized Windows-only adaptations completed in 12 files. CMake selects seven new utility sources/headers; original POSIX utility sources are unchanged. Native LockFileEx ownership, PID files, Unicode CreateProcessW child/argv handling, console notifications and cancellable timeouts are implemented. ew2sc adds full-width SOCKETs, balanced Winsock lifetime, cancellable connect/read/send paths, supervisor-owned worker/socket cleanup, safe EOF/buffer handling, and local GetMessage macro isolation. Original framing and seismic interpretation are preserved.

All five MSVC Release x64 builds exit 0: trylock, waitlock, timeout, run_with_lock, ew2sc. AMD64 PE32+ and recursive static DLL closure PASS for each; raw initial/final logs, actual exits, warnings, artifact SHA-256 and per-file source hashes: logs/p8-winbackend06a/. No runtime tests were run.

Exact batch patches (reverse-check exit 0): P8-WINBACKEND-06A-locks.patch `0F093E0F64F37F65A9C75EDEA063ED2BB22706C55C3712CFEDC49721EB1EB6AA`; P8-WINBACKEND-06A-ew2sc.patch `E42A81B53E5EC5B3887EB1BF90549E4A5EF554FBBE2D0D56E04E79AA7C0992DD`. No dependency versions, scientific algorithms, unrelated APIs or excluded components changed.

Inventory: **73 built / 19 available / 14 Windows-blocked / 2 dependency-blocked / 6 disabled (114 total)**; GUI 11/11. Nine frozen repositories, 833 protected baseline/staging/provider files and vcpkg state match the before hashes. Linux active branches and ew2sc interpretation pass static preservation checks. GUI staging refresh remains deferred.

Remaining contracts and unapplied proposals: logs/p8-winbackend06a/compatibility-proposals.md. Per-PID SIGTERM/SIGHUP needs a Windows controller contract; common Application locking and the POSIX Python controller remain outside this batch. ew2sc retains the upstream literal 5,000-second zero-progress wait and blocking-send timing. Recommend a coherent native application-lock/controller/termination batch, then separately approved bounded ew2sc send deadlines. Engineering build evidence only; numerical/scientific/runtime/release qualification NOT RUN. Report: logs/p8-winbackend06a/REPORT.md.


## P8-WINBACKEND-06B — application locking and controller integration — 22 October 2026

Windows Application lock acquisition now uses the actual 06A-compatible LockFileEx protocol with private RAII lifetime, readable PID metadata, denied deletion/replacement and crash cleanup. The private Python Windows adapter integrates controller locks, per-module guards, explicit CreateProcessW argv/environment/cwd/handle allowlists, atomic kill-on-close Job Object ownership for incomplete launches, verified PID/creation-time/image/file-ID receipts, bounded partial-launch cleanup and real error/exit reporting. Successful detached handoff removes the job kill policy. Windows 10+ required for atomic JOB_LIST; Linux source/AST projections preserved. Windows install selection corrected; nothing installed or executed.

Live stop/reload is deliberately blocked pending the narrow unapplied per-PID control proposal; SIGTERM is graceful application exit, generic SIGHUP ignored, FDSNWS reload module-specific. No PID-only force or invented signal protocol. Python native config bindings remain disabled; the shell frontend/module-specific handlers are not qualified. Controller source is not a deployment/runtime PASS.

Eight focused Release x64 builds exit 0: seiscomp_core, seiscomp_client, trylock, waitlock, timeout, run_with_lock, scm, ew2sc. All AMD64 PE32+, recursive static DLL closure PASS. Exact commands, hashes, warnings and inspections: [batch evidence](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06b/06b-batch-evidence.json). Existing inventory rows refreshed, zero new targets: **73/114 built, 19 available, 14 Windows-blocked, 2 dependency-blocked, 6 disabled; GUI 11/11**.

Applied patches: application-locking `765F610032E8F6B1678D8860D9421B9A8CBB9E09210D7605516A61629ED2ED52`; controller `52DDA4F79A31C85388D6803FB1B5FD8C9CB375FEDC8E4A2697AE5129FABA86C6`. Exact ten-file scope and per-source hashes: [source/patch manifest](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06b/applied-patches.json). ew2sc cumulative packet deadline proposal `DC3ADFC288FA088B636E7C58AE0BFA3AA07AD37D4ABC8CC3D30C8B10051E126F` passes applicability check but remains NOT APPLIED / NOT BUILT / NOT EXECUTED. Existing 5,000-second zero-progress retry remains active.

Nine frozen snapshots and 780 protected archive/staging files preserved; changed affected binaries have hash-verified original archives. All 11 staged GUI bundles retain stale core/client/config copies; refresh deferred. No operational/network/application/scientific testing. Recommend approved per-PID application control/main-loop integration, native Python config bindings and Windows entrypoint/module qualification; deadline approval separately. Report: [06B report](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06b/REPORT.md).


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

06C review-artifact SHA-256 (no native patches):

- `control-contract-amendment.md`: `E299F2DD3B82E218CF3A1665AECCE78122A1771144B8C10BCB9AE51A7BDD76E3`
- `06d-controller-deployment-scope.md`: `FE99B8D5C649AA73722CA229C28152C51303A9F675B91F3C0F9F3EA9C398C9A9`


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

Final applied 06C1 patches (reverse-check exit 0):

- `P8-WINBACKEND-06C1-providers.patch`: `89BA4A035B615677A352B50D8595D525CA672AC16D15409D8157E99CD7112FF9`
- `P8-WINBACKEND-06C1-scautoloc.patch`: `B14DD325B7550E02925C3558E17A1831C2025A5D35D4E95DBA7150CA9E0E193D`
- `P8-WINBACKEND-06C1-controller.patch`: `E14CFC92AF73CC6D787803CB0BE48749F3B790642875ACC13AD4925E758BA8BF`

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

## P8-WINBACKEND-07A — QC and acquisition build attempts

No source patch was applied; patch hashes: none. `seiscomp_qcplugin` failed with C1083 for missing `boost/signals2.hpp`; all ten QC plugin projects depend on that provider and remain blocked. Exact Boost 1.90.0#1 Signals2/Parameter closure proposal: `logs/p8-winbackend07a/boost-signals2-closure-proposal.json`. No dependency was provisioned. `scardac` fails with C3861 at its POSIX `sleep`; seven available SeedLink helpers fail on the individual Windows blockers recorded in `REPORT.md` and their raw logs.

Five existing provider targets (`seiscomp_client`, `seiscomp_daplugin`, `seedlink_native`, `slplugin`, `slutils`) independently built exit 0. DLLs pass AMD64 PE32+ and recursive static private import closure; archives contain AMD64 COFF objects. Hashes/logs: `logs/p8-winbackend07a/provider-verification.json`. These are provider refreshes, not new inventory completions. Before/after custody verified: 207 flat active Release products archived; 1,113 protected prior files and nine frozen repositories unchanged. Nested transitive tau_internal.lib was outside the flat prebuild archive sweep; its current timestamp predates this batch, but no prebuild hash was captured, so preservation cannot be cryptographically asserted. A post-build copy/hash is retained under logs/p8-winbackend07a/dependency-archive-after.  Inventory is 79/120 built (0 available, 22 Windows-portability blocked, 13 dependency blocked, 6 disabled). Historical pre-06C1 config DLL custody remains INCOMPLETE. GUI/controller stages unchanged; runtime/plugin loading NOT RUN.

## P8-WINBACKEND-07B — original native database adapters — 23 October 2026

Two new targets, dbsqlite3 and dbpostgresql, build exit 0 in the isolated VS2022 Release x64 database tree using original target definitions/macros and existing imported core. SQLite reuses approved 3.54.1 /MD/threadsafe static archive; PostgreSQL uses installed 18.1 native client SDK. Both are AMD64 PE32+, export createSCPlugin with original factory registrations, and pass recursive static private DLL closure and named import/export checks. Shared PostgreSQL/SeisComP DLL names explicitly select the existing SeisComP providers; no stage/PATH/dependency installation changes. Runtime loading, schema and persistence NOT_RUN.

Windows-only PostgreSQL uint64 scan width correction preserves Linux branch; source patch SHA-256 23B0813DD88EA7780C1AF5BFE4A30562B0A8CD3913C8C38D42715778AD568F18. Build-harness patch SHA-256 AB1D466F3AC5C81010B84EE7FC0D0FE38CEB149442FF438BD81CF15C8BFC498D. MySQL SDK unqualified; exact requirements/plan recorded without provisioning. Inventory: 81/120 built, 22 Windows-blocked, 13 dependency-blocked, 4 disabled; GUI 11/11. All 237 prebuild Release outputs including nested Tau/SQLite and protected baseline files unchanged. Historical config custody INCOMPLETE and prior 07A Tau exception retained. Report/evidence: logs/p8-winbackend07b/REPORT.md.

## P8-WINBACKEND-07C — database qualification prepared; scardac built — 23 October 2026

New database-07c-native stage contains 20 uniquely selected private DLLs, matching original 07B adapters, original schemas, native qualification harness and input hashes/loader/run plans. Harness compiles exit0; dynamic loading, SQLite/transactions/DataModel tests and PostgreSQL connections NOT_RUN. Prepared path uses original factories/interfaces/archive, with future loaded-module identity checks. PostgreSQL disposable VM profile prepared; compiled driver has no PostgreSQL connection mode. Runtime requires separate authorization; no production/GUI/server/application execution.

Independent scardac Windows wait correction built exit0, AMD64 PE32+, named-provider/static DLL closure PASS; Linux branch unchanged. Inventory82/120 built,21 Windows-blocked,13 dependency-blocked,4 disabled; GUI11/11. Source patch 70D9ADA6F34D4D7D390169295B4D98F5007AF5A700A64494B8101368E759B354; harness patch 23D55C330B4CD8907C09A0AF72220AF41DC587701FEB257A2838D9A938B3F0EF. All243 prebuild outputs including nested Tau/SQLite/07B products and prior stages preserved. Historical config custody INCOMPLETE and 07A Tau exception retained. Evidence: logs/p8-winbackend07c/REPORT.md.


## P8-WINBACKEND-07D — original QC closure and twelve targets built — 23 October 2026

Boost Signals2 (43 headers) and Parameter (100 headers), exact 1.90.0#1 at pinned vcpkg 1e199d32ad53aab1defda61ce41c380302e3f95c, archive SHA-512 verified, staged in a separate project-local overlay private to twelve QC targets. Existing required Boost components and BSL-1.0 provenance verified; installed vcpkg/global paths unchanged. Original QC provider, all ten original plugin DLLs, and scqc built independently with exit 0; AMD64 PE32+, original factories, recursive private DLL and named-export closure verified. Runtime/plugin loading NOT_RUN.

Windows-only QcProcessorObserver/QcPlugin DLL annotations plus complete QcBuffer declaration for MSVC export instantiation; algorithms and Linux branches unchanged. Source patch SHA-256 78DD2EE1152F1DB3BAB5844DE47D6A4A53D87B333AE90105B09252C304D47D51; scoped CMake patch 0EEFD8E51CBC67A483D25FA1495C1845A6D202CB1D88EF91CE125B69F473E059. Client prerequisite rebuilt; previous matching GUI/controller/database stages retained without modification. All245 previous outputs archived including nested libraries; changed client outputs retain before/after hashes. Frozen trees/protected baselines/Boost libraries unchanged. Historical pre-06C1 config custody INCOMPLETE; 07A Tau prebuild-hash exception retained.

Inventory94/120 built,21 Windows-blocked,1 external-dependency blocked (gdrt_plugin/Boost.Asio),4 disabled; GUI11/11. No dependency expansion for Asio; no ew2sc proposal applied. Next prioritize scientific-processing completeness: locnll directory/wildcard portability, then an explicit native child-process contract for scwfparam; independently address localized acquisition/server source defects without transport redesign. Report: logs/p8-winbackend07d/REPORT.md.


## P8-WINBACKEND-07E — private NLL filesystem adapter; locator still blocked

Windows-only GridLib enumeration adapter compiled; 39 isolated matcher/enumeration/order/error checks passed with exit 0 (no SeisComP loading or scientific replay). Original POSIX expansion retained. C-locale matching is case sensitive, includes dot names, supports basic wildcards, escapes, bracket lists/ranges/classes and single-byte collating/equivalence elements; non-C locale, unsupported range/collation syntax and unrepresentable/overlong paths fail explicitly. Full POSIX/locale parity is not claimed. Source patch SHA-256 CD1AABBAF3D66C98F899652B4BFF6C719C548D839428E957E05668D683DE3547.

locnll focused MSVC Release x64 build exits 1 on original variable-length arrays in NLLocLib.c:12735,12917–12921 and alomax_matrix.c:269. These numerical routines are outside 07E filesystem correction scope and unchanged. No locator DLL/PE/static-closure or scientific PASS. Backend stays 94/120 built, 21 Windows-blocked, 1 dependency-blocked, 4 disabled; GUI 11/11. All 279 prebuild outputs and prior stages preserved; frozen trees unchanged. Historical config custody INCOMPLETE and 07A Tau prebuild-hash exception retained. Native scwfparam/locext lifecycle contract prepared only, with script/PATH/job/cancellation decisions explicit. Next: authorize a storage-only NLL VLA port and qualify filesystem edge cases, then implement the native child lifecycle contract. Evidence: logs/p8-winbackend07e/REPORT.md and process-lifecycle-proposal.md.


## P8-WINBACKEND-07E1 — matrix VLA storage compiled; NLL failure propagation proposed

Applied Windows-only checked malloc/free for int inon_zero[i_original_size] in matrix_double_check_diagonal_non_zero_inverse. Exact runtime count/type retained, SIZE_MAX multiplication checked, no zero initialization; ownership freed on all original return paths. Entire original POSIX source reconstructed exactly after removing the added Windows branches. Patch SHA-256 C2075DD8725E3B39ED3E234EF5291A3ADF2023332A5A9F7BAA9E01270E693C03.

locnll build exit 1 remains on six original NLLocLib.c double VLAs. Their callers do not safely propagate allocation failure; per 07E1's explicit failure-path exception, two NLL conversions plus the necessary caller/status changes are a concrete UNAPPLIED proposal (SHA-256 5B5BF84E7737B0DA292A6AC64D6F6E519D4DEDC4A1B9E33AF29E458394B16C75), not silently applied beyond routine-body scope. No locator DLL/build credit; inventory stays 94/120 built, 21 Windows-blocked, 1 dependency-blocked, 4 disabled; GUI 11/11. No new linker evidence because compilation is incomplete. Existing GridLib parrivals warning retained, not suppressed. All 279 archived outputs, protected stages/files and nine frozen repositories preserved; both historical custody exceptions remain unresolved. 07E adapter/proposal unchanged; completed 39 adapter checks not rerun. Next: review the concrete allocation-failure propagation proposal before completing NLL storage/linking. Report: logs/p8-winbackend07e1/REPORT.md.


## P8-WINBACKEND-07E2 — six double arrays ported; independent wrapper blocker

Applied Windows checked malloc/free for azimuths plus p_time, p_error, s_time, s_error and weight, retaining double/runtime MAX_NUM_ARRIVALS counts, uninitialized storage, original writes/formulas/loops and POSIX VLAs. Caller checks gap failure before secondary use; named NLL_VPVS_STORAGE_FAILURE (-2.0) distinguishes fatal storage failure from original nonfatal insufficient-pair -1. Both failures follow existing clean_memory(EXIT_ERROR_LOCATE) before saved output. No new mutable status flag or extra serialization assumption. Applied patch SHA-256 AB06135A5929F29E3CACA85DC6BF177CD0E50E9636402AF027D8B8DCD3BE7789.

NLLocLib.obj compiles as AMD64 COFF. locnll target exits 1 on newly exposed nll_locator.cpp/MSVC iomanip tm type/name collision with original map_project.h:11 global projection function. Compile-only probes reproduce the conflict and show early iomanip parsing avoids it; exact Windows include-order proposal remains UNAPPLIED (SHA-256 CD5E32FBDAC77609D7C72DBC98117882E9890BE1476182CF9F8534175C9F5028) as required for independent blockers outside 07E2 scope. No plugin DLL/build credit: inventory stays 94/120 built, 21 Windows-blocked, 1 dependency-blocked, 4 disabled; GUI11/11. All279 archived completed outputs, stages, nine frozen repositories, 07E adapter and 07E1 matrix change preserved. Historical config custody INCOMPLETE and 07A Tau exception retained. No runtime/scientific execution or repeated adapter checks. Next: review/apply the focused wrapper include-order proposal, retry locnll, then inspect actual link/closure evidence. Report: logs/p8-winbackend07e2/REPORT.md.


## P8-WINBACKEND-07E3 — original locnll built

Original locnll focused MSVC Release x64 build exits 0. AMD64 PE32+, createSCPlugin export, original NonLinLoc registration, provider named imports and recursive static DLL closure verified (17 private symbol pairs). DLL SHA-256 F7516CAEE225E205B44D18DEFC311617DD4653E4C89BFFD86771F0D699515520. Exact reviewed early-iomanip patch CD5E32FBDAC77609D7C72DBC98117882E9890BE1476182CF9F8534175C9F5028 applied/reverse-checked. Separate Windows-only logging macro argument correction uses narrow tableDir.string() for two diagnostics; patch SHA-256 C97E7A165254A996E730F514F513BB63353463EE447B451D8FC0B1EE7DFAE251. No scientific functions/interfaces changed; prior storage/failure handling and POSIX behavior preserved.

Inventory95/120 built,20 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11. All279 archived prior outputs,1503 protected files/stages and nine frozen repositories unchanged. Archive copying overlapped first compile (sequencing exception); all prehashes/archive/current copies match and no prior provider was rebuilt. Historical config custody INCOMPLETE and 07A Tau exception retained. No application/plugin execution, scientific replay, adapter-test repetition, dependency or process-protocol changes. Next workstream: existing scwfparam/locext native lifecycle proposal, without locator feature expansion. Report: logs/p8-winbackend07e3/REPORT.md.


## P8-WINBACKEND-07F — scwfparam and locext native builds complete

Private header-only C++ Windows process helper uses CreateProcessW, UTF-8/UTF-16 validation, MSVC quoting, explicit native .exe/PATH resolution, restricted duplicated standard-handle inheritance, RAII, synchronous actual DWORD status and application-owned asynchronous reaping. No shell/interpreter guessing, controller dependency, kill-on-close job, breakaway, timeout or force termination. scwfparam preserves configured argv/output-before-launch/wait option; locext preserves original XML/Origin/ID path with concurrent binary stdin/stdout and EOF. POSIX translation units reconstruct unchanged. GetMessage macro collision corrected locally; original scientific code untouched.

Both focused Release x64 builds exit0; AMD64 PE32+, External factory/createSCPlugin, recursive private DLL closure and26 private provider symbol pairs pass. Exact source patches and artifact hashes: logs/p8-winbackend07f/source-patches.json and artifacts.json. Backend97/120 built,18 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11. Archive282 outputs completed/verified before compilation; all prior outputs,1567 protected files/stages and nine frozen trees unchanged. Historical config custody INCOMPLETE,07A Tau prehash and07E3 sequencing exception retained. No runtime/child/scientific execution. Noncooperative-child bounded cancellation remains unresolved; indefinite owned I/O/wait is documented rather than introducing termination policy. Next batch: native acquisition mechanical blockers; qualify prepared process fixtures only after separate runtime authorization. Report: logs/p8-winbackend07f/REPORT.md.


## P8-WINBACKEND-07G — scwfas/scplot complete; acquisition blockers clarified

Two new original native targets build exit0: scwfas and scplot. AMD64 PE32+, recursive private DLL closure and24 named provider pairs verified. scwfas uses Windows CRT length-bounded comparison only for three ASCII HTTP status digits; three existing core methods receive Windows export annotations. Existing core exports all retained; before/after core hashes archived. scplot uses CRT cryptographic random suffixes and atomic exclusive binary temporary-file creation, retaining original data/file cleanup. Q330 GNU-only warning flag scoped away from MSVC. Six SeedLink consumers now compile the single original shared plugin.c and use existing native provider closure; frozen symlink identity recorded. Legacy SCREAM snprintf macro guarded for modern MSVC.

Eight acquisition targets attempted independently remain blocked by documented serial/socket/threading/scanner filesystem-identity contracts and platform headers. No transport/scientific redesign or process-helper change. Inventory99/120 built,16 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11. Archive286 outputs completed before compilation; only three archived core provider products changed, preimages retained. All1646 protected files/stages/nine frozen trees preserved. Historical config custody INCOMPLETE,07A Tau prehash and07E3 sequencing exception retained. Runtime/scientific NOT_RUN. Exact patches/artifacts/blockers: logs/p8-winbackend07g/REPORT.md. Next: scoped scanner file-identity/traversal and acquisition serial/socket/thread contracts; dependency graph decisions remain separate.


## P8-WINBACKEND-07H — shared header recovered; scanner native primitives compiled

Recovered frozen SeedLink plugins/plugin.h mode120000 link as a forwarding include to its single canonical header, preserving ABI/entry definitions without copies. SCREAM ring now identifies native MSVC x86/x64 little-endian explicitly; Linux branches unchanged. Seven independent original acquisition builds attempted, all exit1 at genuine socket/time/serial/filesystem API blockers; no new inventory credit.

Added real scanner Windows file-ID/volume, owned target-open, dynamic wide path, native enumeration and caller-event interruptible-second primitives; isolated C compile/width assertions exit0, AMD64 COFF. Not integrated into original scanner because its ino_t/private APIs and legacy one-%llu persistent identity format cannot hold volume64+fileID128. Exact minimal state-version/regex/signal integration proposal documented; no identity truncation, pathname substitution, fake POSIX functions or silent unsupported expression handling. Original MiniSEED scanner source remains frozen-identical. Backend99/120,16 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11. Archive288 outputs completed/verified before compilation, all outputs and protected/frozen baselines unchanged. Historical config/Tau/07E3 exceptions retained. No runtime/scientific execution. Report and hashes: logs/p8-winbackend07h/REPORT.md. Next: scoped scanner persistent-state and notification/ERE contracts, then real transport adapters.


## P8-WINBACKEND-07I — native MiniSEED scanner build complete

Original mseedscan_plugin builds exit0, AMD64 PE32+, original main/send_mseed path and static DLL closure verified. Windows tracking uses volume64+fileID128+original filename, one open target for identity/data and64-bit offsets; rooted traversal retains recursion/native order and explicitly fails ancestor reparse cycles. Versioned binary MSWIN1 state has length-prefixed UTF-8 names, full IDs/signed64 offset/time, required footer/count and strict rejection of malformed/truncated/legacy state. Existing approved Boost POSIX REG_EXTENDED|REG_NOSUB provider reused (no dependency change or pattern rewriting). Ctrl+C requests orderly stop, Ctrl+Break separately prints state through the scanner loop/event; non-console operation explicitly rejected pending a control contract. Original POSIX branches and MiniSEED record processing retained; no runtime execution.

Inventory100/120 built,15 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11. Archive288 outputs completed before compilation; all archived products,1799 protected files/stages and nine frozen trees unchanged. Historical config/Tau/07E3 custody exceptions retained. Exact hashes/provenance: logs/p8-winbackend07i/REPORT.md. Offline unified-installation planning can proceed, but service-mode acquisition, runtime/scientific qualification and remaining transports are not complete. Next: implement a focused remaining socket acquisition target and decide the scanner non-console control contract; no broad repeat reconnaissance.



## P8-WINBACKEND-07J / 08A — original socket plugin and unified development stage

Original sock_plugin focused VS2022/MSVC Release x64 build exits0; AMD64 PE32+, original main/send_mseed entry and static closure verified. Uses real Winsock SOCKET/closesocket with owned WSAStartup/WSACleanup, blocking IPv4 TCP, original partial receive/framing/reconnect behavior and existing Boost POSIX regex API. Native packed MiniSEED layout assertions compile; record parsing/decoding bodies remain byte-identical. Five scoped source patches and exact hashes are in logs/p8-winbackend07j/source-patches.json. Runtime/acquisition NOT_RUN.

Backend101/120 built,14 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11. New unified-08a-native candidate contains142 unique AMD64 PE files/all11 original GUIs and769 manifested files, original installation layout/resources and one selected provider graph.371 private import relationships (including41 ordinal imports), normal/delay imports and private forwarders match selected exports. Current core/client selected explicitly; 07B PG/OpenSSL/libxml/zlib collision policy retained. Three stale inventory provider hashes reconciled against earlier verified artifacts/current prebuild archive, not rebuilt. Previous stages remain unchanged. Static import compatibility is not dynamic-loading or semantic runtime qualification.

Original defaults plus isolated DB-driver selection, writable directory structure, process-local environment file and startup/discovery requirements prepared without execution. Pinned external Python3.10.11 remains required; general Python SDK/Twisted applications excluded. Four generated Tau table inputs absent; geodata/inventory/NLL grid provenance and runtime profiles remain open. Only previously qualified kernel/scautoloc controller handlers registered; others retained inactive. Scanner remains console-only/not service-ready; focused non-console follow-up specification prepared, no new STOP/service/termination protocol.

Archive289 existing outputs completed/hash-verified before compilation; all1826 protected prior files/stages and nine frozen repositories preserved. Historical pre-06C1 config custody INCOMPLETE,07A Tau prehash and07E3 archive/build overlap exceptions retained. No provider/GUI/controller rebuild, dependency upgrade, Phase7 or ew2sc deadline change. Runtime/scientific NOT_RUN; Phase5A PARTIAL. Report: logs/p8-winbackend07j/REPORT.md. Next prioritize model/resource and original Python/core seismic-processing closure, followed by separately authorized isolated database/loader qualification; further controller features deferred.


Exact 07J patch SHA-256:

- `P8-WINBACKEND-07J-sock_plugin.c.patch`: `832545387B2F7F61643D09789CE59510856D8F4A559D83ECEAAD02A85B29380F`.
- `P8-WINBACKEND-07J-seedutils.c.patch`: `6D73C61A50E58B1DD678662B4B711D0D851737A6091E08D93A7D91404416BC91`.
- `P8-WINBACKEND-07J-seedutils.h.patch`: `9468A693EB8348EA6DA683D0E2F42C8E87B08EA7C5C12D31D480ADB41105C8A8`.
- `P8-WINBACKEND-07J-CMakeLists.txt.patch`: `6B4F6AEF22EBA429D706733A30C0416608B2778EED0D26A2705100624E48BAFF`.
- `P8-WINBACKEND-07J-windows_socket_private.h.patch`: `3758B84B94581D37744F45BC1260DC529DBBC2F1DA1699BC6194511360DEBA2B`.


## P8-WINBACKEND-07K — original Python SDK closure and scientific-resource preparation

Eight additional original CPython3.10.11 x64 extensions build exit0: _io,_utils,_datamodel,_math,_seismology,_client,_geo and _strongmotion. Original retained SWIG4.4.1 sources, package/module names and signatures preserved; DataModel package initializer and strong-motion submodule use original install structure. Windows missing export declarations, local GetMessage macro guard and DataModel /bigobj fix actual compiler/linker failures. No scientific implementation body changed. Necessary core dependency rebuilt with32 added exports/all11659 prior named exports retained; client and all other previous providers/GUI executables unchanged. Twelve original extensions now compiled; no extension imported.

Canonical backend101/120 built,14 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11. Eight new SDK outputs reported separately, not added to120. Revised offline unified-08a-r2-native contains150 AMD64 PE files,828 manifested files,389 verified private import relationships and31 original script sources prepared by static syntax/import assessment. One selected graph uses the additive core revision; original08A and every prior stage preserved. Original root initializer/four extensions,PG/OpenSSL/libxml decisions,QC/locator/acquisition/providers/schemas unchanged. Process-local Python/startup requirements prepared; no global dependency/PATH/service changes or controller guard expansion.

Tau recovery0/4 after recorded searches of retained Windows and Linux source/reference/build artifacts. Original iasp91/ak135 model inputs match pinned common source; exact reader/generator/limits/binary hashes and format/paths documented. Original native generators already available; deterministic isolated invocation plan prepared only. Model-generator execution NOT_RUN under07K restriction; no scientific tables invented. Required metadata,NLL grids,waveforms,external Python dependencies and all runtime/scientific gates remain unresolved. Scanner remains console-only,child cancellation unbounded,disabled components and remaining acquisition targets unchanged.

Archive290 outputs completed/hash-verified before compilation. Only core DLL/import/export products changed; archived preimages/before-after hashes retained. All frozen/protected prior files/stages preserved. Historical pre-06C1 config custody INCOMPLETE,07A Tau prehash and07E3 sequencing exceptions retained; Phase7 and ew2sc deadline proposal untouched. Report: logs/p8-winbackend07k/REPORT.md (24 October2026). Next: separately authorize exact original Tau generation/reproducibility and isolated native Python/loader/SQLite qualification,then essential seismic-processing resource/fixture completeness; no optional controller expansion. Phase5A PARTIAL; runtime,science and release NOT_RUN/NOT_QUALIFIED.


Exact patch SHA-256:

- `P8-WINBACKEND-07K-common-libs-swig-CMakeLists.txt.patch`: `FA8CB88583A260ACE8A8D3321291B81E5B6D1D3F2CC37CDDB531C0D614102168`.
- `P8-WINBACKEND-07K-contrib-sed-libs-CMakeLists.txt.patch`: `10A1573F16842BF8EBDBB427857DC3734AE9C7204CFCE032463F93A86627A0E5`.
- `P8-WINBACKEND-07K-contrib-sed-libs-swig-CMakeLists.txt.patch`: `34FE9403C1CB16290FC85BBE45E3AD180B02119EB134EAF008C17F86CC12D619`.
- `P8-WINBACKEND-07K-common-libs-swig-datamodel_python_wrap.cxx.patch`: `C3622CE09E3DEC7BF82722AF535F9FB9FF06B191DFE898DEF84E25399E6273EB`.
- `P8-WINBACKEND-07K-common-libs-swig-datamodelext.i.patch`: `E0DF7FBD1BAAF64FEDF50C9C9F4C25917A6B43853F85A232AECC88F413358D98`.
- `P8-WINBACKEND-07K-common-libs-seiscomp-datamodel-publicobjectcache.h.patch`: `8B9FFEBF3418DF404D584A60FE585CE9CF7E034AEA7FFB60DFF4A723F4ED3634`.
- `P8-WINBACKEND-07K-common-libs-seiscomp-datamodel-exchange-quakeml.h.patch`: `AAD93E531EBB984BEC44321CEDE4967238D0AAB2409B31BA5BC6381805ED8EE2`.
- `P8-WINBACKEND-07K-common-libs-seiscomp-geo-boundingbox.h.patch`: `042D2AADC690FE50B80C3B97C0F5428ED18366F4CF8A400A270CD48E5D1B5CCA`.
- `P8-WINBACKEND-07K-common-libs-seiscomp-geo-coordinate.h.patch`: `D08F165062A80DFCFC3A043922C71A0BD981D042978804D86D9FCCA2689A2077`.
- `P8-WINBACKEND-07K-common-libs-seiscomp-geo-feature.h.patch`: `B3E6D24254ABB011A002A8C7141A67A77DA252BCEBB073B2462841BF2119DC19`.
- `P8-WINBACKEND-07K-common-libs-seiscomp-geo-featureset.h.patch`: `B6B6B065BFAB7DB14108AE6E48FB76773082C6A0D2E47E718ACD4D82F6BA8FCC`.
- `P8-WINBACKEND-07K-common-libs-seiscomp-math-filter-biquad.h.patch`: `0FDA30F41C4F3D3D14C5967B2C4089D57D4A62D9AA87173D2B4F5314EE7E2AB0`.


## P8-WINBACKEND-07L — original Tau resources generated and integrated

Authorized original tau_remodl/tau_setbrn execution for IASPEI91 and AK135 completed in separate fresh local fixed NTFS directories; all four invocations exit0,empty stderr. Exact approved model/generator hashes verified before execution,local copies and process-local environment only. The four final .hed/.tbl files pass source-derived representation/dimension/header and complete table-record compatibility checks. Both headers146472 bytes; table records have no gaps,overlaps,missing or trailing bytes. Original101 overflow??? listing traces reviewed against unconditional source logging,not suppressed. No model contents,equations,interpolation,limits or original source/binaries changed. Actual resource loading and Linux scientific comparison remain NOT_RUN.

New unified-08a-r3-native derives from verified revision2,adds four share/ttt resources and revised qualification/resource documentation. All150 existing PE files,12 native extensions,11 GUI executables,selected providers/schemas/configurations remain byte-identical;389 private relationships/selected graph unchanged. Candidate839 manifested files. Original08A/revision2 and every prior stage preserved. Scientific resource manifest: inventory/tau-scientific-resources.json; actual commands,exits,sizes and hashes: logs/p8-winbackend07l/REPORT.md and scientific-resource-manifest.json.

Backend101/120 built,14 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11,Python12/12. Resource files do not change the120-target binary inventory. Updated07C-derived future Python/package imports,Tau discovery/loading,dynamic DB plugins,SQLite original schema/DataModel persistence,messaging/controller dependencies and GUI readiness plan prepared only. No such check executed; Y: staging and the generator directory are not admitted general runtime sandboxes. Optional Python packages and original metadata/NLL/waveform/runtime limitations retained.

All314 existing build products,4048 protected prior files/stages,nine frozen snapshots and frozen Linux references preserved. Historical pre-06C1 config custody INCOMPLETE,07A Tau prebuild-hash and07E3 sequencing exceptions retained;successful new generation does not repair them. No rebuild,dependency upgrade,Phase7,ew2sc deadline,service,controller STOP/reload or operational configuration change. Only original Tau generators executed. Phase5A PARTIAL; application runtime,numerical/scientific parity and release qualification remain unverified. Next: separately authorized admitted-local Python/loader/Tau-reader/SQLite qualification using the prepared plan,then genuine scientific fixture/parity work.


No upstream/native source patch or binary rebuild in07L. Generation-harness path/environment correction only; original generator/model bytes and scientific arguments retained. New resource SHA-256:

- `iasp91.hed`: `E760C8414C0032BB643BB90C1B5E843DB54266BF894166FD4C664EE7E47913B2` (146472 bytes).
- `iasp91.tbl`: `66137F3E8FC5DB0CD03A5564924EB8E8046A5A6D16E71B16C62075C686515860` (229712 bytes).
- `ak135.hed`: `2853EEC6604FEFAB3C0B3FB71447CA5E13111BAF2A359653DA22A84EFCA2A3AD` (146472 bytes).
- `ak135.tbl`: `C593C6C4392995F1D5994B655A822A7D44EC03E5D65CDDE8A39E01D3D4EB9B1C` (225600 bytes).


## P8-WINBACKEND-08B1 — isolated qualification prepared, execution NOT_RUN

Created a separate fixed local NTFS preparation copy: exact R3 manifest839 files/150PE,
unchanged389 private relationships, separate original07C harness+20DLL flat DB deployment,
and2257 original CPython3.10.11 x64 runtime/stdlib files. Hash/AMD64/private import/export
checks and source AST checks pass; no target executable,extension,plugin,Tau reader or DB
harness ran. All twelve imports,Tau discovery/models/P/S/errors/cleanup,and SQLite original
factory/schema/transactions/Pick/Origin/reconnect/cleanup are individually NOT_RUN.

Host has active adapters; Hyper-V guest inspection is denied by authorization policy.
No disposable guest/isolation evidence or separate execution approval is available.
Boundary NOT_ADMITTED. Exact payload/probe manifests,source-only bounded owned runner,
actual-module observation,admission receipt requirements and fixed four-file cleanup are
prepared in qualification08b1/README.md; none of the new runtime orchestration is qualified.
Report: logs/p8-winbackend08b1/REPORT.md; results: qualification08b1/results.json.

Backend101/120,GUI11/11,Python12/12,Tau4/4 unchanged; no rebuild,regeneration,dependency
upgrade,scientific/upstream source correction,Phase7,ew2sc deadline,controller or service
change. All314 build products,4946 protected files/stages,nine frozen repositories and
original Python runtime/source/inventory/provider identities preserved; Linux source pins
remain clean. Pre-06C1 config custody INCOMPLETE,07A Tau prehash and07E3 sequencing
exceptions retained. Next: operator-provided disconnected disposable VM/admission and
separate explicit scoped runtime approval,then actual imports/Tau/SQLite and genuine core
processing fixture/parity work. Phase5A PARTIAL; science/operation/release unqualified.

New qualification-only source patch: `P8-WINBACKEND-08B1-qualification-preparation.patch`, SHA-256 `8A610918924A0754FC7E549A1D0C927AE0B4D7EACF80EAD69ECF4DA76C52A685`. No copied upstream source patch or binary revision. Detailed source hashes: logs/p8-winbackend08b1/source-record.json. Runtime NOT_RUN.


## P8-WINBACKEND-08B2 — development resumed; backend 102/120

Operator follow-up makes a VM optional for source development, MSVC builds, original
GUI integration and packaging. WINDOWS_DEVELOPMENT_ROADMAP.md records that direction;
existing 08B2 execution restrictions remain and no supervised local replacement is
authorized. Hyper-V inspection remains denied; no guest transfer or runtime execution.

Completed original scream_plugin: focused Release x64 configure/build exits0, AMD64
PE32+, original main/send_raw3 and static system-provider closure verified. Native
pointer-width Winsock TCP/UDP, partial reads, original packet/truncation behavior and
owned cleanup; GCF decoder/mapping/dispatch/main sources unchanged. Linux conditional
source-token projections equal preimages. Windows diagnostic tuple-format mismatch
corrected without changing scientific code; all remaining warnings retained.
Artifact SHA-256 `44CCA3596464041FA510C9F49EBD08535D024E485307BA1F48D6729F7EEC2CEE`.

New unified-08a-r4-native has151 PE/846 manifested files; all150 prior PE identities,
389 private relationships,11 original GUIs,12 extensions,4 Tau resources and providers
remain unchanged. R4 manifest `FD79AE54DA59B0704C976267ECF9F522B324AA10E792A84A27356BCAE5B3C0BE`.
Per-user Windows copy installer/process-local environment and installation/launch guide
prepared with no Hyper-V dependency. Script AST checks and installer -WhatIf pass;
destination unchanged, actual installation/launch NOT_RUN. Original external Python
home/controller limitation is explicit, not silently changed.

Backend102/120:13 Windows-blocked,1 dependency-blocked,4 disabled. Only scream_plugin
inventory row changed. All314 archived outputs,5003 protected files/stages,nine frozen
repositories and existing08B1 qualification payload remain preserved. Pre-06C1 config
custody INCOMPLETE,07A Tau prehash and07E3 sequencing exceptions retained. No provider/
GUI/controller rebuild,dependency upgrade,Tau regeneration,Phase7,ew2sc deadline or
operational/service change. All twelve imports,Tau/DB/SQLite/GUI/acquisition/scientific
runtime outcomes NOT_RUN. The source-only08B1 one-process-job/PowerShell subprocess
conflict is recorded for focused correction; no replacement probe was created.

Report: logs/p8-winbackend08b2/REPORT.md. Next: essential database/core-processing and
fixture completeness, qualified orchestration plus separately approved supervised local
testing, while continuing independent backend ports. Phase5A PARTIAL; no release claim.

Applied patch hashes:

- `P8-WINBACKEND-08B2-scream-CMakeLists.txt.patch`: `87E76EEE1D9A7BA55F56BDBCB93F4D1CDE3A624E04D78162A9FEA5537A893D7D`.
- `P8-WINBACKEND-08B2-scream-oscompat.h.patch`: `27BC41FF06044C7D6E5808A0936D314E674976ED15E4CB1D40440C92387CEA16`.
- `P8-WINBACKEND-08B2-scream-scream.c.patch`: `D28778B9E742119B2931736D240BCB39E6E9B4640F822AEBAEB34381D415CC19`.
- `P8-WINBACKEND-08B2-scream-util.c.patch`: `2B1C43464BF61FD17CCC9840005421D5C209DBE7E851E6C5266176634C4BEC5D`.
- `P8-WINBACKEND-08B2-scream-util.h.patch`: `740A826FBECF5BC70E6272CD9C0719E4627DD40683958CD7991DDF61A3CDC95D`.

Packaging-source identities: logs/p8-winbackend08b2/windows-package-sources.json. No scientific implementation changes.
