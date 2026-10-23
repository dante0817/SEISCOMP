# Native Windows development copy installation

This procedure uses ordinary Windows PowerShell and a local NTFS directory.
Hyper-V and a VM are optional test-environment choices, not installation or build
prerequisites. This is a development candidate; application behavior, numerical
parity and operational use remain unqualified.

## Requirements and copy installation

Use Windows x64, the selected native VC runtime interfaces and an explicit new
per-user destination whose parent already exists. The original eleven GUI apps,
Qt5.15.18 plugins/resources, providers, twelve Python extensions and four Tau
tables are contained in the candidate. Exact files and external requirements are
in SHA256SUMS.json and share/08a/provider-manifest.json. Obtain the manifest's
SHA-256 from the external batch report; do not silently accept a digest calculated
from an untrusted copy.

The script verifies every source hash and rejects missing/unmanifested files and
reparse points. Its copy action requires a new destination, verifies every copied
file, preserves the candidate's own manifest, and writes a sibling installation
receipt. It neither overwrites an existing installation nor deletes anything.
If a copy fails, retain the partial directory and receipt/logs for review.

For example, substitute the exact candidate path and externally recorded digest:

```powershell
$candidate = 'Y:\OFFICE\IPP\2026\PROG\SEISCOMP\SeisComP_Phase5A_AI_Coder_Pack\phase8\staging\unified-08a-r4-native'
$approvedManifest = '<SHA-256 from the external 08B2 report>'
$destination = Join-Path $env:LOCALAPPDATA 'SeisComP-Development-R4'
& "$candidate\share\windows\Install-Development.ps1" -Source $candidate -ExpectedManifestSha256 $approvedManifest -Destination $destination -WhatIf
```

`-WhatIf` verifies the input and shows the copy plan without creating the
destination. Removing `-WhatIf` performs the copy only. No SeisComP executable,
extension, plugin, database transaction, dependency installer, service or GUI is
started. No system PATH, registry, firewall or production configuration changes.
No execution-policy bypass is required or provided; existing organization policy
continues to apply. No administrator account is needed for a writable per-user
destination; do not elevate merely to work around an unsuitable path.

## Environment and supervised launch procedure

In a new PowerShell session, prepare the installed copy's environment:

```powershell
. "$destination\share\windows\Use-DevelopmentEnvironment.ps1" -Root $destination -ExpectedManifestSha256 $approvedManifest
```

This creates only local work/config and work/temp directories and sets
SEISCOMP_ROOT, SEISCOMP_LOCAL_CONFIG, PATH, Qt plugin discovery and temporary paths
for the current process. Closing that session discards the environment changes.
No application is launched. These settings do not disable network access or
constitute runtime approval; review inherited endpoint variables/profiles before
any supervised execution. Original shipped endpoint examples remain dormant data.

After explicit approval of the application's local profile and argument vector,
launch the original executable from installed bin in that supervised session.
Approved profile/arguments must come from that application's actual options and
configuration; do not assume an undocumented --offline switch or that default
GUI launch has no messaging/map/waveform side effects. Application-specific local
launch authorization and behavior remain NOT_RUN in this batch. No controller,
broker, acquisition plugin or service is automatically activated.

Original GUI applications packaged: scconfig, scesv, scheli, scmapcut, scmm, scmv,
scmvx, scolv, scqcv, scrttv and scshowevent. Original Qt plugin layout is retained
under bin/qt-plugins; bin/qt.conf uses a relative plugin path. Their exact exe,
provider and Qt-resource identities are in share/windows/gui-package.json.
This static package check does not establish GUI startup, codec loading or display
behavior. Supply actual inventory/station epochs, responses, profiles, maps/NLL
grids and waveform fixtures where required; no operational data is invented.

## Python/controller and functional qualification

The original external CPython3.10.11 x64 is still required. The frontend currently
has the previously recorded Python home compiled into it:
`C:/Users/dantesoneja/AppData/Local/Programs/Python/Python310`.
The copy installer does not install Python, alter that ABI/home or claim controller
relocatability on another user's machine. Direct use of the pinned external
interpreter and SDK package paths needs its own approved launch procedure.
Optional Python packages remain unprovisioned; the original controller's restricted
handlers/STOP policy are unchanged.

The immutable08B1 payload and original07C DB harness remain separate from this
new candidate. Do not point their launcher at R4 with an old receipt/manifest.
All twelve imports, Tau reader/models/queries, database factories, SQLite schema/
transactions/Pick/Origin and DLL loader checks remain NOT_RUN. The one-process job
versus PowerShell admission-subprocess conflict must be resolved before using that
runner. A supervised local qualification procedure can replace VM-specific
requirements only with explicit authorization; no host runtime workaround is made.

A disposable VM remains useful when the agreed higher-risk isolation cannot be
provided locally. Its availability does not hold up source builds or packaging.
After genuine local qualification, prioritize database/core seismic processing
and scientific fixture comparison before broader messaging/acquisition operation.
