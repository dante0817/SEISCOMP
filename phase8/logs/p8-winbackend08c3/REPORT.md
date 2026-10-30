# PHASE 5A VERIFICATION REPORT — P8-WINBACKEND-08C3

**Agent:** Codex. **Local date:** 30 October 2026, Asia/Manila. **Platform:** native Windows x64, existing VS2022 Professional/MSVC14.44 Release configuration.

Original **win_plugin**, the WIN-format UDP/multicast acquisition plugin, now compiles and links natively. Backend build coverage advances from **103/120 to104/120**. **unified-08a-r7-native** contains153 native PE binaries and851 manifested files. All152 previous binaries,11 original GUI apps,12 Python extensions,four Tau resources and the corrected core retain revision6 bytes. The user authorized this port with focused build/static checks and deferred broad qualification.

Package: `Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\staging\unified-08a-r7-native`.

External **SHA256SUMS.json** identity: **`716BC5CC7B67DC6681EF67276DF48E3DCB26EC7345EC4A13AB607435BC61B174`**.

WIN executable SHA-256: **`86440E95074B7078B35CE067C88ADECEFDA6A9281F1AB7A895E5ECF74A4463E5`**.

## Gate register

| Gate | State | Evidence and actual invocation/exit | Limitation |
|---|---|---|---|
| A: Source + Phase4C evidence | BLOCKED full gate | before.json,verification.json: nine pinned HEAD/status/hash vectors match | Phase4C raw evidence not reaudited |
| B: Transitive dependency closure | NOT_RUN full gate | artifacts.json,native-provider-checks.json: affected target import/export resolution succeeds | Broad closure review remains closed |
| C: Linux original Autoloc offline oracle | NOT_RUN | No invocation | No Linux/WSL access or new reference result |
| D: Windows native original Autoloc offline executable | NOT_RUN full gate | configure-command.json and win_plugin-command.json both exit0 | Original acquisition target build only; no application run |
| E: Replay equivalence and robustness | NOT_RUN | No invocation | Numerical/scientific and transport runtime campaigns deferred |

## Pinned source / patch provenance

Only the editable win_plugin.c,CMakeLists.txt and added windows_win_private.h changed. Exact preimages and final patches/hashes are in final-source-patches.json. The earlier source-patches.json is the initial register; the final register includes the private header's self-contained stdlib include. Original source and shared plugin notices are retained; no distribution/license certification is made.

Windows transport uses pointer-width SOCKET through the main loop,resend and channel-request helpers,with INVALID_SOCKET checks,closesocket and one owned Winsock2.2 startup/cleanup reference. Original IPv4,UDP,multicast membership/interface and socket buffer choices remain. Winsock select receives its ignored nfds argument0. Socket diagnostics capture WSAGetLastError rather than stale CRT errno. Successful send buffers differ only by const-char pointer casts required by Winsock. WSAEMSGSIZE retains leading-byte truncation semantics; other receive failures and empty datagrams do not enter the decoder. These Windows-only error paths are source changes, not runtime-tested results.

The Windows console handler only sets atomic flags. Ctrl+C/close requests stop; Ctrl+Break requests channel-file reload,serviced in the original main loop. The original POSIX signal/SIGHUP branch remains. No service is installed and no detached process is created. No bounded shutdown guarantee is inferred for DNS calls,console close or untested error paths.

The existing -D logging option maps to local Windows Application Event Log using RegisterEventSourceA/ReportEventA/DeregisterEventSource. This code owns the handle and falls back to stderr diagnostics if reporting fails. It does not create a registry event-source definition or install a service; actual event display/permissions remain unqualified. These APIs were not executed in this batch. Without -D,the original console logger remains. A private C short-option parser follows the existing native utility parser's contract,keeping the source a C translation unit. Windows default channel-map path is working-directory win2sl.map; explicit -F is recommended and no mapping/station data was fabricated.

preserved-processing.json verifies11 complete decoder/queue/time/sample function bodies byte-for-byte,including decode_data,decode_second_block,decode_packet,queue_data,wincpy2 and check_ts. Resend/check-packet and send-request bodies differ only by buffer pointer casts. Channel-file processing differs only by the POSIX signal registration guard. The entire main packet decoding tail is identical. This totals15 focused source-preservation checks. Socket parameter types change without altering the packet selection/decoding algorithms. Linux compilation/parity was not run.

All315 watched existing build products,all849 revision6 package files and all nine frozen snapshot HEAD/status/hash vectors match before/after. Superproject/main/common retain `9c395c7f00c788c5fc640363abe97b9ced0b44b0`,`f63cde995e04151dc816151359a036b8b15f6019`,`92d2202a6065aad36ae7d4a9bf960b6fb91222d2`. Current inventory/status/ledger were updated with preimages retained. Prior packages,qualification payloads,protected evidence,dependencies,security policy,controller,Phase7 and operational assets were preserved.

## Build/link inventory

The existing CMake build configuration was regenerated with its existing approved dependency hooks (configure-command.json/log,exit0). Only original win_plugin compiler and `_Link` targets ran,with project-reference builds disabled (win_plugin-command.json/log,exit0). There was no package installation or runtime invocation. Native Windows advapi32 linkage is explicit for logging; no external dependency was provisioned.

The first and only target build succeeded with **101 warnings,0 errors**. Raw warnings are retained without suppression. These include legacy CRT/Winsock deprecations,narrowing and an inherited C4477 printf precision type mismatch. They are not memory/behavior qualification. No full solution,GUI,core,Python or existing acquisition target was rebuilt.

artifacts.json and static/headers.log/imports.log demonstrate AMD64 PE32+ and actual native imports. static/main-symbols.log proves the original main; static/plugin-symbols.log retains original send_raw3. Native Winsock ordinal identities and actual System32 exports are checked in native-provider-checks.json. Event Log imports are present. Every target import resolves against selected native providers or the existing Windows/VC/API-set boundary; no Linux,WSL,Cygwin,MSYS or Wine runtime is imported. There is no new private DLL edge; the package retains389 existing private relationships. Static provider compatibility is not dynamic-loader or transport qualification.

## Windows fixture + result provenance

No executable,UDP endpoint,multicast group,station/server,console callback,Event Log API,database,GUI or scientific workload was executed. No regression or memory campaign was added. Verification consisted of build/link,native import/handle checks,source-body preservation and package/frozen-source hashes.

Revision7 adds only share/plugins/seedlink/win_plugin.exe as a binary. All152 prior PE identities,11 GUIs,12 Python extensions and four Tau resources are unchanged. The selected corrected core remains `167DE26247A3BB4408E0EE55ED34196C7A43B688664700120CC240A83F4D83F8`. Backend coverage104/120 leaves11 Windows portability blockers,one dependency blocker and four disabled targets. Build coverage is not operational completion.

The retained per-user copy installer and process-local environment scripts do not launch anything. The installation guide now references revision7; use the externally recorded08C3 digest. Actual installation/launch is NOT_RUN. Existing external CPython home,optional resource/dependency,controller and execution-scope limits remain. Earlier revision records are historical; revision-08c3.json/current provider-manifest.json describe the candidate. Prior qualification receipts do not admit the changed package.

## Linux fixture + result provenance

NOT_RUN. No Linux compiler,oracle or runtime was invoked.

## Numerical difference matrix

Not applicable. No transport or seismic result was generated or compared.

## Evidence gaps, failures and unresolved scientific questions

There was no target compile/link failure. Legacy warnings and input/error paths remain unqualified. In particular,the original non-default control-file argument branch references argv[4+optind] after accepting three positional arguments; this inherited potential out-of-range access remains unchanged and is a runtime/usability gap,not a completed input-path qualification. No unrelated upstream correction was bundled with this portability patch.

The LLP64 native ABI,UDP truncation/error handling,short-option parsing,console lifecycle,reload behavior,Event Log display/permissions and original acquisition framing need focused runtime qualification before operational use. No leak-free or scientific result is claimed. Historical pre-06C1 configuration custody,07A Tau prehash and07E3 sequencing exceptions remain as documented.

## Final assessed milestone

**Original WIN native build and revision7 integration: completed. Phase5A PARTIAL.** Continue remaining socket transports,then thread/serial/IPC and dependency closure. Essential integration and a small authorized offline workflow check remain necessary for usability. This is an engineering build milestone,not scientific certification or release approval.
