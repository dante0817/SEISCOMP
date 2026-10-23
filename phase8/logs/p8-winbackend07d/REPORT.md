# P8-WINBACKEND-07D — Boost closure and native QC completion

Date: 23 October 2026. Existing VS2022/MSVC 19.44 Release x64, C++17, /MD. **Twelve new targets completed; backend94/120**, GUI11/11. Remaining:21 Windows-portability blocked,1 external-dependency blocked,4 disabled. No SeisComP executable/plugin was run.

## Dependency provenance

The existing 07A proposal was reused. Exact vcpkg checkout `1e199d32ad53aab1defda61ce41c380302e3f95c` is clean. Only `boost-signals2` and `boost-parameter`, version1.90.0 port revision1, were missing from the pinned recursive graph. All required installed Boost ports are1.90.0, including Fusion,MP11,Utility; version.hpp is109000. `dependency-provenance.json` records recipes, complete declared graph, installed version records, archive SHA-512/SHA-256 and original BSL-1.0 license hash. Signals2 reuses the verified05J archive; Parameter was retrieved from the official Boost1.90.0 tag and verified against its pinned recipe. Complete original include trees:43+100=143 headers; no collisions, symlinks or replacement files. Header/license provenance is under `phase8/tools/boost-1.90.0-qc-headers`.

The separate CMake hook exposes headers privately to exactly the provider,ten plugins,and scqc. Generated-project scope and actual MSVC /showIncludes transitive header edges/hashes are in `header-and-registration-evidence.json` (1430 distinct Boost headers). Existing installed Boost libraries,package status and GUI overlay are preserved. No Asio provisioning or system-wide dependency changes.

## Build/link inventory

| Target | Final compiler/linker exit | Architecture | Static interface evidence |
|---|---:|---|---|
| seiscomp_qcplugin | 0 | AMD64 PE32+ | provider exports |
| qcplugin_availability | 0 | AMD64 PE32+ | createSCPlugin |
| qcplugin_delay | 0 | AMD64 PE32+ | createSCPlugin |
| qcplugin_gap | 0 | AMD64 PE32+ | createSCPlugin |
| qcplugin_latency | 0 | AMD64 PE32+ | createSCPlugin |
| qcplugin_offset | 0 | AMD64 PE32+ | createSCPlugin |
| qcplugin_outage | 0 | AMD64 PE32+ | createSCPlugin |
| qcplugin_overlap | 0 | AMD64 PE32+ | createSCPlugin |
| qcplugin_rms | 0 | AMD64 PE32+ | createSCPlugin |
| qcplugin_spike | 0 | AMD64 PE32+ | createSCPlugin |
| qcplugin_timing | 0 | AMD64 PE32+ | createSCPlugin |
| scqc | 0 | AMD64 PE32+ | application imports |

Each final row references its own `<target>.log`, `<target>.exit_code.txt`, and `<target>-command.json` in this directory. Builds used `/p:BuildProjectReferences=false` after prerequisite scheduling, `/p:TrackFileAccess=false` for the established FileTracker path issue, and process-local `CL=/showIncludes`. Configure exit0. Existing client provider separately rebuilt exit0 before QC. No full-solution or Qt build. Raw warnings and failed attempts retained: `*-initial.*`, `*-pre-export.*`, `*-incomplete-type.*`.

`artifacts.json` records every target/provider SHA-256,recursive private import graph,and matching named import/export pairs. PE headers/imports/exports are retained as raw dumpbin logs. The ten plugin sources match frozen originals byte-for-byte and retain ADD_SC_PLUGIN plus REGISTER_QCPLUGIN and original registered names. Static entry exports are verified; dynamic loading is NOT_RUN.

## Pinned source / patch provenance

Frozen before/after revisions match: superproject `9c395c7f00c788c5fc640363abe97b9ced0b44b0`, main `f63cde995e04151dc816151359a036b8b15f6019`, common `92d2202a6065aad36ae7d4a9bf960b6fb91222d2`. All nine frozen repositories retain their recorded clean status and file hash vectors. `original-qc-source-hashes.json` additionally confirms 30 unchanged QC implementation/header files; the two intentional header corrections are isolated below.

07D authorizes localized Windows compilation/linkage corrections. Initial provider LNK2019 named original `QcProcessorObserver::QcProcessorObserver`; that client class lacked its existing library's API annotation. Plugin/scqc linker failures then named original QcPlugin methods/RTTI,whose class also lacked its existing API annotation. Both annotations are now guarded by `_WIN32`. Exporting QcPlugin instantiated its intrusive_ptr<QcBuffer> member before the type was complete (C3861 intrusive_ptr_release); Windows now includes the existing qcbuffer.h. No function bodies,calculations,parameter meanings,protocols or Linux branches changed. Patches are against exact frozen originals; before/after file hashes in `patches.json`.

- `P8-WINBACKEND-07D-qc-windows-exports.patch`: `78DD2EE1152F1DB3BAB5844DE47D6A4A53D87B333AE90105B09252C304D47D51`
- `P8-WINBACKEND-07D-qc-boost-scope.patch`: `0EEFD8E51CBC67A483D25FA1495C1845A6D202CB1D88EF91CE125B69F473E059`

## Provider dependencies and custody

`build-products.json` records 37 final DLL/EXE/import-library/export-file hashes. `overlay-and-provider-compatibility.json` confirms all 143 original header license notices and every previous client export are retained, with 15 observer exports added. Static closure checks match 55 private consumer/provider symbol pairs. `evidence-sha256.json` covers the report, build logs, dependency provenance, patches, overlay, and updated inventory/status/ledger.

QC provider imports the original client/core/config providers and pinned Boost/native dependencies; plugins reuse the same QC provider,and scqc links original client/QC. `artifacts.json` contains the exact graph,provider hashes and Windows/API-set/VC-runtime boundary. Named private imports match selected exports recursively; this does not verify runtime discovery or DLL initialization.

Before compilation,245 existing products including nested Tau,SQLite,database libraries and qualification products were archived and hash-verified in `binary-before/`; `before.json` records1238 protected prior files and all nine frozen source vectors. Final static/preservation verification confirms frozen HEAD/status/file hashes,all protected files,archive hashes,installed Boost library hashes and installed package status. Only these pre-existing outputs changed:

- `seiscomp_client.lib`: `DBE6F5C6FF507A83591F5B3BE9ACFF328C51DD9553F3D22BD5D1FC3F68EE7A27` → `6B28F2A0F17BD062C954B77A5DE4A62076E798BBFA846F67CA330C06C074B340`
- `seiscomp_client.exp`: `9EC62B0708F91CFCD5B58304CC8D72B518812B6626E5BD4332DD37AECCF93257` → `680FEA65169E60A6100C7CBA6FBDC7994584BC72691C9B9F33FF605D24300AAA`
- `seiscomp_client.dll`: `C458AC4F88C060E815D4C82EC57412670AED90368D17545A816F25A7D5D38EA4` → `302AA40361BC4EA3507E62E0A2CC5B5DBD2068DC371DE40F606F6A024B3CB50B`

Prior matching GUI,controller and database stages were not modified. Their prior client revision remains within those stages. New QC products use the rebuilt current client; no mixed provider revision was staged. Historical pre-06C1 configuration DLL custody remains **INCOMPLETE**,and historical07A nested Tau prebuild hash remains unavailable; neither gap is retroactively repaired. ew2sc deadline proposal and Phase7 remain untouched.

## Remaining independent blockers

These retained blockers were not broadened or retested during QC completion. Canonical CSV/JSON and `inventory-summary.json` contain the current complete120-target inventory.

| Target | Current state | Exact retained blocker |
|---|---|---|
| chain_plugin | Blocked by Windows portability | POSIX unistd.h; forked SLCD worker and FD61/62/63 extension transport need the separate contract/architecture proposal. |
| dbmysql | Disabled by CMake configuration | CMake-disabled; no matching MySQL/MariaDB client SDK qualified in configured roots. Exact API/SDK requirements and next build plan: logs/p8-winbackend07b/dependency-qualification.json. No dependency provisioned. |
| echopro_plugin | Blocked by Windows portability | MSVC Release build exit 1: echopro_plugin.c includes unistd.h; plugin.c is a 24-byte path-text file ("../libs//plugin/plugin.c") compiled as C, causing C2059. Exact repair proposal: restore correct source/link ownership and provide Windows primitives; do not modify upstream source in this batch. |
| ewexport_pasv_plugin | Blocked by Windows portability | C1083 unistd.h and netinet/in.h missing; shared plugin.c source is materialized as literal path text in the Windows working copy and triggers C2059. |
| ewexport_plugin | Blocked by Windows portability | MSVC Release build exit 1: ewexport_plugin.c and network.c include unistd.h; swap.c includes netinet/in.h. Native POSIX socket/time API port required. |
| gdrt_plugin | Blocked by external dependency | MSVC Release build exit 1: udpclient.h includes boost/asio.hpp, absent from installed and approved Boost 1.90.0 headers. No dependency provisioning authorized/attempted for this package. |
| hypo71 | Disabled by CMake configuration | SC_IPGP_HYPO71=OFF; stale vcxproj excluded from current solution |
| Hypo71PC | Disabled by CMake configuration | SC_IPGP_HYPO71=OFF; native Fortran/MSVC generator route unresolved |
| iloc | Disabled by CMake configuration | SC_TRUNK_LOCATOR_ILOC=OFF |
| locext | Blocked by Windows portability | Compiler C1083: missing unistd.h in external.cpp; implementation also uses POSIX fork/pipe/dup2/exec/wait semantics for external locator processes. |
| locnll | Blocked by Windows portability | Compiler C1083: missing dirent.h in contrib-sed/libs/3rd-party/nll/GridLib.h; GridLib.c depends on dirent, scandir, alphasort and fnmatch for wildcard expansion. |
| minilogger_plugin | Blocked by Windows portability | MSVC Release build exit 1: mini_logger_writer.c includes unistd.h; minisepdevice.c includes dirent.h. Needs native file enumeration and platform I/O proposal. |
| mseedfifo_plugin | Blocked by Windows portability | POSIX unistd.h plus materialized plugin.c symlink text; native external FIFO input contract unresolved. |
| mseedscan_plugin | Blocked by Windows portability | Compiler C1083: unistd.h unavailable in mseedscan.c. |
| naqs_plugin | Blocked by Windows portability | MSVC Release build exit 1: naqs_plugin.c includes unistd.h; naqs_utils.c includes netdb.h. Native socket/process portability work required. |
| q330_plugin | Blocked by Windows portability | MSVC Release build exit 1: generated MSVC command receives GNU-only /Wno-incompatible-pointer-types (D8021). Prepare a compiler-scoped warning-flag proposal. |
| reftek_plugin | Blocked by Windows portability | MSVC Release build exit 1: CMake custom command invokes MSBuild with GNU make arguments (-C ... PLATFORM=...), and requests Linux defines. Reftek libraries use nested Makefiles; native CMake/MSVC build integration required. |
| scplot | Blocked by Windows portability | Linker LNK2019/LNK1120: unresolved mkstemp from vendored gnuplot_i.c Windows build. |
| scream_plugin | Blocked by Windows portability | C1189 legacy snprintf macro conflicts with MSVC UCRT; C1083 unistd.h; shared plugin.c source is materialized as literal path text and triggers C2059. |
| scream_plugin_ring | Blocked by Windows portability | C1189 snprintf macro conflicts with UCRT; oscompat.h rejects unknown endianness; C1083 sys/time.h and unistd.h; shared plugin.c source is materialized as literal path text and triggers C2059. |
| scwfas | Blocked by Windows portability | Compiler C1083: strings.h unavailable on MSVC; fdsnws.cpp calls strncasecmp; session.cpp includes the same POSIX header. |
| scwfparam | Blocked by Windows portability | Compiler C1083: sys/wait.h unavailable; source also uses fork/execv/waitpid for output script execution. Requires native process-lifecycle port. |
| serial_plugin | Blocked by Windows portability | C1083 unistd.h missing across the shared serial reader and protocol sources. |
| sock_plugin | Blocked by Windows portability | C1083 netinet/in.h and unistd.h missing; shared plugin.c source is materialized as literal path text and triggers C2059. |
| wave24_plugin | Blocked by Windows portability | C1083 sys/socket.h and unistd.h missing; Wave24Logger.cpp also fails const char* to char* initialization and matching overload resolution. |
| win_plugin | Blocked by Windows portability | C1083 sys/time.h missing; shared plugin.c source is materialized as literal path text and triggers C2059. |

Recommended next batch: original scientific-processing completeness,starting with locnll's directory/wildcard portability while preserving path matching and scientific code. Define native child-process lifecycle semantics separately for scwfparam/locext. Localized scwfas source compatibility can proceed independently; acquisition transports requiring networking/process contracts remain explicitly scoped. Asio and disabled locator/MySQL dependency closures remain separate decisions. Do not expand controller features.

## Gate register (Phase5A template)

| Gate | State | Evidence | Exit/command | Limitations |
|---|---|---|---|---|
| A: Source + Phase4C evidence | NOT_RUN as full gate | before.json;artifacts.json | Custody verified by prepare.py/verify-static.py | Phase4C audit not repeated;historical custody gaps retained |
| B: Transitive dependency closure | NOT_RUN as full gate | dependency-provenance.json;header-and-registration-evidence.json;artifacts.json | Focused builds exit0;command JSON/raw logs | QC engineering/static closure only;whole-install closure incomplete |
| C: Linux original Autoloc offline oracle | NOT_RUN | None | Not run | No fixture/oracle execution |
| D: Windows native original Autoloc offline executable | NOT_RUN | None | Not run | No application execution |
| E: Replay equivalence and robustness | NOT_RUN | None | Not run | No scientific replay or functional runtime tests |

## Linux fixture + result provenance

NOT_RUN;no fixture consumed.

## Windows fixture + result provenance

NOT_RUN;no application,plugin,controller,GUI,database or live network acquisition executed. Only the explicitly authorized dependency source archive was retrieved. Database qualification remains prepared,NOT_RUN.

## Numerical difference matrix

| Scenario | Linux origins | Windows origins | OT/epicenter/depth differences | Association differences | Result |
|---|---:|---:|---|---|---|
| Not run | — | — | — | — | NOT_RUN |

## Evidence gaps and final assessed milestone

Phase5A **PARTIAL**. Twelve original native QC build targets are complete with static engineering evidence. Dynamic plugin loading,QC runtime,scientific/numerical parity,database runtime qualification and release certification remain unverified. Full gates A–E are not complete.
