# SAIF v0.26A.1.21.1 — Property State Keyword Fix

Hotfix compile-only untuk v0.26A.1.21.

## Akar masalah

Pawn menggunakan `state` sebagai keyword. Dua callback house/property audit memakai `state` sebagai nama buffer lokal:

- `OnOfflinePropertyListLoaded`
- `OnOfflinePropertyDetailLoaded`

Compiler berhenti pada line 16455 dan 16461, lalu akan berhenti lagi pada blok detail sekitar line 16509 jika hanya blok pertama yang diperbaiki.

## Perbaikan

Seluruh buffer lokal tersebut diganti dari:

```pawn
state
```

menjadi:

```pawn
stateHint
```

Query field database tetap bernama `state_hint`. Tidak ada perubahan logic, SQL, schema, parser, queue, ownership rumah, public interior, garage, ataupun runtime.

## SQL

Tidak ada SQL baru. Tetap gunakan migration/import/verify v0.26A.1.21.

## Target compile

```text
0 Errors.
0 Warnings.
```
