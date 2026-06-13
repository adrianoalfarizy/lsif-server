-- Verify SAIF v0.26A.1.11 Offline Vehicle Queue
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @offline_session_key := _utf8mb4'ecbbfa867b491c93570b92e0c6d3ff34e1e916da9df914d83edb066c1eac52c3' COLLATE utf8mb4_unicode_ci;
SET @offline_session_id := (SELECT id FROM offline_import_sessions WHERE session_key COLLATE utf8mb4_unicode_ci=@offline_session_key LIMIT 1);
SELECT
 COUNT(*) AS total_expected_211,
 SUM(candidate_status='resolved') AS resolved_expected_205,
 SUM(candidate_status='random_model_reference') AS random_model_expected_3,
 SUM(candidate_status='placeholder_zero') AS placeholder_expected_3,
 SUM(resolution_mode='variable_resolved') AS variable_resolved_expected_10,
 SUM(initial_switch_amount=101) AS initial_on_expected_72,
 SUM(initial_switch_amount=0) AS initial_off_expected_136,
 SUM(initial_switch_amount IS NULL) AS initial_unknown_expected_3,
 SUM(plate_name<>'') AS plate_rows,
 SUM(has_been_owned=1) AS owned_flag_rows,
 SUM(enabled=1) AS enabled_should_be_zero,
 SUM(apply_status<>'pending') AS nonpending_apply_should_be_zero,
 SUM(source_file_id IS NULL) AS unlinked_source_should_be_zero,
 SUM(modelid BETWEEN 400 AND 611 AND (ABS(pos_x)>4000 OR ABS(pos_y)>4000 OR pos_z<-100 OR pos_z>1500)) AS invalid_coordinate_should_be_zero
FROM offline_vehicle_queue WHERE session_id=@offline_session_id AND parser_version='saif-vehicle-parser-v0.26A.1.11';

SELECT candidate_status,review_status,COUNT(*) rows_count FROM offline_vehicle_queue WHERE session_id=@offline_session_id AND parser_version='saif-vehicle-parser-v0.26A.1.11' GROUP BY candidate_status,review_status ORDER BY rows_count DESC;
SELECT context_category,COUNT(*) rows_count,SUM(initial_switch_amount=101) initially_on FROM offline_vehicle_queue WHERE session_id=@offline_session_id AND parser_version='saif-vehicle-parser-v0.26A.1.11' GROUP BY context_category ORDER BY rows_count DESC;
SELECT city_region,COUNT(*) rows_count FROM offline_vehicle_queue WHERE session_id=@offline_session_id AND parser_version='saif-vehicle-parser-v0.26A.1.11' GROUP BY city_region ORDER BY rows_count DESC;
SELECT duplicate_key,COUNT(*) rows_count,GROUP_CONCAT(CONCAT(id,':',generator_name,':',modelid) ORDER BY id SEPARATOR ' | ') members FROM offline_vehicle_queue WHERE session_id=@offline_session_id AND parser_version='saif-vehicle-parser-v0.26A.1.11' AND duplicate_key<>'' GROUP BY duplicate_key ORDER BY rows_count DESC;
SELECT id,generator_name,modelid,vehicle_model_name,pos_x,pos_y,pos_z,pos_a,candidate_status,initial_switch_amount FROM offline_vehicle_queue WHERE session_id=@offline_session_id AND parser_version='saif-vehicle-parser-v0.26A.1.11' AND candidate_status<>'resolved' ORDER BY id;
