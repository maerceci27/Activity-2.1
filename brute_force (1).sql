-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 28, 2025 at 08:53 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `brute_force`
--

-- --------------------------------------------------------

--
-- Table structure for table `log_in_attempts`
--

CREATE TABLE `log_in_attempts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `attempt` enum('failed','successful') DEFAULT NULL,
  `attempt_time` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `log_in_attempts`
--

INSERT INTO `log_in_attempts` (`id`, `user_id`, `attempt`, `attempt_time`) VALUES
(1, 2, 'failed', '2025-04-27 23:50:07'),
(2, 3, 'successful', '2025-04-27 23:50:30'),
(3, 3, 'failed', '2025-04-27 23:50:46'),
(4, 3, 'failed', '2025-04-27 23:50:48'),
(5, 3, 'failed', '2025-04-27 23:50:49'),
(6, 3, 'failed', '2025-04-27 23:50:50'),
(7, 3, 'failed', '2025-04-27 23:50:51');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`) VALUES
(1, 'test', '$2y$10$ynASpKgCLJNK95JXTLfEZOV6nIuyva9m8y/m.Umhcs0a4MNVB/mZ2'),
(2, 'okay', '$2y$10$1zCctNl9VLeibDs9KitxLuUTVFIXxSV7F73RvFRSjqqwU/PhCOCCS'),
(3, 'ross', '$2y$10$Vp3xzoF8gV8X6dmkooQBG.M4JVXYuzLY2SoQKZ3Wj.1tcBNU2Agd.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `log_in_attempts`
--
ALTER TABLE `log_in_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `log_in_attempts`
--
ALTER TABLE `log_in_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `log_in_attempts`
--
ALTER TABLE `log_in_attempts`
  ADD CONSTRAINT `log_in_attempts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
