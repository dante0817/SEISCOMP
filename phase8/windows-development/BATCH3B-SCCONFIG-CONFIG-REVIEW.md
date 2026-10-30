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
