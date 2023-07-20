-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- 主機: 127.0.0.1
-- 產生時間： 2018-04-08 10:22:17
-- 伺服器版本: 10.1.26-MariaDB
-- PHP 版本： 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `triopper`
--

-- --------------------------------------------------------

--
-- 資料表結構 `attender`
--

CREATE TABLE `attender` (
  `user_id` varchar(30) COLLATE utf8_bin NOT NULL,
  `trip_id` bigint(20) UNSIGNED NOT NULL,
  `relationship` varchar(10) COLLATE utf8_bin NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 資料表的關聯 `attender`:
--   `user_id`
--       `user` -> `user_id`
--   `trip_id`
--       `trip` -> `trip_id`
--

-- --------------------------------------------------------

--
-- 資料表結構 `comment`
--

CREATE TABLE `comment` (
  `comment_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` varchar(30) COLLATE utf8_bin NOT NULL,
  `trip_id` bigint(20) UNSIGNED NOT NULL,
  `context` varchar(1000) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 資料表的關聯 `comment`:
--   `user_id`
--       `user` -> `user_id`
--   `trip_id`
--       `trip` -> `trip_id`
--

-- --------------------------------------------------------

--
-- 資料表結構 `rating`
--

CREATE TABLE `rating` (
  `user_id` varchar(30) COLLATE utf8_bin NOT NULL,
  `trip_id` bigint(20) UNSIGNED NOT NULL,
  `star` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 資料表的關聯 `rating`:
--   `user_id`
--       `user` -> `user_id`
--   `trip_id`
--       `trip` -> `trip_id`
--

-- --------------------------------------------------------

--
-- 資料表結構 `subscribe`
--

CREATE TABLE `subscribe` (
  `user_id` varchar(30) COLLATE utf8_bin NOT NULL,
  `sub_id` varchar(30) COLLATE utf8_bin NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 資料表的關聯 `subscribe`:
--   `user_id`
--       `user` -> `user_id`
--   `sub_id`
--       `user` -> `user_id`
--

-- --------------------------------------------------------

--
-- 資料表結構 `trip`
--

CREATE TABLE `trip` (
  `trip_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '',
  `place` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `tag` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `context` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `attendable` tinyint(1) NOT NULL,
  `completed` tinyint(1) NOT NULL,
  `rank` int(11) NOT NULL,
  `photo` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 資料表的關聯 `trip`:
--

-- --------------------------------------------------------

--
-- 資料表結構 `user`
--

CREATE TABLE `user` (
  `user_id` varchar(30) COLLATE utf8_bin NOT NULL COMMENT 'FB',
  `name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'FB',
  `location` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'FB',
  `email` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '',
  `personality` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `hobby` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `introduction` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `privacy` int(11) DEFAULT NULL COMMENT 'todo',
  `picture` varchar(300) COLLATE utf8_bin NOT NULL COMMENT 'todo',
  `level` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 資料表的關聯 `user`:
--

--
-- 資料表的匯出資料 `user`
--

INSERT INTO `user` (`user_id`, `name`, `location`, `email`, `personality`, `hobby`, `introduction`, `privacy`, `picture`, `level`) VALUES
('2075143846100926', '蘇昱齊', '台中市', 'susautw@gmail.com', '', '', '', NULL, 'https://lookaside.facebook.com/platform/profilepic/?asid=2075143846100926&height=50&width=50&ext=1523434038&hash=AeTMvLJxaLiPEPmY', 0);

--
-- 已匯出資料表的索引
--

--
-- 資料表索引 `attender`
--
ALTER TABLE `attender`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `trip_id` (`trip_id`);

--
-- 資料表索引 `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `trip_id` (`trip_id`);

--
-- 資料表索引 `rating`
--
ALTER TABLE `rating`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `trip_id` (`trip_id`);

--
-- 資料表索引 `subscribe`
--
ALTER TABLE `subscribe`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `sub_id` (`sub_id`);

--
-- 資料表索引 `trip`
--
ALTER TABLE `trip`
  ADD PRIMARY KEY (`trip_id`);

--
-- 資料表索引 `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- 在匯出的資料表使用 AUTO_INCREMENT
--

--
-- 使用資料表 AUTO_INCREMENT `comment`
--
ALTER TABLE `comment`
  MODIFY `comment_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表 AUTO_INCREMENT `trip`
--
ALTER TABLE `trip`
  MODIFY `trip_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 已匯出資料表的限制(Constraint)
--

--
-- 資料表的 Constraints `attender`
--
ALTER TABLE `attender`
  ADD CONSTRAINT `attender_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `attender_ibfk_2` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`trip_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 資料表的 Constraints `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`trip_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 資料表的 Constraints `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`trip_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 資料表的 Constraints `subscribe`
--
ALTER TABLE `subscribe`
  ADD CONSTRAINT `subscribe_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `subscribe_ibfk_2` FOREIGN KEY (`sub_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
