# Phase 8 — Batch 2 native Qt GUI package audit

**Status:** SOURCE_READY / WINDOWS_TEST_NOT_RUN / GUI_RUNTIME_NOT_RUN. Read-only tooling only; no immutable R9 candidate changed.

## Baseline

- The archived 08C5/R9 evidence reports 11 original native Qt GUI executables, Qt 5.15.18 libraries/plugins, and a dedicated `share/windows/gui-package.json` packaging catalog.
- The original scconfig Windows CMake change is recorded in `P8-WINGUI-04D-scconfig-flowlayout.patch` and avoids compiling the same FlowLayout source twice on Windows while linking `seiscomp_qt`.
- The operator's prior non-launching R9 GUI preflight passed with 131 XML descriptions.
- `scconfig`, `scrttv`, and `scolv` files were found; `qt.conf` references a relative `qt-plugins` directory and `qwindows.dll` resides in its `platforms` directory.
- Seven Qt module/plugin files and five SeisComP/Boost/FreeType DLLs matched approved R9 manifest digests. VC++ redistributable files were present in System32. `dumpbin /DEPENDENTS` identified `scconfig` and `qwindows` direct imports.
- Original GUI startup remains unverified. Hyper-V inventory access was denied to the operator; Sandbox was not detected in standard application locations. Neither condition blocks source-only GUI work.

## Implemented source

`Test-NativeGuiPackage.ps1` checks the externally verified R9 manifest identity, hashes all 11 original GUI executable files, checks essential Qt5 and platform/offscreen DLLs, validates `qt.conf` relative paths and the `gui-package.json` JSON, checks all manifest-listed Qt modules/plugins, and identifies Qt plugin files not present in the manifest. It reports per-file PASS/NEEDS_REVIEW states.

Checks are read-only; no GUI, dynamic-library loader test, shell/profile change, network probing, installation, database access, or service startup is performed. Executable integrity and static package completeness do not establish scientific or GUI runtime qualification.

## Operator usage

Run this only in an approved Windows PowerShell session, after normal organizational source-trust checks, from the tool's directory **outside** the R9 installation:

```powershell
$root = Join-Path $env:LOCALAPPDATA 'SeisComP-Development-R9'
$expected = '475CF040BAE301822A08A31B32A3D218A75621DAD5EEA314A563221E107DFB57'
.\Test-NativeGuiPackage.ps1 -Root $root -ExpectedManifestSha256 $expected
```

The positive result is `STATIC_GUI_PACKAGE_AUDIT_PASS`. If `NEEDS_REVIEW`, inspect the specific missing, hash-mismatched, unmanifested, or unreadable file rather than rebuilding all GUI targets. Do not bypass enterprise script execution restrictions.

## Remaining development

1. Execute this read-only audit on R9 and review discrepancies.
2. Inspect pinned original GUI source (not included in the engineering-record ZIP) for resource loads, effective configuration precedence, map/image providers and confirmed Windows-specific defects.
3. Preserve R9; implement only demonstrated GUI fixes in an independently hashed new candidate.
4. Obtain an authorized isolated Windows session for `scconfig` Qt startup, then offline `scrttv` and `scolv` with matched MiniSEED/SCML fixtures.
5. Continue acquisition/parser and remaining backend development separately under applicable authorization.

**Validation in this environment:** inspected the archived Phase 8 evidence, created a self-contained script, and reviewed source for prohibited execution/write operations; actual PowerShell AST and Windows GUI runtime were not available and are not claimed.

## Operator execution checkpoint — RemoteSigned / ZoneId=3

The first operator attempt to run `Test-NativeGuiPackage.ps1` on the mapped `Y:` development volume was blocked **before script execution** with PowerShell `PSSecurityException` / `AuthorizationManager check failed`.

Read-only diagnosis: MachinePolicy and UserPolicy both Undefined; CurrentUser and LocalMachine `RemoteSigned`, effective `RemoteSigned`; script `NotSigned`; `Zone.Identifier` reports `ZoneId=3`. No GUI or audit execution is claimed. This is consistent with PowerShell marking the unsigned downloaded script as Internet-origin; the mapped-drive location may introduce additional zone classification.

Operator-safe continuation: compare the script SHA-256 with the published original (`CF94FADD595686DB51F218D8E618F156B1938A9C5216DDFD4CE856649D64CBB2`), then use a separate local development-directory copy and `Unblock-File` **only if allowed by organizational policy**, without changing execution policy or administrator rights. Verify the local copy hash before any execution. If permissions still deny execution, seek IT authorization; do not use execution-policy bypass.

R9 installation remains immutable. Static GUI package-audit result is **NOT_RUN** until the operator supplies its actual output.
