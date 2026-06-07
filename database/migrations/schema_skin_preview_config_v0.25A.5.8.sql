-- SAIF / LSIF Dev v0.25A.5.8
-- Skin Preview Duration Config
-- Adds DB-backed configurable skin preview duration.
-- Safe to append to database/schema.sql and safe to re-run.

INSERT INTO server_settings (setting_key, setting_value)
VALUES ('skin_preview_seconds', '8')
ON DUPLICATE KEY UPDATE
    setting_value = IF(CAST(setting_value AS SIGNED) BETWEEN 3 AND 20, setting_value, VALUES(setting_value)),
    updated_at = CURRENT_TIMESTAMP;
