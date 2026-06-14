# SAIF / LSIF v0.26A.1.30.1 - House Vehicle Storage Complete Runtime

Direct implementation of the new house vehicle storage feature.

- 12 houses use exact GTA SA garage geometry immediately.
- 17 remaining houses receive disabled pending rows and can be configured through `/amenus -> House Vehicle Storage Editor`.
- House owners see a red checkpoint near their enabled storage location.
- ALT while driving an owned vehicle opens store confirmation.
- A committed store writes `player_vehicle_storage`, logs a transaction, and despawns the vehicle.
- ALT on foot lists vehicles stored at that house and retrieves one at the configured spawn transform.
- Existing `/garage` remains the three-vehicle inventory; stored vehicles are marked and cannot be spawned or sold until retrieved.
- House sale, location disable, and capacity reduction are guarded while stored vehicles exist.
- Public garages, impound storage, business storage, and hotels remain disabled for later versions.

Final Pawn validation must be performed with F5 using the project Qawno includes.
