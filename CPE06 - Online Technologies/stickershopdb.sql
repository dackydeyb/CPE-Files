-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 15, 2024 at 09:42 AM
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
-- Database: `stickershopdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `item_id`) VALUES
(31, 1, 22),
(32, 1, 25);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `page` varchar(255) NOT NULL DEFAULT 'shop'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `image`, `name`, `description`, `price`, `page`) VALUES
(4, 'Paimon 1.png', 'Paimon', 'Paimon emergency food', 12.49, 'shop'),
(5, 'Lynette 1.png', 'Lyney', 'Lyney from Fontaine', 12.50, 'shop'),
(7, 'Navia.png', 'Navia', 'Navia asjdbakdbasb', 111.02, 'shop'),
(9, 'Kaeya 3.png', 'Kaeya', 'Kaeya from Dawn winery', 134.43, 'shop'),
(12, 'Keqing 1.png', 'Keqing [1]', '[Genshin Impact x OnePlus] OnePlus Collaboration Emoji Now Available!', 129.49, 'newarrivals'),
(13, 'Keqing 2.png', 'Keqing [2]', '[Genshin Impact x OnePlus] OnePlus Collaboration Emoji Now Available!', 121.43, 'newarrivals'),
(14, 'Keqing 3.png', 'Keqing [3]', '[Genshin Impact x OnePlus] OnePlus Collaboration Emoji Now Available!', 458.43, 'newarrivals'),
(15, 'Keqing 4.png', 'Keqing [4]', '[Genshin Impact x OnePlus] OnePlus Collaboration Emoji Now Available!', 230.34, 'newarrivals'),
(16, 'Keqing 5.png', 'Keqing [5]', '[Genshin Impact x OnePlus] OnePlus Collaboration Emoji Now Available!', 349.34, 'newarrivals'),
(17, 'Keqing 6.png', 'Keqing [6]', '[Genshin Impact x OnePlus] OnePlus Collaboration Emoji Now Available!', 234.23, 'newarrivals'),
(18, 'Keqing 7.png', 'Keqing [7]', '[Genshin Impact x OnePlus] OnePlus Collaboration Emoji Now Available!', 243.23, 'newarrivals'),
(20, 'Hu Tao 1.png', 'Hu Tao [1]', 'This is Hu Tao from Liyue', 343.00, 'newarrivals'),
(21, 'Hu Tao 2.png', 'Hu Tao [2]', 'This is Hu Tao from Liyue', 234.33, 'newarrivals'),
(22, 'Hu Tao 3.png', 'Hu Tao [3]', 'This is Hu Tao from Liyue', 245.32, 'newarrivals'),
(23, 'Yae Miko 1.png', 'Yae Miko [1]', 'Yae Miko from Inazuma!', 5432.70, 'newarrivals'),
(24, 'Yae Miko 2.png', 'Yae Miko [2]', 'Yae Miko from Inazuma!', 345.23, 'newarrivals'),
(25, 'Yae Miko 3.png', 'Yae Miko [3]', 'Yae Miko from Inazuma!', 242.53, 'newarrivals'),
(26, 'March 7th_1.png', 'March 7th [1]', 'March 7th from Honkai: Star Rail!', 230.00, 'newarrivals'),
(27, 'March 7th_2.png', 'March 7th [2]', 'March 7th from Honkai: Star Rail!', 346.78, 'newarrivals'),
(28, 'March 7th_3.png', 'March 7th [3]', 'March 7th from Honkai: Star Rail!', 384.34, 'newarrivals'),
(29, 'March 7th_4.png', 'March 7th [4]', 'March 7th from Honkai: Star Rail!', 343.76, 'newarrivals'),
(30, 'March 7th_5.png', 'March 7th [5]', 'March 7th from Honkai: Star Rail!', 234.88, 'newarrivals'),
(31, 'March 7th_6.png', 'Marc 7th [6]', 'March 7th from Honkai: Star Rail!', 834.56, 'newarrivals'),
(32, 'March 7th_7.png', 'March 7th [7]', 'March 7th from Honkai: Star Rail!', 535.34, 'newarrivals'),
(33, 'March 7th_8.png', 'March 7th [8]', 'March 7th from Honkai: Star Rail!', 345.67, 'newarrivals'),
(34, 'March 7th_9.png', 'March 7thh [9]', 'March 7th from Honkai: Star Rail!', 343.34, 'newarrivals'),
(35, 'March 7th_10.png', 'March 7th [10]', 'March 7th from Honkai: Star Rail!', 123.90, 'newarrivals'),
(36, 'Pom-Pom 1.png', 'Pompom [1]', '[Honkai: Star Rail] Pompom, the Astral Conductor!', 431.00, 'bestseller'),
(37, 'Pom-Pom 2.png', 'Pompom [2]', '[Honkai: Star Rail] Pompom, the Astral Conductor!', 356.67, 'bestseller'),
(38, 'Pom-Pom 3.png', 'Pompom [3]', '[Honkai: Star Rail] Pompom, the Astral Conductor!', 234.64, 'bestseller'),
(39, 'Pom-Pom 4.png', 'Pompom [4]', '[Honkai: Star Rail] Pompom, the Astral Conductor!', 235.00, 'bestseller'),
(40, 'Pom-Pom 5.png', 'PomPom [5]', '[Honkai: Star Rail] Pompom, the Astral Conductor!', 654.56, 'bestseller'),
(41, 'Pom-Pom 6.png', 'Pompom [6]', '[Honkai: Star Rail] Pompom, the Astral Conductor!', 345.00, 'bestseller'),
(42, 'Pom-Pom 7.png', 'Pompom [7]', '[Honkai: Star Rail] Pompom, the Astral Conductor!', 235.78, 'bestseller'),
(43, 'Chevreuse 1.png', 'Chevreuse [1]', '[ Captain of the Maison Gardiennage\'s Special Security and Surveillance Patrol.', 14.00, 'bestseller'),
(44, 'Chevreuse 2.png', 'Chevreuse [2]', '[ Captain of the Maison Gardiennage\'s Special Security and Surveillance Patrol.', 52.00, 'bestseller'),
(45, 'Chevreuse 3.png', 'Chevreuse [3]', '[ Captain of the Maison Gardiennage\'s Special Security and Surveillance Patrol.', 23.00, 'bestseller'),
(46, 'Chevreuse 4.png', 'Chevreuse [4]', '[ Captain of the Maison Gardiennage\'s Special Security and Surveillance Patrol.', 24.00, 'bestseller'),
(47, 'Furina.png', 'Furina', 'Introduced as the flamboyant and overconfident Hydro Archon.', 111.00, 'bestseller'),
(48, 'Kamisato Ayaka 1.png', 'Kamisato Ayaka [1]', 'Beautiful, dignified, and noble, considered a model of perfection in Inazuma.', 12.00, 'bestseller'),
(49, 'Kamisato Ayaka 2.png', 'Kamisato Ayaka [2]', 'Beautiful, dignified, and noble, considered a model of perfection in Inazuma.', 45.00, 'bestseller'),
(50, 'Kamisato Ayato.png', 'Kamisato Ayato', 'Brother of Kamisato Ayaka.', 13.00, 'bestseller'),
(51, 'Navia 1.png', 'Navia [1]', 'She is the president of the Spina di Rosula, a mantle previously held by her late father Callas.', 13.00, 'bestseller'),
(52, 'Navia 2.png', 'Navia [2]', 'She is the president of the Spina di Rosula, a mantle previously held by her late father Callas.', 75.00, 'bestseller'),
(53, 'Navia 3.png', 'Navia [3]', 'She is the president of the Spina di Rosula, a mantle previously held by her late father Callas.', 14.00, 'bestseller'),
(54, 'Raiden Shogun 1.png', 'Raiden Shogun [1]', 'Electro Archon of Inazuma', 653.00, 'bestseller'),
(55, 'Raiden Shogun 2.png', 'Raiden Shogun [2]', 'Electro Archon of Inazuma', 14.00, 'bestseller'),
(56, 'Yoimiya 1.png', 'Yoimiya [1]', 'Yoimiya is loved by everyone on Narukami Island.', 234.00, 'bestseller'),
(57, 'Yoimiya 2.png', 'Yoimiya [2]', 'Yoimiya is loved by everyone on Narukami Island.', 149.00, 'bestseller'),
(58, 'Hu Tao.png', 'Hu Tao [3]', 'Director of Wangsheng Funeral Parlor', 345.00, 'bestseller'),
(59, 'Barbara 1.png', 'Barbara', 'Idol from Mondstadt', 80.49, 'bestseller');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`) VALUES
(1, 'djgpaduada@slsu.edu.ph', '$2y$10$9MgrYcwEhmcTDPugbKDfiecHuNp30BItnuNlbCuSB6MST36aXn6tm'),
(2, 'admin@admin.com', '$2y$10$g/RSXTUid5rtSqknqC2Lgu/ISU0f8Z9VSxB6nq3n6rNQZPst1VsqW');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
