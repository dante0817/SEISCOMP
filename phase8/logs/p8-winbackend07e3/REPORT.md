# P8-WINBACKEND-07E3 — Native locnll build completion

**Original locnll built, exit 0. Backend95/120; GUI11/11.** Remaining20 Windows-portability blocked,1 dependency-blocked,4 disabled. 23 October 2026; existing VS2022/MSVC19.44 Release x64 configuration.

## Corrections and provenance

Verified reviewed patch SHA-256 `CD5E32FBDAC77609D7C72DBC98117882E9890BE1476182CF9F8534175C9F5028` and wrapper preimage `948B566562368202A1B4F65C854E12B4DA88C929ECCB05C2BFA4A63A07167367`. Git applicability, application and reverse-check returned0; raw operations in applied-patch.json. The exact Windows-only early iomanip include is applied before the original extern C NLL block; later include remains. Projection tm function, declarations and calculations unchanged. First postimage `58049142117D538BDF8514AA09D0685A4D94C6BC43E6A50F39BE91653095456C`.

Next compiler failure was fmt C2338 at core.h:1594: narrow logging macro arguments received const wchar_t* from std::filesystem::path on Windows. Instantiation points to nll_locator.cpp:496 and the analogous DEBUG call. Localized Windows-only macro-call branches now pass tableDir.string().c_str() for these two diagnostic messages; original POSIX calls stay intact. No actual filesystem path, file selection, scientific calculation or interface is altered. Narrow diagnostic encoding remains subject to standard path conversion behavior; no Unicode runtime qualification is claimed.

Separate patch `P8-WINBACKEND-07E3-nll-path-log.patch` SHA-256 `C97E7A165254A996E730F514F513BB63353463EE447B451D8FC0B1EE7DFAE251`; preimage `58049142117D538BDF8514AA09D0685A4D94C6BC43E6A50F39BE91653095456C`; final wrapper `898AE1C7A36FA22D51C0F90C39261B4F242CBA6D7229EF11F15A1B04A13819F3`. Final reverse-checks pass for both patches, and structural comparison selecting non-Windows branches reconstructs the original wrapper excluding blank lines. Initial misplaced preprocessor directives inside logging macro arguments caused C2121; corrected by branching entire macro calls. Failed raw logs retained as locnll-before-path-log.log and locnll-invalid-macro-directives.log; no failed attempt counted as built.

## Build/link evidence

Final exact command/raw output/actual exit: locnll-command.json, locnll.log, locnll.exit_code.txt. Focused existing target only; qualified core/config reused, no solution/Qt/controller/provider rebuild. Existing TrackFileAccess=false workaround and BuildProjectReferences=false preserved. Prior tm parser errors and path-format errors are absent from final exit0 build. No remaining compiler/linker blocker for this target.

- locnll.dll: AMD64 PE32+, SHA-256 `F7516CAEE225E205B44D18DEFC311617DD4653E4C89BFFD86771F0D699515520`.
- Original createSCPlugin export verified; ADD_SC_PLUGIN and REGISTER_LOCATOR(NLLocator,"NonLinLoc") retained at source/build level. No dummy registration or actual dynamic loading claim.
- Recursive static private DLL closure passes; named imports match selected exports across17 private consumer/provider pairs. Core/config, transitive installed native dependencies and Windows/API-set/VC-runtime boundary recorded in artifacts.json with raw dumpbin headers/imports/exports logs.
- build-products.json records exact DLL/import-library/export-file hashes. Source pre/post/reverse evidence is recorded separately. No successful runtime or numerical evidence inferred from static checks.

## Preservation and limitations

Pre-build hashes were captured and279 previous binary/import/export outputs, including nested Tau/SQLite and all completed providers, were archived. **Sequencing exception:** archive copying overlapped the first focused compilation instead of being awaited to completion. No prior provider target rebuilt, and final verification confirms every prehash, archive copy and current prior output matches; no lost preimage or retroactive recovery claim. This exception is recorded explicitly rather than describing archive completion as preceding all compilation.

All1503 protected files/stages and nine frozen HEAD/status/file vectors unchanged. Frozen superproject9c395c7f00c788c5fc640363abe97b9ced0b44b0, mainf63cde995e04151dc816151359a036b8b15f6019, common92d2202a6065aad36ae7d4a9bf960b6fb91222d2. Approved07E filesystem adapter/restrictions,07E1 matrix storage,07E2 six double arrays/per-call fatal status and original POSIX source remain preserved. Historical pre-06C1 config DLL preimage remains INCOMPLETE;07A Tau prebuild hash remains unavailable. Existing GridLib uninitialized-parrivals warning remains unsuppressed in prior raw evidence; not fixed or certified safe.

No application/plugin/GUI/controller execution, numerical/scientific replay, network/database access, dependency upgrade, Phase7 change or lifecycle implementation. Completed39 adapter checks were not repeated. Prior matching stages untouched; no mixed provider revisions staged. ew2sc deadline proposal remains unapplied. Filesystem locale/path limits and scientific/runtime robustness remain unqualified.

## Inventory and next priority

Canonical CSV/JSON, implementation status and patch ledger updated:95/120 built,20 Windows-blocked,1 dependency-blocked,4 disabled; GUI11/11. Move next to the existing scwfparam/locext native process-lifecycle proposal, especially explicit interpreter/PATH/handle/wait/cancellation contracts. No further locator feature expansion needed for this engineering milestone.

## Gate register (Phase5A template)

| Gate | State | Evidence/exit | Limitation |
|---|---|---|---|
| A: Source + Phase4C evidence | NOT_RUN as full gate | before.json;artifacts.json | Frozen preservation checked; Phase4C not repeated; sequencing exception above |
| B: Transitive dependency closure | NOT_RUN as full gate | locnll build exit0; artifacts.json static closure | Focused plugin only; full-install/runtime closure unqualified |
| C: Linux original Autoloc offline oracle | NOT_RUN | None | No replay |
| D: Windows native original Autoloc offline executable | NOT_RUN | None | No application execution |
| E: Replay equivalence and robustness | NOT_RUN | None | No numerical comparison/fault injection |

## Linux/Windows fixture and numerical evidence

No scientific fixture consumed. Numerical difference matrix: not run; Linux/Windows origins, origin-time/epicenter/depth and association differences unavailable. Source/build evidence does not establish scientific parity.

## Final assessed milestone

Phase5A PARTIAL. Original native locnll engineering build/static qualification complete; dynamic loading, numerical/scientific parity and release qualification remain unverified.
