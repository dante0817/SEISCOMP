# P8-WINBACKEND-06E1 — native Python binding recovery

_core, _system and _logging build PASS (actual exit 0), AMD64 PE32+, correct PyInit exports/python310.dll imports, matching provider exports/imports and recursive private DLL closure. Existing Time ostream declaration/SchemaStructExtent export annotations and explicit original NumericArray TypeInfo instantiations repair ten missing exports. All former core exports preserved. Windows-only SyslogOutput exclusions align generated C++/Python bindings to the original native provider; original POSIX code preserved, no SWIG regeneration, stub or destination mapping. No algorithm/type/layout/serialization change.

Separate controller-06e1-native stage uses 06E baseline, three original extensions/Python sources and matching refreshed core DLL. Existing controller/frontend/_config/launch/locking/restricted STOP unchanged. No modules activated or controller guards lifted. Inventory 79/120 built (original backend 73/114; six completed controller targets), 19 available, 14 Windows-blocked, 2 dependency-blocked, 6 disabled; GUI 11/11 unchanged. All 207 pre-build Release products archived before build; changed provider products recorded in preservation.json. Historical config DLL preimage custody remains INCOMPLETE. Runtime/science NOT RUN; release NOT QUALIFIED. Exact patch SHA-256 4D401EF2087070E0C57CAC083ACD3ADE06B098E12338C1F5382F4946575BAEFE. Details: phase8/logs/p8-winbackend06e1/REPORT.md.

## Results and provenance

VS2022/MSVC Release x64, CPython 3.10.11, original SWIG 4.4.1 generated sources retained with localized conditional edits only. No dependency upgrade. Each target's *-command.json, .log and .exit_code.txt retain actual compiler/linker results and warnings. artifact-evidence.json and artifacts/ contain per-file PE/import/export dumps, SHA-256, all named private-import consistency checks and recursive Windows/API-set/runtime-boundary closure. No extension imported. provider-symbols.json lists the exact ten decorated symbols; before/after DLL exports, current import-library and original compiled object symbol logs demonstrate ownership by seiscomp_core, original definitions and intact old exports. Generated project includes datetime.cpp, typedarray.cpp and schema.cpp. datetime.h lacked the Time export annotation, schema.h lacked SchemaStructExtent export annotation, and inline template TypeInfo methods needed explicit exported instantiation. Original bodies and layouts unchanged.

Windows SyslogOutput constructor/method wrappers, method registrations and upcast are excluded along with its Python shadow class. No fake API and no alternative sink. Remaining original functions/file/FD/rotation outputs are preserved. Platform projection checks verify original POSIX generated C++/Python surface; byte preimages and batch patch/source hashes are retained. Matching SWIG regeneration was unnecessary. Existing unavailable Windows syslog remains unavailable.

## Staging and remaining work

New stage: phase8/staging/controller-06e1-native. All three valid extensions and original Python wrappers copied with refreshed matching private providers; pre-existing binary hashes retained except core DLL. Source capabilities, configuration paths/data/examples and external Python prerequisite retained. Baseline manifests are explicitly historical. SHA256SUMS.txt covers current stage files; dependency/ABI manifest is share/controller/deployment.json. Static closure does not validate dynamic plugin loading or runtime ABI behavior. Existing 06D/06E and all GUI stages unchanged; no release/relocatable claim. print variables/setup/update-config guards remain for the next focused configuration integration; wider STOP/reload, DB, scheduler and aliases remain separate contracts.

## Custody and gates

before.json / binary-before archive all 207 active Release products and import libraries before rebuilding. preservation.json/log records frozen HEAD/status/hash vector, protected prior stages/patches, 06C1 exact sources and installed dependency status. Exact pre/post hashes for changed providers retained; historical pre-06C1 config DLL custody gap INCOMPLETE, never repaired by current archival. WindowsPython310, _config, native frontends and launch/locking/STOP untouched. No Phase7 or ew2sc proposal changes.

| Gate | State | Evidence / limitation |
|---|---|---|
| A: source/Phase4C | NOT_RUN as full gate | Focused source custody PASS; no Phase4C reaudit |
| B: dependency closure | NOT_RUN as full gate | Three binding engineering static closures PASS; no full scientific/plugin claim |
| C: original Linux oracle | NOT_RUN | No fixture/application run |
| D: native original offline Autoloc | NOT_RUN | No application execution |
| E: parity/robustness | NOT_RUN | No origins, numerical measurements or runtime tests |

Phase5A PARTIAL. No fixture consumed or numerical difference values generated. No frontend/controller/application/GUI, extension import, database/network, broad functional/scientific test or blocked preflight executed. Build/compiler tools, dumpbin and source/file tooling only. Next phase: narrowly authorize configuration-model import/frontend integration and qualify pure configuration commands before lifting guards; retain broader platform contracts separately. Runtime/science NOT RUN; release NOT QUALIFIED.

| Binding | Exit | SHA-256 |
|---|---:|---|
| _core | 0 | 918357A7A4D3A3BAF0D4AABCDBC5DA0BBBF97E613C1AA18B38430E422ADC24DD |
| _system | 0 | DD6AAA1AD3AF0789C58403AAE440B88A44402A1B91C9308802DD0BBD2EC30F21 |
| _logging | 0 | E1E9F6C35CFAB0C8CFC16C27F5D915130F30DD8D11B95E1C052568A716997583 |

Final source checks: finalize-final.log (exit 0) verifies original POSIX projections, all ten decorated exports/import-library symbols and preserved old exports. The initial finalize.log (exit 1) is retained: the reused projection helper did not handle whitespace in generated SWIG preprocessor directives. The harness was corrected; product source/build changes were not needed. No compiler/linker failure occurred in this recovery batch.
