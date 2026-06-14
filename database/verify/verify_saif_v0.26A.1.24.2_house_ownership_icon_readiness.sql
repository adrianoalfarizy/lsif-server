-- SAIF v0.26A.1.24.2 readiness verification. Read-only.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @archive_session_id := (SELECT id FROM offline_runtime_archive_sessions WHERE archive_scope='house_catalog' ORDER BY id DESC LIMIT 1);
SET @public_icons := (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND exterior_map_icon>0);
SET @hospital_icons := (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND interior_type='hospital' AND exterior_map_icon>0);
SET @hospital_fallback := GREATEST(0,7-LEAST(7,@hospital_icons));

SELECT 'OWNERSHIP_POLICY_GATE' section,COUNT(*) transition_rows,
       SUM(policy_status='pending_mapping') pending_should_be_zero,
       SUM(policy_status='invalid_source') invalid_should_be_zero,
       SUM(policy_status='mapped') mapped_rows,
       SUM(policy_status='preserve_legacy') preserve_legacy_rows,
       SUM(policy_status='refund_then_release') refund_rows,
       (COUNT(*)=0 OR SUM(policy_status IN ('mapped','preserve_legacy','refund_then_release'))=COUNT(*)) ready_should_be_1
FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id;

SELECT 'OWNERSHIP_UNIQUENESS_GATE' section,
       (SELECT COUNT(*) FROM (SELECT house_catalog_id FROM player_houses WHERE house_catalog_id IS NOT NULL GROUP BY house_catalog_id HAVING COUNT(*)>1) d) duplicate_catalog_owners_should_be_zero,
       (SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema=DATABASE() AND table_name='player_houses' AND index_name='uq_player_houses_catalog_single_owner') unique_guard_should_be_1;

SELECT 'MAP_ICON_POLICY_GATE' section,policy_key,enabled,public_service_slots,owned_house_slots,nearby_for_sale_slots,
       public_service_slots+owned_house_slots+nearby_for_sale_slots total_slots_expected_100,
       (public_service_slots+owned_house_slots+nearby_for_sale_slots=100) split_should_be_1,
       nearby_radius,refresh_interval_ms,
       @public_icons public_db_icon_candidates,@hospital_fallback hospital_fallback_candidates,
       GREATEST(0,@public_icons+@hospital_fallback-public_service_slots) public_overflow_should_be_zero,
       29 total_catalog_houses_eligible_for_streaming,
       nearby_for_sale_slots simultaneous_for_sale_icons,
       owned_house_slots owned_house_icon_slots
FROM house_map_icon_policy WHERE id=1;

SELECT 'FUTURE_APPLY_PROJECTION' section,
       29 canonical_savehouses,
       (SELECT COUNT(DISTINCT old_house_catalog_id) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='preserve_legacy') preserved_legacy_definitions,
       29+(SELECT COUNT(DISTINCT old_house_catalog_id) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='preserve_legacy') projected_active_catalog_rows,
       64 compiled_capacity,
       (29+(SELECT COUNT(DISTINCT old_house_catalog_id) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='preserve_legacy')<=64) capacity_ready_should_be_1;
