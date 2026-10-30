# Batch 0/1 — SeisComP R9 GUI launch tooling (source-only)

**2026-10-30.** This follow-up supplements the Phase 8 Windows development roadmap and the earlier R9 diagnostic. No application or external Windows binaries were executed during development of this file.

## Verified operator observations

- The R9 copy install reported success in `%LOCALAPPDATA%\SeisComP-Development-R9`.
- `bin\scconfig.exe` exists. `etc\descriptions` contains 131 XML files.
- A direct launch without `SEISCOMP_ROOT` failed seeking `C:\Program Files\SeisComP\etc\descriptions`.
- Dot-sourcing the installed `Use-DevelopmentEnvironment.ps1` set `SEISCOMP_ROOT`, `SEISCOMP_LOCAL_CONFIG` and established access to the description folder.
- **No post-environment scconfig window/runtime result has been reported.** This is still NOT_RUN, not PASS.

## What this update implements

`Start-DevelopmentGui.ps1` is a standalone **development launcher and preflight**. It is stored in the GitHub engineering repo, **not** copied into the immutable verified R9 installation. It:

- Defaults to **preflight only**; performs no executable/GUI/service/network execution.
- Verifies external SHA-256 identity of `SHA256SUMS.json` and checks manifest-listed hashes of the selected GUI, environment helper and `bin\qt.conf`.
- Checks local fixed NTFS path, rejects reparse-point ancestors, reports installed description XML count and presence of potential home `.seiscomp` configuration overrides.
- Supports all 11 original named GUI executables.
- Requires explicit `-Run`, a nonempty operator authorization reference, and separate `-IsolatedProfileReviewed` and `-UserConfigurationReviewed` acknowledgements to attempt a launch. The script **does not** establish or verify a network boundary and the acknowledgements alone do not constitute independent approval.
- Uses the existing verified process-local environment helper and restores prior process environment values after the GUI exits. Does not modify machine PATH, firewall, registry, services, production databases or the original package.

## Safe local preflight, no GUI execution

Run these commands in ordinary Windows PowerShell, from a copy of the script stored **outside** the R9 installed directory:

```powershell
$root = Join-Path $env:LOCALAPPDATA 'SeisComP-Development-R9'
$expected = '475CF040BAE301822A08A31B32A3D218A75621DAD5EEA314A563221E107DFB57'
& '.\Start-DevelopmentGui.ps1' -Root $root -ExpectedManifestSha256 $expected -Application scconfig
```

Expected: `PREFLIGHT_PASS`, the root and counts, then `NOT_RUN`. A successful preflight **does not** qualify the GUI or prove isolation. If a file hash or required directory check fails, stop and preserve the error; do not edit the trusted R9 copy.

### Review for an actual GUI smoke test (not an authorization)

A separately approved test procedure must first specify the exact candidate identity, application/arguments, network isolation method and its independent verification, allowed external files/configuration, account and user-home overrides, database access, and evidence to capture. Do not infer offline behavior from the environment script or a GUI's default options. Only after those preconditions are fulfilled may a supervisor choose to use the explicit `-Run` path with the approval reference and review switches. `-WhatIf` can be added to inspect that path without a launch.

## Next required steps

1. Reconcile the operator's actual 08C6/revision-10 source, candidate manifest and report; it is **not** included in the older 08C5/R9 GitHub archive. Do not claim 08C6 source has been published before it is supplied.
2. Obtain actual post-initialization `scconfig` GUI outcome from an approved isolated session. If it opens, no new C++ root fix is needed; if not, inspect the observed error and correct its cause.
3. Determine configuration precedence and expected endpoint behavior from the **pinned** original source, including user-home `.seiscomp`; document a test profile that cannot reach production stations or databases.
4. Continue Batch 3 offline MiniSEED and Batch 4 SCML event workflows with matched, reviewed test fixtures.
5. Keep the 08C6A passive Earthworm malformed-frame parser patch behind its separately required explicit source-change approval; do not apply it in this batch.

## Verification limitations

A source-only inspection was performed in a non-Windows authoring environment. There is no local PowerShell/Windows runtime available to parse/execute the script or verify a GUI. This update is **SOURCE_READY / RUNTIME_NOT_RUN**, not `BUILD_PASS`, `GUI_PASS` or `SCIENCE_PASS`.