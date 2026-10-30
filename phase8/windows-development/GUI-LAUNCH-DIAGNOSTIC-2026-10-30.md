# P8 R9 native Windows GUI launch: local installation and environment diagnosis

**Observed date:** 2026-10-30 (Asia/Manila)  
**Candidate:** `unified-08a-r9-native` / per-user copy `%LOCALAPPDATA%\SeisComP-Development-R9`  
**Status:** copy-install PASS; environment preparation PASS; GUI functional qualification **NOT RUN** after correction.

This note records the operator's actual PowerShell output, without changing code or claiming a successful GUI launch.

## Observed sequence

1. `Install-Development.ps1` returned: `Verified development copy: <per-user development directory>`.
2. Directly running `bin\scconfig.exe` in the original PowerShell process printed:
   ```text
   [error/DESC] boost::filesystem::directory_iterator::construct:
   The system cannot find the path specified [system:3]:
   "C:/Program Files/SeisComP/etc/descriptions"
   read error: not a directory
   ```
3. The installed `bin\scconfig.exe` existed. The per-user `etc\descriptions` directory existed and contained **131 XML files**.
4. Before environment initialization, both `SEISCOMP_ROOT` and `SEISCOMP_LOCAL_CONFIG` were blank in that PowerShell process.
5. Dot-sourcing the packaged `Use-DevelopmentEnvironment.ps1` produced:
   ```text
   Process-local environment prepared. This is not network isolation or execution authorization.
   ```
   Afterwards `SEISCOMP_ROOT` pointed to the local R9 development copy, `SEISCOMP_LOCAL_CONFIG` pointed to its `work\config` directory, and the `SEISCOMP_ROOT\etc\descriptions` existence check returned `True`.

**Interpretation:** The initial path error is consistent with `scconfig` falling back to its compiled/default installation directory because `SEISCOMP_ROOT` was not set. The local copy contains the required description files. This is an environment-setup finding, not proof that `scconfig` will launch successfully after the fix.

## Repeatable environment setup (no executable launch)

In ordinary PowerShell, with the manifest digest obtained from the external verified 08C5 report:

```powershell
$destination = Join-Path $env:LOCALAPPDATA 'SeisComP-Development-R9'
$expected = '475CF040BAE301822A08A31B32A3D218A75621DAD5EEA314A563221E107DFB57'

. "$destination\share\windows\Use-DevelopmentEnvironment.ps1" -Root $destination -ExpectedManifestSha256 $expected

Write-Host "SEISCOMP_ROOT=$env:SEISCOMP_ROOT"
Write-Host "SEISCOMP_LOCAL_CONFIG=$env:SEISCOMP_LOCAL_CONFIG"
Test-Path "$env:SEISCOMP_ROOT\etc\descriptions"
```

The leading **dot followed by a space** is required to prepare the current PowerShell process; simply installing the development copy does **not** establish the environment for every later shell. The environment script sets a temporary process-local PATH and other variables. Do not use the new shell as a general development environment without checking its PATH effects.

## Launch and verification still outstanding

- A post-initialization `scconfig.exe` launch outcome has **not** been supplied. Mark GUI startup, configuration-panel function, and Qt runtime behavior **NOT VERIFIED**.
- No approved isolated runtime test procedure or verified isolation boundary is established by the environment script.
- Do not infer network-offline behavior from `SEISCOMP_ROOT`, `--offline`, or a local installation directory.
- Do not start acquisition modules, connect production databases, or load production station configuration during the initial smoke test.
- A later approved supervised GUI check should capture executable/version identity, exact environment, observed GUI/screenshots, PowerShell stdout/stderr, and whether any local or external messaging was attempted.

## Follow-up engineering improvements

1. Consider a dedicated Windows development-session helper or documented launcher that prepares the *existing* verified `Use-DevelopmentEnvironment.ps1` environment before invoking a GUI, without modifying machine/user-wide settings.
2. Audit whether the original Windows GUI honors `SEISCOMP_ROOT` consistently after session initialization; if not, investigate compiled default-root and Qt install path resolution.
3. Preserve deployment path portability. In particular, external CPython home is still pinned in the R9 candidate, and the current environment script intentionally sets a narrow process-local PATH.
4. Keep all build coverage, scientific parity, acquisition function, GUI qualification, and release-readiness states separate.

This documentation change has **no** source-code, compiled-binary, or production-configuration effect.
