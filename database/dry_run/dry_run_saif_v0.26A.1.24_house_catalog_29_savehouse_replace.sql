-- SAIF / LSIF Dev v0.26A.1.24
-- HOUSE CATALOG 5 -> GTA SA 29 SAVEHOUSES DRY-RUN ONLY.
-- SET/SELECT/temporary-table statements only. No house_catalog/player_houses mutation.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @resolver_version := _utf8mb4'saif-house-property-resolver-v0.26A.1.22' COLLATE utf8mb4_unicode_ci;
SET @resolver_session_id := (SELECT id FROM offline_property_resolver_sessions WHERE BINARY resolver_version=BINARY @resolver_version AND status='complete' ORDER BY id DESC LIMIT 1);
SET @archive_session_id := (SELECT id FROM offline_runtime_archive_sessions WHERE archive_scope='house_catalog' ORDER BY id DESC LIMIT 1);

SELECT 'CURRENT_CATALOG' section,COUNT(*) total_rows,COALESCE(SUM(enabled=1),0) active_rows,
       COALESCE(SUM(legacy_house_index BETWEEN 0 AND 4),0) legacy_rows,
       COALESCE(SUM(canonical_slot IS NOT NULL),0) canonical_rows
FROM house_catalog;
SELECT 'CURRENT_CATALOG_BY_SOURCE' section,source_tag,COUNT(*) total_rows,COALESCE(SUM(enabled=1),0) active_rows
FROM house_catalog GROUP BY source_tag ORDER BY active_rows DESC,total_rows DESC,source_tag;

SELECT 'ARCHIVE_GATE' section,id archive_session_id,archive_status,runtime_rows_total,active_rows_total,target_rows_total,archived_rows,
       (archive_status='complete' AND runtime_rows_total=archived_rows AND target_rows_total=29) ready_should_be_1
FROM offline_runtime_archive_sessions WHERE id=@archive_session_id;

SELECT 'CATALOG_CHECKSUM_GATE' section,COUNT(*) checksum_mismatch_should_be_zero
FROM offline_house_catalog_archive a JOIN house_catalog h ON h.id=a.original_id
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
       (SELECT COUNT(*) FROM player_houses) current_rows,
       (SELECT COUNT(*) FROM offline_house_ownership_archive WHERE archive_session_id=@archive_session_id) archived_rows,
       ((SELECT COUNT(*) FROM player_houses)=(SELECT COUNT(*) FROM offline_house_ownership_archive WHERE archive_session_id=@archive_session_id)) count_match_should_be_1,
       (SELECT COUNT(*) FROM offline_house_ownership_archive a JOIN player_houses ph ON ph.id=a.player_house_id
        WHERE a.archive_session_id=@archive_session_id
          AND BINARY a.row_checksum<>BINARY SHA2(CONCAT_WS('|',ph.id,ph.owner_id,COALESCE(ph.house_catalog_id,'NULL'),ph.house_index,COALESCE(ph.house_name,''),COALESCE(ph.price,0),COALESCE(ph.locked,1),COALESCE(ph.pos_x,0),COALESCE(ph.pos_y,0),COALESCE(ph.pos_z,0)),256)) checksum_mismatch_should_be_zero;

SELECT 'OWNERSHIP_POLICY_GATE' section,COUNT(*) ownership_rows,
       SUM(policy_status='pending_mapping') pending_mapping_rows,
       SUM(policy_status='invalid_source') invalid_source_rows,
       SUM(policy_status='mapped') explicitly_mapped_rows,
       SUM(policy_status='preserve_legacy') preserve_legacy_rows,
       SUM(policy_status='refund_then_release') refund_then_release_rows,
       (COUNT(*)=0 OR SUM(policy_status IN ('mapped','preserve_legacy','refund_then_release'))=COUNT(*)) ready_should_be_1
FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id;

DROP TEMPORARY TABLE IF EXISTS tmp_saif_house29;
CREATE TEMPORARY TABLE tmp_saif_house29 AS
SELECT id plan_id,slot_index,display_name,price_value,city_region,area_code,
       exterior_x,exterior_y,exterior_z,exterior_a,
       exterior_spawn_x,exterior_spawn_y,exterior_spawn_z,exterior_spawn_a,
       interior_id,interior_exit_x,interior_exit_y,interior_exit_z,
       interior_spawn_x,interior_spawn_y,interior_spawn_z,interior_spawn_a,
       savepoint_x,savepoint_y,savepoint_z,garage_status,garage_name,garage_type,garage_distance,
       private_vw_required,confidence,for_sale_queue_id,exterior_enex_queue_id,interior_enex_queue_id,savegame_queue_id,garage_queue_id
FROM offline_property_canonical_plan
WHERE resolver_session_id=@resolver_session_id AND decision_code='baseline_ready';

SELECT 'PLAN_GATE' section,COUNT(*) selected_expected_29,
       MIN(slot_index) min_slot_expected_3,MAX(slot_index) max_slot_expected_31,
       COUNT(DISTINCT slot_index) unique_slots_expected_29,
       SUM(price_value<=0) invalid_price_should_be_zero,
       SUM(interior_id<=0) invalid_interior_should_be_zero,
       SUM(private_vw_required<>1) wrong_private_vw_should_be_zero,
       SUM(ABS(exterior_x)<0.001 AND ABS(exterior_y)<0.001 AND ABS(exterior_z)<0.001) zero_exterior_should_be_zero,
       SUM(ABS(interior_spawn_x)<0.001 AND ABS(interior_spawn_y)<0.001 AND ABS(interior_spawn_z)<0.001) zero_interior_spawn_should_be_zero,
       SUM(savegame_queue_id IS NULL) missing_savepoint_link_should_be_zero
FROM tmp_saif_house29;

SELECT 'PRICE_AUDIT' section,MIN(price_value) min_offline_price,MAX(price_value) max_offline_price,
       SUM(price_value) total_offline_reference_price,AVG(price_value) average_offline_price
FROM tmp_saif_house29;

SELECT 'PROJECTED_REPLACEMENT' section,
       (SELECT COUNT(*) FROM house_catalog WHERE enabled=1) active_catalog_rows_that_would_be_disabled,
       29 rows_to_insert,29 projected_active_after,64 compiled_capacity,35 remaining_capacity,
       (29<=64) fits_should_be_1;

SELECT 'INTERNAL_EXTERIOR_DUPLICATE_GATE' section,COUNT(*) duplicate_pairs_within_100m_should_be_zero
FROM tmp_saif_house29 a JOIN tmp_saif_house29 b ON b.plan_id>a.plan_id
WHERE POW(a.exterior_x-b.exterior_x,2)+POW(a.exterior_y-b.exterior_y,2)+POW(a.exterior_z-b.exterior_z,2)<=1.0;

SELECT 'LEGACY_CATALOG_EXACT_OVERLAP_AUDIT' section,COUNT(*) overlap_pairs,COUNT(DISTINCT p.plan_id) selected_rows_with_overlap
FROM tmp_saif_house29 p JOIN house_catalog h
  ON h.enabled=1
 AND ABS(h.exterior_pickup_x-p.exterior_x)<=0.25
 AND ABS(h.exterior_pickup_y-p.exterior_y)<=0.25
 AND ABS(h.exterior_pickup_z-p.exterior_z)<=0.50;

SELECT 'PUBLIC_INTERIOR_PROXIMITY_AUDIT' section,COUNT(*) pairs_within_300m
FROM tmp_saif_house29 p JOIN public_interiors i
  ON i.enabled=1
 AND POW(i.exterior_x-p.exterior_x,2)+POW(i.exterior_y-p.exterior_y,2)+POW(i.exterior_z-p.exterior_z,2)<=9.0;

SELECT 'GARAGE_CANDIDATE_AUDIT' section,
       SUM(garage_status='nearby_candidate') nearby_candidates_expected_12,
       SUM(garage_status<>'nearby_candidate') no_nearby_garage_expected_17,
       MIN(CASE WHEN garage_status='nearby_candidate' THEN garage_distance END) min_candidate_distance,
       MAX(CASE WHEN garage_status='nearby_candidate' THEN garage_distance END) max_candidate_distance
FROM tmp_saif_house29;

SET @public_icon_rows := (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND map_icon_type>0);
SET @hospital_icon_rows := (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND interior_type='hospital' AND map_icon_type>0);
SET @hospital_fallback_allowance := GREATEST(0,7-LEAST(7,@hospital_icon_rows));
SET @house_slots_available := GREATEST(0,100-LEAST(100,@public_icon_rows+@hospital_fallback_allowance));
SELECT 'MAP_ICON_PROJECTION' section,@public_icon_rows public_db_icon_candidates,@hospital_icon_rows hospital_db_icons,
       @hospital_fallback_allowance conservative_hospital_fallback_allowance,
       @house_slots_available slots_left_for_houses,
       LEAST(29,@house_slots_available) projected_house_icons_rendered,
       GREATEST(0,29-@house_slots_available) projected_house_icons_omitted,
       (29<=@house_slots_available) all_29_fit_should_be_1,
       CASE WHEN 29<=@house_slots_available THEN 'Current allocation is sufficient.'
            ELSE 'Resolve map-icon allocation/streaming before apply.' END note;

SELECT 'SELECTED_29_DETAIL' section,plan_id,slot_index,display_name,price_value,city_region,area_code,
       exterior_x,exterior_y,exterior_z,interior_id,interior_spawn_x,interior_spawn_y,interior_spawn_z,
       garage_status,garage_name,garage_type,garage_distance,confidence
FROM tmp_saif_house29 ORDER BY slot_index;

SELECT 'DEFERRED_ASSETS' section,slot_index,display_name,asset_class,decision_code,pair_status,runtime_target,resolver_reason
FROM offline_property_canonical_plan WHERE resolver_session_id=@resolver_session_id AND decision_code<>'baseline_ready'
ORDER BY slot_index;

SELECT 'SAFETY_CONTRACT' section,
       'Future apply may disable five legacy catalog definitions and insert 29 canonical savehouses only after ownership policy and map-icon strategy are ready. This script performs no house_catalog/player_houses mutation.' rule_text;

DROP TEMPORARY TABLE IF EXISTS tmp_saif_house29;
