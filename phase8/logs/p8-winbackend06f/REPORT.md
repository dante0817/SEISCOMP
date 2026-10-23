# P8-WINBACKEND-06F — concise engineering report

Original print variables path enabled through recovered System bindings. Explicit --stdin setup kernel now uses the original filesystem-only kernel setup handler, validates selection before any action, propagates read/parse/write failures and does not mark the entire installation initialized. Original Config parsing/key/removal behavior retained. No interactive/kernel schema fabricated; setup all/mixed/service handlers and update-config remain explicitly guarded with exact dependency reasons. Kernel description metadata added unchanged. Original installation root, local-config override and six-stage C++ configuration precedence are preserved. Management aggregation/launch/ownership/Job Objects/restricted STOP unchanged.

New controller-06f-native stage preserves 23 matching 06E1 PE products, package/configuration/data paths and pinned external Python3.10 prerequisite, with current source graph/capabilities/dependency/SHA manifests. No binary compilation required; inventory remains 79/120, GUI 11/11. All 207 active Release providers/import libraries archived and unchanged; frozen/protected baselines preserved. Historical config-DLL custody INCOMPLETE. Patch SHA-256 41082DCD396568940445F27A65AFCFF38A453E8372CA96A1702F282222A49D4F. Runtime/scientific NOT RUN; release NOT QUALIFIED. Report: phase8/logs/p8-winbackend06f/REPORT.md. Next work should move to backend acquisition/quality-control/database closure, not indefinite controller expansion.

## Configuration integration and command qualification

Selected source graph: core -> _core; logging -> _logging; config -> _config; system -> _system plus original core/logging/config Python modules. kernel/setup/shell use original config and stdlib. python-dependencies.json lists source SHA/import relationships without any module execution. No dummy imports or replacement parsers. All original SWIG interfaces/binaries retained. System::Environment uses SEISCOMP_ROOT and the prior explicit SEISCOMP_LOCAL_CONFIG alignment. Its original initConfig merges defaults global/app, application global/app, then selected user global/app, respecting its standalone and stage-range options. No precedence code changed. Kernel Environment intentionally retains its original etc/kernel.cfg-only management-config semantics.

print variables now falls through to original System::Environment reporting; import/operation failures remain errors. PowerShell print env and completed enable/disable/status/check/start/restart functions remain byte-equivalent at AST level. Kernel setup is explicitly selected with the original CLI flag order: --stdin setup kernel. It reads original Config stdin syntax; invokes only the installed original kernel handler; uses original kernel.global.organization key and missing-key removal behavior. Malformed existing kernel.cfg fails before writing, explicit filename writes report false/exception as failure. No global seiscomp.init marker is created for a partial setup. Kernel XML is the unmodified original configuration schema and contains no interactive setup groups, so interactive setup remains rejected. No new schema or user-input substitution.

update-config remains unsupported: global.py imports bindings2cfg, whose Client/DataModel/database operations are not included; scmaster administers databases through shell; access/scinv/scevent and acquisition helpers need additional proxy/service/supervisor operations. The kernel/default template base update methods do no work, so they are not offered as successful configuration updates. Matrix covers all 17 commands/15 handlers plus scmaster supplement. No extra operational handler activated. DB/shell/scheduler/aliases/wider STOP/reload remain explicitly separate contracts.

## Staging, provenance and verification

Stage: phase8/staging/controller-06f-native. Metadata repair adds unchanged original etc/descriptions/kernel.xml. Current Python controller/kernel sources, four extensions, frontends/providers, configuration/data paths, capability/dependency/ABI manifests and complete file SHA256SUMS retained. All 23 PE hashes match 06E1's statically qualified products; no new PE claim or repeated build. The external Python310 home/Lib/DLLs/executable remains required. Optional runtime-loaded plugins/model data and external service closure remain unqualified. Historical manifests are named by baseline; current deployment.json reflects this stage.

before.json / binary-before archive 207 active Release products; preservation.log/json confirms exact frozen revision/status/hash vector, protected prior files, 06C1 sources and installed dependency status. No provider changed; no need to compile the Python-only edits. applied-patches.json has exact two-file before/after hashes, final batch patch and reverse-check exit 0. Finalize verifies Linux AST preservation for both changed sources, unchanged management/process-control ASTs, syntax compilation only, source import graph and all preserved PE hashes. Raw finalize.log/exit and seal.log/exit record actual outcomes. Inventory remains 79/120; 19 available, 14 Windows-blocked, 2 external-dependency-blocked, 6 disabled; GUI 11/11. No scientific source edits, Phase7 changes, dependency upgrades or ew2sc proposal application. Historical pre-06C1 config DLL custody remains INCOMPLETE.

## Gate register and limits

| Gate | State | Evidence / limitation |
|---|---|---|
| A: source/Phase4C | NOT_RUN as full gate | Focused custody PASS; Phase4C not repeated |
| B: dependency closure | NOT_RUN as full gate | Source graph/staged binary hash checks only; inherited static PE evidence |
| C: original Linux oracle | NOT_RUN | No fixture or application run |
| D: original native offline Autoloc | NOT_RUN | No application execution |
| E: replay/robustness | NOT_RUN | No origins/numerical measurements or scientific replay |

Phase5A PARTIAL. No frontend/controller/application/GUI or runtime extension import; no network/DB/operational system, broad tests or scientific replay. No fixture consumed or numerical difference values produced. Structural checks do not demonstrate successful runtime setup/import/model behavior. Runtime/scientific NOT RUN; release NOT QUALIFIED.

## Next implementation priorities

Move to the remaining core backend work: focused builds of seiscomp_qcplugin and the ten quality-control plugin targets, then scardac and acquisition helpers from the existing unbuilt inventory. Close explicit acquisition transport/platform blockers independently, followed by native database connector/dependency closure. Keep broad protocol/supervisor and scientific changes scoped separately. Defer controller expansion beyond targeted fixes; any runtime/import/lifecycle qualification requires separate authorization and an admissible isolated boundary.
