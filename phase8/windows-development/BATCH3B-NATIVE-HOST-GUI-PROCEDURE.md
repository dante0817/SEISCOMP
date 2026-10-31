# Batch 3B - Native Windows scconfig first-run procedure (NO SANDBOX)

**Operator choice (2026-10-31): proceed without Windows Sandbox.**
**State:** disposable local R10 copy verified, all 11 GUI preflights PASS,
configuration/source audits PASS, GUI runtime NOT_RUN, network isolation NOT_PROVEN.

## Scope and boundary

- Use only the **disposable** verified `%LOCALAPPDATA%\SeisComP-Scconfig-Test-R10`
  copy (856 manifest files, installed receipt). Do not launch the original
  `%LOCALAPPDATA%\SeisComP-Development-R10` or modify frozen R9/R10.
- No Sandbox, WSL, hypervisor, GitHub or source rebuild is needed for this
  scoped first-window launch. This does **not** grant production use.
- Source review showed `Configurator::showEvent` writes
  `<SEISCOMP_ROOT>/var/run/seiscomp.init` **before** presenting first-run
  setup question. The disposable copy is intentionally writable.
- `QSettings` usage in the original GUI indicates settings may be written
  to the executing user's Windows profile/registry; the disposable copy
  is **not** an absolute boundary for all side effects. Prefer a dedicated
  approved non-production Windows user profile where feasible.
- `WizardWidget::finish` can invoke `<root>/bin/seiscomp --stdin setup`.
  Do not proceed into or finish wizard, start/stop modules, modify DB,
  update inventory, download data, or enter credentials. First prompt:
  choose **No**. The main window is expected to have appeared before
  the prompt, and the prompt may hide it.
- Original scconfig has `QNetworkAccessManager`; absence of observed
  traffic in source search is not proof of no runtime connections.

## Non-Sandbox testing preconditions (operator-managed)

1. Obtain separate, actual organization/operator authorization for a
   limited **disconnected-host** GUI test. Do not put a made-up identifier
   in the launcher's `-AuthorizationReference` parameter.
2. Coordinate any temporary disconnection with your IT team; do not
   disconnect a machine currently required for critical monitoring,
   production applications, remote access or other users.
3. Make the launch scripts and test copy available locally **before**
   disconnecting; do not depend on network-mapped Y: during offline testing.
4. Disconnect Ethernet and Wi-Fi and review VPN/Tailscale/virtual adapters,
   IPv4 and IPv6 routes, and locally running SeisComP services. Do not
   alter OS firewall, adapter, registry or policy configuration to force
   a test. Manual disconnect + route inspection is an indicator, **not
   independently proven isolation**; accept this reduced boundary only
   after specific policy approval for the disconnected-host procedure.
5. Review the shipped endpoint-key indicators, effective profile, and
   user settings. The prior Batch 3B audit counted **5** endpoint-key
   indicators in `etc/defaults/global.cfg` and found **0** `.seiscomp`
   override directories. Counts are **not** resolved endpoint values.
6. Do not launch on a still-connected office workstation. If the operator
   cannot establish and obtain approval for the accepted offline boundary,
   continue development-first C++ work instead of runtime testing.

## Pre-launch command (no SeisComP execution)

Use Windows PowerShell under the intended dedicated non-production profile.
Review output privately; do not publish sensitive network/process details.

~~~powershell
$ErrorActionPreference = 'Stop'
$launcher = Join-Path $env:LOCALAPPDATA 'SeisComP-Batch3-Audit\Start-DevelopmentGui.ps1'
$root = Join-Path $env:LOCALAPPDATA 'SeisComP-Scconfig-Test-R10'
$manifest = '83D6E625B76AFF60864C3FE58FC07C86C40CF2D7705B0B8151AE212EB451CF74'
$launcherHash = '38DC736FBEDA3800BAA03388CBC9781EFCFE7515810DD2BF3315F525AF91B3FD'
if ((Get-FileHash -LiteralPath $launcher -Algorithm SHA256).Hash -ine $launcherHash) { throw 'Untrusted launcher' }
if ((Get-FileHash -LiteralPath (Join-Path $root 'SHA256SUMS.json') -Algorithm SHA256).Hash -ine $manifest) { throw 'Wrong test installation' }
Get-NetAdapter | Where-Object Status -eq 'Up' | Select-Object Name, Status, InterfaceDescription
Get-NetRoute -AddressFamily IPv4 -DestinationPrefix '0.0.0.0/0' -ErrorAction SilentlyContinue | Select-Object InterfaceAlias,NextHop,RouteMetric
Get-NetRoute -AddressFamily IPv6 -DestinationPrefix '::/0' -ErrorAction SilentlyContinue | Select-Object InterfaceAlias,NextHop,RouteMetric
& $launcher -Root $root -ExpectedManifestSha256 $manifest -Application scconfig
~~~

The final invocation **does not include `-Run`** and is nonlaunching.
Interpret all reported adapters/routes, including virtual adapters.
Never interpret this command as automated network-isolation proof.

## Conditional supervised native launch

Only **after** the disconnected-host boundary, actual approval, and
application profile have been reviewed and accepted, the already hash-
verified launcher supports the following invocation. Supply the real
approved reference yourself; do not type a placeholder or invent one.

~~~powershell
$approval = Read-Host 'Actual approved scoped runtime test reference'
if ([string]::IsNullOrWhiteSpace($approval)) { throw 'No approved runtime reference' }
& $launcher -Root $root -ExpectedManifestSha256 $manifest -Application scconfig -Run -AuthorizationReference $approval -IsolatedProfileReviewed -UserConfigurationReviewed -Confirm
~~~

These review switches are **attestations**, not mechanisms for network
isolation or host protection. A disconnected workstation is not the same
as an approved isolated VM. Follow organizational testing policy and
obtain an explicit acceptance of this non-Sandbox approach first.

Observe the splash and `First start` dialog. Click **No**, do not run setup
or invoke controller actions. Check whether main interface, module
descriptions, windows/panels and Qt resources display correctly. Close
`scconfig` and record the actual process exit, GUI observation,
Qt platform-plugin errors, and whether `var/run/seiscomp.init` appeared
in the disposable root. Do not mistake file creation for installation
corruption: the observed source intentionally performs it.

**Do not run the GUI or services for us from GitHub tools.** The program
runs locally only when the authorized Windows operator invokes it.
Never report `GUI_STARTUP_PASS` without operator evidence.

## After testing

- Remain offline until the tested process has exited and the session
  has been reviewed, then restore connections per IT policy.
- Keep original R9 and R10 immutable and separate from the test copy.
- Record actual errors before modifying original C++ code; source changes
  belong in phase8/native-working-copy followed by a new revision.
- If the first launch succeeds, proceed to verified native `scrttv`
  waveform rendering using synthetic local MiniSEED and proper inventory.
