# SAIF / LSIF Dev v0.24K.21L — Clean Schema Baseline Activation

## Goal

Finalize the cleanup sequence by separating the clean runtime schema baseline from historical patch/migration clutter.

## Runtime impact

No gameplay/runtime DB behavior changes. The PWN file only updates `/version` and gamemode text.

## Files

- `lsif_v0.24K.21L_clean_schema_baseline_activation.pwn`
- `schema_clean_runtime_baseline_v0.24K.21L.sql`
- `schema_baseline_verify_v0.24K.21L.sql`
- `fresh_install_order_v0.24K.21L.md`

## Important correction from actual live DB

The actual live DB does **not** contain:

- `turf_config`
- `business`
- `businesses`

Future SQL/scripts should not assume those tables exist.

## Safety rule

Run `schema_baseline_verify_v0.24K.21L.sql` on live DB.
Do not run `schema_clean_runtime_baseline_v0.24K.21L.sql` on live DB unless rebuilding an empty database.

## Next recommended pass

After v0.24K.21L is clear, the next low-risk step is a command/admin reference cleanup pass: align `/amenus`, `/help`, `/changelog`, and audit command references with the cleaned DB/tooling state.
