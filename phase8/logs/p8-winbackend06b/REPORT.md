# P8-WINBACKEND-06B — application locking and controller integration

**Agent / compiler / date:** GPT-6.1 Sol; VS2022/MSVC 14.44.35207, Release x64; 22 October 2026 (Asia/Manila). **Engineering milestone: partial.** Application locking and native launch/ownership source are implemented. Graceful live stop/reload requires approval of a Windows control contract; controller deployment also requires native Python bindings. No applications or services were executed.

## Implemented scope and exact patches

Operator authorization is the Windows-only 06B application/controller task. No scientific algorithm, public Application layout, dependency version or Linux implementation changed. Original notices are retained.

| Applied batch patch | SHA-256 | Exact source scope |
|---|---|---|
| [application locking](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/patches/P8-WINBACKEND-06B-application-locking.patch) | `765F610032E8F6B1678D8860D9421B9A8CBB9E09210D7605516A61629ED2ED52` | common repo: `libs/seiscomp/{CMakeLists.txt,system/CMakeLists.txt,system/application.cpp,system/windows_lock.cpp,system/windows_lock.h}` |
| [controller](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/patches/P8-WINBACKEND-06B-controller.patch) | `52DDA4F79A31C85388D6803FB1B5FD8C9CB375FEDC8E4A2697AE5129FABA86C6` | root repo: `src/system/apps/utils/win32/native.h`; `src/system/libs/python/seiscomp/{CMakeLists.txt,kernel.py,windows.py}`; `src/system/apps/seiscomp/seiscomp-control.py` |

Both patches pass reverse applicability checks, exit 0. The [source/patch manifest](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06b/applied-patches.json) contains every source pre/post SHA-256; preimages are retained separately.

- **Application ownership:** replace the Windows acquireLockfile failure stub with a private RAII handle registry. Reuse 06A LockFileEx ownership on the byte beyond EOF, leaving decimal PID text readable. Acquire before overwriting stale metadata; distinguish contention from access/I/O errors. Deny file deletion/replacement while held; handles are noninherited. Release on Application destruction or OS process cleanup after abnormal exit. No HANDLE is cast to a descriptor.
- **Controller integration:** kernel start/lock/stop paths call a private Windows adapter. The controller directly owns its global kernel file lock and per-module launch guard; inherited SEISCOMP_LOCK is insufficient to bypass it. Preserve module ordering, kernel modules last on stop, and aggregate real failures. Clean run/ownership metadata only after an exclusive free-lock check; retain PID inode continuity.
- **Native launch:** CreateProcessW uses an explicit executable/interpreter, quoted argv, Unicode environment, explicit cwd, and a standard-handle allowlist. Own process/thread/job handles. Resume only after atomic Job Object assignment. An incomplete launch remains in a noninherited kill-on-close job until the child owns its PID lock and its receipt is committed. Failed launches terminate/reap only the created child/job members, with a five-second termination wait. Startup handoff is bounded at ten seconds. Windows 10+ JOB_LIST support is required; restricted parent jobs fail without bypass/fallback.
- **Process identity:** receipt binds PID, creation FILETIME, canonical image, root/module and lockfile file ID. PID-only stop is prohibited. Normal launch handoff clears the job kill policy; foreground completion preserves DWORD exit bits. Missing/stale PID text never proves live ownership. The receipt is private bookkeeping, not an authorization token or control protocol.
- **Install selection:** generated Windows install plan now selects the existing Windows initializer and private adapter. Nothing was installed. Python adapter/controller syntax and x64 ctypes structure layouts pass static checks; Linux AST/source projections match the preimages (source-checks.log, exit 0). These checks do not execute controller or launch APIs.

## Native build/link evidence

Command for each target, in dependency order: `cmake --build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target <target> -- /m:1`. The core target rebuilt because of its new private include/source membership; no ALL build was requested. **Every target below: actual build exit 0, AMD64 PE32+, recursive static DLL closure PASS** (private imports recursively resolved to the Windows/API-set boundary). Optional dynamically loaded plugins are outside static closure.

| Target | Artifact SHA-256 |
|---|---|
| [seiscomp_core](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06b/seiscomp_core.log) | `0B7B668D2B122CAAB04AE27F160F94AD60BF7479CD13875F3D431E7E784DFD61` |
| [seiscomp_client](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06b/seiscomp_client.log) | `470C8F26A45FE1B01256F67A4F79D57E31FBA4BBF90C5EF6B36DF0BC64E20ACA` |
| [trylock](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06b/trylock.log) | `057E2CBBC9E1B56D793386BF22A86CBCB4E688C498D5BF987EBE1F7E81A4D846` |
| [waitlock](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06b/waitlock.log) | `BA3AD10E283442E619177B4F01541F0EE18775DC1187BC5CBE7690298D23413B` |
| [timeout](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06b/timeout.log) | `B66BDD339F360AA9B41DA0693690491FC24700C20A5C83F4F9BC2D2144CA7E80` |
| [run_with_lock](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06b/run_with_lock.log) | `3700B71AC165403561BADB2E351A690644102685E9D477C2055756854F18A4F1` |
| [scm](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06b/scm.log) | `89F2929E1C1AF096F2C8A2EBF84074CD1D2FC65C8E84FE5D827E5940043BF8FB` |
| [ew2sc](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06b/ew2sc.log) | `A4B8CC9D10AC75C946C8CE6EAE5A51A2CF5920115170791184E689DF5A6C1717` |

Raw build commands, exit-code files, warnings and dumpbin header/import logs are preserved in [batch evidence](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06b/06b-batch-evidence.json) and its artifact directories. No target compiler/linker blocker remains in this focused set. Existing core warnings include DLL annotations, conversions, C4305 precision, cephes macro redefinitions and hostinfo.cpp C4715; they remain visible. Warning occurrence counts include repeated compiler output and are not unique defect counts. Initial static-check harness/export-script errors are retained separately; final source/evidence scripts exit 0.

## Compatibility blockers and narrow proposals

[Per-process control proposal](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06b/control-contract-proposal.md) is **NOT IMPLEMENTED**. Existing SIGTERM/SIGINT reaches InterruptibleObject/Application exit; generic SIGHUP is ignored. FDSNWS alone supplies its own `.reload` file/HUP/task/acknowledgement contract. Forced termination is a controller escalation, not signal delivery. The proposed local-session StopRequest/StopAccepted events require operator approval, endpoint ACL/identity validation, safe main-loop dispatch and bounded completion/escalation through the same verified process handle. No generic reload endpoint is proposed.

Live stop/reload currently returns an explicit failure and performs no termination. Restart aborts if stop fails. Module-specific POSIX shutdown overrides and syslog/daemon flags have no reviewed Windows mapping and are rejected. Already stopped modules allow guarded stale-metadata cleanup. Nested controller reentrancy requires a future proven lease rather than an environment flag.

Native Python `_config` bindings remain unavailable in this configuration (`SC_GLOBAL_PYTHON_WRAPPER=OFF`). The shell frontend and module-specific launch/config handlers are not qualified for Windows deployment. Explicit-interpreter launch source is present, but no complete controller installation or runtime operation is claimed. Phase 7 governance mechanisms were not integrated.

## ew2sc deadline proposal — prepared only

The 06A source's zero-progress path retains the upstream literal 5,000-second retry delay (`waitWindowsStop(5000000)` milliseconds), while partial writes/readiness can exceed senderTimeout. The [unapplied three-file patch](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/native-working-copy/phase8-proposals/P8-WINBACKEND-06B-ew2sc-deadline-proposed.patch) (SHA-256 `DC3ADFC288FA088B636E7C58AE0BFA3AA07AD37D4ABC8CC3D30C8B10051E126F`) passes applicability check, exit 0, but is **NOT APPLIED / NOT BUILT / NOT EXECUTED**.

It proposes one GetTickCount64 deadline for the entire existing header/payload/ETX packet, preserving offsets after partial writes without resetting the deadline. WSAPoll waits use at most 100 ms of remaining time; EINTR/WOULDBLOCK retry against that same deadline, zero progress waits at most five ms, and poll/SO_ERROR failures are handled. Cancellation, timeout or errors return -1 and disconnect through existing supervisor cleanup, preventing reuse of an incomplete frame. Nonpositive senderTimeout would fail EINVAL before sending; that policy is explicitly part of the approval request. Framing and seismic interpretation are unchanged. Active ew2sc source hashes still match 06A; its successful rebuild does not qualify this proposal.

## Inventory, preservation and next phase

**Backend: 73/114 built; 19 available; 14 Windows-blocked; 2 dependency-blocked; 6 disabled. GUI: 11/11 built.** Eight existing inventory rows were refreshed only after successful rebuild/inspection; zero new targets were counted.

All nine frozen snapshots retain expected HEAD, clean status and before/after sentinel hashes; 780 protected archive/staging files and the vcpkg package-status hash match baseline. Twelve original affected build products are hash-verified in binary-before; all six changed existing build products have matching pre-batch archives. See [custody evidence](Y:/OFFICE/IPP/2026/PROG/SEISCOMP/SeisComP_Phase5A_AI_Coder_Pack/phase8/logs/p8-winbackend06b/preservation.json). Linux active paths pass static preservation checks. No application/service, operational DB, network session, fixture replay or GUI preflight was run.

All 11 staged GUI bundles still contain stale core/client/config providers; per-copy hashes are recorded in batch evidence. Refresh remains deferred.

**Recommended next development phase:** approve the narrow per-process stop contract, implement its application main-loop dispatch/controller endpoints, then qualify native Python config bindings and a Windows controller entrypoint/module handlers. Approve the ew2sc cumulative deadline change separately. Operational testing remains deferred.

## Phase5A gate register

| Gate | State | Evidence / limitation |
|---|---|---|
| A: Source + Phase4C evidence | NOT_RUN as a full gate | Frozen custody verified; Phase4C audit not repeated. |
| B: Transitive dependency closure | NOT_RUN as a full gate | Eight focused static closures PASS; broader Autoloc gate unchanged. |
| C: Linux original Autoloc offline oracle | NOT_RUN | No application/fixture execution authorized. |
| D: Windows native original Autoloc offline executable | NOT_RUN | Focused library/utility builds do not revalidate this gate. |
| E: Replay equivalence and robustness | NOT_RUN | No numerical/scientific/runtime tests. |

**Final assessed milestone: Phase5A PARTIAL.** Build/static engineering evidence only; no new numerical, scientific or release qualification. Windows API references: [process identity](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-getprocesstimes), [startup attribute lists](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-updateprocthreadattribute), [job lifetime limits](https://learn.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-jobobject_extended_limit_information). Atomic JOB_LIST value and Windows 10 requirement were checked against the installed Windows SDK 10.0.26100.0 WinBase.h; x64 job structure sizes are checked statically.
