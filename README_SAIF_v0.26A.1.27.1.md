# SAIF / LSIF Dev v0.26A.1.27.1 — World Garage Loader Compile Hotfix

## Root cause

Pawn 3.10.11 does not concatenate adjacent string literals in the two new v0.26A.1.27 blocks:

1. `LoadWorldGarageCatalog()` SQL query;
2. `OnGarageCatalogAuditLoaded()` dialog body.

The first block caused errors around lines 8243–8248. The second block would have caused the same error after the first block was fixed.

## Fix

- Build the SQL query with `format` + `strcat` into `query[768]`.
- Build the audit dialog in several formatted sections using `body[2400]` and `line[640]`.
- No SQL schema, data, ownership, house, vehicle, or garage policy behavior changed.

## Replace and compile

Replace `D:\LSIF-DEV\gamemodes\lsif.pwn`, then compile with F5.

Expected:

```text
0 Errors.
0 Warnings.
```

Do not run migration/deploy until compilation is clear.
