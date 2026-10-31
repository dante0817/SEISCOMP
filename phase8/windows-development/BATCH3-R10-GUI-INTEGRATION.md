# Phase 8 / Batch 3 — Native R10 GUI integration

**Status (2026-10-30): BATCH3A_PREFLIGHT_PASS_11_OF_11 / BATCH3B_STATIC_CONFIG_INVENTORY_PASS / R10_INSTALLED / GUI_RUNTIME_NOT_RUN.**

## Verified baseline

The operator built a new R10 candidate from verified R9 and installed it into
a separate local NTFS development root. The externally recorded R10
SHA256SUMS.json digest is:

    83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74

R10 manifest: **856 files**. Original GUI executables: **11/11 PASS**.
GUI static audit: **26/26 PASS** with zero failures. New qoffscreen plugin,
matching Qt provider files and Qt catalog: PASS. Separate development copy
installation: PASS. Original R9 unchanged.

These observations do not prove GUI startup, DLL dynamic loading, isolation,
correct waveform/database behavior, or scientific equivalence.

## Implemented Batch 3 source

Test-R10GuiBatch3.ps1 reuses the guarded Start-DevelopmentGui.ps1 launcher
from the pre-existing Batch 1 branch; no duplicate launcher was introduced.
Both are available in this new Batch 3 branch.

The wrapper validates the externally pinned R10 manifest digest, requires
856 entries, checks the separate installation receipt, verifies SHA-256 and
catalog records of qwindows.dll and qoffscreen.dll, and invokes the guarded
launcher in its **preflight-only** mode for each of the 11 original GUIs. It
prints all per-application outcomes and one aggregate pass/fail result.

It never supplies the launcher's Run switch, does not source the runtime
environment helper, and cannot launch a SeisComP executable. Optional
IncludeEnvironmentInventory reads local host state and may disclose PIDs;
avoid publishing those details. The readiness script labels were corrected
from R9-only to generic selected-installation labels.

**Source verification:** authored source re-fetched from GitHub and compared;
**Windows PowerShell execution NOT RUN** as part of source preparation.

## Operator — one read-only Batch 3 all-GUI pass

Place these two **reviewed** scripts in the same local engineering-tools
directory, not inside the verified R10 installation:

- Test-R10GuiBatch3.ps1
- Start-DevelopmentGui.ps1

Use your organization's normal script-trust process and independently
pinned exact script hashes before executing. Do not bypass policy.

Source SHA-256 of the exact published Batch 3 wrapper:
    9DC1A4A4F945775C2DC1C5F6175BB0C9D3516F5F2D75619C2836FA18F647744E

Source SHA-256 of the inherited guarded GUI launcher:
    38DC736FBEDA3800BAA03388CBC9781EFCFE7515810DD2BF3315F525AF91B3FD

The hashes above are distinct from the installed R10 package manifest digest.
Downloaded files must match these hashes before source review, syntax check
and preflight. A network download or file-size match alone is not proof.

The user-selected installed R10 path is:

    %LOCALAPPDATA%\SeisComP-Development-R10

Example approved PowerShell invocation:

~~~powershell
$tools = Join-Path $env:LOCALAPPDATA 'SeisComP-Batch3-Audit'
$probe = Join-Path $tools 'Test-R10GuiBatch3.ps1'
$root = Join-Path $env:LOCALAPPDATA 'SeisComP-Development-R10'
$expected = '83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74'
& $probe -Root $root -ExpectedManifestSha256 $expected
~~~

A successful local result must include:

    InstallReceipt: VERIFIED
    QtPlatformPluginsAndCatalog: VERIFIED
    ENTRYPOINT_PREFLIGHT_PASS: scconfig
    ENTRYPOINT_PREFLIGHT_PASS: scrttv
    ENTRYPOINT_PREFLIGHT_PASS: scolv
    ...
    ENTRYPOINT_PREFLIGHT_PASS: scshowevent
    GUIEntrypointsPassed: 11/11
    GUIEntrypointsFailed: 0
    BATCH3_R10_GUI_PREFLIGHT_PASS
    GUI_NOT_RUN; NETWORK_ISOLATION_NOT_PROVEN; SCIENTIFIC_NOT_QUALIFIED

A failed entry is a targeted development finding, not permission to alter the
installed R10 copy. Preserve exact error and repair only the affected source
or future candidate; do not relax manifest checks or invent an offline switch.

## Development-first integration sequence

1. scconfig: resolve actual configuration precedence (including per-user
   overrides), original Qt plugin loads, XML module descriptions and a
   disposable test profile. Real GUI launch requires separate authorization.
2. scrttv: integrate synthetic/offline MiniSEED and matched station inventory
   and response metadata; default app arguments are not presumed offline.
3. scolv: integrate disposable SQLite/SCML fixtures, event interfaces and
   original provider dependencies; do not contact production DB or brokers.
4. Other original GUIs: scesv, scheli, scmapcut, scmm, scmv, scmvx, scqcv,
   scshowevent. Verify their actual resource and provider contracts. Both
   scmapcut and scshowevent may use qoffscreen in Tty/headless mode.
5. Continue independent native Windows backend, acquisition, original Python
   stack, configuration and scientific fixtures. Completion of a GUI static
   package check is not completion of the operational SeisComP port.

The earlier managed host cannot assume Windows Sandbox is available and
Hyper-V inventory permissions were denied. No elevation, firewall, adapter,
registry, system PATH, or production changes are proposed. Development is
native Windows without runtime dependencies on WSL or GitHub.

**Batch 3 status:** source implementation ready, local R10 preflight NOT_RUN,
all GUI runtime and scientific qualifications pending. This is an engineering
development milestone, not a software release certificate.

## Operator checkpoint — 2026-10-30 Batch 3A PASS

The operator ran the exact Batch 3A preflight against the separately verified R10 development installation in Windows PowerShell. The actual output recorded externally pinned R10 manifest SHA-256 **83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74**, **856** manifest entries, `InstallReceipt: VERIFIED` and `QtPlatformPluginsAndCatalog: VERIFIED`.

All eleven original GUIs individually reported `ENTRYPOINT_PREFLIGHT_PASS`, including scconfig, scesv, scheli, scmapcut, scmm, scmv, scmvx, scolv, scqcv, scrttv and scshowevent. Final: **GUIEntrypointsPassed: 11/11**, **GUIEntrypointsFailed: 0**, **BATCH3_R10_GUI_PREFLIGHT_PASS**, and **GUI_NOT_RUN; NETWORK_ISOLATION_NOT_PROVEN; SCIENTIFIC_NOT_QUALIFIED**.

**Batch 3A preflight is CLOSED/PASS**. These are entrypoint/static checks only, not a demonstration of actual GUI launch, Qt dynamic plugin behavior or numerical correctness.

## Next: Batch 3B scconfig native runtime integration (no launch yet)

1. Establish independently approved, verified network isolation and a disposable application profile; earlier Hyper-V VM inventory access was denied and an installed Windows Sandbox was not established. Do not assume the connected host is isolated or change its security/virtualization configuration.
2. Keep R9 and verified R10 unchanged. Test only in an authorized isolated Windows environment with a separate scratch/test configuration, after reviewing effective `etc/global.cfg`, possible user-home overrides, and endpoint behavior.
3. The included process-local environment helper configures paths but does **not** disable networking. Inspect pinned original scconfig accepted arguments first; do not assume an `--offline` switch or that a default GUI launch is inert.
4. First independently approved runtime case: launch original scconfig only and record whether the window opens and the expected module descriptions appear; capture Qt platform/plugin errors, stdout/stderr and actual exit without running controller/services.
5. Diagnose a real failure from captured evidence and implement a focused native Windows source fix in the **editable** C++ source tree; produce a new revision rather than modifying installed R10. Continue scrttv MiniSEED and scolv SCML fixture preparation independently.

The existing Start-DevelopmentGui.ps1 has an explicit -Run gate, but its operator flags **do not enforce isolation** or grant independent authorization. Do not use the connected host to silently bypass the established runtime-test safeguards. Runtime, acquisition and scientific qualification remain NOT_RUN.

## Batch 3B source implementation — R10 scconfig config inventory

Created `Inspect-R10ScconfigConfig.ps1` and `BATCH3B-SCCONFIG-CONFIG-REVIEW.md` to begin scconfig native Windows integration **without** touching the R10 installed package or launching any executable. The new read-only script pins the R10 SHA256SUMS identity, checks its sibling installation receipt, verifies scconfig/Qt launcher resources against manifest values, inventories module XML and expected configuration layers, and counts endpoint-relevant configuration keys **without printing values or credentials**. It also reports potential user-home and session environment overrides for isolation review.

The exact authored source was fetched back from GitHub; its standalone ASCII content SHA-256 is `2C1682C0C4D8078A1645AB0AED5988C37DD2CD2C099551FD453CADF12EF09205`. **Windows PowerShell AST and execution NOT_RUN**. An existing Batch 3A all-GUI preflight PASS (11/11) is preserved; it need not be repeated. This inventory is not an effective-configuration resolver or a network isolation mechanism.

Original SeisComP documentation indicates that scconfig can manage modules, write configurations, import metadata and invoke SeisComP module-control commands; therefore an ordinary GUI launch cannot be treated as guaranteed side-effect-free. Runtime startup is deferred to a separately approved isolated/disposable Windows environment, with fixed application arguments/configuration and explicit evidence. No changes to original C++ sources are claimed before obtaining pinned preimages and observed defects.

Follow-on engineering: inspect the original scconfig config/Qt source in the operator's editable Windows source tree, then remediate demonstrated portability issues in a new revision; continue offline scrttv MiniSEED and scolv SCML work independently.

## Operator Batch 3B static inspection — PASS; GUI startup still NOT_RUN

Operator ran the new R10 scconfig config inventory; verified manifest and install receipt, scconfig and Qt config files, **131 module XML files**, and no observed user-home overrides. The shipped default global config contained **17 assignment keys** and **5 endpoint-related key indicators**; system global contained one key. There are no observed module-specific scconfig or helper-local cfg files. All checked process-local SeisComP/Qt environment variables were unset in this nonlaunching PowerShell session. The inventory reported its completion marker and explicitly retained `EFFECTIVE_PRECEDENCE_NOT_PROVEN` / `NO_GUI_EXECUTED`.

Important new startup finding from original scconfig documentation: `var/run/seiscomp.init` determines whether the first-time setup wizard appears. The clean R10 package intentionally excluded that installation-local file; a new R10 runtime session may show the setup wizard. Do not simulate that sentinel or run the wizard on the connected office workstation. See `BATCH3B-SCCONFIG-CONFIG-REVIEW.md` for the exact outcome and the read-only/isolated startup boundary.

Next: source-side scconfig startup-path review, disposable configuration and independently authorized Windows isolation, then supervised first launch. No new C++ bug is proven or patched; keep original R9 and R10 unchanged.

## Operator verified R10 runtime/source transfer ZIP - 2026-10-31

Operator successfully built and independently ran `Test-SeisComPTransferBundle.ps1` on Windows, preserving the immutable installed R10 package and local editable Phase 8 C++ source. The zip is on the original office workstation, **not attached to this repository**:

`Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Transfer\SeisComP-R10-Windows-Runtime-and-Source-20261031.zip`

- ZIP SHA-256: `69A4A75EAB89C6109E9FEFEF1AFFD9108DE25A38D630590C640960D3F3D92C5C`
- ZIP size: 260,762,455 bytes.
- Transfer verifier result: `TRANSFER_ZIP_VERIFIED`, `VERIFIED_FILE_ENTRIES: 15131`.
- R10 payload manifest SHA-256: `83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74` (856 payload files plus manifest).
- Original uncompressed file data: 569,829,773 bytes.
- Default privacy/build-output filtering excluded 579 source files; this is a development transfer bundle rather than an exact raw backup of every phase8 file.

**Transfer package status: CREATED_AND_VERIFIED_ON_SOURCE_PC.** The verifier reports `GUI_NOT_RUN; NETWORK_ISOLATION_NOT_PROVEN; SCIENTIFIC_NOT_QUALIFIED`. CPython 3.10, pinned native toolchain/dependencies, the remaining backend modules, and fresh-machine portability/run checks are **not** included or guaranteed. User-sensitive material must be reviewed before external sharing. Transfer to another PC, re-verification and extraction there remain **NOT_RUN**.
