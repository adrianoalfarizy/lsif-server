# MAP ICON ALLOCATOR GATE HOTFIX AUDIT — v0.26A.1.25.1

## Root cause

The runtime allocator already caps public-service icons at slots 0–90. Hospitals are allocated first, then other public interiors until the 91-slot budget is full. House icons use a separate fixed range: slot 91 for the player's owned house and slots 92–99 for up to eight nearby for-sale houses.

The v0.26A.1.25 SQL gate incorrectly required the raw number of public candidates plus hospital fallback candidates to be at most 91. That condition is stricter than the runtime behavior and can reject a safe house-catalog apply even though the allocator protects all nine house slots.

## Hotfix behavior

- Raw public icon candidates may exceed 91.
- `public_icons_rendered = LEAST(91, candidates)`.
- `public_icons_omitted_by_allocator = GREATEST(0, candidates - rendered)`.
- Omitted is informational, not an apply blocker.
- The database policy row must still exactly specify 91 public + 1 owned house + 8 nearby houses.
- Hospital-first priority remains unchanged in Pawn.
- No map-icon candidate is added or deleted by this patch.

## Safety of the failed attempt

The failing gate was evaluated before creating an apply session and before `START TRANSACTION`. Therefore it did not disable legacy catalog rows, insert canonical rows, or update `player_houses`.
