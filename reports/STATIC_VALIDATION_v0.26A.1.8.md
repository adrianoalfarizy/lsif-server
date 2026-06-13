# Static Validation v0.26A.1.8

- Curly braces: 5777 / 5777
- Parentheses: 23531 / 23531
- Square brackets: 9316 / 9316
- Duplicate dialog IDs: 0
- Service rows: 91
- SCM exact: 71
- Overlay preview: 20
- Unique service keys: 91 / 91
- Unique pair-plan keys: 91 / 91
- Invalid staged coordinates: 0
- New service UI escape/newline check: passed
- Python parser compile: passed
- SCM source marker validation: passed (AMUNAT, TATTO, BARB, CLOTH, JFUD)
- Runtime mutation SQL: none
- Exact source session key used by import/verify/dry-run/rollback
- Rollback defaults to `ROLLBACK` and restores v0.26A.1.7 planner counters/statuses

Callback counts:
- OnGameModeInit: 1
- OnPlayerCommandText: 1
- OnDialogResponse: 1
- OnOfflineServiceSummaryLoaded: 1
- OnOfflineServiceListLoaded: 1
- OnOfflineServiceDetailLoaded: 1

Pawn compiler was not available in this environment; compile with project Qawno/F5 before deployment.
