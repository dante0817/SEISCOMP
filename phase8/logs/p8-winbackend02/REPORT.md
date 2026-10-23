# P8-WINBACKEND-02 report

## P8-WINBACKEND-02 — messaging/acquisition batch — 22 October 2026

Applied only the exact approved patches after SHA-256, exact file/line scope, git apply --check, application, reverse-check and expected postimage verification:

| Approved patch | SHA-256 | Changed file |
|---|---|---|
| Wired helper export | 54FF3D32B9992084624AF4A7C694A515E0DEDC681EA69FBF56555B14529D7267 | common/libs/seiscomp/wired/devices/socket.h (one export annotation) |
| CAPS imported targets | 8CC6483AB8D20C6EB669770EFDD4593ACBE44ED3EEBDB5A9AFAE6DA100E05863 | seedlink/plugins/caps_plugin/CMakeLists.txt (two link inputs) |

Patch provenance/check/application records: logs/p8-winbackend02/{common,seedlink}-{check,apply,reverse-check,patch}.json. Exact applied patch copies: patches/P8-WINBACKEND-02-approved-{wired-export,caps-openssl}.patch.

| Target | Result | Evidence / independent root |
|---|---|---|
| seiscomp_broker | PASS, focused exit 0; **one newly completed target** | seiscomp_broker.log/.exit_code.txt; original broker build success also in scmaster.log |
| scmaster | FAIL, exit 1 | scmaster.log/.exit_code.txt; LNK1120: 8, missing Wired interfaces and application-local ServerStatistics destructor/vtable incorrectly imported from broker DLL |
| dbstore | FAIL, exit 1 | dbstore.log/.exit_code.txt; getConfig<bool> and getConfig<std::string> missing from core DLL imports |
| dbg-delay | FAIL, exit 1 | dbg-delay.log/.exit_code.txt; unistd.h missing; source uses POSIX usleep |
| caps_plugin | BLOCKED, configure/generate exit 1 | configure.log/.exit_code.txt; OpenSSL::Crypto target not created in CAPS directory scope by legacy FindOpenSSL.cmake |
| seedlink | BLOCKED / executable NOT BUILT | seedlink-dependency-block.json; slplugin failed; independently inspected slutils also failed |
| slarchive, slinktool | BLOCKED / executables NOT BUILT | corresponding dependency-block.json; shared slink failed |
| slplugin | FAIL, exit 1 | slplugin.log/.exit_code.txt; plugin.c:17 unistd.h missing |
| slink | FAIL, exit 1 | slink.log/.exit_code.txt; D8021: GNU -Wno-incompatible-pointer-types passed to MSVC |
| slutils | FAIL, exit 1 | slutils.log/.exit_code.txt; utils.cc/conf_xml.cc unistd.h, utils.h sys/time.h, generated scanner FlexLexer.h |

No new executable completed; one new support DLL (broker) completed. Existing core DLL rebuilt as required by the approved export; it is not counted as a new target.

Broker: AMD64 PE32+, SHA-256 `44ED78346E48127A234A3794C17BA0BB114BF7DF56EABDBCE338EFA2262E69A3`; recursive static private DLL closure PASS at Windows/API-set boundary. Rebuilt core: AMD64 PE32+, SHA-256 `AD01A1EF3DE078AAAC3350DE448FD0A2F4481F95341DA518B1641AC45A0436B9`, same static closure PASS. Raw dumpbin headers/dependents and recursive records: logs/p8-winbackend02/artifacts/{seiscomp_broker,seiscomp_core}/. Runtime NOT RUN; optional runtime-loaded plugins are outside static closure.

Release OpenSSL verification for CAPS **BLOCKED**, not PASS. The reviewed two-line patch depends on imported targets that the local legacy module does not define. Fresh regeneration failed; caps-release-linkage.json preserves generated link fields but they are not accepted as valid inputs. Configuration remains generation-blocked pending the proposed Windows CONFIG-discovery correction. No debug dependency silently accepted; no dependency upgrade. Existing core/broker Release artifacts were built before this CAPS generation failure with Release OpenSSL paths as previously audited.

After the unrelated CAPS generation failure, independent acquisition prerequisites were built directly through existing VS Release x64 projects with BuildProjectReferences=false. Their actual project dependencies were explicitly scheduled in order; global ZERO_CHECK regeneration alone was omitted. This is recorded in *-command.json. No compiler or linker errors were suppressed, no /FORCE, and no missing prerequisite was treated as successful. SeedLink/archive executable targets were stopped at failed prerequisites. Broker's focused exit-0 record uses the same existing-project route with its successfully built dependencies.

Follow-up **unapplied** proposals (all exact file scopes and git apply --check exit 0 in proposals.json):

- `P8-WINBACKEND-02-scmaster-linkage-proposed.patch` — SHA-256 `66F5D0727427E46145966C3B0CB37251AA866FCE693D7117F5CE4E39C4AB9F80`. Export five currently unresolved Wired interfaces from their core provider; remove broker dllimport annotation from application-local ServerStatistics. No algorithm changes.
- `P8-WINBACKEND-02-settings-exports-proposed.patch` — SHA-256 `464D14492917BD3901B8D878D107442FDBBC960D86FC3527B8062CEFAB4056F3`. Declare existing int/bool/string getConfig specializations as exported/imported. dbstore currently needs bool/string; dbg-delay fields use int. Existing implementations preserved.
- `P8-WINBACKEND-02-dbg-delay-msleep-proposed.patch` — SHA-256 `3C5D312A828C2C167D1BD97B0AB519EE8441D5E781477B47F4647F8EA06FBF70`. Use existing exported Core::msleep in milliseconds on Windows; retain POSIX code elsewhere.
- `P8-WINBACKEND-02-acquisition-cmake-proposed.patch` — SHA-256 `E6BBA67F8EB0506723BFB0E66E29D79E4C61078011ED82BED839E898BCFC0E15`. Create OpenSSL imported targets in CAPS scope using existing Windows CONFIG discovery pattern; limit GNU/Clang-specific C flag to supported compilers. No library/version changes.
- `P8-WINBACKEND-02-slutils-flex-header-proposed.patch` — SHA-256 `68703BA74247828CE1A7D597166C1E5DFB0EA88BA1431A85163B0F2D62EAB0A9`. Expose the already approved project-local FlexLexer.h beside configured win_flex.exe; no new dependency.
- `P8-WINBACKEND-02-slplugin-crt-write-proposed.patch` — SHA-256 `0BD601A349495CE6DC4CD647208E3C24CD223EB11C0E2C5502FE008BC27EBD43`. Windows native CRT _write for the same bounded packet descriptor writes; explicit int32_t and signed byte-count types. Retain POSIX path. Does not implement parent/child FD 63 inheritance or validate packet ABI.

slutils additionally requires a native descriptor/timeout design: CRT file/pipe descriptors cannot be passed to Winsock select. Replacing sys/time.h with Winsock or adding a success stub would not preserve semantics. slutils-native-port-proposal.md records source-backed boundaries for read/write, timed pipe writes, wall-clock Timer, XML file descriptors and syslog. The Flex header proposal fixes only its independent include-path problem. Native parent/child FD 63 inheritance and packet ABI are unvalidated.

Next implementation batch: approve the acquisition CMake discovery/compiler-flag correction to restore generation; approve grouped messaging export/ownership, settings specializations and dbg-delay sleep patches; rebuild messaging and plugins. Then approve/implement native acquisition descriptor transport and Flex include correction; retry acquisition prerequisites before dependent executables.

Preservation: all nine frozen repos match pinned HEAD/status and full tracked-file SHA-256 before/after. Prior GUI executables/staging/manifests/patches and vcpkg status unchanged. Original Release binaries/libraries copied and hash-verified in phase8/baselines/p8-winbackend02-before before the required core rebuild. Only the two approved tracked source files changed. Evidence: frozen-before/after.json, archived-build-baselines.json, protected-before.json, working-source-before.json, preservation.json. No application/service execution, networking, production connection, GUI runtime preflight or scientific-algorithm modification.

Engineering evidence only. Numerical/scientific/runtime/release evidence NOT RUN; Phase5A gates unchanged. GUI executable build milestone remains 11/11. Full SeisComP installation/completion is not claimed.

Updated non-GUI inventory totals (native applications, DLLs and static support targets plus six disabled source entries): {"Blocked by Windows portability": 10, "Already built": 8, "Available but unbuilt": 89, "Disabled by CMake configuration": 6}. Exact rows: logs/p8-winbackend02/backend-target-inventory.json and .csv.

