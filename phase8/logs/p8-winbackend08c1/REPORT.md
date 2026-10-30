# PHASE 5A VERIFICATION REPORT — P8-WINBACKEND-08C1

**Agent:** Codex. **Local date:** 30 October 2026, Asia/Manila. **Platform:** native Windows x64, existing VS2022 Professional/MSVC 14.44.35207 (19.44) Release configuration.

The corrected original SeisComP core is rebuilt, actually relinked and integrated into **unified-08a-r5-native**. It includes WIN-FIX-01 R1 (Winsock errno), R5 (binary SDS/stdin) and WIN-FIX-02 R2 (PKCS12 borrowed ownership). No additional source change or dependency installation was required. The user directed implementation first and minimal testing, then authorized this core/package milestone.

Package: `Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\staging\unified-08a-r5-native`.

External package SHA256SUMS.json identity: **`06C2A0AF142658924A2D1F9830F56B439658569D94F42BBF694054ECA5A89C7C`**.

New core DLL SHA-256: **`167DE26247A3BB4408E0EE55ED34196C7A43B688664700120CC240A83F4D83F8`**.

## Gate register

| Gate | State | Evidence and actual invocation/exit | Limitation |
|---|---|---|---|
| A: Source + Phase4C evidence | BLOCKED full gate | before.json, verification.json; nine frozen HEAD/status/hash vectors match | Phase4C raw evidence not reaudited |
| B: Transitive dependency closure | NOT_RUN full gate | core-compatibility.json, provider-manifest.json; static checks completed by finalize.py exit0 | Existing package graph checked for the changed provider; broad closure review remains closed |
| C: Linux original Autoloc offline oracle | NOT_RUN | No oracle invocation | No Linux/WSL process run |
| D: Windows native original Autoloc offline executable | NOT_RUN full gate | core-build-command.json and core-link-command.json both exit0; raw PE headers/imports/exports exits0 | Native core/package milestone only; original application execution not performed |
| E: Replay equivalence and robustness | NOT_RUN | No replay invocation | Scientific/numerical qualification deferred |

## Pinned source / patch provenance

No new source patch was applied. Exact current corrected socket.cpp, recordstream/file.cpp and sdsarchive.cpp inputs and hashes are retained under source-inputs and in before.json. They match the approved WIN-FIX-01/WIN-FIX-02 corrections. All frozen repositories have clean status and the same hashes before/after; superproject/main/common retain `9c395c7f00c788c5fc640363abe97b9ced0b44b0`, `f63cde995e04151dc816151359a036b8b15f6019`, and `92d2202a6065aad36ae7d4a9bf960b6fb91222d2`. Six other pinned native source snapshots also match the prior frozen register. No WSL access occurred.

The previous core DLL/import library/export products were copied and hash verified before compilation. Only the core DLL changed among 314 watched build products; the other 313 and all three archived preimages match. All 846 revision4 package files remain unchanged. Original qualification payloads, protected evidence and security state were not modified. Canonical inventory and current status/ledger were updated, with their preimages retained here.

## Build/link inventory

Compilation uses the existing generated core vcxproj, Release x64, project references disabled and no source reconfiguration. `core-build-command.json` records `/t:ClCompile;Link`, actual exit0 and timestamps; `core-build.log` retains 2,345 compiler warnings and zero errors. Existing DLL-interface, narrowing and deprecation warnings were not suppressed. This first command compiled the corrected sources but its bare Link target had no computed object inputs and skipped producing a DLL. Output hash comparison detected the unchanged old DLL. It was not accepted as corrected output.

`core-link-command.json` then invokes the actual `_Link` wrapper with object-input computation, exit0, 0 warnings and 0 errors; raw command/output is in core-link.log. The new DLL hash differs from the old `AFC214B2961963F3EE059A9A61C5CF3E250C3209C8543915A5CA466EDE464AD8`. `linked-corrected-objects.json` binds the actual three corrected object files. The import library remains byte-identical because the exported interface did not change. These targeted compiler/linker invocations avoid the inherited post-build dependency-copy script and its execution-policy switch; no execution policy was changed or bypassed.

The initial assembled trial containing the unchanged DLL is preserved under first-assembly/NOT-DELIVERABLE-link-skipped with its original metadata. The final assemble-final-command.json records exit0 and the final candidate. This correction changed the build invocation and package output only.

The final core is AMD64 PE32+ (`core-headers.log`). All **11,691** prior named exports and their ordinals remain, with no added/removed names. The selected graph's **389** private DLL relationships resolve using actual named/ordinal/delay imports and forwarders; the inherited explicit Windows/VC system boundary remains. Raw core imports/exports and compatibility results are retained. This is static compatibility evidence; no dynamic-loading or full C++ ABI guarantee is inferred.

## Windows fixture + result provenance

No application, GUI, extension, plugin, controller, acquisition process, network endpoint, database workload or scientific fixture was executed. No regression or memory campaign was rerun. Verification was restricted to native build/link, changed-provider compatibility, package hashes and required preservation checks.

The new package has **151 native PE binaries and 847 manifested files**. All **150 other PE binaries**, the **11 original GUI applications**, **12 Python extensions**, **four Tau resources**, configuration files and existing native dependency providers retain revision4 bytes. No target was newly ported in this integration batch; canonical backend count remains **102/120** (13 Windows portability blockers, one dependency blocker, four disabled targets).

The package retains the existing per-user copy installer and process-local environment scripts. Its installation guide now references revision5. Actual installation and application launch were not performed. The original external CPython3.10.11 home and optional package/resource limitations remain; the package is not claimed relocatable or release ready. Older share/08a revision records are retained as historical records; revision-08c1.json and provider-manifest.json are authoritative for this candidate. Prior qualification receipts do not admit the changed package.

## Linux fixture + result provenance

NOT_RUN. No reference dataset or Linux execution was used for this build/package task.

## Numerical difference matrix

Not applicable: no seismic results were generated or compared.

## Evidence gaps, failures and unresolved scientific questions

The direct-Link skip and rejected first assembly are retained above. The final DLL is the actual relinked output. Compiler warnings remain recorded for future targeted work. No full runtime, SSL handshake, persistence, GUI startup, acquisition, numerical or scientific pass is inferred. Historical pre-06C1 config custody, 07A Tau prehash and 07E3 sequencing exceptions remain as previously documented. License notices and existing dependencies were preserved; this development package has no distribution certification.

## Final assessed milestone

**Corrected native core/package integration: completed. Phase5A: PARTIAL.** Next implementation work is the remaining native acquisition ports, starting with the socket transports, followed by serial/process/IPC and unresolved dependencies. Essential application integration and a small final offline workflow check remain necessary for usability; broad review and repeated qualification campaigns are deferred. This is an engineering milestone, not scientific certification or operational/release approval.
