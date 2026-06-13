# SAIF v0.26A.1.8 — Exact Interior Service Point Resolver

## Summary

- Staged service points: **91**
- Native SCM exact: **71**
- SAIF overlay translated: **20**
- Duplicate pair plans remain blocked: **2**
- Runtime rows changed: **0**

## Per family

| Family | Total | SCM exact | Overlay review |
|---|---:|---:|---:|
| 247 | 13 | 0 | 13 |
| ammunation | 11 | 11 | 0 |
| barber | 7 | 7 | 0 |
| burger_shot | 10 | 10 | 0 |
| clothing | 17 | 17 | 0 |
| cluckin_bell | 12 | 12 | 0 |
| gym | 3 | 0 | 3 |
| pizza_stack | 10 | 10 | 0 |
| police | 4 | 0 | 4 |
| tattoo | 4 | 4 | 0 |

## Interpretation

`scm_exact` means the interaction trigger is explicitly reconstructed from `main_decompiled.txt` variables and offsets.

`saif_overlay_translated` means GTA SA has no single equivalent service menu for the SAIF backend. The current canonical SAIF anchor is translated with exact ENEX deltas, and Owner preview remains mandatory.

All rows remain `enabled=0` and `apply_status=draft`.
