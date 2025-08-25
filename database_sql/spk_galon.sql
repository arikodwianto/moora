-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 25, 2025 at 03:01 PM
-- Server version: 8.0.30
-- PHP Version: 8.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `spk_galon`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add kriteria', 7, 'add_kriteria'),
(26, 'Can change kriteria', 7, 'change_kriteria'),
(27, 'Can delete kriteria', 7, 'delete_kriteria'),
(28, 'Can view kriteria', 7, 'view_kriteria'),
(29, 'Can add pelanggan', 8, 'add_pelanggan'),
(30, 'Can change pelanggan', 8, 'change_pelanggan'),
(31, 'Can delete pelanggan', 8, 'delete_pelanggan'),
(32, 'Can view pelanggan', 8, 'view_pelanggan'),
(33, 'Can add pesanan', 9, 'add_pesanan'),
(34, 'Can change pesanan', 9, 'change_pesanan'),
(35, 'Can delete pesanan', 9, 'delete_pesanan'),
(36, 'Can view pesanan', 9, 'view_pesanan'),
(37, 'Can add pengiriman', 10, 'add_pengiriman'),
(38, 'Can change pengiriman', 10, 'change_pengiriman'),
(39, 'Can delete pengiriman', 10, 'delete_pengiriman'),
(40, 'Can view pengiriman', 10, 'view_pengiriman'),
(41, 'Can add nilai', 11, 'add_nilai'),
(42, 'Can change nilai', 11, 'change_nilai'),
(43, 'Can delete nilai', 11, 'delete_nilai'),
(44, 'Can view nilai', 11, 'view_nilai');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$ypuZziOfqbOLm9m4IHtZXL$0O4HVxdB0CliLI2mSut2nCg7IK/UyuBSxJ3UIxveVIU=', '2025-08-25 14:27:23.084871', 1, 'admin', '', '', '', 1, 1, '2025-08-09 11:36:36.543529'),
(2, 'pbkdf2_sha256$600000$nZl8PI0oyyfytsg1lma3cF$WhcHVqaaXAU1U09al3PbU/rvhLhCH3u9GWsMwJ/rY9A=', '2025-08-25 14:35:55.888384', 0, 'user1', '', '', '', 0, 1, '2025-08-25 14:35:45.754409');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `core_kriteria`
--

CREATE TABLE `core_kriteria` (
  `id` bigint NOT NULL,
  `nama_kriteria` varchar(200) NOT NULL,
  `bobot` double NOT NULL,
  `tipe_kriteria` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `core_kriteria`
--

INSERT INTO `core_kriteria` (`id`, `nama_kriteria`, `bobot`, `tipe_kriteria`) VALUES
(3, 'Jumlah galon', 0.3, 'benefit'),
(4, 'Prioritas', 0.25, 'benefit'),
(5, 'Urgensi', 0.25, 'benefit'),
(6, 'Waktu', 2, 'cost');

-- --------------------------------------------------------

--
-- Table structure for table `core_nilai`
--

CREATE TABLE `core_nilai` (
  `id` bigint NOT NULL,
  `nilai` double NOT NULL,
  `kriteria_id` bigint NOT NULL,
  `pesanan_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `core_nilai`
--

INSERT INTO `core_nilai` (`id`, `nilai`, `kriteria_id`, `pesanan_id`) VALUES
(21, 4, 3, 8),
(22, 5, 4, 8),
(23, 3, 5, 8),
(24, 2, 6, 8),
(25, 2, 3, 9),
(26, 3, 4, 9),
(27, 4, 5, 9),
(28, 5, 6, 9),
(29, 5, 3, 10),
(30, 4, 4, 10),
(31, 2, 5, 10),
(32, 3, 6, 10),
(33, 3, 3, 11),
(34, 2, 4, 11),
(35, 5, 5, 11),
(36, 4, 6, 11),
(37, 4, 3, 12),
(38, 3, 4, 12),
(39, 2, 5, 12),
(40, 5, 6, 12),
(41, 1, 3, 13),
(42, 5, 4, 13),
(43, 4, 5, 13),
(44, 3, 6, 13),
(45, 5, 3, 14),
(46, 4, 4, 14),
(47, 3, 5, 14),
(48, 2, 6, 14),
(49, 2, 3, 15),
(50, 3, 4, 15),
(51, 5, 5, 15),
(52, 4, 6, 15),
(53, 3, 3, 16),
(54, 2, 4, 16),
(55, 4, 5, 16),
(56, 5, 6, 16),
(57, 4, 3, 17),
(58, 5, 4, 17),
(59, 2, 5, 17),
(60, 3, 6, 17),
(61, 5, 3, 18),
(62, 4, 4, 18),
(63, 3, 5, 18),
(64, 2, 6, 18),
(65, 2, 3, 19),
(66, 3, 4, 19),
(67, 5, 5, 19),
(68, 4, 6, 19),
(69, 3, 3, 20),
(70, 2, 4, 20),
(71, 4, 5, 20),
(72, 5, 6, 20);

-- --------------------------------------------------------

--
-- Table structure for table `core_pelanggan`
--

CREATE TABLE `core_pelanggan` (
  `id` bigint NOT NULL,
  `nama_pelanggan` varchar(200) NOT NULL,
  `alamat` longtext NOT NULL,
  `no_hp` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `core_pelanggan`
--

INSERT INTO `core_pelanggan` (`id`, `nama_pelanggan`, `alamat`, `no_hp`) VALUES
(15, 'Andi Saputra', 'Jl. Merdeka No. 10', '081234567801'),
(16, 'Budi Santoso', 'Jl. Wiratno No. 5', '081234567802'),
(17, 'Citra Dewi', 'Jl. Sultan Sulaiman No. 12', '081234567803'),
(18, 'Dedi Firmansyah', 'Jl. Basuki Rahmat No. 7', '081234567804'),
(19, 'Eka Pratama', 'Jl. Raja Haji Fisabilillah No. 3', '081234567805'),
(20, 'Fajar Nugroho', 'Jl. Ir. Sutami No. 14', '081234567806'),
(21, 'Gina Lestari', 'Jl. Hang Tuah No. 21', '081234567807'),
(22, 'Hariyanto', 'Jl. D.I. Panjaitan No. 8', '081234567808'),
(23, 'Indah Puspita', 'Jl. Kijang Lama No. 15', '081234567809'),
(24, 'Joko Widodo', 'Jl. Bakar Batu No. 2', '081234567810'),
(25, 'Kurniawan Saputra', 'Jl. Agus Salim No. 11', '081234567811'),
(26, 'Lestari Wulandari', 'Jl. Pramuka No. 9', '081234567812'),
(27, 'Mahmud Rizky', 'Jl. Sei Jang No. 22', '081234567813'),
(28, 'Nadia Putri', 'Jl. Tugu Pahlawan No. 33', '081234567814'),
(29, 'Oscar Pratama', 'Jl. Kota Piring No. 44', '081234567815'),
(30, 'Putri Ayu', 'Jl. Bukit Bestari No. 55', '081234567816'),
(31, 'Qori Maulida', 'Jl. Pinang Merah No. 66', '081234567817'),
(32, 'Rizal Hakim', 'Jl. Dompak No. 77', '081234567818'),
(33, 'Siti Aminah', 'Jl. Kampung Baru No. 88', '081234567819'),
(34, 'Taufik Hidayat', 'Jl. Senggarang No. 99', '081234567820');

-- --------------------------------------------------------

--
-- Table structure for table `core_pengiriman`
--

CREATE TABLE `core_pengiriman` (
  `id` bigint NOT NULL,
  `tanggal_kirim` date NOT NULL,
  `status_pengiriman` varchar(50) NOT NULL,
  `pesanan_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `core_pesanan`
--

CREATE TABLE `core_pesanan` (
  `id` bigint NOT NULL,
  `tanggal_pesan` date NOT NULL,
  `jumlah_galon` int NOT NULL,
  `tanggal_pengiriman` date NOT NULL,
  `pelanggan_id` bigint NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `core_pesanan`
--

INSERT INTO `core_pesanan` (`id`, `tanggal_pesan`, `jumlah_galon`, `tanggal_pengiriman`, `pelanggan_id`, `status`) VALUES
(8, '2025-07-05', 2, '2025-07-06', 15, 1),
(9, '2025-07-10', 4, '2025-07-11', 20, 0),
(10, '2025-07-20', 1, '2025-07-21', 25, 1),
(11, '2025-08-01', 3, '2025-08-02', 15, 1),
(12, '2025-08-03', 2, '2025-08-04', 16, 0),
(13, '2025-08-05', 5, '2025-08-06', 19, 1),
(14, '2025-08-07', 1, '2025-08-08', 21, 0),
(15, '2025-08-08', 4, '2025-08-09', 24, 1),
(16, '2025-08-10', 2, '2025-08-11', 26, 0),
(17, '2025-08-12', 3, '2025-08-13', 28, 1),
(18, '2025-08-14', 6, '2025-08-15', 30, 0),
(19, '2025-08-16', 2, '2025-08-17', 32, 1),
(20, '2025-08-18', 4, '2025-08-19', 34, 0);

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'core', 'kriteria'),
(11, 'core', 'nilai'),
(8, 'core', 'pelanggan'),
(10, 'core', 'pengiriman'),
(9, 'core', 'pesanan'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-08-09 11:36:15.133755'),
(2, 'auth', '0001_initial', '2025-08-09 11:36:15.740742'),
(3, 'admin', '0001_initial', '2025-08-09 11:36:15.875333'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-08-09 11:36:15.891283'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-08-09 11:36:15.902584'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-08-09 11:36:15.984618'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-08-09 11:36:16.047383'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-08-09 11:36:16.085844'),
(9, 'auth', '0004_alter_user_username_opts', '2025-08-09 11:36:16.124943'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-08-09 11:36:16.182063'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-08-09 11:36:16.184784'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-08-09 11:36:16.196214'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-08-09 11:36:16.271674'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-08-09 11:36:16.333767'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-08-09 11:36:16.359130'),
(16, 'auth', '0011_update_proxy_permissions', '2025-08-09 11:36:16.369341'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-08-09 11:36:16.425085'),
(18, 'core', '0001_initial', '2025-08-09 11:36:16.680633'),
(19, 'sessions', '0001_initial', '2025-08-09 11:36:16.726625'),
(20, 'core', '0002_pesanan_status', '2025-08-25 14:26:21.032284');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('attkntea5msylib5j9as2we8mtp9rafz', '.eJxVjDsOwjAQBe_iGln-fyjpcwZrvV7hALKlOKkQd0eWUkD7Zua9WYJjr-kYtKW1sCuT7PK7ZcAntQnKA9q9c-xt39bMp8JPOvjSC71up_t3UGHUWQcRo3bR2yyiJKFCyE5pAVmSA3Rgs7VkjfCIYEqJ5Mk4ZYLxQUmN7PMFwnI3Gg:1uq5Pn:T3LO2LKY_wPgTHjgTW-isp4qIjvnrdVbBVTfKn6sY2Y', '2025-09-07 07:45:23.375778'),
('erohxx1hbzuu8xpl17s7yhz8zz9re9md', '.eJxVjDsOwjAQBe_iGln-fyjpcwZrvV7hALKlOKkQd0eWUkD7Zua9WYJjr-kYtKW1sCuT7PK7ZcAntQnKA9q9c-xt39bMp8JPOvjSC71up_t3UGHUWQcRo3bR2yyiJKFCyE5pAVmSA3Rgs7VkjfCIYEqJ5Mk4ZYLxQUmN7PMFwnI3Gg:1ukxcR:ShuMTtC-HHwoGk3HwEv9ToJ_D-ZZ5Egp4J9Z9bKlkDY', '2025-08-24 04:25:15.441210'),
('ptulyjdvfhvtxob21e08knn3om93mkus', '.eJxVjEEOwiAQRe_C2pAAI1CX7j0DAWZGqgaS0q4a764kXejy__fydhHitpawdVrCjOIitDj9finmJ9UB8BHrvcnc6rrMSQ5FHrTLW0N6XQ_3L1BiLyM7oSZjkT0wKALHicDClFXSFg2wYgccGc743ZiMds4jkk7KZa-jeH8A8r44cQ:1uqYId:39w5sq_KtMCyg-3vyfXE7B8ntidspXAkDOa7Y5fyQtw', '2025-09-08 14:35:55.896972');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `core_kriteria`
--
ALTER TABLE `core_kriteria`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `core_nilai`
--
ALTER TABLE `core_nilai`
  ADD PRIMARY KEY (`id`),
  ADD KEY `core_nilai_kriteria_id_26b0fe90_fk_core_kriteria_id` (`kriteria_id`),
  ADD KEY `core_nilai_pesanan_id_85cc932a_fk_core_pesanan_id` (`pesanan_id`);

--
-- Indexes for table `core_pelanggan`
--
ALTER TABLE `core_pelanggan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `core_pengiriman`
--
ALTER TABLE `core_pengiriman`
  ADD PRIMARY KEY (`id`),
  ADD KEY `core_pengiriman_pesanan_id_234de4eb_fk_core_pesanan_id` (`pesanan_id`);

--
-- Indexes for table `core_pesanan`
--
ALTER TABLE `core_pesanan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `core_pesanan_pelanggan_id_06a71b9c_fk_core_pelanggan_id` (`pelanggan_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `core_kriteria`
--
ALTER TABLE `core_kriteria`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `core_nilai`
--
ALTER TABLE `core_nilai`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `core_pelanggan`
--
ALTER TABLE `core_pelanggan`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `core_pengiriman`
--
ALTER TABLE `core_pengiriman`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `core_pesanan`
--
ALTER TABLE `core_pesanan`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `core_nilai`
--
ALTER TABLE `core_nilai`
  ADD CONSTRAINT `core_nilai_kriteria_id_26b0fe90_fk_core_kriteria_id` FOREIGN KEY (`kriteria_id`) REFERENCES `core_kriteria` (`id`),
  ADD CONSTRAINT `core_nilai_pesanan_id_85cc932a_fk_core_pesanan_id` FOREIGN KEY (`pesanan_id`) REFERENCES `core_pesanan` (`id`);

--
-- Constraints for table `core_pengiriman`
--
ALTER TABLE `core_pengiriman`
  ADD CONSTRAINT `core_pengiriman_pesanan_id_234de4eb_fk_core_pesanan_id` FOREIGN KEY (`pesanan_id`) REFERENCES `core_pesanan` (`id`);

--
-- Constraints for table `core_pesanan`
--
ALTER TABLE `core_pesanan`
  ADD CONSTRAINT `core_pesanan_pelanggan_id_06a71b9c_fk_core_pelanggan_id` FOREIGN KEY (`pelanggan_id`) REFERENCES `core_pelanggan` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
