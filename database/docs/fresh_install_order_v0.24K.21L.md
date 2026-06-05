# SAIF / LSIF Fresh Install Order — v0.24K.21L

This pass activates a clean schema baseline for the repo/fresh-install workflow.
Do **not** run the clean baseline against the current production/live DB unless you are rebuilding an empty database.

## Fresh install order

1. Create empty database, for example `lsif_db`.
2. Run `schema_clean_runtime_baseline_v0.24K.21L.sql`.
3. Run seed files exported from the latest live DB seed split:
   - `seed_core_config_*.sql`
   - `seed_world_data_*.sql`
   - optional: `seed_import_queue_archive_*.sql`
4. Deploy gamemode `.amx`.
5. Start open.mp server.
6. Run in-game audit:
   - `/livedbaudit`
   - `/dbtables`
   - `/dbintegrity`
   - `/sourceaudit`

## Important actual DB notes

The actual SAIF DB does not have these tables:

- `turf_config`
- `business`
- `businesses`

Use these instead when relevant:

- `business_preset_config`
- `player_businesses`
- `gang_territories`
- `turf_war_logs`

## Live DB safety

For an existing live DB, run only `schema_baseline_verify_v0.24K.21L.sql`.
The clean schema file is a repo/fresh-install baseline, not a live migration.
