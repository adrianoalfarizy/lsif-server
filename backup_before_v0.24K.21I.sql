-- --------------------------------------------------------
-- Host:                         192.168.5.8
-- Server version:               10.11.14-MariaDB-0ubuntu0.24.04.1 - Ubuntu 24.04
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             12.7.0.6850
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table lsif_db.admin_logs
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
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.admin_logs: ~75 rows (approximately)
INSERT INTO `admin_logs` (`id`, `admin_id`, `admin_name`, `target_id`, `target_name`, `action`, `detail`, `created_at`) VALUES
	(1, 1, 'Novanov', 1, 'nutrisari', 'SETMONEY', 'setmoney amount=1000000', '2026-05-25 10:44:11'),
	(2, 1, 'Novanov', 1, 'nutrisari', 'SETLEVEL', 'setlevel level=5', '2026-05-25 10:44:53'),
	(3, 1, 'Novanov', 1, 'nutrisari', 'MAKEADMIN', 'makeadmin level=5', '2026-05-25 10:45:07'),
	(4, 1, 'Novanov', 1, 'nutrisari', 'MAKEADMIN', 'makeadmin level=0', '2026-05-25 10:46:28'),
	(5, 1, 'Novanov', 1, 'nutrisari', 'KICK', 'nakal', '2026-05-25 10:46:31'),
	(6, 1, 'Novanov', 1, 'nutrisari', 'BAN', 'ban minutes=2 reason=nakal', '2026-05-25 11:36:53'),
	(7, 1, 'Novanov', 65535, '-', 'UNBAN', 'unban username=nutrisari', '2026-05-25 11:39:10'),
	(8, 1, 'Novanov', 1, 'nutrisari', 'BAN', 'ban minutes=0 reason=permanen mampus', '2026-05-25 11:39:44'),
	(9, 1, 'Novanov', 65535, '-', 'UNBAN', 'unban username=nutrisari', '2026-05-25 11:55:25'),
	(10, 1, 'Novanov', 65535, '-', 'CLOSE_REPORT', 'closereport id=1 note=kamu yang jelek', '2026-05-25 11:57:18'),
	(11, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$1085788 Server=$985788 Count=1', '2026-05-25 22:02:11'),
	(12, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Taxi job cancelled by anti-cheat: invalid taxi vehicle.', '2026-05-25 22:04:51'),
	(13, 1, 'Novanov', 0, '-', 'SAVEALL', 'Manual save all players', '2026-05-26 03:26:52'),
	(14, 1, 'Novanov', 3, 'user', 'SETMONEY', 'setmoney amount=1000000', '2026-05-26 15:35:55'),
	(15, 1, 'Novanov', 1, 'Novanov', 'SETMONEY', 'setmoney amount=1000000', '2026-05-27 11:13:33'),
	(16, 1, 'Novanov', 0, '-', 'ABROADCAST', 'test', '2026-05-27 14:16:57'),
	(17, 1, 'Novanov', 0, '-', 'CLOSE_FEEDBACK', 'closefeedback id=2 note=oke', '2026-05-27 23:48:00'),
	(18, 0, 'SYSTEM', 5, 'akunbaru', 'ANTICHEAT', 'Money mismatch detected. HUD=$15400 Server=$15500 Count=1', '2026-05-28 03:16:51'),
	(19, 0, 'SYSTEM', 5, 'akunbaru', 'ANTICHEAT', 'Money mismatch detected. HUD=$1284809 Server=$1284909 Count=1', '2026-05-28 04:16:24'),
	(20, 0, 'SYSTEM', 2, 'nutrisari', 'ANTICHEAT', 'Money mismatch detected. HUD=$1000021 Server=$1000000 Count=1', '2026-05-28 06:19:52'),
	(21, 0, 'SYSTEM', 0, '-', 'TURF_CAPTURE', '[TURF CAPTURED] Idlewood District berhasil dikuasai oleh Varrios Los Aztecas.', '2026-06-01 09:56:17'),
	(22, 0, 'SYSTEM', 0, '-', 'TURF_CAPTURE', '[TURF CAPTURED] Turf_3 berhasil dikuasai oleh Varrios Los Aztecas.', '2026-06-01 10:15:24'),
	(23, 0, 'SYSTEM', 0, '-', 'TURF_CAPTURE', '[TURF CAPTURED] Turf_3 berhasil dikuasai oleh Varrios Los Aztecas.', '2026-06-01 10:33:44'),
	(24, 0, 'SYSTEM', 0, '-', 'TURF_CAPTURE', '[TURF CAPTURED] Turf_3 berhasil dikuasai oleh Varrios Los Aztecas.', '2026-06-01 10:56:15'),
	(25, 1, 'Novanov', 0, '-', 'SET_TURF_CONFIG', 'Turf config diubah: hold 5, capture 60, grace 20, cooldown 300 detik.', '2026-06-01 11:06:40'),
	(26, 1, 'Novanov', 0, '-', 'SET_TURF_CONFIG', 'Turf config diubah: hold 3, capture 60, grace 20, cooldown 300 detik.', '2026-06-01 11:07:19'),
	(27, 0, 'SYSTEM', 0, '-', 'TURF_CAPTURE', '[TURF CAPTURED] Turf_3 berhasil dikuasai oleh Varrios Los Aztecas.', '2026-06-01 11:08:29'),
	(28, 1, 'Novanov', 0, '-', 'RESET_TURF_CONFIG', 'Turf config dikembalikan ke default.', '2026-06-01 11:11:31'),
	(29, 1, 'Novanov', 0, '-', 'SET_TURF_CONFIG', 'Turf config diubah: hold 3, capture 60, grace 20, cooldown 300 detik.', '2026-06-01 11:48:37'),
	(30, 0, 'SYSTEM', 0, '-', 'TURF_DEFEND', '[TURF DEFENDED] Turf_3 berhasil dipertahankan oleh Grove Street Families.', '2026-06-01 11:49:12'),
	(31, 0, 'SYSTEM', 0, '-', 'TURF_CAPTURE', '[TURF CAPTURED] Turf_3 berhasil dikuasai oleh Grove Street Families.', '2026-06-02 00:04:23'),
	(32, 1, 'Novanov', 0, '-', 'SET_TURF_CONFIG', 'Turf config diubah: hold 3, capture 30, grace 10, cooldown 60 detik.', '2026-06-02 00:16:08'),
	(33, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$946072 Server=$946172 Count=1', '2026-06-02 02:28:19'),
	(34, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$946072 Server=$946172 Count=2', '2026-06-02 02:30:19'),
	(35, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$946072 Server=$946172 Count=1', '2026-06-02 04:04:55'),
	(36, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$946072 Server=$946172 Count=1', '2026-06-02 05:02:54'),
	(37, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=1', '2026-06-02 15:19:20'),
	(38, 0, 'SYSTEM', 0, '-', 'TURF_DEFEND', '[TURF DEFENDED] Idlewood District berhasil dipertahankan oleh Varrios Los Aztecas.', '2026-06-02 15:19:51'),
	(39, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=1', '2026-06-03 03:29:37'),
	(40, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=3', '2026-06-03 03:32:07'),
	(41, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=1', '2026-06-03 03:40:21'),
	(42, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=2', '2026-06-03 03:41:11'),
	(43, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=1', '2026-06-03 03:59:48'),
	(44, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=3', '2026-06-03 04:00:18'),
	(45, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=1', '2026-06-03 04:17:32'),
	(46, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=1', '2026-06-03 04:26:26'),
	(47, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=1', '2026-06-03 04:49:08'),
	(48, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=1', '2026-06-03 05:08:47'),
	(49, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=1', '2026-06-03 05:15:01'),
	(50, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=2', '2026-06-03 05:15:41'),
	(51, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=1', '2026-06-03 05:32:57'),
	(52, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=2', '2026-06-03 05:35:47'),
	(53, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=1', '2026-06-03 09:36:27'),
	(54, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=3', '2026-06-03 09:37:17'),
	(55, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=1', '2026-06-03 09:42:12'),
	(56, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=2', '2026-06-03 09:42:42'),
	(57, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=1', '2026-06-03 09:43:12'),
	(58, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$926372 Server=$926472 Count=1', '2026-06-03 09:51:24'),
	(59, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$922372 Server=$922472 Count=1', '2026-06-04 12:47:11'),
	(60, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$922372 Server=$922472 Count=2', '2026-06-04 12:47:51'),
	(61, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$922372 Server=$922472 Count=3', '2026-06-04 12:48:21'),
	(62, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$922372 Server=$922472 Count=1', '2026-06-04 12:49:01'),
	(63, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$922372 Server=$922472 Count=1', '2026-06-04 13:03:45'),
	(64, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$922372 Server=$922472 Count=1', '2026-06-04 13:32:39'),
	(65, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$922372 Server=$922472 Count=3', '2026-06-04 13:33:49'),
	(66, 0, 'SYSTEM', 1, 'Novanov', 'ANTICHEAT', 'Money mismatch detected. HUD=$922372 Server=$922472 Count=1', '2026-06-04 13:34:29'),
	(67, 1, 'Novanov', 6, 'mizuukii', 'MAKEADMIN', 'makeadmin level=3', '2026-06-04 16:09:23'),
	(68, 1, 'Novanov', 6, 'mizuukii', 'MAKEADMIN', 'makeadmin level=5', '2026-06-04 16:36:40'),
	(69, 1, 'Novanov', 6, 'mizuukii', 'MAKEADMIN', 'makeadmin level=5', '2026-06-04 16:36:55'),
	(70, 0, 'SYSTEM', 0, '-', 'TURF_CAPTURE', '[TURF CAPTURED] Ballas berhasil dikuasai oleh Grove Street Families.', '2026-06-04 16:41:27'),
	(71, 0, 'SYSTEM', 0, '-', 'TURF_CAPTURE', '[TURF CAPTURED] tes berhasil dikuasai oleh Grove Street Families.', '2026-06-04 16:41:47'),
	(72, 0, 'SYSTEM', 0, '-', 'TURF_DEFEND', '[TURF DEFENDED] Ballas berhasil dipertahankan oleh Los Santos Vagos.', '2026-06-04 16:43:14'),
	(73, 0, 'SYSTEM', 0, '-', 'TURF_CAPTURE', '[TURF CAPTURED] Ballas berhasil dikuasai oleh Grove Street Families.', '2026-06-04 16:47:45'),
	(74, 1, 'Novanov', 6, 'mizuukii', 'MAKEADMIN', 'makeadmin level=3', '2026-06-04 16:48:36'),
	(75, 1, 'Novanov', 6, 'mizuukii', 'KICK', 'cheat', '2026-06-04 16:50:46');

-- Dumping structure for table lsif_db.bans
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.bans: ~2 rows (approximately)
INSERT INTO `bans` (`id`, `player_id`, `player_name`, `ip_address`, `admin_id`, `admin_name`, `reason`, `duration_minutes`, `expires_at`, `active`, `unbanned_by_id`, `unbanned_by_name`, `unbanned_at`, `unban_reason`, `created_at`) VALUES
	(1, 2, 'nutrisari', '192.168.18.103', 1, 'Novanov', 'nakal', 2, '2026-05-25 11:38:53', 0, 1, 'Novanov', '2026-05-25 11:39:10', 'manual_unban', '2026-05-25 11:36:53'),
	(2, 2, 'nutrisari', '192.168.18.103', 1, 'Novanov', 'permanen mampus', 0, NULL, 0, 1, 'Novanov', '2026-05-25 11:55:25', 'manual_unban', '2026-05-25 11:39:44');

-- Dumping structure for table lsif_db.beta_whitelist
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.beta_whitelist: ~5 rows (approximately)
INSERT INTO `beta_whitelist` (`id`, `username`, `added_by`, `note`, `active`, `created_at`, `updated_at`) VALUES
	(1, 'HydriZ', 'Novanov', 'manual_add', 1, '2026-05-27 14:17:11', '2026-05-27 14:18:12'),
	(3, 'Novanov', 'Novanov', 'manual_add', 1, '2026-05-27 14:17:11', '2026-05-27 14:18:12'),
	(4, 'akunbaru', 'Novanov', 'manual_add', 1, '2026-05-27 14:17:11', '2026-05-27 14:18:12'),
	(5, 'nutrisari', 'Novanov', 'dialog_add', 1, '2026-05-28 06:18:24', NULL),
	(6, 'mizuukii', 'Novanov', 'dialog_add', 1, '2026-06-04 15:56:19', NULL);

-- Dumping structure for table lsif_db.business_preset_config
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

-- Dumping data for table lsif_db.business_preset_config: ~30 rows (approximately)
INSERT INTO `business_preset_config` (`business_index`, `name`, `x`, `y`, `z`, `price`, `income_per_minute`, `source_tag`, `enabled`, `created_at`, `updated_at`) VALUES
	(0, 'Idlewood Mini Market', 1833.11, -1842.99, 13.5781, 80000, 120, 'db_editor_manual', 0, '2026-06-03 14:29:31', '2026-06-03 14:29:31'),
	(1, 'Willowfield Workshop', 2105.46, -1806.42, 13.5547, 120000, 180, 'legacy_static_migrated', 1, '2026-06-02 13:09:59', NULL),
	(2, 'Market Food Store', 1368.92, -1279.69, 13.5469, 175000, 250, 'db_editor_manual', 0, '2026-06-02 17:37:44', '2026-06-02 17:37:44'),
	(3, 'East LS Gas Station', 2420.33, -1508.22, 24, 250000, 350, 'legacy_static_migrated', 1, '2026-06-02 13:09:59', NULL),
	(4, 'Vinewood Electronics', 1000.58, -919.915, 42.3281, 350000, 500, 'legacy_static_migrated', 1, '2026-06-02 13:09:59', NULL),
	(5, 'Blueberry Gas Station', 219.743, -233.443, 1.5781, 110000, 160, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(6, 'Dillimore General Store', 664.25, -573.91, 16.3359, 120000, 170, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(7, 'Palomino Creek Market', 2303.85, -16.16, 26.4844, 130000, 180, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(8, 'Montgomery Workshop', 1291.71, 269.34, 19.5547, 135000, 190, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(9, 'Angel Pine General Store', -2092.58, -2464.84, 30.625, 125000, 180, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(10, 'Doherty Garage', -2029.65, 143.36, 28.8359, 240000, 320, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(11, 'Wang Cars Showroom', -1952.92, 299.12, 35.4688, 350000, 500, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(12, 'Zero RC Shop', -2244.23, 128.01, 35.3203, 300000, 420, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(13, 'Chinatown Betting Shop', -2172.21, 645.81, 49.4375, 260000, 360, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(14, 'Hashbury Clothing Store', -2491.21, -29.72, 25.7656, 210000, 300, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(15, 'Easter Basin Depot', -1692.55, 1326.85, 7.1875, 230000, 330, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(16, 'Bayside Marina Store', -2454.28, 2254.46, 4.9844, 180000, 260, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(17, 'Fort Carson Diner', -121.26, 1116.38, 19.7422, 145000, 210, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(18, 'El Quebrados Barbers', -1446.15, 2592.77, 55.8359, 145000, 210, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(19, 'Verdant Meadows Airfield', 414.94, 2536.05, 19.1484, 500000, 700, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(20, 'Redsands West Gas Station', 1596.77, 2199.11, 10.8203, 210000, 300, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(21, 'The Strip Casino Kiosk', 2025.25, 1007.73, 10.8203, 350000, 500, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(22, 'Come-A-Lot Gifts', 2169.78, 1122.94, 12.61, 250000, 340, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(23, 'Old Venturas Steakhouse', 2384.9, 1041.53, 10.8203, 240000, 320, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(24, 'Pirates Casino Shop', 1997.21, 1522.09, 14.6172, 320000, 450, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(25, 'Rockshore Industrial Depot', 2520.13, 2311.35, 10.8203, 260000, 360, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(26, 'LV Airport Cargo Office', 1685.62, 1447.52, 10.7734, 300000, 420, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(27, 'SF Airport Cargo Office', -1425.41, -289.62, 14.1484, 300000, 420, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(28, 'LS Airport Rentals', 1685.82, -2241.23, 13.5469, 280000, 390, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL),
	(29, 'Flint County Farm Supply', -1060.72, -1195.43, 129.219, 150000, 220, 'full_sa_business_seed', 1, '2026-06-02 13:36:44', NULL);

-- Dumping structure for table lsif_db.feedback_reports
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.feedback_reports: ~2 rows (approximately)
INSERT INTO `feedback_reports` (`id`, `reporter_id`, `reporter_name`, `type`, `message`, `status`, `handled_by_id`, `handled_by_name`, `close_note`, `closed_at`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Novanov', 'bug', 'tes anu', 'open', NULL, NULL, NULL, NULL, '2026-05-27 23:46:20', NULL),
	(2, 1, 'Novanov', 'suggest', 'tes123', 'closed', 1, 'Novanov', 'oke', '2026-05-27 23:48:00', '2026-05-27 23:46:58', '2026-05-27 23:48:00');

-- Dumping structure for table lsif_db.gangs
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

-- Dumping data for table lsif_db.gangs: ~9 rows (approximately)
INSERT INTO `gangs` (`id`, `name`, `leader_id`, `leader_name`, `gang_color`, `bank_money`, `reputation`, `created_at`, `updated_at`) VALUES
	(1, 'Grove Street Families', 0, 'SYSTEM', 16711935, 68000, 45, '2026-05-28 10:10:55', '2026-06-04 16:47:45'),
	(2, 'Ballas', 0, 'SYSTEM', -1436103425, 0, 0, '2026-05-28 10:10:55', '2026-05-30 14:10:03'),
	(3, 'Los Santos Vagos', 0, 'SYSTEM', -65281, 8000, 5, '2026-05-28 10:10:55', '2026-06-04 16:43:14'),
	(4, 'Varrios Los Aztecas', 0, 'SYSTEM', 16777215, 83000, 55, '2026-05-28 10:10:55', '2026-06-02 15:19:51'),
	(5, 'San Fierro Rifa', 0, 'Server', 869046783, 0, 0, '2026-06-02 13:36:44', NULL),
	(6, 'San Fierro Triads', 0, 'Server', -3435777, 0, 0, '2026-06-02 13:36:44', NULL),
	(7, 'Da Nang Boys', 0, 'Server', -862362881, 0, 0, '2026-06-02 13:36:44', NULL),
	(8, 'The Mafia', 0, 'Server', 1717987071, 0, 0, '2026-06-02 13:36:44', NULL),
	(9, 'Russian Mafia', 0, 'Server', -1717960705, 0, 0, '2026-06-02 13:36:44', NULL);

-- Dumping structure for table lsif_db.gang_hq_interiors
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

-- Dumping data for table lsif_db.gang_hq_interiors: ~9 rows (approximately)
INSERT INTO `gang_hq_interiors` (`gang_id`, `gang_name`, `interior_id`, `virtual_world`, `int_x`, `int_y`, `int_z`, `int_a`, `exit_x`, `exit_y`, `exit_z`, `exit_a`, `enabled`, `created_at`, `updated_at`, `door_pickup_model`, `door_x`, `door_y`, `door_z`, `door_a`, `int_exit_x`, `int_exit_y`, `int_exit_z`, `int_exit_a`) VALUES
	(1, 'Grove Street Families', 3, 42001, 2496.24, -1693.94, 1014.74, 177.231, 2495.39, -1687.49, 13.516, 2.22589, 1, '2026-06-04 16:01:49', '2026-06-04 16:01:49', 1318, 2495.32, -1691.12, 14.7656, 352.407, 2496.17, -1692.1, 1014.74, 185.898),
	(2, 'Ballas', 3, 42002, 2496.05, -1695.24, 1014.74, 180, 2229.32, -1159.73, 25.7331, 0, 1, '2026-06-02 02:08:56', '2026-06-03 11:12:39', 1318, 2229.32, -1159.73, 25.7331, 0, 2496.05, -1693.74, 1014.74, 180),
	(3, 'Los Santos Vagos', 3, 42003, 2496.05, -1695.24, 1014.74, 180, 2421.54, -1224.36, 25.3828, 0, 1, '2026-06-02 02:08:56', '2026-06-03 11:12:39', 1318, 2421.54, -1224.36, 25.3828, 0, 2496.05, -1693.74, 1014.74, 180),
	(4, 'Varrios Los Aztecas', 3, 42004, 2496.05, -1695.24, 1014.74, 180, 1766.6, -1918.3, 13.56, 0, 1, '2026-06-02 02:08:56', '2026-06-03 11:12:39', 1318, 1766.6, -1918.3, 13.56, 0, 2496.05, -1693.74, 1014.74, 180),
	(5, 'San Fierro Rifa', 3, 42005, 2496.05, -1695.24, 1014.74, 180, -2142.7, -238.4, 36.5156, 90, 1, '2026-06-02 13:36:44', '2026-06-03 11:12:39', 1318, -2142.7, -238.4, 36.5156, 90, 2496.05, -1693.74, 1014.74, 180),
	(6, 'San Fierro Triads', 3, 42006, 2496.05, -1695.24, 1014.74, 180, -2175.3, 645.6, 49.4375, 180, 1, '2026-06-02 13:36:44', '2026-06-03 11:12:39', 1318, -2175.3, 645.6, 49.4375, 180, 2496.05, -1693.74, 1014.74, 180),
	(7, 'Da Nang Boys', 3, 42007, 2496.05, -1695.24, 1014.74, 180, -1720.8, 1338.3, 7.1875, 270, 1, '2026-06-02 13:36:44', '2026-06-03 11:12:39', 1318, -1720.8, 1338.3, 7.1875, 270, 2496.05, -1693.74, 1014.74, 180),
	(8, 'The Mafia', 3, 42008, 2496.05, -1695.24, 1014.74, 180, 2170.2, 1677.5, 10.8203, 180, 1, '2026-06-02 13:36:44', '2026-06-03 11:12:39', 1318, 2170.2, 1677.5, 10.8203, 180, 2496.05, -1693.74, 1014.74, 180),
	(9, 'Russian Mafia', 3, 42009, 2496.05, -1695.24, 1014.74, 180, 2520.3, 2311.2, 10.8203, 90, 1, '2026-06-02 13:36:44', '2026-06-03 11:12:39', 1318, 2520.3, 2311.2, 10.8203, 90, 2496.05, -1693.74, 1014.74, 180);

-- Dumping structure for table lsif_db.gang_members
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.gang_members: ~3 rows (approximately)
INSERT INTO `gang_members` (`id`, `gang_id`, `player_id`, `player_name`, `rank_level`, `joined_at`) VALUES
	(6, 1, 2, 'nutrisari', 1, '2026-06-01 10:11:23'),
	(12, 1, 6, 'mizuukii', 1, '2026-06-04 16:02:55'),
	(14, 3, 1, 'Novanov', 1, '2026-06-04 16:43:34');

-- Dumping structure for table lsif_db.gang_member_stats
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.gang_member_stats: ~5 rows (approximately)
INSERT INTO `gang_member_stats` (`id`, `gang_id`, `player_id`, `player_name`, `respect`, `captures`, `defends`, `wars_participated`, `last_activity_at`, `created_at`, `updated_at`) VALUES
	(1, 1, 2, 'nutrisari', 0, 0, 0, 0, NULL, '2026-06-01 23:55:10', NULL),
	(2, 1, 1, 'Novanov', 50, 2, 0, 2, '2026-06-04 16:41:47', '2026-06-01 23:55:10', '2026-06-04 16:41:47'),
	(5, 4, 1, 'Novanov', 0, 0, 0, 0, NULL, '2026-06-02 02:19:45', NULL),
	(9, 1, 6, 'mizuukii', 50, 2, 0, 2, '2026-06-04 16:47:45', '2026-06-04 16:02:55', '2026-06-04 16:47:45'),
	(12, 3, 1, 'Novanov', 0, 0, 0, 0, NULL, '2026-06-04 16:43:29', '2026-06-04 16:43:34');

-- Dumping structure for table lsif_db.gang_preset_config
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

-- Dumping data for table lsif_db.gang_preset_config: ~9 rows (approximately)
INSERT INTO `gang_preset_config` (`gang_id`, `name`, `short_name`, `color`, `color_name`, `hq_x`, `hq_y`, `hq_z`, `hq_a`, `hq_radius`, `source_tag`, `enabled`, `created_at`, `updated_at`, `hq_pickup_model`, `hq_map_icon`) VALUES
	(1, 'Grove Street Families', 'Grove', 16711935, 'Green', 2498.4, -1685.93, 13.4522, 271.068, 8, 'offline_exact_manual', 1, '2026-06-03 11:18:00', '2026-06-03 11:18:00', 1314, 19),
	(2, 'Ballas', 'Ballas', -1436103425, 'Purple', 2229.32, -1159.73, 25.7331, 90, 8, 'offline_exact_manual', 1, '2026-06-02 12:58:27', '2026-06-02 12:58:27', 1314, 19),
	(3, 'Los Santos Vagos', 'Vagos', -65281, 'Yellow', 2421.54, -1224.36, 25.3828, 270, 8, 'offline_exact_manual', 1, '2026-06-02 12:58:27', '2026-06-02 12:58:27', 1314, 19),
	(4, 'Varrios Los Aztecas', 'Aztecas', 16777215, 'Turquoise', 1766.6, -1918.3, 13.56, 180, 8, 'offline_exact_manual', 0, '2026-06-02 14:25:57', '2026-06-02 14:25:57', 1314, 19),
	(5, 'San Fierro Rifa', 'Rifa', 869046783, 'Teal', -2142.7, -238.4, 36.5156, 90, 8, 'offline_reference_manual', 1, '2026-06-02 13:36:44', '2026-06-02 13:36:44', 1314, 19),
	(6, 'San Fierro Triads', 'Triads', -3435777, 'Red', -2175.3, 645.6, 49.4375, 180, 8, 'offline_reference_manual', 1, '2026-06-02 13:36:44', '2026-06-02 13:36:44', 1314, 19),
	(7, 'Da Nang Boys', 'Da Nang', -862362881, 'Brown', -1720.8, 1338.3, 7.1875, 270, 8, 'offline_reference_manual', 1, '2026-06-02 13:36:44', '2026-06-02 13:36:44', 1314, 19),
	(8, 'The Mafia', 'Mafia', 1717987071, 'Gray', 2170.2, 1677.5, 10.8203, 180, 8, 'offline_reference_manual', 1, '2026-06-02 13:36:44', '2026-06-02 13:36:44', 1314, 19),
	(9, 'Russian Mafia', 'Russian', -1717960705, 'Pale Blue', 2520.3, 2311.2, 10.8203, 90, 8, 'offline_reference_manual', 1, '2026-06-02 13:36:44', '2026-06-02 13:36:44', 1314, 19);

-- Dumping structure for table lsif_db.gang_territories
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.gang_territories: ~3 rows (approximately)
INSERT INTO `gang_territories` (`id`, `territory_index`, `territory_name`, `owner_gang_id`, `owner_gang_name`, `owner_org_id`, `owner_org_name`, `owner_color`, `center_x`, `center_y`, `center_z`, `radius`, `min_x`, `min_y`, `max_x`, `max_y`, `enabled`, `created_at`, `updated_at`, `source_tag`) VALUES
	(9, 7, 'Turf_3', 1, 'Grove Street Families', 0, 'Neutral', 16711935, 2195.4, -1700.43, 13.375, 46.3483, 2177.44, -1746.78, 2213.36, -1654.09, 1, '2026-06-01 07:34:48', '2026-06-02 00:04:23', 'manual'),
	(13, 1, 'Ballas', 1, 'Grove Street Families', 0, 'Neutral', 16711935, 2291.69, -1528.54, 26.8691, 11.4245, 2282.25, -1539.96, 2301.12, -1517.11, 1, '2026-06-04 16:36:57', '2026-06-04 16:47:45', 'manual'),
	(14, 2, 'tes', 1, 'Grove Street Families', 0, 'Neutral', 16711935, 2317.26, -1527.6, 25.3438, 14.295, 2308.23, -1541.9, 2326.29, -1513.31, 1, '2026-06-04 16:37:31', '2026-06-04 16:41:47', 'manual');

-- Dumping structure for table lsif_db.gang_weapon_logs
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table lsif_db.gang_weapon_logs: ~2 rows (approximately)
INSERT INTO `gang_weapon_logs` (`id`, `gang_id`, `player_id`, `player_name`, `action`, `weapon_id`, `weapon_name`, `ammo`, `cost`, `created_at`) VALUES
	(1, 1, 1, 'Novanov', 'TAKE', 22, 'Colt 45', 60, 0, '2026-06-02 01:59:22'),
	(2, 1, 1, 'Novanov', 'TAKE', 22, 'Colt 45', 30, 0, '2026-06-02 02:31:15');

-- Dumping structure for table lsif_db.gang_weapon_stash
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table lsif_db.gang_weapon_stash: ~8 rows (approximately)
INSERT INTO `gang_weapon_stash` (`id`, `gang_id`, `weapon_id`, `weapon_name`, `ammo`, `updated_at`) VALUES
	(1, 1, 22, 'Colt 45', 210, '2026-06-02 02:31:15'),
	(2, 1, 25, 'Shotgun', 120, '2026-06-02 00:53:06'),
	(3, 2, 22, 'Colt 45', 300, '2026-06-02 00:53:06'),
	(4, 2, 28, 'Micro SMG', 300, '2026-06-02 00:53:06'),
	(5, 3, 22, 'Colt 45', 300, '2026-06-02 00:53:06'),
	(6, 3, 29, 'MP5', 240, '2026-06-02 00:53:06'),
	(7, 4, 22, 'Colt 45', 300, '2026-06-02 00:53:06'),
	(8, 4, 23, 'Silenced Pistol', 180, '2026-06-02 00:53:06');

-- Dumping structure for table lsif_db.job_stats
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.job_stats: ~6 rows (approximately)
INSERT INTO `job_stats` (`id`, `player_id`, `job_code`, `total_completed`, `total_earned`, `total_xp`, `created_at`, `updated_at`) VALUES
	(1, 1, 'courier', 3, 1000, 80, '2026-05-25 18:37:34', '2026-05-28 06:25:32'),
	(3, 1, 'taxi', 4, 6414, 221, '2026-05-25 18:41:57', '2026-05-28 06:43:29'),
	(4, 1, 'trucker', 2, 8828, 282, '2026-05-25 18:43:20', '2026-05-28 06:26:54'),
	(6, 5, 'taxi', 1, 1709, 56, '2026-05-28 03:24:24', NULL),
	(9, 2, 'courier', 3, 950, 75, '2026-05-28 06:26:29', '2026-05-28 06:29:49'),
	(13, 1, 'police', 1, 900, 55, '2026-05-28 06:29:51', NULL);

-- Dumping structure for table lsif_db.organizations
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.organizations: ~2 rows (approximately)
INSERT INTO `organizations` (`id`, `name`, `owner_id`, `owner_name`, `bank_money`, `gang_color`, `created_at`, `updated_at`) VALUES
	(4, 'KMTS', 1, 'Novanov', 12288, 16711935, '2026-05-26 16:09:52', '2026-05-28 09:37:29'),
	(5, 'test', 5, 'akunbaru', 0, -1, '2026-05-28 05:21:55', NULL);

-- Dumping structure for table lsif_db.organization_members
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.organization_members: ~3 rows (approximately)
INSERT INTO `organization_members` (`id`, `org_id`, `player_id`, `player_name`, `rank_level`, `joined_at`) VALUES
	(8, 4, 1, 'Novanov', 5, '2026-05-26 16:09:52'),
	(9, 4, 3, 'user', 3, '2026-05-26 16:10:09'),
	(10, 5, 5, 'akunbaru', 5, '2026-05-28 05:21:55');

-- Dumping structure for table lsif_db.parked_vehicles
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
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.parked_vehicles: ~134 rows (approximately)
INSERT INTO `parked_vehicles` (`id`, `modelid`, `color1`, `color2`, `pos_x`, `pos_y`, `pos_z`, `pos_a`, `interior`, `virtual_world`, `respawn_delay`, `locked`, `enabled`, `source_tag`, `created_at`, `updated_at`) VALUES
	(1, 420, 234, 1, 2198.54, -1215.64, 23.969, 263.582, 0, 0, 300, 0, 0, 'manual', '2026-06-02 02:51:41', '2026-06-02 02:55:37'),
	(2, 420, 1, 1, 2211.75, -1223.89, 23.8125, 330, 0, 0, 300, 0, 0, 'manual', '2026-06-02 03:01:08', '2026-06-02 12:55:23'),
	(53, 463, -1, -1, 1174.76, 1364.83, 10.1203, 280.035, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(54, 521, -1, -1, 1175, 1366.48, 10.1203, 282.226, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(55, 522, -1, -1, 1174.47, 1368.36, 10.1203, 283.055, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(56, 556, -1, -1, 2692.03, -1674.02, 9.4656, 178.828, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(57, 494, -1, -1, 2676.7, -1673.76, 9.4038, 178.828, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(58, 424, -1, -1, 1104.93, 1614.81, 12.5546, 85.6435, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(59, 468, -1, -1, -1460.87, -1566.74, 101.058, 2, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(60, 478, -1, -1, -1446.24, -1494.73, 101.051, 6, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(61, 531, -1, -1, -1439.64, -1576.82, 101.058, 264.118, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(62, 481, -1, -1, 2412.52, -1326.49, 23.74, 177.92, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(63, 542, -1, -1, 2445.5, -1340.8, 23.5, 180, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(64, 481, -1, -1, 2499.18, -1648.26, 13, 158.61, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(65, 567, -1, -1, 2685.98, -2016.21, 12.5501, 0.337, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(66, 536, -1, -1, 1772.1, -2125.1, 13.0469, 0.3441, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(67, 468, -1, -1, -2048.86, -2521.28, 31.125, 171.023, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(68, 558, -1, -1, -1956.3, 297.7, 34.3, 64.8, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(69, 562, -1, -1, -1952.6, 265.7, 39.9, 292.8, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(70, 560, -1, -1, -1957.7, 277, 34.3, 133.4, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(71, 567, -1, -1, -1952.8, 258.8, 39.9, 259.1, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(72, 561, -1, -1, -1950.5, 259.7, 34.3, 53.8, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(73, 544, -1, -1, -2057, 58, 28, 90, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(74, 407, -1, -1, -2057, 64, 28, 90, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(75, 407, -1, -1, 1763.82, 2075.76, 9.9093, 179.475, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(76, 407, -1, -1, 1751.51, -1455.1, 12.5547, 263.559, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(77, 416, -1, -1, 2033.89, -1432.67, 16.6453, 177.829, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(78, 416, -1, -1, 1178.05, -1338.18, 13.405, 269.492, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(79, 416, -1, -1, -303.781, 1032.33, 19.086, 268.502, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(80, 416, -1, -1, -1507.16, 2525.46, 55.1875, 358.573, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(81, 416, -1, -1, 1229.66, 297.688, 19.0547, 154.955, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(82, 416, -1, -1, -2202.52, -2315.99, 30.1172, 319.681, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(83, 402, -1, -1, 886.378, -25.6671, 63.244, 157.621, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(84, 406, -1, -1, 687.373, 890.67, -40.4285, 35.14, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(85, 486, -1, -1, 620.882, 861.245, -43.9534, 298.743, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(86, 468, -1, -1, 623.34, 887.094, -43.5625, 347.297, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(87, 468, -1, -1, -2486.05, 59.184, 24.8284, 180, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(88, 492, -1, -1, 2216.9, -1160.4, 24.7265, 270.801, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(89, 492, -1, -1, 2216.9, -1160.4, 24.7265, 270.801, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(90, 481, -1, -1, 2229, -1173.8, 24.7331, 90.5569, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(91, 609, -1, -1, 2251.03, -1788.66, 12.7625, 358.959, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(92, 609, -1, -1, -2118.17, -4.0948, 35.0203, 270.142, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(93, 609, -1, -1, 2596.75, 1444.25, 10.3203, 178.271, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(94, 545, 83, 1, 2408.16, -1719.46, 13.6665, 0.5881, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(95, 557, -1, -1, -1778.18, 1207.07, 25.1194, 91.9357, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(96, 599, -1, -1, -1399.72, 2628.59, 55.7823, 271.794, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(97, 568, -1, -1, -379.5, -1443.12, 25.7266, 88.9244, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(98, 442, 1, 1, -2572.04, 1148.56, 55.7333, 337.843, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(99, 589, 126, 1, 2028.45, 2731.1, 10.53, 268.994, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(100, 402, -1, -1, -1673.94, 439.02, 7.01, 136, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(101, 405, -1, -1, 926.45, -1292.29, 13.6, 270, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(102, 411, -1, -1, -2665.44, 990.77, 64.45, 51, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(103, 483, -1, -1, -2516.6, 1228.92, 36.4283, 211.5, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(104, 445, -1, -1, 1122.29, -1699.76, 13.43, 270, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(105, 470, -1, -1, -1006.41, -628.27, 32, 270, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(106, 468, -1, -1, -2085.23, -2437.52, 30.31, 142, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(107, 409, -1, -1, -1922.19, 288.34, 40.84, 180, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(108, 533, -1, -1, -16.66, -2521.17, 36.37, 210, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(109, 534, -1, -1, 1803.38, -1931.05, 13.66, 0, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(110, 415, -1, -1, 1272.24, 2603.03, 10.49, 117, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(111, 489, -1, -1, -112.4, -41.82, 3.26, 160, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(112, 439, -1, -1, -2456.1, 741.65, 34.92, 180, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(113, 514, -1, -1, -1951.81, 2393.83, 50.08, 292, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(114, 480, -1, -1, -2751.79, -281.5, 6.81, 0, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(115, 535, -1, -1, 1923.93, -2118.89, 13.35, 0, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(116, 496, -1, -1, -1675.94, -618.74, 13.86, 256, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(117, 580, -1, -1, -2430.22, 320.84, 34.97, 245, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(118, 475, -1, -1, -2265.33, 200.65, 34.97, 270, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(119, 521, -1, -1, 2282.7, 2535.88, 10.39, 180, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(120, 429, -1, -1, 2133.04, 1009.75, 10.49, 270, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(121, 506, -1, -1, 2229.3, 1402.99, 10.82, 180, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(122, 508, -1, -1, -1550.4, 2687.54, 56.22, 90, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(123, 579, -1, -1, -2068.69, -83.75, 35.1, 0, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(124, 424, -1, -1, 682.17, -1867.46, 4.82, 180, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(125, 536, -1, -1, 1747.87, -2098.03, 13.28, 180, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(126, 463, -1, -1, 1144.46, -1101.26, 25.35, 300, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(127, 500, -1, -1, -2406.25, -2180.84, 33.39, 180, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(128, 477, -1, -1, 2163.79, 1810.23, 10.58, 180, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(129, 587, -1, -1, 2207.43, 1286.13, 10.57, 180, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(130, 532, -1, -1, -540.044, -1396.15, 15, 0, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(131, 532, -1, -1, -289.552, -1389.63, 10, 0, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(132, 532, -1, -1, -192.9, -1331.31, 21.5, 0, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(133, 531, -1, -1, -273.963, -1507.6, 5, 0, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(134, 531, -1, -1, -395.195, -1293.19, 30.8, 0, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(135, 531, -1, -1, -186.649, -1339.21, 6, 0, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(136, 532, -1, -1, -1030.25, -1050.19, 129, 0, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(137, 532, -1, -1, -1169.43, -989.631, 129, 0, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(138, 531, -1, -1, -1110.79, -947.792, 129, 0, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(139, 532, -1, -1, 16.8768, 49.991, 3, 0, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(140, 532, -1, -1, 81.051, 3.3203, 1.5, 0, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(141, 532, -1, -1, -15.2986, -84.6533, 3, 0, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(142, 531, -1, -1, 81.0533, 3.3234, 1.5, 0, 0, 0, 300, 1, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(143, 506, 31, 0, -2093.9, -83.7, 33.9, 359.1, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(144, 541, 15, 15, -2076.8, -84, 33.7, 1.1, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(145, 504, -1, -1, -2151, -409.1, 34.1, 307.2, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(146, 457, -1, -1, 927.721, -1185.04, 16.5, 123.305, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(147, 457, -1, -1, 927.523, -1182.37, 16.5, 123.305, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(148, 457, -1, -1, 926.918, -1178.95, 16.5, 123.305, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(149, 457, -1, -1, 861.354, -1240.76, 14.5, 180.131, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(150, 508, -1, -1, 837.749, -1206.57, 16.5, 153.263, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(151, 508, -1, -1, 897.517, -1207.99, 16.5, 86.5989, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(152, 508, -1, -1, 736.24, -1334.2, 13.5411, 267.811, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(153, 508, -1, -1, 736.962, -1343.91, 13.5197, 273.772, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(154, 468, -1, -1, -2408.51, -2186.02, 32.89, 321.692, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(155, 510, -1, -1, -2407.61, -2177.09, 32.89, 321.692, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(156, 508, -1, -1, -2338.57, -1593.83, 482.945, 20.751, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(157, 483, -1, -1, -2343.37, -1613.94, 482.976, 105.53, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(158, 571, -1, -1, -2213.56, 112.767, 34.9203, 88.472, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(159, 571, -1, -1, -2693.39, -139.456, 3.93359, 90.0856, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(160, 571, -1, -1, -2796.47, -94.1788, 6.9875, 42.6945, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(161, 571, -1, -1, -2206.05, 701.216, 48.9453, 183.417, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(162, 571, -1, -1, -810.56, 2430.36, 156.965, 336.533, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(163, 571, -1, -1, -1693.44, 432.285, 6.9914, 300.903, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(164, 571, -1, -1, -2116.14, 924.807, 85.9791, 94.9293, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(165, 571, -1, -1, -1483.69, 2614.84, 58.2812, 337.938, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(166, 571, -1, -1, 1419.7, 1948, 10.9531, 6.9689, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(167, 571, -1, -1, 1567.39, 2691.12, 10.265, 279.987, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(168, 571, -1, -1, -2087.37, -2519.02, 29.925, 90.9178, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(169, 571, -1, -1, 2615.32, 1939.7, 10.129, 148.176, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(170, 571, -1, -1, 1074.96, 1395.42, 5.303, 36.7673, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(171, 571, -1, -1, 2615.24, -1731.23, 5.9486, 140.821, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(172, 571, -1, -1, 1305.18, -796.695, 83.9477, 185.991, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(173, 539, -1, -1, -2294.93, 2546.98, 5.9175, 290.934, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(174, 539, -1, -1, 714.344, -1488.27, 0.9343, 270, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(175, 539, -1, -1, -1426.41, 506.839, 2.9463, 144.61, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(176, 539, -1, -1, 1971.92, 1560.67, 10.9635, 262.615, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(177, 539, -1, -1, -535.413, -60.8884, 63.5922, 276.976, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(178, 539, -1, -1, -910.27, 2699.06, 42.8, 110.874, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(179, 461, -1, -1, 435.275, 2527.52, 16.371, 90, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(180, 573, -1, -1, 1091.89, 1612.63, 13, 206.758, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(181, 412, -1, -1, 1772.66, -2096.59, 13.99, 182.758, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(182, 515, -1, -1, -2000.24, -2415.51, 29.767, -132, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(183, 578, -1, -1, -1969.81, -2437.94, 29.767, -82.5, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35'),
	(184, 530, -1, -1, -1969.81, -2443.91, 29.767, -19, 0, 0, 300, 0, 1, 'offline_exact_ls', '2026-06-02 06:15:35', '2026-06-02 06:15:35');

-- Dumping structure for table lsif_db.parked_vehicle_import_queue
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
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.parked_vehicle_import_queue: ~132 rows (approximately)
INSERT INTO `parked_vehicle_import_queue` (`id`, `batch_name`, `source_tag`, `modelid`, `color1`, `color2`, `pos_x`, `pos_y`, `pos_z`, `pos_a`, `interior`, `virtual_world`, `respawn_delay`, `locked`, `enabled`, `note`, `created_at`) VALUES
	(1, 'offline_exact_ls', 'offline_exact_ls', 463, -1, -1, 1174.76, 1364.83, 10.1203, 280.035, 0, 0, 300, 0, 1, 'SCM literal 014B offset 201916, Freeway, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(2, 'offline_exact_ls', 'offline_exact_ls', 521, -1, -1, 1175, 1366.48, 10.1203, 282.226, 0, 0, 300, 0, 1, 'SCM literal 014B offset 201959, FCR-900, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(3, 'offline_exact_ls', 'offline_exact_ls', 522, -1, -1, 1174.47, 1368.36, 10.1203, 283.055, 0, 0, 300, 0, 1, 'SCM literal 014B offset 202002, NRG-500, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(4, 'offline_exact_ls', 'offline_exact_ls', 556, -1, -1, 2692.03, -1674.02, 9.4656, 178.828, 0, 0, 300, 0, 1, 'SCM literal 014B offset 215198, Monster A, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(5, 'offline_exact_ls', 'offline_exact_ls', 494, -1, -1, 2676.7, -1673.76, 9.4038, 178.828, 0, 0, 300, 0, 1, 'SCM literal 014B offset 215255, Hotring Racer, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(6, 'offline_exact_ls', 'offline_exact_ls', 424, -1, -1, 1104.93, 1614.81, 12.5546, 85.6435, 0, 0, 300, 0, 1, 'SCM literal 014B offset 215312, BF Injection, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(7, 'offline_exact_ls', 'offline_exact_ls', 468, -1, -1, -1460.87, -1566.74, 101.058, 2, 0, 0, 300, 0, 1, 'SCM literal 014B offset 215369, Sanchez, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(8, 'offline_exact_ls', 'offline_exact_ls', 478, -1, -1, -1446.24, -1494.73, 101.051, 6, 0, 0, 300, 0, 1, 'SCM literal 014B offset 215426, Walton, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(9, 'offline_exact_ls', 'offline_exact_ls', 531, -1, -1, -1439.64, -1576.82, 101.058, 264.118, 0, 0, 300, 0, 1, 'SCM literal 014B offset 215483, Tractor, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(10, 'offline_exact_ls', 'offline_exact_ls', 481, -1, -1, 2412.52, -1326.49, 23.74, 177.92, 0, 0, 300, 0, 1, 'SCM literal 014B offset 215658, BMX, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(11, 'offline_exact_ls', 'offline_exact_ls', 542, -1, -1, 2445.5, -1340.8, 23.5, 180, 0, 0, 300, 0, 1, 'SCM literal 014B offset 215715, Clover, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(12, 'offline_exact_ls', 'offline_exact_ls', 481, -1, -1, 2499.18, -1648.26, 13, 158.61, 0, 0, 300, 0, 1, 'SCM literal 014B offset 215765, BMX, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(13, 'offline_exact_ls', 'offline_exact_ls', 567, -1, -1, 2685.98, -2016.21, 12.5501, 0.337, 0, 0, 300, 0, 1, 'SCM literal 014B offset 215815, Savanna, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(14, 'offline_exact_ls', 'offline_exact_ls', 536, -1, -1, 1772.1, -2125.1, 13.0469, 0.3441, 0, 0, 300, 0, 1, 'SCM literal 014B offset 215865, Blade, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(15, 'offline_exact_ls', 'offline_exact_ls', 468, -1, -1, -2048.86, -2521.28, 31.125, 171.023, 0, 0, 300, 0, 1, 'SCM literal 014B offset 215915, Sanchez, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(16, 'offline_exact_ls', 'offline_exact_ls', 558, -1, -1, -1956.3, 297.7, 34.3, 64.8, 0, 0, 300, 0, 1, 'SCM literal 014B offset 215965, Uranus, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(17, 'offline_exact_ls', 'offline_exact_ls', 562, -1, -1, -1952.6, 265.7, 39.9, 292.8, 0, 0, 300, 0, 1, 'SCM literal 014B offset 216008, Elegy, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(18, 'offline_exact_ls', 'offline_exact_ls', 560, -1, -1, -1957.7, 277, 34.3, 133.4, 0, 0, 300, 0, 1, 'SCM literal 014B offset 216051, Sultan, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(19, 'offline_exact_ls', 'offline_exact_ls', 567, -1, -1, -1952.8, 258.8, 39.9, 259.1, 0, 0, 300, 0, 1, 'SCM literal 014B offset 216094, Savanna, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(20, 'offline_exact_ls', 'offline_exact_ls', 561, -1, -1, -1950.5, 259.7, 34.3, 53.8, 0, 0, 300, 0, 1, 'SCM literal 014B offset 216137, Stratum, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(21, 'offline_exact_ls', 'offline_exact_ls', 544, -1, -1, -2057, 58, 28, 90, 0, 0, 300, 0, 1, 'SCM literal 014B offset 216432, Firetruck Ladder, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(22, 'offline_exact_ls', 'offline_exact_ls', 407, -1, -1, -2057, 64, 28, 90, 0, 0, 300, 0, 1, 'SCM literal 014B offset 216482, Firetruck, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(23, 'offline_exact_ls', 'offline_exact_ls', 407, -1, -1, 1763.82, 2075.76, 9.9093, 179.475, 0, 0, 300, 0, 1, 'SCM literal 014B offset 216532, Firetruck, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(24, 'offline_exact_ls', 'offline_exact_ls', 407, -1, -1, 1751.51, -1455.1, 12.5547, 263.559, 0, 0, 300, 0, 1, 'SCM literal 014B offset 216582, Firetruck, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(25, 'offline_exact_ls', 'offline_exact_ls', 416, -1, -1, 2033.89, -1432.67, 16.6453, 177.829, 0, 0, 300, 0, 1, 'SCM literal 014B offset 216632, Ambulance, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(26, 'offline_exact_ls', 'offline_exact_ls', 416, -1, -1, 1178.05, -1338.18, 13.405, 269.492, 0, 0, 300, 0, 1, 'SCM literal 014B offset 216682, Ambulance, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(27, 'offline_exact_ls', 'offline_exact_ls', 416, -1, -1, -303.781, 1032.33, 19.086, 268.502, 0, 0, 300, 0, 1, 'SCM literal 014B offset 216732, Ambulance, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(28, 'offline_exact_ls', 'offline_exact_ls', 416, -1, -1, -1507.16, 2525.46, 55.1875, 358.573, 0, 0, 300, 0, 1, 'SCM literal 014B offset 216782, Ambulance, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(29, 'offline_exact_ls', 'offline_exact_ls', 416, -1, -1, 1229.66, 297.688, 19.0547, 154.955, 0, 0, 300, 0, 1, 'SCM literal 014B offset 216832, Ambulance, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(30, 'offline_exact_ls', 'offline_exact_ls', 416, -1, -1, -2202.52, -2315.99, 30.1172, 319.681, 0, 0, 300, 0, 1, 'SCM literal 014B offset 216882, Ambulance, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(31, 'offline_exact_ls', 'offline_exact_ls', 402, -1, -1, 886.378, -25.6671, 63.244, 157.621, 0, 0, 300, 0, 1, 'SCM literal 014B offset 216932, Buffalo, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(32, 'offline_exact_ls', 'offline_exact_ls', 406, -1, -1, 687.373, 890.67, -40.4285, 35.14, 0, 0, 300, 0, 1, 'SCM literal 014B offset 217026, Dumper, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(33, 'offline_exact_ls', 'offline_exact_ls', 486, -1, -1, 620.882, 861.245, -43.9534, 298.743, 0, 0, 300, 0, 1, 'SCM literal 014B offset 217076, Dozer, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(34, 'offline_exact_ls', 'offline_exact_ls', 468, -1, -1, 623.34, 887.094, -43.5625, 347.297, 0, 0, 300, 0, 1, 'SCM literal 014B offset 217126, Sanchez, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(35, 'offline_exact_ls', 'offline_exact_ls', 468, -1, -1, -2486.05, 59.184, 24.8284, 180, 0, 0, 300, 0, 1, 'SCM literal 014B offset 217176, Sanchez, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(36, 'offline_exact_ls', 'offline_exact_ls', 492, -1, -1, 2216.9, -1160.4, 24.7265, 270.801, 0, 0, 300, 0, 1, 'SCM literal 014B offset 217446, Greenwood, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(37, 'offline_exact_ls', 'offline_exact_ls', 492, -1, -1, 2216.9, -1160.4, 24.7265, 270.801, 0, 0, 300, 0, 1, 'SCM literal 014B offset 217489, Greenwood, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(38, 'offline_exact_ls', 'offline_exact_ls', 481, -1, -1, 2229, -1173.8, 24.7331, 90.5569, 0, 0, 300, 0, 1, 'SCM literal 014B offset 217532, BMX, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(39, 'offline_exact_ls', 'offline_exact_ls', 609, -1, -1, 2251.03, -1788.66, 12.7625, 358.959, 0, 0, 300, 0, 1, 'SCM literal 014B offset 217575, Boxburg, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(40, 'offline_exact_ls', 'offline_exact_ls', 609, -1, -1, -2118.17, -4.0948, 35.0203, 270.142, 0, 0, 300, 0, 1, 'SCM literal 014B offset 217625, Boxburg, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(41, 'offline_exact_ls', 'offline_exact_ls', 609, -1, -1, 2596.75, 1444.25, 10.3203, 178.271, 0, 0, 300, 0, 1, 'SCM literal 014B offset 217675, Boxburg, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(42, 'offline_exact_ls', 'offline_exact_ls', 545, 83, 1, 2408.16, -1719.46, 13.6665, 0.5881, 0, 0, 300, 1, 1, 'SCM literal 014B offset 217725, Hustler, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(43, 'offline_exact_ls', 'offline_exact_ls', 557, -1, -1, -1778.18, 1207.07, 25.1194, 91.9357, 0, 0, 300, 1, 1, 'SCM literal 014B offset 217768, Monster B, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(44, 'offline_exact_ls', 'offline_exact_ls', 599, -1, -1, -1399.72, 2628.59, 55.7823, 271.794, 0, 0, 300, 1, 1, 'SCM literal 014B offset 217811, Police Ranger, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(45, 'offline_exact_ls', 'offline_exact_ls', 568, -1, -1, -379.5, -1443.12, 25.7266, 88.9244, 0, 0, 300, 1, 1, 'SCM literal 014B offset 217854, Bandito, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(46, 'offline_exact_ls', 'offline_exact_ls', 442, 1, 1, -2572.04, 1148.56, 55.7333, 337.843, 0, 0, 300, 1, 1, 'SCM literal 014B offset 217897, Romero, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(47, 'offline_exact_ls', 'offline_exact_ls', 589, 126, 1, 2028.45, 2731.1, 10.53, 268.994, 0, 0, 300, 1, 1, 'SCM literal 014B offset 217940, Club, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(48, 'offline_exact_ls', 'offline_exact_ls', 402, -1, -1, -1673.94, 439.02, 7.01, 136, 0, 0, 300, 1, 1, 'SCM literal 014B offset 218427, Buffalo, original_delay=0, alarm=70, door=40', '2026-06-02 06:13:44'),
	(49, 'offline_exact_ls', 'offline_exact_ls', 405, -1, -1, 926.45, -1292.29, 13.6, 270, 0, 0, 300, 1, 1, 'SCM literal 014B offset 218470, Sentinel, original_delay=0, alarm=60, door=30', '2026-06-02 06:13:44'),
	(50, 'offline_exact_ls', 'offline_exact_ls', 411, -1, -1, -2665.44, 990.77, 64.45, 51, 0, 0, 300, 1, 1, 'SCM literal 014B offset 218513, Infernus, original_delay=0, alarm=80, door=50', '2026-06-02 06:13:44'),
	(51, 'offline_exact_ls', 'offline_exact_ls', 483, -1, -1, -2516.6, 1228.92, 36.4283, 211.5, 0, 0, 300, 1, 1, 'SCM literal 014B offset 218556, Camper, original_delay=0, alarm=30, door=10', '2026-06-02 06:13:44'),
	(52, 'offline_exact_ls', 'offline_exact_ls', 445, -1, -1, 1122.29, -1699.76, 13.43, 270, 0, 0, 300, 1, 1, 'SCM literal 014B offset 218599, Admiral, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(53, 'offline_exact_ls', 'offline_exact_ls', 470, -1, -1, -1006.41, -628.27, 32, 270, 0, 0, 300, 1, 1, 'SCM literal 014B offset 218642, Patriot, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(54, 'offline_exact_ls', 'offline_exact_ls', 468, -1, -1, -2085.23, -2437.52, 30.31, 142, 0, 0, 300, 1, 1, 'SCM literal 014B offset 218685, Sanchez, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(55, 'offline_exact_ls', 'offline_exact_ls', 409, -1, -1, -1922.19, 288.34, 40.84, 180, 0, 0, 300, 1, 1, 'SCM literal 014B offset 218728, Stretch, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(56, 'offline_exact_ls', 'offline_exact_ls', 533, -1, -1, -16.66, -2521.17, 36.37, 210, 0, 0, 300, 1, 1, 'SCM literal 014B offset 218771, Feltzer, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(57, 'offline_exact_ls', 'offline_exact_ls', 534, -1, -1, 1803.38, -1931.05, 13.66, 0, 0, 0, 300, 1, 1, 'SCM literal 014B offset 218814, Remington, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(58, 'offline_exact_ls', 'offline_exact_ls', 415, -1, -1, 1272.24, 2603.03, 10.49, 117, 0, 0, 300, 1, 1, 'SCM literal 014B offset 218857, Cheetah, original_delay=0, alarm=90, door=30', '2026-06-02 06:13:44'),
	(59, 'offline_exact_ls', 'offline_exact_ls', 489, -1, -1, -112.4, -41.82, 3.26, 160, 0, 0, 300, 1, 1, 'SCM literal 014B offset 218900, Rancher, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(60, 'offline_exact_ls', 'offline_exact_ls', 439, -1, -1, -2456.1, 741.65, 34.92, 180, 0, 0, 300, 1, 1, 'SCM literal 014B offset 218943, Stallion, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(61, 'offline_exact_ls', 'offline_exact_ls', 514, -1, -1, -1951.81, 2393.83, 50.08, 292, 0, 0, 300, 1, 1, 'SCM literal 014B offset 218986, Tanker, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(62, 'offline_exact_ls', 'offline_exact_ls', 480, -1, -1, -2751.79, -281.5, 6.81, 0, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219029, Comet, original_delay=0, alarm=90, door=40', '2026-06-02 06:13:44'),
	(63, 'offline_exact_ls', 'offline_exact_ls', 535, -1, -1, 1923.93, -2118.89, 13.35, 0, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219072, Slamvan, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(64, 'offline_exact_ls', 'offline_exact_ls', 496, -1, -1, -1675.94, -618.74, 13.86, 256, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219115, Blista Compact, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(65, 'offline_exact_ls', 'offline_exact_ls', 580, -1, -1, -2430.22, 320.84, 34.97, 245, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219158, Stafford, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(66, 'offline_exact_ls', 'offline_exact_ls', 475, -1, -1, -2265.33, 200.65, 34.97, 270, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219201, Sabre, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(67, 'offline_exact_ls', 'offline_exact_ls', 521, -1, -1, 2282.7, 2535.88, 10.39, 180, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219244, FCR-900, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(68, 'offline_exact_ls', 'offline_exact_ls', 429, -1, -1, 2133.04, 1009.75, 10.49, 270, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219287, Banshee, original_delay=0, alarm=90, door=50', '2026-06-02 06:13:44'),
	(69, 'offline_exact_ls', 'offline_exact_ls', 506, -1, -1, 2229.3, 1402.99, 10.82, 180, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219330, Super GT, original_delay=0, alarm=90, door=50', '2026-06-02 06:13:44'),
	(70, 'offline_exact_ls', 'offline_exact_ls', 508, -1, -1, -1550.4, 2687.54, 56.22, 90, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219373, Journey, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(71, 'offline_exact_ls', 'offline_exact_ls', 579, -1, -1, -2068.69, -83.75, 35.1, 0, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219416, Huntley, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(72, 'offline_exact_ls', 'offline_exact_ls', 424, -1, -1, 682.17, -1867.46, 4.82, 180, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219459, BF Injection, original_delay=0, alarm=70, door=10', '2026-06-02 06:13:44'),
	(73, 'offline_exact_ls', 'offline_exact_ls', 536, -1, -1, 1747.87, -2098.03, 13.28, 180, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219502, Blade, original_delay=0, alarm=80, door=10', '2026-06-02 06:13:44'),
	(74, 'offline_exact_ls', 'offline_exact_ls', 463, -1, -1, 1144.46, -1101.26, 25.35, 300, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219545, Freeway, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(75, 'offline_exact_ls', 'offline_exact_ls', 500, -1, -1, -2406.25, -2180.84, 33.39, 180, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219588, Mesa, original_delay=0, alarm=70, door=10', '2026-06-02 06:13:44'),
	(76, 'offline_exact_ls', 'offline_exact_ls', 477, -1, -1, 2163.79, 1810.23, 10.58, 180, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219631, ZR-350, original_delay=0, alarm=80, door=10', '2026-06-02 06:13:44'),
	(77, 'offline_exact_ls', 'offline_exact_ls', 587, -1, -1, 2207.43, 1286.13, 10.57, 180, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219674, Euros, original_delay=0, alarm=50, door=10', '2026-06-02 06:13:44'),
	(78, 'offline_exact_ls', 'offline_exact_ls', 532, -1, -1, -540.044, -1396.15, 15, 0, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219927, Combine Harvester, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(79, 'offline_exact_ls', 'offline_exact_ls', 532, -1, -1, -289.552, -1389.63, 10, 0, 0, 0, 300, 1, 1, 'SCM literal 014B offset 219970, Combine Harvester, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(80, 'offline_exact_ls', 'offline_exact_ls', 532, -1, -1, -192.9, -1331.31, 21.5, 0, 0, 0, 300, 1, 1, 'SCM literal 014B offset 220013, Combine Harvester, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(81, 'offline_exact_ls', 'offline_exact_ls', 531, -1, -1, -273.963, -1507.6, 5, 0, 0, 0, 300, 1, 1, 'SCM literal 014B offset 220056, Tractor, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(82, 'offline_exact_ls', 'offline_exact_ls', 531, -1, -1, -395.195, -1293.19, 30.8, 0, 0, 0, 300, 1, 1, 'SCM literal 014B offset 220099, Tractor, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(83, 'offline_exact_ls', 'offline_exact_ls', 531, -1, -1, -186.649, -1339.21, 6, 0, 0, 0, 300, 1, 1, 'SCM literal 014B offset 220142, Tractor, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(84, 'offline_exact_ls', 'offline_exact_ls', 532, -1, -1, -1030.25, -1050.19, 129, 0, 0, 0, 300, 1, 1, 'SCM literal 014B offset 220185, Combine Harvester, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(85, 'offline_exact_ls', 'offline_exact_ls', 532, -1, -1, -1169.43, -989.631, 129, 0, 0, 0, 300, 1, 1, 'SCM literal 014B offset 220228, Combine Harvester, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(86, 'offline_exact_ls', 'offline_exact_ls', 531, -1, -1, -1110.79, -947.792, 129, 0, 0, 0, 300, 1, 1, 'SCM literal 014B offset 220271, Tractor, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(87, 'offline_exact_ls', 'offline_exact_ls', 532, -1, -1, 16.8768, 49.991, 3, 0, 0, 0, 300, 1, 1, 'SCM literal 014B offset 220314, Combine Harvester, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(88, 'offline_exact_ls', 'offline_exact_ls', 532, -1, -1, 81.051, 3.3203, 1.5, 0, 0, 0, 300, 1, 1, 'SCM literal 014B offset 220357, Combine Harvester, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(89, 'offline_exact_ls', 'offline_exact_ls', 532, -1, -1, -15.2986, -84.6533, 3, 0, 0, 0, 300, 1, 1, 'SCM literal 014B offset 220400, Combine Harvester, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(90, 'offline_exact_ls', 'offline_exact_ls', 531, -1, -1, 81.0533, 3.3234, 1.5, 0, 0, 0, 300, 1, 1, 'SCM literal 014B offset 220443, Tractor, original_delay=0, alarm=0, door=100', '2026-06-02 06:13:44'),
	(91, 'offline_exact_ls', 'offline_exact_ls', 506, 31, 0, -2093.9, -83.7, 33.9, 359.1, 0, 0, 300, 0, 1, 'SCM literal 014B offset 269871, Super GT, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(92, 'offline_exact_ls', 'offline_exact_ls', 541, 15, 15, -2076.8, -84, 33.7, 1.1, 0, 0, 300, 0, 1, 'SCM literal 014B offset 269921, Bullet, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(93, 'offline_exact_ls', 'offline_exact_ls', 504, -1, -1, -2151, -409.1, 34.1, 307.2, 0, 0, 300, 0, 1, 'SCM literal 014B offset 270151, Bloodring Banger, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(94, 'offline_exact_ls', 'offline_exact_ls', 457, -1, -1, 927.721, -1185.04, 16.5, 123.305, 0, 0, 300, 0, 1, 'SCM literal 014B offset 272401, Caddy, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(95, 'offline_exact_ls', 'offline_exact_ls', 457, -1, -1, 927.523, -1182.37, 16.5, 123.305, 0, 0, 300, 0, 1, 'SCM literal 014B offset 272444, Caddy, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(96, 'offline_exact_ls', 'offline_exact_ls', 457, -1, -1, 926.918, -1178.95, 16.5, 123.305, 0, 0, 300, 0, 1, 'SCM literal 014B offset 272487, Caddy, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(97, 'offline_exact_ls', 'offline_exact_ls', 457, -1, -1, 861.354, -1240.76, 14.5, 180.131, 0, 0, 300, 0, 1, 'SCM literal 014B offset 272530, Caddy, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(98, 'offline_exact_ls', 'offline_exact_ls', 508, -1, -1, 837.749, -1206.57, 16.5, 153.263, 0, 0, 300, 0, 1, 'SCM literal 014B offset 272573, Journey, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(99, 'offline_exact_ls', 'offline_exact_ls', 508, -1, -1, 897.517, -1207.99, 16.5, 86.5989, 0, 0, 300, 0, 1, 'SCM literal 014B offset 272616, Journey, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(100, 'offline_exact_ls', 'offline_exact_ls', 508, -1, -1, 736.24, -1334.2, 13.5411, 267.811, 0, 0, 300, 0, 1, 'SCM literal 014B offset 272659, Journey, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(101, 'offline_exact_ls', 'offline_exact_ls', 508, -1, -1, 736.962, -1343.91, 13.5197, 273.772, 0, 0, 300, 0, 1, 'SCM literal 014B offset 272702, Journey, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(102, 'offline_exact_ls', 'offline_exact_ls', 468, -1, -1, -2408.51, -2186.02, 32.89, 321.692, 0, 0, 300, 0, 1, 'SCM literal 014B offset 272905, Sanchez, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(103, 'offline_exact_ls', 'offline_exact_ls', 510, -1, -1, -2407.61, -2177.09, 32.89, 321.692, 0, 0, 300, 0, 1, 'SCM literal 014B offset 272948, Mountain Bike, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(104, 'offline_exact_ls', 'offline_exact_ls', 508, -1, -1, -2338.57, -1593.83, 482.945, 20.751, 0, 0, 300, 0, 1, 'SCM literal 014B offset 272991, Journey, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(105, 'offline_exact_ls', 'offline_exact_ls', 483, -1, -1, -2343.37, -1613.94, 482.976, 105.53, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273034, Camper, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(106, 'offline_exact_ls', 'offline_exact_ls', 571, -1, -1, -2213.56, 112.767, 34.9203, 88.472, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273105, Kart, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(107, 'offline_exact_ls', 'offline_exact_ls', 571, -1, -1, -2693.39, -139.456, 3.93359, 90.0856, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273148, Kart, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(108, 'offline_exact_ls', 'offline_exact_ls', 571, -1, -1, -2796.47, -94.1788, 6.9875, 42.6945, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273191, Kart, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(109, 'offline_exact_ls', 'offline_exact_ls', 571, -1, -1, -2206.05, 701.216, 48.9453, 183.417, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273234, Kart, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(110, 'offline_exact_ls', 'offline_exact_ls', 571, -1, -1, -810.56, 2430.36, 156.965, 336.533, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273277, Kart, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(111, 'offline_exact_ls', 'offline_exact_ls', 571, -1, -1, -1693.44, 432.285, 6.9914, 300.903, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273320, Kart, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(112, 'offline_exact_ls', 'offline_exact_ls', 571, -1, -1, -2116.14, 924.807, 85.9791, 94.9293, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273363, Kart, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(113, 'offline_exact_ls', 'offline_exact_ls', 571, -1, -1, -1483.69, 2614.84, 58.2812, 337.938, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273406, Kart, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(114, 'offline_exact_ls', 'offline_exact_ls', 571, -1, -1, 1419.7, 1948, 10.9531, 6.9689, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273449, Kart, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(115, 'offline_exact_ls', 'offline_exact_ls', 571, -1, -1, 1567.39, 2691.12, 10.265, 279.987, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273492, Kart, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(116, 'offline_exact_ls', 'offline_exact_ls', 571, -1, -1, -2087.37, -2519.02, 29.925, 90.9178, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273535, Kart, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(117, 'offline_exact_ls', 'offline_exact_ls', 571, -1, -1, 2615.32, 1939.7, 10.129, 148.176, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273578, Kart, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(118, 'offline_exact_ls', 'offline_exact_ls', 571, -1, -1, 1074.96, 1395.42, 5.303, 36.7673, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273621, Kart, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(119, 'offline_exact_ls', 'offline_exact_ls', 571, -1, -1, 2615.24, -1731.23, 5.9486, 140.821, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273664, Kart, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(120, 'offline_exact_ls', 'offline_exact_ls', 571, -1, -1, 1305.18, -796.695, 83.9477, 185.991, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273707, Kart, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(121, 'offline_exact_ls', 'offline_exact_ls', 539, -1, -1, -2294.93, 2546.98, 5.9175, 290.934, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273855, Vortex, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(122, 'offline_exact_ls', 'offline_exact_ls', 539, -1, -1, 714.344, -1488.27, 0.9343, 270, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273898, Vortex, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(123, 'offline_exact_ls', 'offline_exact_ls', 539, -1, -1, -1426.41, 506.839, 2.9463, 144.61, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273941, Vortex, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(124, 'offline_exact_ls', 'offline_exact_ls', 539, -1, -1, 1971.92, 1560.67, 10.9635, 262.615, 0, 0, 300, 0, 1, 'SCM literal 014B offset 273984, Vortex, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(125, 'offline_exact_ls', 'offline_exact_ls', 539, -1, -1, -535.413, -60.8884, 63.5922, 276.976, 0, 0, 300, 0, 1, 'SCM literal 014B offset 274027, Vortex, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(126, 'offline_exact_ls', 'offline_exact_ls', 539, -1, -1, -910.27, 2699.06, 42.8, 110.874, 0, 0, 300, 0, 1, 'SCM literal 014B offset 274070, Vortex, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(127, 'offline_exact_ls', 'offline_exact_ls', 461, -1, -1, 435.275, 2527.52, 16.371, 90, 0, 0, 300, 0, 1, 'SCM literal 014B offset 274205, PCJ-600, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(128, 'offline_exact_ls', 'offline_exact_ls', 573, -1, -1, 1091.89, 1612.63, 13, 206.758, 0, 0, 300, 0, 1, 'SCM literal 014B offset 274262, Dune, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(129, 'offline_exact_ls', 'offline_exact_ls', 412, -1, -1, 1772.66, -2096.59, 13.99, 182.758, 0, 0, 300, 0, 1, 'SCM literal 014B offset 274312, Voodoo, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(130, 'offline_exact_ls', 'offline_exact_ls', 515, -1, -1, -2000.24, -2415.51, 29.767, -132, 0, 0, 300, 0, 1, 'SCM literal 014B offset 274509, Roadtrain, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(131, 'offline_exact_ls', 'offline_exact_ls', 578, -1, -1, -1969.81, -2437.94, 29.767, -82.5, 0, 0, 300, 0, 1, 'SCM literal 014B offset 274552, DFT-30, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44'),
	(132, 'offline_exact_ls', 'offline_exact_ls', 530, -1, -1, -1969.81, -2443.91, 29.767, -19, 0, 0, 300, 0, 1, 'SCM literal 014B offset 274595, Forklift, original_delay=0, alarm=0, door=0', '2026-06-02 06:13:44');

-- Dumping structure for table lsif_db.players
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.players: ~6 rows (approximately)
INSERT INTO `players` (`id`, `username`, `password_hash`, `money`, `bank_money`, `xp`, `level`, `admin_level`, `skin`, `current_job`, `spawn_house`, `starter_pack_claimed`, `weapon_license`, `pos_x`, `pos_y`, `pos_z`, `pos_a`, `pos_interior`, `pos_virtual_world`, `last_ip`, `last_login`, `created_at`, `updated_at`) VALUES
	(1, 'Novanov', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 924472, 5000, 3213, 5, 5, 0, 2, 0, 1, 1, 2034.78, -1420.57, 16.9922, 131.735, 0, 0, '192.168.10.13', '2026-06-05 07:08:58', '2026-05-24 02:45:13', '2026-06-05 07:12:08'),
	(2, 'nutrisari', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 1001490, 0, 111, 5, 0, 0, 4, 0, 0, 1, 2193.47, -1703.53, 13.5788, 62.3512, 0, 0, '192.168.10.16', '2026-06-01 11:35:31', '2026-05-25 10:43:39', '2026-06-01 11:44:43'),
	(3, 'user', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 901000, 0, 0, 1, 0, 0, 0, 0, 0, 1, 828.706, -860.883, 69.9219, 347.71, 0, 0, '192.168.5.71', '2026-05-26 16:09:19', '2026-05-26 14:49:46', '2026-05-26 16:12:22'),
	(4, 'HydriZ', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 500, 0, 0, 1, 0, 0, 0, 0, 0, 1, 2490.67, -1666.8, 13.3438, 210.962, 0, 0, '182.6.80.195', '2026-06-04 15:54:11', '2026-05-27 14:07:38', '2026-06-04 15:56:49'),
	(5, 'akunbaru', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 1164369, 500, 381, 1, 0, 0, 1, 0, 1, 1, 1348.81, -1289.1, 13.3828, 163.824, 0, 0, '192.168.10.13', '2026-05-28 05:29:17', '2026-05-28 03:15:07', '2026-05-28 05:29:33'),
	(6, 'mizuukii', 'e896df5212322d5fb5295f94e2e18a04722ad6bd935498b2e2c97d108f1accc9', 10300, 0, 100, 1, 3, 0, 0, 0, 0, 1, 2302.43, -1654.63, 14.5135, 1.22477, 0, 0, '61.5.25.123', '2026-06-04 16:31:30', '2026-06-04 15:57:38', '2026-06-04 16:50:47');

-- Dumping structure for table lsif_db.player_businesses
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.player_businesses: ~1 rows (approximately)
INSERT INTO `player_businesses` (`id`, `owner_id`, `business_index`, `business_name`, `price`, `income_per_minute`, `business_level`, `total_collected`, `pos_x`, `pos_y`, `pos_z`, `last_collected`, `created_at`, `updated_at`) VALUES
	(2, 1, 0, 'Idlewood Mini Market', 80000, 120, 2, 3600, 1833.11, -1842.99, 13.5781, '2026-05-27 06:34:35', '2026-05-27 06:19:05', '2026-05-27 06:34:35');

-- Dumping structure for table lsif_db.player_houses
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.player_houses: ~2 rows (approximately)
INSERT INTO `player_houses` (`id`, `owner_id`, `house_index`, `house_name`, `price`, `locked`, `pos_x`, `pos_y`, `pos_z`, `created_at`, `updated_at`) VALUES
	(4, 1, 4, 'Richman Small Villa', 250000, 1, 827.924, -858.105, 70.3308, '2026-05-26 15:00:25', '2026-05-26 15:00:32'),
	(6, 5, 1, 'Idlewood Family House', 75000, 1, 2362.77, -1643.11, 13.5234, '2026-05-28 04:50:56', '2026-05-28 04:51:37');

-- Dumping structure for table lsif_db.player_vehicles
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.player_vehicles: ~3 rows (approximately)
INSERT INTO `player_vehicles` (`id`, `owner_id`, `slot`, `model_id`, `vehicle_name`, `color1`, `color2`, `pos_x`, `pos_y`, `pos_z`, `pos_a`, `health`, `fuel`, `locked`, `created_at`, `updated_at`) VALUES
	(5, 1, 2, 411, 'Infernus Joz', 1, 1, 2133, -1118.22, 25.0331, 327.555, 1000, 81, 0, '2026-05-27 11:13:37', '2026-05-27 14:04:02'),
	(6, 1, 3, 482, 'Vehicle', 1, 1, 2161.33, -1172.46, 23.9439, 88.1793, 1000, 100, 1, '2026-05-27 11:15:33', '2026-05-27 11:17:19'),
	(7, 5, 1, 420, 'Taxi', 1, 1, 2135.08, -1149.57, 24.2556, 153.917, 1000, 96, 0, '2026-05-28 03:23:32', '2026-05-28 03:27:41');

-- Dumping structure for table lsif_db.player_weapons
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.player_weapons: ~0 rows (approximately)

-- Dumping structure for table lsif_db.public_interiors
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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.public_interiors: ~40 rows (approximately)
INSERT INTO `public_interiors` (`id`, `interior_type`, `display_name`, `exterior_x`, `exterior_y`, `exterior_z`, `exterior_a`, `exterior_spawn_x`, `exterior_spawn_y`, `exterior_spawn_z`, `exterior_spawn_a`, `exterior_pickup_model`, `interior_pickup_model`, `exterior_interior`, `exterior_virtual_world`, `interior_id`, `interior_virtual_world`, `interior_x`, `interior_y`, `interior_z`, `interior_a`, `exit_x`, `exit_y`, `exit_z`, `source_tag`, `enabled`, `created_at`, `updated_at`, `service_x`, `service_y`, `service_z`, `service_radius`, `exit_a`, `service_a`, `exterior_map_icon`) VALUES
	(1, 'burgershot', 'Burger Shot', 2397.84, -1898.53, 13.5469, 182.864, 2397.84, -1898.53, 13.5469, 182.864, 1318, 1318, 0, 0, 10, 43001, 363.135, -72.6465, 1001.51, 315, 363.135, -74.8465, 1001.51, 'manual', 0, '2026-06-02 04:26:00', '2026-06-04 05:33:43', 0, 0, 0, 0, 315, 315, 10),
	(2, 'burgershot', 'Burger Shot', 2105.45, -1807.45, 13.5547, 274.709, 2105.45, -1807.45, 13.5547, 274.709, 1318, 1318, 0, 0, 10, 43002, 363.135, -72.6465, 1001.51, 315, 363.135, -74.8465, 1001.51, 'manual', 0, '2026-06-02 04:26:47', '2026-06-04 05:33:43', 0, 0, 0, 0, 315, 315, 10),
	(3, 'ammunation', 'Ammu-Nation', 2070.94, -1793.85, 13.5533, 85.4592, 2070.94, -1793.85, 13.5533, 85.4592, 1318, 1318, 0, 0, 1, 43003, 288.349, -40.6443, 1001.52, 90, 286.149, -40.6443, 1001.52, 'manual', 0, '2026-06-02 04:27:30', '2026-06-04 05:33:43', 0, 0, 0, 0, 90, 90, 6),
	(4, '247', '24/7 Supermarket', 2069.09, -1780.03, 13.5594, 75.8657, 2069.09, -1780.03, 13.5594, 75.8657, 1318, 1318, 0, 0, 17, 43004, -25.8845, -183.669, 1003.55, 0, -25.8845, -185.869, 1003.55, 'manual', 0, '2026-06-02 04:28:04', '2026-06-03 11:45:10', 0, 0, 0, 0, 0, 0, 52),
	(5, 'cluckinbell', 'Cluckin\' Bell', 2124.34, -1854.9, 3.98438, 141.091, 2124.34, -1854.9, 3.98438, 141.091, 1318, 1318, 0, 0, 9, 43005, 364.958, -9.5446, 1001.85, 0, 364.958, -11.7446, 1001.85, 'manual', 0, '2026-06-02 04:40:12', '2026-06-04 05:33:43', 0, 0, 0, 0, 0, 0, 10),
	(6, 'pizzastack', 'Pizza Stack', 2121.4, -1855.06, 3.98438, 0, 2121.4, -1855.06, 3.98438, 0, 1318, 1318, 0, 0, 5, 43006, 372.352, -131.325, 1001.49, 0, 372.352, -133.525, 1001.49, 'manual', 0, '2026-06-02 04:40:19', '2026-06-04 05:33:43', 0, 0, 0, 0, 0, 0, 10),
	(7, 'gym', 'Gym', 2118.65, -1854.35, 3.98438, 90, 2118.65, -1854.35, 3.98438, 90, 1318, 1318, 0, 0, 5, 43007, 774.312, -3.8986, 1000.73, 90, 772.112, -3.8986, 1000.73, 'manual', 0, '2026-06-02 04:40:25', '2026-06-03 11:45:10', 0, 0, 0, 0, 90, 90, 52),
	(8, 'barber', 'Barber Shop', 2115.42, -1854.7, 3.98438, 90, 2115.42, -1854.7, 3.98438, 90, 1318, 1318, 0, 0, 2, 43008, 411.626, -19.2333, 1001.8, 0, 411.626, -21.4333, 1001.8, 'manual', 0, '2026-06-02 04:40:33', '2026-06-04 05:33:43', 413.943, -17.8315, 1001.8, 0, 0, 271.204, 7),
	(9, 'tattoo', 'Tattoo Shop', 2113.1, -1854.17, 3.98438, 90, 2113.1, -1854.17, 3.98438, 90, 1318, 1318, 0, 0, 16, 43009, -204.44, -24.2539, 1002.27, 0, -204.44, -26.4539, 1002.27, 'manual', 0, '2026-06-02 04:40:41', '2026-06-04 05:33:43', 0, 0, 0, 0, 0, 0, 39),
	(10, 'police', 'Police Department', 2111.24, -1853.74, 3.98438, 90, 2111.24, -1853.74, 3.98438, 90, 1318, 1318, 0, 0, 6, 43010, 246.784, 66.1001, 1003.64, 0, 246.784, 63.9001, 1003.64, 'manual', 0, '2026-06-02 04:40:47', '2026-06-04 05:33:43', 0, 0, 0, 0, 0, 0, 30),
	(11, 'hospital', 'Hospital', 2109.41, -1853.4, 3.98438, 90, 2109.41, -1853.4, 3.98438, 90, 1318, 1318, 0, 0, 3, 43011, 390.77, 176.004, 1008.38, 0, 390.77, 173.804, 1008.38, 'manual', 0, '2026-06-02 04:40:53', '2026-06-04 05:33:43', 0, 0, 0, 0, 0, 0, 22),
	(12, 'cityhall', 'City Hall', 2106.97, -1853.34, 3.98438, 237.887, 2106.97, -1853.34, 3.98438, 237.887, 1318, 1318, 0, 0, 3, 43012, 386.526, 175.838, 1008.38, 0, 386.526, 173.638, 1008.38, 'manual', 0, '2026-06-02 04:41:16', '2026-06-03 11:45:10', 0, 0, 0, 0, 0, 0, 52),
	(13, 'casino', 'Casino', 2103.78, -1853.09, 3.98438, 79.4998, 2103.78, -1853.09, 3.98438, 79.4998, 1318, 1318, 0, 0, 1, 43013, 2233.94, 1709.6, 1011.63, 180, 2233.94, 1711.8, 1011.63, 'manual', 0, '2026-06-02 04:41:24', '2026-06-03 11:45:10', 0, 0, 0, 0, 180, 180, 52),
	(14, 'ammunation', 'Ammu-Nation (AMMUN1)', 1368.94, -1279.78, 13.5469, 90.4143, 1366.81, -1279.95, 13.5469, 90.5172, 1318, 1318, 0, 0, 1, 43014, 288.033, -37.4345, 1001.52, 257.623, 285.402, -41.7421, 1001.52, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-03 16:30:54', 296.471, -38.4755, 1001.52, 0, 257.623, 174.777, 6),
	(15, 'ammunation', 'Ammu-Nation (AMMUN2)', 242.668, -178.478, 0.621441, 90.097, 242.668, -178.478, 0.621441, 90.097, 1318, 1318, 0, 0, 4, 43015, 285.801, -84.5476, 1000.54, 354.27, 285.801, -85.4476, 1000.54, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 0, 0, 0, 0, 354.27, 354.27, 6),
	(16, 'ammunation', 'Ammu-Nation (AMMUN2)', 2333.43, 61.5173, 25.7342, 270, 2333.43, 61.5173, 25.7342, 270, 1318, 1318, 0, 0, 4, 43016, 285.801, -84.5476, 1000.54, 354.27, 285.801, -85.4476, 1000.54, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 0, 0, 0, 0, 354.27, 354.27, 6),
	(17, 'ammunation', 'Ammu-Nation (AMMUN3)', 2400.53, -1981.98, 13.5469, 357.946, 2400.5, -1980.38, 13.5469, 2.31156, 1318, 1318, 0, 0, 6, 43017, 296.472, -109.989, 1001.52, 88.9408, 296.964, -112.008, 1001.52, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 290.255, -109.78, 1001.52, 0, 3.96635, 179.67, 6),
	(18, '247', '24/7 Supermarket (X7_11S)', 1352.31, -1758.3, 12.5149, 359.74, 1352.31, -1758.3, 12.5149, 359.74, 1318, 1318, 0, 0, 6, 43018, -26.6916, -55.7149, 1002.55, 0, -26.6916, -57.8149, 1002.55, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-03 11:45:10', 0, 0, 0, 0, 0, 0, 52),
	(19, '247', '24/7 Supermarket (X7_11B)', 1833.55, -1842.56, 13.5781, 94.2071, 1831.6, -1842.62, 13.5781, 85.6582, 1318, 1318, 0, 0, 18, 43019, -31.5785, -90.248, 1003.55, 297.62, -31.0038, -91.9946, 1003.55, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 16:28:00', 0, 0, 0, 0, 0.637965, 0, 52),
	(20, '247', '24/7 Supermarket (X7_11B)', 1315.49, -897.843, 38.571, 180, 1315.49, -897.843, 38.571, 180, 1318, 1318, 0, 0, 18, 43020, -30.9467, -89.6096, 1002.55, 0, -30.9467, -91.7096, 1002.55, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-03 11:45:10', 0, 0, 0, 0, 0, 0, 52),
	(21, '247', '24/7 Supermarket (X711S2)', 1000.33, -919.924, 41.2368, 97, 1000.33, -919.924, 41.2368, 97, 1318, 1318, 0, 0, 4, 43021, -27.3123, -29.2776, 1002.55, 0, -27.3123, -31.3776, 1002.55, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-03 11:45:10', 0, 0, 0, 0, 0, 0, 52),
	(22, 'burgershot', 'Burger Shot (FDBURG)', 811.982, -1616.02, 12.618, 270.42, 811.982, -1616.02, 12.618, 270.42, 1318, 1318, 0, 0, 10, 43022, 363.413, -74.5787, 1000.55, 314.7, 363.113, -74.8787, 1000.55, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 0, 0, 0, 0, 314.7, 314.7, 10),
	(23, 'burgershot', 'Burger Shot (FDBURG)', 1199.13, -918.071, 42.3243, 180, 1199.13, -918.071, 42.3243, 180, 1318, 1318, 0, 0, 10, 43023, 363.413, -74.5787, 1000.55, 314.7, 363.113, -74.8787, 1000.55, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 0, 0, 0, 0, 314.7, 314.7, 10),
	(24, 'cluckinbell', 'Cluckin\' Bell (FDCHICK)', 2419.95, -1509.8, 23.1568, 270, 2419.95, -1509.8, 23.1568, 270, 1318, 1318, 0, 0, 9, 43024, 365.673, -10.7132, 1000.87, 354.27, 365.673, -11.6132, 1000.87, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 0, 0, 0, 0, 354.27, 354.27, 10),
	(25, 'cluckinbell', 'Cluckin\' Bell (FDCHICK)', 2397.75, -1899.16, 13.5469, 353.038, 2398.02, -1897.57, 13.5469, 5.08538, 1318, 1318, 0, 0, 9, 43025, 365.165, -9.9433, 1001.85, 319.168, 364.935, -11.7956, 1001.85, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 12:37:50', 0, 0, 0, 0, 352.514, 354.27, 10),
	(26, 'cluckinbell', 'Cluckin\' Bell (FDCHICK)', 928.525, -1352.77, 12.4344, 90, 928.525, -1352.77, 12.4344, 90, 1318, 1318, 0, 0, 9, 43026, 365.673, -10.7132, 1000.87, 354.27, 365.673, -11.6132, 1000.87, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 0, 0, 0, 0, 354.27, 354.27, 10),
	(27, 'pizzastack', 'Pizza Stack (FDPIZA)', 1367.27, 248.388, 18.6229, 69.0975, 1367.27, 248.388, 18.6229, 69.0975, 1318, 1318, 0, 0, 5, 43027, 372.352, -131.651, 1000.45, 354.27, 372.352, -133.551, 1000.45, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 0, 0, 0, 0, 354.27, 354.27, 10),
	(28, 'pizzastack', 'Pizza Stack (FDPIZA)', 2333.43, 75.0488, 25.7342, 270, 2333.43, 75.0488, 25.7342, 270, 1318, 1318, 0, 0, 5, 43028, 372.352, -131.651, 1000.45, 354.27, 372.352, -133.551, 1000.45, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 0, 0, 0, 0, 354.27, 354.27, 10),
	(29, 'pizzastack', 'Pizza Stack (FDPIZA)', 203.334, -202.532, 0.600709, 180, 203.334, -202.532, 0.600709, 180, 1318, 1318, 0, 0, 5, 43029, 372.352, -131.651, 1000.45, 354.27, 372.352, -133.551, 1000.45, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 0, 0, 0, 0, 354.27, 354.27, 10),
	(30, 'pizzastack', 'Pizza Stack (FDPIZA)', 2105.32, -1806.49, 12.6941, 92, 2105.32, -1806.49, 12.6941, 92, 1318, 1318, 0, 0, 5, 43030, 372.352, -131.651, 1000.45, 354.27, 372.352, -133.551, 1000.45, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 0, 0, 0, 0, 354.27, 354.27, 10),
	(31, 'gym', 'Gym (GYM1)', 2229.63, -1721.63, 12.6529, 137, 2229.63, -1721.63, 12.6529, 137, 1318, 1318, 0, 0, 5, 43031, 772.112, -3.89865, 999.688, 0, 772.112, -4.99865, 999.688, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-03 11:45:10', 0, 0, 0, 0, 0, 0, 52),
	(32, 'barber', 'Barber Shop (BARBERS)', 2070.86, -1793.84, 12.661, 270, 2070.86, -1793.84, 12.661, 270, 1318, 1318, 0, 0, 2, 43032, 411.626, -21.4333, 1000.8, 0, 411.626, -23.3333, 1000.8, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 413.904, -18.0051, 1001.8, 0, 0, 269.818, 7),
	(33, 'barber', 'Barber Shop (BARBER2)', 672.355, -496.834, 15.3751, 271.098, 672.355, -496.834, 15.3751, 271.098, 1318, 1318, 0, 0, 3, 43033, 418.653, -82.6398, 1000.96, 0, 418.653, -84.1398, 1000.96, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 0, 0, 0, 0, 0, 0, 7),
	(34, 'barber', 'Barber Shop (BARBER2)', 823.629, -1588.9, 12.5764, 142.42, 823.629, -1588.9, 12.5764, 142.42, 1318, 1318, 0, 0, 3, 43034, 418.653, -82.6398, 1000.96, 0, 418.653, -84.1398, 1000.96, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 0, 0, 0, 0, 0, 0, 7),
	(35, 'barber', 'Barber Shop (BARBER3)', 2723.76, -2026.72, 12.5753, 90, 2723.76, -2026.72, 12.5753, 90, 1318, 1318, 0, 0, 12, 43035, 412.022, -52.6499, 1000.96, 0, 412.022, -54.5499, 1000.96, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 0, 0, 0, 0, 0, 0, 7),
	(36, 'tattoo', 'Tattoo Shop (TATTOO)', 2068.71, -1779.84, 12.5103, 270, 2068.71, -1779.84, 12.5103, 270, 1318, 1318, 0, 0, 16, 43036, -204.44, -26.454, 1001.3, 0, -204.44, -27.154, 1001.3, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 0, 0, 0, 0, 0, 0, 39),
	(37, 'tattoo', 'Tattoo Shop (TATTOO)', 1975.79, -2036.65, 12.5753, 90, 1975.79, -2036.65, 12.5753, 90, 1318, 1318, 0, 0, 16, 43037, -204.44, -26.454, 1001.3, 0, -204.44, -27.154, 1001.3, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 0, 0, 0, 0, 0, 0, 39),
	(38, 'police', 'Police Department (POLICE1)', 627.642, -571.789, 16.907, 274.098, 627.642, -571.789, 16.907, 274.098, 1318, 1318, 0, 0, 6, 43038, 246.784, 63.9002, 1002.64, 0, 246.784, 62.2002, 1002.64, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 0, 0, 0, 0, 0, 0, 30),
	(39, 'police', 'Police Department (POLICE1)', 1554.95, -1674.99, 15.3283, 90, 1554.95, -1674.99, 15.3283, 90, 1318, 1318, 0, 0, 6, 43039, 246.784, 63.9002, 1002.64, 0, 246.784, 62.2002, 1002.64, 'offline_exact_public', 1, '2026-06-02 10:44:33', '2026-06-04 05:33:43', 0, 0, 0, 0, 0, 0, 30),
	(42, 'police', 'Police Department', 1359.06, -1287.52, 13.2759, 202.355, 1359.06, -1287.52, 13.2759, 202.355, 1318, 1318, 0, 0, 6, 43042, 246.784, 66.1001, 1003.64, 0, 246.784, 63.9001, 1003.64, 'manual', 0, '2026-06-04 05:39:02', '2026-06-04 05:40:48', 0, 0, 0, 0, 0, 0, 30);

-- Dumping structure for table lsif_db.public_interior_import_queue
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.public_interior_import_queue: ~26 rows (approximately)
INSERT INTO `public_interior_import_queue` (`id`, `interior_type`, `display_name`, `exterior_x`, `exterior_y`, `exterior_z`, `exterior_a`, `exterior_interior`, `exterior_virtual_world`, `interior_id`, `interior_x`, `interior_y`, `interior_z`, `interior_a`, `exit_x`, `exit_y`, `exit_z`, `source_file`, `source_ref`, `source_tag`, `enabled`, `imported`, `created_at`) VALUES
	(1, 'ammunation', 'Ammu-Nation (AMMUN1)', 1368.35, -1279.06, 12.55, 90, 0, 0, 1, 286.149, -40.6444, 1000.57, 354.27, 286.149, -41.5444, 1000.57, 'maps/LA/LAn2.ipl', 'AMMUN1', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(2, 'ammunation', 'Ammu-Nation (AMMUN2)', 242.668, -178.478, 0.621441, 90.097, 0, 0, 4, 285.801, -84.5476, 1000.54, 354.27, 285.801, -85.4476, 1000.54, 'maps/country/countrye.ipl', 'AMMUN2', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(3, 'ammunation', 'Ammu-Nation (AMMUN2)', 2333.43, 61.5173, 25.7342, 270, 0, 0, 4, 285.801, -84.5476, 1000.54, 354.27, 285.801, -85.4476, 1000.54, 'maps/country/countrye.ipl', 'AMMUN2', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(4, 'ammunation', 'Ammu-Nation (AMMUN3)', 2400.5, -1981.48, 12.5604, 0, 0, 0, 6, 296.92, -111.072, 1000.57, 354.27, 296.92, -111.972, 1000.57, 'maps/LA/LAs2.ipl', 'AMMUN3', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(5, '247', '24/7 Supermarket (X7_11S)', 1352.31, -1758.3, 12.5149, 359.74, 0, 0, 6, -26.6916, -55.7149, 1002.55, 0, -26.6916, -57.8149, 1002.55, 'maps/LA/LAn.ipl', 'X7_11S', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(6, '247', '24/7 Supermarket (X7_11B)', 1833.54, -1843.38, 12.5595, 90, 0, 0, 18, -30.9467, -89.6096, 1002.55, 0, -30.9467, -91.7096, 1002.55, 'maps/LA/LAs.ipl', 'X7_11B', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(7, '247', '24/7 Supermarket (X7_11B)', 1315.49, -897.843, 38.571, 180, 0, 0, 18, -30.9467, -89.6096, 1002.55, 0, -30.9467, -91.7096, 1002.55, 'maps/LA/LaWn.ipl', 'X7_11B', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(8, '247', '24/7 Supermarket (X711S2)', 1000.33, -919.924, 41.2368, 97, 0, 0, 4, -27.3123, -29.2776, 1002.55, 0, -27.3123, -31.3776, 1002.55, 'maps/LA/LaWn.ipl', 'X711S2', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(9, 'burgershot', 'Burger Shot (FDBURG)', 811.982, -1616.02, 12.618, 270.42, 0, 0, 10, 363.413, -74.5787, 1000.55, 314.7, 363.113, -74.8787, 1000.55, 'maps/LA/LAw.ipl', 'FDBURG', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(10, 'burgershot', 'Burger Shot (FDBURG)', 1199.13, -918.071, 42.3243, 180, 0, 0, 10, 363.413, -74.5787, 1000.55, 314.7, 363.113, -74.8787, 1000.55, 'maps/LA/LaWn.ipl', 'FDBURG', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(11, 'cluckinbell', 'Cluckin\' Bell (FDCHICK)', 2419.95, -1509.8, 23.1568, 270, 0, 0, 9, 365.673, -10.7132, 1000.87, 354.27, 365.673, -11.6132, 1000.87, 'maps/LA/LAe2.ipl', 'FDCHICK', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(12, 'cluckinbell', 'Cluckin\' Bell (FDCHICK)', 2397.83, -1898.65, 12.7131, 0, 0, 0, 9, 365.673, -10.7132, 1000.87, 354.27, 365.673, -11.6132, 1000.87, 'maps/LA/LAs2.ipl', 'FDCHICK', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(13, 'cluckinbell', 'Cluckin\' Bell (FDCHICK)', 928.525, -1352.77, 12.4344, 90, 0, 0, 9, 365.673, -10.7132, 1000.87, 354.27, 365.673, -11.6132, 1000.87, 'maps/LA/LaWn.ipl', 'FDCHICK', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(14, 'pizzastack', 'Pizza Stack (FDPIZA)', 1367.27, 248.388, 18.6229, 69.0975, 0, 0, 5, 372.352, -131.651, 1000.45, 354.27, 372.352, -133.551, 1000.45, 'maps/country/countrye.ipl', 'FDPIZA', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(15, 'pizzastack', 'Pizza Stack (FDPIZA)', 2333.43, 75.0488, 25.7342, 270, 0, 0, 5, 372.352, -131.651, 1000.45, 354.27, 372.352, -133.551, 1000.45, 'maps/country/countrye.ipl', 'FDPIZA', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(16, 'pizzastack', 'Pizza Stack (FDPIZA)', 203.334, -202.532, 0.600709, 180, 0, 0, 5, 372.352, -131.651, 1000.45, 354.27, 372.352, -133.551, 1000.45, 'maps/country/countrye.ipl', 'FDPIZA', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(17, 'pizzastack', 'Pizza Stack (FDPIZA)', 2105.32, -1806.49, 12.6941, 92, 0, 0, 5, 372.352, -131.651, 1000.45, 354.27, 372.352, -133.551, 1000.45, 'maps/LA/LAe.ipl', 'FDPIZA', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(18, 'gym', 'Gym (GYM1)', 2229.63, -1721.63, 12.6529, 137, 0, 0, 5, 772.112, -3.89865, 999.688, 0, 772.112, -4.99865, 999.688, 'maps/LA/LAe2.ipl', 'GYM1', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(19, 'barber', 'Barber Shop (BARBERS)', 2070.86, -1793.84, 12.661, 270, 0, 0, 2, 411.626, -21.4333, 1000.8, 0, 411.626, -23.3333, 1000.8, 'maps/LA/LAe.ipl', 'BARBERS', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(20, 'barber', 'Barber Shop (BARBER2)', 672.355, -496.834, 15.3751, 271.098, 0, 0, 3, 418.653, -82.6398, 1000.96, 0, 418.653, -84.1398, 1000.96, 'maps/country/countrye.ipl', 'BARBER2', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(21, 'barber', 'Barber Shop (BARBER2)', 823.629, -1588.9, 12.5764, 142.42, 0, 0, 3, 418.653, -82.6398, 1000.96, 0, 418.653, -84.1398, 1000.96, 'maps/LA/LAw.ipl', 'BARBER2', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(22, 'barber', 'Barber Shop (BARBER3)', 2723.76, -2026.72, 12.5753, 90, 0, 0, 12, 412.022, -52.6499, 1000.96, 0, 412.022, -54.5499, 1000.96, 'maps/LA/LAs2.ipl', 'BARBER3', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(23, 'tattoo', 'Tattoo Shop (TATTOO)', 2068.71, -1779.84, 12.5103, 270, 0, 0, 16, -204.44, -26.454, 1001.3, 0, -204.44, -27.154, 1001.3, 'maps/LA/LAe.ipl', 'TATTOO', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(24, 'tattoo', 'Tattoo Shop (TATTOO)', 1975.79, -2036.65, 12.5753, 90, 0, 0, 16, -204.44, -26.454, 1001.3, 0, -204.44, -27.154, 1001.3, 'maps/LA/LAs2.ipl', 'TATTOO', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(25, 'police', 'Police Department (POLICE1)', 627.642, -571.789, 16.907, 274.098, 0, 0, 6, 246.784, 63.9002, 1002.64, 0, 246.784, 62.2002, 1002.64, 'maps/country/countrye.ipl', 'POLICE1', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51'),
	(26, 'police', 'Police Department (POLICE1)', 1554.95, -1674.99, 15.3283, 90, 0, 0, 6, 246.784, 63.9002, 1002.64, 0, 246.784, 62.2002, 1002.64, 'maps/LA/LAn.ipl', 'POLICE1', 'offline_exact_public', 1, 1, '2026-06-02 10:41:51');

-- Dumping structure for table lsif_db.public_service_config
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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.public_service_config: ~37 rows (approximately)
INSERT INTO `public_service_config` (`id`, `service_type`, `service_key`, `display_name`, `price`, `health_add`, `armor_add`, `xp_reward`, `wanted_reduce`, `enabled`, `sort_order`, `created_at`, `updated_at`) VALUES
	(1, '247', 'sprunk', 'Sprunk', 25, 5, 0, 0, 0, 1, 1, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(2, '247', 'snack', 'Snack', 35, 8, 0, 0, 0, 1, 2, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(3, '247', 'first_aid', 'First Aid', 150, 25, 0, 0, 0, 1, 3, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(4, '247', 'armor_vest', 'Armor Vest', 600, 0, 25, 0, 0, 1, 4, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(5, 'burgershot', 'kids_meal', 'Moo Kids Meal', 45, 10, 0, 0, 0, 1, 1, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(6, 'burgershot', 'beef_tower', 'Beef Tower', 80, 20, 0, 0, 0, 1, 2, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(7, 'burgershot', 'meat_stack', 'Meat Stack', 120, 35, 0, 0, 0, 1, 3, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(8, 'burgershot', 'big_meal', 'Burger Shot Big Meal', 160, 50, 0, 0, 0, 1, 4, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(9, 'cluckinbell', 'little_meal', 'Cluckin\' Little Meal', 45, 10, 0, 0, 0, 1, 1, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(10, 'cluckinbell', 'big_meal', 'Cluckin\' Big Meal', 80, 20, 0, 0, 0, 1, 2, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(11, 'cluckinbell', 'huge_meal', 'Cluckin\' Huge Meal', 120, 35, 0, 0, 0, 1, 3, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(12, 'cluckinbell', 'salad_meal', 'Salad Meal', 90, 18, 0, 0, 0, 1, 4, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(13, 'pizzastack', 'pizza_slice', 'Pizza Slice', 40, 10, 0, 0, 0, 1, 1, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(14, 'pizzastack', 'small_pizza', 'Small Pizza', 75, 20, 0, 0, 0, 1, 2, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(15, 'pizzastack', 'full_rack', 'Full Rack', 120, 35, 0, 0, 0, 1, 3, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(16, 'pizzastack', 'buster_meal', 'Buster Meal', 160, 50, 0, 0, 0, 1, 4, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(17, 'gym', 'light_training', 'Light Training', 100, 0, 0, 10, 0, 1, 1, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(18, 'gym', 'boxing', 'Boxing Session', 150, 5, 0, 15, 0, 1, 2, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(19, 'gym', 'full_workout', 'Full Workout', 250, 10, 0, 25, 0, 1, 3, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(20, 'barber', 'basic', 'Basic Haircut', 150, 0, 0, 0, 0, 1, 1, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(21, 'barber', 'clean_cut', 'Clean Cut', 250, 0, 0, 0, 0, 1, 2, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(22, 'barber', 'premium', 'Premium Style', 500, 0, 0, 0, 0, 1, 3, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(23, 'tattoo', 'small', 'Small Tattoo', 250, 0, 0, 0, 0, 1, 1, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(24, 'tattoo', 'gang', 'Gang Tattoo', 500, 0, 0, 0, 0, 1, 2, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(25, 'tattoo', 'full_body', 'Full Body Tattoo', 1000, 0, 0, 0, 0, 1, 3, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(26, 'hospital', 'checkup', 'Medical Checkup', 150, 35, 0, 0, 0, 1, 1, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(27, 'hospital', 'emergency', 'Emergency Treatment', 350, 100, 0, 0, 0, 1, 2, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(28, 'hospital', 'armor_patch', 'Armor Patch', 500, 0, 20, 0, 0, 1, 3, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(29, 'police', 'wanted_status', 'Ask Wanted Status', 0, 0, 0, 0, 0, 1, 1, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(30, 'police', 'small_fine', 'Pay Small Fine', 500, 0, 0, 0, 1, 1, 2, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(31, 'police', 'safety_info', 'Public Safety Info', 0, 0, 0, 0, 0, 1, 3, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(32, 'cityhall', 'citizen_info', 'Citizen Service Info', 0, 0, 0, 0, 0, 1, 1, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(33, 'cityhall', 'permit_info', 'Business Permit Info', 0, 0, 0, 0, 0, 1, 2, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(34, 'cityhall', 'license_info', 'License Info', 0, 0, 0, 0, 0, 1, 3, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(35, 'casino', 'casino_info', 'Casino Info', 0, 0, 0, 0, 0, 1, 1, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(36, 'casino', 'lucky_snack', 'Lucky Snack', 100, 10, 0, 0, 0, 1, 2, '2026-06-02 12:25:54', '2026-06-02 12:25:54'),
	(37, 'casino', 'vip_service', 'VIP Service Placeholder', 1000, 0, 0, 20, 0, 1, 3, '2026-06-02 12:25:54', '2026-06-02 12:25:54');

-- Dumping structure for table lsif_db.race_records
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.race_records: ~2 rows (approximately)
INSERT INTO `race_records` (`id`, `player_id`, `race_code`, `best_time_ms`, `total_finishes`, `created_at`, `updated_at`) VALUES
	(1, 1, 'ls_intro', 77103, 3, '2026-05-25 12:14:13', '2026-05-25 13:39:46'),
	(4, 5, 'ls_intro', 35898, 1, '2026-05-28 03:31:21', NULL);

-- Dumping structure for table lsif_db.reports
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.reports: ~1 rows (approximately)
INSERT INTO `reports` (`id`, `reporter_id`, `reporter_name`, `target_id`, `target_name`, `reason`, `status`, `handled_by_id`, `handled_by_name`, `close_note`, `closed_at`, `created_at`) VALUES
	(1, 2, 'nutrisari', 1, 'Novanov', 'admin jelek', 'closed', 1, 'Novanov', 'kamu yang jelek', '2026-05-25 11:57:18', '2026-05-25 11:56:47');

-- Dumping structure for table lsif_db.saif_archive_parked_vehicles
CREATE TABLE IF NOT EXISTS `saif_archive_parked_vehicles` (
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
  `archived_at` timestamp NULL DEFAULT current_timestamp(),
  `archive_reason` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_parked_enabled` (`enabled`),
  KEY `idx_parked_model` (`modelid`),
  KEY `idx_parked_source_tag` (`source_tag`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.saif_archive_parked_vehicles: ~50 rows (approximately)
INSERT INTO `saif_archive_parked_vehicles` (`id`, `modelid`, `color1`, `color2`, `pos_x`, `pos_y`, `pos_z`, `pos_a`, `interior`, `virtual_world`, `respawn_delay`, `locked`, `enabled`, `source_tag`, `created_at`, `updated_at`, `archived_at`, `archive_reason`) VALUES
	(3, 420, 6, 1, 1777.52, -1905.11, 13.23, 270, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(4, 420, 6, 1, 1784.65, -1905.12, 13.23, 270, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(5, 420, 6, 1, 1467.8, -1738.6, 13.28, 0, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(6, 420, 6, 1, 1480.4, -1738.7, 13.28, 0, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(7, 420, 6, 1, 1098.5, -1749.2, 13.25, 90, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(8, 431, 3, 3, 1807.3, -1894.4, 13.42, 90, 0, 0, 420, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(9, 431, 3, 3, 1814.9, -1894.3, 13.42, 90, 0, 0, 420, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(10, 437, 1, 1, 1822.5, -1894, 13.42, 90, 0, 0, 420, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(11, 438, 6, 6, 1768.2, -1862.3, 13.32, 180, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(12, 438, 6, 6, 1759.7, -1862.3, 13.32, 180, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(13, 492, 86, 86, 2491.9, -1682.7, 13.25, 90, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(14, 567, 86, 86, 2512.2, -1673.4, 13.25, 45, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(15, 466, 86, 86, 2475.2, -1648.8, 13.25, 180, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(16, 536, 85, 85, 2122.7, -1128.4, 25.2, 270, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(17, 575, 85, 85, 2133.1, -1149.5, 24.95, 90, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(18, 412, 6, 6, 2242.7, -1468.5, 23.65, 180, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(19, 534, 6, 6, 2261.5, -1436.7, 23.65, 0, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(20, 566, 93, 93, 2396.8, -1226.4, 23.65, 270, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(21, 567, 93, 93, 2410.3, -1221.9, 23.65, 90, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(22, 576, 93, 93, 2424.1, -1244.6, 23.65, 180, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(23, 596, 0, 1, 1535.6, -1678.8, 13.2, 90, 0, 0, 420, 1, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(24, 596, 0, 1, 1544.1, -1684.8, 13.2, 90, 0, 0, 420, 1, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(25, 523, 0, 1, 1565.1, -1694.1, 5.65, 180, 0, 0, 420, 1, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(26, 416, 1, 3, 1178.2, -1328.4, 13.55, 270, 0, 0, 420, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(27, 416, 1, 3, 1186.5, -1337.7, 13.55, 180, 0, 0, 420, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(28, 407, 3, 1, 1760.5, -1450.5, 13.55, 180, 0, 0, 420, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(29, 544, 3, 1, 1752.3, -1450.5, 13.55, 180, 0, 0, 420, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(30, 427, 0, 1, 1585.6, -1671.3, 13.4, 0, 0, 0, 420, 1, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(31, 490, 0, 0, 1593.6, -1710.4, 5.9, 0, 0, 0, 420, 1, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(32, 599, 0, 1, 1600.4, -1704.7, 5.9, 0, 0, 0, 420, 1, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(33, 403, 1, 1, 2205.2, -2660.8, 13.45, 0, 0, 0, 480, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(34, 514, 1, 1, 2194.7, -2660.7, 13.45, 0, 0, 0, 480, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(35, 515, 1, 1, 2183.8, -2660.5, 13.45, 0, 0, 0, 480, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(36, 455, 1, 1, 2172.9, -2660.3, 13.45, 0, 0, 0, 480, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(37, 456, 1, 1, 2162.2, -2660.1, 13.45, 0, 0, 0, 480, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(38, 498, 1, 1, 2151.6, -2660, 13.45, 0, 0, 0, 480, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(39, 443, 1, 1, 2221.7, -2638.5, 13.45, 90, 0, 0, 480, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(40, 414, 1, 1, 2747.6, -2460.4, 13.45, 90, 0, 0, 420, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(41, 578, 1, 1, 2770.4, -2417.5, 13.55, 180, 0, 0, 420, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(42, 499, 1, 1, 2783.2, -2417.5, 13.55, 180, 0, 0, 420, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(43, 461, 1, 1, 370.4, -2030.1, 7.65, 90, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(44, 468, 1, 1, 383.9, -2030.4, 7.65, 90, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(45, 463, 1, 1, 397.2, -2030.7, 7.65, 90, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(46, 471, 1, 1, 414.5, -2025.2, 7.65, 180, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(47, 445, 1, 1, 1120.5, -1456.8, 15.55, 0, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(48, 551, 1, 1, 1130.2, -1456.8, 15.55, 0, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(49, 547, 1, 1, 1140.2, -1456.8, 15.55, 0, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(50, 410, 1, 1, 1150.2, -1456.8, 15.55, 0, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(51, 439, 1, 1, 1160.2, -1456.8, 15.55, 0, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(52, 580, 1, 1, 1170.2, -1456.8, 15.55, 0, 0, 0, 300, 0, 0, 'offline_template_ls', '2026-06-02 05:19:57', '2026-06-02 05:56:35', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup');

-- Dumping structure for table lsif_db.saif_archive_v024K21D_gang_members
CREATE TABLE IF NOT EXISTS `saif_archive_v024K21D_gang_members` (
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

-- Dumping data for table lsif_db.saif_archive_v024K21D_gang_members: ~0 rows (approximately)

-- Dumping structure for table lsif_db.saif_archive_v024K21D_gang_weapon_stash
CREATE TABLE IF NOT EXISTS `saif_archive_v024K21D_gang_weapon_stash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gang_id` int(11) NOT NULL,
  `weapon_id` int(11) NOT NULL,
  `weapon_name` varchar(32) NOT NULL,
  `ammo` int(11) NOT NULL DEFAULT 0,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_gang_weapon` (`gang_id`,`weapon_id`),
  KEY `idx_gang_id` (`gang_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table lsif_db.saif_archive_v024K21D_gang_weapon_stash: ~0 rows (approximately)

-- Dumping structure for table lsif_db.saif_archive_v024K21D_job_stats
CREATE TABLE IF NOT EXISTS `saif_archive_v024K21D_job_stats` (
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

-- Dumping data for table lsif_db.saif_archive_v024K21D_job_stats: ~0 rows (approximately)

-- Dumping structure for table lsif_db.saif_archive_v024K21D_organization_members
CREATE TABLE IF NOT EXISTS `saif_archive_v024K21D_organization_members` (
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

-- Dumping data for table lsif_db.saif_archive_v024K21D_organization_members: ~0 rows (approximately)

-- Dumping structure for table lsif_db.saif_archive_v024K21D_player_businesses
CREATE TABLE IF NOT EXISTS `saif_archive_v024K21D_player_businesses` (
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

-- Dumping data for table lsif_db.saif_archive_v024K21D_player_businesses: ~0 rows (approximately)

-- Dumping structure for table lsif_db.saif_archive_v024K21D_player_houses
CREATE TABLE IF NOT EXISTS `saif_archive_v024K21D_player_houses` (
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

-- Dumping data for table lsif_db.saif_archive_v024K21D_player_houses: ~0 rows (approximately)

-- Dumping structure for table lsif_db.saif_archive_v024K21D_player_vehicles
CREATE TABLE IF NOT EXISTS `saif_archive_v024K21D_player_vehicles` (
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

-- Dumping data for table lsif_db.saif_archive_v024K21D_player_vehicles: ~0 rows (approximately)

-- Dumping structure for table lsif_db.saif_archive_v024K21D_player_weapons
CREATE TABLE IF NOT EXISTS `saif_archive_v024K21D_player_weapons` (
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

-- Dumping data for table lsif_db.saif_archive_v024K21D_player_weapons: ~0 rows (approximately)

-- Dumping structure for table lsif_db.saif_archive_v024K21D_race_records
CREATE TABLE IF NOT EXISTS `saif_archive_v024K21D_race_records` (
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

-- Dumping data for table lsif_db.saif_archive_v024K21D_race_records: ~0 rows (approximately)

-- Dumping structure for table lsif_db.saif_archive_world_pickups
CREATE TABLE IF NOT EXISTS `saif_archive_world_pickups` (
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
  `archived_at` timestamp NULL DEFAULT current_timestamp(),
  `archive_reason` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_world_pickups_enabled` (`enabled`),
  KEY `idx_world_pickups_type` (`pickup_type`),
  KEY `idx_world_pickups_source` (`source_tag`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.saif_archive_world_pickups: ~75 rows (approximately)
INSERT INTO `saif_archive_world_pickups` (`id`, `pickup_type`, `display_name`, `model_id`, `pos_x`, `pos_y`, `pos_z`, `interior`, `virtual_world`, `amount`, `cooldown_seconds`, `source_tag`, `enabled`, `created_at`, `updated_at`, `archived_at`, `archive_reason`) VALUES
	(3, 'bribe', 'LS Bribe - LSPD Alley', 1247, 1566.2, -1695.1, 5.9, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(4, 'bribe', 'LS Bribe - Pershing Square', 1247, 1484.3, -1744.6, 13.55, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(5, 'bribe', 'LS Bribe - Unity Station', 1247, 1815.6, -1893.8, 13.58, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(6, 'bribe', 'LS Bribe - Jefferson Backstreet', 1247, 2182.4, -1161.7, 23.82, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(7, 'bribe', 'LS Bribe - Ocean Docks', 1247, 2574.3, -2218.5, 13.54, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(8, 'bribe', 'LS Bribe - Market Alley', 1247, 1114.5, -1494.8, 15.79, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(9, 'bribe', 'LS Bribe - Santa Maria Beach', 1247, 367.5, -2048.7, 7.83, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(10, 'bribe', 'LS Bribe - LS Airport Lot', 1247, 1952.2, -2182.4, 13.55, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(11, 'health', 'LS Health - County General', 1240, 1176.7, -1323.8, 14.07, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(12, 'health', 'LS Health - Jefferson Hospital', 1240, 2034.2, -1403.4, 17.25, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(13, 'health', 'LS Health - Grove Street', 1240, 2495.3, -1687.9, 13.52, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(14, 'health', 'LS Health - Idlewood', 1240, 1957.4, -1714.2, 15.97, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(15, 'health', 'LS Health - Santa Maria', 1240, 332.8, -1809.4, 4.47, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(16, 'health', 'LS Health - East Beach', 1240, 2737.8, -1765.3, 44.67, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(17, 'armor', 'LS Armor - LSPD Garage', 1242, 1548.6, -1632.2, 13.38, 0, 0, 50, 240, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(18, 'armor', 'LS Armor - Grove Backyard', 1242, 2522.4, -1679.6, 15.5, 0, 0, 50, 240, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(19, 'armor', 'LS Armor - Ocean Docks Warehouse', 1242, 2465.8, -2117.4, 13.55, 0, 0, 50, 240, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(20, 'armor', 'LS Armor - East Los Santos', 1242, 2385.7, -1281.4, 25.13, 0, 0, 50, 240, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(21, 'armor', 'LS Armor - Verdant Bluffs', 1242, 1335.5, -631.8, 109.13, 0, 0, 50, 240, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(22, 'hidden', 'LS Hidden - Vinewood Sign Trail', 1274, 1382.9, -806.1, 86.12, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(23, 'hidden', 'LS Hidden - Mulholland Overlook', 1274, 1263.3, -781.2, 92.03, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(24, 'hidden', 'LS Hidden - Verona Beach Pier', 1274, 850.2, -2067.3, 12.86, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(25, 'hidden', 'LS Hidden - Airport Service Road', 1274, 1701.3, -2347.8, 13.55, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(26, 'hidden', 'LS Hidden - LS Docks Crane', 1274, 2773.9, -2455.3, 13.63, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(27, 'hidden', 'LS Hidden - Downtown Rooftop', 1274, 1407.3, -1367.5, 34.5, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:00:17', '2026-06-02 04:06:59', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(28, 'bribe', 'LS Bribe - LSPD Alley', 1247, 1566.2, -1695.1, 5.9, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(29, 'bribe', 'LS Bribe - Pershing Square', 1247, 1484.3, -1744.6, 13.55, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(30, 'bribe', 'LS Bribe - Unity Station', 1247, 1815.6, -1893.8, 13.58, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(31, 'bribe', 'LS Bribe - Jefferson Backstreet', 1247, 2182.4, -1161.7, 23.82, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(32, 'bribe', 'LS Bribe - Ocean Docks', 1247, 2574.3, -2218.5, 13.54, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(33, 'bribe', 'LS Bribe - Market Alley', 1247, 1114.5, -1494.8, 15.79, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(34, 'bribe', 'LS Bribe - Santa Maria Beach', 1247, 367.5, -2048.7, 7.83, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(35, 'bribe', 'LS Bribe - LS Airport Lot', 1247, 1952.2, -2182.4, 13.55, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(36, 'health', 'LS Health - County General', 1240, 1176.7, -1323.8, 14.07, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(37, 'health', 'LS Health - Jefferson Hospital', 1240, 2034.2, -1403.4, 17.25, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(38, 'health', 'LS Health - Grove Street', 1240, 2495.3, -1687.9, 13.52, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(39, 'health', 'LS Health - Idlewood', 1240, 1957.4, -1714.2, 15.97, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(40, 'health', 'LS Health - Santa Maria', 1240, 332.8, -1809.4, 4.47, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(41, 'health', 'LS Health - East Beach', 1240, 2737.8, -1765.3, 44.67, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(42, 'armor', 'LS Armor - LSPD Garage', 1242, 1548.6, -1632.2, 13.38, 0, 0, 50, 240, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(43, 'armor', 'LS Armor - Grove Backyard', 1242, 2522.4, -1679.6, 15.5, 0, 0, 50, 240, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(44, 'armor', 'LS Armor - Ocean Docks Warehouse', 1242, 2465.8, -2117.4, 13.55, 0, 0, 50, 240, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(45, 'armor', 'LS Armor - East Los Santos', 1242, 2385.7, -1281.4, 25.13, 0, 0, 50, 240, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(46, 'armor', 'LS Armor - Verdant Bluffs', 1242, 1335.5, -631.8, 109.13, 0, 0, 50, 240, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(47, 'hidden', 'LS Hidden - Vinewood Sign Trail', 1274, 1382.9, -806.1, 86.12, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(48, 'hidden', 'LS Hidden - Mulholland Overlook', 1274, 1263.3, -781.2, 92.03, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(49, 'hidden', 'LS Hidden - Verona Beach Pier', 1274, 850.2, -2067.3, 12.86, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(50, 'hidden', 'LS Hidden - Airport Service Road', 1274, 1701.3, -2347.8, 13.55, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(51, 'hidden', 'LS Hidden - LS Docks Crane', 1274, 2773.9, -2455.3, 13.63, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(52, 'hidden', 'LS Hidden - Downtown Rooftop', 1274, 1407.3, -1367.5, 34.5, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:06:59', '2026-06-02 04:07:05', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(53, 'bribe', 'LS Bribe - LSPD Alley', 1247, 1566.2, -1695.1, 5.9, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(54, 'bribe', 'LS Bribe - Pershing Square', 1247, 1484.3, -1744.6, 13.55, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(55, 'bribe', 'LS Bribe - Unity Station', 1247, 1815.6, -1893.8, 13.58, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(56, 'bribe', 'LS Bribe - Jefferson Backstreet', 1247, 2182.4, -1161.7, 23.82, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(57, 'bribe', 'LS Bribe - Ocean Docks', 1247, 2574.3, -2218.5, 13.54, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(58, 'bribe', 'LS Bribe - Market Alley', 1247, 1114.5, -1494.8, 15.79, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(59, 'bribe', 'LS Bribe - Santa Maria Beach', 1247, 367.5, -2048.7, 7.83, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(60, 'bribe', 'LS Bribe - LS Airport Lot', 1247, 1952.2, -2182.4, 13.55, 0, 0, 1, 180, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(61, 'health', 'LS Health - County General', 1240, 1176.7, -1323.8, 14.07, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(62, 'health', 'LS Health - Jefferson Hospital', 1240, 2034.2, -1403.4, 17.25, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(63, 'health', 'LS Health - Grove Street', 1240, 2495.3, -1687.9, 13.52, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(64, 'health', 'LS Health - Idlewood', 1240, 1957.4, -1714.2, 15.97, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(65, 'health', 'LS Health - Santa Maria', 1240, 332.8, -1809.4, 4.47, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(66, 'health', 'LS Health - East Beach', 1240, 2737.8, -1765.3, 44.67, 0, 0, 35, 120, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(67, 'armor', 'LS Armor - LSPD Garage', 1242, 1548.6, -1632.2, 13.38, 0, 0, 50, 240, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(68, 'armor', 'LS Armor - Grove Backyard', 1242, 2522.4, -1679.6, 15.5, 0, 0, 50, 240, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(69, 'armor', 'LS Armor - Ocean Docks Warehouse', 1242, 2465.8, -2117.4, 13.55, 0, 0, 50, 240, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(70, 'armor', 'LS Armor - East Los Santos', 1242, 2385.7, -1281.4, 25.13, 0, 0, 50, 240, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(71, 'armor', 'LS Armor - Verdant Bluffs', 1242, 1335.5, -631.8, 109.13, 0, 0, 50, 240, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(72, 'hidden', 'LS Hidden - Vinewood Sign Trail', 1274, 1382.9, -806.1, 86.12, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(73, 'hidden', 'LS Hidden - Mulholland Overlook', 1274, 1263.3, -781.2, 92.03, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(74, 'hidden', 'LS Hidden - Verona Beach Pier', 1274, 850.2, -2067.3, 12.86, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(75, 'hidden', 'LS Hidden - Airport Service Road', 1274, 1701.3, -2347.8, 13.55, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(76, 'hidden', 'LS Hidden - LS Docks Crane', 1274, 2773.9, -2455.3, 13.63, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup'),
	(77, 'hidden', 'LS Hidden - Downtown Rooftop', 1274, 1407.3, -1367.5, 34.5, 0, 0, 500, 300, 'offline_template_ls', 0, '2026-06-02 04:07:09', '2026-06-02 06:28:26', '2026-06-05 06:55:08', 'v0.24K.21C disabled deprecated curated template cleanup');

-- Dumping structure for table lsif_db.server_settings
CREATE TABLE IF NOT EXISTS `server_settings` (
  `setting_key` varchar(64) NOT NULL,
  `setting_value` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.server_settings: ~4 rows (approximately)
INSERT INTO `server_settings` (`setting_key`, `setting_value`, `created_at`, `updated_at`) VALUES
	('turf_capture_seconds', '30', '2026-06-02 00:09:00', '2026-06-02 00:16:08'),
	('turf_cooldown_seconds', '60', '2026-06-02 00:09:00', '2026-06-02 00:16:08'),
	('turf_grace_seconds', '10', '2026-06-02 00:09:00', '2026-06-02 00:16:08'),
	('turf_hold_seconds', '3', '2026-06-02 00:09:00', '2026-06-02 00:16:08');

-- Dumping structure for table lsif_db.turf_war_logs
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.turf_war_logs: ~7 rows (approximately)
INSERT INTO `turf_war_logs` (`id`, `territory_index`, `territory_name`, `attacker_gang_id`, `attacker_gang_name`, `defender_gang_id`, `defender_gang_name`, `result`, `detail`, `created_at`) VALUES
	(1, 7, 'Turf_3', 4, 'Varrios Los Aztecas', 1, 'Grove Street Families', 'defended', '[TURF DEFENDED] Turf_3 berhasil dipertahankan oleh Grove Street Families.', '2026-06-01 11:49:12'),
	(2, 7, 'Turf_3', 1, 'Grove Street Families', 2, 'Ballas', 'captured', '[TURF CAPTURED] Turf_3 berhasil dikuasai oleh Grove Street Families.', '2026-06-02 00:04:23'),
	(3, 2, 'Idlewood District', 1, 'Grove Street Families', 4, 'Varrios Los Aztecas', 'defended', '[TURF DEFENDED] Idlewood District berhasil dipertahankan oleh Varrios Los Aztecas.', '2026-06-02 15:19:51'),
	(4, 1, 'Ballas', 1, 'Grove Street Families', 0, 'Neutral', 'captured', '[TURF CAPTURED] Ballas berhasil dikuasai oleh Grove Street Families.', '2026-06-04 16:41:27'),
	(5, 2, 'tes', 1, 'Grove Street Families', 0, 'Neutral', 'captured', '[TURF CAPTURED] tes berhasil dikuasai oleh Grove Street Families.', '2026-06-04 16:41:47'),
	(6, 1, 'Ballas', 1, 'Grove Street Families', 3, 'Los Santos Vagos', 'defended', '[TURF DEFENDED] Ballas berhasil dipertahankan oleh Los Santos Vagos.', '2026-06-04 16:43:14'),
	(7, 1, 'Ballas', 1, 'Grove Street Families', 3, 'Los Santos Vagos', 'captured', '[TURF CAPTURED] Ballas berhasil dikuasai oleh Grove Street Families.', '2026-06-04 16:47:45');

-- Dumping structure for table lsif_db.weapon_shop_config
CREATE TABLE IF NOT EXISTS `weapon_shop_config` (
  `weapon_id` int(11) NOT NULL,
  `weapon_name` varchar(32) NOT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  `ammo_per_purchase` int(11) NOT NULL DEFAULT 0,
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`weapon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.weapon_shop_config: ~15 rows (approximately)
INSERT INTO `weapon_shop_config` (`weapon_id`, `weapon_name`, `price`, `ammo_per_purchase`, `enabled`, `updated_at`) VALUES
	(16, 'Grenade', 300, 5, 1, '2026-06-02 12:04:13'),
	(22, '9mm', 200, 68, 1, '2026-06-02 12:04:13'),
	(23, 'Silenced 9mm', 600, 68, 1, '2026-06-02 12:04:13'),
	(24, 'Desert Eagle', 1200, 35, 1, '2026-06-02 12:04:13'),
	(25, 'Shotgun', 600, 24, 1, '2026-06-02 12:04:13'),
	(26, 'Sawnoff Shotgun', 1000, 24, 1, '2026-06-02 12:16:22'),
	(27, 'Combat Shotgun', 1000, 24, 1, '2026-06-02 12:04:13'),
	(28, 'Micro SMG', 500, 150, 1, '2026-06-02 12:04:13'),
	(29, 'SMG', 2000, 150, 1, '2026-06-02 12:04:13'),
	(30, 'AK-47', 3500, 120, 1, '2026-06-02 12:04:13'),
	(31, 'M4', 4500, 120, 1, '2026-06-02 12:04:13'),
	(32, 'Tec-9', 300, 150, 1, '2026-06-02 12:04:13'),
	(33, 'Country Rifle', 1000, 30, 1, '2026-06-02 12:04:13'),
	(34, 'Sniper Rifle', 5000, 20, 1, '2026-06-02 12:04:13'),
	(39, 'Satchel Charge', 2000, 5, 1, '2026-06-02 12:04:13');

-- Dumping structure for table lsif_db.world_locations
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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.world_locations: ~12 rows (approximately)
INSERT INTO `world_locations` (`id`, `location_key`, `location_type`, `display_name`, `pos_x`, `pos_y`, `pos_z`, `pos_a`, `interior`, `virtual_world`, `map_icon`, `pickup_model`, `object_model`, `linked_object_id`, `label_text`, `interaction_radius`, `enabled`, `created_at`, `updated_at`, `source_tag`) VALUES
	(31, 'legacy_static_dealer_ls_grotti', 'dealer', 'LS Grotti Dealership', 2131.92, -1150.12, 24.2266, 0, 0, 0, 55, 1239, 0, 0, '[ALT] Dealership\nLS Grotti Dealership\nVehicle Shop / Garage Service', 8, 1, '2026-06-02 12:32:45', NULL, 'legacy_static_migrated'),
	(32, 'legacy_static_dealer_market_budget', 'dealer', 'Market Budget Cars', 562.615, -1291.76, 17.2482, 0, 0, 0, 55, 1239, 0, 0, '[ALT] Dealership\nMarket Budget Cars\nVehicle Shop / Garage Service', 8, 1, '2026-06-02 12:32:45', NULL, 'legacy_static_migrated'),
	(33, 'legacy_static_dealer_sf_import', 'dealer', 'San Fierro Import Dealer', -1954.25, 300.202, 35.4688, 0, 0, 0, 55, 1239, 0, 0, '[ALT] Dealership\nSan Fierro Import Dealer\nVehicle Shop / Garage Service', 8, 1, '2026-06-02 12:32:45', NULL, 'legacy_static_migrated'),
	(34, 'legacy_static_ammu_market', 'ammunation', 'Market Ammu-Nation Legacy Fallback', 1368.74, -1279.8, 13.5469, 0, 0, 0, 6, 1239, 0, 0, '[ALT] Ammu-Nation\nMarket Ammu-Nation\nLegacy fallback', 7, 0, '2026-06-02 12:32:45', NULL, 'legacy_static_migrated'),
	(35, 'legacy_static_ammu_willowfield', 'ammunation', 'Willowfield Ammu-Nation Legacy Fallback', 2400.49, -1981.96, 13.5469, 0, 0, 0, 6, 1239, 0, 0, '[ALT] Ammu-Nation\nWillowfield Ammu-Nation\nLegacy fallback', 7, 0, '2026-06-02 12:32:45', NULL, 'legacy_static_migrated'),
	(36, 'legacy_static_ammu_blueberry', 'ammunation', 'Blueberry Ammu-Nation Legacy Fallback', 242.006, -178.107, 1.5781, 0, 0, 0, 6, 1239, 0, 0, '[ALT] Ammu-Nation\nBlueberry Ammu-Nation\nLegacy fallback', 7, 0, '2026-06-02 12:32:45', NULL, 'legacy_static_migrated'),
	(37, 'legacy_static_job_taxi_stand', 'job', 'Taxi Mission Stand', 2112.85, -1788.32, 13.5547, 0, 0, 0, 51, 1239, 0, 0, '[JOB] Taxi Mission Stand\nNaik Taxi/Cabbie lalu tekan tombol 2 untuk Taxi Mission.', 5, 1, '2026-06-02 12:32:45', NULL, 'legacy_static_migrated'),
	(38, 'legacy_static_job_courier_depot', 'job', 'Courier Depot', 2102.89, -1806.48, 13.5547, 0, 0, 0, 51, 1239, 0, 0, '[JOB] Courier Depot\nNaik Burrito/Boxville/Mule/Pony/Rumpo lalu tekan tombol 2 untuk Courier.', 5, 1, '2026-06-02 12:32:45', NULL, 'legacy_static_migrated'),
	(39, 'legacy_static_job_trucker_depot', 'job', 'Trucker Cargo Depot', 2460.39, -2114.82, 13.5469, 0, 0, 0, 51, 1239, 0, 0, '[JOB] Trucker Cargo Depot\nNaik truck valid lalu tekan tombol 2 untuk Trucker Mission.', 5, 1, '2026-06-02 12:32:45', NULL, 'legacy_static_migrated'),
	(40, 'legacy_static_job_bus_terminal', 'job', 'Bus Terminal', 1807.93, -1908.11, 13.5781, 0, 0, 0, 51, 1239, 0, 0, '[JOB] Bus Terminal\nNaik Bus/Coach lalu tekan tombol 2 untuk Bus Route.', 5, 1, '2026-06-02 12:32:45', NULL, 'legacy_static_migrated'),
	(41, 'legacy_static_job_police_vigilante', 'job', 'Police Vigilante HQ', 1554.84, -1675.65, 16.1953, 0, 0, 0, 51, 1239, 0, 0, '[JOB] Police Vigilante HQ\nNaik kendaraan polisi lalu tekan tombol 2 untuk Vigilante Mission.', 5, 1, '2026-06-02 12:32:45', NULL, 'legacy_static_migrated'),
	(42, 'legacy_static_race_ls_intro', 'race', 'LS Intro Race Start', 1528.37, -1678.02, 13.3828, 0, 0, 0, 53, 1239, 0, 0, '[RACE] LS Intro\nGunakan /joinrace ls\nTombol 2 hanya untuk vehicle mission/job', 5, 1, '2026-06-02 12:32:45', NULL, 'legacy_static_migrated');

-- Dumping structure for table lsif_db.world_objects
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.world_objects: ~0 rows (approximately)

-- Dumping structure for table lsif_db.world_pickups
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
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.world_pickups: ~124 rows (approximately)
INSERT INTO `world_pickups` (`id`, `pickup_type`, `display_name`, `model_id`, `pos_x`, `pos_y`, `pos_z`, `interior`, `virtual_world`, `amount`, `cooldown_seconds`, `source_tag`, `enabled`, `created_at`, `updated_at`) VALUES
	(1, 'bribe', 'Police Bribe / Wanted Star', 1247, 2151.9, -1174.85, 23.8249, 0, 0, 1, 60, 'manual', 1, '2026-06-02 03:51:18', '2026-06-02 03:51:18'),
	(2, 'armor', 'Armor Pickup', 1242, 2154.64, -1178.53, 23.8263, 0, 0, 50, 60, 'manual', 1, '2026-06-02 03:51:59', '2026-06-02 03:51:59'),
	(78, 'weapon', 'SCM Weapon - Molotov', 344, -366.224, -1429.09, 25.5, 0, 0, 3, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(79, 'weapon', 'SCM Weapon - Chainsaw', 341, -365.791, -1425.25, 25.5, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(80, 'weapon', 'SCM Weapon - Pool Cue', 338, 2854, 944, 11, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(81, 'weapon', 'SCM Weapon - Nightstick', 334, 2241, 2425, 11, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(82, 'weapon', 'SCM Weapon - Golf Club', 333, 1418, 2774, 15, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(83, 'weapon', 'SCM Weapon - Shovel', 337, 1393, 2174, 10, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(84, 'weapon', 'SCM Weapon - Chainsaw', 341, 1061, 2074, 11, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(85, 'weapon', 'SCM Weapon - Parachute', 371, 2057, 2434, 166, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(86, 'weapon', 'SCM Weapon - Katana', 339, 2000, 1526, 15, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(87, 'weapon', 'SCM Weapon - Shovel', 337, 1997, 1658, 12, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(88, 'weapon', 'SCM Weapon - Golf Club', 333, 1457, -792, 90, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(89, 'weapon', 'SCM Weapon - Chainsaw', 341, 2371, -2543, 3, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(90, 'weapon', 'SCM Weapon - Knife', 335, 1124, -1335, 13, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(91, 'weapon', 'SCM Weapon - Katana', 339, 1862, -1862, 14, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(92, 'weapon', 'SCM Weapon - Brass Knuckles', 331, 1339, -1765, 14, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(93, 'weapon', 'SCM Weapon - Chainsaw', 341, 2192.24, -1988.75, 13.4185, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(94, 'weapon', 'SCM Weapon - Shovel', 337, 2459, -1708, 13.6, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(95, 'weapon', 'SCM Weapon - Chainsaw', 341, -2083, 298, 42, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(96, 'weapon', 'SCM Weapon - Baseball Bat', 336, -2306, 93, 35, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(97, 'weapon', 'SCM Weapon - Shovel', 337, -2796.42, 123.686, 6.844, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(98, 'weapon', 'SCM Weapon - Pool Cue', 338, -2135, 197, 35, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(99, 'weapon', 'SCM Weapon - Katana', 339, -2208, 696, 50, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(100, 'weapon', 'SCM Weapon - Brass Knuckles', 331, -2206, 961, 80, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(101, 'weapon', 'SCM Weapon - Nightstick', 334, -2222, -302, 43, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(102, 'weapon', 'SCM Weapon - Knife', 335, -1871, 351, 26, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(103, 'weapon', 'SCM Weapon - Golf Club', 333, -2715, -314, 7, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(104, 'weapon', 'SCM Weapon - Chainsaw', 341, -2359, -82, 35, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(105, 'weapon', 'SCM Weapon - Shovel', 337, -532, -106, 63, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(106, 'weapon', 'SCM Weapon - Shovel', 337, -1809, -1662, 24, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(107, 'weapon', 'SCM Weapon - Golf Club', 333, -2227, -2401, 31.4, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(108, 'weapon', 'SCM Weapon - Shovel', 337, 2240, -83, 27, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(109, 'weapon', 'SCM Weapon - Pool Cue', 338, 294, -188, 2, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(110, 'weapon', 'SCM Weapon - Chainsaw', 341, -761, -126, 66, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(111, 'weapon', 'SCM Weapon - Katana', 339, -1568, 2718, 56, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(112, 'weapon', 'SCM Weapon - Gift Weapon 11', 322, -2401, 2360, 5, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(113, 'weapon', 'SCM Weapon - Shovel', 337, 637, 832, -43, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(114, 'weapon', 'SCM Weapon - Chainsaw', 341, 680, 826, -39, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(115, 'weapon', 'SCM Weapon - Chainsaw', 341, 752, 260, 27, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(116, 'weapon', 'SCM Weapon - Brass Knuckles', 331, -246, 2725, 63, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(117, 'weapon', 'SCM Weapon - Knife', 335, -23, 2322, 24, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(118, 'weapon', 'SCM Weapon - Parachute', 371, -1542.86, 698.482, 139.266, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(119, 'weapon', 'SCM Weapon - Parachute', 371, -225.676, 1394.26, 172.014, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(120, 'weapon', 'SCM Weapon - Parachute', 371, -773.038, 2423.5, 157.086, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(121, 'weapon', 'SCM Weapon - Shovel', 337, 842.978, -17.3791, 64.2, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(122, 'weapon', 'SCM Weapon - Cane', 326, -2677.73, -192.347, 6.8518, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(123, 'weapon', 'SCM Weapon - Chainsaw', 341, -2752.24, -272.289, 6.5956, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(124, 'weapon', 'SCM Weapon - Cane', 326, -2617.47, -97.0801, 4.003, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(125, 'weapon', 'SCM Weapon - Cane', 326, -2777.19, -25.2984, 6.8721, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(126, 'weapon', 'SCM Weapon - Cane', 326, -2774.11, 87.8845, 6.7987, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(127, 'weapon', 'SCM Weapon - Cane', 326, -2770.62, 389.077, 4.2818, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(128, 'weapon', 'SCM Weapon - Katana', 339, -2535.63, 51.7034, 8.6512, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(129, 'weapon', 'SCM Weapon - Cane', 326, -2530.96, -34.1009, 25.2855, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(130, 'weapon', 'SCM Weapon - Cane', 326, -1691.65, 946.768, 24.8084, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(131, 'weapon', 'SCM Weapon - Cane', 326, -2664.52, 636.567, 14.2474, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(132, 'weapon', 'SCM Weapon - Cane', 326, -377.218, -1048.05, 58.9125, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(133, 'weapon', 'SCM Weapon - Cane', 326, -45.5928, -1148.53, 1.3953, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(134, 'weapon', 'SCM Weapon - Brass Knuckles', 331, 2428.5, -1679.27, 13.1633, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(135, 'weapon', 'SCM Weapon - Cane', 326, 1296.16, -1081.89, 26.1502, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(136, 'weapon', 'SCM Weapon - Cane', 326, 1390.61, -800.433, 81.7795, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(137, 'weapon', 'SCM Weapon - Baseball Bat', 336, 1308.47, 2111.29, 10.7221, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(138, 'weapon', 'SCM Weapon - Cane', 326, 2183.12, 2396.83, 10.7722, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(139, 'weapon', 'SCM Weapon - Baseball Bat', 336, 1081.13, 1603.7, 5.6, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(140, 'weapon', 'SCM Weapon - Knife', 335, 777.867, 1948.12, 5.3634, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(141, 'weapon', 'SCM Weapon - Shovel', 337, 1888.27, 2877.26, 10.1621, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(142, 'weapon', 'SCM Weapon - Cane', 326, 1420.94, 2519.88, 10.6199, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(143, 'weapon', 'SCM Weapon - Cane', 326, 1373, 2605.76, 10.8776, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(144, 'weapon', 'SCM Weapon - Katana', 339, 2631.26, 1722.39, 11.0312, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(145, 'weapon', 'SCM Weapon - Cane', 326, 2490.5, 1522.47, 10.576, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(146, 'weapon', 'SCM Weapon - Cane', 326, 455.458, -1485.9, 30.9717, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(147, 'weapon', 'SCM Weapon - Katana', 339, 2002.26, 981.395, 10.5, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(148, 'weapon', 'SCM Weapon - Flowers', 325, 1928.68, -1774.21, 13.54, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(149, 'weapon', 'SCM Weapon - Flowers', 325, 1875.91, -1917.18, 15.03, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(150, 'weapon', 'SCM Weapon - Flowers', 325, 2019.6, -1214.15, 21.47, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(151, 'weapon', 'SCM Weapon - Flowers', 325, 2209.77, -1001.69, 63.71, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(152, 'weapon', 'SCM Weapon - Flowers', 325, 1000.34, -1858.58, 12.3, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(153, 'weapon', 'SCM Weapon - Flowers', 325, 911.11, -1120.31, 24.03, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(154, 'weapon', 'SCM Weapon - Flowers', 325, 929, -750, 105.82, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(155, 'weapon', 'SCM Weapon - Flowers', 325, 1129.09, -2052.82, 69, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(156, 'weapon', 'SCM Weapon - Flowers', 325, -92.74, -1425.46, 12.75, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(157, 'weapon', 'SCM Weapon - Flowers', 325, -77.65, -1167.18, 2.16, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(158, 'weapon', 'SCM Weapon - Flowers', 325, 34, -2649, 40.73, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(159, 'weapon', 'SCM Weapon - Flowers', 325, -739, -1262, 68.12, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(160, 'weapon', 'SCM Weapon - Flowers', 325, -2177, -2423, 30.63, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(161, 'weapon', 'SCM Weapon - Flowers', 325, -615, -861, 105.72, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(162, 'weapon', 'SCM Weapon - Flowers', 325, -2051, 948, 55.4, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(163, 'weapon', 'SCM Weapon - Flowers', 325, -2658, -187, 4.18, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(164, 'weapon', 'SCM Weapon - Flowers', 325, -2649, 734.97, 27.96, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(165, 'weapon', 'SCM Weapon - Flowers', 325, -1791, 481, 25.68, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(166, 'weapon', 'SCM Weapon - Flowers', 325, -2797, 1182, 20.28, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(167, 'weapon', 'SCM Weapon - Flowers', 325, -2589.62, -16.165, 3.9662, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(168, 'weapon', 'SCM Weapon - Flowers', 325, -2865, 690, 23.43, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(169, 'weapon', 'SCM Weapon - Flowers', 325, -2339, -453, 80.24, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(170, 'weapon', 'SCM Weapon - Flowers', 325, -1955, -748, 36.22, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(171, 'weapon', 'SCM Weapon - Flowers', 325, -2420.03, 987.59, 45.3, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(172, 'weapon', 'SCM Weapon - Flowers', 325, -326.56, 2215.37, 43.57, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(173, 'weapon', 'SCM Weapon - Flowers', 325, -1319, 2705, 50.27, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(174, 'weapon', 'SCM Weapon - Flowers', 325, -2474.94, 2443.52, 16.03, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(175, 'weapon', 'SCM Weapon - Flowers', 325, -1670.64, 2590.49, 81.37, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(176, 'weapon', 'SCM Weapon - Flowers', 325, -892.98, 1971.66, 60.61, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(177, 'weapon', 'SCM Weapon - Flowers', 325, 1576.86, 2837.14, 10.83, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(178, 'weapon', 'SCM Weapon - Flowers', 325, 1492.72, 2773.76, 10.81, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(179, 'weapon', 'SCM Weapon - Flowers', 325, 2642.03, 1125.74, 11.03, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(180, 'weapon', 'SCM Weapon - Flowers', 325, 2025.24, 661.6, 10.93, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(181, 'weapon', 'SCM Weapon - Flowers', 325, 2181.82, 1484.97, 11.36, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(182, 'weapon', 'SCM Weapon - Flowers', 325, 2197.02, 2476.33, 11, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(183, 'weapon', 'SCM Weapon - Flowers', 325, 2212, 2526, 10.81, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(184, 'weapon', 'SCM Weapon - Flowers', 325, 2715.79, 1109.47, 6.7, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(185, 'weapon', 'SCM Weapon - Flowers', 325, 2489.25, 918.28, 11.02, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(186, 'weapon', 'SCM Weapon - Flowers', 325, 1472.08, 1890.09, 10.81, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(187, 'weapon', 'SCM Weapon - Nightstick', 334, 911.649, -1235.39, 17.6802, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(188, 'weapon', 'SCM Weapon - Sniper Rifle', 358, 733.433, -1356.47, 23.5229, 0, 0, 20, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(189, 'weapon', 'SCM Weapon - Baseball Bat', 336, 2285.74, -1647.31, 14.0782, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(190, 'weapon', 'SCM Weapon - Parachute', 371, 1797.6, -1308.88, 133.813, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(191, 'weapon', 'SCM Weapon - Knife', 335, -819, 1929, 7, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(192, 'weapon', 'SCM Weapon - Knife', 335, -938.39, 1901.65, 4.3, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(193, 'weapon', 'SCM Weapon - Grenade', 342, 2550.97, 2824.34, 10.6, 0, 0, 3, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(194, 'weapon', 'SCM Weapon - Parachute', 371, 2267.99, 1699.67, 101.4, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(195, 'weapon', 'SCM Weapon - Rocket Launcher', 359, -686, 934, 13.5, 0, 0, 5, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(196, 'weapon', 'SCM Weapon - Heat Seeker', 360, -690, 934, 13.5, 0, 0, 5, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(197, 'weapon', 'SCM Weapon - Minigun', 362, -690, 939, 13.5, 0, 0, 5, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(198, 'weapon', 'SCM Weapon - Flamethrower', 361, -686, 939, 13.5, 0, 0, 5, 300, 'offline_exact_scm', 1, '2026-06-02 06:55:26', '2026-06-02 06:55:26'),
	(199, 'health', 'Health Pickup', 1240, 1172.1, -1323.31, 15.4029, 0, 0, 100, 60, 'manual', 1, '2026-06-02 17:42:01', '2026-06-02 17:42:20');

-- Dumping structure for table lsif_db.world_pickup_import_queue
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
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lsif_db.world_pickup_import_queue: ~121 rows (approximately)
INSERT INTO `world_pickup_import_queue` (`id`, `pickup_type`, `display_name`, `model_id`, `pos_x`, `pos_y`, `pos_z`, `interior`, `virtual_world`, `amount`, `cooldown_seconds`, `source_tag`, `enabled`, `imported_at`) VALUES
	(1, 'weapon', 'SCM Weapon - Molotov', 344, -366.224, -1429.09, 25.5, 0, 0, 3, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(2, 'weapon', 'SCM Weapon - Chainsaw', 341, -365.791, -1425.25, 25.5, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(3, 'weapon', 'SCM Weapon - Pool Cue', 338, 2854, 944, 11, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(4, 'weapon', 'SCM Weapon - Nightstick', 334, 2241, 2425, 11, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(5, 'weapon', 'SCM Weapon - Golf Club', 333, 1418, 2774, 15, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(6, 'weapon', 'SCM Weapon - Shovel', 337, 1393, 2174, 10, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(7, 'weapon', 'SCM Weapon - Chainsaw', 341, 1061, 2074, 11, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(8, 'weapon', 'SCM Weapon - Parachute', 371, 2057, 2434, 166, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(9, 'weapon', 'SCM Weapon - Katana', 339, 2000, 1526, 15, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(10, 'weapon', 'SCM Weapon - Shovel', 337, 1997, 1658, 12, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(11, 'weapon', 'SCM Weapon - Golf Club', 333, 1457, -792, 90, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(12, 'weapon', 'SCM Weapon - Chainsaw', 341, 2371, -2543, 3, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(13, 'weapon', 'SCM Weapon - Knife', 335, 1124, -1335, 13, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(14, 'weapon', 'SCM Weapon - Katana', 339, 1862, -1862, 14, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(15, 'weapon', 'SCM Weapon - Brass Knuckles', 331, 1339, -1765, 14, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(16, 'weapon', 'SCM Weapon - Chainsaw', 341, 2192.24, -1988.75, 13.4185, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(17, 'weapon', 'SCM Weapon - Shovel', 337, 2459, -1708, 13.6, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(18, 'weapon', 'SCM Weapon - Chainsaw', 341, -2083, 298, 42, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(19, 'weapon', 'SCM Weapon - Baseball Bat', 336, -2306, 93, 35, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(20, 'weapon', 'SCM Weapon - Shovel', 337, -2796.42, 123.686, 6.844, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(21, 'weapon', 'SCM Weapon - Pool Cue', 338, -2135, 197, 35, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(22, 'weapon', 'SCM Weapon - Katana', 339, -2208, 696, 50, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(23, 'weapon', 'SCM Weapon - Brass Knuckles', 331, -2206, 961, 80, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(24, 'weapon', 'SCM Weapon - Nightstick', 334, -2222, -302, 43, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(25, 'weapon', 'SCM Weapon - Knife', 335, -1871, 351, 26, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(26, 'weapon', 'SCM Weapon - Golf Club', 333, -2715, -314, 7, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(27, 'weapon', 'SCM Weapon - Chainsaw', 341, -2359, -82, 35, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(28, 'weapon', 'SCM Weapon - Shovel', 337, -532, -106, 63, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(29, 'weapon', 'SCM Weapon - Shovel', 337, -1809, -1662, 24, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(30, 'weapon', 'SCM Weapon - Golf Club', 333, -2227, -2401, 31.4, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(31, 'weapon', 'SCM Weapon - Shovel', 337, 2240, -83, 27, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(32, 'weapon', 'SCM Weapon - Pool Cue', 338, 294, -188, 2, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(33, 'weapon', 'SCM Weapon - Chainsaw', 341, -761, -126, 66, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(34, 'weapon', 'SCM Weapon - Katana', 339, -1568, 2718, 56, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(35, 'weapon', 'SCM Weapon - Gift Weapon 11', 322, -2401, 2360, 5, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(36, 'weapon', 'SCM Weapon - Shovel', 337, 637, 832, -43, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(37, 'weapon', 'SCM Weapon - Chainsaw', 341, 680, 826, -39, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(38, 'weapon', 'SCM Weapon - Chainsaw', 341, 752, 260, 27, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(39, 'weapon', 'SCM Weapon - Brass Knuckles', 331, -246, 2725, 63, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(40, 'weapon', 'SCM Weapon - Knife', 335, -23, 2322, 24, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(41, 'weapon', 'SCM Weapon - Parachute', 371, -1542.86, 698.482, 139.266, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(42, 'weapon', 'SCM Weapon - Parachute', 371, -225.676, 1394.26, 172.014, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(43, 'weapon', 'SCM Weapon - Parachute', 371, -773.038, 2423.5, 157.086, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(44, 'weapon', 'SCM Weapon - Shovel', 337, 842.978, -17.3791, 64.2, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(45, 'weapon', 'SCM Weapon - Cane', 326, -2677.73, -192.347, 6.8518, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(46, 'weapon', 'SCM Weapon - Chainsaw', 341, -2752.24, -272.289, 6.5956, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(47, 'weapon', 'SCM Weapon - Cane', 326, -2617.47, -97.0801, 4.003, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(48, 'weapon', 'SCM Weapon - Cane', 326, -2777.19, -25.2984, 6.8721, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(49, 'weapon', 'SCM Weapon - Cane', 326, -2774.11, 87.8845, 6.7987, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(50, 'weapon', 'SCM Weapon - Cane', 326, -2770.62, 389.077, 4.2818, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(51, 'weapon', 'SCM Weapon - Katana', 339, -2535.63, 51.7034, 8.6512, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(52, 'weapon', 'SCM Weapon - Cane', 326, -2530.96, -34.1009, 25.2855, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(53, 'weapon', 'SCM Weapon - Cane', 326, -1691.65, 946.768, 24.8084, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(54, 'weapon', 'SCM Weapon - Cane', 326, -2664.52, 636.567, 14.2474, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(55, 'weapon', 'SCM Weapon - Cane', 326, -377.218, -1048.05, 58.9125, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(56, 'weapon', 'SCM Weapon - Cane', 326, -45.5928, -1148.53, 1.3953, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(57, 'weapon', 'SCM Weapon - Brass Knuckles', 331, 2428.5, -1679.27, 13.1633, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(58, 'weapon', 'SCM Weapon - Cane', 326, 1296.16, -1081.89, 26.1502, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(59, 'weapon', 'SCM Weapon - Cane', 326, 1390.61, -800.433, 81.7795, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(60, 'weapon', 'SCM Weapon - Baseball Bat', 336, 1308.47, 2111.29, 10.7221, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(61, 'weapon', 'SCM Weapon - Cane', 326, 2183.12, 2396.83, 10.7722, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(62, 'weapon', 'SCM Weapon - Baseball Bat', 336, 1081.13, 1603.7, 5.6, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(63, 'weapon', 'SCM Weapon - Knife', 335, 777.867, 1948.12, 5.3634, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(64, 'weapon', 'SCM Weapon - Shovel', 337, 1888.27, 2877.26, 10.1621, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(65, 'weapon', 'SCM Weapon - Cane', 326, 1420.94, 2519.88, 10.6199, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(66, 'weapon', 'SCM Weapon - Cane', 326, 1373, 2605.76, 10.8776, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(67, 'weapon', 'SCM Weapon - Katana', 339, 2631.26, 1722.39, 11.0312, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(68, 'weapon', 'SCM Weapon - Cane', 326, 2490.5, 1522.47, 10.576, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(69, 'weapon', 'SCM Weapon - Cane', 326, 455.458, -1485.9, 30.9717, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(70, 'weapon', 'SCM Weapon - Katana', 339, 2002.26, 981.395, 10.5, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(71, 'weapon', 'SCM Weapon - Flowers', 325, 1928.68, -1774.21, 13.54, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(72, 'weapon', 'SCM Weapon - Flowers', 325, 1875.91, -1917.18, 15.03, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(73, 'weapon', 'SCM Weapon - Flowers', 325, 2019.6, -1214.15, 21.47, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(74, 'weapon', 'SCM Weapon - Flowers', 325, 2209.77, -1001.69, 63.71, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(75, 'weapon', 'SCM Weapon - Flowers', 325, 1000.34, -1858.58, 12.3, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(76, 'weapon', 'SCM Weapon - Flowers', 325, 911.11, -1120.31, 24.03, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(77, 'weapon', 'SCM Weapon - Flowers', 325, 929, -750, 105.82, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(78, 'weapon', 'SCM Weapon - Flowers', 325, 1129.09, -2052.82, 69, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(79, 'weapon', 'SCM Weapon - Flowers', 325, -92.74, -1425.46, 12.75, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(80, 'weapon', 'SCM Weapon - Flowers', 325, -77.65, -1167.18, 2.16, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(81, 'weapon', 'SCM Weapon - Flowers', 325, 34, -2649, 40.73, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(82, 'weapon', 'SCM Weapon - Flowers', 325, -739, -1262, 68.12, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(83, 'weapon', 'SCM Weapon - Flowers', 325, -2177, -2423, 30.63, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(84, 'weapon', 'SCM Weapon - Flowers', 325, -615, -861, 105.72, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(85, 'weapon', 'SCM Weapon - Flowers', 325, -2051, 948, 55.4, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(86, 'weapon', 'SCM Weapon - Flowers', 325, -2658, -187, 4.18, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(87, 'weapon', 'SCM Weapon - Flowers', 325, -2649, 734.97, 27.96, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(88, 'weapon', 'SCM Weapon - Flowers', 325, -1791, 481, 25.68, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(89, 'weapon', 'SCM Weapon - Flowers', 325, -2797, 1182, 20.28, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(90, 'weapon', 'SCM Weapon - Flowers', 325, -2589.62, -16.165, 3.9662, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(91, 'weapon', 'SCM Weapon - Flowers', 325, -2865, 690, 23.43, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(92, 'weapon', 'SCM Weapon - Flowers', 325, -2339, -453, 80.24, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(93, 'weapon', 'SCM Weapon - Flowers', 325, -1955, -748, 36.22, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(94, 'weapon', 'SCM Weapon - Flowers', 325, -2420.03, 987.59, 45.3, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(95, 'weapon', 'SCM Weapon - Flowers', 325, -326.56, 2215.37, 43.57, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(96, 'weapon', 'SCM Weapon - Flowers', 325, -1319, 2705, 50.27, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(97, 'weapon', 'SCM Weapon - Flowers', 325, -2474.94, 2443.52, 16.03, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(98, 'weapon', 'SCM Weapon - Flowers', 325, -1670.64, 2590.49, 81.37, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(99, 'weapon', 'SCM Weapon - Flowers', 325, -892.98, 1971.66, 60.61, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(100, 'weapon', 'SCM Weapon - Flowers', 325, 1576.86, 2837.14, 10.83, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(101, 'weapon', 'SCM Weapon - Flowers', 325, 1492.72, 2773.76, 10.81, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(102, 'weapon', 'SCM Weapon - Flowers', 325, 2642.03, 1125.74, 11.03, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(103, 'weapon', 'SCM Weapon - Flowers', 325, 2025.24, 661.6, 10.93, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(104, 'weapon', 'SCM Weapon - Flowers', 325, 2181.82, 1484.97, 11.36, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(105, 'weapon', 'SCM Weapon - Flowers', 325, 2197.02, 2476.33, 11, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(106, 'weapon', 'SCM Weapon - Flowers', 325, 2212, 2526, 10.81, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(107, 'weapon', 'SCM Weapon - Flowers', 325, 2715.79, 1109.47, 6.7, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(108, 'weapon', 'SCM Weapon - Flowers', 325, 2489.25, 918.28, 11.02, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(109, 'weapon', 'SCM Weapon - Flowers', 325, 1472.08, 1890.09, 10.81, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(110, 'weapon', 'SCM Weapon - Nightstick', 334, 911.649, -1235.39, 17.6802, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(111, 'weapon', 'SCM Weapon - Sniper Rifle', 358, 733.433, -1356.47, 23.5229, 0, 0, 20, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(112, 'weapon', 'SCM Weapon - Baseball Bat', 336, 2285.74, -1647.31, 14.0782, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(113, 'weapon', 'SCM Weapon - Parachute', 371, 1797.6, -1308.88, 133.813, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(114, 'weapon', 'SCM Weapon - Knife', 335, -819, 1929, 7, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(115, 'weapon', 'SCM Weapon - Knife', 335, -938.39, 1901.65, 4.3, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(116, 'weapon', 'SCM Weapon - Grenade', 342, 2550.97, 2824.34, 10.6, 0, 0, 3, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(117, 'weapon', 'SCM Weapon - Parachute', 371, 2267.99, 1699.67, 101.4, 0, 0, 1, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(118, 'weapon', 'SCM Weapon - Rocket Launcher', 359, -686, 934, 13.5, 0, 0, 5, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(119, 'weapon', 'SCM Weapon - Heat Seeker', 360, -690, 934, 13.5, 0, 0, 5, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(120, 'weapon', 'SCM Weapon - Minigun', 362, -690, 939, 13.5, 0, 0, 5, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04'),
	(121, 'weapon', 'SCM Weapon - Flamethrower', 361, -686, 939, 13.5, 0, 0, 5, 300, 'offline_exact_scm', 1, '2026-06-02 06:46:04');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
