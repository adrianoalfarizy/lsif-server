-- SAIF / LSIF Dev v0.26A.1.26
-- Resolve 52 exact-source IPL GRGE rows into a deterministic garage canonical queue.
-- SAFETY: staging tables only. No house_catalog/player_houses/parked_vehicles/public_interiors/runtime garage mutation.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @garage_resolver_version := _utf8mb4'saif-garage-canonical-resolver-v0.26A.1.26' COLLATE utf8mb4_unicode_ci;
SET @source_parser_version := _utf8mb4'saif-property-source-parser-v0.26A.1.21' COLLATE utf8mb4_unicode_ci;
SET @house_resolver_version := _utf8mb4'saif-house-property-resolver-v0.26A.1.22' COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_resolve_gtasa_garages_v026A126;
DELIMITER //
CREATE PROCEDURE saif_resolve_gtasa_garages_v026A126()
BEGIN
    DECLARE v_source_session BIGINT UNSIGNED DEFAULT NULL;
    DECLARE v_house_resolver_session BIGINT UNSIGNED DEFAULT NULL;
    DECLARE v_source_garages INT DEFAULT 0;
    DECLARE v_session BIGINT UNSIGNED DEFAULT NULL;
    DECLARE v_total INT DEFAULT 0;
    DECLARE v_linked_garages INT DEFAULT 0;
    DECLARE v_linked_house_plans INT DEFAULT 0;
    DECLARE v_baseline_links INT DEFAULT 0;
    DECLARE v_story_links INT DEFAULT 0;
    DECLARE v_unlinked INT DEFAULT 0;
    DECLARE v_services INT DEFAULT 0;
    DECLARE v_world_refs INT DEFAULT 0;
    DECLARE v_invalid_bounds INT DEFAULT 0;
    DECLARE v_enabled INT DEFAULT 0;
    DECLARE v_nondraft INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SELECT id INTO v_source_session
    FROM offline_property_source_sessions
    WHERE BINARY parser_version=BINARY @source_parser_version AND status='complete'
    ORDER BY id DESC LIMIT 1;

    IF v_source_session IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Complete v0.26A.1.21 property source session not found.';
    END IF;

    SELECT id INTO v_house_resolver_session
    FROM offline_property_resolver_sessions
    WHERE source_session_id=v_source_session AND BINARY resolver_version=BINARY @house_resolver_version AND status='complete'
    ORDER BY id DESC LIMIT 1;

    IF v_house_resolver_session IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Complete v0.26A.1.22 house resolver session not found.';
    END IF;

    SELECT COUNT(*) INTO v_source_garages
    FROM offline_property_source_queue
    WHERE session_id=v_source_session AND evidence_type='garage_reference';

    IF v_source_garages<>52 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Exact GRGE source count is not 52. Do not resolve.';
    END IF;

    START TRANSACTION;

    DELETE l FROM offline_garage_house_links l
    JOIN offline_garage_resolver_sessions s ON s.id=l.resolver_session_id
    WHERE BINARY s.resolver_version=BINARY @garage_resolver_version;

    DELETE p FROM offline_garage_canonical_plan p
    JOIN offline_garage_resolver_sessions s ON s.id=p.resolver_session_id
    WHERE BINARY s.resolver_version=BINARY @garage_resolver_version;

    DELETE FROM offline_garage_resolver_sessions
    WHERE BINARY resolver_version=BINARY @garage_resolver_version;

    INSERT INTO offline_garage_resolver_sessions
    (source_session_id,house_resolver_session_id,resolver_version,source_parser_version,house_resolver_version,status,notes)
    VALUES
    (v_source_session,v_house_resolver_session,@garage_resolver_version,@source_parser_version,@house_resolver_version,'building',
     'Exact-source 52 IPL GRGE definitions. House links are evidence only. No runtime door/checkpoint/ownership mutation.');
    SET v_session=LAST_INSERT_ID();

    INSERT INTO offline_garage_canonical_plan
    (resolver_session_id,source_session_id,resolver_version,source_queue_id,garage_key,garage_name,runtime_class,safety_class,link_status,
     garage_type,garage_door_type,center_x,center_y,center_z,bounds_json,source_scope,source_file,source_line,source_record_hash,
     city_region,area_code,confidence,source_tag,enabled,apply_status,row_checksum)
    SELECT v_session,q.session_id,@garage_resolver_version,q.id,
           SHA2(CONCAT_WS('|',q.record_hash,q.garage_name,q.garage_type,q.garage_door_type,q.position_x,q.position_y,q.position_z),256),
           q.garage_name,
           CASE WHEN q.context_type='pay_n_spray' THEN 'pay_n_spray'
                WHEN q.context_type='vehicle_mod_shop' THEN 'vehicle_mod_shop'
                ELSE 'world_garage' END,
           CASE WHEN q.context_type IN ('pay_n_spray','vehicle_mod_shop') THEN 'service_reference'
                ELSE 'world_reference' END,
           CASE WHEN q.context_type IN ('pay_n_spray','vehicle_mod_shop') THEN 'unlinked_service'
                ELSE 'unlinked_world' END,
           q.garage_type,q.garage_door_type,q.position_x,q.position_y,q.position_z,q.bounds_json,
           q.source_scope,q.source_file,q.source_line,q.record_hash,q.city_region,q.area_code,q.confidence,
           'offline_gtasa_garage_plan',0,'draft',''
    FROM offline_property_source_queue q
    WHERE q.session_id=v_source_session AND q.evidence_type='garage_reference'
    ORDER BY q.id;

    INSERT INTO offline_garage_house_links
    (resolver_session_id,garage_plan_id,garage_source_queue_id,house_plan_id,house_slot,house_display_name,house_decision_code,
     house_runtime_target,house_garage_status,garage_distance,link_class,confidence)
    SELECT v_session,g.id,g.source_queue_id,h.id,h.slot_index,h.display_name,h.decision_code,h.runtime_target,h.garage_status,h.garage_distance,
           CASE WHEN h.decision_code='baseline_ready' THEN 'baseline_savehouse_candidate'
                WHEN h.decision_code='story_asset_deferred' THEN 'story_asset_deferred'
                WHEN h.decision_code='business_asset_deferred' THEN 'business_asset_deferred'
                ELSE 'deferred_review' END,
           h.confidence
    FROM offline_property_canonical_plan h
    JOIN offline_garage_canonical_plan g
      ON g.resolver_session_id=v_session AND g.source_queue_id=h.garage_queue_id
    WHERE h.resolver_session_id=v_house_resolver_session
      AND h.garage_queue_id IS NOT NULL
      AND h.garage_status='nearby_candidate';

    UPDATE offline_garage_canonical_plan g
    LEFT JOIN (
        SELECT garage_plan_id,
               COUNT(*) linked_count,
               SUM(link_class='baseline_savehouse_candidate') baseline_count,
               SUM(link_class='story_asset_deferred') story_count,
               SUM(link_class='business_asset_deferred') business_count
        FROM offline_garage_house_links
        WHERE resolver_session_id=v_session
        GROUP BY garage_plan_id
    ) x ON x.garage_plan_id=g.id
    SET g.linked_house_count=COALESCE(x.linked_count,0),
        g.baseline_house_count=COALESCE(x.baseline_count,0),
        g.story_house_count=COALESCE(x.story_count,0),
        g.link_status=CASE
            WHEN COALESCE(x.baseline_count,0)>0 THEN 'linked_baseline'
            WHEN COALESCE(x.story_count,0)>0 OR COALESCE(x.business_count,0)>0 THEN 'linked_deferred'
            WHEN g.runtime_class IN ('pay_n_spray','vehicle_mod_shop') THEN 'unlinked_service'
            ELSE 'unlinked_world' END,
        g.safety_class=CASE
            WHEN COALESCE(x.baseline_count,0)>0 THEN 'baseline_savehouse_candidate'
            WHEN COALESCE(x.story_count,0)>0 THEN 'story_asset_deferred'
            WHEN COALESCE(x.business_count,0)>0 THEN 'business_asset_deferred'
            WHEN g.runtime_class IN ('pay_n_spray','vehicle_mod_shop') THEN 'service_reference'
            ELSE 'world_reference' END
    WHERE g.resolver_session_id=v_session;

    UPDATE offline_garage_canonical_plan
    SET row_checksum=SHA2(CONCAT_WS('|',source_queue_id,garage_key,garage_name,runtime_class,safety_class,link_status,
        garage_type,garage_door_type,center_x,center_y,center_z,COALESCE(bounds_json,''),source_scope,source_file,source_line,
        source_record_hash,city_region,area_code,confidence,linked_house_count,baseline_house_count,story_house_count,
        source_tag,enabled,apply_status),256)
    WHERE resolver_session_id=v_session;

    SELECT COUNT(*) INTO v_total FROM offline_garage_canonical_plan WHERE resolver_session_id=v_session;
    SELECT COUNT(*) INTO v_linked_garages FROM offline_garage_canonical_plan WHERE resolver_session_id=v_session AND linked_house_count>0;
    SELECT COUNT(*) INTO v_linked_house_plans FROM offline_garage_house_links WHERE resolver_session_id=v_session;
    SELECT COUNT(*) INTO v_baseline_links FROM offline_garage_house_links WHERE resolver_session_id=v_session AND link_class='baseline_savehouse_candidate';
    SELECT COUNT(*) INTO v_story_links FROM offline_garage_house_links WHERE resolver_session_id=v_session AND link_class='story_asset_deferred';
    SELECT COUNT(*) INTO v_unlinked FROM offline_garage_canonical_plan WHERE resolver_session_id=v_session AND linked_house_count=0;
    SELECT COUNT(*) INTO v_services FROM offline_garage_canonical_plan WHERE resolver_session_id=v_session AND runtime_class IN ('pay_n_spray','vehicle_mod_shop');
    SELECT COUNT(*) INTO v_world_refs FROM offline_garage_canonical_plan WHERE resolver_session_id=v_session AND runtime_class='world_garage';
    SELECT COUNT(*) INTO v_invalid_bounds FROM offline_garage_canonical_plan
      WHERE resolver_session_id=v_session
        AND CASE WHEN bounds_json IS NULL OR JSON_VALID(bounds_json)=0 THEN 1
                 WHEN JSON_LENGTH(JSON_EXTRACT(bounds_json,'$.values'))<>8 THEN 1
                 ELSE 0 END=1;
    SELECT COUNT(*) INTO v_enabled FROM offline_garage_canonical_plan WHERE resolver_session_id=v_session AND enabled<>0;
    SELECT COUNT(*) INTO v_nondraft FROM offline_garage_canonical_plan WHERE resolver_session_id=v_session AND apply_status<>'draft';

    UPDATE offline_garage_resolver_sessions
    SET total_garages=v_total,
        linked_garages=v_linked_garages,
        linked_house_plans=v_linked_house_plans,
        baseline_house_links=v_baseline_links,
        story_asset_links=v_story_links,
        unlinked_garages=v_unlinked,
        service_garages=v_services,
        world_reference_garages=v_world_refs,
        invalid_bounds=v_invalid_bounds,
        status=CASE WHEN v_total=52 AND v_linked_house_plans=13 AND v_baseline_links=12 AND v_story_links=1
                         AND v_invalid_bounds=0 AND v_enabled=0 AND v_nondraft=0
                    THEN 'complete' ELSE 'count_mismatch' END,
        completed_at=CURRENT_TIMESTAMP,
        notes=CONCAT('Exact GRGE=',v_total,'; linked garages=',v_linked_garages,'; house links=',v_linked_house_plans,
                     '; baseline=',v_baseline_links,'; story=',v_story_links,'; unlinked=',v_unlinked,
                     '; service=',v_services,'; world=',v_world_refs,'; invalid bounds=',v_invalid_bounds,
                     '. Runtime mutation: none.')
    WHERE id=v_session;

    COMMIT;

    SELECT * FROM offline_garage_resolver_sessions WHERE id=v_session;
    SELECT 'SAFETY_GATE' section,v_enabled enabled_should_be_zero,v_nondraft nondraft_should_be_zero,
           'No runtime garage/door/checkpoint/vehicle/house/ownership mutation.' safety_contract;
END//
DELIMITER ;
CALL saif_resolve_gtasa_garages_v026A126();
DROP PROCEDURE IF EXISTS saif_resolve_gtasa_garages_v026A126;
