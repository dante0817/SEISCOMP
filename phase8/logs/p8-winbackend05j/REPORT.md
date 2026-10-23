# P8-WINBACKEND-05J — Build and dependency report

Date: 22 October 2026 (Asia/Manila)
Configuration: VS2022 / MSVC / Release / x64; existing CMake build tree. Each command: `cmake --build phase8/build/vs2022-native-after-sqlite-nohypo71 --config Release --target <target> -- /m:1`. Commands ran sequentially; CMake scheduled prerequisite projects. No executable was launched.

## Boost.Signals2 / scqc

Official vcpkg port identity is `boost-signals2` 1.90.0#1, BSL-1.0, `boostorg/signals2`, tag `boost-1.90.0`. Downloaded official GitHub tag archive SHA-512 exactly matches the port recipe: `63c7dae6bde6bc9f7a070e5fade398c43f5e92fcc1d085dc3e5437fca5b10b6ea6ae5773124067a254c65e005ff8ef1070b11a166baa6d43b4cac5ec344b112f`; archive root and 43 header files verified. Installed Boost header identifies 1.90.0.

Provisioning was not performed: the recipe requires Boost 1.90 dependencies, and `boost-parameter` is missing from the installed package set and header tree. `boost-parameter` itself requires `boost-fusion`, `boost-mp11`, and `boost-utility`. Therefore the requested matching dependency compatibility could not be established from the approved overlay without adding further components. No files were copied and no scqc/CMake include settings changed. `scqc` remains blocked; prior raw failure log is `../p8-winbackend05i/scqc.log`. Package audit: `dependency-verification.json`; verified source archive retained.

## New focused builds

| Target | Exit | Result |
|---|---:|---|
| `test_mn_amplitudes` | 0 | AMD64 PE32+, SHA-256 `4294446AAD72F4BD8EBD7849ACD0FE2629C15DFE8A4435CFF776BCA34CEA55AB`; static DLL closure PASS. |
| `memailplugin` | 0 | AMD64 PE32+, SHA-256 `41FD3C3946E35809A22900CE0ADE5D3BE3E088F78ACEC0439514B5DC9DB5B671`; static DLL closure PASS. |
| `mtextplugin` | 0 | AMD64 PE32+, SHA-256 `EA214C6BB5E80CAE21B5FB90A3590F15B934C8AD0544EE2C70B244B20F39BFF0`; static DLL closure PASS. |

Inspection JSON, recursive import records and raw dumpbin logs are in `artifacts/{test_mn_amplitudes,memailplugin,mtextplugin}/`. Build logs and actual exit codes are named `<target>.log` and `<target>.exit_code.txt`.

Seven attempted available targets failed at first independent roots: `echopro_plugin` (missing `unistd.h`; also source forwarding file `plugin.c` contains only a relative path and triggers C2059), `ewexport_plugin` (`unistd.h`, `netinet/in.h`), `gdrt_plugin` (missing `boost/asio.hpp`), `minilogger_plugin` (`unistd.h`, `dirent.h`), `naqs_plugin` (`unistd.h`, `netdb.h`), `q330_plugin` (GNU `/Wno-incompatible-pointer-types`, MSVC D8021), and `reftek_plugin` (custom build calls MSBuild with GNU `-C` and Linux platform defines). Raw logs retain all warnings and errors. No fixes were applied; source changes require separate proposals/approval.

## Inventory and portability proposal

Inventory is now **68 built / 19 available / 19 Windows-portability blocked / 2 external-dependency blocked / 6 disabled (114 total)**. The six new portability blockers are `echopro_plugin`, `ewexport_plugin`, `minilogger_plugin`, `naqs_plugin`, `q330_plugin`, `reftek_plugin`; `gdrt_plugin` is the second external dependency blocker. GUI remains 11/11. Updated inventory: `../inventory/backend-target-inventory.csv` and `.json`; counts: `inventory-summary.json`.

Grouped process/lock and ew2sc Winsock implementation proposal, including ownership, file lifetime, signal/alarm/timeout, cleanup/error semantics, exact API mappings, and preservation boundaries: `05j-portability-proposal.md`. No major process, signal, lock, or networking architecture was implemented.

All frozen SeisComP source snapshot HEADs/statuses and tracked sentinel hashes match expected values; vcpkg HEAD/status is clean and unchanged (`preservation.json`). No operational installation, service, application, messaging, database, or network runtime use. All 11 GUI staging bundles still have stale provider dependencies; bundle refresh deferred as requested. Runtime/scientific/release validation NOT RUN.
