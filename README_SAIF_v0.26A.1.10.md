# SAIF / LSIF Dev v0.26A.1.10 — Full 91 Public Interior Apply Transaction

## Final scope

This version applies all 91 unique GTA SA public-interior plans in one controlled transaction:

- 71 native SCM-exact service points;
- 20 translated overlay service anchors for 24/7, gym, and police;
- 2 duplicate Pizza Stack plans remain blocked and are not inserted.

The 20 overlay rows are not rejected. They become active runtime rows and are marked `requires_manual_adjustment=1` in the apply mapping so the Owner can refine them using the existing backend editor.

## Families replaced together

```text
ammunation
247
burgershot
cluckinbell
pizzastack
barber
tattoo
clothing
gym
police
```

Existing active rows in those ten families are disabled, never deleted. Other runtime families such as hospital, cityhall, and casino are not touched.

## Required order

1. Compile/deploy `lsif.pwn` with capacity 128.
2. Run the v0.26A.1.10 migration.
3. Capture a **fresh** v0.26A.1.9 public-interior archive after the last runtime edit.
4. Run the v0.26A.1.10 full dry-run.
5. Apply using the exact confirmation token.
6. Run verify.
7. Reload public interiors from DB using `/offlineexactreload` or the apply-status action menu.
8. Review and adjust the 20 overlay IDs listed by verify SQL.

## Apply token

```text
APPLY_91_OFFLINE_PUBLIC_INTERIORS
```

Recommended command from `/opt/lsif-repo`:

```bash
(
  echo "SET @saif_confirm='APPLY_91_OFFLINE_PUBLIC_INTERIORS';"
  cat database/apply/apply_saif_v0.26A.1.10_full_91_public_interiors.sql
) | sudo mariadb lsif_db
```

## Rollback token

```text
ROLLBACK_LATEST_91_OFFLINE_PUBLIC_INTERIORS
```

```bash
(
  echo "SET @saif_confirm='ROLLBACK_LATEST_91_OFFLINE_PUBLIC_INTERIORS';"
  cat database/rollback/rollback_saif_v0.26A.1.10_latest_full_91_public_interior_apply.sql
) | sudo mariadb lsif_db
```

After apply or rollback, reload runtime:

```text
/offlineexactreload
```

## Adjusting overlay service points

The verify SQL lists all 20 runtime IDs and ready-to-use commands. For each row:

```text
/pubintpoints [id]
/pubintgoto [id]
/pubintsetpoint [id] service
/pubintsetfacing [id] service
/pubintserviceradius [id] [radius]
```

The position edits are persisted in the existing `public_interiors` backend and survive reload/restart.

## Safety

- Apply aborts without the exact token.
- Apply aborts without a complete archive.
- Apply aborts if archive counts/checksums no longer match runtime.
- Apply aborts unless gates are exactly 71 exact, 20 overlay, and 2 blocked.
- Apply aborts if projected active rows exceed 128.
- All mutations are inside one transaction.
- Old rows are disabled, not deleted.
- Rollback disables the imported rows and restores prior enabled states.
