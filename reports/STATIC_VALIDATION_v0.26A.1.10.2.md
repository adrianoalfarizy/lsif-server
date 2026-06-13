# Static Validation — v0.26A.1.10.2

- Apply procedure still begins with `DROP PROCEDURE IF EXISTS`.
- Confirmation token uses `VARBINARY` and `_binary` literal.
- Archive checksum comparison casts both sides through unary `BINARY`.
- Runtime mutation section remains unchanged.
- Rollback token is binary-safe.
- No Pawn or schema changes.
