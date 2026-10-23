# P8-WINBACKEND-07H — Acquisition filesystem and shared-header compatibility

**Engineering progress; no new completed acquisition target. Backend99/120, GUI11/11.** Remaining16 Windows-portability blocked,1 external-dependency blocked,4 disabled. Existing VS2022/MSVC19.44 Release x64 configuration,23 October2026.

## Source/header recovery

Frozen Git ls-tree proves plugins/plugin.h is mode120000, pointing to ../libs//plugin/plugin.h. The Windows file previously held that literal text. It now forwards to ../libs/plugin/plugin.h, a single canonical header; no duplicated packet structures, entry definitions or shared logic. Previously corrected07G CMake mappings compile the original canonical plugin.c. Six requested consumers all reach actual platform headers after repair. symlink-provenance.json records remaining acquisition symlink representations: root plugin.c remains a path-text alias not used by the six repaired consumers (mapped around in07G); other unmigrated consumers are still outside this batch; naqsplugin's separate plugin.c/plugin.h links are outside the six consumers and remain explicitly recorded for that transport's phase. Canonical shared C/header content untouched. Original Linux source ownership is preserved by the equivalent forwarding relationship.

SCREAM ring oscompat.h gains a Windows/MSVC _M_X64/_M_IX86 branch selecting its existing i4 little-endian datatype. No decoding, packet framing or numeric calculation change; original other-platform endian logic unchanged. The unknown-endian and plugin.h text failures disappear; no placeholder socket/time/serial API is added.

## Scanner native implementation and exact integration barrier

Added private windows_files_private.h implements actual GetFileInformationByHandleEx(FileIdInfo) identity with uint64 volume and all16 identifier bytes; no inode cast/hash/path-only surrogate. FileIdInfo errors fail explicitly. Native metadata-target opens share read/write/delete and follow reparse targets like original stat; caller owns handles. Dynamic wide child paths use checked allocation and no cwd change/truncation. Native directory enumeration exposes reparse attributes, retains API order without sorting, handles empty/end/error cases and provides explicit search-handle cleanup. Caller-owned-event timing waits preserve current integer seconds (original tv_nsec=0), chunk long waits without DWORD truncation and report interruption distinctly. No handlers or cancellation policy are installed.

These primitives compile with width assertions (8-byte volume,16-byte file ID), actual compile exit0, AMD64 COFF object SHA-256 `BA9B8E9B5C699281737172A74282670C3A3065DC4CD6A1B738A3CB0B2F45EEE9`. identity-configure/identity-compile command JSON/raw logs and identity.obj-headers.log retained. This is NOT a replacement scanner, runtime proof or new operational target.

Original mseedscan.c remains byte-identical to frozen source. Its FileKey/addfile/keycompare accept ino_t; printfilelist/savestate serialize one %llu inode and recoverstate parses/casts it. This cannot represent volume64+fileID128. A shim would silently discard identity. scanner-contract.md prepares the minimum Windows-only versioned full-ID state/private-key change while retaining POSIX format, original filename discriminator, MiniSEED interpretation, offsets, scan counters and file-update behavior. Legacy state migration/reset must be explicit, never treated as valid Windows identity.

Remaining integration decisions also cover wide rooted traversal instead of chdir/fchdir, same-open-handle identity/data checks for replaced files, reparse cycles/rename behavior at original recursion depth,64-bit Windows offsets, POSIX REG_EXTENDED|REG_NOSUB regex compatibility and existing SIGUSR1/INT/TERM/HUP/PIPE interruption semantics. The entire native regex integration remains unsupported/unapplied, not silently approximated by globbing or ECMAScript. No signal-to-termination policy is invented. The helper is deliberately unwired until those source-level APIs/contracts can represent the required behavior; the actual original scanner build still fails on unistd.h.

## Independent focused target attempts

- scream_plugin: exit1; Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\native-working-copy\src\base\seedlink\plugins\scream_plugin\scream.c(44,10): error C1083: Cannot open include file: 'sys/socket.h': No such file or directory
- scream_plugin_ring: exit1; Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\native-working-copy\src\base\seedlink\plugins\scream2_plugin\dispatch_ring.c(20,10): error C1083: Cannot open include file: 'sys/socket.h': No such file or directory
- win_plugin: exit1; Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\native-working-copy\src\base\seedlink\plugins\win_plugin\win_plugin.c(62,10): error C1083: Cannot open include file: 'sys/time.h': No such file or directory
- echopro_plugin: exit1; Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\native-working-copy\src\base\seedlink\plugins\echopro_plugin\echopro_plugin.c(21,10): error C1083: Cannot open include file: 'unistd.h': No such file or directory
- ewexport_pasv_plugin: exit1; Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\native-working-copy\src\base\seedlink\plugins\ewexport_pasv_plugin\ewexport_pasv_plugin.c(40,10): error C1083: Cannot open include file: 'unistd.h': No such file or directory
- sock_plugin: exit1; Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\native-working-copy\src\base\seedlink\plugins\sockplugin\seedutils.c(15,10): error C1083: Cannot open include file: 'netinet/in.h': No such file or directory
- mseedscan_plugin: exit1; Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\native-working-copy\src\base\seedlink\plugins\mseedscan_plugin\mseedscan.c(45,10): error C1083: Cannot open include file: 'unistd.h': No such file or directory

Exact actual commands/raw logs/exit1 records per target; complete diagnostics in remaining-blockers.json. No unsuccessful target counted as built; consequently target DLL/EXE architecture, entry exports, recursive import/export closure and target SHA-256 are unavailable for this batch. Current compile-only object is explicitly separate.

SCREAM uses real recv/socket/TCP/UDP operations; ring uses sockets and time APIs. Win plugin includes multicast/address/socket/syslog/signal interfaces. Echopro uses actual termios/read serial configuration. Export/socket plugins need native socket/time semantics. Q330/pthread and other larger transport contracts remain as documented07G; no library removal, fake POSIX header, unapproved reactor/process design or protocol substitution. Existing native SeedLink components do not by themselves satisfy those distinct transports.

## Exact patches and preservation

- `P8-WINBACKEND-07H-shared-header.patch`: `E5C41FBE3C8A52A908B1102E8FA9D4D8176DA54FD949D34C75209F6C6766EC40`.
- `P8-WINBACKEND-07H-ring-endian.patch`: `7FDD1448976073AFB48DEBFF61F1BFC670952DB67B3519691B43F5612FE0357C`.
- `P8-WINBACKEND-07H-scanner-native-primitives.patch`: `4A6F23D9BB83480620A48B5BD6E685F18E7AF7F5A6E8A87202500C738758CC3A`.

source-patches.json records source pre/post hashes; scanner and canonical header/source scientific/protocol bodies are untouched. No new dependency. All288 current binaries/import/export products including nested libraries and completed scwfas/scplot/core were archived and hash-verified to completion before compilation. Postchecks preserve all288 current/archive copies, 1758 protected prior files/stages, nine frozen HEAD/status/file vectors and installed dependency hashes. verification.json records exact evidence. No rebuilt provider or staging update; no mixed provider revision.

Frozen superproject9c395c7f00c788c5fc640363abe97b9ced0b44b0,mainf63cde995e04151dc816151359a036b8b15f6019,common92d2202a6065aad36ae7d4a9bf960b6fb91222d2. Historical pre-06C1 config DLL preimage custody remains INCOMPLETE;07A Tau prebuild hash remains unavailable;07E3 overlap remains recorded. No retroactive recovery, Phase7 changes, ew2sc modification, process-helper/cancellation changes or reopened completed subsystem. All existing GUI/controller/database/QC/locator/process stages preserved.

## Inventory, next priority and evidence gates

Canonical CSV/JSON,status and patch ledger updated with genuine blockers; counts remain99 built,16 Windows-blocked,1 dependency-blocked,4 disabled. Next focused workstream: the minimal Windows scanner state/private-key plus regex/notification contract in scanner-contract.md, then integrate the compiled native primitives. Subsequent serial/socket/thread contracts should be specific to each existing plugin; do not redesign working SeedLink/CAPS.

| Phase5A gate | State | Evidence/exit | Limitation |
|---|---|---|---|
| A: Source + Phase4C | NOT_RUN as full gate | before.json;verification.json | Frozen custody checked; broad audit not repeated |
| B: Transitive closure | NOT_RUN as full gate | seven focused targets exit1; native primitive object compile0 | No completed acquisition binary |
| C: Linux original oracle | NOT_RUN | None | No science fixture |
| D: Native original Autoloc offline execution | NOT_RUN | None | No application/plugin execution |
| E: Replay equivalence/robustness | NOT_RUN | None | No runtime/filesystem/numerical tests |

Linux/Windows scientific fixtures and numerical difference matrix NOT_RUN; origin/time/location/depth/association differences unavailable. No scanner filesystem traversal, acquisition, database/network, GUI/controller or scientific execution. Only compilation/static checks and source preparation. Phase5A **PARTIAL**; no functional, scientific or release qualification claimed.
