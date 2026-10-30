# Batch 1 — first scconfig GUI test in an offline Windows Sandbox

**Status:** source prepared; sandbox creation, guest execution and GUI runtime NOT RUN. This is for an expressly approved, supervised development test, not production.

## Why this is needed

The R9 development installation passed `PREFLIGHT_PASS: scconfig`, manifest digest check, executable digest check and 131 XML description count. The subsequent GUI startup has not been observed. The host has Ethernet, Tailscale and Hyper-V/WSL adapters up, and a non-SeisComP process is listening on 5432 (PID 8148, identity not yet confirmed). None of these host resources should be modified merely to test the unqualified GUI.

Windows Sandbox supports a custom `.wsb` configuration with `<Networking>Disable</Networking>` and read-only mapped folders; do not use default Sandbox launch because its networking is enabled by default. The original R9 package remains immutable on the host.

## Step 1 — check whether Windows Sandbox is installed (host, read-only)

```powershell
Get-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM | Select-Object FeatureName,State
Get-CimInstance Win32_Process -Filter 'ProcessId=8148' | Select-Object Name,ProcessId
Get-NetTCPConnection -State Listen -LocalPort 5432 | Select-Object LocalAddress,LocalPort,OwningProcess
```

If Windows Sandbox is disabled, enabling it requires a separate approved Windows Features change and usually a restart. Do not change virtualization, Ethernet, Tailscale, the existing service or production firewall rules as part of this stage.

## Step 2 — generate a standalone .wsb file (host, writes only a new config file)

Review `New-OfflineScconfigSandbox.ps1`, validate it under your PowerShell policy, then run:

```powershell
$root = Join-Path $env:LOCALAPPDATA 'SeisComP-Development-R9'
$digest = '475CF040BAE301822A08A31B32A3D218A75621DAD5EEA314A563221E107DFB57'
.\New-OfflineScconfigSandbox.ps1 -Root $root -ExpectedManifestSha256 $digest
```

Output is a new `.wsb` file in the current user's TEMP folder; it DOES NOT start Sandbox, a GUI or a helper. It verifies the external manifest SHA-256 before writing. The source file comes from the Batch 1 engineering branch, not the frozen R9 install.

The configuration explicitly disables networking, clipboard, vGPU, audio, video and printer redirection. It maps **only the local R9 directory**, at `C:\SeisComP-Input`, with `ReadOnly=true`. Read-only mapping does not make the host directory secret; the guest can still inspect its contents. Review and remove any sensitive local test data before connecting that folder to the Sandbox. Do not map the entire office `Y:` drive.

## Step 3 — sandbox initialization (only after environment review/approval)

On an approved supervised test, launch the generated `.wsb` through Windows Explorer. Do not launch Windows Sandbox from its default Start-menu shortcut, which would use a different network configuration. Confirm the custom guest has no network access. The guest is temporary; closing it deletes guest-local changes.

Inside the guest, copy the mapped verified package to the guest's private local disk. These are illustrative commands for a **separately authorized** guest session:

```powershell
$src='C:\SeisComP-Input'; $dst='C:\SeisComP-R9'
Copy-Item -LiteralPath $src -Destination $dst -Recurse -Force
$expected='475CF040BAE301822A08A31B32A3D218A75621DAD5EEA314A563221E107DFB57'
if ((Get-FileHash "$dst\SHA256SUMS.json" -Algorithm SHA256).Hash -ine $expected) { throw 'Guest copy is not the approved package' }
```

Verify the guest has no production configuration or SeisComP services. The guest may not have the user-pinned Python dependency, so a GUI may still fail—this would be a portability finding rather than a failed isolation attempt.

## Step 4 — first GUI smoke test (requires separate explicit approval)

After confirming the complete guest runtime profile is isolated and approved, prepare the guest-local environment from the copied package:

```powershell
. "$dst\share\windows\Use-DevelopmentEnvironment.ps1" -Root $dst -ExpectedManifestSha256 $expected
```

The native launch, ONLY IF separately authorized and the guest remains isolated, is:

```powershell
& "$dst\bin\scconfig.exe"
```

Record the actual window/result and errors. Do not start production modules, connect databases, or import internal station records. Close the Sandbox after collecting minimal non-sensitive evidence. If the script is blocked by an organizational execution policy, stop rather than bypassing the policy.

## Completion decision

- `SANDBOX_CONFIG_CREATED` = configuration file prepared, not Sandbox started.
- `R9_GUEST_COPY_VERIFIED` = guest's manifest copy matches the R9 source, not full file-by-file hash validation.
- `GUI_PASS` only if GUI window and module descriptions load during the approved isolated session and evidence records it.
- Any GUI failure is a diagnostic finding; preserve the unchanged R9 candidate and implement the fix in a new revision.

## Alternative

If Windows Sandbox is unavailable, use an approved isolated Windows VM with no connected virtual switch. Hyper-V's `Get-VMNetworkAdapter -VMName <name>` shows switch connectivity. A VM is a **test boundary**, not a runtime requirement for native Windows SeisComP.

## References

- Microsoft Learn: https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-configure-using-wsb-file
- Microsoft Learn: https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-install

## 2026-10-30 operator checkpoint — Windows Sandbox not detected

An unelevated `Get-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM` returned `The requested operation requires elevation`; therefore the Windows optional-feature state remains **UNKNOWN**, not confirmed Disabled.

The operator subsequently checked the expected `WindowsSandbox.exe` path and Start-menu application entries. Both returned no match. This makes a currently usable Sandbox installation **unlikely** but does not definitively establish feature state.

Do not launch the prepared `.wsb` or enable optional Windows features without the applicable workstation authorization. Next read-only action: `Get-Command Get-VM -ErrorAction SilentlyContinue; Get-VM -ErrorAction SilentlyContinue | Select-Object Name,State,Generation` to see whether an isolated Windows test VM already exists. A separately approved elevated feature inspection is the alternative. Preserve the R9 install and the host Ethernet/Tailscale/PostgreSQL processes unchanged.

No GUI launch or isolation verification has occurred. Status remains `R9_PREFLIGHT_PASS / RUNTIME_NOT_RUN`.


## 2026-10-30 operator checkpoint — Hyper-V inventory authorization denied

The operator ran `Get-VM -ErrorAction Stop` on the development host. The command returned `You do not have the required permission to complete this task`. The command's availability establishes that Hyper-V management tooling is present, but it **does not** establish whether any VMs exist. The earlier empty results with `-ErrorAction SilentlyContinue` must not be interpreted as an empty VM inventory.

**Policy:** Do not attempt elevation, group membership changes, firewall/adapter changes or Windows feature enablement to bypass the managed-host restrictions. An authorized workstation administrator can supply a separately approved isolated Windows test environment or grant limited delegated management access, if appropriate.

**Development-first continuation:** keep the verified R9 candidate immutable; progress the source-only Qt/path/dependency audit and offline MiniSEED/SCML fixture preparation without launching unqualified SeisComP executables on the connected host. No `scconfig` GUI launch has yet been observed. Do not publish the internal computer hostname or other sensitive workstation details in the public repository.
