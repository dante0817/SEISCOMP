# P8-WINBACKEND-06E — concise implementation report

**23 October 2026; Windows x64 / MSVC 19.44 Release / CPython 3.10.11. Phase5A PARTIAL.**

Windows enable/disable/status now validate selections, aggregate failures/exceptions, verify marker postconditions and report required-but-stopped status as failure. Existing check/print env and launch/STOP/restart are preserved. Python/C++ user config selection is aligned through explicit SEISCOMP_LOCAL_CONFIG. Narrow original _core/_logging/_system CMake targets implemented; all three builds FAIL (exit 1): five missing core exports, unavailable SyslogOutput wrappers, five missing SchemaStructExtent exports respectively. No new binding built; no placeholder implementation or provider/algorithm changes. Exact symbols and focused UNAPPLIED follow-up requirements: logs/p8-winbackend06e/binding-blockers.json and follow-up-contracts.md.

Separate controller-06e-native stage preserves all 20 original PE products and adds corrected controller source/capabilities/manifests. No additional handlers activated or runtime qualification. Inventory 76/120 built (original 73/114 plus three completed 06D targets; three newly enumerated 06E blocked targets), 19 available, 17 Windows-blocked, 2 dependency-blocked, 6 disabled; GUI 11/11 unchanged. All 207 active Release preimages archived/hash-verified; no existing Release product changed. Frozen/protected/06C1 source preservation PASS. Historical config DLL custody remains INCOMPLETE. External Python310 required; runtime/science NOT RUN; release NOT QUALIFIED. Patch SHA-256 1FA5820AE435BB5F2C372ED08A5BF9B1760185800BED7117FC846CD1E3B3DB6F. Evidence: phase8/logs/p8-winbackend06e/REPORT.md. Phase5A PARTIAL.

## Binding results and blockers

| Original binding | Actual result | Evidence |
|---|---|---|
| _core | FAIL, exit 1; LNK1120: 5 | _core.log: Time ostream operator, NumericArray<char/int/float/double>::TypeInfo absent from core imports |
| _logging | FAIL, exit 1; compilation | _logging.log: generated SyslogOutput surface refers to class excluded by native Windows header |
| _system | FAIL, exit 1; LNK1120: 5 | _system.log: SchemaStructExtent ClassName/className/TypeInfo/typeInfo/serialize |

No new extension has a valid success/PE/PyInit/ABI/closure claim. All original generated SWIG files remain byte-identical to frozen source; no stub or surrogate was added. system.py imports core, logging and config; only these bindings are selected, no NumPy/general-wrapper expansion. configure.log records successful configuration. Exact build/configure arrays are in *-command.json. WindowsPython310.cmake, narrow option, _config and frontends are preserved.

## Configuration helpers, commands and handlers

Windows enable/disable/status now reject unknown requests, report exceptions and underlying errors, preserve unsupported enable hooks, refuse core-module enable/disable, and verify actual filesystem marker state. Status returns failure when a required module is stopped. check and print env retain the completed 06D behavior; restart abort and restricted scautoloc STOP are untouched. Local configuration path propagation aligns the Python controller with the original C++ Environment while preserving explicit user selection and original parsing/root behavior.

The 17-command/15-handler plus scmaster supplement matrix is in capabilities.md/json, using the requested four classifications. No newly operational handler is claimed. Configuration-model helpers remain dependency-blocked; setup/update-config and print variables retain explicit errors. DB/shell administration, aliases, scheduling, generic reload and broader STOP remain separate contracts. follow-up-contracts.md provides focused actionable provider-export and platform-conditional SWIG requirements, UNAPPLIED.

## Preservation, staging and provenance

before.json and binary-before/ preserve all 207 current Release products before configuration/build. preservation.json/log show nine frozen repositories at matching clean HEAD/status/hash vector, protected files and 13 exact 06C1 sources unchanged; no existing Release product changed. Historical pre-06C1 config DLL preimage gap remains INCOMPLETE, not recovered. Patch exact hashes/preimages/reverse-check are in applied-patches.json; source checks prove unchanged non-Windows controller AST, unchanged process-control/check/print functions, and original generated wrappers. No scientific source edited, dependency upgrade, Phase7 change or ew2sc deadline application.

New staging/controller-06e-native contains all preserved 06D native binaries/providers and external Python identity/prerequisites, corrected controller, existing data/config paths, updated capabilities/dependency manifest and SHA256SUMS.txt. No failed binding is installed. All 20 staged PE files match 06D's statically inspected products; no new PE closure claim substitutes for failed builds. Preserved 06D deployment evidence is clearly named 06D-deployment.json. Existing 06D/GUI stages are unchanged. Runtime-loaded plugins/data closure and relocatability remain unqualified.

## Gate register and scientific evidence

| Gate | State | Evidence / limitation |
|---|---|---|
| A: source + Phase4C | NOT_RUN as full gate | Focused source custody PASS, preservation.json/log; Phase4C not repeated |
| B: dependency closure | BLOCKED for added bindings | Three actual build failures, exact symbols in binding-blockers.json; preserved baseline static closure only |
| C: Linux original oracle | NOT_RUN | No fixture/application execution |
| D: Windows original offline Autoloc | NOT_RUN | No application execution |
| E: parity/robustness | NOT_RUN | No origin outputs/numerical measurements, runtime or scientific test |

No fixtures consumed; no numerical difference matrix values generated. No controller, SeisComP application, extension import, GUI/service, DB/network, scientific replay or blocked network preflight executed. Source compile/AST checks are structural engineering evidence only. Existing scientific/data/sanitizer questions remain unchanged. Report every build as failed, not skipped/PASS.

## Recommended next phase

Resolve the existing core/schema export ownership and define Windows logging SWIG surface per follow-up-contracts.md, then rebuild only the three bindings and inspect successful exports/imports/closure before staging. Keep module configuration/DB and externally visible platform contracts scoped separately. Runtime integration still requires separate authorization. Full native SeisComP functionality remains unfinished.
