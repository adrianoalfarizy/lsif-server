-- SAIF / LSIF Dev v0.25A.5.3
-- Skin Wardrobe Ownership
-- Adds DB-backed owned/purchased skin tracking.

CREATE TABLE IF NOT EXISTS player_skins (
    id INT NOT NULL AUTO_INCREMENT,
    player_id INT NOT NULL,
    skin_id SMALLINT NOT NULL,
    source_tag VARCHAR(32) NOT NULL DEFAULT 'purchase',
    acquired_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_equipped_at DATETIME NULL DEFAULT NULL,
    times_equipped INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    UNIQUE KEY uq_player_skin (player_id, skin_id),
    KEY idx_player_skins_player_id (player_id),
    KEY idx_player_skins_skin_id (skin_id),
    KEY idx_player_skins_source_tag (source_tag)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Backfill current equipped skin as owned wardrobe skin.
INSERT INTO player_skins (player_id, skin_id, source_tag, acquired_at, last_equipped_at, times_equipped)
SELECT id, COALESCE(skin, 0), 'current_skin_backfill', NOW(), NOW(), 1
FROM players
WHERE id IS NOT NULL
  AND COALESCE(skin, 0) BETWEEN 0 AND 311
ON DUPLICATE KEY UPDATE
    last_equipped_at = VALUES(last_equipped_at),
    times_equipped = GREATEST(times_equipped, 1);

-- Guard invalid skin ids if any manual row existed before this migration.
DELETE FROM player_skins
WHERE skin_id < 0 OR skin_id > 311;
