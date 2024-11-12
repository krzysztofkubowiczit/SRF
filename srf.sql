-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Lis 12, 2024 at 05:59 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `srf`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(25, 'Can add cast member', 7, 'add_castmember'),
(26, 'Can change cast member', 7, 'change_castmember'),
(27, 'Can delete cast member', 7, 'delete_castmember'),
(28, 'Can view cast member', 7, 'view_castmember'),
(29, 'Can add director', 8, 'add_director'),
(30, 'Can change director', 8, 'change_director'),
(31, 'Can delete director', 8, 'delete_director'),
(32, 'Can view director', 8, 'view_director'),
(33, 'Can add genre', 9, 'add_genre'),
(34, 'Can change genre', 9, 'change_genre'),
(35, 'Can delete genre', 9, 'delete_genre'),
(36, 'Can view genre', 9, 'view_genre'),
(37, 'Can add keyword', 10, 'add_keyword'),
(38, 'Can change keyword', 10, 'change_keyword'),
(39, 'Can delete keyword', 10, 'delete_keyword'),
(40, 'Can view keyword', 10, 'view_keyword'),
(41, 'Can add movie', 11, 'add_movie'),
(42, 'Can change movie', 11, 'change_movie'),
(43, 'Can delete movie', 11, 'delete_movie'),
(44, 'Can view movie', 11, 'view_movie'),
(45, 'Can add rating', 12, 'add_rating'),
(46, 'Can change rating', 12, 'change_rating'),
(47, 'Can delete rating', 12, 'delete_rating'),
(48, 'Can view rating', 12, 'view_rating'),
(49, 'Can add favorite movie', 13, 'add_favoritemovie'),
(50, 'Can change favorite movie', 13, 'change_favoritemovie'),
(51, 'Can delete favorite movie', 13, 'delete_favoritemovie'),
(52, 'Can view favorite movie', 13, 'view_favoritemovie');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$Pm1L210CIUkQagldrgD98o$eAODqNyNcK4KpG3LpGecn3aTmZ5yeqv+ImwgSZ9L5WY=', NULL, 1, 'admin', '', '', 'krzysztof.kubowicz.it@gmail.com', 1, 1, '2024-11-12 14:49:24.470841'),
(2, 'pbkdf2_sha256$600000$qQK6OSgSIg89336g1rikm2$apU1Ry0+tHUZ7PaUs6KEGTrGjhzxjsj4K4Nt1Jr0vtc=', NULL, 0, 'user1', '', '', '', 0, 1, '2024-11-12 16:11:13.064990'),
(3, 'pbkdf2_sha256$600000$WotFeBvHNPUyEPjS0G7Yxp$RsrHfXdOWTr43QOwGD+twcONaK5Pw/1K6cRJkRPIWe0=', NULL, 0, 'user2', '', '', '', 0, 1, '2024-11-12 16:11:27.968727');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'movies', 'castmember'),
(8, 'movies', 'director'),
(13, 'movies', 'favoritemovie'),
(9, 'movies', 'genre'),
(10, 'movies', 'keyword'),
(11, 'movies', 'movie'),
(12, 'movies', 'rating'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-11-12 14:47:04.331902'),
(2, 'auth', '0001_initial', '2024-11-12 14:47:05.560911'),
(3, 'admin', '0001_initial', '2024-11-12 14:47:05.906903'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-11-12 14:47:05.914903'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-11-12 14:47:05.921952'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-11-12 14:47:06.051905'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-11-12 14:47:06.200904'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-11-12 14:47:06.212911'),
(9, 'auth', '0004_alter_user_username_opts', '2024-11-12 14:47:06.218902'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-11-12 14:47:06.303903'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-11-12 14:47:06.306903'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-11-12 14:47:06.313908'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-11-12 14:47:06.325908'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-11-12 14:47:06.339903'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-11-12 14:47:06.350906'),
(16, 'auth', '0011_update_proxy_permissions', '2024-11-12 14:47:06.358903'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-11-12 14:47:06.370902'),
(18, 'movies', '0001_initial', '2024-11-12 14:47:08.363906'),
(19, 'sessions', '0001_initial', '2024-11-12 14:47:08.394903');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `movies_castmember`
--

CREATE TABLE `movies_castmember` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies_castmember`
--

INSERT INTO `movies_castmember` (`id`, `name`) VALUES
(1, 'Robert Downey Jr.'),
(2, 'Chris Evans'),
(3, 'Scarlett Johansson'),
(4, 'Robert Downey Jr.'),
(5, 'Chris Evans'),
(6, 'Scarlett Johansson');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `movies_director`
--

CREATE TABLE `movies_director` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies_director`
--

INSERT INTO `movies_director` (`id`, `name`) VALUES
(1, 'Christopher Nolan'),
(2, 'Steven Spielberg'),
(3, 'Christopher Nolan'),
(4, 'Steven Spielberg');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `movies_favoritemovie`
--

CREATE TABLE `movies_favoritemovie` (
  `id` bigint(20) NOT NULL,
  `movie_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies_favoritemovie`
--

INSERT INTO `movies_favoritemovie` (`id`, `movie_id`, `user_id`) VALUES
(1, 4, 2),
(2, 5, 2),
(3, 6, 3);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `movies_genre`
--

CREATE TABLE `movies_genre` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies_genre`
--

INSERT INTO `movies_genre` (`id`, `name`) VALUES
(1, 'Akcja'),
(2, 'Komedia'),
(3, 'Dramat'),
(4, 'Akcja'),
(5, 'Komedia'),
(6, 'Dramat');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `movies_keyword`
--

CREATE TABLE `movies_keyword` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies_keyword`
--

INSERT INTO `movies_keyword` (`id`, `name`) VALUES
(1, 'Superbohater'),
(2, 'Przyjaźń'),
(3, 'Miłość'),
(4, 'Superbohater'),
(5, 'Przyjaźń'),
(6, 'Miłość');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `movies_movie`
--

CREATE TABLE `movies_movie` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `release_year` int(11) NOT NULL,
  `description` longtext NOT NULL,
  `poster_url` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies_movie`
--

INSERT INTO `movies_movie` (`id`, `title`, `release_year`, `description`, `poster_url`) VALUES
(1, 'Iron Man', 2008, 'Historia genialnego wynalazcy Tony\'ego Starka.', 'https://link_do_plakatu_iron_man.jpg'),
(2, 'Avengers', 2012, 'Superbohaterowie łączą siły, by uratować świat.', 'https://link_do_plakatu_avengers.jpg'),
(3, 'Forrest Gump', 1994, 'Opowieść o życiu Forresta Gumpa.', 'https://link_do_plakatu_forrest_gump.jpg'),
(4, 'Iron Man', 2008, 'Historia genialnego wynalazcy Tony\'ego Starka.', 'https://link_do_plakatu_iron_man.jpg'),
(5, 'Avengers', 2012, 'Superbohaterowie łączą siły, by uratować świat.', 'https://link_do_plakatu_avengers.jpg'),
(6, 'Forrest Gump', 1994, 'Opowieść o życiu Forresta Gumpa.', 'https://link_do_plakatu_forrest_gump.jpg');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `movies_movie_cast`
--

CREATE TABLE `movies_movie_cast` (
  `id` bigint(20) NOT NULL,
  `movie_id` bigint(20) NOT NULL,
  `castmember_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies_movie_cast`
--

INSERT INTO `movies_movie_cast` (`id`, `movie_id`, `castmember_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 2, 2),
(4, 2, 3),
(5, 4, 4),
(6, 5, 4),
(7, 5, 5),
(8, 5, 6);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `movies_movie_directors`
--

CREATE TABLE `movies_movie_directors` (
  `id` bigint(20) NOT NULL,
  `movie_id` bigint(20) NOT NULL,
  `director_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies_movie_directors`
--

INSERT INTO `movies_movie_directors` (`id`, `movie_id`, `director_id`) VALUES
(1, 1, 2),
(2, 3, 1),
(3, 4, 4),
(4, 6, 3);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `movies_movie_genres`
--

CREATE TABLE `movies_movie_genres` (
  `id` bigint(20) NOT NULL,
  `movie_id` bigint(20) NOT NULL,
  `genre_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies_movie_genres`
--

INSERT INTO `movies_movie_genres` (`id`, `movie_id`, `genre_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 3),
(4, 4, 4),
(5, 5, 4),
(6, 6, 6);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `movies_movie_keywords`
--

CREATE TABLE `movies_movie_keywords` (
  `id` bigint(20) NOT NULL,
  `movie_id` bigint(20) NOT NULL,
  `keyword_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies_movie_keywords`
--

INSERT INTO `movies_movie_keywords` (`id`, `movie_id`, `keyword_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 2, 2),
(4, 3, 2),
(5, 3, 3),
(6, 4, 4),
(7, 5, 4),
(8, 5, 5),
(9, 6, 5),
(10, 6, 6);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `movies_rating`
--

CREATE TABLE `movies_rating` (
  `id` bigint(20) NOT NULL,
  `score` int(11) NOT NULL,
  `comment` longtext DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `movie_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies_rating`
--

INSERT INTO `movies_rating` (`id`, `score`, `comment`, `timestamp`, `movie_id`, `user_id`) VALUES
(4, 5, 'Świetny film!', '2024-11-12 16:12:55.569036', 4, 2),
(5, 4, 'Bardzo dobry, ale mógł być lepszy.', '2024-11-12 16:12:55.585567', 5, 2),
(6, 5, 'Klasyk!', '2024-11-12 16:12:55.590570', 6, 3);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indeksy dla tabeli `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indeksy dla tabeli `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indeksy dla tabeli `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indeksy dla tabeli `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indeksy dla tabeli `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indeksy dla tabeli `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indeksy dla tabeli `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indeksy dla tabeli `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indeksy dla tabeli `movies_castmember`
--
ALTER TABLE `movies_castmember`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `movies_director`
--
ALTER TABLE `movies_director`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `movies_favoritemovie`
--
ALTER TABLE `movies_favoritemovie`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movies_favoritemovie_movie_id_abfa926b_fk_movies_movie_id` (`movie_id`),
  ADD KEY `movies_favoritemovie_user_id_a43bab59_fk_auth_user_id` (`user_id`);

--
-- Indeksy dla tabeli `movies_genre`
--
ALTER TABLE `movies_genre`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `movies_keyword`
--
ALTER TABLE `movies_keyword`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `movies_movie`
--
ALTER TABLE `movies_movie`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `movies_movie_cast`
--
ALTER TABLE `movies_movie_cast`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `movies_movie_cast_movie_id_castmember_id_017bce87_uniq` (`movie_id`,`castmember_id`),
  ADD KEY `movies_movie_cast_castmember_id_ca75f780_fk_movies_castmember_id` (`castmember_id`);

--
-- Indeksy dla tabeli `movies_movie_directors`
--
ALTER TABLE `movies_movie_directors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `movies_movie_directors_movie_id_director_id_eb887327_uniq` (`movie_id`,`director_id`),
  ADD KEY `movies_movie_directo_director_id_9cddcb44_fk_movies_di` (`director_id`);

--
-- Indeksy dla tabeli `movies_movie_genres`
--
ALTER TABLE `movies_movie_genres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `movies_movie_genres_movie_id_genre_id_5ff3c723_uniq` (`movie_id`,`genre_id`),
  ADD KEY `movies_movie_genres_genre_id_c3609db2_fk_movies_genre_id` (`genre_id`);

--
-- Indeksy dla tabeli `movies_movie_keywords`
--
ALTER TABLE `movies_movie_keywords`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `movies_movie_keywords_movie_id_keyword_id_4ecf4efb_uniq` (`movie_id`,`keyword_id`),
  ADD KEY `movies_movie_keywords_keyword_id_a7e7b97e_fk_movies_keyword_id` (`keyword_id`);

--
-- Indeksy dla tabeli `movies_rating`
--
ALTER TABLE `movies_rating`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movies_rating_movie_id_697b1621_fk_movies_movie_id` (`movie_id`),
  ADD KEY `movies_rating_user_id_30a94f7b_fk_auth_user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `movies_castmember`
--
ALTER TABLE `movies_castmember`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `movies_director`
--
ALTER TABLE `movies_director`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `movies_favoritemovie`
--
ALTER TABLE `movies_favoritemovie`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `movies_genre`
--
ALTER TABLE `movies_genre`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `movies_keyword`
--
ALTER TABLE `movies_keyword`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `movies_movie`
--
ALTER TABLE `movies_movie`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `movies_movie_cast`
--
ALTER TABLE `movies_movie_cast`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `movies_movie_directors`
--
ALTER TABLE `movies_movie_directors`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `movies_movie_genres`
--
ALTER TABLE `movies_movie_genres`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `movies_movie_keywords`
--
ALTER TABLE `movies_movie_keywords`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `movies_rating`
--
ALTER TABLE `movies_rating`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `movies_favoritemovie`
--
ALTER TABLE `movies_favoritemovie`
  ADD CONSTRAINT `movies_favoritemovie_movie_id_abfa926b_fk_movies_movie_id` FOREIGN KEY (`movie_id`) REFERENCES `movies_movie` (`id`),
  ADD CONSTRAINT `movies_favoritemovie_user_id_a43bab59_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `movies_movie_cast`
--
ALTER TABLE `movies_movie_cast`
  ADD CONSTRAINT `movies_movie_cast_castmember_id_ca75f780_fk_movies_castmember_id` FOREIGN KEY (`castmember_id`) REFERENCES `movies_castmember` (`id`),
  ADD CONSTRAINT `movies_movie_cast_movie_id_5d4ec172_fk_movies_movie_id` FOREIGN KEY (`movie_id`) REFERENCES `movies_movie` (`id`);

--
-- Constraints for table `movies_movie_directors`
--
ALTER TABLE `movies_movie_directors`
  ADD CONSTRAINT `movies_movie_directo_director_id_9cddcb44_fk_movies_di` FOREIGN KEY (`director_id`) REFERENCES `movies_director` (`id`),
  ADD CONSTRAINT `movies_movie_directors_movie_id_7f54bd58_fk_movies_movie_id` FOREIGN KEY (`movie_id`) REFERENCES `movies_movie` (`id`);

--
-- Constraints for table `movies_movie_genres`
--
ALTER TABLE `movies_movie_genres`
  ADD CONSTRAINT `movies_movie_genres_genre_id_c3609db2_fk_movies_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `movies_genre` (`id`),
  ADD CONSTRAINT `movies_movie_genres_movie_id_ff5e55a1_fk_movies_movie_id` FOREIGN KEY (`movie_id`) REFERENCES `movies_movie` (`id`);

--
-- Constraints for table `movies_movie_keywords`
--
ALTER TABLE `movies_movie_keywords`
  ADD CONSTRAINT `movies_movie_keywords_keyword_id_a7e7b97e_fk_movies_keyword_id` FOREIGN KEY (`keyword_id`) REFERENCES `movies_keyword` (`id`),
  ADD CONSTRAINT `movies_movie_keywords_movie_id_a190a1af_fk_movies_movie_id` FOREIGN KEY (`movie_id`) REFERENCES `movies_movie` (`id`);

--
-- Constraints for table `movies_rating`
--
ALTER TABLE `movies_rating`
  ADD CONSTRAINT `movies_rating_movie_id_697b1621_fk_movies_movie_id` FOREIGN KEY (`movie_id`) REFERENCES `movies_movie` (`id`),
  ADD CONSTRAINT `movies_rating_user_id_30a94f7b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
