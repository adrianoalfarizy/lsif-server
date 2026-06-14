-- Final read-only readiness dry-run after ownership policy decision.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @archive_session_id := (SELECT id FROM offline_runtime_archive_sessions WHERE archive_scope='house_catalog' ORDER BY id DESC LIMIT 1);
SET @public_icons := (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND exterior_map_icon>0);
SET @hospital_icons := (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND interior_type='hospital' AND exterior_map_icon>0);
SET @hospital_fallback := GREATEST(0,7-LEAST(7,@hospital_icons));

SELECT 'TRANSITION_DETAIL' section,t.id transition_id,t.owner_id,COALESCE(p.username,'UNKNOWN') username,
       t.old_house_catalog_id,COALESCE(h.display_name,'MISSING') old_house_name,t.policy_status,t.target_canonical_slot,t.target_plan_id,t.notes
FROM offline_house_ownership_transition_plan t
LEFT JOIN players p ON p.id=t.owner_id LEFT JOIN house_catalog h ON h.id=t.old_house_catalog_id
WHERE t.archive_session_id=@archive_session_id ORDER BY t.id;

SELECT 'READINESS_SUMMARY' section,
       (SELECT COUNT(*) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='pending_mapping') pending_policy_should_be_zero,
       (SELECT COUNT(*) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='invalid_source') invalid_policy_should_be_zero,
       (SELECT COUNT(*) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='preserve_legacy') preserve_legacy_rows,
       (SELECT COUNT(*) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='mapped') mapped_rows,
       @public_icons public_db_icon_candidates,@hospital_fallback hospital_fallback_candidates,
       91 public_service_slots,1 owned_house_slot,8 nearby_for_sale_slots,
       GREATEST(0,@public_icons+@hospital_fallback-91) public_icon_overflow_should_be_zero,
       29 canonical_houses_eligible_for_streaming,
       29+(SELECT COUNT(DISTINCT old_house_catalog_id) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='preserve_legacy') projected_active_catalog_rows,
       64 compiled_capacity,
       ((SELECT COUNT(*) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status IN ('pending_mapping','invalid_source'))=0
        AND GREATEST(0,@public_icons+@hospital_fallback-91)=0
        AND 29+(SELECT COUNT(DISTINCT old_house_catalog_id) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='preserve_legacy')<=64) ready_for_controlled_apply_should_be_1;

SELECT 'SAFETY_CONTRACT' section,
 'No player_houses/house_catalog mutation is performed. The next apply may insert 29 canonical houses, keep only explicitly preserved legacy definitions, and map only explicitly mapped ownership rows.' rule_text;
