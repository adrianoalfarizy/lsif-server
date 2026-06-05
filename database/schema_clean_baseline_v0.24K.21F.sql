-- SAIF / LSIF Dev v0.24K.21F - Clean Schema Baseline (STRUCTURE ONLY)
-- Generated from live DB structure dump audited at v0.24K.20.6, with safe index cleanup from v0.24K.21A reflected.
-- IMPORTANT:
--   * This file is intended as a clean repo baseline / fresh-install structure reference.
--   * Do NOT run this blindly against the live server database.
--   * For existing live DB, use maintenance scripts and backups.
--   * Seed/config data should live in a separate seed file, not mixed with structure migrations.

CREATE DATABASE IF NOT EXISTS `lsif_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `lsif_db`;

SET FOREIGN_KEY_CHECKS=0;

-- --------------------------------------------------------
-- Table structure for `admin_logs`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `admin_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `admin_name` varchar(24) NOT NULL,
  `target_id` int(11) DEFAULT NULL,
  `target_name` varchar(24) DEFAULT NULL,
  `action` varchar(64) NOT NULL,
  `detail` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `bans`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) DEFAULT NULL,
  `player_name` varchar(24) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `admin_name` varchar(24) NOT NULL,
  `reason` varchar(128) NOT NULL,
  `duration_minutes` int(11) NOT NULL DEFAULT 0,
  `expires_at` datetime DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `unbanned_by_id` int(11) DEFAULT NULL,
  `unbanned_by_name` varchar(24) DEFAULT NULL,
  `unbanned_at` datetime DEFAULT NULL,
  `unban_reason` varchar(128) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_player_name` (`player_name`),
  KEY `idx_ip_address` (`ip_address`),
  KEY `idx_active` (`active`),
  KEY `idx_expires_at` (`expires_at`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `beta_whitelist`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `beta_whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(24) NOT NULL,
  `added_by` varchar(24) NOT NULL DEFAULT 'SYSTEM',
  `note` varchar(128) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `idx_username` (`username`),
  KEY `idx_active` (`active`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `business_preset_config`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `business_preset_config` (
  `business_index` int(11) NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `x` float NOT NULL DEFAULT 0,
  `y` float NOT NULL DEFAULT 0,
  `z` float NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 10000,
  `income_per_minute` int(11) NOT NULL DEFAULT 50,
  `source_tag` varchar(64) NOT NULL DEFAULT 'full_sa_business_seed',
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`business_index`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `feedback_reports`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `feedback_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reporter_id` int(11) NOT NULL,
  `reporter_name` varchar(24) NOT NULL,
  `type` varchar(16) NOT NULL,
  `message` varchar(255) NOT NULL,
  `status` varchar(16) NOT NULL DEFAULT 'open',
  `handled_by_id` int(11) DEFAULT NULL,
  `handled_by_name` varchar(24) DEFAULT NULL,
  `close_note` varchar(128) DEFAULT NULL,
  `closed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_reporter_id` (`reporter_id`),
  KEY `idx_type` (`type`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `gang_hq_interiors`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `gang_hq_interiors` (
  `gang_id` int(11) NOT NULL,
  `gang_name` varchar(64) NOT NULL DEFAULT '',
  `interior_id` int(11) NOT NULL DEFAULT 0,
  `virtual_world` int(11) NOT NULL DEFAULT 0,
  `int_x` float NOT NULL DEFAULT 0,
  `int_y` float NOT NULL DEFAULT 0,
  `int_z` float NOT NULL DEFAULT 0,
  `int_a` float NOT NULL DEFAULT 0,
  `exit_x` float NOT NULL DEFAULT 0,
  `exit_y` float NOT NULL DEFAULT 0,
  `exit_z` float NOT NULL DEFAULT 0,
  `exit_a` float NOT NULL DEFAULT 0,
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `door_pickup_model` int(11) NOT NULL DEFAULT 1318,
  `door_x` float DEFAULT NULL,
  `door_y` float DEFAULT NULL,
  `door_z` float DEFAULT NULL,
  `door_a` float DEFAULT NULL,
  `int_exit_x` float DEFAULT NULL,
  `int_exit_y` float DEFAULT NULL,
  `int_exit_z` float DEFAULT NULL,
  `int_exit_a` float DEFAULT NULL,
  PRIMARY KEY (`gang_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `gang_member_stats`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `gang_member_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gang_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(24) NOT NULL,
  `respect` int(11) NOT NULL DEFAULT 0,
  `captures` int(11) NOT NULL DEFAULT 0,
  `defends` int(11) NOT NULL DEFAULT 0,
  `wars_participated` int(11) NOT NULL DEFAULT 0,
  `last_activity_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_gang_player` (`gang_id`,`player_id`),
  KEY `idx_gang_id` (`gang_id`),
  KEY `idx_player_id` (`player_id`),
  KEY `idx_respect` (`respect`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `gang_members`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `gang_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gang_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(24) NOT NULL,
  `rank_level` tinyint(4) NOT NULL DEFAULT 1,
  `joined_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `player_id` (`player_id`),
  KEY `idx_gang_id` (`gang_id`),
  KEY `idx_player_id` (`player_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `gang_preset_config`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `gang_preset_config` (
  `gang_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `short_name` varchar(24) NOT NULL DEFAULT '',
  `color` int(11) NOT NULL DEFAULT 0,
  `color_name` varchar(24) NOT NULL DEFAULT 'DB Custom',
  `hq_x` float NOT NULL DEFAULT 0,
  `hq_y` float NOT NULL DEFAULT 0,
  `hq_z` float NOT NULL DEFAULT 0,
  `hq_a` float NOT NULL DEFAULT 0,
  `hq_radius` float NOT NULL DEFAULT 8,
  `source_tag` varchar(32) NOT NULL DEFAULT 'offline_reference_manual',
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `hq_pickup_model` int(11) NOT NULL DEFAULT 1314,
  `hq_map_icon` int(11) NOT NULL DEFAULT 19,
  PRIMARY KEY (`gang_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `gang_territories`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `gang_territories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `territory_index` int(11) NOT NULL,
  `territory_name` varchar(64) NOT NULL,
  `owner_gang_id` int(11) NOT NULL DEFAULT 0,
  `owner_gang_name` varchar(64) NOT NULL DEFAULT 'Neutral',
  `owner_org_id` int(11) NOT NULL DEFAULT 0,
  `owner_org_name` varchar(64) NOT NULL DEFAULT 'Neutral',
  `owner_color` int(11) NOT NULL DEFAULT -1431655681,
  `center_x` float NOT NULL,
  `center_y` float NOT NULL,
  `center_z` float NOT NULL,
  `radius` float NOT NULL DEFAULT 100,
  `min_x` float NOT NULL DEFAULT 0,
  `min_y` float NOT NULL DEFAULT 0,
  `max_x` float NOT NULL DEFAULT 0,
  `max_y` float NOT NULL DEFAULT 0,
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `source_tag` varchar(64) NOT NULL DEFAULT 'manual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `territory_index` (`territory_index`),
  KEY `idx_owner_org_id` (`owner_org_id`),
  KEY `idx_territory_index` (`territory_index`),
  KEY `idx_owner_gang_id` (`owner_gang_id`),
  KEY `idx_gang_territories_enabled` (`enabled`),
  KEY `idx_gang_territories_source_tag` (`source_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `gang_weapon_logs`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `gang_weapon_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gang_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(24) NOT NULL,
  `action` varchar(24) NOT NULL,
  `weapon_id` int(11) NOT NULL,
  `weapon_name` varchar(32) NOT NULL,
  `ammo` int(11) NOT NULL DEFAULT 0,
  `cost` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_gang_id` (`gang_id`),
  KEY `idx_player_id` (`player_id`),
  KEY `idx_created_at` (`created_at`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `gang_weapon_stash`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `gang_weapon_stash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gang_id` int(11) NOT NULL,
  `weapon_id` int(11) NOT NULL,
  `weapon_name` varchar(32) NOT NULL,
  `ammo` int(11) NOT NULL DEFAULT 0,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_gang_weapon` (`gang_id`,`weapon_id`),
  KEY `idx_gang_id` (`gang_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `gangs`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `gangs` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `leader_id` int(11) NOT NULL DEFAULT 0,
  `leader_name` varchar(32) NOT NULL DEFAULT 'Server',
  `gang_color` int(11) NOT NULL DEFAULT 0,
  `bank_money` int(11) NOT NULL DEFAULT 0,
  `reputation` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `idx_leader_id` (`leader_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `job_stats`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `job_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `job_code` varchar(32) NOT NULL,
  `total_completed` int(11) NOT NULL DEFAULT 0,
  `total_earned` int(11) NOT NULL DEFAULT 0,
  `total_xp` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_player_job` (`player_id`,`job_code`),
  KEY `idx_job_code` (`job_code`),
  KEY `idx_total_earned` (`total_earned`),
  KEY `idx_total_completed` (`total_completed`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `organization_members`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `organization_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `org_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(24) NOT NULL,
  `rank_level` tinyint(4) NOT NULL DEFAULT 1,
  `joined_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `player_id` (`player_id`),
  KEY `idx_org_id` (`org_id`),
  KEY `idx_player_id` (`player_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `organizations`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `organizations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `owner_name` varchar(24) NOT NULL,
  `bank_money` int(11) NOT NULL DEFAULT 0,
  `gang_color` int(11) NOT NULL DEFAULT -1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `idx_owner_id` (`owner_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `parked_vehicle_import_queue`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `parked_vehicle_import_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `batch_name` varchar(64) NOT NULL DEFAULT 'offline_exact_ls',
  `source_tag` varchar(64) NOT NULL DEFAULT 'offline_exact_ls',
  `modelid` int(11) NOT NULL,
  `color1` int(11) NOT NULL DEFAULT 1,
  `color2` int(11) NOT NULL DEFAULT 1,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `pos_a` float NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0,
  `virtual_world` int(11) NOT NULL DEFAULT 0,
  `respawn_delay` int(11) NOT NULL DEFAULT 300,
  `locked` tinyint(4) NOT NULL DEFAULT 0,
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `note` varchar(128) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_parked_vehicle_import_queue_source_enabled` (`source_tag`,`enabled`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `parked_vehicles`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `parked_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modelid` int(11) NOT NULL,
  `color1` int(11) NOT NULL DEFAULT 1,
  `color2` int(11) NOT NULL DEFAULT 1,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `pos_a` float NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0,
  `virtual_world` int(11) NOT NULL DEFAULT 0,
  `respawn_delay` int(11) NOT NULL DEFAULT 300,
  `locked` tinyint(4) NOT NULL DEFAULT 0,
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `source_tag` varchar(64) NOT NULL DEFAULT 'manual',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_parked_enabled` (`enabled`),
  KEY `idx_parked_model` (`modelid`),
  KEY `idx_parked_source_tag` (`source_tag`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `player_businesses`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `player_businesses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) NOT NULL,
  `business_index` int(11) NOT NULL,
  `business_name` varchar(64) NOT NULL,
  `price` int(11) NOT NULL,
  `income_per_minute` int(11) NOT NULL,
  `business_level` int(11) NOT NULL DEFAULT 1,
  `total_collected` int(11) NOT NULL DEFAULT 0,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `last_collected` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `owner_id` (`owner_id`),
  KEY `idx_owner_id` (`owner_id`),
  KEY `idx_business_index` (`business_index`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `player_houses`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `player_houses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) NOT NULL,
  `house_index` int(11) NOT NULL,
  `house_name` varchar(64) NOT NULL,
  `price` int(11) NOT NULL,
  `locked` tinyint(4) NOT NULL DEFAULT 1,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `owner_id` (`owner_id`),
  KEY `idx_owner_id` (`owner_id`),
  KEY `idx_house_index` (`house_index`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `player_vehicles`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `player_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) NOT NULL,
  `slot` int(11) NOT NULL DEFAULT 1,
  `model_id` int(11) NOT NULL,
  `vehicle_name` varchar(32) NOT NULL DEFAULT 'Vehicle',
  `color1` int(11) NOT NULL DEFAULT 1,
  `color2` int(11) NOT NULL DEFAULT 1,
  `pos_x` float NOT NULL DEFAULT 1958.38,
  `pos_y` float NOT NULL DEFAULT 1343.16,
  `pos_z` float NOT NULL DEFAULT 15.3746,
  `pos_a` float NOT NULL DEFAULT 269.142,
  `health` float NOT NULL DEFAULT 1000,
  `fuel` int(11) NOT NULL DEFAULT 100,
  `locked` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_owner_slot` (`owner_id`,`slot`),
  KEY `idx_owner_id` (`owner_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `player_weapons`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `player_weapons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `weapon_id` int(11) NOT NULL,
  `weapon_name` varchar(32) NOT NULL,
  `ammo` int(11) NOT NULL DEFAULT 0,
  `total_purchased` int(11) NOT NULL DEFAULT 0,
  `last_purchased_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_player_weapon` (`player_id`,`weapon_id`),
  KEY `idx_player_id` (`player_id`),
  KEY `idx_weapon_id` (`weapon_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `players`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(24) NOT NULL,
  `password_hash` varchar(128) NOT NULL,
  `money` int(11) NOT NULL DEFAULT 500,
  `bank_money` int(11) NOT NULL DEFAULT 0,
  `xp` int(11) NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 1,
  `admin_level` tinyint(4) NOT NULL DEFAULT 0,
  `skin` int(11) NOT NULL DEFAULT 0,
  `current_job` tinyint(4) NOT NULL DEFAULT 0,
  `spawn_house` tinyint(4) NOT NULL DEFAULT 0,
  `starter_pack_claimed` tinyint(4) NOT NULL DEFAULT 0,
  `weapon_license` tinyint(4) NOT NULL DEFAULT 1,
  `pos_x` float NOT NULL DEFAULT 1958.38,
  `pos_y` float NOT NULL DEFAULT 1343.16,
  `pos_z` float NOT NULL DEFAULT 15.3746,
  `pos_a` float NOT NULL DEFAULT 269.142,
  `pos_interior` int(11) NOT NULL DEFAULT 0,
  `pos_virtual_world` int(11) NOT NULL DEFAULT 0,
  `last_ip` varchar(45) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `public_interior_import_queue`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `public_interior_import_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `interior_type` varchar(32) NOT NULL DEFAULT 'public',
  `display_name` varchar(64) NOT NULL DEFAULT 'Public Interior',
  `exterior_x` float NOT NULL DEFAULT 0,
  `exterior_y` float NOT NULL DEFAULT 0,
  `exterior_z` float NOT NULL DEFAULT 0,
  `exterior_a` float NOT NULL DEFAULT 0,
  `exterior_interior` int(11) NOT NULL DEFAULT 0,
  `exterior_virtual_world` int(11) NOT NULL DEFAULT 0,
  `interior_id` int(11) NOT NULL DEFAULT 0,
  `interior_x` float NOT NULL DEFAULT 0,
  `interior_y` float NOT NULL DEFAULT 0,
  `interior_z` float NOT NULL DEFAULT 0,
  `interior_a` float NOT NULL DEFAULT 0,
  `exit_x` float NOT NULL DEFAULT 0,
  `exit_y` float NOT NULL DEFAULT 0,
  `exit_z` float NOT NULL DEFAULT 0,
  `source_file` varchar(128) NOT NULL DEFAULT '',
  `source_ref` varchar(128) NOT NULL DEFAULT '',
  `source_tag` varchar(64) NOT NULL DEFAULT 'offline_exact_public',
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `imported` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_pubint_import_enabled` (`enabled`),
  KEY `idx_pubint_import_source_tag` (`source_tag`),
  KEY `idx_pubint_import_type` (`interior_type`),
  KEY `idx_pubint_import_imported` (`imported`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `public_interiors`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `public_interiors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `interior_type` varchar(32) NOT NULL,
  `display_name` varchar(64) NOT NULL,
  `exterior_x` float NOT NULL,
  `exterior_y` float NOT NULL,
  `exterior_z` float NOT NULL,
  `exterior_a` float NOT NULL DEFAULT 0,
  `exterior_spawn_x` float DEFAULT NULL,
  `exterior_spawn_y` float DEFAULT NULL,
  `exterior_spawn_z` float DEFAULT NULL,
  `exterior_spawn_a` float DEFAULT NULL,
  `exterior_pickup_model` int(11) NOT NULL DEFAULT 1318,
  `interior_pickup_model` int(11) NOT NULL DEFAULT 1318,
  `exterior_interior` int(11) NOT NULL DEFAULT 0,
  `exterior_virtual_world` int(11) NOT NULL DEFAULT 0,
  `interior_id` int(11) NOT NULL DEFAULT 0,
  `interior_virtual_world` int(11) NOT NULL DEFAULT 0,
  `interior_x` float NOT NULL,
  `interior_y` float NOT NULL,
  `interior_z` float NOT NULL,
  `interior_a` float NOT NULL DEFAULT 0,
  `exit_x` float NOT NULL,
  `exit_y` float NOT NULL,
  `exit_z` float NOT NULL,
  `source_tag` varchar(64) NOT NULL DEFAULT 'manual',
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `service_x` float NOT NULL DEFAULT 0,
  `service_y` float NOT NULL DEFAULT 0,
  `service_z` float NOT NULL DEFAULT 0,
  `service_radius` float NOT NULL DEFAULT 0,
  `exit_a` float NOT NULL DEFAULT 0,
  `service_a` float NOT NULL DEFAULT 0,
  `exterior_map_icon` int(11) NOT NULL DEFAULT 52,
  PRIMARY KEY (`id`),
  KEY `idx_public_interiors_enabled` (`enabled`),
  KEY `idx_public_interiors_type` (`interior_type`),
  KEY `idx_public_interiors_source` (`source_tag`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `public_service_config`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `public_service_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_type` varchar(32) NOT NULL,
  `service_key` varchar(32) NOT NULL,
  `display_name` varchar(48) NOT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  `health_add` float NOT NULL DEFAULT 0,
  `armor_add` float NOT NULL DEFAULT 0,
  `xp_reward` int(11) NOT NULL DEFAULT 0,
  `wanted_reduce` int(11) NOT NULL DEFAULT 0,
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_public_service_type_key` (`service_type`,`service_key`),
  KEY `idx_public_service_type` (`service_type`),
  KEY `idx_public_service_enabled` (`enabled`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `race_records`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `race_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `race_code` varchar(32) NOT NULL,
  `best_time_ms` int(11) NOT NULL,
  `total_finishes` int(11) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_player_race` (`player_id`,`race_code`),
  KEY `idx_race_code` (`race_code`),
  KEY `idx_best_time_ms` (`best_time_ms`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `reports`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reporter_id` int(11) DEFAULT NULL,
  `reporter_name` varchar(24) NOT NULL,
  `target_id` int(11) DEFAULT NULL,
  `target_name` varchar(24) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `status` varchar(16) NOT NULL DEFAULT 'open',
  `handled_by_id` int(11) DEFAULT NULL,
  `handled_by_name` varchar(24) DEFAULT NULL,
  `close_note` varchar(255) DEFAULT NULL,
  `closed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_reporter_id` (`reporter_id`),
  KEY `idx_target_id` (`target_id`),
  KEY `idx_created_at` (`created_at`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `server_settings`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `server_settings` (
  `setting_key` varchar(64) NOT NULL,
  `setting_value` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`setting_key`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `turf_war_logs`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `turf_war_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `territory_index` int(11) NOT NULL,
  `territory_name` varchar(64) NOT NULL,
  `attacker_gang_id` int(11) NOT NULL DEFAULT 0,
  `attacker_gang_name` varchar(64) NOT NULL DEFAULT 'Neutral',
  `defender_gang_id` int(11) NOT NULL DEFAULT 0,
  `defender_gang_name` varchar(64) NOT NULL DEFAULT 'Neutral',
  `result` varchar(24) NOT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_territory_index` (`territory_index`),
  KEY `idx_attacker_gang_id` (`attacker_gang_id`),
  KEY `idx_defender_gang_id` (`defender_gang_id`),
  KEY `idx_result` (`result`),
  KEY `idx_created_at` (`created_at`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `weapon_shop_config`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `weapon_shop_config` (
  `weapon_id` int(11) NOT NULL,
  `weapon_name` varchar(32) NOT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  `ammo_per_purchase` int(11) NOT NULL DEFAULT 0,
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`weapon_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `world_locations`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `world_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location_key` varchar(64) NOT NULL,
  `location_type` varchar(24) NOT NULL,
  `display_name` varchar(64) NOT NULL,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `pos_a` float NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0,
  `virtual_world` int(11) NOT NULL DEFAULT 0,
  `map_icon` int(11) NOT NULL DEFAULT 51,
  `pickup_model` int(11) NOT NULL DEFAULT 1239,
  `object_model` int(11) NOT NULL DEFAULT 0,
  `linked_object_id` int(11) NOT NULL DEFAULT 0,
  `label_text` varchar(96) DEFAULT NULL,
  `interaction_radius` float NOT NULL DEFAULT 3,
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `source_tag` varchar(64) DEFAULT 'manual',
  PRIMARY KEY (`id`),
  KEY `idx_location_type` (`location_type`),
  KEY `idx_enabled` (`enabled`),
  KEY `idx_location_key` (`location_key`),
  KEY `idx_world_locations_linked_object_id` (`linked_object_id`),
  KEY `idx_world_locations_source_tag` (`source_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `world_objects`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `world_objects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_name` varchar(64) NOT NULL DEFAULT 'Object',
  `model_id` int(11) NOT NULL,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `rot_x` float NOT NULL DEFAULT 0,
  `rot_y` float NOT NULL DEFAULT 0,
  `rot_z` float NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0,
  `virtual_world` int(11) NOT NULL DEFAULT 0,
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `source_tag` varchar(64) NOT NULL DEFAULT 'manual',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_model_id` (`model_id`),
  KEY `idx_enabled` (`enabled`),
  KEY `idx_world_interior` (`virtual_world`,`interior`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `world_pickup_import_queue`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `world_pickup_import_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pickup_type` varchar(32) NOT NULL DEFAULT 'weapon',
  `display_name` varchar(64) NOT NULL,
  `model_id` int(11) NOT NULL,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `interior` int(11) NOT NULL DEFAULT 0,
  `virtual_world` int(11) NOT NULL DEFAULT 0,
  `amount` int(11) NOT NULL DEFAULT 30,
  `cooldown_seconds` int(11) NOT NULL DEFAULT 300,
  `source_tag` varchar(64) NOT NULL DEFAULT 'offline_exact_scm',
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `imported_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_source_tag` (`source_tag`),
  KEY `idx_enabled` (`enabled`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for `world_pickups`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `world_pickups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pickup_type` varchar(32) NOT NULL,
  `display_name` varchar(64) NOT NULL DEFAULT '',
  `model_id` int(11) NOT NULL DEFAULT 1239,
  `pos_x` float NOT NULL DEFAULT 0,
  `pos_y` float NOT NULL DEFAULT 0,
  `pos_z` float NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0,
  `virtual_world` int(11) NOT NULL DEFAULT 0,
  `amount` int(11) NOT NULL DEFAULT 1,
  `cooldown_seconds` int(11) NOT NULL DEFAULT 60,
  `source_tag` varchar(64) NOT NULL DEFAULT 'manual',
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_world_pickups_enabled` (`enabled`),
  KEY `idx_world_pickups_type` (`pickup_type`),
  KEY `idx_world_pickups_source` (`source_tag`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS=1;
