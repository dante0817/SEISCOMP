# SeisComP Phase 8 Batch 1 — GUI runtime readiness: next bounded step

**Status:** R9 package and launcher **PREFLIGHT_PASS** on operator's Windows PC. No successful post-environment `scconfig` GUI startup has been observed. This new tool is **SOURCE_READY / WINDOWS_RUN_NOT_DONE**.

## Recorded operator evidence

- `Start-DevelopmentGui.ps1` printed `PREFLIGHT_PASS: scconfig` against manifest SHA-256 `475CF040BAE301822A08A31B32A3D218A75621DAD5EEA314A563221E107DFB57`.
- Verified original GUI and process-local environment helper; 131 XML module descriptions; no user `.seiscomp` directory observed by the launcher.
- It printed `NOT_RUN` because `-Run` was omitted; no SeisComP GUI was started.
- Separate syntax-check script was intermittently blocked by Windows, though the launcher itself passed preflight; the issue does not justify bypassing endpoint security.

## New read-only helper

`Get-DevelopmentGuiReadiness.ps1` reads the R9 manifest identity, `scconfig.exe` presence, description count, environment-variable states, a short list of potential configuration override locations (file counts only), process inventory, local listening socket table on a selected port list, and network adapter state.

It does **not** launch a GUI, call the existing environment script, probe any remote service, change PowerShell policy, write files, change firewall rules, or establish isolation. The script does not print configuration content, host IPs, credentials, command lines, or production endpoint details. The configured directory checks are not an exhaustive SeisComP precedence audit.

Run only after verifying the script source is trusted and acceptable under your organization's security policy:

```powershell
$root = Join-Path $env:LOCALAPPDATA 'SeisComP-Development-R9'
$expected = '475CF040BAE301822A08A31B32A3D218A75621DAD5EEA314A563221E107DFB57'
.\Get-DevelopmentGuiReadiness.ps1 -Root $root -ExpectedManifestSha256 $expected
```

If an unsigned script is blocked, do not bypass policy or remove trust markings without verifying the source. As an alternative, the operator can run the equivalent read-only PowerShell commands interactively.

## Interpreting results

- The reported inventory is not a network isolation guarantee. No running processes and no watched listeners still cannot exclude access to external endpoints, inherited configuration, DLL loading issues or startup side effects.
- If SeisComP processes are present, do not terminate them. Resolve whether they are production services before any further run.
- If listeners appear on watched ports, review them separately. They may be unrelated applications.
- Only a separately approved and independently verified isolation boundary, together with reviewed effective configuration and scoped application arguments, can authorize a GUI launch.

## Minimal supervised GUI smoke-test proposal (not yet executed or authorized)

1. Keep the verified R9 install immutable. Store all new scripts outside its directory.
2. Choose a genuinely isolated native Windows test environment (for example a disconnected test VM or dedicated offline host). The VM is optional for development, but the runtime isolation boundary must be demonstrable. Physical/disconnected adapters alone do not necessarily isolate loopback services.
3. Verify actual effective SeisComP configuration and confirm that it cannot connect to production messaging, station services, or databases; document user-home overrides and the selected process account. Do not change production services or machine-wide firewall rules.
4. Record an explicit per-test authorization with exact executable `scconfig.exe`, approved arguments, installation digest, permitted fixtures, timeout/cleanup responsibilities and evidence collection method.
5. After those independent gates, use the reviewed launcher with `-Run` and its recorded authorization switches. Record GUI outcome, loaded Qt DLL identities, errors and process exit. Never infer GUI_PASS from a windowless `PREFLIGHT_PASS`.

## Next actions

- Review the read-only inventory output and resolve conflicts, if any, without changing existing production processes.
- Obtain observed GUI startup using the approved isolated procedure, then proceed to `scrttv` offline MiniSEED and `scolv` SCML event-fixture integration.
- Continue independent backend port work without blocking on this single runtime gate.

## 2026-10-30 operator runtime-readiness observations

The operator's read-only process query found **no matches** for the 10 checked process names: `scmaster.exe`, `seedlink.exe`, `scconfig.exe`, `scrttv.exe`, `scolv.exe`, `scautopick.exe`, `scautoloc.exe`, `scamp.exe`, `scmag.exe`, and `scevent.exe`. This is a scoped process-name inventory only, not a full system process guarantee.

The selected local listener-port query returned **two entries for TCP port 5432, both attributed to PID 8148**. Multiple entries can correspond to distinct listening addresses or IP families; do not assume two separate servers. The process identity, command line, bind addresses and whether this is an existing PostgreSQL service have **not yet** been established.

The adapter inventory reported `Ethernet`, `Tailscale`, `vEthernet (Default Switch)`, and `vEthernet (WSL (Hyper-V firewall))` as `Up`. This is not an isolation guarantee. Do not stop or modify these connections or PID 8148 as part of GUI smoke testing.

**Next focused, read-only inventory:** `Get-CimInstance Win32_Process -Filter 'ProcessId=8148' | Select-Object Name,ProcessId` and `Get-NetTCPConnection -State Listen -LocalPort 5432 | Select-Object LocalAddress,LocalPort,OwningProcess` (sanitize local addresses before publicly sharing). No SeisComP GUI launch was reported; runtime boundary and explicit application authorization remain pending.

## 2026-10-30 operator verification — GUI and Qt package layout

The operator inspected the **verified R9 per-user development installation** with read-only PowerShell commands. Findings:

- Original GUI executables `bin/scconfig.exe`, `bin/scrttv.exe`, and `bin/scolv.exe` all exist.
- `bin/qt.conf` contents: `[Paths]`, `Prefix=.`, `Plugins=qt-plugins`.
- `bin/qt5core.dll`, `qt5gui.dll`, `qt5network.dll`, `qt5printsupport.dll`, `qt5svg.dll`, and `qt5widgets.dll` all exist.
- Windows Qt platform plugin is at `bin/qt-plugins/platforms/qwindows.dll`, consistent with the configured plugin-relative path.

**Interpretation:** the GUI-package file layout is consistent with a Qt5 Windows application. File presence is not proof of complete dependency loading, DLL ABI consistency, platform-plugin initialization, GUI startup, or scientific functionality. Do not mark `GUI_PASS` or change the reported build coverage.

**Next source/read-only checks:** verify the Qt DLL and platform plugin hashes against the approved R9 manifest (if listed), then inspect native imports/dependencies with the available MSVC tooling. Continue source-only remediation until an approved isolated GUI test environment is available.

Do not publish internal hostnames, usernames, private local directories, addresses, or network information in this public repository.
