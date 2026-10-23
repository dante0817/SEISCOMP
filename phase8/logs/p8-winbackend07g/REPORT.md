# P8-WINBACKEND-07G — Mechanical native backend progress

**Two new targets complete; backend99/120, GUI11/11.** Remaining16 Windows-portability blocked,1 dependency-blocked,4 CMake-disabled. Existing VS2022/MSVC19.44 Release x64 configuration,23 October2026. No application/plugin, network/database, GUI/controller, acquisition or scientific execution.

## Successful focused builds

- scwfas: exit0, AMD64 PE32+, SHA-256 `4B898422D991F3FC3F73B16E5259830EE324B5CE312CFFD46177DCA2F4370FCE`.
- scplot: exit0, AMD64 PE32+, SHA-256 `C576C2AE60522F437714610A1DCC0EF60F0C62A69E1D8372977FAAC3B53F719D`.

Actual commands/raw warnings/exits retained as target-command.json, target.log and target.exit_code.txt. Static AMD64 PE32+, recursive DLL resolution and24 private named export/import pairs pass; artifacts.json and raw dumpbin logs contain exact graph/provider hashes and Windows/API-set/VC-runtime boundary. Application targets do not require plugin factories. No runtime or dynamic discovery claim.

## Compatibility corrections

scwfas guards POSIX strings.h and maps bounded comparison to _strnicmp on Windows. All actual call sites compare exactly three ASCII numeric bytes (404 or204); same length bound, NUL-stop/equality and digit behavior apply, without locale-sensitive alphabetic differences. Session had no such comparison use. First link then exposed missing existing SDSArchive constructor and URLInsituOptions::next/nameEquals exports. Windows-only declarations now use the existing SC_SYSTEM_CORE_API; core alone rebuilt exit0, then scwfas linked. Every previous core export remains (core-export-compatibility.json); only three existing methods added. No HTTP/FDSNWS algorithm/protocol or provider interface redesign.

scplot's two original mkstemp calls use a private Windows implementation: rand_s supplies each suffix character; _sopen_s uses O_CREAT|O_EXCL|O_RDWR|O_BINARY|O_NOINHERIT and original file permission/lifetime handling. Exclusive creation is atomic, collision retries bounded128, failures return-1/errno into original diagnostics. No existence-check/create race, predictable generated filename, zero-filled data or delete-on-close change. Original data writes, stored filenames and later cleanup retained; original POSIX mkstemp untouched. Runtime uniqueness/cleanup not executed.

Q330 CMake retains original warning flag on non-MSVC compilers and omits it for MSVC only; regenerated project now reaches genuine source errors instead of D8021. No warning suppression or linker forcing added.

Frozen SeedLink Git mode120000 proves plugins/plugin.c was a symlink with text ../libs//plugin/plugin.c. Six authorized consumer CMake files now name ../../libs/plugin/plugin.c directly, eliminating Windows path-text compilation without divergent source copies. Windows consumers link existing slplugin/native dependency closure. This retains the exact shared implementation, packet contracts and original Linux source identity. shared-source-provenance.json records hashes/generated mapping; consumers still fail on their independent source contracts. Modern MSVC uses its existing C99 snprintf instead of SCREAM's obsolete conflicting macro; older/non-MSVC branches retained.

## Attempted but still blocked

- q330_plugin: exit1; Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\native-working-copy\src\base\seedlink\plugins\q330plugin\q330_plugin.cc(24,10): error C1083: Cannot open include file: 'unistd.h': No such file or directory
- mseedscan_plugin: exit1; Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\native-working-copy\src\base\seedlink\plugins\mseedscan_plugin\mseedscan.c(45,10): error C1083: Cannot open include file: 'unistd.h': No such file or directory
- echopro_plugin: exit1; Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\native-working-copy\src\base\seedlink\plugins\echopro_plugin\echopro_plugin.c(21,10): error C1083: Cannot open include file: 'unistd.h': No such file or directory
- ewexport_pasv_plugin: exit1; Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\native-working-copy\src\base\seedlink\plugins\ewexport_pasv_plugin\ewexport_pasv_plugin.c(40,10): error C1083: Cannot open include file: 'unistd.h': No such file or directory
- scream_plugin: exit1; Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\native-working-copy\src\base\seedlink\plugins\plugin.h(1,1): error C2059: syntax error: '.'
- scream_plugin_ring: exit1; Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\native-working-copy\src\base\seedlink\plugins\scream2_plugin\oscompat.h(112,1): error C1189: #error:  Unknown endianness
- sock_plugin: exit1; Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\native-working-copy\src\base\seedlink\plugins\sockplugin\seedutils.c(15,10): error C1083: Cannot open include file: 'netinet/in.h': No such file or directory
- win_plugin: exit1; Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\native-working-copy\src\base\seedlink\plugins\win_plugin\win_plugin.c(62,10): error C1083: Cannot open include file: 'sys/time.h': No such file or directory

Full independent diagnostics in remaining-blockers.json and per-target raw logs. Q330 additionally includes syslog.h,pthread.h,sys/resource.h and links pthread; its transport/thread/runtime contract cannot be replaced by removing headers. Echopro actually uses termios/read serial operations. Export/socket consumers require genuine socket/select/time portability, not placeholder header stubs. SCREAM still requires POSIX unistd/sys/time, with ring endian detection also unresolved; snprintf conflict itself is repaired. Win plugin requires POSIX time/network behavior.

mseedscan's unistd is functional: scans open directory descriptors, chdir/fchdir, enumerate dirent entries and use d_ino as persistent file keys; it also relies on regex.h, nanosleep and signals. A correct native port must define stable file identity, reparse/symlink handling, ordering, directory restoration, regex equivalence and signal/interruption timing. No unused-include deletion or lossy Sleep substitution was applied. No FIFO replacement, serial/socket reactor or major IPC redesign attempted. These exact contracts need the next focused phase.

## Exact source patches

- `P8-WINBACKEND-07G-1-scwfas-fdsnws.cpp.patch`: `CED8CF3DA2AB53DCBA8146AF3974E88EAF246961088D747DBE94ACB861025176`
- `P8-WINBACKEND-07G-2-scwfas-session.cpp.patch`: `160C23AC32B0B1D3EBFE3A2D881DD797A901B9287D12AAB048A21C1FED702FCA`
- `P8-WINBACKEND-07G-3-q330plugin-CMakeLists.txt.patch`: `9FA775842BA4263D84D34281BCF568073746822ADCD95016768826828D475308`
- `P8-WINBACKEND-07G-4-scplot-gnuplot_i.c.patch`: `6367E46B5EE191E9FBFFCB89DBBB857AF23397D1D10AA2513150B7A1BDA87F63`
- `P8-WINBACKEND-07G-5-echopro_plugin-CMakeLists.txt.patch`: `14D9C1F9B7E5E93D7A9EE8375B7CDE1B73CB099F4C5167004ECAB360A0657DD1`
- `P8-WINBACKEND-07G-6-ewexport_pasv_plugin-CMakeLists.txt.patch`: `4C05C3743675AAF3D1477BCD095D0EDAEE3D085F79F939F7DB2EA6EC49A2A633`
- `P8-WINBACKEND-07G-7-scream_plugin-CMakeLists.txt.patch`: `2F0839E2BD5B62936BEFC9EEF596EA60EC44097A5AB4CB7D54D4F12ADFC79237`
- `P8-WINBACKEND-07G-8-scream2_plugin-CMakeLists.txt.patch`: `8CFEACA9C3CFF28E6346BF7C55BC662D9D5FBF5FB487E820EA44AA3CF69C8210`
- `P8-WINBACKEND-07G-9-sockplugin-CMakeLists.txt.patch`: `D326CB289E58337A0A5B7B7EB7D0AB04DB4E7D17558AF01D9EE0B77361C0D708`
- `P8-WINBACKEND-07G-10-win_plugin-CMakeLists.txt.patch`: `A64D1CAD0177675063237784D90BF14B5FEC2705472FC15E3A96856224C53416`
- `P8-WINBACKEND-07G-11-recordstream-sdsarchive.h.patch`: `42A2F90D69C5B77CBFEE9D62D943D2B8EF3A3520BD519A53281B90451D075F7C`
- `P8-WINBACKEND-07G-12-protocols-http.h.patch`: `697441D723634EC08CA326A341077CCF720EBD2A7EC4450A96BF81F6BE26A903`
- `P8-WINBACKEND-07G-13-scream_plugin-oscompat.h.patch`: `70F9E7F4277AB370F0FBF5818E197FB4BAEFAFD28430359CD6D34054648327B0`
- `P8-WINBACKEND-07G-14-scream2_plugin-oscompat.h.patch`: `C7CC5F03822F66CECE73C32A528AB284104CE806EBE65D620EF2C6060A08D3A0`

source-patches.json records source pre/post hashes and preimage references (original frozen SeedLink CMake definitions where applicable); source headers retain licensing. build-products.json and artifacts.json record completed artifacts/current providers; before.json and binary-before retain original products. No scientific calculations, packet framing/timing, network configuration or original POSIX behavior changed.

## Preservation and custody

Archive286 prior binaries/import/export outputs including nested Tau/SQLite and completed process targets finished/hash-verified before any compilation. Final verification preserves all archive copies and1646 protected prior files/stages plus nine frozen HEAD/status/file vectors. Only seiscomp_core.dll/.lib/.exp changed; exact pre/post hashes in artifacts.json, originals in binary-before. No stage updated with the new core; prior stage revisions remain matched. Existing controller/Python/database/QC/locnll/scwfparam/locext sources and private process helper are unchanged; no provider other than proven core dependency rebuilt. Required CMake regeneration performed; no solution/Qt rebuild. Installed dependencies/status unchanged.

Frozen superproject9c395c7f00c788c5fc640363abe97b9ced0b44b0,mainf63cde995e04151dc816151359a036b8b15f6019,common92d2202a6065aad36ae7d4a9bf960b6fb91222d2. Pre-06C1 config custody remains INCOMPLETE;07A Tau prebuild hash unavailable;07E3 archive/build overlap remains recorded. No retroactive repair claims, Phase7 changes, dependency upgrades, cancellation/STOP/reload expansion or ew2sc deadline modification.

## Inventory, next work and gates

Canonical CSV/JSON,status and patch ledger updated:99 built,16 Windows-blocked,1 dependency-blocked,4 disabled. Next batch should define scanner file-identity/traversal semantics and focused native serial/socket/thread contracts; do not redesign working SeedLink/CAPS or reopen completed controller work. Boost.Asio and disabled dependencies remain separate version-pinned decisions.

| Phase5A gate | State | Evidence/exit | Limitation |
|---|---|---|---|
| A: Source + Phase4C | NOT_RUN as full gate | before.json/artifacts.json | Required custody checked; broad audit not repeated |
| B: Transitive closure | NOT_RUN as full gate | focused builds exit0; static closure | Whole-install/runtime incomplete |
| C: Linux original oracle | NOT_RUN | None | No scientific fixture |
| D: Native original Autoloc offline execution | NOT_RUN | None | No application execution |
| E: Replay equivalence/robustness | NOT_RUN | None | No numerical/runtime tests |

Linux/Windows scientific fixtures and numerical difference matrix NOT_RUN (origin counts,time/location/depth/association differences unavailable). Phase5A **PARTIAL**: native engineering build/static progress only; scientific parity,runtime behavior and release qualification remain unverified.
