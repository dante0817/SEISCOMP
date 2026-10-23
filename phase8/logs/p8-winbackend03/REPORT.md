# P8-WINBACKEND-03 report

## P8-WINBACKEND-03 — messaging recovery and acquisition portability — 22 October 2026

CMake configure/generate **PASS**, actual exit **0**, existing VS2022 Release x64 build configuration. Raw log and command: configure.log, configure.exit_code.txt, configure-command.json. CAPS generated Release linker inputs **PASS**: C:/vcpkg/installed/x64-windows/lib/libcrypto.lib and libssl.lib; no debug OpenSSL paths (caps-release-linkage.json, caps-release-linkage-final.json). Later CMake regeneration during the slinktool build also succeeds. CAPS executable itself is NOT BUILT because prerequisites remain blocked.

All six exact operator-approved patches applied after independent SHA-256, numstat/file-scope and git apply --check verification. Reverse checks exit 0. Symbol ownership verified against existing core definitions (IPACL/BindAddress/IPAddress and getConfig specializations), application-owned ServerStatistics implementation, exported Core::msleep, native CRT packet writes, and existing Windows OpenSSL CONFIG discovery pattern. No replacement algorithms. Patch scope and before/after file hashes: applied.json; raw check/application/reverse-check records 1-6-*.json. Original notices retained.

| Patch | Exact SHA-256 | Changed files relative to component repository |
|---|---|---|
| P8-WINBACKEND-02-acquisition-cmake-proposed.patch | `E6BBA67F8EB0506723BFB0E66E29D79E4C61078011ED82BED839E898BCFC0E15` | plugins/caps_plugin/CMakeLists.txt, CMakeLists.txt |
| P8-WINBACKEND-02-scmaster-linkage-proposed.patch | `66F5D0727427E46145966C3B0CB37251AA866FCE693D7117F5CE4E39C4AB9F80` | libs/seiscomp/wired/ipacl.h, libs/seiscomp/wired/server.h, libs/seiscomp/wired/devices/socket.h, apps/messaging/scmaster/statistics/statistics.h |
| P8-WINBACKEND-02-settings-exports-proposed.patch | `464D14492917BD3901B8D878D107442FDBBC960D86FC3527B8062CEFAB4056F3` | libs/seiscomp/system/settings.h |
| P8-WINBACKEND-02-dbg-delay-msleep-proposed.patch | `3C5D312A828C2C167D1BD97B0AB519EE8441D5E781477B47F4647F8EA06FBF70` | apps/messaging/scmaster/plugins/dbg-delay/dbg-delay.cpp |
| P8-WINBACKEND-02-slutils-flex-header-proposed.patch | `68703BA74247828CE1A7D597166C1E5DFB0EA88BA1431A85163B0F2D62EAB0A9` | libs/slutils/CMakeLists.txt |
| P8-WINBACKEND-02-slplugin-crt-write-proposed.patch | `0BD601A349495CE6DC4CD647208E3C24CD223EB11C0E2C5502FE008BC27EBD43` | libs/plugin/plugin.c, libs/plugin/plugin.h |
| P8-WINBACKEND-03-slinktool-access-mode.patch | `6CF7BC5DED092330C0DF2C4A0983F614A7F775184C40C2907C7C4D2AD10DF5F1` | apps/3rd-party/slinktool/src/dsarchive.c |
| P8-WINBACKEND-03-libslink-native-link.patch | `E31526691F793618CBD4337AE49B91561E7CF7FE0A249D2A841E0F49C46E37ED` | libs/3rd-party/libslink/CMakeLists.txt, libs/3rd-party/libslink/statefile.c |

The last two patches are additional low-risk self-contained Windows corrections authorized by the current operator instruction: F_OK=0 for the existing access existence check; transitive ws2_32 linkage and CRT _chsize(fd,0) for the existing truncate-to-zero state-file operation. No dependency upgrade or protocol/scientific algorithm change. All exact diffs are retained in phase8/patches and hashes above.

| Target | Build | Architecture / closure |
|---|---|---|
| scmaster | PASS, exit 0 | AMD64 PE32+, recursive static DLL closure PASS |
| dbstore | PASS, exit 0 | AMD64 PE32+, recursive static DLL closure PASS |
| dbg-delay | PASS, exit 0 | AMD64 PE32+, recursive static DLL closure PASS |
| slinktool | PASS, final exit 0 | AMD64 PE32+, recursive static DLL closure PASS |
| slink | PASS, exit 0 (also rebuilt for slinktool) | AMD64 COFF static archive |
| mseed | PASS, exit 0 | AMD64 COFF static archive |
| slplugin | FAIL, exit 1 | approved C-only packet writer portability advances, C++ plugin_channel still includes blocked shared slutils/time interfaces |
| slutils | FAIL, exit 1 | unistd.h/sys/time.h still unavailable; FlexLexer include problem cleared |
| slarchive | FAIL, exit 1 | sys/resource.h and dirent.h; real glob/resource/directory usages confirmed |
| caps_plugin / seedlink | BLOCKED / NOT BUILT | actual slplugin/slutils prerequisites unavailable |

All focused build commands are *-command.json; actual outputs and exit codes are <target>.log and <target>.exit_code.txt. New executable/DLL header/import dumpbin logs and complete recursive resolution are artifacts/<target>/. Static archives have <target>-coff-headers.log and <target>-artifact.json. Closure PASS means static private import recursion with Windows/API-set boundary, not optional runtime-loaded plugin or application configuration closure.

Newly completed **6 targets: 2 executables, 2 DLL plugins, 2 static libraries**. Core and broker rebuilds are existing targets and are not counted as newly completed. No GUI executable target rebuilt. Binary hashes:

- scmaster: `E89E87E29DCF264DB024047B38D7C810F4938EAF2405D8DF21F9FCD40CB90384`
- dbstore: `8C06B8BC1D66174DF97450D4FA6DC7B12FA29776B70912195FCAC1780D6BBF9C`
- dbg-delay: `17BFB96F315BDE6888AFAED3E91D52243F00B7DF7B72C5F06A99314E383DE096`
- slinktool: `860E48CC2B507C49384DA1C6FB888C55C1E519EB9D01455A861C29C7C8BAAA82`
- slink: `F6B70A9950B20D9EF0EE1DF7FB7ABF22693322923F642FA27F7F600C8ACF5FC5`
- mseed: `B37F561BD32E32D9022868D43744A897D0E2CD5AD4FC6E56A8EBBB7F368A27D0`

Remaining implementation blockers:

1. slutils/slplugin: actual file/pipe/time utilities and mixed readiness. Native Winsock select cannot consume CRT file/pipe descriptors. No fake header, no-op transport or success stub introduced. Native-acquisition-transport-proposal.md is a coherent source-backed architecture proposal for separate approval: typed CRT/HANDLE/SOCKET endpoints, overlapped byte pipes, process/handle whitelisting, child-local FD63 bootstrap in binary mode, partial frames/byte counts, timeout cancellation/error mapping, wall-clock vs wait-clock separation, cooperative stop/escalation and ownership/EOF lifetime. Existing source hashes: transport-source-provenance.json. This design is NOT applied and NOT runtime tested. It includes chain_plugin timed-write call sites, not only SeedLink's main pipe.
2. Confirmed libslink width defect remains: SOCKET is a Windows typedef, but #ifndef SOCKET currently shadows it with int. The separately checked one-line source patch is intentionally UNAPPLIED because it changes the public socket/SLCD ABI and requires architecture approval and all-consumer rebuild. A successfully linked x64 slinktool is not proof of correct socket-width behavior.
3. slarchive: source-backed filesystem/resource/OpenSSL proposal in slarchive-portability-proposal.md. Preserve certificate verification and archive ordering; do not substitute empty directory/glob results. An existing pointer-from-globfree lifetime concern is documented as static inspection, not a runtime/sanitizer result.

Socket-width proposal: `P8-WINBACKEND-03-libslink-socket-width-proposed.patch`, SHA-256 `1220DD0B86AA8ED49EA35F8E7E3025F38A7158985EADE5924C5521E99106B4A2`; git apply --check exit 0, not applied.

Next recommended batch: review/approve the typed acquisition transport and socket-width source patch; implement native slutils/child launch/FD63/readiness/timeout paths as a coherent series and rebuild all acquisition consumers. Independently implement the source-backed slarchive filesystem/resource/OpenSSL group. Then complete slplugin/slutils before CAPS/SeedLink. No messaging source blocker remains in the three requested targets.

Evidence limitation: the first slinktool F_OK failure's complete raw log was overwritten by the next focused build before per-attempt archiving was enabled. Its exact initial compiler diagnostic is retained in initial-slinktool-diagnostic.txt and the tool transcript, not presented as a full log. Subsequent failed link output is preserved in attempts/, and the successful final build has its complete raw log/exit. All build warnings are otherwise retained; no warning/error was suppressed.

Preservation: nine frozen repositories match pinned HEAD/status and tracked-file hashes before/after; protected GUI binaries/staging/manifests/patches and package status unchanged. Original build binaries/libraries were archived with hashes in phase8/baselines/p8-winbackend03-before before rebuilding providers. Exact modified source scope is accounted for by applied.json and preservation.json. No application/service execution, live data, networking, production system access, GUI runtime preflight or scientific-algorithm modification. Engineering build evidence only; numerical/scientific/runtime/release evidence NOT RUN; existing Phase5A gate register remains unchanged. GUI milestone remains 11/11; full native SeisComP installation is not complete.

Updated backend/support inventory totals: {"Already built": 14, "Available but unbuilt": 88, "Blocked by Windows portability": 5, "Disabled by CMake configuration": 6}. Exact rows in backend-target-inventory.json/.csv.
