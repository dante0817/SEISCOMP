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
