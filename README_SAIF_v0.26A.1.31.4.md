# SAIF / LSIF v0.26A.1.31.4 — Vehicle ALT Polling Fallback Hotfix

Hotfix for in-vehicle ALT interactions that work through `/housestorage` but do not respond to the physical ALT key.

Changes:
- Keeps `OnPlayerKeyStateChange` routing.
- Supports `KEY_FIRE`, `KEY_ACTION`, and `KEY_WALK` while in a vehicle.
- Adds lightweight `OnPlayerUpdate` polling fallback through `GetPlayerKeys`.
- Adds a per-player held-key latch to prevent duplicate dialogs.
- Resets the latch when leaving a vehicle, disconnecting, or resetting house-storage runtime.
- No SQL or database changes.
- Existing owned-vehicle yellow spawn map marker remains active.
