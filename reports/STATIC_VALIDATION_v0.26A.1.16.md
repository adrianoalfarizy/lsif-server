# SAIF v0.26A.1.16 Static Validation

## Pawn structure

- Curly braces: balanced (5827 / 5827)
- Parentheses: balanced (24592 / 24592)
- Square brackets: balanced (9510 / 9510)
- Duplicate dialog IDs: 0
- `OnGameModeInit`: 1
- `OnPlayerCommandText`: 1
- `OnDialogResponse`: 1
- Adjacent Pawn string literal risk introduced by patch: 0

## Map icon registry

- Native slot budget: 100 (`0..99`)
- Public interior budget: 95
- House/property reserve: 5
- Runtime style: `MAPICON_LOCAL`
- `SetPlayerMapIcon(... MAPICON_GLOBAL)` calls: 0
- 1500m / 20-slot timer manager: disabled
- `SetPlayerMapIcon` runtime call sites: 3, all canonical/local

## Canonical mappings

- Ammu-Nation: 6
- Barber: 7
- Burger Shot: 10
- Cluckin' Bell: 14
- Hospital: 22
- Caligula's: 25
- Mod Garage: 27
- Pizza Stack: 29
- Police: 30
- Property for sale: 31
- Save House: 35
- Tattoo: 39
- Triads Casino: 44
- Clothes Shop: 45
- Restaurant: 50
- 24/7: 52
- Gym: 54
- Pay 'n' Spray: 63
- City Hall: hidden (no canonical GTA SA legend icon)

## Safety

- No public interior coordinates changed.
- No entry/exit pickup coordinates changed.
- No service point coordinates changed.
- No parked vehicle data changed.
- SQL fix backs up old icon values before update.
- Rollback SQL ends with `ROLLBACK` by default.
- No icon type 56 is introduced.

## Compiler status

`pawncc` was not available in the generation environment. Qawno/F5 remains the final Pawn compiler validation.
