# Native Windows Port — Implementation Status

## P8-WINBACKEND-08C5 — Earthworm export built; backend106/120

Original ewexport_plugin builds native AMD64 PE32+ with Winsock nonblocking I/O
and cooperative CRT receiver cancellation/join. Shared-buffer reuse/reconnect is
refused on3000ms join failure;no forced thread kill. Original message framing,
acknowledgement/trace conversion/processing preserved. Mechanical receiver helper
passes two cancel/join/restart generations,guard network entries0;original target
and real acquisition NOT_RUN. Build23warnings/0errors retained.
Revision9 adds one executable;154 previous binaries,11GUIs,12Python extensions
and4Tau resources unchanged. Backend106/120;9Windows-blocked,1dependency blocker,
4disabled. All317 watched old products,revision8 and9 frozen repositories preserved.
No dependency/security/service/controller/Phase7/operational change. Report:
logs/p8-winbackend08c5/REPORT.md. Phase5A PARTIAL;runtime/science/release remain open.


## P8-WINBACKEND-08C4 — SCREAM ring built; WIN input fixed; backend105/120

WIN control-file argv index corrected;6 extracted-block cases pass. Original
scream_plugin_ring now compiles/links with native CRT workers,SRW locks,Winsock,
waitable timers and process-local clock/TZ adapters. GCF/mapping files,ring stack
and worker packet/ordering logic retained. Original process-exit lifetime kept;
workers are not joined and graceful/service shutdown remains unqualified.
Revision8 adds ring and updates WIN;152 other previous binaries,11GUIs,12Python
extensions and4Tau resources unchanged. Backend105/120;10Windows-blocked,1dependency
blocker,4disabled. Initial diagnostic-macro build and failed intermediate compile
retained;final build0. No original acquisition/network/scientific execution.
Nine frozen snapshots,revision7 and315 other watched products preserved. No package,
security,service,controller,Phase7 or operational change. Report:
logs/p8-winbackend08c4/REPORT.md. Phase5A PARTIAL; integration/runtime remain open.


## P8-WINBACKEND-08C3 — original WIN UDP target built; backend104/120

Original win_plugin compiles/links natively with pointer-width Winsock,UDP/multicast,
owned cleanup,console stop/reload and Windows Event Log output adapters. Original
decoder/queue/time/sample bodies and packet decode tail retained; only transport
buffer casts alter resend/request bodies. Revision7 adds one executable; all152
prior PE binaries,11GUIs,12Python extensions and4Tau resources remain unchanged.
Backend104/120;11Windows-blocked,1dependency-blocked,4disabled. Build101 warnings
retained,0errors. Native imports,source preservation and package hashes checked;
no runtime/test campaign. All315 prior products,revision6 and9 frozen repositories
preserved. No dependency/security/service/controller/Phase7 or operational change.
Report: logs/p8-winbackend08c3/REPORT.md. Next: remaining socket acquisition ports,
then thread/serial/IPC and essential integration. Phase5A PARTIAL.


## P8-WINBACKEND-08C2 — original NAQS acquisition target built; backend103/120

Original naqs_plugin now compiles/links as native AMD64 PE32+ with full-width
Winsock handles,owned startup/cleanup,native signals/sleep and existing Boost POSIX
regex adapter.24 original protocol/processing/selection function bodies retained.
Revision6 adds only this executable and package metadata; all151 previous PE files,
11GUIs,12Python extensions and4Tau files remain unchanged. Backend103/120;12Windows
portability blockers,1dependency blocker,4disabled. First strcasecmp link failure
resolved with Windows CRT _stricmp; failure and remaining warnings retained.
Build/static package checks only; no target/server/network/scientific execution.
All314 watched old products,revision5 and9 frozen snapshots preserved. No new
dependency,policy,service,controller,Phase7 or operational change. See
logs/p8-winbackend08c2/REPORT.md. Next: remaining socket acquisition ports,then
thread/serial/IPC contracts and essential integration. Phase5A PARTIAL.

## P8-WINBACKEND-08C1 — corrected core integrated into revision 5

The original native core now includes approved WIN-FIX-01 R1/R5 and WIN-FIX-02 R2.
VS2022 x64 compilation and actual DLL link exit0. All11,691 prior named exports
and their ordinals remain;389 private dependency relationships resolve statically.
New unified-08a-r5-native contains151 PE files/847 manifested files. All150 other
PEs,11 original GUIs,12 Python extensions and4 Tau resources retain revision4 bytes.
Backend102/120 remains unchanged. The new source-corrected core is now packaged.

Verification was limited to build/link,native PE/dependency compatibility,package
hashes and required frozen-source preservation. No regression campaign,original
application launch,service,network,DB or scientific workload ran. First direct Link
target skipped output;hash comparison caught it and the actual _Link invocation
produced the new DLL. Both attempts and prebuild core products are retained.
No new source patch,dependency,execution policy,security or operational change.
External Python home and historical custody exceptions remain. Old stages and
sealed evidence remain unchanged. Report: logs/p8-winbackend08c1/REPORT.md.
Next: finish remaining socket acquisition ports and essential application integration;
broad review closed. Phase5A PARTIAL; runtime/science/release qualification open.


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

## P8-WINBACKEND-07L — original Tau resources generated and integrated

Authorized original tau_remodl/tau_setbrn execution for IASPEI91 and AK135 completed in separate fresh local fixed NTFS directories; all four invocations exit0,empty stderr. Exact approved model/generator hashes verified before execution,local copies and process-local environment only. The four final .hed/.tbl files pass source-derived representation/dimension/header and complete table-record compatibility checks. Both headers146472 bytes; table records have no gaps,overlaps,missing or trailing bytes. Original101 overflow??? listing traces reviewed against unconditional source logging,not suppressed. No model contents,equations,interpolation,limits or original source/binaries changed. Actual resource loading and Linux scientific comparison remain NOT_RUN.

New unified-08a-r3-native derives from verified revision2,adds four share/ttt resources and revised qualification/resource documentation. All150 existing PE files,12 native extensions,11 GUI executables,selected providers/schemas/configurations remain byte-identical;389 private relationships/selected graph unchanged. Candidate839 manifested files. Original08A/revision2 and every prior stage preserved. Scientific resource manifest: inventory/tau-scientific-resources.json; actual commands,exits,sizes and hashes: logs/p8-winbackend07l/REPORT.md and scientific-resource-manifest.json.

Backend101/120 built,14 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11,Python12/12. Resource files do not change the120-target binary inventory. Updated07C-derived future Python/package imports,Tau discovery/loading,dynamic DB plugins,SQLite original schema/DataModel persistence,messaging/controller dependencies and GUI readiness plan prepared only. No such check executed; Y: staging and the generator directory are not admitted general runtime sandboxes. Optional Python packages and original metadata/NLL/waveform/runtime limitations retained.

All314 existing build products,4048 protected prior files/stages,nine frozen snapshots and frozen Linux references preserved. Historical pre-06C1 config custody INCOMPLETE,07A Tau prebuild-hash and07E3 sequencing exceptions retained;successful new generation does not repair them. No rebuild,dependency upgrade,Phase7,ew2sc deadline,service,controller STOP/reload or operational configuration change. Only original Tau generators executed. Phase5A PARTIAL; application runtime,numerical/scientific parity and release qualification remain unverified. Next: separately authorized admitted-local Python/loader/Tau-reader/SQLite qualification using the prepared plan,then genuine scientific fixture/parity work.


## P8-WINBACKEND-07K — original Python SDK closure and scientific-resource preparation

Eight additional original CPython3.10.11 x64 extensions build exit0: _io,_utils,_datamodel,_math,_seismology,_client,_geo and _strongmotion. Original retained SWIG4.4.1 sources, package/module names and signatures preserved; DataModel package initializer and strong-motion submodule use original install structure. Windows missing export declarations, local GetMessage macro guard and DataModel /bigobj fix actual compiler/linker failures. No scientific implementation body changed. Necessary core dependency rebuilt with32 added exports/all11659 prior named exports retained; client and all other previous providers/GUI executables unchanged. Twelve original extensions now compiled; no extension imported.

Canonical backend101/120 built,14 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11. Eight new SDK outputs reported separately, not added to120. Revised offline unified-08a-r2-native contains150 AMD64 PE files,828 manifested files,389 verified private import relationships and31 original script sources prepared by static syntax/import assessment. One selected graph uses the additive core revision; original08A and every prior stage preserved. Original root initializer/four extensions,PG/OpenSSL/libxml decisions,QC/locator/acquisition/providers/schemas unchanged. Process-local Python/startup requirements prepared; no global dependency/PATH/service changes or controller guard expansion.

Tau recovery0/4 after recorded searches of retained Windows and Linux source/reference/build artifacts. Original iasp91/ak135 model inputs match pinned common source; exact reader/generator/limits/binary hashes and format/paths documented. Original native generators already available; deterministic isolated invocation plan prepared only. Model-generator execution NOT_RUN under07K restriction; no scientific tables invented. Required metadata,NLL grids,waveforms,external Python dependencies and all runtime/scientific gates remain unresolved. Scanner remains console-only,child cancellation unbounded,disabled components and remaining acquisition targets unchanged.

Archive290 outputs completed/hash-verified before compilation. Only core DLL/import/export products changed; archived preimages/before-after hashes retained. All frozen/protected prior files/stages preserved. Historical pre-06C1 config custody INCOMPLETE,07A Tau prehash and07E3 sequencing exceptions retained; Phase7 and ew2sc deadline proposal untouched. Report: logs/p8-winbackend07k/REPORT.md (24 October2026). Next: separately authorize exact original Tau generation/reproducibility and isolated native Python/loader/SQLite qualification,then essential seismic-processing resource/fixture completeness; no optional controller expansion. Phase5A PARTIAL; runtime,science and release NOT_RUN/NOT_QUALIFIED.


## P8-WINBACKEND-07J / 08A — original socket plugin and unified development stage

Original sock_plugin focused VS2022/MSVC Release x64 build exits0; AMD64 PE32+, original main/send_mseed entry and static closure verified. Uses real Winsock SOCKET/closesocket with owned WSAStartup/WSACleanup, blocking IPv4 TCP, original partial receive/framing/reconnect behavior and existing Boost POSIX regex API. Native packed MiniSEED layout assertions compile; record parsing/decoding bodies remain byte-identical. Five scoped source patches and exact hashes are in logs/p8-winbackend07j/source-patches.json. Runtime/acquisition NOT_RUN.

Backend101/120 built,14 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11. New unified-08a-native candidate contains142 unique AMD64 PE files/all11 original GUIs and769 manifested files, original installation layout/resources and one selected provider graph.371 private import relationships (including41 ordinal imports), normal/delay imports and private forwarders match selected exports. Current core/client selected explicitly; 07B PG/OpenSSL/libxml/zlib collision policy retained. Three stale inventory provider hashes reconciled against earlier verified artifacts/current prebuild archive, not rebuilt. Previous stages remain unchanged. Static import compatibility is not dynamic-loading or semantic runtime qualification.

Original defaults plus isolated DB-driver selection, writable directory structure, process-local environment file and startup/discovery requirements prepared without execution. Pinned external Python3.10.11 remains required; general Python SDK/Twisted applications excluded. Four generated Tau table inputs absent; geodata/inventory/NLL grid provenance and runtime profiles remain open. Only previously qualified kernel/scautoloc controller handlers registered; others retained inactive. Scanner remains console-only/not service-ready; focused non-console follow-up specification prepared, no new STOP/service/termination protocol.

Archive289 existing outputs completed/hash-verified before compilation; all1826 protected prior files/stages and nine frozen repositories preserved. Historical pre-06C1 config custody INCOMPLETE,07A Tau prehash and07E3 archive/build overlap exceptions retained. No provider/GUI/controller rebuild, dependency upgrade, Phase7 or ew2sc deadline change. Runtime/scientific NOT_RUN; Phase5A PARTIAL. Report: logs/p8-winbackend07j/REPORT.md. Next prioritize model/resource and original Python/core seismic-processing closure, followed by separately authorized isolated database/loader qualification; further controller features deferred.


## P8-WINBACKEND-07I — native MiniSEED scanner build complete

Original mseedscan_plugin builds exit0, AMD64 PE32+, original main/send_mseed path and static DLL closure verified. Windows tracking uses volume64+fileID128+original filename, one open target for identity/data and64-bit offsets; rooted traversal retains recursion/native order and explicitly fails ancestor reparse cycles. Versioned binary MSWIN1 state has length-prefixed UTF-8 names, full IDs/signed64 offset/time, required footer/count and strict rejection of malformed/truncated/legacy state. Existing approved Boost POSIX REG_EXTENDED|REG_NOSUB provider reused (no dependency change or pattern rewriting). Ctrl+C requests orderly stop, Ctrl+Break separately prints state through the scanner loop/event; non-console operation explicitly rejected pending a control contract. Original POSIX branches and MiniSEED record processing retained; no runtime execution.

Inventory100/120 built,15 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11. Archive288 outputs completed before compilation; all archived products,1799 protected files/stages and nine frozen trees unchanged. Historical config/Tau/07E3 custody exceptions retained. Exact hashes/provenance: logs/p8-winbackend07i/REPORT.md. Offline unified-installation planning can proceed, but service-mode acquisition, runtime/scientific qualification and remaining transports are not complete. Next: implement a focused remaining socket acquisition target and decide the scanner non-console control contract; no broad repeat reconnaissance.


## P8-WINBACKEND-07H — shared header recovered; scanner native primitives compiled

Recovered frozen SeedLink plugins/plugin.h mode120000 link as a forwarding include to its single canonical header, preserving ABI/entry definitions without copies. SCREAM ring now identifies native MSVC x86/x64 little-endian explicitly; Linux branches unchanged. Seven independent original acquisition builds attempted, all exit1 at genuine socket/time/serial/filesystem API blockers; no new inventory credit.

Added real scanner Windows file-ID/volume, owned target-open, dynamic wide path, native enumeration and caller-event interruptible-second primitives; isolated C compile/width assertions exit0, AMD64 COFF. Not integrated into original scanner because its ino_t/private APIs and legacy one-%llu persistent identity format cannot hold volume64+fileID128. Exact minimal state-version/regex/signal integration proposal documented; no identity truncation, pathname substitution, fake POSIX functions or silent unsupported expression handling. Original MiniSEED scanner source remains frozen-identical. Backend99/120,16 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11. Archive288 outputs completed/verified before compilation, all outputs and protected/frozen baselines unchanged. Historical config/Tau/07E3 exceptions retained. No runtime/scientific execution. Report and hashes: logs/p8-winbackend07h/REPORT.md. Next: scoped scanner persistent-state and notification/ERE contracts, then real transport adapters.


## P8-WINBACKEND-07G — scwfas/scplot complete; acquisition blockers clarified

Two new original native targets build exit0: scwfas and scplot. AMD64 PE32+, recursive private DLL closure and24 named provider pairs verified. scwfas uses Windows CRT length-bounded comparison only for three ASCII HTTP status digits; three existing core methods receive Windows export annotations. Existing core exports all retained; before/after core hashes archived. scplot uses CRT cryptographic random suffixes and atomic exclusive binary temporary-file creation, retaining original data/file cleanup. Q330 GNU-only warning flag scoped away from MSVC. Six SeedLink consumers now compile the single original shared plugin.c and use existing native provider closure; frozen symlink identity recorded. Legacy SCREAM snprintf macro guarded for modern MSVC.

Eight acquisition targets attempted independently remain blocked by documented serial/socket/threading/scanner filesystem-identity contracts and platform headers. No transport/scientific redesign or process-helper change. Inventory99/120 built,16 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11. Archive286 outputs completed before compilation; only three archived core provider products changed, preimages retained. All1646 protected files/stages/nine frozen trees preserved. Historical config custody INCOMPLETE,07A Tau prehash and07E3 sequencing exception retained. Runtime/scientific NOT_RUN. Exact patches/artifacts/blockers: logs/p8-winbackend07g/REPORT.md. Next: scoped scanner file-identity/traversal and acquisition serial/socket/thread contracts; dependency graph decisions remain separate.


## P8-WINBACKEND-07F — scwfparam and locext native builds complete

Private header-only C++ Windows process helper uses CreateProcessW, UTF-8/UTF-16 validation, MSVC quoting, explicit native .exe/PATH resolution, restricted duplicated standard-handle inheritance, RAII, synchronous actual DWORD status and application-owned asynchronous reaping. No shell/interpreter guessing, controller dependency, kill-on-close job, breakaway, timeout or force termination. scwfparam preserves configured argv/output-before-launch/wait option; locext preserves original XML/Origin/ID path with concurrent binary stdin/stdout and EOF. POSIX translation units reconstruct unchanged. GetMessage macro collision corrected locally; original scientific code untouched.

Both focused Release x64 builds exit0; AMD64 PE32+, External factory/createSCPlugin, recursive private DLL closure and26 private provider symbol pairs pass. Exact source patches and artifact hashes: logs/p8-winbackend07f/source-patches.json and artifacts.json. Backend97/120 built,18 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11. Archive282 outputs completed/verified before compilation; all prior outputs,1567 protected files/stages and nine frozen trees unchanged. Historical config custody INCOMPLETE,07A Tau prehash and07E3 sequencing exception retained. No runtime/child/scientific execution. Noncooperative-child bounded cancellation remains unresolved; indefinite owned I/O/wait is documented rather than introducing termination policy. Next batch: native acquisition mechanical blockers; qualify prepared process fixtures only after separate runtime authorization. Report: logs/p8-winbackend07f/REPORT.md.


## P8-WINBACKEND-07E3 — original locnll built

Original locnll focused MSVC Release x64 build exits 0. AMD64 PE32+, createSCPlugin export, original NonLinLoc registration, provider named imports and recursive static DLL closure verified (17 private symbol pairs). DLL SHA-256 F7516CAEE225E205B44D18DEFC311617DD4653E4C89BFFD86771F0D699515520. Exact reviewed early-iomanip patch CD5E32FBDAC77609D7C72DBC98117882E9890BE1476182CF9F8534175C9F5028 applied/reverse-checked. Separate Windows-only logging macro argument correction uses narrow tableDir.string() for two diagnostics; patch SHA-256 C97E7A165254A996E730F514F513BB63353463EE447B451D8FC0B1EE7DFAE251. No scientific functions/interfaces changed; prior storage/failure handling and POSIX behavior preserved.

Inventory95/120 built,20 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11. All279 archived prior outputs,1503 protected files/stages and nine frozen repositories unchanged. Archive copying overlapped first compile (sequencing exception); all prehashes/archive/current copies match and no prior provider was rebuilt. Historical config custody INCOMPLETE and 07A Tau exception retained. No application/plugin execution, scientific replay, adapter-test repetition, dependency or process-protocol changes. Next workstream: existing scwfparam/locext native lifecycle proposal, without locator feature expansion. Report: logs/p8-winbackend07e3/REPORT.md.


## P8-WINBACKEND-07E2 — six double arrays ported; independent wrapper blocker

Applied Windows checked malloc/free for azimuths plus p_time, p_error, s_time, s_error and weight, retaining double/runtime MAX_NUM_ARRIVALS counts, uninitialized storage, original writes/formulas/loops and POSIX VLAs. Caller checks gap failure before secondary use; named NLL_VPVS_STORAGE_FAILURE (-2.0) distinguishes fatal storage failure from original nonfatal insufficient-pair -1. Both failures follow existing clean_memory(EXIT_ERROR_LOCATE) before saved output. No new mutable status flag or extra serialization assumption. Applied patch SHA-256 AB06135A5929F29E3CACA85DC6BF177CD0E50E9636402AF027D8B8DCD3BE7789.

NLLocLib.obj compiles as AMD64 COFF. locnll target exits 1 on newly exposed nll_locator.cpp/MSVC iomanip tm type/name collision with original map_project.h:11 global projection function. Compile-only probes reproduce the conflict and show early iomanip parsing avoids it; exact Windows include-order proposal remains UNAPPLIED (SHA-256 CD5E32FBDAC77609D7C72DBC98117882E9890BE1476182CF9F8534175C9F5028) as required for independent blockers outside 07E2 scope. No plugin DLL/build credit: inventory stays 94/120 built, 21 Windows-blocked, 1 dependency-blocked, 4 disabled; GUI11/11. All279 archived completed outputs, stages, nine frozen repositories, 07E adapter and 07E1 matrix change preserved. Historical config custody INCOMPLETE and 07A Tau exception retained. No runtime/scientific execution or repeated adapter checks. Next: review/apply the focused wrapper include-order proposal, retry locnll, then inspect actual link/closure evidence. Report: logs/p8-winbackend07e2/REPORT.md.


## P8-WINBACKEND-07E1 — matrix VLA storage compiled; NLL failure propagation proposed

Applied Windows-only checked malloc/free for int inon_zero[i_original_size] in matrix_double_check_diagonal_non_zero_inverse. Exact runtime count/type retained, SIZE_MAX multiplication checked, no zero initialization; ownership freed on all original return paths. Entire original POSIX source reconstructed exactly after removing the added Windows branches. Patch SHA-256 C2075DD8725E3B39ED3E234EF5291A3ADF2023332A5A9F7BAA9E01270E693C03.

locnll build exit 1 remains on six original NLLocLib.c double VLAs. Their callers do not safely propagate allocation failure; per 07E1's explicit failure-path exception, two NLL conversions plus the necessary caller/status changes are a concrete UNAPPLIED proposal (SHA-256 5B5BF84E7737B0DA292A6AC64D6F6E519D4DEDC4A1B9E33AF29E458394B16C75), not silently applied beyond routine-body scope. No locator DLL/build credit; inventory stays 94/120 built, 21 Windows-blocked, 1 dependency-blocked, 4 disabled; GUI 11/11. No new linker evidence because compilation is incomplete. Existing GridLib parrivals warning retained, not suppressed. All 279 archived outputs, protected stages/files and nine frozen repositories preserved; both historical custody exceptions remain unresolved. 07E adapter/proposal unchanged; completed 39 adapter checks not rerun. Next: review the concrete allocation-failure propagation proposal before completing NLL storage/linking. Report: logs/p8-winbackend07e1/REPORT.md.


## P8-WINBACKEND-07E — private NLL filesystem adapter; locator still blocked

Windows-only GridLib enumeration adapter compiled; 39 isolated matcher/enumeration/order/error checks passed with exit 0 (no SeisComP loading or scientific replay). Original POSIX expansion retained. C-locale matching is case sensitive, includes dot names, supports basic wildcards, escapes, bracket lists/ranges/classes and single-byte collating/equivalence elements; non-C locale, unsupported range/collation syntax and unrepresentable/overlong paths fail explicitly. Full POSIX/locale parity is not claimed. Source patch SHA-256 CD1AABBAF3D66C98F899652B4BFF6C719C548D839428E957E05668D683DE3547.

locnll focused MSVC Release x64 build exits 1 on original variable-length arrays in NLLocLib.c:12735,12917–12921 and alomax_matrix.c:269. These numerical routines are outside 07E filesystem correction scope and unchanged. No locator DLL/PE/static-closure or scientific PASS. Backend stays 94/120 built, 21 Windows-blocked, 1 dependency-blocked, 4 disabled; GUI 11/11. All 279 prebuild outputs and prior stages preserved; frozen trees unchanged. Historical config custody INCOMPLETE and 07A Tau prebuild-hash exception retained. Native scwfparam/locext lifecycle contract prepared only, with script/PATH/job/cancellation decisions explicit. Next: authorize a storage-only NLL VLA port and qualify filesystem edge cases, then implement the native child lifecycle contract. Evidence: logs/p8-winbackend07e/REPORT.md and process-lifecycle-proposal.md.


## P8-WINBACKEND-07D — original QC closure and twelve targets built — 23 October 2026

Boost Signals2 (43 headers) and Parameter (100 headers), exact 1.90.0#1 at pinned vcpkg 1e199d32ad53aab1defda61ce41c380302e3f95c, archive SHA-512 verified, staged in a separate project-local overlay private to twelve QC targets. Existing required Boost components and BSL-1.0 provenance verified; installed vcpkg/global paths unchanged. Original QC provider, all ten original plugin DLLs, and scqc built independently with exit 0; AMD64 PE32+, original factories, recursive private DLL and named-export closure verified. Runtime/plugin loading NOT_RUN.

Windows-only QcProcessorObserver/QcPlugin DLL annotations plus complete QcBuffer declaration for MSVC export instantiation; algorithms and Linux branches unchanged. Source patch SHA-256 78DD2EE1152F1DB3BAB5844DE47D6A4A53D87B333AE90105B09252C304D47D51; scoped CMake patch 0EEFD8E51CBC67A483D25FA1495C1845A6D202CB1D88EF91CE125B69F473E059. Client prerequisite rebuilt; previous matching GUI/controller/database stages retained without modification. All245 previous outputs archived including nested libraries; changed client outputs retain before/after hashes. Frozen trees/protected baselines/Boost libraries unchanged. Historical pre-06C1 config custody INCOMPLETE; 07A Tau prebuild-hash exception retained.

Inventory94/120 built,21 Windows-blocked,1 external-dependency blocked (gdrt_plugin/Boost.Asio),4 disabled; GUI11/11. No dependency expansion for Asio; no ew2sc proposal applied. Next prioritize scientific-processing completeness: locnll directory/wildcard portability, then an explicit native child-process contract for scwfparam; independently address localized acquisition/server source defects without transport redesign. Report: logs/p8-winbackend07d/REPORT.md.


## P8-WINBACKEND-07C — database qualification prepared; scardac built — 23 October 2026

New database-07c-native stage contains 20 uniquely selected private DLLs, matching original 07B adapters, original schemas, native qualification harness and input hashes/loader/run plans. Harness compiles exit0; dynamic loading, SQLite/transactions/DataModel tests and PostgreSQL connections NOT_RUN. Prepared path uses original factories/interfaces/archive, with future loaded-module identity checks. PostgreSQL disposable VM profile prepared; compiled driver has no PostgreSQL connection mode. Runtime requires separate authorization; no production/GUI/server/application execution.

Independent scardac Windows wait correction built exit0, AMD64 PE32+, named-provider/static DLL closure PASS; Linux branch unchanged. Inventory82/120 built,21 Windows-blocked,13 dependency-blocked,4 disabled; GUI11/11. Source patch 70D9ADA6F34D4D7D390169295B4D98F5007AF5A700A64494B8101368E759B354; harness patch 23D55C330B4CD8907C09A0AF72220AF41DC587701FEB257A2838D9A938B3F0EF. All243 prebuild outputs including nested Tau/SQLite/07B products and prior stages preserved. Historical config custody INCOMPLETE and 07A Tau exception retained. Evidence: logs/p8-winbackend07c/REPORT.md.


## P8-WINBACKEND-07B — original native database adapters — 23 October 2026

Two new targets, dbsqlite3 and dbpostgresql, build exit 0 in the isolated VS2022 Release x64 database tree using original target definitions/macros and existing imported core. SQLite reuses approved 3.54.1 /MD/threadsafe static archive; PostgreSQL uses installed 18.1 native client SDK. Both are AMD64 PE32+, export createSCPlugin with original factory registrations, and pass recursive static private DLL closure and named import/export checks. Shared PostgreSQL/SeisComP DLL names explicitly select the existing SeisComP providers; no stage/PATH/dependency installation changes. Runtime loading, schema and persistence NOT_RUN.

Windows-only PostgreSQL uint64 scan width correction preserves Linux branch; source patch SHA-256 23B0813DD88EA7780C1AF5BFE4A30562B0A8CD3913C8C38D42715778AD568F18. Build-harness patch SHA-256 AB1D466F3AC5C81010B84EE7FC0D0FE38CEB149442FF438BD81CF15C8BFC498D. MySQL SDK unqualified; exact requirements/plan recorded without provisioning. Inventory: 81/120 built, 22 Windows-blocked, 13 dependency-blocked, 4 disabled; GUI 11/11. All 237 prebuild Release outputs including nested Tau/SQLite and protected baseline files unchanged. Historical config custody INCOMPLETE and prior 07A Tau exception retained. Report/evidence: logs/p8-winbackend07b/REPORT.md.


## P8-WINBACKEND-07A — QC/acquisition backend dependency and build audit — 23 October 2026

No new QC or acquisition target completed. The 11 QC provider/plugin targets are dependency-blocked by missing Boost.Signals2 1.90.0 headers; their generated project dependencies establish that all ten plugin DLLs require `seiscomp_qcplugin`. The exact full pinned closure and staged local-overlay proposal are recorded in `logs/p8-winbackend07a/boost-signals2-closure-proposal.{md,json}`; no package or dependency change occurred. `scardac` fails at unguarded POSIX `sleep` in `scardac.cpp:746`. Seven independent SeedLink acquisition targets were attempted and expose POSIX headers, SCREAM snprintf/endianness, Wave24 const-correctness, or shared `plugin.c` path-stub blockers.

Five prerequisite targets independently built exit 0: `seiscomp_client`, `seiscomp_daplugin`, `seedlink_native`, `slplugin`, `slutils`. Current DLL PE architecture/recursive static closure, COFF archive architecture, SHA-256, and raw logs are in `logs/p8-winbackend07a/provider-verification.json`; named client/data-plugin imports from SeisComP core/config match provider exports in `provider-symbol-closure.json`. These provider refreshes are not newly completed application/plugin targets. Inventory: 79/120 built, 0 available, 22 Windows-blocked, 13 external-dependency-blocked, 6 disabled. No source patch was applied; prior controller/GUI stages and 1,113 protected files remain unchanged. The 207 flat Release products were archived before compilation. Nested transitive `tau_internal.lib` was outside that sweep; its current timestamp predates this batch, but its prebuild hash was not captured, so preservation is not cryptographically asserted. Historical pre-06C1 config DLL custody remains INCOMPLETE. Full batch evidence and blockers: `logs/p8-winbackend07a/REPORT.md`.


## P8-WINBACKEND-04 — native acquisition implementation/build progress — 22 October 2026

Nine newly completed targets: six executables (seedlink, caps_plugin, fs_plugin, slarchive, load_timetable, scautopick), three static libraries (seedlink_native, slutils, slplugin); no new DLL. slink/slinktool rebuilt after the exact approved SOCKET-width patch. Focused Release x64 builds and recursive static PE DLL closure PASS for successful executables; raw logs, architectures and hashes: logs/p8-winbackend04/REPORT.md. CMake generation and actual CAPS Release OpenSSL linkage PASS; no debug OpenSSL libraries or dependency upgrades.

Windows typed transport, CreateProcessW/FD63 bootstrap, cancellation-safe byte-pipe I/O, cooperative-stop/job escalation, CAPS and FS child adapters, server readiness and slarchive native filesystem/resource paths implemented. Linux branches and scientific algorithms preserved. Acquisition portability remains PARTIAL: chain workers/extensions and mseedfifo external transport need the documented separate contract proposal; 6/8 socket-ABI consumers build. scamp/scmag fmt mode and scevent local-DLL/macro errors have narrow unapplied proposals.

Backend/support inventory 23/114 built, 80 available/unbuilt, 5 Windows-blocked, 6 disabled (new denominator includes seedlink_native). GUI 11/11 preserved. Nine frozen sources, 468 protected files and original build archives verified unchanged. No applications/services/network/runtime preflights executed; build success is not runtime, scientific or release validation. Details, 53-file scope, patch hashes and next batch: logs/p8-winbackend04/{REPORT.md,applied.json,backend-target-inventory.json,follow-up-proposals.json,remaining-contract-proposal.json,preservation.json}.

## P8-WINBACKEND-03 — messaging recovered — 22 October 2026

CMake generation PASS (exit 0); CAPS generated Release linker inputs now use native Release OpenSSL libraries. Six exact approved patches and two additional authorized self-contained Windows fixes applied; full hashes/scopes/checks in logs/p8-winbackend03/applied.json and REPORT.md.

scmaster, dbstore, dbg-delay and slinktool PASS (exit 0), AMD64 PE32+ with recursive static private DLL closure PASS. slink and mseed native static libraries also PASS. **Six newly completed targets: 2 executables, 2 DLLs, 2 static libraries.** Core/broker provider rebuilds are not counted as new targets. Raw logs/exits and binary hashes: logs/p8-winbackend03/; final backend inventory there.

slplugin/slutils remain blocked by native file/pipe/time interfaces; slarchive by POSIX directory/glob/resource APIs. CAPS and SeedLink are not built because their prerequisites fail. Source-backed native acquisition transport and independent slarchive proposals are prepared; separate checked SOCKET-width source patch is unapplied pending architecture approval. Successful x64 linking does not validate socket width or operational acquisition behavior. Nine frozen snapshots and protected GUI/package/staging baselines preserved; original build products archived. GUI remains 11/11, no applications executed or scientific validation claimed. Initial slinktool failure full-log gap is explicitly documented in REPORT.md; subsequent attempts are archived.


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


Follow-up proposal hashes/details: logs/p8-winbackend02/REPORT.md and proposals.json. Six checked source/build proposals remain unapplied; native descriptor/timeout design remains unresolved. Nine frozen repositories and protected GUI artifacts preserved; original build baselines archived. No applications executed.


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


## P8-WINGUI-04C scconfig stdout fix — 22 October 2026

Patch application PASS: exact approved SHA-256 9BBFCA3F3C89242B51AD19DED40B79342B39AA60789626F96DB53386537E2445, two files/five identifier renames; postimages verified. git apply check/apply/reverse-check exit 0: logs/p8-wingui04c-stdout/{check,apply,reverse-check}.json.

scconfig focused MSVC Release x64 build FAIL, actual exit 1. Both modified translation units compile. Independent link root: SC_GUI_API FlowLayout header declares DLL imports, but scconfig compiles flowlayout.cpp locally and links core only. LNK2019 imports: __imp_??_7FlowLayout@Gui@Seiscomp@@6BQObject@@@ and __imp_??_7FlowLayout@Gui@Seiscomp@@6BQLayoutItem@@@; LNK1120: 2. Existing seiscomp_qt.dll exports both exact vtables (logs/p8-wingui04c-stdout/qt-exports.log). Smallest clean proposed correction: Windows-only omit local flowlayout.cpp compilation and link existing internal qt alongside core. NOT APPLIED; separate authorization required.

Raw build/warnings: logs/p8-wingui04c-stdout-scconfig.log; actual exit: corresponding .exit_code.txt. Command: VS-bundled cmake --build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target scconfig -- /m:1. Analysis: logs/p8-wingui04c-stdout/linker-errors.json. Successful scconfig executable architecture/SHA-256 unavailable; recursive DLL closure NOT CHECKED; staging BLOCKED (not prepared).

Final Qt inventory 10/11 built, milestone incomplete: logs/p8-wingui04c-stdout/final-gui-build-inventory.json and .csv; ten existing executable hashes/stage existence reverified. Frozen pinned HEAD/status/tracked-file hashes unchanged; protected prior executables/staging/patches unchanged: logs/p8-wingui04c-stdout/preservation.json and frozen-before/after.json. No further source changes, dependency upgrades, application/service execution or runtime preflight.

Engineering only; numerical/scientific/runtime/release evidence NOT RUN, Phase5A gates unchanged. Broader confirmed blockers remain runtime network isolation, socket/TLS correctness, Hypo71 native Fortran configuration, database/release closure and scientific parity.


## Approved P8-WINGUI-04C Qt exports; scmvx linked — 21 October 2026

Applied exact approved three-header/five-annotation patch SHA-256 `18CB22AFD593C7F6136FB81236103B7A58BEBDE26DED649718E06D68D039CF48`. All six symbols now verified in seiscomp_qt DLL exports and import library. Focused scmvx Release x64 build **PASS**, actual exit **0**, AMD64 PE32+, SHA-256 `DF3F96F3EA262D3380F64176BC7FAD45481557B30B8C0B3FEDA4292A9CBD0D08`. Static recursive private DLL closure PASS; staging/scmvx-offline READY for binaries only, 32 PE files and matching Qt 5.15.18 Windows plugin.

scconfig subsequent focused build **FAIL**, exit **1**: local variable `stdout` collides with MSVC stdio macro in panels/inventory.cpp:860 and panels/system.cpp:371; logStdOut type error at :475 is the same root. Prepared unapplied two-file rename proposal `native-working-copy/phase8-proposals/P8-WINGUI-04C-scconfig-stdout-proposed.patch` (five local identifier occurrences to standardOutput), check exit 0. Separate approval required; no more source changes applied. Raw build/exits: `logs/p8-wingui04c-exports-{scmvx,scconfig}.*`; all provider/deployment/hash/custody evidence: `logs/p8-wingui04c-exports/`. Current final inventory JSON/CSV records **10 PASS/staged Qt executables; scconfig FAIL**. Prior successful baselines, frozen snapshots and dependencies preserved. No application execution or runtime preflight. Next smallest task: approve local stdout renames, then rebuild scconfig.

## Approved P8-WINGUI-04C scmvx guard reached linking — 21 October 2026

Applied exact approved one-file GetMessage guard in mainx/apps/gui-qt/scmvx/mainwindow.cpp, patch SHA-256 `190992781A159E1734995A8D354EE02983C3A57318B0D7FD8342C31E6597704E`. Compilation succeeds; focused Release x64 scmvx build exits **1** at link with six missing Qt DLL exports: icon(QString,QColor), two pixmap overloads, AnnotationItem destructor, VRuler constructor/setAnnotation. Provider-object definitions confirmed, all six absent from DLL exports/import library. scconfig NOT RUN per sequence stop condition. No executable hashes or ready staging for these two targets. Raw log/actual exit: `logs/p8-wingui04c-approved-scmvx.log`, `.exit_code.txt`; detailed provider/source/custody evidence: `logs/p8-wingui04c-approved/`.

Prepared unapplied three-header/five-annotation proposal `native-working-copy/phase8-proposals/P8-WINGUI-04C-scmvx-qt-exports-proposed.patch`: export the three required free-function overloads in gui/core/icon.h and the AnnotationItem and VRuler classes. Check exits 0; separate approval required. Final current inventory: **9 Qt executables previously built/staged, scmvx FAIL, scconfig NOT RUN**; full paths/hashes in `logs/p8-wingui04c-approved/final-gui-build-inventory.json` and .csv. scshowevent/scmapcut are Tty Qt utilities. All prior successful artifacts/staging, frozen snapshots and dependencies preserved; no application execution. Next smallest action: approve export proposal, rebuild scmvx, then continue scconfig after success.

## P8-WINGUI-04C continuation — 21 October 2026

Following operator “continue”, focused Release x64 builds: **scmm PASS (exit 0), scmapcut PASS (exit 0), scmvx FAIL (exit 1), scconfig NOT RUN**. Successful executables are AMD64 PE32+, static recursive private DLL closure PASS, separate staging READY for binaries only. scmm SHA-256 `9BB3B0C05FC0D4A5DADD8B1C3A551510F28D468E61F0FA5A30D0C3360BD7552E`; scmapcut SHA-256 `F87020EE570AE5B37B4E5FF93D3BA6BBDDD99EA527D80D2BBFDD5E8BCBFEC75A`. scmapcut source uses Tty by default, so its staging includes matching Qt 5.15.18 offscreen and Windows plugins; it is a Qt map-rendering utility, not the visible-GUI milestone. scmm has the matching Windows plugin. No source changes or execution.

Sequence stopped at scmvx/mainwindow.cpp:1157, Win32 GetMessage macro collision on DataModel::Notifier::GetMessage(true); C2660/C2440 are cascading. Prepared unapplied `native-working-copy/phase8-proposals/P8-WINGUI-04C-scmvx-getmessage-proposed.patch`, Windows-only guard after all includes. mainx pinned revision/clean status confirmed, patch check exits 0; separate approval required. Raw logs/exits: `logs/p8-wingui04c-{scmm,scmapcut,scmvx}.*`; complete hash/deployment/error/custody evidence: `logs/p8-wingui04c/`. Earlier successful binaries, staging, patches, frozen snapshots and dependencies preserved. Next: approve scmvx guard, rebuild it, then continue scconfig after success. No blocked runtime preflight repeated.

## P8-WINGUI-04B batch completed — 21 October 2026

Approved scqcv mainframe.cpp GetMessage guard applied exactly, patch SHA-256 `ADB46F497DCE373D382221C9D02B1C3EFBB9A9D8E2AB12DAD83579B739164636`. scqcv and scheli focused Release x64 builds both **PASS**, actual exit **0**. Both are AMD64 PE32+; recursive private DLL closure PASS. Separate staging directories READY for binaries only, with Qt 5.15.18 Windows plugin (31 binaries for scqcv, 32 for scheli). scqcv SHA-256 `C845484CB6DBA7708BC675E4899A85DE151B181EEC211BE3B936E30CE298B9F6`; scheli SHA-256 `75E4F17B31BD0BDAFFAE73A5ED7DA95DB4CFD61678D9E5E04631D1A09D1EED41`. Together with prior scmv success this completes build batch 1. No remaining blocker in these targets. Raw logs and actual exits: `logs/p8-wingui04b-scqcv-approved-{scqcv,scheli}.*`; stage/dependency/hash/custody evidence: `logs/p8-wingui04b-scqcv-approved/`. Prior successful baselines, source/frozen/dependency custody preserved; no application executed. Remaining proposed order: scmm, scmapcut, scmvx, scconfig.

## P8-WINGUI-04B map exports applied; scmv linked — 21 October 2026

Exact approved three-header patch SHA-256 `F7F78AA5BC38FCACCA2E68D05F7FF98550D647B13AF920245AA79B72645396A6` applied; four previously missing symbols verified in rebuilt seiscomp_qt DLL exports and import library. Focused scmv Release x64 **PASS**, exit **0**, AMD64 PE32+, executable SHA-256 `2B0ACAE44A2EFA2324ECFCD1EC5B79E48A5B88706CCE768576D9CE82A0C01348`. Static recursive DLL closure PASS; `staging/scmv-offline/` READY (31 binaries plus local Qt config/notes, Qt 5.15.18 qwindows plugin). This covers binaries only, not verified offline startup/runtime.

Sequence continued to scqcv, **FAIL**, exit **1**: first independent root at `apps/gui-qt/scqcv/mainframe.cpp:514`, Win32 GetMessage macro changes Notifier::GetMessage(true) to GetMessageA; C2660/C2440 cascade from C2039. scheli NOT RUN. Prepared unapplied one-file guard proposal `native-working-copy/phase8-proposals/P8-WINGUI-04B-scqcv-getmessage-proposed.patch`, check exit 0, requiring separate approval. Raw logs/actual exits: `logs/p8-wingui04b-mapexports-{scmv,scqcv}.log`, corresponding `.exit_code.txt`; exports, stage hashes/versions/dependencies and custody: `logs/p8-wingui04b-mapexports/`. Prior successful baselines/staging, frozen snapshots and installed dependencies preserved. No application execution or runtime preflight. Next task: approve scqcv guard, rebuild, then resume scheli on success.

## P8-WINGUI-04B follow-up reached linking — 21 October 2026

Applied exact separately approved stationdatahandler.cpp ERROR guard; macro compiler errors resolved. Focused scmv Release x64 build exits **1** at link with four unresolved symbols: Annotations constructor/add, AnnotationLayer constructor, EventLegend constructor. Defined symbols are confirmed in Qt provider objects, absent from seiscomp_qt DLL exports/import library. No additional source corrections applied. scqcv and scheli NOT RUN per sequence stop condition; DLL closure NOT CHECKED and staging BLOCKED/NOT PREPARED. Raw log/exit: `logs/p8-wingui04b-followup-scmv.log`, `.exit_code.txt`; provider evidence: `logs/p8-wingui04b-followup/linker-analysis.json` and raw dumpbin log.

Prepared unapplied `native-working-copy/phase8-proposals/P8-WINGUI-04B-scmv-map-exports-proposed.patch`: SC_GUI_API on Annotations, AnnotationLayer and EventLegend in three headers, plus direct gui/qt.h include supplying the export macro in annotations.h. Check exits 0. Separate approval required before applying; next action is this export correction and retrying scmv. Existing baselines, frozen snapshots and dependencies remain preserved; no runtime execution/preflight.

## Approved P8-WINGUI-04B header guard applied — 21 October 2026

Applied exact approved ERROR macro guard in `apps/gui-qt/scmv/types.h`; check/application/reverse-check exit 0. Header declarations now compile, but focused scmv Release x64 build exits **1** with four diagnostics at `stationdatahandler.cpp:499,:509`: ERROR is defined again by later includes, breaking QCStatus::ERROR (C2589 plus cascading C2062). No further source changes applied. Sequence stopped; scqcv and scheli NOT RUN; DLL closure NOT CHECKED and new staging BLOCKED/NOT PREPARED. Raw log/actual exit: `logs/p8-wingui04b-approved-scmv.log`, `.exit_code.txt`; exact errors/custody: `logs/p8-wingui04b-approved/`.

Prepared unapplied follow-up `native-working-copy/phase8-proposals/P8-WINGUI-04B-stationdatahandler-error-proposed.patch`, adding the same Windows-only guard after all includes in stationdatahandler.cpp; check exit 0. Separate approval required. Earlier binaries, patches and staging, frozen snapshots and dependencies are preserved. No application execution or runtime preflight. Next action: approve this translation-unit guard, then retry scmv and resume only after success.

## P8-WINGUI-04B batch stopped at scmv — 21 October 2026

Focused Release x64 scmv build **FAIL**, actual exit **1**. First independent root: Win32 `ERROR` macro (`wingdi.h`, value 0) collides with `StationGlyphs::ERROR` at `apps/gui-qt/scmv/types.h:27` and `QCStatus::ERROR` at :100. Later errors in mvmainwindow, stationdatahandler and legend follow those declarations/macro uses. Sequence stopped; scqcv and scheli **NOT RUN**. No executable/hash or DLL closure PASS; new staging BLOCKED/NOT PREPARED. No source correction applied.

Prepared single-header Windows-only ERROR undef proposal: `native-working-copy/phase8-proposals/P8-WINGUI-04B-scmv-error-macro-proposed.patch`, SHA-256 `414FB400DDB70C32FE4692AF9754F444A5A81A5779FE182615336141E80B730C`; `git apply --check` exits 0. Separate approval required before applying/rebuilding. Raw build/exit: `logs/p8-wingui04b-scmv.log`, `.exit_code.txt`; exact compiler diagnostics, proposal and custody: `logs/p8-wingui04b/`. Completed binaries/patches/manifests/staging, frozen snapshots and dependencies remain unchanged. No execution, source change, runtime preflight or network access. Next smallest task: approve scmv ERROR macro guard, then resume the sequential build batch if scmv succeeds.

## P8-WINGUI-04A scesv linked and staged — 21 October 2026

Original scesv target exists; focused existing Release x64 build **PASS**, actual exit **0**. Executable AMD64 PE32+, SHA-256 `F665F3180338FC3F4BDF56F02904E03C4829B26FC575D038E3DA19FB31C3981E`. Recursive private DLL import closure **PASS** (OS/API-set boundary); staging **READY** for binaries at `phase8/staging/scesv-offline/` with 31 verified files of PE code, matching Qt 5.15.18 Windows plugin and local qt.conf. No compiler/linker blocker. No source/dependency changes or execution. Existing 202 protected baseline binary/patch/staging/manifest files and source/frozen/dependency custody remain unchanged. Raw build/exit: `logs/p8-wingui04a-scesv.log`, `.exit_code.txt`; target, deployment, hash and custody evidence: `logs/p8-wingui04a/`.

All requested original targets have source and configured projects: scesv, scmv, scqcv, scheli, scmm (trunk); scmvx with its mvx provider (mainx); scconfig (common). Additional configured Qt utility: scmapcut. Recommended remaining build order: **scmv → scqcv → scheli → scmm → scmapcut → scmvx → scconfig**. These are available targets, not claimed successful builds. scesv/main.cpp has no explicit offline switch and uses normal messaging/database startup; binary staging does not authorize a default offline launch. Runtime validation remains deferred; no blocked scrttv/scolv preflight repeated.

## Approved P8-WINGUI-03A scolv link milestone — 21 October 2026

Exact approved one-line sleep patch applied to `apps/gui-qt/scolv/mainframe.cpp`; existing Core helper uses seconds. Focused existing MSVC Release x64 scolv build **PASS**, actual exit **0**. Executable AMD64 PE32+, SHA-256 `4B310F845CCEC761F46D51527D1C37E3E95FE8DA26FCFC7EC90899EC4840F8CB`. Static recursive private DLL closure **PASS**; separate staging **READY** at `phase8/staging/scolv-offline/` with 31 verified binaries, matching Qt 5.15.18 Release Windows platform plugin and local qt.conf. No remaining build blocker. Raw build/actual exit: `logs/p8-wingui03a-approved-scolv.log`, `.exit_code.txt`; dependency/architecture/hash evidence: `logs/p8-wingui03a-approved/`, staged `SHA256SUMS.txt`.

Source-verified offline command is staged in `offline-command.txt`, using --offline plus existing local `inventory-expanded.xml` and `config-expanded.xml` from `data/phase5b6/gfz2010avtm/inputs/`. These parse as SCML Inventory/Config; runtime loading is NOT RUN. No event is preselected. Existing scrttv executable/staging/fixture/evidence, frozen snapshots and installed dependencies are preserved. P8-WINGUI-02E remains BLOCKED_NETWORK_ISOLATION. No application, service, network or isolation operation occurred. Next meaningful gate: separately authorized offline runtime validation after verified network isolation is established.

## P8-WINGUI-03A scolv focused build — 21 October 2026

P8-WINGUI-02E is **BLOCKED_NETWORK_ISOLATION**; no unsuccessful launch preflight was repeated. Original `scolv` target is enabled. Focused existing VS 2022 Release x64 build exits **1** with one independent compiler root: `src/base/trunk/apps/gui-qt/scolv/mainframe.cpp:1757`, C3861 `sleep` not found. No link or successful executable; DLL closure NOT CHECKED, staging BLOCKED. Minimal proposal replaces that single call with `Seiscomp::Core::sleep(1)` using its already-included header. Existing helper calls Win32 Sleep(seconds*1000) or Linux ::sleep(seconds); DLL export/import availability verified. Proposed patch check exits 0; source remains unchanged pending approval. Evidence: `logs/p8-wingui03a-scolv.log`, `.exit_code.txt`, `logs/p8-wingui03a/`.

Source-reviewed offline command template is in `logs/p8-wingui03a/offline-invocation-proposed.txt`: explicit --offline plus local SCML --inventory-db, --config-db and --input-file. --offline alone does not unconditionally disable database access in this source revision. Input files need selection before a separately authorized launch. scrttv executable/staging, fixture and evidence remain byte-identical; frozen/source/dependency custody unchanged. No application, service or network-isolation operation occurred. Next smallest task: approve the single-call sleep portability proposal, then repeat the focused scolv build.

## P8-WINGUI-02E launch preflight BLOCKED — 21 October 2026

Seven-header implementation authorization, applied patch/source hashes, staged executable SHA-256 `AC4ECD4769FF9207F486D873FA0623CED26D0779C4A0D606977F4DFB6D075052`, complete staging manifest and matching Qt 5.15.18 Windows plugin verified. Required process network isolation could not be established: current token is non-elevated (Administrators deny-only), no matching firewall application filter exists for staged scrttv, and Windows Sandbox is unavailable. Firewall profiles are enabled, but that does not establish a verified per-application network block. No firewall/connectivity changes attempted. Per operator instruction, launch **NOT RUN**; GUI/plugin/fixture rendering remain untested. No scrttv process existed at preflight; none was launched, so no cleanup or screenshot was needed. Evidence: `logs/p8-wingui02e/preflight.json`, `custody.json`, `evidence.sha256`. Source/dependency/frozen custody and staged bytes remain unchanged. Next prerequisite: operator-provided verified reversible process isolation, covering remote and loopback access, before the bounded authorized offline launch can proceed.

## P8-WINGUI-02D scrttv linked and staged — 21 October 2026

With operator instruction to implement the seven-header plan, exported the three core time/string symbols and seven GUI symbols, and made the two Packet forward declarations consistently `struct` while preserving both smart-pointer aliases. Focused VS 2022 Release x64 `scrttv` build exits **0**, rebuilding necessary core/client/Qt dependencies and linking the original application. All ten symbols are verified in DLL export tables and import libraries; `mainwindow.obj` and `moc_mainwindow.obj` now use the same struct-Packet signature. No remaining compiler/linker blocker was observed. Raw build/exit: `logs/p8-wingui02d-scrttv.log`, `.exit_code.txt`; source, interface and artifact evidence: `logs/p8-wingui02d/`.

`scrttv.exe` is AMD64 PE32+, SHA-256 `AC4ECD4769FF9207F486D873FA0623CED26D0779C4A0D606977F4DFB6D075052`. Static recursive private DLL closure **PASS**; isolated staging **READY** at `phase8/staging/scrttv-offline/` with 31 verified binaries, Qt 5.15.18 Release x64 `platforms/qwindows.dll`, local `qt.conf`, preserved fixture copy and proposed offline command. Manifest: `logs/p8-wingui02d/deployment.json`, staged `SHA256SUMS.txt`; command: staged `offline-command.txt`. Original fixture/invocation, prior scshowevent staging, frozen snapshots and installed dependencies remain unchanged. No SeisComP application/library was executed or loaded; visible GUI and waveform rendering are NOT RUN. Next meaningful batch: separately authorize one isolated offline visible-GUI launch using the prepared `--offline --no-inventory` command.

## P8-WINGUI-02C approved macro correction — 21 October 2026

Added exactly the approved `_WIN32`/`GetMessage` guard after all includes in scrttv `associator.cpp` and `mainwindow.cpp`. Focused Release x64 build reaches linking with no compiler errors, then exits **1** with **11 unique unresolved symbols**. First: `Core::operator<<(std::ostream&, const TimeSpan&)`; remaining groups are Core time/string conversions, Gui icon, RecordWidgetDecorator constructor/metaobject methods, SpectrogramSettings constructor/init, and MainWindow::messageArrived. No additional source changes were made. No executable linked; recursive DLL closure NOT CHECKED and offline staging BLOCKED pending separate linker corrections. Exact signatures and raw log: `logs/p8-wingui02c/unresolved-symbols.json`, `logs/p8-wingui02c-scrttv.log`; actual exit in `.exit_code.txt`. Frozen/source/dependency custody, existing binaries/staging, miniSEED fixture and prepared invocation preserved. No application executed. Next smallest batch: analyze the 11 provider/signature failures and prepare scoped corrections for separate approval.

## P8-WINGUI-02B scrttv build — 21 October 2026

Original `scrttv` target is enabled in the existing configuration. Source verifies GuiClient operation, `--offline` disabling messaging/database/config-module access, `--no-inventory`, and positional local miniSEED input taking `loadFiles()` instead of acquisition. Focused Release x64 build **FAIL**, actual exit **1**: Win32 `GetMessage` macro expands `DataModel::Notifier::GetMessage` into `GetMessageA` at `scrttv/associator.cpp:1050` and `scrttv/mainwindow.cpp:1526`. C2660/C2440 diagnostics cascade from this root. No executable linked; DLL closure NOT CHECKED, staging BLOCKED. No source patch applied. Next smallest correction requires separate approval: local WIN32-guarded `GetMessage` undef after includes in those two files, matching the previously approved eventlistview approach.

Raw build/exit: `logs/p8-wingui02b-scrttv.log`, `.exit_code.txt`; result and custody: `logs/p8-wingui02b/`. Verified existing 4,096-byte fixture `data/phase5c1/phase5c1a/NC_NGVB_20s.mseed`, SHA-256 `995768AC810924BEB6EC4F195A294E966AFD05F2BEEA8428B6688F57586374E6`, matches its historical provenance/hash record. Source-verified proposed command is recorded in `logs/p8-wingui02b/offline-invocation.txt`, NOT EXECUTED. Frozen/source/dependency custody and existing scshowevent staging remain unchanged. No application/service execution.

## P8-WINGUI-02A deployment preparation — 21 October 2026

Static recursive private DLL closure **PASS**; staged 32 verified AMD64 Release binaries under `phase8/staging/scshowevent-offline/`, including matching Qt 5.15.18 `platforms/qwindows.dll` and `platforms/qoffscreen.dll`, with local `qt.conf`. No missing dependencies or conflicting candidates; identical build-directory copies are documented. Installed x64 MSVC runtime 14.50.35719.0 is used from System32 and was not copied/replaced. Matching `windeployqt.exe` is unavailable, so deployment-tool dry-run was NOT RUN. Raw dependency inspections, package ownership, versions, hashes, custody and search assumptions: `logs/p8-wingui02a/`; staged hashes: `staging/scshowevent-offline/SHA256SUMS.txt`. Original build/package/source custody remained unchanged; no rebuild or SeisComP execution occurred.

Launch constraint discovered in original `src/base/trunk/apps/gui-qt/scshowevent/sendevent.cpp`: this target constructs `Application::Tty`, enables messaging and database access, and sends a show-origin command to another client. GUI base `application.cpp` forces the offscreen Qt platform for Tty. It is not a standalone visible event viewer. Binary staging is READY, but a default launch is unsuitable for the offline objective. Before separately authorized execution, review an isolated offline invocation/config disabling database and messaging; use a suitable GUI-mode target for a visible Windows GUI smoke check. Static closure does not validate optional runtime-loaded plugins/drivers or application behavior.

## Native GUI link milestone — 21 October 2026

The approved eight-header, 12-declaration export patch was verified and applied exactly. Focused Release x64 `seiscomp_qt` build exits **0**, rebuilding and linking `seiscomp_core.dll`, `seiscomp_client.dll`, and `seiscomp_qt.dll`; the subsequent `scshowevent` build exits **0**, producing `phase8/build/vs2022-native-after-sqlite-nohypo71/bin/Release/scshowevent.exe`. All 15 previously unresolved symbols are verified in their provider DLL exports and import libraries. All four binaries are AMD64 PE32+. No compiler/linker blocker remains for these targets; warnings are preserved in the raw logs.

Evidence: `logs/p8-wingui-export-seiscomp-qt.log`, `logs/p8-wingui-export-scshowevent.log`, corresponding `.exit_code.txt` files, `logs/p8-wingui-export-symbol-verification.json`, and `logs/p8-wingui-export-artifacts.json` (paths, SHA-256 hashes and direct dependencies). Executable SHA-256: `0FBBB8B7D766FD6727BEA96675DD0601ACCE92780D443EBE96D2114FD0B2323F`. Approved scope, source hashes, custody and complete evidence manifest are recorded in `patch-ledger.md` and `logs/p8-wingui-export-evidence.sha256`. Frozen snapshots and existing dependencies remain unchanged. No GUI, application or operational service was run; runtime/scientific validation is not claimed. Next smallest meaningful batch: inspect runtime DLL closure and Qt platform-plugin deployment for an isolated offline GUI launch package.

## P8-WINGUI-01D build checkpoint — 21 October 2026

`seiscomp_qt`: **FAIL**, actual exit 1. The existing Visual Studio 2022 x64 Release build, using bundled CMake 3.31.6, compiled the GUI with the local Boost overlay and reached linking without compiler errors. Link failed with **15 unique unresolved symbols**. First independent root: `application.obj` requires `Seiscomp::Util::HEXCHARS` (`?HEXCHARS@Util@Seiscomp@@3PADA`); `utils/misc.h:89` declares the existing array without `SC_SYSTEM_CORE_API`, and `utils/misc.cpp:28` defines it. `dumpbin` confirms the definition in Release `misc.obj`, but no export/import-library entry in `seiscomp_core.dll`/`.lib`; the GUI Release link already includes the core import library. Required next correction: separately approve the minimal core DLL export annotation for that array, then review the remaining 14 symbol signatures. Repeated `Geo::contains` diagnostics refer to one symbol; LNK1120 is the final summary.

`scshowevent`: **NOT RUN**, since its Qt dependency failed. No successful new GUI DLL or executable hash is claimed. Raw build and actual exit: `logs/p8-wingui01d-seiscomp-qt.log` (SHA-256 `076F3F4A2D26668721D67EA6F9631F835CBE93EFC33427687458F2F327A3DEF4`) and `.exit_code.txt`. Unique decorated symbols and importing objects: `logs/p8-wingui01d-unresolved-symbols.json`. Frozen snapshots, tracked working-source diffs and existing Boost libraries match before/after custody records. No source/dependency changes, application execution, or service interaction occurred in this batch.

## P8-WINGUI-01B build checkpoint — 21 October 2026

`seiscomp_qt`: **FAIL**, actual exit 1 from `cmake --build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target seiscomp_qt -- /m:2 /v:minimal`. The approved ProcessManager source compiles; the first genuine root is `gui/core/utils.cpp:33` C1083, missing `boost/assign.hpp`, used by `boost::assign::map_list_of` at lines 220 and 255. Both `C:/vcpkg/installed/x64-windows/include/boost/assign.hpp` and the `boost/assign` directory are absent, and installed vcpkg status has no `boost-assign` package. The repeated C1083 is the same missing-header root; no linker errors were reached. `scshowevent`: **NOT RUN** because its Qt dependency failed. No successful new GUI artifacts or hashes are claimed. Raw build output: `logs/p8-wingui01b-seiscomp-qt.log` (SHA-256 `141BC7630385A295844DFE63348D78C28EB4D2E475C7FB9ED6A1AFD7FA1475C8`); exit code: `logs/p8-wingui01b-seiscomp-qt.exit_code.txt`. No source edits, reconfiguration, package changes, application launches, or service interactions occurred in this build batch. Next smallest batch: close the native Boost.Assign header dependency with operator-approved dependency provisioning, then repeat this focused build.

## ProcessManager decision and deferred backlog — 21 October 2026

The operator rejected the Toolhelp/thread-suspension proposal in its current form. The minimal Windows unsupported-pause/resume patch was explicitly approved and applied in P8-WINGUI-01A; its hash and resulting diff were verified. P8-WINGUI-01B compiles `processmanager.cpp` and stops at the Boost.Assign dependency above. Deferred development backlog: design reliable native Windows pause/resume around cooperative child-process control, explicit lifecycle ownership, and failure recovery before revisiting that feature. No GUI executable has been linked or run.

## P8-WINGUI-01 checkpoint — 20 October 2026

With separate operator approval for a three-file mechanical GUI batch, the isolated `common` working copy now uses `_putenv_s` for the Tty Qt environment setting on Windows, undefines the Win32 `GetMessage` macro in `eventlistview.cpp` after its includes, and uses `_stricmp` for `pickerview.cpp` unit matching on Windows. Linux branches remain intact. A second explicit approval covered moving the unchanged `RecordIIRFilter<T>::lastError` definition from its DLL-imported header into `iirfilter.cpp` ahead of the existing float/double instantiations. A third approval covered four explicit `Core::Time` conversions at `pickerview.cpp` assignments, matching adjacent comparisons. A fourth approval covered a Windows `std::sin`/`std::cos` path for four confidence-ellipse `sincos` calls while retaining Linux `sincos`. The latest focused Release x64 `seiscomp_qt` build exits 1; the only observed compiler root is `processmanager.cpp` POSIX `unistd.h` and its related `SIGSTOP`/`SIGCONT` process semantics. `seiscomp_core.dll` rebuilt and its import library contains both `lastError` instantiations. A nine-angle Windows scalar trigonometric smoke check exits 0 with max analytic error `2.45e-16` and max unit-circle error `2.22e-16` at `2e-15` tolerance; it is not GNU `sincos` parity or rendered-ellipse validation. No GUI executable was linked or run. Raw output and exit codes: `logs/p8-wingui01-qtgui-focused.*`, `logs/p8-wingui01-iir-abi-focused.*`, `logs/p8-wingui01-time-conversion-focused.*`, `logs/p8-wingui01-sincos-focused.*`, and `logs/p8-wingui01-sincos-numeric-smoke.*`; patch and hashes: `patch-ledger.md`. Native process stop/continue semantics need separate operator approval. Next smallest meaningful batch: port `ProcessManager::stop`/`continue_` to native Windows behavior and repeat the focused `seiscomp_qt` build.

**Date:** 20 October 2026  
**Execution mode:** Windows PowerShell, Windows Git, MSVC, Windows CMake, and Windows Python only. No WSL, Linux shell, POSIX compatibility runtime, Linux build/test process, or operational SeisComP service was used.  
**Current status:** P8-WINLINK-01 closes the 58 prior `seiscomp_client` unresolved symbols and builds `scautoloc.exe` as native Release x64 PE32+. The core-first configure exits 0 with Qt5 enabled and optional Hypo71 disabled; core/client/Autoloc build results and hashes are recorded below. A focused Qt5 `scshowevent` build reaches `seiscomp_qt` but currently fails on GUI source portability roots. Socket width, reactor/TLS runtime, full Hypo71 configuration, and GUI build remain open. No executable was run, no operational services were accessed, and no scientific parity suite was run.

The prior Phase 6P candidate at `phase6p/d/candidate-001/source` was not used as a build baseline: it has no Git metadata, and **5 of 4,149** files disagree with its `copied_sources.sha256.json`, including `autoloc.cpp`. That candidate remains untouched. A new native Windows source snapshot was obtained from the official repositories and assembled in `phase8/native-working-copy`. The source snapshot repositories are detached at the following commits and were clean before/after static inventory and CMake configuration:

| Repository | Working-copy path | Revision | Selection |
|---|---|---|---|
| `seiscomp` | `phase8/native-working-copy` | `9c395c7f00c788c5fc640363abe97b9ced0b44b0` | Project-pinned superproject revision |
| `main` (`trunk`) | `src/base/trunk` | `f63cde995e04151dc816151359a036b8b15f6019` | Project-pinned main revision |
| `common` | `src/base/common` | `92d2202a6065aad36ae7d4a9bf960b6fb91222d2` | Project-pinned common revision |
| `seedlink` | `src/base/seedlink` | `8d798847e5d49f0b722628953cc40aea81828b7b` | Latest default-branch commit before 2026-10-13 00:00 +02:00 |
| `mainx` | `src/base/mainx` | `c0f56ffea74c8ff119703553456708362537744f` | Same source-date cutoff |
| `extras` | `src/base/extras` | `37e6c1d5c4436f4c9133094e7581533ebf90a545` | Same source-date cutoff |
| `contrib-gns` | `src/base/contrib-gns` | `56d3485ab6e50fd691e1e5c94816f438386ddc15` | Same source-date cutoff |
| `contrib-ipgp` | `src/base/contrib-ipgp` | `139ee4cb6dd7325078d4298b9d16de61992f62ed` | Same source-date cutoff |
| `contrib-sed` | `src/base/contrib-sed` | `b96fd7b738aff8a949ed25b52966179c6e35ef3e` | Same source-date cutoff |

The first three revisions are the project’s pinned source baseline. The additional repository commits use a documented date cutoff because the project did not contain pins for them. This is a reproducible development vector, not a claim that every repository is from a single tagged upstream release. Repositories and status records are in [source-revisions.csv](inventory/source-revisions.csv).

## Inventory completed

- The Phase 5A source inventory ran successfully on Windows Python against the pinned `main` and `common` trees. It found 14 `scautoloc` C++ files and 13 local headers. Its report explicitly says it is not the full dependency closure.
- The multi-repository application scan found 52 CMake target directories using the inspected `SC_ADD_*` macros. See [application-target-inventory.csv](inventory/application-target-inventory.csv). This is a source inventory, not a complete target/link graph.
- A static scan found 468 POSIX API/include hits across 150 files in `common`, `main`, `seedlink`, `mainx`, `extras`, and contributed repositories. See [platform-api-hits.txt](inventory/platform-api-hits.txt). This is a keyword scan and is not exhaustive.
- The root CMake configuration directly requests LibXml2, Python interpreter/development libraries, optional NumPy, Qt 5/6, Boost components, OpenSSL, and database adapters. The `common` CMake defaults MySQL ON. The current vcpkg installation has Boost 1.90.0, LibXml2 2.15.1, OpenSSL 3.6.1, Qt 5.15.18, zlib 1.3.1, and LZ4 1.10.0. No MySQL/MariaDB or SQLite vcpkg development package was found. A native PostgreSQL installation is present, but its suitability as the full-system database target is not yet qualified.

## Native toolchain and configure evidence

Available: Visual Studio 2022 Professional with MSVC 19.44.35225.0, x64 Windows SDK, and its bundled CMake 3.31.6; Python 3.10.11 x64 with headers and import library; vcpkg-installed native x64 packages listed above. The standalone CMake on PATH is a 4.3.0 release candidate and was not used.

Out-of-source configuration used `Visual Studio 17 2022`, x64, the existing `C:\vcpkg` installed triplet, no vcpkg manifest installation, unit tests disabled, Python wrappers/NumPy disabled, Qt5 enabled, and all database plugins disabled. No system package was installed or modified. After explicit approval, WinFlexBison was provisioned as a project-local build tool; its provenance is in `tools/DEPENDENCIES.md`.

| Attempt | Result | Evidence |
|---|---|---|
| Initial dependency discovery | Exit 1: CMake selected Python 3.14.2 for NumPy; NumPy development component was missing. | `logs/vs2022-feasibility/configure.*` |
| Constrained Python attempt | Exit 1: the project’s bundled `FindBoost.cmake` searched for VS 14.0 library suffixes while installed libraries use `vc145`; Python path arguments were also malformed by the initial PowerShell array construction. | `logs/vs2022-feasibility-python310/configure.*` and `logs/vs2022-configmode/configure.*` |
| Native configure with config-mode Boost and Python 3.10 pinned | Exit 1. `common/libs/seiscomp/CMakeLists.txt` requires epoll or kqueue and aborts on Windows. `scmaster/share/CMakeLists.txt` also rejects `INSTALL(DIRECTORY fonts/.)` although `fonts` exists in the source. | `logs/vs2022-native/configure.stdout.log`, `configure.stderr.log`, `configure.exit_code.txt` |
| Configure after P8-CMAKE-001 asset path fix | Exit 1 at `seedlink/libs/slutils/CMakeLists.txt:2` because `FLEX_EXECUTABLE` was not found. No package was installed. | `logs/vs2022-native-after-assets/configure.combined.log`, `configure.exit_code.txt` |
| Core-first diagnostic configure after P8-CMAKE-001 | For diagnosis only, `src/base/CMakeLists.txt` was temporarily reordered to configure `common` before SeedLink, then restored. Exit 1 at the expected POSIX-only epoll/kqueue check. The `fonts/.` asset-path error no longer appeared. | `logs/vs2022-native-core-first-after-assets/configure.combined.log`, `configure.exit_code.txt` |
| Normal-order configure with local WinFlexBison 2.5.25 and reactor patch | SeedLink configured successfully; configuration passed `common` and `main`, then failed because `scevent` unconditionally requires SQLite3. | `logs/vs2022-native-after-wired-port/configure.combined.log`, `configure.exit_code.txt` |
| Native reactor compile-only check | MSVC x64 object-library build compiled `device_win.cpp`, `socket.cpp`, `fd.cpp`, and `endpoint.cpp`; exit code 0. Compile evidence only; no executable link or runtime/functional qualification. | `logs/reactor-compile-check/build.combined.log`, `build.exit_code.txt` |
| Native SQLite local build | Official SQLite 3.54.1 amalgamation compiled as x64 static library; CMake configure/build exit codes 0. | `tools/DEPENDENCIES.md`; `logs/sqlite-native/` |
| Full-scope configure with local SQLite and installed GNU Fortran | Exit 1 at `ENABLE_LANGUAGE(Fortran)`: MSVC generator reports no working Fortran compiler; the try-compile invokes `devenv.com`, which reports the Visual Studio evaluation period has ended. | `logs/vs2022-native-after-sqlite/configure.combined.log`, `configure.exit_code.txt` |
| Diagnostic configure with local SQLite and `SC_IPGP_HYPO71=OFF` | Exit 0, all listed packages configure and generate. Hypo71PC is explicitly omitted in this diagnostic and remains in full product scope. SQLite cache is ON and points to the project-local x64 static library. | `logs/vs2022-native-after-sqlite-nohypo71/configure.combined.log`, `configure.exit_code.txt` |
| Initial `seiscomp_core` build under default MSVC C++ mode | Exit 1. MSVC lacked C++17 (`std::optional`, `std::string_view`); the log also recorded earlier `unistd.h` and string-buffer compatibility failures before those source adjustments. | `logs/vs2022-native-after-sqlite-nohypo71/core-build.combined.log`, `core-build.exit_code.txt` |
| `seiscomp_core` build after enabling MSVC C++17 | Exit 1; MSVC stopped after 100 errors. The log identified POSIX `unistd.h` includes in logging, export syntax on templates in `core/strings.h`, GCC packed-struct syntax in SeedLink/MiniSEED, Winsock header conflicts, and platform issues in core/HTTP and application utilities. Subsequent working-copy edits address the MSVC template placement, several logging headers/calls, alternative operator tokens, and Winsock include order; those edits have not yet been rebuilt. Warnings are preserved in the raw log. | `logs/vs2022-native-after-sqlite-nohypo71/core-build-cxx17.combined.log`, `core-build-cxx17.exit_code.txt` |
| `seiscomp_core` incremental build after common MSVC fixes | Exit 1. Build reached generated DataModel and wired sources but still has hundreds of unique diagnostics: GNU `bits/functexcept.h`, POSIX `syslog`/`SIGPIPE`, winsock.h/winsock2.h redefinitions, missing `strings.h`, and WebSocket parse failures. Warnings are retained in the raw log. | `logs/vs2022-native-after-sqlite-nohypo71/core-build-after-common-msvc.combined.log`, `core-build-after-common-msvc.exit_code.txt` |

The frozen source snapshots for `main` and `common` remain clean at their pinned revisions; committed-file SHA-256 values for the nine-repository source vector are in `logs/source-snapshot-sha256.json`. The first shared-object clone attempt emitted invalid Git alternate-path errors; that copy was abandoned and replaced by independent clones. Only compile-only builds were run; no test suite or live service was run.

## Layout compile check

SeedLink4 and MiniSEED Steim1/Steim2 declarations compile under MSVC x64. Compile-time assertions preserve the 17-byte SeedLink fixed header and 64-byte Steim frames. Configure/build exit codes and SHA-256 evidence are in phase8/logs/layout-compile-check-*. This is compile-only engineering evidence, not runtime or data-parity validation.

## Blocking platform findings

The working copy now contains an initial Windows `WSAPoll` backend and pointer-sized `SOCKET` handling. The compile-only harness builds the reactor, socket, file-descriptor and endpoint translation units; it does not validate runtime reactor semantics. `WSAPoll` supports sockets only, so non-socket device use remains unresolved. The TLS path still passes x64 `SOCKET` through OpenSSL `SSL_set_fd(int)`, which remains a native TLS correctness blocker. Local SQLite 3.54.1 is available and enabled. Full-scope configure is blocked on the native Fortran/CMake route for Hypo71PC, and the C++17 core compile has over 100 unresolved native compiler/platform errors.

1. The working copy has an initial `WSAPoll` reactor with Winsock wake sockets and Windows timer logic. Its sources compile in the object-library harness, but runtime behavior and integration remain unqualified; WSAPoll handles sockets only.
2. `Wired::Device`/`Socket` use pointer-sized Windows `SOCKET` handles in the working copy. TLS calls still narrow those handles through OpenSSL `SSL_set_fd(int)` and remain blocked pending a width-safe BIO path.
3. Static scanning finds POSIX process, dynamic-library, socket, signal, file, and thread APIs across the messaging reactor, plugin loader, application/process manager, external locator, SeedLink, and contribution modules. Each target needs an explicit native implementation or a documented non-applicable feature disposition.
4. SeedLink's `slutils` requires `flex` and `FlexLexer.h`. The approved project-local native WinFlexBison 2.5.25 dependency cleared this configuration blocker; its tools are explicitly passed to CMake, and global PATH/system packages remain unchanged.
5. `INSTALL(DIRECTORY ...)` now uses explicit absolute `fonts/` and `assets/` source directories in the independent working copy (patch P8-CMAKE-001). A core-first diagnostic configure passed this point; install output is not yet built or checked.
6. Local SQLite 3.54.1 is built and enabled for `scevent`'s event ID persistence. The optional common database plugin remains disabled; MySQL/MariaDB and a supported database server/runtime are not qualified.

## Next work

1. Continue the common core build by resolving remaining compiler and Windows API errors; preserve every failed build log.
2. Qualify a full-scope native Fortran/CMake route for Hypo71PC without dropping the target from product scope.
3. Resolve the TLS socket-width blocker, then qualify reactor runtime behavior offline.
4. Continue platform ports through process launching, filesystem paths, messaging, SeedLink, service lifecycle, GUI modules, and a complete native database backend.
5. Finish transitive target/link/runtime and licensing inventories; current scans do not establish full release closure.

This is engineering progress only. No native SeisComP application or service has yet been built, launched, or demonstrated, and no scientific or operational parity is claimed.
| Layout-only MSVC check | SeedLink4 translation unit and MiniSEED Steim1/Steim2 frame declarations compiled with the native Visual Studio x64 compiler; static assertions enforce SeedLink header size 17 and Steim frame sizes 64 bytes. The source headers compile directly with no test-only typedef aliases. Compile-only evidence, no runtime/data parity claim. | `logs/layout-compile-check-configure.combined.log`, `logs/layout-compile-check-build.combined.log`, exit-code files, and `logs/layout-compile-check.sha256.json` |







## P8-WINCORE-01 evidence and current blockers

- Core-first configure: exit 0, `SC_IPGP_HYPO71=OFF`, SQLite enabled, Qt5 enabled; Hypo71 source and option remain for later full-scope work.
- Core target: native `seiscomp_core.dll` compiles/links in Release x64. The earlier focused core check11 artifact SHA-256 was `FE3DE88E2BB7244D2D1C9BC7A24D634C849AAD9C802F4F78A375C3E1677BCD95`; the latest rebuilt core DLL after P8-WINLINK interface corrections is `44CBF99652E824D625BEEF048325CF565E9BBF20F9D81EC29D27820257064BB0`. `dumpbin` confirms PE32+ machine 8664; current hash/header evidence is in `logs/p8-winlink01-artifacts.log`.
- Native Release x64 `seiscomp_client.dll`: compile/link exit 0 after resolving all 58 previously unresolved symbols. The final ArrayType import correction declares the existing explicit `TypedArray` instantiations as DLL imports in consumer TUs. Log: `logs/p8-winlink01-client-arraytype-import-v2.log`; DLL SHA-256: `B52E645C0A34E146FB232AFBEEC525F498D354D0C63CF278D66ECB23A80C3027`; PE32+ machine 8664 (x64).
- Native Release x64 `scautoloc.exe`: compile/link exit 0 with the original Autoloc algorithms. The focused build found an unused POSIX `unistd.h` include in `stationconfig.cpp` and missing exports for existing `Logging::Publish` definitions; both were corrected without changing processing behavior. Log: `logs/p8-winlink01-scautoloc-publish-export.log`; executable SHA-256: `FD58AFE5A9F0AEC45BBB060844CA37D796F65870C346B80AA3FDEAFE211BF5E3`; PE32+ machine 8664 (x64). The executable was not run.
- Qt5 GUI path: generated GUI projects and vcpkg Qt5 x64 configuration are present. Focused `scshowevent` build exits 1 in `seiscomp_qt`; raw log: `logs/p8-winlink01-scshowevent-qtgui.log`. Root groups are POSIX `setenv`/`unistd.h`, GNU `sincos`, Win32 `GetMessage` macro collision (with conversion/member cascades), `strcasecmp`, `RecordIIRFilter<T>::lastError` DLL linkage, and ambiguous `pickerview.cpp` assignments. No GUI source changes or application launches were made.
- Core log records 288 MSVC warnings, chiefly C4251 STL DLL-interface warnings plus conversion/security CRT warnings. All are preserved; no warning was silently suppressed.
- Networking remains compile-only. `IO::Socket::_sockfd` is still `int`; MSVC warns at the `SOCKET` assignment. The built core DLL is not evidence of functional x64 socket, TLS, interrupt, or reactor behavior.
- Qt5 GUI configuration is ready in the generated native solution. The focused `scshowevent` target was attempted; it fails in `seiscomp_qt` on the GUI roots listed above.
- Full Hypo71-enabled configure remains blocked by the existing Fortran/MSVC generator route. The core-first switch is diagnostic and does not remove Hypo71 from product scope.

Grouped diagnostic report: `phase8/inventory/P8-WINCORE-01-root-causes.md`. Patch exports and hashes: `phase8/patch-ledger.md`. Build, configure, PE, and binary hashes: `phase8/logs/p8-wincore01-evidence.sha256`.
- The dependency build surfaced MSVC C4700 at `processing/picker/bk_private.cpp:381` (`realdown` used uninitialized). It remains an upstream warning, is retained in the raw Autoloc build log, and has not been changed or evaluated at runtime.


## P8-WINBACKEND-05A — Processing build completion

The existing P8-WINBACKEND-04 scamp/scmag fmt and scevent local-message proposals were already present in the working copy. Their exact SHA-256 values, scopes, prior apply records, reverse-apply checks and generated `FMT_HEADER_ONLY` settings were verified. Release x64 builds now pass for `scamp` and `scmag`. `scevent` reaches link and is blocked by three missing common-provider exports. Five focused executables succeeded this batch: `scamp`, `scmag`, `scchkcfg`, `scquery`, `scxmlmerge`; each is AMD64 PE32+ with static recursive DLL closure PASS. Inventory: 28/114 built, 75 available/unbuilt, 5 Windows-portability blocked, 6 disabled by CMake.

`scinv`, `scxmldump`, and `scevent` expose an independent export-ownership defect. A three-header proposal is prepared and `git apply --check` passes; it is not applied. Raw logs, hashes, closure evidence, source ownership and the updated inventory are in `logs/p8-winbackend05a/` and `inventory/backend-target-inventory.{json,csv}`. Applications/services were not executed; runtime validation remains NOT RUN.


## P8-WINBACKEND-05C — core exports and independent backend builds

Applied the operator-approved `P8-WINBACKEND-05A-export-fixes-proposed.patch` (SHA-256 `25714462321B6007284FA018DB73A00DA678DC9DA0D55A33965A9804637E7756`), adding export annotations to three existing common-provider APIs. `seiscomp_core` rebuilt successfully; `scevent`, `scinv`, `scxmldump`, `scdb`, and `screpick` built in native MSVC Release x64. Each is AMD64 PE32+ with SHA-256 and recursive private-DLL closure PASS in `logs/p8-winbackend05c/artifacts/`. Inventory is now 33/114 built. `scdispatch` fails on missing `sleep`; `stdloc` fails on absent `<string>` includes in two least-squares headers; `fdsnxml` fails because six existing common-provider symbols are not exported. Three narrow unapplied proposals, their hashes and clean `git apply --check` evidence are in `logs/p8-winbackend05c/prepared-proposals.json` and `batch-evidence.json`. Runtime was not run. Pre-build binaries were archived and verified with zero hash failures.


## P8-WINBACKEND-05D — portability fixes and backend builds

Applied the three hash-verified P8-WINBACKEND-05C proposals: the platform sleep helper for `scdispatch`, `<string>` includes for `stdloc`, and export annotations for six existing `seiscomp_core` APIs used by `fdsnxml`. `seiscomp_core` rebuilt successfully and dumpbin confirms the fdsnxml provider exports. `stdloc`, `fdsnxml`, `dlsv2inv`, `fdsnxml2inv`, `invextr`, `scorg2nll`, and `screloc` built successfully. `scdispatch` now compiles past sleep but is blocked at link by three unresolved `DataModel::Diff2` methods. An unapplied one-header export proposal is prepared and passes `git apply --check`; SHA and scope are in `logs/p8-winbackend05c/05d-batch-evidence.json`. Inventory: 40/114 built (65 available/unbuilt, 3 Windows-portability blocked, 6 disabled). Successful binaries are AMD64 PE32+ with recursive DLL closure PASS. Runtime NOT RUN.


## P8-WINBACKEND-05E — accelerated backend builds

Applied the verified `Diff2` export patch (SHA-256 `F6B84A9218897635DE95A6C554B14D59832B298F125B2D0D5A2AA0704BB3D730`). `seiscomp_core` and `scdispatch` rebuilt successfully; dumpbin confirms the required Diff2 exports. In the 15-target independent batch, six targets built; removing unused `unistd.h` includes then cleared the first blocker for `mlr` and `mlh`, which also built. Nine newly successful targets (`scdispatch`, `seiscomp_evplugin`, `evmmi`, `evrc`, `evtype`, `mwpd`, `nuttli`, `mlr`, `mlh`) pass AMD64 PE32+ and recursive DLL closure inspection. Inventory is 49/114 built, 50 available/unbuilt, 9 Windows-portability blocked, and 6 CMake-disabled. Remaining blockers and two focused unapplied proposals are recorded in `logs/p8-winbackend05e/05e-batch-evidence.json`. `seiscomp_core` and `seiscomp_client` changed; previously staged GUI bundles may require refreshed matching provider DLLs. Runtime NOT RUN.

## P8-WINBACKEND-05F — 22 October 2026

Applied the two authorized patches after exact SHA-256, scope, clean apply, provider ownership and signature checks. seiscomp_core and seiscomp_client rebuilt successfully; seiscomp_datamodel_sm and locrouter now link. Additional dmsm and sczip builds passed. New provider exports are confirmed in the core DLL export table.

The md filter ownership issue is cleared; its link now fails on separately imported plugin-local AmplitudeProcessor_Md and MagnitudeProcessor_Md symbols. scwfparam requires a native replacement for fork/execv/waitpid; scsmdump has eight unresolved fmt v10 implementation symbols. The extra batch passed 2/8: tau tools link m.lib incorrectly under MSVC, scwfas and mseedscan_plugin require POSIX headers, scqc is missing Boost.Signals2 headers, and scplot lacks mkstemp.

Inventory is 53 built / 42 available / 12 Windows-portability blocked / 1 external-dependency blocked / 6 disabled (114 total). Artifact architecture, SHA-256, static DLL closure, raw logs, export listing and locnll/locext source inspections are in logs/p8-winbackend05f/05f-batch-evidence.json and adjacent logs. No application/service/runtime tests were run. Rebuilt core/client DLLs may need refreshing in staged GUI bundles.

## P8-WINBACKEND-05G — 22 October 2026

Applied the approved tau libtau CMake patch (hash verified: 7178B8A7E6E30ECE260EF869C71B8896B22B9BCC84BC025482C5F073AFFF7875); CMake regenerated successfully. tau_remodl and tau_setbrn still fail because their separate bin/CMakeLists.txt directly links m. A one-file follow-up proposal is prepared and passes apply-check, but was not applied.

Removed SC_SYSTEM_CLIENT_API import annotations from the plugin-local AmplitudeProcessor_Md and MagnitudeProcessor_Md declarations; md builds. The scoped md patch hash and md.h pre/post hashes are recorded in logs/p8-winbackend05g/05g-batch-evidence.json.

For fmt, the existing compiled fmt v10 source remains owned by seiscomp_config.dll. The Windows provider now exports its fmt symbols, scsmdump imports them and links config explicitly; dumpbin confirms the previously unresolved exports and scsmdump builds.

Five newly successful targets: md, scsmdump, sccnv, seiscomp_mplugin and scimport. seiscomp_daplugin fails at C2676 path-separator/string concatenation; scimex fails on three SCDM051 constructor exports. Boost 1.90.0 is installed, but signals2.hpp is absent from both installed headers and the approved local overlay, so scqc remains dependency-blocked. Inventory: 58 built / 37 available / 12 Windows-portability blocked / 1 external-dependency blocked / 6 disabled. Artifact hashes, architecture, closure, exports and raw logs are in logs/p8-winbackend05g/. Runtime NOT RUN.


## P8-WINBACKEND-05H — focused processing/linkage recovery (2026-10-22)

Applied the verified tau executable CMake proposal (`P8-WINBACKEND-05G-tau-executables-math-proposed.patch`, SHA-256 `815FC24947F8741622B744C26F192B9EBB6AEEDB32DDE74ABDAF62454EC3F410`; one file, Windows omits `m`, Unix keeps `m`). `tau_remodl` and `tau_setbrn` build exit 0. Added plugin-local `SC_SYSTEM_CORE_API` exports to the provider-owned `SCDM051::GenericHandler`, `ImporterSCDM051`, and `ExporterSCDM051`; `scimex` builds exit 0 and `dumpbin /exports` confirms the constructor symbols. Changed only the SDS collector path joining and its path diagnostic conversion; the original C2676 path-separator error is cleared, but `seiscomp_daplugin` remains blocked at link by LNK1181 for the generated relative `tau_internal.lib` input.

Three new inventory targets built: `tau_remodl`, `tau_setbrn`, and `scimex`. Each is AMD64 PE32+ with static recursive DLL closure PASS; hashes and inspections are in `logs/p8-winbackend05h/artifacts/`. Inventory: **61/114 built, 30 available, 16 Windows-portability blocked, 1 external-dependency blocked, 6 disabled**. Seven independent attempts failed at their first Windows root: `ew2sc` lacks `netdb.h`; `ql2sc` has an anonymous-namespace exported vftable and missing `usleep`; `scm` lacks the imported `Client::Status::parse` symbol; `run_with_lock`, `timeout`, `trylock`, and `waitlock` include POSIX `unistd.h`. `gmsexample` was interrupted when its dependency graph began recompiling Qt and has no recorded outcome. `scqc` remains blocked because Boost 1.90.0 Signals2 headers are absent from vcpkg and the approved overlay. The vcpkg tree has the exact `boost-signals2` 1.90.0#1 port metadata; proposed next step is to provision that header-only component into the approved local overlay and add the include path only to scqc, pending dependency authorization.

The build refreshed `seiscomp_core.dll` (`F85BDF0C5607A3F0F03B03587EBBAAE2745AC56E5B74C5B7F698EFFF06D66687`), `seiscomp_client.dll` (`304187503D9BD14265B6D5689B9FB670F4BB52EFD2F583B4C4863BBDECA1F03C`), and `seiscomp_config.dll` (`1F3364FDDFEFC5F3EB4E72FFD8C3F21BAC26C27788684CE5B12B077237C824F8`). All 11 existing offline staged GUI bundles (`scconfig-offline`, `scesv-offline`, `scheli-offline`, `scmapcut-offline`, `scmm-offline`, `scmv-offline`, `scmvx-offline`, `scolv-offline`, `scqcv-offline`, `scrttv-offline`, `scshowevent-offline`) contain older copies of these providers and require synchronization before use. No GUI was launched. Frozen snapshot HEADs and clean statuses match the required revisions; see `logs/p8-winbackend05h/05h-batch-evidence.json`. No application, service, network or database was run.

## P8-WINBACKEND-05I — dependency and portability recovery (2026-10-22)

Built four additional inventory targets in VS2022/MSVC Release x64: `seiscomp_daplugin`, `scm`, `ql2sc`, and `gmsexample`. All are AMD64 PE32+ with recursive static DLL closure PASS. Their hashes and inspection JSON are in `logs/p8-winbackend05i/artifacts/`; raw build logs are alongside them.

For `seiscomp_daplugin`, CMake now links the target-produced `tau_internal` privately to `seiscomp_core`; the generated plugin Release project no longer receives a Tau archive input. `scm` now imports the existing `Status::parse` implementation from `seiscomp_client`. `ql2sc` uses `Core::msleep(100)`, keeps app-local cache classes local, and imports the existing QuakeLink, Diff2/Diff5 and notification queue APIs from their providers. `gmsexample` built against the existing matching Qt provider after its baseline hash matched and the rebuilt core retained every archived export; no Qt rebuild was performed. See `logs/p8-winbackend05i/05i-applied-change-record.md`.

The four lock utilities remain blocked at `unistd.h`; their actual implementations also require native process, signal, alarm and file-lock translations. `scqc` remains dependency-blocked by missing Boost.Signals2 1.90.0 headers; no dependency was downloaded or installed. `ew2sc` remains blocked by POSIX `netdb.h` and socket APIs; a Winsock proposal is prepared. These scoped proposals are in `logs/p8-winbackend05i/05i-prepared-proposals.md`.

Inventory: **65/114 built, 29 available, 13 Windows-portability blocked, 1 external-dependency blocked, 6 CMake-disabled**. Rebuilt providers `seiscomp_core.dll` and `seiscomp_client.dll` have changed hashes. All 11 offline staged GUI bundles contain stale `seiscomp_core.dll`, `seiscomp_client.dll`, and `seiscomp_config.dll` copies; synchronization is deferred until providers stabilize. Frozen snapshots remain at required clean HEADs. No SeisComP application, service, GUI, network, or database was run. Evidence: `logs/p8-winbackend05i/05i-batch-evidence.json` (SHA-256 `D069CED07FEB47F28E615ACDFF54C1D1E1810B61C60F0054A6E1B23157AC7F75`).

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
