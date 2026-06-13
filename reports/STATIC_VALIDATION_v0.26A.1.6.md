# SAIF v0.26A.1.6 — Static Validation

## Pawn structure

- Source: `gamemodes/lsif.pwn`
- Curly braces after stripping strings/comments: `5720 / 5720`
- Parentheses after stripping strings/comments: `22372 / 22372`
- Square brackets after stripping strings/comments: `8405 / 8405`
- Duplicate `public` definitions: `0`
- Duplicate `stock` definitions: `0`
- Duplicate `forward` definitions: `0`
- Dialog definitions: `293`
- Duplicate numeric dialog IDs: `0`
- `OnGameModeInit`: `1`
- `OnPlayerCommandText`: `1`
- `OnDialogResponse`: `1`
- New dialog ID `DIALOG_OFFLINE_CONTEXT_SUMMARY`: `1295`

Pawn compile was not executed because the matching Qawno/pawncc compiler and project includes are not present in this environment. User-side `F5` compile remains mandatory before Git/deploy.

## Resolver dataset

- Input ENEX rows: `376`
- Unique record hashes: `376 / 376`
- Resolver status:
  - resolved: `329`
  - partial: `39`
  - review_required: `8`
  - pending: `0`
- Evidence rows generated: `2081`
- Unique evidence composite keys: `2081 / 2081`
- Resolver confidence range: `20–100`
- Mean confidence: `94.64`

## Pairing

- exterior_interior_pair: `289`
- single_record: `58`
- interior_group: `17`
- multi_exterior_group: `12`

## Access scope

- public_shared: `190`
- property_private: `110`
- mission_reference: `45`
- player_private: `15`
- review_required: `8`
- event_shared: `6`
- gang_shared: `2`

## SQL safety

Generated resolver SQL contains:

- `376` updates to `offline_interior_queue` context metadata;
- `2081` evidence upserts into `offline_interior_context_evidence`;
- one import-session status update;
- resolver-specific audit-log refresh;
- one transaction ending in `COMMIT`.

It does not contain runtime DML against:

- `public_interiors`;
- `world_pickups`;
- `parked_vehicles`;
- `player_houses`;
- `public_service_config`;
- `skin_catalog`;
- `gang_preset_config`.

Those names may appear only as text values in `recommended_runtime_target` or reports.

The resolver does not update `enabled`, `review_status`, or `apply_status`. Expected state remains:

- `enabled=1`: `0`
- `apply_status <> 'pending'`: `0`

## Python tool

`python3 -m py_compile tools/offline_import/saif_enex_context_resolver.py` completed successfully.

## Deliberately unresolved rows

Eight rows remain `review_required`:

- four unnamed ENEX markers;
- two `ATRIUME` rows;
- two `ATRIUMX` rows.

They were deliberately not force-classified because source evidence is insufficient for safe runtime binding.
