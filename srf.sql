-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Lis 19, 2024 at 11:43 PM
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
(1, '', NULL, 0, 'user1', '', '', '', 0, 1, '2024-11-19 00:11:02.000000'),
(2, '', NULL, 0, 'user2', '', '', '', 0, 1, '2024-11-19 00:11:02.000000'),
(3, '', NULL, 0, 'user3', '', '', '', 0, 1, '2024-11-19 00:11:02.000000'),
(4, '', NULL, 0, 'user4', '', '', '', 0, 1, '2024-11-19 00:11:02.000000'),
(5, '', NULL, 0, 'user5', '', '', '', 0, 1, '2024-11-19 00:11:02.000000'),
(6, '', NULL, 0, 'user6', '', '', '', 0, 1, '2024-11-19 00:11:02.000000'),
(7, '', NULL, 0, 'user7', '', '', '', 0, 1, '2024-11-19 00:11:02.000000'),
(8, '', NULL, 0, 'user8', '', '', '', 0, 1, '2024-11-19 00:11:02.000000'),
(9, '', NULL, 0, 'user9', '', '', '', 0, 1, '2024-11-19 00:11:02.000000'),
(10, '', NULL, 0, 'user10', '', '', '', 0, 1, '2024-11-19 00:11:02.000000'),
(11, '', NULL, 0, 'user11', '', '', '', 0, 1, '2024-11-19 22:44:07.000000');

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
(1, 'contenttypes', '0001_initial', '2024-11-18 23:09:51.118258'),
(2, 'auth', '0001_initial', '2024-11-18 23:09:52.155105'),
(3, 'admin', '0001_initial', '2024-11-18 23:09:52.453568'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-11-18 23:09:52.461148'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-11-18 23:09:52.468487'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-11-18 23:09:52.565616'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-11-18 23:09:52.708582'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-11-18 23:09:52.729616'),
(9, 'auth', '0004_alter_user_username_opts', '2024-11-18 23:09:52.738582'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-11-18 23:09:52.814043'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-11-18 23:09:52.816041'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-11-18 23:09:52.823041'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-11-18 23:09:52.835075'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-11-18 23:09:52.846041'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-11-18 23:09:52.858042'),
(16, 'auth', '0011_update_proxy_permissions', '2024-11-18 23:09:52.867649'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-11-18 23:09:52.879658'),
(18, 'movies', '0001_initial', '2024-11-18 23:09:54.624399'),
(19, 'sessions', '0001_initial', '2024-11-18 23:09:54.642433');

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
(1, 'Adam Nowak'),
(2, 'Anna Kowalska'),
(3, 'Maria Wiśniewska'),
(4, 'Tomasz Kaczmarek'),
(5, 'Michał Lewandowski'),
(6, 'Katarzyna Wójcik'),
(7, 'Joanna Zielińska'),
(8, 'Paweł Kamiński'),
(9, 'Piotr Nowak'),
(10, 'Agnieszka Nowicka'),
(11, 'Łukasz Wiśniewski'),
(12, 'Ewelina Kaczmarek'),
(13, 'Mateusz Lewandowski'),
(14, 'Justyna Wójcik'),
(15, 'Marcin Kowalski'),
(16, 'Anna Wiśniewska'),
(17, 'Damian Nowak'),
(18, 'Karolina Nowicka'),
(19, 'Adrian Kaczmarek'),
(20, 'Monika Kamińska'),
(21, 'Szymon Kowalczyk'),
(22, 'Alicja Zielińska'),
(23, 'Bartosz Nowak'),
(24, 'Katarzyna Nowakowska'),
(25, 'Maciej Wiśniewski'),
(26, 'Paulina Kowalska'),
(27, 'Grzegorz Nowak'),
(28, 'Agata Lewandowska'),
(29, 'Filip Kowalski'),
(30, 'Natalia Nowak'),
(31, 'Rafał Kaczmarek'),
(32, 'Joanna Zielińska'),
(33, 'Kamil Wiśniewski'),
(34, 'Magdalena Kowalska'),
(35, 'Damian Kowalczyk'),
(36, 'Aleksandra Nowicka'),
(37, 'Łukasz Kaczmarek'),
(38, 'Martyna Nowak'),
(39, 'Robert Nowak'),
(40, 'Ewa Kowalska'),
(41, 'Mike Myers'),
(42, 'Eddie Murphy'),
(43, 'Cameron Diaz'),
(44, 'Antonio Banderas'),
(45, 'John Lithgow'),
(46, 'Julie Andrews'),
(47, 'John Cleese'),
(48, 'Rupert Everett'),
(49, 'Justin Timberlake'),
(50, 'Walt Dohrn'),
(51, 'Raman Hui'),
(52, 'Mike Myers'),
(53, 'Eddie Murphy'),
(54, 'Cameron Diaz'),
(55, 'Antonio Banderas');

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
(1, 'Piotr Zieliński'),
(2, 'Ewa Malinowska'),
(3, 'Andrzej Nowicki'),
(4, 'Monika Kwiatkowska'),
(5, 'Krzysztof Kowalczyk'),
(6, 'Anna Zielińska'),
(7, 'Tomasz Nowicki'),
(8, 'Piotr Kaczmarek'),
(9, 'Ewa Lewandowska'),
(10, 'Anna Kaczmarek'),
(11, 'Monika Wiśniewska'),
(12, 'Piotr Nowicki'),
(13, 'Krzysztof Nowak'),
(14, 'Tomasz Wiśniewski'),
(15, 'Andrew Adamson'),
(16, 'Vicky Jenson'),
(17, 'Kelly Asbury'),
(18, 'Conrad Vernon'),
(19, 'Mike Mitchell'),
(20, 'Chris Miller'),
(21, 'Raman Hui'),
(22, 'Gary Trousdale');

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
(1, 1, 1),
(2, 3, 1),
(3, 2, 2),
(4, 4, 2),
(5, 20, 3),
(6, 3, 3),
(7, 5, 4),
(8, 6, 4),
(9, 7, 5),
(10, 8, 5),
(11, 9, 6),
(12, 10, 6),
(13, 5, 7),
(14, 20, 7),
(15, 4, 8),
(16, 2, 8),
(17, 11, 9),
(18, 7, 9),
(19, 6, 10),
(20, 9, 10),
(21, 16, 2),
(22, 21, 11),
(23, 22, 11);

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
(8, 'Akcja'),
(13, 'Animacja'),
(4, 'Dramat'),
(12, 'Familijny'),
(7, 'Fantasy'),
(9, 'Horror'),
(10, 'Komedia'),
(1, 'Kryminał'),
(6, 'Przygodowy'),
(3, 'Romans'),
(5, 'Sci-Fi'),
(11, 'Sportowy'),
(2, 'Thriller');

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
(37, 'Afryka'),
(29, 'apokalipsa'),
(17, 'Arktyka'),
(52, 'bajka'),
(61, 'Boże Narodzenie'),
(33, 'cywilizacja'),
(1, 'detektyw'),
(45, 'drużyna'),
(38, 'dzieci'),
(32, 'dżungla'),
(21, 'eksperyment'),
(6, 'Europa'),
(43, 'komunikacja'),
(7, 'kosmos'),
(24, 'królestwo'),
(53, 'księżniczka'),
(35, 'kultura'),
(9, 'las'),
(26, 'magia'),
(12, 'maszyny'),
(14, 'miasteczko'),
(4, 'miłość'),
(22, 'morze'),
(30, 'muzyka'),
(31, 'nadzieja'),
(20, 'nauka'),
(48, 'naukowcy'),
(34, 'odkrycie'),
(50, 'ogr'),
(51, 'osioł'),
(8, 'planeta'),
(5, 'podróż'),
(19, 'podróże w czasie'),
(27, 'powrót'),
(3, 'przeszłość'),
(11, 'przetrwanie'),
(10, 'przygoda'),
(16, 'przyjaciele'),
(23, 'przyjaźń'),
(18, 'przyroda'),
(42, 'przyszłość'),
(28, 'rodzina'),
(36, 'różnice'),
(15, 'sekret'),
(54, 'smok'),
(44, 'sport'),
(40, 'sprawiedliwość'),
(60, 'święta'),
(2, 'tajemnica'),
(13, 'walka'),
(25, 'wojownik'),
(46, 'wygrana'),
(47, 'wyspa'),
(39, 'zemsta'),
(49, 'zjawiska'),
(41, 'żołnierz');

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
(1, 'Cienie Przeszłości', 2010, 'Detektyw John Smith odkrywa tajemnice swojej przeszłości, które mogą zmienić jego przyszłość.', 'http://example.com/poster1.jpg'),
(2, 'Wschód Słońca', 2012, 'Historia miłości, która rodzi się podczas podróży pociągiem przez Europę.', 'http://example.com/poster2.jpg'),
(3, 'Gwiezdna Misja', 2015, 'Grupa astronautów wyrusza w podróż, by odkryć nową planetę zdolną do podtrzymania życia.', 'http://example.com/poster3.jpg'),
(4, 'Tajemnice Lasu', 2018, 'Młoda biolog odkrywa tajemnicę skrywaną przez starożytny las.', 'http://example.com/poster4.jpg'),
(5, 'Mroczne Sekrety', 2011, 'Grupa przyjaciół odkrywa mroczne tajemnice swojego rodzinnego miasta.', 'http://example.com/poster5.jpg'),
(6, 'Zimowy Wiatr', 2013, 'Opowieść o przetrwaniu w surowych warunkach Arktyki.', 'http://example.com/poster6.jpg'),
(7, 'Podróżnicy w Czasie', 2016, 'Naukowcy odkrywają sposób na podróżowanie w czasie, co prowadzi do nieoczekiwanych konsekwencji.', 'http://example.com/poster7.jpg'),
(8, 'Morska Przygoda', 2014, 'Grupa przyjaciół wyrusza w rejs, który zamienia się w niesamowitą przygodę.', 'http://example.com/poster8.jpg'),
(9, 'Królestwo Cieni', 2017, 'Młody wojownik musi ocalić swoje królestwo przed siłami ciemności.', 'http://example.com/poster9.jpg'),
(10, 'Droga do Domu', 2019, 'Po latach podróży mężczyzna wraca do rodzinnego miasta, by zmierzyć się z przeszłością.', 'http://example.com/poster10.jpg'),
(11, 'Dzień Sądu', 2011, 'Świat staje w obliczu zagłady, a grupa ludzi walczy o przetrwanie.', 'http://example.com/poster11.jpg'),
(12, 'Światło w Ciemności', 2012, 'Niewidomy pianista odnajduje sens życia dzięki spotkaniu z tajemniczą kobietą.', 'http://example.com/poster12.jpg'),
(13, 'Nieznane Ścieżki', 2015, 'Podróżnik odkrywa zaginioną cywilizację w sercu dżungli.', 'http://example.com/poster13.jpg'),
(14, 'Bez Granic', 2013, 'Historia miłości pomiędzy dwojgiem ludzi z różnych kultur.', 'http://example.com/poster14.jpg'),
(15, 'W Pustyni i w Puszczy', 2018, 'Dwoje dzieci przeżywa niesamowite przygody w Afryce.', 'http://example.com/poster15.jpg'),
(16, 'Czas Zemsty', 2016, 'Były żołnierz szuka sprawiedliwości po tym, jak jego rodzina została skrzywdzona.', 'http://example.com/poster16.jpg'),
(17, 'Echo Przyszłości', 2018, 'Naukowiec odkrywa sposób komunikacji z przyszłością.', 'http://example.com/poster17.jpg'),
(18, 'Mistrzowie', 2017, 'Drużyna sportowa walczy o mistrzostwo, pokonując własne słabości.', 'http://example.com/poster18.jpg'),
(19, 'Tajemnica Wyspy', 2019, 'Grupa naukowców odkrywa niezwykłe zjawiska na odległej wyspie.', 'http://example.com/poster19.jpg'),
(20, 'Ostatni Bastion', 2021, 'Ostatnia grupa ludzi walczy o przetrwanie w świecie opanowanym przez maszyny.', 'http://example.com/poster20.jpg'),
(21, 'Shrek', 2001, 'Ogr wyrusza na misję, aby uratować księżniczkę i odzyskać swój dom.', 'http://example.com/shrek1.jpg'),
(22, 'Shrek 2', 2004, 'Poślubiona para odwiedza rodziców księżniczki, co prowadzi do nowych przygód.', 'http://example.com/shrek2.jpg'),
(23, 'Shrek Trzeci', 2007, 'Shrek szuka następcy tronu, aby uniknąć przejęcia obowiązków królewskich.', 'http://example.com/shrek3.jpg'),
(24, 'Shrek Forever', 2010, 'Shrek podpisuje pakt, który zmienia rzeczywistość jego świata.', 'http://example.com/shrek4.jpg'),
(25, 'Pada Shrek', 2007, 'Shrek planuje spokojne święta z rodziną, ale chaos wkracza wraz z nieproszonymi gośćmi.', 'http://example.com/pada_shrek.jpg');

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
(2, 1, 2),
(3, 2, 3),
(4, 2, 4),
(5, 3, 5),
(6, 3, 6),
(7, 4, 7),
(8, 4, 8),
(9, 5, 9),
(10, 5, 10),
(11, 6, 11),
(12, 6, 12),
(13, 7, 13),
(14, 7, 14),
(15, 8, 15),
(16, 8, 16),
(17, 9, 17),
(18, 9, 18),
(19, 10, 19),
(20, 10, 20),
(21, 11, 21),
(22, 11, 22),
(23, 12, 23),
(24, 12, 24),
(25, 13, 25),
(26, 13, 26),
(27, 14, 27),
(28, 14, 28),
(29, 15, 29),
(30, 15, 30),
(31, 16, 31),
(32, 16, 32),
(33, 17, 33),
(34, 17, 34),
(35, 18, 35),
(36, 18, 36),
(37, 19, 37),
(38, 19, 38),
(39, 20, 39),
(40, 20, 40),
(41, 21, 41),
(42, 21, 42),
(43, 21, 43),
(44, 21, 45),
(48, 22, 41),
(49, 22, 42),
(50, 22, 43),
(51, 22, 44),
(52, 22, 46),
(53, 22, 47),
(55, 23, 41),
(56, 23, 42),
(57, 23, 43),
(58, 23, 44),
(59, 23, 49),
(62, 24, 41),
(63, 24, 42),
(64, 24, 43),
(65, 24, 44),
(66, 24, 50),
(69, 25, 41),
(70, 25, 42),
(71, 25, 43),
(72, 25, 44),
(73, 25, 52),
(74, 25, 53),
(75, 25, 54),
(76, 25, 55);

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
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10),
(11, 11, 5),
(12, 12, 6),
(13, 13, 7),
(14, 14, 8),
(15, 15, 9),
(16, 16, 11),
(17, 17, 12),
(18, 18, 9),
(19, 19, 13),
(20, 20, 5),
(21, 21, 15),
(22, 21, 16),
(24, 22, 15),
(25, 22, 17),
(26, 22, 18),
(27, 23, 20),
(28, 23, 21),
(30, 24, 19),
(31, 25, 22);

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
(2, 1, 2),
(3, 2, 3),
(4, 2, 4),
(5, 3, 5),
(6, 3, 6),
(8, 4, 6),
(7, 4, 7),
(10, 5, 2),
(9, 5, 9),
(11, 6, 4),
(12, 6, 6),
(14, 7, 2),
(13, 7, 5),
(15, 8, 6),
(16, 8, 10),
(17, 9, 7),
(18, 9, 8),
(20, 10, 3),
(19, 10, 4),
(22, 11, 5),
(21, 11, 8),
(24, 12, 3),
(23, 12, 4),
(25, 13, 6),
(26, 13, 7),
(28, 14, 3),
(27, 14, 4),
(29, 15, 6),
(30, 15, 12),
(32, 16, 2),
(31, 16, 8),
(34, 17, 2),
(33, 17, 5),
(35, 18, 4),
(36, 18, 11),
(38, 19, 5),
(37, 19, 6),
(40, 20, 5),
(39, 20, 8),
(44, 21, 6),
(43, 21, 10),
(42, 21, 12),
(41, 21, 13),
(51, 22, 6),
(50, 22, 10),
(49, 22, 12),
(48, 22, 13),
(58, 23, 6),
(57, 23, 10),
(56, 23, 12),
(55, 23, 13),
(66, 24, 6),
(64, 24, 7),
(65, 24, 10),
(63, 24, 12),
(62, 24, 13),
(71, 25, 10),
(70, 25, 12),
(69, 25, 13);

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
(2, 1, 2),
(3, 1, 3),
(4, 2, 4),
(5, 2, 5),
(6, 2, 6),
(8, 3, 5),
(7, 3, 7),
(9, 3, 8),
(11, 4, 2),
(10, 4, 9),
(12, 4, 10),
(13, 5, 14),
(14, 5, 15),
(15, 5, 16),
(16, 6, 11),
(17, 6, 17),
(18, 6, 18),
(19, 7, 19),
(20, 7, 20),
(21, 7, 21),
(23, 8, 5),
(22, 8, 22),
(24, 8, 23),
(25, 9, 24),
(26, 9, 25),
(27, 9, 26),
(30, 10, 3),
(28, 10, 27),
(29, 10, 28),
(32, 11, 11),
(33, 11, 13),
(31, 11, 29),
(35, 12, 4),
(34, 12, 30),
(36, 12, 31),
(37, 13, 32),
(38, 13, 33),
(39, 13, 34),
(40, 14, 4),
(41, 14, 35),
(42, 14, 36),
(45, 15, 10),
(43, 15, 37),
(44, 15, 38),
(46, 16, 39),
(47, 16, 40),
(48, 16, 41),
(51, 17, 20),
(49, 17, 42),
(50, 17, 43),
(52, 18, 44),
(53, 18, 45),
(54, 18, 46),
(55, 19, 47),
(56, 19, 48),
(57, 19, 49),
(58, 20, 11),
(59, 20, 12),
(60, 20, 13),
(64, 21, 10),
(62, 21, 50),
(63, 21, 51),
(61, 21, 53),
(65, 21, 54),
(69, 22, 4),
(72, 22, 23),
(68, 22, 24),
(70, 22, 50),
(71, 22, 51),
(78, 23, 10),
(75, 23, 24),
(76, 23, 50),
(77, 23, 51),
(85, 24, 23),
(82, 24, 26),
(83, 24, 50),
(84, 24, 51),
(92, 25, 10),
(93, 25, 28),
(90, 25, 50),
(91, 25, 51),
(94, 25, 60),
(89, 25, 61);

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
(1, 8, 'Bardzo dobry film!', '2024-11-19 00:11:03.000000', 1, 1),
(2, 9, 'Świetne efekty specjalne.', '2024-11-19 00:11:03.000000', 3, 1),
(3, 7, 'Piękna historia.', '2024-11-19 00:11:03.000000', 2, 2),
(4, 8, 'Uwielbiam takie klimaty.', '2024-11-19 00:11:03.000000', 4, 2),
(5, 9, 'Trzyma w napięciu.', '2024-11-19 00:11:03.000000', 20, 3),
(6, 8, 'Bardzo ciekawy.', '2024-11-19 00:11:03.000000', 3, 3),
(7, 7, 'Dreszczyk emocji.', '2024-11-19 00:11:03.000000', 5, 4),
(8, 8, 'Piękne krajobrazy.', '2024-11-19 00:11:03.000000', 6, 4),
(9, 8, 'Intrygująca fabuła.', '2024-11-19 00:11:03.000000', 7, 5),
(10, 7, 'Dużo humoru.', '2024-11-19 00:11:03.000000', 8, 5),
(11, 9, 'Epicki film.', '2024-11-19 00:11:03.000000', 9, 6),
(12, 8, 'Wzruszający.', '2024-11-19 00:11:03.000000', 10, 6),
(13, 8, 'Polecam!', '2024-11-19 00:11:03.000000', 5, 7),
(14, 9, 'Świetna akcja.', '2024-11-19 00:11:03.000000', 20, 7),
(15, 9, 'Magiczny klimat.', '2024-11-19 00:11:03.000000', 4, 8),
(16, 8, 'Romantyczny.', '2024-11-19 00:11:03.000000', 2, 8),
(17, 8, 'Intensywny.', '2024-11-19 00:11:03.000000', 11, 9),
(18, 9, 'Zaskakujący.', '2024-11-19 00:11:03.000000', 7, 9),
(19, 9, 'Piękna historia.', '2024-11-19 00:11:03.000000', 6, 10),
(20, 9, 'Niesamowity świat.', '2024-11-19 00:11:03.000000', 9, 10),
(21, 9, 'Zajebisty!', '2024-11-19 20:23:50.558902', 16, 2),
(22, 8, 'Bardzo fajny!', '2024-11-19 21:45:36.133392', 21, 11),
(23, 9, 'Dobry film', '2024-11-19 22:02:32.423174', 22, 11);

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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_name` (`name`);

--
-- Indeksy dla tabeli `movies_keyword`
--
ALTER TABLE `movies_keyword`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_name` (`name`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `movies_director`
--
ALTER TABLE `movies_director`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `movies_favoritemovie`
--
ALTER TABLE `movies_favoritemovie`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `movies_genre`
--
ALTER TABLE `movies_genre`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `movies_keyword`
--
ALTER TABLE `movies_keyword`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `movies_movie`
--
ALTER TABLE `movies_movie`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `movies_movie_cast`
--
ALTER TABLE `movies_movie_cast`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT for table `movies_movie_directors`
--
ALTER TABLE `movies_movie_directors`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `movies_movie_genres`
--
ALTER TABLE `movies_movie_genres`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `movies_movie_keywords`
--
ALTER TABLE `movies_movie_keywords`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `movies_rating`
--
ALTER TABLE `movies_rating`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

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
