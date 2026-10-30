# PHASE 5A VERIFICATION REPORT — P8-WINBACKEND-08C4

**Agent:** Codex. **Local date:** 30 October2026,Asia/Manila. **Platform:** native Windows x64,existing VS2022 Professional/MSVC14.44 Release toolchain.

The inherited WIN control-file argument bug is corrected and the original **scream_plugin_ring** target now compiles and links natively. Backend build coverage advances to **105/120**. New **unified-08a-r8-native** contains154 PE binaries/853 manifested files: it updates WIN,adds SCREAM ring and preserves the other152 prior binaries,11 original GUIs,12 Python extensions and four Tau resources. Work follows the user's implementation-first/minimal-testing direction.

Package: `Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\staging\unified-08a-r8-native`.

Externally recorded **SHA256SUMS.json** identity: **`FA2D1E1B2AC513B65C4BD048637DF3DC26944BE02788019EE6892004858AAB30`**.

## Gate register

| Gate | State | Evidence / actual invocation and exit | Limitation |
|---|---|---|---|
| A: Source + Phase4C evidence | BLOCKED full gate | before.json,verification.json: nine frozen HEAD/status/hash vectors match | Phase4C raw evidence not reaudited |
| B: Transitive dependency closure | NOT_RUN full gate | artifacts.json: changed/new target native imports resolved | Broad closure review remains closed |
| C: Linux original Autoloc offline oracle | NOT_RUN | No invocation | No WSL/Linux compiler/oracle run |
| D: Windows native original Autoloc offline executable | NOT_RUN full gate | configure-command.json,win-fixed-command.json,ring-final2-command.json exit0 | Target build/package milestone only |
| E: Replay equivalence and robustness | NOT_RUN | argument-commands.json exit0 for isolated argument block | Synthetic argument cases are not seismic or transport parity |

## Pinned source / patch provenance

Exact preimages and10 final source patches/hashes are in source-patches.json. The editable WIN source changes only `argv[4+optind]` to `argv[optind + 1]`,using the actual accepted control-file positional argument. The complete remainder of that source matches revision7. No station or scientific behavior is altered by this index correction.

Ring edits affect CMakeLists.txt,util.h,util.c,oscompat.h,main.c,scream.c,dispatch_ring.c and two added private Windows helper files. Original notices are preserved. Nine original GCF/mapping/header source files remain byte-identical,including gcf.c and mapping.c. The complete dispatch/stack/sort/order core is identical. Both receive/distribute worker bodies retain their original processing statements,with only diagnostic-call parentheses normalized. Local Windows aliases bind the existing mutex and sleep call sites to real SRW locks and timers; no pthread/POSIX runtime is used. source-preservation.json records those exact comparisons; no Linux/scientific parity is inferred.

The three required frozen pins remain superproject`9c395c7f00c788c5fc640363abe97b9ced0b44b0`,main`f63cde995e04151dc816151359a036b8b15f6019`,common`92d2202a6065aad36ae7d4a9bf960b6fb91222d2`,with clean status and matching file hashes. Six additional frozen snapshots match. The previous WIN executable was archived before compilation; it is the only changed existing binary among316 watched products. The other315 products and all851 revision7 package files remain unchanged. Old stages,qualification payloads,protected evidence,security settings,dependencies,controller,Phase7 and operational assets were preserved. Current inventory/status/ledger have retained preimages.

## Build/link inventory

WIN compile/link exits0 (`win-fixed.log`,101 warnings/0 errors). A single focused standalone harness executes the exact corrected control-file source block,testing normal filename,negated filename and all-channels '-' at two option offsets. All **six cases pass**,harness build/run exit0 (`argument-commands.json`,argument-run.stdout.log). It opens no socket,loads no SeisComP plugin and executes no original acquisition program. This is a synthetic argument-block check,not full CLI qualification or memory instrumentation.

Ring uses `_beginthreadex` with native CRT thread trampolines,owned Windows thread handles,SRWLOCK try/unlock,waitable microsecond-delay requests and Sleep for whole seconds. Wall-clock queries convert Windows FILETIME to Unix seconds; `_putenv_s`/`_tzset` retain the original process-local UTC-if-unset intent. Modern MSVC fixed-width integer types retain the original decoder's64-bit accumulator. Winsock2.2 startup is owned once per process. Full-width SOCKET reaches both the main receiver and TCP gap-retrieval path; INVALID_SOCKET,closesocket,recv and flag0 replace the native-platform API differences. Existing partial-read loops,wire commands,packet fields and algorithms are retained. Raw dump mode is binary on Windows.

Original process-exit lifetime is preserved. Native cleanup closes owned thread handles and releases Winsock; workers are not joined and no graceful/bounded service shutdown is claimed. Ctrl+C requests process exit through the main loop;Ctrl+Break toggles the existing packet-drop diagnostic mode. This differs from WIN's Ctrl+Break channel reload and is documented per target. No shell-based sleep or Linux subprocess is used in the Windows branch.

The first ring build exits0 with90 warnings; its executable is archived under first-ring-build. Compiler output revealed an inherited diagnostic macro treating a tuple's comma expression as a string pointer. Its Windows form was corrected to pass format arguments. The intermediate ring-final build exits1 because two plain-string callers still needed tuple parentheses; those exact C2143 errors are retained. After normalizing diagnostic call syntax,the final ring build exits0 with88 warnings/0 errors (`ring-final2.log`),with no warning suppression. Remaining C4477 time_t/long diagnostics,C4244 narrowing,C4146 unsigned-negation and legacy CRT/Winsock warnings remain recorded. Some original GNU `%m` diagnostic strings also remain Windows-unqualified; they are not error-code proof.

Only the two target compiler/linker wrappers and existing CMake regeneration ran; reference-project builds were disabled. No packages,dependencies or system policy were installed/changed. artifacts.json and raw static headers/imports prove AMD64 PE32+ and actual native provider resolution. Original ring main and send_raw3 symbols are retained. All normal/delay/private named/ordinal/forwarder relationships resolve against the selected graph and inherited Windows/VC/API-set boundary. No Linux,WSL,Cygwin,MSYS,Wine or pthread runtime is imported. Private graph remains389 relationships. Static compatibility is not runtime qualification.

## Windows fixture + result provenance

Only the standalone six-case argument harness was executed. Neither original acquisition program,its workers,UDP/TCP endpoints,station/server,Event Log,GUI,Python binding,database nor scientific workload ran. No broad regression,memory or parity campaign was added.

Revision8's updated WIN binary is `B11B422F80CF7B705DA68493DC262C8793B78750A0A5D96A0DA060FA132E531D`. Ring binary identity is in artifacts.json. The selected corrected core and all other152 prior PE files are unchanged. Inventory count is independently105 Already built,10 Windows portability blockers,one dependency blocker and four disabled targets. This denotes builds,not operational readiness.

The inherited copy installer/environment scripts remain; the guide references revision8 and its external08C4 manifest identity. Actual installation/launch is NOT_RUN. Existing external CPython home,optional resources/dependencies,controller and execution-scope limitations remain. Current provider-manifest.json/revision-08c4.json describe this package; older records remain historical. Old qualification receipts do not admit changed payloads.

## Linux fixture + result provenance

NOT_RUN. No Linux or new reference dataset was used.

## Numerical difference matrix

Not applicable. No seismic or transport outputs were generated or compared.

## Evidence gaps, failures and unresolved scientific questions

The diagnostic-macro correction's intermediate compile failure is retained. Known inherited concurrency/error/memory paths,thread shutdown,blocking I/O cancellation,ring saturation,reconnect/gap retrieval and clock/timezone behavior remain runtime-unqualified. Waitable timer resolution differs by host scheduling; a requested one-microsecond delay is not a measured timing guarantee. The current helper allocates/closes a timer per micro-delay and performance has not been assessed. No joined-worker or service lifecycle is introduced. No memory-safety,acquisition,scientific or release PASS is claimed.

The WIN index bug is resolved by source/build/focused cases; other inherited input/diagnostic paths remain unqualified. Historical pre-06C1 configuration custody,07A Tau prehash and07E3 sequencing exceptions remain. License notices are retained; no distribution certification is asserted.

## Final assessed milestone

**WIN argument correction and original SCREAM ring native build/package: completed. Phase5A PARTIAL.** Continue remaining acquisition transports and their native thread/serial/IPC contracts,then essential application integration. A small authorized offline integration check remains necessary for usability. This is engineering progress,not scientific certification or release approval.
