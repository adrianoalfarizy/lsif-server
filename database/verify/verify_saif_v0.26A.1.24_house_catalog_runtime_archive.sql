-- SAIF / LSIF Dev v0.26A.1.24
-- Verify latest house_catalog + ownership archive and 29-savehouse projection.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @resolver_version := _utf8mb4'saif-house-property-resolver-v0.26A.1.22' COLLATE utf8mb4_unicode_ci;
SET @resolver_session_id := (SELECT id FROM offline_property_resolver_sessions WHERE BINARY resolver_version=BINARY @resolver_version AND status='complete' ORDER BY id DESC LIMIT 1);
SET @archive_session_id := (SELECT id FROM offline_runtime_archive_sessions WHERE archive_scope='house_catalog' ORDER BY id DESC LIMIT 1);

SELECT 'ARCHIVE_GATE' section,id archive_session_id,archive_status,runtime_rows_total,active_rows_total,target_rows_total,archived_rows,
       (archive_status='complete' AND runtime_rows_total=archived_rows AND target_rows_total=29) ready_should_be_1
FROM offline_runtime_archive_sessions WHERE id=@archive_session_id;

SELECT 'CATALOG_CHECKSUM_GATE' section,
       COUNT(*) checksum_mismatch_should_be_zero
FROM offline_house_catalog_archive a
JOIN house_catalog h ON h.id=a.original_id
WHERE a.archive_session_id=@archive_session_id
  AND BINARY a.row_checksum<>BINARY SHA2(CONCAT_WS('|',h.id,COALESCE(h.legacy_house_index,'NULL'),COALESCE(h.canonical_slot,'NULL'),COALESCE(h.display_name,''),COALESCE(h.price,0),
      COALESCE(h.exterior_pickup_x,0),COALESCE(h.exterior_pickup_y,0),COALESCE(h.exterior_pickup_z,0),COALESCE(h.exterior_facing,0),
      COALESCE(h.exterior_spawn_x,0),COALESCE(h.exterior_spawn_y,0),COALESCE(h.exterior_spawn_z,0),COALESCE(h.exterior_spawn_a,0),
      COALESCE(h.interior_id,0),COALESCE(h.interior_exit_x,0),COALESCE(h.interior_exit_y,0),COALESCE(h.interior_exit_z,0),
      COALESCE(h.interior_spawn_x,0),COALESCE(h.interior_spawn_y,0),COALESCE(h.interior_spawn_z,0),COALESCE(h.interior_spawn_a,0),
      COALESCE(h.savepoint_x,'NULL'),COALESCE(h.savepoint_y,'NULL'),COALESCE(h.savepoint_z,'NULL'),COALESCE(h.garage_source_evidence_id,'NULL'),
      COALESCE(h.map_icon_type,0),COALESCE(h.pickup_model,0),COALESCE(h.pickup_type,0),COALESCE(h.private_vw_required,0),
      COALESCE(h.enabled,0),COALESCE(h.sort_order,0),COALESCE(h.source_tag,'')),256);

SELECT 'CATALOG_LINKAGE_GATE' section,
       (SELECT COUNT(*) FROM house_catalog h LEFT JOIN offline_house_catalog_archive a ON a.archive_session_id=@archive_session_id AND a.original_id=h.id WHERE a.original_id IS NULL) current_missing_from_archive_should_be_zero,
       (SELECT COUNT(*) FROM offline_house_catalog_archive a LEFT JOIN house_catalog h ON h.id=a.original_id WHERE a.archive_session_id=@archive_session_id AND h.id IS NULL) archived_missing_from_runtime_should_be_zero;

SELECT 'OWNERSHIP_ARCHIVE_GATE' section,
       (SELECT COUNT(*) FROM player_houses) current_ownership_rows,
       (SELECT COUNT(*) FROM offline_house_ownership_archive WHERE archive_session_id=@archive_session_id) archived_ownership_rows,
       ((SELECT COUNT(*) FROM player_houses)=(SELECT COUNT(*) FROM offline_house_ownership_archive WHERE archive_session_id=@archive_session_id)) count_match_should_be_1,
       (SELECT COUNT(*) FROM offline_house_ownership_archive a JOIN player_houses ph ON ph.id=a.player_house_id
        WHERE a.archive_session_id=@archive_session_id
          AND BINARY a.row_checksum<>BINARY SHA2(CONCAT_WS('|',ph.id,ph.owner_id,COALESCE(ph.house_catalog_id,'NULL'),ph.house_index,COALESCE(ph.house_name,''),COALESCE(ph.price,0),COALESCE(ph.locked,1),COALESCE(ph.pos_x,0),COALESCE(ph.pos_y,0),COALESCE(ph.pos_z,0)),256)) checksum_mismatch_should_be_zero,
       (SELECT COUNT(*) FROM player_houses ph LEFT JOIN offline_house_ownership_archive a ON a.archive_session_id=@archive_session_id AND a.player_house_id=ph.id WHERE a.player_house_id IS NULL) current_missing_from_archive_should_be_zero,
       (SELECT COUNT(*) FROM offline_house_ownership_archive a LEFT JOIN player_houses ph ON ph.id=a.player_house_id WHERE a.archive_session_id=@archive_session_id AND ph.id IS NULL) archived_missing_from_runtime_should_be_zero;

SELECT 'OWNERSHIP_POLICY_GATE' section,
       COUNT(*) transition_rows,
       SUM(policy_status='pending_mapping') pending_mapping_rows,
       SUM(policy_status='invalid_source') invalid_source_rows,
       SUM(policy_status IN ('mapped','preserve_legacy','refund_then_release')) resolved_rows,
       (COUNT(*)=0 OR SUM(policy_status IN ('mapped','preserve_legacy','refund_then_release'))=COUNT(*)) policy_ready_should_be_1
FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id;

SELECT 'CURRENT_CATALOG_BASELINE' section,
       COUNT(*) total_expected_5,
       SUM(enabled=1) active_expected_5,
       SUM(legacy_house_index BETWEEN 0 AND 4) legacy_expected_5,
       SUM(canonical_slot IS NOT NULL) canonical_should_be_zero,
       SUM(source_tag<>'legacy_house_catalog_v0.26A.1.23') unexpected_source_should_be_zero
FROM house_catalog;

SELECT 'PLAN_GATE' section,
       COUNT(*) total_expected_32,
       SUM(decision_code='baseline_ready') baseline_expected_29,
       SUM(decision_code='business_asset_deferred') business_deferred_expected_2,
       SUM(decision_code='story_asset_deferred') story_deferred_expected_1,
       SUM(decision_code='baseline_ready' AND apply_status<>'draft') nondraft_should_be_zero,
       SUM(decision_code='baseline_ready' AND enabled<>0) enabled_should_be_zero
FROM offline_property_canonical_plan WHERE resolver_session_id=@resolver_session_id;

SELECT 'BASELINE_TRANSFORM_GATE' section,
       SUM(decision_code='baseline_ready' AND runtime_target<>'house_catalog') wrong_target_should_be_zero,
       SUM(decision_code='baseline_ready' AND pair_status<>'exact_pair') nonexact_pair_should_be_zero,
       SUM(decision_code='baseline_ready' AND (pair_distance IS NULL OR pair_distance>15.0)) far_pair_should_be_zero,
       SUM(decision_code='baseline_ready' AND interior_id<=0) invalid_interior_should_be_zero,
       SUM(decision_code='baseline_ready' AND private_vw_required<>1) wrong_private_vw_should_be_zero,
       SUM(decision_code='baseline_ready' AND price_value<=0) invalid_price_should_be_zero,
       SUM(decision_code='baseline_ready' AND ABS(exterior_x)<0.001 AND ABS(exterior_y)<0.001 AND ABS(exterior_z)<0.001) zero_exterior_should_be_zero,
       SUM(decision_code='baseline_ready' AND ABS(interior_spawn_x)<0.001 AND ABS(interior_spawn_y)<0.001 AND ABS(interior_spawn_z)<0.001) zero_interior_spawn_should_be_zero,
       SUM(decision_code='baseline_ready' AND savepoint_status<>'template_linked') missing_savepoint_should_be_zero
FROM offline_property_canonical_plan WHERE resolver_session_id=@resolver_session_id;

SELECT 'INTERNAL_EXTERIOR_DUPLICATE_GATE' section,
       COUNT(*) duplicate_pairs_within_100m_should_be_zero
FROM offline_property_canonical_plan p1
JOIN offline_property_canonical_plan p2 ON p2.id>p1.id AND p2.resolver_session_id=p1.resolver_session_id AND p2.decision_code='baseline_ready'
WHERE p1.resolver_session_id=@resolver_session_id AND p1.decision_code='baseline_ready'
  AND POW(p1.exterior_x-p2.exterior_x,2)+POW(p1.exterior_y-p2.exterior_y,2)+POW(p1.exterior_z-p2.exterior_z,2)<=1.0;

SELECT 'CAPACITY_GATE' section,64 compiled_capacity,29 projected_active_after,35 remaining_capacity,
       (29<=64) fits_should_be_1;

SET @public_icon_rows := (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND map_icon_type>0);
SET @hospital_icon_rows := (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND interior_type='hospital' AND map_icon_type>0);
SET @hospital_fallback_allowance := GREATEST(0,7-LEAST(7,@hospital_icon_rows));
SET @house_slots_available := GREATEST(0,100-LEAST(100,@public_icon_rows+@hospital_fallback_allowance));
SELECT 'MAP_ICON_PROJECTION' section,@public_icon_rows public_db_icon_candidates,@hospital_icon_rows hospital_db_icons,
       @hospital_fallback_allowance conservative_hospital_fallback_allowance,
       @house_slots_available native_slots_left_for_houses,
       LEAST(29,@house_slots_available) projected_house_icons_rendered,
       (29<=@house_slots_available) all_29_house_icons_fit_should_be_1,
       CASE WHEN 29<=@house_slots_available THEN 'Current allocator can render all 29 houses.'
            ELSE 'Map-icon allocation/streaming strategy is required before apply.' END note;
