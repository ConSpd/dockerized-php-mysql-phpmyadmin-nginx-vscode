-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: May 22, 2023 at 01:44 PM
-- Server version: 5.7.34
-- PHP Version: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `general_insurance`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_insurances` (IN `p_afm` INT(9), `p_date` DATE)  begin
drop table if exists customer_insur;

create temporary table customer_insur (contract_no int(3),start_day date,end_day date,price float(7,2));

insert into customer_insur
select contract_no,start_day,end_day,price 
from contract inner join customer
on contract.customer_no = customer.customer_no
where afm = p_afm;

select count(*),sum(price)
from customer_insur
where p_date between customer_insur.start_day and customer_insur.end_day;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `contract`
--

CREATE TABLE `contract` (
  `contract_no` int(11) NOT NULL,
  `customer_no` int(11) NOT NULL,
  `product_no` int(11) NOT NULL,
  `start_day` date DEFAULT NULL,
  `end_day` date DEFAULT NULL,
  `price` float(7,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `contract`
--

INSERT INTO `contract` (`contract_no`, `customer_no`, `product_no`, `start_day`, `end_day`, `price`) VALUES
(100, 10, 20, '2020-08-01', '2021-02-01', 90.00),
(110, 10, 40, '2019-01-09', '2019-09-09', 180.00),
(120, 10, 30, '2019-08-09', '2020-08-09', 150.00),
(130, 30, 40, '2018-04-15', '2018-12-15', 180.00),
(140, 30, 10, '2019-03-28', '2019-09-28', 75.00),
(150, 40, 40, '2020-03-24', '2020-11-24', 180.00),
(160, 20, 40, '2021-01-18', '2021-09-18', 180.00);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_no` int(11) NOT NULL,
  `c_name` varchar(14) DEFAULT NULL,
  `address` varchar(20) DEFAULT NULL,
  `c_phone` bigint(20) DEFAULT NULL,
  `afm` bigint(20) DEFAULT NULL,
  `doy` varchar(14) DEFAULT NULL,
  `cost_of_contracts` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_no`, `c_name`, `address`, `c_phone`, `afm`, `doy`, `cost_of_contracts`) VALUES
(10, 'nikos', 'karaiskaki 14', 6985249678, 154534687, 'aigaleou', 420),
(20, 'maria', 'filiatron 28', 6988453678, 154524187, 'peristeriou', 180),
(30, 'foteini', 'aristarxou 5', 6988635845, 653574187, 'aigaleou', 255),
(40, 'aris', 'agion panton 28', 6925758432, 536988715, 'kalitheas', 180);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_no` int(11) NOT NULL,
  `prod_type` varchar(14) DEFAULT NULL,
  `cost_perYear` float(7,2) DEFAULT NULL,
  `minimum_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_no`, `prod_type`, `cost_perYear`, `minimum_time`) VALUES
(10, 'Health', 180.00, 6),
(20, 'Crit Illness', 200.00, 4),
(30, 'Home', 150.00, 12),
(40, 'Car', 220.00, 8);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contract`
--
ALTER TABLE `contract`
  ADD PRIMARY KEY (`contract_no`),
  ADD KEY `customer_no` (`customer_no`),
  ADD KEY `product_no` (`product_no`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_no`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_no`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contract`
--
ALTER TABLE `contract`
  ADD CONSTRAINT `contract_ibfk_1` FOREIGN KEY (`customer_no`) REFERENCES `customer` (`customer_no`),
  ADD CONSTRAINT `contract_ibfk_2` FOREIGN KEY (`product_no`) REFERENCES `product` (`product_no`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
