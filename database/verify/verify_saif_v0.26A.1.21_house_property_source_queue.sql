-- SAIF v0.26A.1.21 verification: house/property source queue foundation
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @sid := (SELECT id FROM offline_property_source_sessions WHERE BINARY parser_version=BINARY 'saif-property-source-parser-v0.26A.1.21' ORDER BY id DESC LIMIT 1);
SELECT 'SESSION_GATE' AS section,id,status,total_rows,property_for_sale_rows,property_locked_rows,savegame_rows,enex_savehouse_rows,enex_property_rows,garage_rows,unique_property_slots,unique_save_positions,duplicate_extra_rows FROM offline_property_source_sessions WHERE id=@sid;
SELECT 'QUEUE_GATE' AS section,
 COUNT(*) AS total_expected_255,
 SUM(evidence_type='property_for_sale_pickup') AS forsale_expected_32,
 SUM(evidence_type='property_locked_pickup') AS locked_expected_29,
 SUM(evidence_type='savegame_pickup') AS savegame_expected_37,
 SUM(evidence_type='enex_savehouse') AS enex_savehouse_expected_99,
 SUM(evidence_type='enex_property') AS enex_property_expected_6,
 SUM(evidence_type='garage_reference') AS garage_expected_52,
 SUM(enabled<>0) AS enabled_should_be_zero,
 SUM(apply_status<>'pending') AS nonpending_apply_should_be_zero,
 SUM(review_status<>'pending') AS nonpending_review_should_be_zero
FROM offline_property_source_queue WHERE session_id=@sid;
SELECT 'PROPERTY_SLOT_GATE' AS section,
 COUNT(DISTINCT CASE WHEN evidence_type='property_for_sale_pickup' THEN slot_index END) AS unique_forsale_slots_expected_32,
 COUNT(DISTINCT CASE WHEN evidence_type='property_locked_pickup' THEN slot_index END) AS unique_locked_slots_expected_26,
 SUM(evidence_type='property_for_sale_pickup' AND price_value IS NOT NULL) AS resolved_prices_expected_32,
 MIN(CASE WHEN evidence_type='property_for_sale_pickup' THEN price_value END) AS min_price_expected_6000,
 MAX(CASE WHEN evidence_type='property_for_sale_pickup' THEN price_value END) AS max_price_expected_120000
FROM offline_property_source_queue WHERE session_id=@sid;
SELECT 'SAVE_DUPLICATE_GATE' AS section,
 COUNT(DISTINCT CASE WHEN evidence_type='savegame_pickup' THEN CONCAT(ROUND(position_x,4),'|',ROUND(position_y,4),'|',ROUND(position_z,4)) END) AS unique_save_positions_expected_19,
 SUM(duplicate_group_size>1) AS rows_in_duplicate_groups_expected_42,
 SUM(CASE WHEN duplicate_group_size>1 THEN 1.0/duplicate_group_size ELSE 0 END) AS duplicate_groups_expected_21
FROM offline_property_source_queue WHERE session_id=@sid;
SELECT 'LINKAGE_GATE' AS section,
 (SELECT total_rows FROM offline_property_source_sessions WHERE id=@sid) AS session_rows,
 COUNT(*) AS queue_rows,
 SUM(session_id<>@sid) AS wrong_session_should_be_zero,
 COUNT(*)-(SELECT total_rows FROM offline_property_source_sessions WHERE id=@sid) AS count_delta_should_be_zero
FROM offline_property_source_queue WHERE session_id=@sid;
SELECT 'RUNTIME_UNTOUCHED_REFERENCE' AS section,
 (SELECT COUNT(*) FROM player_houses) AS player_houses_rows,
 (SELECT COUNT(*) FROM public_interiors) AS public_interiors_rows,
 (SELECT COUNT(*) FROM world_pickups) AS world_pickups_rows;
