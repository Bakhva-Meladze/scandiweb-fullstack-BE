-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 11, 2024 at 04:17 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `scandiweb`
--

-- --------------------------------------------------------

--
-- Table structure for table `attributes`
--

CREATE TABLE `attributes` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attributes`
--

INSERT INTO `attributes` (`id`, `name`, `type`) VALUES
('capacity', 'capacity', 'text'),
('color', 'color', 'swatch'),
('size', 'size', 'text'),
('Touch ID in keyboard', 'Touch ID in keyboard', 'text'),
('With USB 3 ports', 'With USB 3 ports', 'text');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`name`) VALUES
('all'),
('clothes'),
('tech');

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `label` varchar(50) NOT NULL,
  `symbol` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`label`, `symbol`) VALUES
('EUR', '€'),
('USD', '$');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `total_currency` varchar(50) NOT NULL,
  `status` enum('pending','processing','shipped','delivered') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `total_amount`, `total_currency`, `status`, `created_at`, `updated_at`) VALUES
(241, '1278.00', 'USD', 'pending', '2024-08-09 12:29:16', '2024-08-09 12:29:16'),
(242, '144.00', 'USD', 'pending', '2024-08-09 12:30:20', '2024-08-09 12:30:20'),
(243, '144.00', 'USD', 'pending', '2024-08-09 12:32:35', '2024-08-09 12:32:35'),
(244, '144.00', 'USD', 'pending', '2024-08-09 12:33:25', '2024-08-09 12:33:25'),
(245, '144.00', 'USD', 'pending', '2024-08-09 12:34:42', '2024-08-09 12:34:42'),
(246, '289.00', 'USD', 'pending', '2024-08-09 12:36:00', '2024-08-09 12:36:00'),
(247, '1600.00', 'USD', 'pending', '2024-08-09 12:37:23', '2024-08-09 12:37:23'),
(248, '2118.00', 'USD', 'pending', '2024-08-09 12:40:13', '2024-08-09 12:40:13'),
(249, '3718.00', 'USD', 'pending', '2024-08-09 13:12:11', '2024-08-09 13:12:11'),
(250, '518.00', 'USD', 'pending', '2024-08-09 13:13:04', '2024-08-09 13:13:04'),
(251, '518.00', 'USD', 'pending', '2024-08-09 13:14:45', '2024-08-09 13:14:45'),
(252, '518.00', 'USD', 'pending', '2024-08-09 13:20:55', '2024-08-09 13:20:55'),
(253, '518.00', 'USD', 'pending', '2024-08-09 13:23:12', '2024-08-09 13:23:12'),
(254, '518.00', 'USD', 'pending', '2024-08-09 13:40:20', '2024-08-09 13:40:20'),
(255, '518.00', 'USD', 'pending', '2024-08-09 13:41:32', '2024-08-09 13:41:32'),
(256, '518.00', 'USD', 'pending', '2024-08-09 13:41:53', '2024-08-09 13:41:53'),
(257, '518.00', 'USD', 'pending', '2024-08-09 13:43:57', '2024-08-09 13:43:57'),
(258, '518.00', 'USD', 'pending', '2024-08-09 13:44:05', '2024-08-09 13:44:05'),
(259, '1555.00', 'USD', 'pending', '2024-08-09 13:44:38', '2024-08-09 13:44:38'),
(260, '1720.00', 'USD', 'pending', '2024-08-09 13:46:39', '2024-08-09 13:46:39'),
(261, '1278.00', 'USD', 'pending', '2024-08-10 08:20:55', '2024-08-10 08:20:55'),
(262, '289.00', 'USD', 'pending', '2024-08-10 09:30:55', '2024-08-10 09:30:55');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `attribute_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`attribute_values`)),
  `quantity` int(10) UNSIGNED DEFAULT 1,
  `paid_amount` decimal(10,2) NOT NULL,
  `paid_currency` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `product_name`, `attribute_values`, `quantity`, `paid_amount`, `paid_currency`, `created_at`, `updated_at`) VALUES
(155, 241, 'huarache-x-stussy-le', 'Nike Air Huarache Le', '{\"size\":\"40\"}', 1, '289.38', 'USD', '2024-08-09 12:29:16', '2024-08-09 12:29:16'),
(156, 241, 'huarache-x-stussy-le', 'Nike Air Huarache Le', '{\"size\":\"43\"}', 1, '144.69', 'USD', '2024-08-09 12:29:16', '2024-08-09 12:29:16'),
(157, 241, 'ps-5', 'Nike Air Huarache Le', '{\"color\":\"#44FF03\",\"capacity\":\"512G\"}', 1, '844.02', 'USD', '2024-08-09 12:29:16', '2024-08-09 12:29:16'),
(158, 242, 'huarache-x-stussy-le', 'Nike Air Huarache Le', '{\"size\":\"41\"}', 1, '144.69', 'USD', '2024-08-09 12:30:20', '2024-08-09 12:30:20'),
(159, 243, 'huarache-x-stussy-le', 'Nike Air Huarache Le', '{\"size\":\"40\"}', 1, '144.69', 'USD', '2024-08-09 12:32:35', '2024-08-09 12:32:35'),
(160, 244, 'huarache-x-stussy-le', 'Nike Air Huarache Le', '{\"size\":\"40\"}', 1, '144.69', 'USD', '2024-08-09 12:33:25', '2024-08-09 12:33:25'),
(161, 245, 'huarache-x-stussy-le', 'Nike Air Huarache Le', '{\"size\":\"43\"}', 1, '144.69', 'USD', '2024-08-09 12:34:42', '2024-08-09 12:34:42'),
(162, 246, 'huarache-x-stussy-le', 'Nike Air Huarache Le', '{\"size\":\"43\"}', 1, '144.69', 'USD', '2024-08-09 12:36:00', '2024-08-09 12:36:00'),
(163, 246, 'huarache-x-stussy-le', 'Nike Air Huarache Le', '{\"size\":\"42\"}', 1, '144.69', 'USD', '2024-08-09 12:36:00', '2024-08-09 12:36:00'),
(164, 247, 'apple-imac-2021', 'Nike Air Huarache Le', '{\"capacity\":\"512GB\",\"Touch ID in keyboard\":\"Yes\",\"With USB 3 ports\":\"No\"}', 1, '1600.00', 'USD', '2024-08-09 12:37:23', '2024-08-09 12:37:23'),
(165, 248, 'apple-imac-2021', 'Nike Air Huarache Le', '{\"capacity\":\"512GB\",\"Touch ID in keyboard\":\"Yes\",\"With USB 3 ports\":\"No\"}', 1, '1600.00', 'USD', '2024-08-09 12:40:13', '2024-08-09 12:40:13'),
(166, 248, 'jacket-canada-goosee', 'Nike Air Huarache Le', '{\"size\":\"M\"}', 1, '518.47', 'USD', '2024-08-09 12:40:13', '2024-08-09 12:40:13'),
(167, 249, 'apple-imac-2021', 'Nike Air Huarache Le', '{\"capacity\":\"512GB\",\"Touch ID in keyboard\":\"Yes\",\"With USB 3 ports\":\"No\"}', 1, '3200.00', 'USD', '2024-08-09 13:12:11', '2024-08-09 13:12:11'),
(168, 249, 'jacket-canada-goosee', 'Nike Air Huarache Le', '{\"size\":\"M\"}', 1, '518.47', 'USD', '2024-08-09 13:12:11', '2024-08-09 13:12:11'),
(169, 250, 'jacket-canada-goosee', 'Nike Air Huarache Le', '{\"size\":\"L\"}', 1, '518.47', 'USD', '2024-08-09 13:13:04', '2024-08-09 13:13:04'),
(170, 251, 'jacket-canada-goosee', 'Nike Air Huarache Le', '{\"size\":\"M\"}', 1, '518.47', 'USD', '2024-08-09 13:14:45', '2024-08-09 13:14:45'),
(171, 252, 'jacket-canada-goosee', 'Nike Air Huarache Le', '{\"size\":\"M\"}', 1, '518.47', 'USD', '2024-08-09 13:20:55', '2024-08-09 13:20:55'),
(172, 253, 'jacket-canada-goosee', 'Nike Air Huarache Le', '{\"size\":\"L\"}', 1, '518.47', 'USD', '2024-08-09 13:23:12', '2024-08-09 13:23:12'),
(173, 254, 'jacket-canada-goosee', 'Nike Air Huarache Le', '{\"size\":\"XL\"}', 1, '518.47', 'USD', '2024-08-09 13:40:20', '2024-08-09 13:40:20'),
(174, 255, 'jacket-canada-goosee', 'Nike Air Huarache Le', '{\"size\":\"M\"}', 1, '518.47', 'USD', '2024-08-09 13:41:32', '2024-08-09 13:41:32'),
(175, 256, 'jacket-canada-goosee', 'Nike Air Huarache Le', '{\"size\":\"XL\"}', 1, '518.47', 'USD', '2024-08-09 13:41:53', '2024-08-09 13:41:53'),
(176, 257, 'jacket-canada-goosee', 'Nike Air Huarache Le', '{\"size\":\"M\"}', 1, '518.47', 'USD', '2024-08-09 13:43:57', '2024-08-09 13:43:57'),
(177, 258, 'jacket-canada-goosee', 'Nike Air Huarache Le', '{\"size\":\"L\"}', 1, '518.47', 'USD', '2024-08-09 13:44:05', '2024-08-09 13:44:05'),
(178, 259, 'jacket-canada-goosee', 'Nike Air Huarache Le', '{\"size\":\"L\"}', 1, '518.47', 'USD', '2024-08-09 13:44:38', '2024-08-09 13:44:38'),
(179, 259, 'jacket-canada-goosee', 'Nike Air Huarache Le', '{\"size\":\"XL\"}', 1, '1036.94', 'USD', '2024-08-09 13:44:38', '2024-08-09 13:44:38'),
(180, 260, 'apple-airtag', 'Nike Air Huarache Le', '[]', 1, '120.57', 'USD', '2024-08-09 13:46:39', '2024-08-09 13:46:39'),
(181, 260, 'apple-imac-2021', 'Nike Air Huarache Le', '{\"capacity\":\"256GB\",\"Touch ID in keyboard\":\"No\",\"With USB 3 ports\":\"No\"}', 1, '1600.00', 'USD', '2024-08-09 13:46:39', '2024-08-09 13:46:39'),
(182, 261, 'huarache-x-stussy-le', 'Nike Air Huarache Le', '{\"size\":\"40\"}', 1, '289.38', 'USD', '2024-08-10 08:20:55', '2024-08-10 08:20:55'),
(183, 261, 'huarache-x-stussy-le', 'Nike Air Huarache Le', '{\"size\":\"43\"}', 1, '144.69', 'USD', '2024-08-10 08:20:55', '2024-08-10 08:20:55'),
(184, 261, 'ps-5', 'Nike Air Huarache Le', '{\"color\":\"#44FF03\",\"capacity\":\"512G\"}', 1, '844.02', 'USD', '2024-08-10 08:20:55', '2024-08-10 08:20:55'),
(185, 262, 'huarache-x-stussy-le', 'Nike Air Huarache Le', '{\"size\":\"41\"}', 1, '144.69', 'USD', '2024-08-10 09:30:55', '2024-08-10 09:30:55'),
(186, 262, 'huarache-x-stussy-le', 'Nike Air Huarache Le', '{\"size\":\"42\"}', 1, '144.69', 'USD', '2024-08-10 09:30:55', '2024-08-10 09:30:55');

-- --------------------------------------------------------

--
-- Table structure for table `prices`
--

CREATE TABLE `prices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `currency` varchar(50) NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `label` varchar(20) NOT NULL,
  `symbol` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prices`
--

INSERT INTO `prices` (`id`, `amount`, `currency`, `product_id`, `label`, `symbol`) VALUES
(1, '144.69', 'USD', 'huarache-x-stussy-le', 'USD', '$'),
(2, '518.47', 'USD', 'jacket-canada-goosee', 'USD', '$'),
(3, '844.02', 'USD', 'ps-5', 'USD', '$'),
(4, '333.99', 'USD', 'xbox-series-s', 'USD', '$'),
(5, '1600.00', 'USD', 'apple-imac-2021', 'USD', '$'),
(6, '1000.76', 'USD', 'apple-iphone-12-pro', 'USD', '$'),
(7, '300.00', 'USD', 'apple-airpods-pro', 'USD', '$'),
(8, '120.57', 'USD', 'apple-airtag', 'USD', '$');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `inStock` tinyint(1) DEFAULT 1,
  `gallery` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`gallery`)),
  `description` text DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `inStock`, `gallery`, `description`, `category`, `brand`) VALUES
('apple-airpods-pro', 'AirPods Pro', 0, '[\"https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MWP22?wid=572&hei=572&fmt=jpeg&qlt=95&.v=1591634795000\"]', ' <h3>Magic like you’ve never heard</h3> <p>AirPods Pro have been designed to deliver Active Noise Cancellation for immersive sound, Transparency mode so you can hear your surroundings, and a customizable fit for all-day comfort. Just like AirPods, AirPods Pro connect magically to your iPhone or Apple Watch. And they’re ready to use right out of the case. <h3>Active Noise Cancellation</h3> <p>Incredibly light noise-cancelling headphones, AirPods Pro block out your environment so you can focus on what you’re listening to. AirPods Pro use two microphones, an outward-facing microphone and an inward-facing microphone, to create superior noise cancellation. By continuously adapting to the geometry of your ear and the fit of the ear tips, Active Noise Cancellation silences the world to keep you fully tuned in to your music, podcasts, and calls. <h3>Transparency mode</h3> <p>Switch to Transparency mode and AirPods Pro let the outside sound in, allowing you to hear and connect to your surroundings. Outward- and inward-facing microphones enable AirPods Pro to undo the sound-isolating effect of the silicone tips so things sound and feel natural, like when you’re talking to people around you.</p> <h3>All-new design</h3> <p>AirPods Pro offer a more customizable fit with three sizes of flexible silicone tips to choose from. With an internal taper, they conform to the shape of your ear, securing your AirPods Pro in place and creating an exceptional seal for superior noise cancellation.</p> <h3>Amazing audio quality</h3> <p>A custom-built high-excursion, low-distortion driver delivers powerful bass. A superefficient high dynamic range amplifier produces pure, incredibly clear sound while also extending battery life. And Adaptive EQ automatically tunes music to suit the shape of your ear for a rich, consistent listening experience.</p> <h3>Even more magical</h3> <p>The Apple-designed H1 chip delivers incredibly low audio latency. A force sensor on the stem makes it easy to control music and calls and switch between Active Noise Cancellation and Transparency mode. Announce Messages with Siri gives you the option to have Siri read your messages through your AirPods. And with Audio Sharing, you and a friend can share the same audio stream on two sets of AirPods — so you can play a game, watch a movie, or listen to a song together.</p> ', 'tech', 'Apple'),
('apple-airtag', 'AirTag', 1, '[\"https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/airtag-double-select-202104?wid=445&hei=370&fmt=jpeg&qlt=95&.v=1617761672000\"]', ' <h1>Lose your knack for losing things.</h1> <p>AirTag is an easy way to keep track of your stuff. Attach one to your keys, slip another one in your backpack. And just like that, they’re on your radar in the Find My app. AirTag has your back.</p> ', 'tech', 'Apple'),
('apple-imac-2021', 'iMac 2021', 1, '[\"https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/imac-24-blue-selection-hero-202104?wid=904&hei=840&fmt=jpeg&qlt=80&.v=1617492405000\"]', 'The new iMac!', 'tech', 'Apple'),
('apple-iphone-12-pro', 'iPhone 12 Pro', 1, '[\"https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-12-pro-family-hero?wid=940&amp;hei=1112&amp;fmt=jpeg&amp;qlt=80&amp;.v=1604021663000\"]', 'This is iPhone 12. Nothing else to say.', 'tech', 'Apple'),
('huarache-x-stussy-le', 'Nike Air Huarache Le', 1, '[\"https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_2_720x.jpg?v=1612816087\",\"https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_1_720x.jpg?v=1612816087\",\"https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_3_720x.jpg?v=1612816087\",\"https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_5_720x.jpg?v=1612816087\",\"https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_4_720x.jpg?v=1612816087\"]', '<p>Great sneakers for everyday use!</p>', 'clothes', 'Nike x Stussy'),
('jacket-canada-goosee', 'Jacket', 1, '[\"https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016105/product-image/2409L_61.jpg\",\"https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016107/product-image/2409L_61_a.jpg\",\"https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016108/product-image/2409L_61_b.jpg\",\"https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016109/product-image/2409L_61_c.jpg\",\"https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016110/product-image/2409L_61_d.jpg\",\"https://images.canadagoose.com/image/upload/w_1333,c_scale,f_auto,q_auto:best/v1634058169/product-image/2409L_61_o.png\",\"https://images.canadagoose.com/image/upload/w_1333,c_scale,f_auto,q_auto:best/v1634058159/product-image/2409L_61_p.png\"]', '<p>Awesome winter jacket</p>', 'clothes', 'Canada Goose'),
('ps-5', 'PlayStation 5', 1, '[\"https://images-na.ssl-images-amazon.com/images/I/510VSJ9mWDL._SL1262_.jpg\",\"https://images-na.ssl-images-amazon.com/images/I/610%2B69ZsKCL._SL1500_.jpg\",\"https://images-na.ssl-images-amazon.com/images/I/51iPoFwQT3L._SL1230_.jpg\",\"https://images-na.ssl-images-amazon.com/images/I/61qbqFcvoNL._SL1500_.jpg\",\"https://images-na.ssl-images-amazon.com/images/I/51HCjA3rqYL._SL1230_.jpg\"]', '<p>A good gaming console. Plays games of PS4! Enjoy if you can buy it mwahahahaha</p>', 'tech', 'Sony'),
('xbox-series-s', 'Xbox Series S 512GB', 0, '[\"https://images-na.ssl-images-amazon.com/images/I/71vPCX0bS-L._SL1500_.jpg\",\"https://images-na.ssl-images-amazon.com/images/I/71q7JTbRTpL._SL1500_.jpg\",\"https://images-na.ssl-images-amazon.com/images/I/71iQ4HGHtsL._SL1500_.jpg\",\"https://images-na.ssl-images-amazon.com/images/I/61IYrCrBzxL._SL1500_.jpg\",\"https://images-na.ssl-images-amazon.com/images/I/61RnXmpAmIL._SL1500_.jpg\"]', ' <div> <ul> <li><span>Hardware-beschleunigtes Raytracing macht dein Spiel noch realistischer</span></li> <li><span>Spiele Games mit bis zu 120 Bilder pro Sekunde</span></li> <li><span>Minimiere Ladezeiten mit einer speziell entwickelten 512GB NVMe SSD und wechsle mit Quick Resume nahtlos zwischen mehreren Spielen.</span></li> <li><span>Xbox Smart Delivery stellt sicher, dass du die beste Version deines Spiels spielst, egal, auf welcher Konsole du spielst</span></li> <li><span>Spiele deine Xbox One-Spiele auf deiner Xbox Series S weiter. Deine Fortschritte, Erfolge und Freundesliste werden automatisch auf das neue System übertragen.</span></li> <li><span>Erwecke deine Spiele und Filme mit innovativem 3D Raumklang zum Leben</span></li> <li><span>Der brandneue Xbox Wireless Controller zeichnet sich durch höchste Präzision, eine neue Share-Taste und verbesserte Ergonomie aus</span></li> <li><span>Ultra-niedrige Latenz verbessert die Reaktionszeit von Controller zum Fernseher</span></li> <li><span>Verwende dein Xbox One-Gaming-Zubehör -einschließlich Controller, Headsets und mehr</span></li> <li><span>Erweitere deinen Speicher mit der Seagate 1 TB-Erweiterungskarte für Xbox Series X (separat erhältlich) und streame 4K-Videos von Disney+, Netflix, Amazon, Microsoft Movies &amp; TV und mehr</span></li> </ul> </div>', 'tech', 'Microsoft');

-- --------------------------------------------------------

--
-- Table structure for table `product_attributes`
--

CREATE TABLE `product_attributes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `attribute_id` varchar(255) DEFAULT NULL,
  `displayValue` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_attributes`
--

INSERT INTO `product_attributes` (`id`, `product_id`, `attribute_id`, `displayValue`, `value`) VALUES
(1, 'huarache-x-stussy-le', 'size', '40', '40'),
(2, 'huarache-x-stussy-le', 'size', '41', '41'),
(3, 'huarache-x-stussy-le', 'size', '42', '42'),
(4, 'huarache-x-stussy-le', 'size', '43', '43'),
(5, 'jacket-canada-goosee', 'size', 'Small', 'S'),
(6, 'jacket-canada-goosee', 'size', 'Medium', 'M'),
(7, 'jacket-canada-goosee', 'size', 'Large', 'L'),
(8, 'jacket-canada-goosee', 'size', 'Extra Large', 'XL'),
(9, 'ps-5', 'color', 'Green', '#44FF03'),
(10, 'ps-5', 'color', 'Cyan', '#03FFF7'),
(11, 'ps-5', 'color', 'Blue', '#030BFF'),
(12, 'ps-5', 'color', 'Black', '#000000'),
(13, 'ps-5', 'color', 'White', '#FFFFFF'),
(14, 'ps-5', 'capacity', '512G', '512G'),
(15, 'ps-5', 'capacity', '1T', '1T'),
(16, 'xbox-series-s', 'color', 'Green', '#44FF03'),
(17, 'xbox-series-s', 'color', 'Cyan', '#03FFF7'),
(18, 'xbox-series-s', 'color', 'Blue', '#030BFF'),
(19, 'xbox-series-s', 'color', 'Black', '#000000'),
(20, 'xbox-series-s', 'color', 'White', '#FFFFFF'),
(21, 'xbox-series-s', 'capacity', '512G', '512G'),
(22, 'xbox-series-s', 'capacity', '1T', '1T'),
(23, 'apple-imac-2021', 'capacity', '256GB', '256GB'),
(24, 'apple-imac-2021', 'capacity', '512GB', '512GB'),
(25, 'apple-imac-2021', 'With USB 3 ports', 'Yes', 'Yes'),
(26, 'apple-imac-2021', 'With USB 3 ports', 'No', 'No'),
(27, 'apple-imac-2021', 'Touch ID in keyboard', 'Yes', 'Yes'),
(28, 'apple-imac-2021', 'Touch ID in keyboard', 'No', 'No'),
(29, 'apple-iphone-12-pro', 'capacity', '512G', '512G'),
(30, 'apple-iphone-12-pro', 'capacity', '1T', '1T'),
(31, 'apple-iphone-12-pro', 'color', 'Green', '#44FF03'),
(32, 'apple-iphone-12-pro', 'color', 'Cyan', '#03FFF7'),
(33, 'apple-iphone-12-pro', 'color', 'Blue', '#030BFF'),
(34, 'apple-iphone-12-pro', 'color', 'Black', '#000000'),
(35, 'apple-iphone-12-pro', 'color', 'White', '#FFFFFF');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attributes`
--
ALTER TABLE `attributes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_attribute` (`name`,`type`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`label`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `prices`
--
ALTER TABLE `prices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_product_price_currency` (`product_id`,`currency`),
  ADD KEY `currency` (`currency`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category` (`category`);

--
-- Indexes for table `product_attributes`
--
ALTER TABLE `product_attributes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_product_attribute_value` (`product_id`,`attribute_id`,`value`),
  ADD KEY `attribute_id` (`attribute_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=263;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=187;

--
-- AUTO_INCREMENT for table `prices`
--
ALTER TABLE `prices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `product_attributes`
--
ALTER TABLE `product_attributes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `prices`
--
ALTER TABLE `prices`
  ADD CONSTRAINT `prices_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `prices_ibfk_2` FOREIGN KEY (`currency`) REFERENCES `currencies` (`label`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category`) REFERENCES `categories` (`name`) ON DELETE SET NULL;

--
-- Constraints for table `product_attributes`
--
ALTER TABLE `product_attributes`
  ADD CONSTRAINT `product_attributes_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_attributes_ibfk_2` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
