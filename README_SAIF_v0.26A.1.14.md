# SAIF / LSIF Dev v0.26A.1.14 — Full 130 Parked Vehicle Apply Transaction

## Scope

Applies exactly 130 GTA SA SCM car-generator locations:

- 68 `baseline_ready`
- 62 `progression_optional`
- 81 deferred rows remain staging-only

Existing active `parked_vehicles` rows are archived first, mapped, then disabled. They are never deleted.

## Required order

1. Compile/deploy `gamemodes/lsif.pwn` so capacity 256 and status/reload UI are active.
2. Backup database.
3. Run migration v0.26A.1.14.
4. Capture a fresh v0.26A.1.13 parked-vehicle archive.
5. Run v0.26A.1.14 dry-run gate.
6. Apply with confirmation token.
7. Run verify.
8. In game run `/offlinevehiclereload`.

## Apply

```bash
(
  echo "SET @saif_confirm='APPLY_130_OFFLINE_PARKED_VEHICLES';"
  cat database/apply/apply_saif_v0.26A.1.14_full_130_parked_vehicles.sql
) | sudo mariadb lsif_db
```

## Rollback

```bash
(
  echo "SET @saif_confirm='ROLLBACK_LATEST_130_OFFLINE_PARKED_VEHICLES';"
  cat database/rollback/rollback_saif_v0.26A.1.14_latest_full_130_parked_vehicle_apply.sql
) | sudo mariadb lsif_db
```

Then run `/offlinevehiclereload` in game.

## In-game commands

- `/offlinevehicleapplystatus`
- `/offlinecarapplystatus`
- `/offlinevehiclereload`
- `/offlinecarreload`
- `/offlinevehicledryrun`

## Safety

- Binary-safe confirmation token.
- Archive row-count and SHA-256 checksum gate.
- Exact planner-count gate: 211/68/62/81.
- Model/coordinate/dependency validation.
- No DELETE on runtime rows.
- One-command tracked rollback.
