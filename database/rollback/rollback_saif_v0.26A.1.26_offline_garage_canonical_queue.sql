-- SAIF / LSIF Dev v0.26A.1.26 rollback
-- Removes only the v0.26A.1.26 garage staging/resolver session.
-- Does not touch house_catalog, player_houses, parked_vehicles, public_interiors, or runtime garage state.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @resolver_version := _utf8mb4'saif-garage-canonical-resolver-v0.26A.1.26' COLLATE utf8mb4_unicode_ci;
START TRANSACTION;
DELETE l FROM offline_garage_house_links l JOIN offline_garage_resolver_sessions s ON s.id=l.resolver_session_id WHERE BINARY s.resolver_version=BINARY @resolver_version;
DELETE p FROM offline_garage_canonical_plan p JOIN offline_garage_resolver_sessions s ON s.id=p.resolver_session_id WHERE BINARY s.resolver_version=BINARY @resolver_version;
DELETE FROM offline_garage_resolver_sessions WHERE BINARY resolver_version=BINARY @resolver_version;
COMMIT;
SELECT 'ROLLBACK_COMPLETE' section,@resolver_version removed_resolver_version,
       (SELECT COUNT(*) FROM offline_garage_resolver_sessions WHERE BINARY resolver_version=BINARY @resolver_version) sessions_should_be_zero,
       'Runtime tables untouched.' safety_contract;
