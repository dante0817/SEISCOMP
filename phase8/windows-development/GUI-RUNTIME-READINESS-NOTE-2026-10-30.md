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

## 2026-10-30 operator verification — Qt binary manifest integrity 7/7 PASS

Operator ran a read-only SHA-256 comparison between seven installed R9 Qt files and their entries in the approved `SHA256SUMS.json` manifest. All seven reported **PASS**:

- `bin/qt5core.dll`
- `bin/qt5gui.dll`
- `bin/qt5network.dll`
- `bin/qt5printsupport.dll`
- `bin/qt5svg.dll`
- `bin/qt5widgets.dll`
- `bin/qt-plugins/platforms/qwindows.dll`

This establishes integrity relative to the recorded R9 package manifest, not external upstream provenance, DLL dependency closure, runtime loading, successful GUI startup, or scientific qualification. The approved manifest digest had previously been verified by the R9 preflight.

**Next read-only task:** inspect imported dependencies for `bin/scconfig.exe` and `bin/qt-plugins/platforms/qwindows.dll` with the existing MSVC `dumpbin /dependents` utility, where available. Do not infer resolution of every imported module from the import listing alone; dynamic and delay-loaded modules may need separate runtime checks in an authorized isolated environment.

## 2026-10-30 operator verification — PE direct-import inspection

Operator successfully ran `dumpbin /DEPENDENTS` against the R9 `bin/scconfig.exe` and `bin/qt-plugins/platforms/qwindows.dll`. No process launch or write was performed.

**scconfig.exe direct imports:** `seiscomp_qt.dll`, `Qt5Network.dll`, `Qt5Svg.dll`, `seiscomp_core.dll`, `boost_program_options-vc145-mt-x64-1_90.dll`, `seiscomp_config.dll`, `Qt5Widgets.dll`, `Qt5Gui.dll`, `Qt5Core.dll`, `MSVCP140.dll`, `VCRUNTIME140.dll`, `VCRUNTIME140_1.dll`, several `api-ms-win-crt-*` API-set names, and `KERNEL32.dll`.

**qwindows.dll direct imports:** `dwmapi.dll`, `IMM32.dll`, `WTSAPI32.dll`, `freetype.dll`, `KERNEL32.dll`, `USER32.dll`, `GDI32.dll`, `SHELL32.dll`, `ole32.dll`, `OLEAUT32.dll`, `Qt5Gui.dll`, `Qt5Core.dll`, `WINMM.dll`, `MSVCP140.dll`, `VCRUNTIME140.dll`, and `api-ms-win-crt-*` API-set names.

**Interpretation:** both PE import tables were readable. Import names alone do not establish DLL presence, loader search-path resolution, ABI compatibility, transitive/delay-loaded closure, GUI startup or scientific qualification. The import listing does not reveal an inherently incorrect module name. Focus next checks on the exact packaged Boost library, `freetype.dll`, SeisComP core libraries, and VC++ runtime availability; do not treat API-set names as ordinary missing files. Do not infer the build compiler from the version of the external `dumpbin` inspection utility.

**Next:** compare exact filenames/manifest SHA-256 for non-system DLLs. Retain runtime qualification pending an authorized isolated Windows test. No R9 files have been modified.

## 2026-10-30 operator verification — application DLL manifest integrity 5/5 PASS

Operator performed read-only file presence and SHA-256 verification against the approved installed R9 `SHA256SUMS.json` manifest. The following five **non-system DLLs passed**:

- `bin/seiscomp_qt.dll`
- `bin/seiscomp_core.dll`
- `bin/seiscomp_config.dll`
- `bin/boost_program_options-vc145-mt-x64-1_90.dll`
- `bin/freetype.dll`

The operator also checked VC++ runtime names `MSVCP140.dll`, `VCRUNTIME140.dll`, and `VCRUNTIME140_1.dll`: all **present in System32**, none present in the R9 `bin` folder. This layout can be normal for a host using installed VC++ redistributables; it does **not** prove runtime loader/ABI compatibility or represent a packaging defect by itself.

**Summary of demonstrated checks:** verified R9 package and GUI preflight; 131 module description XML files; Qt package paths; 7/7 Qt DLL/plugin manifest hashes; `dumpbin /DEPENDENTS` for `scconfig.exe` and `qwindows.dll`; 5/5 application-specific DLL hashes; three VC++ runtime files present in System32.

**Not demonstrated:** complete transitive/delay-load resolution, actual `scconfig` Qt startup, GUI functionality, network isolation, or scientific correctness. No unqualified GUI was executed, and the R9 package remains unchanged.

**Next milestone:** avoid repetitive primary-file checks. Proceed with source-level integration work in parallel and arrange one explicitly approved isolated `scconfig` smoke test to gather the first actual window/error evidence. No escalation of local Hyper-V privileges or modification of live services is implied.
