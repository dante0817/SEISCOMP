# P8-WINBACKEND-07C — isolated native database qualification preparation

Stage **PREPARED**, harness **BUILD PASS / RUNTIME NOT_RUN**. No plugin, harness, application, GUI, server, database connection, transaction or scientific replay was executed. Independent acquisition work also completed **scardac**, raising backend inventory to **82/120 built** (21 Windows-blocked, 13 dependency-blocked, 4 disabled); GUI 11/11.

## Database stage and DLL strategy

New stage: `Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\staging\database-07c-native`. It contains 20 original/selected private DLLs, both original 07B adapters, core/config, libpq, PostgreSQL libintl/iconv support, approved OpenSSL/libxml/other dependencies, original sqlite3.sql/postgres.sql, SQLite static-library/license provenance, harness executable/source, capability/dependency/identity manifests and a SHA-256 manifest. No previous stage was overwritten. The Y: project stage is provenance/preparation only; proposed runtime root C:/P8-07C/database-native requires an exact copy into an approved local NTFS sandbox/VM. The copy and isolation are not created/admitted; SQLite must not run on the mapped/shared project drive.

One selected DLL per basename is colocated in bin. Differing PostgreSQL-shipped providers are excluded in favor of the exact existing SeisComP/vcpkg provider graph qualified in 07B. All matching 07B source hashes were checked before copying. SQLite remains statically linked; no SQLite DLL substitution. `manifests/dependencies.json` retains exact source/provider identities and collision decisions. OS/API-set/installed VC runtime dependencies remain external; no global PATH/package/library modifications.

Prepared launcher verifies an externally approved manifest SHA, every staged input hash and the exact DLL list. It runs in stage/work with temporary process environment settings restored afterwards. The native harness uses absolute LoadLibraryEx paths and restricted DLL search, invokes original createSCPlugin and DatabaseInterface factories, then checks actual loaded private module paths against stage/bin. Pre-main core dependencies are colocated with the executable. These runtime path checks are compiled but **NOT RUN**; successful static closure is not actual loading proof. The launcher is not a sandbox; runtime approval must admit filesystem/process/network isolation. No execution-policy bypass is prepared.

Stage SHA256SUMS.json SHA-256: **E9372089B3576BE531346FC2312741D293132087F971A9B846C97399920D4D07**.

## Harness readiness and SQLite status

Source: `phase8/database-qualification07c/qualify.cpp`; isolated VS2022 Release x64 build uses existing core imports without rebuilding providers. Configure and final compile/link exit0. Prepared checks use original DatabaseInterface, DatabaseArchive, DatabaseObjectWriter, Pick and Origin. No replacement adapter/API or dummy registration.

Modes: `--plugins` loads both adapters, calls createSCPlugin, checks original factory names and loaded provider paths without connecting. `--sqlite` loads SQLite only, creates the fixed disposable work/qualification.sqlite with CREATE_NEW (refuses existing file), executes the unchanged original schema, checks version0.14.0, commit/rollback, original Pick/Origin insertion/retrieval through a new archive after reconnect, invalid SQL, missing-file failure and disconnect cleanup. Synthetic values test database serialization only. Modules stay loaded until process exit to preserve static-factory lifetimes.

SQLite checks: **PREPARED / NOT RUN**. No database file exists from this batch. Executable commands, working directories, expected output logs, failure/cleanup conditions are in `prepared-commands.json`, stage README, run-approved.ps1 and cleanup-prepared.ps1. Failed future runs retain raw logs/database; explicit cleanup only removes four fixed SQLite files after hashes are retained.

Harness SHA-256: **1AD66EB093BBF39B231C8BF40924E71D3FD5951BEF97C04A0F12258FD433DA2C**. New harness patch SHA-256: **23D55C330B4CD8907C09A0AF72220AF41DC587701FEB257A2838D9A938B3F0EF** (`phase8/patches/P8-WINBACKEND-07C-database-qualification-harness.patch`).

## PostgreSQL qualification preparation

PostgreSQL profile: `profiles/postgresql-prepared.json`; exact VM command templates: `profiles/postgresql-commands.txt`. Matching native libpq18.1/selected TLS dependencies staged. Proposed boundary is a disposable Windows VM/private virtual network, dedicated18.1 cluster, fixed test-only NIC/port55432, throwaway SCRAM role/database, original destructive PostgreSQL schema only inside that disposable database, and scoped start/stop/cleanup. Localhost alone is explicitly insufficient. Credentials, HBA hashes and TLS certificates still need runtime-boundary approval; no shared/production server permitted.

PostgreSQL status: **PROFILE PREPARED / CONNECTION NOT RUN**. The compiled driver intentionally has no PostgreSQL connection mode. Original DataModel PostgreSQL round-trip implementation remains a future harness extension; the profile lists transaction/reconnect/schema/auth/TLS cases. No server/client commands were executed.

## Independent backend implementation

After preparing the database path, completed scardac's localized Windows compile blocker. Windows uses exported Core::msleep(1000) for each of the original five one-second reconnect iterations; exit polling, connection behavior and the Linux branch remain unchanged. Non-Windows source projection matches the preimage exactly. Focused existing Release x64 project build exit0 used BuildProjectReferences=false against the already qualified providers and TrackFileAccess=false for the previously documented tracker-path issue. No prerequisite compiler/linker error was suppressed. No app was run.

Source patch SHA-256 **70D9ADA6F34D4D7D390169295B4D98F5007AF5A700A64494B8101368E759B354** (`phase8/patches/P8-WINBACKEND-07C-scardac-wait.patch`). scardac SHA-256 **DEC679B8AE73AB06CE2CF0607B61F162FDED62929F72E84604BEA9F45855534F**. `scardac-patch.json` records source pre/post hashes, reverse-check and scope. `artifacts.json` records both executable AMD64 PE32+ identities, all named private import/export comparisons and recursive static closure. This is one new operational inventory target; the qualification executable is excluded from that inventory.

## Preservation and limitations

All 243 prebuild outputs, including nested Tau, SQLite and original 07B DLL/import libraries, remain unchanged. All 1101 protected prior stage/patch/baseline files and nine frozen HEAD/status/hash vectors are unchanged. Original SQL files and 07B PostgreSQL postimage unchanged. Historical pre-06C1 config DLL custody stays **INCOMPLETE**; historical 07A Tau prehash exception remains and is not retroactively repaired. Existing controller/GUI stages untouched.

Runtime blockers: separate explicit operator authorization and an admitted isolation boundary; actual plugin loader behavior, SQLite/schema/transaction/object checks unexecuted; PostgreSQL additionally requires its disposable server boundary and a future DataModel harness mode. No unavailable runtime test is PASS. No whole-install or scientific/release claim.

## Gate register and next priority

| Phase5A gate | State | Scope/limit |
|---|---|---|
| A: Source + Phase4C | NOT_RUN full gate | Focused preservation checked; Phase4C not repeated |
| B: Transitive closure | NOT_RUN full gate | Focused static PE/named-import closure PASS; runtime loader NOT_RUN |
| C: Linux oracle | NOT_RUN | No fixture/application |
| D: Native offline Autoloc | NOT_RUN | No application execution |
| E: Replay equivalence | NOT_RUN | No scientific replay/numerical difference values |

Phase5A **PARTIAL**. Continue core seismic/backend completeness and the exact pinned QC Signals2/Parameter closure when dependency provisioning is authorized; broader acquisition process/IPC contracts remain separate. scardac progress demonstrates independent work can proceed while database runtime remains unapproved. No controller expansion or ew2sc deadline change.
