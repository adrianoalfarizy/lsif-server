# Static Validation — SAIF v0.26A.1.15

- Source: `saif_v0.26A.1.14/gamemodes/lsif.pwn`
- Target: `v0.26A.1.15 World Spawn Height Normalization`
- Pawn compiler: not available in this environment; Qawno F5 remains final compile validation.

## Structural checks

- Curly braces: 5866 / 5866 — PASS
- Parentheses: 24572 / 24572 — PASS
- Square brackets: 9540 / 9540 — PASS

## Targeted checks

- Parked vehicle source tag loaded from DB: PASS
- Runtime lift restricted to source prefix `offline_gtasa_parkveh130_a`: PASS
- Database `pos_z` remains unchanged: PASS
- Public interior arrow lift restricted to model `1318`: PASS
- Exterior and interior pickup coordinates use visual runtime Z: PASS
- Player interior spawn/exit coordinates remain unchanged: PASS
- No SQL migration required: PASS
- No runtime table mutation added: PASS
