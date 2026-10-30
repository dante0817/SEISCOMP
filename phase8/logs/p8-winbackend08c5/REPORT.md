# PHASE 5A VERIFICATION REPORT — P8-WINBACKEND-08C5

**Agent:** Codex. **Local date:** 30October2026,Asia/Manila. **Platform:** native Windows x64,existing VS2022 Professional/MSVC14.44 Release toolchain.

Original **ewexport_plugin**,the Earthworm export client,is now compiled/linked and packaged natively. Backend build coverage advances to **106/120**. New **unified-08a-r9-native** contains155 PE binaries/855 manifested files. All154 previous binaries,11 original GUIs,12 Python extensions,four Tau files and the corrected core retain revision8 bytes. The user authorized continued acquisition conversion with focused checks and deferred broad qualification.

Package: `Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\staging\unified-08a-r9-native`.

External **SHA256SUMS.json** identity: **`475CF040BAE301822A08A31B32A3D218A75621DAD5EEA314A563221E107DFB57`**.

Earthworm executable SHA-256: **`3BCE18051A734E443E0AB502BC6B39E91E97143D3EE9E14D2FA3437383D52120`**.

## Gate register

| Gate | State | Actual evidence/invocation and exit | Limitation |
|---|---|---|---|
| A: Source + Phase4C evidence | BLOCKED full gate | before.json,verification.json: nine frozen HEAD/status/hash vectors match | Phase4C raw evidence not reaudited |
| B: Transitive dependency closure | NOT_RUN full gate | artifacts.json,static/imports.log: affected target imports resolved | Broad code/dependency review remains closed |
| C: Linux original Autoloc offline oracle | NOT_RUN | No invocation | No Linux/WSL compiler/oracle execution |
| D: Windows native original Autoloc offline executable | NOT_RUN full gate | configure-command.json,ewexport-command.json exit0 | Original acquisition target build only |
| E: Replay equivalence and robustness | NOT_RUN full gate | receiver-commands.json: mechanical helper build/run0 | No acquisition/message/scientific parity result |

## Pinned source / patch provenance

Seven scoped editable files are recorded with exact preimages,final patches and hashes in source-patches.json: ewexport_plugin.c,network.h,swap.c,util.c,CMakeLists.txt and two added private Windows files. Original network.c,trace definitions and conversion sources remain unchanged. The original copyright/license notices are retained;the Windows transport adaptation attributes the original network routines to Chad Trabant. This development package has no distribution/license certification.

The Windows CMake branch uses the original main,swap,logging and trace conversion sources,existing original slplugin and the private native transport. It excludes the POSIX network.c and materialized plugin.c placeholder;the original POSIX source recipe remains. No algorithm or transport is stubbed. Native my_connect/my_recv/my_send use real Winsock calls;their code was built,not exercised against a server.

Native sockets retain full pointer width through Sd,network helpers and WriteToSocket. Windows connection failures use INVALID_SOCKET,including timeout;POSIX condition/type aliases preserve its existing ABI. Connections use IPv4,nonblocking ioctlsocket,one-second proxy/NAT settling delay,a10-second connect readiness budget,SO_ERROR/peek validation and keepalive. The native select wait polls process cancellation in100ms intervals. Send/receive retain the original5ms polling,partial-send accounting,timeout return conventions and EOF/error distinction,using WSAGetLastError rather than POSIX errno internally.

The receiver uses `_beginthreadex`,owned handles and manual-reset cancellation/process events. The console callback sets an event;it does not asynchronously terminate the worker. Reconnect requests cancellation and waits up to3000ms for thread exit before closing/replacing the socket or reusing the shared MsgBuf. A failed wait refuses reconnect and returns failure;no TerminateThread or substitute pthread runtime is used. Thread completion returns through the native CRT trampoline. Process cleanup retains event handles if a worker failed to join,so a live worker does not see recycled event handles before process termination. Console/event-handle cleanup is synchronized. Ordinary main-thread stop frees MsgBuf only after successful join.

source-preservation.json confirms the complete waveform import/filter,WriteToSocket,configuration,usage and strip bodies are identical. Heartbeat/ack bodies differ only by full-width socket casts. The entire receive framing state machine differs only by a cooperative cancellation check;start/end/escape handling,old/acknowledged export modes,message acknowledgement and trace/sample conversion remain original. swap.c differs only by the native system header. Compile assertions preserve TRACE_HEADER/TRACE2_HEADER64-byte sizes,starttime offset8,sample-rate offset24 and MSG_LOGO size3. These are source/representation checks,not message or scientific validation.

All317 watched prior build products and all853 revision8 package files match before hashes. Nine frozen HEAD/status/hash vectors match;superproject/main/common remain `9c395c7f00c788c5fc640363abe97b9ced0b44b0`,`f63cde995e04151dc816151359a036b8b15f6019`,`92d2202a6065aad36ae7d4a9bf960b6fb91222d2`,with clean status. Current inventory/status/ledger preimages are retained. Older packages,qualification payloads,protected evidence,dependencies,security settings,controller,Phase7 and operational assets were preserved.

## Build/link inventory

The existing CMake configuration regenerated using the existing approved native dependency hooks;configure-command.json/log records exit0. Only the original Earthworm target's compiler and `_Link` wrapper ran,with reference-project builds disabled. ewexport-command.json/log records **exit0,23 warnings,0 errors**,on its first build. Remaining legacy CRT warnings are retained without suppression. No dependency,package,execution policy or system setting was changed.

artifacts.json,static/headers.log/imports.log and static/main-symbols.log prove AMD64 PE32+,original main and its send_raw_depoch reference. All affected imports resolve against selected native providers or the inherited Windows/VC/API-set boundary. No Linux,WSL,Cygwin,MSYS,Wine,pthread runtime or TerminateThread import is present. No new private DLL relationship is needed;the package retains389 private relationships. Static compatibility is not dynamic-loader or transport qualification.

## Windows fixture + result provenance

One focused mechanical worker check links the actual compiled windows_ew_private.obj and original util.obj. Its harmless callback waits for cancellation;it does not implement or invoke Earthworm message processing. Two generations each start,cancel,join and restart successfully;duplicate live starts are refused and repeated stop is safe. receiver-commands.json records actual harness build/run exits0;receiver-run.stdout.log records PASS. The offline guard records **child exit0 and network_api_entries0** in receiver-run.stderr.log and receiver-guard-receipt.json. This establishes only the exercised helper ownership contract.

No original acquisition executable,Earthworm exporter,network endpoint,station,console callback,database,GUI,Python extension or scientific workload was run. The timeout/failure path of the worker join was not executed. No broad regression,memory or parity campaign was added.

Revision9 adds share/plugins/seedlink/ewexport_plugin.exe. The other154 prior PE identities,11GUIs,12Python extensions,four Tau resources and corrected core remain unchanged. Canonical backend106/120 leaves nine Windows portability blockers,one dependency blocker and four disabled targets. This is build coverage,not operational completion.

The retained per-user copy installer/environment scripts do not launch anything. The guide references revision9 and its external08C5 manifest identity. Actual installation/launch is NOT_RUN. External CPython home,optional resources/dependencies,controller and execution-scope limitations remain. Current provider-manifest.json/revision-08c5.json describe the candidate;older records remain historical. Old qualification receipts do not admit changed packages.

## Linux fixture + result provenance

NOT_RUN. No Linux compiler,reference dataset or oracle was accessed.

## Numerical difference matrix

Not applicable. No seismic or transport outputs were generated or compared.

## Evidence gaps, failures and unresolved scientific questions

There was no compile/link failure in this batch. Actual socket connect/read/write,reconnect,heartbeat timing,ACK behavior,framing,trace conversion and persistence remain runtime-unqualified. DNS resolution is not bounded by the select deadline. A worker blocked in downstream SeedLink output may fail the3000ms join;reconnect is refused,and process cleanup can attempt another join before exit. Thus this is not a proved global shutdown deadline or service-readiness claim. Inherited configuration/error/diagnostic paths remain unqualified;some outer source messages still use CRT errno even though native transport logs its own Winsock errors.

The mechanical callback check is not an Earthworm acquisition PASS. No memory-safety,scientific,operational or release qualification is claimed. Historical pre-06C1 configuration custody,07A Tau prehash and07E3 sequencing exceptions remain as documented.

## Final assessed milestone

**Original Earthworm export native build and revision9 integration: completed. Phase5A PARTIAL.** Continue the passive Earthworm/remaining transport and native serial/IPC/dependency work,then essential application integration. A small authorized offline integration check remains necessary for usability. This is engineering progress,not scientific certification or release approval.
