# PHASE 5A VERIFICATION REPORT — P8-WINBACKEND-08C2

**Agent:** Codex. **Local date:** 30 October 2026, Asia/Manila. **Platform:** native Windows x64, existing VS2022 Professional/MSVC14.44 Release toolchain and approved native dependencies.

Original **naqs_plugin** now compiles and links natively. Canonical backend coverage advances from **102/120 to 103/120**. New package **unified-08a-r6-native** adds this executable and retains all151 previous PE binaries, including the corrected revision5 core,11 original GUIs,12 Python extensions and four Tau resource files. The broad review remains closed; verification was confined to this port's build/static compatibility and required custody.

Package: `Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\staging\unified-08a-r6-native`.

Externally recorded **SHA256SUMS.json** identity: `B25B755038E1586E15B8935283389788469110B6F783F92A68EAB93E37C9F541`.

NAQS executable SHA-256: `776B5057E583F2F47B068A05928771ED8D94BB3CEFB73543D07EE4E973DABE4B`.

## Gate register

| Gate | State | Actual evidence/invocation | Limitation |
|---|---|---|---|
| A: Source + Phase4C evidence | BLOCKED full gate | before.json,verification.json: nine frozen revision/status/hash vectors match | Phase4C raw evidence not reaudited |
| B: Transitive dependency closure | NOT_RUN full gate | artifacts.json,static/imports.log: affected target native import closure checked | No broad dependency or code review repeated |
| C: Linux original Autoloc offline oracle | NOT_RUN | No invocation | No WSL/Linux process or new reference result |
| D: Windows native original Autoloc offline executable | NOT_RUN full gate | configure-command.json exit0; naqs-retry-command.json exit0 | Acquisition plugin build is an engineering milestone; no full application run |
| E: Replay equivalence and robustness | NOT_RUN | No invocation | Scientific/runtime campaigns deferred |

## Pinned source / patch provenance

The user authorized continuing the remaining socket acquisition ports with minimal testing. Five files are scoped to the editable NAQS directory: naqs_plugin.c,naqs_utils.c,naqs_utils.h,CMakeLists.txt and added naqs_platform.h. `final-source-patches.json` binds exact pre/post hashes, preimages and final unified patches. `source-patches.json` and the earlier patch files are the initial attempt; the final register includes the later native CRT alias correction and is authoritative. All original notices remain. Native NAQS's own Nanometrics notice and original SeedLink AGPL notices are preserved; this is development evidence, not redistribution/license certification.

Native transport uses pointer-width SOCKET/INVALID_SOCKET through every helper/caller. Windows startup owns one Winsock2.2 reference, validates its version and registers cleanup. Active sockets are closed using closesocket; ownership is cleared after reconnect/shutdown. Windows sleep uses Sleep and supported SIGINT/SIGTERM/SIGBREAK handlers; the original POSIX sigaction branch remains. No POSIX signal or pthread emulation package is introduced. The original exponential reconnect interval and blocking TCP protocol remain.

Header compile assertions preserve MessageHeader12,DataAddRequest20 and AddRequest16 bytes and pointer-width socket handles. Existing single-send length checks and MSG_WAITALL receive/error behavior are retained. No new retry heuristic,timeouts,decoding,byte swapping,sampling,timestamp or channel request policy is introduced. The24 full original function bodies recorded in preserved-function-bodies.json match their preimages exactly, including processData,header/request/receive functions and channel/regex selection. Windows socket types differ in signatures; POSIX aliases retain int ABI. Linux compilation or parity was not run.

The local materialized plugin.c/plugin.h placeholders remain unchanged. The Windows build excludes that placeholder C source and links the existing original slplugin library; the utility source directly includes the canonical plugin header on Windows. The real send_raw_depoch path remains in the preserved processData body. Windows regex calls reuse the existing scanner's native adapter and approved Boost POSIX extended/no-subexpression API rather than translating patterns or adding a dependency. Case-insensitive channel-name comparison maps to the native CRT _stricmp on Windows.

All nine frozen snapshots have matching HEAD/status/hash vectors. Superproject/main/common retain `9c395c7f00c788c5fc640363abe97b9ced0b44b0`,`f63cde995e04151dc816151359a036b8b15f6019`,`92d2202a6065aad36ae7d4a9bf960b6fb91222d2`. All314 watched existing build products and all847 revision5 package files match their before hashes. No older stage,qualification payload,security setting,dependency,service,controller,Phase7 or operational asset was changed. Current inventory/status/ledger were updated with preimages retained under records-before.

## Build/link inventory

The existing root CMake configuration was regenerated against existing native dependencies; configure-command.json/log records exit0. No package fetch or installation was requested. Only the original NAQS target's compiler and `_Link` wrapper ran, with project reference builds disabled. Exact argv/timestamps/exits are retained.

The first target build exited1 with `LNK2019 unresolved external symbol strcasecmp` and `LNK1120`, after compiler warningC4013. The Windows-only `_stricmp` mapping resolved that blocker. The final build exits0 with11 warnings and0 errors; naqs-retry.log retains C4267 size conversions and C4996 legacy CRT/Winsock deprecations. No suppression or scientific cleanup was added. The first failure is retained in naqs_plugin.log and its command record.

`artifacts.json`,static/headers.log,static/imports.log and static/entry-symbols.log demonstrate AMD64 PE32+,original main and the actual import tables. Winsock functions are imported by ordinal; winsock-ordinal-identities.json resolves WSAStartup,WSACleanup and closesocket against the actual native System32 provider. Every normal/delay import is resolved against selected native providers or the explicit Windows/VC/API-set boundary. No Linux,WSL,Cygwin,MSYS or Wine runtime is imported. There is no new private DLL relationship; the package retains389 existing private relationships. The existing slplugin.lib and seedlink_native.lib hashes are recorded. This is static build evidence, not acquisition correctness or dynamic-loader qualification.

## Windows fixture + result provenance

No target executable,NAQS server,station,network endpoint,original application,GUI,extension,database or seismic fixture was executed. No regression,memory or scientific campaign was added. Compile-time ABI assertions,PE/import checks,preserved-body comparisons and package/frozen-source hashes are the limited checks used here.

Revision6 has **152 native PE binaries and849 manifested files**. The only added binary is share/plugins/seedlink/naqs_plugin.exe. The inherited selected core remains `167DE26247A3BB4408E0EE55ED34196C7A43B688664700120CC240A83F4D83F8`; all151 prior PE identities are preserved. The canonical inventory credits NAQS build completion only;12 Windows portability blockers,one dependency blocker and four disabled targets remain.

The per-user copy installer and process-local environment scripts are retained. The installation guide references revision6 and its external08C2 manifest digest. Actual installation/launch is NOT_RUN. Existing external CPython home,optional dependency/resource,controller and execution-scope limits remain. Earlier package revision records are historical; revision-08c2.json/current provider-manifest.json describe this candidate. Prior qualification receipts do not admit the changed package.

## Linux fixture + result provenance

NOT_RUN. No Linux compilation,oracle or runtime dependency is introduced.

## Numerical difference matrix

Not applicable. No seismic or transport outputs were generated or compared.

## Evidence gaps, failures and unresolved scientific questions

The first missing-CRT-symbol build failure is retained. Static record tooling initially expected named Winsock imports; actual ordinal imports were then resolved using the system export table. A later documentation read encountered Python3.10's default cp1252 decoding of the existing UTF-8 status file. Explicit UTF-8 fixed documentation finalization through finish-records.py without another build or assembly. These were recording-tool issues; no additional production source change or target execution followed.

Protocol/transport behavior,console/service lifecycle,reconnect timing,regex corner cases and inherited memory/error paths are runtime-unqualified. No leak-free,scientific,operational or release claim is made. Historical pre-06C1 configuration custody,07A Tau prehash and07E3 sequencing exceptions remain as previously documented.

## Final assessed milestone

**Original NAQS native build and revision6 integration: completed. Phase5A PARTIAL.** Continue the remaining socket acquisition transports,then thread/serial/IPC contracts and dependency closure. Essential application integration and a small authorized offline workflow check remain necessary for usability. This milestone is engineering progress, not scientific certification.
