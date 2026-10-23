# P8-WINBACKEND-07B — native database backend

Two new targets built: **dbsqlite3 and dbpostgresql**. Inventory: **81/120 built**, 22 Windows-portability blocked, 13 dependency-blocked, 4 CMake-disabled; GUI 11/11. Database runtime/persistence remains NOT_RUN.

## Build/link inventory

Original database subdirectory and original SeisComP macros are invoked by `phase8/database-native07b/CMakeLists.txt`. Separate VS2022/MSVC 19.44 Release x64 build: `phase8/build/database-native07b`. The completed main build tree and imported core/config providers were not rebuilt. Configure exit 0; dbsqlite3 exit 0; final dbpostgresql exit 0. Exact invocations and raw output: `configure-command.json`, `dbsqlite3-command.json`, `dbpostgresql-format-fix-command.json` and matching logs/exit files.

| Target | Dependency | Result and SHA-256 |
|---|---|---|
| dbsqlite3 | Approved static SQLite 3.54.1, /MD, SQLITE_THREADSAFE=1 | exit 0, AMD64 PE32+; 4095FC80F736903B133E9ABC04751FA264EE433C016848EF5DDD83FC2E23E3EC |
| dbpostgresql | Installed PostgreSQL 18.1 MSVC x64 libpq SDK | exit 0, AMD64 PE32+; 4FC857027CB1CB919FBF7F696A9B2BFB602319DC5189317554259189BB970739 |
| dbmysql | No matching client SDK qualified in configured roots | CMake-disabled; not built |

Both DLLs export `createSCPlugin`; the original compiled factory registrations are `sqlite3` and `postgresql`. `artifacts.json` records PE headers, all hashes, 23 successful private consumer/provider named-import comparisons, and recursive static closure to Windows/API-set boundaries. Original plugin sources and build definitions are used. Runtime registration/loading is not verified.

PostgreSQL's SDK ships different same-named OpenSSL/libxml provider DLLs. The qualified static graph selects the existing SeisComP/vcpkg providers and records every alternate and hash; all required named imports resolve in that graph. PostgreSQL supplies libpq/libintl-9/libiconv-2 where required. No PATH changes or dependency copying were made; deployment must preserve this exact provider selection. Static ABI checks do not prove runtime compatibility or TLS operation.

SQLite adapter APIs link against the existing approved archive. Its threading and CRT configuration match this build. SQLITE_OMIT_LOAD_EXTENSION=1 is inherited from the approved dependency: extension-loading SQL is unavailable; no adapter code requests that API. Existing-file checks, URI options (sync, busy_timeout, journal), SQL execution, transactions, row values and original schema are unchanged. No database/schema was created or opened.

## Pinned source / patch provenance

One authorized Windows mechanical correction: the affected-row scan used `%lu` for uint64_t, producing MSVC C4477 because Windows unsigned long is 32 bits. The Windows branch now uses SCNu64, preserving the original trailing literal and the original Linux branch. No transaction, schema, query, serialization or scientific algorithm changes. The initial successful build/warning log and pre-correction DLL/import libraries are retained; the final build clears C4477.

- Source patch: `phase8/patches/P8-WINBACKEND-07B-postgresql-count-width.patch`; SHA-256 **23B0813DD88EA7780C1AF5BFE4A30562B0A8CD3913C8C38D42715778AD568F18**. Source pre/post hashes, user 07B mechanical-portability authorization and reverse-check exit 0 are in `patch.json`.
- Independent build-harness addition: `phase8/patches/P8-WINBACKEND-07B-isolated-database-build.patch`; SHA-256 **AB1D466F3AC5C81010B84EE7FC0D0FE38CEB149442FF438BD81CF15C8BFC498D**. Original upstream CMake remains unchanged; `build-harness.json` records harness/source identity.

## Database integration capability matrix

| Component | Original source/build capability | Remaining qualification |
|---|---|---|
| DatabaseInterface | Factory Create(service); Open(scheme://parameters); sqlite3/postgresql factory names preserved; absent scheme defaults to mysql | Load plugins and exercise connections separately |
| scmaster / dbstore | Existing built broker processor selects driver/read/write configuration and creates original DataModel::DatabaseArchive for notifiers | Driver DLL deployment, schema, transactions and persistence untested |
| scdb | Existing built ObjectWriter/DatabaseArchive storage and separate write URI | SQLite/PostgreSQL end-to-end behavior untested |
| scardac | Original workers open DatabaseInterface and store data availability | Existing POSIX sleep blocker remains; untouched |
| Inventory / Pick / Amplitude / Origin / Magnitude / Event | Original core DatabaseArchive and sqlite3.sql/postgres.sql schemas retained; Schema-Version lookup retained | Matching original schema, references and storage round trips untested |

Exact source references/configuration contracts: `database-capability-matrix.json`. No operational configuration was edited.

## MySQL/MariaDB qualification and next build plan

No mysql.h/errmsg.h plus matching native import library/DLL was qualified in vcpkg, project dependency tools or the named Program Files MySQL/MariaDB roots. This is not an assertion about every possible file on the machine. `dependency-qualification.json` lists source ABI/TLS requirements and the plan: select an operator-approved exact native MSVC x64 Connector/C/MySQL client release, pin headers/import-library/DLL/license/source hashes, check version/MariaDB branches and all private dependencies, configure original MYSQL_INCLUDE_DIR/MYSQL_LIBRARIES, then build original dbmysql separately. No download/install/upgrade was performed.

## Preservation and custody

Before compilation, **237 Release outputs** were archived and hash-verified, including nested Tau and the approved SQLite static archive. All are unchanged after compilation. All 1099 protected prior stage/patch/baseline files and nine frozen repository HEAD/status/hash vectors are unchanged. Only the recorded PostgreSQL source correction changed in the database source set. Existing GUI/controller/06F stages were untouched. `preservation.json` contains the current batch checks.

Historical pre-06C1 config DLL custody remains **INCOMPLETE**. The 07A Tau prebuild-hash exception remains historical and is not retroactively repaired by the 07B preimage archive.

## Gate register

| Gate | State | Evidence and limitation |
|---|---|---|
| A: Source + Phase4C evidence | NOT_RUN as full gate | Focused source custody checked; Phase4C not repeated |
| B: Transitive dependency closure | NOT_RUN as full gate | Focused two-plugin static closure/named imports PASS; entire installation/runtime closure unqualified |
| C: Linux original Autoloc offline oracle | NOT_RUN | No fixture or application run |
| D: Windows native original Autoloc offline executable | NOT_RUN | No application or runtime extension execution |
| E: Replay equivalence and robustness | NOT_RUN | No scientific replay or numerical measurements |

## Linux / Windows fixture provenance and numerical differences

No fixture consumed, server started, database transaction, application, controller, GUI, service, live acquisition, network connection or scientific replay executed. No numerical comparison data exists for this batch. Existing scientific caveats and Phase4C findings are not requalified. Warnings are retained in raw logs and `warnings.json`.

## Evidence gaps and final assessed milestone

Phase5A **PARTIAL**. This completes native compilation/static qualification for two original database adapters. Persistence, plugin loading, schema/migration behavior, rollback, concurrency, reconnect and TLS remain untested. Initial verification harness collisions/summary parsing were corrected before final exit-0 verification; no plugin behavior was altered for verification. No release qualification is claimed.

Recommended next phase: prepare an explicitly isolated database runtime qualification boundary with original schemas and object round-trip/transaction cases for these two adapters; separately close the MySQL client dependency. Continue core automatic-processing/backend dependencies and the QC Signals2 closure, rather than expanding controller features.
