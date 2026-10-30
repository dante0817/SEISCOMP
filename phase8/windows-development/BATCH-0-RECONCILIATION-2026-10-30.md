# Batch 0 — source and runtime status reconciliation

Date: 2026-10-30 (Asia/Manila). Source: exported `SEISCOMP-main.zip` engineering archive (through 08C5/R9), user-supplied local PowerShell outputs, and later user-reported 08C6 summary. **Do not treat the R9 report as proof of R10.**

| Item | Evidence | Status | Next action |
|---|---|---|---|
| 08C5/R9 candidate | Archived report records 106/120 native backend targets, 11/11 GUI executables, 12/12 Python extension builds, 855 package files | RECORDED / archival | Preserve immutable R9 |
| 08C6/R10 passive Earthworm | User reports successful build/worker checks and 107/120 backend coverage; R10 source/build evidence not supplied in uploaded archive | REPORTED / NOT RECONCILED | Obtain actual R10 report, source hashes, candidate manifest |
| 08C6A parser hardening | Proposed inherited Earthworm parser change | PENDING EXPLICIT APPROVAL | Review exact source/preimage and bounded tests before applying |
| R9 per-user copy installer | User's PowerShell reported successful verified copy | INSTALL_PASS (reported) | Do not mutate installed manifest |
| R9 direct `scconfig` launch | Before environment setup: fell back to `C:\Program Files\SeisComP\etc\descriptions` and failed | RUNTIME_FAIL, cause consistent with missing process env | Do not infer C++ bug yet |
| R9 description XML files | User observed 131 XML files | FILES_PRESENT | Preserve inventory |
| R9 process-local environment helper | User observed correct `SEISCOMP_ROOT` and configuration path after dot-source | ENV_PREP_PASS | Obtain post-environment GUI result in approved isolated session |
| GUI functional runtime | No post-environment result or screenshot supplied | NOT_RUN | Supervised isolated test needed |
| Archive patch fidelity | 3 stored patch files fail `git apply --numstat` parsing | REPRODUCIBILITY_GAP | Repair after reviewing original source/preimages; do not rewrite silently |
| 4 built inventory states | 4 rows with classification built but incomplete explicit `build_state` | EVIDENCE_GAP | Reconcile against build artifacts |
| GitHub documentation | PR #1 opened on a review branch; main remains unchanged until merge | PR_OPEN | Review and merge separately |
| Windows GUI launcher | New separate source-only preflight/gated launch helper in Batch 1 | SOURCE_READY (unexecuted) | Windows parser + safe preflight before any launch |
| Scientific and operational workflow | No approved full validation evidence | NOT_RUN | Prepare multi-station offline fixture and test profile |

## Required baseline receipt for 08C6/R10

Before moving current baseline forward, collect: actual branch/commit and dirty status of each frozen source tree; source preimage/postimage hashes for approved changes; CMake generator/MSVC/SDK and pinned dependencies; 08C6 report; current canonical 120-row backend inventory; actual R10 SHA256SUMS.json external identity and package artifact counts; and explicit authorization/exception log. Keep R9 and R10 separate; do not move the `current` pointer from an assertion alone.

## Review and publication scope

The new standalone launcher is separate tooling, not a binary/package change; publishing it does not modify R9 or establish GUI startup. No sensitive local configuration, waveform, production station metadata, or credentials are included. Any release of third-party source/patches needs a separate licensing and source-provenance review.