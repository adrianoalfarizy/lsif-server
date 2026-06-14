-- SAIF / LSIF Dev v0.26A.1.25.1
-- Controlled apply of exactly 29 GTA SA canonical savehouses.
-- REQUIRED: SET @saif_confirm='APPLY_29_GTASA_SAVEHOUSES';
-- No DELETE. Explicitly preserved legacy definitions stay enabled.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_apply_gtasa29_savehouses_v026A125;
DROP PROCEDURE IF EXISTS saif_apply_gtasa29_savehouses_v026A1251;
DELIMITER //
CREATE PROCEDURE saif_apply_gtasa29_savehouses_v026A1251()
main: BEGIN
    DECLARE v_done INT DEFAULT 0;
    DECLARE v_confirm VARBINARY(96) DEFAULT X'';
    DECLARE v_archive_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_resolver_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_apply_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_archive_status VARCHAR(32) DEFAULT '';
    DECLARE v_archive_total INT DEFAULT 0;
    DECLARE v_archive_active INT DEFAULT 0;
    DECLARE v_archive_target INT DEFAULT 0;
    DECLARE v_archive_rows INT DEFAULT 0;
    DECLARE v_catalog_total_before INT DEFAULT 0;
    DECLARE v_catalog_active_before INT DEFAULT 0;
    DECLARE v_ownership_before INT DEFAULT 0;
    DECLARE v_catalog_checksum_mismatch INT DEFAULT 0;
    DECLARE v_catalog_archive_missing INT DEFAULT 0;
    DECLARE v_catalog_current_missing INT DEFAULT 0;
    DECLARE v_owner_checksum_mismatch INT DEFAULT 0;
    DECLARE v_owner_archive_missing INT DEFAULT 0;
    DECLARE v_owner_current_missing INT DEFAULT 0;
    DECLARE v_total_plans INT DEFAULT 0;
    DECLARE v_baseline_plans INT DEFAULT 0;
    DECLARE v_business_deferred INT DEFAULT 0;
    DECLARE v_story_deferred INT DEFAULT 0;
    DECLARE v_invalid_selected INT DEFAULT 0;
    DECLARE v_internal_duplicates INT DEFAULT 0;
    DECLARE v_transition_rows INT DEFAULT 0;
    DECLARE v_pending_rows INT DEFAULT 0;
    DECLARE v_invalid_policy_rows INT DEFAULT 0;
    DECLARE v_unsupported_refund_rows INT DEFAULT 0;
    DECLARE v_preserve_rows INT DEFAULT 0;
    DECLARE v_mapped_rows INT DEFAULT 0;
    DECLARE v_preserved_catalogs INT DEFAULT 0;
    DECLARE v_invalid_mapped_targets INT DEFAULT 0;
    DECLARE v_duplicate_mapped_targets INT DEFAULT 0;
    DECLARE v_public_icons INT DEFAULT 0;
    DECLARE v_hospital_icons INT DEFAULT 0;
    DECLARE v_hospital_fallback INT DEFAULT 0;
    DECLARE v_public_candidates INT DEFAULT 0;
    DECLARE v_public_rendered INT DEFAULT 0;
    DECLARE v_public_omitted INT DEFAULT 0;
    DECLARE v_live_apply INT DEFAULT 0;
    DECLARE v_orphan_import_active INT DEFAULT 0;
    DECLARE v_existing_canonical_rows INT DEFAULT 0;
    DECLARE v_disabled_count INT DEFAULT 0;
    DECLARE v_inserted_count INT DEFAULT 0;
    DECLARE v_catalog_id INT UNSIGNED DEFAULT 0;
    DECLARE v_active_after INT DEFAULT 0;
    DECLARE v_ownership_after INT DEFAULT 0;
    DECLARE v_ownership_invalid_after INT DEFAULT 0;
    DECLARE v_expected_active_after INT DEFAULT 0;
    DECLARE v_apply_key VARCHAR(96) DEFAULT '';
    DECLARE v_source_tag VARCHAR(64) DEFAULT '';
    DECLARE v_row_checksum CHAR(64) DEFAULT '';

    DECLARE v_plan_id BIGINT UNSIGNED;
    DECLARE v_slot INT;
    DECLARE v_display_name VARCHAR(160);
    DECLARE v_price INT;
    DECLARE v_ext_x DOUBLE; DECLARE v_ext_y DOUBLE; DECLARE v_ext_z DOUBLE; DECLARE v_ext_a DOUBLE;
    DECLARE v_ext_spawn_x DOUBLE; DECLARE v_ext_spawn_y DOUBLE; DECLARE v_ext_spawn_z DOUBLE; DECLARE v_ext_spawn_a DOUBLE;
    DECLARE v_interior INT;
    DECLARE v_int_exit_x DOUBLE; DECLARE v_int_exit_y DOUBLE; DECLARE v_int_exit_z DOUBLE;
    DECLARE v_int_spawn_x DOUBLE; DECLARE v_int_spawn_y DOUBLE; DECLARE v_int_spawn_z DOUBLE; DECLARE v_int_spawn_a DOUBLE;
    DECLARE v_save_x DOUBLE; DECLARE v_save_y DOUBLE; DECLARE v_save_z DOUBLE;
    DECLARE v_garage_id BIGINT UNSIGNED;

    DECLARE cur_selected CURSOR FOR
        SELECT p.id,p.slot_index,p.display_name,p.price_value,
               p.exterior_x,p.exterior_y,p.exterior_z,p.exterior_a,
               p.exterior_spawn_x,p.exterior_spawn_y,p.exterior_spawn_z,p.exterior_spawn_a,
               p.interior_id,p.interior_exit_x,p.interior_exit_y,p.interior_exit_z,
               p.interior_spawn_x,p.interior_spawn_y,p.interior_spawn_z,p.interior_spawn_a,
               p.savepoint_x,p.savepoint_y,p.savepoint_z,p.garage_queue_id
        FROM offline_property_canonical_plan p
        WHERE p.resolver_session_id=v_resolver_session_id
          AND p.resolver_version='saif-house-property-resolver-v0.26A.1.22'
          AND p.decision_code='baseline_ready' AND p.apply_status='draft' AND p.enabled=0
        ORDER BY p.slot_index;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done=1;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        IF v_apply_session_id>0 THEN
            UPDATE offline_house_catalog_apply_sessions
            SET apply_status='failed',notes=CONCAT(notes,' Transaction rolled back by SQL exception.')
            WHERE id=v_apply_session_id;
        END IF;
        RESIGNAL;
    END;

    SET v_confirm=BINARY COALESCE(@saif_confirm,'');
    IF v_confirm<>_binary'APPLY_29_GTASA_SAVEHOUSES' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation token missing. Required: APPLY_29_GTASA_SAVEHOUSES';
    END IF;

    SELECT COALESCE(MAX(id),0) INTO v_archive_session_id FROM offline_runtime_archive_sessions WHERE archive_scope='house_catalog';
    IF v_archive_session_id=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No house_catalog archive found.'; END IF;
    SELECT archive_status,runtime_rows_total,active_rows_total,target_rows_total,archived_rows
      INTO v_archive_status,v_archive_total,v_archive_active,v_archive_target,v_archive_rows
    FROM offline_runtime_archive_sessions WHERE id=v_archive_session_id;
    IF v_archive_status<>'complete' OR v_archive_total<>v_archive_rows OR v_archive_target<>29 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Latest house_catalog archive is not complete/target-29.';
    END IF;

    SELECT COALESCE(MAX(id),0) INTO v_resolver_session_id FROM offline_property_resolver_sessions
    WHERE resolver_version='saif-house-property-resolver-v0.26A.1.22' AND status='complete';
    IF v_resolver_session_id=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Complete v0.26A.1.22 house resolver session not found.'; END IF;

    SELECT COUNT(*),COALESCE(SUM(enabled=1),0) INTO v_catalog_total_before,v_catalog_active_before FROM house_catalog;
    SELECT COUNT(*) INTO v_ownership_before FROM player_houses;
    IF v_catalog_total_before<>v_archive_total OR v_catalog_active_before<>v_archive_active THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='house_catalog count/enabled state changed after archive. Capture fresh archive.';
    END IF;
    IF v_ownership_before<>(SELECT COUNT(*) FROM offline_house_ownership_archive WHERE archive_session_id=v_archive_session_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='player_houses row count changed after archive. Capture fresh archive.';
    END IF;

    SELECT COUNT(*) INTO v_catalog_archive_missing FROM offline_house_catalog_archive a LEFT JOIN house_catalog h ON h.id=a.original_id WHERE a.archive_session_id=v_archive_session_id AND h.id IS NULL;
    SELECT COUNT(*) INTO v_catalog_current_missing FROM house_catalog h LEFT JOIN offline_house_catalog_archive a ON a.archive_session_id=v_archive_session_id AND a.original_id=h.id WHERE a.original_id IS NULL;
    SELECT COUNT(*) INTO v_catalog_checksum_mismatch FROM offline_house_catalog_archive a JOIN house_catalog h ON h.id=a.original_id
    WHERE a.archive_session_id=v_archive_session_id AND BINARY a.row_checksum<>BINARY SHA2(CONCAT_WS('|',h.id,COALESCE(h.legacy_house_index,'NULL'),COALESCE(h.canonical_slot,'NULL'),COALESCE(h.display_name,''),COALESCE(h.price,0),COALESCE(h.exterior_pickup_x,0),COALESCE(h.exterior_pickup_y,0),COALESCE(h.exterior_pickup_z,0),COALESCE(h.exterior_facing,0),COALESCE(h.exterior_spawn_x,0),COALESCE(h.exterior_spawn_y,0),COALESCE(h.exterior_spawn_z,0),COALESCE(h.exterior_spawn_a,0),COALESCE(h.interior_id,0),COALESCE(h.interior_exit_x,0),COALESCE(h.interior_exit_y,0),COALESCE(h.interior_exit_z,0),COALESCE(h.interior_spawn_x,0),COALESCE(h.interior_spawn_y,0),COALESCE(h.interior_spawn_z,0),COALESCE(h.interior_spawn_a,0),COALESCE(h.savepoint_x,'NULL'),COALESCE(h.savepoint_y,'NULL'),COALESCE(h.savepoint_z,'NULL'),COALESCE(h.garage_source_evidence_id,'NULL'),COALESCE(h.map_icon_type,0),COALESCE(h.pickup_model,0),COALESCE(h.pickup_type,0),COALESCE(h.private_vw_required,0),COALESCE(h.enabled,0),COALESCE(h.sort_order,0),COALESCE(h.source_tag,'')),256);
    IF v_catalog_archive_missing<>0 OR v_catalog_current_missing<>0 OR v_catalog_checksum_mismatch<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='house_catalog no longer matches archive checksum/linkage.';
    END IF;

    SELECT COUNT(*) INTO v_owner_archive_missing FROM offline_house_ownership_archive a LEFT JOIN player_houses ph ON ph.id=a.player_house_id WHERE a.archive_session_id=v_archive_session_id AND ph.id IS NULL;
    SELECT COUNT(*) INTO v_owner_current_missing FROM player_houses ph LEFT JOIN offline_house_ownership_archive a ON a.archive_session_id=v_archive_session_id AND a.player_house_id=ph.id WHERE a.player_house_id IS NULL;
    SELECT COUNT(*) INTO v_owner_checksum_mismatch FROM offline_house_ownership_archive a JOIN player_houses ph ON ph.id=a.player_house_id
    WHERE a.archive_session_id=v_archive_session_id AND BINARY a.row_checksum<>BINARY SHA2(CONCAT_WS('|',ph.id,ph.owner_id,COALESCE(ph.house_catalog_id,'NULL'),ph.house_index,COALESCE(ph.house_name,''),COALESCE(ph.price,0),COALESCE(ph.locked,1),COALESCE(ph.pos_x,0),COALESCE(ph.pos_y,0),COALESCE(ph.pos_z,0)),256);
    IF v_owner_archive_missing<>0 OR v_owner_current_missing<>0 OR v_owner_checksum_mismatch<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='player_houses no longer matches archive checksum/linkage.';
    END IF;

    SELECT COUNT(*),SUM(decision_code='baseline_ready' AND apply_status='draft'),SUM(decision_code='business_asset_deferred'),SUM(decision_code='story_asset_deferred')
      INTO v_total_plans,v_baseline_plans,v_business_deferred,v_story_deferred
    FROM offline_property_canonical_plan WHERE resolver_session_id=v_resolver_session_id;
    IF v_total_plans<>32 OR v_baseline_plans<>29 OR v_business_deferred<>2 OR v_story_deferred<>1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Canonical house plan gate mismatch.';
    END IF;

    SELECT COUNT(*) INTO v_invalid_selected FROM offline_property_canonical_plan p
    WHERE p.resolver_session_id=v_resolver_session_id AND p.decision_code='baseline_ready'
      AND (p.apply_status<>'draft' OR p.enabled<>0 OR p.runtime_target<>'house_catalog' OR p.pair_status<>'exact_pair'
           OR p.private_vw_required<>1 OR p.price_value<=0 OR p.interior_id<=0 OR p.savepoint_status<>'template_linked'
           OR (ABS(p.exterior_x)<0.001 AND ABS(p.exterior_y)<0.001 AND ABS(p.exterior_z)<0.001)
           OR (ABS(p.interior_spawn_x)<0.001 AND ABS(p.interior_spawn_y)<0.001 AND ABS(p.interior_spawn_z)<0.001));
    IF v_invalid_selected<>0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Selected house plan contains invalid transform/payload rows.'; END IF;

    SELECT COUNT(*) INTO v_internal_duplicates FROM offline_property_canonical_plan p1 JOIN offline_property_canonical_plan p2
      ON p2.id>p1.id AND p2.resolver_session_id=p1.resolver_session_id AND p2.decision_code='baseline_ready'
    WHERE p1.resolver_session_id=v_resolver_session_id AND p1.decision_code='baseline_ready'
      AND POW(p1.exterior_x-p2.exterior_x,2)+POW(p1.exterior_y-p2.exterior_y,2)+POW(p1.exterior_z-p2.exterior_z,2)<=1.0;
    IF v_internal_duplicates<>0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Canonical house exterior duplicate detected.'; END IF;

    SELECT COUNT(*),SUM(policy_status='pending_mapping'),SUM(policy_status='invalid_source'),SUM(policy_status='refund_then_release'),SUM(policy_status='preserve_legacy'),SUM(policy_status='mapped')
      INTO v_transition_rows,v_pending_rows,v_invalid_policy_rows,v_unsupported_refund_rows,v_preserve_rows,v_mapped_rows
    FROM offline_house_ownership_transition_plan WHERE archive_session_id=v_archive_session_id;
    IF v_transition_rows<>v_ownership_before OR v_pending_rows<>0 OR v_invalid_policy_rows<>0 OR v_unsupported_refund_rows<>0 OR v_preserve_rows+v_mapped_rows<>v_transition_rows THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Ownership transition policy is incomplete or unsupported.';
    END IF;

    SELECT COUNT(DISTINCT old_house_catalog_id) INTO v_preserved_catalogs FROM offline_house_ownership_transition_plan WHERE archive_session_id=v_archive_session_id AND policy_status='preserve_legacy';
    SELECT COUNT(*) INTO v_invalid_mapped_targets FROM offline_house_ownership_transition_plan t LEFT JOIN offline_property_canonical_plan p
      ON p.id=t.target_plan_id AND p.slot_index=t.target_canonical_slot AND p.resolver_session_id=v_resolver_session_id AND p.decision_code='baseline_ready'
    WHERE t.archive_session_id=v_archive_session_id AND t.policy_status='mapped' AND p.id IS NULL;
    SELECT COUNT(*) INTO v_duplicate_mapped_targets FROM (SELECT target_canonical_slot FROM offline_house_ownership_transition_plan WHERE archive_session_id=v_archive_session_id AND policy_status='mapped' GROUP BY target_canonical_slot HAVING COUNT(*)>1) d;
    IF v_invalid_mapped_targets<>0 OR v_duplicate_mapped_targets<>0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Mapped ownership target is invalid or duplicated.'; END IF;

    SELECT COUNT(*) INTO v_public_icons FROM public_interiors WHERE enabled=1 AND exterior_map_icon>0;
    SELECT COUNT(*) INTO v_hospital_icons FROM public_interiors WHERE enabled=1 AND interior_type='hospital' AND exterior_map_icon>0;
    SET v_hospital_fallback=GREATEST(0,7-LEAST(7,v_hospital_icons));
    SET v_public_candidates=v_public_icons+v_hospital_fallback;
    SET v_public_rendered=LEAST(91,v_public_candidates);
    SET v_public_omitted=GREATEST(0,v_public_candidates-v_public_rendered);
    -- Candidate overflow is informational. The Pawn allocator renders hospitals first,
    -- then other public services up to slot 90. Slots 91-99 remain reserved for houses.
    IF NOT EXISTS (SELECT 1 FROM house_map_icon_policy WHERE id=1 AND enabled=1 AND public_service_slots=91 AND owned_house_slots=1 AND nearby_for_sale_slots=8) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='House map icon policy is missing or differs from 91+1+8 readiness contract.';
    END IF;

    SELECT COUNT(*) INTO v_live_apply FROM offline_house_catalog_apply_sessions WHERE apply_status='complete' AND rolled_back_at IS NULL;
    SELECT COUNT(*) INTO v_orphan_import_active FROM house_catalog WHERE enabled=1 AND source_tag LIKE 'offline_gtasa_house29_a%';
    SELECT COUNT(*) INTO v_existing_canonical_rows FROM house_catalog WHERE canonical_slot IS NOT NULL;
    IF v_live_apply<>0 OR v_orphan_import_active<>0 OR v_existing_canonical_rows<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='A live/orphan/canonical house apply already exists.';
    END IF;

    SET v_expected_active_after=29+v_preserved_catalogs;
    IF v_expected_active_after>64 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Projected active house catalog exceeds runtime capacity 64.'; END IF;

    SET v_apply_key=CONCAT('gtasa29_house_apply_',DATE_FORMAT(NOW(6),'%Y%m%d%H%i%s%f'));
    INSERT INTO offline_house_catalog_apply_sessions
      (apply_key,archive_session_id,resolver_session_id,apply_status,catalog_rows_before,catalog_active_before,ownership_rows_before,preserve_legacy_rows,mapped_ownership_rows,notes)
    VALUES
      (v_apply_key,v_archive_session_id,v_resolver_session_id,'applying',v_catalog_total_before,v_catalog_active_before,v_ownership_before,v_preserve_rows,v_mapped_rows,
       CONCAT('Controlled apply: preserve explicitly protected legacy definitions, insert exactly 29 canonical GTA SA savehouses, map only explicit mapped ownership rows. Public icon candidates=',v_public_candidates,', rendered=',v_public_rendered,', omitted_by_allocator=',v_public_omitted,'.'));
    SET v_apply_session_id=LAST_INSERT_ID();
    SET v_source_tag=CONCAT('offline_gtasa_house29_a',v_apply_session_id);
    UPDATE offline_house_catalog_apply_sessions SET source_tag=v_source_tag WHERE id=v_apply_session_id;

    START TRANSACTION;

    INSERT INTO offline_house_catalog_disabled_rows(apply_session_id,house_catalog_id,previous_enabled,previous_source_tag,row_checksum)
    SELECT v_apply_session_id,h.id,h.enabled,COALESCE(h.source_tag,''),
           SHA2(CONCAT_WS('|',h.id,COALESCE(h.legacy_house_index,'NULL'),COALESCE(h.canonical_slot,'NULL'),COALESCE(h.display_name,''),COALESCE(h.price,0),COALESCE(h.exterior_pickup_x,0),COALESCE(h.exterior_pickup_y,0),COALESCE(h.exterior_pickup_z,0),COALESCE(h.exterior_facing,0),COALESCE(h.exterior_spawn_x,0),COALESCE(h.exterior_spawn_y,0),COALESCE(h.exterior_spawn_z,0),COALESCE(h.exterior_spawn_a,0),COALESCE(h.interior_id,0),COALESCE(h.interior_exit_x,0),COALESCE(h.interior_exit_y,0),COALESCE(h.interior_exit_z,0),COALESCE(h.interior_spawn_x,0),COALESCE(h.interior_spawn_y,0),COALESCE(h.interior_spawn_z,0),COALESCE(h.interior_spawn_a,0),COALESCE(h.savepoint_x,'NULL'),COALESCE(h.savepoint_y,'NULL'),COALESCE(h.savepoint_z,'NULL'),COALESCE(h.garage_source_evidence_id,'NULL'),COALESCE(h.map_icon_type,0),COALESCE(h.pickup_model,0),COALESCE(h.pickup_type,0),COALESCE(h.private_vw_required,0),h.enabled,COALESCE(h.sort_order,0),COALESCE(h.source_tag,'')),256)
    FROM house_catalog h
    WHERE h.enabled=1 AND NOT EXISTS (
        SELECT 1 FROM offline_house_ownership_transition_plan t
        WHERE t.archive_session_id=v_archive_session_id AND t.policy_status='preserve_legacy' AND t.old_house_catalog_id=h.id
    );
    SET v_disabled_count=ROW_COUNT();

    UPDATE house_catalog h JOIN offline_house_catalog_disabled_rows d ON d.house_catalog_id=h.id AND d.apply_session_id=v_apply_session_id SET h.enabled=0;

    SET v_done=0;
    OPEN cur_selected;
    selected_loop: LOOP
        FETCH cur_selected INTO v_plan_id,v_slot,v_display_name,v_price,
            v_ext_x,v_ext_y,v_ext_z,v_ext_a,v_ext_spawn_x,v_ext_spawn_y,v_ext_spawn_z,v_ext_spawn_a,
            v_interior,v_int_exit_x,v_int_exit_y,v_int_exit_z,v_int_spawn_x,v_int_spawn_y,v_int_spawn_z,v_int_spawn_a,
            v_save_x,v_save_y,v_save_z,v_garage_id;
        IF v_done=1 THEN LEAVE selected_loop; END IF;

        INSERT INTO house_catalog
        (legacy_house_index,canonical_slot,display_name,price,
         exterior_pickup_x,exterior_pickup_y,exterior_pickup_z,exterior_facing,
         exterior_spawn_x,exterior_spawn_y,exterior_spawn_z,exterior_spawn_a,
         interior_id,interior_exit_x,interior_exit_y,interior_exit_z,
         interior_spawn_x,interior_spawn_y,interior_spawn_z,interior_spawn_a,
         savepoint_x,savepoint_y,savepoint_z,garage_source_evidence_id,
         map_icon_type,pickup_model,pickup_type,private_vw_required,enabled,sort_order,source_tag)
        VALUES
        (NULL,v_slot,v_display_name,v_price,
         v_ext_x,v_ext_y,v_ext_z,v_ext_a,
         v_ext_spawn_x,v_ext_spawn_y,v_ext_spawn_z,v_ext_spawn_a,
         v_interior,v_int_exit_x,v_int_exit_y,v_int_exit_z,
         v_int_spawn_x,v_int_spawn_y,v_int_spawn_z,v_int_spawn_a,
         v_save_x,v_save_y,v_save_z,v_garage_id,
         31,1318,1,1,1,100+v_slot,v_source_tag);
        SET v_catalog_id=LAST_INSERT_ID();

        SELECT SHA2(CONCAT_WS('|',id,COALESCE(legacy_house_index,'NULL'),COALESCE(canonical_slot,'NULL'),COALESCE(display_name,''),COALESCE(price,0),COALESCE(exterior_pickup_x,0),COALESCE(exterior_pickup_y,0),COALESCE(exterior_pickup_z,0),COALESCE(exterior_facing,0),COALESCE(exterior_spawn_x,0),COALESCE(exterior_spawn_y,0),COALESCE(exterior_spawn_z,0),COALESCE(exterior_spawn_a,0),COALESCE(interior_id,0),COALESCE(interior_exit_x,0),COALESCE(interior_exit_y,0),COALESCE(interior_exit_z,0),COALESCE(interior_spawn_x,0),COALESCE(interior_spawn_y,0),COALESCE(interior_spawn_z,0),COALESCE(interior_spawn_a,0),COALESCE(savepoint_x,'NULL'),COALESCE(savepoint_y,'NULL'),COALESCE(savepoint_z,'NULL'),COALESCE(garage_source_evidence_id,'NULL'),COALESCE(map_icon_type,0),COALESCE(pickup_model,0),COALESCE(pickup_type,0),COALESCE(private_vw_required,0),COALESCE(enabled,0),COALESCE(sort_order,0),COALESCE(source_tag,'')),256)
          INTO v_row_checksum FROM house_catalog WHERE id=v_catalog_id;
        INSERT INTO offline_house_catalog_apply_rows(apply_session_id,plan_id,canonical_slot,house_catalog_id,source_tag,row_checksum)
        VALUES(v_apply_session_id,v_plan_id,v_slot,v_catalog_id,v_source_tag,v_row_checksum);
        SET v_inserted_count=v_inserted_count+1;
    END LOOP;
    CLOSE cur_selected;

    IF v_inserted_count<>29 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Inserted canonical house count differs from 29.'; END IF;

    INSERT INTO offline_house_ownership_apply_rows
    (apply_session_id,transition_id,player_house_id,policy_status,
     old_house_catalog_id,old_house_index,old_house_name,old_price,old_locked,old_pos_x,old_pos_y,old_pos_z,
     new_house_catalog_id,new_house_index,new_house_name,new_price,new_locked,new_pos_x,new_pos_y,new_pos_z,
     before_checksum,after_checksum)
    SELECT v_apply_session_id,t.id,ph.id,t.policy_status,
           ph.house_catalog_id,ph.house_index,COALESCE(ph.house_name,''),COALESCE(ph.price,0),COALESCE(ph.locked,1),COALESCE(ph.pos_x,0),COALESCE(ph.pos_y,0),COALESCE(ph.pos_z,0),
           CASE WHEN t.policy_status='mapped' THEN ar.house_catalog_id ELSE ph.house_catalog_id END,
           CASE WHEN t.policy_status='mapped' THEN t.target_canonical_slot ELSE ph.house_index END,
           CASE WHEN t.policy_status='mapped' THEN hc.display_name ELSE COALESCE(ph.house_name,'') END,
           CASE WHEN t.policy_status='mapped' THEN hc.price ELSE COALESCE(ph.price,0) END,
           COALESCE(ph.locked,1),
           CASE WHEN t.policy_status='mapped' THEN hc.exterior_pickup_x ELSE COALESCE(ph.pos_x,0) END,
           CASE WHEN t.policy_status='mapped' THEN hc.exterior_pickup_y ELSE COALESCE(ph.pos_y,0) END,
           CASE WHEN t.policy_status='mapped' THEN hc.exterior_pickup_z ELSE COALESCE(ph.pos_z,0) END,
           SHA2(CONCAT_WS('|',ph.id,ph.owner_id,COALESCE(ph.house_catalog_id,'NULL'),ph.house_index,COALESCE(ph.house_name,''),COALESCE(ph.price,0),COALESCE(ph.locked,1),COALESCE(ph.pos_x,0),COALESCE(ph.pos_y,0),COALESCE(ph.pos_z,0)),256),
           SHA2(CONCAT_WS('|',ph.id,ph.owner_id,
                COALESCE(CASE WHEN t.policy_status='mapped' THEN ar.house_catalog_id ELSE ph.house_catalog_id END,'NULL'),
                CASE WHEN t.policy_status='mapped' THEN t.target_canonical_slot ELSE ph.house_index END,
                CASE WHEN t.policy_status='mapped' THEN hc.display_name ELSE COALESCE(ph.house_name,'') END,
                CASE WHEN t.policy_status='mapped' THEN hc.price ELSE COALESCE(ph.price,0) END,
                COALESCE(ph.locked,1),
                CASE WHEN t.policy_status='mapped' THEN hc.exterior_pickup_x ELSE COALESCE(ph.pos_x,0) END,
                CASE WHEN t.policy_status='mapped' THEN hc.exterior_pickup_y ELSE COALESCE(ph.pos_y,0) END,
                CASE WHEN t.policy_status='mapped' THEN hc.exterior_pickup_z ELSE COALESCE(ph.pos_z,0) END),256)
    FROM offline_house_ownership_transition_plan t
    JOIN player_houses ph ON ph.id=t.player_house_id
    LEFT JOIN offline_house_catalog_apply_rows ar ON ar.apply_session_id=v_apply_session_id AND ar.plan_id=t.target_plan_id
    LEFT JOIN house_catalog hc ON hc.id=ar.house_catalog_id
    WHERE t.archive_session_id=v_archive_session_id;

    UPDATE player_houses ph
    JOIN offline_house_ownership_transition_plan t ON t.player_house_id=ph.id AND t.archive_session_id=v_archive_session_id AND t.policy_status='mapped'
    JOIN offline_house_catalog_apply_rows ar ON ar.apply_session_id=v_apply_session_id AND ar.plan_id=t.target_plan_id
    JOIN house_catalog hc ON hc.id=ar.house_catalog_id
    SET ph.house_catalog_id=hc.id,ph.house_index=t.target_canonical_slot,ph.house_name=hc.display_name,
        ph.price=hc.price,ph.pos_x=hc.exterior_pickup_x,ph.pos_y=hc.exterior_pickup_y,ph.pos_z=hc.exterior_pickup_z;

    UPDATE offline_property_canonical_plan p JOIN offline_house_catalog_apply_rows r ON r.plan_id=p.id AND r.apply_session_id=v_apply_session_id SET p.apply_status='applied';

    SELECT COALESCE(SUM(enabled=1),0) INTO v_active_after FROM house_catalog;
    SELECT COUNT(*) INTO v_ownership_after FROM player_houses;
    SELECT COUNT(*) INTO v_ownership_invalid_after FROM player_houses ph LEFT JOIN house_catalog hc ON hc.id=ph.house_catalog_id WHERE hc.id IS NULL OR hc.enabled<>1;
    IF v_active_after<>v_expected_active_after OR v_ownership_after<>v_ownership_before OR v_ownership_invalid_after<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Post-apply catalog/ownership gate mismatch.';
    END IF;

    UPDATE offline_house_catalog_apply_sessions
    SET apply_status='complete',legacy_rows_disabled=v_disabled_count,canonical_rows_inserted=v_inserted_count,
        catalog_active_after=v_active_after,ownership_rows_after=v_ownership_after,completed_at=CURRENT_TIMESTAMP,
        notes=CONCAT('Complete. Disabled ',v_disabled_count,' non-preserved legacy definitions; inserted 29 canonical GTA SA savehouses; preserved ownership rows ',v_preserve_rows,'; mapped ownership rows ',v_mapped_rows,'. Public icon candidates=',v_public_candidates,', rendered=',v_public_rendered,', omitted_by_allocator=',v_public_omitted,'.')
    WHERE id=v_apply_session_id;

    COMMIT;

    SELECT v_apply_session_id apply_session_id,v_archive_session_id archive_session_id,v_source_tag source_tag,
           v_catalog_active_before active_before,v_disabled_count legacy_rows_disabled,v_inserted_count canonical_rows_inserted,
           v_preserve_rows preserve_legacy_rows,v_mapped_rows mapped_ownership_rows,v_active_after active_after,
           v_public_candidates public_icon_candidates,v_public_rendered public_icons_rendered,v_public_omitted public_icons_omitted_by_allocator,
           'COMPLETE' apply_status;
END//
DELIMITER ;
CALL saif_apply_gtasa29_savehouses_v026A1251();
DROP PROCEDURE IF EXISTS saif_apply_gtasa29_savehouses_v026A1251;
DROP PROCEDURE IF EXISTS saif_apply_gtasa29_savehouses_v026A125;
