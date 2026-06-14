-- Verify latest live controlled GTA SA 29-savehouse apply.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @apply_session_id := (SELECT id FROM offline_house_catalog_apply_sessions WHERE apply_status='complete' AND rolled_back_at IS NULL ORDER BY id DESC LIMIT 1);
SET @expected_active := (SELECT 29+COUNT(DISTINCT old_house_catalog_id) FROM offline_house_ownership_transition_plan t JOIN offline_house_catalog_apply_sessions s ON s.archive_session_id=t.archive_session_id WHERE s.id=@apply_session_id AND t.policy_status='preserve_legacy');

SELECT 'APPLY_SESSION' section,id,archive_session_id,resolver_session_id,apply_status,source_tag,catalog_rows_before,catalog_active_before,ownership_rows_before,preserve_legacy_rows,mapped_ownership_rows,legacy_rows_disabled,canonical_rows_inserted,catalog_active_after,ownership_rows_after,created_at,completed_at
FROM offline_house_catalog_apply_sessions WHERE id=@apply_session_id;

SELECT 'CORE_GATE' section,
       (SELECT COUNT(*) FROM offline_house_catalog_apply_rows WHERE apply_session_id=@apply_session_id) mapped_rows_expected_29,
       (SELECT COUNT(*) FROM offline_house_catalog_apply_rows r JOIN house_catalog h ON h.id=r.house_catalog_id WHERE r.apply_session_id=@apply_session_id) runtime_rows_present_expected_29,
       (SELECT COUNT(*) FROM offline_house_catalog_apply_rows r JOIN house_catalog h ON h.id=r.house_catalog_id WHERE r.apply_session_id=@apply_session_id AND h.enabled=1) runtime_rows_active_expected_29,
       (SELECT COUNT(*) FROM house_catalog WHERE enabled=1 AND source_tag=(SELECT source_tag FROM offline_house_catalog_apply_sessions WHERE id=@apply_session_id)) canonical_active_expected_29,
       (SELECT COUNT(*) FROM house_catalog WHERE enabled=1) total_active_expected_projection,
       @expected_active expected_active_projection,
       ((SELECT COUNT(*) FROM house_catalog WHERE enabled=1)=@expected_active) active_count_match_should_be_1;

SELECT 'PLAN_AND_SLOT_GATE' section,
       (SELECT COUNT(*) FROM offline_property_canonical_plan p JOIN offline_house_catalog_apply_rows r ON r.plan_id=p.id AND r.apply_session_id=@apply_session_id WHERE p.apply_status='applied') plans_applied_expected_29,
       (SELECT COUNT(DISTINCT canonical_slot) FROM offline_house_catalog_apply_rows WHERE apply_session_id=@apply_session_id) unique_slots_expected_29,
       (SELECT MIN(canonical_slot) FROM offline_house_catalog_apply_rows WHERE apply_session_id=@apply_session_id) min_slot_expected_3,
       (SELECT MAX(canonical_slot) FROM offline_house_catalog_apply_rows WHERE apply_session_id=@apply_session_id) max_slot_expected_31;

SELECT 'CHECKSUM_GATE' section,
       (SELECT COUNT(*) FROM offline_house_catalog_apply_rows r JOIN house_catalog h ON h.id=r.house_catalog_id WHERE r.apply_session_id=@apply_session_id AND BINARY r.row_checksum<>BINARY SHA2(CONCAT_WS('|',h.id,COALESCE(h.legacy_house_index,'NULL'),COALESCE(h.canonical_slot,'NULL'),COALESCE(h.display_name,''),COALESCE(h.price,0),COALESCE(h.exterior_pickup_x,0),COALESCE(h.exterior_pickup_y,0),COALESCE(h.exterior_pickup_z,0),COALESCE(h.exterior_facing,0),COALESCE(h.exterior_spawn_x,0),COALESCE(h.exterior_spawn_y,0),COALESCE(h.exterior_spawn_z,0),COALESCE(h.exterior_spawn_a,0),COALESCE(h.interior_id,0),COALESCE(h.interior_exit_x,0),COALESCE(h.interior_exit_y,0),COALESCE(h.interior_exit_z,0),COALESCE(h.interior_spawn_x,0),COALESCE(h.interior_spawn_y,0),COALESCE(h.interior_spawn_z,0),COALESCE(h.interior_spawn_a,0),COALESCE(h.savepoint_x,'NULL'),COALESCE(h.savepoint_y,'NULL'),COALESCE(h.savepoint_z,'NULL'),COALESCE(h.garage_source_evidence_id,'NULL'),COALESCE(h.map_icon_type,0),COALESCE(h.pickup_model,0),COALESCE(h.pickup_type,0),COALESCE(h.private_vw_required,0),COALESCE(h.enabled,0),COALESCE(h.sort_order,0),COALESCE(h.source_tag,'')),256)) imported_checksum_mismatch_should_be_zero,
       (SELECT COUNT(*) FROM offline_house_catalog_disabled_rows d JOIN house_catalog h ON h.id=d.house_catalog_id WHERE d.apply_session_id=@apply_session_id AND BINARY d.row_checksum<>BINARY SHA2(CONCAT_WS('|',h.id,COALESCE(h.legacy_house_index,'NULL'),COALESCE(h.canonical_slot,'NULL'),COALESCE(h.display_name,''),COALESCE(h.price,0),COALESCE(h.exterior_pickup_x,0),COALESCE(h.exterior_pickup_y,0),COALESCE(h.exterior_pickup_z,0),COALESCE(h.exterior_facing,0),COALESCE(h.exterior_spawn_x,0),COALESCE(h.exterior_spawn_y,0),COALESCE(h.exterior_spawn_z,0),COALESCE(h.exterior_spawn_a,0),COALESCE(h.interior_id,0),COALESCE(h.interior_exit_x,0),COALESCE(h.interior_exit_y,0),COALESCE(h.interior_exit_z,0),COALESCE(h.interior_spawn_x,0),COALESCE(h.interior_spawn_y,0),COALESCE(h.interior_spawn_z,0),COALESCE(h.interior_spawn_a,0),COALESCE(h.savepoint_x,'NULL'),COALESCE(h.savepoint_y,'NULL'),COALESCE(h.savepoint_z,'NULL'),COALESCE(h.garage_source_evidence_id,'NULL'),COALESCE(h.map_icon_type,0),COALESCE(h.pickup_model,0),COALESCE(h.pickup_type,0),COALESCE(h.private_vw_required,0),d.previous_enabled,COALESCE(h.sort_order,0),COALESCE(h.source_tag,'')),256)) disabled_checksum_mismatch_should_be_zero;

SELECT 'OWNERSHIP_GATE' section,
       (SELECT COUNT(*) FROM offline_house_ownership_apply_rows WHERE apply_session_id=@apply_session_id) tracked_ownership_rows,
       (SELECT ownership_rows_before FROM offline_house_catalog_apply_sessions WHERE id=@apply_session_id) expected_ownership_rows,
       (SELECT COUNT(*) FROM offline_house_ownership_apply_rows r JOIN player_houses ph ON ph.id=r.player_house_id WHERE r.apply_session_id=@apply_session_id AND BINARY r.after_checksum=BINARY SHA2(CONCAT_WS('|',ph.id,ph.owner_id,COALESCE(ph.house_catalog_id,'NULL'),ph.house_index,COALESCE(ph.house_name,''),COALESCE(ph.price,0),COALESCE(ph.locked,1),COALESCE(ph.pos_x,0),COALESCE(ph.pos_y,0),COALESCE(ph.pos_z,0)),256)) ownership_rows_matching_after_state,
       (SELECT COUNT(*) FROM player_houses ph LEFT JOIN house_catalog h ON h.id=ph.house_catalog_id WHERE h.id IS NULL OR h.enabled<>1) orphan_or_disabled_ownership_should_be_zero,
       (SELECT COUNT(*) FROM (SELECT house_catalog_id FROM player_houses WHERE house_catalog_id IS NOT NULL GROUP BY house_catalog_id HAVING COUNT(*)>1) d) duplicate_catalog_owner_should_be_zero;

SELECT 'RUNTIME_PAYLOAD_GATE' section,
       (SELECT COUNT(*) FROM house_catalog WHERE enabled=1 AND source_tag=(SELECT source_tag FROM offline_house_catalog_apply_sessions WHERE id=@apply_session_id) AND (canonical_slot<3 OR canonical_slot>31 OR price<=0 OR interior_id<=0 OR pickup_model<>1318 OR pickup_type<>1 OR private_vw_required<>1 OR map_icon_type<>31)) invalid_canonical_payload_should_be_zero,
       (SELECT COUNT(*) FROM house_catalog WHERE enabled=1 AND source_tag=(SELECT source_tag FROM offline_house_catalog_apply_sessions WHERE id=@apply_session_id) AND (ABS(exterior_pickup_x)<0.001 AND ABS(exterior_pickup_y)<0.001 AND ABS(exterior_pickup_z)<0.001)) zero_exterior_should_be_zero;
