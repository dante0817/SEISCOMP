# P8-WINBACKEND-06C1 — approved restricted Client STOP implementation

**Agent:** Codex / GPT-6. **Date:** 23 October 2026 (Asia/Manila).
**Engineering milestone: restricted Client STOP source and build integration COMPLETE;
runtime qualification NOT RUN; one active-prerequisite preimage custody gap.**
VS2022/MSVC 14.44.35207, Release x64. CMake regeneration selected installed
Windows SDK 10.0.28000.0 (recorded in the raw core log); no SDK/package was installed.

## Implemented capability and authorization

Operator approved the exact 06C amendment SHA-256
`E299F2DD3B82E218CF3A1665AECCE78122A1771144B8C10BCB9AE51A7BDD76E3`.
No additional design approval was requested. The approved scope is implemented:
explicit Windows pre-exec opt-in, endpoints only inside the initialized active
Client run loop, distinct WindowsStop notification, nonblocking queue commit versus
cancellation, owner-thread original termination broadcast, and joined listener
lifetime nested before done/queue/application destruction. No Application data
member or vtable addition. Linux active-source projections match preimages.

The first enrolled executable is **scautoloc**, by a Windows-only entrypoint call.
Its original algorithms and app.cpp are unchanged. Owner dispatch invokes the
original InterruptibleObject termination path so application exit and registered
messaging I/O wakeups both occur on the owner thread. The event listener never
calls Application, InterruptibleObject, Qt/reactor APIs or application setters.
The original shutdown/done path remains responsible for actual completion.

Native core support creates two new manual-reset nonsignaled, noninherited
Local events named from actual PID and creation FILETIME. Explicit protected
DACLs allow only the user SID and SYSTEM. Owner/DACL, token ownership, primary
token/session/integrity/elevation and impersonation policy are verified; collisions
are refused. Supported policy is a non-elevated medium-integrity user-owned
primary token in a nonzero client session. Same-SID code remains trusted; no
protection against hostile code running under that SID is claimed.

Controller holds the existing module guard, replacement-protected PID file,
write/delete-protected receipt and verified process handle through the request.
Root/module/file-ID/PID/creation/image and token/endpoint security are checked.
StopAccepted means queued, never exited. Same-handle actual exit is observed;
original DWORD status is preserved in reporting/errors. Distinct unsupported,
not-ready/unavailable, access/identity/security denial, acceptance timeout,
shutdown timeout, already-exited and nonzero/crash outcomes are implemented.
No PROCESS_TERMINATE right, forced-stop escalation or generic reload/HUP.

Cleanup verifies actual receipt/process exit even if the PID lock has already
become free, then removes run/receipt metadata under the guard and exclusive
free-file lock. PID inode stays. Existing launch, Job Object custody, file-lock,
kernel-last order, aggregate errors and restart-abort logic are preserved.

Detailed source contract, outcome matrix and timing/lifetime rationale:
[implementation-contract.md](implementation-contract.md). Module-guard acquisition
is bounded at 10 seconds; readiness/ack share 5 seconds; actual exit gets the
existing finite killTimeout. Listener retry is bounded at 5 seconds and its
cancellation wait slices at 20/10 ms. Thread completion depends on OS scheduling;
join always preserves resource lifetime. No hard-real-time guarantee or bounded
completion of arbitrary original application shutdown is claimed.

## Exact patches and provenance

| Patch in phase8/patches | SHA-256 | Source scope |
|---|---|---|
| providers | `89BA4A035B615677A352B50D8595D525CA672AC16D15409D8157E99CD7112FF9` | 11 files |
| scautoloc | `B14DD325B7550E02925C3558E17A1831C2025A5D35D4E95DBA7150CA9E0E193D` | 1 files |
| controller | `E14CFC92AF73CC6D787803CB0BE48749F3B790642875ACC13AD4925E758BA8BF` | 1 files |

All three final patches pass reverse applicability checks, actual exit 0.
`applied-patches.json` records commands, exact 13-file source pre/post SHA-256,
and new-file provenance. Preimages are retained separately. Native additions
retain AGPLv3/commercial provenance references; all original notices are preserved.
No scientific source patch, dependency upgrade or distribution claim.

## Focused build/link inventory

Core's command/output/exit use `seiscomp_core-command.json`, `.log` and
`.exit_code.txt`. Client and scautoloc final artifact commands/output/exits use
`<target>-final-command.json`, `<target>-final.log` and `<target>-final.exit_code.txt`;
initial complete build logs/exits are retained too. The final incremental compile
forces the one-shot capability refinement through compilation and relinks its
executable consumer; the timestamp-only refresh preserves source bytes and is
documented in incremental-rebuild-source.json. No ALL/full-solution
build or SeisComP execution was requested.

| Target | Actual build exit | Architecture | Artifact SHA-256 |
|---|---:|---|---|
| seiscomp_core | 0 | AMD64 PE32+ | `F999BA19BCB03F63E289B46D7BF8A04E320EFF1331E7BDAFA1D52A2051A15346` |
| seiscomp_client | 0 | AMD64 PE32+ | `6632B40494EDBEF3ACCD1CBED6DBBACFA563DB4D72794B8688B29B818A73A349` |
| scautoloc | 0 | AMD64 PE32+ | `1407046F87DC86EF29604A860B50B8DBDA397A6481B78E2980CA47A352AFD4CD` |

The required `seiscomp_config` prerequisite also rebuilt within the successful
core command (not a separate requested target). Its AMD64 PE32+ SHA-256 is
`62D55F2FA42D19A0730D37E2CE5056B4ACF9E31F7451A769B7A721831749D77F`; it is included in recursive import/export inspection. No config
source was edited. See the custody exception below for its missing old active DLL.

All three artifacts pass recursive static private DLL closure to the Windows/API-set
boundary. Dumpbin headers/imports/exports/dependents and resolution manifests:
`artifacts/<target>/inspection.json` and adjacent raw logs. Named private imports
match their provider exports. New core WindowsStopEvents exports, Client opt-in
and queue exports, and scautoloc's opt-in import are present. Every pre-batch
core/client export is retained. Optional runtime-loaded plugins and Windows/API-set
implementation resolution remain outside this static closure boundary.

Warning occurrence counts, including repetitions, are in 06c1-batch-evidence.json.
Existing DLL-interface/conversion/precision/hostinfo warnings remain unsuppressed;
private PIMPL DLL-interface warnings are retained where emitted. Counts are not unique
defect counts. An evidence-script Windows path-key lookup failure is retained in
source-checks-manifest-initial.log (exit 1); the corrected final checker exits 0.
The initial finalizer also failed on a Windows-default decoding of an existing
UTF-8 document; finalize-initial.log (exit 1) is retained, and the corrected
finalizer uses explicit UTF-8. These script errors are not native compiler
failures. No skipped
runtime check is called PASS. Python controller syntax compiles without importing
it. Bindings remain OFF, so no native Python controller operation is claimed.

## Supported versus unsupported families

Only explicitly opted-in applications actively in the qualified Client run loop
have the capability; only **scautoloc.exe** is enrolled now. The Windows controller
table uses canonical root/bin or root/sbin paths solely for capability diagnostics,
never as an authorization token. Non-opted Clients, generic System, Qt, broker,
ew2sc, acquisition supervisors and Python/Twisted remain unsupported. FDSNWS's
existing reload contract remains intact in source with native delivery unsupported.
No inheritance-based automatic exposure or generic Windows SIGHUP was introduced.

## Updated inventory and preserved baseline

**Backend/support: 73/114 built; 19 available, 14 Windows-blocked,
2 dependency-blocked, 6 disabled. GUI: 11/11 built. New targets: 0.**
Four existing inventory rows (three explicit targets plus config prerequisite)
are refreshed after successful build/inspection.
Current capability/deployment state is in
`phase8/inventory/P8-WINBACKEND-06C1-control-status.json`; batch inventory is copied
locally. Existing GUI staging is not refreshed and retains previously documented
stale providers.

Nine frozen Windows snapshots retain expected HEADs, clean status and sentinel
hashes before/after. Original Ubuntu-24.04 frozen superproject/main/common also
retain exact expected HEAD, clean status and sentinel hashes; source-only raw
logs and exits are wsl-frozen-before/after. Protected archives/staging/prior
patches, vcpkg package status, ew2sc active source/proposal and 06D deployment
scope are hash-verified unchanged. Seven of eight changed existing build products
have verified pre-batch archives; the remaining active config DLL is the explicit
exception below. Evidence: baseline.log, before.json, preservation.log,
preservation.json. No operational installation, service, live database, messaging,
network test, isolation preflight, Phase 7 governance or package/security policy
was modified or executed.

### Custody exception — prior active config DLL unavailable

The CMake dependency rebuild replaced active `seiscomp_config.dll`, which was
outside the immediate pre-build copy set. Its pre-batch hash was
`1F3364FDDFEFC5F3EB4E72FFD8C3F21BAC26C27788684CE5B12B077237C824F8`;
the new hash is `62D55F2FA42D19A0730D37E2CE5056B4ACF9E31F7451A769B7A721831749D77F`. Exact-hash recovery from existing project archives
was unsuccessful. No prior protected archive was overwritten, and the active
new DLL was not rolled back or fabricated. **Active build preimage custody is
INCOMPLETE**, separate from frozen/protected-archive custody PASS. Original
config sources were not patched; current linking and recursive inspection pass.
The raw initial failed audit and recovery attempts remain preservation-initial.log
(exit 1), archive-recovery.log (exit 1) and prerequisite-archive-recovery.json.
The final audit exits 0 because it completed and explicitly records this gap,
not because the missing-preimage gate passed. Before future provider builds,
archive all providers that CMake can rebuild transitively, including config.

## Reproducible static evidence and remaining runtime qualification

Source-only commands (from phase pack):

```text
python phase8/logs/p8-winbackend06c1/batch.py before
python phase8/logs/p8-winbackend06c1/batch.py build seiscomp_core seiscomp_client scautoloc
python phase8/logs/p8-winbackend06c1/batch.py build-final seiscomp_client scautoloc
python phase8/logs/p8-winbackend06c1/check-sources.py
python phase8/logs/p8-winbackend06c1/batch.py patches
python phase8/logs/p8-winbackend06c1/inspect-artifacts.py
python phase8/logs/p8-winbackend06c1/batch.py after
python phase8/logs/p8-winbackend06c1/finalize.py
```

Raw script logs/exits are retained; final source checks and patches have separate
`*-final` logs after source refinement. Static PASS evidence covers Linux source
projection preservation, Python syntax, unchanged 06B launch/lock/job AST,
listener/queue call policy and source security checks. It is not a concurrency,
ACL enforcement or lifecycle runtime result. No mocks or fabricated outputs.

**NOT RUN:** live owner-thread STOP dispatch, full/closed queue and cancellation
stress, actual ACL/token denial, collision/partial-publication races, PID reuse,
ack/exit timing, nonzero exit/timeout retention, early lock release and restart.
No SeisComP application, service, controller operation or scientific replay ran.

## Next recommended P8-WINBACKEND-06D batch

Keep `phase8/logs/p8-winbackend06c/06d-controller-deployment-scope.md` unchanged:
resolve legacy 3.14 headers/import library against configured CPython 3.10.11 x64,
preserve that ABI, build/stage original _config.pyd with matching providers,
replace .so/symlink/py-compile and shell frontend paths on Windows, establish DLL
search, and qualify commands/module handlers in isolated staging. Do not enable
wrappers against the mixed cache. This batch does not upgrade dependencies or
deploy/run an operational controller. Broader STOP families and FDSNWS native
reload still require their own scoped work. ew2sc deadline patch stays unapplied.

## Phase5A gate register and fixture/numerical evidence

| Gate | State | Evidence / limitation |
|---|---|---|
| A: Source + Phase4C evidence | NOT_RUN as full gate | Focused source custody PASS with raw logs; Phase4C raw audit not repeated. |
| B: Transitive dependency closure | NOT_RUN as full gate | Three focused static DLL closures PASS; full Autoloc closure gate unchanged. |
| C: Linux original Autoloc offline oracle | NOT_RUN | No application/fixture execution. |
| D: Windows native original Autoloc offline executable | NOT_RUN | Original scautoloc links natively; offline/scientific operation not revalidated. |
| E: Replay equivalence and robustness | NOT_RUN | No numerical, fixture, scientific or runtime testing. |

No fixtures were consumed; no Linux/Windows origin outputs or numerical-difference
matrix entries were generated. **Final assessed milestone: Phase5A PARTIAL.**
06C1 restricted engineering source/build implementation complete; runtime and
scientific evidence NOT RUN; release NOT QUALIFIED. Full functional Windows
SeisComP and deployed native management remain unfinished.
