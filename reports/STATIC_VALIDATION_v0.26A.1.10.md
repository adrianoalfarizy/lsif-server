# Static Validation — v0.26A.1.10 Full 91 Apply

- Curly braces: 5793 / 5793
- Parentheses: 23768 / 23768
- Square brackets: 9331 / 9331
- OnGameModeInit definitions: 1
- OnPlayerCommandText definitions: 1
- OnDialogResponse definitions: 1
- Duplicate dialog numeric IDs: 0
- Modified apply UI escaped tab/newline audit: passed
- Apply confirmation token: present
- Rollback confirmation token: present
- Exact gate: 71
- Overlay gate: 20
- Total insertion gate: 91
- Blocked duplicate gate: 2
- Runtime capacity: 128
- Ten replacement families: included
- Overlay adjustment mapping: included
- DELETE FROM public_interiors: absent
- Old runtime rows: disabled, not deleted
- Apply transaction: START TRANSACTION / COMMIT with SQLEXCEPTION rollback
- Rollback: imported rows disabled; previous enabled states restored

Pawn compilation must still be run with the project Qawno/pawncc environment.
