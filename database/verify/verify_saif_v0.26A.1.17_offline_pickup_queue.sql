-- Verify SAIF v0.26A.1.17 pickup queue foundation
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SELECT 'QUEUE_GATE' section,
 COUNT(*) total_expected_782,
 SUM(source_scope='SCM') scm_expected_777,
 SUM(source_scope='IPL') ipl_expected_5,
 SUM(position_resolved=1) resolved_expected_758,
 SUM(position_resolved=0) unresolved_expected_24,
 SUM(zero_coordinate=1) zero_coordinate_expected_5,
 SUM(enabled=1) enabled_should_be_zero,
 SUM(apply_status<>'pending') nonpending_should_be_zero,
 SUM(review_status<>'pending') nonpending_review_should_be_zero,
 COUNT(*)-COUNT(DISTINCT record_hash) duplicate_hash_should_be_zero
FROM offline_pickup_queue WHERE parser_version='saif-pickup-parser-v0.26A.1.17';

SELECT 'SOURCE_COMMANDS' section,source_command,COUNT(*) rows_count
FROM offline_pickup_queue WHERE parser_version='saif-pickup-parser-v0.26A.1.17' GROUP BY source_command ORDER BY rows_count DESC,source_command;
SELECT 'CATEGORIES' section,pickup_category,multiplayer_safety,COUNT(*) rows_count
FROM offline_pickup_queue WHERE parser_version='saif-pickup-parser-v0.26A.1.17' GROUP BY pickup_category,multiplayer_safety ORDER BY rows_count DESC,pickup_category;
SELECT 'SOURCE_LINK_GATE' section,SUM(source_file_id IS NULL) missing_source_file_links
FROM offline_pickup_queue WHERE parser_version='saif-pickup-parser-v0.26A.1.17';
SELECT 'DUPLICATE_AUDIT' section,COUNT(DISTINCT NULLIF(duplicate_key,'')) duplicate_groups,SUM(duplicate_group_size>1) duplicate_rows
FROM offline_pickup_queue WHERE parser_version='saif-pickup-parser-v0.26A.1.17';
SELECT 'RUNTIME_UNTOUCHED_REFERENCE' section,COUNT(*) current_world_pickups,SUM(enabled=1) current_world_pickups_active FROM world_pickups;
