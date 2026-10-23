# P8-WINBACKEND-06A — native lock utilities and ew2sc

**Agent / compiler / date:** GPT-6.1 Sol; VS2022/MSVC 14.44.35207; Release x64; 22 October 2026 (Asia/Manila). **Five native build targets completed; runtime validation not performed.** Operator authorization: Windows-only portability of the four utility targets and ew2sc.

## Source modifications and patch provenance

| Patch in phase8/patches/ | SHA-256 | Exact source scope |
|---|---|---|
| P8-WINBACKEND-06A-locks.patch | `0F093E0F64F37F65A9C75EDEA063ED2BB22706C55C3712CFEDC49721EB1EB6AA` | `src/system/apps/utils/CMakeLists.txt`; new `win32/{native.h,locking.c,process.c,trylock.c,waitlock.c,timeout.c,run_with_lock.c}`. |
| P8-WINBACKEND-06A-ew2sc.patch | `E42A81B53E5EC5B3887EB1BF90549E4A5EF554FBBE2D0D56E04E79AA7C0992DD` | In contrib-ipgp: `apps/ew2sc/{CMakeLists.txt,ew2sc.h,ew2sc.cpp}` and new `ew2sc_win32.cpp`. |

Both batch-only patches pass `git apply --reverse --check` (exit 0) against the final working copies. All source pre/post hashes and commands: `applied-patches.json`; preimages: `preimages/`. Original notices remain intact; ew2sc Windows code retains GPLv3-or-later provenance. No dependency version changed.

The three file-locking utilities use the same exclusive kernel byte beyond EOF so PID text remains readable, with noninherited handle ownership. `run_with_lock` creates/writes its own PID and retains ownership until direct-child completion; console handling retains the lock while Windows notifies the child. Unicode argument quoting, child cleanup and exit propagation use CreateProcessW/process handles. `timeout` uses a real monotonic timed wait and terminates/reaps only its direct child. `waitlock` cancels/drains pending asynchronous lock requests before releasing OVERLAPPED resources. Existing missing-file, contention, zero-timeout and error/status behavior is recorded in `compatibility-proposals.md`.

ew2sc implements native IPv4 resolution, cancellable connection/read/send waits, pointer-width SOCKET storage/signatures, Winsock errors, balanced startup/cleanup and supervisor-owned socket/thread lifetime. Workers cannot join themselves or close a reused socket. Reconnect buffer ownership, receive EOF and short malformed frames are handled safely; valid protocol framing and the entire seismic interpretation section remain unchanged. Local GetMessage macro isolation fixes the notifier ABI collision without provider-DLL changes.

## Build/link inventory — engineering evidence

Exact command per target: `cmake --build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target <target> -- /m:1`. CMake schedules prerequisites; no full-project rebuild.

| Target | Build exit | Architecture / recursive static closure | Executable SHA-256 |
|---|---:|---|---|
| trylock | 0 | AMD64 PE32+ / PASS | `9B5CAC86F7B171FC9150F8E0686960496EA096DB96BE7FE1E3545DDAEA621A71` |
| waitlock | 0 | AMD64 PE32+ / PASS | `FA0B7E04ADB526642678F115D6CE8E007CEA916F3988DF6B6646061F369D348C` |
| timeout | 0 | AMD64 PE32+ / PASS | `23FDE856D02FA0959D3D64376DA7561B508C8F98BFFB61B2054FF37EB3CCD831` |
| run_with_lock | 0 | AMD64 PE32+ / PASS | `3590BE8A749C8B818D6433F12E80CF51ADFCE17FCE6D210E51E58BE13D09ED4A` |
| ew2sc | 0 | AMD64 PE32+ / PASS | `A4B8CC9D10AC75C946C8CE6EAE5A51A2CF5920115170791184E689DF5A6C1717` |

Raw final build logs/exits: `<target>.log`, `<target>.exit_code.txt`; commands: `<target>-command.json`. Initial macro warnings, the Winsock send name-resolution compile error and later Notifier::GetMessageA link error are retained in `*-initial.*` and `*-attempt02.*`. Final utility builds have no reported warnings. ew2sc retains framework DLL-interface/linkage warnings, conversions, existing unused variables and CRT/gethostbyname deprecation warnings; exact counts/raw messages are in `06a-batch-evidence.json` and `ew2sc.log`. Nothing was suppressed. Per-binary dumpbin headers/import logs and recursive private/OS/API-set resolution: `artifacts/<target>/`. Static closure excludes optional runtime-loaded plugins. **No compiler/linker blocker remains among these five targets.**

## Remaining contracts and recommended next architecture batch

`compatibility-proposals.md` records exact decisions and separate unapplied proposals: native application/controller locks plus per-PID graceful SIGTERM/SIGHUP equivalents, interpreter launch and native exit handling; a real ew2sc monotonic millisecond send deadline; fail-closed inaccessible lock probes. The existing POSIX Python controller and common Application Windows lock stub were outside this batch and remain untouched. Native console notifications/DWORD exit codes cannot encode arbitrary POSIX signal injection/re-raising. Synchronous DNS can delay cancellation. ew2sc intentionally retains the literal 5,000-second zero-progress sleep and original blocking-send timing; senderTimeout is not an absolute deadline. No new protocol or timing contract was silently introduced.

Inventory is **73/114 built, 19 available, 14 Windows-blocked, 2 dependency-blocked, 6 disabled; GUI 11/11**. CSV/JSON inventory, implementation status and patch ledger are updated. GUI staging and its stale provider copies remain untouched. Recommended architectural batch: coherent native common-application locking, Python controller launch/notification/termination and exit-status handling; separately approve bounded ew2sc send deadlines.

## Preservation / Phase5A gate register

All nine frozen repositories retain expected HEADs, clean status and before/after tracked-file hashes; all 833 protected baseline/staging/provider files and vcpkg state match pre-batch hashes (`before.json`, `preservation.json`). Source checks exit 0 (`source-preservation-check.log/.json`): original utility source bytes, Linux active branches and ew2sc interpretation are preserved. Excluded components were not changed.

| Gate | This batch | Evidence / limitation |
|---|---|---|
| A: Source + Phase4C evidence | NOT_RUN as a full gate | Frozen custody PASS; Phase4C audit not repeated. |
| B: Transitive dependency closure | NOT_RUN as a full gate | Five static PE closures PASS; broader Autoloc closure unchanged. |
| C: Linux original Autoloc offline oracle | NOT_RUN | No applications or fixture replay permitted. |
| D: Windows native original Autoloc offline executable | NOT_RUN | These utility/network builds do not revalidate this gate. |
| E: Replay equivalence and robustness | NOT_RUN | No numerical/scientific/runtime testing. |

**Final assessed milestone:** Phase5A remains PARTIAL with its existing gate state. P8-WINBACKEND-06A focused native build engineering is complete; runtime behavior, numerical/scientific parity and release qualification remain unvalidated. No applications, services, network sessions, operational databases or GUI preflights were run.
