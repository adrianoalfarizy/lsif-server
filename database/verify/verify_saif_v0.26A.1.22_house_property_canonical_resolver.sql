-- SAIF v0.26A.1.22 verify house/property canonical resolver
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @resolver_version='saif-house-property-resolver-v0.26A.1.22';
SET @resolver_session_id=(SELECT id FROM offline_property_resolver_sessions WHERE resolver_version=@resolver_version AND status='complete' ORDER BY id DESC LIMIT 1);

SELECT 'SESSION_GATE' section,id,status,total_plans,baseline_ready_rows,deferred_rows,exact_pair_rows,unpaired_asset_rows,savepoint_linked_rows,garage_candidate_rows,
 (status='complete' AND total_plans=32 AND baseline_ready_rows=29 AND deferred_rows=3 AND exact_pair_rows=30 AND unpaired_asset_rows=2 AND savepoint_linked_rows=30 AND garage_candidate_rows=13) AS ready_should_be_1
FROM offline_property_resolver_sessions WHERE id=@resolver_session_id;

SELECT 'PLAN_GATE' section,
 COUNT(*) total_expected_32,
 SUM(decision_code='baseline_ready') baseline_expected_29,
 SUM(decision_code='business_asset_deferred') business_deferred_expected_2,
 SUM(decision_code='story_asset_deferred') story_deferred_expected_1,
 SUM(pair_status='exact_pair') exact_pair_expected_30,
 SUM(pair_status='unpaired_asset') unpaired_expected_2,
 SUM(savepoint_status='template_linked') savepoint_linked_expected_30,
 SUM(garage_status='nearby_candidate') garage_candidates_expected_13,
 SUM(decision_code='baseline_ready' AND garage_status='nearby_candidate') baseline_garage_candidates_expected_12,
 SUM(private_vw_required=1) private_vw_expected_29,
 SUM(enabled<>0) enabled_should_be_zero,
 SUM(apply_status<>'draft') nondraft_should_be_zero
FROM offline_property_canonical_plan WHERE resolver_session_id=@resolver_session_id;

SELECT 'BASELINE_PAIR_GATE' section,
 SUM(decision_code='baseline_ready' AND (exterior_enex_queue_id IS NULL OR interior_enex_queue_id IS NULL)) missing_pair_should_be_zero,
 SUM(decision_code='baseline_ready' AND (pair_distance IS NULL OR pair_distance>15.0)) far_pair_should_be_zero,
 SUM(decision_code='baseline_ready' AND interior_id<=0) invalid_interior_should_be_zero,
 SUM(decision_code='baseline_ready' AND runtime_target<>'house_catalog') wrong_target_should_be_zero,
 SUM(decision_code='baseline_ready' AND private_vw_required<>1) wrong_private_vw_should_be_zero,
 SUM(decision_code='baseline_ready' AND price_value<=0) invalid_price_should_be_zero,
 SUM(decision_code='baseline_ready' AND (purchase_x=0 AND purchase_y=0 AND purchase_z=0)) zero_purchase_should_be_zero
FROM offline_property_canonical_plan WHERE resolver_session_id=@resolver_session_id;

SELECT 'SOURCE_LINKAGE_GATE' section,
 SUM(for_sale_queue_id IS NULL) missing_for_sale_should_be_zero,
 SUM(decision_code='baseline_ready' AND exterior_enex_queue_id IS NULL) missing_exterior_should_be_zero,
 SUM(decision_code='baseline_ready' AND interior_enex_queue_id IS NULL) missing_interior_should_be_zero,
 SUM(decision_code='baseline_ready' AND savegame_queue_id IS NULL) missing_save_template_should_be_zero
FROM offline_property_canonical_plan WHERE resolver_session_id=@resolver_session_id;

SELECT 'ASSET_CLASS_GATE' section,slot_index,display_name,asset_class,decision_code,pair_status,runtime_target
FROM offline_property_canonical_plan WHERE resolver_session_id=@resolver_session_id AND slot_index IN(0,1,2) ORDER BY slot_index;

SELECT 'BACKEND_GAP_REFERENCE' section,5 AS compiled_hardcoded_house_slots,29 AS canonical_source_ready_slots,24 AS dynamic_catalog_gap,
 (SELECT COUNT(*) FROM player_houses) AS current_owned_house_rows,
 'No player_houses mutation. Dynamic house_catalog bridge required before apply.' AS note;
