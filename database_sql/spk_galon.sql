-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 10, 2025 at 02:24 PM
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

--
-- Dumping data for table `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(1, 'Admin');

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
(1, 'pbkdf2_sha256$600000$h7tv0TOGohylieECmO6vXp$4jq2BK+8qNHVg20gtx9iPaCRa6p5nhBMfmlwmOdEWfM=', '2025-09-10 14:23:12.533081', 1, 'owner', '', '', '', 1, 1, '2025-09-10 12:13:31.532171'),
(2, 'pbkdf2_sha256$600000$wNtWTo14rLwGCarPvy329l$yuVYjhmoVjeA4/TDyrs5ScCTWU9rOYpKlHXqEClNw/A=', '2025-09-10 14:10:49.472842', 0, 'admin', '', '', '', 0, 1, '2025-09-10 12:25:02.630162');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auth_user_groups`
--

INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES
(1, 2, 1);

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
(4, 'Jumlah galon', 0.3, 'benefit'),
(5, 'Prioritas', 0.25, 'benefit'),
(6, 'Urgensi', 0.25, 'benefit'),
(7, 'Waktu Pemesanan', 0.2, 'cost');

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
(47, 0.7, 4, 3),
(48, 0.8, 5, 3),
(49, 0.6, 6, 3),
(50, 0.9, 7, 3),
(51, 0.8, 4, 4),
(52, 0.7, 5, 4),
(53, 0.7, 6, 4),
(54, 0.8, 7, 4),
(55, 0.6, 4, 5),
(56, 0.9, 5, 5),
(57, 0.8, 6, 5),
(58, 0.7, 7, 5),
(59, 0.9, 4, 6),
(60, 0.6, 5, 6),
(61, 0.7, 6, 6),
(62, 0.8, 7, 6),
(63, 0.8, 4, 7),
(64, 0.7, 5, 7),
(65, 0.9, 6, 7),
(66, 0.6, 7, 7),
(67, 0.7, 4, 8),
(68, 0.8, 5, 8),
(69, 0.6, 6, 8),
(70, 0.9, 7, 8),
(71, 0.6, 4, 9),
(72, 0.9, 5, 9),
(73, 0.8, 6, 9),
(74, 0.7, 7, 9),
(75, 0.9, 4, 10),
(76, 0.7, 5, 10),
(77, 0.7, 6, 10),
(78, 0.8, 7, 10),
(79, 0.7, 4, 11),
(80, 0.8, 5, 11),
(81, 0.9, 6, 11),
(82, 0.6, 7, 11),
(83, 0.8, 4, 12),
(84, 0.7, 5, 12),
(85, 0.6, 6, 12),
(86, 0.9, 7, 12),
(87, 0.6, 4, 13),
(88, 0.8, 5, 13),
(89, 0.7, 6, 13),
(90, 0.9, 7, 13),
(91, 0.9, 4, 14),
(92, 0.7, 5, 14),
(93, 0.8, 6, 14),
(94, 0.6, 7, 14),
(95, 0.8, 4, 15),
(96, 0.9, 5, 15),
(97, 0.7, 6, 15),
(98, 0.6, 7, 15),
(99, 0.7, 4, 16),
(100, 0.6, 5, 16),
(101, 0.8, 6, 16),
(102, 0.9, 7, 16),
(103, 0.9, 4, 17),
(104, 0.7, 5, 17),
(105, 0.6, 6, 17),
(106, 0.8, 7, 17),
(107, 0.6, 4, 18),
(108, 0.9, 5, 18),
(109, 0.8, 6, 18),
(110, 0.7, 7, 18),
(111, 0.7, 4, 19),
(112, 0.8, 5, 19),
(113, 0.9, 6, 19),
(114, 0.6, 7, 19),
(115, 0.8, 4, 20),
(116, 0.7, 5, 20),
(117, 0.6, 6, 20),
(118, 0.9, 7, 20),
(119, 0.9, 4, 21),
(120, 0.6, 5, 21),
(121, 0.8, 6, 21),
(122, 0.7, 7, 21),
(123, 0.7, 4, 22),
(124, 0.9, 5, 22),
(125, 0.6, 6, 22),
(126, 0.8, 7, 22);

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
(3, 'Andi Pratama', 'Jl. Basuki Rahmat', '081234567890'),
(4, 'Budi Santoso', 'Jl. DI Panjaitan', '082134567891'),
(5, 'Citra Dewi', 'Jl. Sultan Machmud', '083234567892'),
(6, 'Dewi Lestari', 'Jl. Merdeka', '084234567893'),
(7, 'Eko Wijaya', 'Jl. Ketapang', '085234567894'),
(8, 'Fajar Nugroho', 'Jl. Kamboja', '086234567895'),
(9, 'Gina Putri', 'Jl. Potong Lembu', '087234567896'),
(10, 'Hariyanto', 'Jl. Brigjen Katamso', '088234567897'),
(11, 'Indah Sari', 'Jl. Wiratno', '089234567898'),
(12, 'Joko Susanto', 'Jl. Tambak', '081034567899'),
(13, 'Kartika Ayu', 'Jl. Pemuda', '081134567800'),
(14, 'Lukman Hakim', 'Jl. Pos', '081234567801'),
(15, 'Mega Wulandari', 'Jl. Pramuka', '081334567802'),
(16, 'Nanda Pratama', 'Jl. Kuantan', '081434567803'),
(17, 'Oka Saputra', 'Jl. Sumatera', '081534567804'),
(18, 'Putri Amelia', 'Jl. Kepodang', '081634567805'),
(19, 'Rizky Kurniawan', 'Jl. Rawa Sari', '081734567806'),
(20, 'Siti Aisyah', 'Jl. Haji Agus Salim', '081834567807'),
(21, 'Taufik Hidayat', 'Jl. Potong Lembu 2', '081934567808'),
(22, 'Umi Kalsum', 'Jl. Sultan Abdulrahman', '082034567809');

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
  `status` tinyint(1) NOT NULL,
  `pelanggan_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `core_pesanan`
--

INSERT INTO `core_pesanan` (`id`, `tanggal_pesan`, `jumlah_galon`, `tanggal_pengiriman`, `status`, `pelanggan_id`) VALUES
(3, '2025-08-01', 2, '2025-08-02', 0, 3),
(4, '2025-08-03', 5, '2025-08-04', 1, 4),
(5, '2025-08-05', 3, '2025-08-06', 0, 5),
(6, '2025-08-07', 1, '2025-08-08', 0, 6),
(7, '2025-08-09', 4, '2025-08-10', 1, 7),
(8, '2025-08-11', 6, '2025-08-12', 0, 8),
(9, '2025-08-13', 2, '2025-08-14', 1, 9),
(10, '2025-08-15', 3, '2025-08-16', 0, 10),
(11, '2025-08-17', 5, '2025-08-18', 0, 11),
(12, '2025-08-19', 2, '2025-08-20', 1, 12),
(13, '2025-08-21', 1, '2025-08-22', 0, 13),
(14, '2025-08-23', 4, '2025-08-24', 0, 14),
(15, '2025-08-25', 3, '2025-08-26', 1, 15),
(16, '2025-08-27', 6, '2025-08-28', 0, 16),
(17, '2025-08-29', 2, '2025-08-30', 1, 17),
(18, '2025-08-31', 5, '2025-09-01', 0, 18),
(19, '2025-09-02', 4, '2025-09-03', 1, 19),
(20, '2025-09-04', 2, '2025-09-05', 0, 20),
(21, '2025-09-06', 3, '2025-09-07', 0, 21),
(22, '2025-09-08', 1, '2025-09-09', 1, 22);

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
(1, 'contenttypes', '0001_initial', '2025-09-10 12:13:02.165539'),
(2, 'auth', '0001_initial', '2025-09-10 12:13:02.621671'),
(3, 'admin', '0001_initial', '2025-09-10 12:13:02.741565'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-09-10 12:13:02.749850'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-09-10 12:13:02.765516'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-09-10 12:13:02.853885'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-09-10 12:13:02.917770'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-09-10 12:13:02.965857'),
(9, 'auth', '0004_alter_user_username_opts', '2025-09-10 12:13:02.981675'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-09-10 12:13:03.046387'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-09-10 12:13:03.046387'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-09-10 12:13:03.062928'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-09-10 12:13:03.118815'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-09-10 12:13:03.183342'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-09-10 12:13:03.215034'),
(16, 'auth', '0011_update_proxy_permissions', '2025-09-10 12:13:03.230871'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-09-10 12:13:03.294943'),
(18, 'core', '0001_initial', '2025-09-10 12:13:03.576785'),
(19, 'sessions', '0001_initial', '2025-09-10 12:13:03.617498');

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
('fh9ayxla5rpl6lbkdynquxs0lrgc7tgf', '.eJxVjEEOwiAQRe_C2pCWDgVduu8ZyMwwSNVAUtqV8e7apAvd_vfef6mA25rD1mQJc1QX1avT70bIDyk7iHcst6q5lnWZSe-KPmjTU43yvB7u30HGlr-10EDOnx0JdsalZJgFPPhOcCSOksCLFcMUEzBEA0PvwY7AaD0IJ_X-ABeYOS0:1uwLj6:Y49s_Rm89aeDVdOWLROVvAfWD5KHpVXbdIhPXJ4tDzs', '2025-09-24 14:23:12.539326');

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT for table `core_pelanggan`
--
ALTER TABLE `core_pelanggan`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `core_pengiriman`
--
ALTER TABLE `core_pengiriman`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `core_pesanan`
--
ALTER TABLE `core_pesanan`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

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
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

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
