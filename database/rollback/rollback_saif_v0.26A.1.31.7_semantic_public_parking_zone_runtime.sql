-- SAIF / LSIF v0.26A.1.31.7
-- Roll back latest complete semantic public parking apply.
-- Required: SET @saif_confirm='ROLLBACK_SEMANTIC_PUBLIC_PARKING';
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_rollback_semantic_public_parking_v026A1317;
DELIMITER //
CREATE PROCEDURE saif_rollback_semantic_public_parking_v026A1317()
BEGIN
    DECLARE v_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_previous_policy TINYINT DEFAULT 0;
    DECLARE v_previous_nearest TINYINT DEFAULT 0;
    DECLARE v_restored INT UNSIGNED DEFAULT 0;
    DECLARE v_removed_slots INT UNSIGNED DEFAULT 0;
    DECLARE v_removed_zones INT UNSIGNED DEFAULT 0;
    DECLARE v_preserved_curated_zones INT UNSIGNED DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF COALESCE(@saif_confirm,'') <> 'ROLLBACK_SEMANTIC_PUBLIC_PARKING' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation token missing: ROLLBACK_SEMANTIC_PUBLIC_PARKING';
    END IF;

    SELECT MAX(id) INTO v_session_id
    FROM semantic_parking_apply_sessions
    WHERE apply_version='v0.26A.1.31.7' AND apply_status='complete';

    IF v_session_id IS NULL OR v_session_id=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No complete v0.26A.1.31.7 apply session found';
    END IF;

    SELECT previous_policy_enabled,previous_nearest_spawn_enabled
    INTO v_previous_policy,v_previous_nearest
    FROM semantic_parking_apply_sessions WHERE id=v_session_id;

    START TRANSACTION;

    -- Remove only slots generated directly by the controlled apply. Slots created
    -- later through /parkingslotadd use the manual source tag and are preserved.
    DELETE FROM public_parking_slots
    WHERE source_tag='saif_semantic_public_parking_v0.26A.1.31.7';
    SET v_removed_slots=ROW_COUNT();

    -- Preserve facility zones that an admin has curated (approved) or that own
    -- manual slots. Unreviewed candidate zones and untouched legacy conversions
    -- can be removed safely.
    DELETE z
    FROM public_parking_zones z
    LEFT JOIN public_parking_slots s
      ON s.zone_id=z.id
     AND s.source_tag='saif_semantic_public_parking_manual_v0.26A.1.31.7'
    WHERE z.source_tag='saif_semantic_public_parking_v0.26A.1.31.7'
      AND s.id IS NULL
      AND (z.review_status='candidate' OR z.facility_type='legacy_admin_custom');
    SET v_removed_zones=ROW_COUNT();

    SELECT COUNT(*) INTO v_preserved_curated_zones
    FROM public_parking_zones
    WHERE source_tag='saif_semantic_public_parking_v0.26A.1.31.7';

    UPDATE vehicle_spawn_points vsp
    INNER JOIN semantic_parking_legacy_point_archive a
      ON a.vehicle_spawn_point_id=vsp.id AND a.apply_session_id=v_session_id
    SET vsp.enabled=a.previous_enabled;
    SET v_restored=ROW_COUNT();

    UPDATE public_parking_policy
    SET enabled=v_previous_policy
    WHERE id=1;

    UPDATE vehicle_storage_policy
    SET nearest_spawn_enabled=v_previous_nearest
    WHERE id=1;

    UPDATE semantic_parking_apply_sessions
    SET apply_status='rolled_back',rolled_back_at=NOW()
    WHERE id=v_session_id;

    COMMIT;

    SELECT 'ROLLBACK_GATE' section,v_session_id apply_session_id,
           v_restored restored_legacy_point_rows,
           v_removed_slots removed_apply_generated_slots,
           v_removed_zones removed_uncurated_apply_zones,
           v_preserved_curated_zones preserved_curated_zones_informational,
           (SELECT COUNT(*) FROM public_parking_slots WHERE source_tag='saif_semantic_public_parking_v0.26A.1.31.7') generated_slots_should_be_zero,
           (SELECT apply_status FROM semantic_parking_apply_sessions WHERE id=v_session_id) status_expected_rolled_back;
END//
DELIMITER ;
CALL saif_rollback_semantic_public_parking_v026A1317();
DROP PROCEDURE IF EXISTS saif_rollback_semantic_public_parking_v026A1317;
