-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 05, 2018 at 12:41 AM
-- Server version: 10.1.29-MariaDB
-- PHP Version: 7.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `paintball_bingo`
--

-- --------------------------------------------------------

--
-- Table structure for table `bingo_card`
--

CREATE TABLE `bingo_card` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `match_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `won` int(11) DEFAULT '0',
  `win_match_event_id` int(11) DEFAULT NULL,
  `won_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bingo_card`
--

INSERT INTO `bingo_card` (`id`, `user_id`, `match_id`, `created_at`, `won`, `win_match_event_id`, `won_at`) VALUES
(5, 10, 13, '2018-08-03 11:40:16', 1, 15, '2018-08-04 11:22:04'),
(6, 10, 13, '2018-08-03 13:55:24', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bingo_card_event`
--

CREATE TABLE `bingo_card_event` (
  `id` int(11) UNSIGNED NOT NULL,
  `bingo_card_id` int(11) DEFAULT NULL,
  `bingo_event_id` int(11) DEFAULT NULL,
  `hit_at` timestamp NULL DEFAULT NULL,
  `hit_match_event_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bingo_card_event`
--

INSERT INTO `bingo_card_event` (`id`, `bingo_card_id`, `bingo_event_id`, `hit_at`, `hit_match_event_id`) VALUES
(1, 5, 58, NULL, NULL),
(2, 5, 106, NULL, NULL),
(3, 5, 70, '2018-08-04 09:14:14', 2),
(4, 5, 71, NULL, NULL),
(5, 5, 87, NULL, NULL),
(6, 5, 54, NULL, NULL),
(7, 5, 119, '2018-08-04 10:35:28', 3),
(8, 5, 113, NULL, NULL),
(9, 5, 72, NULL, NULL),
(10, 5, 90, NULL, NULL),
(11, 5, 28, '2018-08-04 10:35:33', 4),
(12, 5, 36, NULL, NULL),
(13, 5, 46, NULL, NULL),
(14, 5, 68, NULL, NULL),
(15, 5, 99, '2018-08-04 10:35:50', 5),
(16, 5, 51, NULL, NULL),
(17, 6, 39, NULL, NULL),
(18, 6, 98, NULL, NULL),
(19, 6, 101, NULL, NULL),
(20, 6, 118, NULL, NULL),
(21, 6, 57, NULL, NULL),
(22, 6, 78, NULL, NULL),
(23, 6, 56, NULL, NULL),
(24, 6, 69, NULL, NULL),
(25, 6, 58, NULL, NULL),
(26, 6, 76, NULL, NULL),
(27, 6, 48, NULL, NULL),
(28, 6, 37, NULL, NULL),
(29, 6, 55, NULL, NULL),
(30, 6, 72, NULL, NULL),
(31, 6, 97, NULL, NULL),
(32, 6, 100, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bingo_event`
--

CREATE TABLE `bingo_event` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bingo_event`
--

INSERT INTO `bingo_event` (`id`, `name`) VALUES
(21, 'event1'),
(22, 'event2'),
(23, 'event3'),
(24, 'event4'),
(25, 'event5'),
(26, 'event6'),
(27, 'event7'),
(28, 'event8'),
(29, 'event9'),
(30, 'event10'),
(31, 'event11'),
(32, 'event12'),
(33, 'event13'),
(34, 'event14'),
(35, 'event15'),
(36, 'event16'),
(37, 'event17'),
(38, 'event18'),
(39, 'event19'),
(40, 'event20'),
(41, 'event21'),
(42, 'event22'),
(43, 'event23'),
(44, 'event24'),
(45, 'event25'),
(46, 'event26'),
(47, 'event27'),
(48, 'event28'),
(49, 'event29'),
(50, 'event30'),
(51, 'event31'),
(52, 'event32'),
(53, 'event33'),
(54, 'event34'),
(55, 'event35'),
(56, 'event36'),
(57, 'event37'),
(58, 'event38'),
(59, 'event39'),
(60, 'event40'),
(61, 'event41'),
(62, 'event42'),
(63, 'event43'),
(64, 'event44'),
(65, 'event45'),
(66, 'event46'),
(67, 'event47'),
(68, 'event48'),
(69, 'event49'),
(70, 'event50'),
(71, 'event51'),
(72, 'event52'),
(73, 'event53'),
(74, 'event54'),
(75, 'event55'),
(76, 'event56'),
(77, 'event57'),
(78, 'event58'),
(79, 'event59'),
(80, 'event60'),
(81, 'event61'),
(82, 'event62'),
(83, 'event63'),
(84, 'event64'),
(85, 'event65'),
(86, 'event66'),
(87, 'event67'),
(88, 'event68'),
(89, 'event69'),
(90, 'event70'),
(91, 'event71'),
(92, 'event72'),
(93, 'event73'),
(94, 'event74'),
(95, 'event75'),
(96, 'event76'),
(97, 'event77'),
(98, 'event78'),
(99, 'event79'),
(100, 'event80'),
(101, 'event81'),
(102, 'event82'),
(103, 'event83'),
(104, 'event84'),
(105, 'event85'),
(106, 'event86'),
(107, 'event87'),
(108, 'event88'),
(109, 'event89'),
(110, 'event90'),
(111, 'event91'),
(112, 'event92'),
(113, 'event93'),
(114, 'event94'),
(115, 'event95'),
(116, 'event96'),
(117, 'event97'),
(118, 'event98'),
(119, 'event99'),
(120, 'event100');

-- --------------------------------------------------------

--
-- Table structure for table `bingo_match`
--

CREATE TABLE `bingo_match` (
  `id` int(11) UNSIGNED NOT NULL,
  `start_at` timestamp NULL DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `price_id` int(11) DEFAULT NULL,
  `winner_bingo_card_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bingo_match`
--

INSERT INTO `bingo_match` (`id`, `start_at`, `name`, `price_id`, `winner_bingo_card_id`) VALUES
(11, '2018-08-03 02:16:33', 'Hammerheads vs Orcas', NULL, NULL),
(12, '2018-08-04 03:21:00', 'Linkin Park vs Metallica', NULL, NULL),
(13, '2018-08-03 13:13:00', 'Dragons vs Dungeons', NULL, 5),
(14, '2018-08-06 03:41:00', 'Enterprise vs Voyager', NULL, NULL),
(15, '2018-08-07 16:09:00', 'Orcs vs Rohan', NULL, NULL),
(16, '2018-08-08 02:20:00', 'Dogs vs Cats', NULL, NULL),
(17, '2018-08-09 09:15:00', 'Coke vs Pepsi', NULL, NULL),
(18, '2018-08-13 00:16:00', 'House vs Vicodin', NULL, NULL),
(19, '2018-08-14 08:06:00', 'PHP vs ASP', NULL, NULL),
(20, '2018-08-17 05:07:00', 'Griffindor vs Slytherin', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bingo_match_event`
--

CREATE TABLE `bingo_match_event` (
  `id` int(11) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `match_id` int(11) DEFAULT NULL,
  `bingo_event_id` int(11) DEFAULT NULL,
  `is_winner_event` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bingo_match_event`
--

INSERT INTO `bingo_match_event` (`id`, `created_at`, `match_id`, `bingo_event_id`, `is_winner_event`) VALUES
(1, '2018-08-03 21:48:33', 13, 30, NULL),
(2, '2018-08-03 22:15:21', 13, 70, NULL),
(3, '2018-08-04 10:34:45', 13, 119, NULL),
(4, '2018-08-04 10:34:45', 13, 28, NULL),
(5, '2018-08-04 10:34:59', 13, 99, 1);

-- --------------------------------------------------------

--
-- Table structure for table `bingo_match_prize`
--

CREATE TABLE `bingo_match_prize` (
  `id` int(11) UNSIGNED NOT NULL,
  `match_id` int(11) UNSIGNED NOT NULL,
  `prize_id` int(11) UNSIGNED NOT NULL,
  `prize_order` int(2) UNSIGNED NOT NULL,
  `winner_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bingo_match_prize`
--

INSERT INTO `bingo_match_prize` (`id`, `match_id`, `prize_id`, `prize_order`, `winner_id`) VALUES
(1, 11, 3, 1, 0),
(2, 11, 4, 2, 0),
(3, 11, 5, 3, 0),
(4, 12, 6, 1, 0),
(5, 13, 7, 1, 10),
(6, 13, 8, 2, 0),
(7, 13, 9, 3, 0),
(8, 14, 10, 1, 0),
(9, 14, 11, 2, 0),
(10, 15, 12, 1, 0),
(11, 16, 13, 1, 0),
(12, 16, 14, 2, 0),
(13, 16, 3, 3, 0),
(14, 17, 4, 1, 0),
(15, 18, 4, 1, 0),
(16, 18, 5, 2, 0),
(17, 18, 6, 3, 0),
(18, 19, 7, 1, 0),
(19, 19, 8, 2, 0),
(20, 20, 9, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `bingo_prize`
--

CREATE TABLE `bingo_prize` (
  `id` int(11) UNSIGNED NOT NULL,
  `active` int(11) DEFAULT '1',
  `name` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bingo_prize`
--

INSERT INTO `bingo_prize` (`id`, `active`, `name`) VALUES
(3, 1, 'Invisible Ink Pen'),
(4, 1, 'Waterproof Men\'s Sports Watch'),
(5, 1, 'UNO R3 Development Board'),
(6, 1, 'Diamond Tester'),
(7, 1, '4x4x4 Speed Rubik\'s Cube'),
(8, 1, 'Stainless Multi-tool Pliers'),
(9, 1, 'Magic Color Changing Egg Timer'),
(10, 1, 'Fidget cube'),
(11, 1, 'Kisha umbrella'),
(12, 1, 'Swiss Army Knife'),
(13, 1, 'Web Development For Dummies'),
(14, 1, 'Pocket Ref Reference Book');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bingo_card`
--
ALTER TABLE `bingo_card`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bingo_card_event`
--
ALTER TABLE `bingo_card_event`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bingo_card_id` (`bingo_card_id`,`hit_match_event_id`),
  ADD KEY `match_id` (`hit_match_event_id`);

--
-- Indexes for table `bingo_event`
--
ALTER TABLE `bingo_event`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bingo_match`
--
ALTER TABLE `bingo_match`
  ADD PRIMARY KEY (`id`),
  ADD KEY `start_at` (`start_at`);

--
-- Indexes for table `bingo_match_event`
--
ALTER TABLE `bingo_match_event`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bingo_match_prize`
--
ALTER TABLE `bingo_match_prize`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bingo_prize`
--
ALTER TABLE `bingo_prize`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bingo_card`
--
ALTER TABLE `bingo_card`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `bingo_card_event`
--
ALTER TABLE `bingo_card_event`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `bingo_event`
--
ALTER TABLE `bingo_event`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `bingo_match`
--
ALTER TABLE `bingo_match`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `bingo_match_event`
--
ALTER TABLE `bingo_match_event`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `bingo_match_prize`
--
ALTER TABLE `bingo_match_prize`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `bingo_prize`
--
ALTER TABLE `bingo_prize`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
