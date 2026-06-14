-- SAIF / LSIF Dev v0.26A.1.26 verification
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @resolver_version := _utf8mb4'saif-garage-canonical-resolver-v0.26A.1.26' COLLATE utf8mb4_unicode_ci;
SET @sid := (SELECT id FROM offline_garage_resolver_sessions WHERE BINARY resolver_version=BINARY @resolver_version ORDER BY id DESC LIMIT 1);

SELECT 'SESSION_GATE' section,id,status,total_garages,linked_garages,linked_house_plans,baseline_house_links,story_asset_links,
       unlinked_garages,service_garages,world_reference_garages,invalid_bounds,
       (status='complete' AND total_garages=52 AND linked_house_plans=13 AND baseline_house_links=12 AND story_asset_links=1 AND invalid_bounds=0) ready_should_be_1
FROM offline_garage_resolver_sessions WHERE id=@sid;

SELECT 'SOURCE_GATE' section,
       COUNT(*) source_garages_expected_52,
       SUM(position_resolved<>1) unresolved_should_be_zero,
       SUM(CASE WHEN bounds_json IS NULL OR JSON_VALID(bounds_json)=0 THEN 1 WHEN JSON_LENGTH(JSON_EXTRACT(bounds_json,'$.values'))<>8 THEN 1 ELSE 0 END) invalid_source_bounds_should_be_zero,
       SUM(enabled<>0) source_enabled_should_be_zero,
       SUM(apply_status<>'pending') source_nonpending_should_be_zero
FROM offline_property_source_queue
WHERE session_id=(SELECT source_session_id FROM offline_garage_resolver_sessions WHERE id=@sid)
  AND evidence_type='garage_reference';

SELECT 'PLAN_GATE' section,
       COUNT(*) canonical_garages_expected_52,
       COUNT(DISTINCT source_queue_id) unique_source_rows_expected_52,
       COUNT(DISTINCT garage_key) unique_keys_expected_52,
       SUM(enabled<>0) enabled_should_be_zero,
       SUM(apply_status<>'draft') nondraft_should_be_zero,
       SUM(CASE WHEN bounds_json IS NULL OR JSON_VALID(bounds_json)=0 THEN 1 WHEN JSON_LENGTH(JSON_EXTRACT(bounds_json,'$.values'))<>8 THEN 1 ELSE 0 END) invalid_bounds_should_be_zero,
       SUM(ABS(center_x)<0.001 AND ABS(center_y)<0.001 AND ABS(center_z)<0.001) zero_center_should_be_zero,
       SUM(BINARY row_checksum<>BINARY SHA2(CONCAT_WS('|',source_queue_id,garage_key,garage_name,runtime_class,safety_class,link_status,
           garage_type,garage_door_type,center_x,center_y,center_z,COALESCE(bounds_json,''),source_scope,source_file,source_line,
           source_record_hash,city_region,area_code,confidence,linked_house_count,baseline_house_count,story_house_count,
           source_tag,enabled,apply_status),256)) checksum_mismatch_should_be_zero
FROM offline_garage_canonical_plan WHERE resolver_session_id=@sid;

SELECT 'SOURCE_IMMUTABILITY_GATE' section,
       SUM(q.id IS NULL) missing_source_should_be_zero,
       SUM(q.evidence_type<>'garage_reference') wrong_source_type_should_be_zero,
       SUM(BINARY p.source_record_hash<>BINARY q.record_hash) record_hash_mismatch_should_be_zero,
       SUM(p.garage_name<>q.garage_name OR p.garage_type<>q.garage_type OR p.garage_door_type<>q.garage_door_type) payload_mismatch_should_be_zero
FROM offline_garage_canonical_plan p
LEFT JOIN offline_property_source_queue q ON q.id=p.source_queue_id
WHERE p.resolver_session_id=@sid;

SELECT 'HOUSE_LINK_GATE' section,
       COUNT(*) house_links_expected_13,
       SUM(link_class='baseline_savehouse_candidate') baseline_links_expected_12,
       SUM(link_class='story_asset_deferred') story_links_expected_1,
       COUNT(DISTINCT garage_plan_id) linked_garages,
       SUM(g.id IS NULL) orphan_garage_plan_should_be_zero,
       SUM(h.id IS NULL) orphan_house_plan_should_be_zero,
       SUM(h.garage_queue_id<>l.garage_source_queue_id) source_link_mismatch_should_be_zero
FROM offline_garage_house_links l
LEFT JOIN offline_garage_canonical_plan g ON g.id=l.garage_plan_id AND g.resolver_session_id=l.resolver_session_id
LEFT JOIN offline_property_canonical_plan h ON h.id=l.house_plan_id
WHERE l.resolver_session_id=@sid;

SELECT 'CLASS_GATE' section,runtime_class,safety_class,link_status,COUNT(*) rows_count
FROM offline_garage_canonical_plan WHERE resolver_session_id=@sid
GROUP BY runtime_class,safety_class,link_status
ORDER BY FIELD(safety_class,'baseline_savehouse_candidate','story_asset_deferred','service_reference','world_reference'),runtime_class,link_status;

SELECT 'BASELINE_HOUSE_GARAGE_DETAIL' section,l.house_slot,l.house_display_name,g.id garage_plan_id,g.garage_name,g.garage_type,g.garage_door_type,
       ROUND(l.garage_distance,2) garage_distance,g.center_x,g.center_y,g.center_z,g.source_file,g.source_line
FROM offline_garage_house_links l
JOIN offline_garage_canonical_plan g ON g.id=l.garage_plan_id
WHERE l.resolver_session_id=@sid AND l.link_class='baseline_savehouse_candidate'
ORDER BY l.house_slot;

SELECT 'RUNTIME_UNTOUCHED_REFERENCE' section,
       (SELECT COUNT(*) FROM house_catalog) house_catalog_rows,
       (SELECT COUNT(*) FROM player_houses) player_house_rows,
       (SELECT COUNT(*) FROM parked_vehicles) parked_vehicle_rows,
       (SELECT COUNT(*) FROM public_interiors) public_interior_rows,
       'Read-only reference; compare with pre-run values if required.' rule_text;
