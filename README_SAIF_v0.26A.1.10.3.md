# SAIF / LSIF Dev v0.26A.1.10.3 — Restaurant Map Icon Brand Fix

Fixes the restaurant map icon fallback and persists brand-specific icons for Full-91 imported rows.

- Burger Shot: icon 10
- Cluckin' Bell: icon 14
- Well Stacked Pizza / Pizza Stack: icon 29

## Existing live import
Run `database/fixes/20260613_saif_v0.26A.1.10.3_restaurant_map_icon_brand_fix.sql`, then reload public interiors in-game.

## Future rollback/re-apply
Use `database/apply/apply_saif_v0.26A.1.10.3_full_91_public_interiors.sql`; it writes the correct restaurant icon IDs during insert.

No schema changes.
