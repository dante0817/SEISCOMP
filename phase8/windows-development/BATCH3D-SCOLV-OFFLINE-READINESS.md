# Batch 3D — Original native Windows `scolv` offline readiness

**Checkpoint prepared: 2026-11-01 — source/readiness only; NO `scolv` execution authorized.**

## Starting evidence and acceptance boundaries

- Original native Windows `scconfig` screenshot/exit code 0: PASS.
- Original native Windows `scrttv` offline local miniSEED screenshot/exit code 0: PASS, with NC/NGVB/EHZ trace visibly rendered. Historical test input SHA-256 and exact binary + Qt entrypoint integrity verified.
- Therefore **2 of 11** original GUI applications have actual first-window and clean-exit smoke evidence. Eleven entrypoints passed prior static packaging inspection, which is not runtime qualification.
- `scrttv` evidence `phase8/logs/batch3c-scrttv-gui/scrttv-20261101-092220.stdout.txt` and `scrttv-20261101-092220.qt-stderr.txt` has **not** yet been screened by the operator; diagnostic acceptance remains pending. Do not imply an error-free Qt log without reading it.
- The connected office workstation is not isolated: program-scoped ActiveStore block rule presence does **not** prove packet-level egress control, local loopback confinement, or helper-process containment.

## Prior `scolv` engineering baseline

From `phase8/IMPLEMENTATION_STATUS.md` P8-WINGUI-03A:

- Focused MSVC Release x64 original `scolv` build previously exited 0 after approved source change to `Seiscomp::Core::sleep(1)`; binary hash at that **historical staged build** was `4B310F845CCEC761F46D51527D1C37E3E95FE8DA26FCFC7EC90899EC4840F8CB`.
- That historical staging hash must **not** be presumed equal to the disposable R10 `bin/scolv.exe`. The R10 manifest provides the current identity.
- The previous source review recorded a `scolv --offline` path with local SCML `inventory-expanded.xml` and `config-expanded.xml` from `data/phase5b6/gfz2010avtm/inputs/`, plus `--inventory-db`, `--config-db` and `--input-file` options.
- Critically, **`--offline` alone does not unconditionally disable database access** in this source revision. An event input file is not yet selected or verified; first-window startup should not be conflated with event content or scientifically accurate locations.
- No `scolv` GUI, local XML loader, database operation or production messaging has been tested in this batch.

## Batch 3D-01 deliverable

Added read-only `Inspect-R10ScolvOfflineReadiness.ps1` to `phase8/windows-development/`.

- SHA-256 (ASCII source): `1ADFAE022431857B97680D823B5E3746FA54AA89ABC653AF2508092A7DEE502A` (8,054 bytes).
- Reads the verified disposable R10 856-entry manifest and receipt, validates `bin/scolv.exe`, `qt.conf`, `qwindows.dll`, and process-local environment helper hashes, and counts module-description XML files.
- Inspects both local SCML input filenames in **two known candidate workspace directories**. For existing regular files up to 50 MiB, returns actual size/SHA-256 and performs *well-formed XML only* streaming validation with DTD prohibited, external resolver disabled, 100 MiB parsed-character cap. It checks the document element name is `seiscomp`; it does not certify XML schema, epoch, responses, provenance or completeness.
- Inspects, **without modifying**, ActiveStore profile status and the exact named `SeisComP-R10Test-scolv.exe-OutboundBlock` rule scope for **only** the disposable `bin/scolv.exe`. Missing/mismatched rules are reported, not repaired.
- Explicitly reports `SCOLV_OFFLINE_EVENT_INPUT: NOT_SELECTED`, `SCOLV_GUI: NOT_RUN`, and the absence of traffic-level containment proof.
- Source was committed and read back, ASCII SHA-256 calculated, delimiter-balanced and manually screened for process execution/firewall mutations. **Actual Windows PowerShell parse and operator run have NOT been performed.**

## Next authorized work — separate from GUI runtime

1. Operator saves new source beside existing Phase 8 development scripts in the Y: workspace and verifies exact SHA-256 and `Parser.ParseFile` syntax. Per-file trust review only if permitted by IT policy; no PowerShell policy bypass.
2. Operator runs the **read-only** inspector on the disposable R10 and Y: workspace to report actual XML locations/hash and `scolv` firewall scope. A missing firewall rule should not be falsely reported as a verified block.
3. Source-level review must select an actual local event input, confirm `scolv` offline/database precedence, and design narrowly scoped child-process/egress boundaries before any launch. Avoid repeated checkpoints when previous hashes have passed.
4. Only a later, **new explicit `scolv`-specific authorization** may enable a non-elevated, one-session native Windows GUI test from the disposable R10 copy. The original `scconfig` and `scrttv` permissions do not extend to `scolv`.

**Current status: `BATCH3D_01_SCOLV_READINESS_SOURCE_READY / HOST_INPUT_CHECK_PENDING / SCOLV_GUI_NOT_RUN / NETWORK_AND_SCIENCE_NOT_QUALIFIED`.**

## Operator Windows readiness result: partial XML and package passes

2026-11-01 operator confirmed initial read denial on the new read-only inspector was transient: subsequent exact SHA-256 verification and Windows PowerShell parser check **PASS**. The operator performed policy-approved per-file `Unblock-File` and invoked `Inspect-R10ScolvOfflineReadiness.ps1` without launching a GUI.

Observed output as provided (the transcript is **partial** and ends at config file size):

```text
=== HASH VERIFICATION ===
SCOLV SCRIPT SHA256 PASS
=== SYNTAX VERIFICATION ===
SCOLV SCRIPT SYNTAX PASS
BATCH3D_SCRIPT_VERIFICATION_PASS
NO FILES CHANGED; NO GUI EXECUTED
=== BATCH3D SCOLV OFFLINE INPUT READINESS ===
VerifiedExecutable: C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10\bin\scolv.exe
Manifest: 83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74
DisposableReceiptAndQtRuntimeFiles: VERIFIED
DescriptionXMLCount: 131
inventory-expanded.xml: XML_WELL_FORMED
inventory-expanded.xml Path: Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\data\phase5b6\gfz2010avtm\inputs\inventory-expanded.xml
inventory-expanded.xml SizeBytes: 196426
inventory-expanded.xml SHA256: FE208FA1BD82F8FC87B6461453139FB21985DD1A20E9CCE3F12D162E5A4D0010
config-expanded.xml: XML_WELL_FORMED
config-expanded.xml Path: Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\data\phase5b6\gfz2010avtm\inputs\config-expanded.xml
config-expanded.xml SizeBytes: 13309
```

The output shared so far does **not** contain config file SHA-256, ActiveStore firewall profile/rule observations, final completion marker, or PowerShell return prompt. Treat this as **partial successful inspection**, not complete inspection, and do not invent a missing firewall result. No scolv runtime authorization has been requested or granted. The `XML_WELL_FORMED` result means only syntactic well-formedness, not valid SCML structure, time epochs, response/metadata quality or functional database isolation.

**Status: `BATCH3D_01_PARTIAL_PACKAGE_AND_XML_PARSE_PASS / FIREWALL_RESULT_PENDING / FINAL_INSPECTION_MARKER_PENDING / SCOLV_GUI_NOT_RUN`.**

## Operator Windows read-only readiness result — 2026-11-01

The operator verified the new `Inspect-R10ScolvOfflineReadiness.ps1` as 8,054 bytes with the pinned SHA-256 and a successful Windows PowerShell parser check. Earlier intermittent Y: Access Denied did not recur; per-file `Unblock-File` was then applied without changing execution policy. Executed the read-only inspector (no `-Run`) and reported:

```text
=== BATCH3D SCOLV OFFLINE INPUT READINESS ===
VerifiedExecutable: C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10\bin\scolv.exe
Manifest: 83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74
DisposableReceiptAndQtRuntimeFiles: VERIFIED
DescriptionXMLCount: 131
inventory-expanded.xml: XML_WELL_FORMED
inventory-expanded.xml Path: Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\data\phase5b6\gfz2010avtm\inputs\inventory-expanded.xml
inventory-expanded.xml SizeBytes: 196426
inventory-expanded.xml SHA256: FE208FA1BD82F8FC87B6461453139FB21985DD1A20E9CCE3F12D162E5A4D0010
config-expanded.xml: XML_WELL_FORMED
config-expanded.xml Path: Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\data\phase5b6\gfz2010avtm\inputs\config-expanded.xml
config-expanded.xml SizeBytes: 13309
config-expanded.xml SHA256: 98E56386BFB3DB4C58AAF89026DA31B1272153535B836FF73BEC1C8CF35556CD
FIREWALL_PROFILES_ENABLED
SCOLV_OUTBOUND_BLOCK_RULE_MISSING
SCOLV_OFFLINE_EVENT_INPUT: NOT_SELECTED
SCOLV_GUI: NOT_RUN; NEW_RUNTIME_AUTHORIZATION_REQUIRED
BATCH3D_READ_ONLY_INSPECTION_COMPLETE
NO_GUI_EXECUTED; NO_FIREWALL_CHANGE; NO_NETWORK_PROBE
ACTIVE_RULE_MATCH_WOULD_NOT_PROVE_TRAFFIC_EGRESS_OR_HELPER_CONTAINMENT
```

**Assessment:** `BATCH3D_01_SCOLV_PACKAGE_AND_XML_WELLFORMED_PASS`; inventory/config XML are parseable but have not passed SCML schema/content/epoch checks. An actual local event SCML input remains unidentified, and the exact-path named `scolv` outbound block is missing. No executable, firewall or network operations occurred. Do not launch `scolv` with only `--offline`, as prior source review warns it does not unconditionally eliminate database access. The earlier `scrttv` Qt log contents also remain outstanding; its GUI and clean-exit smoke milestone remains PASS.

Next source-first step: bounded search/selection of local offline event SCML inputs, plus application-specific containment preparation; a distinct one-session `scolv` authorization is required before any runtime start.

## Batch 3D-02 event XML filename discovery — operator result

2026-11-01: Operator ran a **read-only recursive filename discovery** in the Y: project `data` tree and `phase8/staging/scolv-offline` subtree, obtaining **85 XML files**, **11 event/origin/pick/catalog/location-name candidates**, and no application execution or file modifications. The terminal display truncated several long paths; do not infer file contents from truncated filenames.

Three explicit stable candidates were visible under project `data/real-events/`:

- `data/real-events/gfz2010avtm/event.xml`
- `data/real-events/gfz2010eaoy/event.xml`
- `data/real-events/gfz2010llha/event.xml`

Other candidate paths were found under `data/phase5b9/gfz2010avtm/{inputs,raw}/` and `data/phase5c1/phase5c3/evaluation/ncedc_c3e/`, but filenames in transcript were truncated. A filename search is **discovery only**: no XML element shape, EventParameters, event/origin/pick references, hash/size or suitability as `scolv --input-file` established yet.

**Next bounded source-first step:** Read-only inspection of exactly these three `event.xml` files: absolute path, size, SHA-256, DTD-disabled streaming XML parse, document root, EventParameters count, event/origin/pick/magnitude counts, unique `publicID` presence, optional `preferredOriginID`, without copying complete event XML to chat. Select one only after inspecting actual content and the known `scolv --offline --inventory-db --config-db --input-file` source-option behavior. The existing inventory/config XML is well-formed; `scolv` specific program block remains missing and no runtime approval is held.

**Checkpoint:** `SCOLV_EVENT_XML_CANDIDATES_3_IDENTIFIED_BY_FILENAME / XML_EVENT_SEMANTICS_UNVERIFIED / GUI_NOT_RUN`.

## Batch 3D-02: three event XML files structurally verified — primary selected

2026-11-01 operator completed read-only bounded XML inspection of the three candidate local `data/real-events/` files, using a DTD-prohibited XML reader and SHA-256. All are well formed with root `quakeml`, one `EventParameters`, one event, one origin, six magnitude elements and a preferred-origin ID resolving to the present origin (**1/1 matched**). Distinct pick counts and integrity pins:

| Candidate | Bytes | SHA-256 | Picks | Primary? |
| --- | ---: | --- | ---: | --- |
| `data/real-events/gfz2010avtm/event.xml` | 185646 | `B81D460B33A6E8A6422742CC7465A2EF85694893F08B3405FF31A74BA32B4EB2` | 292 | **YES — first candidate** |
| `data/real-events/gfz2010eaoy/event.xml` | 109143 | `F076D33D1B16A10372F4621D0AE3E71E2CD68B8F0350A6A6DB697F902CDE17EB` | 143 | fallback |
| `data/real-events/gfz2010llha/event.xml` | 346807 | `AB57CA6C65EA97C1AC8187BBBA0E83A4966894772A5566AEDC29E43620E1A33F` | 472 | fallback |

**Primary choice rationale:** `gfz2010avtm` matches the previously verified local `data/phase5b6/gfz2010avtm/inputs/inventory-expanded.xml` and `config-expanded.xml` by dataset identifier. It provides one event, a resolvable preferred origin and 292 picks, a reasonable first-viewer structural fixture. This dataset-name match does not establish cross-document station/epoch/response consistency, schema-specific correctness, import compatibility or scientific calibration. The six magnitudes were counted but not numerically validated. No event or configuration files were altered.

## Batch 3D-03: scoped `scolv` firewall preparation source added

Created `phase8/windows-development/Ensure-R10ScolvOutboundBlock.ps1` as a narrowly rewritten counterpart of the already used guarded scrttv exact-program rule script, **not** a global firewall policy change. Source read back byte-for-byte from GitHub, 6,941 ASCII bytes, SHA-256 **`FB2E930019C1FE304A355E5EAB928F380D9AE5001D5DDBECD7412A9370B5A44E`**. Delimiter lexical scan PASS; **actual Windows PowerShell parser and execution NOT RUN**.

The script allows only the verified disposable native Windows R10 `bin/scolv.exe`, exact manifest SHA-256, 856-entry receipt and local NTFS install root, a named exact-path program outbound block rule `SeisComP-R10Test-scolv.exe-OutboundBlock`, and no GUI or network probe. Its **default mode is read-only**, reports missing/mismatched/ActiveStore rule status. Its mutating `-Apply` path is gated by elevation, `SupportsShouldProcess`/ConfirmImpact High, and re-verifies exact ActiveStore scope. It does NOT set default firewall policy, network configuration, packet-level egress proof or helper/process containment. On the last operator inspection, the named rule was missing.

**Do not run `-Apply` without local/office firewall-change permission.** Do not launch `scolv` using the earlier scrttv runtime launcher: that launcher correctly rejects all non-scrttv `-Run` targets. A source-reviewed bounded `scolv` launcher with explicit offline XML arguments, no implicit database linkage, event-hash pins, and separately authorized session is a later deliverable. `--offline` alone is insufficient to guarantee database isolation in the earlier source review. Qt stderr contents of scrttv remain pending independent read-only inspection.

**Checkpoint:** `BATCH3D_EVENT_3_XML_WELLFORMED_AND_PREFERRED_ORIGIN_PASS / PRIMARY_GFZ2010AVTM_SELECTED / SCOLV_FW_SOURCE_PREPARED / FW_RULE_MISSING_LAST_CHECK / GUI_NOT_RUN / NO_NEW_RUNTIME_AUTHORIZATION`.

## Batch 3D-03 operator verified firewall script and missing rule

2026-11-01 operator reported successful host SHA-256 and Windows PowerShell parser verification for `Ensure-R10ScolvOutboundBlock.ps1` (6,941 bytes, `FB2E930019C1FE304A355E5EAB928F380D9AE5001D5DDBECD7412A9370B5A44E`). The script was individually unblocked by the operator; no global execution policy change was reported. The earlier intermittent Y: read denial cleared with no ACL changes.

Read-only preflight output:

```text
=== BATCH3D SCOLV OUTBOUND FIREWALL PREPARATION ===
VerifiedScolvExecutable: C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10\bin\scolv.exe
PinnedManifestSHA256: 83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74
DISPOSABLE_R10_IDENTITY_PASS; ACTIVE_FIREWALL_PROFILES_ENABLED
SCOLV_EXACT_PATH_OUTBOUND_BLOCK_RULE_MISSING
PREFLIGHT_ONLY; REQUIRES_APPLY_AND_ADMINISTRATOR_APPROVAL
NO_GUI_EXECUTED; NO_FIREWALL_CHANGE
```

**Assessment:** `BATCH3D_03_FIREWALL_SCRIPT_HASH_SYNTAX_AND_PREFLIGHT_PASS / EXACT_SCOLV_RULE_MISSING / GUI_NOT_RUN`. Creating the single exact-program outbound block rule requires distinct explicit owner/office IT authorization and elevated interactive `-Apply` confirmation; do not infer consent from successful preflight. Rule configuration alone does not prove traffic-level containment, helper blocking or absence of database connections. `scolv` runtime is still gated separately on source-level offline/database behavior review and a new one-session authorization; the earlier `scrttv` permission is not transferable.

Three real-event XML files were structurally inspected; primary `gfz2010avtm` has one event, one origin, preferredOrigin matched 1/1, 292 picks, six magnitudes and is pinned by SHA-256 `B81D460B33A6E8A6422742CC7465A2EF85694893F08B3405FF31A74BA32B4EB2`. These results are not evidence of scientific fidelity or `scolv` loader compatibility.

## Batch 3D-04 owner authorization for one exact-path scolv firewall rule

2026-11-01 operator answered **`i authorize`** immediately following a specific request for permission to create **one exact-path Windows Firewall outbound block rule** for the verified disposable R10 `bin/scolv.exe`, **provided local office IT policy permits the administrator-level firewall change**. This does not grant permission to start `scolv`, access live data, run services, alter production configuration or modify firewall default policies.

Operator instructions issued: open an elevated Windows PowerShell session, revalidate SHA-256 `FB2E930019C1FE304A355E5EAB928F380D9AE5001D5DDBECD7412A9370B5A44E` for `Ensure-R10ScolvOutboundBlock.ps1`, and run script against exact local `C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10` using `-Apply -Confirm`. Interactive rule-specific confirmation required; if Y: workspace is unavailable in elevated session, stop and report instead of bypassing restrictions. Then verify in non-elevated shell with the default read-only invocation.

**Current evidence:** Script hash and Windows parser PASS and preflight showed `SCOLV_EXACT_PATH_OUTBOUND_BLOCK_RULE_MISSING`. **No administrator `-Apply` output has yet been provided. Do not claim the rule was created.** The permitted rule would cover only its executable path; network egress effectiveness and subprocess containment remain untested. Any future `scolv` GUI session requires **new, separate operator authorization** and source-verified offline/database behavior.

**Checkpoint:** `BATCH3D_04_FIREWALL_RULE_APPLY_AUTHORIZED_CONDITIONAL_ON_OFFICE_POLICY / HOST_APPLY_AND_ACTIVE_SCOPE_VERIFICATION_PENDING / SCOLV_NOT_RUN`.

## Batch 3D-04 operator confirmed scolv exact outbound block creation and independent verification

2026-11-01 operator provided two chronological host records after explicit authorization conditional on local office policy. First, elevated Windows PowerShell verified script SHA-256 `FB2E930019C1FE304A355E5EAB928F380D9AE5001D5DDBECD7412A9370B5A44E`, invoked `Ensure-R10ScolvOutboundBlock.ps1 -Root <disposable R10> -Apply -Confirm`, reached the exact program-path ShouldProcess confirmation, and reported:

```text
VerifiedScolvExecutable: C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10\bin\scolv.exe
PinnedManifestSHA256: 83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74
DISPOSABLE_R10_IDENTITY_PASS; ACTIVE_FIREWALL_PROFILES_ENABLED
SCOLV_OUTBOUND_BLOCK_RULE_CREATED_AND_ACTIVE_SCOPE_MATCH
NO_GUI_EXECUTED; DEFAULT_FIREWALL_POLICY_UNCHANGED
RULE_SCOPE_IS_NOT_EGRESS_EFFECTIVENESS_PROOF_OR_HELPER_CONTAINMENT
```

PowerShell's extra prompts to set CIM aliases were seen during command/module loading with `-Confirm` and do not themselves represent any authorized expansion of the firewall change. Next, the operator pasted an earlier read-only pre-creation `SCOLV_EXACT_PATH_OUTBOUND_BLOCK_RULE_MISSING` result, **then a newer independent normal-user preflight** showing:

```text
SCOLV_ACTIVE_BLOCK_RULE_SCOPE_MATCH
RULE_ALREADY_PRESENT; NO_FIREWALL_CHANGE
NO_GUI_EXECUTED; EGRESS_EFFECTIVENESS_NOT_TESTED; HELPERS_NOT_COVERED
```

**Qualified result:** `BATCH3D_04_SCOLV_EXACT_APP_OUTBOUND_RULE_CREATED_AND_ACTIVE_SCOPE_VERIFIED`; current state is matching rule PRESENT. No package/source changes or `scolv` launch. Still no independent packet-level outbound egress measurements, child-process confinement, or scientific/DB isolation. Prior `scconfig` and `scrttv` first-window / clean-exit 2-of-11 remains unchanged.

**Next source-first gate:** review actual `scolv --offline` option precedence and external DB/messaging paths; preserve tested and pinned inventory/config XML and `data/real-events/gfz2010avtm/event.xml`. Build a new `scolv`-specific fail-closed launcher with verified path hashes/real event input and no unwanted database access, plus separate operator authorization for exactly one connected-host offline GUI session before any launch. The existing `Start-R10RemainingGuiConnectedHost.ps1` intentionally disables non-scrttv `-Run`.

**Checkpoint:** `SCOLV_FIREWALL_POLICY_SCOPE_PASS / EVENT_INPUT_STRUCTURAL_PASS / SCOLV_GUI_NOT_RUN / NEW_RUNTIME_AUTHORIZATION_PENDING`.

## Batch 3D-05 historical offline source command reviewed and dedicated guarded launcher prepared

On 2026-11-01 the operator displayed two existing, never-run historical command records: `phase8/staging/scolv-offline/offline-command.txt` and `phase8/logs/p8-wingui03a/offline-invocation-proposed.txt`. The historical `scolv/main.cpp` source review recorded these semantics: explicit `--offline` disables messaging, and providing a nonempty `--inventory-db` disables database access (`setDatabaseEnabled(false,false)`). Local `--config-db` provides offline configuration bindings and `--input-file` selects EventParameters. **This result verifies existing reviewed command documentation, not a new code inspection or actual loader behavior.** Bare `--offline` alone is insufficient for DB isolation. Both old commands reference historical Y: staging, not the current manifest-pinned R10 binary; never execute them verbatim.

Added `phase8/windows-development/Start-R10ScolvOfflineConnectedHost.ps1` to the GitHub branch. This is a dedicated fail-closed launcher **distinct from** the prior `Start-R10RemainingGuiConnectedHost.ps1` (which intentionally rejects non-scrttv `-Run`). Exact UTF-8 ASCII source read back after final correction: 13,942 bytes; SHA-256 **`7C88244EA5F86050C7201C33E5CA994B17406C481443A73081069AFB40CBD449`**. Source-only validation: ASCII PASS, balanced lexical delimiters PASS, `-Run` and `ShouldProcess` gates occur *before* the only fixture-copy and GUI launch paths; no firewall/service/network modifications. **Actual Windows parser/preflight/run NOT YET PERFORMED.**

Default invocation without `-Run` checks installed R10 856-entry receipt/manifest; original `bin/scolv.exe`, `qt.conf`, `qwindows.dll`, environment-helper pinned hashes; 131 XML descriptions; and size/SHA-256 for previously verified inventory (`196426 B`, `FE208FA1...`), config (`13309 B`, `98E56386...`), event (`185646 B`, `B81D460B...`). It does not copy fixtures, create directories, require firewall rule, launch app, or probe network. Output marker `BATCH3D_SCOLV_OFFLINE_GUI_SOURCE_PREFLIGHT_PASS` means **preflight only**.

Proposed separately authorized `-Run` path additionally requires a scolv-specific authorization reference, connected-host/config/egress/helper/DB-behavior acknowledgments, non-elevated user session, no pre-existing scolv process, clean process SeisComP/Qt variables, no user-home `.seiscomp` directory, active firewall profiles and exact scoped `SeisComP-R10Test-scolv.exe-OutboundBlock` ActiveStore filters, plus a pre-existing evidence directory outside the test install. It uses `ShouldProcess`, then stages pinned source XML into local NTFS `C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10\work\offline-gui-scolv\inputs\gfz2010avtm` with immediate SHA-256 verification and refuses hash-conflicting existing copies or reparse-point test staging directories. Process-local user/profile and AppData paths are redirected to the disposable work area, then the existing manifest-pinned environment helper sets SeisComP/Qt paths. It launches the **disposable R10** `scolv.exe` with exact `--offline --inventory-db <local XML> --config-db <local XML> --input-file <local XML>` and Qt stdout/stderr logging, waits for clean exit and restores host shell environment.

**Scope/limitations:** No real `scolv` executable was launched; new launcher has no Windows runtime result and does not change source/frozen files or host firewall. Existing ActiveStore scolv outbound program block was separately created and verified in Batch 3D-04. Some `Y:` staging **source read by the parent PowerShell** necessarily touches the mapped workspace; during GUI run, local fixture copies reduce reliance on Y: but do not prove host isolation. A rule's configuration does not prove blocking, and child processes are not contained. The local SCML event has structural but not scientific acceptance. The historical `P8-WINGUI-02E` network-isolation requirement is not silently declared satisfied; a specific connected-host risk acceptance is required before executing.

**Checkpoint:** `BATCH3D_05_SCOLV_GUARDED_LAUNCHER_SOURCE_READY / HOST_PS_PARSE_AND_PREFLIGHT_PENDING / GUI_RUNTIME_AUTH_PENDING / SCIENCE_NOT_QUALIFIED`.

## Batch 3D-05 persistent Y-drive access denial on new launcher

2026-11-01 operator attempted SHA-256 verification of `phase8/windows-development/Start-R10ScolvOfflineConnectedHost.ps1` on the Y: workspace. `Get-Item` showed **13,942 bytes** and Archive attributes. `Get-FileHash` failed three times in a row with `Access to the path ... is denied`; the script was **not readable**, therefore no host SHA-256/syntax PASS is justified and no `-Run` or default preflight occurred. Read-only `Get-Acl` output showed owner `AzureAD\dantesoneja`, Administrator/SYSTEM FullControl, Authenticated Users Modify and Users ReadAndExecute, but effective access can still be blocked by share permissions, security filters, or a file handle. Do not diagnose a specific cause without more evidence.

**Next gate**: compare one read-only standard file-read/hash of the blocked script against a known-good same-directory script and inspect the normal Get-Content result; preserve ACLs, files, share settings and organizational security policies. Treat repeat failures as an operator/IT file-access issue, not a build or syntax failure. Do not unblock or execute a file whose content hash has not passed. Prior GitHub ASCII source static verification and hash `7C88244EA5F86050C7201C33E5CA994B17406C481443A73081069AFB40CBD449` are source-side evidence **not host verification**.

**Checkpoint**: `BATCH3D_05_LAUNCHER_SOURCE_READY / HOST_FILE_ACCESS_DENIED / SHA256_AND_PS_PARSE_NOT_VERIFIED / SCOLV_GUI_NOT_RUN`.

## Batch 3D-05 Y drive diagnostic: launcher access recovered

Operator subsequently ran a read-only Windows file-access diagnostic on the Y: workspace and reported `Y:` Win32_LogicalDisk `DriveType=3`, `FileSystem=NTFS`. Both the previously verified `Ensure-R10ScolvOutboundBlock.ps1` and the new `Start-R10ScolvOfflineConnectedHost.ps1` passed `Get-Content -TotalCount 1` and `[IO.File]::Open` read-only handle checks. Explicit terminal markers: `GET_CONTENT_READ: PASS`, `STANDARD_FILE_READ: PASS` for each and `BATCH3D_FILE_ACCESS_DIAGNOSTICS_COMPLETE; NO FILES CHANGED; NO GUI EXECUTED`.

**Interpretation:** The earlier 3-attempt access-denied state was not reproduced in this test. Current readability is PASS but **not a SHA-256/content integrity or Windows syntax PASS**; no preflight/run has yet been performed, and underlying transient denial cause remains unknown. Do not change ACLs, default execution policy or endpoint-security controls. The next bounded step is a single new `Get-FileHash` comparison against `7C88244EA5F86050C7201C33E5CA994B17406C481443A73081069AFB40CBD449`, Windows `Parser.ParseFile` and default `-Root ... -WorkspaceRoot ...` preflight only. If the signed-script restriction reappears, after hash verification handle per-file Unblock-File only where office policy permits.

**Checkpoint:** `SCOLV_NEW_LAUNCHER_READ_ACCESS_PASS / SHA256_PS_PARSE_AND_PREFLIGHT_PENDING / SCOLV_GUI_NOT_RUN`.

## Batch 3D-05 operator Windows launcher offline preflight PASS

On 2026-11-01 the operator completed per-file trust handling (as permitted under host policy), then ran the default **non-`-Run`** `Start-R10ScolvOfflineConnectedHost.ps1 -Root <disposable R10> -WorkspaceRoot <Y: project>`. Host read-only preflight reported:

```text
=== BATCH3D SCOLV NATIVE OFFLINE GUI PREFLIGHT ===
Executable: C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10\bin\scolv.exe
Manifest: 83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74
DISPOSABLE_RECEIPT_AND_QT_RUNTIME_HASHES_PASS
DescriptionXMLCount: 131
GFZ2010AVTM_INVENTORY_CONFIG_EVENT_SHA256_AND_SIZE_PASS
BATCH3D_SCOLV_OFFLINE_GUI_SOURCE_PREFLIGHT_PASS
GUI_NOT_RUN; FIREWALL_NOT_CHANGED; NO_NETWORK_PROBE; NO_FIXTURE_COPIES_CREATED
RUNTIME_REQUIRES_SEPARATE_SCOLV_AUTHORIZATION_AND_CONNECTED_HOST_REVIEW
```

Prior operator command output separately confirmed the new launcher's SHA-256 `7C88244EA5F86050C7201C33E5CA994B17406C481443A73081069AFB40CBD449` and PowerShell syntax PASS before initial unsigned-script policy blocking; the operator subsequently resolved the per-file execution restriction. Exact ActiveStore `scolv` application outbound rule had also been independently verified earlier, but **the preflight-only launch did not itself check firewall or apply changes**.

**Qualified milestone:** `BATCH3D_05_SCOLV_GUARDED_LAUNCHER_HOST_PREFLIGHT_PASS`. The `-Run` branch remains **NOT RUN**: no local fixture staging, no runtime environment preparation, no GUI startup, no stdout/Qt stderr or process exit. GUI testing requires a distinct, specific operator authorization for **one supervised offline GFZ2010AVTM `scolv` GUI session on a connected host** with acknowledged limitations: active rule scope is not packet-level proof; helper processes not contained; database/messaging disablement based on historical source review and unproven at runtime; local event's science not yet validated. Do not imply prior firewall creation authorization extends to GUI launch.

**Current GUI count:** 2/11 first-window/exit-code-0 evidence (`scconfig`, `scrttv`), 9 not yet runtime tested; `scolv` is next once separately authorized.

## Batch 3D-06 operator authorizes one supervised scolv GUI session

2026-11-01 operator explicitly replied **`pls proceed, i authorize`** to the specific proposed one-session native Windows `scolv` offline GUI smoke on the **connected host**, accepting unproven packet-level outbound isolation, helper-process containment, runtime database/messaging behavior, and scientific event-location fidelity.

This authorization is **separate from** the previously completed Administrator firewall-rule change. Scope: exactly one interactive, non-elevated supervised `scolv.exe` GUI session via the approved hash-verified `phase8/windows-development/Start-R10ScolvOfflineConnectedHost.ps1`, using current manifest-pinned original `bin/scolv.exe` in `C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10` and three hash-pinned GFZ2010AVTM local inventory/config/event XML inputs. The launcher must stage copies under the disposable local NTFS test root, pass explicit `--offline --inventory-db --config-db --input-file` local arguments, verify the named ActiveStore outbound program rule, capture stdout/stderr/exit, and restore session-scoped variables.

No authorization for live SeedLink/acquisition, external messaging/database, process/service startup, production configuration changes, further GUIs or repeat sessions. The host has no verified network isolation; program-specific rule scope is a safeguard, **not** a packet-level proof. Operators must cancel unexpected connection/setup prompts and close the GUI normally. Do not claim GUI launch or functional/clean-exit PASS until operator provides screenshot and launcher log.

**Checkpoint:** `BATCH3D_06_SCOLV_SINGLE_CONNECTED_HOST_OFFLINE_GUI_SESSION_OPERATOR_AUTHORIZED / RUN_NOT_YET_REPORTED / SCIENCE_UNQUALIFIED`.

## Batch 3D-06: first scolv offline input-file import failure

2026-11-01 operator supplied screenshot from the first separately authorized supervised native `scolv` test: GUI error dialog stated exactly `Unable to find EventParameters structures in C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10\work\offline-gui-scolv\inputs\gfz2010avtm\event.xml.`

**Important:** The prior original event source passed SHA-256 and **XML well-formedness** checks but had `quakeml` as document root and one nested `EventParameters` by local name. Well-formed QuakeML does not imply the SCML structure the scolv `--input-file` reader expects. Official SeisComP scolv docs specify offline event XML in SCML; official sccnv docs state QuakeML **input** conversion is not directly supported by sccnv and may require matching-version XSLT, with potential data-mapping limitations. The format/serialization mismatch is therefore a **likely** cause, not a confirmed source-code or Qt defect. Do **not** simply rename XML roots or destroy original data.

**Runtime result remains partial/failed**: screenshot proves scolv reached the offline event-file import error dialog (a Qt-visible application prompt), but does not yet establish complete main window rendering, event import, clean process exit, Qt logs, scientific accuracy, or absence of live network activity. No new session is authorized; the one-session consent has been used. Ask operator to dismiss dialog/close normally and send `SCOLV_PROCESS_EXIT`, stdout and stderr evidence. No relaunch of unchanged failing fixture.

**Source-first recovery:** (1) read-only scan workspace for native SCML `<seiscomp>` document containing direct `EventParameters` and evaluate hashes, schema/version and references; (2) identify packaged or source-tree QuakeML-to-SCML XSLT converters appropriate for the pinned R10 schema; (3) if no already-native SCML is available, design bounded offline QuakeML-to-SCML transformation to a new disposable test fixture, preserving original QuakeML, validate Event/Origin/Pick/Magnitude object hierarchy and reference mapping, pin output SHA-256; (4) update guarded launcher to select only vetted native SCML input, separate change review and new operator session authorization before any retry.

**Checkpoint:** `BATCH3D_06_SCOLV_XML_EVENT_IMPORT_FAILED / FORMAT_MISMATCH_SUSPECTED / GUI_SMOKE_NOT_PASS / EXIT_AND_QT_LOGS_PENDING`.

## Batch 3D-07 native SCML source discovery: 18 schema-0.14 candidates and bundled XSLT

2026-11-02 operator completed a bounded **read-only** search over project `data` XML/SCML sources. 105 files inspected, **18** had a root-local-name `seiscomp` with at least one immediate `EventParameters` child, all reported namespace `http://geofon.gfz.de/ns/seiscomp-schema/0.14`. Search verifies XML structure/namespace and SHA-256, but **does not** count or confirm full Event or Origin objects. Most 18 filenames contain `picks`, so they may represent picks-only EventParameters; do not claim full event import eligibility.

Promising GFZ2010AVTM candidates:

| Path relative to project | Bytes | SHA-256 |
| --- | ---: | --- |
| `data/phase5b2/gfz2010avtm/picks.scml` | 43809 | `602F5D6657BF612518C5EB1D46E0947550BBBDC30157B7A1E1BE5C0C7832FA1D` |
| `data/phase5b3/gfz2010avtm/picks.scml` | 43809 | `602F5D6657BF612518C5EB1D46E0947550BBBDC30157B7A1E1BE5C0C7832FA1D` |
| `data/phase5b6/gfz2010avtm/output/picks-batch1.scml` | 12998 | `719CB6AED8A1B8518407B86EFC609884D8066B63D6B942709181E41D240FFF3D` |
| `data/phase5b6/gfz2010avtm/output/picks-expanded.scml` | 68687 | `36B64FBA52EDE10D6143C7CD080692CA97C1E3160108AAADCF63B40F7EB747F6` |

Other picks-only-named SCML candidates are within `data/phase5b9/gfz2010avtm/output/`, `data/phase5c1/phase5c2{b,c}/output/` and later phase5c* inputs/output including negative-control samples. Identical SHA-256 `DB2E6D20244CD3D61D9E97868B511936088E465A9405C014DFC3C328120A43AA` recurs for **147-byte** files—likely minimal skeletons, not useful full event inputs. This is inferred from size/name, not content-confirmed.

Two file reads failed during the scan, including `config-with-IU-bindings-loc00.invalid-original.xml` and a sealed evaluation XML; no execution or changes, no conclusion about SeisComP runtime.

**Bundled local converter found** under verified disposable R10 test root: `share/xml/0.14/quakeml_1.2__scml_0.14.xsl`. Other versions are available too. Official SeisComP `sccnv` documentation confirms matched-version XSLT can map QuakeML 1.2 into SCML and warns conversion depends on source fidelity/ID references; no conversion has been attempted yet. Exact installed XSLT bytes and current XSLT dependency/document() behavior have not been reviewed; do not directly execute unreviewed transformations or imply scientific fidelity.

**Next:** Read-only inspect 18 source SCML files for Event/Origin/Pick/Magnitude object counts, reference matches and namespace, prioritize existing complete 0.14 `EventParameters` before QuakeML-to-SCML transformation. If only picks-only files, prepare a disposable, bounded XSLT conversion of originally pinned 185,646-byte GFZ2010AVTM QuakeML using the installed 0.14 stylesheet with DTD/external resources disabled. Validate transformed event/origin/pick references and archive source/output hashes before any repeated `scolv` GUI run. Original one-session `scolv` test already reached an input-import error; its exit code/stdout/Qt stderr still not reported, and **new session authorization required**.

**Checkpoint:** `BATCH3D_07_NATIVE_SCML_CANDIDATES_18_FOUND / COMPLETE_EVENT_SEMANTICS_NOT_VERIFIED / MATCHED_0_14_XSLT_DISCOVERED / SCOLV_IMPORT_RECOVERY_SOURCE_ONLY`.

## Batch 3D-08 all native SCML candidates are picks-only; secure conversion source prepared

2026-11-02 operator completed DTD-prohibited read-only object count of all **18** structurally valid SCML namespace 0.14 EventParameters fixtures. **All 18 have Events=0, Origins=0, Magnitudes=0, Arrivals=0, PreferredOrigins=0/0**. Pick counts sorted: 202 x3 Napa, 62 negative-control, 58 x2 Fiji, 54 x2 E4, 22 GFZ expanded, 17 x2 GFZ baseline, 5 x2 GFZ batch1/BBSR, 3 GFZ ANMO final and 0 x4 tiny/smoke. Thus no complete existing native SCML event/origin fixture was found. Those pick-only SCML artifacts are useful for other workflows but are **not** suitable as a full-event `scolv --input-file` substitute. Source text unchanged, no GUI/network execution.

**Selected development remedy:** Prepare a *separate, derived* GFZ2010AVTM native SCML 0.14 fixture via the already installed `share/xml/0.14/quakeml_1.2__scml_0.14.xsl`. The original pinned QuakeML is 185,646 bytes, SHA-256 `B81D460B33A6E8A6422742CC7465A2EF85694893F08B3405FF31A74BA32B4EB2`, with one event/origin, 292 picks, six magnitudes and matching preferred origin. Official SeisComP `sccnv` guidance explains that XSLT conversion exists but mapping can be limited by source QuakeML references/nonstandard attributes and may be lossy. No transformed output yet exists in observed evidence.

Added source-only `phase8/windows-development/Prepare-R10ScolvScmlEvent.ps1`, 12,158 ASCII bytes, pinned script SHA-256 **`E918EA88D90124C7C65538AED8AD5BA5780B18B76B7681D49076DBF30A794BD1`**, committed and byte-for-byte readback verified. Source-only lexical delimiter test PASS, conversion behavior ordered behind explicit `-Convert` and ShouldProcess confirmation, script prohibits XSLT DTD/external resolver, disables XSLT script/document() and requires no XSLT includes/imports, pinned stylesheet SHA-256 supplied by operator after preflight. **Actual Windows PowerShell parser, installed stylesheet scan and conversion NOT RUN.**

Default mode verifies original QuakeML size/hash and its event/origin/pick/magnitude counts; identifies the installed schema-0.14 XSLT size/hash and scans for import, script and document() references; prints one designated output path under `C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10\work\offline-gui-scolv\converted\gfz2010avtm-event-scml014.xml`. **Default mode makes no directory, output or GUI changes**. Opt-in `-Convert` requires pinning observed XSLT SHA-256 and confirmation, writes only one new bounded local disposable output via temporary file, rejects overwrites, checks expected SCML root/version, 1 EventParameters/event/origin, all 292 picks/6 magnitudes, preferred-origin and arrival-to-pick references, and only then commits the result and records its hash. On any conversion or validation error, removes its temporary output, leaves original files untouched and refuses GUI use. Cannot establish independent scientific equivalence. If XSLT uses unsupported extension features, output is blocked for separate review rather than enabling document() or network access.

**Next safe operator step:** Save the new script from GitHub and run Windows `Get-FileHash` + `Parser.ParseFile` + its **no-switch default read-only** source/XSLT inspection. Do not use `-Convert` until source style review and explicit acknowledgment of one new disposable derived-file creation. Any subsequent modification to the guarded `scolv` launcher must pin the derived output hash and requires another separately authorized GUI session. Original one-session `scolv` event-import failure screenshot remains the last operational result; GUI exit/Qt logs are still not supplied.

**Checkpoint:** `BATCH3D_08_PICK_ONLY_SCML_CONFIRMED / QUAKEML_TO_SCML_SOURCE_READY / CONVERSION_NOT_RUN / SCOLV_RETRY_NOT_AUTHORIZED`.

## Batch 3D-08 operator confirms XSLT document() guard in preflight

On 2026-11-02 operator verified new `Prepare-R10ScolvScmlEvent.ps1` via read-only byte-stream SHA-256 and PowerShell parser: `STANDARD_FILE_READ_PASS`, `CONVERTER_SHA256_PASS`, `CONVERTER_SYNTAX_PASS`. Earlier Y: `Get-FileHash` Access Denied cleared via a standard file stream; no ACL or global policy changes. Operator per-file unblocked the SHA-256-verified script, then ran **default preflight only**.

```text
=== BATCH3D SCOLV QUAKE-TO-SCML PREPARATION ===
VerifiedQuakeML: Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\data\real-events\gfz2010avtm\event.xml
QuakeMLSHA256: B81D460B33A6E8A6422742CC7465A2EF85694893F08B3405FF31A74BA32B4EB2
OriginalObjects: events=1 origins=1 picks=292 magnitudes=6 preferredOrigins=1/1
InstalledStylesheet: C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10\share\xml\0.14\quakeml_1.2__scml_0.14.xsl
InstalledStylesheetSHA256: 48D7A0CD04AD2E716D94EF3180D0E60DDEDC5375BD0A16460E08436AD843BCD0
StylesheetInspection: imports=0 scripts=0 documentCalls=1
ProposedOutput: C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10\work\offline-gui-scolv\converted\gfz2010avtm-event-scml014.xml
BATCH3D_QML_TO_SCML_PREFLIGHT_PASS
PREFLIGHT_ONLY; NO_CONVERSION; NO_FILES_MODIFIED; NO_GUI_OR_NETWORK_EXECUTION
```

**Interpretation:** The single XSLT `document()` reference is **not yet characterized**. It could be `document('')` style-local lookup or refer to an external resource. The source converter's fail-closed `-Convert` path checks `DocumentCalls -ne 0` and must remain blocked until the source-specific reference and XSLT 1.0 processor behavior are audited; do not enable document() or supply a network-capable resolver. The path and XSLT hash are observed on host but input scientific equivalence and conversion outputs remain unverified.

**Next read-only task:** inspect the verified stylesheet with an `XmlReader` configured to prohibit DTD and null resolver; capture the element name, XSLT attribute and a bounded attribute value containing `document(`. Check whether the occurrence is actually executable XPath and whether the call can reference any external file/URL. Also determine whether stylesheet SHA-256 matches installed manifest if an entry exists. No conversion or GUI rerun in this step.

**Checkpoint:** `BATCH3D_08_CONVERTER_HOST_PREFLIGHT_PASS / XSLT_DOCUMENT_REFERENCE_REVIEW_REQUIRED / CONVERSION_NOT_RUN / SCOLV_GUI_RETRY_NOT_AUTHORIZED`.

## Batch 3D-09 exact XSLT document() reference localized

2026-11-02 operator read-only inspection of manifest-pinned installed XSLT `share/xml/0.14/quakeml_1.2__scml_0.14.xsl`, SHA256 `48D7A0CD04AD2E716D94EF3180D0E60DDEDC5375BD0A16460E08436AD843BCD0`, independently confirmed `XSLT_SHA256_PASS` and `XSLT_MANIFEST_HASH_PASS`. Exactly one XPath-bearing stylesheet attribute was found:

```text
REFERENCE 1
Element: variable
Attribute: select
Line: 261
Expression: document('scml_0.14.xsd')
Document-bearing attributes: 1
BATCH3D_XSLT_DOCUMENT_REFERENCE_INSPECTION_COMPLETE
NO CONVERSION; NO FILES MODIFIED; NO GUI EXECUTED
```

**Assessment:** this is a **relative file reference** to a named SCML schema, likely in the same `share/xml/0.14` directory as the stylesheet. It is **not an explicit remote URI**, but this by itself does not establish whether the reference resolves locally, whether the schema exists and is manifest-pinned, whether the XSD contains additional external includes/imports, or how the stylesheet uses the returned nodes. A separate read-only XSD inspection is required before updating conversion code. Do not simply enable `document()` with unrestricted `XmlUrlResolver`: .NET `XslCompiledTransform` by default disables `document()`; if enabled it uses the transform-time `XmlResolver` to resolve external resources and unscoped default overloads can admit unwanted file/network references (Microsoft XSLT security docs). The eventual solution should restrict resolver access to one manifest-verified local SCML XSD with DTD/external resolution disabled, or avoid document() entirely with an equivalent audited isolated mapping. Existing fail-closed `-Convert` guard remains in effect.

**Read-only next check:** verify `share/xml/0.14/scml_0.14.xsd` exists as a regular file, get size/hash and compare to R10 manifest, parse XSD with DTD and external entities prohibited, inspect schema includes/imports/redefines and root namespace, and display bounded local stylesheet context around line 261 (no transform or edit). Review before implementing an exact allowlist resolver.

**Checkpoint:** `BATCH3D_09_XSLT_RELATIVE_SCHEMA_DOCUMENT_REFERENCE_IDENTIFIED / LOCAL_XSD_IDENTITY_PENDING / CONVERSION_NOT_RUN / SCOLV_RETRY_NOT_AUTHORIZED`.

## Batch 3D-09 local SCML XSD verified; memory-only one-file resolver implemented

2026-11-02 operator confirmed the referenced `C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10\share\xml\0.14\scml_0.14.xsd` was a regular 77,453-byte local file with SHA-256 `5E5E77BB60BD9B24AB140EB716027E8D6F041BC3A9EB3BF9B9DCCE13EBDCC0E8`, independently matching the 856-file R10 installation manifest (`XSD_MANIFEST_HASH_PASS`). Secure DTD-prohibited parse returned root `schema`, target namespace `http://geofon.gfz.de/ns/seiscomp-schema/0.14`, `SchemaDependencies: 0`, `XSD_XML_PARSE_PASS`. The exact XSLT context at line 261 is `<xsl:variable name="schema" select="document('scml_0.14.xsd')"/>`, with global `$version` = `0.14` at line 260 and source object keys at lines 265-268. `NO CONVERSION; NO FILES MODIFIED; NO GUI EXECUTED`.

Updated existing `phase8/windows-development/Prepare-R10ScolvScmlEvent.ps1` (new **18,620-byte ASCII** version; source SHA-256 **`BDA211D423C36A9BD8868D4824DC10477792B0320A4E0F09E3423A9BCC1B5842`**). GitHub read-back byte-match and source-only marker checks PASS; **Windows PowerShell parser, Add-Type compiler, conversion and GUI not yet run**. Old script's `E918EA88...` hash is obsolete; replace the existing Y: copy only by authorized project-version update and re-hash before execution.

Changes: both preflight and opt-in conversion verify exactly one pinned, manifest-matching local SCML XSD at `share/xml/0.14/scml_0.14.xsd`, its secure parse, correct namespace and zero schema dependencies. The stylesheet must contain exactly one `xsl:variable/@select` equal to `document('scml_0.14.xsd')` and zero includes/imports/scripts/other document() references. The conversion branch enables XslCompiledTransform **document()** but leaves embedded scripts disabled. It supplies a narrow `P8SeisCompOnlyXsd014ResolverV1` to `Transform`, matching only the verified stylesheet-relative `scml_0.14.xsd` URI and returning a memory-backed stream from independently SHA-256-verified local schema bytes; all other resources and credentials throw. `Load` uses null resolver; original input and schema scans prohibit DTD and XML external resolution. No blanket XmlUrlResolver, no network resolver. The existing ShouldProcess/confirmation and pinned XSLT SHA argument, output no-overwrite, temp cleanup, SCML expected event/origin/pick/magnitude/reference checks and source protection remain in effect.

**Next:** user saves updated script in Y: workspace, verifies new `BDA211...` hash and `Parser.ParseFile` on Windows, then runs default *read-only* preflight and, only if it passes, may choose one local derived-file creation via `-Convert -ExpectedStylesheetSha256 48D7A0CD04AD2E716D94EF3180D0E60DDEDC5375BD0A16460E08436AD843BCD0 -Confirm`. Never add `-Run` or invoke `scolv` for this step. This derived-file creation is NOT a new GUI session; the one approved `scolv` session is consumed and a fresh authorization is required for later GUI retry. If the transformation fails a strict structure check, inspect the emitted error and do not relax checks or relaunch GUI.

**Checkpoint:** `BATCH3D_09_SCHEMA_LOCAL_MANIFEST_VERIFIED / ONE_FILE_MEMORY_RESOLVER_SOURCE_READY / OPERATOR_WINDOWS_TEST_PENDING / GUI_RETRY_NOT_AUTHORIZED`.

## Batch 3D-09 updated Y: script hash verification blocked

2026-11-02 operator tried the updated 18,620-byte `Prepare-R10ScolvScmlEvent.ps1` verification/conversion instructions, but the first `Get-FileHash -LiteralPath` of the Y: development script returned **`FileReadError / Access to the path is denied`**, at the hash-verification line. It terminated the outer `ErrorActionPreference=Stop` block **before syntax verification, default preflight, opt-in `-Convert`, or any output creation**.

Same mapped workspace previously had intermittent Get-FileHash access denial even when `Get-Content` or `[IO.File]::Open(..., Read, ReadWrite)` succeeded; however recurrence does **not establish** root cause or host policy permission. Next bounded step: read-only standard file stream, verify script byte count 18,620, derive SHA-256 from streamed bytes and compare to `BDA211D423C36A9BD8868D4824DC10477792B0320A4E0F09E3423A9BCC1B5842`, then PowerShell Parser.ParseInput from exactly those verified bytes. If standard file reading is also denied, **stop** and involve office IT/security rather than changing ACLs/endpoint policy. Only after successful verification and existing execution policy consent should the default **read-only** script preflight be retried; any actual conversion remains opt-in, and scolv GUI rerun requires a new separate authorization.

**Checkpoint:** `BATCH3D_09_UPDATED_CONVERTER_Y_FILE_READ_DENIED / NEW_SOURCE_NOT_YET_HOST_HASH_VERIFIED / CONVERSION_NOT_RUN / GUI_NOT_RUN`.

## Batch 3D-09 converter Windows SHA/parser PASS, unsigned-script policy blocks execution

2026-11-02 operator ran standard .NET stream byte-read and SHA-256 verification of updated `Prepare-R10ScolvScmlEvent.ps1`, reported `BATCH3D_UPDATED_CONVERTER_VERIFICATION_PASS` and `NO FILES MODIFIED; NO CONVERSION; NO GUI EXECUTED`, establishing the new pinned 18,620-byte script content and PowerShell parse passed. A subsequent normal PowerShell invocation of default read-only preflight returned `PSSecurityException / UnauthorizedAccess`: the Y: file **is not digitally signed** and cannot be loaded under current effective execution policy. No converter preflight, Add-Type, XSLT transform or local SCML file creation took place.

The script was overwritten with the new version after a prior per-file Unblock-File on the superseded version. A newly applied Zone.Identifier or another policy restriction is possible, but not proven. Next operator action: read-only `Get-ExecutionPolicy -List`, `Get-ExecutionPolicy`, and `Get-Item -Stream Zone.Identifier` inspection. Only if effective policy is `RemoteSigned`, a Zone.Identifier exists and office rules allow it, use **per-file** `Unblock-File -LiteralPath` on the **SHA-verified** updated script, then run default read-only preflight. If policy is AllSigned, Restricted, enforced via MachinePolicy/UserPolicy, or the file remains blocked without a Mark of the Web, stop and obtain an authorized signed build or IT review; do not use process-wide Bypass, copy/rename-to-evade, or relax policies. No scolv GUI rerun authorization.

**Checkpoint:** `BATCH3D_09_UPDATED_CONVERTER_SHA_AND_PARSER_PASS / WINDOWS_UNSIGNED_SCRIPT_POLICY_BLOCK / CONVERSION_NOT_RUN / SCOLV_GUI_NOT_RUN`.
