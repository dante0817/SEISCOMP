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

## Operator result — all 11 GUI hashes PASS; qoffscreen provenance unresolved

The operator executed Batch 2's read-only PowerShell audit on the immutable R9 copy. The approved manifest digest matched `475CF040BAE301822A08A31B32A3D218A75621DAD5EEA314A563221E107DFB57`. **All 11 original GUI EXEs and all manifest-listed Qt provider, image-format and Windows platform plugin files passed.** `qt.conf` relative paths and GUI catalog JSON readability passed. Total 26 audited entries: 25 `PASS`, one `NOT_MANIFESTED` for `bin/qt-plugins/platforms/qoffscreen.dll`. The initial check did **not** report whether this file existed: the manifest test preceded the file-presence check.

**Why this matters:** Historical `phase8/patch-ledger.md` (P8-WINGUI-04C) explicitly says native `scmapcut` uses `Application::Tty` and its staging required matching Qt 5.15.18 `qoffscreen.dll`. `phase8/IMPLEMENTATION_STATUS.md` (P8-WINGUI-02A) documents the offscreen plugin for the Tty `scshowevent`. Therefore do not downgrade this plugin to 'optional' for **all** original GUI/Qt utilities, and do not mark complete package qualification based solely on visible `scconfig`, `scrttv`, or `scolv`.

**Checker revision:** The maintained `Test-NativeGuiPackage.ps1` now explicitly distinguishes `MISSING_AND_UNMANIFESTED` from `PRESENT_BUT_UNMANIFESTED`, and avoids duplicating an already-known unmanifested plugin in the QT_UNLISTED findings. This revision is **SOURCE_UPDATED / WINDOWS_RERUN_NOT_PERFORMED**, so the original operator result remains authoritative until a targeted read-only presence check or rerun.

**Next determination on R9:** inspect `Test-Path` for the exact Qt 5.15.18 `bin/qt-plugins/platforms/qoffscreen.dll`, whether the approved manifest contains it, and whether `share/windows/gui-package.json` lists it. If missing, treat this as a candidate packaging gap for headless Qt utilities and restore only in a new separately verified build candidate from the pinned Qt distribution (not by copying arbitrary installed Qt binaries or editing the R9 approved manifest). If present but unmanifested, treat it as an integrity/provenance defect. Both cases remain `NEEDS_REVIEW` until reconciled.

**Unchanged:** R9 files, network/services, runtime execution and scientific qualification. The static audit confirms 11/11 GUI executable integrity; visible-GUI runtime startup remains NOT_RUN.

## 2026-10-30 operator-confirmed R9 packaging defect — qoffscreen omitted

Operator performed a targeted, read-only check against the immutable R9 development copy:

| Check | Result |
|---|---|
| `bin/qt-plugins/platforms/qoffscreen.dll` physically present | **False** |
| Entry exists in approved `SHA256SUMS.json` | **False** |
| Filename mentioned in `share/windows/gui-package.json` | **False** |

**Diagnosis:** confirmed omitted offscreen Qt platform plugin in the R9 package and package inventories, not a hash mismatch. Earlier staging evidence shows this plugin was needed for the `Application::Tty` utilities `scmapcut` and `scshowevent`. The other 11 GUI executable identities and the tested Windows Qt platform/Qt provider files remain valid. This specific omission does not imply that all visible Qt GUIs fail startup.

**Release engineering correction:** create a **new** isolated candidate, not an in-place R9 modification. Recover the `qoffscreen.dll` matching the previously pinned Qt **5.15.18 x64 Release** provider from verified earlier Phase 8 staging or the approved dependency bundle; record its source, version, architecture and SHA-256; perform direct and recursive native dependency checks; include it under `bin/qt-plugins/platforms/`; update `share/windows/gui-package.json` and the candidate `SHA256SUMS.json` and verify them in a clean copy. Preserve the previous R9 manifest identity. Re-run static package audit against the **new externally approved manifest digest** before a separate isolated runtime qualification.

**Important:** the operator ran the first version of the checker and saw generic `NOT_MANIFESTED`. The revised checker reports `MISSING_AND_UNMANIFESTED`; no additional R9 rerun is needed to prove this already confirmed result. The result `STATIC_GUI_PACKAGE_AUDIT_NEEDS_REVIEW` remains accurate.

**Open dependency:** no trustworthy exact plugin binary or complete installed GUI package catalog contents are available in the connected source-only repo. Do not invent a plugin file/hash, claim packaging repair complete, or patch R9. The next operator data collection is a targeted read-only location/version/hash inspection of candidates in previously approved staging. Until then: `BATCH2_STATIC_11_GUI_PASS_WITH_QOFFSCREEN_OMISSION / GUI_RUNTIME_NOT_RUN`.

## 2026-10-30 operator discovery — two staged Qt 5.15.18 offscreen candidates

The operator ran a bounded read-only search for `qoffscreen.dll` in two historical Phase 8 staging roots. Two candidate files were found:

- `phase8/staging/scmapcut-offline/platforms/qoffscreen.dll` — Windows file version **5.15.18.0**.
- `phase8/staging/scshowevent-offline/platforms/qoffscreen.dll` — Windows file version **5.15.18.0**.

Both are consistent with the pinned Qt provider version, but **the table output truncated file sizes and SHA-256 values**. Their byte identity, staged provenance, AMD64 PE architecture, and cross-dependency compatibility with the approved R9 Qt libraries remain to be independently confirmed. No plugin has been copied, executed, or installed. R9 still lacks the plugin.

**Next bounded checks:** display complete SHA-256 for both candidates without column truncation, establish byte identity, inspect `dumpbin /HEADERS` and `/DEPENDENTS` on the selected candidate and compare against the packaged Qt provider set, verify each against a staged hash receipt if available, and inspect `share/windows/gui-package.json` object shape before implementing manifest and catalog updates in a **new** versioned candidate. Do not edit R9, do not use an arbitrary Qt installation, and do not claim GUI runtime qualification.

## 2026-10-30 operator evidence — staged offscreen copies are identical

The operator's full read-only hash and version check returned exactly:

| Staged origin | File version | Size (bytes) | SHA-256 |
|---|---|---:|---|
| `phase8/staging/scmapcut-offline/platforms/qoffscreen.dll` | 5.15.18.0 | 102912 | `111CD9A0E512545DCD7E4BCC130E70ABA4EA1B9A1B1068545F5D1B193B0C04A6` |
| `phase8/staging/scshowevent-offline/platforms/qoffscreen.dll` | 5.15.18.0 | 102912 | `111CD9A0E512545DCD7E4BCC130E70ABA4EA1B9A1B1068545F5D1B193B0C04A6` |

Operator's comparison: `BOTH PLUGINS ARE BYTE-IDENTICAL`.

**Interpretation:** two historical sources contain exactly matching candidate plugin bytes consistent with Qt 5.15.18. This is sufficient to identify a deterministic candidate for a new separate packaging revision; it does not yet prove x64 PE architecture, import closure, original staging manifest provenance, or runtime compatibility. No file has been moved or installed. R9 remains intact.

**Next static read-only inspections:** `dumpbin /HEADERS` and `/DEPENDENTS` on the identified staged candidate; compare Qt provider module file versions; check historical staging receipts/hashes if present. Prepare a new candidate only after verification, with new `SHA256SUMS.json` and `gui-package.json` entries, preserving externally pinned R9 identity.

## 2026-10-30 operator evidence — x64 import checks confirm offscreen packaging candidate

Static operator inspection of `phase8/staging/scmapcut-offline/platforms/qoffscreen.dll` returned `8664 machine (x64)` using MSVC `dumpbin /HEADERS`. Its `dumpbin /DEPENDENTS` direct imports are:

`freetype.dll`, `Qt5Gui.dll`, `Qt5Core.dll`, `VCRUNTIME140.dll`, `api-ms-win-crt-string-l1-1-0.dll`, `api-ms-win-crt-heap-l1-1-0.dll`, `api-ms-win-crt-runtime-l1-1-0.dll`, `KERNEL32.dll`.

The installed R9 `Qt5Core.dll`, `Qt5Gui.dll`, and `qwindows.dll` all have file version `5.15.18.0`; previously, the Qt DLLs, `freetype.dll`, and Windows VC++ runtime presence had passed their respective checks. The staged `qoffscreen.dll` has file version `5.15.18.0`, size 102912, SHA-256 `111CD9A0E512545DCD7E4BCC130E70ABA4EA1B9A1B1068545F5D1B193B0C04A6`, matching the separate `scshowevent` staged copy.

**Conclusion:** confirmed byte-identified AMD64 Qt 5.15.18 offscreen-plugin candidate with direct import names consistent with the existing R9 package. This is not proof of full recursive import resolution, Qt platform plugin loading, GUI startup, or scientific functionality. No application was executed and R9 remains unchanged.

**Next release-engineering input needed:** inspect the on-disk `share/windows/gui-package.json` structure and the recorded `qwindows.dll` entry so the new versioned candidate can update the catalog accurately rather than guessing its schema. Candidate construction must separately verify the source plugin and all files, produce fresh manifest and external manifest identity, and install into a separate R10 development directory. Do not repoint R9 receipts to the new manifest.

## Batch 2 release preparation — R10 offscreen recovery builder added

The operator inspected the R9 GUI catalog structure and confirmed it contains `original_applications` and `Qt` child objects, alongside `qt_conf_sha256`, `private_provider_manifest`, `config_and_resource_manifest`, and `inspection`. A representative `Qt.qwindows.dll` item has `path` and `sha256` members. The recovered offscreen plugin is x64 / Qt 5.15.18.0 with the pinned SHA-256 from the previous checkpoint.

Prepared `phase8/windows-development/New-NativeGuiR10Candidate.ps1` in **draft PR #3**. This source-only packaging utility:

- Pins the approved R9 manifest digest and the confirmed Qt offscreen plugin hash, checks PE AMD64 and version.
- Re-verifies every manifest-listed R9 source file and rejects unmanifested source files and reparse points.
- Validates that the existing GUI catalog includes a consistent `Qt.qwindows.dll` `path`/`sha256` and does not already list `qoffscreen.dll`.
- Supports a mandatory fresh, local fixed NTFS candidate destination; will not replace the installed R9 copy.
- Adds a `Qt.qoffscreen.dll` object with path/hash to `share/windows/gui-package.json` in a new copy; updates only that changed catalog entry and adds the plugin to the new flat `SHA256SUMS.json`.
- Re-verifies all new payload hashes, manifest entry count, filesystem file count, and updated Qt catalog; writes a separate build receipt containing the new manifest identity and explicit NOT_RUN runtime status.
- Never executes SeisComP or Qt; uses `SupportsShouldProcess` so `-WhatIf` validates and previews without creating the candidate.

**Operator read-only preflight:** after a script trust review, run

```powershell
$source = Join-Path $env:LOCALAPPDATA 'SeisComP-Development-R9'
$plugin = 'Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\staging\scmapcut-offline\platforms\qoffscreen.dll'
$destination = Join-Path $env:LOCALAPPDATA 'SeisComP-R10-Candidate'
.\New-NativeGuiR10Candidate.ps1 -SourceRoot $source -OffscreenPlugin $plugin -Destination $destination -WhatIf
```

After operator-approved copy, omit `-WhatIf` and record `R10_MANIFEST_SHA256`. Separately install into a **different** R10 development path using the existing verified installer and the **new** externally approved manifest digest. Do not reuse R9's installer receipt, root, or digest for R10.

**Validation declaration:** source authored and GitHub readback verified; native Windows PowerShell AST, dry run, copy operation and GUI runtime are **NOT_RUN** in this assistant environment. Do not claim R10 is built until the actual operator transcript proves it. Continue development-first GUI integration and defer actual runtime qualification to an approved isolated Windows environment.
