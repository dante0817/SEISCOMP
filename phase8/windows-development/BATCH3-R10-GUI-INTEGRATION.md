# Phase 8 / Batch 3 — Native R10 GUI integration

**Status (2026-10-30): SOURCE_IMPLEMENTED / OPERATOR_R10_INSTALLED / GUI_STARTUP_NOT_RUN.**

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
