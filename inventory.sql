-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 04, 2025 at 04:41 PM
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
-- Database: `inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`, `description`) VALUES
(1, 'Electronics', 'Devices, gadgets, and other electronic items'),
(2, 'Clothing', 'Apparel and fashion items'),
(3, 'Furniture', 'Home and office furniture'),
(4, 'Books', 'Various books including fiction, non-fiction, and academic'),
(5, 'Toys', 'Toys and games for children');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `stock_quantity` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `name`, `description`, `price`, `category_id`, `supplier_id`, `stock_quantity`) VALUES
(1, 'Laptop', '15-inch laptop with 8GB RAM and 512GB SSD', 1200.00, 1, 1, 50),
(2, 'Smartphone', 'Android smartphone with 128GB storage and 6GB RAM', 600.00, 1, 1, 100),
(3, 'T-shirt', 'Cotton t-shirt with funny prints', 20.00, 2, 2, 200),
(4, 'Jeans', 'Blue denim jeans with a slim fit', 40.00, 2, 2, 150),
(5, 'Sofa', '3-seater sofa with leather upholstery', 500.00, 3, 3, 30),
(6, 'Office Chair', 'Ergonomic office chair with adjustable height', 120.00, 3, 3, 25),
(7, 'Mystery Novel', 'A thrilling mystery novel by John Doe', 15.00, 4, 4, 500),
(8, 'Textbook - Math', 'Mathematics textbook for high school students', 30.00, 4, 4, 300),
(9, 'Action Figure', 'Superhero action figure with multiple accessories', 15.00, 5, 5, 100),
(10, 'Board Game', 'Family-friendly board game for 4-6 players', 25.00, 5, 5, 75);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `description`) VALUES
(1, 'Admin', 'Has full access to the system.'),
(2, 'Staff', 'Can manage inventory and view reports.');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `session_id` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `login_time` datetime DEFAULT current_timestamp(),
  `session_validity` datetime DEFAULT current_timestamp(),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_movements`
--

CREATE TABLE `stock_movements` (
  `movement_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `movement_type` enum('in','out') NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stock_movements`
--

INSERT INTO `stock_movements` (`movement_id`, `product_id`, `quantity`, `movement_type`, `date`) VALUES
(1, 1, 50, 'in', '2025-01-21 15:03:27'),
(2, 2, 100, 'in', '2025-01-21 15:03:27'),
(3, 3, 200, 'in', '2025-01-21 15:03:27'),
(4, 4, 150, 'in', '2025-01-21 15:03:27'),
(5, 5, 30, 'in', '2025-01-21 15:03:27'),
(6, 6, 25, 'in', '2025-01-21 15:03:27'),
(7, 7, 500, 'in', '2025-01-21 15:03:27'),
(8, 8, 300, 'in', '2025-01-21 15:03:27'),
(9, 9, 100, 'in', '2025-01-21 15:03:27'),
(10, 10, 75, 'in', '2025-01-21 15:03:27'),
(11, 1, -10, 'out', '2025-01-21 15:03:27'),
(12, 2, -20, 'out', '2025-01-21 15:03:27'),
(13, 3, -50, 'out', '2025-01-21 15:03:27'),
(14, 4, -30, 'out', '2025-01-21 15:03:27'),
(15, 5, -5, 'out', '2025-01-21 15:03:27'),
(16, 6, -10, 'out', '2025-01-21 15:03:27'),
(17, 7, -100, 'out', '2025-01-21 15:03:27'),
(18, 8, -50, 'out', '2025-01-21 15:03:27'),
(19, 9, -20, 'out', '2025-01-21 15:03:27'),
(20, 10, -15, 'out', '2025-01-21 15:03:27'),
(21, 7, -10, 'in', '2025-02-04 15:11:19'),
(22, 1, 10, 'in', '2025-02-04 15:17:08');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `contact_info` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `name`, `contact_info`) VALUES
(1, 'ABC Electronics Ltd.', '123 Electronics Ave, New York, NY, contact@abcelectronics.com'),
(2, 'XYZ Fashion Co.', '456 Fashion St, Los Angeles, CA, contact@xyzfashion.com'),
(3, 'Global Furnishings', '789 Furniture Blvd, Chicago, IL, contact@globalfurnishings.com'),
(4, 'BookWorld Publishers', '101 Book St, Boston, MA, contact@bookworld.com'),
(5, 'KidsPlay Inc.', '202 Toy Rd, San Francisco, CA, contact@kidsplay.com');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_active` int(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password_hash`, `email`, `role_id`, `created_at`, `updated_at`, `is_active`) VALUES
(2, 'Babit2a', '$2y$10$uxlqC7dejI9oDS20ojwP3.BLknJ2HXKPFavZDalKAjn9P6b6.DFx2', 'babeetstha@gmail.com', 1, '2025-02-04 06:40:05', '2025-02-04 06:40:05', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `stock_movements`
--
ALTER TABLE `stock_movements`
  ADD PRIMARY KEY (`movement_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `stock_movements`
--
ALTER TABLE `stock_movements`
  MODIFY `movement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`);

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `stock_movements`
--
ALTER TABLE `stock_movements`
  ADD CONSTRAINT `stock_movements_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
