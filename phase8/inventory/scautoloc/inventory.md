# Phase 5A direct source inventory

**Static inspection only — not a dependency closure or a successful port.**

Pinned `main`: `f63cde995e04151dc816151359a036b8b15f6019`
Pinned `common`: `92d2202a6065aad36ae7d4a9bf960b6fb91222d2`

CMake source files: **14**; local headers: **13**.

| Source | Direct include count | SHA-256 |
|---|---:|---|
| app.cpp | 13 | `b648c91f23787f6ce6b6ccf87d8eeba6e1fef3a220e0a629ed4b7558a126689a` |
| associator.cpp | 6 | `00f940d655a956f76937cef113bdb36c530ea2d8a71892ade67389b482b014d9` |
| autoloc.cpp | 10 | `2413d73ced7223e1269579f925000b5d6efcafea9e309424cf041423be5e432a` |
| config.cpp | 2 | `049d9e54922e4e95a690c136eab4ba17a943c3952c79deccdb3cfa018d5d083c` |
| datamodel.cpp | 10 | `4e66ca88e81de3f044162d3b4b7d290986d6caeae9c1dc52e200763eee5d15a2` |
| locator.cpp | 8 | `360bb8134b16bae37ea8223c43905f7672016caace3e5d3a240af5df0b3f7978` |
| nucleator.cpp | 13 | `18d81272f632c2e34bbf5fe70c7c4d0bc9caf71d20def2178460f29f43889177` |
| objectqueue.cpp | 7 | `6a90242e95ca9e9419df32df3cbd597e4c4fe64469294d08ec215de8ccb5dbf1` |
| scutil.cpp | 12 | `f418be3db804665038cbcc20cf3f241f281b09e26ccd6d1e62f53909a70131c8` |
| util.cpp | 18 | `f4608dc10cda01b2f6480d325d210d1300e1d9e7302d978023ecd9d4963d7554` |
| main.cpp | 2 | `e3c65e5f2a4415d3878ae848ea85e4a3994de149fff751d658418902d6d0fa55` |
| stationconfig.cpp | 9 | `20f2343da1f817e9dd5e4317a485077b1ea5d22e6610be2019691969a2f0b4e5` |
| stationlocationfile.cpp | 7 | `c139872c73dd87cd410724b3856a70f3f9cfa6f60d882cacaf9a03e164ffc546` |
| picklog.cpp | 4 | `18c73bdb6d122492155661636b67e17a66196ebe98f2fd8974fe7c53fd81cd52` |

## Keyword hits (source only)

- client_application: 7
- factory: 7
- messaging_network: 6
- windows_unix_os_apis: 1

## Next

Inspect `inventory.json` for direct includes, trace **transitive** CMake/ELF link dependencies, and link the registration objects and test actual `LocatorInterface::Create("LOCSAT")` factory instantiation. No BUILD PASS was asserted.

## Static LOCSAT factory and initialization trace

This source trace confirms the original registration points exist in the frozen source; it does not prove the native linker retained or registered these objects at runtime.

- `apps/processing/scautoloc/locator.cpp:109` calls `Seismology::LocatorInterface::Create(locator.c_str())` for the configured locator name.
- `apps/processing/scautoloc/autoloc.cpp:48-50` rejects initialization when the SeisComP Inventory is missing; `:84-92` creates the configured depth lookup.
- `common/libs/seiscomp/seismology/locatorinterface.cpp:52-55` dispatches through `LocatorInterfaceFactory::Create`.
- `common/libs/seiscomp/seismology/locator/locsat.cpp:201` registers the LOCSAT locator. The implementation calls the original `sc_locsat_*` functions.
- `common/libs/seiscomp/seismology/ttt/locsat.cpp:410` registers the LOCSAT travel-time table and calls the same original LOCSAT table routines.
- `common/libs/seiscomp/seismology/CMakeLists.txt:21-24` includes locator and travel-time subdirectories through `SC_ADD_SUBDIR_SOURCES` and `SC_SETUP_LIB_SUBDIR(SEISMOLOGY)`. `main/apps/processing/scautoloc/CMakeLists.txt:48` links the application to internal `client`.

The required link/load check remains open: build the original Seismology library and call the factory in a native offline process with the table assets present. Never substitute a fake locator.

