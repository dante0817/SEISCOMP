# P8-WINBACKEND-08B2 — native development resumed

**Original scream_plugin built; backend 102/120.** New revision 4 contains 151 native
PE files and 846 manifested files. GUI 11/11, Python 12/12 and Tau resources 4/4 remain
unchanged. VS2022/MSVC 19.44 Release x64, 24 October 2026. Application/runtime,
scientific and release qualification remain **NOT_RUN / NOT_QUALIFIED**.

## Scope and VM admission

The operator's follow-up makes a VM optional for general source development, builds,
GUI integration and Windows packaging. That direction is implemented in
phase8/WINDOWS_DEVELOPMENT_ROADMAP.md and the new installation guide. No Hyper-V
prerequisite is imposed on those development activities.

Existing 08B2 runtime authorization is preserved. Read-only Get-VM inspection remains
denied by the host authorization policy; exact message/HRESULT and host adapter facts
are in current-host.json/inspect-current.log. No elevation or attempt to bypass access.
VM identity, guest OS, guest network/ACL/clipboard/redirection evidence, approved transfer
method and disposal procedure are unavailable. No payload was transferred to a guest.
Admission remains **NOT_ADMITTED**, approved runtime modes empty, separate execution
approval absent. A supervised local replacement has not been authorized. This runtime
boundary does not block the completed source/build/package work below.

## Newly completed original target

`scream_plugin` configure and final compiler/linker exits are **0**:
configure-command.json/configure.log/configure.exit_code.txt and
scream_plugin-command.json/scream_plugin.log/scream_plugin.exit_code.txt.
Only its existing project was compiled; BuildProjectReferences=false. No full-solution,
Qt, core/client, controller, Python or database rebuild, no dependency upgrade.

Windows uses pointer-width SOCKET/INVALID_SOCKET, Winsock 2.2 startup with one owned
cleanup reference, closesocket, immediate WSA error capture and the original blocking
IPv4 TCP/UDP choices. Original host lookup/first IPv4 address, bind/reuse behavior,
single-byte TCP start command, partial reads, EOF/fatal behavior, UDP zero-fill and
truncation policy remain. WSAEMSGSIZE retains the filled leading UDP bytes as POSIX recv
does; other receive failures take the existing fatal path. Linux MSG_CONFIRM remains
in its original branch; the ordinary one-byte Windows TCP send uses flags0. No new
reactor, timeout, cancellation, protocol, configuration or controller STOP policy.

Modern MSVC stdint types provide the decoder's existing 64-bit accumulator and compile-
time 8/16/32/64-bit width checks. The internal complete_read parameter retains full
SOCKET width on Windows; Linux retains int/read. Native CRT math replaces the unsupported
Windows libm link; Linux keeps libm. Existing slplugin→seedlink_native supplies Ws2_32.

GCF decoding/reconstruction, dispatch, mapping and main source/header files are byte-
identical in nine files. The four edited C/header Linux conditional-token projections
equal their preimages; includes were not expanded, and Linux compilation/parity was
not rerun. No scientific calculation, packet interpretation, station/sample/timing
algorithm or original Linux behavior is intentionally changed.

Initial build exited0 but exposed a diagnostic macro passing a comma-expression integer
as a %s pointer. Its executable/logs/patches were archived in first-build before correction.
The Windows-only tuple-format diagnostic now preserves format arguments and original
exit behavior; short-read messages avoid unsupported GNU %m. No mapping/decoder source
was changed. Final build0 removes C4477/C4313. Remaining warnings are retained:
C4996=49, C4244=2 (original time_t→double calls in dispatch.c:84/91), C4146=1
(original unsigned unary minus in gcf.c:212). They are not suppressed or scientific PASS.

| Artifact check | Actual evidence |
|---|---|
| SHA-256 | `44CCA3596464041FA510C9F49EBD08535D024E485307BA1F48D6729F7EEC2CEE` |
| Architecture | AMD64 PE32+; static/headers.log and artifacts.json |
| Original entry | main.obj main symbol; original plugin.obj send_raw3; static/*symbols.log |
| Recursive private DLL closure | Empty: no private DLL import; actual Windows/VC/API-set boundary retained |
| Required symbols | Host System32 normal/ordinal exports checked, including Winsock; raw imports.log/artifacts.json |
| Static link provenance | Unchanged slplugin.lib/seedlink_native.lib hashes and generated project dependency list |
| Runtime/protocol/science | NOT_RUN; no executable or transport was started |

## Revision 4 and ordinary Windows installation

Candidate: `phase8/staging/unified-08a-r4-native`.
Manifest SHA-256 **`FD79AE54DA59B0704C976267ECF9F522B324AA10E792A84A27356BCAE5B3C0BE`**.
All 846 files verified; all 150 prior PE identities and 389 private relationships remain
unchanged. Added only the original SCREAM executable at the generated install-rule
destination share/plugins/seedlink plus Windows installation/roadmap metadata. No prior
stage was concatenated or overwritten. The matching original SCREAM description remains.

All eleven original GUI exes, Qt5.15.18 providers/platform/image plugins, bin/qt.conf,
original configurations/resources, twelve extensions and four Tau files retain R3 bytes.
share/windows/gui-package.json records exact GUI/Qt identities; static packaging does not
prove GUI startup, dynamic plugin/codec loading or rendering. No original GUI replacement.

Prepared Install-Development.ps1 verifies the externally pinned candidate manifest,
every file and exact file list, rejects reparse points/overwrites, copies to a new local
NTFS destination and verifies copied files. No service, registry/global PATH, dependency
installer or application launch. Use-DevelopmentEnvironment.ps1 prepares process-local
paths only and does not establish isolation or execution permission. The original
frontend's pinned external CPython3.10.11 home remains a deployment limitation; no
silent Python bundling/repathing or controller relocatability claim.

Both scripts AST-parse successfully. Copy installer **-WhatIf exits0**, verifies846 inputs
and leaves the destination absent: install-whatif.log/install-whatif.json. Actual copy
installation and application launch are **NOT_RUN**. Normal Windows copy/install and
supervised launch prerequisites are in phase8/windows-development/INSTALL-WINDOWS.md
and the candidate's share/windows copy. Hyper-V is not required for these procedures.

## Runtime results and exact preserved qualification identities

| Identity | SHA-256 |
|---|---|
| Immutable 08B1 payload | `4A3225142119D74E94A8A3A49D5E2A3949A43D12F1D8A88958F33A32628C6771` |
| R3 candidate manifest | `27BE3946B3F92E122C42C1444A4A9C85E7FAA4219771B76667FB4D3D07F9FC0A` |
| Original external python.exe | `3CCE33D75D6FDAE4E004D0BDF149320B3147482A9CAF370079DCB9C191A1B260` |
| python310.dll | `14B06796F288BC6599E458FB23A944AB0C843E9868058F02A91D4606533505ED` |
| Core | `AFC214B2961963F3EE059A9A61C5CF3E250C3209C8543915A5CA466EDE464AD8` |
| Client | `302AA40361BC4EA3507E62E0A2CC5B5DBD2068DC371DE40F606F6A024B3CB50B` |
| Config | `62D55F2FA42D19A0730D37E2CE5056B4ACF9E31F7451A769B7A721831749D77F` |

Original 08B1 DB/Python/schema/Tau manifests and all probe bytes remain unchanged;
the new R4 candidate cannot use an old admission receipt as authorization.

| Extension | Original package | Runtime outcome |
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

LibTau factory, default/explicit discovery, iasp91/ak135 loading, P/S queries, finite
values/errors/model switching/cleanup: **all NOT_RUN**. DB plugin/createSCPlugin/sqlite3
factory, original schema0.14.0, creation/commit/rollback, Pick/Origin/reconnect/readback,
invalid SQL/disconnect/cleanup: **all NOT_RUN**. Actual loaded target DLL evidence,
runtime exceptions/exits and DB artifacts are absent, not inferred from static imports.
No PostgreSQL server/connection, messaging/controller, GUI, acquisition or replay run.

New source-level orchestration blocker: run-owned.py:76 sets one active process; its
probe.py:22→admission.py:12 admission call starts PowerShell. That conflicts with the
one-process job after assignment, with a separate creation-before-assignment race.
This is an inference from source, not an observed Win32 error or runtime FAIL. No
replacement probe or pinned-payload edit was made. qualification-followups.md proposes
in-process fact collection preserving checks, bounded suspended launch/assignment and
completion timestamps before separately authorized use. It does not delay development.

## Patches, inventory and custody

| Applied Windows-only source patch | SHA-256 |
|---|---|
| P8-WINBACKEND-08B2-scream-CMakeLists.txt.patch | `87E76EEE1D9A7BA55F56BDBCB93F4D1CDE3A624E04D78162A9FEA5537A893D7D` |
| P8-WINBACKEND-08B2-scream-oscompat.h.patch | `27BC41FF06044C7D6E5808A0936D314E674976ED15E4CB1D40440C92387CEA16` |
| P8-WINBACKEND-08B2-scream-scream.c.patch | `D28778B9E742119B2931736D240BCB39E6E9B4640F822AEBAEB34381D415CC19` |
| P8-WINBACKEND-08B2-scream-util.c.patch | `2B1C43464BF61FD17CCC9840005421D5C209DBE7E851E6C5266176634C4BEC5D` |
| P8-WINBACKEND-08B2-scream-util.h.patch | `740A826FBECF5BC70E6272CD9C0719E4627DD40683958CD7991DDF61A3CDC95D` |

source-patches.json retains exact pre/post source hashes, preimages, untouched decoding
files and Linux projection evidence. Windows packaging-source hashes are recorded in
windows-package-sources.json. Original license notices remain; no distribution/release claim.

Completed/hash-verified archive **314 outputs before compilation**, including nested
providers/import libraries. Archive UTC precedes configure/build start. All314 current
products/archive copies remain unchanged; only the new SCREAM product was added.
All5003 protected prior files/stages,116 additionally watched immutable files and nine
frozen repository HEAD/status/hash vectors remain unchanged (verification.json,
verify-final.log/exit0). Super/main/common pins remain9c395c7f00c788c5fc640363abe97b9ced0b44b0 /
f63cde995e04151dc816151359a036b8b15f6019 /92d2202a6065aad36ae7d4a9bf960b6fb91222d2.
No frozen writes, Tau regeneration, core/client/GUI/controller/SDK/DB changes, dependency
upgrade, Phase7, ew2sc deadline, STOP/reload, production or host security/service change.

Historical pre-06C1 config DLL custody remains **INCOMPLETE**; 07A nested-Tau prebuild
hash and07E3 archive/build sequencing exceptions remain. No retroactive repair claimed.
Canonical inventory changed only scream_plugin: **102 built,13 Windows-blocked,
1 dependency-blocked,4 disabled,total120**. Remaining target reasons retained.
Qualification records, implementation status and patch ledger updated.

| Phase5A gate | State | Evidence / actual exit | Limitation |
|---|---|---|---|
| A: Source + Phase4C evidence | NOT_RUN full gate | before/build-before/verification; custody helper0 | Phase4C raw audit not repeated |
| B: Transitive closure | NOT_RUN full gate | SCREAM build0; artifacts/static; inherited unchanged graph | Dynamic/application closure NOT_RUN |
| C: Original Linux Autoloc oracle | NOT_RUN | No target invocation | No matching fixture/oracle comparison |
| D: Native original Autoloc offline run | NOT_RUN | No target invocation | Acquisition build is engineering evidence |
| E: Replay equivalence/robustness | NOT_RUN | No target invocation | No origin/time/depth/association matrix |

**Development milestone complete; Phase5A PARTIAL.** Next prioritize essential database/
core-processing resource and fixture completeness, a focused correction of qualification
orchestration and an explicitly authorized supervised local testing procedure. Continue
remaining original backend ports independently; a VM is optional when its isolation is
needed. No operational usability, numerical/scientific certification or release readiness claim.
