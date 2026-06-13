-- SAIF / LSIF Dev v0.26A.1.20
-- APPLY exactly 89 GTA SA baseline world pickups: 49 police bribe + 40 body armour.
-- REQUIRED: SET @saif_confirm='APPLY_89_OFFLINE_WORLD_PICKUPS';
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_apply_baseline89_world_pickups_v026A120;
DELIMITER //
CREATE PROCEDURE saif_apply_baseline89_world_pickups_v026A120()
main: BEGIN
    DECLARE v_done INT DEFAULT 0;
    DECLARE v_confirm VARBINARY(96) DEFAULT X'';
    DECLARE v_archive_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_resolver_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_apply_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_runtime_total_before INT DEFAULT 0;
    DECLARE v_runtime_active_before INT DEFAULT 0;
    DECLARE v_runtime_active_after INT DEFAULT 0;
    DECLARE v_archive_meta_total INT DEFAULT 0;
    DECLARE v_archive_meta_active INT DEFAULT 0;
    DECLARE v_archive_target INT DEFAULT 0;
    DECLARE v_archive_rows INT DEFAULT 0;
    DECLARE v_checksum_mismatch INT DEFAULT 0;
    DECLARE v_archive_missing INT DEFAULT 0;
    DECLARE v_runtime_missing INT DEFAULT 0;
    DECLARE v_live_apply_count INT DEFAULT 0;
    DECLARE v_orphan_import_count INT DEFAULT 0;
    DECLARE v_total_plan_count INT DEFAULT 0;
    DECLARE v_baseline_plan_count INT DEFAULT 0;
    DECLARE v_bribe_plan_count INT DEFAULT 0;
    DECLARE v_armor_plan_count INT DEFAULT 0;
    DECLARE v_deferred_plan_count INT DEFAULT 0;
    DECLARE v_blocked_plan_count INT DEFAULT 0;
    DECLARE v_invalid_selected_count INT DEFAULT 0;
    DECLARE v_internal_duplicate_count INT DEFAULT 0;
    DECLARE v_disabled_count INT DEFAULT 0;
    DECLARE v_inserted_count INT DEFAULT 0;
    DECLARE v_bribe_inserted INT DEFAULT 0;
    DECLARE v_armor_inserted INT DEFAULT 0;
    DECLARE v_world_pickup_id INT DEFAULT 0;
    DECLARE v_apply_key VARCHAR(96) DEFAULT '';
    DECLARE v_source_tag VARCHAR(96) DEFAULT '';
    DECLARE v_display_name VARCHAR(128) DEFAULT '';

    DECLARE v_plan_id BIGINT UNSIGNED;
    DECLARE v_queue_id BIGINT UNSIGNED;
    DECLARE v_category VARCHAR(48);
    DECLARE v_pickup_type VARCHAR(32);
    DECLARE v_model_id INT;
    DECLARE v_amount INT;
    DECLARE v_cooldown INT;
    DECLARE v_interior INT;
    DECLARE v_virtual_world INT;
    DECLARE v_pos_x DOUBLE;
    DECLARE v_pos_y DOUBLE;
    DECLARE v_pos_z DOUBLE;

    DECLARE cur_selected CURSOR FOR
        SELECT p.id,p.queue_id,p.canonical_category,p.canonical_pickup_type,
               p.canonical_model_id,p.canonical_amount,p.canonical_cooldown_seconds,
               p.recommended_interior,p.recommended_virtual_world,
               q.pos_x,q.pos_y,q.pos_z+p.runtime_z_lift
        FROM offline_pickup_canonical_plan p
        INNER JOIN offline_pickup_queue q ON q.id=p.queue_id
        WHERE p.resolver_session_id=v_resolver_session_id
          AND p.resolver_version='saif-pickup-resolver-v0.26A.1.18'
          AND p.decision_code='baseline_ready'
          AND p.apply_status='draft'
          AND p.enabled=0
        ORDER BY p.canonical_category,q.city_region,q.area_code,p.id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done=1;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET v_confirm=BINARY COALESCE(@saif_confirm,'');
    IF v_confirm<>_binary'APPLY_89_OFFLINE_WORLD_PICKUPS' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation token missing. Required: APPLY_89_OFFLINE_WORLD_PICKUPS';
    END IF;

    SELECT COALESCE(MAX(id),0) INTO v_archive_session_id
    FROM offline_runtime_archive_sessions
    WHERE archive_scope='world_pickups';
    IF v_archive_session_id=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No world_pickups archive found. Capture a fresh archive first.';
    END IF;

    SELECT runtime_rows_total,active_rows_total,target_rows_total,archived_rows
      INTO v_archive_meta_total,v_archive_meta_active,v_archive_target,v_archive_rows
    FROM offline_runtime_archive_sessions
    WHERE id=v_archive_session_id AND archive_status='complete';
    IF v_archive_rows<>v_archive_meta_total OR v_archive_target<>89 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Latest world_pickups archive is not a complete Baseline-89 archive.';
    END IF;

    SELECT COALESCE(MAX(id),0) INTO v_resolver_session_id
    FROM offline_pickup_resolver_sessions
    WHERE BINARY resolver_version=BINARY 'saif-pickup-resolver-v0.26A.1.18'
      AND resolver_status='complete';
    IF v_resolver_session_id=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Pickup canonical resolver session v0.26A.1.18 not found or incomplete.';
    END IF;

    SELECT COUNT(*) INTO v_live_apply_count
    FROM offline_runtime_apply_sessions
    WHERE apply_scope='world_pickups_offline_baseline89'
      AND apply_status='complete' AND rolled_back_at IS NULL;
    IF v_live_apply_count>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='A completed Baseline-89 world pickup apply is already live. Roll it back before applying again.';
    END IF;

    SELECT COUNT(*) INTO v_orphan_import_count
    FROM world_pickups
    WHERE enabled=1 AND source_tag LIKE 'offline_gtasa_pickup89_a%';
    IF v_orphan_import_count>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Active Baseline-89 source-tag rows exist without a live tracked apply.';
    END IF;

    SELECT COUNT(*),COALESCE(SUM(enabled=1),0)
      INTO v_runtime_total_before,v_runtime_active_before
    FROM world_pickups;
    IF v_runtime_total_before<>v_archive_meta_total OR v_runtime_active_before<>v_archive_meta_active THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Runtime world_pickups count/state changed after archive capture. Capture a fresh archive.';
    END IF;

    SELECT COUNT(*) INTO v_archive_missing
    FROM offline_world_pickups_archive a
    LEFT JOIN world_pickups w ON w.id=a.original_id
    WHERE a.archive_session_id=v_archive_session_id AND w.id IS NULL;

    SELECT COUNT(*) INTO v_runtime_missing
    FROM world_pickups w
    LEFT JOIN offline_world_pickups_archive a
      ON a.archive_session_id=v_archive_session_id AND a.original_id=w.id
    WHERE a.original_id IS NULL;

    SELECT COUNT(*) INTO v_checksum_mismatch
    FROM offline_world_pickups_archive a
    JOIN world_pickups w ON w.id=a.original_id
    WHERE a.archive_session_id=v_archive_session_id
      AND BINARY a.row_checksum<>BINARY SHA2(CONCAT_WS('|',w.id,COALESCE(w.pickup_type,''),COALESCE(w.display_name,''),COALESCE(w.model_id,0),COALESCE(w.pos_x,0),COALESCE(w.pos_y,0),COALESCE(w.pos_z,0),COALESCE(w.interior,0),COALESCE(w.virtual_world,0),COALESCE(w.amount,0),COALESCE(w.cooldown_seconds,60),COALESCE(w.source_tag,''),COALESCE(w.enabled,0)),256);
    IF v_archive_missing<>0 OR v_runtime_missing<>0 OR v_checksum_mismatch<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Runtime world_pickups no longer matches archive checksum/linkage. Capture a fresh archive.';
    END IF;

    SELECT COUNT(*),
           COALESCE(SUM(p.decision_code='baseline_ready' AND p.apply_status='draft'),0),
           COALESCE(SUM(p.decision_code='baseline_ready' AND p.canonical_category='bribe' AND p.apply_status='draft'),0),
           COALESCE(SUM(p.decision_code='baseline_ready' AND p.canonical_category='armor' AND p.apply_status='draft'),0),
           COALESCE(SUM(p.safety_class='deferred'),0),
           COALESCE(SUM(p.safety_class='blocked'),0)
      INTO v_total_plan_count,v_baseline_plan_count,v_bribe_plan_count,v_armor_plan_count,v_deferred_plan_count,v_blocked_plan_count
    FROM offline_pickup_canonical_plan p
    WHERE p.resolver_session_id=v_resolver_session_id
      AND p.resolver_version='saif-pickup-resolver-v0.26A.1.18';

    IF v_total_plan_count<>782 OR v_baseline_plan_count<>89 OR v_bribe_plan_count<>49 OR v_armor_plan_count<>40
       OR v_deferred_plan_count<>649 OR v_blocked_plan_count<>44 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Pickup planner gate mismatch. Expected total=782, baseline=89, bribe=49, armor=40, deferred=649, blocked=44.';
    END IF;

    SELECT COUNT(*) INTO v_invalid_selected_count
    FROM offline_pickup_canonical_plan p
    JOIN offline_pickup_queue q ON q.id=p.queue_id
    WHERE p.resolver_session_id=v_resolver_session_id
      AND p.resolver_version='saif-pickup-resolver-v0.26A.1.18'
      AND p.decision_code='baseline_ready'
      AND (p.apply_status<>'draft' OR p.enabled<>0 OR p.review_status<>'ready'
           OR p.runtime_target<>'world_pickups' OR q.script_name<>'INITIAL'
           OR p.recommended_interior<>0 OR p.recommended_virtual_world<>0
           OR (ABS(q.pos_x)<0.001 AND ABS(q.pos_y)<0.001 AND ABS(q.pos_z)<0.001)
           OR ABS(p.runtime_z_lift-0.25)>0.001
           OR (p.canonical_category='bribe' AND (p.canonical_model_id<>1247 OR p.canonical_pickup_type<>'bribe' OR p.canonical_amount<>1 OR p.canonical_cooldown_seconds<>180))
           OR (p.canonical_category='armor' AND (p.canonical_model_id<>1242 OR p.canonical_pickup_type<>'armor' OR p.canonical_amount<>100 OR p.canonical_cooldown_seconds<>240))
           OR p.canonical_category NOT IN ('bribe','armor'));
    IF v_invalid_selected_count<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Selected Baseline-89 plan contains invalid/unresolved payload or transform rows.';
    END IF;

    SELECT COUNT(*) INTO v_internal_duplicate_count
    FROM offline_pickup_canonical_plan p1
    JOIN offline_pickup_queue q1 ON q1.id=p1.queue_id
    JOIN offline_pickup_canonical_plan p2
      ON p2.id>p1.id AND p2.resolver_session_id=p1.resolver_session_id
     AND p2.decision_code='baseline_ready'
    JOIN offline_pickup_queue q2 ON q2.id=p2.queue_id
    WHERE p1.resolver_session_id=v_resolver_session_id
      AND p1.decision_code='baseline_ready'
      AND POW(q1.pos_x-q2.pos_x,2)+POW(q1.pos_y-q2.pos_y,2)
          +POW((q1.pos_z+p1.runtime_z_lift)-(q2.pos_z+p2.runtime_z_lift),2)<=0.25;
    IF v_internal_duplicate_count<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Baseline-89 contains internal duplicate transforms within 0.50m.';
    END IF;

    IF 89>300 OR 89>700 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Projected active world pickups exceed loader or compiled capacity.';
    END IF;

    START TRANSACTION;

    SET v_apply_key=CONCAT('worldpickup_offline89_',DATE_FORMAT(NOW(6),'%Y%m%d%H%i%s%f'));
    INSERT INTO offline_runtime_apply_sessions
    (apply_key,apply_scope,apply_label,archive_session_id,import_session_id,plan_version,resolver_version,
     source_tag,apply_status,runtime_active_before,blocked_rows_skipped,deferred_rows_skipped,notes)
    VALUES
    (v_apply_key,'world_pickups_offline_baseline89','GTA SA world pickups: 49 police bribe + 40 body armour',
     v_archive_session_id,v_resolver_session_id,'saif-pickup-canonical-plan-v0.26A.1.18',
     'saif-pickup-resolver-v0.26A.1.18','',
     'applying',v_runtime_active_before,v_blocked_plan_count,v_deferred_plan_count,
     'Canonical replacement: disable every active previous world pickup and insert exactly 89 INITIAL world pickups.');

    SET v_apply_session_id=LAST_INSERT_ID();
    SET v_source_tag=CONCAT('offline_gtasa_pickup89_a',v_apply_session_id);
    UPDATE offline_runtime_apply_sessions SET source_tag=v_source_tag WHERE id=v_apply_session_id;

    INSERT INTO offline_world_pickup_disabled_rows
    (apply_session_id,world_pickup_id,previous_enabled,previous_source_tag,row_checksum)
    SELECT v_apply_session_id,w.id,w.enabled,COALESCE(w.source_tag,''),
           SHA2(CONCAT_WS('|',w.id,COALESCE(w.pickup_type,''),COALESCE(w.display_name,''),COALESCE(w.model_id,0),
               COALESCE(w.pos_x,0),COALESCE(w.pos_y,0),COALESCE(w.pos_z,0),COALESCE(w.interior,0),
               COALESCE(w.virtual_world,0),COALESCE(w.amount,0),COALESCE(w.cooldown_seconds,60),
               COALESCE(w.source_tag,''),COALESCE(w.enabled,0)),256)
    FROM world_pickups w WHERE w.enabled=1;
    SET v_disabled_count=ROW_COUNT();

    IF v_disabled_count<>v_runtime_active_before THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Disabled-old mapping count differs from active runtime count.';
    END IF;

    UPDATE world_pickups w
    JOIN offline_world_pickup_disabled_rows d
      ON d.world_pickup_id=w.id AND d.apply_session_id=v_apply_session_id
    SET w.enabled=0;

    SET v_done=0;
    OPEN cur_selected;
    selected_loop: LOOP
        FETCH cur_selected INTO v_plan_id,v_queue_id,v_category,v_pickup_type,v_model_id,v_amount,
            v_cooldown,v_interior,v_virtual_world,v_pos_x,v_pos_y,v_pos_z;
        IF v_done=1 THEN LEAVE selected_loop; END IF;

        IF v_category='bribe' THEN
            SET v_display_name='GTA SA Police Bribe';
        ELSEIF v_category='armor' THEN
            SET v_display_name='GTA SA Body Armour';
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Unexpected canonical pickup category during cursor apply.';
        END IF;

        INSERT INTO world_pickups
        (pickup_type,display_name,model_id,pos_x,pos_y,pos_z,interior,virtual_world,amount,cooldown_seconds,source_tag,enabled)
        VALUES
        (v_pickup_type,v_display_name,v_model_id,v_pos_x,v_pos_y,v_pos_z,v_interior,v_virtual_world,
         v_amount,v_cooldown,v_source_tag,1);
        SET v_world_pickup_id=LAST_INSERT_ID();

        INSERT INTO offline_world_pickup_apply_rows
        (apply_session_id,plan_id,queue_id,world_pickup_id,canonical_category,pickup_type,model_id,source_tag,row_checksum)
        VALUES
        (v_apply_session_id,v_plan_id,v_queue_id,v_world_pickup_id,v_category,v_pickup_type,v_model_id,v_source_tag,
         SHA2(CONCAT_WS('|',v_world_pickup_id,v_pickup_type,v_display_name,v_model_id,v_pos_x,v_pos_y,v_pos_z,
             v_interior,v_virtual_world,v_amount,v_cooldown,v_source_tag,1),256));

        SET v_inserted_count=v_inserted_count+1;
        IF v_category='bribe' THEN
            SET v_bribe_inserted=v_bribe_inserted+1;
        ELSEIF v_category='armor' THEN
            SET v_armor_inserted=v_armor_inserted+1;
        END IF;
    END LOOP;
    CLOSE cur_selected;

    IF v_inserted_count<>89 OR v_bribe_inserted<>49 OR v_armor_inserted<>40 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Inserted world pickup count mismatch; transaction rolled back.';
    END IF;

    UPDATE offline_pickup_canonical_plan p
    JOIN offline_world_pickup_apply_rows r
      ON r.plan_id=p.id AND r.apply_session_id=v_apply_session_id
    SET p.apply_status='applied';

    UPDATE offline_pickup_queue q
    JOIN offline_world_pickup_apply_rows r
      ON r.queue_id=q.id AND r.apply_session_id=v_apply_session_id
    SET q.apply_status='applied';

    SELECT COALESCE(SUM(enabled=1),0) INTO v_runtime_active_after FROM world_pickups;
    IF v_runtime_active_after<>89 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Runtime active world pickup count differs from expected 89; transaction rolled back.';
    END IF;

    UPDATE offline_runtime_apply_sessions
    SET apply_status='complete',old_rows_disabled=v_disabled_count,new_rows_inserted=v_inserted_count,
        exact_rows_inserted=v_inserted_count,baseline_rows_inserted=v_inserted_count,
        bribe_rows_inserted=v_bribe_inserted,armor_rows_inserted=v_armor_inserted,
        runtime_active_after=v_runtime_active_after,completed_at=CURRENT_TIMESTAMP,
        notes=CONCAT('Complete. Disabled ',v_disabled_count,' previous active rows; inserted 49 police bribe + 40 body armour pickups.')
    WHERE id=v_apply_session_id;

    COMMIT;

    SELECT v_apply_session_id AS apply_session_id,v_archive_session_id AS archive_session_id,
           v_source_tag AS source_tag,v_runtime_active_before AS runtime_active_before,
           v_disabled_count AS old_rows_disabled,v_bribe_inserted AS bribe_rows_inserted,
           v_armor_inserted AS armor_rows_inserted,v_inserted_count AS total_rows_inserted,
           v_runtime_active_after AS runtime_active_after,'COMPLETE' AS apply_status;

    SELECT r.canonical_category,COUNT(*) AS inserted_rows
    FROM offline_world_pickup_apply_rows r
    WHERE r.apply_session_id=v_apply_session_id
    GROUP BY r.canonical_category;
END//
DELIMITER ;

CALL saif_apply_baseline89_world_pickups_v026A120();
DROP PROCEDURE IF EXISTS saif_apply_baseline89_world_pickups_v026A120;
