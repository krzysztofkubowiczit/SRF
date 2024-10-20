-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Paź 21, 2024 at 01:57 AM
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
-- Database: `movie_recommendation`
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
(1, 'Can add cast', 1, 'add_cast'),
(2, 'Can change cast', 1, 'change_cast'),
(3, 'Can delete cast', 1, 'delete_cast'),
(4, 'Can view cast', 1, 'view_cast'),
(5, 'Can add genre', 2, 'add_genre'),
(6, 'Can change genre', 2, 'change_genre'),
(7, 'Can delete genre', 2, 'delete_genre'),
(8, 'Can view genre', 2, 'view_genre'),
(9, 'Can add movie', 3, 'add_movie'),
(10, 'Can change movie', 3, 'change_movie'),
(11, 'Can delete movie', 3, 'delete_movie'),
(12, 'Can view movie', 3, 'view_movie'),
(13, 'Can add rating', 4, 'add_rating'),
(14, 'Can change rating', 4, 'change_rating'),
(15, 'Can delete rating', 4, 'delete_rating'),
(16, 'Can view rating', 4, 'view_rating'),
(17, 'Can add log entry', 5, 'add_logentry'),
(18, 'Can change log entry', 5, 'change_logentry'),
(19, 'Can delete log entry', 5, 'delete_logentry'),
(20, 'Can view log entry', 5, 'view_logentry'),
(21, 'Can add permission', 6, 'add_permission'),
(22, 'Can change permission', 6, 'change_permission'),
(23, 'Can delete permission', 6, 'delete_permission'),
(24, 'Can view permission', 6, 'view_permission'),
(25, 'Can add group', 7, 'add_group'),
(26, 'Can change group', 7, 'change_group'),
(27, 'Can delete group', 7, 'delete_group'),
(28, 'Can view group', 7, 'view_group'),
(29, 'Can add user', 8, 'add_user'),
(30, 'Can change user', 8, 'change_user'),
(31, 'Can delete user', 8, 'delete_user'),
(32, 'Can view user', 8, 'view_user'),
(33, 'Can add content type', 9, 'add_contenttype'),
(34, 'Can change content type', 9, 'change_contenttype'),
(35, 'Can delete content type', 9, 'delete_contenttype'),
(36, 'Can view content type', 9, 'view_contenttype'),
(37, 'Can add session', 10, 'add_session'),
(38, 'Can change session', 10, 'change_session'),
(39, 'Can delete session', 10, 'delete_session'),
(40, 'Can view session', 10, 'view_session'),
(41, 'Can add favorite', 11, 'add_favorite'),
(42, 'Can change favorite', 11, 'change_favorite'),
(43, 'Can delete favorite', 11, 'delete_favorite'),
(44, 'Can view favorite', 11, 'view_favorite'),
(45, 'Can add user', 12, 'add_user'),
(46, 'Can change user', 12, 'change_user'),
(47, 'Can delete user', 12, 'delete_user'),
(48, 'Can view user', 12, 'view_user');

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
(5, 'admin', 'logentry'),
(7, 'auth', 'group'),
(6, 'auth', 'permission'),
(8, 'auth', 'user'),
(9, 'contenttypes', 'contenttype'),
(1, 'movies', 'cast'),
(11, 'movies', 'favorite'),
(2, 'movies', 'genre'),
(3, 'movies', 'movie'),
(4, 'movies', 'rating'),
(12, 'movies', 'user'),
(10, 'sessions', 'session');

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
(1, 'contenttypes', '0001_initial', '2024-10-20 23:12:29.444300'),
(2, 'auth', '0001_initial', '2024-10-20 23:12:29.699579'),
(3, 'admin', '0001_initial', '2024-10-20 23:12:29.764255'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-10-20 23:12:29.772256'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-10-20 23:12:29.780292'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-10-20 23:12:29.818703'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-10-20 23:12:29.850111'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-10-20 23:12:29.863735'),
(9, 'auth', '0004_alter_user_username_opts', '2024-10-20 23:12:29.870721'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-10-20 23:12:29.897432'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-10-20 23:12:29.901396'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-10-20 23:12:29.908395'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-10-20 23:12:29.921405'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-10-20 23:12:29.934162'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-10-20 23:12:29.946000'),
(16, 'auth', '0011_update_proxy_permissions', '2024-10-20 23:12:29.955974'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-10-20 23:12:29.967968'),
(18, 'movies', '0001_initial', '2024-10-20 23:12:30.152766'),
(19, 'sessions', '0001_initial', '2024-10-20 23:12:30.171708'),
(20, 'movies', '0002_favorite_user_alter_rating_unique_together_and_more', '2024-10-20 23:24:14.867857');

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
-- Struktura tabeli dla tabeli `movies_favorite`
--

CREATE TABLE `movies_favorite` (
  `id` bigint(20) NOT NULL,
  `movie_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies_favorite`
--

INSERT INTO `movies_favorite` (`id`, `movie_id`, `user_id`) VALUES
(55, 1, 1),
(56, 2, 1),
(57, 4, 2),
(58, 5, 3),
(59, 7, 4),
(60, 9, 5),
(61, 10, 6),
(62, 11, 7),
(63, 12, 8),
(64, 6, 9),
(65, 8, 10),
(66, 1, 11),
(67, 3, 12),
(68, 5, 13),
(69, 7, 14),
(70, 9, 15),
(71, 2, 16),
(72, 11, 17),
(73, 12, 18),
(74, 3, 1),
(75, 5, 1),
(76, 3, 2),
(77, 1, 22),
(78, 3, 22),
(79, 20, 22),
(80, 53, 22),
(81, 100, 22);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `movies_movie`
--

CREATE TABLE `movies_movie` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `genre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies_movie`
--

INSERT INTO `movies_movie` (`id`, `title`, `genre`) VALUES
(1, 'Look Mom I Can Fly', 'Action'),
(2, 'Film 2', 'Comedy'),
(3, 'Titanic', 'Drama'),
(4, 'Inception', 'Sci-Fi'),
(5, 'The Dark Knight', 'Action'),
(6, 'Pulp Fiction', 'Crime'),
(7, 'Forrest Gump', 'Drama'),
(8, 'The Matrix', 'Sci-Fi'),
(9, 'The Godfather', 'Crime'),
(10, 'The Lord of the Rings', 'Fantasy'),
(11, 'Fight Club', 'Drama'),
(12, 'Interstellar', 'Sci-Fi'),
(13, 'The Social Network', 'Drama'),
(14, 'Parasite', 'Thriller'),
(15, 'The Avengers', 'Action'),
(16, 'Toy Story', 'Animation'),
(17, 'Titanic', 'Romance'),
(18, 'Gladiator', 'Action'),
(19, 'The Green Mile', 'Fantasy'),
(20, 'Parasite', 'Thriller'),
(21, 'The Lion King', 'Animation'),
(22, 'Titanic', 'Romance'),
(23, 'Jurassic Park', 'Adventure'),
(24, 'The Avengers', 'Action'),
(25, 'Spider-Man: Into the Spider-Verse', 'Animation'),
(26, 'Interstellar', 'Sci-Fi'),
(27, 'Gladiator', 'Action'),
(28, 'The Departed', 'Crime'),
(29, 'Whiplash', 'Drama'),
(30, 'The Social Network', 'Biography'),
(31, 'Black Panther', 'Action'),
(32, 'A Beautiful Mind', 'Biography'),
(33, 'Toy Story', 'Animation'),
(34, 'Back to the Future', 'Adventure'),
(35, 'The Incredibles', 'Animation'),
(36, 'Coco', 'Animation'),
(37, 'Finding Nemo', 'Animation'),
(38, 'The Grand Budapest Hotel', 'Comedy'),
(39, 'The Shape of Water', 'Fantasy'),
(40, 'The Revenant', 'Adventure'),
(41, 'Mad Max: Fury Road', 'Action'),
(42, 'Django Unchained', 'Western'),
(43, 'La La Land', 'Musical'),
(44, 'The Princess Bride', 'Fantasy'),
(45, 'The Sixth Sense', 'Thriller'),
(46, 'The Prestige', 'Drama'),
(47, 'Get Out', 'Horror'),
(48, 'Zootopia', 'Animation'),
(49, '12 Years a Slave', 'Biography'),
(50, 'Her', 'Romance'),
(51, 'The Fault in Our Stars', 'Romance'),
(52, 'The Martian', 'Sci-Fi'),
(53, 'The Breakfast Club', 'Comedy'),
(54, 'Joker', 'Drama'),
(55, 'Room', 'Drama'),
(56, 'Fargo', 'Crime'),
(57, 'Inside Out', 'Animation'),
(58, 'The Big Lebowski', 'Comedy'),
(59, 'Moonlight', 'Drama'),
(60, 'A Star Is Born', 'Romance'),
(61, 'Spotlight', 'Drama'),
(62, 'The Wolf of Wall Street', 'Biography'),
(63, 'Black Swan', 'Drama'),
(64, 'The Babadook', 'Horror'),
(65, 'The Conjuring', 'Horror'),
(66, 'The Exorcist', 'Horror'),
(67, 'It', 'Horror'),
(68, 'Get Out', 'Thriller'),
(69, 'The Ring', 'Horror'),
(70, 'The Shining', 'Horror'),
(71, 'No Country for Old Men', 'Thriller'),
(72, 'The Truman Show', 'Comedy'),
(73, 'The Imitation Game', 'Biography'),
(74, 'The Theory of Everything', 'Biography'),
(75, 'Slumdog Millionaire', 'Drama'),
(76, 'Gravity', 'Sci-Fi'),
(77, 'The Help', 'Drama'),
(78, 'The Good, the Bad and the Ugly', 'Western'),
(79, 'Casino Royale', 'Action'),
(80, 'Skyfall', 'Action'),
(81, 'Wonder Woman', 'Action'),
(82, 'Blade Runner 2049', 'Sci-Fi'),
(83, 'Eternal Sunshine of the Spotless Mind', 'Romance'),
(84, 'The Great Gatsby', 'Drama'),
(85, 'American Beauty', 'Drama'),
(86, 'Gone Girl', 'Thriller'),
(87, 'Deadpool', 'Action'),
(88, 'Jumanji: Welcome to the Jungle', 'Adventure'),
(89, 'Bridget Jones\'s Diary', 'Romance'),
(90, 'Ferris Bueller\'s Day Off', 'Comedy'),
(91, 'Mean Girls', 'Comedy'),
(92, 'The Lego Movie', 'Animation'),
(93, 'Star Wars: The Force Awakens', 'Sci-Fi'),
(94, 'The Martian', 'Sci-Fi'),
(95, 'The Amazing Spider-Man', 'Action'),
(96, 'Wonder', 'Drama'),
(97, 'The Secret Life of Pets', 'Animation'),
(98, 'The Nut Job', 'Animation'),
(99, 'Rogue One: A Star Wars Story', 'Sci-Fi'),
(100, 'Fantastic Beasts and Where to Find Them', 'Fantasy'),
(101, 'The Nun', 'Horror'),
(102, 'A Quiet Place', 'Horror'),
(103, 'The Shape of Water', 'Fantasy'),
(104, 'Sicario', 'Thriller'),
(105, 'Birdman', 'Drama'),
(106, 'Room', 'Drama'),
(107, 'Knives Out', 'Mystery'),
(108, 'The Favourite', 'Comedy'),
(109, '1917', 'War'),
(110, 'Ford v Ferrari', 'Drama'),
(111, 'Jojo Rabbit', 'Comedy'),
(112, 'The Irishman', 'Crime'),
(113, 'Midsommar', 'Horror'),
(114, 'Knives Out', 'Mystery'),
(115, 'Parasite', 'Thriller'),
(116, 'Soul', 'Animation'),
(117, 'The Invisible Man', 'Horror'),
(118, 'A Beautiful Day in the Neighborhood', 'Drama'),
(119, 'The Trial of the Chicago 7', 'Drama'),
(120, 'Sound of Metal', 'Drama'),
(121, 'Promising Young Woman', 'Thriller'),
(122, 'Dune', 'Sci-Fi'),
(123, 'Shang-Chi and the Legend of the Ten Rings', 'Action'),
(124, 'The Matrix Resurrections', 'Sci-Fi'),
(125, 'Black Widow', 'Action'),
(126, 'The Suicide Squad', 'Action'),
(127, 'Luca', 'Animation'),
(128, 'Free Guy', 'Comedy'),
(129, 'Space Jam: A New Legacy', 'Animation'),
(130, 'Jungle Cruise', 'Adventure'),
(131, 'The Green Knight', 'Fantasy'),
(132, 'Old', 'Thriller'),
(133, 'Candyman', 'Horror'),
(134, 'Venom: Let There Be Carnage', 'Action'),
(135, 'No Time to Die', 'Action'),
(136, 'Eternals', 'Action'),
(137, 'West Side Story', 'Musical'),
(138, 'Last Night in Soho', 'Thriller'),
(139, 'King Richard', 'Biography'),
(140, 'The French Dispatch', 'Comedy'),
(141, 'Belfast', 'Drama'),
(142, 'Cyrano', 'Musical'),
(143, 'The Worst Person in the World', 'Drama'),
(144, 'Licorice Pizza', 'Comedy'),
(145, 'Spider-Man: No Way Home', 'Action'),
(146, 'The Lost Daughter', 'Drama'),
(147, 'Encanto', 'Animation'),
(148, 'Sing 2', 'Animation'),
(149, 'Ghostbusters: Afterlife', 'Comedy'),
(150, 'Nightmare Alley', 'Thriller'),
(151, 'Scream', 'Horror'),
(152, 'Top Gun: Maverick', 'Action'),
(153, 'The Batman', 'Action'),
(154, 'Doctor Strange in the Multiverse of Madness', 'Sci-Fi'),
(155, 'Uncharted', 'Action'),
(156, 'Fantastic Beasts: The Secrets of Dumbledore', 'Fantasy'),
(157, 'The Lost City', 'Adventure'),
(158, 'Everything Everywhere All at Once', 'Comedy'),
(159, 'Marry Me', 'Romance'),
(160, 'Downton Abbey: A New Era', 'Drama'),
(161, 'The Northman', 'Action'),
(162, 'The Unbearable Weight of Massive Talent', 'Comedy'),
(163, 'The King\'s Daughter', 'Fantasy'),
(164, 'The Contractor', 'Action'),
(165, 'The Tender Bar', 'Drama');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `movies_rating`
--

CREATE TABLE `movies_rating` (
  `id` bigint(20) NOT NULL,
  `movie_id` bigint(20) NOT NULL,
  `rating` decimal(2,1) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies_rating`
--

INSERT INTO `movies_rating` (`id`, `movie_id`, `rating`, `user_id`) VALUES
(1, 1, 5.0, 1),
(2, 2, 3.0, 1),
(3, 1, 4.0, 2),
(4, 3, 4.5, 3),
(5, 1, 4.5, 1),
(6, 2, 5.0, 1),
(7, 3, 4.0, 1),
(8, 4, 3.5, 1),
(9, 5, 5.0, 1),
(10, 1, 4.0, 2),
(11, 6, 4.5, 2),
(12, 7, 3.0, 2),
(13, 8, 5.0, 2),
(14, 9, 4.5, 2),
(15, 3, 5.0, 3),
(16, 4, 4.0, 3),
(17, 10, 5.0, 3),
(18, 11, 3.5, 3),
(19, 12, 4.5, 3),
(20, 2, 4.5, 4),
(21, 5, 4.0, 4),
(22, 6, 5.0, 4),
(23, 13, 3.5, 4),
(24, 14, 4.5, 4),
(25, 7, 4.0, 5),
(26, 8, 5.0, 5),
(27, 9, 3.5, 5),
(28, 10, 4.5, 5),
(29, 11, 4.0, 5),
(30, 1, 5.0, 6),
(31, 3, 4.5, 6),
(32, 4, 3.5, 6),
(33, 12, 4.0, 6),
(34, 15, 5.0, 6),
(35, 2, 4.5, 7),
(36, 5, 4.0, 7),
(37, 9, 3.5, 7),
(38, 13, 4.5, 7),
(39, 14, 4.0, 7),
(40, 6, 4.5, 8),
(41, 7, 5.0, 8),
(42, 8, 4.0, 8),
(43, 10, 3.5, 8),
(44, 15, 4.5, 8),
(45, 1, 4.0, 9),
(46, 2, 4.5, 9),
(47, 3, 3.0, 9),
(48, 5, 5.0, 9),
(49, 9, 4.5, 9),
(50, 6, 5.0, 10),
(51, 7, 4.5, 10),
(52, 8, 4.0, 10),
(53, 11, 3.5, 10),
(54, 12, 4.5, 10),
(55, 1, 4.0, 11),
(56, 3, 3.5, 11),
(57, 2, 5.0, 12),
(58, 3, 4.0, 12),
(59, 4, 4.5, 12),
(60, 1, 3.5, 13),
(61, 5, 4.5, 13),
(62, 6, 5.0, 14),
(63, 7, 4.0, 14),
(64, 8, 4.5, 14),
(65, 1, 5.0, 15),
(66, 3, 4.5, 15),
(67, 2, 3.5, 16),
(68, 5, 5.0, 16),
(69, 8, 4.0, 17),
(70, 9, 4.5, 18),
(71, 10, 4.0, 18),
(72, 11, 4.5, 18),
(73, 17, 3.5, 22);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `movies_user`
--

CREATE TABLE `movies_user` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies_user`
--

INSERT INTO `movies_user` (`id`, `name`) VALUES
(1, 'Uzytkownik 1'),
(2, 'Uzytkownik 2'),
(3, 'Uzytkownik 3'),
(4, 'Piotr'),
(5, 'Anna'),
(6, 'Kamil'),
(7, 'Ewa'),
(8, 'Michał'),
(9, 'Katarzyna'),
(10, 'Tomasz'),
(11, 'Magda'),
(12, 'Robert'),
(13, 'Zofia'),
(14, 'Adam'),
(15, 'Ewelina'),
(16, 'Paulina'),
(17, 'Janusz'),
(18, 'Barbara'),
(19, 'Olek'),
(20, 'Karolina'),
(21, 'Łukasz'),
(22, 'Maxim'),
(23, 'Joseph Thompson'),
(24, 'Grace Garcia'),
(25, 'Samuel Martinez'),
(26, 'Chloe Robinson'),
(27, 'David Clark'),
(28, 'Sofia Rodriguez'),
(29, 'Anthony Lewis'),
(30, 'Avery Lee'),
(31, 'Robert Walker'),
(32, 'Lily Hall'),
(33, 'Charles Allen'),
(34, 'Scarlett Young'),
(35, 'Thomas King'),
(36, 'Aria Wright'),
(37, 'Jack Scott'),
(38, 'Nora Torres'),
(39, 'Henry Nguyen'),
(40, 'Eleanor Hill'),
(41, 'Owen Flores'),
(42, 'Luna Green'),
(43, 'Alexander Adams'),
(44, 'Zoe Nelson'),
(45, 'Isaac Baker'),
(46, 'Stella Carter'),
(47, 'Eli Mitchell'),
(48, 'Maya Perez'),
(49, 'Aaron Roberts'),
(50, 'Violet Turner'),
(51, 'Nathan Phillips'),
(52, 'Hazel Campbell'),
(53, 'Carter Parker'),
(54, 'Addison Evans'),
(55, 'Ryan Edwards'),
(56, 'Lucy Edwards'),
(57, 'Luke Collins'),
(58, 'Sadie Stewart'),
(59, 'Jameson Sanchez'),
(60, 'Skylar Morris'),
(61, 'Gavin Rivera'),
(62, 'Peyton Cooper'),
(63, 'Mason Reed'),
(64, 'Natalie Cook'),
(65, 'Hunter Morgan'),
(66, 'Riley Bell'),
(67, 'Justin Murphy'),
(68, 'Claire Bailey'),
(69, 'Dylan Rivera'),
(70, 'Brooklyn Hughes'),
(71, 'Miles Ward'),
(72, 'Aurora James'),
(73, 'Chase Flores'),
(74, 'Ellie Nguyen'),
(75, 'Cooper Reyes'),
(76, 'Lila Rogers'),
(77, 'Zachary Ramirez'),
(78, 'Julia Ramirez'),
(79, 'Axel Fisher'),
(80, 'Anna Mills'),
(81, 'Silas Sanchez'),
(82, 'Alice Grant'),
(83, 'Jonathan Wood'),
(84, 'Sophie Hunter'),
(85, 'Bryson Wright'),
(86, 'Emilia Brooks'),
(87, 'Santiago Torres'),
(88, 'Rachel Hughes'),
(89, 'Jaxon Martinez'),
(90, 'Megan Price'),
(91, 'Victor Collins'),
(92, 'Clara Simmons'),
(93, 'Levi Foster'),
(94, 'Cora Wood'),
(95, 'Ian Ramirez'),
(96, 'Elena Murphy'),
(97, 'Nolan Peterson'),
(98, 'Maddox Kelly'),
(99, 'Tristan Cox'),
(100, 'Madeline Sanders'),
(101, 'Timothy Ward'),
(102, 'Jasmine Wood'),
(103, 'Vincent Lopez'),
(104, 'Vivian Mitchell'),
(105, 'Bennett Gonzalez'),
(106, 'Josephine Ramirez'),
(107, 'Mark Peterson'),
(108, 'Raelynn Ward'),
(109, 'Blaine Fisher'),
(110, 'Kaitlyn Bailey'),
(111, 'Roman Morris'),
(112, 'Isabel Rivera'),
(113, 'Malachi Murphy'),
(114, 'Vivienne Wright'),
(115, 'Wesley Reed'),
(116, 'Ariella Price'),
(117, 'Ezekiel Cook'),
(118, 'Ashley Powell'),
(119, 'Victor Stewart'),
(120, 'Liliana Bell'),
(121, 'Jeremiah Rogers'),
(122, 'Hannah Rivera'),
(123, 'Gideon Foster'),
(124, 'Skylar Green'),
(125, 'Julian Murphy'),
(126, 'Noah King'),
(127, 'Piper Lee'),
(128, 'Ryder Young'),
(129, 'Sienna Brooks'),
(130, 'Zane Nguyen'),
(131, 'Rosie Martinez'),
(132, 'Dallas Hall'),
(133, 'Elliott Torres'),
(134, 'Lydia Sanders'),
(135, 'Preston Wood'),
(136, 'Nina Martinez'),
(137, 'Emery Clark'),
(138, 'Landon Phillips'),
(139, 'Paige Davis'),
(140, 'Jonah Martinez'),
(141, 'Daphne Lee'),
(142, 'Graham Jones'),
(143, 'Victoria Anderson'),
(144, 'Jett Williams'),
(145, 'Lena Scott'),
(146, 'Aidan Parker'),
(147, 'Vivian Ramirez'),
(148, 'Blake Campbell'),
(149, 'Margaret Sanchez'),
(150, 'Kellan Johnson'),
(151, 'Ivy Martinez'),
(152, 'Finn Rivera'),
(153, 'Sadie Hall'),
(154, 'Hugo Lewis'),
(155, 'Alana Carter'),
(156, 'Luca Rogers'),
(157, 'Danielle Miller'),
(158, 'Cash Parker'),
(159, 'Diana Brown'),
(160, 'Rafael Wilson'),
(161, 'Julianna Lee'),
(162, 'Cyrus Jackson'),
(163, 'Maggie White'),
(164, 'Simon Moore'),
(165, 'Ellie Adams'),
(166, 'Eric Thompson'),
(167, 'Giana Hall'),
(168, 'Trevor Garcia'),
(169, 'Sierra Williams'),
(170, 'Bodhi Taylor'),
(171, 'Sharon Parker'),
(172, 'Alvin Lee'),
(173, 'Fiona Edwards'),
(174, 'Devin Miller'),
(175, 'Gracie Davis'),
(176, 'Jason Martinez'),
(177, 'Lola Johnson'),
(178, 'Quinn Garcia'),
(179, 'Rory Carter'),
(180, 'Nina Wilson'),
(181, 'Dante Brown'),
(182, 'Julia Hill'),
(183, 'Victor Carter'),
(184, 'Juliet Robinson'),
(185, 'Harrison Taylor'),
(186, 'Sophia Allen'),
(187, 'Theo Martinez'),
(188, 'Brielle Johnson'),
(189, 'Milo Williams'),
(190, 'Elena Walker'),
(191, 'Parker Green'),
(192, 'Summer Martinez');

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
-- Indeksy dla tabeli `movies_favorite`
--
ALTER TABLE `movies_favorite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movies_favorite_movie_id_a7df9107_fk_movies_movie_id` (`movie_id`),
  ADD KEY `movies_favorite_user_id_99780e1c_fk_movies_user_id` (`user_id`);

--
-- Indeksy dla tabeli `movies_movie`
--
ALTER TABLE `movies_movie`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `movies_rating`
--
ALTER TABLE `movies_rating`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movies_rating_movie_id_697b1621` (`movie_id`),
  ADD KEY `movies_rating_user_id_30a94f7b_fk_movies_user_id` (`user_id`);

--
-- Indeksy dla tabeli `movies_user`
--
ALTER TABLE `movies_user`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `movies_favorite`
--
ALTER TABLE `movies_favorite`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `movies_movie`
--
ALTER TABLE `movies_movie`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=166;

--
-- AUTO_INCREMENT for table `movies_rating`
--
ALTER TABLE `movies_rating`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `movies_user`
--
ALTER TABLE `movies_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=193;

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
-- Constraints for table `movies_favorite`
--
ALTER TABLE `movies_favorite`
  ADD CONSTRAINT `movies_favorite_movie_id_a7df9107_fk_movies_movie_id` FOREIGN KEY (`movie_id`) REFERENCES `movies_movie` (`id`),
  ADD CONSTRAINT `movies_favorite_user_id_99780e1c_fk_movies_user_id` FOREIGN KEY (`user_id`) REFERENCES `movies_user` (`id`);

--
-- Constraints for table `movies_rating`
--
ALTER TABLE `movies_rating`
  ADD CONSTRAINT `movies_rating_movie_id_697b1621_fk_movies_movie_id` FOREIGN KEY (`movie_id`) REFERENCES `movies_movie` (`id`),
  ADD CONSTRAINT `movies_rating_user_id_30a94f7b_fk_movies_user_id` FOREIGN KEY (`user_id`) REFERENCES `movies_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
