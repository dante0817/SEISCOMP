# SeisComP native Windows port engineering records

This repository collects Phase 8 Windows portability patches, development and packaging notes, target inventories, and milestone reports for an engineering effort to build the original SeisComP software natively with MSVC.

The records describe work in progress. A successful build or static PE inspection does not establish runtime, scientific parity, or release readiness. Current runtime qualification remains pending separate authorization and an isolated test procedure. Consult `phase8/WINDOWS_DEVELOPMENT_ROADMAP.md` and the latest report under `phase8/logs/p8-winbackend08c5/REPORT.md` for current status.

The patch files are engineering changes against identified SeisComP source revisions. Original SeisComP source trees and compiled binaries are not included here. SeisComP components retain their upstream notices and license terms; review those terms before redistribution or use.

## Native Windows R9 startup diagnostic (2026-10-30)

The per-user R9 development copy was installed and its 131 module-description XML files were found. An initial direct `scconfig.exe` invocation failed while searching `C:/Program Files/SeisComP/etc/descriptions` because the development environment had not been loaded. Dot-sourcing the packaged environment script subsequently set `SEISCOMP_ROOT` to the R9 copy and verified that the descriptions directory exists. **No post-fix GUI launch success has been established.**

See [the R9 GUI launch diagnostic](phase8/windows-development/GUI-LAUNCH-DIAGNOSTIC-2026-10-30.md) for the exact observed outcomes and process-local setup procedure. It does not authorize unisolated runtime execution or change the current backend coverage evidence.
