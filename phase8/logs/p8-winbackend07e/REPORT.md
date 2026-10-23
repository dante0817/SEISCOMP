# P8-WINBACKEND-07E — Native Windows locator portability

**Result: PARTIAL. locnll remains blocked; inventory stays 94/120 built.** Existing VS2022/MSVC 19.44 Release x64 configuration used. No prerequisite provider, Qt or solution rebuild. 23 October 2026.

## Implementation and focused build

Private `nll_windows_files.h` is included only by GridLib.c under `_WIN32`. GridLib.h keeps original POSIX headers and fnmatch_wrapper declaration on non-Windows; the original ExpandWildCards/fnmatch_wrapper bodies are retained unchanged in the POSIX branch. No process-global dirent/fnmatch shim or added dependency. The existing locnll target/CMake sources are used without reconfiguration.

Original behavior inspected at GridLib.c:4790–4866: expansion triggers only on '*'/'?' (bracket-only paths are literal), splits the last '/', scandir filters with fnmatch flags 0, alphasort orders by strcoll, and entries remain in ascending output slots despite reverse cleanup. Directory entries are not restricted to regular files. Empty/no-match/enumeration failure returns -1 with the original generic diagnostic; excess matches use the original specific diagnostic. The Windows wrapper preserves these error categories and releases its enumeration handle and temporary list on every path, including excess matches (the POSIX implementation leaks the namelist on that error; its branch is unchanged).

The adapter enumerates all names with FindFirstFileW/FindNextFileW and applies a separate case-sensitive matcher. Windows wildcard semantics are not used for selection. Matching supports '*', '?', backslash escapes, bracket lists, negation, ordinary byte ranges, standard POSIX character classes, and single-byte C-locale collating/equivalence elements. Leading dots are ordinary with flags 0. Sorting uses strcoll after requiring C collation/character locale. Relative paths, forward/backslash separators, drive-relative C:name, drive-root and UNC directory prefixes are interpreted natively; no chdir/global locale change. Output is bounded by the existing FILENAME_MAX stride, with explicit overflow failure rather than truncation. Wide directory entries must round-trip to the native ACP without best-fit substitution; unrepresentable names fail explicitly.

**Compatibility limits:** non-C locales, complex collating/equivalence elements and collating/class range endpoints are rejected with a diagnostic and EINVAL rather than silently approximated. Paths beyond the original fixed output stride and unrepresentable narrow names are rejected. Native root/backslash/drive handling extends the POSIX separator interpretation deliberately. Complete POSIX fnmatch locale parity, Unicode scientific I/O and exhaustive path/matching equivalence remain unqualified. This is a bounded engineering adapter, not a full locator parity claim.

The actual locnll build exits **1**. GridLib.c compiles to AMD64 COFF (`GridLib.obj-headers.log`; hash in verification.json). The unchanged scientific routines then fail MSVC C2057/C2466/C2133:

- NLLocLib.c:12735: `double azimuths[MAX_NUM_ARRIVALS]` in CalcAzimuthGap. MAX_NUM_ARRIVALS is a runtime global (GridLib.h:693).
- NLLocLib.c:12917–12921: runtime-sized p_time, p_error, s_time, s_error and weight arrays in CalculateVpVsEstimate.
- alomax_matrix/alomax_matrix.c:269: `int inon_zero[i_original_size]` in matrix_double_check_diagonal_non_zero_inverse.

These are outside the authorized filesystem compatibility corrections. No numerical routine was edited, no fixed cap or substitute calculation introduced. Further linker/export defects remain unknown because compilation did not complete. Existing GridLib.c C4700 warning for uninitialized parrivals at line 5561 (shifted by the wrapper) is retained in the raw log, not fixed or certified safe. No locnll DLL was linked; its PE/import/export/recursive closure/SHA gates are unavailable and it is not counted as built.

Raw invocations and actual exits: `locnll-command.json`, `locnll.log`, `locnll.exit_code.txt`; first attempt retained as `locnll-initial.log`. `/p:BuildProjectReferences=false` reused the available core/config prerequisites; `/p:TrackFileAccess=false` preserves the established FileTracker workaround. Compiler include traces and warnings are retained.

## Engineering-only adapter checks

The independent `phase8/filesystem07e` helper contains no SeisComP library or scientific input. CMake configure/build exit 0; helper execution exit 0, **39 checks passed** (`adapter-checks.log` and exact command JSON). Checks cover case sensitivity, dots, wildcard backtracking, ranges/negation/classes/escapes/collating elements, malformed bracket literals, sorted fixture selection, relative backslash paths, excess/no matches, missing directories, bracket-only literal fast path, zero capacity, overlong input and rejected unsupported syntax. Fixtures are private under this log directory. Helper is AMD64 PE32+; this evidence does not qualify locnll or replace a Linux oracle. Untested cases include locale variants, UNC/drive roots, real long/non-ASCII paths and exhaustive fnmatch differential behavior.

## Pinned source / patch provenance and custody

Patch: `phase8/patches/P8-WINBACKEND-07E-nll-filesystem.patch` SHA-256 **CD1AABBAF3D66C98F899652B4BFF6C719C548D839428E957E05668D683DE3547**. Includes only GridLib.c/GridLib.h filesystem branches and the private adapter; per-file before/after hashes are in `verification.json`. Original LGPL notices remain in the upstream files. NLLocLib.c and alomax_matrix.c remain byte-identical to frozen sources.

All nine frozen repositories match the recorded HEAD/status/file vectors before/after. Frozen superproject `9c395c7f00c788c5fc640363abe97b9ced0b44b0`, main `f63cde995e04151dc816151359a036b8b15f6019`, common `92d2202a6065aad36ae7d4a9bf960b6fb91222d2`. Before compilation, **279** current binaries/import libraries/export files including nested Tau, SQLite, database and QC products were archived in binary-before with hashes. All remain unchanged; 1433 protected prior files, all stages and installed Boost libraries/package status are unchanged. No staged provider revision was replaced. Historical pre-06C1 config DLL preimage remains **INCOMPLETE**; the historical 07A Tau prebuild hash remains unavailable, without retroactive recovery claims. Phase7 and the unapplied ew2sc deadline proposal remain unchanged.

## Native process proposal and next phase

`process-lifecycle-proposal.md` documents original scwfparam fork/execv/wait option and locext pipe/dup2/execvp/XML/wait semantics, plus a coherent application-owned CreateProcessW/RAII handle contract. It covers standard handles, cwd/environment, path search, quoting, exit/error handling, synchronous/asynchronous ownership, cancellation, cleanup and Unix script compatibility. Existing C and Python controller helpers were inspected as references; controller ownership is not imported. No process protocol, script semantics, configuration or helper implementation was changed.

Next phase should authorize a storage-only MSVC VLA compatibility correction in the three named numerical routines while preserving all loop bounds, precision and calculations; then retry locnll and address real linker failures. Qualify the adapter's explicitly limited filesystem contract separately. Follow with the native scwfparam/locext child contract, including explicit interpreter/PATH/job/cancellation decisions. Remaining locator blockers include locext POSIX process handling and disabled iloc/Hypo71/native Fortran dependencies; they were not changed. CSV/JSON inventory, implementation status and patch ledger updated with the new exact locnll blocker; counts remain 94 built, 21 Windows-blocked, 1 dependency-blocked, 4 disabled.

## Gate register (Phase5A template)

| Gate | State | Evidence | Exit/command | Limitation |
|---|---|---|---|---|
| A: Source + Phase4C evidence | NOT_RUN as full gate | before.json;verification.json | prepare.py/finalize.py custody assertions | Phase4C review not repeated; historical gaps retained |
| B: Transitive dependency closure | NOT_RUN as full gate | locnll.log;verification.json | Focused build exit 1; command JSON | DLL link not reached |
| C: Linux original Autoloc offline oracle | NOT_RUN | None | Not run | No science/oracle fixture |
| D: Windows native original Autoloc offline executable | NOT_RUN | None | Not run | Isolated filesystem helper only |
| E: Replay equivalence and robustness | NOT_RUN | None | Not run | No numerical/scientific comparison |

## Linux and Windows fixture provenance

Scientific fixtures and SeisComP application execution NOT_RUN. Only private filesystem helper fixtures were used, with no messaging, database, GUI/controller, acquisition or scientific replay. No dependency upgrades.

## Numerical difference matrix

| Scenario | Linux origins | Windows origins | Numerical/association difference | Result |
|---|---:|---:|---|---|
| Not run | — | — | — | NOT_RUN |

## Final assessed milestone

Phase5A **PARTIAL**. Filesystem engineering progress and explicit remaining blockers are recorded. locnll is not completed; dynamic loading, locator accuracy, numerical/scientific parity and release qualification remain unverified.
