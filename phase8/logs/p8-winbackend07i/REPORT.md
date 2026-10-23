# P8-WINBACKEND-07I — Native MiniSEED scanner integration

**Original mseedscan_plugin build exits0; backend100/120 built, GUI11/11.** Remaining15 Windows-portability blocked,1 external-dependency blocked,4 disabled. Existing VS2022/MSVC19.44 Release x64;23 October2026. Runtime/scientific qualification NOT_RUN.

## Windows file tracking and traversal

FileKey retains the filename discriminator plus full uint64 volume and all16 FileIdInfo bytes. Construction/addfile/lookup/comparison use the same identity type; no inode narrowing, hash surrogate or path-only identity. Renamed paths remain distinct keys as in the original scanner; replaced files acquire new keys and offsets while old keys prune under original scan rules. Scan counters,idle/quiet flags, nextnew, modtime/size checks and offset advancement retained. Native64-bit offsets use _lseeki64/read on a duplicate of the same opened target handle that supplied identity/size/time, avoiding reopen-by-path identity races. The original MiniSEED processing loop matches byte-for-byte after native read/close naming; seedutil.c remains unchanged.

Root paths are expanded once with dynamic UTF-16 storage. Native enumeration order and original recursion limits retained; no arbitrary sort or process cwd mutation. Existing07H path/enumeration/full-ID/wait primitives reused. Reparse targets are followed as stat did; ancestor full directory IDs detect cycles and report a fatal scan error before pruning/saving incomplete scan state. Sibling aliases retain distinct filenames. Broken disappeared targets may be skipped as original broken-link handling; unsupported FileIdInfo/filesystems and other open/identity/enumeration errors report failure, not successful skips. File times convert to signed64 Unix seconds, including pre-epoch floor behavior. Directory-list config uses wide CRT paths and64-bit stat. No waveform/packet formatting change.

## Versioned Windows state

MSWIN1 binary file starts with eight magic bytes `MSWIN1\r\n`. Each record stores little-endian u64 UTF-8 filename length, exact filename bytes (no embedded NUL), u64 volume,16 raw file-ID bytes, signed64 offset and signed64 modification time represented as two's-complement bits. A UINT64_MAX marker and u64 record count footer is required. Recovery validates magic, complete fields, sizes/UTF-8, offset >=-1, duplicate keys, footer count and no trailing bytes. Malformed/truncated or legacy POSIX records fail startup and are not overwritten by a continuing scan. Explicit removal/reset or separately approved migration is required; absent new state is allowed. POSIX state serialization/recovery remains unchanged in its branch. Windows drive colon and optional interval suffix are distinguished.

The original direct state-write lifetime is retained; atomic crash-safe replacement/checksums are not claimed. Interrupted writes will be rejected on recovery, not silently interpreted. No waveform/event/scientific data format changed.

## Regex and interruption compatibility

Inspection found an already approved source-tree POSIX regex provider: seedlink_native contains boost_posix_api.cpp and slutils/native_regex.h, backed by installed Boost1.90.0. The scanner's private C/C++ bridge calls that existing regcompA/regexecA API with the actual REG_EXTENDED|REG_NOSUB constants, zero execution flags, no captures and no pattern rewriting. The initial restricted std::regex draft was replaced before final qualification; no subset restrictions are imposed by the final bridge. Invalid expressions and evaluation errors are reported; failed evaluation aborts rather than becoming a false include/exclude match. No engine installed/upgraded. POSIX syntax/locale/Unicode behavior is inherited from the existing Boost provider and remains runtime-unqualified against a Linux oracle; this build is not full regex parity certification.

Attached-console mode maps Ctrl+C to an orderly stop request and Ctrl+Break to print state, separately. Callback only queues Interlocked flags and wakes the caller-owned event; tree traversal/printing happens on the scanner thread. Event reset ordering avoids losing notifications; a private SRW lock protects event closure against in-flight callbacks. Integral scan seconds use the existing interruptible native wait, without DWORD truncation. This does not reproduce all POSIX signals: SIGTERM/non-console service control and SIGHUP/SIGPIPE have no invented external protocol; console close/logoff/shutdown are not translated. Startup without an attached console explicitly fails with a diagnostic. No arbitrary PID controls, forced termination, controller/service or new deadline. Original Linux signals/nanosleep remain unchanged.

## Focused build and static evidence

Actual exit0 command/raw output: mseedscan_plugin-command.json, mseedscan_plugin.log, mseedscan_plugin.exit_code.txt. Original generated target and existing slplugin/seedlink_native dependencies used; Windows regex translation unit added through scoped CMake. No provider/Qt/controller/solution rebuild. Initial missing S_ISREG linker error repaired with native CRT mode predicate; failed/intermediate logs retained. No source/plugin/child/scanner execution.

Completed executable: AMD64 PE32+, SHA-256 **`B76D99BF36CBBA5A718E4BA271B24D16E342518BD01E5F55875F07523A113017`**. The Windows UTF-16 CRT entry `wmain` converts argv losslessly to UTF-8 and invokes the original scanner main body as ms_scanner_main; the POSIX main is unchanged. Both native entry/driver symbols and the original send_mseed reference are verified in COFF symbols with the static provider chain. This is not a SeisComP DLL factory plugin and no fake createSCPlugin export was added. Original record parser/output retained. Raw PE headers/import/export logs and artifacts.json verify static private DLL closure at Windows/API-set/VC-runtime boundary. There are0 private DLL provider pairs because regex/SeedLink providers link statically; their exact hashes are in static-link-provenance.json. Runtime loader/stream behavior remains NOT_RUN.

## Exact source patches

- `P8-WINBACKEND-07I-mseedscan.c.patch`: `CE118FB327A8928B0A4BB0973C23A7CD98E1E5BBEFD03FF5AA53A7EFEBDD794C`.
- `P8-WINBACKEND-07I-CMakeLists.txt.patch`: `D4C5E322F86349DFDA94733AF13AA9B7A861E747D4870C0912CBBE0566124E45`.
- `P8-WINBACKEND-07I-windows_scanner_private.h.patch`: `D9E8A9FC759A9C1BF185B69F217C30D43F6E244D2C9D361E2F95EF647BD8F798`.
- `P8-WINBACKEND-07I-windows_regex.h.patch`: `62C3DD9F8FA146F18716530537AD7C0FE3BB1C4658AFCE7FE7C7997FEF845FA6`.
- `P8-WINBACKEND-07I-windows_regex.cpp.patch`: `5FC271B7486AB9F58BD20446723D415FF4C0F75A855719382B8721474738DBB0`.

source-patches.json contains pre/post source hashes and MiniSEED-loop equivalence evidence. POSIX private identity typedef remains ino_t; original traversal/process/state functions and signal logic are retained under their POSIX branches. New code is Windows-scoped, with original scientific processing and source licenses preserved.

## Preservation, inventory and installation readiness

Before compilation,288 completed binary/import/export products including nested libraries were archived/hash-verified to completion. All288 current/archive products,1799 protected prior files/stages, nine frozen HEAD/status/file vectors and installed dependency status/libraries remain unchanged. No staged providers updated or mixed. Frozen superproject9c395c7f00c788c5fc640363abe97b9ced0b44b0,mainf63cde995e04151dc816151359a036b8b15f6019,common92d2202a6065aad36ae7d4a9bf960b6fb91222d2. Historical pre-06C1 config preimage INCOMPLETE,07A Tau prebuild hash unavailable,07E3 overlap retained; no retroactive recovery claims. Phase7, completed process helper/cancellation policy and ew2sc proposal unchanged.

Canonical CSV/JSON,status and patch ledger now100 built,15 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11. Remaining acquisition work includes Q330 threading/platform services, serial termios, TCP/UDP/socket/time APIs, FIFO/worker IPC and Reftek native build integration; Boost.Asio and disabled database/locator dependencies stay separate decisions.

Next highest-value implementation: one scoped socket acquisition target (SCREAM or sock_plugin) reusing established native socket components only where semantics match, plus a focused non-console scanner notification contract. Unified offline installation assembly planning can proceed from static evidence, but no complete/service-ready installation is claimed: scanner service mode is unsupported,15 targets remain Windows-blocked, and runtime/regex/state/traversal/scientific parity is unverified. No installation deployment performed.

## Phase5A gate register

| Gate | State | Evidence/exit | Limitation |
|---|---|---|---|
| A: Source + Phase4C | NOT_RUN as full gate | before.json;artifacts.json | Frozen custody checked; broad audit not repeated |
| B: Transitive closure | NOT_RUN as full gate | focused build exit0;static closure | Whole-install/runtime incomplete |
| C: Linux original oracle | NOT_RUN | None | No fixture/oracle execution |
| D: Native original Autoloc offline execution | NOT_RUN | None | No application execution |
| E: Replay/robustness | NOT_RUN | None | No numerical, filesystem, state or control tests |

Linux/Windows fixtures and numerical matrix NOT_RUN: origins/time/location/depth/association differences unavailable. Only source integration, compilation/linking and static inspection; no network/database/live acquisition, GUI/controller or scientific replay. Phase5A **PARTIAL**; engineering build completion only.
