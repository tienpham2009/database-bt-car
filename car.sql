-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 27, 2021 at 07:59 AM
-- Server version: 8.0.25-0ubuntu0.20.04.1
-- PHP Version: 8.0.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `car`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `custormer_number` int NOT NULL,
  `customer_lastname` varchar(50) NOT NULL,
  `customer_firstname` varchar(50) NOT NULL,
  `customers_phone` int NOT NULL,
  `address_line1` varchar(50) NOT NULL,
  `address_line2` varchar(50) DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `postal_code` int NOT NULL,
  `country` varchar(50) NOT NULL,
  `credit_limit` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_number` int NOT NULL,
  `employee_lastname` varchar(50) NOT NULL,
  `employee_firstname` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `job_title` varchar(50) NOT NULL,
  `report_to` int NOT NULL,
  `office_code` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `offices`
--

CREATE TABLE `offices` (
  `office_code` varchar(10) NOT NULL,
  `city` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `postal_code` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_number` int NOT NULL,
  `order_date` date NOT NULL,
  `requied_date` date NOT NULL,
  `shipped_date` date NOT NULL,
  `status` varchar(15) NOT NULL,
  `comments` text,
  `quantity_ordered` int NOT NULL,
  `price_each` int NOT NULL,
  `customer_number` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `order_number` int NOT NULL,
  `product_code` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `customer_number` int NOT NULL,
  `check_number` varchar(50) NOT NULL,
  `payment_date` date NOT NULL,
  `amount` int NOT NULL,
  `sales_rep_employee_number` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `productline`
--

CREATE TABLE `productline` (
  `productline` varchar(50) NOT NULL,
  `text_description` text,
  `image` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_code` int NOT NULL,
  `product_name` varchar(70) NOT NULL,
  `product_vendor` varchar(50) NOT NULL,
  `product_scale` varchar(10) NOT NULL,
  `product_description` text NOT NULL,
  `quantity_in_stock` int NOT NULL,
  `buy_price` int NOT NULL,
  `MSRP` int NOT NULL,
  `product_line` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`custormer_number`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_number`),
  ADD KEY `report_to` (`report_to`),
  ADD KEY `employees_ibfk_1` (`office_code`);

--
-- Indexes for table `offices`
--
ALTER TABLE `offices`
  ADD PRIMARY KEY (`office_code`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_number`),
  ADD KEY `customer_number` (`customer_number`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD KEY `product_code` (`product_code`),
  ADD KEY `order_number` (`order_number`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD KEY `customer_number` (`customer_number`),
  ADD KEY `sales_rep_employee_number` (`sales_rep_employee_number`);

--
-- Indexes for table `productline`
--
ALTER TABLE `productline`
  ADD PRIMARY KEY (`productline`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_code`),
  ADD KEY `product_line` (`product_line`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`office_code`) REFERENCES `offices` (`office_code`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_number`) REFERENCES `customers` (`custormer_number`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`product_code`) REFERENCES `products` (`product_code`),
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`order_number`) REFERENCES `orders` (`order_number`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`customer_number`) REFERENCES `customers` (`custormer_number`),
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`sales_rep_employee_number`) REFERENCES `employees` (`employee_number`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`product_line`) REFERENCES `productline` (`productline`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
