# Phase 8 / Batch 3B - R10 scconfig native Windows integration

**Status (2026-10-30): Source prepared / Windows configuration inventory NOT_RUN / GUI runtime NOT_RUN.**

## Why Batch 3B needs a separate configuration boundary

Batch 3A finished **11/11** R10 GUI entrypoint preflights with no failures, but started no
SeisComP executables. scconfig is not a passive viewer. Its UI can save or modify
configuration and invoke controller actions such as module starts, stops, reloads,
inventory operations and update-config. A successful preflight alone must not be
relabelled as GUI startup, native Qt loading, or offline operational safety.

Current SeisComP configuration documentation identifies a layered set of
**defaults -> system -> user/local overrides**, normally reading:

1. `etc/defaults/global.cfg`
2. `etc/defaults/scconfig.cfg`
3. `etc/global.cfg`
4. `etc/scconfig.cfg`
5. `$HOME/.seiscomp/global.cfg` (or configured local-configuration directory)
6. `$HOME/.seiscomp/scconfig.cfg` (or configured local-configuration directory)

SeisComP also supports `SEISCOMP_LOCAL_CONFIG` to redefine its local
configuration directory. These statements are based on the current public
documentation and **must be checked against the pinned original native port**
before claiming effective configuration resolution.

References:
- https://www.seiscomp.de/doc/base/concepts/configuration.html
- https://www.seiscomp.de/doc/apps/scconfig.html
- https://qthub.com/static/doc/qt5/qtdoc/qt-conf.html

## Implemented source: Inspect-R10ScconfigConfig.ps1

The Batch 3B script performs read-only inspection, without starting a
controller or GUI. It:

- Pins the verified R10 manifest SHA-256 and 856-entry installation receipt.
- Rechecks exact scconfig.exe, qt.conf, process-local environment helper, and
  qwindows.dll hashes against the manifest.
- Counts available scconfig module XML descriptions.
- Reports presence and counts of assignment keys in defaults, system and
  prospective helper-local scconfig/global config files.
- Reports **counts only** for keys related to endpoints, servers, messaging,
  recordstreams and databases; it **does not print keys' values, credentials,
  IP addresses, URLs or configuration file bodies**.
- Reports only the presence/count of possible user-home override directories
  and the state of process environment override variables.
- Does not claim its observed config files form an exhaustive effective-config
  resolver. No GUI, Python, service, database, station or network execution.

### Externally pinned script SHA-256

    2C1682C0C4D8078A1645AB0AED5988C37DD2CD2C099551FD453CADF12EF09205

### Operator invocation

Download the script to the existing **local** Batch 3 engineering-tools
directory. Validate its SHA-256 and PowerShell syntax; review the source and
follow organizational trust policy before running. Do not place it inside the
installed R10 directory. For example:

~~~powershell
$tools = Join-Path $env:LOCALAPPDATA 'SeisComP-Batch3-Audit'
$path = Join-Path $tools 'Inspect-R10ScconfigConfig.ps1'
$root = Join-Path $env:LOCALAPPDATA 'SeisComP-Development-R10'
$expected = '83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74'
& $path -Root $root -ExpectedManifestSha256 $expected
~~~

Expected *markers* only, not already measured results:

    R10InstallReceipt: VERIFIED
    ScconfigAndQtConf: VERIFIED
    DescriptionXMLCount: [measured count]
    CONFIG_SOURCE: DEFAULT_GLOBAL Present=[...] Keys=[...] EndpointKeyIndicators=[...]
    ...
    SCONFIG_CONFIG_INVENTORY_COMPLETE
    VALUES_NOT_DISPLAYED; EFFECTIVE_PRECEDENCE_NOT_PROVEN
    NO_GUI_EXECUTED; NO_NETWORK_ISOLATION_PROVEN; NOT_RUNTIME_QUALIFIED

Counts of endpoint-related keys are **indicators**, not proof that a
configuration is safe or that a network connection was made.

## Actual scconfig GUI integration - separately authorized later

1. Confirm an independently enforced and verified disconnected Windows test
   boundary (approved isolated VM or authorized equivalent). The current host
   should be treated as network-connected. Previous Sandbox availability was
   not established and Hyper-V inventory was permission-denied; do not
   elevate or adjust host firewall/adapters to work around these restrictions.
2. Use a disposable guest-local copy of the pinned R10 payload with newly
   reviewed temporary configuration and no inherited user .seiscomp profile;
   do not modify R9, installed R10 or use a production database or SeedLink.
3. Confirm scconfig accepted options from the pinned native source, and the
   process-local Qt plugin resolution. Do not assume an undocumented
   '--offline' option or rely solely on environment settings for isolation.
4. Obtain explicit local execution approval; first launch only scconfig,
   recording actual window display, module list, Qt plugin diagnostics and
   any attempted controller child processes. Do **not** click Start/Stop/
   Restart/Check/Reload/Enable/Disable/Update config/Inventory actions.
5. If actual startup fails, patch the **editable C++ workspace** and build a
   new revision with recorded preimage; do not patch the verified installed R10.
   If it starts, continue scrttv offline MiniSEED and scolv disposable SCML
   integration on independent branches.

**Completion criteria:** a screenshot or verified observation of scconfig
opening with module descriptions, native Qt platform/plugin loading confirmed,
and bounded evidence of no operational side effects inside approved isolation.
Only then mark Batch 3B GUI startup PASS. The read-only config inventory is
an engineering milestone, not the runtime test itself.

## Operator checkpoint: R10 scconfig configuration inventory PASS

2026-10-30 operator output for `Inspect-R10ScconfigConfig.ps1` against installed R10:

```text
R10Manifest: 83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74
R10InstallReceipt: VERIFIED
ScconfigAndQtConf: VERIFIED
DescriptionXMLCount: 131
CONFIG_SOURCE: DEFAULT_GLOBAL Present=True Keys=17 EndpointKeyIndicators=5
CONFIG_SOURCE: DEFAULT_SCCONFIG Present=False Keys=0 EndpointKeyIndicators=0
CONFIG_SOURCE: SYSTEM_GLOBAL Present=True Keys=1 EndpointKeyIndicators=0
CONFIG_SOURCE: SYSTEM_SCCONFIG Present=False Keys=0 EndpointKeyIndicators=0
CONFIG_SOURCE: HELPER_LOCAL_GLOBAL Present=False Keys=0 EndpointKeyIndicators=0
CONFIG_SOURCE: HELPER_LOCAL_SCCONFIG Present=False Keys=0 EndpointKeyIndicators=0
UserHomeSeiscompOverrideDirsPresent: 0
USER_HOME_OVERRIDE_FILE: global.cfg PresentInDirs=0
USER_HOME_OVERRIDE_FILE: scconfig.cfg PresentInDirs=0
SESSION_ENV: SEISCOMP_ROOT UNSET
SESSION_ENV: SEISCOMP_LOCAL_CONFIG UNSET
SESSION_ENV: QT_PLUGIN_PATH UNSET
SESSION_ENV: QT_QPA_PLATFORM_PLUGIN_PATH UNSET
SESSION_ENV: QT_QPA_PLATFORM UNSET
SCONFIG_CONFIG_INVENTORY_COMPLETE
VALUES_NOT_DISPLAYED; EFFECTIVE_PRECEDENCE_NOT_PROVEN
NO_GUI_EXECUTED; NO_NETWORK_ISOLATION_PROVEN; NOT_RUNTIME_QUALIFIED
```

**Assessment:** static R10 scconfig config source inventory **PASS**, with 131 descriptions and zero observed user-home override directories. The five endpoint-key indicators are *only text key classifications from shipped defaults*, not verified effective values, configured connections or proof of network activity. It is expected that the SeisComP/Qt process-local variables are unset until the reviewed environment helper is activated in a separate execution session. This output does not establish a safe disconnected profile or permit a live GUI launch.

### Important first-run wizard hazard

The official scconfig documentation states that the first-start setup prompt uses the presence of `var/run/seiscomp.init` to decide whether initial setup was completed. The R10 package builder **explicitly excluded** an unmanifested `var/run/seiscomp.init` as installation-local state while assembling the clean distribution. Consequently the new R10 installation is **expected** to lack that marker and scconfig may open an initial setup wizard instead of the normal module window. This is not evidence of a bug. It changes the first supervised GUI test: do **not** complete the wizard, supply production credentials, configure scmaster, connect databases or start modules. If the wizard appears, record it as a valid startup observation and close the application without accepting setup. Do not fabricate `seiscomp.init` or modify the verified R10 installation to suppress the prompt.

Documented first-start behavior: https://www.seiscomp.de/doc/apps/scconfig.html . Configuration precedence: https://www.seiscomp.de/doc/base/concepts/configuration.html .

**Next native engineering milestone:** locate the authoritative editable C++ scconfig source and inspect the startup-marker/wizard path, original root resolution and Qt plugin startup behavior. Execute GUI in an independently approved isolated Windows environment only; use a disposable native Windows copy with a reviewed configuration. Batch 3B first-run/GUI runtime remains **NOT_RUN**.

## Source discovery - editable native scconfig C++ tree

2026-10-30 operator read-only search identified the original native C++ source files under the **phase8/native-working-copy/src/base/common/apps/tools/scconfig** tree (primary editable development copy). The historically preserved **phase8/source-snapshot/common/apps/tools/scconfig** and **phase8/working-copy/src/base/common/apps/tools/scconfig** are comparators. The `phase8/build/vs2022-*` and historical Phase 7 `build-attempt-*` paths are generated build artifacts, **not editable C++ source**.

SHA-256 identities as reported by the operator:

| File | Native working copy | Snapshot/older working copy |
|---|---|---|
| `main.cpp` | `B60C6478E0721CDCA0A6776CC37C29278E6D85BAFC3DF16D4EBE9C87FADCECDD` | Same hash |
| `CMakeLists.txt` | `B17CDA78A808DF738E6D15AE0656B3D09041FAF26A23417635337077EA918EC9` | `292DB70804A1AA1FF79BC4F35908DFD446B2A767FFE4437900C7CF947F24F57A` |

The native CMake difference is consistent with the archived **P8-WINGUI-04D** scoped correction that excludes local FlowLayout compilation on WIN32 while linking internal `seiscomp_qt`, and preserves the original non-Windows compilation source. Exact historical patch exists at `phase8/patches/P8-WINGUI-04D-scconfig-flowlayout.patch`; do not revert the native CMake version to the older snapshot.

New source tool: `phase8/windows-development/Inspect-ScconfigNativeSource.ps1`, independently pinned SHA-256 **`F1091D9A8D29A865204F8097AF3D24D095A4E4C4233FE373EEBD683F5944A5A5`** (5,106 ASCII bytes). It verifies operator-reported main.cpp/CMake hash baselines and reads only bounded startup/Qt/wizard/configuration references in main.cpp, wizard.cpp, configurator.cpp, gui.h, http.cpp and CMakeLists.txt; does not edit code, build, run binaries or connect externally.

Status: **SOURCE_DISCOVERED / HISTORICAL_CMAKE_CORRECTION_PRESERVED / ORIGINAL_CPP_STARTUP_PATH_NOT_YET_INSPECTED / GUI_RUNTIME_NOT_RUN.** The executable startup logic cannot be inferred from filename hashes alone. After operator executes the source inspection, use actual source lines to determine whether there is a real Windows portability defect before suggesting a patch; preserve the verified R10 installation and produce a new source revision if needed.

## Operator result: targeted original C++ source inspection - first pass complete

2026-10-30 read-only PowerShell output confirmed `SOURCE BASELINE VERIFIED` and `NATIVE SOURCE INSPECTION COMPLETED`. These are source inspections only. **No source code was changed, no GUI launched and no build executed.**

| Original source file | Operator-observed evidence | Engineering interpretation |
|---|---|---|
| `main.cpp` | `#include <QApplication>` line 34; high DPI Qt attributes lines 282-283; `QApplication app(argc, argv)` line 286 | Native Qt application startup exists; does not prove successful platform plugin loading |
| `main.cpp` | Existing-instance warning line 292; splash messages near 304, 326 and 342 | Startup/configuration sequence is present; guard and effects need contextual review |
| `wizard.cpp` | Wizard window title line 115; `_ranSetup = false` line 119; `ranSetup()` lines 211-212; abort warning lines 222-223 | Setup workflow exists; first-run decisions and side effects not established from matches alone |
| `configurator.cpp` | Mode selector near lines 252-267; `env->appConfigDir()` displayed on 267 | Application configuration directory used in GUI; exact user/root resolution needs inspection |
| `gui.h` | `Configurator : public QMainWindow` at 232; `wizard()` declared at 307 | Original Qt widget application architecture confirmed |
| `http.cpp` | `QNetworkAccessManager` signal wiring lines 38-39; `HttpRequest::get` at 59 | Network-capable HTTP client present; its actual invocation and startup network activity are NOT established |
| `CMakeLists.txt` | `IF(NOT WIN32)` / FlowLayout append lines 103-104; `IF(WIN32)` internal `qt` linkage lines 109-110 | Prior Windows-only FlowLayout ownership fix remains in native editable source |

**Assessment:** the read-only first-pass inspection found a coherent original native Qt startup path and preserved the CMake correction. It did **not** demonstrate a concrete portability defect, runtime DLL failure, unsafe connection, or effective first-run decision. Do not invent a C++ patch or mark GUI runtime PASS.

**Next targeted code-reading step:** inspect actual `main.cpp` block ~270-385 and the call sites of `Configurator::wizard`, `WizardWidget`, `ranSetup`, `seiscomp.init`, `QProcess`, `HttpRequest::get` and `SEISCOMP_ROOT` in the editable tree (with line numbers). Distinguish an explicit user-initiated action from an automatic startup side effect. If a defect is demonstrated, create an isolated source change with exact file preimages. Independently approved offline test isolation is still required for a native GUI launch. Installed R9/R10 are immutable.

## Operator result: contextual native scconfig startup lines (Batch 3B)

Observed in operator's Windows PowerShell, against the pinned local `phase8/native-working-copy/src/base/common/apps/tools/scconfig`:

- `main.cpp:277-286`: Qt5 high-DPI attributes followed by `QApplication app(argc, argv)`.
- `main.cpp:288-300`: `Environment::Instance()->installDir()` informs `RunGuard`; duplicate instance prompts before proceeding.
- `main.cpp:302-306`: splash opens and `Configurator c(Seiscomp::Environment::CS_CONFIG_APP)` is constructed.
- `main.cpp:326-345`: `System::SchemaDefinitions::load(filebase + module_desc)` returns errors 1/2 on unreadable or empty definitions; a `System::Model` is created and `c.setModel(&model)` must return true.
- `main.cpp:347-351`: splash closes, app processes events, `c.resize(800,600)` and `c.show()` display the main Qt window.
- `configurator.cpp:1587`: existing action triggers `Configurator::wizard()`; sentinel reference appears around 1932, but controlling branch has not been shown.
- `configurator.cpp:2136-2168`: wizard entrypoint, Widget and `ranSetup()` usage found; context not yet examined.
- `wizard.cpp:455-494`: `WizardWidget::finish()` creates a `QProcess`, sets channels and finished signal; exact command and invocation conditions must be read before allowing wizard actions.
- `http.cpp:59`: HTTP helper has `get()` implementation, but *no automatic startup call* has been proven.
- `main.cpp:353-385`: optional `--panel`, `--module` and `--station` selection paths; not equivalent to an offline switch.

**Engineering assessment:** the original source has an explicit native Qt startup and 131 installed XML description files were observed earlier. However no DLL loads, runtime XML parsing, GUI display or isolation have been demonstrated yet. `QProcess` appears in a wizard-finish path but source excerpts do not prove an automatic subprocess launch. No source defect is established and no unreviewed C++ patch should be attempted. R9 and R10 remain immutable.

**Next bounded read-only inspection:** print line-numbered `configurator.cpp` around 1900-1965 and 2125-2185, `wizard.cpp` around 445-502, and `main.cpp` around 385-430 or to EOF. This confirms wizard invocation, sentinel use, subprocess command, and event-loop termination before isolated runtime qualification.

## Operator confirmation: first-run state write and setup child process

2026-10-31 operator read the full relevant native C++ source blocks. **Source control flow is now resolved**; no claim of actual GUI execution.

**`main.cpp:386-425`:** optional `--station`/`--parameter` selections and error dialogs complete; final `return app.exec()` at line 424 runs the Qt event loop. `c.show()` occurred earlier at line 351.

**`configurator.cpp:1916-1953`:** on first `Configurator::showEvent` (`_firstShow`), the program restores UI geometry and calls `Environment::Instance()->installDir()`; computes `<root>/var/run/seiscomp.init`; returns early if the marker exists. If it does not exist, it creates `<root>/var/run` with `QDir::mkpath`, opens/truncates `seiscomp.init` via `QFile::open(QIODevice::WriteOnly|QIODevice::Truncate)` and closes it **BEFORE showing the 'First start' setup question**. The result of mkpath/open is not checked by the shown code. Clicking **No** skips the wizard, **but does not undo the marker creation**. Clicking Yes calls `wizard()`.

**`configurator.cpp:2136-2177`:** `wizard()` builds setup input groups, runs modal `WizardWidget::exec()` if nonempty, and reloads user config after `ranSetup()`.

**`wizard.cpp:455-495`:** `WizardWidget::finish()` changes to output page; unless compile-time `DRY_RUN` is enabled, uses `QProcess::start` with program `QString('%1/bin/seiscomp').arg(env->installDir().c_str())`, arguments `--stdin setup`, and writes serialized setup data to the child process. This child action is associated with finishing the wizard, **not proven automatic on mere GUI startup**. The exact viability of the script/executable path under Windows must be verified independently. The `DRY_RUN` preprocessor symbol is not an established runtime safety mechanism.

**Operational consequence:** R10 is an immutable, receipt-verified development installation. Because the R10 builder intentionally excluded the installation-local `seiscomp.init` marker, the first display of its normal GUI is expected to ATTEMPT A WRITE inside installed R10. Even pressing 'No' at the prompt does not avoid that write; launch must **never** target the verified R10 directory when requiring immutability. Testing requires a disposable guest-local copy with suitable writable `var/run` and separately verified network isolation. Do not create the marker as a fake workaround in the verified installation.

**Remaining controlled sequence:** (1) read-only inspect existence/type/hash of `bin/seiscomp`, `bin/seiscomp.exe`, and init marker in installed R10 without launching any executable; (2) prepare a disposable root and isolated Windows GUI test session under separate approved authorization; (3) record initial window, module definitions, expected first-start prompt, Qt plugin loads and any process/network activity. Do not select Yes, run setup, start/stop services or enter credentials. If no isolated test environment is available, continue other native GUI/backend source implementation rather than running unqualified processes on connected host.

**Checkpoint: BATCH3B_STARTUP_CONTROL_FLOW_REVIEW_PASS / GUI_RUNTIME_NOT_RUN / NETWORK_ISOLATION_NOT_PROVEN / SCIENTIFIC_NOT_QUALIFIED.**

## Disposable R10 test-copy preparation - reuse existing installer

The existing manifest-verified `share/windows/Install-Development.ps1` (source read in repository) can be used to create a **new local NTFS R10 test copy** under `%LOCALAPPDATA%`, without launching SeisComP. It verifies every listed source file, rejects unmanifested source files/reparse points, copies to a never-before-used destination, and writes a sibling installation receipt. It does not copy the sibling original installation receipt as part of the package.

**Limitations:** (1) the copied test directory is not itself network isolation and must not be launched on the connected office workstation; (2) the test copy is intentionally writable and will no longer match an immutable release state once `scconfig` creates `var/run/seiscomp.init`; (3) the installer demands that all source files match the R10 856-entry manifest, and may reject the original R10 source if other earlier runtime operations created unmanifested files; (4) the destination must be a new path on a fixed local NTFS volume and source must contain no reparse points. Preserve failure evidence; do not delete or overwrite a conflicting previous test path.

Suggested operator copy target (new only): `%LOCALAPPDATA%/SeisComP-Scconfig-Test-R10`. The actual supervised launch should occur only after moving the verified test payload into an independently approved, disconnected Windows environment and ensuring a guest-local writable installation. Do not assume the existence of a Windows Sandbox, and do not run GUI directly from any read-only host mapping.

Before enabling or finishing first-run setup, inspect `bin/seiscomp` and `bin/seiscomp.exe` entrypoint presence and platform type on the disposable copy, since `wizard.cpp` currently requests the extensionless `<root>/bin/seiscomp` command. An absent/invalid Windows entrypoint would be a concrete integration gap **only after** package/source context is verified; it is not reason to test the wizard on the office host.

## Operator checkpoint: disposable R10 test install PASS and next isolation plan

2026-10-31 Windows PowerShell operator result:

```text
Verified development copy: C:\Users\dantesoneja\AppData\Local\SeisComP-Scconfig-Test-R10
bin\seiscomp: False
bin\seiscomp.exe: True
var\run\seiscomp.init: False
R10 TEST COPY PREPARED
NO GUI OR SERVICE EXECUTED
```

The original verified R10 copy installer reported successful completion, and the operator's subsequent independent script confirmed the destination SHA256SUMS digest and installation receipt (`856` files). **This closes the disposable test copy preparation milestone.** The destination is writable test material; installed R10 remains unchanged. No launch or network isolation was performed.

Original `wizard.cpp:461` uses an absolute Windows-compatible forward-slash path `<root>/bin/seiscomp` without `.exe`; the test install contains only `seiscomp.exe`. The Qt QProcess documentation states `.exe` is usually optional on Windows, with caveats depending on CreateProcess invocation: https://doc.qt.io/qt-6/qprocess.html . The Microsoft CreateProcessW documentation includes path/extension details: https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-createprocessw . This is **not currently a proven defect** in the pinned Qt5.15.18 behavior and must not trigger an unverified C++ patch. Do not run the setup wizard merely to test name resolution.

New source-only tool `New-R10ScconfigSandboxConfig.ps1` generates a `.wsb` with networking/vGPU/clipboard/audio/video/printer disabled, the **disposable R10 test copy only** mapped read-only to `C:\SeisComP-Input`, and no automatic logon command. It verifies the pinned R10 manifest, receipt and selected essential file hashes, rejects a preexisting init marker and existing output, and writes the config into an existing engineering folder (recommended Y: workspace). Tool source SHA-256: **`DC73BF4D76D96E683E6853662A1AF0BCAA7071C4B4865087EDEE66B9B4D65ECE`** (6,051 ASCII bytes), verified by GitHub source readback. **Windows execution NOT_RUN; .wsb NOT_CREATED by developer.**

Windows Sandbox is an optional candidate isolated test platform **only if already available and approved by host policy**; do not alter Windows Optional Features, install a hypervisor, elevate, change firewall or adapters without separate authorization. Microsoft documentation: https://learn.microsoft.com/en-us/windows/security/threat-protection/windows-sandbox/windows-sandbox-configure-using-wsb-file . A prepared file containing `<Networking>Disable</Networking>` is not evidence of an actually isolated running guest.

After independent isolation approval and verification, copy `C:\SeisComP-Input` from read-only guest mapping into a new guest-local writable root; verify package identity again; review guest settings and launch approval before starting `scconfig.exe`. Do not execute GUI from the read-only mapped host folder, because `Configurator::showEvent` creates `var/run/seiscomp.init`. At first-start question choose No; never finish setup. Collect GUI, Qt plugin and process evidence inside the guest only. Work on separate source fixes only for observed bugs.

**Current status: BATCH3B_DISPOSABLE_TEST_COPY_PASS / SANDBOX_CONFIG_TOOL_SOURCE_READY / GUI_RUNTIME_NOT_RUN / NETWORK_ISOLATION_NOT_PROVEN / SCIENTIFIC_NOT_QUALIFIED.**

## Operator decision: no sandbox, keep host internet connected

2026-10-31 operator requested **proceed without Windows Sandbox and without disconnecting the host's network**. Adopt that operating constraint for further development. Do not silently substitute a Sandbox/VM or require host-wide network disconnection. **This is not proof or approval of application-level network containment**, and does not override the separate established GUI-runtime approval gate.

**Proposed connected-host route:** use only the existing disposable `SeisComP-Scconfig-Test-R10`; keep R9 and verified installed R10 unchanged; preserve access to the internet for other applications. If authorized by the host owner/organization, apply narrowly scoped **outbound Block rules** for the disposable `bin/scconfig.exe` and `bin/seiscomp.exe` executables, on all profiles, review effective rule policy, and verify that their outbound traffic is prevented. Windows Defender Firewall supports program-specific outbound rules: https://learn.microsoft.com/en-us/powershell/module/netsecurity/new-netfirewallrule?view=windowsdefender . This is **not equivalent to a disconnected host** and does not automatically contain unknown helper processes or external browsers. Do not use the existing guarded launcher with false `-IsolatedProfileReviewed` claims.

Created `Test-R10ScconfigConnectedHost.ps1` in the development branch to inspect the disposable test root's verified manifest/receipt and selected executable/Qt file hashes and report whether active outbound firewall rules were **observed** for `scconfig.exe` and `seiscomp.exe`. The script does not modify firewall rules, probe network endpoints, launch GUIs, elevate, or alter system settings. A rule being present is **not proof of effective blocking**. Exact source SHA-256 **`EFDB1E3AF0381176D3CF3497CA5D5C3FB408B832023F844C890D626A47281DE4`**, 6,114 ASCII bytes, re-fetched from GitHub and hashed; local Windows PowerShell execution NOT_RUN.

**Next operator check (read-only):** inspect whether firewall management is policy-controlled and whether application-specific egress blocking can be authorized, without changing any rules yet. If approved and independently verified, perform a strictly bounded GUI-only startup from the disposable test root, choose **No** to setup if first-run prompt appears, avoid all module-management and data actions, and collect only local Qt/GUI/exit evidence. Do not treat the operator's request to keep internet connected as authorization to bypass host security controls. If individual app egress controls cannot be installed or verified, continue native source implementation rather than launching uncontained executables on an office production network.

**Status:** CONNECTED_HOST_WORKFLOW_SELECTED / DISPOSABLE_R10_VERIFIED / APP_EGRESS_CONTROLS_NOT_VERIFIED / GUI_RUNTIME_NOT_RUN / SCIENTIFIC_NOT_QUALIFIED.

## Connected-host Windows Firewall readiness measured (operator)

2026-10-31 user executed the direct read-only readiness check in PowerShell. Disposable test `scconfig.exe=True`, `seiscomp.exe=True`; Windows Firewall Domain, Private and Public `Enabled=True`, `DefaultOutboundAction=Allow`; `PowerShell elevated=False`. No application started and no firewall settings changed.

This means **network access is still permitted by default** and no app-specific outbound block rule has yet been verified; it does not prove any traffic occurred or that the executables are blocked. Creating program-specific firewall rules on this host requires separately approved privileged administration under applicable organizational policy. User explicitly requested to leave internet connected and not use Windows Sandbox.

Prepared `BATCH3B-CONNECTED-HOST-TEST-BOUNDARY.md` as a non-applying, precisely scoped proposal: only the two disposable test executables would be restricted by authorized outbound program block rules, leaving other host applications connected. It documents limits concerning helper processes and mandatory effectiveness checks. No policy change or host-level action was performed and the existing guarded launcher must not be invoked with fictional isolation attestation.

**State: CONNECTED_HOST_READINESS_OBSERVED / R10_TEST_COPY_PASS / APPLICATION_EGRESS_NOT_VERIFIED / GUI_RUNTIME_NOT_RUN.**