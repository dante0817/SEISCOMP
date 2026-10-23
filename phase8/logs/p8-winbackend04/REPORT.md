# P8-WINBACKEND-04 implementation report — PARTIAL

**Agent:** Codex; **Date/platform:** 22 October 2026, Windows x64, existing Visual Studio 2022 / MSVC 14.44 Release x64 configuration. **Authorization:** operator P8-WINBACKEND-04, Phase 8 native working copy only. Applicable root AGENTS.md and PHASE5A_AGENT_TASK.md read. No nested source AGENTS.md found. No applications, services, test programs, GUI runtime preflights or networking operations executed.

Engineering build/static evidence only. Numerical, scientific, runtime and release evidence NOT RUN. Existing Phase5A gate states A–D BLOCKED, E NOT_RUN are unchanged. No observed data, oracle replay or functional test input was used. Full SeisComP development/qualification is not complete.

## Completed implementation groups

- Approved SOCKET macro correction applied after exact SHA-256, exact one-file 1/1-line scope, git apply --check and reverse-check. Windows SOCKET and SLCD::link retain pointer width; CAPS Socket owns a pointer-width NativeSocket. Actual slink provider is a static library, not a shared DLL. All eight generated consumer targets attempted; six build, two remain blocked.
- Windows typed CRT/pipe/SOCKET I/O, overlapped byte pipes, native EOF/error/partial-count results, rolling write timeouts, resolved cancellation before buffer destruction, pipe readiness separate from WSAPoll socket readiness. slutils Timer and SeedLink monitor wall-clock sampling use signed 64-bit Unix seconds and microseconds; original Timer arithmetic/scheduled increments retained. The upstream CAPS DateTime still stores Windows timeval long seconds; its post-2038 range is a separate unresolved representation limitation, not silently changed here.
- CreateProcessW with explicit native executable/argv mapping, UTF-16 conversion/quoting, inherited-handle whitelist, child-local FD63 bootstrap, binary mode, separate stop event, owned process/job and bounded forced escalation. Native CAPS and FS plugins explicitly bootstrap FD63 and check cooperative stop; arbitrary external plugins do not become compatible automatically. Contract and limitations are documented in source libs/slutils/NATIVE_WINDOWS_TRANSPORT.md.
- SeedLink server and slutils/slplugin call sites use the native paths. Linux process/select/filesystem implementations remain under their original platform branches. Windows network sockets close with closesocket and do not pass through CRT APIs. Width-safe OpenSSL 3 BIO callbacks avoid SSL_set_fd(int) truncation in CAPS; certificate-verification configuration is retained, not runtime certified.
- Native slarchive directory enumeration, wildcard expansion using existing sl_globmatch, deterministic lexical match ordering, real errors, owned filename lifetimes, binary CRT file access and native resource-limit handling. Certificate-verification code and archive record logic are unchanged. Windows filesystem paths currently use ANSI/CRT APIs; Unicode/extended-length paths remain unqualified.
- Windows endian declaration/packed-frame syntax fixes keep existing 64-byte Steim frame layout and algorithms. Packet header fields/encodings are unchanged. Raw input sample counts are checked before byte multiplication. Source-derived compile assertions do not establish authenticated Linux ABI parity.
- Existing-version Boost 1.90 POSIX regex implementation copied byte-for-byte from the local vcpkg build source and compiled only in the native support library; matching installed header verified. Original Boost license/notices included. No regex stub or dependency upgrade. Independent load_timetable CLI/math-link portability completed; scautopick builds without source changes.

Exact 53-file change scope (41 modified, 12 added including license/contract documentation), preimage/postimage hashes and five batch-only patch groups: [source-change-manifest.json](source-change-manifest.json), [applied.json](applied.json). All exported implementation patches pass git apply --reverse --check against the final working source; old working-copy changes are excluded by hash-verified preimages.

## Build/link inventory

Every command, actual exit, full warning/error log and attempt history is retained in [build-results.json](build-results.json), target .log/.exit_code.txt/-command.json files, and attempts/. No /FORCE or linker-error suppression used.

| Target | Focused result | Raw build log |
|---|---|---|
| seedlink_native | PASS, exit 0 | [seedlink_native.log](seedlink_native.log) |
| slutils | PASS, exit 0 | [slutils.log](slutils.log) |
| slplugin | PASS, exit 0 | [slplugin.log](slplugin.log) |
| slink | PASS, exit 0 | [slink.log](slink.log) |
| seedlink | PASS, exit 0 | [seedlink.log](seedlink.log) |
| caps_plugin | PASS, exit 0 | [caps_plugin.log](caps_plugin.log) |
| fs_plugin | PASS, exit 0 | [fs_plugin.log](fs_plugin.log) |
| slarchive | PASS, exit 0 | [slarchive.log](slarchive.log) |
| load_timetable | PASS, exit 0 | [load_timetable.log](load_timetable.log) |
| slinktool | PASS, exit 0 | [slinktool.log](slinktool.log) |
| scautopick | PASS, exit 0 | [scautopick.log](scautopick.log) |
| chain_plugin | FAIL, exit 1 | [chain_plugin.log](chain_plugin.log) |
| mseedfifo_plugin | FAIL, exit 1 | [mseedfifo_plugin.log](mseedfifo_plugin.log) |
| scamp | FAIL, exit 1 | [scamp.log](scamp.log) |
| scmag | FAIL, exit 1 | [scmag.log](scmag.log) |
| scevent | FAIL, exit 1 | [scevent.log](scevent.log) |

CMake automatic ZERO_CHECK regeneration/configuration succeeded; raw successful configure/generate spans and target exit 0 are indexed by [cmake-generation.json](cmake-generation.json). Existing Hypo71-disabled configuration retained. CAPS generated Release inputs and actual MSBuild linker trace both resolve to `C:\vcpkg\installed\x64-windows\lib\libcrypto.lib` and `libssl.lib`; no debug OpenSSL path. [caps-release-linkage.json](caps-release-linkage.json) and original UTF-16 link command trace retain inputs/hashes.

### Successful PE artifacts

All following executables are AMD64 PE32+; recursive private DLL import closure PASS to the Windows System32/API-set boundary. Optional dynamically loaded plugins and runtime search paths are outside this static claim. Raw dumpbin headers/dependents, hashes and resolved dependency paths are in artifacts/<target>/inspection.json and sibling logs. No Linux/POSIX-emulation runtime dependency found.

| Executable | SHA-256 |
|---|---|
| [seedlink](artifacts/seedlink/inspection.json) | `053AB60ADA33B266B296740926403732ADADDC2309BF5F27792FD21470DFDA2C` |
| [caps_plugin](artifacts/caps_plugin/inspection.json) | `FB49CD110BF0A2255EF20F4DE24BC37803BE0E1D7B25D0A92665FEFF3F23065E` |
| [fs_plugin](artifacts/fs_plugin/inspection.json) | `3139D837751F21FFEB8F573BFBA0A5BCAD7CF2F053F5EEE7A2AB5E263E157F23` |
| [slarchive](artifacts/slarchive/inspection.json) | `5EC28854C080F7599767A504216C01945CEDFA312DF4E33A51B098C67716F7A4` |
| [load_timetable](artifacts/load_timetable/inspection.json) | `2FE6D2CE00892A9221273F4604B5EC7871C76345178A4185C99225D8CE7811F2` |
| [scautopick](artifacts/scautopick/inspection.json) | `286F78CA998C7E10E468AAFAE3936CCFF097E1FFF5D561F78E0624591D82313D` |
| [slinktool](artifacts/slinktool/inspection.json) | `4F456C0F666A123245ECEA5B695BD6E1C81E9414C093E23E7115030F6111C374` |

seedlink_native, slutils, slplugin and rebuilt slink static archives have AMD64 8664 COFF members. Their SHA-256 and raw archive-member header evidence are in [static-library-artifacts.json](static-library-artifacts.json); DLL closure is inapplicable to a static archive, and final executable imports were inspected. [abi-compile-checks.json](abi-compile-checks.json) records packet/header/time/sample/SOCKET/frame assertions. Engineering compile/layout evidence only; numerical/scientific/operational evidence is absent.

## Remaining confirmed blockers and next batch

- chain_plugin: unistd.h is the first compiler stop. Source confirms fork-copy SLCD workers, POSIX shell hooks/timetable loader and select over three extension pipes (FD61 commands, FD62 raw input, FD63 packet output). It has not been migrated or counted complete. The proposed worker re-entry and versioned multi-channel external bootstrap require the separate contract/architecture approval specified by this task.
- mseedfifo_plugin: missing POSIX headers and materialized plugin.c/header symlinks. Native external FIFO producer semantics must be explicitly mapped; there is no implicit replacement of filesystem FIFOs. A minimal provider CMake patch is proposed only, not applied.
- scamp/scmag: unresolved bundled fmt::v10::vformat; Windows consumer projects lack FMT_HEADER_ONLY used locally by the common provider. A narrow two-CMake-file proposal is ready, not applied.
- scevent: C2201 anonymous executable-local message classes incorrectly decorated as imported DLL API plus Win32 GetMessage macro collision. Localized proposal is ready, not applied.

[follow-up-proposals.json](follow-up-proposals.json) supplies exact proposal hashes/scopes and successful git apply --check results (no application/build claim). [remaining-contract-proposal.json](remaining-contract-proposal.json) links the source-backed chain/FIFO architecture proposal and source hashes. Next development batch: approved chain worker/extension/FIFO contract implementation, then these independent processing build fixes. Runtime integration stays deferred. CAPS and FS are the only explicitly bootstrapped native plugin implementations established in this batch; external plugins and chain extensions remain unsupported until individually adapted/rebuilt.

Disabled configuration entries retained:
- Hypo71PC: SC_IPGP_HYPO71=OFF; native Fortran/MSVC generator route unresolved
- hypo71: SC_IPGP_HYPO71=OFF; stale vcxproj excluded from current solution
- dbmysql: SC_TRUNK_DB_MYSQL=OFF; native client development dependency not qualified
- dbpostgresql: SC_TRUNK_DB_POSTGRESQL=OFF; native client dependency not qualified
- dbsqlite3: SC_TRUNK_DB_SQLITE3=OFF; scevent SQLite cache is separate
- iloc: SC_TRUNK_LOCATOR_ILOC=OFF

Other available targets remain unbuilt; successful acquisition executables do not imply a complete native service/database/locator installation.

## Completion counts and custody

**9 newly completed targets: 6 executables, 0 DLLs, 3 static libraries.** Rebuilt slink/slinktool are not counted as new. Backend/support inventory **23/114 built**, 80 available but unbuilt, 5 Windows-portability-blocked, 6 disabled. The denominator increases by one for seedlink_native. GUI milestone remains **11/11**, excluded from backend totals. Exact rows: [backend-target-inventory.json](backend-target-inventory.json)/.csv.

Preservation PASS: nine frozen repository HEAD/status/file-hash maps identical; 468 protected GUI/staging/manifest/package/patch files unchanged, and all original build-product archives verified. [frozen-before.json](frozen-before.json), [frozen-after.json](frozen-after.json), [preservation.json](preservation.json), [archived-build-baselines.json](archived-build-baselines.json). Source snapshots, existing staging, dependency versions and protected successful baselines were not modified. Original build products are preserved separately under phase8/baselines/p8-winbackend04-before.

Pinned source vector remains superproject 9c395c7f00c788c5fc640363abe97b9ced0b44b0; main f63cde995e04151dc816151359a036b8b15f6019; common 92d2202a6065aad36ae7d4a9bf960b6fb91222d2 plus six other pinned repositories. Original AGPL/LGPL/Boost notices retained; no release/distribution or scientific parity claim.
