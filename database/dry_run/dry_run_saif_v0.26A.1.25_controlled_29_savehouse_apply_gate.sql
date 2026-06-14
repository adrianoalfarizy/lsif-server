-- SAIF / LSIF Dev v0.26A.1.25
-- Final read-only gate before controlled GTA SA 29-savehouse apply.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @archive_session_id := (SELECT id FROM offline_runtime_archive_sessions WHERE archive_scope='house_catalog' ORDER BY id DESC LIMIT 1);
SET @resolver_session_id := (SELECT id FROM offline_property_resolver_sessions WHERE resolver_version='saif-house-property-resolver-v0.26A.1.22' AND status='complete' ORDER BY id DESC LIMIT 1);
SET @public_icons := (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND exterior_map_icon>0);
SET @hospital_icons := (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND interior_type='hospital' AND exterior_map_icon>0);
SET @hospital_fallback := GREATEST(0,7-LEAST(7,@hospital_icons));
SET @preserved_catalogs := (SELECT COUNT(DISTINCT old_house_catalog_id) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='preserve_legacy');

SELECT 'ARCHIVE_GATE' section,s.id archive_session_id,s.archive_status,s.runtime_rows_total,s.active_rows_total,s.target_rows_total,s.archived_rows,
       (s.archive_status='complete' AND s.runtime_rows_total=s.archived_rows AND s.target_rows_total=29) ready_should_be_1
FROM offline_runtime_archive_sessions s WHERE s.id=@archive_session_id;

SELECT 'CATALOG_ARCHIVE_CHECKSUM_GATE' section,
       (SELECT COUNT(*) FROM offline_house_catalog_archive a JOIN house_catalog h ON h.id=a.original_id
        WHERE a.archive_session_id=@archive_session_id AND BINARY a.row_checksum<>BINARY SHA2(CONCAT_WS('|',h.id,COALESCE(h.legacy_house_index,'NULL'),COALESCE(h.canonical_slot,'NULL'),COALESCE(h.display_name,''),COALESCE(h.price,0),COALESCE(h.exterior_pickup_x,0),COALESCE(h.exterior_pickup_y,0),COALESCE(h.exterior_pickup_z,0),COALESCE(h.exterior_facing,0),COALESCE(h.exterior_spawn_x,0),COALESCE(h.exterior_spawn_y,0),COALESCE(h.exterior_spawn_z,0),COALESCE(h.exterior_spawn_a,0),COALESCE(h.interior_id,0),COALESCE(h.interior_exit_x,0),COALESCE(h.interior_exit_y,0),COALESCE(h.interior_exit_z,0),COALESCE(h.interior_spawn_x,0),COALESCE(h.interior_spawn_y,0),COALESCE(h.interior_spawn_z,0),COALESCE(h.interior_spawn_a,0),COALESCE(h.savepoint_x,'NULL'),COALESCE(h.savepoint_y,'NULL'),COALESCE(h.savepoint_z,'NULL'),COALESCE(h.garage_source_evidence_id,'NULL'),COALESCE(h.map_icon_type,0),COALESCE(h.pickup_model,0),COALESCE(h.pickup_type,0),COALESCE(h.private_vw_required,0),COALESCE(h.enabled,0),COALESCE(h.sort_order,0),COALESCE(h.source_tag,'')),256)) checksum_mismatch_should_be_zero,
       (SELECT COUNT(*) FROM offline_house_catalog_archive a LEFT JOIN house_catalog h ON h.id=a.original_id WHERE a.archive_session_id=@archive_session_id AND h.id IS NULL) archived_missing_should_be_zero,
       (SELECT COUNT(*) FROM house_catalog h LEFT JOIN offline_house_catalog_archive a ON a.archive_session_id=@archive_session_id AND a.original_id=h.id WHERE a.original_id IS NULL) current_missing_should_be_zero;

SELECT 'OWNERSHIP_ARCHIVE_GATE' section,
       (SELECT COUNT(*) FROM player_houses) current_rows,
       (SELECT COUNT(*) FROM offline_house_ownership_archive WHERE archive_session_id=@archive_session_id) archived_rows,
       ((SELECT COUNT(*) FROM player_houses)=(SELECT COUNT(*) FROM offline_house_ownership_archive WHERE archive_session_id=@archive_session_id)) count_match_should_be_1,
       (SELECT COUNT(*) FROM offline_house_ownership_archive a JOIN player_houses ph ON ph.id=a.player_house_id
        WHERE a.archive_session_id=@archive_session_id AND BINARY a.row_checksum<>BINARY SHA2(CONCAT_WS('|',ph.id,ph.owner_id,COALESCE(ph.house_catalog_id,'NULL'),ph.house_index,COALESCE(ph.house_name,''),COALESCE(ph.price,0),COALESCE(ph.locked,1),COALESCE(ph.pos_x,0),COALESCE(ph.pos_y,0),COALESCE(ph.pos_z,0)),256)) checksum_mismatch_should_be_zero;

SELECT 'PLAN_GATE' section,
       COUNT(*) total_expected_32,
       SUM(decision_code='baseline_ready' AND apply_status='draft') baseline_expected_29,
       SUM(decision_code='business_asset_deferred') business_expected_2,
       SUM(decision_code='story_asset_deferred') story_expected_1,
       SUM(decision_code='baseline_ready' AND (runtime_target<>'house_catalog' OR pair_status<>'exact_pair' OR private_vw_required<>1 OR price_value<=0 OR interior_id<=0 OR savepoint_status<>'template_linked' OR (ABS(exterior_x)<0.001 AND ABS(exterior_y)<0.001 AND ABS(exterior_z)<0.001) OR (ABS(interior_spawn_x)<0.001 AND ABS(interior_spawn_y)<0.001 AND ABS(interior_spawn_z)<0.001))) invalid_selected_should_be_zero
FROM offline_property_canonical_plan WHERE resolver_session_id=@resolver_session_id;

SELECT 'OWNERSHIP_POLICY_GATE' section,
       COUNT(*) transition_rows,
       SUM(policy_status='pending_mapping') pending_should_be_zero,
       SUM(policy_status='invalid_source') invalid_should_be_zero,
       SUM(policy_status='refund_then_release') unsupported_refund_should_be_zero,
       SUM(policy_status='preserve_legacy') preserve_legacy_rows,
       SUM(policy_status='mapped') mapped_rows,
       SUM(policy_status='mapped' AND (target_canonical_slot IS NULL OR target_plan_id IS NULL)) invalid_mapping_should_be_zero,
       (COUNT(*)=(SELECT COUNT(*) FROM player_houses) AND SUM(policy_status IN ('preserve_legacy','mapped'))=COUNT(*)) ready_should_be_1
FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id;

SELECT 'MAPPED_TARGET_GATE' section,
       (SELECT COUNT(*) FROM offline_house_ownership_transition_plan t LEFT JOIN offline_property_canonical_plan p ON p.id=t.target_plan_id AND p.slot_index=t.target_canonical_slot AND p.resolver_session_id=@resolver_session_id AND p.decision_code='baseline_ready' WHERE t.archive_session_id=@archive_session_id AND t.policy_status='mapped' AND p.id IS NULL) invalid_target_should_be_zero,
       (SELECT COUNT(*) FROM (SELECT target_canonical_slot FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='mapped' GROUP BY target_canonical_slot HAVING COUNT(*)>1) d) duplicate_target_should_be_zero;

SELECT 'CURRENT_RUNTIME_GATE' section,
       (SELECT COUNT(*) FROM house_catalog) current_catalog_rows,
       (SELECT COUNT(*) FROM house_catalog WHERE enabled=1) active_catalog_rows,
       (SELECT COUNT(*) FROM house_catalog WHERE canonical_slot IS NOT NULL) canonical_rows_should_be_zero,
       (SELECT COUNT(*) FROM house_catalog WHERE enabled=1 AND source_tag LIKE 'offline_gtasa_house29_a%') orphan_import_active_should_be_zero,
       (SELECT COUNT(*) FROM offline_house_catalog_apply_sessions WHERE apply_status='complete' AND rolled_back_at IS NULL) live_apply_should_be_zero;

SELECT 'MAP_ICON_AND_CAPACITY_GATE' section,@public_icons public_db_icons,@hospital_fallback hospital_fallback,
       GREATEST(0,@public_icons+@hospital_fallback-91) public_overflow_should_be_zero,
       @preserved_catalogs preserved_legacy_definitions,
       29+@preserved_catalogs projected_active_catalog_rows,64 compiled_capacity,
       (29+@preserved_catalogs<=64) capacity_ready_should_be_1;

SELECT 'PROJECTED_ACTION' section,
       (SELECT COUNT(*) FROM house_catalog h WHERE h.enabled=1 AND NOT EXISTS (SELECT 1 FROM offline_house_ownership_transition_plan t WHERE t.archive_session_id=@archive_session_id AND t.policy_status='preserve_legacy' AND t.old_house_catalog_id=h.id)) legacy_rows_that_would_be_disabled,
       29 canonical_rows_that_would_be_inserted,
       (SELECT COUNT(*) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='mapped') ownership_rows_that_would_be_mapped,
       (SELECT COUNT(*) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='preserve_legacy') ownership_rows_that_would_remain_unchanged;
