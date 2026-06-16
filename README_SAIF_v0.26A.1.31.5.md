# SAIF / LSIF v0.26A.1.31.5
## Global Nearest Parking Spawn Rework

Owned vehicle calls now search a world-global parking catalog instead of garage-only positions.

Runtime sources:

- garage/storage physical slots;
- exact origins of enabled parked vehicles;
- left and right parking offsets around parked vehicle origins;
- enabled vehicle mission default spawn points;
- enabled vehicle mission pool spawn points;
- Owner-created `admin_custom` parking points.

Search is performed in stages at 300, 750, 1500, and 2500 metres, constrained to the player's interior and virtual world. Occupied points, points near another player, and temporarily reserved points are skipped.

Owner commands:

- `/parkingpointaudit`
- `/parkingpointadd [name]`
- `/parkingpointdisable [id]`
- `/parkingpointreload`

The yellow owned-vehicle map marker remains active and now identifies the selected global parking point.
