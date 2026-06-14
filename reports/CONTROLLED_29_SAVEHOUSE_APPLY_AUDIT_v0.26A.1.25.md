# Controlled GTA SA 29-Savehouse Apply Audit — v0.26A.1.25

## Selected data

- Canonical resolver: `saif-house-property-resolver-v0.26A.1.22`
- Selected decisions: `baseline_ready`
- Canonical slots: 3–31
- Selected rows: 29
- Deferred: Wang Cars, Zero RC Shop, Verdant Meadows

## Ownership policy

- `preserve_legacy`: legacy catalog definition remains enabled and ownership row remains unchanged.
- `mapped`: ownership row is linked to the explicitly selected canonical slot.
- `refund_then_release`: rejected by this apply version.

## No-delete rule

- Existing non-preserved catalog rows become `enabled=0`.
- Imported rows remain in the database on rollback but become `enabled=0`.
- Ownership rows are never deleted.

## Runtime transforms

Exact coordinates are stored in `house_catalog`. Runtime-only normalization is applied to canonical source tags:

- arrow/pickup +1.00 Z
- player spawn +0.50 Z

## Expected default projection

With two current owners staged as `preserve_legacy`:

- 29 canonical active
- 2 preserved legacy definitions active
- 31 active catalog definitions total
- 64 compiled capacity
