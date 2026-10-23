# P8-WINBACKEND-07J / 08A — Native socket acquisition and unified candidate

**sock_plugin completed; backend101/120 built, GUI11/11.** Remaining14 Windows-portability blocked,1 external-dependency blocked,4 disabled. A separate offline unified Windows development candidate contains142 unique AMD64 PE32+ files and769 manifested files. Runtime/scientific qualification **NOT_RUN**. VS2022/MSVC19.44 Release x64;23 October2026. User07J authorizes these scoped portability changes and offline assembly; no application or operational execution.

## Socket implementation and focused build

Selected original `sock_plugin`: a single blocking IPv4 TCP receiver for512-byte MiniSEED records. Its transport is smaller than SCREAM's additional TCP/UDP contracts; no threading, process or protocol redesign is required. Existing CMake target/source locations remain `src/base/seedlink/plugins/sockplugin`.

Windows uses real SOCKET/INVALID_SOCKET, closesocket on connection/read failure and EOF, one owned WSAStartup2.2 reference and atexit WSACleanup, immediate WSAGetLastError diagnostics and the original IPv4 gethostbyname first-address behavior. SO_KEEPALIVE, htons/ntohs/ntohl and blocking connect/recv remain. Partial recv accumulation,256-byte reads, original record order and EOF/reconnect rules are unchanged. WSAEINTR follows the original read-error/reconnect path rather than becoming EOF; no select/nonblocking/deadline, UDP, outgoing network send or shutdown protocol was added because the original target uses none. Sleep preserves unsigned seconds with checked-width millisecond chunks. CRT errno remains solely for original non-socket/SeedLink diagnostics.

Windows compiles the two original utility files as C++ to reuse the existing native short-option parser and already-approved Boost POSIX regcompA/regexecA provider. REG_EXTENDED and zero execution flags retained; invalid compilation fails explicitly. No engine upgrade/pattern rewriting. MSVC pack(push,1)/pop and compile-time10/12/28/4/8-byte assertions preserve MiniSEED layouts; NULL spelling repairs C++ pointer compatibility. `process_record`, `parse_record` and byte-order helper bodies are byte-identical to their preimages. Linux branches/semantics retained. Ws2_32 comes through the existing slplugin→seedlink_native dependency; no global linkage or errno facade.

Configure and final focused compile/link exit0: `configure-command.json`, `configure.log`, `configure.exit_code.txt`, `sock_plugin-command.json`, `sock_plugin.log`, `sock_plugin.exit_code.txt`. Initial successful build logs retain redundant regex-macro warnings; direct qualified Boost calls remove those warnings in the final build. Remaining C4996 CRT/gethostbyname deprecations are saved, not suppressed. No failed target counted.

Final exe SHA-256 **`31DAC2FD2E7912A163E2915928FDD86670CFBFC9EB44270A363EA5A4C767F2C9`**. AMD64 PE32+, real Winsock imports/ordinals, original main/send_mseed object symbols and recursive static closure verified. The target has0 private DLL edges because SeedLink/regex providers link statically; `static-link-provenance.json` records exact object/provider library hashes. No fabricated createSCPlugin interface. Raw PE/COFF logs and `artifacts.json` support these engineering checks; runtime transport/regex/stream behavior is unverified.

## Unified installation deliverable and providers

Candidate: `phase8/staging/unified-08a-native`. Original generated install rules from275 scripts determine application, module, acquisition and resource destinations; `install-plan.json` preserves the mapping. Includes core/messaging/scmaster, both database adapters, models available locally, controller/four extensions, original automatic processing/event applications, locators, QC provider/ten plugins, built acquisition helpers and all11 original GUI executables. Each GUI hash matches its previous individual stage. No old stages were concatenated.

`unified-graph.json` and candidate `share/08a/provider-manifest.json` specify every selected binary, source/build identity, hash, normal/delay imports, package, provider and duplicate choice.371 private import relationships include41 ordinal imports; selected private exports and forwarders match. All142 actual staged PEs rechecked with unique basenames/hash identity. Windows/API-set/installed VC runtimes are an explicit external boundary. Current core `05720EEEEB9EC7F7141B2D3E376EDC10A8CF7E0B9058FB77471862F3F2B9C418` and client `302AA40361BC4EA3507E62E0A2CC5B5DBD2068DC371DE40F606F6A024B3CB50B` selected; previous export-only corrections preserve existing interfaces. No incompatible consumer found by static checks and no provider/GUI rebuild needed. This is not ABI/runtime/dynamic-loading certification.

07B's explicit PostgreSQL/OpenSSL/libxml2/zlib selection is retained: existing SeisComP/vcpkg providers win over differing PG copies, with exact candidate/selected hashes and imported symbols recorded. libpq remains the pinned installed18.1 client. Three stale inventory provider hashes (datamodel_sm,broker,mplugin) were caught and reconciled to prior verified inspection records and the unchanged07J prebuild archive; `inventory-hash-reconciliation.json` records both identities. No silent replacement/rebuild. Qt5.15.18 platform/image modules are explicit dynamic roots; CPython3.10.11 x64 external home remains required.

`SHA256SUMS.json` hashes all769 candidate files except itself; SHA-256 **`B7DC3CBD7B672890B748111B5F407DB6CA01181AD750058908EA3A2B38BA013F`**. Resources/schema/configuration provenance,74 explicit exclusions and earlier-stage provider comparisons are recorded. Static build libraries/tests are outside the runtime candidate. Four generated Tau tables (iasp91/ak135 .tbl/.hed) are absent. General Python SDK/client/data-model bindings and optional application dependencies remain unavailable; unsupported scripts/packages excluded. Real inventory, station epochs, waveform fixtures, maps/NLL grids and scientific profiles are not invented.

`startup-requirements.md` covers original broker/DB defaults, plugin/package searches, inventory/station/waveform entry points, Qt resources, Python/controller and writable directories. Candidate etc/global.cfg selects the two built DB adapters without URI/credentials; original shipped defaults remain intact and dormant. A process-local environment file is prepared but not sourced. Only kernel/scautoloc handlers remain registered; others retained inactive. No auto/PID/run markers, service, system PATH or operational settings changed. Scanner remains console-only/not service-ready; `scanner-non-console-followup.md` specifies the next owned-launch control decisions without implementing endpoints, controller STOP, deadlines or termination policy.

## Patches, custody and inventory

Exact five patch SHA-256 values (source pre/post hashes in `source-patches.json`):

- sock_plugin.c: `832545387B2F7F61643D09789CE59510856D8F4A559D83ECEAAD02A85B29380F`
- seedutils.c: `6D73C61A50E58B1DD678662B4B711D0D851737A6091E08D93A7D91404416BC91`
- seedutils.h: `9468A693EB8348EA6DA683D0E2F42C8E87B08EA7C5C12D31D480ADB41105C8A8`
- CMakeLists.txt: `6B4F6AEF22EBA429D706733A30C0416608B2778EED0D26A2705100624E48BAFF`
- windows_socket_private.h: `3758B84B94581D37744F45BC1260DC529DBBC2F1DA1699BC6194511360DEBA2B`

Before compilation289 potentially affected outputs/import libraries, including nested products, were archived and hash-verified to completion. All289 current/archive copies,1826 protected prior files/stages, nine frozen HEAD/status/hash vectors and dependency/Boost baselines unchanged. Only the new socket product is added. Frozen superproject9c395c7f00c788c5fc640363abe97b9ced0b44b0,mainf63cde995e04151dc816151359a036b8b15f6019,common92d2202a6065aad36ae7d4a9bf960b6fb91222d2. `before.json`, `artifacts.json` and final verification retain evidence. Historical pre-06C1 config custody **INCOMPLETE**,07A Tau prebuild-hash exception and07E3 archive/build overlap remain unresolved historical records. No Phase7, dependency upgrade, ew2sc deadline or completed controller/process/scientific implementation changes.

Canonical CSV/JSON, implementation status and patch ledger updated. `remaining-blockers.json` retains exact prior diagnostic files/lines and dependency reasons. Remaining Windows targets: chain (fork/SLCD extensions),echopro/serial (serial/termios),ewexport/ewexport_pasv/naqs/scream/scream_ring/wave24/win (native socket/time and target-specific contracts),minilogger (filesystem/device I/O),mseedfifo (external FIFO contract),q330 (POSIX threads/process APIs),reftek (nested GNU build integration). gdrt remains blocked by the exact Boost.Asio closure. dbmysql,hypo71,Hypo71PC,iloc remain CMake-disabled. These targets were not retried or credited in07J.

Recommended next: recover/qualify exact model/resource provenance and original Python/core seismic-processing closure, then separately authorize isolated loader/SQLite/database qualification using07C plans. Remaining original transports need focused ports; further controller features are deferred.

## Phase5A evidence register

| Gate | State | Evidence/actual exit | Limitation |
|---|---|---|---|
| A: Source + Phase4C | NOT_RUN as full gate | before.json; artifacts.json; custody checks0 | Broad baseline/oracle audit not repeated |
| B: Transitive dependency closure | NOT_RUN as full gate | socket build0; unified-static raw logs; assembly-summary.json | Static candidate only; dynamic/resource gaps retained |
| C: Linux original Autoloc oracle | NOT_RUN | None | No scientific fixture/replay |
| D: Native original Autoloc offline execution | NOT_RUN | None | No application/plugin execution |
| E: Replay equivalence/robustness | NOT_RUN | None | No runtime/numerical tests |

Linux/Windows scientific fixture hashes, origin/time/location/depth/association difference matrix and scientific validation are unavailable/NOT_RUN. No acquisition, network connection, database transaction, GUI/controller/service or scientific execution. Phase5A **PARTIAL**: engineering build/static assembly complete for this batch; runtime, scientific and release qualification remain open.
