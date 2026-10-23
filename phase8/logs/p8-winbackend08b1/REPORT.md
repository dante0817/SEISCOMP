# P8-WINBACKEND-08B1 — isolated qualification preparation

**Preparation complete; boundary NOT_ADMITTED; execution NOT_RUN.** 24 October2026,
Windows11 Pro x64 build26200. Existing VS2022/MSVC19.44 Release x64 outputs reused;
no compilation, Tau regeneration, dependency provisioning or target execution.
Backend **101/120**, GUI **11/11**, Python **12/12**, Tau resources **4/4** unchanged.

## Boundary and exact deployment

Prepared a fresh fixed C: NTFS copy at
`C:\Users\dantesoneja\AppData\Local\SeisComP_08B1_20261024`. Local NTFS and a successful preparation write/read check are
filesystem facts, not isolation admission. Host Ethernet, Tailscale and virtual adapters
are Up. Hyper-V tools exist, but Get-VM returns an authorization-policy permission error.
No disposable guest, guest filesystem/ACL boundary, disconnected guest network or separate
operator runtime approval is available. No elevation, VM/service/network/firewall/security
change was attempted. **Do not execute the copied targets on this development host.**

The source-only boundary proposal, exact paths, guest receipt requirements, allowed five
modes, observer/deadline and fixed cleanup are in `phase8/qualification08b1/README.md`.
`admission.required.json` deliberately remains NOT_ADMITTED, all isolation/approval
booleans false and approval ID null. 08B1 B/H explicitly requires separate approval;
neither a script flag nor a temporary directory establishes that approval/isolation.
The runtime checks were not attempted to test or bypass admission.

| Preparation check | Actual state / evidence |
|---|---|
| R3 exact manifest/every file | PASS static:839 files; prepare.log and verify-final.log, exits0 |
| Native architecture/imports | PASS static:150 candidate +21 DB-copy PE files AMD64 PE32+; static-preparation.json |
| Host VC runtime | Required named exports found in current System32 and original Python-local runtimes; preparation.json. Guest OS/API-set/forwarder closure pending |
| Original CPython | Original executable/runtime/header/import-library hashes retained;2257 runtime/stdlib files copied and source/copy hashes rechecked; no site-packages/cache/package installation |
| Selected providers/DLL collisions | Exact R3 identities retained; no duplicate DLL basename within either SeisComP deployment or conflicting overlap with Python DLLs |
| Python/plugin/resource paths | Original package hierarchy and flat07C layout prepared; actual discovery/loading NOT_RUN |
| Isolation/approval | BLOCKED: no admitted guest; Hyper-V inspection denied; no separate execution approval |
| Writable work | Fresh local directories and sentinel verified; guest permissions/isolation pending |
| Owned observation/cleanup | Source prepared and AST checked; behavior NOT_RUN |

All preserved build/stage hashes are in before.json and verification.json. Raw host facts
and exact VM inspection error are in host-boundary.json/inspect-boundary.log. Development
helpers prepare.py, finish-preparation.py and verify-final.py all exited0; these read PE
tables/copy/hash files and never launch the target probes or harness.

| Identity | SHA-256 |
|---|---|
| R3 SHA256SUMS.json (839 files) | `27BE3946B3F92E122C42C1444A4A9C85E7FAA4219771B76667FB4D3D07F9FC0A` |
| Immutable preparation payload (3131 files) | `4A3225142119D74E94A8A3A49D5E2A3949A43D12F1D8A88958F33A32628C6771` |
| Flat DB-copy manifest (23 files:20DLLs+harness+schema+DLL list) | `0944BAC69C198D23B7F3FC613432B108D7727B58C204A7BA5CA2737DA84880FF` |
| CPython runtime-copy manifest (2257 files) | `C18E9C8E6157E339526684F3B226D36E9B1A45563E042A9AD95D4155FAEE1779` |
| Original CPython3.10.11 x64 python.exe | `3CCE33D75D6FDAE4E004D0BDF149320B3147482A9CAF370079DCB9C191A1B260` |
| Original python310.dll | `14B06796F288BC6599E458FB23A944AB0C843E9868058F02A91D4606533505ED` |
| Selected core | `AFC214B2961963F3EE059A9A61C5CF3E250C3209C8543915A5CA466EDE464AD8` |
| Selected client | `302AA40361BC4EA3507E62E0A2CC5B5DBD2068DC371DE40F606F6A024B3CB50B` |
| Selected config | `62D55F2FA42D19A0730D37E2CE5056B4ACF9E31F7451A769B7A721831749D77F` |
| Unchanged original07C dbqualify.exe | `1AD66EB093BBF39B231C8BF40924E71D3FD5951BEF97C04A0F12258FD433DA2C` |

Payload manifest excludes mutable work/evidence paths. Each deployment's own manifest
remains exact. All150 PE identities and389 private relationships match R3; selected graph
SHA `6360F370A4762F1E7462DD18F0784E2E816C317A370FF17D7C44E2FB9CAFE963`.
Host VC14.50.35719 and retained Python-local VC14.29.30139 required named exports were
inspected without loading. No guest compatibility or actual loader choice is inferred.
The copied external interpreter is invoked directly in the future plan; the frontend's
compiled Python home and original external installation are not changed.

## Python results — individually NOT_RUN

Original dependency order comes from07K inventory imports and original wrapper declarations,
not assumed independent top-level PYDs. Meaningful existing interfaces are pinned in
import-plan.json. Twelve actual PyInit exports statically present; this is not import success.

| Extension | Intended package/module | Runtime result |
|---|---|---|
| _config | seiscomp.config | NOT_RUN |
| _core | seiscomp.core | NOT_RUN |
| _logging | seiscomp.logging | NOT_RUN |
| _system | seiscomp.system | NOT_RUN |
| _utils | seiscomp.utils | NOT_RUN |
| _math | seiscomp.math | NOT_RUN |
| _io | seiscomp.io | NOT_RUN |
| _geo | seiscomp.geo | NOT_RUN |
| _datamodel | seiscomp.datamodel | NOT_RUN |
| _seismology | seiscomp.seismology | NOT_RUN |
| _client | seiscomp.client | NOT_RUN |
| _strongmotion | seiscomp.datamodel.strongmotion | NOT_RUN |

Prepared probe captures package/native paths/hashes, per-import loaded modules including
python310.dll, original intermodule imports/interface existence and exact exceptions/
tracebacks/winerror where provided. Failed prerequisites stop dependent checks. No client
Application is constructed. Optional NumPy/zmq/plugin, jwt/Twisted/zope/FDSNWS, requests,
nettab/local setup helpers remain separate, unprovisioned exclusions.

## Tau and SQLite results

**All Tau checks NOT_RUN:** libtau factory, default share/ttt discovery, explicit trailing-
separator SEISCOMP_LIBTAU_TABLE_DIR, iasp91/ak135 loads, selected model, P/S queries,
finite values, error handling, model switching and resource cleanup. The four exact07L
hashes are retained in scientific-resource-manifest.json and the verified candidate manifest.
Prepared cases use original factory/reader/compute, two discovery modes, iasp91→ak135→iasp91,
P/S at source(0,0,10km),receiver(0,30,0),ellc1; missing phase/model and depth801 negatives.
Cleanup prepares original setModel-empty/destruction plus exclusive read-only file reopens.
No corrupt table, scientific substitution, replay or Linux/Windows parity claim.

**All SQLite checks NOT_RUN:** plugin load/createSCPlugin, sqlite3 factory, original schema
0.14.0, database creation, commit/rollback, original Pick/Origin storage, reconnect/new
archive/readback, invalid SQL/missing-file behavior, disconnect and cleanup. The separate
flat copy reuses the unchanged07C harness and exact20-DLL mapping; schemas/sqlite3.sql is
unchanged. No database artifact exists. PostgreSQL registration is prepared only; its
server/connections and DataModel persistence remain outside this phase/harness.

**Actual target DLL loader evidence: unavailable (NOT_RUN), not inferred from imports.**
Future Python probes enumerate actual module handles/paths/hashes. The new runner samples
the exact DB child and joins original MODULE lines to observed identities; missing coverage
fails qualification even with exit0. Sampling does not claim all transient load/unload events.
It prepares a one-child job,120-second deadline,raw logs/exits and artifact hashes. Timeout/
unknown DLL/failed job assignment fails admission/qualification; only the exact owned job/
child can be terminated. All new runner/admission/cleanup behavior is still unqualified.

## Corrections, preservation and custody

No upstream/scientific/application source change, binary rebuild or ABI correction.
New qualification-only tooling patch SHA **`8A610918924A0754FC7E549A1D0C927AE0B4D7EACF80EAD69ECF4DA76C52A685`**; exact new source hashes are
in source-record.json. Corrections during preparation select real Math DoubleVector/CoordD
interfaces and use an absolute SystemRoot PowerShell path for future child inspection.
No runtime failure was observed because execution was not admitted. A failed optional
inspection of nonexistent exceptions.i was resolved by reading the real seismology.i mapping.

Static review identified a potential existing failure-path allocation leak: original
LibTau::compute allocates TravelTimeList before setDepth can throw. This is not a runtime
finding; no unapproved algorithm/source repair applied. The unchanged07C harness also
reports generic LoadLibraryEx failure without a numeric Win32 code; if encountered later,
retain exact logs/exit and propose scoped in-process diagnostics rather than inventing it.

Final preservation exit0: **314 build products,
4946 protected prior files/stages,
42 watched native source/inventory files,
nine frozen Windows repositories (HEAD/status/hash vectors),2257 original Python runtime
source files and existing dependency/Boost identities unchanged. All three Linux source
references retain expected HEAD and clean status in the final read-only check. Exact
super/main/common pins remain9c395c7f00c788c5fc640363abe97b9ced0b44b0 /
f63cde995e04151dc816151359a036b8b15f6019 /92d2202a6065aad36ae7d4a9bf960b6fb91222d2.
R3 and every earlier candidate,controller/GUI stage,adapter/schema,extension,Tau/QC/locator/
acquisition binary remain immutable. No Phase7, ew2sc deadline, STOP/reload, operational
configuration, global dependency or service change.

Historical pre-06C1 config DLL custody stays **INCOMPLETE** (missing preimage SHA
`1F3364FDDFEFC5F3EB4E72FFD8C3F21BAC26C27788684CE5B12B077237C824F8`).
07A nested-Tau prebuild-hash exception and07E3 archive/build sequencing exception remain;
this batch does not retroactively repair them. Canonical backend CSV/JSON remain byte-
identical:101 built,14 Windows-blocked,1 external-dependency blocked,4 disabled,total120.
Qualification records and implementation status/patch ledger updated; no invented build progress.

## Gate register and remaining work

| Phase5A gate | State | Evidence / actual exit | Limitation |
|---|---|---|---|
| A: Source + Phase4C evidence | NOT_RUN full gate | before.json/verification.json; final preservation helper0 | Broad Phase4C audit not repeated |
| B: Transitive dependency closure | NOT_RUN full gate | static-preparation.json; preparation helpers0 | Guest/runtime loader closure not admitted |
| C: Linux original Autoloc oracle | NOT_RUN | No target invocation/exit | No matching scientific fixture/oracle execution |
| D: Native original Autoloc offline execution | NOT_RUN | No target invocation/exit | This is isolated qualification preparation only |
| E: Replay equivalence/robustness | NOT_RUN | No target invocation/exit | No numerical origin/time/location/depth/association matrix |

Next: an operator-provided disposable Windows VM, actual offline filesystem/network/VC
admission evidence and separate explicit approval of this exact payload/probe boundary.
Then imports→independent Tau/DB plugin checks→SQLite,stopping dependent checks on failure.
Afterward prioritize genuine database/core seismic-processing resource/fixture completeness
and original Linux/Windows scientific comparison; broader PostgreSQL and operational
integration require their own scope. No controller expansion.

**08B1 preparation complete; runtime qualification blocked/NOT_RUN. Phase5A PARTIAL.**
Engineering preparation/static compatibility does not establish numerical/scientific
certification, operational usability or release readiness.
