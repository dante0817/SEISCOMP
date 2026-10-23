# P8-WINBACKEND-07E1 — NLL array storage port

**PARTIAL: matrix VLA correction compiles; locnll build exits 1.** Backend remains **94/120 built**, GUI 11/11; 21 Windows-portability blocked, 1 dependency-blocked, 4 disabled. No SeisComP application, science replay, network/database or GUI/controller execution. 23 October 2026.

## Exact storage review and result

| Routine | Original declaration/count | Applied result |
|---|---|---|
| matrix_double_check_diagonal_non_zero_inverse | int inon_zero[i_original_size] | Windows checked malloc/free, compiled AMD64 COFF |
| CalcAzimuthGap | double azimuths[MAX_NUM_ARRIVALS] | Unchanged pending failure-propagation scope; proposed port prepared |
| CalculateVpVsEstimate | double p_time, p_error, s_time, s_error, weight arrays, each [MAX_NUM_ARRIVALS] | Unchanged pending failure-propagation scope; proposed port prepared |

The applied matrix allocation retains int elements and the exact runtime i_original_size. It validates positive size and count <= SIZE_MAX / sizeof(*inon_zero), then mallocs without initialization. This occurs before matrix access so invalid-size/allocation failures use the existing error_message/-1 mechanism safely. The original tolerance calculations, diagonal tests, array assignments, traversal, inversion, comparisons and floating-point operations are unchanged. Every element continues to be explicitly assigned by the original loop. free(inon_zero) occurs at all three original error returns and the normal return; the two new pre-allocation failures own no memory. No array sizeof or pointer-conversion use needed adjustment; sizeof(*inon_zero) is int. No calloc, fixed capacity, C++ ownership or scientific substitutions.

Existing allocations unrelated to this array are unchanged; pre-existing matrix-pointer/error handling is not certified safe by this patch. The original Linux VLA remains. A structural check reconstructs the entire frozen alomax_matrix.c exactly by removing only the new Windows branches (verification.json), stronger than checking the numerical expressions individually.

## Explicit failure-path exception and concrete proposal

07E1 directs: “If a routine has no safe allocation-failure path, isolate that issue and prepare the smallest justified failure-handling proposal.” This exception applies to the two NLLocLib.c routines: its active gap caller consumes pgap_secondary and continues without checking failure; its Vp/Vs caller ignores the return. Returning -1 locally would either expose an unset secondary gap or leave stale estimate fields in a saved location. Treating every Vp/Vs -1 as fatal would change the original valid insufficient-pair behavior. The other textual gap call is commented-out historical code, not an active call.

`failure-handling-proposal.md` and `P8-WINBACKEND-07E1-nll-failure-propagation-PROPOSED.patch` contain the two checked double-array conversions, full partial/normal/error cleanup, and two active driver checks through existing clean_memory(EXIT_ERROR_LOCATE). A private Windows storage-status flag distinguishes new Vp/Vs allocation errors from original insufficient pairs; its single-call-context/concurrency limitation is explicit. Additional driver/status scope requires review before application. This proposal is **UNAPPLIED, NOT COMPILED, NOT EXECUTED**; no scientific code is silently changed to force a build. NLLocLib.c remains byte-identical to frozen source.

Applied source patch: `phase8/patches/P8-WINBACKEND-07E1-matrix-array-storage.patch`
SHA-256: `C2075DD8725E3B39ED3E234EF5291A3ADF2023332A5A9F7BAA9E01270E693C03`.

Unapplied proposal patch: `phase8/patches/P8-WINBACKEND-07E1-nll-failure-propagation-PROPOSED.patch`
SHA-256: `5B5BF84E7737B0DA292A6AC64D6F6E519D4DEDC4A1B9E33AF29E458394B16C75`.

## Focused build and remaining blockers

Existing VS2022/MSVC 19.44 Release x64 target, original CMake sources and verified providers; `/p:BuildProjectReferences=false /p:TrackFileAccess=false /m:1`, process-local /showIncludes. Exact command, raw warning/error log and actual exit in locnll-command.json, locnll.log, locnll.exit_code.txt. No solution, Qt or provider rebuild.

The matrix translation unit compiles; its new object has AMD64 COFF headers and SHA-256 recorded in verification.json. Remaining MSVC C2057/C2466/C2133 are solely NLLocLib.c:12735 (azimuths), :12917 (p_time), :12918 (p_error), :12919 (s_time), :12920 (s_error), :12921 (weight). These are the known unconverted VLAs, not new linker failures. No link occurred, so locnll PE32+, plugin entry/registration linkage, provider export/import consistency, recursive DLL closure and DLL SHA are **UNAVAILABLE**, not passed. No built-target credit.

The existing GridLib.c uninitialized-parrivals C4700 warning is outside scope and unchanged; this incremental build need not re-emit it because GridLib.c did not change. Original warning evidence remains in 07E/locnll.log. No suppression, algorithm fix or numerical result adjustment.

## Preservation and provenance

Before compilation, 279 binary/import/export outputs including nested Tau, SQLite, database, controller/GUI/QC provider products were archived and hashed. All 279 current outputs and archived copies remain unchanged; 1460 protected files and all nine frozen HEAD/status/file vectors match before/after. The compiled alomax_matrix.obj is an intermediate, not a completed inventory artifact. verification.json records source before/after hashes and the post-build intermediate hash; no intermediate preimage custody is claimed. Installed Boost/package status, scientific inputs, stages and 07E GridLib adapter files remain unchanged. The 07E lifecycle proposal is preserved; its completed 39 adapter checks were not repeated.

Frozen superproject `9c395c7f00c788c5fc640363abe97b9ced0b44b0`, main `f63cde995e04151dc816151359a036b8b15f6019`, common `92d2202a6065aad36ae7d4a9bf960b6fb91222d2`. Original licenses retained. Historical pre-06C1 config DLL preimage custody remains **INCOMPLETE**; 07A Tau prebuild hash remains unavailable. No retroactive recovery claims. No dependencies upgraded, process protocols implemented, Phase7 changes or ew2sc deadline proposal applied.

## Gate register (Phase5A template)

| Gate | State | Evidence and actual command/exit | Limitation |
|---|---|---|---|
| A: Source + Phase4C evidence | NOT_RUN as full gate | before.json; verification.json; prepare.py/finalize.py | Frozen preservation checked; Phase4C gate not repeated |
| B: Transitive dependency closure | NOT_RUN as full gate | locnll-command.json; locnll.log; exit 1 | Matrix partial compilation; DLL link not reached |
| C: Linux original Autoloc offline oracle | NOT_RUN | None | No oracle execution |
| D: Windows native original Autoloc offline executable | NOT_RUN | None | No application execution |
| E: Replay equivalence and robustness | NOT_RUN | None | No replay or fault-injection execution |

## Linux/Windows fixture and numerical evidence

No scientific fixture consumed and no numerical comparison performed. Array initialization/lifetime and POSIX equivalence are source-review/static evidence, not numerical parity or runtime robustness certification.

| Scenario | Linux origins | Windows origins | Numerical/association difference | Result |
|---|---:|---:|---|---|
| Not run | — | — | — | NOT_RUN |

## Final assessed milestone and next phase

Phase5A **PARTIAL**. Review/authorize the concrete NLL driver/status failure-propagation scope, apply the two prepared array conversions, retry the same focused locnll target and capture any actual new compiler/linker blockers. Then qualify original plugin loading and numerical behavior separately when authorized. The 07E filesystem locale/path limitations and GridLib warning remain. Updated inventory, implementation status and patch ledger retain the incomplete native locator accurately.
