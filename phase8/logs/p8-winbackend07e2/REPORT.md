# P8-WINBACKEND-07E2 — NLL double storage and failure propagation

**Authorized storage/caller changes complete; locnll remains independently blocked.** Focused VS2022/MSVC 19.44 Release x64 build exits **1**. Backend remains **94/120 built**, GUI **11/11**; 21 Windows-blocked, 1 dependency-blocked, 4 disabled. 23 October 2026.

## Completed storage and failure mechanism

CalcAzimuthGap now allocates `double azimuths[MAX_NUM_ARRIVALS]` as Windows malloc storage with the same element type/count. Positive size, count/index bounds and SIZE_MAX/sizeof(double) overflow are checked. No calloc or automatic element initialization. On invalid size/allocation failure it logs and returns -1.0 without writing a false secondary gap. For valid azimuths with the routine's existing >=2 usable-arrival precondition, the largest circular gap is nonnegative; -1 cannot be a valid gap. The single active caller detects negative failure before reading pgap_secondary and uses clean_memory(EXIT_ERROR_LOCATE). The other textual gap call remains commented-out historical code. The original numerical loops, sort, comparisons, precision and output writes are unchanged. The array is freed before the successful return; error returns own no allocated array.

CalculateVpVsEstimate allocates five separate double arrays (`p_time`, `p_error`, `s_time`, `s_error`, `weight`), each with its original MAX_NUM_ARRIVALS element count. Count/overflow checks precede allocation. Only ownership pointers are initialized to NULL, not elements. Partial allocation failure frees every acquired pointer, logs and returns the Windows-only named **NLL_VPVS_STORAGE_FAILURE (-2.0)**. All five arrays are also freed at normal return and at the original insufficient-pair return. Existing field writes and -1.0 for fewer than two pairs remain nonfatal. The active caller compares exactly to the named -2 code and takes clean_memory(EXIT_ERROR_LOCATE) before SaveLocation. There is no mutable translation-unit status flag, TLS, signature change, new lock or serialization assumption.

The -2 code is distinct from every original return. The original function returns -1 for insufficient pairs or B. B starts at 2; k is -3..3 and dB starts at 0.5, multiplied by 0.4 each outer iteration. Total absolute search displacement is bounded by 3*0.5/(1-0.4)=2.5, so all candidate/results stay approximately within [-0.5,4.5], far from -2. Input-dependent weights/comparisons select candidates but cannot extend that bound. Equality to exact double -2 is therefore safe. Gap valid-input and usable-arrival assumptions are not newly broadened; unrelated pre-existing numerical edge cases remain unqualified.

All formulas, comparisons, array assignments/index order, double precision and original runtime counts are retained. No affected sizeof(array) use exists. The POSIX VLA declarations and original caller behavior remain in non-Windows branches. Structural verification reconstructs the entire frozen NLLocLib.c, ignoring only inserted blank lines, after evaluating the added Windows branches as false. New failure status is per-call; existing NLL global-state/reentrancy limitations are not claimed solved. Allocation failure is not treated as an observed lack of arrivals or pairs.

## Patch and partial artifact hashes

- Applied `phase8/patches/P8-WINBACKEND-07E2-nll-storage-propagation.patch`: `AB06135A5929F29E3CACA85DC6BF177CD0E50E9636402AF027D8B8DCD3BE7789`.
- Compiled `NLLocLib.obj` (AMD64 COFF): `49A28DDD824D0F8041FD5FF689B8FA8F6B7986D121BB9156D90BC0D00E474CB7`. Source pre/post hashes and raw object headers: applied-patch.json, verification.json, NLLocLib.obj-headers.log. This object is not a completed plugin.
- Reviewed 07E1 proposal verified at expected SHA-256 `5B5BF84E7737B0DA292A6AC64D6F6E519D4DEDC4A1B9E33AF29E458394B16C75`; its mutable flag was deliberately not adopted.
- Unapplied wrapper follow-up patch: `CD5E32FBDAC77609D7C72DBC98117882E9890BE1476182CF9F8534175C9F5028` (`wrapper-proposal.json` gives path/source hash).

## Actual build and independent new blocker

Original locnll project and existing dependencies used without reconfigure, Qt/controller/provider or full-solution rebuild. Actual invocation in locnll-command.json, raw output in locnll.log, exit **1** in locnll.exit_code.txt. `/p:BuildProjectReferences=false /p:TrackFileAccess=false /m:1`, with process-local /showIncludes. NLL C compilation now produces the object without VLA diagnostics. Linking is not reached.

The C++ wrapper `src/base/contrib-sed/plugins/locator/nll/nll_locator.cpp` includes the original C headers before `<iomanip>`. GridLib.h includes map_project.h:11, which declares `void tm(int,double,double,double*,double*)`, the Transverse Mercator projection. This hides the tm type in MSVC's subsequent `<iomanip>` get_time/put_time templates. Eighteen errors begin at iomanip:168 (C2059 '>'), followed by C2065/C2988/C2143/C2447/C4430/C2146/C2760/C3878, including iomanip:173–174. Exact evidence is in locnll.log and verification.json.

Two isolated compile-only object probes confirm the name/type conflict: tm_collision exits 1 (first error at xlocinfo:94 in the minimal include context), while parsing iomanip before the C function declaration exits 0. Their configure/build command JSON and logs are retained; no executable/plugin was launched. These probes do not prove that a full corrected wrapper or plugin will link.

`wrapper-followup.md` and `phase8/patches/P8-WINBACKEND-07E2-nll-wrapper-include-order-PROPOSED.patch` prepare a Windows-only early `<iomanip>` include before the NLL extern C block. The wrapper, projection function, calculations and STL installation are unchanged. This is **UNAPPLIED**, following 07E2 section E's direction to propose independent blockers outside the numerical-function/caller scope. Further compiler/linker blockers remain unknown.

No successful locnll DLL exists from this build. Plugin PE32+, original entry/registration linkage, provider imports/exports, recursive static DLL closure and DLL SHA-256 are **UNAVAILABLE**, not passed. No inventory completion is counted. The existing GridLib uninitialized-parrivals warning remains unchanged and unsuppressed; prior raw warning evidence remains in 07E. No scientific replay, fault-injection run or numerical parity claim.

## Preservation and inventory

All **279** prebuild completed binaries/import libraries/export files, including nested Tau/SQLite and current QC/database providers, were archived with hashes before compilation and remain byte-identical after the build. All 1476 protected prior files, stages, installed Boost/status and nine frozen HEAD/status/file vectors are unchanged. 07E adapter files/restrictions and process proposal, 07E1 matrix change, prior controller/GUI/database/QC implementations and unapplied ew2sc proposal are preserved. No staging update, mismatched provider revision, dependency upgrade or Phase7 change. Intermediate NLLocLib.obj has a post-build hash only; no prior intermediate custody is claimed.

Frozen superproject `9c395c7f00c788c5fc640363abe97b9ced0b44b0`, main `f63cde995e04151dc816151359a036b8b15f6019`, common `92d2202a6065aad36ae7d4a9bf960b6fb91222d2`. Historical pre-06C1 config DLL preimage custody remains **INCOMPLETE** and 07A Tau prebuild hash remains unavailable; neither is retrospectively recovered. Source licenses remain intact. CSV/JSON inventory, implementation status and patch ledger record the new exact wrapper blocker and unchanged counts.

## Gate register (Phase5A template)

| Gate | State | Evidence / exit | Limitation |
|---|---|---|---|
| A: Source + Phase4C evidence | NOT_RUN as full gate | before.json; verification.json; preservation scripts | Required frozen custody checked; Phase4C gate not repeated |
| B: Transitive dependency closure | NOT_RUN as full gate | locnll-command.json/log; exit 1 | Original C object compiled; wrapper prevents link |
| C: Linux original Autoloc offline oracle | NOT_RUN | None | No oracle run |
| D: Windows native original Autoloc offline executable | NOT_RUN | None | No SeisComP application/plugin execution |
| E: Replay equivalence and robustness | NOT_RUN | None | Source/static assessment only |

## Linux/Windows fixture provenance and numerical differences

No scientific fixture, database/network operation, GUI/controller or child-process protocol execution. Completed adapter checks were not repeated. Only compile-time storage review and tiny independent compile probes were used.

| Scenario | Linux origins | Windows origins | Numerical/association difference | Result |
|---|---:|---:|---|---|
| Not run | — | — | — | NOT_RUN |

## Final assessed milestone and next priority

Phase5A **PARTIAL**. All authorized NLL storage/failure changes are implemented and the C VLA blockers removed. Review/apply the prepared wrapper include-order correction next, rebuild original locnll, then address actual linker/static-closure results. Scientific correctness, dynamic loading, filesystem locale/path limits, existing warnings and runtime robustness remain unqualified. No scwfparam/locext lifecycle implementation was added.
