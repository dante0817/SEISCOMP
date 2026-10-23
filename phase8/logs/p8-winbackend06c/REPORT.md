# P8-WINBACKEND-06C — cooperative Windows process control

**Agent:** Codex / GPT-6. **Date:** 23 October 2026, Asia/Manila.
**Assessed milestone: PARTIAL engineering; cooperative STOP BLOCKED at conditional contract qualification.**

## Cooperative stop implementation status and approval boundary

No STOP implementation was applied. The operator's Section B requires the full
proposal to pass verification, otherwise stop that part and prepare a precise
amendment. Qualification found no common safe main-loop dispatcher: Client,
Qt, broker reactor and ew2sc use different owner loops. Calling the existing
InterruptibleObject broadcast from an event worker does not marshal to those
loops; System exit writes plain state. Existing Client queue insertion can block
indefinitely on a full queue. The proposed endpoint security, token/session checks,
publication race and listener lifetime are not implemented in 06B. They cannot
be labeled verified. This is a source-contract blocker, not a runtime test failure.

The concrete [contract amendment](control-contract-amendment.md) restricts the
first capability to active Client loops, specifies principal/session/ACL/naming,
collision and publication rules, bounded owner-thread dispatch, acceptance versus
exit observation, cleanup and explicit failures. It removes forced escalation
from STOP. It asks for acceptance of this materially restricted scope before
source changes; other families remain unsupported. No new permission requirement
was inferred from generic caution: the stop condition is the user's Section B.

06A/06B CreateProcessW launch, file locks, receipt/creation/image/file identity,
atomic Job Object launch custody and cleanup are unchanged. Live native stop
still raises ControlProtocolRequired after ownership verification. It sends no
request or termination. Reload returns explicit unsupported on Windows; FDSNWS's
existing POSIX/Twisted/file-acknowledgement contract is preserved in source and
has no approved native delivery adapter. Restart already aborts on stop failure.
Kernel-last ordering and failure aggregation are preserved; no runtime proof is
claimed.

## Gate register (Phase5A template retained)

| Gate | State | Evidence / command / exit | Limitation |
|---|---|---|---|
| A: Source + Phase4C evidence | NOT_RUN as full gate | audit.py before/after, exit 0; Ubuntu-24.04 source-only audit exit 0 | Source custody PASS only; Phase4C raw audit not repeated. |
| B: Transitive dependency closure | NOT_RUN | Prior 06B closures retained | No changed native target; no new Autoloc closure qualification. |
| C: Linux original Autoloc offline oracle | NOT_RUN | No application execution | Out of scope. |
| D: Windows native original Autoloc offline executable | NOT_RUN | No native build/execution in 06C | Prior build milestones unchanged. |
| E: Replay equivalence and robustness | NOT_RUN | No runtime/numerical/scientific testing | No parity or release certification. |

## Exact patches, source and preservation provenance

**Native patches: NONE. Source changes: NONE. New binaries: NONE.**
The two review artifacts and their SHA-256 are:

- control-contract-amendment.md: `E299F2DD3B82E218CF3A1665AECCE78122A1771144B8C10BCB9AE51A7BDD76E3`
- 06d-controller-deployment-scope.md: `FE99B8D5C649AA73722CA229C28152C51303A9F675B91F3C0F9F3EA9C398C9A9`

Full tracked/untracked working-source hashes/status before/after are in
before.json / after.json. All nine frozen Windows repositories retain pinned
HEADs, clean status and full tracked-file hashes (6,971 files). The original
Linux frozen superproject/main/common in Ubuntu-24.04 retain expected HEADs,
clean status and CMakeLists.txt sentinel hashes before/after. Raw source-only
commands/results: wsl-ubuntu24-frozen-before.log and -after.log, both exit 0.
Initial default-distro and explicit Ubuntu probes did not contain these paths;
their failed logs/exits are retained, and are not presented as custody PASS.
No original source was modified through WSL.

813 protected staging/archive/patch files, 204 existing Release build products,
vcpkg package-status hash, CMake cache, and all native working-source bytes/status
are unchanged. See preservation.json and audit-before.log / audit-after.log.
The ew2sc deadline proposal and active source are unchanged and UNAPPLIED.
No dependency, package, service, execution policy, Phase 7 file or existing GUI
staging bundle was changed. Original notices/licenses remain untouched.

## Build/link inventory and exact evidence

**New successful builds: NONE. Builds: NOT RUN**, because no native code or build
configuration changed. No solution rebuild was warranted. Existing configuration
remains VS2022/MSVC 14.44.35207, Release x64. AMD64 PE, provider exports/imports,
recursive static DLL closure and actual build-exit evidence remain the prior
06B records, not new 06C PASS claims. No linker/dependency failure was observed
in this batch because no compilation/link was attempted.

All eight existing 06B artifact SHA-256 values match their 06B build evidence;
exact paths/hashes are in 06c-batch-evidence.json baseline_products. That equality
preserves previous inspections; it does not re-run architecture or closure
validation. Prior raw warnings/failures stay in 06B logs. No new compiler warning
counts or runtime export consistency result are invented.

## Native Python/controller deployment and recommended 06D

The [implementation scope](06d-controller-deployment-scope.md) identifies the
configured CPython 3.10.11 x64 interpreter and conflicting legacy 3.14.2
headers/import library, hardcoded .so/symlink wrapper staging, POSIX py-compile
post-build hook, absent Windows .pyd install/frontend, and module qualification.
Cache line evidence: python-cache-evidence.txt. Preserve the configured 3.10 ABI;
do not enable wrappers against the mixed cache or upgrade dependencies.

Recommended 06D: Windows-only ABI-consistent discovery bridge; original _config
binding build/PE/export/import/closure evidence; configuration-aware .pyd/source
staging and native interpreter frontend; DLL search setup; static per-command
and per-module qualification. 15 handler/base/template source files were
inventoried in module-handler-inventory.json (not an approved module allowlist).
The accepted restricted STOP amendment can then be implemented as a separately
identified prerequisite. Full native management still needs reactor, GUI,
acquisition/ew2sc and Python/Twisted adapters. No operational execution is proposed.

## Updated inventory

**Backend/support: 73/114 already built, 19 available, 14 Windows-blocked,
2 dependency-blocked, 6 disabled. GUI: 11/11 built. New/rebuilt targets: 0.**
The existing build inventory is preserved byte-for-byte and copied into this
batch; the current control/deployment states are recorded in
phase8/inventory/P8-WINBACKEND-06C-control-status.json. 11 GUI bundles still have
the previously documented stale provider copies; refresh remains deferred.

## Reproducible source/static checks

From the phase pack, actual invocations are:

```text
python phase8/logs/p8-winbackend06c/audit.py before
python phase8/logs/p8-winbackend06c/inspect-handlers.py
python phase8/logs/p8-winbackend06c/audit.py after
python phase8/logs/p8-winbackend06c/finalize.py
```

Each command's .log and .exit_code.txt are retained. audit.py before protects
against overwriting its baseline. Syntax compilation (without importing or
executing the controller) and static handler extraction exit 0; source-checks.log
is the raw output. Source locations and hashes: source-evidence.txt and
source-evidence-supplement.txt. Manifest SHA256SUMS.txt records this batch's final
artifacts and updated project documents. No tests attempted network connections;
no application, service, GUI, controller operation, isolation preflight, live DB,
messaging or scientific fixture execution was performed.

## Linux/Windows fixture provenance and numerical difference matrix

No fixtures were consumed, no outputs generated, and no numerical comparisons
were run. These template sections are NOT_RUN for 06C. No synthetic or observed
earthquake results are claimed.

## Evidence gaps, exceptions and final assessed milestone

Cooperative STOP, endpoint ACL/identity/runtime behavior, bounded listener
shutdown, actual process exit under STOP, Python binding import/deployment and
module-specific handlers remain unqualified. Conditional STOP authorization did
not authorize an unsafe generic worker or the material amendment above.
No scientific algorithm patch or dependency change was requested/applied.

**Phase5A PARTIAL; 06C STOP BLOCKED.** The engineering deliverable is a concrete
contract amendment, deployment plan, source/static inventory and preservation
evidence. Numerical/scientific/runtime evidence NOT RUN; release NOT QUALIFIED.
The ultimate complete functional Windows SeisComP objective remains unfinished.
