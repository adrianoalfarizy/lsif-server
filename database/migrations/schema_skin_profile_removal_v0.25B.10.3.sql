-- SAIF / LSIF Dev v0.25B.10.3
-- Skin Profile Removal Cleanup
-- Purpose: remove ineffective skin movement_profile / anim_profile DB fields.
-- Safe behavior: archive existing profile values first when the columns still exist.

CREATE TABLE IF NOT EXISTS skin_catalog_profile_archive_v0_25B_10_3 (
    id INT NULL,
    skin_id INT NULL,
    movement_profile VARCHAR(32) NULL,
    anim_profile VARCHAR(32) NULL,
    archived_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET @has_movement_profile := (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'skin_catalog'
      AND COLUMN_NAME = 'movement_profile'
);

SET @has_anim_profile := (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'skin_catalog'
      AND COLUMN_NAME = 'anim_profile'
);

SET @archive_sql := IF(
    @has_movement_profile = 1 AND @has_anim_profile = 1,
    'INSERT INTO skin_catalog_profile_archive_v0_25B_10_3 (id, skin_id, movement_profile, anim_profile, archived_at) SELECT id, skin_id, movement_profile, anim_profile, NOW() FROM skin_catalog',
    'SELECT ''skin profile archive skipped: columns already missing or partially removed'' AS info'
);
PREPARE stmt FROM @archive_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @drop_movement_sql := IF(
    @has_movement_profile = 1,
    'ALTER TABLE skin_catalog DROP COLUMN movement_profile',
    'SELECT ''movement_profile already removed'' AS info'
);
PREPARE stmt FROM @drop_movement_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @has_anim_profile_after_movement := (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'skin_catalog'
      AND COLUMN_NAME = 'anim_profile'
);

SET @drop_anim_sql := IF(
    @has_anim_profile_after_movement = 1,
    'ALTER TABLE skin_catalog DROP COLUMN anim_profile',
    'SELECT ''anim_profile already removed'' AS info'
);
PREPARE stmt FROM @drop_anim_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
