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
