# SAIF / LSIF Dev v0.26A.1.24.2 — Ownership Transition & House Map-Icon Readiness

This patch does not apply the 29 GTA SA houses. It resolves two blockers from v0.26A.1.24:

1. explicit transition policy for existing legacy owners;
2. fixed native map-icon allocation: 91 public/service slots, one owned-house slot, and eight streamed nearby for-sale slots.

Safe default policy is `preserve_legacy`; it is available as confirmation-token SQL and does not mutate ownership. Runtime also gains single-owner purchase protection and an occupancy-aware house label/icon loader.
