# P8-WINBACKEND-07F — Native child lifecycle engineering build

**Both original targets build: scwfparam and locext, exit0. Backend97/120, GUI11/11.** Remaining18 Windows-portability blocked,1 dependency-blocked,4 disabled. Existing VS2022/MSVC19.44 Release x64 configuration, 23 October 2026. Runtime/children/scientific replay **NOT_RUN**.

## Implementation and compatibility decisions

`common/libs/seiscomp/utils/windows_child_private.h` is a private header-only implementation, with no exported library interface or controller/Python dependency. CreateProcessW uses an explicit resolved image, validated UTF-8 converted to UTF-16, MSVC inverse argv quoting and the32767-character command bound. STARTUPINFOEXW/PROC_THREAD_ATTRIBUTE_HANDLE_LIST restrict inheritance to duplicated child standard handles; parent pipe ends remain non-inheritable. RAII closes every owned process/thread/pipe/attribute handle. Current directory and environment inherit through NULL CreateProcess arguments without changing parent state. No shell, WSL, dependency, job/breakaway policy, new timeout or force termination.

scwfparam's exact configured executable bypasses PATH and must resolve to a native .exe. Original argv values/order, inherited standard streams, cwd/environment and ShakeMap file-close-before-launch ordering are retained. scriptWait=true waits indefinitely and reports actual DWORD exit status alongside original completion logging; scriptWait=false transfers the process handle to an application-owned polling reaper and returns promptly. Reaper retains the most recently observed real exit status; shutdown closes pending handles without explicitly killing children. Resource-allocation failure during reaper transfer waits for the still-owned child before reporting failure. Enclosing jobs can independently constrain child lifetime and are not bypassed. No automatic script interpreter is added.

locext retains original Core::split profile tokenization, appended options and XML serialization of EventParameters/Origin/Arrivals/Picks/Comments. Serialization completes before launch so data-model exceptions do not orphan a launched process. Explicit execvp-style resolution searches only semicolon-separated PATH entries in order; empty entries mean cwd, paired directory quotes are removed, bare names may add .exe. Names containing slash/backslash/colon bypass search. No PATHEXT, implicit application/system-directory search, shell or ENOEXEC fallback. Supported native Windows PE executables are checked with GetBinaryTypeW (32/64-bit native images); Unix/batch scripts or unsupported images reject explicitly. A native interpreter may be explicit in locext's existing token list; scwfparam's single executable field does not gain a new interpreter-arguments schema.

Binary stdin/stdout use owned pipes: a joined writer handles partial writes while the caller drains stdout in order, then stdin closes for EOF, all output is collected and actual process completion status obtained. Only exit0 enters the unchanged Origin parser/ID handling. Original no-profile/pick/XML/nonzero-exit behavior retained; native stdin/stdout creation and write errors map to existing locator error categories with detailed native diagnostics. No Windows exit code is represented as a POSIX signal.

**Unresolved runtime contract:** no bounded cancellation is implemented or claimed. A noncooperative child or inherited descendant pipe handle can block reads, writer join, wait or exception cleanup indefinitely. Handles and active writer state remain owned rather than detached or silently abandoned; adding cooperative cancellation, termination or a deadline requires a separate contract. Wait failures/fault-injection behavior, concurrent launch inheritance, async shutdown and pipe robustness are not runtime-qualified. See future-process-fixtures.md for prepared isolated cases; none executed. This is engineering source/build completion, not runtime lifecycle certification.

## Builds, static validation and hashes

- `scwfparam`: exit0, AMD64 PE32+, SHA-256 `B4FE13C16C27BC2739EDB6980C12BA11785BE6F0E047AA22BFF2BE9CF6EC858C`.
- `locext`: exit0, AMD64 PE32+, SHA-256 `A84415B9580ED8FDA7AFE846F59C85417D78756A6D213543C188BBD0F5E7EF74`.

Exact commands/logs/actual exits in `<target>-command.json`, `<target>.log`, `<target>.exit_code.txt`. Original generated targets used independently with BuildProjectReferences=false, TrackFileAccess=false and /m:1 after prerequisites were available. No full-solution/Qt/provider/controller rebuild. Initial Windows GetMessage macro expansion broke DataModel::Notifier::GetMessage; the private helper now removes that Windows macro after including windows.h. Initial failed logs and successful pre-category logs are retained. Scientific C4244 warnings remain unchanged in raw logs.

Both PE32+ architectures checked. locext exports createSCPlugin and retains original ADD_SC_PLUGIN and REGISTER_LOCATOR(ExternalLocator,"External"). Provider named imports match selected exports recursively across26 private consumer/provider pairs; exact core/config/client/strong-motion and external dependency graph/hashes plus Windows/API-set/VC-runtime boundary are in artifacts.json. Raw dumpbin headers/imports/exports and build-products.json retained. Static closure does not establish dynamic plugin loading or child execution.

- `P8-WINBACKEND-07F-private-helper.patch`: `0B53EB8D39E0828451241D87F7D54C3CB30B641F148E96142F404BBB647403FF`.
- `P8-WINBACKEND-07F-scwfparam.patch`: `B508ADE77F0294C56A4A21D036D979BDC14230B76D009E8499CCD641BC2A0931`.
- `P8-WINBACKEND-07F-locext.patch`: `D7BFF44CA835C76ECCEC3A4486F3F75AF1EF683B026806DBB491A0CDE7A19AF1`.

source-patches.json records exact pre/post hashes, private helper addition and per-translation-unit patches. Original POSIX implementations reconstruct unchanged after selecting the non-Windows branches (ignoring added blank lines). No scientific algorithms, formats, controller ownership, locator formulas or original licenses modified.

## Preservation, inventory and next work

All282 prior binary/import/export products including nested Tau/SQLite and locnll were archived and hash-verified **to completion before any compilation** in this batch. All remain unchanged, as do1567 protected prior files/stages, all nine frozen HEAD/status/file vectors and installed Boost/status. Frozen superproject9c395c7f00c788c5fc640363abe97b9ced0b44b0, mainf63cde995e04151dc816151359a036b8b15f6019, common92d2202a6065aad36ae7d4a9bf960b6fb91222d2. Existing GUI/controller/database/QC/acquisition/locnll stages,07E filesystem adapter,07E1/07E2 scientific storage patches and earlier process proposal preserved. No stage update or mixed provider revisions.

Historical pre-06C1 config DLL preimage remains **INCOMPLETE**;07A Tau prebuild hash remains unavailable;07E3 archive/build sequencing exception remains recorded. This batch's correct sequencing does not retroactively resolve them. Phase7, unrelated STOP/reload and ew2sc deadline proposal unchanged. Canonical CSV/JSON inventory, status and patch ledger updated to97 built,18 Windows-blocked,1 dependency-blocked,4 disabled.

Next development batch: remaining acquisition mechanical/source-materialization blockers and native scwfas compatibility, with transport contracts kept separate. Future process runtime qualification requires separately authorized isolated fixtures and an explicit bounded-cancellation decision. No further controller or locator feature expansion.

## Gate register (Phase5A template)

| Gate | State | Evidence/exit | Limitation |
|---|---|---|---|
| A: Source + Phase4C evidence | NOT_RUN as full gate | before.json;artifacts.json | Required frozen custody verified; broad audit not repeated |
| B: Transitive dependency closure | NOT_RUN as full gate | two focused builds exit0;artifacts.json | Focused static closure only |
| C: Linux original Autoloc offline oracle | NOT_RUN | None | No oracle/fixture execution |
| D: Windows native original Autoloc offline executable | NOT_RUN | None | No application/plugin/child execution |
| E: Replay equivalence and robustness | NOT_RUN | None | No numerical replay or process runtime/fault tests |

## Linux/Windows fixture and numerical provenance

No scientific inputs consumed; no numerical/association difference matrix computed (all values unavailable, NOT_RUN). Only compilation, linking, source/static inspection and future fixture preparation performed. No network/database/live acquisition or GUI/controller operations.

## Final assessed milestone

Phase5A **PARTIAL**. Two native engineering builds and static qualification complete; scientific parity, dynamic loading and process runtime/cancellation robustness remain unverified.
