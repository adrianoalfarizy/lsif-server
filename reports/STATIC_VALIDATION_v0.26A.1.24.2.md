# STATIC VALIDATION — v0.26A.1.24.2

- No 29-house apply SQL is included.
- No DELETE from `player_houses` or `house_catalog`.
- Ownership policy scripts only update staging table `offline_house_ownership_transition_plan`.
- Runtime map icon split: 91 + 1 + 8 = 100.
- House loader reads `owner_count` and purchase path blocks occupied houses.
- Unique DB guard prevents two ownership rows from sharing one `house_catalog_id`.
- Timer refreshes only house slots 91–99 every 8 seconds.

## Structural counts
- Curly: 6004 / 6004
- Parentheses: 26403 / 26403
- Brackets: 10083 / 10083
- Duplicate functions: 0
- Duplicate dialog IDs: 0
