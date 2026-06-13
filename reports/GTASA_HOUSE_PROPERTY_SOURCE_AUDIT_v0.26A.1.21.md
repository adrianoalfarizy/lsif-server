# GTA SA House / Savehouse / Property Source Audit — SAIF v0.26A.1.21

## Scope

This phase composes previously audited GTA SA source evidence and adds direct IPL `GRGE` scanning. It does not decide which entries become purchasable multiplayer houses.

## Exact evidence inventory

| Evidence | Rows |
|---|---:|
| SCM property-for-sale pickups | 32 |
| SCM locked-property pickups | 29 |
| SCM savegame pickups | 37 |
| IPL ENEX savehouse records | 99 |
| IPL ENEX property records | 6 |
| IPL GRGE garage boundaries | 52 |
| **Total** | **255** |

## Structural findings

- 32 distinct property slots (`$save_housepickup[0..31]`) have a for-sale state.
- All 32 prices resolve from SCM variables. Range: `$6,000`–`$120,000`; total offline reference value: `$1,039,000`.
- Locked-property evidence contains 26 unique slots and 3 duplicated state statements.
- Savegame evidence contains 37 statements but only 19 unique positions; 18 are repeated lifecycle/script statements.
- ENEX provides 105 candidate property/savehouse door records. It is not safe to pair them solely by nearest distance: some property slots are businesses/story assets rather than houses.
- 52 garage boundaries are kept as reference-only evidence for the later garage bridge.

## Safety conclusion

All 255 rows remain `enabled=0`, `review_status=pending`, and `apply_status=pending`. No ownership, runtime door, pickup, house, private VW, or garage behavior is changed.

## Next resolver responsibilities

1. Build one canonical record per property slot or standalone savehouse.
2. Resolve property type: purchasable house, story property, business asset, save-only location, or reference-only.
3. Pair exterior purchase pickup with the correct ENEX side and interior.
4. Resolve duplicate lifecycle statements.
5. Link nearby garage boundaries only when evidence is strong.
6. Map canonical records to SAIF `player_houses` without losing private virtual-world ownership semantics.
