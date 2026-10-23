# P8-WINBACKEND-07L — Original Tau generation and resource completion

**Four original Tau resources generated and structurally validated; revision3 assembled.** Four generator invocations exited0. Backend101/120,GUI11/11,Python12/12 unchanged. Revised candidate150 native PE files,839 manifested files,389 unchanged private provider relationships. Only original Tau generators executed; application runtime,Tau reader loading and Linux scientific comparison **NOT_RUN**. 24 October2026,Windows x64.

## Exact inputs,commands and execution

07L explicitly authorizes this narrow offline generation. Reused07K's prepared original remodl→setbrn sequence; no model search,alternate tables,download,rebuild or scientific source change. Verified original input hashes:

- iasp91.tvel: `AD21E7461335934F8D23A87F12AC778DF69A714CC11E220230EBAAE5EA4C853F`
- ak135.tvel: `5E8CF23E32014E28539566CB94BE78692995E79BC873BE3843B892665B962481`
- tau_remodl.exe: `96F3C8621DE492080ABBEF34A37E3CC2BE633B908CB582F0B4A109DC2C52F2EA`
- tau_setbrn.exe: `E0DBA60B30C0ED3E8A8216897E8105C97ED38F9FDB44BA8673EB0D2D94668A67`

Pinned original common92d2202a6065aad36ae7d4a9bf960b6fb91222d2 producer/reader/limits/model definitions and all07K source hashes rechecked. Existing native generator identities are tied to retained source/build provenance and SHA,not an invented version number. Before execution,copied exact binaries into local bin and models into local inputs,then verified copy hashes. Fixed C: NTFS volume verified by native volume APIs; no global PATH/environment/registry change.

Actual execution root **`C:/Users/dantesoneja/AppData/Local/SeisComP_Tau_07L_20261024`**; call it G below. Each argv is exact after expanding that prefix:

| Working directory | Actual argv | Exit |
|---|---|---:|
| G/iasp91 | G/bin/tau_remodl.exe iasp91 G/inputs | 0 |
| G/iasp91 | G/bin/tau_setbrn.exe iasp91 | 0 |
| G/ak135 | G/bin/tau_remodl.exe ak135 G/inputs | 0 |
| G/ak135 | G/bin/tau_setbrn.exe ak135 | 0 |

Full absolute argv,cwd,UTC timestamps,elapsed times,input/generator hashes,environment overrides and actual exits are in `generation-results.json` and each `generation/<model>/<generator>-command.json`. Raw stdout/stderr,exit files,intermediate remodl tables and all five original .lis files are retained in both local output directories and the project evidence copy. Existing output directories were rejected; no prior resources overwritten. Process-local PATH used System32,TEMP/TMP used the new local directory; no network service/API is required by the inspected original generators. Project evidence/staging copies remain separate from local execution.

An initial orchestration KeyError for SystemRoot's environment-key casing occurred before any generator started; corrected the harness lookup only. Actual four generator calls then succeeded. `inspection-attempts.json` retains that distinction; no model arguments or scientific inputs changed.

## Four completed resources

| Resource | Bytes | SHA-256 |
|---|---:|---|
| iasp91.hed | 146472 | `E760C8414C0032BB643BB90C1B5E843DB54266BF894166FD4C664EE7E47913B2` |
| iasp91.tbl | 229712 | `66137F3E8FC5DB0CD03A5564924EB8E8046A5A6D16E71B16C62075C686515860` |
| ak135.hed | 146472 | `2853EEC6604FEFAB3C0B3FB71447CA5E13111BAF2A359653DA22A84EFCA2A3AD` |
| ak135.tbl | 225600 | `C593C6C4392995F1D5994B655A822A7D44EC03E5D65CDDE8A39E01D3D4EB9B1C` |

`resource-validation.json` records the complete source-derived parse: little-endian4-byte int/float,8-byte double,original three240-byte s_struct blocks and dimensions jsrc150,jseg30,jbrn100,jout2250,jtsm350. Both headers consume exactly146472 bytes with no remainder. Active branch/segment/ray indices and counts fit their original arrays; all active branch points are accounted for and numeric scalar arrays are finite.

Model pairing is checked against the intermediate remodl model-name field,isolated original commands and expected final filenames. Header sample indices match original intermediate indices,including the source's S-index adjustment. Every final .tbl record is walked in the original producer order using its phase-specific width and duplicate-offset rules. IASPEI91 has49 P/61 S records;AK135 has48 P/60 S records. Every record begins at the expected offset,stays within the paired table and references a complete intermediate record; final cursor equals actual .tbl size. No gaps,overlap,missing/unaccounted trailing bytes or nonfinite written doubles.

All four stderr logs are empty. Listings contain101 literal `overflow???` traces. Frozen original remodl.c:308 prints that line unconditionally inside pgrid; it is not guarded by an overflow/error condition. Each line is retained/classified in diagnostic_review; no unresolved warning/error lines found. No diagnostic was suppressed or used as numerical correctness evidence. Structural compatibility and successful generation do **not** prove travel-time numerical parity,repeatability across toolchains or actual LibTau loading. Those checks remain NOT_RUN.

## Revision3 and scientific manifests

Created **`phase8/staging/unified-08a-r3-native`** from verified revision2,adding the four files only under original share/ttt locations plus updated provenance/qualification documentation. Original08A and revision2 remain unchanged. `inventory/tau-scientific-resources.json`,the batch manifest and candidate `share/08a/scientific-resource-manifest.json` contain exact resources,inputs,commands,exits,sizes,hashes and structural findings. Four obsolete missing-Tau exclusions removed; other exclusions retained.

All150 existing PE files,12 extensions,original Python hierarchy,11 GUI executables,core/client,DB/QC/locator/acquisition providers,schemas and configurations are byte-identical to revision2. No compilation. Selected nodes,roots,normal/delay import graph,389 private edges,duplicate-name decisions and OS boundary remain equal. Only provider-manifest stage/revision metadata changes. Selected graph SHA-256 **`6360F370A4762F1E7462DD18F0784E2E816C317A370FF17D7C44E2FB9CAFE963`**.

Candidate SHA256SUMS.json covers839 files except itself; SHA-256 **`27BE3946B3F92E122C42C1444A4A9C85E7FAA4219771B76667FB4D3D07F9FC0A`**. The inherited07K generation plan is historical preparation; actual07L local commands/results are authoritative. These C Tau files are not LOCSAT/NLL formats and do not complete every travel-time/resource dependency.

## Next integration qualification — prepared only

`next-integration-qualification.md` updates07C isolation/DB evidence for revision3: native extension/package imports,original libtau factory/setModel discovery/loading,dynamic DB factories,unchanged SQLite schema0.14.0 and original Pick/Origin persistence,messaging/controller dependencies and GUI readiness. A source-only Python import/Tau-load probe and exact07C-derived20-DLL flat DB-copy map are prepared,not executed. The existing07C harness expects bin adapters/schemas rather than the unified share/plugins/share/db layout; the plan resolves that explicitly without changing the candidate or original harness.

Neither Y: staging nor the local generator directory is an admitted general runtime sandbox. Future execution needs its own admitted local NTFS/VM boundary and exact manifest/external CPython3.10.11 identities. No plugin,Python extension,DB schema/transaction,controller,scmaster or GUI application was loaded/run in07L. Original shipped connection examples remain dormant provenance. Optional unresolved package imports remain numpy/zmq/plugin,jwt/Twisted/zope plus original FDSNWS package,requests,nettab helpers and local DB setup integration; exact source-module names are in the updated plan and07K inventory. No package provision/upgrade.

Actual GUI startup,dynamic codec/driver behavior,SQLite/PostgreSQL transactions,SWIG director/API behavior,Tau reader loading,RecordStream/acquisition and scientific parity remain unresolved. Scanner stays console-only;scwfparam/locext bounded cancellation,remaining transports and disabled MySQL/Hypo71/iLoc unchanged. Real station/response metadata,NLL grids,waveforms,credentials and observed-event fixtures are not fabricated.

## Preservation,inventory and assessment

314 existing build products and4048 protected prior files/stages unchanged;all nine frozen snapshots and three Linux references retain expected HEAD/clean status/hashes. Original source super9c395c7f00c788c5fc640363abe97b9ced0b44b0,mainf63cde995e04151dc816151359a036b8b15f6019,common92d2202a6065aad36ae7d4a9bf960b6fb91222d2. Exact before/after evidence in before.json/verification.json. No upstream/native source patch,no scientific model/equation/interpolation/limits change,no binary rebuild. No Phase7,ew2sc deadline,operational config,global dependency,service or STOP/reload change.

Historical pre-06C1 config custody **INCOMPLETE**,07A Tau prebuild-hash exception and07E3 sequencing exception remain; new generation does not retroactively repair them. Binary inventory files unchanged:101/120 built,14 Windows-blocked,1 dependency-blocked,4 disabled;GUI11/11,Python12/12. Scientific resources are counted separately. Implementation status,resource manifests and patch ledger updated.

| Phase5A gate | State | Evidence/actual exit | Limitation |
|---|---|---|---|
| A: Source + Phase4C evidence | NOT_RUN as full gate | before.json/verification.json;custody checks0 | Broad Phase4C audit not repeated |
| B: Transitive closure | NOT_RUN as full gate | all four generators0;resource-validation.json;unchanged selected provider graph | Reader/application/runtime closure not executed |
| C: Linux original Autoloc oracle | NOT_RUN | None | No Linux scientific comparison |
| D: Native original Autoloc offline execution | NOT_RUN | None | Only Tau generators executed |
| E: Replay equivalence/robustness | NOT_RUN | None | Origin/time/location/depth/association matrix unavailable |

**07L resource-generation/structural-integration milestone complete. Phase5A PARTIAL.** Next prioritize separately authorized admitted-local Python/loader/Tau-reader/SQLite qualification,then genuine scientific fixture/numerical parity work. No operational usability,scientific certification or release claim.
