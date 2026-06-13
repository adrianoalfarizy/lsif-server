-- SAIF / LSIF Dev v0.26A.1.10.3
-- HOTFIX: binary-safe confirmation and archive checksum comparisons
-- APPLY: all 91 unique GTA SA public interiors.
-- Includes 71 SCM-exact service points + 20 overlay service anchors.
-- Two duplicate Pizza Stack plans remain blocked.
-- REQUIRED SESSION VARIABLE:
--   @saif_confirm = 'APPLY_91_OFFLINE_PUBLIC_INTERIORS'
-- Running this file directly without the token aborts before mutation.

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_apply_full_public_interiors_v026A110;
DELIMITER //
CREATE PROCEDURE saif_apply_full_public_interiors_v026A110()
main: BEGIN
    DECLARE v_done INT DEFAULT 0;
    DECLARE v_confirm VARBINARY(96) DEFAULT X'';
    DECLARE v_archive_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_import_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_apply_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_runtime_total_before INT DEFAULT 0;
    DECLARE v_runtime_active_before INT DEFAULT 0;
    DECLARE v_runtime_active_after INT DEFAULT 0;
    DECLARE v_archive_meta_total INT DEFAULT 0;
    DECLARE v_archive_rows INT DEFAULT 0;
    DECLARE v_checksum_mismatch INT DEFAULT 0;
    DECLARE v_live_apply_count INT DEFAULT 0;
    DECLARE v_exact_plan_count INT DEFAULT 0;
    DECLARE v_overlay_plan_count INT DEFAULT 0;
    DECLARE v_blocked_count INT DEFAULT 0;
    DECLARE v_target_active_before INT DEFAULT 0;
    DECLARE v_projected_active INT DEFAULT 0;
    DECLARE v_disabled_count INT DEFAULT 0;
    DECLARE v_inserted_count INT DEFAULT 0;
    DECLARE v_exact_inserted INT DEFAULT 0;
    DECLARE v_overlay_inserted INT DEFAULT 0;
    DECLARE v_public_interior_id INT DEFAULT 0;
    DECLARE v_apply_key VARCHAR(96) DEFAULT '';
    DECLARE v_source_tag VARCHAR(96) DEFAULT '';

    DECLARE v_plan_id BIGINT UNSIGNED;
    DECLARE v_service_point_id BIGINT UNSIGNED;
    DECLARE v_runtime_type VARCHAR(32);
    DECLARE v_display_name VARCHAR(128);
    DECLARE v_resolution_method VARCHAR(48);
    DECLARE v_review_status VARCHAR(32);
    DECLARE v_requires_adjustment TINYINT;
    DECLARE v_exterior_x DOUBLE;
    DECLARE v_exterior_y DOUBLE;
    DECLARE v_exterior_z DOUBLE;
    DECLARE v_exterior_a DOUBLE;
    DECLARE v_exterior_spawn_x DOUBLE;
    DECLARE v_exterior_spawn_y DOUBLE;
    DECLARE v_exterior_spawn_z DOUBLE;
    DECLARE v_exterior_spawn_a DOUBLE;
    DECLARE v_interior_id INT;
    DECLARE v_interior_x DOUBLE;
    DECLARE v_interior_y DOUBLE;
    DECLARE v_interior_z DOUBLE;
    DECLARE v_interior_a DOUBLE;
    DECLARE v_exit_x DOUBLE;
    DECLARE v_exit_y DOUBLE;
    DECLARE v_exit_z DOUBLE;
    DECLARE v_exit_a DOUBLE;
    DECLARE v_service_x DOUBLE;
    DECLARE v_service_y DOUBLE;
    DECLARE v_service_z DOUBLE;
    DECLARE v_service_a DOUBLE;
    DECLARE v_service_radius DOUBLE;

    DECLARE cur_all CURSOR FOR
        SELECT
            p.id,
            sp.id,
            p.runtime_type,
            p.display_name,
            sp.resolution_method,
            sp.review_status,
            IF(sp.resolution_method='saif_overlay_translated',1,0),
            p.exterior_x,
            p.exterior_y,
            p.exterior_z,
            p.exterior_a,
            p.exterior_spawn_x,
            p.exterior_spawn_y,
            p.exterior_spawn_z,
            p.exterior_spawn_a,
            p.interior_id,
            p.interior_x,
            p.interior_y,
            p.interior_z,
            p.interior_a,
            p.exit_x,
            p.exit_y,
            p.exit_z,
            p.exit_a,
            sp.service_x,
            sp.service_y,
            sp.service_z,
            sp.service_a,
            sp.service_radius
        FROM offline_interior_apply_plan p
        INNER JOIN offline_interior_service_points sp ON sp.id=p.service_point_id
        WHERE p.session_id=v_import_session_id
          AND p.plan_version='saif_enex_pair_planner_v0.26A.1.7'
          AND p.plan_status='pair_ready'
          AND p.apply_status='draft'
          AND sp.resolver_version='saif_service_point_resolver_v0.26A.1.8'
          AND sp.apply_status='draft'
          AND (
                (p.apply_readiness='dry_run_ready'
                 AND sp.resolution_method='scm_exact'
                 AND sp.review_status='approved_exact')
             OR (p.apply_readiness='service_overlay_review'
                 AND sp.resolution_method='saif_overlay_translated'
                 AND sp.review_status='preview_required')
          )
        ORDER BY p.runtime_type,p.area_code,p.id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done=1;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET v_confirm=BINARY COALESCE(@saif_confirm,'');
    IF v_confirm <> _binary'APPLY_91_OFFLINE_PUBLIC_INTERIORS' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation token missing. Required: APPLY_91_OFFLINE_PUBLIC_INTERIORS';
    END IF;

    SELECT COALESCE(MAX(id),0)
      INTO v_archive_session_id
    FROM offline_runtime_archive_sessions
    WHERE archive_scope='public_interiors'
      AND archive_status='complete';

    IF v_archive_session_id=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No complete public_interiors archive found. Capture a fresh archive first.';
    END IF;

    SELECT COALESCE(MAX(session_id),0)
      INTO v_import_session_id
    FROM offline_interior_apply_plan
    WHERE plan_version='saif_enex_pair_planner_v0.26A.1.7';

    IF v_import_session_id=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='ENEX apply plan session not found.';
    END IF;

    SELECT COUNT(*) INTO v_live_apply_count
    FROM offline_runtime_apply_sessions
    WHERE apply_scope IN ('public_interiors_offline_91','public_interiors_exact_71')
      AND apply_status='complete'
      AND rolled_back_at IS NULL;

    IF v_live_apply_count>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='A completed public interior offline apply is already live. Roll it back before applying again.';
    END IF;

    SELECT COUNT(*),COALESCE(SUM(enabled=1),0)
      INTO v_runtime_total_before,v_runtime_active_before
    FROM public_interiors;

    SELECT runtime_rows_total,archived_rows
      INTO v_archive_meta_total,v_archive_rows
    FROM offline_runtime_archive_sessions
    WHERE id=v_archive_session_id;

    IF v_archive_meta_total<>v_runtime_total_before OR v_archive_rows<>v_runtime_total_before THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Archive row count no longer matches runtime. Capture a fresh archive before apply.';
    END IF;

    SELECT COUNT(*) INTO v_checksum_mismatch
    FROM offline_public_interiors_archive a
    LEFT JOIN public_interiors p ON p.id=a.original_id
    WHERE a.archive_session_id=v_archive_session_id
      AND (
          p.id IS NULL OR
          BINARY a.row_checksum<>BINARY SHA2(CONCAT_WS('|',
              p.id,COALESCE(p.interior_type,''),COALESCE(p.display_name,''),
              COALESCE(p.exterior_x,0),COALESCE(p.exterior_y,0),COALESCE(p.exterior_z,0),COALESCE(p.exterior_a,0),
              COALESCE(p.exterior_spawn_x,0),COALESCE(p.exterior_spawn_y,0),COALESCE(p.exterior_spawn_z,0),COALESCE(p.exterior_spawn_a,0),
              COALESCE(p.exterior_pickup_model,0),COALESCE(p.interior_pickup_model,0),COALESCE(p.exterior_map_icon,0),
              COALESCE(p.exterior_interior,0),COALESCE(p.exterior_virtual_world,0),COALESCE(p.interior_id,0),COALESCE(p.interior_virtual_world,0),
              COALESCE(p.interior_x,0),COALESCE(p.interior_y,0),COALESCE(p.interior_z,0),COALESCE(p.interior_a,0),
              COALESCE(p.exit_x,0),COALESCE(p.exit_y,0),COALESCE(p.exit_z,0),COALESCE(p.exit_a,0),
              COALESCE(p.service_x,0),COALESCE(p.service_y,0),COALESCE(p.service_z,0),COALESCE(p.service_a,0),COALESCE(p.service_radius,0),
              COALESCE(p.source_tag,''),COALESCE(p.enabled,0)
          ),256)
      );

    IF v_checksum_mismatch<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Runtime public_interiors changed after archive capture. Capture a fresh archive before apply.';
    END IF;

    SELECT COUNT(*) INTO v_exact_plan_count
    FROM offline_interior_apply_plan p
    INNER JOIN offline_interior_service_points sp ON sp.id=p.service_point_id
    WHERE p.session_id=v_import_session_id
      AND p.plan_version='saif_enex_pair_planner_v0.26A.1.7'
      AND p.apply_readiness='dry_run_ready'
      AND p.plan_status='pair_ready'
      AND p.apply_status='draft'
      AND sp.resolver_version='saif_service_point_resolver_v0.26A.1.8'
      AND sp.resolution_method='scm_exact'
      AND sp.review_status='approved_exact'
      AND sp.apply_status='draft';

    SELECT COUNT(*) INTO v_overlay_plan_count
    FROM offline_interior_apply_plan p
    INNER JOIN offline_interior_service_points sp ON sp.id=p.service_point_id
    WHERE p.session_id=v_import_session_id
      AND p.plan_version='saif_enex_pair_planner_v0.26A.1.7'
      AND p.apply_readiness='service_overlay_review'
      AND p.plan_status='pair_ready'
      AND p.apply_status='draft'
      AND sp.resolver_version='saif_service_point_resolver_v0.26A.1.8'
      AND sp.resolution_method='saif_overlay_translated'
      AND sp.review_status='preview_required'
      AND sp.apply_status='draft';

    SELECT COUNT(*) INTO v_blocked_count
    FROM offline_interior_apply_plan
    WHERE session_id=v_import_session_id
      AND plan_version='saif_enex_pair_planner_v0.26A.1.7'
      AND apply_readiness='blocked_duplicate';

    IF v_exact_plan_count<>71 OR v_overlay_plan_count<>20 OR v_blocked_count<>2 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Planner gate mismatch. Expected exact=71, overlay=20, blocked=2.';
    END IF;

    SELECT COUNT(*) INTO v_target_active_before
    FROM public_interiors
    WHERE enabled=1
      AND interior_type IN ('ammunation','247','burgershot','cluckinbell','pizzastack','barber','tattoo','clothing','gym','police');

    SET v_projected_active=v_runtime_active_before-v_target_active_before+v_exact_plan_count+v_overlay_plan_count;
    IF v_projected_active>128 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Projected active public interiors exceed compiled capacity 128.';
    END IF;

    START TRANSACTION;

    SET v_apply_key=CONCAT('pubint_offline91_',DATE_FORMAT(NOW(6),'%Y%m%d%H%i%s%f'));

    INSERT INTO offline_runtime_apply_sessions
    (
        apply_key,apply_scope,apply_label,archive_session_id,import_session_id,
        plan_version,resolver_version,source_tag,apply_status,
        runtime_active_before,blocked_rows_skipped,notes
    )
    VALUES
    (
        v_apply_key,'public_interiors_offline_91','GTA SA public interiors: 71 SCM exact + 20 overlay anchors',
        v_archive_session_id,v_import_session_id,
        'saif_enex_pair_planner_v0.26A.1.7','saif_service_point_resolver_v0.26A.1.8','',
        'applying',v_runtime_active_before,v_blocked_count,
        'All 91 unique rows are applied. Overlay rows remain flagged for manual service-point adjustment.'
    );

    SET v_apply_session_id=LAST_INSERT_ID();
    SET v_source_tag=CONCAT('offline_gtasa_pubint91_a',v_apply_session_id);

    UPDATE offline_runtime_apply_sessions
    SET source_tag=v_source_tag
    WHERE id=v_apply_session_id;

    INSERT INTO offline_public_interior_disabled_rows
    (
        apply_session_id,public_interior_id,interior_type,previous_enabled,
        previous_source_tag,row_checksum
    )
    SELECT
        v_apply_session_id,p.id,COALESCE(p.interior_type,''),p.enabled,
        COALESCE(p.source_tag,''),
        SHA2(CONCAT_WS('|',p.id,COALESCE(p.interior_type,''),COALESCE(p.display_name,''),
            COALESCE(p.exterior_x,0),COALESCE(p.exterior_y,0),COALESCE(p.exterior_z,0),
            COALESCE(p.source_tag,''),COALESCE(p.enabled,0)),256)
    FROM public_interiors p
    WHERE p.enabled=1
      AND p.interior_type IN ('ammunation','247','burgershot','cluckinbell','pizzastack','barber','tattoo','clothing','gym','police');

    SET v_disabled_count=ROW_COUNT();

    UPDATE public_interiors p
    INNER JOIN offline_public_interior_disabled_rows d
        ON d.public_interior_id=p.id
       AND d.apply_session_id=v_apply_session_id
    SET p.enabled=0;

    SET v_done=0;
    OPEN cur_all;
    all_loop: LOOP
        FETCH cur_all INTO
            v_plan_id,v_service_point_id,v_runtime_type,v_display_name,
            v_resolution_method,v_review_status,v_requires_adjustment,
            v_exterior_x,v_exterior_y,v_exterior_z,v_exterior_a,
            v_exterior_spawn_x,v_exterior_spawn_y,v_exterior_spawn_z,v_exterior_spawn_a,
            v_interior_id,v_interior_x,v_interior_y,v_interior_z,v_interior_a,
            v_exit_x,v_exit_y,v_exit_z,v_exit_a,
            v_service_x,v_service_y,v_service_z,v_service_a,v_service_radius;

        IF v_done=1 THEN
            LEAVE all_loop;
        END IF;

        INSERT INTO public_interiors
        (
            interior_type,display_name,
            exterior_x,exterior_y,exterior_z,exterior_a,
            exterior_spawn_x,exterior_spawn_y,exterior_spawn_z,exterior_spawn_a,
            exterior_pickup_model,interior_pickup_model,exterior_map_icon,
            exterior_interior,exterior_virtual_world,
            interior_id,interior_virtual_world,
            interior_x,interior_y,interior_z,interior_a,
            exit_x,exit_y,exit_z,exit_a,
            service_x,service_y,service_z,service_a,service_radius,
            source_tag,enabled
        )
        VALUES
        (
            v_runtime_type,v_display_name,
            v_exterior_x,v_exterior_y,v_exterior_z,v_exterior_a,
            v_exterior_spawn_x,v_exterior_spawn_y,v_exterior_spawn_z,v_exterior_spawn_a,
            1318,1318,
            CASE v_runtime_type
                WHEN 'burgershot' THEN 10
                WHEN 'cluckinbell' THEN 14
                WHEN 'pizzastack' THEN 29
                ELSE 0
            END,
            0,0,
            v_interior_id,0,
            v_interior_x,v_interior_y,v_interior_z,v_interior_a,
            v_exit_x,v_exit_y,v_exit_z,v_exit_a,
            v_service_x,v_service_y,v_service_z,v_service_a,v_service_radius,
            v_source_tag,1
        );

        SET v_public_interior_id=LAST_INSERT_ID();

        UPDATE public_interiors
        SET interior_virtual_world=43000+v_public_interior_id
        WHERE id=v_public_interior_id;

        INSERT INTO offline_public_interior_apply_rows
        (
            apply_session_id,plan_id,service_point_id,public_interior_id,
            runtime_type,display_name,resolution_method,review_status,
            requires_manual_adjustment,source_tag,row_checksum
        )
        VALUES
        (
            v_apply_session_id,v_plan_id,v_service_point_id,v_public_interior_id,
            v_runtime_type,v_display_name,v_resolution_method,v_review_status,
            v_requires_adjustment,v_source_tag,
            SHA2(CONCAT_WS('|',v_public_interior_id,v_plan_id,v_service_point_id,
                v_runtime_type,v_display_name,v_resolution_method,v_requires_adjustment,v_source_tag),256)
        );

        SET v_inserted_count=v_inserted_count+1;
        IF v_resolution_method='scm_exact' THEN
            SET v_exact_inserted=v_exact_inserted+1;
        ELSEIF v_resolution_method='saif_overlay_translated' THEN
            SET v_overlay_inserted=v_overlay_inserted+1;
        END IF;
    END LOOP;
    CLOSE cur_all;

    IF v_inserted_count<>91 OR v_exact_inserted<>71 OR v_overlay_inserted<>20 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Inserted row count mismatch; transaction rolled back.';
    END IF;

    UPDATE offline_interior_apply_plan p
    INNER JOIN offline_public_interior_apply_rows r
        ON r.plan_id=p.id
       AND r.apply_session_id=v_apply_session_id
    SET p.apply_status='applied';

    UPDATE offline_interior_service_points sp
    INNER JOIN offline_public_interior_apply_rows r
        ON r.service_point_id=sp.id
       AND r.apply_session_id=v_apply_session_id
    SET sp.apply_status='applied';

    SELECT COALESCE(SUM(enabled=1),0) INTO v_runtime_active_after
    FROM public_interiors;

    IF v_runtime_active_after<>v_projected_active THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Runtime active count differs from projection; transaction rolled back.';
    END IF;

    UPDATE offline_runtime_apply_sessions
    SET apply_status='complete',
        old_rows_disabled=v_disabled_count,
        new_rows_inserted=v_inserted_count,
        exact_rows_inserted=v_exact_inserted,
        overlay_rows_inserted=v_overlay_inserted,
        manual_adjustment_rows=v_overlay_inserted,
        runtime_active_after=v_runtime_active_after,
        completed_at=CURRENT_TIMESTAMP,
        notes=CONCAT('Complete. Disabled ',v_disabled_count,
                     ' existing target-family rows; inserted 71 SCM exact + 20 overlay rows. ',
                     'The 20 overlays are active and flagged for Owner adjustment.')
    WHERE id=v_apply_session_id;

    COMMIT;

    SELECT
        v_apply_session_id AS apply_session_id,
        v_archive_session_id AS archive_session_id,
        v_source_tag AS source_tag,
        v_runtime_active_before AS runtime_active_before,
        v_disabled_count AS old_rows_disabled,
        v_exact_inserted AS scm_exact_rows_inserted,
        v_overlay_inserted AS overlay_rows_inserted,
        v_blocked_count AS duplicate_rows_skipped,
        v_runtime_active_after AS runtime_active_after,
        'COMPLETE' AS apply_status;

    SELECT
        r.public_interior_id,
        r.runtime_type,
        r.display_name,
        p.interior_id,
        sp.service_x,sp.service_y,sp.service_z,sp.service_a,sp.service_radius,
        CONCAT('/pubintpoints ',r.public_interior_id) AS editor_command
    FROM offline_public_interior_apply_rows r
    INNER JOIN offline_interior_apply_plan p ON p.id=r.plan_id
    INNER JOIN offline_interior_service_points sp ON sp.id=r.service_point_id
    WHERE r.apply_session_id=v_apply_session_id
      AND r.requires_manual_adjustment=1
    ORDER BY r.runtime_type,r.display_name,r.public_interior_id;
END//
DELIMITER ;

CALL saif_apply_full_public_interiors_v026A110();
DROP PROCEDURE IF EXISTS saif_apply_full_public_interiors_v026A110;
