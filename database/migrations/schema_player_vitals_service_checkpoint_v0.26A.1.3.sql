-- SAIF / LSIF Dev v0.26A.1.3
-- Player Vitals Persistence & Service Checkpoint Restore
-- Scope: persist player health/armour, including Ammu-Nation Body Armor and public service/pickup effects.

ALTER TABLE players
    ADD COLUMN IF NOT EXISTS health FLOAT NOT NULL DEFAULT 100.0 AFTER wanted_level,
    ADD COLUMN IF NOT EXISTS armour FLOAT NOT NULL DEFAULT 0.0 AFTER health;

-- Normalize legacy/live rows after adding columns.
UPDATE players
SET health = 100.0
WHERE health < 1.0 OR health > 100.0;

UPDATE players
SET armour = 0.0
WHERE armour < 0.0 OR armour > 100.0;
