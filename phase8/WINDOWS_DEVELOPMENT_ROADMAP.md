# Native Windows SeisComP development roadmap

The operator's 08B2 follow-up makes a VM optional for the general development
workflow. Source portability, MSVC builds, original GUI integration, Python
bindings, resource generation and offline packaging continue on the development
host. None of those activities depends on Hyper-V admission.

The existing 08B2 VM-specific runtime authorization is not replaced by that
direction. Actual application, extension, plugin, database, acquisition and
scientific execution still needs an explicitly approved procedure and scope.
A supervised local procedure may be proposed; a VM remains an option when its
isolation is useful or the agreed boundary cannot otherwise be established.

## Implementation sequence

1. Complete independently portable original backend/acquisition targets using
   the existing VS2022/MSVC Release x64 configuration. Preserve framing, timing,
   metadata, algorithms and Linux branches. Archive affected outputs before any
   compilation. Continue independent work when a separate contract/dependency blocks a target.
2. Maintain one coherent Windows development candidate containing the original
   eleven GUI applications, Qt plugins/resources, selected core/client/config,
   database/QC/locator providers, Python hierarchy and scientific resources.
   Older stages remain immutable; new outputs enter a new revision.
3. Provide normal per-user Windows copy-install and process-local environment
   procedures. No Hyper-V dependency, automatic application launch, service,
   production profile, registry or system PATH change.
4. Prepare separately approved supervised local checks, starting with imports,
   file/model access and disposable SQLite. Record real outcomes and loader identities.
   Do not infer network-disabled behavior from a process-local environment.
5. Progress database and core seismic-processing integration using actual original
   interfaces, matching resources and admissible fixtures. Qualify acquisition,
   messaging and operational integration only within their explicit scopes.

## Current remaining work

Use the canonical backend CSV/JSON for actual counts and exact target blockers.
SCREAM TCP/UDP is the current bounded implementation batch. Its ring variant,
Earthworm export, NAQS and WIN transports retain their independent socket/time
contracts. Reftek needs native library-build integration; Q330 needs native
thread/process support. Serial/minilogger/echopro need serial-device contracts;
chain/FIFO need explicit IPC contracts. GDRT's exact Boost.Asio dependency closure
is not provisioned. MySQL, Hypo71/Fortran and iLoc remain disabled/unqualified.

The 08B1 source-only runtime runner has a process-contract conflict: its one-process
job contains a Python probe whose admission check starts PowerShell. Preserve the
exact payload and record a focused orchestration correction before attempting it.
This issue does not block source builds, GUI resource packaging or copy-install work.

Historical pre-06C1 config custody remains INCOMPLETE; the 07A Tau prebuild-hash
and 07E3 archive/build sequencing exceptions remain. No Phase7, controller
STOP/reload, ew2sc deadline, scientific substitution or production change is implied.
Build/package progress is engineering evidence; runtime, science and release
qualification remain separate.
