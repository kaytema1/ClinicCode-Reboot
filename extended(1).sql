-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 09, 2013 at 08:47 AM
-- Server version: 5.1.44
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `extended`
--

-- --------------------------------------------------------

--
-- Table structure for table `admissionnotes`
--

CREATE TABLE IF NOT EXISTS `admissionnotes` (
  `noteid` int(11) NOT NULL AUTO_INCREMENT,
  `visitid` int(11) NOT NULL,
  `doctorsid` varchar(255) DEFAULT NULL,
  `note` text NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`noteid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `admissionnotes`
--


-- --------------------------------------------------------

--
-- Table structure for table `aggrevation_options`
--

CREATE TABLE IF NOT EXISTS `aggrevation_options` (
  `aggrevation_id` int(11) NOT NULL AUTO_INCREMENT,
  `aggrevation` varchar(255) NOT NULL,
  PRIMARY KEY (`aggrevation_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `aggrevation_options`
--

INSERT INTO `aggrevation_options` (`aggrevation_id`, `aggrevation`) VALUES
(2, 'Eating'),
(3, 'Sleeping'),
(4, 'Application of Pressure');

-- --------------------------------------------------------

--
-- Table structure for table `allergies`
--

CREATE TABLE IF NOT EXISTS `allergies` (
  `allergyid` int(11) NOT NULL AUTO_INCREMENT,
  `type` text,
  `name` text,
  `possible_rxns` text,
  `suggested_treatment` text,
  PRIMARY KEY (`allergyid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `allergies`
--

INSERT INTO `allergies` (`allergyid`, `type`, `name`, `possible_rxns`, `suggested_treatment`) VALUES
(1, 'Food', 'Fruit', 'Mild itching, rash, blisters at point of oral contact', ''),
(2, 'Food', 'Garlic', ' 	Dermatitis, asymmetrical pattern of fissure, thickening/shedding of the outer skin layers,[1] anaphylaxis', ''),
(3, 'Food', 'Oats', ' Dermatitis, respiratory problems', '');

-- --------------------------------------------------------

--
-- Table structure for table `appoint`
--

CREATE TABLE IF NOT EXISTS `appoint` (
  `patientId` varchar(30) DEFAULT NULL,
  `doctorId` varchar(30) DEFAULT NULL,
  `content` varchar(30) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start` text,
  `title` text,
  `allday` text,
  `end` text,
  `honored` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `appoint`
--


-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE IF NOT EXISTS `appointment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patientId` varchar(30) DEFAULT NULL,
  `title` varchar(50) NOT NULL,
  `detail` text,
  `start` text,
  `end` text NOT NULL,
  `allday` text,
  `status` varchar(15) NOT NULL,
  `time_honoured` timestamp NULL DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `staff_id` varchar(50) NOT NULL,
  `time_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_added` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `appointment`
--


-- --------------------------------------------------------

--
-- Table structure for table `appointment_type`
--

CREATE TABLE IF NOT EXISTS `appointment_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `staff_id` varchar(50) NOT NULL,
  `date_added` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `appointment_type`
--

INSERT INTO `appointment_type` (`id`, `name`, `description`, `staff_id`, `date_added`) VALUES
(1, 'General', '', 'ClaimSync0009', '2013-09-11');

-- --------------------------------------------------------

--
-- Table structure for table `appointtype`
--

CREATE TABLE IF NOT EXISTS `appointtype` (
  `typeid` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `appointtype`
--


-- --------------------------------------------------------

--
-- Table structure for table `archived_ref_range_det`
--

CREATE TABLE IF NOT EXISTS `archived_ref_range_det` (
  `id` int(11) NOT NULL,
  `detailedinv_refrange_type_id` int(11) NOT NULL,
  `det_from` varchar(11) NOT NULL,
  `det_to` varchar(11) NOT NULL,
  `m_lower` varchar(11) NOT NULL,
  `m_upper` varchar(11) NOT NULL,
  `f_lower` varchar(11) NOT NULL,
  `f_upper` varchar(11) NOT NULL,
  `oerderid` text NOT NULL,
  `patienttreatmentid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `archived_ref_range_det`
--


-- --------------------------------------------------------

--
-- Table structure for table `archived_ref_range_uni`
--

CREATE TABLE IF NOT EXISTS `archived_ref_range_uni` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `detailedinv_refrange_type_id` int(11) NOT NULL,
  `selected` int(11) NOT NULL,
  `lower_ref_range` varchar(25) DEFAULT NULL,
  `upper_ref_range` varchar(25) DEFAULT NULL,
  `paragraphic` text,
  `orderid` text NOT NULL,
  `patienttreatmentid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `archived_ref_range_uni`
--


-- --------------------------------------------------------

--
-- Table structure for table `backup_sync_table`
--

CREATE TABLE IF NOT EXISTS `backup_sync_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `syncfrequency` int(11) DEFAULT NULL,
  `day_date` date DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `am_pm` varchar(10) DEFAULT NULL,
  `back_frequncy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `backup_sync_table`
--


-- --------------------------------------------------------

--
-- Table structure for table `bed`
--

CREATE TABLE IF NOT EXISTS `bed` (
  `bedid` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `occuppied` tinyint(1) NOT NULL,
  `ward_or_room` text NOT NULL,
  `wardid` int(11) NOT NULL,
  `roomid` int(11) NOT NULL,
  PRIMARY KEY (`bedid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `bed`
--

INSERT INTO `bed` (`bedid`, `description`, `occuppied`, `ward_or_room`, `wardid`, `roomid`) VALUES
(2, 'Bed 2', 0, 'ward_1', 0, 0),
(3, 'Bed 3', 1, 'ward_1', 1, 0),
(4, 'Bed 4', 1, 'ward_1', 1, 0),
(5, 'Bed 5', 1, 'ward_1', 1, 0),
(6, 'Bed 1', 1, 'ward_3', 3, 0),
(7, 'Bed 2', 1, 'ward_3', 3, 0),
(8, 'Bed 3', 1, 'ward_3', 3, 0),
(9, 'Bed 1', 1, 'room_1', 0, 1),
(10, 'Bed 2', 1, 'room_2', 0, 2),
(11, 'Bed 3', 1, 'room_3', 0, 3),
(12, 'Bed 4', 1, 'room_4', 0, 4),
(13, 'Bed 1', 0, 'ward_4', 4, 0),
(14, 'Bed 2', 0, 'ward_4', 4, 0),
(15, 'Bed 3', 0, 'ward_4', 4, 0),
(16, 'Bed 4', 0, 'ward_3', 3, 0),
(17, 'Bed 6', 0, 'ward_3', 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `body_part_options`
--

CREATE TABLE IF NOT EXISTS `body_part_options` (
  `body_part_id` int(11) NOT NULL AUTO_INCREMENT,
  `body_part` varchar(255) NOT NULL,
  PRIMARY KEY (`body_part_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `body_part_options`
--

INSERT INTO `body_part_options` (`body_part_id`, `body_part`) VALUES
(1, 'Head'),
(2, 'Shoulder'),
(3, 'Foot'),
(4, 'Lungs');

-- --------------------------------------------------------

--
-- Table structure for table `card_fee`
--

CREATE TABLE IF NOT EXISTS `card_fee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_fee` double NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `card_fee`
--

INSERT INTO `card_fee` (`id`, `card_fee`, `user_id`, `date_added`, `status`) VALUES
(1, 20, 'ClaimSync0009', '2013-11-28 11:48:00', 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `card_printing`
--

CREATE TABLE IF NOT EXISTS `card_printing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patientid` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `print_count` int(11) NOT NULL,
  `last_print_date` datetime NOT NULL,
  `orderedby` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `card_printing`
--

INSERT INTO `card_printing` (`id`, `patientid`, `price`, `print_count`, `last_print_date`, `orderedby`) VALUES
(12, '13DC2', 20, 1, '2013-12-09 07:02:58', 'ClaimSync0002'),
(11, '13DC4', 20, 1, '2013-12-08 22:33:50', 'ClaimSync0002'),
(10, '13DC1', 20, 2, '2013-11-29 09:52:01', 'ClaimSync0002');

-- --------------------------------------------------------

--
-- Table structure for table `characteristic_options`
--

CREATE TABLE IF NOT EXISTS `characteristic_options` (
  `characteristic_id` int(11) NOT NULL AUTO_INCREMENT,
  `characteristic` varchar(255) NOT NULL,
  PRIMARY KEY (`characteristic_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `characteristic_options`
--

INSERT INTO `characteristic_options` (`characteristic_id`, `characteristic`) VALUES
(3, 'Very Painful'),
(2, 'Severe');

-- --------------------------------------------------------

--
-- Table structure for table `claimtable`
--

CREATE TABLE IF NOT EXISTS `claimtable` (
  `tableid` int(11) NOT NULL AUTO_INCREMENT,
  `claimid` int(11) NOT NULL,
  `sportype` varchar(20) NOT NULL,
  `visitid` int(11) NOT NULL,
  `patientid` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `total_claim` double DEFAULT NULL,
  `claim_date` date NOT NULL,
  `first_visit` date NOT NULL,
  `second_visit` date DEFAULT NULL,
  `third_visit` date DEFAULT NULL,
  `fourth_visit` date DEFAULT NULL,
  `second_visitid` int(11) DEFAULT NULL,
  `third_visitid` int(11) DEFAULT NULL,
  `fourth_visitid` int(11) DEFAULT NULL,
  `patientage` int(11) NOT NULL,
  `badgeid` text NOT NULL,
  `return_amount` double NOT NULL,
  `return_notes` text NOT NULL,
  `insuranceid` text NOT NULL,
  `accept_reject` text NOT NULL,
  PRIMARY KEY (`tableid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `claimtable`
--


-- --------------------------------------------------------

--
-- Table structure for table `clerkingquestion`
--

CREATE TABLE IF NOT EXISTS `clerkingquestion` (
  `clerkid` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(250) NOT NULL,
  `frequecy` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`clerkid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `clerkingquestion`
--

INSERT INTO `clerkingquestion` (`clerkid`, `question`, `frequecy`, `category_id`) VALUES
(2, 'Chest pain/angina', 0, 6),
(8, 'Sleep disturbance', 0, 5),
(10, 'Skin: rashes/bruising', 0, 5),
(11, 'Rash', 0, 12),
(13, 'Swollen glands', 0, 11),
(14, 'Nausia', 0, 7);

-- --------------------------------------------------------

--
-- Table structure for table `clerking_categories`
--

CREATE TABLE IF NOT EXISTS `clerking_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `clerking_categories`
--

INSERT INTO `clerking_categories` (`id`, `category_name`, `active`) VALUES
(5, 'GENERAL', 1),
(2, 'CARDIOVASCULAR', 1),
(6, 'RESPIRATORY', 1),
(7, 'GASTROINTESTINAL', 1),
(8, 'MUSCULOSKELETAL', 1),
(9, 'GENITO-URINARY', 1),
(10, 'CENTRAL NERVOUS SYSTEM', 1),
(11, 'ENDOCRINE', 1),
(12, 'SKIN', 1);

-- --------------------------------------------------------

--
-- Table structure for table `client_info`
--

CREATE TABLE IF NOT EXISTS `client_info` (
  `unique_id` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `other_names` varchar(100) NOT NULL,
  `date_of_birth` date NOT NULL,
  `gender` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telephone` varchar(100) NOT NULL,
  `next_of_kin` text NOT NULL,
  `next_of_kin_contact` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `country` text NOT NULL,
  `city` text NOT NULL,
  `employer` text NOT NULL,
  `date_of_registration` date NOT NULL,
  `marital_status` varchar(20) NOT NULL,
  `last_claim_id` int(11) DEFAULT NULL,
  `last_visit_id` int(11) DEFAULT NULL,
  `folder_number` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`unique_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client_info`
--


-- --------------------------------------------------------

--
-- Table structure for table `clinic_inventory_requests`
--

CREATE TABLE IF NOT EXISTS `clinic_inventory_requests` (
  `requisitionid` int(11) NOT NULL AUTO_INCREMENT,
  `itemcode` varchar(100) NOT NULL,
  `orderer` text NOT NULL,
  `orderdate` datetime NOT NULL,
  `deliverydate` datetime DEFAULT NULL,
  `deliverer` text,
  `status` text NOT NULL,
  `unit` text NOT NULL,
  `requestedquantity` int(11) NOT NULL,
  `deliveredquantity` int(11) NOT NULL,
  PRIMARY KEY (`requisitionid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `clinic_inventory_requests`
--

INSERT INTO `clinic_inventory_requests` (`requisitionid`, `itemcode`, `orderer`, `orderdate`, `deliverydate`, `deliverer`, `status`, `unit`, `requestedquantity`, `deliveredquantity`) VALUES
(1, 'ARTHES', 'ClaimSync0009', '2013-06-29 00:00:00', '2013-06-29 00:00:00', 'ClaimSync0009', 'Cancelled', 'Dispensary', 10, 100),
(2, 'PARACE', 'ClaimSync0009', '2013-06-29 00:00:00', '2013-06-29 00:00:00', 'ClaimSync0009', 'Approved', 'Dispensary', 10, 99),
(9, 'PARACE', 'ClaimSync0009', '2013-06-29 00:00:00', '2013-06-29 00:00:00', 'ClaimSync0009', 'Cancelled', 'Dispensary', 10, 99),
(10, 'ARTHES', 'ClaimSync0009', '2013-06-29 00:00:00', NULL, '', 'Pending', 'Dispensary', 100, 0),
(11, 'PARACE', 'ClaimSync0009', '2013-06-29 00:00:00', '2013-06-29 00:00:00', 'ClaimSync0009', 'Delivered', 'Dispensary', 1, 99),
(12, 'PARACE', 'ClaimSync0009', '2013-06-29 00:00:00', '2013-06-29 00:00:00', 'ClaimSync0009', 'Delivered', 'Dispensary', 5, 3),
(13, 'PARACE', 'ClaimSync0009', '2013-06-30 00:00:00', NULL, '', 'Pending', 'Dispensary', 5, 0);

-- --------------------------------------------------------

--
-- Table structure for table `company_profile`
--

CREATE TABLE IF NOT EXISTS `company_profile` (
  `companyid` varchar(200) NOT NULL,
  `comapnyname` text NOT NULL,
  `servicenumber` text NOT NULL,
  `telephone` text NOT NULL,
  `address` text NOT NULL,
  `eclaimnumber` text NOT NULL,
  `clinic_folder_code` varchar(10) NOT NULL,
  `diagnostics_folder_code` varchar(10) NOT NULL,
  `clinic_folder_start_number` int(11) NOT NULL,
  `diagnostic_folder_start_number` int(11) NOT NULL,
  `clinic_folder_start_active` int(11) NOT NULL,
  `lab_folder_start_active` int(11) NOT NULL,
  `lab_report_header_active` tinyint(1) NOT NULL,
  `lab_report_footer_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`companyid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `company_profile`
--

INSERT INTO `company_profile` (`companyid`, `comapnyname`, `servicenumber`, `telephone`, `address`, `eclaimnumber`, `clinic_folder_code`, `diagnostics_folder_code`, `clinic_folder_start_number`, `diagnostic_folder_start_number`, `clinic_folder_start_active`, `lab_folder_start_active`, `lab_report_header_active`, `lab_report_footer_active`) VALUES
('1', 'Danpong', '123456', '0246002991', 'No, 19 Banana Street', '12434545', 'DC', 'DL', 0, 20577, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `consultation`
--

CREATE TABLE IF NOT EXISTS `consultation` (
  `conid` int(11) NOT NULL AUTO_INCREMENT,
  `contype` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  PRIMARY KEY (`conid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `consultation`
--

INSERT INTO `consultation` (`conid`, `contype`, `amount`) VALUES
(1, 'Consultation (Normal)', 20),
(2, 'Consultation (Review) within 4 Days', 15),
(3, 'Specialist Consultation (Obs & Gynae)', 50),
(4, 'Specialist Consultation (Paediatrics)', 50),
(5, 'Specialist Review Consultation (Obs + Gynae) within 7 Days', 30),
(6, 'Specialist Review Consultation (Paediatics) within 4 Days', 30);

-- --------------------------------------------------------

--
-- Table structure for table `consultingrooms`
--

CREATE TABLE IF NOT EXISTS `consultingrooms` (
  `consultingroomid` int(11) NOT NULL AUTO_INCREMENT,
  `consultingroom` varchar(200) NOT NULL,
  `type` varchar(200) NOT NULL,
  PRIMARY KEY (`consultingroomid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `consultingrooms`
--

INSERT INTO `consultingrooms` (`consultingroomid`, `consultingroom`, `type`) VALUES
(5, 'Room 1', 'consultation'),
(2, 'Room 2', 'consultation'),
(3, 'Room 3', 'consultation');

-- --------------------------------------------------------

--
-- Table structure for table `core_ghana_groupings`
--

CREATE TABLE IF NOT EXISTS `core_ghana_groupings` (
  `groupingid` int(11) NOT NULL AUTO_INCREMENT,
  `core_GDRG` varchar(10) NOT NULL,
  `diagnostic_group` varchar(10) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`groupingid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `core_ghana_groupings`
--

INSERT INTO `core_ghana_groupings` (`groupingid`, `core_GDRG`, `diagnostic_group`, `description`) VALUES
(1, 'ASUR01', 'ASUR', 'Operations of thyroid and parathyroid glands');

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE IF NOT EXISTS `department` (
  `departmentid` int(11) NOT NULL AUTO_INCREMENT,
  `department` text NOT NULL,
  PRIMARY KEY (`departmentid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`departmentid`, `department`) VALUES
(1, 'Clinic'),
(4, 'Diagnostics'),
(10, 'Pharmacy'),
(11, 'Inventory & Stores');

-- --------------------------------------------------------

--
-- Table structure for table `detailedinv_posinvresults`
--

CREATE TABLE IF NOT EXISTS `detailedinv_posinvresults` (
  `detailedinv_posinvresult_id` int(11) NOT NULL AUTO_INCREMENT,
  `detailedinv_id` int(11) NOT NULL,
  `posinvresult_id` int(11) NOT NULL,
  PRIMARY KEY (`detailedinv_posinvresult_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1722 ;

--
-- Dumping data for table `detailedinv_posinvresults`
--

INSERT INTO `detailedinv_posinvresults` (`detailedinv_posinvresult_id`, `detailedinv_id`, `posinvresult_id`) VALUES
(1664, 1, 1664),
(1663, 1, 1663),
(1662, 1, 1662),
(1661, 1, 1661),
(1660, 1, 1660),
(770, 2, 770),
(769, 2, 769),
(778, 4, 778),
(777, 4, 777),
(776, 4, 776),
(775, 4, 775),
(774, 4, 774),
(773, 4, 773),
(772, 4, 772),
(771, 4, 771),
(16, 6, 16),
(17, 6, 17),
(18, 7, 18),
(19, 7, 19),
(20, 7, 20),
(21, 7, 21),
(22, 7, 22),
(23, 7, 23),
(24, 7, 24),
(25, 7, 25),
(795, 345, 795),
(794, 344, 794),
(784, 8, 784),
(783, 8, 783),
(782, 8, 782),
(31, 10, 31),
(32, 10, 32),
(33, 11, 33),
(34, 11, 34),
(802, 20, 802),
(801, 20, 801),
(800, 20, 800),
(793, 344, 793),
(799, 20, 799),
(808, 21, 808),
(807, 21, 807),
(806, 21, 806),
(805, 21, 805),
(804, 21, 804),
(46, 22, 46),
(47, 22, 47),
(48, 22, 48),
(49, 22, 49),
(50, 22, 50),
(51, 23, 51),
(52, 23, 52),
(53, 23, 53),
(54, 23, 54),
(55, 23, 55),
(56, 24, 56),
(57, 24, 57),
(58, 24, 58),
(59, 24, 59),
(60, 24, 60),
(61, 25, 61),
(62, 25, 62),
(63, 25, 63),
(64, 25, 64),
(65, 25, 65),
(66, 26, 66),
(67, 26, 67),
(68, 26, 68),
(69, 26, 69),
(70, 26, 70),
(71, 27, 71),
(72, 27, 72),
(73, 27, 73),
(74, 27, 74),
(75, 27, 75),
(76, 29, 76),
(77, 29, 77),
(78, 30, 78),
(79, 30, 79),
(80, 31, 80),
(81, 31, 81),
(82, 32, 82),
(83, 32, 83),
(86, 34, 86),
(87, 34, 87),
(88, 35, 88),
(89, 35, 89),
(1690, 36, 1690),
(1689, 36, 1689),
(788, 37, 788),
(787, 37, 787),
(792, 39, 792),
(791, 39, 791),
(102, 45, 102),
(103, 45, 103),
(104, 45, 104),
(105, 45, 105),
(106, 45, 106),
(107, 45, 107),
(108, 46, 108),
(109, 46, 109),
(110, 46, 110),
(111, 46, 111),
(112, 46, 112),
(113, 46, 113),
(128, 93, 128),
(129, 93, 129),
(130, 93, 130),
(131, 94, 131),
(132, 94, 132),
(133, 94, 133),
(134, 94, 134),
(1066, 124, 1066),
(1059, 123, 1059),
(1058, 123, 1058),
(1057, 123, 1057),
(1056, 123, 1056),
(1065, 124, 1065),
(1064, 124, 1064),
(1063, 124, 1063),
(1062, 124, 1062),
(1061, 124, 1061),
(1060, 124, 1060),
(219, 126, 219),
(220, 126, 220),
(221, 126, 221),
(222, 126, 222),
(223, 126, 223),
(224, 126, 224),
(225, 127, 225),
(226, 127, 226),
(227, 127, 227),
(228, 127, 228),
(229, 127, 229),
(230, 127, 230),
(231, 127, 231),
(232, 128, 232),
(233, 128, 233),
(234, 128, 234),
(235, 128, 235),
(236, 128, 236),
(237, 128, 237),
(1071, 129, 1071),
(1070, 129, 1070),
(1069, 129, 1069),
(1068, 129, 1068),
(1067, 129, 1067),
(1077, 130, 1077),
(1076, 130, 1076),
(1075, 130, 1075),
(1074, 130, 1074),
(1073, 130, 1073),
(1088, 131, 1088),
(1087, 131, 1087),
(1086, 131, 1086),
(1085, 131, 1085),
(1084, 131, 1084),
(1094, 132, 1094),
(1093, 132, 1093),
(1092, 132, 1092),
(1091, 132, 1091),
(1090, 132, 1090),
(258, 133, 258),
(259, 133, 259),
(1099, 134, 1099),
(1098, 134, 1098),
(1097, 134, 1097),
(1096, 134, 1096),
(1105, 135, 1105),
(1104, 135, 1104),
(1103, 135, 1103),
(1102, 135, 1102),
(1101, 135, 1101),
(269, 140, 269),
(270, 140, 270),
(271, 140, 271),
(272, 140, 272),
(273, 140, 273),
(274, 141, 274),
(275, 141, 275),
(276, 141, 276),
(277, 141, 277),
(278, 141, 278),
(279, 142, 279),
(280, 142, 280),
(281, 142, 281),
(282, 142, 282),
(283, 142, 283),
(284, 143, 284),
(285, 143, 285),
(286, 143, 286),
(287, 143, 287),
(288, 143, 288),
(1158, 151, 1158),
(1157, 151, 1157),
(1156, 151, 1156),
(1155, 151, 1155),
(1154, 151, 1154),
(1153, 151, 1153),
(1190, 160, 1190),
(1189, 160, 1189),
(1188, 160, 1188),
(1187, 160, 1187),
(1186, 160, 1186),
(1185, 160, 1185),
(1196, 161, 1196),
(1195, 161, 1195),
(1194, 161, 1194),
(1193, 161, 1193),
(1192, 161, 1192),
(1191, 161, 1191),
(1201, 162, 1201),
(1200, 162, 1200),
(1199, 162, 1199),
(1198, 162, 1198),
(1197, 162, 1197),
(1208, 163, 1208),
(1207, 163, 1207),
(1206, 163, 1206),
(1205, 163, 1205),
(1204, 163, 1204),
(1203, 163, 1203),
(1213, 164, 1213),
(1212, 164, 1212),
(1211, 164, 1211),
(1210, 164, 1210),
(1209, 164, 1209),
(1220, 165, 1220),
(1219, 165, 1219),
(1218, 165, 1218),
(1217, 165, 1217),
(1216, 165, 1216),
(1215, 165, 1215),
(329, 167, 329),
(330, 167, 330),
(331, 167, 331),
(332, 167, 332),
(333, 167, 333),
(334, 167, 334),
(1232, 168, 1232),
(1231, 168, 1231),
(1230, 168, 1230),
(1229, 168, 1229),
(1228, 168, 1228),
(1227, 168, 1227),
(1238, 169, 1238),
(1237, 169, 1237),
(1236, 169, 1236),
(1235, 169, 1235),
(1234, 169, 1234),
(1233, 169, 1233),
(1244, 170, 1244),
(1243, 170, 1243),
(1242, 170, 1242),
(1241, 170, 1241),
(1240, 170, 1240),
(1239, 170, 1239),
(1250, 171, 1250),
(1249, 171, 1249),
(1248, 171, 1248),
(1247, 171, 1247),
(1246, 171, 1246),
(1245, 171, 1245),
(1256, 172, 1256),
(1255, 172, 1255),
(1254, 172, 1254),
(1253, 172, 1253),
(1252, 172, 1252),
(1251, 172, 1251),
(1262, 173, 1262),
(1261, 173, 1261),
(1260, 173, 1260),
(1259, 173, 1259),
(1258, 173, 1258),
(1257, 173, 1257),
(1496, 178, 1496),
(1495, 178, 1495),
(1494, 178, 1494),
(1493, 178, 1493),
(1492, 178, 1492),
(1491, 178, 1491),
(1502, 179, 1502),
(1501, 179, 1501),
(1500, 179, 1500),
(1499, 179, 1499),
(1498, 179, 1498),
(1497, 179, 1497),
(1514, 180, 1514),
(1513, 180, 1513),
(1512, 180, 1512),
(1511, 180, 1511),
(1510, 180, 1510),
(1509, 180, 1509),
(1490, 181, 1490),
(1489, 181, 1489),
(1488, 181, 1488),
(1487, 181, 1487),
(1486, 181, 1486),
(1485, 181, 1485),
(1520, 182, 1520),
(1519, 182, 1519),
(1518, 182, 1518),
(1517, 182, 1517),
(1516, 182, 1516),
(1515, 182, 1515),
(1526, 184, 1526),
(1525, 184, 1525),
(1524, 184, 1524),
(1523, 184, 1523),
(1522, 184, 1522),
(1521, 184, 1521),
(1532, 185, 1532),
(1531, 185, 1531),
(1530, 185, 1530),
(1529, 185, 1529),
(1528, 185, 1528),
(1527, 185, 1527),
(1538, 186, 1538),
(1537, 186, 1537),
(1536, 186, 1536),
(1535, 186, 1535),
(1534, 186, 1534),
(1533, 186, 1533),
(1544, 187, 1544),
(1543, 187, 1543),
(1542, 187, 1542),
(1541, 187, 1541),
(1540, 187, 1540),
(1539, 187, 1539),
(1550, 188, 1550),
(1549, 188, 1549),
(1548, 188, 1548),
(1547, 188, 1547),
(1546, 188, 1546),
(1545, 188, 1545),
(1556, 189, 1556),
(1555, 189, 1555),
(1554, 189, 1554),
(1553, 189, 1553),
(1552, 189, 1552),
(1551, 189, 1551),
(1562, 190, 1562),
(1561, 190, 1561),
(1560, 190, 1560),
(1559, 190, 1559),
(1558, 190, 1558),
(1557, 190, 1557),
(1268, 195, 1268),
(1267, 195, 1267),
(1266, 195, 1266),
(1265, 195, 1265),
(1264, 195, 1264),
(1263, 195, 1263),
(1274, 196, 1274),
(1273, 196, 1273),
(1272, 196, 1272),
(1271, 196, 1271),
(1270, 196, 1270),
(1269, 196, 1269),
(1280, 197, 1280),
(1279, 197, 1279),
(1278, 197, 1278),
(1277, 197, 1277),
(1276, 197, 1276),
(1275, 197, 1275),
(1286, 198, 1286),
(1285, 198, 1285),
(1284, 198, 1284),
(1283, 198, 1283),
(1282, 198, 1282),
(1281, 198, 1281),
(1292, 199, 1292),
(1291, 199, 1291),
(1290, 199, 1290),
(1289, 199, 1289),
(1288, 199, 1288),
(1287, 199, 1287),
(1304, 201, 1304),
(1303, 201, 1303),
(1302, 201, 1302),
(1301, 201, 1301),
(1300, 201, 1300),
(1299, 201, 1299),
(1310, 202, 1310),
(1309, 202, 1309),
(1308, 202, 1308),
(1307, 202, 1307),
(1306, 202, 1306),
(1305, 202, 1305),
(1322, 207, 1322),
(1321, 207, 1321),
(1320, 207, 1320),
(1319, 207, 1319),
(1318, 207, 1318),
(1317, 207, 1317),
(1328, 208, 1328),
(1327, 208, 1327),
(1326, 208, 1326),
(1325, 208, 1325),
(1324, 208, 1324),
(1323, 208, 1323),
(1334, 209, 1334),
(1333, 209, 1333),
(1332, 209, 1332),
(1331, 209, 1331),
(1330, 209, 1330),
(1329, 209, 1329),
(1316, 210, 1316),
(1315, 210, 1315),
(1314, 210, 1314),
(1313, 210, 1313),
(1312, 210, 1312),
(1311, 210, 1311),
(1345, 211, 1345),
(1344, 211, 1344),
(1343, 211, 1343),
(1342, 211, 1342),
(1341, 211, 1341),
(1352, 212, 1352),
(1351, 212, 1351),
(1350, 212, 1350),
(1349, 212, 1349),
(1348, 212, 1348),
(1347, 212, 1347),
(1574, 221, 1574),
(1573, 221, 1573),
(1572, 221, 1572),
(1571, 221, 1571),
(1570, 221, 1570),
(1569, 221, 1569),
(1568, 220, 1568),
(1567, 220, 1567),
(1566, 220, 1566),
(1565, 220, 1565),
(1564, 220, 1564),
(1563, 220, 1563),
(1340, 217, 1340),
(1339, 217, 1339),
(1338, 217, 1338),
(1337, 217, 1337),
(1336, 217, 1336),
(1335, 217, 1335),
(1580, 222, 1580),
(1579, 222, 1579),
(1578, 222, 1578),
(1577, 222, 1577),
(1576, 222, 1576),
(1575, 222, 1575),
(1586, 223, 1586),
(1585, 223, 1585),
(1584, 223, 1584),
(1583, 223, 1583),
(1582, 223, 1582),
(1581, 223, 1581),
(1592, 224, 1592),
(1591, 224, 1591),
(1590, 224, 1590),
(1589, 224, 1589),
(1588, 224, 1588),
(1587, 224, 1587),
(1598, 225, 1598),
(1597, 225, 1597),
(1596, 225, 1596),
(1595, 225, 1595),
(1594, 225, 1594),
(1593, 225, 1593),
(580, 230, 580),
(581, 230, 581),
(582, 230, 582),
(583, 230, 583),
(584, 230, 584),
(585, 230, 585),
(586, 231, 586),
(587, 231, 587),
(588, 231, 588),
(589, 231, 589),
(590, 231, 590),
(591, 231, 591),
(592, 232, 592),
(593, 232, 593),
(594, 232, 594),
(595, 232, 595),
(596, 232, 596),
(597, 232, 597),
(598, 233, 598),
(599, 233, 599),
(600, 233, 600),
(601, 233, 601),
(602, 233, 602),
(603, 233, 603),
(604, 234, 604),
(605, 234, 605),
(606, 234, 606),
(607, 234, 607),
(608, 234, 608),
(609, 234, 609),
(610, 235, 610),
(611, 235, 611),
(612, 235, 612),
(613, 235, 613),
(614, 235, 614),
(1358, 240, 1358),
(1357, 240, 1357),
(1356, 240, 1356),
(1355, 240, 1355),
(1354, 240, 1354),
(1353, 240, 1353),
(1364, 241, 1364),
(1363, 241, 1363),
(1362, 241, 1362),
(1361, 241, 1361),
(1360, 241, 1360),
(1359, 241, 1359),
(1370, 242, 1370),
(1369, 242, 1369),
(1368, 242, 1368),
(1367, 242, 1367),
(1366, 242, 1366),
(1365, 242, 1365),
(1376, 243, 1376),
(1375, 243, 1375),
(1374, 243, 1374),
(1373, 243, 1373),
(1372, 243, 1372),
(1371, 243, 1371),
(1382, 244, 1382),
(1381, 244, 1381),
(1380, 244, 1380),
(1379, 244, 1379),
(1378, 244, 1378),
(1377, 244, 1377),
(1387, 245, 1387),
(1386, 245, 1386),
(1385, 245, 1385),
(1384, 245, 1384),
(1383, 245, 1383),
(1442, 251, 1442),
(1441, 251, 1441),
(1440, 251, 1440),
(1439, 251, 1439),
(1438, 251, 1438),
(1437, 251, 1437),
(1448, 252, 1448),
(1447, 252, 1447),
(1446, 252, 1446),
(1445, 252, 1445),
(1444, 252, 1444),
(1443, 252, 1443),
(1454, 253, 1454),
(1453, 253, 1453),
(1452, 253, 1452),
(1451, 253, 1451),
(1450, 253, 1450),
(1449, 253, 1449),
(1460, 254, 1460),
(1459, 254, 1459),
(1458, 254, 1458),
(1457, 254, 1457),
(1456, 254, 1456),
(1455, 254, 1455),
(1466, 255, 1466),
(1465, 255, 1465),
(1464, 255, 1464),
(1463, 255, 1463),
(1462, 255, 1462),
(1461, 255, 1461),
(1472, 256, 1472),
(1471, 256, 1471),
(1470, 256, 1470),
(1469, 256, 1469),
(1468, 256, 1468),
(1467, 256, 1467),
(1478, 259, 1478),
(1477, 259, 1477),
(1476, 259, 1476),
(1475, 259, 1475),
(1474, 259, 1474),
(1473, 259, 1473),
(1394, 261, 1394),
(1393, 261, 1393),
(1392, 261, 1392),
(1391, 261, 1391),
(1390, 261, 1390),
(1389, 261, 1389),
(1406, 262, 1406),
(1405, 262, 1405),
(1404, 262, 1404),
(1403, 262, 1403),
(1402, 262, 1402),
(1401, 262, 1401),
(1412, 263, 1412),
(1411, 263, 1411),
(1410, 263, 1410),
(1409, 263, 1409),
(1408, 263, 1408),
(1407, 263, 1407),
(1418, 264, 1418),
(1417, 264, 1417),
(1416, 264, 1416),
(1415, 264, 1415),
(1414, 264, 1414),
(1413, 264, 1413),
(1424, 265, 1424),
(1423, 265, 1423),
(1422, 265, 1422),
(1421, 265, 1421),
(1420, 265, 1420),
(1419, 265, 1419),
(1430, 266, 1430),
(1429, 266, 1429),
(1428, 266, 1428),
(1427, 266, 1427),
(1426, 266, 1426),
(1425, 266, 1425),
(1436, 267, 1436),
(1435, 267, 1435),
(1434, 267, 1434),
(1433, 267, 1433),
(1432, 267, 1432),
(1431, 267, 1431),
(1400, 268, 1400),
(1399, 268, 1399),
(1398, 268, 1398),
(1397, 268, 1397),
(1396, 268, 1396),
(1395, 268, 1395),
(1686, 283, 1686),
(1685, 283, 1685),
(1687, 284, 1687),
(755, 286, 755),
(756, 286, 756),
(757, 286, 757),
(758, 342, 758),
(759, 342, 759),
(796, 345, 796),
(1667, 346, 1667),
(1666, 346, 1666),
(803, 20, 803),
(809, 405, 809),
(810, 405, 810),
(1696, 273, 1696),
(1695, 273, 1695),
(1694, 273, 1694),
(1693, 274, 1693),
(1692, 274, 1692),
(1691, 274, 1691),
(817, 406, 817),
(818, 406, 818),
(819, 406, 819),
(820, 406, 820),
(821, 407, 821),
(822, 407, 822),
(823, 407, 823),
(824, 407, 824),
(825, 408, 825),
(826, 408, 826),
(827, 408, 827),
(828, 408, 828),
(829, 409, 829),
(830, 409, 830),
(831, 409, 831),
(832, 409, 832),
(833, 410, 833),
(834, 410, 834),
(835, 410, 835),
(836, 410, 836),
(837, 411, 837),
(838, 411, 838),
(839, 411, 839),
(840, 411, 840),
(841, 412, 841),
(842, 412, 842),
(843, 355, 843),
(844, 355, 844),
(845, 355, 845),
(846, 355, 846),
(847, 356, 847),
(848, 356, 848),
(849, 356, 849),
(850, 356, 850),
(851, 356, 851),
(852, 356, 852),
(853, 356, 853),
(854, 358, 854),
(855, 358, 855),
(856, 358, 856),
(857, 358, 857),
(858, 358, 858),
(859, 358, 859),
(860, 359, 860),
(861, 359, 861),
(862, 359, 862),
(863, 359, 863),
(864, 359, 864),
(865, 359, 865),
(866, 359, 866),
(867, 360, 867),
(868, 360, 868),
(869, 360, 869),
(870, 360, 870),
(871, 360, 871),
(872, 360, 872),
(873, 361, 873),
(874, 361, 874),
(875, 361, 875),
(876, 361, 876),
(877, 361, 877),
(878, 361, 878),
(879, 362, 879),
(880, 362, 880),
(881, 362, 881),
(882, 362, 882),
(883, 362, 883),
(884, 362, 884),
(885, 363, 885),
(886, 363, 886),
(887, 363, 887),
(888, 363, 888),
(889, 363, 889),
(890, 363, 890),
(891, 364, 891),
(892, 364, 892),
(893, 364, 893),
(894, 364, 894),
(895, 364, 895),
(896, 364, 896),
(897, 365, 897),
(898, 365, 898),
(899, 366, 899),
(900, 366, 900),
(901, 366, 901),
(902, 366, 902),
(903, 366, 903),
(904, 366, 904),
(905, 367, 905),
(906, 367, 906),
(907, 367, 907),
(908, 367, 908),
(909, 367, 909),
(910, 367, 910),
(993, 369, 993),
(992, 369, 992),
(991, 369, 991),
(990, 369, 990),
(989, 369, 989),
(988, 369, 988),
(987, 369, 987),
(986, 369, 986),
(985, 369, 985),
(984, 369, 984),
(983, 369, 983),
(982, 369, 982),
(958, 370, 958),
(957, 370, 957),
(956, 370, 956),
(955, 370, 955),
(954, 370, 954),
(953, 370, 953),
(952, 370, 952),
(951, 370, 951),
(950, 370, 950),
(949, 370, 949),
(948, 370, 948),
(947, 370, 947),
(935, 371, 935),
(936, 371, 936),
(937, 371, 937),
(938, 371, 938),
(939, 371, 939),
(940, 371, 940),
(941, 371, 941),
(942, 371, 942),
(943, 371, 943),
(944, 371, 944),
(945, 371, 945),
(946, 371, 946),
(994, 372, 994),
(995, 372, 995),
(996, 372, 996),
(997, 372, 997),
(998, 372, 998),
(999, 373, 999),
(1000, 373, 1000),
(1001, 373, 1001),
(1002, 373, 1002),
(1003, 373, 1003),
(1004, 374, 1004),
(1005, 374, 1005),
(1006, 374, 1006),
(1007, 374, 1007),
(1008, 374, 1008),
(1009, 375, 1009),
(1010, 375, 1010),
(1011, 375, 1011),
(1012, 375, 1012),
(1013, 375, 1013),
(1688, 284, 1688),
(1684, 283, 1684),
(1024, 380, 1024),
(1025, 380, 1025),
(1026, 380, 1026),
(1027, 380, 1027),
(1028, 380, 1028),
(1029, 380, 1029),
(1713, 382, 1713),
(1712, 382, 1712),
(1711, 382, 1711),
(1710, 382, 1710),
(1717, 383, 1717),
(1716, 383, 1716),
(1715, 383, 1715),
(1714, 383, 1714),
(1072, 129, 1072),
(1078, 130, 1078),
(1089, 131, 1089),
(1095, 132, 1095),
(1100, 134, 1100),
(1106, 135, 1106),
(1107, 137, 1107),
(1108, 137, 1108),
(1109, 137, 1109),
(1110, 137, 1110),
(1111, 137, 1111),
(1112, 137, 1112),
(1113, 137, 1113),
(1114, 137, 1114),
(1115, 137, 1115),
(1116, 137, 1116),
(1117, 137, 1117),
(1118, 137, 1118),
(1119, 138, 1119),
(1120, 138, 1120),
(1121, 138, 1121),
(1122, 138, 1122),
(1123, 138, 1123),
(1124, 138, 1124),
(1125, 138, 1125),
(1126, 138, 1126),
(1127, 138, 1127),
(1128, 138, 1128),
(1129, 138, 1129),
(1130, 138, 1130),
(1131, 139, 1131),
(1132, 139, 1132),
(1133, 139, 1133),
(1134, 139, 1134),
(1135, 139, 1135),
(1136, 139, 1136),
(1137, 139, 1137),
(1138, 139, 1138),
(1139, 139, 1139),
(1140, 139, 1140),
(1141, 139, 1141),
(1142, 139, 1142),
(1721, 153, 1721),
(1720, 153, 1720),
(1719, 153, 1719),
(1718, 153, 1718),
(1171, 154, 1171),
(1172, 154, 1172),
(1173, 154, 1173),
(1174, 154, 1174),
(1175, 154, 1175),
(1176, 154, 1176),
(1177, 154, 1177),
(1178, 154, 1178),
(1179, 154, 1179),
(1180, 154, 1180),
(1181, 154, 1181),
(1182, 154, 1182),
(1202, 162, 1202),
(1214, 164, 1214),
(1221, 166, 1221),
(1222, 166, 1222),
(1223, 166, 1223),
(1224, 166, 1224),
(1225, 166, 1225),
(1226, 166, 1226),
(1346, 211, 1346),
(1388, 245, 1388),
(1479, 415, 1479),
(1480, 415, 1480),
(1481, 415, 1481),
(1482, 415, 1482),
(1483, 415, 1483),
(1484, 415, 1484),
(1599, 422, 1599),
(1600, 422, 1600),
(1601, 422, 1601),
(1602, 422, 1602),
(1603, 422, 1603),
(1604, 422, 1604),
(1605, 423, 1605),
(1606, 423, 1606),
(1607, 423, 1607),
(1608, 423, 1608),
(1609, 423, 1609),
(1610, 423, 1610),
(1611, 424, 1611),
(1612, 424, 1612),
(1613, 424, 1613),
(1614, 424, 1614),
(1615, 424, 1615),
(1616, 424, 1616),
(1617, 425, 1617),
(1618, 425, 1618),
(1619, 425, 1619),
(1620, 425, 1620),
(1621, 425, 1621),
(1622, 425, 1622),
(1623, 426, 1623),
(1624, 426, 1624),
(1625, 426, 1625),
(1626, 426, 1626),
(1627, 426, 1627),
(1628, 426, 1628),
(1629, 421, 1629),
(1630, 421, 1630),
(1631, 421, 1631),
(1632, 421, 1632),
(1633, 421, 1633),
(1634, 421, 1634),
(1665, 391, 1665),
(1668, 431, 1668),
(1669, 431, 1669),
(1670, 431, 1670),
(1671, 431, 1671),
(1672, 432, 1672),
(1673, 432, 1673),
(1674, 432, 1674),
(1675, 432, 1675),
(1676, 432, 1676),
(1677, 432, 1677);

-- --------------------------------------------------------

--
-- Table structure for table `detailed_transfer`
--

CREATE TABLE IF NOT EXISTS `detailed_transfer` (
  `detailed_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_batch` varchar(255) NOT NULL,
  `quantity_orderd` int(11) NOT NULL,
  `transfer_id` int(11) NOT NULL,
  PRIMARY KEY (`detailed_id`),
  KEY `item_batch` (`item_batch`),
  KEY `transfer_id` (`transfer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `detailed_transfer`
--


-- --------------------------------------------------------

--
-- Table structure for table `details_diagnosis`
--

CREATE TABLE IF NOT EXISTS `details_diagnosis` (
  `detailid` int(11) NOT NULL AUTO_INCREMENT,
  `diagnostic_group` varchar(10) NOT NULL,
  `gdrg` varchar(10) NOT NULL,
  `icd10` varchar(10) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`detailid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `details_diagnosis`
--

INSERT INTO `details_diagnosis` (`detailid`, `diagnostic_group`, `gdrg`, `icd10`, `description`) VALUES
(1, 'DENT', 'GDRG1', 'ICD1', 'Malaria'),
(2, 'MEDI', 'GDRG2', 'ICD2', 'Dysentry'),
(3, 'DENT', 'GDRG3', 'ICD3', 'Tooth Decay'),
(4, 'OBGY', 'GDRG4', 'ICD4', 'Normal Pregnancy');

-- --------------------------------------------------------

--
-- Table structure for table `diagnosis`
--

CREATE TABLE IF NOT EXISTS `diagnosis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `diagnosis_code` varchar(100) NOT NULL,
  `diagnosis` varchar(200) NOT NULL,
  `gdrg` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=910 ;

--
-- Dumping data for table `diagnosis`
--

INSERT INTO `diagnosis` (`id`, `diagnosis_code`, `diagnosis`, `gdrg`) VALUES
(1, 'O71.9', 'Other obstetric trauma ', NULL),
(2, 'O90.9', 'Other Complications of the puerperium', NULL),
(3, 'N85.9', 'Other disorders of the adnexae', NULL),
(4, 'O00.9', 'Ectopic pregnancy ', NULL),
(5, 'O08.9', 'Post abortion complications', NULL),
(6, 'D25.9', 'Leiomyoma of uterus ', NULL),
(7, 'D27', 'Benign neoplasm of ovary ', NULL),
(8, 'N72', 'Inflammatory disease of cervix uteri/vulva ', NULL),
(9, 'N80.9', 'Endometriosis ', NULL),
(10, 'D26.0', 'Benign lesions of the cervix', NULL),
(11, 'C57.9', 'Premalignant lesions of the vulva', NULL),
(12, 'O35.9', 'Other abnormal products of conception ', NULL),
(13, 'O06', 'Abortions', NULL),
(14, 'O02.0', 'Molar pregnancies', NULL),
(15, 'O72.1', 'Postpartum haemorrhage ', NULL),
(16, 'N73.9', 'Pelvic Inflammatory diseases', NULL),
(17, 'R10.2', 'Other causes of pelvic pain', NULL),
(18, 'N95.1', 'Menopausal disorders ', NULL),
(19, 'O26.9', 'Medical disorders in pregnancy', NULL),
(20, 'O20.0', 'Threatened Abortion', NULL),
(21, 'O21.0', 'Excessive vomiting in pregnancy ', NULL),
(22, 'O22.8', 'Venous complications in pregnancy ', NULL),
(23, 'O86.2', 'Genitourinary tract infection in pregnancy', NULL),
(24, 'O24.4', 'Diabetes in pregnancy ', NULL),
(25, 'O25', 'Malnutrition in pregnancy ', NULL),
(26, 'O30.9', 'Multiple gestation ', NULL),
(27, 'O74.9', 'Complications of anaesthesia during labour and delivery ', NULL),
(28, 'O85', 'Puerperal sepsis ', NULL),
(29, 'O88.5', 'Obstetric embolism ', NULL),
(30, 'O29.9', 'Complications of anaesthesia during the puerperium ', NULL),
(31, 'O92.7', 'Disorders of the breast and lactation associated with delivery', NULL),
(32, 'D26.9', 'Other benign neoplasms of uterus ', NULL),
(33, 'N75.9', 'Diseases of Bartholin|s gland ', NULL),
(34, 'N80.9', 'Endometriosis ', NULL),
(35, 'N75.9', 'Diseases of Bartholin|s gland ', NULL),
(36, 'N75.9', 'Diseases of Bartholin|s gland ', NULL),
(37, 'N89.9', 'Other disorders of the vagina', NULL),
(38, 'N90.9', 'Other disorders of the vulva', NULL),
(39, 'O71.9', 'Other obstetric trauma ', NULL),
(40, 'O90.9', 'Other Complications of the puerperium', NULL),
(41, 'O92.7', 'Disorders of the breast and lactation associated with delivery', NULL),
(42, 'N81.9', 'Female genital prolapse ', NULL),
(43, 'N81.1', 'Cystocele', NULL),
(44, 'N81.6', 'Rectocele', NULL),
(45, 'N80.9', 'Endometriosis ', NULL),
(46, 'N81.9', 'Female genital prolapse ', NULL),
(47, 'D25.9', 'Leiomyoma of uterus ', NULL),
(48, 'D26.9', 'Other benign neoplasms of uterus ', NULL),
(49, 'N81.5', 'Enterocele', NULL),
(50, 'N81.9', 'Female genital prolapse ', NULL),
(51, 'N81.9', 'Female genital prolapse ', NULL),
(52, 'N82.0', 'Vesico-vaginal Fistulae ', NULL),
(53, 'N82.3', 'Recto-vaginal Fistulae ', NULL),
(54, 'N80.9', 'Endometriosis ', NULL),
(55, 'N81.9', 'Female genital prolapse ', NULL),
(56, 'C53.9', 'Premalignant lesions of the cervix', NULL),
(57, 'D25.9', 'Leiomyoma of uterus ', NULL),
(58, 'D26.9', 'Other benign neoplasms of uterus ', NULL),
(59, 'C53.9', 'Malignant neoplasm of cervix uteri ', NULL),
(60, 'O71.5', '3rd & 4th degree Perineal laceration ', NULL),
(61, 'O71.9', 'Other obstetric trauma ', NULL),
(62, 'O72.1', 'Postpartum haemorrhage ', NULL),
(63, 'O90.9', 'Other Complications of the puerperium', NULL),
(64, 'O82.2', 'Vaginal hysterectomy', NULL),
(65, 'N81.6', 'Rectocele repair', NULL),
(66, 'N81.1', 'Cystocele repair', NULL),
(67, 'C53.6', 'Premalignant lesions of the cervix', NULL),
(68, 'N93.9', 'Abnormal uterine and vaginal bleeding ', NULL),
(69, 'C52', 'Premalignant lesions of the vagina.', NULL),
(70, 'D36.9', 'Polyps ', NULL),
(71, 'D36.9', 'Polyps ', NULL),
(72, 'N93.9', 'Abnormal uterine and vaginal bleeding ', NULL),
(73, 'C27.9', 'Premalignant lesions of the vulva', NULL),
(74, 'O24.9', 'Diabetes in pregnancy ', NULL),
(75, 'O26.9', 'Medical disorders in pregnancy', NULL),
(76, 'P20', 'Fetal stress, delayed 2nd stage', NULL),
(77, 'O26.9', 'Other disorders related to pregnancy ', NULL),
(78, 'P95', 'Intra Uterine Fetal Death', NULL),
(79, 'O26.9', 'Medical disorders in pregnancy', NULL),
(80, 'O24.9', 'Diabetes in pregnancy ', NULL),
(81, 'O30.9', 'Multiple gestation ', NULL),
(82, 'O32.9', 'Malpresentation of fetus ', NULL),
(83, 'O33.9', 'Disproportion ', NULL),
(84, 'O61.9', 'Failed induction of labour ', NULL),
(85, 'O62.9', 'Dysfunctional Labour', NULL),
(86, 'O66.9', 'Obstructed labour ', NULL),
(87, 'O67.9', 'Intrapartum haemorrhage', NULL),
(88, 'P20', 'Fetal stress', NULL),
(89, 'O80.9', 'Normal pregnancy', NULL),
(90, 'O75.6', 'Normal pregnancy with delayed 2nd stage', NULL),
(91, 'N88.3', 'Cervical incompetence ', NULL),
(92, 'D25.9', 'Leiomyoma of uterus ', NULL),
(93, 'D26.9', 'Other benign neoplasms of uterus ', NULL),
(94, 'O80.9', 'Delivery', NULL),
(95, 'O67.9', 'Genital tract bleeding after delivery', NULL),
(96, 'G04.0', 'Simple goitre', NULL),
(97, 'E05.0', 'Toxic Goitre', NULL),
(98, 'D44.0', 'Thyroid tumours', NULL),
(99, 'D35.1', 'Parathyroid adenoma', NULL),
(100, 'J98.4', 'Broncho-pulmonary lesions', NULL),
(101, 'J90', 'Pleural effusion', NULL),
(102, 'J93.9', 'Pneumothorax', NULL),
(103, 'J94.2', 'Haemopneumothorax', NULL),
(104, 'J90', 'Chronic Pleural effusion', NULL),
(105, 'J90', 'Recurent Pleural effusion', NULL),
(106, 'K44.9', 'Diaphragrmatic hernia', NULL),
(107, 'K22.5', 'Esophageal diverticulum', NULL),
(108, 'K22.2', 'Esophageal stenosis', NULL),
(109, 'K37.7', 'Esophageal tumour', NULL),
(110, 'K22.0', 'Achalasia', NULL),
(111, 'K22.3', 'Esophageal rupture', NULL),
(112, 'K44.9', 'Hiatus hernia', NULL),
(113, 'R22.1', 'Neck swellings excluding thyroid gland', NULL),
(114, 'Q89.2', 'Thyroglossal Cyst', NULL),
(115, 'D11.9', 'Salivary gland mass', NULL),
(116, 'D73.5', 'Splenic infarct', NULL),
(117, 'D73.3', 'Splenic abscess', NULL),
(118, 'S36.0', 'Traumatic spleen', NULL),
(119, 'D37.7', 'Splenic tumour', NULL),
(120, 'None', 'Nezer Diagnosis 1', NULL),
(121, 'D73.4', 'Splenic cyst', NULL),
(122, 'None', 'Nezer Diagnosis 1', NULL),
(123, 'None', 'Nezer Diagnosis 1', NULL),
(124, 'D41.0', 'Kidney tumour', NULL),
(125, 'D44.1', 'Adrenal tumour', NULL),
(126, 'D30.0', 'Kidney masses', NULL),
(127, 'K25.9', 'Gastric ulcer', NULL),
(128, 'D37.1', 'Gastric tumour', NULL),
(129, 'K31.7', 'Gastric polyp', NULL),
(130, 'K92.2', 'Upper gastrointestinal bleeding', NULL),
(131, 'K26.9', 'Duodenal ulcer', NULL),
(132, 'K31.1', 'Gastric outlet obstruction', NULL),
(133, 'K25.5', 'Perforation of gastric ulcer', NULL),
(134, 'K26.5', 'Perforation of duodenal ulcer', NULL),
(135, 'T14.0', 'Traumatic perforation', NULL),
(136, 'K35.0', 'Ruptured appendix', NULL),
(137, 'K65.9', 'Peritonitis', NULL),
(138, 'K63.9', 'Inflammatory bowel disease', NULL),
(139, 'K37.7', 'Appendicitis', NULL),
(140, 'I85.0', 'Bleeding Esophageal varices', NULL),
(141, 'I85.9', 'Oesophageal varices', NULL),
(142, 'K56.1', 'Intussusception', NULL),
(143, 'K56.6', 'Intestinal obstruction', NULL),
(144, 'D37.7', 'Intestinal tumour', NULL),
(145, 'I82.9', 'Venous thrombosis', NULL),
(146, 'K92.2', 'Intestinal bleeding', NULL),
(147, 'K63.9', 'Colon lesion ', NULL),
(148, 'K56.1', 'Intussusception', NULL),
(149, 'Q43.8', 'Volvulus', NULL),
(150, 'K62.3', 'Prolaps rectum', NULL),
(151, 'K92.2', 'Large Bowel haemorrhage', NULL),
(152, 'S36.5', 'Large bowel trauma', NULL),
(153, 'K63.9', 'Colonic lesion', NULL),
(154, 'K63.9', 'Small bowel lesion', NULL),
(155, 'D37.5', 'Rectal tumour', NULL),
(156, 'N13.3', 'Hydronephrosis or obstructed kidney', NULL),
(157, 'K60.3', 'Anal fistula', NULL),
(158, 'K61.0', 'Anal/Rectal abscess', NULL),
(159, 'K60.2', 'Anal fissure', NULL),
(160, 'D23.9', 'Pilonidal disease', NULL),
(161, 'I84.9', 'Haemorrhoids', NULL),
(162, 'K62.3', 'Prolapsed rectum', NULL),
(163, 'A06.4', 'Amoebic liver abscess/Pyogenic liver abscess', NULL),
(164, 'K80.2', 'Cholelithiasis', NULL),
(165, 'K81.0', 'Empyema of gallbladder', NULL),
(166, 'K83.1', 'Obstruction of bile duct', NULL),
(167, 'S36.1', 'Bile duct trauma', NULL),
(168, 'K83.1', 'obstuctive Jaundice', NULL),
(169, 'K86.3', 'Pancreatic pseudocyst', NULL),
(170, 'D37.7', 'Pancreatic tumour', NULL),
(171, 'K86.2', 'Pancreatic cyst', NULL),
(172, 'K46.9', 'Mesenteric hernia', NULL),
(173, 'K46.9', 'Omental hernia', NULL),
(174, 'K40.9', 'Inguinal hernia', NULL),
(175, 'K43.9', 'Spigelian hernia', NULL),
(176, 'K41.9', 'Femoral hernia', NULL),
(177, 'K42.9', 'Umbilical hernia', NULL),
(178, 'K43.9', 'Incisional hernia', NULL),
(179, 'K43.9', 'Epigastric hernia', NULL),
(180, 'N34.0', 'Urethral abscess', NULL),
(181, 'N36.0', 'Urethral fistula', NULL),
(182, 'N36.1', 'Urethral diverticulum', NULL),
(183, 'N40', 'Bening prostatic hypertrophy', NULL),
(184, 'N35.9', 'Urethral stricture', NULL),
(185, 'N43.3', 'Hydrocele', NULL),
(186, 'N44', 'Torsion of testis', NULL),
(187, 'I86.1', 'Varicocele', NULL),
(188, 'None', 'Nezer Diagnosis 1', NULL),
(189, 'C50.9', 'Malignant breast lesion', NULL),
(190, 'I73.9', 'Claudication', NULL),
(191, 'I74.9', 'Embolism', NULL),
(192, 'I71.9', 'Aorta aneurysm', NULL),
(193, 'I72.4', 'Femoral aneurysm', NULL),
(194, 'I83.9', 'Varicose veins', NULL),
(195, 'I83.0', 'Venous ulcer', NULL),
(196, 'E14.5', 'Diabetic foot', NULL),
(197, 'R02', 'Gangrene', NULL),
(198, 'T89.0', 'Elephantiasis', NULL),
(199, 'D48.7', 'Limb tumours', NULL),
(200, 'T14.9', 'Trauma', NULL),
(201, 'None', 'Nezer Diagnosis 1', NULL),
(202, 'N47', 'Phimosis', NULL),
(203, 'N47', 'Paraphimosis', NULL),
(204, 'K80.5', 'Calculus', NULL),
(205, 'B65.9', 'Schistosoma Granuloma', NULL),
(206, 'None', 'Nezer Diagnosis 1', NULL),
(207, 'N32.9', 'Bladder mass', NULL),
(208, 'T14.9', 'Trauma', NULL),
(209, 'S02.9', 'Fractured skull', NULL),
(210, 'I61.9', 'Intracranial haematoma ', NULL),
(211, 'D43.2', 'Excision biopsy of brain tumour', NULL),
(212, 'G06.0', 'Intracranial abscess', NULL),
(213, 'M67.4', 'Ganglion', NULL),
(214, 'L72.1', 'Sebaceous cyst', NULL),
(215, 'D23.9', 'Dermoid cyst', NULL),
(216, 'P22.9', 'Other soft tissue lumps', NULL),
(217, 'T14.1', 'Lacerations', NULL),
(218, 'N63', 'Benign breast lumps', NULL),
(219, 'N62', 'Gynaecomastia', NULL),
(220, 'Q89.2', 'Thyroglossal Cyst', NULL),
(221, 'L03.9', 'Cellulitis', NULL),
(222, 'M60.0', 'Pyomyositis', NULL),
(223, 'L02.9', 'Abscess', NULL),
(224, 'T79.3', 'Wound infection', NULL),
(225, 'N61', 'Breast abscess', NULL),
(226, 'L43.3', 'Colostomy and ileostomy', NULL),
(227, 'I85.9', 'Oesophageal varices', NULL),
(228, 'K76.6', 'Portal hypertension', NULL),
(229, 'K00.1', 'Supernumerary Teeth', NULL),
(230, 'K00.6', 'Retained Primary Teeth', NULL),
(231, 'K01.0', 'Embedded/Impaced Teeth (with symptoms)', NULL),
(232, 'K05.1', 'Gingivitis/Periodontal Diseases', NULL),
(233, 'K07.3', 'Anomalies of tooth position', NULL),
(234, 'K04.7', 'Periapical abscess', NULL),
(235, 'K01.0', '(a)   Embedded/Impacted Tooth ', NULL),
(236, 'K08.3', '(b)    Retained dental root', NULL),
(237, 'K02.9', 'Dental caries', NULL),
(238, 'K03.1', '(a)   Abrasion of Teeth', NULL),
(239, 'K02.9', '(b)   Dental caries', NULL),
(240, 'K03.1', '(a)   Abrasion of Teeth', NULL),
(241, 'K02.9', '(b)   Dental caries', NULL),
(242, 'K05.6', 'Periodontal Disease', NULL),
(243, 'K05.1', '(a)   Gingivitis', NULL),
(244, 'K06.1', '(b)   Gingival enlargement', NULL),
(245, 'K04.0', '(a)   Pulpitis', NULL),
(246, 'K04.7', '(b)   Periapical abscess', NULL),
(247, 'K04.8', '(c)   Radicular cyst', NULL),
(248, 'K04.8', '(a)   Radicular cyst', NULL),
(249, 'K04.7', '(a)   Periapical abscess', NULL),
(250, 'K05.6', '(b)   Periodontal abscess', NULL),
(251, 'l03.9', '(c)   Cellulitis', NULL),
(252, 'None', 'Nezer Diagnosis 1', NULL),
(253, 'K10.3', '(b)   Fibrous Dysplasia', NULL),
(254, 'K10.3', '(a)   Alveolitis', NULL),
(255, 'K10.3', '(b)   Dry Socket', NULL),
(256, 'K10.2', '(c)   Osteitis/osteomyelitis', NULL),
(257, 'K11.5', '(a)   Sialolithiasis', NULL),
(258, 'K11.2', '(a)   Sialoadenitis', NULL),
(259, 'K11.6', '(b)   Mucocoele', NULL),
(260, 'D11.9', '(c)   Tumor of Salivary glands', NULL),
(261, 'S03.2', '(a) Avulsion of teeth', NULL),
(262, 'S01.5', '(b) Laceration of lips', NULL),
(263, 'S01.5', '©  Laceration of tongue', NULL),
(264, 'S01.8', '(d) Laceration of face', NULL),
(265, 'S01.0', '(e) Laceration of scalp', NULL),
(266, 'T14.1', '(a)   Incision and Drainage of abscess', NULL),
(267, 'T14.1', '(b)   Lacerations of lips, face, scalp', NULL),
(268, 'Q38.1', 'Tongue tie', NULL),
(269, 'D48.0', 'Tumour of facial bones and soft tissues', NULL),
(270, 'D148.0', 'Advanced Tumour of facial bones and soft tissues', NULL),
(271, 'S02.9', 'Fracture of facial bones (no displacement)', NULL),
(272, 'S02.7', 'Fracture of facial bones (displacement)', NULL),
(273, 'None', 'Nezer Diagnosis 1', NULL),
(274, 'S03.0', 'Dislocation of Jaw/Tooth', NULL),
(275, 'None', 'Nezer Diagnosis 1', NULL),
(276, 'None', 'Nezer Diagnosis 1', NULL),
(277, 'Q18.1', 'Infected Preauricular cyst', NULL),
(278, 'Q18.1', 'Preauricular sinus', NULL),
(279, 'J33.9', 'Nasal polyposis', NULL),
(280, 'None', 'Nezer Diagnosis 1', NULL),
(281, 'C09.9', 'Neoplasm of tonsil', NULL),
(282, 'S09.9', 'Trauma to auricle,', NULL),
(283, 'S09.9', 'Trauma to ext canal,', NULL),
(284, 'H61.3', 'Acquired stenosis of ext canal', NULL),
(285, 'H66.3', 'Chronic suppurative', NULL),
(286, 'H66.3', 'Otitis media', NULL),
(287, 'None', 'Nezer Diagnosis 1', NULL),
(288, 'None', 'Nezer Diagnosis 1', NULL),
(289, 'H66.3', 'Chronic suppurative otitis media', NULL),
(290, 'H66.3', 'Chronic suppurative otitis media', NULL),
(291, 'H74.4', 'Polyp of middle ear', NULL),
(292, 'H80.9', 'Otosclerosis', NULL),
(293, 'H81.0', 'Menieres disease', NULL),
(294, 'Q17.3', 'Congenital malformation of ear', NULL),
(295, 'H70.9', 'Mastoiditis', NULL),
(296, 'H71', 'Cholesteatoma', NULL),
(297, 'H66.3', 'Chronic suppurative otitis media', NULL),
(298, 'H70.9', 'Infected mastoid cavity', NULL),
(299, 'J32.9', 'Chronic sinusitis', NULL),
(300, 'None', 'Nezer Diagnosis 1', NULL),
(301, 'J32.0', 'Maxillary sinusitis', NULL),
(302, 'J32.9', 'Chronic sinusitis', NULL),
(303, 'J32.0', 'Maxillary sinusitis', NULL),
(304, 'J32.9', 'Chronic sinusitis', NULL),
(305, 'J32.2', 'Ethmoid sinusitis', NULL),
(306, 'J32.9', 'Chronic sinusitis', NULL),
(307, 'G47.3', 'Obstructive sleep apnoea', NULL),
(308, 'J03.9', 'Recurrent tonsillitis', NULL),
(309, 'J35.0', 'Chronic tonsillitis', NULL),
(310, 'D37.0', 'Parotid tumour', NULL),
(311, 'K11.5', 'Sialolithiasis of submandibular gland', NULL),
(312, 'C07', 'Malignant mass of parotid', NULL),
(313, 'K11.1', 'Enlarged submandiblar gland ', NULL),
(314, 'C32.9', 'Malignant mass of larynx', NULL),
(315, 'D10.5', 'Oropharyngeal mass', NULL),
(316, 'D10.6', 'Nasopharyngeal mass', NULL),
(317, 'R22.1', 'Metastatic neck lump', NULL),
(318, 'D38.0', 'Laryngeal tumour', NULL),
(319, 'G52.2', 'Lesion in the larynx', NULL),
(320, 'T78.3', 'Reinkes| oedema', NULL),
(321, 'R49.0', 'Hoarsenes of voice', NULL),
(322, 'D37.0', 'Mass in the oropharynx', NULL),
(323, 'None', 'Nezer Diagnosis 1', NULL),
(324, 'Q38.7', 'Pharyngeal pouch', NULL),
(325, 'T16', 'Foreign body in the ear, nose, throat', NULL),
(326, 'K20', 'Septal abscess of ear, nose, throat', NULL),
(327, 'S02.2', 'Fractured Nasal bone', NULL),
(328, 'J34.2', 'Deviated nasal septum', NULL),
(329, 'J34.8', 'Nasal obstruction', NULL),
(330, 'M95.0', 'Deformed external nose', NULL),
(331, 'J34.8', 'Nasal obstruction due to turbinate hypertrophy', NULL),
(332, 'Q30.0', 'Choanal atresia', NULL),
(333, 'N94.8', 'Life threatening epistaxis', NULL),
(334, 'S09.9', 'Traumatic injury to pharynx', NULL),
(335, 'S01.3', 'Lacerated ear', NULL),
(336, 'Q89.2', 'Throglossal  cyst ', NULL),
(337, 'R22.1', 'Neck lumps', NULL),
(338, 'L72.1', 'Sebcious cysts', NULL),
(339, 'H93.3', 'Lesion external ear', NULL),
(340, 'None', 'Nezer Diagnosis 1', NULL),
(341, 'R04.0', 'Epistaxis', NULL),
(342, 'R42', 'Recurrent vertigo', NULL),
(343, 'H91.9', 'Paediatric hearing loss', NULL),
(344, 'J32.9', 'Chronic sinusitis', NULL),
(345, 'J34.8', 'Diseases of nose and paranasal sinuses', NULL),
(346, 'Q38.7', 'Phayrngeal pouch', NULL),
(347, 'J38.7', 'Diseases of larynx', NULL),
(348, 'J39.2', 'Diseases of pharynx', NULL),
(349, 'J32.9', 'Rhinosinusitis', NULL),
(350, 'E00.9', 'Congenital Hypothyroidism', NULL),
(351, 'E03.9', 'Acquired Hypothyroidism', NULL),
(352, 'E05.9', 'Hyperthyroidism', NULL),
(353, 'E61.8', 'Iodine Deficiency Disorder', NULL),
(354, 'E04.9', 'Goitre', NULL),
(355, 'E14', 'Newly diagnosed diabetes', NULL),
(356, 'E10', 'Uncontrolled blood glucose', NULL),
(357, 'E14.0', 'Diabetes with complications', NULL),
(358, 'E14.1', 'Diabetes ketoacidosis', NULL),
(359, 'E87.0', 'Hyper Osmolar nonketotic hyperglycaemia', NULL),
(360, 'E23.2', 'Diabetic insipidus', NULL),
(361, 'E21.3', 'Hyperparathyroidism', NULL),
(362, 'E27.4', 'Adrenocortical insufficiency', NULL),
(363, 'E25.0', 'Congenital Adrenal hyperplasia', NULL),
(364, 'E43', 'Protein Calorie Malnutrition', NULL),
(365, 'E55.9', 'Vitamin D deficiency', NULL),
(366, 'D50.9', 'Iron deficiency', NULL),
(367, 'D51.9', 'Other deficiencies: Vit B12, folate', NULL),
(368, 'D58.9', 'Haemolytic Anaemia', NULL),
(369, 'Q24.9', 'Acyanotic Congenital Heart Disease', NULL),
(370, 'Q24.9', 'Cyanotic Congenital Health Disease', NULL),
(371, 'I00', 'Acute Rheumatic fever', NULL),
(372, 'I38', 'Valvular heart disease', NULL),
(373, 'I42.9', 'Cardiomyopathy', NULL),
(374, 'I31.3', 'Pericardial effusion', NULL),
(375, 'I50.9', 'Cardiac failure', NULL),
(376, 'I51.4', 'Myocarditis', NULL),
(377, 'I31.9', 'Pericarditis', NULL),
(378, 'J68.0', 'Chemical Pneumonitis', NULL),
(379, 'T54.3', 'Casutic soda ingestion', NULL),
(380, 'T52.0', 'Kerosene ingestion', NULL),
(381, 'T50.9', 'Drug poisoning', NULL),
(382, 'E14.0', 'Diabetic Coma', NULL),
(383, 'G03.9', 'Meningitis/Encephalitis with Coma', NULL),
(384, 'E15', 'Drug Coma', NULL),
(385, 'R40.2', 'Alcoholic Coma', NULL),
(386, 'I64', 'Cerebrovascular accident with coma', NULL),
(387, 'E14.0', 'Hypoglycaemic coma', NULL),
(388, 'D57', 'Encephalopathy', NULL),
(389, 'K72.9', 'Hepatic coma', NULL),
(390, 'N19', 'Uraemic coma', NULL),
(391, 'G61.0', 'Gullain Barre Syndrome', NULL),
(392, 'G37.3', 'Transverse myelitis', NULL),
(393, 'G82.2', 'Paraplegia', NULL),
(394, 'G82.5', 'Tetraplegia', NULL),
(395, 'G41.9', 'Uncontrolled/Status epilepticus', NULL),
(396, 'R56.8', 'Other causes of convulsions', NULL),
(397, 'G41.9', 'TRANSIENT ISCHAEMIC ATTACK (TIA)', NULL),
(398, 'R55', 'Syncope', NULL),
(399, 'R40.2', 'Other causes of loss of Consciousness', NULL),
(400, 'R55', 'Collapse', NULL),
(401, 'I64', 'Cerebrovascular accident (CVA)', NULL),
(402, 'G80.9', 'CEREBRAL PALSY', NULL),
(403, 'D61.9', 'Bone marrow hypoplasia', NULL),
(404, 'D57.1', 'Haemoglobinopathy with crisis', NULL),
(405, 'D65', 'Disseminated Intravascular coagulopathy (DIC)', NULL),
(406, 'P53', 'Haemorrhagic disease of the new born', NULL),
(407, 'D66', 'Haemophilia', NULL),
(408, 'D68.9', 'Other Clotting disorders', NULL),
(409, 'L30.9', 'Severe Eczema', NULL),
(410, 'L51.1', 'Steven-Johnson syndrome', NULL),
(411, 'L23.9', 'Other allergic skin conditions', NULL),
(412, 'T30.0', 'Burns', NULL),
(413, 'N00', 'Acute Nephritic syndrome', NULL),
(414, 'N04', 'Nephrotic syndrome', NULL),
(415, 'N17.9', 'Acute renal failure', NULL),
(416, 'N18.9', 'Acute-on-chronic renal failure', NULL),
(417, 'N17.9', 'Acute renal failure', NULL),
(418, 'N17.9', 'Acute renal failure complicating any condition', NULL),
(419, 'I45.9', 'Asthma', NULL),
(420, 'I21.9', 'Bronchiolitis', NULL),
(421, 'J44.9', 'Chronic obstructive airway disease', NULL),
(422, 'A09', 'Gastroenteritis/Dysentry', NULL),
(423, 'T62.9', 'Food poisoning', NULL),
(424, 'K73.9', 'Chronic Hepatitis', NULL),
(425, 'C22.0', 'Hepatoma', NULL),
(426, 'K74.9', 'Cirrhosis', NULL),
(427, 'K92.2', 'All cause of GI bleeding - upper GI', NULL),
(428, 'K92.2', 'Intestinal bleeding', NULL),
(429, 'K92.2', 'Large bowel bleeding', NULL),
(430, 'K27.9', 'Peptic Ulcer', NULL),
(431, 'R10.4', 'Abdominal pain', NULL),
(432, 'R57.0', 'Cardiogenic Shock', NULL),
(433, 'R58', 'Haemorrhagic shock', NULL),
(434, 'I33.0', 'Acute Infective endocarditis', NULL),
(435, 'N12', 'Pyelonephritis', NULL),
(436, 'G04.9', 'Encephalitis', NULL),
(437, 'J18.9', 'Severe pneumonia', NULL),
(438, 'J47', 'Bronchiectasis', NULL),
(439, 'G03.9', 'Meningitis', NULL),
(440, 'M86.1', 'Acute Osteomyelitis', NULL),
(441, 'M00.9', 'Acute Septic Arthritis', NULL),
(442, 'L03.9', 'Cellulitis', NULL),
(443, 'N39.0', 'Urinary Tract Infection', NULL),
(444, 'J40', 'Bronchitis', NULL),
(445, 'J32.9', 'Sinusitis', NULL),
(446, 'H66.9', 'Acute Otitis media', NULL),
(447, 'J02.9', 'Pharyngitis', NULL),
(448, 'J18.9', 'Mild-Moderate Pneumonia', NULL),
(449, 'J98.8', 'Chest Infection', NULL),
(450, 'L01.0', 'Impetigo', NULL),
(451, 'P38', 'Cord sepsis', NULL),
(452, 'I10', 'Hypertension Urgency', NULL),
(453, 'I10', 'Malignant hypertension', NULL),
(454, 'I20.9', 'Angina', NULL),
(455, 'I21.9', 'Myocardial infarction', NULL),
(456, 'I20.0', 'Unstable Angina', NULL),
(457, 'I26.9', 'Pulmonary embolism', NULL),
(458, 'I82.9', 'Venous thrombosis', NULL),
(459, 'L98.4', 'Chronic Skin Ulcer', NULL),
(460, 'T63.0', 'Snake bite', NULL),
(461, 'W54', 'Dog bite', NULL),
(462, 'W53', 'Rat bite', NULL),
(463, 'None', 'Nezer Diagnosis 1', NULL),
(464, 'H05.2', 'Disorganised eye', NULL),
(465, 'H57.1', 'Painful blind eye', NULL),
(466, 'H44.0', 'Endophthalmitis  ', NULL),
(467, 'S05.3', 'Ruptured globe ', NULL),
(468, 'H15.8', 'Staphyloma', NULL),
(469, 'None', 'Nezer Diagnosis 1', NULL),
(470, 'T15.0', 'Superficial Corneal foreign body', NULL),
(471, 'None', 'Nezer Diagnosis 1', NULL),
(472, 'T15.0', 'Deep corneal foreign body', NULL),
(473, 'H44.7', 'Intra ocular foreign body', NULL),
(474, 'S05.4', 'Intraorbital foreign body', NULL),
(475, 'S01.1', 'Eye lid laceration', NULL),
(476, 'None', 'Nezer Diagnosis 1', NULL),
(477, 'H16.2', 'Keratoconjunctivitis', NULL),
(478, 'H02.1', 'Ectropion', NULL),
(479, 'H02.0', 'Entropion', NULL),
(480, 'Q10.0', 'Congenital blepharoptosis', NULL),
(481, 'H11.0', 'Pterygium ', NULL),
(482, 'None', 'Nezer Diagnosis 1', NULL),
(483, 'S05.3', 'Corneal and scleral lacerations', NULL),
(484, 'H21.0', 'Hyphaema ', NULL),
(485, 'H40.9', 'All types of glaucoma', NULL),
(486, 'H26.9', 'All types of cataract', NULL),
(487, 'H50.9', 'All strabismus', NULL),
(488, 'H00.0', 'Chalazion ', NULL),
(489, 'H16.2', 'Keratoconjunctivitis', NULL),
(490, 'H02.1', 'Ectropion', NULL),
(491, 'H02.0', 'Entropion', NULL),
(492, 'Q10.0', 'Congenital blepharoptosis', NULL),
(493, 'H04.5', 'Nasolacrimal drainage blockage', NULL),
(494, 'H05.0', 'Orbital abscess', NULL),
(495, 'H00.0', 'Eyelid abscess', NULL),
(496, 'None', 'Nezer Diagnosis 1', NULL),
(497, 'None', 'Nezer Diagnosis 1', NULL),
(498, 'None', 'Nezer Diagnosis 1', NULL),
(499, 'M65.9', 'Synovitis', NULL),
(500, 'M00.9', 'Pyoarthrosis', NULL),
(501, 'M11.9', 'Crystal arthropathy', NULL),
(502, 'M19.9', 'Osteo-arthrosis', NULL),
(503, 'M13.9', 'Inflammed Arthropathy', NULL),
(504, 'M12.5', 'Traumatic Arthropathy', NULL),
(505, 'M65.9', 'Tenovaginitis', NULL),
(506, 'M00.9', 'Pyo-arthrosis', NULL),
(507, 'M12.9', 'Traumatic arthropathy', NULL),
(508, 'M13.9', 'Inflammatory arthropathy', NULL),
(509, 'M19.9', 'Osteo-arthrosis', NULL),
(510, 'M23.9', 'Internal derangement of knee', NULL),
(511, 'M19.9', 'Osteo-arthrosis', NULL),
(512, 'M01.1', 'TB arthropathy', NULL),
(513, 'M06.9', 'Rheumatoid arthritis', NULL),
(514, 'M20.4', 'Hammertoes', NULL),
(515, 'None', 'Nezer Diagnosis 1', NULL),
(516, 'M84.1', 'Non-union of fractures', NULL),
(517, 'M95.9', 'Congenital deformity of long bone', NULL),
(518, 'M95.9', 'Acquired deformity of long bone', NULL),
(519, 'Q68.8', 'Congenital deformity of joint', NULL),
(520, '', 'Sickle cell osteopathy', NULL),
(521, 'M19.9', 'Osteoarthrosis', NULL),
(522, 'S72.0', 'Intra capsular fracture neck of femur', NULL),
(523, 'T14.1', 'Lacerations', NULL),
(524, 'L08.9', 'Hand infections', NULL),
(525, 'T14.1', 'Open fractures', NULL),
(526, 'T14.3', 'Open dislocations', NULL),
(527, 'M06.9', 'Rheumatoid arthritis', NULL),
(528, 'M65.9', 'Synovitis', NULL),
(529, 'M24.5', 'Contracture of joints eg. Hammertoes', NULL),
(530, 'M62.4', 'Contracture of muscle', NULL),
(531, 'M24.5', 'Contracture of tendons eg. Club foot', NULL),
(532, 'M65.3', 'Trigger digits', NULL),
(533, 'M06.9', 'Rheumatoid arthritis', NULL),
(534, 'G57.5', 'Tunnel syndromes', NULL),
(535, 'T14.1', 'Tendon rupture (Truamatic or inflammatory)', NULL),
(536, 'T79.6', 'Compartment syndrome', NULL),
(537, 'T14.1', 'Open fractures', NULL),
(538, 'T14.0', 'Closed fractures', NULL),
(539, 'T30.0', 'Burns', NULL),
(540, 'L08.9', 'Hand infections', NULL),
(541, 'T14.9', 'Crush injury', NULL),
(542, 'M86.6', 'Chronic osteomyelitis', NULL),
(543, 'M86.6', 'Brodies abscess', NULL),
(544, 'A18.0', 'Tuberculous osteitis/TB arthirtis', NULL),
(545, 'B99', 'Infected implant', NULL),
(546, 'M86.1', 'Acute osteomyelitis', NULL),
(547, 'R02', 'Gangrenous limb', NULL),
(548, 'C41.9', 'Malignancy of limb - osteosarcoma', NULL),
(549, 'R02', 'Gas gangrene of limb', NULL),
(550, 'C49.2', 'Liposarcoma of limb', NULL),
(551, 'Q74.9', 'Congenital anomaly of limb', NULL),
(552, 'T14.9', 'Crushed limb', NULL),
(553, 'T14.3', 'Sprains of muscle', NULL),
(554, 'T14.0', 'Contusions', NULL),
(555, 'T14.3', 'Strains of muscle, ligaments and tendons', NULL),
(556, 'T14.0', 'Abrasions ', NULL),
(557, 'T14.1', 'Wounds, skin burns', NULL),
(558, 'T14.1', 'Minor lacerations', NULL),
(559, 'S60.9', 'Traumatic, nail injuries', NULL),
(560, 'L60.0', 'Ingrowing toe nails', NULL),
(561, 'L03.0', 'Infected nails (paronychia)', NULL),
(562, 'S73.0', 'Dislocations of hip', NULL),
(563, 'S72.9', 'Fractures of femur', NULL),
(564, 'Q68.8', 'Congenital dislocations', NULL),
(565, 'T14.2', 'Closed fractures', NULL),
(566, 'T02.9', 'Multiple fractures', NULL),
(567, 'T14.2', 'Open fractures', NULL),
(568, 'S32.7', 'Pelvic fractures', NULL),
(569, 'M21.7', 'Leg length inequality', NULL),
(570, 'M80.8', 'Pathological fractures due to infection', NULL),
(571, 'S72.9', 'Shaft femur', NULL),
(572, 'S42.4', 'Supracondylar humeral fractures', NULL),
(573, 'S73.0', 'Hip (+ Steinman pin)', NULL),
(574, 'S62.6', 'Digital fractures', NULL),
(575, 'C41.9', 'Segmental bone loss (trauma, infection, tumour of bone)', NULL),
(576, 'S42.3', 'Humeral fracture', NULL),
(577, 'M93.9', 'Slipped epiphysis', NULL),
(578, 'M67.4', 'Ganglion', NULL),
(579, 'D36.1', 'Neuroma', NULL),
(580, 'R22.9', 'Nodules', NULL),
(581, 'T14.2', 'Fractures', NULL),
(582, 'None', 'Nezer Diagnosis 1', NULL),
(583, 'S52.2', 'Shaft Fractures', NULL),
(584, 'M84.1', 'Non-union diaphyseal fracture', NULL),
(585, 'M84.4', 'Pathological diaphyseal fracture', NULL),
(586, 'S02.8', 'Fracture patella', NULL),
(587, 'S52.0', 'Fracture olecranoni', NULL),
(588, 'T14.2', 'Closed fractures', NULL),
(589, 'T14.3', 'Joint dislocation', NULL),
(590, 'T14.2', 'Fracture - dislocation of joint', NULL),
(591, 'L02.9', '1. Soft tissue abscess', NULL),
(592, 'M60.0', '2. Pyomyositis', NULL),
(593, 'T14.0', '3. Haematoma', NULL),
(594, 'D16.9', '1. Osteoma ', NULL),
(595, 'D16.9', '2. Osteochondroma', NULL),
(596, 'M61.5', '3. Myositis Ossificans', NULL),
(597, 'P13.9', '4. Post skeletal trauma', NULL),
(598, 'D16.9', '5. Bone tumour', NULL),
(599, 'S43.0', '1. Dislocated joints (shoulder, elbow, wrist,', NULL),
(600, 'None', 'Nezer Diagnosis 1', NULL),
(601, 'S73.0', '2. Dislocated hip, knee, ankle and inter-tarsal joints', NULL),
(602, 'None', 'Nezer Diagnosis 1', NULL),
(603, 'S42.3', '    Humerus, (DCP)', NULL),
(604, 'S52.8', 'Radius (DCP)', NULL),
(605, 'S52.2', 'Ultra (DCP)', NULL),
(606, 'S72.0', 'Hip', NULL),
(607, 'S72.9', '    Femur - DCP, K - nail', NULL),
(608, 'S82.1', 'Condyles - screws', NULL),
(609, 'S82.2', 'Tibia - DCP', NULL),
(610, 'None', 'Nezer Diagnosis 1', NULL),
(611, 'M84.0', '4. Malunion', NULL),
(612, 'E03.1', 'Congenital Hypothyroidism', NULL),
(613, 'E03.9', 'Acquired Hypothyroidism', NULL),
(614, 'E05.9', 'Hyperthyroidism', NULL),
(615, 'E61.8', 'Iodine Deficiency Disorder', NULL),
(616, 'E04.9', 'Goitre', NULL),
(617, 'E14', 'Newly diagnosed diabetes', NULL),
(618, 'E10', 'Uncontrolled blood glucose', NULL),
(619, 'E14.0', 'Diabetes with complications', NULL),
(620, 'E14.1', 'Diabetes ketoacidosis', NULL),
(621, 'E87.0', 'Hyper Osmolar nonketotic hyperglycaemia', NULL),
(622, 'E23.2', 'Diabetic insipidus', NULL),
(623, 'E21.3', 'Hyperparathyroidism', NULL),
(624, 'E27.4', 'Adrenocortical insufficiency', NULL),
(625, 'E25.0', 'Congenital Adrenal hyperplasia', NULL),
(626, 'E43', 'Protein Calorie Malnutrition', NULL),
(627, 'E54', 'Ascorbic acid deficiency (Scurvy)', NULL),
(628, 'E55.9', 'Vitamin D deficiency', NULL),
(629, 'D50.9', 'Iron deficiency', NULL),
(630, 'D51.9', 'Other deficiencies: Vit B12, folate', NULL),
(631, 'D58.9', 'Haemolytic Anaemia', NULL),
(632, 'E88.9', 'Metabolic diseases', NULL),
(633, 'E70.1', '- Phenylketonuria (PKU)', NULL),
(634, 'E74.2', '- Galactosaemia', NULL),
(635, 'P58.9', 'Severe haemolytic Neonatal Jaundice/Kernicterus', NULL),
(636, 'P59.9', 'Mild-moderate haemolytic neonatal jaundice', NULL),
(637, 'P59.9', 'Neonatal jaundice of other and non-specific cause', NULL),
(638, 'P07.0', 'Extreme Low Weight', NULL),
(639, 'P07.2', 'Extreme immaturity', NULL),
(640, 'P07.3', 'Other Preterm infants', NULL),
(641, 'P08.0', 'EXTREMELY LARGE BABY', NULL),
(642, 'P08.2', 'POST-TERM BABY', NULL),
(643, 'None', 'Nezer Diagnosis 1', NULL),
(644, 'None', 'Nezer Diagnosis 1', NULL),
(645, 'P15.9', 'Abdominal injury due to birth trauma', NULL),
(646, 'None', 'Nezer Diagnosis 1', NULL),
(647, 'P13.9', 'Bone fractures', NULL),
(648, 'P10.9', 'INTRACRANIAL HAEMORRHAGE', NULL),
(649, 'None', 'Nezer Diagnosis 1', NULL),
(650, 'P22.0', 'Respiratory Distress syndrome', NULL),
(651, 'G03.9', 'Meningitis', NULL),
(652, 'A33', 'Neonatal tetanus', NULL),
(653, 'J18.9', 'Severe pneumonia', NULL),
(654, 'Q24.9', 'Acyanotic Congenital Heart Disease', NULL),
(655, 'Q24.9', 'Cyanotic Congenital Health Disease', NULL),
(656, 'I00', 'Acute Rheumatic fever', NULL),
(657, 'I38', 'Valvular heart disease', NULL),
(658, 'I42.9', 'Cardiomyopathy', NULL),
(659, 'I31.3', 'Pericardial effusion', NULL),
(660, 'I50.9', 'Cardiac failure', NULL),
(661, 'I51.4', 'Myocarditis', NULL),
(662, 'I31.9', 'Pericarditis', NULL),
(663, 'J68.0', 'Chemical Pneumonitis', NULL),
(664, 'T54.3', 'Casutic soda ingestion', NULL),
(665, 'T52.0', 'Kerosene ingestion', NULL),
(666, 'T50.9', 'Drug poisoning', NULL),
(667, 'B50.0', 'Cerebral Malaria', NULL),
(668, 'E14.0', 'Diabetic Coma', NULL),
(669, 'G03.9', 'Meningitis/Encephalitis with Coma', NULL),
(670, 'E15', 'Drug Coma', NULL),
(671, 'B40.2', 'Alcoholic Coma', NULL),
(672, 'I64', 'Cerebrovascular accident with coma', NULL),
(673, 'A17.0', 'TB Meningitis', NULL),
(674, 'E14.0', 'Hypoglycaemic coma', NULL),
(675, 'G93.4', 'Encephalopathy', NULL),
(676, 'K72.9', 'Hepatic coma', NULL),
(677, 'N19', 'Uraemic coma', NULL),
(678, 'G61.0', 'Gullain Barre Syndrome', NULL),
(679, 'G37.3', 'Transverse myelitis', NULL),
(680, 'A80.9', 'Polio', NULL),
(681, 'G82.2', 'Paraplegia', NULL),
(682, 'G82.5', 'Tetraplegia', NULL),
(683, 'G41.9', 'Uncontrolled/Status epilepticus', NULL),
(684, 'R56.8', 'Other causes of convulsions', NULL),
(685, 'G41.9', 'TRANSIENT ISCHAEMIC ATTACK (TIA)', NULL),
(686, 'R55', 'Syncope', NULL),
(687, 'R40.2', 'Other causes of loss of Consciousness', NULL),
(688, 'R55', 'Collapse', NULL),
(689, 'I64', 'Cerebrovascular accident (CVA)', NULL),
(690, 'G80.9', 'CEREBRAL PALSY', NULL),
(691, 'D61.9', 'Bone marrow hypoplasia', NULL),
(692, 'D57.1', 'Haemoglobinopathy with crisis', NULL),
(693, 'D65', 'Disseminated Intravascular coagulopathy (DIC)', NULL),
(694, 'P53', 'Haemorrhagic disease of the new born', NULL),
(695, 'D66', 'Haemophilia', NULL),
(696, 'D68.9', 'Other Clotting disorders', NULL),
(697, 'L30.9', 'Severe Eczema', NULL),
(698, 'L51.1', 'Steven-Johnson syndrome', NULL),
(699, 'L23.9', 'Other allergic skin conditions', NULL),
(700, 'T30.0', 'Burns', NULL),
(701, 'N00', 'Acute Nephritic syndrome', NULL),
(702, 'N04', 'Nephrotic syndrome', NULL),
(703, 'N17.9', 'Acute renal failure', NULL),
(704, 'N18.9', 'Acute-on-chronic renal failure', NULL),
(705, 'N17.9', 'Acute renal failure', NULL),
(706, 'N17.9', 'Acute renal failure complicating any condition', NULL),
(707, 'I45.9', 'Asthma', NULL),
(708, 'I21.9', 'Bronchiolitis', NULL),
(709, 'J44.9', 'Chronic obstructive airway disease', NULL),
(710, 'A09', 'Gastroenteritis', NULL),
(711, 'T62.9', 'Food poisoning', NULL),
(712, 'A09', 'Dysentry', NULL),
(713, 'A00.9', 'Cholera', NULL),
(714, 'A03.9', 'Shigelosis', NULL),
(715, 'A04.7', 'Necrotising enterocolitis', NULL),
(716, 'B19.9', 'Acute viral hepatitis', NULL),
(717, 'K73.9', 'Chronic Hepatitis', NULL),
(718, 'C22.0', 'Hepatoma', NULL),
(719, 'K74.9', 'Cirrhosis', NULL),
(720, 'K92.2', 'All cause of GI bleeding - upper GI', NULL),
(721, 'K92.2', 'Intestinal bleeding', NULL),
(722, 'K92.2', 'Large bowel bleeding', NULL),
(723, 'K27.9', 'Peptic Ulcer', NULL),
(724, 'B83.9', 'Helminthiasis', NULL),
(725, 'B89', 'Parasitic diseases', NULL),
(726, 'R10.4', 'Abdominal pain', NULL),
(727, 'R57.0', 'Cardiogenic Shock', NULL),
(728, 'A41.9', 'Septicaemic Shock', NULL),
(729, 'R58', 'Haemorrhagic shock', NULL),
(730, 'B54', 'Uncomplicated Malaria', NULL),
(731, 'B50.9', 'Drug Resistant Malaria / Complicated Malaria / Severe Malaria', NULL),
(732, 'B50.8', 'Black water Fever', NULL),
(733, 'I33.0', 'Acute Infective endocarditis', NULL),
(734, 'A41.9', 'Septicaemia', NULL),
(735, 'N12', 'Pyelonephritis', NULL),
(736, 'A01.0', 'Enteric Fever/Typhoid fever/Typhoid Peforation', NULL),
(737, 'G04.9', 'Encephalitis', NULL),
(738, 'J18.9', 'Severe pneumonia', NULL),
(739, 'J47', 'Bronchiectasis', NULL),
(740, 'G03.9', 'Meningitis', NULL),
(741, 'M86.1', 'Acute Osteomyelitis', NULL),
(742, 'M00.9', 'Acute Septic Arthritis', NULL),
(743, 'L03.9', 'Cellulitis', NULL),
(744, 'N39.0', 'Urinary Tract Infection', NULL),
(745, 'J40', 'Bronchitis', NULL),
(746, 'J32.9', 'Sinusitis', NULL),
(747, 'H66.9', 'Acute Otitis media', NULL),
(748, 'J02.9', 'Pharyngitis', NULL),
(749, 'J18.9', 'Mild-Moderate Pneumonia', NULL),
(750, 'J98.8', 'Chest Infection', NULL),
(751, 'L01.0', 'Impetigo', NULL),
(752, 'P38', 'Cord sepsis', NULL),
(753, 'I10', 'Hypertension Urgency', NULL),
(754, 'I10', 'Malignant hypertension', NULL),
(755, 'I20.9', 'Angina', NULL),
(756, 'I21.9', 'Myocardia infarction', NULL),
(757, 'I20.0', 'Unstable Angina', NULL),
(758, 'I26.9', 'Pulmonary embolism', NULL),
(759, 'I82.9', 'Venous thrombosis', NULL),
(760, 'L98.4', 'Chronic Skin Ulcer', NULL),
(761, 'A31.1', 'Buruli Ulcer', NULL),
(762, 'T63.0', 'Snake bite', NULL),
(763, 'W54', 'Dog bite', NULL),
(764, 'W53', 'Rat bite', NULL),
(765, 'None', 'Nezer Diagnosis 1', NULL),
(766, 'K56.6', 'Intestinal obstruction', NULL),
(767, 'K46.0', 'Strangulated hernia', NULL),
(768, 'Q43.0', 'Meckel|s diverticulum', NULL),
(769, 'Q41.9', 'Intestinal atresia', NULL),
(770, 'Q43.1', 'Hirschsprung|s disease', NULL),
(771, 'K31.1', 'Pyloric stenosis', NULL),
(772, 'N28.9', 'Renal mass', NULL),
(773, 'D73.1', 'Hypersplenism', NULL),
(774, 'E27.9', 'Adrenal mass', NULL),
(775, 'N83.9', 'Ovarian mass', NULL),
(776, 'N13.0', 'Hydronephrosis with pelvi-ureteric junction obstruction', NULL),
(777, 'N13.1', 'Reimplantation of ureters', NULL),
(778, 'Q61.0', 'Multi-cystic kidney', NULL),
(779, 'Q61.4', 'Dysplastic kidney', NULL),
(780, 'Q63.9', 'Congenital abnormalities of the kidney', NULL),
(781, 'D48.9', 'Sacroccygeal teratoma', NULL),
(782, 'C80', 'Rhabdomyosarcoma', NULL),
(783, 'D18.1', 'Cystic hygroma', NULL),
(784, 'K62.1', 'Rectal polyp', NULL),
(785, 'Q18.0', 'Branchial cyst', NULL),
(786, 'R22.9', 'Other superficial  swellings', NULL),
(787, 'D23.9', 'External angulardermoid', NULL),
(788, 'Q89.2', 'Thyroglossal cyst/fistula', NULL),
(789, 'l02.2', 'Perineal abscess', NULL),
(790, 'N61', 'Breast abscess', NULL),
(791, 'l02.9', 'All other abscesses', NULL),
(792, 'K42.9', 'Umbilical hernia', NULL),
(793, 'N43.3', 'Hydrocele', NULL),
(794, 'K40.9', 'Inguinal hernia', NULL),
(795, 'Q79.2', 'Exomphalos (Omphalocoele)', NULL),
(796, 'Q79.3', 'Gastroschisis', NULL),
(797, 'K43.9', 'Incisional hernia', NULL),
(798, 'k43.9', 'Ventral hernia ', NULL),
(799, 'Q79.4', 'Prune belly syndrome', NULL),
(800, 'K65.9', 'Primary peritonitis', NULL),
(801, 'K66.1', 'Haemoperitoneum', NULL),
(802, 'S31.8', 'Stab wound to abdomen', NULL),
(803, 'Q39.0', 'Oesophageal atresia', NULL),
(804, 'T54.9', 'Ingestion of corrosive oesphageal stricture', NULL),
(805, 'K44.9', 'Diaphragmatic hernia', NULL),
(806, 'K43.9', 'Ventral hernia ', NULL),
(807, 'K35.0', 'Ruptured appendix', NULL),
(808, 'K37', 'Simple appendicitis', NULL),
(809, 'K35.9', 'Gangrenous appendix', NULL),
(810, 'K36', 'Chronic apprendicitis', NULL),
(811, 'K37', 'Interval appendicectomy', NULL),
(812, 'K35.1', 'Appendix abscess', NULL),
(813, 'K38.8', 'Appendix mass', NULL),
(814, 'l03.9', 'Cellulitis', NULL),
(815, 'N45.9', 'Epididymo-orchitis', NULL),
(816, 'Q39.0', 'Oesophageal atresia', NULL),
(817, 'K21.9', 'Gastrooesophageal reflux', NULL),
(818, 'K22.0', 'Achalasia of the cardia', NULL),
(819, 'K22.2', 'Oesophageal replacement', NULL),
(820, 'K22.2', 'Oesophageal stricture for replacement', NULL),
(821, 'Q54.9', 'Hypospadias, PUV', NULL),
(822, 'Q64.0', 'Simple epispadias', NULL),
(823, 'N32.2', 'Urethrocutaneous fistula', NULL),
(824, 'Q89.9', 'Cloacal anomaly', NULL),
(825, 'Q64.1', 'Bladder extrophy with epispadias', NULL),
(826, 'Q64.0', 'Female epispadias', NULL),
(827, 'Q64.1', 'Cloacal extrophy', NULL),
(828, 'K60.2', 'Anal fissure', NULL),
(829, 'K62.1', 'Rectal polyp', NULL),
(830, 'K60.3', 'Anal fistula', NULL),
(831, 'Q05.9', 'Spina bifida', NULL),
(832, 'Q01.0', 'Nasal encephalocoele', NULL),
(833, 'Q36.9', 'Cleft lip', NULL),
(834, 'Q35.9', 'Cleft palate', NULL),
(835, 'K80.2', 'Cholelithiasis', NULL),
(836, 'Q44.2', 'Biliary atresia ', NULL),
(837, 'K81.9', 'Cholecystitis', NULL),
(838, 'Q44.4', 'Choledochal cyst', NULL),
(839, 'Q89.4', 'Conjoint twins', NULL),
(840, 'Q89.4', 'Siamese twins', NULL),
(841, 'Q53.9', 'Undescended testis', NULL),
(842, 'I86.1', 'Varicocoele', NULL),
(843, 'Q53.0', 'Ectopic testis', NULL),
(844, 'T14.1', 'Wounds (primary)', NULL),
(845, 'T14.1', 'Wounds (postop)', NULL),
(846, 'R19.8', 'Ruptured solid Abdo. Viscus', NULL),
(847, 'S36.0', 'Ruptured spleen', NULL),
(848, 'S36.1', 'Ruptured liver', NULL),
(849, 'Q43.1', 'Hischsprung disease', NULL),
(850, 'Q43.9', 'Anorectal anomaly', NULL),
(851, 'K91.4', 'Conditions with enterostomy', NULL),
(852, 'Q43.9', 'Anorectal malformations', NULL),
(853, 'T30.0', 'Minor burns <10%', NULL),
(854, 'T30.0', 'Burns over 10% BSA', NULL),
(855, 'T30.0', 'Burn complications', NULL),
(856, 'T30.0', 'Major Burns >10 BSA with eschars or requiring skin graft', NULL),
(857, 'T74.2', 'Rape/defilement', NULL),
(858, 'T74.2', 'Rape/defilement', NULL),
(859, 'Q41.9', 'Intestinal atresia', NULL),
(860, 'Q43.3', 'Malrotation', NULL),
(861, 'K66.8', 'Mesenteric cysts', NULL),
(862, 'Q36.9', 'Cleft lip', NULL),
(863, 'Q35.9', 'Cleft Palate', NULL),
(864, 'Q54.9', 'Hypospadias', NULL),
(865, 'T14.6', 'Tendon Injury', NULL),
(866, 'T14.5', 'Vascular Injury', NULL),
(867, 'T14.4', 'Peripheral Nerve Injury', NULL),
(868, 'T30.0', 'Burns', NULL),
(869, 'T14.9', 'Traumatic Wounds', NULL),
(870, 'L98.4', 'Ulcers', NULL),
(871, 'T30.0', 'Burns', NULL),
(872, 'A31.0', 'Buruli Ulcer', NULL),
(873, 'T14.9', 'Injuries without Tissue Loss', NULL),
(874, 'T14.9', 'Injuries with Tissue Loss', NULL),
(875, 'T14.1', 'Lacerations', NULL),
(876, 'T14.9', 'Injuries without tissue loss', NULL),
(877, 'T14.9', 'Injuries with Tissue Loss', NULL),
(878, 'T14.9', 'Injuries with Tissue Loss', NULL),
(879, 'D17.9', 'Lipoma', NULL),
(880, 'C49.9', 'Fibroma', NULL),
(881, 'M67.4', 'Ganglion', NULL),
(882, 'D18.0', 'Haemangioma', NULL),
(883, 'Q69.9', 'Polydactyly', NULL),
(884, 'None', 'Nezer Diagnosis 1', NULL),
(885, 'T30.0', 'Burns', NULL),
(886, 'M62.4', 'Contractures ', NULL),
(887, 'Q75.0', 'Craniosynostosis', NULL),
(888, 'T14.9', 'Traumatic', NULL),
(889, 'H93.9', 'Defect of Ear', NULL),
(890, 'K13.0', 'Defect of Lip', NULL),
(891, 'J34.8', 'Defect Nose', NULL),
(892, 'C43.9', 'Lymphoedema', NULL),
(893, 'M62.4', 'Postburns Contracture', NULL),
(894, 'M62.4', 'Contractures Others', NULL),
(895, 'L65.9', 'Facial skin loss', NULL),
(896, 'S69.9', 'Hand injuries with skin loss', NULL),
(897, 'Q85.0', 'Neurobibromatosis', NULL),
(898, 'Q70.9', 'Syndactyly', NULL),
(899, 'M62.4', 'Contracture joints of Hand', NULL),
(900, 'H02.1', 'Ectropion of Eyelids', NULL),
(901, 'Q85.0', 'Neurofibromatosis', NULL),
(902, 'T14.9', 'Injuries without tissue loss', NULL),
(903, 'None', 'Nezer Diagnosis 1', NULL),
(904, 'NA', 'Another added investigation', 'gdrg'),
(905, 'NA', 'New Diagnosis', 'gdrg'),
(907, 'NA', '', 'gdrg'),
(908, 'NA', '', 'gdrg'),
(909, 'NA', '', 'gdrg');

-- --------------------------------------------------------

--
-- Table structure for table `diagnosis_symptoms`
--

CREATE TABLE IF NOT EXISTS `diagnosis_symptoms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `diagnosis_id` int(11) NOT NULL,
  `symptoms_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `diagnosis_symptoms`
--


-- --------------------------------------------------------

--
-- Table structure for table `diagnostic_groupings`
--

CREATE TABLE IF NOT EXISTS `diagnostic_groupings` (
  `code` varchar(10) NOT NULL,
  `descriptio` text NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `diagnostic_groupings`
--

INSERT INTO `diagnostic_groupings` (`code`, `descriptio`) VALUES
('ASUR', 'Adult Surgery'),
('DENT', 'Dental'),
('ENTH', 'ENT'),
('MEDI', 'MEDICAL'),
('OBGY', 'OBS & GYN'),
('OPTH', 'Opthalmology'),
('ORTH', 'Orthopaedics'),
('PAED', 'Paediatrics'),
('PSUR', 'Paediatrics Surgery'),
('ZOOM', 'Zoom-Cross');

-- --------------------------------------------------------

--
-- Table structure for table `dispensary_batch`
--

CREATE TABLE IF NOT EXISTS `dispensary_batch` (
  `item_batch` varchar(100) NOT NULL,
  `item_code` varchar(255) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `quantity_received` int(11) NOT NULL,
  `quantity_on_hand` int(11) NOT NULL,
  `date_received` date NOT NULL,
  `expiry_date` date NOT NULL,
  `purchase_price` double NOT NULL,
  `selling_price` double NOT NULL,
  `received_value` double NOT NULL,
  `value_on_hand` double NOT NULL,
  PRIMARY KEY (`item_batch`),
  KEY `item_code` (`item_code`),
  KEY `invoice_id` (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dispensary_batch`
--

INSERT INTO `dispensary_batch` (`item_batch`, `item_code`, `invoice_id`, `quantity_received`, `quantity_on_hand`, `date_received`, `expiry_date`, `purchase_price`, `selling_price`, `received_value`, `value_on_hand`) VALUES
('PA0000001', 'PARAINJE', 1, 700, 700, '2013-11-26', '2016-11-26', 0.2, 1.6, 1120, 1120);

-- --------------------------------------------------------

--
-- Table structure for table `dispensary_items`
--

CREATE TABLE IF NOT EXISTS `dispensary_items` (
  `item_description` varchar(255) NOT NULL,
  `item_code` varchar(100) NOT NULL,
  `quantity_on_hand` int(11) NOT NULL,
  `manufacturer` varchar(500) NOT NULL,
  `price_markup` double NOT NULL,
  `percentage_markup` double NOT NULL,
  `form_id` int(11) NOT NULL,
  `unit_of_issue` int(11) NOT NULL,
  `reorder_level` int(11) NOT NULL,
  `minimum_stock_level` int(11) NOT NULL,
  `strength` varchar(255) NOT NULL,
  `active_ingredients` varchar(1000) NOT NULL,
  `reorder_qty` int(11) NOT NULL,
  `maximum_stock_level` int(11) DEFAULT NULL,
  `therapeutic_group` int(11) NOT NULL,
  `vatable` tinyint(1) NOT NULL,
  PRIMARY KEY (`item_code`),
  KEY `form_id` (`form_id`),
  KEY `unit_of_issue` (`unit_of_issue`),
  KEY `therapeutic_group` (`therapeutic_group`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dispensary_items`
--

INSERT INTO `dispensary_items` (`item_description`, `item_code`, `quantity_on_hand`, `manufacturer`, `price_markup`, `percentage_markup`, `form_id`, `unit_of_issue`, `reorder_level`, `minimum_stock_level`, `strength`, `active_ingredients`, `reorder_qty`, `maximum_stock_level`, `therapeutic_group`, `vatable`) VALUES
('Paracetamol Injection', 'PARAINJE', 0, 'Norvatis', 0.3, 1.2, 1, 2, 800, 200, '125mg', 'Parcetamol', 200, 1000, 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `dosage`
--

CREATE TABLE IF NOT EXISTS `dosage` (
  `dosage_id` int(11) NOT NULL AUTO_INCREMENT,
  `short_code` varchar(10) NOT NULL,
  `description` text NOT NULL,
  `quantity` int(11) NOT NULL,
  `item_code` varchar(255) NOT NULL,
  PRIMARY KEY (`dosage_id`),
  KEY `item_code` (`item_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `dosage`
--

INSERT INTO `dosage` (`dosage_id`, `short_code`, `description`, `quantity`, `item_code`) VALUES
(1, '2TD5DAYS', 'Take 2 Tablets 5 Times Daily', 0, 'COARTE'),
(2, '3TD5DAYS', 'Take 3 Tablets 5 Times Daily', 0, 'PARAINJE');

-- --------------------------------------------------------

--
-- Table structure for table `dosagemonitor`
--

CREATE TABLE IF NOT EXISTS `dosagemonitor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `treatment_id` text NOT NULL,
  `visitid` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `nurse` text NOT NULL,
  `date` date NOT NULL,
  `time` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `dosagemonitor`
--


-- --------------------------------------------------------

--
-- Table structure for table `drugs`
--

CREATE TABLE IF NOT EXISTS `drugs` (
  `treatmentid` int(11) NOT NULL AUTO_INCREMENT,
  `treatment` text NOT NULL,
  `price` double NOT NULL,
  `icd10` text NOT NULL,
  `gdrg` text NOT NULL,
  PRIMARY KEY (`treatmentid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1898 ;

--
-- Dumping data for table `drugs`
--

INSERT INTO `drugs` (`treatmentid`, `treatment`, `price`, `icd10`, `gdrg`) VALUES
(1, 'Adrenaline (Epinephrine) Injection, B1/M R ADRENAIN1 100 microgram/ml (1:10 000) \r\n', 100, '', ''),
(2, 'Adrenaline (Epinephrine) Injection, B1/M R ADRENAIN2 1 mg/ ml (1:1000) \r\n', 5, '', ''),
(3, 'Atropine Injection, 0.6 mg/ml B2 R ATROPIIN1\r\n', 20, '', ''),
(4, 'Atropine Injection, 1 mg/ml C R ATROPIIN2 \r\n', 5, '', ''),
(5, 'Bupivacaine + Adrenaline Injection, (0.25% + 1:200 000) C NR BUPADRIN1 \r\n', 80, '', ''),
(6, 'Bupivacaine + Adrenaline Injection, (0.5% + 1:200 000) C NR BUPADRIN2 \r\n', 100, '', ''),
(7, 'Bupivacaine Injection, 0.25% (Plain) C R BUPIVAIN2 \r\n', 30, '', ''),
(8, 'Bupivacaine Injection, 0.5% (Heavy) C R BUPIVAIN1 \r\n', 85, '', ''),
(9, 'Diazep am Injection, 5 mg/ml B1/M R DIAZEPIN1 \r\n', 90, '', ''),
(10, 'Ephedrine Hydrochloride Injection, 50 mg C R EPHEDRIN1 \r\n', 75, '', ''),
(11, 'Fentanyl Citrate Injection, 50 microgram C NR FENCITIN1 \r\n', 75, '', ''),
(12, 'Halothane Inhalation, 250 ml C NR HALOTHGA1 \r\n', 45, '', ''),
(13, 'Isoflurane Inhalation, 100 ml C NR ISOFLUGA1 \r\n', 75, '', ''),
(14, 'Ketamine Injection, 10 mg/ml C R KETAMIIN1 \r\n', 45, '', ''),
(15, 'Ketamine Injection, 50 mg/ml C R KETAMIIN2 \r\n', 90, '', ''),
(16, 'Ketorolac Injection, 30 mg/ml C NR KETOROIN1 \r\n', 100, '', ''),
(17, 'Lidocaine Injection, 2% B1/M R LIDOCAIN2 \r\n', 100, '', ''),
(18, 'Midazolam Injection, 5 mg/ml C R MIDAZOIN1 \r\n', 45, '', ''),
(19, 'Midazolam Tablet, 15 mg C R MIDAZOTA1 \r\n', 100, '', ''),
(20, 'Neostigmine Injection, 0.5 mg/ml C NR NEOSTIIN2 \r\n', 95, '', ''),
(21, 'Neostigmine Injection, 2.5 mg/ml C R NEOSTIIN1 \r\n', 75, '', ''),
(22, 'Nitrous Oxide Inhalation C NR NITOXIGA1 \r\n', 100, '', ''),
(23, 'Noradrenaline (Norepinephrine) Injection, 1 mg/ml (1:1000) D NR NORADRIN1 \r\n', 10, '', ''),
(24, 'Oxygen (Medicinal Gas) Inhalation B1/M NR OXYGENGA1 \r\n', 100, '', ''),
(25, 'Pancuronium Bromide, 2 mg/ml C NR PANBROIN1 \r\n', 90, '', ''),
(26, 'Propofol Injection, 10 mg/ml C R PROPOFIN1 \r\n', 95, '', ''),
(27, 'Suxamethonium Succinylcholine Injection, 50mg/ml C NR SUXAMEIN1 \r\n', 60, '', ''),
(28, 'Thiopentone Sodium Injection, 1 g C NR THISODIN1 \r\n', 55, '', ''),
(29, 'Vecuronium Bromide Injection, 10 mg C NR VECBROIN1 \r\n', 95, '', ''),
(30, 'Bupivacaine Injection, 5 mg/ml C R BUPIVAIN2 \r\n', 60, '', ''),
(31, 'Lidocaine + Adrenaline Injection, (10 mg/ml + 5 microgram/ml) B2 R LIDADRIN2 \r\n', 30, '', ''),
(32, 'Lidocaine + Adrenaline Injection, (20 mg/ml + 5 microgram/ml) B2 R LIDADRIN3 \r\n', 45, '', ''),
(33, 'Lidocaine Cream, 2 % A/M R LIDOCACR1 \r\n', 55, '', ''),
(34, 'Lidocaine Gel, 2 % B1/M R LIDOCAGE2 \r\n', 50, '', ''),
(35, 'Lidocaine Injection, 1 % B1/M R LIDOCAIN1 \r\n', 30, '', ''),
(36, 'Lidocaine Injection, 2 % B1/M R LIDOCAIN2 \r\n', 55, '', ''),
(37, 'Lidocaine Injection, 20 mg/ml B2 R LIDOCAIN3 \r\n', 10, '', ''),
(38, 'Lidocaine Spray, 10 % B1/M R LIDOCASP1 \r\n', 60, '', ''),
(39, 'Atropine Injection, 0.6 mg/ml B2 R ATROPIIN1 \r\n', 45, '', ''),
(40, 'Diazepam Injection, 5 mg/ml B1/M R DIAZEPIN1 \r\n', 25, '', ''),
(41, 'Lorazepam Injection, 4 mg/ml D R LORAZEIN1 \r\n', 10, '', ''),
(42, 'Lorazepam Tablet, 1 mg B2 R LORAZETA1 \r\n', 80, '', ''),
(43, 'Lorazepam Tablet, 2 mg B2 R LORAZETA2 \r\n', 25, '', ''),
(44, 'Midazolam Injection, 1mg/ml C R MIDAZOIN1 \r\n', 80, '', ''),
(45, 'Acetyl Salicylic Acid Tablet, 300 mg B1/M R ACETYLTA1 \r\n', 80, '', ''),
(46, 'Diclofenac Capsule, 75 mg B2 R DICLOFCA1 \r\n', 90, '', ''),
(47, 'Diclofenac Gel, 1% A/M R DICLOFGE1\r\n', 45, '', ''),
(48, 'Diclofenac Injection, 25 mg/ml  B2 R DICLOFIN1 \r\n', 25, '', ''),
(49, 'Midazolam Tablet, 15 mg C R MIDAZOTA1 \r\n', 20, '', ''),
(50, 'Diclofenac Suppository, 100 mg A/M R DICLOFRE2 \r\n', 5, '', ''),
(51, 'Diclofenac Suppository, 50 mg A/M R DICLOFRE1 \r\n', 55, '', ''),
(52, 'Diclofenac Tablet, 25 mg B2 R DICLOFTA1 \r\n', 80, '', ''),
(53, 'Diclofenac Tablet, 50 mg B2 R DICLOFTA2 \r\n', 15, '', ''),
(54, 'Ibuprofen Suspension, 100 mg/ 5 ml B1/M R IBUPROSU1 \r\n', 20, '', ''),
(55, 'Ibuprofen Tablet, 200 mg B1/M R IBUPROTA1 \r\n', 90, '', ''),
(56, 'Ibuprofen Tablet, 400 mg B1/M R IBUPROTA2 \r\n', 50, '', ''),
(57, 'Paracetamol Suppository, 125 mg A/M R PARACERE1 \r\n', 50, '', ''),
(58, 'Paracetamol Suppository, 250 mg A/M R PARACERE2 \r\n', 85, '', ''),
(59, 'Paracetamol Suppository, 300 mg A/M R PARACERE3 \r\n', 35, '', ''),
(60, 'Paracetamol Suppository, 500 mg A/M R PARACERE4 \r\n', 75, '', ''),
(61, 'Paracetamol Syrup, 120 mg/ 5 ml A/M R PARACESY1 \r\n', 75, '', ''),
(62, 'Paracetamol Tablet, 500 mg A/M R PARACETA1 \r\n', 50, '', ''),
(63, 'Morphine Injection, 10 mg/ml (Preservative -Free) SD R MORPHIIN2 \r\n', 10, '', ''),
(64, 'Morphine Injection, 10 mg/ml C R MORPHIIN1 \r\n', 95, '', ''),
(65, 'Morphine Sulphate Tablet, 30 mg (Slow -Release) C R MORSULTA2 \r\n', 45, '', ''),
(66, 'Morphine Sulphate Tablets, 10 mg C R MORSULTA1 \r\n', 90, '', ''),
(67, 'Pethidine Injection, 50 mg/ml B2 R PETHIDIN1 \r\n', 95, '', ''),
(68, 'Tramadol Hydrochloride Injection, 50 mg/ml B2 NR TRAHYDIN1 \r\n', 80, '', ''),
(69, 'Tramadol Hydrochloride Capsule, 50 mg B2 NR TRAHYDCA1 \r\n', 50, '', ''),
(70, 'Allopurinol Tablet, 100 mg B2 R ALLOPUTA1 \r\n', 85, '', ''),
(71, 'Allopurinol Tablet, 300 mg B2 R ALLOPUTA2 \r\n', 80, '', ''),
(72, 'Adrenaline Injection, 1 mg/ml (1:1000) B1/M R ADRENAIN1 \r\n', 25, '', ''),
(73, 'Chlorphenamine Syrup, 2 mg/ 5 ml A/M R CHLPHESY1 \r\n', 40, '', ''),
(74, 'Chlorphenamine Tablet, 4 mg A/M R CHLPHETA1 \r\n', 60, '', ''),
(75, 'Dexamethasone Injection, 4mg/ml C R DEXAMEIN1 \r\n', 90, '', ''),
(76, 'Dexamethasone Tablet, 500 micrograms D R DEXAMETA1 \r\n', 55, '', ''),
(77, 'Hydrocortisone Cream, 1 % B1 R HYDROCCR1 \r\n', 40, '', ''),
(78, 'Hydrocortisone Sodium Succinate Injection, 100 mg B1/M R HYSOSUIN1 \r\n', 20, '', ''),
(79, 'Diclofenac Tablet, 25 mg B2 R DICLOFTA1 \r\n', 20, '', ''),
(80, 'Diclofenac Tablet, 50 mg B2 R DICLOFTA2 \r\n', 45, '', ''),
(81, 'Ibuprofen Suspension, 100 mg/ 5 ml B1/M R IBUPROSU1 \r\n', 55, '', ''),
(82, 'Ibuprofen Tablet, 200 mg B1/M R IBUPROTA1 \r\n', 45, '', ''),
(83, 'Ibuprofen Tablet, 400 mg B1/M R IBUPROTA2 \r\n', 95, '', ''),
(84, 'Paracetamol Suppository, 125 mg A/M R PARACERE1 \r\n', 25, '', ''),
(85, 'Paracetamol Suppository, 250 mg A/M R PARACERE2 \r\n', 60, '', ''),
(86, 'Paracetamol Suppository, 300 mg A/M R PARACERE3 \r\n', 50, '', ''),
(87, 'Paracetamol Suppository, 500 mg A/M R PARACERE4 \r\n', 20, '', ''),
(88, 'Paracetamol Syrup, 120 mg/ 5 ml A/M R PARACESY1 \r\n', 70, '', ''),
(89, 'Paracetamol Tablet, 500 mg A/M R PARACETA1 \r\n', 35, '', ''),
(90, 'Morphine Injection, 10 mg/ml (Preservative -Free) SD R MORPHIIN2 \r\n', 40, '', ''),
(91, 'Morphine Injection, 10 mg/ml C R MORPHIIN1 \r\n', 60, '', ''),
(92, 'Morphine Sulphate Tablet, 30 mg (Slow -Release) C R MORSULTA2 \r\n', 65, '', ''),
(93, 'Morphine Sulphate Tablets, 10 mg C R MORSULTA1 \r\n', 80, '', ''),
(94, 'Pethidine Injection, 50 mg/ml B2 R PETHIDIN1 \r\n', 85, '', ''),
(95, 'Tramadol Hydrochloride Injection, 50 mg/ml B2 NR TRAHYDIN1 \r\n', 25, '', ''),
(96, 'Tramadol Hydrochloride Capsule, 50 mg B2 NR TRAHYDCA1 \r\n', 5, '', ''),
(97, 'Allopurinol Tablet, 100 mg B2 R ALLOPUTA1 \r\n', 95, '', ''),
(98, 'Allopurinol Tablet, 300 mg B2 R ALLOPUTA2 \r\n', 60, '', ''),
(99, 'Adrenaline Injection, 1 mg/ml (1:1000) B1/M R ADRENAIN1 \r\n', 55, '', ''),
(100, 'Chlorphenamine Syrup, 2 mg/ 5 ml A/M R CHLPHESY1 \r\n', 55, '', ''),
(101, 'Chlorphenamine Tablet, 4 mg A/M R CHLPHETA1 \r\n', 45, '', ''),
(102, 'Dexamethasone Injection, 4mg/ml C R DEXAMEIN1 \r\n', 90, '', ''),
(103, 'Dexamethasone Tablet, 500 micrograms D R DEXAMETA1 \r\n', 90, '', ''),
(104, 'Hydrocortisone Cream, 1 % B1 R HYDROCCR1 \r\n', 50, '', ''),
(105, 'Hydrocortisone Sodium Succinate Injection, 100 mg B1/M R HYSOSUIN1 \r\n', 45, '', ''),
(106, 'Hydrocortisone Tablet, 10 mg C NR HYDROCTA1 \r\n', 55, '', ''),
(107, 'Hydrocortisone Tablet, 20 mg SD NR HYDROCTA2 \r\n', 60, '', ''),
(108, 'Prednisolone Tablet, 5 mg B2 R PREDNITA1 \r\n', 40, '', ''),
(109, 'Promethazine Hydrochloride Elixir, 5 mg/5 ml B1/M R PROHYDEL1 \r\n', 100, '', ''),
(110, 'Promethazine Hydrochloride Injection, 25 mg /ml B1/M R PROHYDIN1 \r\n', 60, '', ''),
(111, 'Promethazine Hydrochloride Tablet, 25 mg B1/M R PROMETTA1 \r\n', 55, '', ''),
(112, 'Acetylcysteine Injection, 200 mg/ml C R ACETYLIN1 \r\n', 15, '', ''),
(113, 'Activated Charcoal Powder, 50 g A/M R ACTCHAPO1 \r\n', 70, '', ''),
(114, 'Atropine Injection, 0.6 mg/ml B2 R ATROPIIN1 \r\n', 85, '', ''),
(115, 'Benzatropine Injection, 1 mg/ml C R BENZATIN1 \r\n', 60, '', ''),
(116, 'Diazepam Injection, 10 mg/ml B1/M R DIAZEPIN1 \r\n', 55, '', ''),
(117, 'Flumazenil Injection, 0.2 mg D R FLUMAZIN1 \r\n', 25, '', ''),
(118, 'Naloxone Injection, 200 microgram /ml C R NALOXOIN1 \r\n', 100, '', ''),
(119, 'Naloxone Injection, 400 microgram /ml C R NALOXOIN2 \r\n', 15, '', ''),
(120, 'Phytomenadione Injection, 10 mg/ml B2/M R PHYTOMIN1 \r\n', 5, '', ''),
(121, 'Phytomenadione Tablet, 10 mg B2 NR PHYTOMTA1 \r\n', 25, '', ''),
(122, 'Carbamazepine Tablet, 200 mg (Sustained Release) SD R CARBAMTA3 \r\n', 60, '', ''),
(123, 'Carbamazepine Tablet, 400 mg (Sustained Release) SD R CARBAMTA4 \r\n', 75, '', ''),
(124, 'Carbamazepine Tablet, 100 mg C R CARBAMTA1 \r\n', 80, '', ''),
(125, 'Carbamazepine Tablet, 200 mg C R CARBAMTA2 \r\n', 35, '', ''),
(126, 'Diazepam Injection, 5 mg/ml B1/M R DIAZEPIN1 \r\n', 75, '', ''),
(127, 'Diazepam Rectal Tubes, 2 mg/ml A/M R DIAZEPRS1 \r\n', 55, '', ''),
(128, 'Ethosuximide Syrup, 250 mg/ 5 ml D R ETHOSUSY1 \r\n', 15, '', ''),
(129, 'Ethosuximide Tablet, 250 mg D R ETHOSUTA1 \r\n', 80, '', ''),
(130, 'Magnesium Sulphate Injection, 20 % B1/M R MAGSULIN1 \r\n', 35, '', ''),
(131, 'Magnesium Sulphate Injection, 25 % B2/M R MAGSULIN2 \r\n', 90, '', ''),
(132, 'Magnesium Sulphate Injection, 50 % C R MAGSULIN3 \r\n', 80, '', ''),
(133, 'Phenobarbital Injection, 200 mg/ml B1 R PHENOBIN1 \r\n', 45, '', ''),
(134, 'Hydrocortisone Tablet, 10 mg C NR HYDROCTA1 \r\n', 85, '', ''),
(135, 'Hydrocortisone Tablet, 20 mg SD NR HYDROCTA2 \r\n', 20, '', ''),
(136, 'Prednisolone Tablet, 5 mg B2 R PREDNITA1 \r\n', 85, '', ''),
(137, 'Promethazine Hydrochloride Elixir, 5 mg/5 ml B1/M R PROHYDEL1 \r\n', 5, '', ''),
(138, 'Promethazine Hydrochloride Injection, 25 mg /ml B1/M R PROHYDIN1 \r\n', 70, '', ''),
(139, 'Promethazine Hydrochloride Tablet, 25 mg B1/M R PROMETTA1 \r\n', 10, '', ''),
(140, 'Acetylcysteine Injection, 200 mg/ml C R ACETYLIN1 \r\n', 30, '', ''),
(141, 'Activated Charcoal Powder, 50 g A/M R ACTCHAPO1 \r\n', 55, '', ''),
(142, 'Atropine Injection, 0.6 mg/ml B2 R ATROPIIN1 \r\n', 5, '', ''),
(143, 'Benzatropine Injection, 1 mg/ml C R BENZATIN1 \r\n', 95, '', ''),
(144, 'Diazepam Injection, 10 mg/ml B1/M R DIAZEPIN1 \r\n', 90, '', ''),
(145, 'Flumazenil Injection, 0.2 mg D R FLUMAZIN1 \r\n', 25, '', ''),
(146, 'Naloxone Injection, 200 microgram /ml C R NALOXOIN1 \r\n', 65, '', ''),
(147, 'Naloxone Injection, 400 microgram /ml C R NALOXOIN2 \r\n', 90, '', ''),
(148, 'Phytomenadione Injection, 10 mg/ml B2/M R PHYTOMIN1 \r\n', 85, '', ''),
(149, 'Phytomenadione Tablet, 10 mg B2 NR PHYTOMTA1 \r\n', 50, '', ''),
(150, 'Carbamazepine Tablet, 200 mg (Sustained Release) SD R CARBAMTA3 \r\n', 100, '', ''),
(151, 'Carbamazepine Tablet, 400 mg (Sustained Release) SD R CARBAMTA4 \r\n', 80, '', ''),
(152, 'Carbamazepine Tablet, 100 mg C R CARBAMTA1 \r\n', 15, '', ''),
(153, 'Carbamazepine Tablet, 200 mg C R CARBAMTA2 \r\n', 20, '', ''),
(154, 'Diazepam Injection, 5 mg/ml B1/M R DIAZEPIN1 \r\n', 90, '', ''),
(155, 'Diazepam Rectal Tubes, 2 mg/ml A/M R DIAZEPRS1 \r\n', 100, '', ''),
(156, 'Ethosuximide Syrup, 250 mg/ 5 ml D R ETHOSUSY1 \r\n', 100, '', ''),
(157, 'Ethosuximide Tablet, 250 mg D R ETHOSUTA1 \r\n', 55, '', ''),
(158, 'Magnesium Sulphate Injection, 20 % B1/M R MAGSULIN1 \r\n', 85, '', ''),
(159, 'Magnesium Sulphate Injection, 25 % B2/M R MAGSULIN2 \r\n', 10, '', ''),
(160, 'Magnesium Sulphate Injection, 50 % C R MAGSULIN3 \r\n', 45, '', ''),
(161, 'Phenobarbital Injection, 200 mg/ml B1 R PHENOBIN1 \r\n', 15, '', ''),
(162, 'Phenytoin Injection, 50 mg/ml D R PHENYTIN1 \r\n', 45, '', ''),
(163, 'Phenytoin Sodium Capsule, 100 mg B2 R PHENYTCA2 \r\n', 85, '', ''),
(164, 'Phenytoin Sodium Tablet, 100 mg B2 R PHENYTTA1 \r\n', 20, '', ''),
(165, 'Primidone Tablet, 250 mg C R PRIMIDTA1 \r\n', 20, '', ''),
(166, 'Sodium Valproate Syrup, 200 mg/ 5 ml D R SODVALSY1 \r\n', 40, '', ''),
(167, 'Sodium Valproate Capsule, 500 mg (Slow-Release) D R SODVALCA2 \r\n', 45, '', ''),
(168, 'Sodium Valproate Capsule, 200 mg D R SODVALCA1 \r\n', 100, '', ''),
(169, 'Sodium Valproate Tablet, 200 mg D R SODVALTA1 \r\n', 55, '', ''),
(170, 'Albendazole Syrup, 100 mg/ 5ml A/M R ALBENDSY1 \r\n', 55, '', ''),
(171, 'Albendazole Tablet, 200 mg A/M R ALBENDTA1 \r\n', 35, '', ''),
(172, 'Albendazole Tablet, 400 mg A/M R ALBENDTA2 \r\n', 30, '', ''),
(173, 'Mebendazole Tablet, 100 mg A/M R MEBENDTA1 \r\n', 65, '', ''),
(174, 'Mebendazole Tablet, 500 mg A/M R MEBENDTA2 \r\n', 40, '', ''),
(175, 'Niclosamide Tablet, 500 mg B2 R NICLOSTA1 \r\n', 20, '', ''),
(176, 'Tiabendazole Suspension, 50 mg/ml B2 R TIABENSU1 \r\n', 80, '', ''),
(177, 'Tiabendazole Tablet, 500 mg B2 R TIABENTA1 \r\n', 60, '', ''),
(178, 'Praziquantel Tablet, 600 mg B1 R PRAZIQTA1 \r\n', 70, '', ''),
(179, 'Amoxicillin + Clavulanic Acid Injection, (500 mg + 100 mg) B2 R COAMOXIN1 \r\n', 50, '', ''),
(180, 'Amoxicillin + Clavulanic Acid Suspension, (250 mg + 62 mg) B2 R COAMOXSU1 \r\n', 60, '', ''),
(181, 'Amoxicillin + Clavulanic Acid Suspension, (400 mg + 57mg) B2 R COAMOXSU2 \r\n', 100, '', ''),
(182, 'Amoxicillin + Clavulanic Acid Tablet, (250 mg + 125 mg) B2 R COAMOXTA2 \r\n', 50, '', ''),
(183, 'Amoxicillin + Clavulanic Acid Tablet, (500 mg + 125 mg) B2 R COAMOXTA1 \r\n', 95, '', ''),
(184, 'Phenytoin Injection, 50 mg/ml D R PHENYTIN1 \r\n', 100, '', ''),
(185, 'Phenytoin Sodium Capsule, 100 mg B2 R PHENYTCA2 \r\n', 95, '', ''),
(186, 'Phenytoin Sodium Tablet, 100 mg B2 R PHENYTTA1 \r\n', 80, '', ''),
(187, 'Primidone Tablet, 250 mg C R PRIMIDTA1 \r\n', 15, '', ''),
(188, 'Sodium Valproate Syrup, 200 mg/ 5 ml D R SODVALSY1 \r\n', 50, '', ''),
(189, 'Sodium Valproate Capsule, 500 mg (Slow-Release) D R SODVALCA2 \r\n', 100, '', ''),
(190, 'Sodium Valproate Capsule, 200 mg D R SODVALCA1 \r\n', 10, '', ''),
(191, 'Sodium Valproate Tablet, 200 mg D R SODVALTA1 \r\n', 5, '', ''),
(192, 'Albendazole Syrup, 100 mg/ 5ml A/M R ALBENDSY1 \r\n', 15, '', ''),
(193, 'Albendazole Tablet, 200 mg A/M R ALBENDTA1 \r\n', 55, '', ''),
(194, 'Albendazole Tablet, 400 mg A/M R ALBENDTA2 \r\n', 25, '', ''),
(195, 'Mebendazole Tablet, 100 mg A/M R MEBENDTA1 \r\n', 30, '', ''),
(196, 'Mebendazole Tablet, 500 mg A/M R MEBENDTA2 \r\n', 95, '', ''),
(197, 'Niclosamide Tablet, 500 mg B2 R NICLOSTA1 \r\n', 90, '', ''),
(198, 'Tiabendazole Suspension, 50 mg/ml B2 R TIABENSU1 \r\n', 15, '', ''),
(199, 'Tiabendazole Tablet, 500 mg B2 R TIABENTA1 \r\n', 10, '', ''),
(200, 'Praziquantel Tablet, 600 mg B1 R PRAZIQTA1 \r\n', 40, '', ''),
(201, 'Amoxicillin + Clavulanic Acid Injection, (500 mg + 100 mg) B2 R COAMOXIN1 \r\n', 100, '', ''),
(202, 'Amoxicillin + Clavulanic Acid Suspension, (250 mg + 62 mg) B2 R COAMOXSU1 \r\n', 40, '', ''),
(203, 'Amoxicillin + Clavulanic Acid Suspension, (400 mg + 57mg) B2 R COAMOXSU2 \r\n', 25, '', ''),
(204, 'Amoxicillin + Clavulanic Acid Tablet, (250 mg + 125 mg) B2 R COAMOXTA2 \r\n', 10, '', ''),
(205, 'Amoxicillin + Clavulanic Acid Tablet, (500 mg + 125 mg) B2 R COAMOXTA1 \r\n', 10, '', ''),
(206, 'Amoxicillin Capsule, 250 mg B1/M R AMOXICCA1 \r\n', 65, '', ''),
(207, 'Amoxicillin Capsule, 500 mg B1/M R AMOXICCA2 \r\n', 85, '', ''),
(208, 'Amoxicillin Suspension, 125 mg/ 5 ml B1/M R AMOXICSU1 \r\n', 15, '', ''),
(209, 'Ampicillin Injection, 500 mg B1/M R AMPICIIN1 \r\n', 95, '', ''),
(210, 'Benzathine Benzylpenicillin Injection, 1.2 MU PD NR BENBENIN1 \r\n', 70, '', ''),
(211, 'Benzathine Benzylpenicillin Injection, 2.4 MU PD NR BENBENIN2 \r\n', 50, '', ''),
(212, 'Benzyl Penicillin Injection, 1 MU B2 R BENZYLIN1 \r\n', 35, '', ''),
(213, 'Benzyl Penicillin Injection, 5 MU B2 R BENZYLIN2 \r\n', 70, '', ''),
(214, 'Cloxacillin Injection, 250 mg B2 R CLOXACIN1 \r\n', 40, '', ''),
(215, 'Cloxacillin Injection, 500 mg B2 R CLOXACIN2 \r\n', 15, '', ''),
(216, 'Flucloxacillin Capsule, 250 mg B1/M R FLUCLOCA1 \r\n', 40, '', ''),
(217, 'Flucloxacillin Suspension, 125 mg/ 5 ml B1/M R FLUCLOSU1 \r\n', 15, '', ''),
(218, 'Phenoxymethyl Penicillin Tablet, 250 mg B1/M R PHEPENTA1 \r\n', 20, '', ''),
(219, 'Tetracycline Capsule, 250mg B2 R TETRACCA1 \r\n', 5, '', ''),
(220, 'Azithromycin Capsule, 250 mg C R AZITHRCA1 \r\n', 65, '', ''),
(221, 'uspension, Azithromycin Oral s200 mg/ml C R AZITHRSU1 \r\n', 55, '', ''),
(222, 'Cefaclor Capsule, 250 mg B2 R CEFACLCA1 \r\n', 75, '', ''),
(223, 'Cefaclor Capsule, 500 mg B2 R CEFACLCA2 \r\n', 90, '', ''),
(224, 'Cefaclor Suspension, 125 mg/ 5ml B2 R CEFACLSU1 \r\n', 45, '', ''),
(225, 'Cefaclor Suspension, 250 mg/ 5ml B2 R CEFACLSU2 \r\n', 45, '', ''),
(226, 'Cefotaxime Injection, 1 g C R CEFOTAIN2 \r\n', 60, '', ''),
(227, 'Cefotaxime Injection, 500 mg C R CEFOTAIN1 \r\n', 90, '', ''),
(228, 'Ceftriaxone Injection, 1 g C R CEFTRIIN2 \r\n', 95, '', ''),
(229, 'Ceftriaxone Injection, 2 g C R CEFTRIIN3 \r\n', 5, '', ''),
(230, 'Ceftriaxone Injection, 250 mg PD R CEFTRIIN1 \r\n', 95, '', ''),
(231, 'Cefuroxime Injection, 1.5 g C R CEFUROIN2 \r\n', 90, '', ''),
(232, 'Cefuroxime Injection, 750 mg C R CEFUROIN1 \r\n', 5, '', ''),
(233, 'Cefuroxime Suspension, 125 mg/ 5 ml C R CEFUROSU1 \r\n', 5, '', ''),
(234, 'Cefuroxime Tablet, 125 mg C R CEFUROTA1 \r\n', 40, '', ''),
(235, 'Cefuroxime Tablet, 250 mg C R CEFUROTA2 \r\n', 55, '', ''),
(236, 'Chloramphenicol Injection, 1 g C R CHLORAIN1 \r\n', 85, '', ''),
(237, 'Ciprofloxacin Infusion, 2 mg/ml B2 R CIPROFIN1 \r\n', 95, '', ''),
(238, 'Amoxicillin Capsule, 250 mg B1/M R AMOXICCA1 \r\n', 80, '', ''),
(239, 'Amoxicillin Capsule, 500 mg B1/M R AMOXICCA2 \r\n', 75, '', ''),
(240, 'Amoxicillin Suspension, 125 mg/ 5 ml B1/M R AMOXICSU1 \r\n', 20, '', ''),
(241, 'Ampicillin Injection, 500 mg B1/M R AMPICIIN1 \r\n', 25, '', ''),
(242, 'Benzathine Benzylpenicillin Injection, 1.2 MU PD NR BENBENIN1 \r\n', 35, '', ''),
(243, 'Benzathine Benzylpenicillin Injection, 2.4 MU PD NR BENBENIN2 \r\n', 35, '', ''),
(244, 'Benzyl Penicillin Injection, 1 MU B2 R BENZYLIN1 \r\n', 50, '', ''),
(245, 'Benzyl Penicillin Injection, 5 MU B2 R BENZYLIN2 \r\n', 60, '', ''),
(246, 'Cloxacillin Injection, 250 mg B2 R CLOXACIN1 \r\n', 20, '', ''),
(247, 'Cloxacillin Injection, 500 mg B2 R CLOXACIN2 \r\n', 20, '', ''),
(248, 'Flucloxacillin Capsule, 250 mg B1/M R FLUCLOCA1 \r\n', 75, '', ''),
(249, 'Flucloxacillin Suspension, 125 mg/ 5 ml B1/M R FLUCLOSU1 \r\n', 40, '', ''),
(250, 'Phenoxymethyl Penicillin Tablet, 250 mg B1/M R PHEPENTA1 \r\n', 5, '', ''),
(251, 'Tetracycline Capsule, 250mg B2 R TETRACCA1 \r\n', 80, '', ''),
(252, 'Azithromycin Capsule, 250 mg C R AZITHRCA1 \r\n', 10, '', ''),
(253, 'uspension, Azithromycin Oral s200 mg/ml C R AZITHRSU1 \r\n', 55, '', ''),
(254, 'Cefaclor Capsule, 250 mg B2 R CEFACLCA1 \r\n', 40, '', ''),
(255, 'Cefaclor Capsule, 500 mg B2 R CEFACLCA2 \r\n', 85, '', ''),
(256, 'Cefaclor Suspension, 125 mg/ 5ml B2 R CEFACLSU1 \r\n', 75, '', ''),
(257, 'Cefaclor Suspension, 250 mg/ 5ml B2 R CEFACLSU2 \r\n', 45, '', ''),
(258, 'Cefotaxime Injection, 1 g C R CEFOTAIN2 \r\n', 60, '', ''),
(259, 'Cefotaxime Injection, 500 mg C R CEFOTAIN1 \r\n', 50, '', ''),
(260, 'Ceftriaxone Injection, 1 g C R CEFTRIIN2 \r\n', 70, '', ''),
(261, 'Ceftriaxone Injection, 2 g C R CEFTRIIN3 \r\n', 95, '', ''),
(262, 'Ceftriaxone Injection, 250 mg PD R CEFTRIIN1 \r\n', 60, '', ''),
(263, 'Cefuroxime Injection, 1.5 g C R CEFUROIN2 \r\n', 10, '', ''),
(264, 'Cefuroxime Injection, 750 mg C R CEFUROIN1 \r\n', 30, '', ''),
(265, 'Cefuroxime Suspension, 125 mg/ 5 ml C R CEFUROSU1 \r\n', 35, '', ''),
(266, 'Cefuroxime Tablet, 125 mg C R CEFUROTA1 \r\n', 55, '', ''),
(267, 'Cefuroxime Tablet, 250 mg C R CEFUROTA2 \r\n', 5, '', ''),
(268, 'Chloramphenicol Injection, 1 g C R CHLORAIN1 \r\n', 60, '', ''),
(269, 'Ciprofloxacin Infusion, 2 mg/ml B2 R CIPROFIN1 \r\n', 95, '', ''),
(270, '\r\n', 20, '', ''),
(271, 'Ciprofloxacin Tablet, 250 mg B1/M R CIPROFTA1 \r\n', 25, '', ''),
(272, 'Ciprofloxacin Tablet, 500 mg B1/M R CIPROFTA2 \r\n', 75, '', ''),
(273, 'Clarithromycin Capsule, 250 mg C R CLARITCA1 \r\n', 40, '', ''),
(274, 'Clarithromycin Capsule, 500 mg C R CLARITCA2 \r\n', 20, '', ''),
(275, 'Clarithromycin Paediatric Suspension, 125 mg/ml C R CLARITSU1 \r\n', 30, '', ''),
(276, 'Clindamycin Capsule, 150 mg D R CLINDACA1 \r\n', 30, '', ''),
(277, 'Clindamycin Injection, 150 mg/ml D R CLINDAIN1 \r\n', 95, '', ''),
(278, 'Clindamycin Suspension, 75 mg/ 5 ml D R CLINDASU1 \r\n', 90, '', ''),
(279, 'Co-trimoxazole Suspension, (200 mg + 40 mg) / 5 ml B1 R COTRIMSU1 \r\n', 95, '', ''),
(280, 'Co-trimoxazole Tablet, (400 mg + 80 mg) B1 R COTRIMTA2 \r\n', 5, '', ''),
(281, 'Doxycycline Capsule, 100 mg PD/SD R DOXYCYCA1 \r\n', 30, '', ''),
(282, 'Erythromycin Syrup, 125 mg/ 5 ml B1/M R ERYTHRSY1 \r\n', 15, '', ''),
(283, 'Erythromycin Tablet, 250 mg B1/M R ERYTHRTA1 \r\n', 5, '', ''),
(284, 'Gentamicin Injection, 40 mg/ml C R GENTAMIN1 \r\n', 20, '', ''),
(285, 'Neomycin Tablet, 500 mg C R NEOMYCTA1 \r\n', 40, '', ''),
(286, 'Nitrofurantoin Tablet, 100 mg B2 R NITROFTA1 \r\n', 85, '', ''),
(287, 'Ethambutol Tablet, 100 mg PD NR ETHAMBTA1 \r\n', 20, '', ''),
(288, 'Ethambutol Tablet, 400 mg PD NR ETHAMBTA2 \r\n', 60, '', ''),
(289, 'Isoniazid Tablet, 100 mg PD NR ISONIATA1 \r\n', 50, '', ''),
(290, 'Isoniazid Tablet, 300 mg PD NR ISONIATA2 \r\n', 90, '', ''),
(291, 'Pyrazinamide Tablet, 150 mg PD NR PYRAZITA1 \r\n', 60, '', ''),
(292, 'Pyrazinamide Tablet, 400 mg PD NR PYRAZITA2\r\n', 100, '', ''),
(293, 'Pyridoxine Tablet, 100 mg B2 R PYRIDOTA3 \r\n', 15, '', ''),
(294, 'Pyridoxine Tablet, 50 mg B2 R PYRIDOTA2\r\n', 25, '', ''),
(295, 'Rifa mpicin + Isoniazid + Ethambutol Tablet, (150 mg + 75 mg + 275 mg) PD NR RIISETTA1\r\n', 65, '', ''),
(296, 'Rifampicin + Isoniazid + Pyrazinamide + Ethambutol Tablet, (150 mg + 75 mg + 400 mg + 275 mg) PD NR RIISPYTA2 \r\n', 85, '', ''),
(297, 'Rifampicin + Isoniazid + Pyrazinamide Tablet, (60 mg + 30 mg + 150 mg) PD NR RIISPYTA1 \r\n', 5, '', ''),
(298, 'Rifampicin + Isoniazid Tablet, (150 mg + 75 mg) PD NR RIFISOTA2 \r\n', 45, '', ''),
(299, 'Rifampicin + Isoniazid Tablet, (60 mg + 30 mg) PD NR RIFISOTA1 \r\n', 30, '', ''),
(300, 'Ciprofloxacin Tablet, 250 mg B1/M R CIPROFTA1 \r\n', 10, '', ''),
(301, 'Ciprofloxacin Tablet, 500 mg B1/M R CIPROFTA2 \r\n', 30, '', ''),
(302, 'Clarithromycin Capsule, 250 mg C R CLARITCA1 \r\n', 50, '', ''),
(303, 'Clarithromycin Capsule, 500 mg C R CLARITCA2 \r\n', 80, '', ''),
(304, 'Clarithromycin Paediatric Suspension, 125 mg/ml C R CLARITSU1 \r\n', 100, '', ''),
(305, 'Clindamycin Capsule, 150 mg D R CLINDACA1 \r\n', 30, '', ''),
(306, 'Clindamycin Injection, 150 mg/ml D R CLINDAIN1 \r\n', 5, '', ''),
(307, 'Clindamycin Suspension, 75 mg/ 5 ml D R CLINDASU1 \r\n', 65, '', ''),
(308, 'Co-trimoxazole Suspension, (200 mg + 40 mg) / 5 ml B1 R COTRIMSU1 \r\n', 90, '', ''),
(309, 'Co-trimoxazole Tablet, (400 mg + 80 mg) B1 R COTRIMTA2 \r\n', 65, '', ''),
(310, 'Doxycycline Capsule, 100 mg PD/SD R DOXYCYCA1 \r\n', 20, '', ''),
(311, 'Erythromycin Syrup, 125 mg/ 5 ml B1/M R ERYTHRSY1 \r\n', 100, '', ''),
(312, 'Erythromycin Tablet, 250 mg B1/M R ERYTHRTA1 \r\n', 65, '', ''),
(313, 'Gentamicin Injection, 40 mg/ml C R GENTAMIN1 \r\n', 85, '', ''),
(314, 'Neomycin Tablet, 500 mg C R NEOMYCTA1 \r\n', 75, '', ''),
(315, 'Nitrofurantoin Tablet, 100 mg B2 R NITROFTA1 \r\n', 40, '', ''),
(316, 'Ethambutol Tablet, 100 mg PD NR ETHAMBTA1 \r\n', 75, '', ''),
(317, 'Ethambutol Tablet, 400 mg PD NR ETHAMBTA2 \r\n', 10, '', ''),
(318, 'Isoniazid Tablet, 100 mg PD NR ISONIATA1 \r\n', 85, '', ''),
(319, 'Isoniazid Tablet, 300 mg PD NR ISONIATA2 \r\n', 20, '', ''),
(320, 'Pyrazinamide Tablet, 150 mg PD NR PYRAZITA1 \r\n', 50, '', ''),
(321, 'Pyrazinamide Tablet, 400 mg PD NR PYRAZITA2\r\n', 10, '', ''),
(322, 'Pyridoxine Tablet, 100 mg B2 R PYRIDOTA3\r\n', 35, '', ''),
(323, 'Pyridoxine Tablet, 50 mg B2 R PYRIDOTA2 \r\n', 90, '', ''),
(324, 'Rifa mpicin + Isoniazid + Ethambutol Tablet, (150 mg + 75 mg + 275 mg) PD NR RIISETTA1 \r\n', 40, '', ''),
(325, 'Rifampicin + Isoniazid + Pyrazinamide + Ethambutol Tablet, (150 mg + 75 mg + 400 mg + 275 mg) PD NR RIISPYTA2 \r\n', 45, '', ''),
(326, 'Rifampicin + Isoniazid + Pyrazinamide Tablet, (60 mg + 30 mg + 150 mg) PD NR RIISPYTA1 \r\n', 60, '', ''),
(327, 'Rifampicin + Isoniazid Tablet, (150 mg + 75 mg) PD NR RIFISOTA2 \r\n', 20, '', ''),
(328, 'Rifampicin + Isoniazid Tablet, (60 mg + 30 mg) PD NR RIFISOTA1 \r\n', 85, '', ''),
(329, 'Metronidazole Suspension, 200 mg/ 5ml (as benzoate) B1/M R METRONSU2 \r\n', 90, '', ''),
(330, 'Metronidazole Tablet, 200 mg B1/M R METRONTA1 \r\n', 50, '', ''),
(331, 'Metronidazole Tablet, 400 mg B1/M R METRONTA2 \r\n', 80, '', ''),
(332, 'Tinidazole Capsule, 500 mg B2 R TINIDACA1 \r\n', 60, '', ''),
(333, 'Artemether + Lumefantrine Dispersible Tablet, (20 mg + 120 mg) (Co-Formulated) A/M R ARTLUMDT1 \r\n', 65, '', ''),
(334, 'Artemether + Lumefantrine Tablet, (20 mg + 120 mg ) (Co -Formulated) A/M R ARTLUMTA1 \r\n', 25, '', ''),
(335, 'Artesunate + Amodiaquine Granular Powder, (25 mg + 75 mg) A/M R ARTAMOPO1 \r\n', 80, '', ''),
(336, 'Artesunate + Amodiaquine Tablet, (25 mg + 75 mg) (Co-Blistered) A/M R ARTAMOTA2 \r\n', 95, '', ''),
(337, 'Artesunate + Amodiaquine Tablet, (50 mg + 150 mg) (Co -Blistered) A/M R ARTAMOTA1 \r\n', 95, '', ''),
(338, 'Artesunate + Amodiaquine Tablet, (100 mg + 270 mg) (Fixed Dose) A/M R ARTAMOTA5 \r\n', 95, '', ''),
(339, 'Rifampicin Tablet, 300 mg PD NR RIFAMPTA2 \r\n', 70, '', ''),
(340, 'Streptomycin Sulphate Injection, 1 g PD NR STREPTIN1 \r\n', 35, '', ''),
(341, 'Fluconaz ole Tablets, 50 mg C R FLUCONTA1 \r\n', 100, '', ''),
(342, 'Griseofulvin Tablet, 125 mg B2 R GRISEOTA1 \r\n', 100, '', ''),
(343, 'Griseofulvin Tablet, 500 mg B2 R GRISEOTA2 \r\n', 10, '', ''),
(344, 'Itraconazole Tablet, 100 mg D R ITRACOTA1 \r\n', 25, '', ''),
(345, 'Ketoconazole Tablet, 200 mg C R KETOCOTA1 \r\n', 60, '', ''),
(346, 'Miconazole Oral Gel, 20 mg/g C R MICONAOG1 \r\n', 55, '', ''),
(347, 'Nystatin Suspension, 100 000 IU/ml B2 R NYSTATSU1 \r\n', 10, '', ''),
(348, 'Nystatin Tablet, 100 000 IU C R NYSTATTA1 \r\n', 40, '', ''),
(349, 'Nystatin Tablet, 500 000 IU C R NYSTATTA2 \r\n', 10, '', ''),
(350, 'Terbinafine Hydrochloride Tablet, 250 mg D R TERBINTA1 \r\n', 45, '', ''),
(351, 'Metronidazole Injection, 5 mg/ml B2 R METRONIN1 \r\n', 95, '', ''),
(352, 'Metronidazole Suppository, 500 mg B2 R METRONRE1 \r\n', 35, '', ''),
(353, 'Metronidazole Suspension, 100 mg/ 5ml (as benzoate) B1/M R METRONSU1 \r\n', 35, '', ''),
(354, 'Metronidazole Suspension, 200 mg/ 5ml (as benzoate) B1/M R METRONSU2 \r\n', 90, '', ''),
(355, 'Metronidazole Tablet, 200 mg B1/M R METRONTA1 \r\n', 50, '', ''),
(356, 'Metronidazole Tablet, 400 mg B1/M R METRONTA2 \r\n', 30, '', ''),
(357, 'Tinidazole Capsule, 500 mg B2 R TINIDACA1 \r\n', 90, '', ''),
(358, 'Artemether + Lumefantrine Dispersible Tablet, (20 mg + 120 mg) (Co-Formulated) A/M R ARTLUMDT1 \r\n', 90, '', ''),
(359, 'Artemether + Lumefantrine Tablet, (20 mg + 120 mg ) (Co -Formulated) A/M R ARTLUMTA1 \r\n', 70, '', ''),
(360, 'Artesunate + Amodiaquine Granular Powder, (25 mg + 75 mg) A/M R ARTAMOPO1 \r\n', 85, '', ''),
(361, 'Artesunate + Amodiaquine Tablet, (25 mg + 75 mg) (Co-Blistered) A/M R ARTAMOTA2 \r\n', 45, '', ''),
(362, 'Artesunate + Amodiaquine Tablet, (50 mg + 150 mg) (Co -Blistered) A/M R ARTAMOTA1 \r\n', 95, '', ''),
(363, 'Artesunate + Amodiaquine Tablet, (100 mg + 270 mg) (Fixed Dose) A/M R ARTAMOTA5 \r\n', 30, '', ''),
(364, 'Rifampicin Tablet, 300 mg PD NR RIFAMPTA2 \r\n', 25, '', ''),
(365, 'Streptomycin Sulphate Injection, 1 g PD NR STREPTIN1 \r\n', 15, '', ''),
(366, 'Fluconaz ole Tablets, 50 mg C R FLUCONTA1 \r\n', 10, '', ''),
(367, 'Griseofulvin Tablet, 125 mg B2 R GRISEOTA1 \r\n', 55, '', ''),
(368, 'Griseofulvin Tablet, 500 mg B2 R GRISEOTA2 \r\n', 60, '', ''),
(369, 'Itraconazole Tablet, 100 mg D R ITRACOTA1 \r\n', 25, '', ''),
(370, 'Ketoconazole Tablet, 200 mg C R KETOCOTA1 \r\n', 40, '', ''),
(371, 'Miconazole Oral Gel, 20 mg/g C R MICONAOG1 \r\n', 15, '', ''),
(372, 'Nystatin Suspension, 100 000 IU/ml B2 R NYSTATSU1 \r\n', 40, '', ''),
(373, 'Nystatin Tablet, 100 000 IU C R NYSTATTA1 \r\n', 60, '', ''),
(374, 'Nystatin Tablet, 500 000 IU C R NYSTATTA2 \r\n', 30, '', ''),
(375, 'Terbinafine Hydrochloride Tablet, 250 mg D R TERBINTA1 \r\n', 30, '', ''),
(376, 'Metronidazole Injection, 5 mg/ml B2 R METRONIN1 \r\n', 95, '', ''),
(377, 'Metronidazole Suppository, 500 mg B2 R METRONRE1 \r\n', 40, '', ''),
(378, 'Metronidazole Suspension, 100 mg/ 5ml (as benzoate) B1/M R METRONSU1 \r\n', 85, '', ''),
(379, 'Acyclovir Tablet, 200 mg B2 R ACICLOTA1 \r\n', 45, '', ''),
(380, 'Acyclovir Injection, 25 mg/ml C R ACICLOIN1 \r\n', 50, '', ''),
(381, 'Acyclovir Suspension, 200 mg/ 5ml B2 R ACICLOSU2 \r\n', 15, '', ''),
(382, 'Acetyl Salicylic Acid Tablet, 300 mg B1 R ACETYLTA1 \r\n', 40, '', ''),
(383, 'Ergotamine Tartrate Tablet, 1 mg C R ERGTARTA1 \r\n', 5, '', ''),
(384, 'Ergotamine Tartrate Tablet, 2 mg C R ERGTARTA2 \r\n', 80, '', ''),
(385, 'Paracetamol Tablet, 500 mg A/M R PARACETA1 \r\n', 90, '', ''),
(386, 'Propranolol Tablet, 40 mg B2 R PROPRATA2 \r\n', 55, '', ''),
(387, 'Artesunate + Amodiaquine Tablet, (25 mg + 67.5 mg) (Fixed Dose) A/M R ARTAMOTA3 \r\n', 90, '', ''),
(388, 'Artesunate + Amodiaquine Tablet, (50 mg + 135 mg) (Fixed Dose) A/M R ARTAMOTA4 \r\n', 15, '', ''),
(389, 'Artesunate Injection, 60 mg (as Anhydrous Artesunic acid) + 5 % Sodium bicarbonate solution for reconstitution B2 R ARTESUIN1 \r\n', 85, '', ''),
(390, 'Artesunate Suppository, 200 mg A/M R ARTESURE2 \r\n', 70, '', ''),
(391, 'Artesunate Suppository, 50 mg A/M R ARTESURE1 \r\n', 40, '', ''),
(392, 'Arthemether Injection, 40 mg/ml B2 R ARTHEMIN1 \r\n', 70, '', ''),
(393, 'Arthemether Injection, 80 mg/ml B2 R ARTHEMIN2 \r\n', 95, '', ''),
(394, 'Dihydroartemisinin + Piperaquine Tablet, (40 mg + 320 mg) (Co-Formulated) A/M R DIHPIPTA1 \r\n', 95, '', ''),
(395, 'Quinine Dihydrochloride Syrup, 20 mg/ml B2 R QUININSY1 \r\n', 100, '', ''),
(396, 'Quinine Sulphate Tablet, 300 mg B2/M R QUININTA1 \r\n', 5, '', ''),
(397, 'Sulfadoxine + Pyrimethamine Tablet, (500 mg + 25 mg) PD NR SULPYRTA1 \r\n', 60, '', ''),
(398, 'Quinine Dihydrochloride Injection, 300 mg/ml in 2 mls B2 R QUINININ1\r\n', 85, '', ''),
(399, 'Acyclovir Tablet, 200 mg B2 R ACICLOTA1 \r\n', 80, '', ''),
(400, 'Acyclovir Injection, 25 mg/ml C R ACICLOIN1 \r\n', 35, '', ''),
(401, 'Acyclovir Suspension, 200 mg/ 5ml B2 R ACICLOSU2 \r\n', 30, '', ''),
(402, 'Acetyl Salicylic Acid Tablet, 300 mg B1 R ACETYLTA1 \r\n', 70, '', ''),
(403, 'Ergotamine Tartrate Tablet, 1 mg C R ERGTARTA1 \r\n', 50, '', ''),
(404, 'Ergotamine Tartrate Tablet, 2 mg C R ERGTARTA2 \r\n', 5, '', ''),
(405, 'Paracetamol Tablet, 500 mg A/M R PARACETA1 \r\n', 55, '', ''),
(406, 'Propranolol Tablet, 40 mg B2 R PROPRATA2 \r\n', 20, '', ''),
(407, 'Artesunate + Amodiaquine Tablet, (25 mg + 67.5 mg) (Fixed Dose) A/M R ARTAMOTA3 \r\n', 95, '', ''),
(408, 'Artesunate + Amodiaquine Tablet, (50 mg + 135 mg) (Fixed Dose) A/M R ARTAMOTA4 \r\n', 45, '', ''),
(409, 'Artesunate Injection, 60 mg (as Anhydrous Artesunic acid) + 5 % Sodium bicarbonate solution for reconstitution B2 R ARTESUIN1 \r\n', 65, '', ''),
(410, 'Artesunate Suppository, 200 mg A/M R ARTESURE2 \r\n', 95, '', ''),
(411, 'Artesunate Suppository, 50 mg A/M R ARTESURE1 \r\n', 55, '', ''),
(412, 'Arthemether Injection, 40 mg/ml B2 R ARTHEMIN1 \r\n', 70, '', ''),
(413, 'Arthemether Injection, 80 mg/ml B2 R ARTHEMIN2 \r\n', 45, '', ''),
(414, 'Dihydroartemisinin + Piperaquine Tablet, (40 mg + 320 mg) (Co-Formulated) A/M R DIHPIPTA1 \r\n', 75, '', ''),
(415, 'Quinine Dihydrochloride Syrup, 20 mg/ml B2 R QUININSY1 \r\n', 85, '', ''),
(416, 'Quinine Sulphate Tablet, 300 mg B2/M R QUININTA1 \r\n', 30, '', ''),
(417, 'Sulfadoxine + Pyrimethamine Tablet, (500 mg + 25 mg) PD NR SULPYRTA1 \r\n', 35, '', ''),
(418, 'Quinine Dihydrochloride Injection, 300 mg/ml in 2 mls B2 R QUINININ1 \r\n', 30, '', ''),
(419, '5-Fluorouracil Injection, 50 mg/ml D R 5FLUORIN1 \r\n', 60, '', ''),
(420, '6-Mercaptopurine Tablet, 50 mg D NR MERCAPTA1 \r\n', 70, '', ''),
(421, 'Adriamycin Hydrochloride Injection, 10 mg D NR ADRIAMIN1 \r\n', 30, '', ''),
(422, 'Adriamycin Hydrochloride Injection, 50 mg D R ADRIAMIN2 \r\n', 50, '', ''),
(423, 'Bicalutamide Tablet, 150 mg D NR BICALUTA2 \r\n', 10, '', ''),
(424, 'Bicalutamide Tablet, 50 mg D NR BICALUTA1 \r\n', 45, '', ''),
(425, 'Bleomycin Injection, 15 IU D NR BLEOMYIN1 \r\n', 80, '', ''),
(426, 'Busulphan Tablet, 2 mg D NR BUSULFTA2 \r\n', 90, '', ''),
(427, 'Busulphan Tablet, 500 microgram D NR BUSULFTA1 \r\n', 10, '', ''),
(428, 'Capecitabine Tablet, 500 mg D R CAPECITA1 \r\n', 25, '', ''),
(429, 'Chlorambucil Tablet, 2 mg D NR CHLORATA1 \r\n', 80, '', ''),
(430, 'Chlorambucil Tablet, 5 mg D NR CHLORATA2 \r\n', 45, '', ''),
(431, 'Cisplatin Injection, 50 mg D NR CISPLAIN1 \r\n', 5, '', ''),
(432, 'Crisantaspase Injection, 10 000 units D NR CRISANIN1 \r\n', 75, '', ''),
(433, 'Cyclophosphamide Injection, 200 mg D NR CYCLOPIN2 \r\n', 95, '', ''),
(434, 'Cyclophosphamide Injection, 500 mg D R CYCLOPIN1 \r\n', 35, '', ''),
(435, 'Cyclophosphamide Tablet, 50 mg D NR CYCLOPTA1 \r\n', 45, '', ''),
(436, 'Cytarabine Injection, 100 mg D NR CYTARAIN1 \r\n', 95, '', ''),
(437, 'Dacarbazine Injection, 100 mg D NR DACARBIN1 \r\n', 75, '', ''),
(438, 'Daunorubicin Injection, 50 mg D NR DAUNORIN2 \r\n', 95, '', ''),
(439, 'Docetaxel Injection (Concentrate), 20 mg/ 0.5 ml D R DOCETAIN1 \r\n', 65, '', ''),
(440, 'Estramustine Phosphate Capsules, 140 mg D NR ESTPHOCA1 \r\n', 25, '', ''),
(441, 'Estramustine Phosphate Capsules, 280 mg D NR ESTPHOCA2 \r\n', 75, '', ''),
(442, 'Etoposide Capsule, 100 mg D NR ETOPOSCA1 \r\n', 35, '', ''),
(443, 'Etoposide Injection, 20 mg/ml D NR ETOPOSIN1 \r\n', 10, '', ''),
(444, 'Flutamide Tablet, 250 mg D NR FLUTAMTA1 \r\n', 15, '', ''),
(445, 'Folinic Acid Injection, 15 mg D NR FOLINIIN1 \r\n', 45, '', ''),
(446, 'Folinic Acid Tablet, 15 mg D NR FOLINITA1 \r\n', 70, '', ''),
(447, 'Goserelin Injection, 10.8 mg D NR GOSEREIN2 \r\n', 80, '', ''),
(448, 'Goserelin Injection, 3.6 mg D NR GOSEREIN1 \r\n', 55, '', ''),
(449, 'Hydroxycarbamide Capsule, 500 mg B2 NR HYDCARTA2 \r\n', 5, '', ''),
(450, 'Imatinib Tablet, 100 mg D NR IMATINTA1 \r\n', 80, '', ''),
(451, 'Imatinib Tablet, 400 mg D NR IMATINTA2 \r\n', 70, '', ''),
(452, 'Leuprolide Acetate Injection, 3.75 mg/ml D NR LEUPROIN1 \r\n', 75, '', ''),
(453, 'Methotrexate Injection, 2.5 mg/ml D R METHOTIN1 \r\n', 30, '', ''),
(454, 'Methotrexate Injection, 25 mg/ml D R METHOTIN2 \r\n', 55, '', ''),
(455, 'Methotrexate Tablet, 10 mg D R METHOTTA2 \r\n', 95, '', ''),
(456, 'Methotrexate Tablet, 2.5 mg D R METHOTTA1 \r\n', 100, '', ''),
(457, 'Mitoxantrone Injection, 2 mg/ml D NR MITOXAIN1 \r\n', 75, '', ''),
(458, 'OncoTICE (Bacillus Calmette-BCG, Strain TICE) Injection SD NR ONCOTIIN1 \r\n', 60, '', ''),
(459, 'Procarbazine Tablet, 50 mg D NR PROCARTA1 \r\n', 80, '', ''),
(460, 'Stilboestrol Tablet, 1 mg D NR STILBOTA1 \r\n', 5, '', ''),
(461, 'Stilboestrol Tablet, 2 mg D NR STILBOTA2 \r\n', 80, '', ''),
(462, 'Stilboestrol Tablet, 5 mg D NR STILBOTA3 \r\n', 55, '', ''),
(463, 'Thiotepa Injection, 15 mg SD NR THIOTEIN1 \r\n', 10, '', ''),
(464, 'Vinblastine Injection, 1 mg/ml D NR VINBLAIN1 \r\n', 10, '', ''),
(465, 'Vincristine Injection, 1 mg D NR VINCRIIN1 \r\n', 20, '', ''),
(466, 'Vincristine Injection, 2 mg D NR VINCRIIN2 \r\n', 65, '', ''),
(467, 'Vincristine Injection, 5 mg D NR VINCRIIN3 \r\n', 10, '', ''),
(468, 'Prednisolone Tablet, 5 mg B2 R PREDNITA1 \r\n', 85, '', ''),
(469, 'Benzatropine Tablet, 2 mg C R BENZATTA1 \r\n', 75, '', ''),
(470, 'Biperiden Injection, 5 mg/ml C NR BIPERIIN1 \r\n', 30, '', ''),
(471, 'Biperiden Tablet, 2 mg C NR BIPERITA1 \r\n', 30, '', ''),
(472, 'Trihexyphenidyl Tablet, 2 mg C R TRIHEXTA1 \r\n', 80, '', ''),
(473, 'Trihexyphenidyl Tablet, 5 mg C R TRIHEXTA2 \r\n', 65, '', ''),
(474, 'Flutamide Tablet, 250 mg D NR FLUTAMTA1 \r\n', 80, '', ''),
(475, 'Folinic Acid Injection, 15 mg D NR FOLINIIN1 \r\n', 75, '', ''),
(476, 'Folinic Acid Tablet, 15 mg D NR FOLINITA1 \r\n', 65, '', ''),
(477, 'Goserelin Injection, 10.8 mg D NR GOSEREIN2 \r\n', 30, '', ''),
(478, 'Goserelin Injection, 3.6 mg D NR GOSEREIN1 \r\n', 80, '', ''),
(479, 'Hydroxycarbamide Capsule, 500 mg B2 NR HYDCARTA2 \r\n', 85, '', ''),
(480, 'Imatinib Tablet, 100 mg D NR IMATINTA1 \r\n', 40, '', ''),
(481, 'Imatinib Tablet, 400 mg D NR IMATINTA2 \r\n', 5, '', ''),
(482, 'Leuprolide Acetate Injection, 3.75 mg/ml D NR LEUPROIN1 \r\n', 15, '', ''),
(483, 'Methotrexate Injection, 2.5 mg/ml D R METHOTIN1 \r\n', 10, '', ''),
(484, 'Methotrexate Injection, 25 mg/ml D R METHOTIN2 \r\n', 35, '', ''),
(485, 'Methotrexate Tablet, 10 mg D R METHOTTA2 \r\n', 80, '', ''),
(486, 'Methotrexate Tablet, 2.5 mg D R METHOTTA1 \r\n', 80, '', ''),
(487, 'Mitoxantrone Injection, 2 mg/ml D NR MITOXAIN1 \r\n', 75, '', ''),
(488, 'OncoTICE (Bacillus Calmette-BCG, Strain TICE) Injection SD NR ONCOTIIN1 \r\n', 40, '', ''),
(489, 'Procarbazine Tablet, 50 mg D NR PROCARTA1 \r\n', 30, '', ''),
(490, 'Stilboestrol Tablet, 1 mg D NR STILBOTA1 \r\n', 85, '', ''),
(491, 'Stilboestrol Tablet, 2 mg D NR STILBOTA2 \r\n', 90, '', ''),
(492, 'Stilboestrol Tablet, 5 mg D NR STILBOTA3 \r\n', 55, '', ''),
(493, 'Thiotepa Injection, 15 mg SD NR THIOTEIN1 \r\n', 35, '', ''),
(494, 'Vinblastine Injection, 1 mg/ml D NR VINBLAIN1 \r\n', 55, '', ''),
(495, 'Vincristine Injection, 1 mg D NR VINCRIIN1 \r\n', 80, '', ''),
(496, 'Vincristine Injection, 2 mg D NR VINCRIIN2 \r\n', 70, '', ''),
(497, 'Vincristine Injection, 5 mg D NR VINCRIIN3 \r\n', 65, '', ''),
(498, 'Prednisolone Tablet, 5 mg B2 R PREDNITA1 \r\n', 35, '', ''),
(499, 'Benzatropine Tablet, 2 mg C R BENZATTA1 \r\n', 35, '', ''),
(500, 'Biperiden Injection, 5 mg/ml C NR BIPERIIN1 \r\n', 20, '', ''),
(501, 'Biperiden Tablet, 2 mg C NR BIPERITA1 \r\n', 60, '', ''),
(502, 'Trihexyphenidyl Tablet, 2 mg C R TRIHEXTA1 \r\n', 15, '', ''),
(503, 'Trihexyphenidyl Tablet, 5 mg C R TRIHEXTA2 \r\n', 55, '', ''),
(504, 'Ferrous Sulphate + Folic Acid Tablet, (60 mg + 250 microgram) A/M R FESUFOTA1\r\n', 70, '', ''),
(505, 'Ferrous Fumarate Tablet, (100 mg Elemental Iron) B1/M R FERFUMTA1 \r\n', 80, '', ''),
(506, 'Ferrous Sulphate (BPC) Syrup, 60 mg/ 5 ml B1/M R FERSULSY1 \r\n', 35, '', ''),
(507, 'Ferrous Sulphate Tablet, (60 mg Elemental Iron) B1/M R FERSULTA1 \r\n', 35, '', ''),
(508, 'Folic Acid Tablet, 5 mg B1/M R FOLACITA1 \r\n', 5, '', ''),
(509, 'Hydroxycobalamine Injection, 1 mg/ml D R HYDROXIN1 \r\n', 60, '', ''),
(510, 'Iron Dextran Injection, 100 mg/ 2 ml C R IRODEXIN1 \r\n', 70, '', ''),
(511, 'Iron Sucrose Injection, 20 mg/ml D R IROSUCIN1 \r\n', 85, '', ''),
(512, 'Acetyl Salicylic Acid Tablet, 75 mg (Dispersible) C R ACETYLDT1 \r\n', 65, '', ''),
(513, 'Heparin [Low molecular weight] Injection, 4000 units/ml C R HEPARIIN4 \r\n', 55, '', ''),
(514, 'Heparin Injection, 1000 units/ml D R HEPARIIN1 \r\n', 65, '', ''),
(515, 'Heparin Injection, 5000 units/ 0.2 ml D R HEPARIIN2 \r\n', 10, '', ''),
(516, 'Heparin Injection, 5000 units/ml D R HEPARIIN3 \r\n', 5, '', ''),
(517, 'Phytomenadione Tablet, 10 mg B2 NR PHYTOMTA1 \r\n', 80, '', ''),
(518, 'Phytomenadione Injection, 1 mg/ml M R PHYTOMIN1 \r\n', 70, '', ''),
(519, 'Phytomenadione Injection, 10 mg/ml B2 R PHYTOMIN2 \r\n', 95, '', ''),
(520, 'Protamine sulphate Injection, 10 mg/ml D R PROSULIN1 \r\n', 5, '', ''),
(521, 'Streptokinase Injection, 100 000 units D R STREPKIN1 \r\n', 75, '', ''),
(522, 'Streptokinase Injection, 250 000 units D R STREPKIN2 \r\n', 85, '', ''),
(523, 'Streptokinase Injection, 750 000 units D R STREPKIN3 \r\n', 20, '', ''),
(524, 'Tirofiban Infusion, 250 micrograms/ml (Concentrate) D R TIROFIIN2 \r\n', 85, '', ''),
(525, 'Tirofiban Infusion, 50 micrograms/ml D R TIROFIIN1 \r\n', 85, '', ''),
(526, 'Tranexamic Acid Capsule, 250 mg D R TRAACICA1 \r\n', 100, '', ''),
(527, 'Tranexamic Acid Injection, 100 mg/ml D R TRAACIIN1 \r\n', 55, '', ''),
(528, 'Tranexamic Acid Tablet, 500 mg D R TRAACITA1 \r\n', 25, '', ''),
(529, 'Warfarin Tablet, 5 mg (Scored) D R WARFARTA3 \r\n', 45, '', ''),
(530, 'Warfarin Tablet, 1 mg D R WARFARTA1 \r\n', 30, '', ''),
(531, 'Warfarin Tablet, 3 mg D R WARFARTA2 \r\n', 30, '', ''),
(532, 'Cryoprecipitate B2 NR CRYOPRIN1 \r\n', 15, '', ''),
(533, 'Fresh Frozen Plasma B2 NR FRFRPLIN1\r\n', 20, '', ''),
(534, 'Gelatin Infusion (Succinylated Gelatin) B2 R GELATIIN1 \r\n', 95, '', ''),
(535, 'Packed Red Cells B2 NR PARECEIN1 \r\n', 55, '', ''),
(536, 'Platelet Concentrate B2 NR PLACONIN1 \r\n', 75, '', ''),
(537, 'Glyceryl Trinitrate Sublingual Tablet, 500 microgram C R GLTRSUTA1 \r\n', 5, '', ''),
(538, 'Isosorbide Dinitrate Sublingual Tablet, 5 mg C R ISDISUTA1 \r\n', 30, '', ''),
(539, 'Isosorbide Dinitrate Tablet, 10 mg C R ISODINTA1 \r\n', 40, '', ''),
(540, 'Nifedipine Tablet, 10 mg (Slow-Release) B2 R NIFEDITA1 \r\n', 30, '', ''),
(541, 'Nifedipine Tablet, 20 mg (Slow -Release) B2 R NIFEDITA2 \r\n', 35, '', ''),
(542, 'Nifedipine Tablet, 30 mg (GITS) B2 R NIFEDITA3 \r\n', 100, '', ''),
(543, 'Propranolol Tablet, 10 mg B2 R PROPRATA1 \r\n', 75, '', ''),
(544, 'Propranolol Tablet, 40 mg B2 R PROPRATA2 \r\n', 5, '', ''),
(545, 'Propranolol Tablet, 80 mg B2 R PROPRATA3 \r\n', 35, '', ''),
(546, 'Lidocaine Injection, 20 mg/ml B2 R LIDOCAIN3 \r\n', 60, '', ''),
(547, 'Amlodipine Tablet, 5 mg B2 R AMLODITA1 \r\n', 5, '', ''),
(548, 'Amlodipine Tablet, 10 mg B2 R AMLODITA2 \r\n', 70, '', ''),
(549, 'Atenolol + Hydrochlorthiazide Tablet, (100 mg + 25 mg) B2 R ATEHYDTA2 \r\n', 70, '', ''),
(550, 'Atenolol + Hydrochlorthiazide Tablet, (50 mg + 25 mg) B2 R ATEHYDTA1 \r\n', 25, '', ''),
(551, 'Atenolol Injection, 500 microgram/ml D R ATENOLIN1 \r\n', 35, '', ''),
(552, 'Atenolol Tablet, 100 mg C R ATENOLTA3 \r\n', 15, '', ''),
(553, 'Atenolol Tablet, 25 mg B2 R ATENOLTA1 \r\n', 75, '', ''),
(554, 'Atenolol Tablet, 50 mg B2 R ATENOLTA2 \r\n', 100, '', ''),
(555, 'Bendroflumethiazide Tablet, 2.5 mg B2 R BENDROTA1 \r\n', 50, '', ''),
(556, 'Bendroflumethiazide Tablet, 5 mg B2 R BENDROTA2 \r\n', 95, '', ''),
(557, 'Bisoprolol Tablet, 5 mg D NR BISOPRTA1 \r\n', 35, '', ''),
(558, 'Bisoprolol Tablet, 10 mg D NR BISOPRTA2 \r\n', 55, '', ''),
(559, 'Candesartan Tablet, 8 mg D NR CANDESTA1 \r\n', 70, '', ''),
(560, 'Candesartan Tablet, 16 mg D NR CANDESTA2 \r\n', 85, '', ''),
(561, 'Dobutamine Injection, 12.5 mg/ml D NR DOBUTAIN1 \r\n', 90, '', ''),
(562, 'Hydralazine Injection, 20 mg C R HYDRALIN1 \r\n', 40, '', ''),
(563, 'Hydralazine Tablet, 25 mg C R HYDRALTA1 \r\n', 50, '', ''),
(564, 'Labetalol Injection, 5 mg/ml D R LABETAIN1 \r\n', 50, '', ''),
(565, 'Losartan Tablet, 25 mg D R LOSARTTA1 \r\n', 5, '', ''),
(566, 'Losartan Tablet, 50 mg D R LOSARTTA2 \r\n', 70, '', ''),
(567, 'Losartan Tablet, 100 mg D R LOSARTTA3 \r\n', 80, '', ''),
(568, 'Methyldopa Tablet, 250 mg B2 R METHYLTA1 \r\n', 35, '', ''),
(569, 'Nifedipine Capsule, 5 mg D R NIFEDICA1 \r\n', 25, '', ''),
(570, 'Nifedipine Capsule, 10 mg D R NIFEDICA2 \r\n', 55, '', ''),
(571, 'Nifedipine Tablet, 10 mg (Slow-Release) B2 R NIFEDITA1 \r\n', 80, '', ''),
(572, 'Nifedipine Tablet, 20 mg (Slow-Release) B2 R NIFEDITA2 \r\n', 65, '', ''),
(573, 'Nifedipine Tablet, 30 mg (GITS) B2 R NIFEDITA3 \r\n', 40, '', ''),
(574, 'Prazosin Tablet, 500 microgram D R PRAZOSTA1 \r\n', 5, '', ''),
(575, 'Propranolol Injection, 1 mg/ml D R PROPRAIN1 \r\n', 100, '', ''),
(576, 'Propranolol Tablet, 10 mg B2 R PROPRATA1 \r\n', 30, '', ''),
(577, 'Propranolol Tablet, 40 mg B2 R PROPRATA2 \r\n', 25, '', ''),
(578, 'Propranolol Tablet, 80 mg B2 R PROPRATA3 \r\n', 50, '', ''),
(579, 'Ramipril Tablet, 2.5 mg C R RAMIPRTA1 \r\n', 50, '', ''),
(580, 'Digoxin Elixir, 50 microgram/ml C R DIGOXIEL1 \r\n', 45, '', ''),
(581, 'Digoxin Tablet, 125 microgram C R DIGOXITA1 \r\n', 35, '', ''),
(582, 'Digoxin Tablet, 250 microgram C R DIGOXITA2 \r\n', 60, '', ''),
(583, 'Atorvastatin Tablet, 10 mg C R ATORVATA1 \r\n', 10, '', ''),
(584, 'Atorvastatin Tablet, 20 mg C R ATORVATA2 \r\n', 70, '', ''),
(585, 'Fluvastatin Capsule, 20 mg D R FLUVASCA1 \r\n', 5, '', ''),
(586, 'Rosuvastatin Tablet, 5 mg D R ROSUVATA1 \r\n', 95, '', ''),
(587, 'Rosuvastatin Tablet, 10 mg D R ROSUVATA2 \r\n', 100, '', ''),
(588, 'Simvastatin Tablet, 10 mg C R SIMVASTA1 \r\n', 55, '', ''),
(589, 'Simvastatin Tablet, 20 mg C R SIMVASTA2 \r\n', 20, '', ''),
(590, 'Simvastatin Tablet, 40 mg D R SIMVASTA3 \r\n', 100, '', ''),
(591, 'Simvastatin Tablet, 80 mg D R SIMVASTA4 \r\n', 90, '', ''),
(592, 'Bisoprolol Tablet, 5 mg D NR BISOPRTA1 \r\n', 15, '', ''),
(593, 'Bisoprolol Tablet, 10 mg D NR BISOPRTA2 \r\n', 70, '', ''),
(594, 'Candesartan Tablet, 8 mg D NR CANDESTA1 \r\n', 70, '', ''),
(595, 'Candesartan Tablet, 16 mg D NR CANDESTA2 \r\n', 30, '', ''),
(596, 'Dobutamine Injection, 12.5 mg/ml D NR DOBUTAIN1 \r\n', 30, '', ''),
(597, 'Hydralazine Injection, 20 mg C R HYDRALIN1 \r\n', 55, '', ''),
(598, 'Hydralazine Tablet, 25 mg C R HYDRALTA1 \r\n', 55, '', ''),
(599, 'Labetalol Injection, 5 mg/ml D R LABETAIN1 \r\n', 30, '', ''),
(600, 'Losartan Tablet, 25 mg D R LOSARTTA1 \r\n', 70, '', ''),
(601, 'Losartan Tablet, 50 mg D R LOSARTTA2 \r\n', 15, '', ''),
(602, 'Losartan Tablet, 100 mg D R LOSARTTA3 \r\n', 80, '', ''),
(603, 'Methyldopa Tablet, 250 mg B2 R METHYLTA1 \r\n', 10, '', ''),
(604, 'Nifedipine Capsule, 5 mg D R NIFEDICA1 \r\n', 45, '', ''),
(605, 'Nifedipine Capsule, 10 mg D R NIFEDICA2 \r\n', 90, '', ''),
(606, 'Nifedipine Tablet, 10 mg (Slow-Release) B2 R NIFEDITA1 \r\n', 30, '', ''),
(607, 'Nifedipine Tablet, 20 mg (Slow-Release) B2 R NIFEDITA2 \r\n', 75, '', ''),
(608, 'Nifedipine Tablet, 30 mg (GITS) B2 R NIFEDITA3 \r\n', 95, '', ''),
(609, 'Prazosin Tablet, 500 microgram D R PRAZOSTA1 \r\n', 80, '', ''),
(610, 'Propranolol Injection, 1 mg/ml D R PROPRAIN1 \r\n', 50, '', ''),
(611, 'Propranolol Tablet, 10 mg B2 R PROPRATA1 \r\n', 95, '', ''),
(612, 'Propranolol Tablet, 40 mg B2 R PROPRATA2 \r\n', 75, '', ''),
(613, 'Propranolol Tablet, 80 mg B2 R PROPRATA3 \r\n', 90, '', ''),
(614, 'Ramipril Tablet, 2.5 mg C R RAMIPRTA1 \r\n', 40, '', ''),
(615, 'Digoxin Elixir, 50 microgram/ml C R DIGOXIEL1 \r\n', 60, '', ''),
(616, 'Digoxin Tablet, 125 microgram C R DIGOXITA1 \r\n', 90, '', ''),
(617, 'Digoxin Tablet, 250 microgram C R DIGOXITA2 \r\n', 95, '', ''),
(618, 'Atorvastatin Tablet, 10 mg C R ATORVATA1 \r\n', 5, '', ''),
(619, 'Atorvastatin Tablet, 20 mg C R ATORVATA2 \r\n', 70, '', ''),
(620, 'Fluvastatin Capsule, 20 mg D R FLUVASCA1 \r\n', 20, '', ''),
(621, 'Rosuvastatin Tablet, 5 mg D R ROSUVATA1 \r\n', 100, '', ''),
(622, 'Rosuvastatin Tablet, 10 mg D R ROSUVATA2 \r\n', 50, '', ''),
(623, 'Simvastatin Tablet, 10 mg C R SIMVASTA1 \r\n', 70, '', ''),
(624, 'Simvastatin Tablet, 20 mg C R SIMVASTA2 \r\n', 35, '', ''),
(625, 'Simvastatin Tablet, 40 mg D R SIMVASTA3 \r\n', 85, '', ''),
(626, 'Simvastatin Tablet, 80 mg D R SIMVASTA4 \r\n', 5, '', ''),
(627, 'Hydrocortisone Sodium Succinate Injection, 100 mg B1/M R HYSOSUIN1 \r\n', 20, '', ''),
(628, 'Benzoic Acid + Salicylic Acid Ointment, (6 % + 3 %) B1 R BEACSAOI1 \r\n', 90, '', ''),
(629, 'Ciclopirox Olamine Cream, 1 % B1/M R CICOLACR1 \r\n', 40, '', ''),
(630, 'Clotrimazole + Hydrocortisone Cream, (2 % + 1 % ) C NR CLOHYDCR2 \r\n', 15, '', ''),
(631, 'Clotrimazole Cream, 2 % B2 R CLOTRICR2 \r\n', 90, '', ''),
(632, 'Clotrimazole Pessary, 100 mg B2/M R CLOTRIVP1 \r\n', 100, '', ''),
(633, 'Clotrimazole Topical Solution, 1 % B2 R CLOTRISO1 \r\n', 85, '', ''),
(634, 'Clotrimazole Vaginal Tablet, 200 mg B2/M R CLOTRIVP2 \r\n', 55, '', ''),
(635, 'Gentian Violet Paint, 1 % A/M R GENVIPSO1 \r\n', 45, '', ''),
(636, 'Miconazole Cream, 2 % B2 R MICONACR1 \r\n', 90, '', ''),
(637, 'Miconazole Oral Gel, 24 mg/ml B2 R MICONAOG1 \r\n', 65, '', ''),
(638, 'Selenium Sulphide Shampoo, 2.5 % C R SELSULSH1 \r\n', 95, '', ''),
(639, 'Cetrimide + Chlorhexidine Gluconate Solution, (0.15 % + 0.015 %) B1 R CETCHLSO1 \r\n', 5, '', ''),
(640, 'Cetrimide + Chlorhexidine Gluconate Solution, (15 % + 1.5 %) B1 R CETCHLSO2 \r\n', 15, '', ''),
(641, 'Cetrimide Cream, 0.5 % B1/M R CETRIMCR1 \r\n', 5, '', ''),
(642, 'Acyclovir Cream, 5 % C R ACICLOCR1 \r\n', 5, '', ''),
(643, 'Cetrimide Solution B1/M NR CETRIMSO1\r\n', 75, '', ''),
(644, 'Chlorhexidine Cream, 1 % B1/M R CHLORHCR1 \r\n', 35, '', ''),
(645, 'Chlorhexidine Solution, 2.5 % B1/M R CHLORHSO2 \r\n', 35, '', ''),
(646, 'Crotamiton Lotion, 10 % B1 R CROTAMLO1 \r\n', 45, '', ''),
(647, 'Betamethasone Valerate Cream, 0.05 % D R BETVALCR1 \r\n', 35, '', ''),
(648, 'Betamethasone Valerate Cream, 0.1 % D R BETVALCR2 \r\n', 30, '', ''),
(649, 'Calamine Cream, 15 % B1/M R CALAMICR1\r\n', 35, '', ''),
(650, 'Calamine Lotion, 15 % B1/M R CALAMILO1 \r\n', 50, '', ''),
(651, 'Silver Sulphadiazine Cream, 1 % C R SILSULCR1 \r\n', 20, '', ''),
(652, 'Hydrocortisone Cream, 1 % B1 R HYDROCCR1 \r\n', 95, '', ''),
(653, 'Salicylic Acid Ointment, 2 % B1 R SALACIOI1 \r\n', 75, '', ''),
(654, 'Benzyl Benzoate Lotion, 25 % B2 R BENBENLO1 \r\n', 70, '', ''),
(655, 'Lindane Lotion, 1 % B2 R LINDANLO1 \r\n', 10, '', ''),
(656, 'Aqueous Cream BP B1 R AQUEOUCR1 \r\n', 65, '', ''),
(657, 'Benzoyl Peroxide Solution, 5 % C R BENPERSO1\r\n', 5, '', ''),
(658, 'Benzoyl Peroxide Solution, 10 % C R BENPERSO2 \r\n', 100, '', ''),
(659, 'Clindamycin Solution, 1 % C R CLINDASO1 \r\n', 15, '', ''),
(660, 'Mercurochrome Solution B2 R MERCURSO1\r\n', 95, '', ''),
(661, 'Fluorescein Solution, 2 % C NR FLUORESO1\r\n', 90, '', ''),
(662, 'Fluorescein Strips C NR FLUOREST1\r\n', 25, '', ''),
(663, 'Methylcellulose Eye Drops, 1 % D NR METHYLID1\r\n', 35, '', ''),
(664, 'Methylcellulose Eye Drops, 1 % D NR METHYLID2\r\n', 20, '', ''),
(665, 'Rose Bengal Minims, 1 % D NR ROSBENMI1 \r\n', 100, '', ''),
(666, 'Tropicamide Eye Drops, 1 % C NR TROPICID1 \r\n', 35, '', ''),
(667, 'Diagnostic Strips -Glucose B1 NR DIASTRGL1\r\n', 55, '', ''),
(668, 'Diagnostic Strips -Multipurpose B2 NR DIASTRMU1 \r\n', 65, '', ''),
(669, 'Diagnostic Strips -Protein B2 NR DIASTRPR1 \r\n', 50, '', ''),
(670, 'Diagnostic Tablets -Glucose B1 NR DIATABGL1\r\n', 35, '', ''),
(671, 'Diagnostic Tablets -Ketones B1 NR DIATABKE1 \r\n', 30, '', ''),
(672, 'Edrophonium Injection, 10 mg/ml D NR EDROPHIN1 \r\n', 80, '', ''),
(673, 'Chlorhexidine Cream, 1 % B1 R CHLORHCR1 \r\n', 100, '', ''),
(674, 'Chlorhexidine Solution, 2.5 % B1/M R CHLORHSO2 \r\n', 45, '', ''),
(675, 'Chlorhexidine Solution, 4 % in detergent base B2 NR CHLORHSO1 \r\n', 25, '', ''),
(676, 'Povidone Iodine (aq.) Solution, 10 % B1 R POVIDOSO1 \r\n', 5, '', '');
INSERT INTO `drugs` (`treatmentid`, `treatment`, `price`, `icd10`, `gdrg`) VALUES
(677, 'Bendroflumethiazide Tablet, 2.5 mg B2 R BENDROTA1 \r\n', 70, '', ''),
(678, 'Bendroflumethiazide Tablet, 5 mg B2 R BENDROTA2 \r\n', 70, '', ''),
(679, 'Furosemide Injection, 10 mg/ml B2 R FUROSEIN1 \r\n', 60, '', ''),
(680, 'Furosemide Tablet, 40 mg B2 R FUROSETA1 \r\n', 80, '', ''),
(681, 'Mannitol Injection, 10 % C R MANNITIN1 \r\n', 90, '', ''),
(682, 'Mannitol Injection, 20 % C R MANNITIN2 \r\n', 50, '', ''),
(683, 'Metolazone Tablet, 5 mg D R METOLATA1 \r\n', 30, '', ''),
(684, 'Spironolactone Tablet, 25 mg C R SPIRONTA1 \r\n', 70, '', ''),
(685, 'Spironolactone Tablet, 50 mg C R SPIRONTA2 \r\n', 50, '', ''),
(686, 'Calcium Carbonate Tablet, 500 mg B1 R CALCARTA1 \r\n', 80, '', ''),
(687, 'Esomeprazole Capsule, 20 mg D R ESOMEPCA1 \r\n', 80, '', ''),
(688, 'Esomeprazole Capsule, 40 mg D R ESOMEPCA2 \r\n', 65, '', ''),
(689, 'Esomeprazole Injection, 40 mg D NR ESOMEPIN1 \r\n', 40, '', ''),
(690, 'Magnesium Trisilicate Mixture A/M R MAGTRIMI1 \r\n', 15, '', ''),
(691, 'Magnesium Trisilicate Tablet, 500 mg A/M R MAGTRITA1 \r\n', 55, '', ''),
(692, 'Omeprazole Capsule, 20 mg D R OMEPRATA1 \r\n', 20, '', ''),
(693, 'Rabeprazole Capsule, 10 mg D NR RABEPRCA1 \r\n', 80, '', ''),
(694, 'Rabeprazole Capsule, 20 mg D R RABEPRCA2 \r\n', 70, '', ''),
(695, 'Ranitidine Injection, 25 mg/ml C NR RANITIIN1 \r\n', 90, '', ''),
(696, 'Ranitidine Tablet, 150 mg C R RANITITA1 \r\n', 80, '', ''),
(697, 'Dexamethasone Tablet, 1 mg D R DEXAMETA2 \r\n', 20, '', ''),
(698, 'Dexamethasone Tablet, 500 microgram D R DEXAMETA1 \r\n', 80, '', ''),
(699, 'Domperidone Tablet, 10 mg D R DOMPERTA1 \r\n', 55, '', ''),
(700, 'Granisetron Injection, 1 mg/ml D R GRANISIN1 \r\n', 70, '', ''),
(701, 'Granisetron Tablet, 1 mg D R GRANISTA1 \r\n', 20, '', ''),
(702, 'Metoclopramide Injection, 5 mg/ml C R METOCLIN1 \r\n', 95, '', ''),
(703, 'Metoclopramide Tablet, 10 mg C R METOLATA1 \r\n', 65, '', ''),
(704, 'Promethazine Hydrochloride Elixir, 5 mg/ 5 ml B1/M R PROHYDEL1 \r\n', 20, '', ''),
(705, 'Promethazine Hydrochloride Injection, 25 mg/ml B1/M R PROHYDIN1 \r\n', 65, '', ''),
(706, 'Promethazine Teoclate Tablet, 25 mg B1/M R PROTHETA1 \r\n', 100, '', ''),
(707, 'Hyoscine -N-Butyl -Bromide Injection, 20 mg/ml B1/M R HYOBUTIN1 \r\n', 95, '', ''),
(708, 'Hyoscine -N-Butyl- Bromide Tablet, 10 mg B1/M R HYOBUTTA1 \r\n', 10, '', ''),
(709, 'Mebeverine Tablet, 135 mg C R MEBEVETA1 \r\n', 20, '', ''),
(710, 'Bisacodyl Suppository, 10 mg B2 NR BISACORE1 \r\n', 20, '', ''),
(711, 'Bisacodyl Tablet, 5 mg B2 R BISACOTA1 \r\n', 25, '', ''),
(712, 'Lactulose Liquid, 3.1 -3.7g/ 5 ml C R LACTULLI1 \r\n', 70, '', ''),
(713, 'Magnesium Sulphate, Salt C R MAGSULPO1 \r\n', 80, '', ''),
(714, 'Paraffin Liquid A/M R PARAFFLI1 \r\n', 85, '', ''),
(715, 'Senna Syrup, 7.5 mg/ 5 ml B1 NR SENNA SY1 \r\n', 20, '', ''),
(716, 'Senna Tablet, 7.5 mg B1 NR SENNA TA1 \r\n', 85, '', ''),
(717, 'Soothing Agent + Local Anaesthetic Sup pository M R SOOANARE1 \r\n', 60, '', ''),
(718, 'Soothing Agent + Local Anaesthetic Ointment M R SOOANAOI1 \r\n', 35, '', ''),
(719, 'Soothing Agent + Local Anaesthetic + Steroid Suppository B2 R SOANSTRE1 \r\n', 5, '', ''),
(720, 'Soothing Agent + Local Anaesthetic + Steroid Ointment B2 R SOANSTOI1 \r\n', 95, '', ''),
(721, 'Oral Rehydration Salts Sachet A/M R ORRESAPO1 \r\n', 75, '', ''),
(722, 'Oral Rehydration Salts + Zinc Sachet A/M R ORRESAPO2 \r\n', 90, '', ''),
(723, 'Codeine Tablet, 30 mg B2 R CODEINTA1 \r\n', 100, '', ''),
(724, 'Dexamethasone Injection, 4 mg/ml C R DEXAMEIN1 \r\n', 25, '', ''),
(725, 'Hydrocortisone Sodium Succinate Injection, 100 mg B1/M R HYSOSUIN1 \r\n', 35, '', ''),
(726, 'Prednisolone Tablet, 5 mg B2 R PREDNITA1 \r\n', 70, '', ''),
(727, 'Condoms (Female) A/PD NR CONDOMFE \r\n', 95, '', ''),
(728, 'Condoms (Male) A/PD NR CONDOMMA \r\n', 70, '', ''),
(729, 'Ethinylestradiol + Levonorgestrel \r\n', 25, '', ''),
(730, '(Injectable Contraceptives) PD NR ETHLEVIN1 \r\n', 75, '', ''),
(731, 'Ethinylestradiol + Levonorgestrel (Oral Hormonal Contraceptives) PD NR ETHLEVTA1 \r\n', 40, '', ''),
(732, 'Ethinylestradiol + Norethisterone (Oral Contraceptives) PD NR ETHNORTA1 \r\n', 35, '', ''),
(733, 'Levonorgestrel 0.75 mg (Oral contraceptive, mini pill) PD NR LEVONOTA1 \r\n', 95, '', ''),
(734, 'Levonorgestrel Emergency Contraceptives, 1.5 mg PD NR LEVONOTA2 \r\n', 15, '', ''),
(735, 'Levonorgestrel Implant Contraceptives PD NR LEVONOTA3 \r\n', 90, '', ''),
(736, 'Levonorgestrel Intra Uterine Contraceptives (Hormonal) PD NR LEINUTIN1 \r\n', 80, '', ''),
(737, 'Medroxyprogesterone Acetate Injection, 150 mg (Depot) PD NR MEDACEIN1 \r\n', 80, '', ''),
(738, 'Conjugated Oestrogen + Norgesterol Tablet, 625 microgram + 150 microgram C R COOENOTA1 \r\n', 20, '', ''),
(739, 'Conju gated Oestrogen Tablet, 625 microgram D R CONOESTA1 \r\n', 20, '', ''),
(740, 'Conjugated Oestrogen Vaginal cream, 625 micrograms/g D R CONOESVC1 \r\n', 65, '', ''),
(741, 'Gliclazide Tablet, 80 mg C R GLICLATA1 \r\n', 100, '', ''),
(742, 'Glibenclamide Tablet, 5 mg B2 R GLIBENTA1 \r\n', 55, '', ''),
(743, 'Glimepiride Tablet, 1 mg C R GLIMEPTA1 \r\n', 10, '', ''),
(744, 'Glimepiride Tablet, 2 mg C R GLIMEPTA2 \r\n', 70, '', ''),
(745, 'Glimepiride Tablet, 4 mg C R GLIMEPTA4 \r\n', 100, '', ''),
(746, 'Glucagon Injection, 1 mg C R GLUCAGIN1 \r\n', 35, '', ''),
(747, 'Insulin aspart, 100 units/ml D NR INSASPIN1 \r\n', 95, '', ''),
(748, 'Insulin detemir, 100 units/ml D NR INSDETIN1 \r\n', 95, '', ''),
(749, 'Insulin glargine, 100 units/ml D NR INSGLAIN1 \r\n', 85, '', ''),
(750, 'Insulin lispro, 100 units/ml D NR INSLISIN1 \r\n', 40, '', ''),
(751, 'Insulin pre -mixed (30/70) HM Injection, 100 units/ml C R INPRMIIN1 \r\n', 20, '', ''),
(752, 'Insulin Soluble HM, 100 units/ml C R INSSOLIN1 \r\n', 35, '', ''),
(753, 'Isophane Insulin Injection (HM), 100 units/ml C R ISOINSIN1 \r\n', 10, '', ''),
(754, 'Metformin Tablet, 500 mg B2 R METFORTA1 \r\n', 5, '', ''),
(755, 'Pioglitazone Tablet, 15 mg C R PIOGLITA1 \r\n', 25, '', ''),
(756, 'Pioglitazone Tablet, 30 mg C R PIOGLITA2 \r\n', 95, '', ''),
(757, 'Rosiglitazone Tablet, 4 mg C R ROSIGLTA1 \r\n', 25, '', ''),
(758, 'Tolbutamide Tablet, 500 mg B2 R TOLBUTTA1 \r\n', 45, '', ''),
(759, 'Clomifene Citrate Tablet, 50 mg D NR CLOMIFTA1 \r\n', 45, '', ''),
(760, 'Medroxyprogesterone Acetate Tablet, 5 mg D R MEDACETA1 \r\n', 15, '', ''),
(761, 'Norethisterone Tablet, 5 mg D R NORETHTA1 \r\n', 55, '', ''),
(762, 'Carbimazole Tablet, 20 mg C R CARBIMTA2 \r\n', 50, '', ''),
(763, 'Carbimazole Tablet, 5 mg C R CARBIMTA1 \r\n', 60, '', ''),
(764, 'Levothyroxine Tablet, 100 microgram C R LEVSODTA3 \r\n', 10, '', ''),
(765, 'Levothyroxine Tablet, 50 microgram C R LEVSODTA2 \r\n', 75, '', ''),
(766, 'Propylthiouracil Tablet, 50 mg D R PROPYLTA1 \r\n', 10, '', ''),
(767, 'Bromocriptine Tablet, 2.5 mg D R BROMOCTA1 \r\n', 10, '', ''),
(768, 'Tuberculin (PPD) Injection, 20 units/ml B2 NR TUBERCIN1 \r\n', 5, '', ''),
(769, 'Anti D Rh Immunoglobulin Injection C R ANIMGLIN1 \r\n', 60, '', ''),
(770, 'Antirabies Immunoglobulins Injection, 1000 IU/ 5 ml B1 NR ANRAIMIN1 \r\n', 95, '', ''),
(771, 'Anti -Snake Serum (West African \r\n', 80, '', ''),
(772, 'Polyvalent) Injection, 1500 IU/ml \r\n', 95, '', ''),
(773, 'B1 NR ANSNVEIN1 \r\n', 50, '', ''),
(774, 'Tetanus Toxoid Injection, 40 IU (0.5 ml) B1/M NR TETTOXIN1 \r\n', 70, '', ''),
(775, 'Tetanus Immunoglobulins Injection, 250 IU/ml B1/M R TETIMMIN1 \r\n', 70, '', ''),
(776, 'Tetanus Immunoglobulins Injection, 5000 IU/amp R TETIMMIN2 C \r\n', 70, '', ''),
(777, 'Isophane Insulin Injection (HM), 100 units/ml C R ISOINSIN1 \r\n', 100, '', ''),
(778, 'Metformin Tablet, 500 mg B2 R METFORTA1 \r\n', 5, '', ''),
(779, 'Pioglitazone Tablet, 15 mg C R PIOGLITA1 \r\n', 45, '', ''),
(780, 'Pioglitazone Tablet, 30 mg C R PIOGLITA2 \r\n', 80, '', ''),
(781, 'Rosiglitazone Tablet, 4 mg C R ROSIGLTA1 \r\n', 85, '', ''),
(782, 'Tolbutamide Tablet, 500 mg B2 R TOLBUTTA1 \r\n', 55, '', ''),
(783, 'Clomifene Citrate Tablet, 50 mg D NR CLOMIFTA1 \r\n', 90, '', ''),
(784, 'Medroxyprogesterone Acetate Tablet, 5 mg D R MEDACETA1 \r\n', 20, '', ''),
(785, 'Norethisterone Tablet, 5 mg D R NORETHTA1 \r\n', 85, '', ''),
(786, 'Carbimazole Tablet, 20 mg C R CARBIMTA2 \r\n', 65, '', ''),
(787, 'Carbimazole Tablet, 5 mg C R CARBIMTA1 \r\n', 40, '', ''),
(788, 'Levothyroxine Tablet, 100 microgram C R LEVSODTA3 \r\n', 45, '', ''),
(789, 'Levothyroxine Tablet, 50 microgram C R LEVSODTA2 \r\n', 100, '', ''),
(790, 'Propylthiouracil Tablet, 50 mg D R PROPYLTA1 \r\n', 10, '', ''),
(791, 'Bromocriptine Tablet, 2.5 mg D R BROMOCTA1 \r\n', 40, '', ''),
(792, 'Tuberculin (PPD) Injection, 20 units/ml B2 NR TUBERCIN1 \r\n', 80, '', ''),
(793, 'Anti D Rh Immunoglobulin Injection C R ANIMGLIN1 \r\n', 65, '', ''),
(794, 'Antirabies Immunoglobulins Injection, 1000 IU/ 5 ml B1 NR ANRAIMIN1 \r\n', 55, '', ''),
(795, 'Anti -Snake Serum (West African Polyvalent) Injection, 1500 IU/ml B1 NR ANSNVEIN1 \r\n', 50, '', ''),
(796, 'Tetanus Toxoid Injection, 40 IU (0.5 ml) B1/M NR TETTOXIN1 \r\n', 55, '', ''),
(797, 'Tetanus Immunoglobulins Injection, 250 IU/ml B1/M R TETIMMIN1 \r\n', 45, '', ''),
(798, 'Tetanus Immunoglobulins Injection, 5000 IU/amp R TETIMMIN2 C \r\n', 45, '', ''),
(799, 'Five in One Vaccine Injection (Diphtheria, Pertussis, Tetanus, Haemophilus influenzae b and Hepatitis B) PD NR FIINONIN1 \r\n', 85, '', ''),
(800, 'Bacillus Calmette-Guérin (BCG) Vaccine Injection PD NR BCGVACIN1 \r\n', 25, '', ''),
(801, 'Hepatitis B Vaccine Injection PD NR HEPBVAIN1 \r\n', 90, '', ''),
(802, 'Measles Vaccine Injection PD NR MEAVACIN1 \r\n', 40, '', ''),
(803, 'Poliomyelitis Vaccine Oral Solution PD NR POLVACSO1 \r\n', 95, '', ''),
(804, 'Tetanus Vaccine Injection, 40 IU/ 5 ml B1/PD NR TETVACIN1 \r\n', 50, '', ''),
(805, 'Yellow Fever Vaccine Injection PD NR YEFEVAIN1 \r\n', 95, '', ''),
(806, 'Meningococcal Vaccine Injection B1 NR MENVACIN1 \r\n', 10, '', ''),
(807, 'Rabies Vaccine Injection B1 NR RABVACIN1 \r\n', 10, '', ''),
(808, 'Tetanus Toxoid Injection, 40 IU (0.5 ml) B1 NR TETTOXIN1 \r\n', 75, '', ''),
(809, 'Tetanus Vaccine Injection, 40 IU/ 5 ml B1/PD NR TETVACIN1 \r\n', 30, '', ''),
(810, 'Atracurium Injection, 10 mg/ml D NR ATRACUIN1 \r\n', 50, '', ''),
(811, 'Neostigmine Injection, 0.5 mg C NR NEOSTIIN2 \r\n', 35, '', ''),
(812, 'Yellow Fever Vaccine Injection PD NR YEFEVAIN1 \r\n', 45, '', ''),
(813, 'Neostigmine Injection, 2.5 mg C R NEOSTIIN1 \r\n', 5, '', ''),
(814, 'Rocuro nium Injection, 10 mg/ml D NR ROCUROIN1 \r\n', 55, '', ''),
(815, 'Suxamethonium Injection, 100 mg/ 2 ml C NR SUXAMEIN1 \r\n', 70, '', ''),
(816, 'Vecuronium Bromide Injection, 10 mg C NR VECBROIN1 \r\n', 80, '', ''),
(817, 'Acyclovir Eye Ointment, 3% C R ACICLOEO1 \r\n', 40, '', ''),
(818, 'Chloramphenicol Ear, Eye Drops, 0.5 % B1/M R CHLORAID1 \r\n', 85, '', ''),
(819, 'Chloramphenicol Eye Ointment, 1 % B1/M R CHLORAEO1 \r\n', 40, '', ''),
(820, 'Ciprofloxacin Eye Drops, 3 % C R CIPROFID1 \r\n', 20, '', ''),
(821, 'Erythromycin Ointment, 0.5 % B1 NR ERYTHROI1 \r\n', 75, '', ''),
(822, 'Fluconazole Ophthalmic Solution SD NR FLUCONID1 \r\n', 10, '', ''),
(823, 'Genta micin Eye Drops, 0.3 % B1 R GENTAMID1 \r\n', 85, '', ''),
(824, 'Gentamicin Ointment, 0.3 % B1 NR GENTAOI1 \r\n', 75, '', ''),
(825, 'Natamycin Eye Drops, 5 % SD NR NATAMYID1 \r\n', 80, '', ''),
(826, 'Tetracycline Eye Ointment, 0.5 % B1 R TETRACEO1 \r\n', 5, '', ''),
(827, 'Tetracycline Eye Ointment, 1 % B1 R TETRACEO2 \r\n', 50, '', ''),
(828, 'Lodoxamide Eye Drops, 0.1 % C R LODOXAID1 \r\n', 25, '', ''),
(829, 'Sodium Cromoglycate Eye Drops, 4 % C NR SODCROID1 \r\n', 20, '', ''),
(830, 'Atropine Sulphate Eye Drops, 0.5 % C NR ATROPIID1 \r\n', 15, '', ''),
(831, 'Atropine Sulphate Eye Drops, 1 % C R ATROPIID2 \r\n', 10, '', ''),
(832, 'Cyclopentolate Eye Drops, 0.5 % SD NR CYCLOPID1 \r\n', 85, '', ''),
(833, 'Cyclopentolate Eye Drops, 1 % SD R CYCLOPID2 \r\n', 90, '', ''),
(834, 'Cyclopentolate Eye Drops, 2 % SD NR CYCLOPID3 \r\n', 60, '', ''),
(835, 'Phenylephrine Eye Drops, 10 % SD NR PHENYLID2 \r\n', 5, '', ''),
(836, 'Phenylephrine Eye Drops, 2.5 % SD NR PHENYLID1 \r\n', 5, '', ''),
(837, 'Corticosteroid + Antibiotic Eye Drops C R CORANTID1 \r\n', 50, '', ''),
(838, 'Corticosteroid + Antibiotic Eye Ointment C R CORANTEO1 \r\n', 75, '', ''),
(839, 'Dexamethasone Eye Drops, 1 % C R DEXAMEID1 \r\n', 90, '', ''),
(840, 'Dexamethasone Eye Ointment, 1 % C R DEXAMEEO1 \r\n', 25, '', ''),
(841, 'Hydrocortisone Eye Drops, 1 % C R HYDROCCR1 \r\n', 35, '', ''),
(842, 'Hydrocortisone Eye Ointment, 1 % C R HYDROCEO1 \r\n', 10, '', ''),
(843, 'Acetazolamide Injection, 500 mg C R ACETAZIN1 \r\n', 85, '', ''),
(844, 'Acetazolamide Tablet, 250 mg C R ACETAZTA1 \r\n', 5, '', ''),
(845, 'Bimatoprost Eye Drops, 300 micrograms/ml SD NR BIMATOID1 \r\n', 40, '', ''),
(846, 'Latanoprost Eye Drops, 50 micrograms/ml SD NR LATANOID1 \r\n', 45, '', ''),
(847, 'Pilocarpine Eye Drops, 2 % C R PILOCAID1 \r\n', 50, '', ''),
(848, 'Pilocarpine Eye Drops, 4 % C R PILOCAID2 \r\n', 65, '', ''),
(849, 'Timolol Maleate Eye Drops, 0.5 % C R TIMMALID1 \r\n', 70, '', ''),
(850, 'Ergometrine Injection, 0.2 mg/ml B1/M R ERGOMEIN1 \r\n', 100, '', ''),
(851, 'Ergometrine Injection, 0.5 mg/ml B1/M R ERGOMEIN2 \r\n', 5, '', ''),
(852, 'Ergometrine Tablet, 0.2 mg A/M R ERGOTATA1 \r\n', 75, '', ''),
(853, 'Ergometrine Tablet, 0.5 mg A/M R ERGOMETA1 \r\n', 95, '', ''),
(854, 'Mifepristone Tablet, 600 microgram SD NR MIFEPRTA1 \r\n', 60, '', ''),
(855, 'Tetracycline Eye Ointment, 0.5 % B1 R TETRACEO1 \r\n', 60, '', ''),
(856, 'Tetracycline Eye Ointment, 1 % B1 R TETRACEO2 \r\n', 25, '', ''),
(857, 'Lodoxamide Eye Drops, 0.1 % C R LODOXAID1 \r\n', 60, '', ''),
(858, 'Sodium Cromoglycate Eye Drops, 4 % C NR SODCROID1 \r\n', 55, '', ''),
(859, 'Atropine Sulphate Eye Drops, 0.5 % C NR ATROPIID1 \r\n', 55, '', ''),
(860, 'Atropine Sulphate Eye Drops, 1 % C R ATROPIID2 \r\n', 20, '', ''),
(861, 'Cyclopentolate Eye Drops, 0.5 % SD NR CYCLOPID1 \r\n', 40, '', ''),
(862, 'Cyclopentolate Eye Drops, 1 % SD R CYCLOPID2 \r\n', 90, '', ''),
(863, 'Cyclopentolate Eye Drops, 2 % SD NR CYCLOPID3 \r\n', 65, '', ''),
(864, 'Phenylephrine Eye Drops, 10 % SD NR PHENYLID2 \r\n', 25, '', ''),
(865, 'Phenylephrine Eye Drops, 2.5 % SD NR PHENYLID1 \r\n', 20, '', ''),
(866, 'Corticosteroid + Antibiotic Eye Drops C R CORANTID1 \r\n', 5, '', ''),
(867, 'Corticosteroid + Antibiotic Eye Ointment C R CORANTEO1 \r\n', 30, '', ''),
(868, 'Dexamethasone Eye Drops, 1 % C R DEXAMEID1 \r\n', 90, '', ''),
(869, 'Dexamethasone Eye Ointment, 1 % C R DEXAMEEO1 \r\n', 15, '', ''),
(870, 'Hydrocortisone Eye Drops, 1 % C R HYDROCCR1 \r\n', 100, '', ''),
(871, 'Hydrocortisone Eye Ointment, 1 % C R HYDROCEO1 \r\n', 45, '', ''),
(872, 'Acetazolamide Injection, 500 mg C R ACETAZIN1 \r\n', 80, '', ''),
(873, 'Acetazolamide Tablet, 250 mg C R ACETAZTA1 \r\n', 35, '', ''),
(874, 'Bimatoprost Eye Drops, 300 micrograms/ml SD NR BIMATOID1 \r\n', 5, '', ''),
(875, 'Latanoprost Eye Drops, 50 micrograms/ml SD NR LATANOID1 \r\n', 20, '', ''),
(876, 'Pilocarpine Eye Drops, 2 % C R PILOCAID1 \r\n', 100, '', ''),
(877, 'Pilocarpine Eye Drops, 4 % C R PILOCAID2 \r\n', 15, '', ''),
(878, 'Timolol Maleate Eye Drops, 0.5 % C R TIMMALID1 \r\n', 40, '', ''),
(879, 'Ergometrine Injection, 0.2 mg/ml B1/M R ERGOMEIN1 \r\n', 50, '', ''),
(880, 'Ergometrine Injection, 0.5 mg/ml B1/M R ERGOMEIN2 \r\n', 45, '', ''),
(881, 'Ergometrine Tablet, 0.2 mg A/M R ERGOTATA1 \r\n', 100, '', ''),
(882, 'Ergometrine Tablet, 0.5 mg A/M R ERGOMETA1 \r\n', 20, '', ''),
(883, 'Mifepristone Tablet, 600 microgram SD NR MIFEPRTA1 \r\n', 55, '', ''),
(884, 'Misoprostol Tablet, 100 microgram PD NR MISOPRTA1 \r\n', 35, '', ''),
(885, 'Misoprostol Tablet, 200 microgram PD NR MISOPRTA2 \r\n', 95, '', ''),
(886, 'Misoprostol Tablet, 25 microgram A/PD NR MISOPRTA3 \r\n', 85, '', ''),
(887, 'Misoprostol Tablet, 50 microgram A/PD NR MISOPRTA4 \r\n', 80, '', ''),
(888, 'Misoprostol Vaginal Tablet, 200 microgram PD R MISOPRVP1 \r\n', 10, '', ''),
(889, 'Oxytocin Injection, 5 units/ml B1/M R OXYTOCIN1 \r\n', 80, '', ''),
(890, 'Oxytocin Injection, 10 units/ml R OXYTOCIN2 \r\n', 60, '', ''),
(891, 'Salbutamol Sulphate Injection, 500 microgram/ml B2 R SALSULIN1 \r\n', 15, '', ''),
(892, 'Salbutamol Tablet, 4 mg B1 R SALBUTTA2 \r\n', 25, '', ''),
(893, 'Amitriptyline Tablet, 10 mg C R AMITRITA1 \r\n', 65, '', ''),
(894, 'Amitriptyline Tablet, 25 mg C R AMITRITA2 \r\n', 40, '', ''),
(895, 'Amitr iptyline Tablet, 50 mg C R AMITRITA3 \r\n', 40, '', ''),
(896, 'Chlordiazepoxide Hydrochloride Tablet, 5 mg C R CHLORDTA1 \r\n', 100, '', ''),
(897, 'Chlorpromazine Injection, 25 mg/ml B2 R CHLPROIN1 \r\n', 35, '', ''),
(898, 'Chlorpromazine Tablet, 25 mg B2 R CHLPROTA1 \r\n', 5, '', ''),
(899, 'Chlorpromazine Tablet, 50mg B2 R CHLPROTA2 \r\n', 30, '', ''),
(900, 'Chlorpromazine Tablet, 100 mg B2 R CHLPROTA3 \r\n', 45, '', ''),
(901, 'Diazepam Injection, 5 mg/ml B1/M R DIAZEPIN1 \r\n', 90, '', ''),
(902, 'Diazepam Tablet, 5 mg M R DIAZEPTA1 \r\n', 50, '', ''),
(903, 'Diazepam Tablet, 10 mg M R DIAZEPTA \r\n', 95, '', ''),
(904, 'Fluox etine Capsule, 20 mg C R FLUOXECA1 \r\n', 80, '', ''),
(905, 'Fluphenazine Deconoate Injection, 25 mg/ml SD R FLUDECIN1 \r\n', 25, '', ''),
(906, 'Haloperidol Injection, 5 mg SD R HALOPEIN1 \r\n', 95, '', ''),
(907, 'Haloperidol Tablet, 5 mg C R HALOPETA1 \r\n', 30, '', ''),
(908, 'Haloperidol Tablet, 10 mg C R HALOPETA2 \r\n', 75, '', ''),
(909, 'Imipramine Tablet, 25 mg C R IMIPRATA1 \r\n', 20, '', ''),
(910, 'Lithium Carbonate Tablet, 200 mg (Slow-Release) SD R LITCARTA1 \r\n', 90, '', ''),
(911, 'Lithium Carbonate Tablet, 500 mg (Slow-Release) SD R LITCARTA2 \r\n', 95, '', ''),
(912, 'Lorazepam Tablet, 2 mg B2 R LORAZETA2 \r\n', 70, '', ''),
(913, 'Methylphenidate Hydrochloride Tablet, 5 mg SD R METHYDTA1 \r\n', 30, '', ''),
(914, 'Misoprostol Tablet, 100 microgram PD NR MISOPRTA1 \r\n', 60, '', ''),
(915, 'Misoprostol Tablet, 200 microgram PD NR MISOPRTA2 \r\n', 90, '', ''),
(916, 'Misoprostol Tablet, 25 microgram A/PD NR MISOPRTA3 \r\n', 55, '', ''),
(917, 'Misoprostol Tablet, 50 microgram A/PD NR MISOPRTA4 \r\n', 75, '', ''),
(918, 'Misoprostol Vaginal Tablet, 200 microgram PD R MISOPRVP1 \r\n', 5, '', ''),
(919, 'Oxytocin Injection, 5 units/ml B1/M R OXYTOCIN1 \r\n', 30, '', ''),
(920, 'Oxytocin Injection, 10 units/ml B1/M R OXYTOCIN2 \r\n', 90, '', ''),
(921, 'Salbutamol Sulphate Injection, 500 microgram/ml B2 R SALSULIN1 \r\n', 10, '', ''),
(922, 'Salbutamol Tablet, 4 mg B1 R SALBUTTA2 \r\n', 5, '', ''),
(923, 'Amitriptyline Tablet, 10 mg C R AMITRITA1 \r\n', 25, '', ''),
(924, 'Amitriptyline Tablet, 25 mg C R AMITRITA2 \r\n', 95, '', ''),
(925, 'Amitr iptyline Tablet, 50 mg C R AMITRITA3 \r\n', 40, '', ''),
(926, 'Chlordiazepoxide Hydrochloride Tablet, 5 mg C R CHLORDTA1 \r\n', 85, '', ''),
(927, 'Chlorpromazine Injection, 25 mg/ml B2 R CHLPROIN1 \r\n', 40, '', ''),
(928, 'Chlorpromazine Tablet, 25 mg B2 R CHLPROTA1 \r\n', 20, '', ''),
(929, 'Chlorpromazine Tablet, 50mg B2 R CHLPROTA2 \r\n', 40, '', ''),
(930, 'Chlorpromazine Tablet, 100 mg B2 R CHLPROTA3 \r\n', 70, '', ''),
(931, 'Diazepam Injection, 5 mg/ml B1/M R DIAZEPIN1 \r\n', 45, '', ''),
(932, 'Diazepam Tablet, 5 mg M R DIAZEPTA1 \r\n', 90, '', ''),
(933, 'Diazepam Tablet, 10 mg M R DIAZEPTA \r\n', 40, '', ''),
(934, 'Fluox etine Capsule, 20 mg C R FLUOXECA1 \r\n', 5, '', ''),
(935, 'Fluphenazine Deconoate Injection, 25 mg/ml SD R FLUDECIN1 \r\n', 5, '', ''),
(936, 'Haloperidol Injection, 5 mg SD R HALOPEIN1 \r\n', 25, '', ''),
(937, 'Haloperidol Tablet, 5 mg C R HALOPETA1 \r\n', 15, '', ''),
(938, 'Haloperidol Tablet, 10 mg C R HALOPETA2 \r\n', 100, '', ''),
(939, 'Imipramine Tablet, 25 mg C R IMIPRATA1 \r\n', 25, '', ''),
(940, 'Lithium Carbonate Tablet, 200 mg (Slow-Release) SD R LITCARTA1 \r\n', 10, '', ''),
(941, 'Lithium Carbonate Tablet, 500 mg (Slow-Release) SD R LITCARTA2 \r\n', 25, '', ''),
(942, 'Lorazepam Tablet, 2 mg R LORAZETA2 \r\n', 85, '', ''),
(943, 'Methylphenidate Hydrochloride Tablet, 5 mg SD R METHYDTA1 \r\n', 20, '', ''),
(944, 'Olanzapine Injection, 5 mg/ml SD R OLANZAIN1 \r\n', 85, '', ''),
(945, 'Olanzapine Tablet, 5 mg SD R OLANZATA1 \r\n', 35, '', ''),
(946, 'Olanzapine Tablet, 10 mg SD R OLANZATA2 \r\n', 65, '', ''),
(947, 'Risperidone Liquid, 1 mg/ml SD R RISPERLI1 \r\n', 30, '', ''),
(948, 'Risperidone Tablet, 1 mg SD R RISPERTA1 \r\n', 35, '', ''),
(949, 'Risperidone Tablet, 2 mg SD R RISPERTA2 \r\n', 15, '', ''),
(950, 'Risperidone Tablet, 500 microgram SD R RISPERTA1 \r\n', 35, '', ''),
(951, 'Sertraline Tablet, SD R SERTRATA1 \r\n', 25, '', ''),
(952, 'Sertraline Tablet, 50 mg 100 mg SD R SERTRATA2 \r\n', 40, '', ''),
(953, 'Sodium Valproate Tablet, 200 mg D R SODVALTA1 \r\n', 40, '', ''),
(954, 'Adrenaline (Epinephrine) Injection, 1 mg/ ml (1:1000) B1/M R ADRENAIN1 \r\n', 95, '', ''),
(955, 'Aminophylline Injection, 250 mg/10 ml B2 R AMINOPIN1 \r\n', 85, '', ''),
(956, 'Beclometasone dipropionate Inhaler, 100 microgram /metered dose (200 doses) B2 R BECDIPGA2 \r\n', 90, '', ''),
(957, 'Budesonide + Formoterol (80 microgram/ 4.5 microgram) SD R BUDFORGA1 \r\n', 40, '', ''),
(958, 'Budesonide + Formoterol (160 microgram/ 4.5 microgram) SD R BUDFORGA2 \r\n', 30, '', ''),
(959, 'Budesonide 100 microgram SD R BUDESOGA1 \r\n', 15, '', ''),
(960, 'Budesonide 200 microgram SD R BUDESOGA2 \r\n', 60, '', ''),
(961, 'Fluticasone + Salmeterol (250 micrograms/ 50 microgram) SD R FLUSALGA1 \r\n', 55, '', ''),
(962, 'Fluticasone 50 microgram SD R FLUTICGA1 \r\n', 30, '', ''),
(963, 'Fluticasone 125 microgram SD R FLUTICGA2 \r\n', 35, '', ''),
(964, 'Fluticasone 250 microgram SD R FLUTICGA3 \r\n', 50, '', ''),
(965, 'Hydrocortisone Sodium Succinate Injection, 100 mg B1/M R HYSOSUIN1 \r\n', 100, '', ''),
(966, 'Prednisolone Tablet, 5 mg B2 R PREDNITA1\r\n', 80, '', ''),
(967, 'Salbutamol Inhaler, 100 microgram/metered dose Inhaler (200 doses ) B1 R SALBUTGA1 \r\n', 90, '', ''),
(968, 'Salbutamol Nebulizer, 2.5 mg Nebules B1 R SALBUTGA2 \r\n', 55, '', ''),
(969, 'Salbutamol Nebulizer, 5 mg Nebules B1 R SALBUTGA3 \r\n', 75, '', ''),
(970, 'Salbutamol Syrup, 2 mg/ 5 ml B1 R SALBUTSY1 \r\n', 45, '', ''),
(971, 'Salbutamol Tablet, 2 mg B1 R SALBUTTA1 \r\n', 55, '', ''),
(972, 'Salbutamol Tablet, 4 mg B1 R SALBUTTA2 \r\n', 75, '', ''),
(973, 'Olanzapine Injection, 5 mg/ml SD R OLANZAIN1 \r\n', 5, '', ''),
(974, 'Olanzapine Tablet, 5 mg SD R OLANZATA1 \r\n', 65, '', ''),
(975, 'Olanzapine Tablet, 10 mg SD R OLANZATA2 \r\n', 30, '', ''),
(976, 'Risperidone Liquid, 1 mg/ml SD R RISPERLI1 \r\n', 70, '', ''),
(977, 'Risperidone Tablet, 1 mg SD R RISPERTA1 \r\n', 5, '', ''),
(978, 'Risperidone Tablet, 2 mg SD R RISPERTA2 \r\n', 45, '', ''),
(979, 'Risperidone Tablet, 500 microgram SD R RISPERTA1 \r\n', 75, '', ''),
(980, 'Sertraline Tablet, 50 mg SD R SERTRATA1 \r\n', 40, '', ''),
(981, 'Sertraline Tablet, 100 mg SD R SERTRATA2 \r\n', 20, '', ''),
(982, 'Sodium Valproate Tablet, 200 mg D R SODVALTA1 \r\n', 85, '', ''),
(983, 'Adrenaline (Epinephrine) Injection, 1 mg/ ml (1:1000) B1/M R ADRENAIN1 \r\n', 10, '', ''),
(984, 'Aminophylline Injection, 250 mg/10 ml B2 R AMINOPIN1 \r\n', 90, '', ''),
(985, 'Beclometasone dipropionate Inhaler, 100 microgram /metered dose (200 doses) B2 R BECDIPGA2 \r\n', 55, '', ''),
(986, 'Budesonide + Formoterol (80 microgram/ 4.5 microgram) SD R BUDFORGA1 \r\n', 15, '', ''),
(987, 'Budesonide + Formoterol (160 microgram/ 4.5 microgram) SD R BUDFORGA2 \r\n', 35, '', ''),
(988, 'Budesonide 100 microgram SD R BUDESOGA1 \r\n', 55, '', ''),
(989, 'Budesonide 200 microgram SD R BUDESOGA2 \r\n', 10, '', ''),
(990, 'Fluticasone + Salmeterol (250 micrograms/ 50 microgram) SD R FLUSALGA1 \r\n', 35, '', ''),
(991, 'Fluticasone 50 microgram SD R FLUTICGA1 \r\n', 65, '', ''),
(992, 'Fluticasone 125 microgram SD R FLUTICGA2 \r\n', 35, '', ''),
(993, 'Fluticasone 250 microgram SD R FLUTICGA3 \r\n', 40, '', ''),
(994, 'Hydrocortisone Sodium Succinate Injection, 100 mg B1/M R HYSOSUIN1 \r\n', 100, '', ''),
(995, 'Prednisolone Tablet, 5 mg B2 R PREDNITA1\r\n', 20, '', ''),
(996, 'Salbutamol Inhaler, 100 microgram/metered dose Inhaler (200 doses) B1 R SALBUTGA1\r\n', 45, '', ''),
(997, 'Salbutamol Nebulizer, 2.5 mg Nebules B1 R SALBUTGA2 \r\n', 75, '', ''),
(998, 'Salbutamol Nebulizer, 5 mg Nebules B1 R SALBUTGA3 \r\n', 100, '', ''),
(999, 'Salbutamol Syrup, 2 mg/ 5 ml B1 R SALBUTSY1 \r\n', 75, '', ''),
(1000, 'Salbutamol Tablet, 2 mg B1 R SALBUTTA1 \r\n', 85, '', ''),
(1001, 'Salbutamol Tablet, 4 mg B1 R SALBUTTA2 \r\n', 85, '', ''),
(1002, 'Theophylline Tablet, 200 mg (Slow-Release) C R THEOPHTA1 \r\n', 60, '', ''),
(1003, 'Carbocisteine Capsule, 375 mg B1 R CARBOCCA1 \r\n', 10, '', ''),
(1004, 'Carbocisteine Syrup Paediatric, 125 mg/ 5ml B1 R CARBOCSY1 \r\n', 85, '', ''),
(1005, 'Carbocisteine Syrup, 250 mg/ 5ml B1 R CARBOCSY2 \r\n', 65, '', ''),
(1006, 'Simple Linctus (Paediatric) BPC A/M R SIMLINSY1 \r\n', 55, '', ''),
(1007, 'Simple Linctus BPC R SIMLINSY2 \r\n', 65, '', ''),
(1008, 'Oral Rehydration Salts, Sachet R ORRESAPO1 \r\n', 85, '', ''),
(1009, 'Potassium Chloride Tablet, 600 mg (Enteric-Coated) B2 R POTCHLTA1 \r\n', 30, '', ''),
(1010, 'Cholera Replacement Fluid Injection, (5:4:1) B1 R CHREFLIN1 \r\n', 90, '', ''),
(1011, 'Dextrose in Sodium Chloride Intravenous Infusion, 10 % in 0.18 % (250 ml ) C R DESOCHIN3 \r\n', 45, '', ''),
(1012, 'Dextrose in Sodium Chloride Intravenous Infusion, 4.3% in 0.18% (250 ml) B1 R DESOCHIN1 \r\n', 5, '', ''),
(1013, 'Dextrose in Sodium Chloride Intravenous Infusion, 5 % in 0.9% (500 ml ) B1/M R DESOCHIN2 \r\n', 45, '', ''),
(1014, 'Dextrose Infusion, 10 % (250 ml) B2 R DEXTROIN3 \r\n', 40, '', ''),
(1015, 'Dextrose Infusion, 10 % (500 ml ) B2 R DEXTROIN4 \r\n', 20, '', ''),
(1016, 'Dextrose Infusion, 20 % (250 ml ) C R DEXTROIN5 \r\n', 55, '', ''),
(1017, 'Dextrose Infusion, 5 % (250 ml ) B1/M R DEXTROIN1 \r\n', 55, '', ''),
(1018, 'Dextrose Infusion, 5 % (500 ml ) B1/M R DEXTROIN2 \r\n', 100, '', ''),
(1019, 'Dextrose Infusion, 50 % (50 ml ) B2 R DEXTROIN6 \r\n', 35, '', ''),
(1020, 'Potassium Chloride Injection, 20 mEq/10 ml C R POTCHLIN1 \r\n', 90, '', ''),
(1021, 'Ringers Lactate Intravenous Infusion, 500 ml B1/M R RINLACSO1\r\n', 100, '', ''),
(1022, 'Theophylline Tablet, 200 mg (Slow-Release) C R THEOPHTA1 \r\n', 60, '', ''),
(1023, 'Carbocisteine Capsule, 375 mg B1 R CARBOCCA1 \r\n', 85, '', ''),
(1024, 'Carbocisteine Syrup Paediatric, 125 mg/ 5ml B1 R CARBOCSY1 \r\n', 75, '', ''),
(1025, 'Carbocisteine Syrup, 250 mg/ 5ml B1 R CARBOCSY2 \r\n', 35, '', ''),
(1026, 'Simple Linctus (Paediatric) BPC A/M R SIMLINSY1 \r\n', 20, '', ''),
(1027, 'Simple Linctus BPC R SIMLINSY2 \r\n', 100, '', ''),
(1028, 'Oral Rehydration Salts, Sachet A/M R ORRESAPO1 \r\n', 90, '', ''),
(1029, 'Potassium Chloride Tablet, 600 mg (Enteric-Coated) B2 R POTCHLTA1 \r\n', 35, '', ''),
(1030, 'Cholera Replacement Fluid Injection, (5:4:1) B1 R CHREFLIN1 \r\n', 60, '', ''),
(1031, 'Dextrose in Sodium Chloride Intravenous Infusion, 10 % in 0.18 % (250 ml ) C R DESOCHIN3 \r\n', 20, '', ''),
(1032, 'Dextrose in Sodium Chloride Intravenous Infusion, 4.3% in 0.18% (250 ml) B1 R DESOCHIN1 \r\n', 65, '', ''),
(1033, 'Dextrose in Sodium Chloride Intravenous Infusion, 5 % in 0.9% (500 ml ) B1/M R DESOCHIN2 \r\n', 75, '', ''),
(1034, 'Dextrose Infusion, 10 % (250 ml) B2 R DEXTROIN3 \r\n', 15, '', ''),
(1035, 'Dextrose Infusion, 10 % (500 ml ) B2 R DEXTROIN4 \r\n', 40, '', ''),
(1036, 'Dextrose Infusion, 20 % (250 ml ) C R DEXTROIN5 \r\n', 85, '', ''),
(1037, 'Dextrose Infusion, 5 % (250 ml ) B1/M R DEXTROIN1 \r\n', 20, '', ''),
(1038, 'Dextrose Infusion, 5 % (500 ml ) B1/M R DEXTROIN2 \r\n', 95, '', ''),
(1039, 'Dextrose Infusion, 50 % (50 ml ) B2 R DEXTROIN6 \r\n', 60, '', ''),
(1040, 'Potassium Chloride Injection, 20 mEq/10 ml C R POTCHLIN1 \r\n', 10, '', ''),
(1041, 'Ringers Lactate Intravenous Infusion, 500 ml B1/M R RINLACSO1\r\n', 75, '', ''),
(1042, 'Sodium Bicarbonate Injection, 8.4 % C R SODBICIN1 \r\n', 70, '', ''),
(1043, 'Sodium Chloride + Potasium Chloride Injection, 0.9 % + 20 mMol(500 ml) SD NR SOCHPOIN1 \r\n', 85, '', ''),
(1044, 'Sodium Chloride Injection, 0.45 % (250 ml) B2 R SODCHLIN1 \r\n', 10, '', ''),
(1045, 'Sodium Chloride Injection, 0.9% (250 ml) B1 NR SODCHLIN2 \r\n', 30, '', ''),
(1046, 'Sodium Chloride Injection, 0.9% (500 ml) B1 R SODCHLIN3 \r\n', 95, '', ''),
(1047, 'Water for Injection A/M R WATFORIN1 \r\n', 80, '', ''),
(1048, 'Calciferol Tablet, 10 000 units D R CALCIFTA1 \r\n', 30, '', ''),
(1049, 'Calcium Gluconate Injection, 100 mg/ml C R CALGLUIN1 \r\n', 15, '', ''),
(1050, 'Calcium + Vitamin D Tablet, (97 mg + 10 microgram) C R CALVITTA1 \r\n', 25, '', ''),
(1051, 'Multivitamin Syrup A/M R MULTIVSY1 \r\n', 45, '', ''),
(1052, 'Multivitamin Tablet A/M R MULTIVTA1 \r\n', 25, '', ''),
(1053, 'Pyridoxine Tablet, 100 mg B2 R PYRIDOTA3 \r\n', 40, '', ''),
(1054, 'Pyridoxine Tablet, 50 mg B2 R PYRIDOTA2 \r\n', 20, '', ''),
(1055, 'Retinol Soft Capsule, 100 000 IU R RETSOFCA1 \r\n', 20, '', ''),
(1056, 'Retinol Soft Capsule, 200 000 IU R RETSOFCA2 \r\n', 10, '', ''),
(1057, 'Thiamine Injection, 100 mg C R THIAMIIN1 \r\n', 15, '', ''),
(1058, 'Thiamine Tablet, 25 mg C R THIAMITA1 \r\n', 10, '', ''),
(1059, 'Thiamine Tablet, 50 mg C R THIAMITA2 \r\n', 35, '', ''),
(1060, 'Thiamine Tablet, 100 mg C R THIAMITA3 \r\n', 25, '', ''),
(1061, 'Sodium Chloride Nasal Drops, 0.9 % R SODCHLND1 \r\n', 50, '', ''),
(1062, 'Chlorhexidine Mouthwash, 0.2 % B2 R CHLORHMW1 \r\n', 90, '', ''),
(1063, 'Lidocaine + Adrenaline Cartridge, (20 mg/ml + [1:80 000/1:100 000]) B2 R LIDADRIN1 \r\n', 80, '', ''),
(1064, 'Miconazole Oral Gel, 24 mg/ml B2 R MICONAOG1 \r\n', 45, '', ''),
(1065, 'Nystatin Ointment, 100 000 IU B2 R NYSTATOI1 \r\n', 100, '', ''),
(1066, 'Abacavir Oral Solution, 20 mg/ml PD NR ABACAVSO1 \r\n', 25, '', ''),
(1067, 'Abacavir Tablet, 300 mg PD NR ABACAVTA1 \r\n', 15, '', ''),
(1068, 'Sodium Bicarbonate Injection, 8.4 % C R SODBICIN1 \r\n', 5, '', ''),
(1069, 'Sodium Chloride + Potasium Chloride Injection, 0.9 % + 20 mMol(500 ml) SD NR SOCHPOIN1 \r\n', 30, '', ''),
(1070, 'Sodium Chloride Injection, 0.45 % (250 ml) B2 R SODCHLIN1 \r\n', 45, '', ''),
(1071, 'Sodium Chloride Injection, 0.9% (250 ml) B1 NR SODCHLIN2 \r\n', 35, '', ''),
(1072, 'Sodium Chloride Injection, 0.9% (500 ml) B1 R SODCHLIN3 \r\n', 25, '', ''),
(1073, 'Water for Injection A/M R WATFORIN1 \r\n', 80, '', ''),
(1074, 'Calciferol Tablet, 10 000 units D R CALCIFTA1 \r\n', 75, '', ''),
(1075, 'Calcium Gluconate Injection, 100 mg/ml C R CALGLUIN1 \r\n', 5, '', ''),
(1076, 'Calcium + Vitamin D Tablet, (97 mg + 10 microgram) C R CALVITTA1 \r\n', 60, '', ''),
(1077, 'Multivitamin Syrup A/M R MULTIVSY1 \r\n', 95, '', ''),
(1078, 'Multivitamin Tablet A/M R MULTIVTA1 \r\n', 60, '', ''),
(1079, 'Pyridoxine Tablet, 100 mg B2 R PYRIDOTA3 \r\n', 25, '', ''),
(1080, 'Pyridoxine Tablet, 50 mg B2 R PYRIDOTA2 \r\n', 100, '', ''),
(1081, 'Retinol Soft Capsule, 100 000 IU R RETSOFCA1 \r\n', 45, '', ''),
(1082, 'Retinol Soft Capsule, 200 000 IU R RETSOFCA2 \r\n', 100, '', ''),
(1083, 'Thiamine Injection, 100 mg C R THIAMIIN1 \r\n', 85, '', ''),
(1084, 'Thiamine Tablet, 25 mg C R THIAMITA1 \r\n', 95, '', ''),
(1085, 'Thiamine Tablet, 50 mg C R THIAMITA2 \r\n', 25, '', ''),
(1086, 'Thiamine Tablet, 100 mg C R THIAMITA3 \r\n', 40, '', ''),
(1087, 'Sodium Chloride Nasal Drops, 0.9 % R SODCHLND1 \r\n', 10, '', ''),
(1088, 'Chlorhexidine Mouthwash, 0.2 % B2 R CHLORHMW1 \r\n', 5, '', ''),
(1089, 'Lidocaine + Adrenaline Cartridge, (20 mg/ml + [1:80 000/1:100 000]) B2 R LIDADRIN1 \r\n', 65, '', ''),
(1090, 'Miconazole Oral Gel, 24 mg/ml B2 R MICONAOG1 \r\n', 55, '', ''),
(1091, 'Nystatin Ointment, 100 000 IU B2 R NYSTATOI1 \r\n', 45, '', ''),
(1092, 'Abacavir Oral Solution, 20 mg/ml PD NR ABACAVSO1 \r\n', 75, '', ''),
(1093, 'Abacavir Tablet, 300 mg PD NR ABACAVTA1 \r\n', 95, '', ''),
(1094, 'Didanosine Capsule, 200 mg PD NR DIDANOCA1 \r\n', 80, '', ''),
(1095, 'Didanosine Oral solution, 10 mg/ml PD NR DIDANOSO1 \r\n', 40, '', ''),
(1096, 'Didanosine Tablet, 100 mg PD NR DIDANOTA3 \r\n', 90, '', ''),
(1097, 'Didanosine Tablet, 150 mg PD NR DIDANOTA4 \r\n', 15, '', ''),
(1098, 'Didanosine Tablet, 25 mg PD NR DIDANOTA1 \r\n', 10, '', ''),
(1099, 'Didanosine Tablet, 50 mg PD NR DIDANOTA2 \r\n', 25, '', ''),
(1100, 'Efavirenz Capsule, 100 mg PD NR EFAVIRCA2 \r\n', 60, '', ''),
(1101, 'Efavirenz Capsule, 200 mg PD NR EFAVIRCA3 \r\n', 35, '', ''),
(1102, 'Efavirenz Capsule, 50 mg PD NR EFAVIRCA1 \r\n', 60, '', ''),
(1103, 'Efavirenz Syrup, 30 mg/ml PD NR EFAVIRSY1 \r\n', 15, '', ''),
(1104, 'Efavirenz Tablet, 600 mg PD NR EFAVIRTA1 \r\n', 45, '', ''),
(1105, 'Emtricitabine Tablets, 200 mg PD NR EMTRICTA1 \r\n', 100, '', ''),
(1106, 'Indinavir Tablet, 400 mg PD NR INDINATA1 \r\n', 100, '', ''),
(1107, 'Lamivudine Oral solution, 10 mg/ml PD NR LAMIVUSO1 \r\n', 10, '', ''),
(1108, 'Lamivudine Tablet, 150 mg PD NR LAMIVUTA1 \r\n', 30, '', ''),
(1109, 'Liponavir + Ritonavir Capsule, (133.3 mg + 33.3 mg) PD NR LIPRITCA1 \r\n', 85, '', ''),
(1110, 'Liponavir + Ritonavir Oral solution, (80 mg + 20 mg/ml) PD NR LIPRITSO1 \r\n', 75, '', ''),
(1111, 'Nelfinavir Tablet, 250 mg PD NR NELFINTA1 \r\n', 40, '', ''),
(1112, 'Nevirapine Suspension, 10 mg/ml PD NR NEVIRASU1 \r\n', 10, '', ''),
(1113, 'Nevirapine Tablet, 200 mg PD NR NEVIRATA1 \r\n', 55, '', ''),
(1114, 'Ritonavir Capsule, 100 mg PD NR RITONACA1 \r\n', 65, '', ''),
(1115, 'Saquinavir Capsule, 200 mg PD NR SAQUINCA1 \r\n', 15, '', ''),
(1116, 'Stavudine Capsule, 15 mg PD NR STAVUDCA1 \r\n', 5, '', ''),
(1117, 'Stavudine Capsule, 20 mg PD NR STAVUDCA2 \r\n', 80, '', ''),
(1118, 'Stavudine Capsule, 30 mg PD NR STAVUDCA3 \r\n', 75, '', ''),
(1119, 'Stavudine Capsule, 40 mg PD NR STAVUDCA4 \r\n', 5, '', ''),
(1120, 'Stavudine Oral Solution, 1 mg/ml PD NR STAVUDSO1 \r\n', 60, '', ''),
(1121, 'Tenofovir Tablet, 300 mg PD NR TENOFOTA1 \r\n', 45, '', ''),
(1122, 'Zidovudine + Lamivudine Tablet, (300 mg + 150 mg) PD NR ZIDLAMTA1 \r\n', 5, '', ''),
(1123, 'Zidovudine Capsule, 100 mg PD NR ZIDOVUCA1 \r\n', 95, '', ''),
(1124, 'Zidovudine Syrup, 10 mg/ml PD NR ZIDOVUSY1 \r\n', 75, '', ''),
(1125, 'Zidovudine Tablet, 300 mg PD NR ZIDOVUTA1 \r\n', 90, '', ''),
(1126, 'Finasteride Tablet, 5 mg SD R FINASTTA1 \r\n', 10, '', ''),
(1127, 'Tamsulosin Capsule, 400 microgram SD R TAMSULCA1 \r\n', 95, '', ''),
(1128, 'Terazosin Tablet, 2 mg SD R TERAZOTA1 \r\n', 85, '', ''),
(1129, 'Terazosin Tablet, 5 mg SD R TERAZOTA2 \r\n', 25, '', ''),
(1130, 'Aciclovir Denk 200mg', 50, '', ''),
(1131, 'A1  Paracetamol (Germany)', 60, '', ''),
(1132, 'Acumal Syrup', 35, '', ''),
(1133, 'Acumal-200', 40, '', ''),
(1134, 'Acyclovir Tabs', 85, '', ''),
(1135, 'Acyclovir Cream', 20, '', ''),
(1136, 'Addyzoa', 40, '', ''),
(1137, 'Advantan Crème', 80, '', ''),
(1138, 'Ampicilline Injection', 45, '', ''),
(1139, 'Amino Pep', 100, '', ''),
(1140, 'Analgin Injection 5mls', 5, '', ''),
(1141, 'Anacol Syrup', 15, '', ''),
(1142, 'Aritrine', 90, '', ''),
(1143, 'Arsuamoon', 20, '', ''),
(1144, 'Artenex 200mg', 90, '', ''),
(1145, 'Artenex 50mg', 85, '', ''),
(1146, 'Artenesunate inj', 10, '', ''),
(1147, 'Alaxine Tabs', 75, '', ''),
(1148, 'Alaxine 20mg Supp', 85, '', ''),
(1149, 'Alaxine 40mg Supp', 75, '', ''),
(1150, 'Alaxine 18g Susp', 70, '', ''),
(1151, 'Aldomet', 80, '', ''),
(1152, 'Alesof-10', 55, '', ''),
(1153, 'Alaxine 80mg Supp', 95, '', ''),
(1154, 'Allopurinol 300mg', 50, '', ''),
(1155, 'Amino Pep', 55, '', ''),
(1156, 'Amodiaquine 200mg', 25, '', ''),
(1157, 'Amoxiciline 500mg', 100, '', ''),
(1158, 'Amlodac 10', 5, '', ''),
(1159, 'Anticid plus', 65, '', ''),
(1160, 'Anticid Plus Suspension', 20, '', ''),
(1161, 'Antiver Suspension', 85, '', ''),
(1162, 'Anti D-Injection', 30, '', ''),
(1163, 'Anytime Sanitary Pad', 30, '', ''),
(1164, 'Argentum Nitricum Stick', 5, '', ''),
(1165, 'Aspirin Soluble 75mg', 100, '', ''),
(1166, 'Asthalex Syrup', 35, '', ''),
(1167, 'Atecor 100', 85, '', ''),
(1168, 'Atenol Denk 50mg', 85, '', ''),
(1169, 'Atropin inj.', 25, '', ''),
(1170, 'Augmentin Tab 625mg', 75, '', ''),
(1171, 'Augmentin Syrup', 95, '', ''),
(1172, 'Axacef', 40, '', ''),
(1173, 'Aziwok Suspension', 50, '', ''),
(1174, 'Aziwok', 95, '', ''),
(1175, 'Blue', 90, '', ''),
(1176, 'Bad Heilbrunner Abführtee', 45, '', ''),
(1177, 'Baby Cough Syrup', 65, '', ''),
(1178, 'B-Co Tabs', 85, '', ''),
(1179, 'Bed Pad', 25, '', ''),
(1180, 'Bendrofluazide', 50, '', ''),
(1181, 'Betasone Cream', 80, '', ''),
(1182, 'Bifilac Caps', 85, '', ''),
(1183, 'Bifilac Satchet', 25, '', ''),
(1184, 'Bisacordyl Suppositories', 90, '', ''),
(1185, 'Bioferon Caps', 30, '', ''),
(1186, 'Bioferon syrup', 5, '', ''),
(1187, 'Biospot Chlorine Tables', 30, '', ''),
(1188, 'Brozedex', 90, '', ''),
(1189, 'Buscolex Tabs', 60, '', ''),
(1190, 'Buscomed Tabs', 25, '', ''),
(1191, 'Buscapan Injection', 100, '', ''),
(1192, 'Calflavone', 40, '', ''),
(1193, 'Calcuim-C Sandos 500mg', 65, '', ''),
(1194, 'Calcuim-C Sandos 1000mg', 20, '', ''),
(1195, 'Candid Cream', 5, '', ''),
(1196, 'Candid-V Gel', 55, '', ''),
(1197, 'Candid-V6 Vaginal Tab', 75, '', ''),
(1198, 'Canditral Caps', 15, '', ''),
(1199, 'Canesten Cream', 55, '', ''),
(1200, 'Canesten Ovules', 55, '', ''),
(1201, 'Castor Oil', 20, '', ''),
(1202, 'Cannula I.V 20G Pink', 80, '', ''),
(1203, 'Ceptapol (Paracetamol Susp)', 80, '', ''),
(1204, 'Cerazette', 40, '', ''),
(1205, 'Clamycef 150mg', 100, '', ''),
(1206, 'Chloroquine Tab', 95, '', ''),
(1207, 'Chlorhexadine Gauze Dressing', 90, '', ''),
(1208, 'Chlorpheniramine Syrup', 35, '', ''),
(1209, 'Chlorpheniramine Tab (blis)', 90, '', ''),
(1210, 'Chlorpheniramine Tab (counting)', 40, '', ''),
(1211, 'Choriomon 5000i.u.(Profasi)', 50, '', ''),
(1212, 'Ciprofloxacine 500mg', 45, '', ''),
(1213, 'Ciprolex Eye/Ear Drop', 55, '', ''),
(1214, 'Ciprodenk', 100, '', ''),
(1215, 'Ciprobay', 40, '', ''),
(1216, 'ClanoxyTab 625mg', 65, '', ''),
(1217, 'Clexane 20mg Inj.', 60, '', ''),
(1218, 'Clermycine', 50, '', ''),
(1219, 'Clearvitarx', 20, '', ''),
(1220, 'Clomid 50mg Tab', 85, '', ''),
(1221, 'Clotri Denk Cream', 90, '', ''),
(1222, 'Clotri Denk Vag. Tab 100mg', 30, '', ''),
(1223, 'Clotrikin Cream', 5, '', ''),
(1224, 'Coartem 20/120', 85, '', ''),
(1225, 'Coasucam100mg/270mg', 95, '', ''),
(1226, 'Coasucam100mg/270mg', 50, '', ''),
(1227, 'Confido', 60, '', ''),
(1228, 'Cordvadil 10mg', 40, '', ''),
(1229, 'Cordipin (Nifedipine) 10mg', 85, '', ''),
(1230, '"Combat-N cream,"', 25, '', ''),
(1231, 'Conbantrin', 5, '', ''),
(1232, 'Concavit Caps', 15, '', ''),
(1233, 'Co-Trimoxazole PR 400/80 mg', 60, '', ''),
(1234, 'Crestor Tabs 10mg', 30, '', ''),
(1235, 'Crinone 8%', 65, '', ''),
(1236, 'Cream Gogynax', 40, '', ''),
(1237, 'Cyklokapron 500mg', 15, '', ''),
(1238, 'Cyklokapron 500mg', 25, '', ''),
(1239, 'Cytotec (Misoprestrol)', 55, '', ''),
(1240, 'Cyclogest 400mg  Vag Tabs', 40, '', ''),
(1241, 'Dalacin C', 75, '', ''),
(1242, 'Day Nurse', 25, '', ''),
(1243, 'Day Quil', 80, '', ''),
(1244, 'Depo Provera Inj', 45, '', ''),
(1245, 'Dermofix Cream 20g', 70, '', ''),
(1246, 'Dermofix Vaginal Tabs', 70, '', ''),
(1247, 'Denk Sweet', 50, '', ''),
(1248, 'Diane', 20, '', ''),
(1249, 'Dexamethasone Inj', 15, '', ''),
(1250, 'Diazepam 5mg', 5, '', ''),
(1251, 'Diazepam 10mg', 50, '', ''),
(1252, 'Diazepam inj.', 55, '', ''),
(1253, 'Dextrose 10% Drip', 55, '', ''),
(1254, 'Dextrose 5% Drip', 35, '', ''),
(1255, 'Diflucan 150mg', 30, '', ''),
(1256, 'Drip DNS', 95, '', ''),
(1257, 'Drip NS', 100, '', ''),
(1258, 'Drip Ringer Lactate', 35, '', ''),
(1259, 'Drip Haes-steril', 90, '', ''),
(1260, 'Diclo Denk Inj.', 40, '', ''),
(1261, 'Diclofenac Sandoz', 75, '', ''),
(1262, 'Diclo Denk Suppository', 25, '', ''),
(1263, 'Diclo Denk 50mg Tab', 100, '', ''),
(1264, 'Diclo HEXAL', 30, '', ''),
(1265, 'Diclolex Power Heat Gel', 35, '', ''),
(1266, 'Diclolex tabs 50mg', 40, '', ''),
(1267, 'Diclomol SR', 75, '', ''),
(1268, 'Diclodenk Suppository', 20, '', ''),
(1269, 'D - SPA', 30, '', ''),
(1270, 'Doxycycline Caps 100mg', 70, '', ''),
(1271, 'Doxikin 100mg.', 45, '', ''),
(1272, 'DoxiHEXAL/ 1 A 200', 20, '', ''),
(1273, 'Dumocalcium', 5, '', ''),
(1274, 'Duphaston 10mg', 75, '', ''),
(1275, 'Enaphage 500mg', 80, '', ''),
(1276, 'Enamycin 250mg', 55, '', ''),
(1277, 'Enoquine Syrup', 75, '', ''),
(1278, 'Equat. Body Guard (Adult)', 40, '', ''),
(1279, 'Equat. Body Guard (Kids)', 15, '', ''),
(1280, 'Equat. Mosquito Blaster', 15, '', ''),
(1281, 'Equat. Mosq Blaster (Refill)', 95, '', ''),
(1282, 'Ergometrin inj.', 75, '', ''),
(1283, 'Ergometrin Tab', 30, '', ''),
(1284, 'Erotab 250', 15, '', ''),
(1285, 'Espumisan', 90, '', ''),
(1286, 'Evecare', 85, '', ''),
(1287, 'Fasigyn 500mg Tab', 55, '', ''),
(1288, 'Farcosolvin', 45, '', ''),
(1289, 'Fegem 100mg Tabs', 40, '', ''),
(1290, 'Female Condom', 95, '', ''),
(1291, 'Femoston Conti 1/5mg', 45, '', ''),
(1292, 'Ferofort Syrup', 60, '', ''),
(1293, 'Ferofort Caps', 100, '', ''),
(1294, 'Ferro Force', 30, '', ''),
(1295, 'Ferrolex Caps', 35, '', ''),
(1296, 'Ferrolex Syrup', 90, '', ''),
(1297, 'Ferrosanol duodenal', 95, '', ''),
(1298, 'Ferrosanol duodenal', 70, '', ''),
(1299, 'Ferrosantrane Syrup', 55, '', ''),
(1300, 'Ferrous Sulphate', 5, '', ''),
(1301, 'Fevorit Tabs(Chewable)', 50, '', ''),
(1302, 'Fevorit Syrup', 85, '', ''),
(1303, 'Foliron', 65, '', ''),
(1304, 'Foley Catheter', 30, '', ''),
(1305, 'Fostimon 75 i.u. (FSH)', 80, '', ''),
(1306, 'Fleet enema', 10, '', ''),
(1307, 'Flemming  Susp228.5mg', 70, '', ''),
(1308, 'Flemming 625mg', 90, '', ''),
(1309, 'Fluxakin 125mg/ 5ml Susp', 65, '', ''),
(1310, 'Folic Acid (England Blisters)', 65, '', ''),
(1311, 'Folic Acid (Blisters)', 10, '', ''),
(1312, 'Folic Acid (Counting)', 45, '', ''),
(1313, 'Fragmid P. Fort Inj', 90, '', ''),
(1314, 'Funbact-A Triple Action', 10, '', ''),
(1315, 'Gebedol Tab', 30, '', ''),
(1316, 'Gebedol forte Tab', 85, '', ''),
(1317, 'Gentamycine Injection', 75, '', ''),
(1318, 'Gentalex Eye Drop', 75, '', ''),
(1319, 'Germidine Cream', 60, '', ''),
(1320, 'Germidine Vaginal Tabs', 65, '', ''),
(1321, 'Giving Set Plain', 15, '', ''),
(1322, 'Giving Set Plain', 10, '', ''),
(1323, 'Gyno-Travogen Ovule', 80, '', ''),
(1324, 'Gyno-Travogen cream', 55, '', ''),
(1325, 'Gogynax Vaginal Tabs', 60, '', ''),
(1326, 'Gogynax Vaginal Cream', 100, '', ''),
(1327, 'Gvither Oral Suspension', 75, '', ''),
(1328, 'Gvither 80mg Injection', 60, '', ''),
(1329, 'GvFluc 150mg', 10, '', ''),
(1330, 'GvFluc 50mg', 20, '', ''),
(1331, 'GvFluc 200mg', 55, '', ''),
(1332, 'GvFluc Suspension', 10, '', ''),
(1333, '"GlibenHEXAL 3,5mg"', 70, '', ''),
(1334, 'Gloves (Disposable)', 40, '', ''),
(1335, 'Gloves (Surgical)', 95, '', ''),
(1336, 'Glycerol Suppositories', 60, '', ''),
(1337, 'Hapenz', 75, '', ''),
(1338, 'Haematovite Syrup', 50, '', ''),
(1339, 'Haestril 6% (I.V.)', 75, '', ''),
(1340, 'Hb Plus', 30, '', ''),
(1341, 'Hirudoid Cream', 5, '', ''),
(1342, 'Histacet Tab', 30, '', ''),
(1343, 'Horamine Syrup', 75, '', ''),
(1344, 'HCG 25000i.u. Inj.', 40, '', ''),
(1345, 'Hydrogen Peroxide', 10, '', ''),
(1346, 'Hydralasin 25mg', 80, '', ''),
(1347, 'Hyoscine ButylbromideInj.', 40, '', ''),
(1348, 'I U C D (copper T)', 70, '', ''),
(1349, 'IBUCAP', 50, '', ''),
(1350, 'Ibuprofen 200mg', 10, '', ''),
(1351, 'Ibuprofen 400mg', 15, '', ''),
(1352, 'Injection Tray', 50, '', ''),
(1353, 'Imazole Vag Pess', 40, '', ''),
(1354, 'Imferon  Iron Dextrand Inj', 5, '', ''),
(1355, 'Immodium Caps', 35, '', ''),
(1356, 'Imunex Tab', 50, '', ''),
(1357, 'Imunex Syrup 60ml', 100, '', ''),
(1358, 'Kamatone', 85, '', ''),
(1359, 'Kandistat Pessary', 75, '', ''),
(1360, 'Kandistat Vag. Cream', 20, '', ''),
(1361, 'Kandistop-150', 60, '', ''),
(1362, 'Kefstar Tabs', 30, '', ''),
(1363, 'Kefstar Suspension', 65, '', ''),
(1364, 'Kefstar 750mg Inj.', 80, '', ''),
(1365, 'Ketamine Injection', 10, '', ''),
(1366, 'Ketamine Injection', 5, '', ''),
(1367, 'Kinapril-10', 50, '', ''),
(1368, 'Kinaclox (Cloxacillin) 250mg', 65, '', ''),
(1369, 'Klister Enema', 95, '', ''),
(1370, 'Kinamox 500', 100, '', ''),
(1371, 'Kinamyein 300mg', 5, '', ''),
(1372, 'Ky-Jelly', 20, '', ''),
(1373, 'Lariam', 30, '', ''),
(1374, 'Lamar Cream (20mg)', 75, '', ''),
(1375, 'Lactacyd', 100, '', ''),
(1376, 'Lamisil Tab 250mg', 90, '', ''),
(1377, 'Lactodel', 60, '', ''),
(1378, 'Lidocaine inj 5ml', 40, '', ''),
(1379, 'Lidocaine Gel', 65, '', ''),
(1380, 'Lidocaine Spray', 45, '', ''),
(1381, 'Lipitor 10mg', 20, '', ''),
(1382, 'Lipitor 20mg', 50, '', ''),
(1383, 'Little Adult Cough Syrup', 75, '', ''),
(1384, 'Little Baby Cough Syrup', 75, '', ''),
(1385, 'Little Infant Cough syr. 25ml', 85, '', ''),
(1386, 'Livertone Junior', 10, '', ''),
(1387, 'Locid-20', 90, '', ''),
(1388, 'Lodipin-5', 60, '', ''),
(1389, 'Lofnac-100 Suppository', 35, '', ''),
(1390, 'Lofnac-50 Suppository', 35, '', ''),
(1391, 'Lonart Syrup', 40, '', ''),
(1392, 'Lonart Tabs', 65, '', ''),
(1393, 'Lonart Forte Tabs', 95, '', ''),
(1394, 'Lonart Suppository 120mg', 100, '', ''),
(1395, 'Loperamide Denk 2', 75, '', ''),
(1396, 'Lucon', 10, '', ''),
(1397, 'Loquin Syrup', 30, '', ''),
(1398, 'Malareich 500/25mg', 20, '', ''),
(1399, 'Malaron', 15, '', ''),
(1400, 'Maladar', 80, '', ''),
(1401, 'Malafin', 85, '', ''),
(1402, 'Magnisium Sulphate 100ml', 90, '', ''),
(1403, 'Magnisium Diasporal 300mgMagnesium Citrate', 85, '', ''),
(1404, 'Magnisium Diasporal 100mgMagnesium Citrate', 55, '', ''),
(1405, 'Magnisiocard', 40, '', ''),
(1406, 'Mg5 longoral', 95, '', ''),
(1407, 'Maxital Suspension', 70, '', ''),
(1408, 'Maxital Mouth Dissolving', 20, '', ''),
(1409, 'Maxital Gel 20mg', 40, '', ''),
(1410, 'Male Condom', 10, '', ''),
(1411, 'Malucid Gel', 10, '', ''),
(1412, 'Malaria Kits', 95, '', ''),
(1413, 'Medivite Gold', 20, '', ''),
(1414, 'Medivite Omega', 30, '', ''),
(1415, 'Medivite drops 25ml', 90, '', ''),
(1416, 'Mebendazole 500mg', 50, '', ''),
(1417, 'Merional 75 iu Inj.', 100, '', ''),
(1418, 'Meltus cough syrup', 75, '', ''),
(1419, 'Menthodex Cough Mixture', 25, '', ''),
(1420, 'Menthodex Cough Mixture', 65, '', ''),
(1421, 'Menthodex Lozenges', 45, '', ''),
(1422, 'Meronal Suspension', 35, '', ''),
(1423, 'Metformin Denk', 70, '', ''),
(1424, 'Metoclopramide Tabs', 5, '', ''),
(1425, 'Metoclopramide Injection', 85, '', ''),
(1426, 'Metoclopramide Syrup', 35, '', ''),
(1427, 'Metronidazole 200mg Tab', 55, '', ''),
(1428, 'Metronidazole 250mg. Egypt', 20, '', ''),
(1429, 'Metronidazole Susp. Egypt', 10, '', ''),
(1430, 'Metronidazol IV', 95, '', ''),
(1431, 'Menovital', 65, '', ''),
(1432, 'Mictonorm', 70, '', ''),
(1433, 'Microgynon', 50, '', ''),
(1434, 'Millton Steralizing Liquid', 10, '', ''),
(1435, 'Milton Sterilising Tabs', 60, '', ''),
(1436, 'Minadex Tonic 200ml', 100, '', ''),
(1437, 'Minadex Tonic 400ml', 15, '', ''),
(1438, 'Mumfer drops', 75, '', ''),
(1439, 'Muc-Sabona Syr.', 75, '', ''),
(1440, 'Myclav 625', 15, '', ''),
(1441, 'Myopril 5mg', 30, '', ''),
(1442, 'Myospaz', 50, '', ''),
(1443, 'Mycopirox', 30, '', ''),
(1444, 'Multivite (Ernerst)', 75, '', ''),
(1445, 'Multi - Gyn Actigel', 50, '', ''),
(1446, 'Multi - Mam Balsam', 80, '', ''),
(1447, 'Multi - Mam Kompressen', 80, '', ''),
(1448, 'Multi - Mam Kompressen', 45, '', ''),
(1449, 'Nadoxin Cream', 5, '', ''),
(1450, 'Neo-Hycolex Drops', 75, '', ''),
(1451, 'Neo-Penotran', 35, '', ''),
(1452, 'Neomoxine - P', 90, '', ''),
(1453, 'Nexium 20mg', 70, '', ''),
(1454, 'Nifedipine 10mg Caps.', 40, '', ''),
(1455, 'Night Nurse', 80, '', ''),
(1456, 'Nifedipine 10mg Tabs', 95, '', ''),
(1457, 'Nugel Tabs', 75, '', ''),
(1458, 'Nugel Suspension', 30, '', ''),
(1459, 'Norplant', 15, '', ''),
(1460, 'Non Aspirin', 95, '', ''),
(1461, 'Non Aspirin', 75, '', ''),
(1462, 'NyQuil', 100, '', ''),
(1463, 'Omezole 20', 60, '', ''),
(1464, 'Omega H3 Cap', 100, '', ''),
(1465, 'Omizac', 5, '', ''),
(1466, 'Orfix 200mg caps', 95, '', ''),
(1467, 'Ortho-Gynest', 60, '', ''),
(1468, 'Orofer Syrup', 90, '', ''),
(1469, 'Orofer tablet', 15, '', ''),
(1470, 'O R S Hydrolyte', 55, '', ''),
(1471, 'Osteocare', 55, '', ''),
(1472, 'Osteovite', 5, '', ''),
(1473, 'Ovulation Test Kit', 90, '', ''),
(1474, 'Ovulation Test (LH) Strip', 40, '', ''),
(1475, 'Oxytocin Inj.', 60, '', ''),
(1476, 'Palidar Tab', 30, '', ''),
(1477, 'Paracetamol  Syrup  100ml', 35, '', ''),
(1478, 'Parace  120mg/5mlSyrup', 45, '', ''),
(1479, 'Paracetamol (counting)', 70, '', ''),
(1480, 'Paracetamol Blister', 45, '', ''),
(1481, 'Paracetamol 250mg Supo', 90, '', ''),
(1482, 'Paracetamol 500mg Supo', 10, '', ''),
(1483, 'Paracetamol inj', 70, '', ''),
(1484, 'Parlodel Tab 2.5mg', 10, '', ''),
(1485, 'PC-30 Skin Lotion', 55, '', ''),
(1486, 'Penamox Syrup', 15, '', ''),
(1487, 'Permoxyl Caps', 10, '', ''),
(1488, 'Phenergan Inj.', 10, '', ''),
(1489, 'Pethidine Injection', 25, '', ''),
(1490, 'Plasmotrim Lactab 200mg', 45, '', ''),
(1491, 'Potassium Permanganate', 5, '', ''),
(1492, 'Pikovit Syrup', 70, '', ''),
(1493, 'Pilex Ointment', 100, '', ''),
(1494, '"Plaster 1"" Zinc Oxide"', 55, '', ''),
(1495, 'Plaster Stripes', 90, '', ''),
(1496, 'Pre-Par Injection', 20, '', ''),
(1497, 'Pre-Par 10mg Tabs', 25, '', ''),
(1498, 'Pregnazone Tabs', 45, '', ''),
(1499, 'Pregnacare caps', 95, '', ''),
(1500, 'Pregnacare Cream', 45, '', ''),
(1501, 'Pregnacare + Omega3', 25, '', ''),
(1502, 'Prenatal Multi', 70, '', ''),
(1503, 'Pregn Early Detect (ACON)', 5, '', ''),
(1504, 'Primogyn Depot 10mg', 35, '', ''),
(1505, 'Primolut Depot 250mg', 95, '', ''),
(1506, 'Primolut N 5mg tab', 5, '', ''),
(1507, 'Progynova 2mg', 10, '', ''),
(1508, 'Promethazine Tab 25mg', 15, '', ''),
(1509, 'Promethalex', 5, '', ''),
(1510, 'Promethazine Inj. 25mg', 100, '', ''),
(1511, 'Pulmo-Cordio mite SL', 40, '', ''),
(1512, 'Quinine Inj.  600mg', 50, '', ''),
(1513, 'Quinine Tab 300mg', 85, '', ''),
(1514, 'Ranitic 150mg', 20, '', ''),
(1515, 'Ranitic 300mg', 45, '', ''),
(1516, 'Ratioxon Inject.', 10, '', ''),
(1517, 'Recer Gel Suspension', 95, '', ''),
(1518, 'Rifun 40mg', 60, '', ''),
(1519, 'Ringer Lactate Infusion', 65, '', ''),
(1520, 'Rizole Suspension 5ml', 40, '', ''),
(1521, 'Rocephin inj 1g', 15, '', ''),
(1522, 'Rubriment Essenz', 80, '', ''),
(1523, 'Sab Simplex Suspension', 95, '', ''),
(1524, 'Salbutamol Tabs 4mg', 50, '', ''),
(1525, 'Stamlo Beta', 50, '', ''),
(1526, 'Scheriproct Cream', 85, '', ''),
(1527, 'Scheriproct Suppository', 40, '', ''),
(1528, 'Secure Tabs (3 months)', 75, '', ''),
(1529, 'Septex (Cotrim Susp)', 45, '', ''),
(1530, 'Septazole Suspension', 100, '', ''),
(1531, 'Shalcip 500', 35, '', ''),
(1532, 'Seven Seas Cod Liver Oil', 10, '', ''),
(1533, 'Seven Seas COL (Plain)', 80, '', ''),
(1534, 'Seven Seas CLO (Cherry)', 25, '', ''),
(1535, 'Simplotan Duo Pakage', 50, '', ''),
(1536, 'Simplotan Tab', 65, '', ''),
(1537, 'Speman Tabs', 70, '', ''),
(1538, 'Spizef 250mg', 80, '', ''),
(1539, 'Spizef Inj 750mg (IM/IV)', 50, '', ''),
(1540, 'Silverzine Cream', 50, '', ''),
(1541, 'Supirocin Cream', 70, '', ''),
(1542, 'Sulpivert', 75, '', ''),
(1543, 'Sutures Nylon', 5, '', ''),
(1544, 'Sutures Plain Cut 1', 20, '', ''),
(1545, 'Sutures Chromic', 80, '', ''),
(1546, 'Sutures Vicryl 3-0', 85, '', ''),
(1547, 'Syclox(cloxa) Caps 250mg', 40, '', ''),
(1548, 'Syringes & Needles 2ml', 45, '', ''),
(1549, 'Syringes & Needles 5ml', 10, '', ''),
(1550, 'Syringes & Needles 10ml', 50, '', ''),
(1551, 'Tacizol tablet', 85, '', ''),
(1552, 'Tavanic 500mg', 15, '', ''),
(1553, 'Tacholiquin Inhaler', 80, '', ''),
(1554, 'Tannodact Bath', 35, '', '');
INSERT INTO `drugs` (`treatmentid`, `treatment`, `price`, `icd10`, `gdrg`) VALUES
(1555, 'Tamopharm 20mg', 75, '', ''),
(1556, 'Tagera Forte', 90, '', ''),
(1557, 'Tiger Plaster', 40, '', ''),
(1558, 'Tensi Plus', 50, '', ''),
(1559, 'Tensiplus M', 85, '', ''),
(1560, 'Topcef 200mg', 25, '', ''),
(1561, 'Travogyn Cream', 10, '', ''),
(1562, 'Travogyn tab', 5, '', ''),
(1563, 'Tranexamic Acid', 70, '', ''),
(1564, 'Tylenol PM', 85, '', ''),
(1565, 'Tylenol PM', 65, '', ''),
(1566, 'Tylenol extra strength', 80, '', ''),
(1567, 'Tylenol extra strength', 65, '', ''),
(1568, 'Urgedol (Tamadol) Injection', 50, '', ''),
(1569, 'Urine Bag', 15, '', ''),
(1570, 'Urgedol (Tamadol) Capsule', 100, '', ''),
(1571, 'Vaginax Cream', 70, '', ''),
(1572, 'Vaginax Tab', 60, '', ''),
(1573, 'Valgisup', 30, '', ''),
(1574, 'Ventolin Inhaler', 10, '', ''),
(1575, 'Vegibon vag. Wash', 25, '', ''),
(1576, 'Vermox', 35, '', ''),
(1577, 'Vicryl Sutures', 60, '', ''),
(1578, 'Viscof-D Dry Cough', 30, '', ''),
(1579, 'Viscof-S  Cough syr.', 55, '', ''),
(1580, 'Visine Eye Drops (Yellow)', 95, '', ''),
(1581, 'Visine Eye Drops (Blue)', 45, '', ''),
(1582, 'Vitamin K1 Inj.', 10, '', ''),
(1583, 'Vitamin-B Denk', 65, '', ''),
(1584, 'Vitamin - E', 45, '', ''),
(1585, 'Vitamin - C (Valupack)', 70, '', ''),
(1586, 'Vit B-Complex Counting', 10, '', ''),
(1587, 'VitaLong-100 Caps', 60, '', ''),
(1588, 'Vomitin - 30', 90, '', ''),
(1589, 'V-2 Plus', 50, '', ''),
(1590, 'Xamic Injection', 70, '', ''),
(1591, 'Wokadine Vag Tab', 75, '', ''),
(1592, 'Wokadine Creame', 30, '', ''),
(1593, 'Yasmin tablets', 100, '', ''),
(1594, 'Zeben susp', 50, '', ''),
(1595, 'Zedex  sry.', 30, '', ''),
(1596, 'Zincofer Nuture Tabs', 60, '', ''),
(1597, 'Zincofer Liquid (Syrup 200ml)', 50, '', ''),
(1598, 'Zincovit Drops Syrup 15ml', 30, '', ''),
(1599, 'Zincovit Syrup 200ml', 55, '', ''),
(1600, 'Zincovite Tabs', 80, '', ''),
(1601, 'Zink Vit', 25, '', ''),
(1602, 'Zinnat Tabs', 35, '', ''),
(1603, 'Zithromax Suspension', 85, '', ''),
(1604, 'Zithromax Tab / Caps', 60, '', ''),
(1608, 'Advantan Cream', 75, '', ''),
(1609, 'Calamine Lotion', 55, '', ''),
(1610, 'Candid V6 Vag. Pess.    Candid V6 Vag. Pess.	  ', 5, '', ''),
(1611, 'Candiderm Cream', 55, '', ''),
(1612, 'Cap Amoxycillin', 40, '', ''),
(1613, 'Cap Artemos', 25, '', ''),
(1614, 'Cap Artemos Plus', 90, '', ''),
(1615, 'Cap Bioe', 65, '', ''),
(1616, 'Cap Bioferon', 15, '', ''),
(1617, 'Cap Celebrex 200mg', 100, '', ''),
(1618, 'Cap Ciprinol 500mg', 45, '', ''),
(1619, 'Cap Clamacef 150mg', 80, '', ''),
(1620, 'Cap Diflucan 150mg', 55, '', ''),
(1621, 'Cap Doxycycline 100mg', 10, '', ''),
(1622, 'Cap Feroglobin', 65, '', ''),
(1623, 'Cap Ferozin', 55, '', ''),
(1624, 'Cap Flucloxacillin 250mg', 80, '', ''),
(1625, 'Cap Immodium 2mg', 60, '', ''),
(1626, 'Cap Lyrica 75mg', 30, '', ''),
(1627, 'Cap Motilium 10mg', 10, '', ''),
(1628, 'Cap Naklofen duo 75mg', 70, '', ''),
(1629, 'Cap Norvasc 10mg', 85, '', ''),
(1630, 'Cap Nucleo CMP', 5, '', ''),
(1631, 'Cap Omega H3', 85, '', ''),
(1632, 'Cap Omeprazole 20mg', 65, '', ''),
(1633, 'Cap Ponstan 250mg', 20, '', ''),
(1634, 'Cap Pregnacare', 80, '', ''),
(1635, 'Cap Sporanox', 30, '', ''),
(1636, 'Cap Tarmadol 50mg', 90, '', ''),
(1637, 'Caps Vitamine E 400IU', 60, '', ''),
(1638, 'Cap Wellwoman', 90, '', ''),
(1639, 'Cap Zincovit', 10, '', ''),
(1640, 'Cap Zithromax 250mg', 95, '', ''),
(1641, 'Chloramphenicol Eye/Ear', 60, '', ''),
(1642, 'Ciprolex Ear Drops', 45, '', ''),
(1643, 'Complan', 60, '', ''),
(1644, 'Cyclogest Vag. Pess. 400mg', 55, '', ''),
(1645, 'Daktarin Cream', 20, '', ''),
(1646, 'Daktacort Cream', 50, '', ''),
(1647, 'Decatylen Lozenges', 35, '', ''),
(1648, 'Deep Heat gel', 100, '', ''),
(1649, 'Deep Heat Spray', 15, '', ''),
(1650, 'Dermofix Cream', 75, '', ''),
(1651, 'Ephedrine nasal Drops', 45, '', ''),
(1652, 'Forever Multi Maca', 60, '', ''),
(1653, 'Funbact A', 50, '', ''),
(1654, 'Gentamycin Eye', 60, '', ''),
(1655, 'Gyno-Daktarin Cream', 20, '', ''),
(1656, 'Gyno-Daktarin Ovules', 50, '', ''),
(1657, 'Im Adrenaline', 5, '', ''),
(1658, 'Im Amoksiclav 1g', 95, '', ''),
(1659, 'Im Amoksiclav 600mg', 100, '', ''),
(1660, 'Im Atropine', 30, '', ''),
(1661, 'Im Buscopan 10mg', 85, '', ''),
(1662, 'Im Ceftriaxone 1g', 65, '', ''),
(1663, 'Im Cefuroxime 750mg', 60, '', ''),
(1664, 'Im Choriomon 5000iu', 90, '', ''),
(1665, 'Im Clexane 40mg', 10, '', ''),
(1666, 'Im Clindamycin 300mg', 35, '', ''),
(1667, 'Im Depo-Provera', 15, '', ''),
(1668, 'Im Dexamethazone', 80, '', ''),
(1669, 'Im Diazepam 10mg', 60, '', ''),
(1670, 'Im Diclofenac 75mg', 55, '', ''),
(1671, 'Im Dopamine 200mg/5ml', 15, '', ''),
(1672, 'Im Dormicum 5mg', 70, '', ''),
(1673, 'Im Enoskaparin(Clexane)', 10, '', ''),
(1674, 'Im Ephedrine', 60, '', ''),
(1675, 'Im Ergometrine', 5, '', ''),
(1676, 'Im Flucloxacillin 500mg', 40, '', ''),
(1677, 'Im Furosemide 40mg', 30, '', ''),
(1678, 'Im Fustimon 75iu', 85, '', ''),
(1679, 'Im Gentamycin 80mg', 55, '', ''),
(1680, 'Im Gvither 80mg', 60, '', ''),
(1681, 'Im Heavy  Marcain 0.5', 100, '', ''),
(1682, 'Im Ketamine', 100, '', ''),
(1683, 'Im Lidocaine', 80, '', ''),
(1684, 'Im Lidocaine and Anderline', 100, '', ''),
(1685, 'Im Maxolon', 45, '', ''),
(1686, 'Im Mesporin 250mg', 40, '', ''),
(1687, 'Im Mesporin 500mg', 10, '', ''),
(1688, 'im Nexium', 25, '', ''),
(1689, 'Im Nospa 20mg', 20, '', ''),
(1690, 'Im Oxytocin', 45, '', ''),
(1691, 'Im Pabrinex I&II', 70, '', ''),
(1692, 'Im Pethedine 100mg', 70, '', ''),
(1693, 'Im Phenegan', 70, '', ''),
(1694, 'Im Pregynl 500iu', 100, '', ''),
(1695, 'Im Primolut 250mg', 100, '', ''),
(1696, 'Im Progestrone 100mg', 75, '', ''),
(1697, 'Im Progynon 10mg', 95, '', ''),
(1698, 'Im Suprecur', 60, '', ''),
(1699, 'Im Suxemethonium', 5, '', ''),
(1700, 'Im Tetanol', 80, '', ''),
(1701, 'Im Tramadol 100mg', 85, '', ''),
(1702, 'Im Traxenamic Acid 100mg', 35, '', ''),
(1703, 'Im Vecuronoium', 75, '', ''),
(1704, 'Im Vitamin K', 70, '', ''),
(1705, 'Inj  Zoladex', 100, '', ''),
(1706, 'Iv Ciprofloxacin 200mg', 55, '', ''),
(1707, 'Iv Dextrose', 60, '', ''),
(1708, 'Iv Dextrose Paed', 80, '', ''),
(1709, 'Iv Dextrose Saline', 55, '', ''),
(1710, 'Iv Flagyl 500mg', 100, '', ''),
(1711, 'Iv Haemacell', 15, '', ''),
(1712, 'Iv Meronem 500mg', 20, '', ''),
(1713, 'Iv Mesporin 250mg', 55, '', ''),
(1714, 'Iv Mesporin 500mg', 50, '', ''),
(1715, 'Iv Normal Saline', 45, '', ''),
(1716, 'IV Propofol', 60, '', ''),
(1717, 'Iv Quinine 300mg', 5, '', ''),
(1718, 'Iv Ringers Lactate', 45, '', ''),
(1719, 'IV Rocephin 1g', 20, '', ''),
(1720, 'Iv Tavanic 500mg', 60, '', ''),
(1721, 'Iv Thiopental 1g', 35, '', ''),
(1722, 'Iv Zithromax 500mg', 25, '', ''),
(1723, 'Lidocaine Gel', 70, '', ''),
(1724, 'M&G Multivitamin', 15, '', ''),
(1725, 'Maxidex Eye Drops', 60, '', ''),
(1726, 'Methyl Salicilate Oint.', 25, '', ''),
(1727, 'Mixtard Insulin 30', 45, '', ''),
(1728, 'Neo-Hycolex E\\E\\N Drops', 50, '', ''),
(1729, 'Neo Penotran Forte', 40, '', ''),
(1730, 'Normal Saline Nasal drops', 60, '', ''),
(1731, 'O.R.S', 90, '', ''),
(1732, 'Olfen Gel', 50, '', ''),
(1733, 'Sublingual Nifidipine 10mg', 5, '', ''),
(1734, 'Supiricon Cream', 90, '', ''),
(1735, 'Supp Annusol', 100, '', ''),
(1736, 'Supp Diclofenac 100mg', 5, '', ''),
(1737, 'Supp Plasmotium 200mg', 15, '', ''),
(1738, 'Supp Plasmotrium 50mg', 85, '', ''),
(1739, 'Supp P''mol 125mg', 55, '', ''),
(1740, 'Supp P''mol 1g', 15, '', ''),
(1741, 'Supp P''mol 250mg', 15, '', ''),
(1742, 'Supp P''mol 500mg', 55, '', ''),
(1743, 'Supp Prontogest 400mg', 55, '', ''),
(1744, 'Supp Scheriproct', 95, '', ''),
(1745, 'Supp Utrogestan 200mg', 15, '', ''),
(1746, 'Susp Amoksiclav 457mg', 45, '', ''),
(1747, 'Susp Amoxyl 125m5', 35, '', ''),
(1748, 'Susp Antacid Plus', 85, '', ''),
(1749, 'Susp Augmentin 228mg', 30, '', ''),
(1750, 'Susp Camoquine Plus', 90, '', ''),
(1751, 'Susp Fleming 228mg', 30, '', ''),
(1752, 'Susp Flucloxacillin', 100, '', ''),
(1753, 'Susp Fleming Drops', 95, '', ''),
(1754, 'Susp Gvither', 35, '', ''),
(1755, 'Susp Lonart', 70, '', ''),
(1756, 'Susp Maalox', 100, '', ''),
(1757, 'Susp Vermox', 75, '', ''),
(1758, 'Susp Zinnat 125mg', 15, '', ''),
(1759, 'Susp Zithromax 200mg', 60, '', ''),
(1760, 'Susp Z''max 2g', 90, '', ''),
(1761, 'Symbicort Inhaler', 45, '', ''),
(1762, 'Syrp Aerius', 90, '', ''),
(1763, 'Syrp Benylin with Codein', 95, '', ''),
(1764, 'Syrp Bioferon', 25, '', ''),
(1765, 'Syrp Bonnisan', 50, '', ''),
(1766, 'Syrp Calpol', 20, '', ''),
(1767, 'Syrp Citrizine 5mg', 80, '', ''),
(1768, 'Syrp ferozin', 70, '', ''),
(1769, 'Syrp Flagyl', 75, '', ''),
(1770, 'Syrp Fleming infant', 95, '', ''),
(1771, 'Syrp Kofol', 40, '', ''),
(1772, 'Syrp Lactulose', 80, '', ''),
(1773, 'Syrp Lexofen', 55, '', ''),
(1774, 'Syrp Menthodex', 30, '', ''),
(1775, 'Syrp Metrolex-F', 50, '', ''),
(1776, 'Syrp Nugel-O', 25, '', ''),
(1777, 'Syrp P''mol 125mg', 25, '', ''),
(1778, 'Syrp Rhinathiol Adult', 20, '', ''),
(1779, 'Syrp Rhinathiol Paed', 100, '', ''),
(1780, 'Syrp Septrin 240mg', 65, '', ''),
(1781, 'Syrp Seven Seas multivitamin', 70, '', ''),
(1782, 'Syrp Ventolin', 45, '', ''),
(1783, 'Syrp Vitamin C', 45, '', ''),
(1784, 'Syrp Zentel', 75, '', ''),
(1785, 'Syrp Zincovit', 15, '', ''),
(1786, 'Tab Aciclovir 200mg', 70, '', ''),
(1787, 'Tab Addyzoa', 80, '', ''),
(1788, 'Tab Allupurinol 300mg', 75, '', ''),
(1789, 'Tab Amoksiclav 1g', 20, '', ''),
(1790, 'Tab Amoksiclav 625mg', 80, '', ''),
(1791, 'Tab Amtripthline 25mg', 20, '', ''),
(1792, 'Tab Atacand Plus', 60, '', ''),
(1793, 'Tab Atenolol', 65, '', ''),
(1794, 'Tab Avomine 25mg', 55, '', ''),
(1795, 'Tab Bendro', 45, '', ''),
(1796, 'Tab Brufen', 35, '', ''),
(1797, 'Tab Buscopan 10mg', 10, '', ''),
(1798, 'Tab Cataflan 50mg', 40, '', ''),
(1799, 'Tab Cefix 200mg', 75, '', ''),
(1800, 'Tab Ciprolex 500mg', 5, '', ''),
(1801, 'Tab Cipro-TZ', 15, '', ''),
(1802, 'Tab Citrizine 10mg', 80, '', ''),
(1803, 'Tab Crestor 10mg', 85, '', ''),
(1804, 'Tab Clomid 50mg', 5, '', ''),
(1805, 'Tab Coartem', 65, '', ''),
(1806, 'Tab Codiovan 160/12.5MG', 90, '', ''),
(1807, 'Tab Codiovan80/12.5MG', 100, '', ''),
(1808, 'Tab Confido', 70, '', ''),
(1809, 'Tab Co-Trimaxole 480mg', 25, '', ''),
(1810, 'Tab Cytotec 200mg', 40, '', ''),
(1811, 'Tab Daflon 500mg', 95, '', ''),
(1812, 'Tab Daonil 5mg', 80, '', ''),
(1813, 'Tab Daraprim', 50, '', ''),
(1814, 'Tab Diazepam 5mg', 5, '', ''),
(1815, 'Tab Diclofenac', 40, '', ''),
(1816, 'Tab Decatylen Lozenges', 95, '', ''),
(1817, 'Tab Dilatrend 25mg', 85, '', ''),
(1818, 'Tab Dostinex 0.5mg', 50, '', ''),
(1819, 'Tab Evanova', 5, '', ''),
(1820, 'Tab Evecare', 90, '', ''),
(1821, 'Tab Exforge', 85, '', ''),
(1822, 'Tab Fenpar', 95, '', ''),
(1823, 'Tab Ferrous Sulphate', 85, '', ''),
(1824, 'Tab Flagentyl 500mg', 70, '', ''),
(1825, 'Tab Flagyl 200mg', 85, '', ''),
(1826, 'Tab Flex-It', 55, '', ''),
(1827, 'Tab Folic Acid', 10, '', ''),
(1828, 'Tab Forever  Mult  Maca', 70, '', ''),
(1829, 'Tab Forever Pro 6', 20, '', ''),
(1830, 'Tab Fromilid 500mg', 60, '', ''),
(1831, 'Tab Furosemide 40mg', 60, '', ''),
(1832, 'Tab Glizone 15mg', 15, '', ''),
(1833, 'Tab Glucophage', 100, '', ''),
(1834, 'Tab Greseofulvin 125mg', 25, '', ''),
(1835, 'Tab Hypnodid', 55, '', ''),
(1836, 'Tab Ideos', 20, '', ''),
(1837, 'Tab Legalon 70mg', 75, '', ''),
(1838, 'Tab Lescol 80mg', 65, '', ''),
(1839, 'Tab Lexotanil 1.5mg', 10, '', ''),
(1840, 'Tab Lipitor 10mg', 75, '', ''),
(1841, 'Tab Lisinopril', 50, '', ''),
(1842, 'Tab Liv 52', 100, '', ''),
(1843, 'Tab Lonart Forte', 55, '', ''),
(1844, 'Tab Lumartem', 100, '', ''),
(1845, 'Tab M2 Tone', 35, '', ''),
(1846, 'Tab Maalox', 70, '', ''),
(1847, 'Tab Metakelfin 500mg', 40, '', ''),
(1848, 'Tab Metoclopramide 10mg', 100, '', ''),
(1849, 'Tab Multivitamin', 50, '', ''),
(1850, 'Tab Naproxen 500mg', 100, '', ''),
(1851, 'Tab Nature Min', 45, '', ''),
(1852, 'Tab Netab Pro', 10, '', ''),
(1853, 'Tab Nexium', 20, '', ''),
(1854, 'Tab Nifecard XL 30mg', 100, '', ''),
(1855, 'Tab Nifedipine R 20mg', 20, '', ''),
(1856, 'Tab Nimesulide 100mg', 90, '', ''),
(1857, 'Tab Norvasc', 85, '', ''),
(1858, 'Tab Nospa 40mg', 45, '', ''),
(1859, 'Tab Osteovite', 55, '', ''),
(1860, 'Tab Parlodel 2.5mg', 15, '', ''),
(1861, 'Tab Pariet 20mg', 85, '', ''),
(1862, 'Tab Phenobarbitone 60mg', 95, '', ''),
(1863, 'Tab Primolut N', 95, '', ''),
(1864, 'Tab Prowoman', 15, '', ''),
(1865, 'Tab Phlebodia 600mg', 25, '', ''),
(1866, 'Tab Piriton', 85, '', ''),
(1867, 'Tab Plendil 10mg', 90, '', ''),
(1868, 'Tab P''mol 500mg', 70, '', ''),
(1869, 'Tab Prendisolone 5mg', 100, '', ''),
(1870, 'Tab Progynova 2mg(20''s)', 40, '', ''),
(1871, 'Tab Progynova 2mg(84''s)', 55, '', ''),
(1872, 'Tab Propanolol 40mg', 35, '', ''),
(1873, 'Tab Provera 5mg', 5, '', ''),
(1874, 'Tab Quinine 300mg', 65, '', ''),
(1875, 'Tab Salbutamol 4mg', 10, '', ''),
(1876, 'Tab Secnidazole 1g', 95, '', ''),
(1877, 'Tab Secure', 20, '', ''),
(1878, 'Tab Soluble Aspirin', 60, '', ''),
(1879, 'Tab Speman', 20, '', ''),
(1880, 'Tab Tavanic', 80, '', ''),
(1881, 'Tab Tenox', 5, '', ''),
(1882, 'Tab Traxenamic Acid 100mg', 20, '', ''),
(1883, 'Tab  Tylenol pm', 60, '', ''),
(1884, 'Tab Tylenol Adult', 15, '', ''),
(1885, 'Tab Tylenol Paed', 60, '', ''),
(1886, 'Tab Vermox 500mg', 75, '', ''),
(1887, 'Tab Vitafol', 60, '', ''),
(1888, 'Tab Vitamin B''complex', 35, '', ''),
(1889, 'Tab Vitamin B-Denk', 40, '', ''),
(1890, 'Tab Viagra  50mg', 90, '', ''),
(1891, 'Tab Vitamin C 500mg', 15, '', ''),
(1892, 'Tab Zinnat', 45, '', ''),
(1893, 'Ventolin Inhaler', 15, '', ''),
(1894, 'Ventolin Nebules', 45, '', ''),
(1895, 'Water for Injection', 5, '', ''),
(1896, 'Xylo Mepha nasal drops', 5, '', ''),
(1897, 'Emofluor Mouthwash', 80, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `drugtype`
--

CREATE TABLE IF NOT EXISTS `drugtype` (
  `drugType` varchar(30) DEFAULT NULL,
  `id` int(30) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `drugtype`
--


-- --------------------------------------------------------

--
-- Table structure for table `duration_options`
--

CREATE TABLE IF NOT EXISTS `duration_options` (
  `duration_id` int(11) NOT NULL AUTO_INCREMENT,
  `duration` varchar(255) NOT NULL,
  PRIMARY KEY (`duration_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `duration_options`
--

INSERT INTO `duration_options` (`duration_id`, `duration`) VALUES
(1, '2 Days'),
(2, '1 Day'),
(3, '1 Hour'),
(4, '2 Hours'),
(5, '1 Week');

-- --------------------------------------------------------

--
-- Table structure for table `extended`
--

CREATE TABLE IF NOT EXISTS `extended` (
  `code` varchar(20) NOT NULL,
  `icd10` text NOT NULL,
  `description` text NOT NULL,
  `type_id` int(11) NOT NULL,
  `unit_of_pricing` varchar(20) NOT NULL,
  `group_id` varchar(10) NOT NULL,
  `theragroup` int(11) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `extended`
--


-- --------------------------------------------------------

--
-- Table structure for table `facility`
--

CREATE TABLE IF NOT EXISTS `facility` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor_incharge` text NOT NULL,
  `facility_name` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `facility`
--

INSERT INTO `facility` (`id`, `doctor_incharge`, `facility_name`) VALUES
(8, 'Doctor In-Charge', 'Nungua Collection Point'),
(7, 'Doctor In-Charge', 'Private'),
(6, 'Dr. Peter K. Fosu', 'Danpong Clinic');

-- --------------------------------------------------------

--
-- Table structure for table `folder`
--

CREATE TABLE IF NOT EXISTS `folder` (
  `foldernumber` varchar(50) NOT NULL DEFAULT '',
  `shelvenumber` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `previouslocation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`foldernumber`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `folder`
--

INSERT INTO `folder` (`foldernumber`, `shelvenumber`, `status`, `previouslocation`) VALUES
('13DC1', 'J-0001', 'Consultation', 'Consultation'),
('13DC2', 'K-0001', 'ward_1', 'Clinic');

-- --------------------------------------------------------

--
-- Table structure for table `folder_numbering`
--

CREATE TABLE IF NOT EXISTS `folder_numbering` (
  `numbering_id` int(11) NOT NULL AUTO_INCREMENT,
  `folder_abbreviation_clinic` text NOT NULL,
  `folder_abbreviation_diagnostics` text NOT NULL,
  `folder_abbreviation_pharmacy` text NOT NULL,
  `clinic_start_number` int(11) NOT NULL,
  `diagnostic_start_number` int(11) NOT NULL,
  `pharmacy_start_number` int(11) NOT NULL,
  `clinic_counter` int(11) NOT NULL,
  `diagnostic_counter` int(11) NOT NULL,
  `pharmacy_counter` int(11) NOT NULL,
  PRIMARY KEY (`numbering_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `folder_numbering`
--

INSERT INTO `folder_numbering` (`numbering_id`, `folder_abbreviation_clinic`, `folder_abbreviation_diagnostics`, `folder_abbreviation_pharmacy`, `clinic_start_number`, `diagnostic_start_number`, `pharmacy_start_number`, `clinic_counter`, `diagnostic_counter`, `pharmacy_counter`) VALUES
(1, 'DC', 'DL', 'DPH', 0, 20577, 0, 0, 126, 0);

-- --------------------------------------------------------

--
-- Table structure for table `general_settings`
--

CREATE TABLE IF NOT EXISTS `general_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` tinyint(1) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `staff_id` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `name`, `value`, `date_added`, `staff_id`) VALUES
(1, 'lab_report_header_active', 0, '2013-08-09 07:27:15', 'ClaimSync0006'),
(2, 'lab_report_footer_active', 1, '2013-08-13 10:19:18', 'ClaimSync0006');

-- --------------------------------------------------------

--
-- Table structure for table `general_stock_movement`
--

CREATE TABLE IF NOT EXISTS `general_stock_movement` (
  `move_id` int(11) NOT NULL AUTO_INCREMENT,
  `date_of_movement` date NOT NULL,
  `pharmacy_batch_number` varchar(255) DEFAULT NULL,
  `dispensary_batch_number` varchar(255) DEFAULT NULL,
  `quantity_b4_transfer` int(11) NOT NULL,
  `quantity_transferred` int(11) NOT NULL,
  `quantity_after_transfer` int(11) NOT NULL,
  `issued_by` varchar(255) NOT NULL,
  `issued_to` varchar(255) DEFAULT NULL,
  `reason` text NOT NULL,
  PRIMARY KEY (`move_id`),
  KEY `issued_by` (`issued_by`),
  KEY `issued_to` (`issued_to`),
  KEY `pharmacy_batch_number` (`pharmacy_batch_number`),
  KEY `dispensary_batch_number` (`dispensary_batch_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `general_stock_movement`
--


-- --------------------------------------------------------

--
-- Table structure for table `inventory_items`
--

CREATE TABLE IF NOT EXISTS `inventory_items` (
  `item_description` varchar(255) NOT NULL,
  `item_code` varchar(100) NOT NULL,
  `quantity_on_hand` int(11) NOT NULL,
  `manufacturer` varchar(500) NOT NULL,
  `price_markup` double NOT NULL,
  `percentage_markup` double NOT NULL,
  `form_id` int(11) NOT NULL,
  `unit_of_issue` int(11) DEFAULT NULL,
  `reorder_level` int(11) NOT NULL,
  `minimum_stock_level` int(11) NOT NULL,
  `strength` varchar(255) NOT NULL,
  `active_ingredients` varchar(1000) DEFAULT NULL,
  `reorder_qty` int(11) NOT NULL,
  `maximum_stock_level` int(11) DEFAULT NULL,
  `therapeutic_group` int(11) NOT NULL,
  `vatable` tinyint(1) NOT NULL,
  `location` varchar(255) NOT NULL,
  PRIMARY KEY (`item_code`),
  KEY `form_id` (`form_id`),
  KEY `unit_of_issue` (`unit_of_issue`),
  KEY `therapeutic_group` (`therapeutic_group`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inventory_items`
--

INSERT INTO `inventory_items` (`item_description`, `item_code`, `quantity_on_hand`, `manufacturer`, `price_markup`, `percentage_markup`, `form_id`, `unit_of_issue`, `reorder_level`, `minimum_stock_level`, `strength`, `active_ingredients`, `reorder_qty`, `maximum_stock_level`, `therapeutic_group`, `vatable`, `location`) VALUES
('Coartem', 'COARTE', 0, 'Norvatis', 1.4, 12, 3, 1, 300, 200, '500mg', 'Anti Malaris', 200, 500, 2, 0, 'PHY'),
('Paracetamol Injection', 'PARAINJE', 0, 'Norvatis', 0.3, 1.2, 1, 2, 800, 200, '125mg', 'Parcetamol', 200, 1000, 2, 0, 'DIS');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_transfer`
--

CREATE TABLE IF NOT EXISTS `inventory_transfer` (
  `transfer_id` int(11) NOT NULL AUTO_INCREMENT,
  `from_location` varchar(10) NOT NULL,
  `to_location` varchar(10) NOT NULL,
  `initiating_staff` varchar(255) NOT NULL,
  `reveiving_staff` varchar(100) NOT NULL,
  `date_of_issue` date NOT NULL,
  `approved_by` varchar(100) NOT NULL,
  `approve_by_second` varchar(100) NOT NULL,
  PRIMARY KEY (`transfer_id`),
  KEY `initiating_staff` (`initiating_staff`),
  KEY `reveiving_staff` (`reveiving_staff`),
  KEY `approved_by` (`approved_by`),
  KEY `approve_by_second` (`approve_by_second`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `inventory_transfer`
--


-- --------------------------------------------------------

--
-- Table structure for table `investigation`
--

CREATE TABLE IF NOT EXISTS `investigation` (
  `detailed_inv_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(25) NOT NULL,
  `name` varchar(225) NOT NULL,
  `rate` double DEFAULT NULL,
  `nhis_rate` double NOT NULL,
  `low_bound` varchar(50) DEFAULT NULL,
  `high_bound` varchar(50) DEFAULT NULL,
  `lab_type_id` int(11) NOT NULL,
  `type_of_test_id` int(11) NOT NULL,
  `grouped_under_id` int(11) DEFAULT '0',
  `units` varchar(50) DEFAULT NULL,
  `interpretation` text,
  `default_value` varchar(50) DEFAULT NULL,
  `range_from` varchar(50) DEFAULT NULL,
  `range_up_to` varchar(50) DEFAULT NULL,
  `comments` text,
  `report_coll_days` varchar(225) DEFAULT NULL,
  `report_coll_time` date DEFAULT NULL,
  `result_options` tinyint(1) NOT NULL,
  `ref_range_type` varchar(11) NOT NULL,
  `specimen_id` int(11) NOT NULL,
  `antibiotic` tinyint(1) NOT NULL,
  `order_num` int(11) DEFAULT NULL,
  `is_subheading` tinyint(1) NOT NULL,
  `active` int(11) NOT NULL,
  PRIMARY KEY (`detailed_inv_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=433 ;

--
-- Dumping data for table `investigation`
--

INSERT INTO `investigation` (`detailed_inv_id`, `code`, `name`, `rate`, `nhis_rate`, `low_bound`, `high_bound`, `lab_type_id`, `type_of_test_id`, `grouped_under_id`, `units`, `interpretation`, `default_value`, `range_from`, `range_up_to`, `comments`, `report_coll_days`, `report_coll_time`, `result_options`, `ref_range_type`, `specimen_id`, `antibiotic`, `order_num`, `is_subheading`, `active`) VALUES
(1, 'Malaria', 'Malaria Examination (Thick Film)', 10, 10, NULL, 'NA', 1, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-07-09', 1, 'non', 1, 0, 4, 0, 1),
(2, 'MALA. Ag', 'Malaria Antigen (RDT)', 15, 15, NULL, 'NA', 1, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-07-09', 1, 'non', 1, 0, 5, 0, 0),
(3, 'ESR', 'Erythrocytes Sedimentation Rate', 15, 0, NULL, 'NA', 1, 1, 0, 'mm/Hr', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-03', 1, 'det', 1, 0, 2, 0, 0),
(4, 'BLOOD GRP', 'Blood Group (ABO & Rh. Factor)', 15, 0, NULL, 'NA', 1, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'non', 1, 0, 6, 0, 0),
(5, 'ELECT', 'ELECTROPHORESIS', 30, 0, NULL, 'NA', 1, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 0, 'non', 1, 0, 7, 0, 0),
(6, 'SICK', 'Sickling', 0, 0, NULL, 'NA', 1, 2, 5, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'non', 1, 0, NULL, 0, 0),
(7, 'Hb. ELECT', 'Hb. Electrophoresis', 0, 0, NULL, 'NA', 1, 2, 5, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'non', 1, 0, NULL, 0, 0),
(8, 'G6PD', 'G6PD Activity', 20, 0, NULL, 'NA', 1, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'non', 1, 0, 8, 0, 0),
(9, 'COOMBS', 'COOMBS', 20, 0, NULL, 'NA', 1, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 0, 'non', 1, 0, 9, 0, 0),
(10, 'D. COOMBS', 'Direct Coombs', 0, 0, NULL, 'NA', 1, 2, 9, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'non', 1, 0, NULL, 0, 0),
(11, 'I. COOMBS', 'Indirect Coombs', 0, 0, NULL, 'NA', 1, 2, 9, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'non', 1, 0, NULL, 0, 0),
(317, 'WBC', 'White Blood Cells (WBC)', 0, 0, NULL, 'NA', 1, 2, 315, '10^3/uL', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'det', 1, 0, 1, 0, 0),
(320, 'Hg', 'Haemoglobin (Hb)', 0, 0, NULL, 'NA', 1, 2, 315, 'g/dL', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'det', 1, 0, 3, 0, 0),
(19, 'WIDAL', 'WIDAL SCREEN', 15, 15, NULL, 'NA', 2, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-16', 0, 'non', 1, 0, 1, 0, 0),
(20, 'TO', 'Salmonella typhi O', 0, 0, NULL, 'NA', 2, 2, 19, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-15', 1, 'uni', 1, 0, NULL, 0, 0),
(21, 'TH', 'Salmonella typhi H', 0, 0, NULL, 'NA', 2, 2, 19, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'uni', 1, 0, NULL, 0, 0),
(22, 'AO', 'Salmonella paratyphi AO', 0, 0, NULL, 'NA', 2, 2, 19, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'uni', 1, 0, NULL, 0, 0),
(23, 'AH', 'Salmonella paratyphi AH', 0, 0, NULL, 'NA', 2, 2, 19, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'uni', 1, 0, NULL, 0, 0),
(24, 'BO', 'Salmonella paratyphi BO', 0, 0, NULL, 'NA', 2, 2, 19, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'uni', 1, 0, NULL, 0, 0),
(25, 'BH', 'Salmonella paratyphi BH', 0, 0, NULL, 'NA', 2, 2, 19, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'uni', 1, 0, NULL, 0, 0),
(26, 'CO', 'Salmonella paratyphi CO', 0, 0, NULL, 'NA', 2, 2, 19, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'uni', 1, 0, NULL, 0, 0),
(27, 'CH', 'Salmonella paratyphi CH', 0, 0, NULL, 'NA', 2, 2, 19, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'uni', 1, 0, NULL, 0, 0),
(28, 'HBV PROFILE', 'HEPATITIS B VIRUS PROFILE', 80, 0, NULL, 'NA', 2, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 0, 'non', 1, 0, 4, 0, 0),
(29, 'HBsAg', 'Hepatitis B Surface Antigen', 0, 0, NULL, 'NA', 2, 2, 28, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'non', 1, 0, NULL, 0, 0),
(30, 'HBsAb', 'Hepatitis B Surface Antibody', 0, 0, NULL, 'NA', 2, 2, 28, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'non', 1, 0, NULL, 0, 0),
(31, 'HBeAg', 'Hepatitis B Envelope Antigen', 0, 0, NULL, 'NA', 2, 2, 28, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'non', 1, 0, NULL, 0, 0),
(32, 'HBeAb', 'Hepatitis B Envelope Antibody', 0, 0, NULL, 'NA', 2, 2, 28, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'non', 1, 0, NULL, 0, 0),
(34, 'HBsAg', 'Hepatitis B Surface Antigen', 15, 0, NULL, 'NA', 2, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 1, 0, 3, 0, 0),
(35, 'HCV', 'Hepatitis C Virus Screen', 20, 0, NULL, 'NA', 2, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'non', 1, 0, 5, 0, 0),
(36, 'SYPHILIS', 'Syphilis Antibody Screen', 20, 0, NULL, 'NA', 2, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'non', 1, 0, 6, 0, 0),
(37, 'VDRL/RPR', 'VDRL / RPR Screen', 20, 0, NULL, 'NA', 2, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'non', 1, 0, 7, 0, 0),
(39, 'CHL', 'Chlamydia Screen', 30, 0, NULL, 'NA', 2, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'non', 1, 0, 9, 0, 0),
(42, 'FBS', 'Fasting Blood Glucose', 10, 10, NULL, 'NA', 18, 1, 0, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-03-06', 1, 'det', 1, 0, 1, 0, 0),
(43, 'RBS', 'Random Blood Glucose', 10, 0, NULL, 'NA', 18, 1, 0, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 0, 'det', 1, 0, 2, 0, 0),
(44, 'URINE G.', 'URINE SUGAR & KETONES', 10, 10, NULL, 'NA', 18, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-03-06', 0, 'non', 2, 0, 3, 0, 0),
(45, 'SUGAR', 'Sugar', 0, 0, NULL, 'NA', 18, 2, 44, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'non', 2, 0, NULL, 0, 0),
(46, 'KETONES', 'Ketones', 0, 0, NULL, 'NA', 18, 2, 44, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 1, 'non', 2, 0, NULL, 0, 0),
(47, '2HR PP', 'POST PRANDIAL GLUCOSE (2HR)', 20, 20, NULL, 'NA', 18, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 1, 0, 6, 0, 0),
(48, 'FASTING', 'Fasting Blood Glucose', 0, 0, NULL, 'NA', 18, 2, 47, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 0, 'det', 1, 0, NULL, 0, 0),
(49, '2HR PP', '2 Hour Post Prandial', 0, 0, NULL, 'NA', 18, 2, 47, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 0, 'det', 1, 0, NULL, 0, 0),
(50, 'GTT', 'GLUCOSE TOLERANCE (75g - 2HR)', 40, 40, NULL, 'NA', 18, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 1, 0, 5, 0, 0),
(51, 'FBS', 'Fasting Blood Glucose', 0, 0, NULL, 'NA', 18, 2, 50, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 0, 'non', 1, 0, NULL, 0, 0),
(52, '1HR FBS', '1 Hour Blood Glucose', 0, 0, NULL, 'NA', 18, 2, 50, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 0, 'non', 1, 0, NULL, 0, 0),
(53, '2HR FBS', '2 Hour Blood Glucose', 0, 0, NULL, 'NA', 18, 2, 50, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-07', 0, 'uni', 1, 0, NULL, 0, 0),
(54, 'HBA1C', 'HbA1C (Red Cells)', 40, 40, NULL, 'NA', 18, 1, 0, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-03-06', 1, 'uni', 1, 0, 4, 0, 0),
(55, 'URIC ACID', 'Uric Acid', 15, 0, NULL, 'NA', 3, 1, 0, 'umol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-03', 0, 'det', 1, 0, 4, 0, 0),
(56, 'AMYLASE', 'Amylase', 20, 20, NULL, 'NA', 19, 1, 0, 'U/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-03-06', 1, 'det', 1, 0, NULL, 0, 0),
(58, 'Ca+', 'Calcium', 20, 0, NULL, 'NA', 3, 1, 0, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'det', 1, 0, 5, 0, 0),
(59, 'PHOS', 'Phosphorus', 20, 0, NULL, 'NA', 3, 1, 0, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'det', 1, 0, 7, 0, 0),
(60, 'Mg+', 'Magnesium', 20, 0, NULL, 'NA', 3, 1, 0, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'det', 1, 0, 6, 0, 0),
(61, 'BUE', 'KIDNEY FUNCTION TESTS', 45, 0, NULL, 'NA', 3, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 1, 0, 2, 0, 0),
(72, 'CHOLES', 'Cholesterol (Total)', 0, 0, NULL, 'NA', 3, 2, 71, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'uni', 1, 0, NULL, 0, 0),
(62, 'CREAT.', 'Creatinine', 0, 0, NULL, 'NA', 3, 2, 61, 'umol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'det', 1, 0, NULL, 0, 0),
(63, 'UREA', 'Urea', 0, 0, NULL, 'NA', 3, 2, 61, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'det', 1, 0, NULL, 0, 0),
(64, 'K+', 'Potassium', 0, 0, NULL, 'NA', 3, 2, 61, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'det', 1, 0, NULL, 0, 0),
(65, 'Na+', 'Sodium', 0, 0, NULL, 'NA', 3, 2, 61, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'det', 1, 0, NULL, 0, 0),
(66, 'Cl-', 'Chloride', 0, 0, NULL, 'NA', 3, 2, 61, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'det', 1, 0, NULL, 0, 0),
(71, 'LIPIDS', 'LIPID PROFILE', 40, 0, NULL, 'NA', 3, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'non', 1, 0, 3, 0, 0),
(73, 'HDL', 'HDL Cholesterol', 0, 0, NULL, 'NA', 3, 2, 71, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'uni', 1, 0, NULL, 0, 0),
(75, 'LDL', 'LDL Cholesterol (Calculated)', 0, 0, NULL, 'NA', 3, 2, 71, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'uni', 1, 0, NULL, 0, 0),
(76, 'TRIG.', 'Triglycerides', 0, 0, NULL, 'NA', 3, 2, 71, 'mmol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'uni', 1, 0, NULL, 0, 0),
(77, 'TC/HDL', 'Cholesterol (Total) / HDL Ratio', 0, 0, NULL, 'NA', 3, 2, 71, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-03', 0, 'uni', 1, 0, NULL, 0, 0),
(78, 'LIVER FT.', 'LIVER FUNCTION TESTS', 50, 0, NULL, 'NA', 3, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'non', 1, 0, 1, 0, 0),
(79, 'T. BIL', 'Total Bilirubin', 0, 0, NULL, 'NA', 3, 2, 78, 'umol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'det', 1, 0, NULL, 0, 0),
(80, 'D. BIL', 'Direct Bilirubin', 0, 0, NULL, 'NA', 3, 2, 78, 'umol/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'det', 1, 0, NULL, 0, 0),
(81, 'T. PRO', 'Total Protein', 0, 0, NULL, 'NA', 3, 2, 78, 'g/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'det', 1, 0, NULL, 0, 0),
(82, 'ALBU', 'Albumin', 0, 0, NULL, 'NA', 3, 2, 78, 'g/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'det', 1, 0, NULL, 0, 0),
(83, 'AST', 'ASAT / SGOT', 0, 0, NULL, 'NA', 3, 2, 78, 'U/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'det', 1, 0, NULL, 0, 0),
(84, 'ALT', 'ALAT / SGPT', 0, 0, NULL, 'NA', 3, 2, 78, 'U/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'det', 1, 0, NULL, 0, 0),
(85, 'ALK. PHO', 'Alkaline Phosphatase', 0, 0, NULL, 'NA', 3, 2, 78, 'U/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'det', 1, 0, NULL, 0, 0),
(86, 'LDH', 'LDH', 0, 0, NULL, 'NA', 3, 2, 78, 'U/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'det', 1, 0, NULL, 0, 0),
(87, 'GGT', 'Gamma GT', 0, 0, NULL, 'NA', 3, 2, 78, 'U/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'det', 1, 0, NULL, 0, 0),
(120, 'URINE  C/S.', 'URINE ROUTINE, CULTURE & SENSITIVITY', 40, 0, NULL, 'NA', 5, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-23', 0, 'non', 2, 0, 1, 0, 0),
(121, 'URINE RE', 'ROUTINE EXAMINATION', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'non', 2, 0, NULL, 1, 0),
(122, 'MAC. U', 'Macroscopic Examination', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'non', 2, 0, NULL, 1, 0),
(123, 'APP. U', 'Appearance', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(124, 'COL. U', 'Colour', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(125, 'BIO. U', 'Biochemical Activities', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 0, 'non', 2, 0, NULL, 1, 0),
(126, 'PH. U', 'pH', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(127, 'S.G. U', 'Specific Gravity', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(128, 'GLU. U', 'Glucose', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(129, 'LEUC. U', 'Leucocytes', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(130, 'BLOOD. U', 'Blood', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(131, 'KET. U', 'Ketones', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(132, 'PROT. U', 'Protein', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(133, 'NIT. U', 'Nitrite', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(134, 'BILI. U', 'Bilirubin', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(135, 'UROB. U', 'Urobilinogen', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(136, 'MIC. U', 'Microscopic Examination', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'non', 2, 0, NULL, 1, 0),
(137, 'WBC. U', 'White Blood Cells', 0, 0, NULL, 'NA', 5, 2, 120, 'per hpf ', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 2, 0, NULL, 0, 0),
(138, 'RBC. U', 'Red Blood Cells', 0, 0, NULL, 'NA', 5, 2, 120, 'per hpf', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 2, 0, NULL, 0, 0),
(139, 'EPI. U', 'Epithelial Cells', 0, 0, NULL, 'NA', 5, 2, 120, 'per hpf', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 2, 0, NULL, 0, 0),
(140, 'S. H. U', 'S. haematobium ova', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(141, 'YEAST. U', 'Yeast Cells', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(142, 'TRICH. U', 'Trichomonas vaginalis', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(143, 'BACT. U', 'Bacterial Cells', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(144, 'CAST. U', 'Casts', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(145, 'CRYS. U', 'Crystals', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 2, 0, NULL, 0, 0),
(146, 'CULTURE', 'CULTURE & SENSITIVITY', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'non', 2, 0, NULL, 1, 0),
(147, 'ORGANISM', 'Organism Isolated', 0, 0, NULL, 'NA', 5, 2, 120, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'non', 2, 1, NULL, 0, 0),
(148, 'STOOL C/S', 'STOOL ROUTINE, CULTURE & SENSITIVITY', 40, 0, NULL, 'NA', 5, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-26', 0, 'non', 4, 0, 2, 0, 0),
(149, 'STOOL RE', 'ROUTINE EXAMINATION', 0, 0, NULL, 'NA', 5, 2, 148, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'non', 4, 0, NULL, 1, 0),
(150, 'MAC. S', 'Macroscopic Examination', 0, 0, NULL, 'NA', 5, 2, 148, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'non', 4, 0, NULL, 1, 0),
(151, 'APP. S', 'Appearance / Consistency', 0, 0, NULL, 'NA', 5, 2, 148, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 4, 0, NULL, 0, 0),
(152, 'MIC. U', 'Microscopic Examination', 0, 0, NULL, 'NA', 5, 2, 148, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'non', 4, 0, NULL, 1, 0),
(153, 'WBC. S', 'White Blood Cells', 0, 0, NULL, 'NA', 5, 2, 148, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-26', 1, 'non', 4, 0, NULL, 0, 0),
(154, 'RBC. S', 'Red Blood Cells', 0, 0, NULL, 'NA', 5, 2, 148, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-26', 0, 'non', 4, 0, NULL, 0, 0),
(155, 'PARA. S', 'Parasites', 0, 0, NULL, 'NA', 5, 2, 148, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 1, 'non', 4, 0, NULL, 0, 0),
(156, 'CULTURE', 'CULTURE & SENSITIVITY', 0, 0, NULL, 'NA', 5, 2, 148, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'non', 4, 0, NULL, 1, 0),
(157, 'ORGANISM', 'Organism Isolated', 0, 0, NULL, 'NA', 5, 2, 148, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-08', 0, 'non', 4, 1, NULL, 0, 0),
(158, 'HVS RE / CS', 'HIGH VAGINAL SWAB ROUTINE, CULTURE & SENSITIVITY', 40, 0, NULL, 'NA', 5, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-23', 0, 'non', 3, 0, 3, 0, 0),
(159, 'WET', 'Wet Preparation', 0, 0, NULL, 'NA', 5, 2, 158, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 0, NULL, 1, 0),
(160, 'WBC', 'White Blood Cells', 0, 0, NULL, 'NA', 5, 2, 158, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(161, 'RBC', 'Red Blood Cells', 0, 0, NULL, 'NA', 5, 2, 158, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(162, 'EPI', 'Epithelial Cells', 0, 0, NULL, 'NA', 5, 2, 158, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(163, 'YEAST', 'Yeast Cells', 0, 0, NULL, 'NA', 5, 2, 158, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(164, 'TRICH', 'Trichomonas vaginalis', 0, 0, NULL, 'NA', 5, 2, 158, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(165, 'CLUE C', 'Clue Cells', 0, 0, NULL, 'NA', 5, 2, 158, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(166, 'GRAM', 'Gram Staining', 0, 0, NULL, 'NA', 5, 2, 158, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 1, 0),
(167, 'GPB', 'Gram Positive Bacilli', 0, 0, NULL, 'NA', 5, 2, 158, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(168, 'GNB', 'Gram Negative Bacilli', 0, 0, NULL, 'NA', 5, 2, 158, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(169, 'GPC', 'Gram Positive Cocci', 0, 0, NULL, 'NA', 5, 2, 158, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(170, 'GNC', 'Gram Negative Cocci', 0, 0, NULL, 'NA', 5, 2, 158, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(171, 'GVB', 'Gram Variable Bacilli', 0, 0, NULL, 'NA', 5, 2, 158, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(172, 'GVCB', 'Gram Variable Coccobacilli', 0, 0, NULL, 'NA', 5, 2, 158, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(173, 'GNID', 'G.N.I.D.', 0, 0, NULL, 'NA', 5, 2, 158, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(174, 'CULTURE', 'CULTURE & SENSITIVITY', 0, 0, NULL, 'NA', 5, 2, 158, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 0, NULL, 1, 0),
(175, 'ORGANISM', 'Organism Isolated', 0, 0, NULL, 'NA', 5, 2, 158, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 1, NULL, 0, 0),
(176, 'CERVICAL', 'CERVICAL SWAB ROUTINE, CULTURE & SENSITIVITY', 40, 0, NULL, 'NA', 5, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-23', 0, 'non', 3, 0, 4, 0, 0),
(177, 'WET', 'Wet Preparation', 0, 0, NULL, 'NA', 5, 2, 176, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 0, 1, 1, 0),
(178, 'WBC', 'White Blood Cells', 0, 0, NULL, 'NA', 5, 2, 176, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 2, 0, 0),
(179, 'RBC. C', 'Red Blood Cells', 0, 0, NULL, 'NA', 5, 2, 176, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 3, 0, 3, 0, 0),
(180, 'EPI. C', 'Epithelial Cells', 0, 0, NULL, 'NA', 5, 2, 176, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 4, 0, 0),
(181, 'YEAST. C', 'Yeast Cells', 0, 0, NULL, 'NA', 5, 2, 176, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 5, 0, 0),
(182, 'CLUE C', 'Clue Cells', 0, 0, NULL, 'NA', 5, 2, 176, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 7, 0, 0),
(183, 'GRAM', 'Gram Staining', 0, 0, NULL, 'NA', 5, 2, 176, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 0, 8, 1, 0),
(184, 'GPB', 'Gram Positive Bacilli', 0, 0, NULL, 'NA', 5, 2, 176, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 9, 0, 0),
(185, 'GNB', 'Gram Negative Bacilli', 0, 0, NULL, 'NA', 5, 2, 176, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 10, 0, 0),
(186, 'GPC', 'Gram Positive Cocci', 0, 0, NULL, 'NA', 5, 2, 176, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 11, 0, 0),
(187, 'GNC', 'Gram Negative Cocci', 0, 0, NULL, 'NA', 5, 2, 176, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 12, 0, 0),
(188, 'GVB', 'Gram Variable Bacilli', 0, 0, NULL, 'NA', 5, 2, 176, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 13, 0, 0),
(189, 'GVCB', 'Gram Variable Coccobacilli', 0, 0, NULL, 'NA', 5, 2, 176, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 14, 0, 0),
(190, 'GNID', 'G.N.I.D.', 0, 0, NULL, 'NA', 5, 2, 176, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 15, 0, 0),
(191, 'CULTURE', 'CULTURE & SENSITIVITY', 0, 0, NULL, 'NA', 5, 2, 176, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 0, 16, 1, 0),
(192, 'ORGANISM', 'Organism Isolated', 0, 0, NULL, 'NA', 5, 2, 176, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 1, 17, 0, 0),
(193, 'URETHRAL', 'URETHRAL SWAB ROUTINE, CULTURE & SENSITIVITY', 40, 0, NULL, 'NA', 5, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-23', 0, 'non', 3, 0, 5, 0, 0),
(194, 'GRAM', 'Gram Staining', 0, 0, NULL, 'NA', 5, 2, 193, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 0, 1, 1, 0),
(195, 'WBC. UR', 'White Blood Cells', 0, 0, NULL, 'NA', 5, 2, 193, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 2, 0, 0),
(196, 'EPI. UR', 'Epithelial Cells', 0, 0, NULL, 'NA', 5, 2, 193, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 3, 0, 0),
(197, 'GPC', 'Gram Positive Cocci', 0, 0, NULL, 'NA', 5, 2, 193, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 4, 0, 0),
(198, 'GNC', 'Gram Negative Cocci', 0, 0, NULL, 'NA', 5, 2, 193, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 5, 0, 0),
(199, 'GPB', 'Gram Positive Bacilli', 0, 0, NULL, 'NA', 5, 2, 193, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 6, 0, 0),
(201, 'GNID UT', 'G.N.I.D.', 0, 0, NULL, 'NA', 5, 2, 193, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 8, 0, 0),
(202, 'GNED', 'G.N.E.D.', 0, 0, NULL, 'NA', 5, 2, 193, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 9, 0, 0),
(203, 'CULTURE', 'CULTURE & SENSITIVITY', 0, 0, NULL, 'NA', 5, 2, 193, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 0, 10, 1, 0),
(204, 'ORGANISM', 'Organism Isolated', 0, 0, NULL, 'NA', 5, 2, 193, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 1, 11, 0, 0),
(205, 'EAR RE / CS', 'EAR SWAB ROUTINE, CULTURE & SENSITIVITY', 40, 0, NULL, 'NA', 5, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-23', 0, 'non', 3, 0, 6, 0, 0),
(206, 'GRAM', 'Gram Staining', 0, 0, NULL, 'NA', 5, 2, 205, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 0, 1, 1, 0),
(207, 'WBC. E', 'White Blood Cells', 0, 0, NULL, 'NA', 5, 2, 205, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 2, 0, 0),
(208, 'EPI. E', 'Epithelial Cells', 0, 0, NULL, 'NA', 5, 2, 205, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 3, 0, 0),
(209, 'GPB', 'Gram Positive Bacilli', 0, 0, NULL, 'NA', 5, 2, 205, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 4, 0, 0),
(210, 'GNB', 'Gram Negative Bacilli', 0, 0, NULL, 'NA', 5, 2, 193, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 7, 0, 0),
(211, 'GPC', 'Gram Positive Cocci', 0, 0, NULL, 'NA', 5, 2, 205, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 6, 0, 0),
(212, 'GNC', 'Gram Negative Cocci', 0, 0, NULL, 'NA', 5, 2, 205, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 7, 0, 0),
(215, 'CULTURE', 'CULTURE & SENSITIVITY', 0, 0, NULL, 'NA', 5, 2, 205, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 0, 10, 1, 0),
(216, 'ORGANISM', 'Organism Isolated', 0, 0, NULL, 'NA', 5, 2, 205, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 1, 11, 0, 0),
(217, 'GNB', 'Gram Negative Bacilli', 0, 0, NULL, 'NA', 5, 2, 205, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 5, 0, 0),
(218, 'NASAL RE/CS', 'NASAL SWAB ROUTINE, CULTURE & SENSITIVITY', 40, 0, NULL, 'NA', 5, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-23', 0, 'non', 3, 0, 8, 0, 0),
(219, 'GRAM', 'Gram Staining', 0, 0, NULL, 'NA', 5, 2, 218, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 0, NULL, 1, 0),
(220, 'WBC. N', 'White Blood Cells', 0, 0, NULL, 'NA', 5, 2, 218, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(221, 'EPI. N', 'Epithelial Cells', 0, 0, NULL, 'NA', 5, 2, 218, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(222, 'GPB', 'Gram Positive Bacilli', 0, 0, NULL, 'NA', 5, 2, 218, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(223, 'GNB', 'Gram Negative Bacilli', 0, 0, NULL, 'NA', 5, 2, 218, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(224, 'GPC', 'Gram Positive Cocci', 0, 0, NULL, 'NA', 5, 2, 218, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(225, 'GNC', 'Gram Negative Cocci', 0, 0, NULL, 'NA', 5, 2, 218, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(226, 'CULTURE', 'CULTURE & SENSITIVITY', 0, 0, NULL, 'NA', 5, 2, 218, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 0, NULL, 1, 0),
(227, 'ORGANISM', 'Organism Isolated', 0, 0, NULL, 'NA', 5, 2, 218, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 1, NULL, 0, 0),
(228, 'EYE RE /CS', 'EYE SWAB ROUTINE, CULTURE & SENSITIVITY', 40, 0, NULL, 'NA', 5, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-26', 0, 'non', 3, 0, 7, 0, 0),
(229, 'GRAM', 'Gram Staining', 0, 0, NULL, 'NA', 5, 2, 228, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 0, NULL, 1, 0),
(230, 'WBC. E', 'White Blood Cells', 0, 0, NULL, 'NA', 5, 2, 228, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(231, 'EPI. E', 'Epithelial Cells', 0, 0, NULL, 'NA', 5, 2, 228, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(232, 'GPB', 'Gram Positive Bacilli', 0, 0, NULL, 'NA', 5, 2, 228, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(233, 'GNB', 'Gram Negative Bacilli', 0, 0, NULL, 'NA', 5, 2, 228, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(234, 'GPC', 'Gram Positive Cocci', 0, 0, NULL, 'NA', 5, 2, 228, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(235, 'GNC', 'Gram Negative Cocci', 0, 0, NULL, 'NA', 5, 2, 228, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(236, 'CULTURE', 'CULTURE & SENSITIVITY', 0, 0, NULL, 'NA', 5, 2, 228, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 0, NULL, 1, 0),
(237, 'ORGANISM', 'Organism Isolated', 0, 0, NULL, 'NA', 5, 2, 228, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 1, NULL, 0, 0),
(238, 'WOUND RE / CS', 'WOUND SWAB ROUTINE, CULTURE & SENSISTIVITY', 40, 0, NULL, 'NA', 5, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-23', 0, 'non', 3, 0, 11, 0, 0),
(239, 'GRAM', 'Gram Staining', 0, 0, NULL, 'NA', 5, 2, 238, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 0, NULL, 1, 0),
(240, 'WBC W', 'White Blood Cells', 0, 0, NULL, 'NA', 5, 2, 238, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(241, 'EPI. W', 'Epithelial Cells', 0, 0, NULL, 'NA', 5, 2, 238, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(242, 'GPB', 'Gram Positive Bacilli', 0, 0, NULL, 'NA', 5, 2, 238, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(243, 'GNB', 'Gram Negative Bacilli', 0, 0, NULL, 'NA', 5, 2, 238, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(244, 'GPC', 'Gram Positive Cocci', 0, 0, NULL, 'NA', 5, 2, 238, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(245, 'GNC', 'Gram Negative Cocci', 0, 0, NULL, 'NA', 5, 2, 238, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, NULL, 0, 0),
(246, 'CULTURE', 'Culture & Sensitivity', 0, 0, NULL, 'NA', 5, 2, 238, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-24', 0, 'non', 3, 0, NULL, 1, 0),
(247, 'ORGANISM', 'Organism Isolated', 0, 0, NULL, 'NA', 5, 2, 238, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 1, NULL, 0, 0),
(248, 'SPUTUM RE /CS', 'SPUTUM ROUTINE, CULTURE & SENSITIVITY', 40, 0, NULL, 'NA', 5, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-23', 0, 'non', 7, 0, 10, 0, 0),
(249, 'THROAT RE / CS', 'THROAT SWAB ROUTINE, CULTURE & SENSITIVITY', 40, 0, NULL, 'NA', 5, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-23', 0, 'non', 3, 0, 9, 0, 0),
(250, 'GRAM', 'Gram Staining', 0, 0, NULL, 'NA', 5, 2, 248, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 7, 0, 1, 1, 0),
(251, 'WBC. S', 'White Blood Cells', 0, 0, NULL, 'NA', 5, 2, 248, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 7, 0, 2, 0, 0),
(252, 'EPI. S', 'Epithelial Cells', 0, 0, NULL, 'NA', 5, 2, 248, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 7, 0, 3, 0, 0),
(253, 'GPB', 'Gram Positive Bacilli', 0, 0, NULL, 'NA', 5, 2, 248, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 7, 0, 5, 0, 0),
(254, 'GNB', 'Gram Negative Bacilli', 0, 0, NULL, 'NA', 5, 2, 248, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 7, 0, 6, 0, 0),
(255, 'GPC', 'Gram Positive Cocci', 0, 0, NULL, 'NA', 5, 2, 248, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 7, 0, 7, 0, 0),
(256, 'GNC', 'Gram Negative Cocci', 0, 0, NULL, 'NA', 5, 2, 248, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 7, 0, 8, 0, 0),
(257, 'CULTURE', 'Culture & Sensitivity', 0, 0, NULL, 'NA', 5, 2, 248, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-23', 0, 'non', 7, 0, 9, 0, 0),
(258, 'ORGANISM', 'Organism Isolated', 0, 0, NULL, 'NA', 5, 2, 248, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 7, 1, 10, 0, 0),
(259, 'YEAST', 'Yeast Cells', 0, 0, NULL, 'NA', 5, 2, 248, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 7, 0, 4, 0, 0),
(260, 'GRAM', 'Gram Staining', 0, 0, NULL, 'NA', 5, 2, 249, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 0, 1, 1, 0),
(261, 'WBC. T', 'White Blood Cells', 0, 0, NULL, 'NA', 5, 2, 249, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 2, 0, 0),
(262, 'EPI. T', 'Epithelial Cells', 0, 0, NULL, 'NA', 5, 2, 249, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 4, 0, 0),
(263, 'GPB', 'Gram Positive Bacilli', 0, 0, NULL, 'NA', 5, 2, 249, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 6, 0, 0),
(264, 'GNB', 'Gram Negative Bacilli', 0, 0, NULL, 'NA', 5, 2, 249, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 7, 0, 0),
(265, 'GPC', 'Gram Positive Cocci', 0, 0, NULL, 'NA', 5, 2, 249, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 8, 0, 0),
(266, 'GNC', 'Gram Negative Cocci', 0, 0, NULL, 'NA', 5, 2, 249, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 9, 0, 0),
(267, 'YEAST', 'Yeast Cells', 0, 0, NULL, 'NA', 5, 2, 249, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 3, 0, 5, 0, 0),
(269, 'CULTURE', 'CULTURE & SENSITIVITY', 0, 0, NULL, 'NA', 5, 2, 249, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 0, 10, 1, 0),
(270, 'ORGANISM', 'Organism Isolated', 0, 0, NULL, 'NA', 5, 2, 249, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 3, 1, 11, 0, 0),
(273, 'URINE PT', 'Urine Pregnancy', 10, 0, NULL, 'NA', 8, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 2, 0, 1, 0, 0),
(274, 'SERUM PT', 'Serum Pregnancy', 15, 0, NULL, 'NA', 8, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 1, 0, 2, 0, 0),
(277, 'SEMEN R/E', 'SEMEN ROUTINE ANALYSIS', 40, 0, NULL, 'NA', 7, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 6, 0, NULL, 0, 0),
(278, 'SPE. PRO', 'Specimen Production Time', 0, 0, NULL, 'NA', 7, 2, 277, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 6, 0, 1, 0, 0),
(279, 'Time. S', 'Time Received At Lab.', 0, 0, NULL, 'NA', 7, 2, 277, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 6, 0, 2, 0, 0),
(280, 'PRO. S', 'Method of Production', 0, 0, NULL, 'NA', 7, 2, 277, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 6, 0, 3, 0, 0),
(281, 'ABSTI. S', 'Duration of Abstinence', 0, 0, NULL, 'NA', 7, 2, 277, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 6, 0, 4, 0, 0),
(282, 'EJA. S.', 'Ejaculation - Analysis Interval', 0, 0, NULL, 'NA', 7, 2, 277, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 6, 0, 5, 0, 0),
(283, 'Liq. S', 'Liquefaction', 0, 0, NULL, 'NA', 7, 2, 277, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 6, 0, 6, 0, 0),
(284, 'APP. S', 'Appearance / Colour', 0, 0, NULL, 'NA', 7, 2, 277, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 6, 0, 7, 0, 0),
(285, 'Volu S.', 'Specimen Volume', 0, 0, NULL, 'NA', 7, 2, 277, 'ml(s)', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 6, 0, 8, 0, 0),
(286, 'VISCO', 'Specimen Viscosity', 0, 0, NULL, 'NA', 7, 2, 277, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 1, 'non', 6, 0, 9, 0, 0),
(287, 'pH. S', 'Specimen pH', 0, 0, NULL, 'NA', 7, 2, 277, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 6, 0, 10, 0, 0),
(288, 'WBC. S', 'Round Cells', 0, 0, NULL, 'NA', 7, 2, 277, 'per hpf', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 6, 0, 11, 0, 0),
(289, 'MOTILITY', 'Motility', 0, 0, NULL, 'NA', 7, 2, 277, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-09-02', 0, 'non', 6, 0, 12, 1, 0),
(290, 'Active S.', 'Rapid & Progressive Cells', 0, 0, NULL, 'NA', 7, 2, 277, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 6, 0, 13, 0, 0),
(291, 'Inactive', 'Slow & Non - Progressive Cells', 0, 0, NULL, 'NA', 7, 2, 277, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 6, 0, 14, 0, 0),
(292, 'Dead S.', 'Dead Cells', 0, 0, NULL, 'NA', 7, 2, 277, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 6, 0, 15, 0, 0),
(293, 'Sperm C.', 'Spermatozoal Cells Count', 0, 0, NULL, 'NA', 7, 2, 277, 'per ml', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'uni', 6, 0, 16, 0, 0),
(294, 'MORPH', 'Morphology', 0, 0, NULL, 'NA', 7, 2, 277, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-13', 0, 'non', 6, 0, 17, 0, 0),
(295, 'NOR.', 'Normal Spermatozoal Cells', 0, 0, NULL, 'NA', 7, 2, 277, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 6, 0, 18, 0, 0),
(296, 'ABNOR', 'Abnormal Spermatozoal Cells', 0, 0, NULL, 'NA', 7, 2, 277, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'non', 6, 0, 19, 0, 0),
(297, 'SEMEN RE / CS', 'SEMEN ROUTINE, CULTURE & SENSITIVITY', 80, 80, NULL, 'NA', 5, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-23', 0, 'non', 6, 0, 12, 0, 0),
(299, 'PROGES', 'Progesterone', 35, 0, NULL, 'NA', 8, 1, 0, 'ng/ml', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'uni', 1, 0, 6, 0, 0),
(300, 'PROLAC', 'Prolactin', 35, 0, NULL, 'NA', 8, 1, 0, 'ng/ml', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 0, 'uni', 1, 0, 5, 0, 0),
(301, 'FSH', 'Follicle Stimulating Hormone', 35, 0, NULL, 'NA', 8, 1, 0, 'IU/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'uni', 1, 0, 4, 0, 0),
(302, 'LS', 'Luteinizing Hormone (LH)', 35, 0, NULL, 'NA', 8, 1, 0, 'IU/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'uni', 1, 0, 3, 0, 0),
(303, 'Oestra', 'Estrogen (Estradiol)', 35, 0, NULL, 'NA', 8, 1, 0, 'pg/ml', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'uni', 1, 0, 7, 0, 0),
(304, 'Testo', 'Testosterone', 35, 0, NULL, 'NA', 8, 1, 0, 'ng/ml', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'uni', 1, 0, 8, 0, 0),
(305, 'PSA', 'PSA (Total)', 40, 0, NULL, 'NA', 9, 1, 0, 'ng/ml', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 0, 'det', 1, 0, NULL, 0, 0),
(406, 'S. Cells', 'Squamous Cells', 0, 0, NULL, 'NA', 15, 2, 352, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 3, 0, NULL, 0, 0),
(407, 'E. Cells', 'Endocervical Cells', 0, 0, NULL, 'NA', 15, 2, 352, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 3, 0, NULL, 0, 0),
(408, 'R. Cells', 'Red Blood Cells', 0, 0, NULL, 'NA', 15, 2, 352, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 3, 0, NULL, 0, 0),
(409, 'Exu', 'Exudate', 0, 0, NULL, 'NA', 15, 2, 352, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 3, 0, NULL, 0, 0),
(410, 'Dod.', 'Doderlains Bacilli', 0, 0, NULL, 'NA', 15, 2, 352, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 3, 0, NULL, 0, 0),
(411, 'G.V.', 'Gardnerella Vaginalis', 0, 0, NULL, 'NA', 15, 2, 352, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 3, 0, NULL, 0, 0),
(412, 'HPV/MPV', 'HPV / MPV ( Condyloma )', 0, 0, NULL, 'NA', 15, 2, 352, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 3, 0, NULL, 0, 0),
(429, 'BhCG', 'Serum hCG (Quantitative)', 40, 40, NULL, 'NA', 8, 1, 0, 'IU/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-13', 1, 'uni', 1, 0, NULL, 0, 0),
(414, 'BLOOD/CS', 'BLOOD CULTURE & SENSITIVITY', 60, 60, NULL, 'NA', 5, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-23', 0, 'non', 1, 0, 13, 0, 0),
(312, 'CK-MB', 'CK-MB', 30, 0, NULL, 'NA', 11, 1, 0, 'U/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'det', 1, 0, 2, 0, 0),
(313, 'CK', 'Creatine Kinase', 20, 0, NULL, 'NA', 11, 1, 0, 'U/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'det', 1, 0, 1, 0, 0),
(314, 'LDH', 'LDH (Total)', 20, 0, NULL, 'NA', 11, 1, 0, 'U/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-02-10', 0, 'det', 1, 0, 3, 0, 0),
(315, 'FBC', 'FULL BLOOD COUNT', 20, 20, NULL, 'NA', 1, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-01', 0, 'non', 1, 0, NULL, 0, 0),
(319, 'RBC', 'Red Blood Cells (RBC)', 0, 0, NULL, 'NA', 1, 2, 315, '10^6/uL', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-01', 0, 'det', 1, 0, 2, 0, 0),
(321, 'HCT', 'Haematocrit (HCT)', 0, 0, NULL, 'NA', 1, 2, 315, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-01', 0, 'det', 1, 0, 4, 0, 0),
(322, 'MCV', 'Mean Cell Volume (MCV)', 0, 0, NULL, 'NA', 1, 2, 315, 'fL', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-01', 0, 'det', 1, 0, 5, 0, 0),
(323, 'MCH', 'Mean Cell Haemoglobin (MCH)', 0, 0, NULL, 'NA', 1, 2, 315, 'pg', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-01', 0, 'det', 1, 0, 6, 0, 0),
(324, 'MCHC', 'Mean Cell Hb. Conc. (MCHC)', 0, 0, NULL, 'NA', 1, 2, 315, 'g/dL', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'det', 1, 0, 7, 0, 0),
(325, 'PLT', 'Platelets (PLT)', 0, 0, NULL, 'NA', 1, 2, 315, '10^3/uL', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-01', 0, 'det', 1, 0, 8, 0, 0),
(326, 'RDW-SD', 'Red Cells Dist. Width-SD (RDW-SD)', 0, 0, NULL, 'NA', 1, 2, 315, 'fL', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'det', 1, 0, 9, 0, 0),
(327, 'RDW-CV', 'Red Cells Dist. Width-CV (RDW-CV)', 0, 0, NULL, 'NA', 1, 2, 315, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'det', 1, 0, 10, 0, 0),
(328, 'PDW', 'Platelets Distribution Width (PDW)', 0, 0, NULL, 'NA', 1, 2, 315, 'fL', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-01', 0, 'det', 1, 0, 11, 0, 0),
(329, 'MPV', 'Mean Platelet Volume (MPV)', 0, 0, NULL, 'NA', 1, 2, 315, 'fL', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-01', 0, 'det', 1, 0, 12, 0, 0),
(330, 'P-LCR', 'Platelet-Large Cell Ratio (P-LCR)', 0, 0, NULL, 'NA', 1, 2, 315, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'det', 1, 0, 13, 0, 0),
(331, 'PCT', 'Plateletcrit (PCT)', 0, 0, NULL, 'NA', 1, 2, 315, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-01', 0, 'det', 1, 0, 14, 0, 0),
(332, 'NEUT%', 'Neutrophils % (NEUT%)', 0, 0, NULL, 'NA', 1, 2, 315, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'det', 1, 0, 15, 0, 0),
(333, 'LYMP%', 'Lymphocytes % (LYMP%)', 0, 0, NULL, 'NA', 1, 2, 315, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'det', 1, 0, 16, 0, 0),
(334, 'MONO%', 'Monocytes % (MONO%)', 0, 0, NULL, 'NA', 1, 2, 315, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'det', 1, 0, 17, 0, 0),
(335, 'EOS%', 'Eosinophils % (EOS%)', 0, 0, NULL, 'NA', 1, 2, 315, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'det', 1, 0, 18, 0, 0),
(336, 'BASO%', 'Basophils % (BASO%)', 0, 0, NULL, 'NA', 1, 2, 315, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'det', 1, 0, 19, 0, 0),
(337, 'NEUT#', 'Neutrophils Count (NEUT#)', 0, 0, NULL, 'NA', 1, 2, 315, '10^3/uL', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-01', 0, 'det', 1, 0, 20, 0, 0),
(338, 'LYMP#', 'Lymphocytes Count (LYMP#)', 0, 0, NULL, 'NA', 1, 2, 315, '10^3/uL', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-01', 0, 'det', 1, 0, 21, 0, 0),
(339, 'MONO#', 'Monocytes Count (MONO#)', 0, 0, NULL, 'NA', 1, 2, 315, '10^3/uL', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-01', 0, 'det', 1, 0, 22, 0, 0),
(340, 'EOS#', 'Eosinophils Count (EOS#)', 0, 0, NULL, 'NA', 1, 2, 315, '10^3/uL', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-01', 0, 'det', 1, 0, 23, 0, 0),
(341, 'BASO#', 'Basophils Count (BASO#)', 0, 0, NULL, 'NA', 1, 2, 315, '10^3/uL', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-01', 0, 'det', 1, 0, 24, 0, 0),
(342, 'HIV', 'HIV (1 & 2) Antibody', 15, 15, NULL, 'NA', 2, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 1, 0, 2, 0, 0),
(343, 'GONO', 'Gonorrhea Screen', 20, 20, NULL, 'NA', 2, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 1, 0, 8, 0, 0),
(344, 'Pylori', 'H. Pylori Antibody (Serum)', 20, 20, NULL, 'NA', 20, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 1, 0, NULL, 0, 0),
(345, 'Pylori Ag', 'H. Pylori Antigen (Stool)', 40, 40, NULL, 'NA', 20, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 4, 0, NULL, 0, 0),
(346, 'RF', 'Rheumatoid Factor', 20, 20, NULL, 'NA', 17, 1, 0, 'IU/ml', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-13', 1, 'uni', 1, 0, NULL, 0, 0),
(347, 'TFT', 'THYROID FUNCTION TESTS', 110, 110, NULL, 'NA', 16, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 1, 0, NULL, 0, 0),
(348, 'TSH', 'Thyroid Stimulating Hormone (TSH)', 0, 0, NULL, 'NA', 16, 2, 347, 'mIU/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-13', 0, 'det', 1, 0, NULL, 0, 0),
(349, 'FT4', 'Free Thyroxine (FT4)', 0, 0, NULL, 'NA', 16, 2, 347, 'ng/dL', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-13', 0, 'det', 1, 0, NULL, 0, 0),
(350, 'FT3', 'Free Tri-Iodothyronine (FT3)', 0, 0, NULL, 'NA', 16, 2, 347, 'pg/ml', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-13', 0, 'det', 1, 0, NULL, 0, 0),
(351, 'TSH', 'Thyroid Stimulating Hormone (TSH)', 40, 40, NULL, 'NA', 16, 1, 0, 'mIU/L', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-03', 0, 'det', 1, 0, NULL, 0, 0),
(352, 'PAP', 'PAP SMEAR', 100, 100, NULL, 'NA', 15, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 0, 'non', 3, 0, NULL, 0, 0),
(353, 'URINE RE', 'URINE ROUTINE EXAMINATION', 15, 15, NULL, 'NA', 21, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-26', 0, 'non', 2, 0, NULL, 0, 0),
(354, 'MACRO', 'Macroscopic Examination', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-13', 0, 'non', 2, 0, NULL, 1, 0),
(355, 'APP', 'Appearance', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(356, 'COLOUR', 'Colour', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(357, 'BIO', 'Biochemical Activities', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 2, 0, NULL, 1, 0),
(358, 'PH', 'pH', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(359, 'SG', 'Specific Gravity', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(360, 'GLUC', 'Glucose', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(361, 'LEUC', 'Leucocytes', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(362, 'BLOOD', 'Blood', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(363, 'KET', 'Ketones', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(364, 'PRO', 'Protein', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(365, 'NIT', 'Nitrite', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(366, 'BIL', 'Bilirubin', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(367, 'URO', 'Urobilinogen', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(368, 'MICRO', 'Microscopic Examination', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-13', 0, 'non', 2, 0, NULL, 1, 0),
(369, 'WBC', 'White Blood Cells', 0, 0, NULL, 'NA', 21, 2, 353, 'per hpf', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 2, 0, NULL, 0, 0),
(370, 'RBC', 'Red Blood Cells', 0, 0, NULL, 'NA', 21, 2, 353, 'per hpf', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 2, 0, NULL, 0, 0),
(371, 'EPI', 'Epithelial Cells', 0, 0, NULL, 'NA', 21, 2, 353, 'per hpf', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(372, 'S. HAEM', 'S. haematobium ova', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(373, 'YEAST', 'Yeast Cells', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(374, 'TRI', 'Trichomonas vaginalis', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(375, 'BACT', 'Bacterial Cells', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(376, 'CASTS', 'Casts', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(377, 'CRYSTALS', 'Crystals', 0, 0, NULL, 'NA', 21, 2, 353, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 2, 0, NULL, 0, 0),
(378, 'STOOL', 'STOOL ROUTINE EXAMINATION', 15, 15, NULL, 'NA', 21, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 4, 0, NULL, 0, 0),
(379, 'MACRO', 'Macroscopic Examination', 0, 0, NULL, 'NA', 21, 2, 378, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-13', 0, 'non', 4, 0, NULL, 1, 0),
(380, 'APP', 'Appearance / Consistency', 0, 0, NULL, 'NA', 21, 2, 378, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 4, 0, NULL, 0, 0),
(381, 'MICRO', 'Microscopic Examination', 0, 0, NULL, 'NA', 21, 2, 378, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-13', 0, 'non', 4, 0, NULL, 1, 0),
(382, 'WBC', 'White Blood Cells', 0, 0, NULL, 'NA', 21, 2, 378, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-26', 1, 'non', 4, 0, NULL, 0, 0),
(383, 'RBC', 'Red Blood Cells', 0, 0, NULL, 'NA', 21, 2, 378, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-26', 1, 'non', 4, 0, NULL, 0, 0),
(384, 'PARA', 'Parasites', 0, 0, NULL, 'NA', 21, 2, 378, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 1, 'non', 4, 0, NULL, 0, 0),
(385, 'SPT', 'Specimen Production Time', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 6, 0, 2, 0, 0),
(386, 'TRL', 'Time Received At Lab.', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 6, 0, 3, 0, 0),
(387, 'METH', 'Method of Production', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 6, 0, 4, 0, 0),
(388, 'DUR', 'Duration of Abstinence', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 6, 0, 5, 0, 0),
(389, 'EJAC', 'Ejaculation - Analysis Interval', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 6, 0, 6, 0, 0),
(390, 'LIQUE', 'Liquefaction', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 6, 0, 7, 0, 0);
INSERT INTO `investigation` (`detailed_inv_id`, `code`, `name`, `rate`, `nhis_rate`, `low_bound`, `high_bound`, `lab_type_id`, `type_of_test_id`, `grouped_under_id`, `units`, `interpretation`, `default_value`, `range_from`, `range_up_to`, `comments`, `report_coll_days`, `report_coll_time`, `result_options`, `ref_range_type`, `specimen_id`, `antibiotic`, `order_num`, `is_subheading`, `active`) VALUES
(391, 'APP', 'Appearance / Colour', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 6, 0, 8, 0, 0),
(392, 'VOL', 'Specimen Volume', 0, 0, NULL, 'NA', 5, 2, 297, 'ml(s)', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 6, 0, 9, 0, 0),
(393, 'VISC', 'Specimen Viscosity', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 6, 0, 10, 0, 0),
(394, 'PH', 'Specimen pH', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 6, 0, 11, 0, 0),
(395, 'ROUND', 'Round Cells', 0, 0, NULL, 'NA', 5, 2, 297, 'per hpf', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 6, 0, 12, 0, 0),
(396, 'MOT', 'Motility', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 0, 'non', 6, 0, 13, 1, 0),
(397, 'RAP', 'Rapid & Progressive Cells', 0, 0, NULL, 'NA', 5, 2, 297, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 6, 0, 14, 0, 0),
(398, 'SLOW', 'Slow & Non - Progressive Cells', 0, 0, NULL, 'NA', 5, 2, 297, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 6, 0, 15, 0, 0),
(399, 'DEAD', 'Dead Cells', 0, 0, NULL, 'NA', 5, 2, 297, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 6, 0, 16, 0, 0),
(400, 'COUNT', 'Spermatozoal Cells Count', 0, 0, NULL, 'NA', 5, 2, 297, 'per ml', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'uni', 6, 0, 17, 0, 0),
(401, 'MORPH', 'Morphology', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 0, 'non', 6, 0, 18, 0, 0),
(402, 'NORM', 'Normal Spermatozoal Cells', 0, 0, NULL, 'NA', 5, 2, 297, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 6, 0, 19, 0, 0),
(403, 'ABNOR', 'Abnormal Spermatozoal Cells', 0, 0, NULL, 'NA', 5, 2, 297, '%', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 6, 0, 20, 0, 0),
(404, 'ORG', 'Organism Isolated', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-02', 0, 'non', 6, 1, 29, 0, 0),
(405, 'HBcAb', 'Hepatitis B Core Antibody', 0, 0, NULL, 'NA', 2, 2, 28, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-03', 1, 'non', 1, 0, NULL, 0, 0),
(415, 'Tri', 'Trichomonas Vaginalis', 0, 0, NULL, 'NA', 5, 2, 176, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 3, 0, 6, 0, 0),
(416, 'SUB 1', '1st Sub Culture At Day 2', 0, 0, NULL, 'NA', 5, 2, 414, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 0, 'non', 1, 0, NULL, 1, 0),
(417, 'ORG', 'Organism Isolated', 0, 0, NULL, 'NA', 5, 2, 414, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 0, 'non', 1, 1, NULL, 0, 0),
(418, 'SUB 2', '2nd Sub Culture At Day 7', 0, 0, NULL, 'NA', 5, 2, 414, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 0, 'non', 1, 0, NULL, 1, 0),
(419, 'ORG', 'Organism Isolated', 0, 0, NULL, 'NA', 5, 2, 414, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 0, 'non', 1, 1, NULL, 0, 0),
(420, 'Gram', 'GRAM STAINING', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 0, 'non', 6, 0, 21, 1, 0),
(421, 'WBC.', 'White Blood Cells', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 6, 0, 22, 0, 0),
(422, 'EPI. ', 'Epithelial Cells', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 6, 0, 23, 0, 0),
(423, 'GPB.', 'Gram Positive Bacilli', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 6, 0, 26, 0, 0),
(424, 'GPC.', 'Gram Positive Cocci', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 6, 0, 24, 0, 0),
(425, 'GNB.', 'Gram Negative Bacilli', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 6, 0, 27, 0, 0),
(426, 'GNC.', 'Gram Negative Cocci', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 1, 'non', 6, 0, 25, 0, 0),
(427, 'CS.', 'CULTURE & SENSITIVITY', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 0, 'non', 6, 0, 28, 1, 0),
(428, 'RE.', 'ROUTINE ANALYSIS', 0, 0, NULL, 'NA', 5, 2, 297, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-08', 0, 'non', 6, 0, 1, 1, 0),
(430, 'SPUTUM', 'Sputum AFB Microscopy', 15, 15, NULL, 'NA', 22, 1, 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-20', 0, 'non', 7, 0, NULL, 0, 0),
(431, 'MACRO', 'Macroscopic Appearance', 0, 0, NULL, 'NA', 22, 2, 430, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-20', 1, 'non', 7, 0, NULL, 0, 0),
(432, 'ZN', 'Z-N Staining', 0, 0, NULL, 'NA', 22, 2, 430, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', '2013-08-20', 1, 'non', 7, 0, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `investigation_antibiotic`
--

CREATE TABLE IF NOT EXISTS `investigation_antibiotic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inv_id` int(11) NOT NULL,
  `antibiotic_id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `investigation_antibiotic`
--


-- --------------------------------------------------------

--
-- Table structure for table `investigation_resistant_susc`
--

CREATE TABLE IF NOT EXISTS `investigation_resistant_susc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ptreatment_id` int(11) NOT NULL,
  `susceptible_to` int(11) NOT NULL,
  `resistant_to` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=91 ;

--
-- Dumping data for table `investigation_resistant_susc`
--

INSERT INTO `investigation_resistant_susc` (`id`, `ptreatment_id`, `susceptible_to`, `resistant_to`) VALUES
(1, 28, 0, 16),
(2, 28, 0, 17),
(3, 28, 0, 18),
(4, 235, 0, 15),
(5, 235, 0, 16),
(6, 235, 0, 17),
(7, 235, 0, 18),
(8, 235, 0, 19),
(9, 235, 0, 20),
(10, 263, 1, 0),
(11, 263, 2, 0),
(12, 263, 3, 0),
(13, 263, 4, 0),
(14, 263, 5, 0),
(15, 293, 0, 18),
(16, 293, 0, 20),
(17, 293, 17, 0),
(18, 293, 19, 0),
(19, 323, 0, 14),
(20, 323, 0, 16),
(21, 323, 19, 0),
(22, 323, 20, 0),
(23, 346, 0, 17),
(24, 346, 0, 18),
(25, 346, 16, 0),
(26, 389, 0, 8),
(27, 389, 0, 13),
(28, 389, 11, 0),
(29, 510, 4, 0),
(30, 510, 9, 0),
(31, 510, 0, 1),
(32, 510, 0, 5),
(33, 510, 0, 8),
(34, 510, 0, 16),
(35, 510, 0, 18),
(59, 1315, 0, 10),
(60, 1315, 0, 12),
(61, 1315, 3, 0),
(62, 1315, 5, 0),
(63, 1315, 7, 0),
(64, 1315, 8, 0),
(65, 1315, 9, 0),
(66, 5941, 0, 1),
(67, 5941, 0, 7),
(73, 5941, 9, 0),
(72, 5941, 8, 0),
(71, 5941, 5, 0),
(70, 5941, 0, 18),
(69, 5941, 0, 12),
(68, 5941, 0, 10),
(58, 1315, 0, 1),
(74, 5941, 20, 0),
(75, 4203, 5, 0),
(76, 4203, 16, 0),
(77, 4203, 0, 7),
(78, 4203, 0, 8),
(79, 4203, 0, 9),
(80, 4203, 0, 17),
(81, 4203, 0, 18),
(82, 4203, 0, 21);

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE IF NOT EXISTS `invoice` (
  `invoice_id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_invoice` varchar(255) NOT NULL,
  `orderid` int(11) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `vat_value` double DEFAULT NULL,
  `percentage_discount` double NOT NULL,
  `price_discount` double NOT NULL,
  `comment` text,
  `received_by` varchar(255) NOT NULL,
  `invoice_date` date NOT NULL,
  `date_received` date NOT NULL,
  `invoice_amount` double NOT NULL,
  `net_total` double NOT NULL,
  `tax_amount` double NOT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `orderid` (`orderid`),
  KEY `supplier_id` (`supplier_id`),
  KEY `received_by` (`received_by`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`invoice_id`, `supplier_invoice`, `orderid`, `supplier_id`, `vat_value`, `percentage_discount`, `price_discount`, `comment`, `received_by`, `invoice_date`, `date_received`, `invoice_amount`, `net_total`, `tax_amount`) VALUES
(1, 'INV0001', 1, 1, 17.5, 12, 916.8, 'No additional information', 'ClaimSync0009', '2013-11-26', '2013-11-26', 7640, 6799.6, 7716.4);

-- --------------------------------------------------------

--
-- Table structure for table `in_patient_bills`
--

CREATE TABLE IF NOT EXISTS `in_patient_bills` (
  `visitid` int(11) NOT NULL,
  `patientid` text NOT NULL,
  `total_bill` double NOT NULL,
  `amount_paid` double NOT NULL,
  `status` text NOT NULL,
  PRIMARY KEY (`visitid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `in_patient_bills`
--


-- --------------------------------------------------------

--
-- Table structure for table `itemtype`
--

CREATE TABLE IF NOT EXISTS `itemtype` (
  `itemType` varchar(100) DEFAULT NULL,
  `id` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `itemtype`
--


-- --------------------------------------------------------

--
-- Table structure for table `item_batch`
--

CREATE TABLE IF NOT EXISTS `item_batch` (
  `item_batch` varchar(100) NOT NULL,
  `item_code` varchar(255) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `quantity_received` int(11) NOT NULL,
  `quantity_on_hand` int(11) NOT NULL,
  `date_received` date NOT NULL,
  `expiry_date` date NOT NULL,
  `purchase_price` double NOT NULL,
  `selling_price` double NOT NULL,
  `received_value` double NOT NULL,
  `value_on_hand` double NOT NULL,
  PRIMARY KEY (`item_batch`),
  KEY `invoice_id` (`invoice_id`),
  KEY `item_code` (`item_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `item_batch`
--

INSERT INTO `item_batch` (`item_batch`, `item_code`, `invoice_id`, `quantity_received`, `quantity_on_hand`, `date_received`, `expiry_date`, `purchase_price`, `selling_price`, `received_value`, `value_on_hand`) VALUES
('CO0000001', 'COARTE', 1, 500, 500, '2013-11-26', '2016-11-26', 15, 16.4, 0, 0),
('PA0000001', 'PARAINJE', 1, 700, 700, '2013-11-26', '2016-11-26', 0.2, 1.6, 800, 800);

-- --------------------------------------------------------

--
-- Table structure for table `item_form`
--

CREATE TABLE IF NOT EXISTS `item_form` (
  `form_id` int(11) NOT NULL AUTO_INCREMENT,
  `form_description` varchar(255) NOT NULL,
  PRIMARY KEY (`form_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `item_form`
--

INSERT INTO `item_form` (`form_id`, `form_description`) VALUES
(1, 'Suspension'),
(2, 'Capsule'),
(3, 'Tablet'),
(4, 'Syrup');

-- --------------------------------------------------------

--
-- Table structure for table `laboratory_batch`
--

CREATE TABLE IF NOT EXISTS `laboratory_batch` (
  `item_batch` varchar(100) NOT NULL,
  `item_code` varchar(255) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `quantity_received` int(11) NOT NULL,
  `quantity_on_hand` int(11) NOT NULL,
  `date_received` date NOT NULL,
  `expiry_date` date NOT NULL,
  `purchase_price` double NOT NULL,
  `selling_price` double NOT NULL,
  `received_value` double NOT NULL,
  `value_on_hand` double NOT NULL,
  PRIMARY KEY (`item_batch`),
  KEY `item_code` (`item_code`),
  KEY `invoice_id` (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `laboratory_batch`
--


-- --------------------------------------------------------

--
-- Table structure for table `laboratory_item`
--

CREATE TABLE IF NOT EXISTS `laboratory_item` (
  `item_description` varchar(255) NOT NULL,
  `item_code` varchar(100) NOT NULL,
  `quantity_on_hand` int(11) NOT NULL,
  `manufacturer` varchar(500) NOT NULL,
  `price_markup` double NOT NULL,
  `percentage_markup` double NOT NULL,
  `form_id` int(11) NOT NULL,
  `unit_of_issue` int(11) NOT NULL,
  `reorder_level` int(11) NOT NULL,
  `minimum_stock_level` int(11) NOT NULL,
  `strength` varchar(255) NOT NULL,
  `active_ingredients` varchar(1000) NOT NULL,
  `reorder_qty` int(11) NOT NULL,
  `maximum_stock_level` int(11) DEFAULT NULL,
  `therapeutic_group` int(11) NOT NULL,
  `vatable` tinyint(1) NOT NULL,
  PRIMARY KEY (`item_code`),
  KEY `form_id` (`form_id`),
  KEY `unit_of_issue` (`unit_of_issue`),
  KEY `therapeutic_group` (`therapeutic_group`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `laboratory_item`
--


-- --------------------------------------------------------

--
-- Table structure for table `laborders`
--

CREATE TABLE IF NOT EXISTS `laborders` (
  `orderid` varchar(100) NOT NULL,
  `patientid` varchar(50) NOT NULL,
  `facility` text NOT NULL,
  `fromdoc` varchar(255) NOT NULL,
  `todoc` varchar(255) DEFAULT NULL,
  `physician` text NOT NULL,
  `total_amount` double NOT NULL,
  `orderdate` datetime NOT NULL,
  `donedate` datetime DEFAULT NULL,
  `viewed` tinyint(1) DEFAULT NULL,
  `visitid` int(11) NOT NULL,
  `done` varchar(20) NOT NULL,
  `amountpaid` double DEFAULT NULL,
  `outstanding` double DEFAULT NULL,
  `scrutinized` text NOT NULL,
  `date` date NOT NULL,
  `received_by` varchar(255) NOT NULL,
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `laborders`
--


-- --------------------------------------------------------

--
-- Table structure for table `labtypes`
--

CREATE TABLE IF NOT EXISTS `labtypes` (
  `lab_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `lab_code` varchar(10) NOT NULL,
  `lab_type` varchar(225) NOT NULL,
  `order_num` int(11) DEFAULT NULL,
  `active` int(11) NOT NULL,
  PRIMARY KEY (`lab_type_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `labtypes`
--

INSERT INTO `labtypes` (`lab_type_id`, `lab_code`, `lab_type`, `order_num`, `active`) VALUES
(1, 'HAEM', 'HAEMATOLOGY', 1, 1),
(2, 'INFECTIOUS', 'INFECTIOUS DISEASES', 6, 1),
(5, 'MICRO', 'MICROBIOLOGY', 15, 1),
(7, 'ANDRO', 'ANDROLOGY', 13, 1),
(8, 'FERTILITY', 'FERTILITY MARKERS', 10, 1),
(9, 'TUMOUR M.', 'TUMOUR MARKERS', 11, 1),
(3, 'BIOCHEM', 'BIOCHEMISTRY', 3, 1),
(11, 'MYO', 'MYOCARDIAL', 4, 1),
(15, 'CYTO', 'CYTOLOGY', 12, 1),
(16, 'ENDO/IMMU', 'ENDOCRINOLOGY / IMMUNOLOGY', 9, 1),
(17, 'AUTO', 'AUTOIMMUNE DISEASES', 8, 1),
(18, 'DIABETES', 'DIABETES SCREENING', 2, 1),
(19, 'PANCREATIC', 'PANCREATIC SCREENING', 5, 1),
(20, 'PEPTIC', 'PEPTIC ULCER SCREENING', 7, 1),
(21, 'PARA', 'PARASITOLOGY', 14, 1),
(22, 'BACT', 'BACTERIOLOGY', 16, 1);

-- --------------------------------------------------------

--
-- Table structure for table `labtype_detailedinv`
--

CREATE TABLE IF NOT EXISTS `labtype_detailedinv` (
  `labtype_maintest_id` int(11) NOT NULL AUTO_INCREMENT,
  `labtype_id` int(11) NOT NULL,
  `detailed_inv_id` int(11) NOT NULL,
  PRIMARY KEY (`labtype_maintest_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=119 ;

--
-- Dumping data for table `labtype_detailedinv`
--

INSERT INTO `labtype_detailedinv` (`labtype_maintest_id`, `labtype_id`, `detailed_inv_id`) VALUES
(99, 1, 1),
(100, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 8),
(7, 1, 9),
(107, 20, 345),
(12, 2, 19),
(13, 2, 28),
(14, 2, 34),
(15, 2, 35),
(16, 2, 36),
(17, 2, 37),
(23, 18, 43),
(24, 18, 44),
(25, 18, 47),
(28, 3, 55),
(29, 19, 56),
(31, 3, 58),
(32, 3, 59),
(34, 3, 61),
(38, 3, 78),
(37, 3, 71),
(41, 5, 120),
(81, 18, 42),
(43, 5, 158),
(82, 18, 44),
(45, 5, 193),
(46, 5, 205),
(48, 5, 228),
(49, 5, 238),
(84, 18, 50),
(51, 5, 249),
(85, 18, 54),
(58, 7, 277),
(59, 5, 297),
(61, 8, 299),
(62, 8, 300),
(63, 8, 301),
(64, 8, 302),
(65, 8, 303),
(66, 8, 304),
(67, 9, 305),
(72, 11, 312),
(73, 11, 313),
(74, 11, 314),
(106, 20, 344),
(105, 2, 343),
(90, 2, 39),
(91, 3, 60),
(104, 2, 342),
(93, 5, 248),
(94, 5, 148),
(95, 5, 176),
(96, 5, 218),
(102, 13, 316),
(103, 1, 315),
(108, 17, 346),
(109, 16, 347),
(110, 16, 351),
(111, 15, 352),
(112, 21, 353),
(113, 21, 378),
(114, 5, 414),
(115, 8, 273),
(116, 8, 274),
(117, 8, 429),
(118, 22, 430);

-- --------------------------------------------------------

--
-- Table structure for table `lab_antibiotic`
--

CREATE TABLE IF NOT EXISTS `lab_antibiotic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `order_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Dumping data for table `lab_antibiotic`
--

INSERT INTO `lab_antibiotic` (`id`, `name`, `order_num`) VALUES
(1, 'Augmentin', 1),
(2, 'Neomycin', 2),
(3, 'Cefuroxime', 3),
(4, 'Ceftriaxone', 4),
(5, 'Gentamicin', 5),
(6, 'Ceftazidime', 6),
(7, 'Norfloxacin', 7),
(8, 'Tobramycin', 8),
(9, 'Ciprofloxacin', 9),
(10, 'Nalidixic Acid', 10),
(11, 'Doxycycline', 11),
(12, 'Sulphamethoxazole /Trimethoprim', 12),
(13, 'Erythromycin', 13),
(14, 'Metronidazole', 14),
(15, 'Vancomycin', 15),
(16, 'Cephalexin', 16),
(17, 'Amoxycillin', 17),
(18, 'Azithromycin', 18),
(19, 'Oxacillin', 19),
(20, 'Nitrofurantoin', 20),
(21, 'Cefotaxime', 21);

-- --------------------------------------------------------

--
-- Table structure for table `lab_discount`
--

CREATE TABLE IF NOT EXISTS `lab_discount` (
  `discount_id` int(11) NOT NULL AUTO_INCREMENT,
  `lab_id` text NOT NULL,
  `patient_id` text NOT NULL,
  `percentage_discount` double NOT NULL,
  `discounted` double NOT NULL,
  `new_amount` double NOT NULL,
  `staff_id` text NOT NULL,
  `status` text NOT NULL,
  `reason` text NOT NULL,
  PRIMARY KEY (`discount_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `lab_discount`
--


-- --------------------------------------------------------

--
-- Table structure for table `lab_patient`
--

CREATE TABLE IF NOT EXISTS `lab_patient` (
  `patientid` varchar(50) NOT NULL,
  `fname` varchar(100) DEFAULT NULL,
  `lname` varchar(100) DEFAULT NULL,
  `midname` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `employer` varchar(100) DEFAULT NULL,
  `dateofbirth` date DEFAULT NULL,
  `contact` varchar(100) DEFAULT NULL,
  `emergencyperson` varchar(100) DEFAULT NULL,
  `emergencycontact` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `dateofregistration` datetime DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `maritalstatus` varchar(255) DEFAULT NULL,
  `imglocation` varchar(255) DEFAULT NULL,
  `last_visit_id` int(11) NOT NULL,
  `last_claim_id` int(11) DEFAULT NULL,
  `folder_number` varchar(50) NOT NULL,
  PRIMARY KEY (`patientid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lab_patient`
--


-- --------------------------------------------------------

--
-- Table structure for table `loggingtable`
--

CREATE TABLE IF NOT EXISTS `loggingtable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(200) NOT NULL,
  `logintime` time DEFAULT NULL,
  `logoutitme` time DEFAULT NULL,
  `action` text NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `loggingtable`
--


-- --------------------------------------------------------

--
-- Table structure for table `maininv_subinv`
--

CREATE TABLE IF NOT EXISTS `maininv_subinv` (
  `maininv_subinv_id` int(11) NOT NULL AUTO_INCREMENT,
  `maininv_id` int(11) NOT NULL,
  `subinv_id` int(11) NOT NULL,
  PRIMARY KEY (`maininv_subinv_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=346 ;

--
-- Dumping data for table `maininv_subinv`
--

INSERT INTO `maininv_subinv` (`maininv_subinv_id`, `maininv_id`, `subinv_id`) VALUES
(1, 5, 6),
(2, 5, 7),
(3, 9, 10),
(4, 9, 11),
(5, 12, 13),
(6, 12, 14),
(7, 12, 15),
(8, 19, 20),
(9, 19, 21),
(10, 19, 22),
(11, 19, 23),
(12, 19, 24),
(13, 19, 25),
(14, 19, 26),
(15, 19, 27),
(16, 28, 29),
(17, 28, 30),
(18, 28, 31),
(19, 28, 32),
(20, 28, 33),
(21, 44, 45),
(22, 44, 46),
(23, 47, 48),
(24, 47, 49),
(25, 50, 51),
(26, 50, 52),
(27, 50, 53),
(28, 61, 62),
(29, 61, 63),
(30, 61, 64),
(31, 61, 65),
(32, 61, 66),
(35, 71, 72),
(36, 71, 73),
(38, 71, 75),
(39, 71, 76),
(40, 71, 77),
(41, 78, 79),
(42, 78, 80),
(43, 78, 81),
(44, 78, 82),
(45, 78, 83),
(46, 78, 84),
(47, 78, 85),
(48, 78, 86),
(49, 78, 87),
(50, 88, 89),
(51, 88, 90),
(52, 88, 91),
(53, 88, 92),
(54, 88, 93),
(55, 88, 94),
(56, 88, 95),
(57, 88, 96),
(58, 88, 97),
(59, 88, 98),
(60, 88, 99),
(61, 88, 100),
(62, 88, 101),
(63, 88, 102),
(64, 88, 103),
(65, 88, 104),
(66, 88, 105),
(67, 88, 106),
(68, 88, 107),
(69, 88, 108),
(70, 88, 109),
(71, 88, 110),
(72, 88, 111),
(73, 88, 112),
(74, 113, 114),
(75, 113, 115),
(76, 113, 116),
(77, 113, 117),
(78, 113, 118),
(79, 113, 119),
(80, 120, 121),
(81, 120, 122),
(82, 120, 123),
(83, 120, 124),
(84, 120, 125),
(85, 120, 126),
(86, 120, 127),
(87, 120, 128),
(88, 120, 129),
(89, 120, 130),
(90, 120, 131),
(91, 120, 132),
(92, 120, 133),
(93, 120, 134),
(94, 120, 135),
(95, 120, 136),
(96, 120, 137),
(97, 120, 138),
(98, 120, 139),
(99, 120, 140),
(100, 120, 141),
(101, 120, 142),
(102, 120, 143),
(103, 120, 144),
(104, 120, 145),
(105, 120, 146),
(106, 120, 147),
(107, 148, 149),
(108, 148, 150),
(109, 148, 151),
(110, 148, 152),
(111, 148, 153),
(112, 148, 154),
(113, 148, 155),
(114, 148, 156),
(115, 148, 157),
(116, 158, 159),
(117, 158, 160),
(118, 158, 161),
(119, 158, 162),
(120, 158, 163),
(121, 158, 164),
(122, 158, 165),
(123, 158, 166),
(124, 158, 167),
(125, 158, 168),
(126, 158, 169),
(127, 158, 170),
(128, 158, 171),
(129, 158, 172),
(130, 158, 173),
(131, 158, 174),
(132, 158, 175),
(133, 176, 177),
(134, 176, 178),
(135, 176, 179),
(136, 176, 180),
(137, 176, 181),
(138, 176, 182),
(139, 176, 183),
(140, 176, 184),
(141, 176, 185),
(142, 176, 186),
(143, 176, 187),
(144, 176, 188),
(145, 176, 189),
(146, 176, 190),
(147, 176, 191),
(148, 176, 192),
(149, 193, 194),
(150, 193, 195),
(151, 193, 196),
(152, 193, 197),
(153, 193, 198),
(154, 193, 199),
(156, 193, 201),
(157, 193, 202),
(158, 193, 203),
(159, 193, 204),
(160, 205, 206),
(161, 205, 207),
(162, 205, 208),
(163, 205, 209),
(164, 193, 210),
(165, 205, 211),
(166, 205, 212),
(167, 205, 213),
(168, 205, 214),
(169, 205, 215),
(170, 205, 216),
(171, 205, 217),
(172, 218, 219),
(173, 218, 220),
(174, 218, 221),
(175, 218, 222),
(176, 218, 223),
(177, 218, 224),
(178, 218, 225),
(179, 218, 226),
(180, 218, 227),
(181, 228, 229),
(182, 228, 230),
(183, 228, 231),
(184, 228, 232),
(185, 228, 233),
(186, 228, 234),
(187, 228, 235),
(188, 228, 236),
(189, 228, 237),
(190, 238, 239),
(191, 238, 240),
(192, 238, 241),
(193, 238, 242),
(194, 238, 243),
(195, 238, 244),
(196, 238, 245),
(197, 238, 246),
(198, 238, 247),
(199, 248, 250),
(200, 248, 251),
(201, 248, 252),
(202, 248, 253),
(203, 248, 254),
(204, 248, 255),
(205, 248, 256),
(206, 248, 257),
(207, 248, 258),
(208, 248, 259),
(209, 249, 260),
(210, 249, 261),
(211, 249, 262),
(212, 249, 263),
(213, 249, 264),
(214, 249, 265),
(215, 249, 266),
(216, 249, 267),
(217, 249, 268),
(218, 249, 269),
(219, 249, 270),
(220, 277, 278),
(221, 277, 279),
(222, 277, 280),
(223, 277, 281),
(224, 277, 282),
(225, 277, 283),
(226, 277, 284),
(227, 277, 285),
(228, 277, 286),
(229, 277, 287),
(230, 277, 288),
(231, 277, 289),
(232, 277, 290),
(233, 277, 291),
(234, 277, 292),
(235, 277, 293),
(236, 277, 294),
(237, 277, 295),
(238, 277, 296),
(239, 309, 310),
(240, 309, 311),
(241, 316, 317),
(242, 315, 316),
(243, 315, 317),
(244, 315, 318),
(245, 315, 319),
(246, 315, 320),
(247, 315, 321),
(248, 315, 322),
(249, 315, 323),
(250, 315, 324),
(251, 315, 325),
(252, 315, 326),
(253, 315, 327),
(254, 1, 328),
(255, 315, 329),
(256, 315, 330),
(257, 315, 331),
(258, 315, 332),
(259, 315, 333),
(260, 315, 334),
(261, 315, 335),
(262, 315, 336),
(263, 315, 337),
(264, 315, 338),
(265, 315, 339),
(266, 315, 340),
(267, 315, 341),
(268, 347, 348),
(269, 347, 349),
(270, 347, 350),
(271, 353, 354),
(272, 353, 355),
(273, 353, 356),
(274, 353, 357),
(275, 353, 358),
(276, 353, 359),
(277, 353, 360),
(278, 353, 361),
(279, 353, 362),
(280, 353, 363),
(281, 353, 364),
(282, 353, 365),
(283, 353, 366),
(284, 353, 367),
(285, 353, 368),
(286, 353, 369),
(287, 353, 370),
(288, 353, 371),
(289, 353, 372),
(290, 353, 373),
(291, 353, 374),
(292, 353, 375),
(293, 353, 376),
(294, 353, 377),
(295, 378, 379),
(296, 378, 380),
(297, 378, 381),
(298, 378, 382),
(299, 378, 383),
(300, 378, 384),
(301, 297, 385),
(302, 297, 386),
(303, 297, 387),
(304, 297, 388),
(305, 297, 389),
(306, 297, 390),
(307, 297, 391),
(308, 297, 392),
(309, 297, 393),
(310, 297, 394),
(311, 297, 395),
(312, 297, 396),
(313, 297, 397),
(314, 297, 398),
(315, 297, 399),
(316, 297, 400),
(317, 297, 401),
(318, 297, 402),
(319, 297, 403),
(320, 297, 404),
(321, 28, 405),
(322, 352, 406),
(323, 352, 407),
(324, 352, 408),
(325, 352, 409),
(326, 352, 410),
(327, 352, 411),
(328, 352, 412),
(329, 352, 413),
(330, 176, 415),
(331, 414, 416),
(332, 414, 417),
(333, 414, 418),
(334, 414, 419),
(335, 297, 420),
(336, 297, 421),
(337, 297, 422),
(338, 297, 423),
(339, 297, 424),
(340, 297, 425),
(341, 297, 426),
(342, 297, 427),
(343, 297, 428),
(344, 430, 431),
(345, 430, 432);

-- --------------------------------------------------------

--
-- Table structure for table `manufacturer`
--

CREATE TABLE IF NOT EXISTS `manufacturer` (
  `manufacturerid` int(11) NOT NULL AUTO_INCREMENT,
  `manufaturer` text NOT NULL,
  `telephone` text,
  `address` text,
  `email` text,
  PRIMARY KEY (`manufacturerid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `manufacturer`
--

INSERT INTO `manufacturer` (`manufacturerid`, `manufaturer`, `telephone`, `address`, `email`) VALUES
(3, 'Amponsah-Effah', '0546002991', 'No. 78 Kwame Nkurmah Av.', ''),
(4, 'Glaxo Smith-Kline', '0546002991', 'No. 5 East London', '');

-- --------------------------------------------------------

--
-- Table structure for table `medical_histories`
--

CREATE TABLE IF NOT EXISTS `medical_histories` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history` varchar(255) NOT NULL,
  PRIMARY KEY (`history_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `medical_histories`
--

INSERT INTO `medical_histories` (`history_id`, `history`) VALUES
(6, 'Anemia'),
(7, 'Heart Disease'),
(11, 'Macroscopic Examinations');

-- --------------------------------------------------------

--
-- Table structure for table `newborn`
--

CREATE TABLE IF NOT EXISTS `newborn` (
  `newbordid` int(11) NOT NULL AUTO_INCREMENT,
  `year` year(4) NOT NULL,
  `month` varchar(3) NOT NULL,
  `day` varchar(3) NOT NULL,
  `time` time NOT NULL,
  `momsid` varchar(255) NOT NULL,
  `supervisingmidwife` varchar(255) DEFAULT NULL,
  `complications` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`newbordid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `newborn`
--


-- --------------------------------------------------------

--
-- Table structure for table `nhisinvestigation`
--

CREATE TABLE IF NOT EXISTS `nhisinvestigation` (
  `detailed_inv_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(25) NOT NULL,
  `name` varchar(225) NOT NULL,
  `rate` double DEFAULT NULL,
  `low_bound` varchar(50) DEFAULT NULL,
  `high_bound` varchar(50) DEFAULT NULL,
  `lab_type_id` int(11) NOT NULL,
  `type_of_test_id` int(11) NOT NULL,
  `grouped_under_id` int(11) DEFAULT '0',
  `units` varchar(50) DEFAULT NULL,
  `interpretation` text,
  `default_value` varchar(50) DEFAULT NULL,
  `range_from` varchar(50) DEFAULT NULL,
  `range_up_to` varchar(50) DEFAULT NULL,
  `comments` text,
  `report_coll_days` varchar(225) DEFAULT NULL,
  `report_coll_time` date DEFAULT NULL,
  `result_options` tinyint(1) NOT NULL,
  `ref_range_type` varchar(11) NOT NULL,
  PRIMARY KEY (`detailed_inv_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `nhisinvestigation`
--


-- --------------------------------------------------------

--
-- Table structure for table `nhistreatment`
--

CREATE TABLE IF NOT EXISTS `nhistreatment` (
  `treatmentid` int(11) NOT NULL AUTO_INCREMENT,
  `medicine` varchar(1000) NOT NULL,
  `unit_price` varchar(20) NOT NULL,
  `price` double NOT NULL,
  `gdrg` varchar(25) NOT NULL,
  `therapeutic_group` int(11) NOT NULL,
  `diagnosticgroup` varchar(10) NOT NULL,
  PRIMARY KEY (`treatmentid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `nhistreatment`
--


-- --------------------------------------------------------

--
-- Table structure for table `nurses_patient_conditions`
--

CREATE TABLE IF NOT EXISTS `nurses_patient_conditions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `condition_id` int(11) NOT NULL,
  `visitid` int(11) NOT NULL,
  `patientid` varchar(11) NOT NULL,
  `seenby` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `nurses_patient_conditions`
--

INSERT INTO `nurses_patient_conditions` (`id`, `condition_id`, `visitid`, `patientid`, `seenby`) VALUES
(1, 2, 2, '13DC2', 'ClaimSync0005');

-- --------------------------------------------------------

--
-- Table structure for table `nurses_patient_condition_notes`
--

CREATE TABLE IF NOT EXISTS `nurses_patient_condition_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  `condition_note` text NOT NULL,
  `seenby` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `nurses_patient_condition_notes`
--


-- --------------------------------------------------------

--
-- Table structure for table `nurses_patient_onsets`
--

CREATE TABLE IF NOT EXISTS `nurses_patient_onsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `onset_id` int(11) NOT NULL,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  `seenby` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `nurses_patient_onsets`
--

INSERT INTO `nurses_patient_onsets` (`id`, `onset_id`, `patientid`, `visitid`, `seenby`) VALUES
(1, 2, '13DC2', 2, 'ClaimSync0005');

-- --------------------------------------------------------

--
-- Table structure for table `nurses_patient_onset_notes`
--

CREATE TABLE IF NOT EXISTS `nurses_patient_onset_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  `onset_note` text NOT NULL,
  `seenby` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `nurses_patient_onset_notes`
--


-- --------------------------------------------------------

--
-- Table structure for table `nurses_patient_reliefs`
--

CREATE TABLE IF NOT EXISTS `nurses_patient_reliefs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `relief_id` int(11) NOT NULL,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  `seenby` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `nurses_patient_reliefs`
--

INSERT INTO `nurses_patient_reliefs` (`id`, `relief_id`, `patientid`, `visitid`, `seenby`) VALUES
(1, 3, '13DC2', 2, 'ClaimSync0005');

-- --------------------------------------------------------

--
-- Table structure for table `nurses_patient_relief_notes`
--

CREATE TABLE IF NOT EXISTS `nurses_patient_relief_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `relief_note` text NOT NULL,
  `patientid` varchar(11) NOT NULL,
  `visitid` int(11) NOT NULL,
  `seenby` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `nurses_patient_relief_notes`
--


-- --------------------------------------------------------

--
-- Table structure for table `nursingtable_vitals`
--

CREATE TABLE IF NOT EXISTS `nursingtable_vitals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) NOT NULL,
  `staff_id` varchar(50) NOT NULL,
  `doc_id` varchar(50) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `nursingtable_vitals`
--

INSERT INTO `nursingtable_vitals` (`id`, `visit_id`, `staff_id`, `doc_id`, `time`) VALUES
(1, 1, 'ClaimSync0005', 'doc', '2013-12-09 03:44:45'),
(2, 2, 'ClaimSync0005', 'doc', '2013-12-09 07:14:47');

-- --------------------------------------------------------

--
-- Table structure for table `onset_options`
--

CREATE TABLE IF NOT EXISTS `onset_options` (
  `onset_id` int(11) NOT NULL AUTO_INCREMENT,
  `onset` varchar(255) NOT NULL,
  PRIMARY KEY (`onset_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `onset_options`
--

INSERT INTO `onset_options` (`onset_id`, `onset`) VALUES
(1, 'Today'),
(2, 'Yesterday');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE IF NOT EXISTS `patient` (
  `patientid` varchar(50) NOT NULL,
  `fname` varchar(100) DEFAULT NULL,
  `lname` varchar(100) DEFAULT NULL,
  `midname` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `employer` varchar(100) DEFAULT NULL,
  `dateofbirth` date DEFAULT NULL,
  `contact` varchar(100) DEFAULT NULL,
  `second_contact` varchar(255) NOT NULL,
  `emergencyperson` varchar(100) DEFAULT NULL,
  `emergencycontact` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `dateofregistration` date DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `maritalstatus` varchar(255) DEFAULT NULL,
  `imglocation` varchar(255) DEFAULT NULL,
  `last_visit_id` int(11) NOT NULL,
  `last_claim_id` int(11) DEFAULT NULL,
  `dependent` tinyint(1) NOT NULL,
  `bearer_lastname` text,
  `bearer_othernames` text,
  `company` text,
  `occupation` text NOT NULL,
  `emergency_patient` int(11) NOT NULL,
  PRIMARY KEY (`patientid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patientid`, `fname`, `lname`, `midname`, `gender`, `address`, `employer`, `dateofbirth`, `contact`, `second_contact`, `emergencyperson`, `emergencycontact`, `email`, `dateofregistration`, `country`, `city`, `maritalstatus`, `imglocation`, `last_visit_id`, `last_claim_id`, `dependent`, `bearer_lastname`, `bearer_othernames`, `company`, `occupation`, `emergency_patient`) VALUES
('13DC1', 'Kwame', 'Johnson', '', 'Male', 'N/A', 'N/A', '2010-03-03', '0232323232', '1212121212', 'Mr. Johnson', '3002323231', 'NA', '2013-12-09', 'Ghana', 'Accra', 'Married', '', 1, NULL, 0, '11', '', NULL, 'Driver', 0),
('13DC2', 'Major', 'Konadu', '', 'Male', 'N/A', 'N/A', '2000-08-04', '054342342342', '032323222323', 'Mr. Konadu', '0323121212', 'NA', '2013-12-09', 'Ghana', 'Accra', 'Separated', '', 2, NULL, 0, '11', '', NULL, 'Doctor', 0);

-- --------------------------------------------------------

--
-- Table structure for table `patientclerking`
--

CREATE TABLE IF NOT EXISTS `patientclerking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visitid` int(11) NOT NULL,
  `questionid` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `patientclerking`
--


-- --------------------------------------------------------

--
-- Table structure for table `patientconsultation`
--

CREATE TABLE IF NOT EXISTS `patientconsultation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visitid` int(11) NOT NULL,
  `typeid` int(11) NOT NULL,
  `amountpaid` double DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `copaid` tinyint(1) NOT NULL,
  `secondary_payment` double NOT NULL,
  `personally_supported` tinyint(1) NOT NULL,
  `personal_support_amount` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `patientconsultation`
--

INSERT INTO `patientconsultation` (`id`, `visitid`, `typeid`, `amountpaid`, `status`, `copaid`, `secondary_payment`, `personally_supported`, `personal_support_amount`) VALUES
(1, 1, 1, 60, NULL, 0, 0, 0, 0),
(2, 2, 1, 60, NULL, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `patientdiagnosis`
--

CREATE TABLE IF NOT EXISTS `patientdiagnosis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patientid` varchar(20) NOT NULL,
  `diagnosisid` int(11) NOT NULL,
  `code` varchar(20) NOT NULL,
  `visitationid` int(11) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `patientdiagnosis`
--

INSERT INTO `patientdiagnosis` (`id`, `patientid`, `diagnosisid`, `code`, `visitationid`, `date`) VALUES
(1, '13DC1', 19, 'CODE', 1, '2013-12-09'),
(2, '13DC2', 27, 'CODE', 2, '2013-12-09'),
(3, '13DC2', 730, 'CODE', 2, '2013-12-09');

-- --------------------------------------------------------

--
-- Table structure for table `patientinvestigation`
--

CREATE TABLE IF NOT EXISTS `patientinvestigation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patientid` varchar(20) NOT NULL,
  `code` varchar(10) NOT NULL,
  `investigationid` int(11) NOT NULL,
  `Result` varchar(500) DEFAULT NULL,
  `concentration` varchar(100) DEFAULT NULL,
  `resultrange` varchar(100) DEFAULT NULL,
  `price` double NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `visitationid` int(11) NOT NULL,
  `note` varchar(250) DEFAULT NULL,
  `performed` varchar(20) DEFAULT NULL,
  `date` datetime NOT NULL,
  `amountpaid` double NOT NULL,
  `orderid` varchar(100) NOT NULL,
  `copaid` tinyint(1) NOT NULL,
  `is_private` tinyint(1) NOT NULL,
  `secondary_amount` double NOT NULL,
  `private_amount` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=64 ;

--
-- Dumping data for table `patientinvestigation`
--

INSERT INTO `patientinvestigation` (`id`, `patientid`, `code`, `investigationid`, `Result`, `concentration`, `resultrange`, `price`, `quantity`, `visitationid`, `note`, `performed`, `date`, `amountpaid`, `orderid`, `copaid`, `is_private`, `secondary_amount`, `private_amount`) VALUES
(1, '13DC1', 'CODE', 315, '', '', '', 20, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(2, '13DC1', 'CODE', 317, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(3, '13DC1', 'CODE', 319, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(4, '13DC1', 'CODE', 320, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(5, '13DC1', 'CODE', 321, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(6, '13DC1', 'CODE', 322, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(7, '13DC1', 'CODE', 323, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(8, '13DC1', 'CODE', 324, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(9, '13DC1', 'CODE', 325, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(10, '13DC1', 'CODE', 326, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(11, '13DC1', 'CODE', 327, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(12, '13DC1', 'CODE', 328, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(13, '13DC1', 'CODE', 329, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(14, '13DC1', 'CODE', 330, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(15, '13DC1', 'CODE', 331, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(16, '13DC1', 'CODE', 332, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(17, '13DC1', 'CODE', 333, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(18, '13DC1', 'CODE', 334, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(19, '13DC1', 'CODE', 335, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(20, '13DC1', 'CODE', 336, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(21, '13DC1', 'CODE', 337, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(22, '13DC1', 'CODE', 338, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(23, '13DC1', 'CODE', 339, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(24, '13DC1', 'CODE', 340, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(25, '13DC1', 'CODE', 341, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(26, '13DC1', 'CODE', 3, '', '', '', 15, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(27, '13DC1', 'CODE', 5, '', '', '', 30, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(28, '13DC1', 'CODE', 6, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(29, '13DC1', 'CODE', 7, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(30, '13DC1', 'CODE', 9, '', '', '', 20, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(31, '13DC1', 'CODE', 10, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(32, '13DC1', 'CODE', 11, '', '', '', 0, 0, 1, '', 'No', '2013-12-09 04:29:57', 0, '13TLA11', 0, 0, 0, 0),
(33, '13DC2', 'CODE', 315, '', '', '', 20, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(34, '13DC2', 'CODE', 317, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(35, '13DC2', 'CODE', 319, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(36, '13DC2', 'CODE', 320, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(37, '13DC2', 'CODE', 321, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(38, '13DC2', 'CODE', 322, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(39, '13DC2', 'CODE', 323, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(40, '13DC2', 'CODE', 324, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(41, '13DC2', 'CODE', 325, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(42, '13DC2', 'CODE', 326, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(43, '13DC2', 'CODE', 327, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(44, '13DC2', 'CODE', 328, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(45, '13DC2', 'CODE', 329, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(46, '13DC2', 'CODE', 330, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(47, '13DC2', 'CODE', 331, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(48, '13DC2', 'CODE', 332, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(49, '13DC2', 'CODE', 333, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(50, '13DC2', 'CODE', 334, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(51, '13DC2', 'CODE', 335, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(52, '13DC2', 'CODE', 336, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(53, '13DC2', 'CODE', 337, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(54, '13DC2', 'CODE', 338, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(55, '13DC2', 'CODE', 339, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(56, '13DC2', 'CODE', 340, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(57, '13DC2', 'CODE', 341, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(58, '13DC2', 'CODE', 9, '', '', '', 20, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(59, '13DC2', 'CODE', 10, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(60, '13DC2', 'CODE', 11, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(61, '13DC2', 'CODE', 430, '', '', '', 15, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(62, '13DC2', 'CODE', 431, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0),
(63, '13DC2', 'CODE', 432, '', '', '', 0, 0, 2, '', 'No', '2013-12-09 07:28:26', 0, '13TLA12', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `patienttreatment`
--

CREATE TABLE IF NOT EXISTS `patienttreatment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `treatmentid` int(11) NOT NULL,
  `dosage` int(100) NOT NULL,
  `visitationid` int(11) NOT NULL,
  `price` double NOT NULL,
  `duration` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `dispensed` varchar(10) NOT NULL,
  `amounpaid` double DEFAULT NULL,
  `orderid` varchar(50) NOT NULL,
  `transition_id` int(11) DEFAULT NULL,
  `pharmacy_order_id` varchar(255) DEFAULT NULL,
  `copaid` tinyint(1) DEFAULT NULL,
  `is_private` tinyint(1) DEFAULT NULL,
  `secondary_amount` double DEFAULT NULL,
  `private_amount` double DEFAULT NULL,
  `vat_value` double DEFAULT NULL,
  `net_value` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `pharmacy_item_code` varchar(255) DEFAULT NULL,
  `dispensary_item_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dosage` (`dosage`),
  KEY `orderid` (`orderid`),
  KEY `transition_id` (`transition_id`),
  KEY `pharmacy_order_id` (`pharmacy_order_id`),
  KEY `pharmacy_item_code` (`pharmacy_item_code`),
  KEY `dispensary_item_code` (`dispensary_item_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `patienttreatment`
--


-- --------------------------------------------------------

--
-- Table structure for table `patient_aggravations`
--

CREATE TABLE IF NOT EXISTS `patient_aggravations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aggravation_id` int(11) NOT NULL,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `patient_aggravations`
--

INSERT INTO `patient_aggravations` (`id`, `aggravation_id`, `patientid`, `visitid`) VALUES
(1, 2, '13DC1', 1),
(2, 4, '13DC2', 2);

-- --------------------------------------------------------

--
-- Table structure for table `patient_aggravation_notes`
--

CREATE TABLE IF NOT EXISTS `patient_aggravation_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aggravation_note` text NOT NULL,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `patient_aggravation_notes`
--


-- --------------------------------------------------------

--
-- Table structure for table `patient_allergies`
--

CREATE TABLE IF NOT EXISTS `patient_allergies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patientid` varchar(100) NOT NULL,
  `allergyid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `patient_allergies`
--

INSERT INTO `patient_allergies` (`id`, `patientid`, `allergyid`) VALUES
(1, '13DC1', 1),
(2, '13DC1', 2),
(3, '13DC1', 3),
(4, '13DC2', 1);

-- --------------------------------------------------------

--
-- Table structure for table `patient_bed`
--

CREATE TABLE IF NOT EXISTS `patient_bed` (
  `visitid` int(11) NOT NULL,
  `patientid` varchar(100) NOT NULL,
  `bedid` int(11) NOT NULL,
  PRIMARY KEY (`visitid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient_bed`
--

INSERT INTO `patient_bed` (`visitid`, `patientid`, `bedid`) VALUES
(2, '13DC2', 4);

-- --------------------------------------------------------

--
-- Table structure for table `patient_bills`
--

CREATE TABLE IF NOT EXISTS `patient_bills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_type` varchar(255) NOT NULL,
  `patientid` text NOT NULL,
  `visitid` int(11) NOT NULL,
  `total_bill` double NOT NULL,
  `amount_paid` double NOT NULL,
  `status` text NOT NULL,
  `laborder_discount` int(11) NOT NULL,
  `pharmorder_discount` int(11) NOT NULL,
  `medical_discount` int(11) NOT NULL,
  `procedure_discount` int(11) NOT NULL,
  `billdate` datetime NOT NULL,
  `staff_id` varchar(255) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `patient_bills`
--

INSERT INTO `patient_bills` (`id`, `bill_type`, `patientid`, `visitid`, `total_bill`, `amount_paid`, `status`, `laborder_discount`, `pharmorder_discount`, `medical_discount`, `procedure_discount`, `billdate`, `staff_id`, `date`) VALUES
(1, 'Registration Bill', '13DC1', 1, 15, 15, 'Paid', 0, 0, 0, 0, '2013-12-09 03:42:44', 'ClaimSync0002', '2013-12-09'),
(2, 'Card Bill', '13DC1', 1, 20, 20, 'Paid', 0, 0, 0, 0, '2013-12-09 03:42:47', 'ClaimSync0002', '2013-12-09'),
(3, 'Consultation Bill', '13DC1', 1, 20, 20, 'Paid', 0, 0, 0, 0, '2013-12-09 03:42:55', 'ClaimSync0002', '2013-12-09'),
(4, 'Registration Bill', '13DC2', 2, 15, 15, 'Paid', 0, 0, 0, 0, '2013-12-09 07:02:55', 'ClaimSync0002', '2013-12-09'),
(5, 'Card Bill', '13DC2', 2, 20, 20, 'Paid', 0, 0, 0, 0, '2013-12-09 07:02:58', 'ClaimSync0002', '2013-12-09'),
(6, 'Consultation Bill', '13DC2', 2, 20, 20, 'Paid', 0, 0, 0, 0, '2013-12-09 07:03:09', 'ClaimSync0002', '2013-12-09'),
(7, 'Procedure Bill', '13DC2', 0, 45, 0, 'Not-Paid', 0, 0, 0, 0, '2013-12-09 07:14:46', 'ClaimSync0005', '2013-12-09'),
(8, 'Procedure Bill', '13DC2', 0, 8, 0, 'Not-Paid', 0, 0, 0, 0, '2013-12-09 07:28:27', 'ClaimSync0001', '2013-12-09');

-- --------------------------------------------------------

--
-- Table structure for table `patient_body_parts`
--

CREATE TABLE IF NOT EXISTS `patient_body_parts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `body_part_id` int(11) NOT NULL,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `patient_body_parts`
--

INSERT INTO `patient_body_parts` (`id`, `body_part_id`, `patientid`, `visitid`) VALUES
(1, 1, '13DC1', 1),
(2, 3, '13DC2', 2);

-- --------------------------------------------------------

--
-- Table structure for table `patient_body_part_notes`
--

CREATE TABLE IF NOT EXISTS `patient_body_part_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `body_part_note` text NOT NULL,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `patient_body_part_notes`
--


-- --------------------------------------------------------

--
-- Table structure for table `patient_characteristics`
--

CREATE TABLE IF NOT EXISTS `patient_characteristics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `characteristic_id` int(11) NOT NULL,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `patient_characteristics`
--

INSERT INTO `patient_characteristics` (`id`, `characteristic_id`, `patientid`, `visitid`) VALUES
(1, 3, '13DC1', 1),
(2, 2, '13DC2', 2);

-- --------------------------------------------------------

--
-- Table structure for table `patient_characteristic_notes`
--

CREATE TABLE IF NOT EXISTS `patient_characteristic_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `characteristic_note` text NOT NULL,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `patient_characteristic_notes`
--


-- --------------------------------------------------------

--
-- Table structure for table `patient_conditions`
--

CREATE TABLE IF NOT EXISTS `patient_conditions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `condition_id` int(11) NOT NULL,
  `visitid` int(11) NOT NULL,
  `patientid` varchar(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `patient_conditions`
--

INSERT INTO `patient_conditions` (`id`, `condition_id`, `visitid`, `patientid`) VALUES
(1, 2, 1, '13DC1'),
(2, 3, 2, '13DC2');

-- --------------------------------------------------------

--
-- Table structure for table `patient_condition_notes`
--

CREATE TABLE IF NOT EXISTS `patient_condition_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  `condition_note` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `patient_condition_notes`
--


-- --------------------------------------------------------

--
-- Table structure for table `patient_discount`
--

CREATE TABLE IF NOT EXISTS `patient_discount` (
  `discount_id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) NOT NULL,
  `patient_id` text NOT NULL,
  `percentage_discount` double NOT NULL,
  `discounted` double NOT NULL,
  `new_amount` double NOT NULL,
  `staff_id` text NOT NULL,
  `status` text NOT NULL,
  `reason` text NOT NULL,
  PRIMARY KEY (`discount_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `patient_discount`
--


-- --------------------------------------------------------

--
-- Table structure for table `patient_drug_history`
--

CREATE TABLE IF NOT EXISTS `patient_drug_history` (
  `patient_drug_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) NOT NULL,
  `patient_id` varchar(11) NOT NULL,
  `drug_taken` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`patient_drug_history_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `patient_drug_history`
--


-- --------------------------------------------------------

--
-- Table structure for table `patient_durations`
--

CREATE TABLE IF NOT EXISTS `patient_durations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `duration_id` int(11) NOT NULL,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `patient_durations`
--

INSERT INTO `patient_durations` (`id`, `duration_id`, `patientid`, `visitid`) VALUES
(1, 1, '13DC1', 1),
(2, 4, '13DC2', 2);

-- --------------------------------------------------------

--
-- Table structure for table `patient_duration_notes`
--

CREATE TABLE IF NOT EXISTS `patient_duration_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  `duration_note` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `patient_duration_notes`
--


-- --------------------------------------------------------

--
-- Table structure for table `patient_family_history`
--

CREATE TABLE IF NOT EXISTS `patient_family_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visitid` int(11) NOT NULL,
  `patientid` varchar(11) NOT NULL,
  `history_id` int(11) NOT NULL,
  `family_member` varchar(255) NOT NULL,
  `duration_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `patient_family_history`
--

INSERT INTO `patient_family_history` (`id`, `visitid`, `patientid`, `history_id`, `family_member`, `duration_id`, `date`) VALUES
(1, 1, '13DC1', 6, 'Siblings', 2, '2013-12-09 04:29:57'),
(2, 1, '13DC1', 7, 'Mother', 2, '2013-12-09 04:29:57'),
(3, 1, '13DC1', 11, 'Siblings', 3, '2013-12-09 04:29:57'),
(4, 2, '13DC2', 6, 'Siblings', 2, '2013-12-09 07:28:26'),
(5, 2, '13DC2', 7, 'Mother', 4, '2013-12-09 07:28:26');

-- --------------------------------------------------------

--
-- Table structure for table `patient_immunizations`
--

CREATE TABLE IF NOT EXISTS `patient_immunizations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  `immunization` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `patient_immunizations`
--

INSERT INTO `patient_immunizations` (`id`, `patientid`, `visitid`, `immunization`) VALUES
(1, '13DC1', 1, 'Polio'),
(2, '13DC1', 1, 'Hepatitis'),
(3, '13DC2', 2, 'Polio'),
(4, '13DC2', 2, 'Hepatitis');

-- --------------------------------------------------------

--
-- Table structure for table `patient_major_examinations`
--

CREATE TABLE IF NOT EXISTS `patient_major_examinations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  `examination_note` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `patient_major_examinations`
--

INSERT INTO `patient_major_examinations` (`id`, `patientid`, `visitid`, `examination_note`) VALUES
(1, '13DC1', 1, 'The Patient is really sick'),
(2, '13DC2', 2, 'The Patient is experiencing a stroke');

-- --------------------------------------------------------

--
-- Table structure for table `patient_medical_history`
--

CREATE TABLE IF NOT EXISTS `patient_medical_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visitid` int(11) NOT NULL,
  `patientid` varchar(11) NOT NULL,
  `history_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `patient_medical_history`
--

INSERT INTO `patient_medical_history` (`id`, `visitid`, `patientid`, `history_id`, `date`) VALUES
(1, 1, '13DC1', 6, '2013-12-09 04:29:57'),
(2, 1, '13DC1', 7, '2013-12-09 04:29:57'),
(3, 1, '13DC1', 11, '2013-12-09 04:29:57'),
(4, 2, '13DC2', 6, '2013-12-09 07:28:26');

-- --------------------------------------------------------

--
-- Table structure for table `patient_onsets`
--

CREATE TABLE IF NOT EXISTS `patient_onsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `onset_id` int(11) NOT NULL,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `patient_onsets`
--

INSERT INTO `patient_onsets` (`id`, `onset_id`, `patientid`, `visitid`) VALUES
(1, 1, '13DC1', 1),
(2, 1, '13DC2', 2);

-- --------------------------------------------------------

--
-- Table structure for table `patient_onset_notes`
--

CREATE TABLE IF NOT EXISTS `patient_onset_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  `onset_note` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `patient_onset_notes`
--


-- --------------------------------------------------------

--
-- Table structure for table `patient_procedure`
--

CREATE TABLE IF NOT EXISTS `patient_procedure` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patientid` varchar(100) NOT NULL,
  `procedure_code` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `visitid` int(11) NOT NULL,
  `amountpaid` double NOT NULL,
  `copaid` tinyint(1) NOT NULL,
  `is_private` tinyint(1) NOT NULL,
  `secondary_amount` double NOT NULL,
  `private_amount` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `patient_procedure`
--

INSERT INTO `patient_procedure` (`id`, `patientid`, `procedure_code`, `date`, `visitid`, `amountpaid`, `copaid`, `is_private`, `secondary_amount`, `private_amount`) VALUES
(1, '13DC1', 'DRESSING 1', '2013-12-09', 1, 0, 0, 0, 0, 0),
(2, '13DC2', 'DRESSING 2', '2013-12-09', 2, 0, 0, 0, 0, 0),
(3, '13DC2', 'SUTURING 4', '2013-12-09', 2, 0, 0, 0, 0, 0),
(4, '13DC2', 'DRESSING 1', '2013-12-09', 3, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `patient_procedure_walkins`
--

CREATE TABLE IF NOT EXISTS `patient_procedure_walkins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` varchar(255) NOT NULL,
  `procedure_code` varchar(255) NOT NULL,
  `procedure_price` double NOT NULL,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `patient_procedure_walkins`
--


-- --------------------------------------------------------

--
-- Table structure for table `patient_registration`
--

CREATE TABLE IF NOT EXISTS `patient_registration` (
  `reg_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` varchar(25) NOT NULL,
  `payment_status` tinyint(1) NOT NULL DEFAULT '0',
  `amount_paid` double NOT NULL DEFAULT '0',
  `date_paid` date DEFAULT NULL,
  `reg_fee_id` int(11) NOT NULL,
  `copaid` tinyint(1) NOT NULL,
  `secondary_payment` double NOT NULL,
  `personally_supported` tinyint(1) NOT NULL,
  `personal_support_amount` double NOT NULL,
  PRIMARY KEY (`reg_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `patient_registration`
--

INSERT INTO `patient_registration` (`reg_id`, `patient_id`, `payment_status`, `amount_paid`, `date_paid`, `reg_fee_id`, `copaid`, `secondary_payment`, `personally_supported`, `personal_support_amount`) VALUES
(1, '13DC2', 1, 0, '2013-12-09', 0, 0, 0, 0, 0),
(2, '13DC2', 1, 0, '2013-12-09', 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `patient_reliefs`
--

CREATE TABLE IF NOT EXISTS `patient_reliefs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `relief_id` int(11) NOT NULL,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `patient_reliefs`
--

INSERT INTO `patient_reliefs` (`id`, `relief_id`, `patientid`, `visitid`) VALUES
(1, 2, '13DC1', 1),
(2, 3, '13DC2', 2);

-- --------------------------------------------------------

--
-- Table structure for table `patient_relief_notes`
--

CREATE TABLE IF NOT EXISTS `patient_relief_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `relief_note` text NOT NULL,
  `patientid` varchar(11) NOT NULL,
  `visitid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `patient_relief_notes`
--


-- --------------------------------------------------------

--
-- Table structure for table `patient_social_history`
--

CREATE TABLE IF NOT EXISTS `patient_social_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visitid` int(11) NOT NULL,
  `patientid` varchar(11) NOT NULL,
  `social_history_id` int(11) NOT NULL,
  `duration_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `patient_social_history`
--

INSERT INTO `patient_social_history` (`id`, `visitid`, `patientid`, `social_history_id`, `duration_id`, `date`) VALUES
(1, 1, '13DC1', 2, 1, '2013-12-09 04:29:57'),
(2, 1, '13DC1', 3, 2, '2013-12-09 04:29:57'),
(3, 1, '13DC1', 4, 2, '2013-12-09 04:29:57'),
(4, 2, '13DC2', 2, 1, '2013-12-09 07:28:26'),
(5, 2, '13DC2', 3, 2, '2013-12-09 07:28:26');

-- --------------------------------------------------------

--
-- Table structure for table `patient_surgeries`
--

CREATE TABLE IF NOT EXISTS `patient_surgeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  `surgery` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `patient_surgeries`
--

INSERT INTO `patient_surgeries` (`id`, `patientid`, `visitid`, `surgery`) VALUES
(1, '13DC1', 1, 'Heart Surgery'),
(2, '13DC1', 1, 'Leg Surgery'),
(3, '13DC2', 2, 'Heart Surgery'),
(4, '13DC2', 2, 'Throat Surgery');

-- --------------------------------------------------------

--
-- Table structure for table `patient_systemic_reviews`
--

CREATE TABLE IF NOT EXISTS `patient_systemic_reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visitid` int(11) NOT NULL,
  `patientid` varchar(11) NOT NULL,
  `systemic_review_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `patient_systemic_reviews`
--

INSERT INTO `patient_systemic_reviews` (`id`, `visitid`, `patientid`, `systemic_review_id`, `date`) VALUES
(1, 1, '13DC1', 8, '2013-12-09 04:29:57'),
(2, 1, '13DC1', 10, '2013-12-09 04:29:57'),
(3, 1, '13DC1', 2, '2013-12-09 04:29:57'),
(4, 1, '13DC1', 14, '2013-12-09 04:29:57'),
(5, 1, '13DC1', 13, '2013-12-09 04:29:57'),
(6, 1, '13DC1', 11, '2013-12-09 04:29:57'),
(7, 2, '13DC2', 8, '2013-12-09 07:28:26'),
(8, 2, '13DC2', 11, '2013-12-09 07:28:26');

-- --------------------------------------------------------

--
-- Table structure for table `patient_treatment_batch`
--

CREATE TABLE IF NOT EXISTS `patient_treatment_batch` (
  `object_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_treatment_id` int(11) NOT NULL,
  `batch_number` varchar(255) NOT NULL,
  PRIMARY KEY (`object_id`),
  KEY `patient_treatment_id` (`patient_treatment_id`),
  KEY `batch_number` (`batch_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `patient_treatment_batch`
--


-- --------------------------------------------------------

--
-- Table structure for table `patient_treatment_notes`
--

CREATE TABLE IF NOT EXISTS `patient_treatment_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `treatment_note` text NOT NULL,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `patient_treatment_notes`
--


-- --------------------------------------------------------

--
-- Table structure for table `patient_treats`
--

CREATE TABLE IF NOT EXISTS `patient_treats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `treatment_id` int(11) NOT NULL,
  `patientid` varchar(10) NOT NULL,
  `visitid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `patient_treats`
--

INSERT INTO `patient_treats` (`id`, `treatment_id`, `patientid`, `visitid`) VALUES
(1, 2, '13DC1', 1),
(2, 2, '13DC1', 1),
(3, 3, '13DC2', 2);

-- --------------------------------------------------------

--
-- Table structure for table `payment_object`
--

CREATE TABLE IF NOT EXISTS `payment_object` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(255) NOT NULL,
  `transaction_type` varchar(255) NOT NULL,
  `item_id` varchar(255) DEFAULT NULL,
  `primary_sponsor_id` varchar(50) DEFAULT NULL,
  `primary_sponsor_amount` double DEFAULT NULL,
  `sec_sponsor_id` varchar(50) DEFAULT NULL,
  `sec_sponsor_amount` double DEFAULT NULL,
  `out_of_pocket_id` varchar(50) DEFAULT NULL,
  `out_of_pocket_amount` double DEFAULT NULL,
  `date_paid` date NOT NULL,
  `time_paid` time NOT NULL,
  `staff_id` varchar(100) NOT NULL,
  `patient_id` varchar(255) NOT NULL,
  `status` varchar(30) NOT NULL,
  `total_amount_paid` double NOT NULL,
  `unknown_two` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `payment_object`
--

INSERT INTO `payment_object` (`id`, `transaction_id`, `transaction_type`, `item_id`, `primary_sponsor_id`, `primary_sponsor_amount`, `sec_sponsor_id`, `sec_sponsor_amount`, `out_of_pocket_id`, `out_of_pocket_amount`, `date_paid`, `time_paid`, `staff_id`, `patient_id`, `status`, `total_amount_paid`, `unknown_two`) VALUES
(1, '2', 'Card Payment', '', '11', 20, '', 0, '11', 20, '2013-12-09', '07:05:20', 'ClaimSync0003', '13DC2', 'status', 20, NULL),
(2, '2', 'Registration Payment', '', '11', 15, '', 0, '11', 15, '2013-12-09', '07:05:20', 'ClaimSync0003', '13DC2', 'status', 15, NULL),
(3, '2', 'Consultation Payment', '', '11', 20, '', 0, '11', 20, '2013-12-09', '07:05:20', 'ClaimSync0003', '13DC2', 'status', 20, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

CREATE TABLE IF NOT EXISTS `permission` (
  `permissionid` int(11) NOT NULL AUTO_INCREMENT,
  `permission` text NOT NULL,
  `departmentid` int(11) NOT NULL,
  PRIMARY KEY (`permissionid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=86 ;

--
-- Dumping data for table `permission`
--

INSERT INTO `permission` (`permissionid`, `permission`, `departmentid`) VALUES
(1, 'Register New Patient', 1),
(2, 'Receiving of Money', 1),
(3, 'Allow Discount at Clinic', 1),
(4, 'Removal of Patient', 1),
(5, 'Delete Record', 1),
(6, 'Booking Test', 4),
(7, 'Register Patient at Lab', 4),
(8, 'Enter Result', 4),
(9, 'Scrutinize Results', 4),
(11, 'Edit a Booked a Test', 4),
(12, 'Delete a Test', 4),
(14, 'Removal of Lab Patient', 4),
(15, 'Setting up Test', 4),
(16, 'Allow Discount at the Lab', 4),
(17, 'View Lab Report', 4),
(18, 'View Detail Report', 4),
(19, 'Generate Claim', 1),
(20, 'View Staff Logging', 0),
(21, 'Lab Patient Registration', 4),
(22, 'Update Lab Patient Details', 4),
(23, 'Receiving Paying', 4),
(24, 'View Lab Results', 4),
(25, 'View Results Archive', 4),
(26, 'Sample Collection', 4),
(27, 'Results Entry', 4),
(28, 'Outstanding Result Entry', 4),
(29, 'Results Scrutiny', 4),
(30, 'Lab Code Setup', 4),
(31, 'Lab Price Setup', 4),
(32, 'General Deletion', 4),
(33, 'General View', 4),
(34, 'General Creating items', 4),
(35, 'General Updating items', 4),
(36, 'Reordering Lab Classification', 4),
(37, 'Create Lab Classification', 4),
(38, 'Update Lab Classification', 4),
(39, 'View Lab Classification', 4),
(40, 'Delete Lab Classification', 4),
(41, 'Create Main Lab', 4),
(42, 'View Main Lab', 4),
(43, 'Update Main Lab', 4),
(44, 'Delete Main Lab', 4),
(45, 'Create Sub Lab', 4),
(46, 'View Sub Lab', 4),
(47, 'Update Sub Lab', 4),
(48, 'Delete Sub Lab', 4),
(49, 'Create Profile', 4),
(50, 'View Profile', 4),
(51, 'Update Profile', 4),
(52, 'Delete Profile', 4),
(53, 'Create Anti Biotics', 4),
(54, 'View Anti Biotics', 4),
(55, 'Update Anti Biotics', 4),
(56, 'Delete Anti Biotics', 4),
(57, 'Create Specimen', 4),
(58, 'Update Specimen', 4),
(59, 'View Specimen', 4),
(60, 'Delete Specimen', 4),
(61, 'Add New Stock Item', 4),
(62, 'View Lab Stock Item', 4),
(63, 'Update Lab Stock Item', 4),
(64, 'Delete Lab Stock Item', 4),
(65, 'Receive Items to Lab Stock', 4),
(66, 'Remove Items From Lab Stock', 4),
(67, 'Edit Lab Stock Items', 4),
(68, 'Move Items to Shelve', 4),
(69, 'Edit Items In USe', 4),
(70, 'Delete Items In use', 4),
(71, 'View Items In use', 4),
(72, 'Allow Lab Discout', 4),
(73, 'Lab Admin Over ride', 4),
(74, 'Laboratory Price List Report', 4),
(75, 'Staff Sales Report', 4),
(76, 'Patient History Report', 4),
(77, 'Test Load Report', 4),
(78, 'Test Booking Report', 4),
(79, 'Outstanding Test Report', 4),
(80, 'Outstanding Payments Reports', 4),
(81, 'Current Outstanding Report', 4),
(82, 'Sponsorship Report', 4),
(83, 'Facility Referral Report', 4),
(84, 'Doctor''s Referral Report', 4),
(85, 'Report Tracking', 4);

-- --------------------------------------------------------

--
-- Table structure for table `pharmacyorder`
--

CREATE TABLE IF NOT EXISTS `pharmacyorder` (
  `order_id` varchar(100) NOT NULL,
  `dispensed_by` varchar(100) DEFAULT NULL,
  `pharmacist` varchar(100) DEFAULT NULL,
  `dispensed_date` datetime DEFAULT NULL,
  `client_info_id` varchar(100) DEFAULT NULL,
  `staff_id` varchar(100) DEFAULT NULL,
  `date` datetime NOT NULL,
  `total_cost` double NOT NULL,
  `amount_paid` double NOT NULL,
  `outstanding_amount` double NOT NULL,
  `payment_status` varchar(100) DEFAULT NULL,
  `requested_by` varchar(100) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `discounted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `pharmacist` (`pharmacist`),
  KEY `client_info_id` (`client_info_id`),
  KEY `dispensed_by` (`dispensed_by`),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pharmacyorder`
--


-- --------------------------------------------------------

--
-- Table structure for table `pharmacy_batch`
--

CREATE TABLE IF NOT EXISTS `pharmacy_batch` (
  `item_batch` varchar(255) NOT NULL,
  `item_code` varchar(255) NOT NULL,
  `quantity_received` int(11) NOT NULL,
  `quantity_on_hand` int(11) NOT NULL,
  `date_received` date NOT NULL,
  `expiry_date` date NOT NULL,
  `selling_price` double NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `purchase_price` double NOT NULL,
  `received_value` double NOT NULL,
  `value_on_hand` double NOT NULL,
  PRIMARY KEY (`item_batch`),
  KEY `item_code` (`item_code`),
  KEY `invoice_id` (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pharmacy_batch`
--


-- --------------------------------------------------------

--
-- Table structure for table `pharmacy_discount`
--

CREATE TABLE IF NOT EXISTS `pharmacy_discount` (
  `discount_id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` text NOT NULL,
  `patient_id` text NOT NULL,
  `percentage_discount` double NOT NULL,
  `discounted` double NOT NULL,
  `new_amount` double NOT NULL,
  `staff_id` text NOT NULL,
  `status` text NOT NULL,
  `reason` text NOT NULL,
  PRIMARY KEY (`discount_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `pharmacy_discount`
--


-- --------------------------------------------------------

--
-- Table structure for table `pharmacy_item`
--

CREATE TABLE IF NOT EXISTS `pharmacy_item` (
  `item_description` varchar(255) NOT NULL,
  `item_code` varchar(100) NOT NULL,
  `quantity_on_hand` int(11) NOT NULL,
  `manufacturer` varchar(500) NOT NULL,
  `price_markup` double NOT NULL,
  `percentage_markup` double NOT NULL,
  `form_id` int(11) NOT NULL,
  `unit_of_issue` int(11) NOT NULL,
  `reorder_level` int(11) NOT NULL,
  `minimum_stock_level` int(11) NOT NULL,
  `strength` varchar(255) NOT NULL,
  `active_ingredients` varchar(1000) NOT NULL,
  `reorder_qty` int(11) NOT NULL,
  `maximum_stock_level` int(11) DEFAULT NULL,
  `therapeutic_group` int(11) NOT NULL,
  `vatable` tinyint(1) NOT NULL,
  PRIMARY KEY (`item_code`),
  KEY `form_id` (`form_id`),
  KEY `unit_of_issue` (`unit_of_issue`),
  KEY `therapeutic_group` (`therapeutic_group`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pharmacy_item`
--

INSERT INTO `pharmacy_item` (`item_description`, `item_code`, `quantity_on_hand`, `manufacturer`, `price_markup`, `percentage_markup`, `form_id`, `unit_of_issue`, `reorder_level`, `minimum_stock_level`, `strength`, `active_ingredients`, `reorder_qty`, `maximum_stock_level`, `therapeutic_group`, `vatable`) VALUES
('Coartem', 'COARTE', 0, 'Norvatis', 1.4, 12, 3, 1, 300, 200, '500mg', 'Anti Malaris', 200, 500, 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `pharmorder`
--

CREATE TABLE IF NOT EXISTS `pharmorder` (
  `orderid` varchar(50) NOT NULL,
  `patientid` text NOT NULL,
  `fromdoc` text,
  `orderdate` date NOT NULL,
  `dispenseddate` date DEFAULT NULL,
  `visitid` int(11) DEFAULT NULL,
  `dispensed` varchar(50) DEFAULT NULL,
  `amoutpaid` double DEFAULT NULL,
  `outstanding` double DEFAULT NULL,
  `total_amount` double NOT NULL,
  `dispensed_by` varchar(255) NOT NULL,
  `received_by` varchar(255) NOT NULL,
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pharmorder`
--

INSERT INTO `pharmorder` (`orderid`, `patientid`, `fromdoc`, `orderdate`, `dispenseddate`, `visitid`, `dispensed`, `amoutpaid`, `outstanding`, `total_amount`, `dispensed_by`, `received_by`) VALUES
('13DPH1', '13DC1', 'ClaimSync0001', '2013-12-09', NULL, 1, 'Not Done', 0, 0, 0, 'Non', 'Non');

-- --------------------------------------------------------

--
-- Table structure for table `possibleinv_results`
--

CREATE TABLE IF NOT EXISTS `possibleinv_results` (
  `posinv_result_id` int(11) NOT NULL AUTO_INCREMENT,
  `posinv_result` varchar(255) NOT NULL,
  PRIMARY KEY (`posinv_result_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1722 ;

--
-- Dumping data for table `possibleinv_results`
--

INSERT INTO `possibleinv_results` (`posinv_result_id`, `posinv_result`) VALUES
(1, 'No MPs Seen'),
(2, 'MPs Present (+)'),
(3, 'MPs Present (++)'),
(4, 'MPs Present (+++)'),
(5, 'MPs Present (++++)'),
(6, 'Negative'),
(7, 'Positive'),
(8, 'A Rhesus (D) Positve '),
(9, 'B Rhesus (D) Positive'),
(10, 'AB Rhesus (D) Positve'),
(11, 'O Rhesus (D) Positive'),
(12, 'A Rhesus (D) Negative'),
(13, 'B Rhesus (D) Negative'),
(14, 'AB Rhesus (D) Negative'),
(15, 'O Rhesus (D) Negative'),
(16, 'Negative'),
(17, 'Positve'),
(18, 'Genotype (AA)'),
(19, 'Genotype (AS)'),
(20, 'Genotype (AC)'),
(21, 'Genotype (SS)'),
(22, 'Genotype (SC)'),
(23, 'Genotype (CC)'),
(24, 'Genotype (AF)'),
(25, 'Genotype (SF)'),
(26, 'No Defect'),
(27, 'Full Defect'),
(28, 'Normal Activity'),
(29, 'Abnormal Activity (Reduced)'),
(30, 'Partial Defect'),
(31, 'Negative'),
(32, 'Positive'),
(33, 'Negative'),
(34, 'Positive'),
(36, 'Negative at 1/20'),
(37, 'Negative at 1/40'),
(38, 'Positive at 1/80'),
(39, 'Positive at 1/160'),
(40, 'Positive at 1/320'),
(41, 'Negative at 1/20'),
(42, 'Negative at 1/40'),
(43, 'Positive at 1/80'),
(44, 'Positive at 1/160'),
(45, 'Positive at 1/320'),
(46, 'Negative at 1/20'),
(47, 'Negative at 1/40'),
(48, 'Positive at 1/80'),
(49, 'Positive at 1/160'),
(50, 'Positive at 1/320'),
(51, 'Negative at 1/20'),
(52, 'Negative at 1/40'),
(53, 'Positive at 1/80'),
(54, 'Positive at 1/160'),
(55, 'Positive at 1/320'),
(56, 'Negative at 1/20'),
(57, 'Negative at 1/40'),
(58, 'Positive at 1/80'),
(59, 'Positive at 1/160'),
(60, 'Positive at 1/320'),
(61, 'Negative at 1/20'),
(62, 'Negative at 1/40'),
(63, 'Positive at 1/80'),
(64, 'Positive at 1/160'),
(65, 'Positive at 1/320'),
(66, 'Negative at 1/20'),
(67, 'Negative at 1/40'),
(68, 'Positive at 1/80'),
(69, 'Positive at 1/160'),
(70, 'Positive at 1/320'),
(71, 'Negative at 1/20'),
(72, 'Negative at 1/40'),
(73, 'Positive at 1/80'),
(74, 'Positive at 1/160'),
(75, 'Positive at 1/320'),
(76, 'Negative'),
(77, 'Positive'),
(78, 'Positve '),
(79, 'Negative'),
(80, 'Negative'),
(81, 'Positive'),
(82, 'Negative'),
(83, 'Positive'),
(86, 'Negative'),
(87, 'Positive'),
(88, 'Negative'),
(89, 'Positive'),
(90, 'Negative'),
(91, 'Positive'),
(92, 'Negative'),
(93, 'Positive'),
(96, 'Negative'),
(97, 'Positive'),
(102, 'Negative'),
(103, 'Trace'),
(104, 'Positive (+)'),
(105, 'Positive (++)'),
(106, 'Positive (+++)'),
(107, 'Positve (++++)'),
(108, 'Negative'),
(109, 'Trace'),
(110, 'Positive (+)'),
(111, 'Positive (++)'),
(112, 'Positive (+++)'),
(113, 'Positive (++++)'),
(208, 'Clear'),
(209, 'Slightly Cloudy'),
(210, 'Cloudy'),
(211, 'Slightly Hazy'),
(212, 'Hazy'),
(213, 'Colourless'),
(214, 'Straw'),
(215, 'Light Amber'),
(216, 'Amber'),
(217, 'Deep Amber'),
(218, 'Reddish'),
(219, '5.0'),
(220, '6.0'),
(221, '6.5'),
(222, '7.0'),
(223, '8.0'),
(224, '9.0'),
(225, '1.000'),
(226, '1.005'),
(227, '1.010'),
(228, '1.015'),
(229, '1.020'),
(230, '1.025'),
(231, '1.030'),
(232, 'Negative'),
(233, 'Trace'),
(234, 'Positive (+)'),
(235, 'Positive (++)'),
(236, 'Positive (+++)'),
(237, 'Positive (++++)'),
(238, 'Negative'),
(239, 'Trace'),
(240, 'Positive (+)'),
(241, 'Positive (++)'),
(242, 'Positive (+++)'),
(243, 'Negative'),
(244, 'Trace'),
(245, 'Positive (+)'),
(246, 'Positive (++)'),
(247, 'Positive (+++)'),
(248, 'Negative'),
(249, 'Trace'),
(250, 'Positive (+)'),
(251, 'Positive (++)'),
(252, 'Positive (+++)'),
(253, 'Negative'),
(254, 'Trace'),
(255, 'Positive (+)'),
(256, 'Positive (++)'),
(257, 'Positive (+++)'),
(258, 'Negative'),
(259, 'Positive'),
(260, 'Negative'),
(261, 'Positive (+)'),
(262, 'Positive (++)'),
(263, 'Positive (+++)'),
(264, 'Normal'),
(265, 'Trace'),
(266, 'Positive (+)'),
(267, 'Positive (++)'),
(268, 'Positive (+++)'),
(269, 'None Seen'),
(270, 'Positive (+)'),
(271, 'Positive (++)'),
(272, 'Positive (+++)'),
(273, 'Positive (++++)'),
(274, 'None Seen'),
(275, 'Present (+)'),
(276, 'Present (++)'),
(277, 'Present (+++)'),
(278, 'Present (++++)'),
(279, 'None Seen'),
(280, 'Present (+)'),
(281, 'Present (++)'),
(282, 'Present (+++)'),
(283, 'Present (++++)'),
(284, 'None Seen'),
(285, 'Present (+)'),
(286, 'Present (++)'),
(287, 'Present (+++)'),
(288, 'Present (++++)'),
(289, 'Semiformed Specimen'),
(290, 'Formed Specimen'),
(291, 'Loose Specimen'),
(292, 'Watery Specimen'),
(293, 'Bloody Specimen'),
(294, 'Mucous Specimen'),
(295, 'None Seen'),
(296, 'Occasional'),
(297, 'Present (+)'),
(298, 'Present (++)'),
(299, 'Present (+++)'),
(300, 'Present (++++)'),
(301, 'None Seen'),
(302, 'Occasional'),
(303, 'Present (+)'),
(304, 'Present (++)'),
(305, 'Present (+++)'),
(306, 'Present (++++)'),
(307, 'None Seen'),
(308, 'Present (+)'),
(309, 'Present (++)'),
(310, 'Present (+++)'),
(311, 'Present (++++)'),
(312, 'None Seen'),
(313, 'Occasional'),
(314, 'Present (+)'),
(315, 'Present (++)'),
(316, 'Present (+++)'),
(317, 'Present (++++)'),
(318, 'None Seen'),
(319, 'Present (+)'),
(320, 'Present (++)'),
(321, 'Present (+++)'),
(322, 'Present (++++)'),
(323, 'None Seen'),
(324, 'Occasional'),
(325, 'Positive (+)'),
(326, 'Positive (++)'),
(327, 'Positive (+++)'),
(328, 'Positive (++++)'),
(329, 'None Seen'),
(330, 'Occasional'),
(331, 'Present (+)'),
(332, 'Present (++)'),
(333, 'Present (+++)'),
(334, 'Present (++++)'),
(335, 'None Seen'),
(336, 'Occasional'),
(337, 'Present (+)'),
(338, 'Present (++)'),
(339, 'Present (+++)'),
(340, 'Present (++++)'),
(341, 'None Seen'),
(342, 'Occasional'),
(343, 'Present (+)'),
(344, 'Present (++)'),
(345, 'Present (+++)'),
(346, 'Present (++++)'),
(347, 'None Seen'),
(348, 'Occasional'),
(349, 'Present (+)'),
(350, 'Present (++)'),
(351, 'Present (+++)'),
(352, 'Present (++++)'),
(353, 'None Seen'),
(354, 'Occasional'),
(355, 'Present (+)'),
(356, 'Present (++)'),
(357, 'Present (+++)'),
(358, 'Present (++++)'),
(359, 'None Seen'),
(360, 'Occasional'),
(361, 'Present (+)'),
(362, 'Present (++)'),
(363, 'Present (+++)'),
(364, 'Present (++++)'),
(365, 'None Seen'),
(366, 'Occasional'),
(367, 'Present (+)'),
(368, 'Present (++)'),
(369, 'Present (+++)'),
(370, 'Present (++++)'),
(371, 'None Seen'),
(372, 'Occasional'),
(373, 'Present (+)'),
(374, 'Present (++)'),
(375, 'Present (+++)'),
(376, 'Present (++++)'),
(377, 'None Seen'),
(378, 'Occasional'),
(379, 'Present (+)'),
(380, 'Present (++)'),
(381, 'Present (+++)'),
(382, 'Present (++++)'),
(383, 'None Seen'),
(384, 'Occasional'),
(385, 'Present (+)'),
(386, 'Present (++)'),
(387, 'Present (+++)'),
(388, 'Present (++++)'),
(389, 'None Seen'),
(390, 'Occasional'),
(391, 'Positive (+)'),
(392, 'Positive (++)'),
(393, 'Positive (+++)'),
(394, 'Positive (++++)'),
(395, 'None Seen'),
(396, 'Occasional'),
(397, 'Present (+)'),
(398, 'Present (++)'),
(399, 'Present (+++)'),
(400, 'Present (++++)'),
(401, 'None Seen'),
(402, 'Occasional'),
(403, 'Positive (+)'),
(404, 'Positive (++)'),
(405, 'Positive (+++)'),
(406, 'Positive (++++)'),
(407, 'None Seen'),
(408, 'Occasional'),
(409, 'Positive (+)'),
(410, 'Positive (++)'),
(411, 'Positive (+++)'),
(412, 'Positive (++++)'),
(413, 'None Seen'),
(414, 'Occasional'),
(415, 'Positive (+)'),
(416, 'Positive (++)'),
(417, 'Positive (+++)'),
(418, 'Positive (++++)'),
(419, 'None Seen'),
(420, 'Occasional'),
(421, 'Present (+)'),
(422, 'Present (++)'),
(423, 'Present (+++)'),
(424, 'Present (++++)'),
(425, 'None Seen'),
(426, 'Occasional'),
(427, 'Positive (+)'),
(428, 'Positive (++)'),
(429, 'Positive (+++)'),
(430, 'Positive (++++)'),
(431, 'None Seen'),
(432, 'Occasional'),
(433, 'Present (+)'),
(434, 'Present (++)'),
(435, 'Present (+++)'),
(436, 'Present (++++)'),
(437, 'None Seen'),
(438, 'Occasional'),
(439, 'Present (+)'),
(440, 'Present (++)'),
(441, 'Present (+++)'),
(442, 'Present (++++)'),
(443, 'None Seen'),
(444, 'Occasional'),
(445, 'Present (+)'),
(446, 'Present (++)'),
(447, 'Present (+++)'),
(448, 'Present (++++)'),
(449, 'None Seen'),
(450, 'Occasional'),
(451, 'Present (+)'),
(452, 'Present (++)'),
(453, 'Present (+++)'),
(454, 'Present (++++)'),
(455, 'None Seen'),
(456, 'Occasional'),
(457, 'Present (+)'),
(458, 'Present (++)'),
(459, 'Present (+++)'),
(460, 'Present (++++)'),
(461, 'None Seen'),
(462, 'Occasional'),
(463, 'Present (+)'),
(464, 'Present (++)'),
(465, 'Present (+++)'),
(466, 'Present (++++)'),
(467, 'None Seen'),
(468, 'Occasional'),
(469, 'Present (+)'),
(470, 'Present (++)'),
(471, 'Present (+++)'),
(472, 'Present (++++)'),
(473, 'None Seen'),
(474, 'Occasional'),
(475, 'Present (+)'),
(476, 'Present (++)'),
(477, 'Present (+++)'),
(478, 'Present (++++)'),
(479, 'None Seen'),
(480, 'Occasional'),
(481, 'Present (+)'),
(482, 'Present (++)'),
(483, 'Present (+++)'),
(484, 'Present (++++)'),
(485, 'None Seen'),
(486, 'Occasional'),
(487, 'Present (+)'),
(488, 'Present (++)'),
(489, 'Present (+++)'),
(490, 'Present (++++)'),
(491, 'None Seen'),
(492, 'Occasional'),
(493, 'Present (+)'),
(494, 'Present (++)'),
(495, 'Present (+++)'),
(496, 'Present (++++)'),
(497, 'None Seen'),
(498, 'Occasional'),
(499, 'Present (+)'),
(500, 'Present (++)'),
(501, 'Present (+++)'),
(502, 'Present (++++)'),
(503, 'None Seen'),
(504, 'Occasional'),
(505, 'Present (+)'),
(506, 'Present (++)'),
(507, 'Present (+++)'),
(508, 'Present (++++)'),
(509, 'None Seen'),
(510, 'Occasional'),
(511, 'Present (+)'),
(512, 'Present (++)'),
(513, 'Present (+++)'),
(514, 'Present (++++)'),
(515, 'None Seen'),
(516, 'Present (+)'),
(517, 'Present (++)'),
(518, 'Present (+++)'),
(519, 'Present (++++)'),
(520, 'None Seen'),
(521, 'Occasional'),
(522, 'Present (+)'),
(523, 'Present (++)'),
(524, 'Present (+++)'),
(525, 'Present (++++)'),
(553, 'Present (++)'),
(552, 'Present (+)'),
(551, 'Occasional'),
(550, 'None Seen'),
(549, 'Present (++++)'),
(548, 'Present (+++)'),
(547, 'Present (++)'),
(546, 'Present (+)'),
(545, 'Occasional'),
(544, 'None Seen'),
(538, 'None Seen'),
(539, 'Occasional'),
(540, 'Present (+)'),
(541, 'Present (++)'),
(542, 'Present (+++)'),
(543, 'Present (++++)'),
(554, 'Present (+++)'),
(555, 'Present (++++)'),
(556, 'None Seen'),
(557, 'Occasional'),
(558, 'Present (+)'),
(559, 'Present (++)'),
(560, 'Present (+++)'),
(561, 'Present (++++)'),
(562, 'None Seen'),
(563, 'Occasional'),
(564, 'Present (+)'),
(565, 'Present (++)'),
(566, 'Present (+++)'),
(567, 'Present (++++)'),
(568, 'None Seen'),
(569, 'Occasional'),
(570, 'Present (+)'),
(571, 'Present (++)'),
(572, 'Present (+++)'),
(573, 'Present (++++)'),
(574, 'None Seen'),
(575, 'Occasional'),
(576, 'Present (+)'),
(577, 'Present (++)'),
(578, 'Present (+++)'),
(579, 'Present (++++)'),
(580, 'None Seen'),
(581, 'Occasional'),
(582, 'Present (+)'),
(583, 'Present (++)'),
(584, 'Present (+++)'),
(585, 'Present (++++)'),
(586, 'None Seen'),
(587, 'Occasional'),
(588, 'Present (+)'),
(589, 'Present (++)'),
(590, 'Present (+++)'),
(591, 'Present (++++)'),
(592, 'None Seen'),
(593, 'Occasional'),
(594, 'Present (+)'),
(595, 'Present (++)'),
(596, 'Present (+++)'),
(597, 'Present (++++)'),
(598, 'None Seen'),
(599, 'Occasional'),
(600, 'Present (+)'),
(601, 'Present (++)'),
(602, 'Present (+++)'),
(603, 'Present (++++)'),
(604, 'None Seen'),
(605, 'Occasional'),
(606, 'Present (+)'),
(607, 'Present (++)'),
(608, 'Present (+++)'),
(609, 'Present (++++)'),
(610, 'None Seen'),
(611, 'Present (+)'),
(612, 'Present (++)'),
(613, 'Present (+++)'),
(614, 'Present (++++)'),
(615, 'None Seen'),
(616, 'Occasional'),
(617, 'Present (+)'),
(618, 'Present (++)'),
(619, 'Present (+++)'),
(620, 'Present (++++)'),
(621, 'None Seen'),
(622, 'Occasional'),
(623, 'Present (+)'),
(624, 'Present (++)'),
(625, 'Present (+++)'),
(626, 'Present (++++)'),
(627, 'None Seen'),
(628, 'Occasional'),
(629, 'Present (+)'),
(630, 'Present (++)'),
(631, 'Present (+++)'),
(632, 'Present (++++)'),
(633, 'None Seen'),
(634, 'Occasional'),
(635, 'Present (+)'),
(636, 'Present (++)'),
(637, 'Present (+++)'),
(638, 'Present (++++)'),
(639, 'None Seen'),
(640, 'Occasional'),
(641, 'Present (+)'),
(642, 'Present (++)'),
(643, 'Present (+++)'),
(644, 'Present (++++)'),
(645, 'None Seen'),
(646, 'Present (+)'),
(647, 'Present (++)'),
(648, 'Present (+++)'),
(649, 'Present (++++)'),
(650, 'None Seen'),
(651, 'Occasional'),
(652, 'Present (+)'),
(653, 'Present (++)'),
(654, 'Present (+++)'),
(655, 'Present (++++)'),
(656, 'None Seen'),
(657, 'Occasional'),
(658, 'Present (+)'),
(659, 'Present (++)'),
(660, 'Present (+++)'),
(661, 'Present (++++)'),
(662, 'None Seen'),
(663, 'Occasional'),
(664, 'Present (+)'),
(665, 'Present (++)'),
(666, 'Present (+++)'),
(667, 'Present (++++)'),
(668, 'None Seen'),
(669, 'Occasional'),
(670, 'Present (+)'),
(671, 'Present (++)'),
(672, 'Present (+++)'),
(673, 'Present (++++)'),
(674, 'None Seen'),
(675, 'Occasional'),
(676, 'Present (+)'),
(677, 'Present (++)'),
(678, 'Present (+++)'),
(679, 'Present (++++)'),
(680, 'None Seen'),
(681, 'Occasional'),
(682, 'Present (+)'),
(683, 'Present (++)'),
(684, 'Present (+++)'),
(685, 'Present (++++)'),
(686, 'None Seen'),
(687, 'Occasional'),
(688, 'Present (+)'),
(689, 'Present (++)'),
(690, 'Present (+++)'),
(691, 'Present (++++)'),
(692, 'None Seen'),
(693, 'Occasional'),
(694, 'Present (+)'),
(695, 'Present (++)'),
(696, 'Present (+++)'),
(697, 'Present (++++)'),
(698, 'None Seen'),
(699, 'Occasional'),
(700, 'Present (+)'),
(701, 'Present (++)'),
(702, 'Present (+++)'),
(703, 'Present (++++)'),
(704, 'None Seen'),
(705, 'Occasional'),
(706, 'Present (+)'),
(707, 'Present (++)'),
(708, 'Present (+++)'),
(709, 'Present (++++)'),
(710, 'None Seen'),
(711, 'Occasional'),
(712, 'Present (+)'),
(713, 'Present (++)'),
(714, 'Present (+++)'),
(715, 'Present (++++)'),
(716, 'None Seen'),
(717, 'Occasional'),
(718, 'Present (+)'),
(719, 'Present (++)'),
(720, 'Present (+++)'),
(721, 'Present (++++)'),
(722, 'None Seen'),
(723, 'Occasional'),
(724, 'Present (+)'),
(725, 'Present (++)'),
(726, 'Present (+++)'),
(727, 'Present (++++)'),
(728, 'None Seen'),
(729, 'Occasional'),
(730, 'Present (+)'),
(731, 'Present (++)'),
(732, 'Present (+++)'),
(733, 'Present (++++)'),
(734, 'None Seen'),
(735, 'Occasional'),
(736, 'Present (+)'),
(737, 'Present (++)'),
(738, 'Present (+++)'),
(739, 'Present (++++)'),
(752, 'Complete After One Hour'),
(753, 'Partially After One Hour'),
(754, 'Opaque / Greyish'),
(755, 'Highly Viscid'),
(756, 'Partially Viscid'),
(757, 'Non Viscid'),
(758, 'Non Reactive'),
(759, 'Reactive'),
(760, 'No MP`s Seen'),
(761, 'MP`s Present (+)'),
(762, 'MP`s Present (++)'),
(763, 'MP`s Present (+++)'),
(764, 'MP`s Present (++++)'),
(765, 'Negative'),
(766, 'Positive'),
(767, 'Positive'),
(768, 'Negative'),
(769, 'Negative'),
(770, 'Positive'),
(771, 'A Rhesus (D) Positve '),
(772, 'B Rhesus (D) Positive'),
(773, 'AB Rhesus (D) Positve'),
(774, 'O Rhesus (D) Positive'),
(775, 'A Rhesus (D) Negative'),
(776, 'B Rhesus (D) Negative'),
(777, 'AB Rhesus (D) Negative'),
(778, 'O Rhesus (D) Negative'),
(779, 'No Defect'),
(780, 'Partial Defect'),
(781, 'Full Defect'),
(782, 'Full Defect'),
(783, 'Partial Defect'),
(784, 'No Defect'),
(785, 'Negative'),
(786, 'Positive'),
(787, 'Non Reactive'),
(788, 'Reactive'),
(789, 'Negative'),
(790, 'Positive'),
(791, 'Positive'),
(792, 'Negative'),
(793, 'Negative'),
(794, 'Positive'),
(795, 'Negative'),
(796, 'Positive'),
(797, 'Negative'),
(798, 'Positive'),
(799, 'Negative at 1/20'),
(800, 'Negative at 1/40'),
(801, 'Positive at 1/80'),
(802, 'Positve at 1/160'),
(803, 'Positve at 1/320'),
(804, 'Negative at 1/20'),
(805, 'Negative at 1/40'),
(806, 'Positive at 1/80'),
(807, 'Positive at 1/160'),
(808, 'Positive at 1/320'),
(809, 'Negative'),
(810, 'Positive'),
(811, 'Negative'),
(812, 'Positive'),
(813, 'Equivocal'),
(814, 'Negative'),
(815, 'Positive'),
(816, 'Equivocal'),
(817, 'None Seen'),
(818, 'Present (+)'),
(819, 'Present (++)'),
(820, 'Present (+++)'),
(821, 'None Seen'),
(822, 'Present (+)'),
(823, 'Present (++)'),
(824, 'Present (+++)'),
(825, 'None Seen'),
(826, 'Present (+)'),
(827, 'Present (++)'),
(828, 'Present (+++)'),
(829, 'None Seen'),
(830, 'Present (+)'),
(831, 'Present (++)'),
(832, 'Present (+++)'),
(833, 'None Seen'),
(834, 'Present (+)'),
(835, 'Present (++)'),
(836, 'Present (+++)'),
(837, 'None Seen'),
(838, 'Present (+)'),
(839, 'Present (++)'),
(840, 'Present (+++)'),
(841, 'Absent'),
(842, 'Present'),
(843, 'Clear'),
(844, 'Slightly Cloudy'),
(845, 'Cloudy'),
(846, 'Bloody'),
(847, 'Colourless'),
(848, 'Straw'),
(849, 'Light Amber'),
(850, 'Amber'),
(851, 'Deep Amber'),
(852, 'Reddish'),
(853, 'Yellowish'),
(854, '5.0'),
(855, '6.0'),
(856, '6.5'),
(857, '7.0'),
(858, '8.0'),
(859, '9.0'),
(860, '1.000'),
(861, '1.005'),
(862, '1.010'),
(863, '1.015'),
(864, '1.020'),
(865, '1.025'),
(866, '1.030'),
(867, 'Negative'),
(868, 'Trace'),
(869, 'Positive (+)'),
(870, 'Positive (++)'),
(871, 'Positive (+++)'),
(872, 'Positive (++++)'),
(873, 'Negative'),
(874, 'Trace'),
(875, 'Positive (+)'),
(876, 'Positive (++)'),
(877, 'Positive (+++)'),
(878, 'Positive (++++)'),
(879, 'Negative'),
(880, 'Trace'),
(881, 'Positive (+)'),
(882, 'Positive (++)'),
(883, 'Positive (+++)'),
(884, 'Positive (++++)'),
(885, 'Negative'),
(886, 'Trace'),
(887, 'Positive (+)'),
(888, 'Positive (++)'),
(889, 'Positive (+++)'),
(890, 'Positive (++++)'),
(891, 'Negative'),
(892, 'Trace'),
(893, 'Positive (+)'),
(894, 'Positive (++)'),
(895, 'Positive (+++)'),
(896, 'Positive (++++)'),
(897, 'Negative'),
(898, 'Positive'),
(899, 'Negative'),
(900, 'Trace'),
(901, 'Positive (+)'),
(902, 'Positive (++)'),
(903, 'Positive (+++)'),
(904, 'Positive (++++)'),
(905, 'Normal'),
(906, 'Trace'),
(907, 'Positive (+)'),
(908, 'Positive (++)'),
(909, 'Positive (+++)'),
(910, 'Positive (++++)'),
(911, 'None Seen'),
(912, '1'),
(913, '2'),
(914, '3'),
(915, '4'),
(916, '5'),
(917, '6'),
(918, '7'),
(919, '8'),
(920, '9'),
(921, '10'),
(922, '>15'),
(923, 'None Seen'),
(924, '1'),
(925, '2'),
(926, '3'),
(927, '4'),
(928, '5'),
(929, '6'),
(930, '7'),
(931, '8'),
(932, '9'),
(933, '10'),
(934, '>15'),
(935, 'None Seen'),
(936, '1'),
(937, '2'),
(938, '3'),
(939, '4'),
(940, '5'),
(941, '6'),
(942, '7'),
(943, '8'),
(944, '9'),
(945, '10 - 20'),
(946, '>20'),
(947, 'None Seen'),
(948, '1'),
(949, '2'),
(950, '3'),
(951, '4'),
(952, '5'),
(953, '6'),
(954, '7'),
(955, '8'),
(956, '9'),
(957, '10 - 20'),
(958, '>20'),
(959, 'None Seen'),
(960, '1'),
(961, '2'),
(962, '3'),
(963, '4'),
(964, '5'),
(965, '6'),
(966, '7'),
(967, '8'),
(968, '9'),
(969, '>15'),
(970, '10 - 20'),
(971, '9'),
(972, '8'),
(973, '7'),
(974, '6'),
(975, '5'),
(976, '4'),
(977, '3'),
(978, '2'),
(979, '1'),
(980, 'None Seen'),
(981, '>20'),
(982, 'None Seen'),
(983, '1'),
(984, '2'),
(985, '3'),
(986, '4'),
(987, '5'),
(988, '6'),
(989, '7'),
(990, '8'),
(991, '9'),
(992, '10 - 20'),
(993, '>20'),
(994, 'None Seen'),
(995, 'Present (+)'),
(996, 'Present (++)'),
(997, 'Present (+++)'),
(998, 'Positive (++++)'),
(999, 'None Seen'),
(1000, 'Present (+)'),
(1001, 'Present (++)'),
(1002, 'Present (+++)'),
(1003, 'Positive (++++)'),
(1004, 'None Seen'),
(1005, 'Present (+)'),
(1006, 'Present (++)'),
(1007, 'Present (+++)'),
(1008, 'Positive (++++)'),
(1009, 'None Seen'),
(1010, 'Present (+)'),
(1011, 'Present (++)'),
(1012, 'Present (+++)'),
(1013, 'Positive (++++)'),
(1014, 'None Seen'),
(1015, 'Present (+)'),
(1016, 'Present (++)'),
(1017, 'Positive (+++)'),
(1018, 'Positive (++++)'),
(1019, 'None Seen'),
(1020, 'Present (+)'),
(1021, 'Present (++)'),
(1022, 'Present (+++)'),
(1023, 'Positive (++++)'),
(1024, 'Semi-formed Specimen '),
(1025, 'Formed Specimen'),
(1026, 'Loose Specimen'),
(1027, 'Watery Specimen'),
(1028, 'Mucoid Specimen'),
(1029, 'Bloody Specimen'),
(1030, 'None Seen'),
(1031, '1'),
(1032, '2'),
(1033, '3'),
(1034, '4'),
(1035, '5'),
(1036, '6'),
(1037, '7'),
(1038, '8'),
(1039, '9'),
(1040, '10 - 20'),
(1041, '>20'),
(1042, 'None Seen'),
(1043, '1'),
(1044, '2'),
(1045, '3'),
(1046, '4'),
(1047, '5'),
(1048, '6'),
(1049, '7'),
(1050, '8'),
(1051, '9'),
(1052, '10 - 20'),
(1053, '>20'),
(1054, 'None Seen'),
(1055, 'Present'),
(1056, 'Clear'),
(1057, 'Slightly Cloudy'),
(1058, 'Cloudy'),
(1059, 'Bloody'),
(1060, 'Colourless'),
(1061, 'Straw'),
(1062, 'Light Amber'),
(1063, 'Amber'),
(1064, 'Deep Amber'),
(1065, 'Reddish'),
(1066, 'Yellowish'),
(1067, 'Negative'),
(1068, 'Trace'),
(1069, 'Positive (+)'),
(1070, 'Positive (++)'),
(1071, 'Positive (+++)'),
(1072, 'Positive (++++)'),
(1073, 'Negative'),
(1074, 'Trace'),
(1075, 'Positive (+)'),
(1076, 'Positive (++)'),
(1077, 'Positive (+++)'),
(1078, 'Positive (++++)'),
(1079, 'Negative'),
(1080, 'Trace'),
(1081, 'Positive (+)'),
(1082, 'Positive (++)'),
(1083, 'Positive (+++)'),
(1084, 'Positive (+++)'),
(1085, 'Positive (++)'),
(1086, 'Positive (+)'),
(1087, 'Trace'),
(1088, 'Negative'),
(1089, 'Positive (++++)'),
(1090, 'Negative'),
(1091, 'Trace'),
(1092, 'Positive (+)'),
(1093, 'Positive (++)'),
(1094, 'Positive (+++)'),
(1095, 'Positive (++++)'),
(1096, 'Negative'),
(1097, 'Positive (+)'),
(1098, 'Positive (++)'),
(1099, 'Positive (+++)'),
(1100, 'Positive (++++)'),
(1101, 'Normal'),
(1102, 'Trace'),
(1103, 'Positive (+)'),
(1104, 'Positive (++)'),
(1105, 'Positive (+++)'),
(1106, 'Positive (++++)'),
(1107, 'None Seen'),
(1108, '1'),
(1109, '2'),
(1110, '3'),
(1111, '4'),
(1112, '5'),
(1113, '6'),
(1114, '7'),
(1115, '8'),
(1116, '9'),
(1117, '10 - 20'),
(1118, '>20'),
(1119, 'None Seen'),
(1120, '1'),
(1121, '2'),
(1122, '3'),
(1123, '4'),
(1124, '5'),
(1125, '6'),
(1126, '7'),
(1127, '8'),
(1128, '9'),
(1129, '10 - 20'),
(1130, '>20'),
(1131, 'None Seen'),
(1132, '1'),
(1133, '2'),
(1134, '3'),
(1135, '4'),
(1136, '5'),
(1137, '6'),
(1138, '7'),
(1139, '8'),
(1140, '9'),
(1141, '10 - 20'),
(1142, '>20'),
(1143, 'None Seen'),
(1144, 'Present (+)'),
(1145, 'Present (++)'),
(1146, 'Present (+++)'),
(1147, 'Present (++++)'),
(1148, 'None Seen'),
(1149, 'Present (+)'),
(1150, 'Present (++)'),
(1151, 'Present (+++)'),
(1152, 'Present (++++)'),
(1153, 'Semi-formed Specimen'),
(1154, 'Formed Specimen'),
(1155, 'Loose Specimen'),
(1156, 'Watery Specimen'),
(1157, 'Bloody Specimen'),
(1158, 'Mucoid Specimen'),
(1159, 'None Seen'),
(1160, '1'),
(1161, '2'),
(1162, '3'),
(1163, '4'),
(1164, '5'),
(1165, '6'),
(1166, '7'),
(1167, '8'),
(1168, '9'),
(1169, '10 - 20'),
(1170, '>20'),
(1171, 'None Seen'),
(1172, '1'),
(1173, '2'),
(1174, '3'),
(1175, '4'),
(1176, '5'),
(1177, '6'),
(1178, '7'),
(1179, '8'),
(1180, '9'),
(1181, '10 - 20'),
(1182, '>20'),
(1183, 'Absent'),
(1184, 'Present'),
(1185, 'None Seen'),
(1186, 'Scanty'),
(1187, 'Present (+)'),
(1188, 'Present (++)'),
(1189, 'Present (+++)'),
(1190, 'Present (++++)'),
(1191, 'None Seen'),
(1192, 'Scanty'),
(1193, 'Present (+)'),
(1194, 'Present (++)'),
(1195, 'Present (+++)'),
(1196, 'Present (++++)'),
(1197, 'None Seen'),
(1198, 'Present (+)'),
(1199, 'Present (++)'),
(1200, 'Present (+++)'),
(1201, 'Present (++++)'),
(1202, 'Scanty'),
(1203, 'None Seen'),
(1204, 'Scanty'),
(1205, 'Present (+)'),
(1206, 'Present (++)'),
(1207, 'Present (+++)'),
(1208, 'Present (++++)'),
(1209, 'None Seen'),
(1210, 'Present (+)'),
(1211, 'Present (++)'),
(1212, 'Present (+++)'),
(1213, 'Present (++++)'),
(1214, 'Scanty'),
(1215, 'None Seen'),
(1216, 'Scanty'),
(1217, 'Positive (+)'),
(1218, 'Positive (++)'),
(1219, 'Positive (+++)'),
(1220, 'Positive (++++)'),
(1221, 'None Seen'),
(1222, 'Scanty'),
(1223, 'Present (+)'),
(1224, 'Present (++)'),
(1225, 'Present (+++)'),
(1226, 'Present (++++)'),
(1227, 'None Seen'),
(1228, 'Scanty'),
(1229, 'Present (+)'),
(1230, 'Present (++)'),
(1231, 'Present (+++)'),
(1232, 'Present (++++)'),
(1233, 'None Seen'),
(1234, 'Scanty'),
(1235, 'Present (+)'),
(1236, 'Present (++)'),
(1237, 'Present (+++)'),
(1238, 'Present (++++)'),
(1239, 'None Seen'),
(1240, 'Scanty'),
(1241, 'Present (+)'),
(1242, 'Present (++)'),
(1243, 'Present (+++)'),
(1244, 'Present (++++)'),
(1245, 'None Seen'),
(1246, 'Scanty'),
(1247, 'Present (+)'),
(1248, 'Present (++)'),
(1249, 'Present (+++)'),
(1250, 'Present (++++)'),
(1251, 'None Seen'),
(1252, 'Scanty'),
(1253, 'Present (+)'),
(1254, 'Present (++)'),
(1255, 'Present (+++)'),
(1256, 'Present (++++)'),
(1257, 'None Seen'),
(1258, 'Scanty'),
(1259, 'Present (+)'),
(1260, 'Present (++)'),
(1261, 'Present (+++)'),
(1262, 'Present (++++)'),
(1263, 'None Seen'),
(1264, 'Scanty'),
(1265, 'Present (+)'),
(1266, 'Present (++)'),
(1267, 'Present (+++)'),
(1268, 'Present (++++)'),
(1269, 'None Seen'),
(1270, 'Scanty'),
(1271, 'Present (+)'),
(1272, 'Present (++)'),
(1273, 'Present (+++)'),
(1274, 'Present (++++)'),
(1275, 'None Seen'),
(1276, 'Scanty'),
(1277, 'Present (+)'),
(1278, 'Present (++)'),
(1279, 'Present (+++)'),
(1280, 'Present (++++)'),
(1281, 'None Seen'),
(1282, 'Scanty'),
(1283, 'Present (+)'),
(1284, 'Present (++)'),
(1285, 'Present (+++)'),
(1286, 'Present (++++)'),
(1287, 'None Seen'),
(1288, 'Scanty'),
(1289, 'Present (+)'),
(1290, 'Present (++)'),
(1291, 'Present (+++)'),
(1292, 'Present (++++)'),
(1299, 'None Seen'),
(1300, 'Scanty'),
(1301, 'Present (+)'),
(1302, 'Present (++)'),
(1303, 'Present (+++)'),
(1304, 'Present (++++)'),
(1305, 'None Seen'),
(1306, 'Scanty'),
(1307, 'Present (+)'),
(1308, 'Present (++)'),
(1309, 'Present (+++)'),
(1310, 'Present (++++)'),
(1311, 'None Seen'),
(1312, 'Scanty'),
(1313, 'Present (+)'),
(1314, 'Present (++)'),
(1315, 'Present (+++)'),
(1316, 'Present (++++)'),
(1317, 'None Seen'),
(1318, 'Scanty'),
(1319, 'Present (+)'),
(1320, 'Present (++)'),
(1321, 'Present (+++)'),
(1322, 'Present (++++)'),
(1323, 'None Seen'),
(1324, 'Scanty'),
(1325, 'Present (+)'),
(1326, 'Present (++)'),
(1327, 'Present (+++)'),
(1328, 'Present (++++)'),
(1329, 'None Seen'),
(1330, 'Scanty'),
(1331, 'Present (+)'),
(1332, 'Present (++)'),
(1333, 'Present (+++)'),
(1334, 'Present (++++)'),
(1335, 'None Seen'),
(1336, 'Scanty'),
(1337, 'Present (+)'),
(1338, 'Present (++)'),
(1339, 'Present (+++)'),
(1340, 'Present (++++)'),
(1341, 'None Seen'),
(1342, 'Present (+)'),
(1343, 'Present (++)'),
(1344, 'Present (+++)'),
(1345, 'Present (++++)'),
(1346, 'Scanty'),
(1347, 'None Seen'),
(1348, 'Scanty'),
(1349, 'Present (+)'),
(1350, 'Present (++)'),
(1351, 'Present (+++)'),
(1352, 'Present (++++)'),
(1353, 'None Seen'),
(1354, 'Scanty'),
(1355, 'Present (+)'),
(1356, 'Present (++)'),
(1357, 'Present (+++)'),
(1358, 'Present (++++)'),
(1359, 'None Seen'),
(1360, 'Scanty'),
(1361, 'Present (+)'),
(1362, 'Present (++)'),
(1363, 'Present (+++)'),
(1364, 'Present (++++)'),
(1365, 'None Seen'),
(1366, 'Scanty'),
(1367, 'Present (+)'),
(1368, 'Present (++)'),
(1369, 'Present (+++)'),
(1370, 'Present (++++)'),
(1371, 'None Seen'),
(1372, 'Scanty'),
(1373, 'Present (+)'),
(1374, 'Present (++)'),
(1375, 'Present (+++)'),
(1376, 'Present (++++)'),
(1377, 'None Seen'),
(1378, 'Scanty'),
(1379, 'Present (+)'),
(1380, 'Present (++)'),
(1381, 'Present (+++)'),
(1382, 'Present (++++)'),
(1383, 'None Seen'),
(1384, 'Present (+)'),
(1385, 'Present (++)'),
(1386, 'Present (+++)'),
(1387, 'Present (++++)'),
(1388, 'Scanty'),
(1389, 'None Seen'),
(1390, 'Scanty'),
(1391, 'Present (+)'),
(1392, 'Present (++)'),
(1393, 'Present (+++)'),
(1394, 'Present (++++)'),
(1395, 'None Seen'),
(1396, 'Scanty'),
(1397, 'Present (+)'),
(1398, 'Present (++)'),
(1399, 'Present (+++)'),
(1400, 'Present (++++)'),
(1401, 'None Seen'),
(1402, 'Scanty'),
(1403, 'Present (+)'),
(1404, 'Present (++)'),
(1405, 'Present (+++)'),
(1406, 'Present (++++)'),
(1407, 'None Seen'),
(1408, 'Scanty'),
(1409, 'Present (+)'),
(1410, 'Present (++)'),
(1411, 'Present (+++)'),
(1412, 'Present (++++)'),
(1413, 'None Seen'),
(1414, 'Scanty'),
(1415, 'Present (+)'),
(1416, 'Present (++)'),
(1417, 'Present (+++)'),
(1418, 'Present (++++)'),
(1419, 'None Seen'),
(1420, 'Scanty'),
(1421, 'Present (+)'),
(1422, 'Present (++)'),
(1423, 'Present (+++)'),
(1424, 'Present (++++)'),
(1425, 'None Seen'),
(1426, 'Scanty'),
(1427, 'Present (+)'),
(1428, 'Present (++)'),
(1429, 'Present (+++)'),
(1430, 'Present (++++)'),
(1431, 'None Seen'),
(1432, 'Scanty'),
(1433, 'Present (+)'),
(1434, 'Present (++)'),
(1435, 'Present (+++)'),
(1436, 'Present (++++)'),
(1437, 'None Seen'),
(1438, 'Scanty'),
(1439, 'Present (+)'),
(1440, 'Present (++)'),
(1441, 'Present (+++)'),
(1442, 'Present (++++)'),
(1443, 'None Seen'),
(1444, 'Scanty'),
(1445, 'Present (+)'),
(1446, 'Present (++)'),
(1447, 'Present (+++)'),
(1448, 'Present (++++)'),
(1449, 'None Seen'),
(1450, 'Scanty'),
(1451, 'Present (+)'),
(1452, 'Present (++)'),
(1453, 'Present (+++)'),
(1454, 'Present (++++)'),
(1455, 'None Seen'),
(1456, 'Scanty'),
(1457, 'Present (+)'),
(1458, 'Present (++)'),
(1459, 'Present (+++)'),
(1460, 'Present (++++)'),
(1461, 'None Seen'),
(1462, 'Scanty'),
(1463, 'Present (+)'),
(1464, 'Present (++)'),
(1465, 'Present (+++)'),
(1466, 'Present (++++)'),
(1467, 'None Seen'),
(1468, 'Scanty'),
(1469, 'Present (+)'),
(1470, 'Present (++)'),
(1471, 'Present (+++)'),
(1472, 'Present (++++)'),
(1473, 'None Seen'),
(1474, 'Scanty'),
(1475, 'Present (+)'),
(1476, 'Present (++)'),
(1477, 'Present (+++)'),
(1478, 'Present (++++)'),
(1479, 'None Seen'),
(1480, 'Scanty'),
(1481, 'Present (+)'),
(1482, 'Present (++)'),
(1483, 'Present (+++)'),
(1484, 'Present (++++)'),
(1485, 'None Seen'),
(1486, 'Scanty'),
(1487, 'Positive (+)'),
(1488, 'Positive (++)'),
(1489, 'Positive (+++)'),
(1490, 'Positive (++++)'),
(1491, 'None Seen'),
(1492, 'Scanty'),
(1493, 'Present (+)'),
(1494, 'Present (++)'),
(1495, 'Present (+++)'),
(1496, 'Present (++++)'),
(1497, 'None Seen'),
(1498, 'Scanty'),
(1499, 'Present (+)'),
(1500, 'Present (++)'),
(1501, 'Present (+++)'),
(1502, 'Present (++++)'),
(1503, 'None Seen'),
(1504, 'Scanty'),
(1505, 'Present (+)'),
(1506, 'Present (++)'),
(1507, 'Present (+++)'),
(1508, 'Present (++++)'),
(1509, 'Present (++++)'),
(1510, 'Present (+++)'),
(1511, 'Present (++)'),
(1512, 'Present (+)'),
(1513, 'Scanty'),
(1514, 'None Seen'),
(1515, 'None Seen'),
(1516, 'Scanty'),
(1517, 'Present (+)'),
(1518, 'Present (++)'),
(1519, 'Present (+++)'),
(1520, 'Present (++++)'),
(1521, 'None Seen'),
(1522, 'Scanty'),
(1523, 'Positive (+)'),
(1524, 'Positive (++)'),
(1525, 'Positive (+++)'),
(1526, 'Positive (++++)'),
(1527, 'None Seen'),
(1528, 'Scanty'),
(1529, 'Positive (+)'),
(1530, 'Positive (++)'),
(1531, 'Positive (+++)'),
(1532, 'Positive (++++)'),
(1533, 'None Seen'),
(1534, 'Scanty'),
(1535, 'Positive (+)'),
(1536, 'Positive (++)'),
(1537, 'Positive (+++)'),
(1538, 'Positive (++++)'),
(1539, 'None Seen'),
(1540, 'Scanty'),
(1541, 'Present (+)'),
(1542, 'Present (++)'),
(1543, 'Present (+++)'),
(1544, 'Present (++++)'),
(1545, 'None Seen'),
(1546, 'Scanty'),
(1547, 'Positive (+)'),
(1548, 'Positive (++)'),
(1549, 'Positive (+++)'),
(1550, 'Positive (++++)'),
(1551, 'None Seen'),
(1552, 'Scanty'),
(1553, 'Present (+)'),
(1554, 'Present (++)'),
(1555, 'Present (+++)'),
(1556, 'Present (++++)'),
(1557, 'None Seen'),
(1558, 'Scanty'),
(1559, 'Present (+)'),
(1560, 'Present (++)'),
(1561, 'Present (+++)'),
(1562, 'Present (++++)'),
(1563, 'Present (++++)'),
(1564, 'Present (+++)'),
(1565, 'Present (++)'),
(1566, 'Present (+)'),
(1567, 'Scanty'),
(1568, 'None Seen'),
(1569, 'Present (++++)'),
(1570, 'Present (+++)'),
(1571, 'Present (++)'),
(1572, 'Present (+)'),
(1573, 'Scanty'),
(1574, 'None Seen'),
(1575, 'None Seen'),
(1576, 'Scanty'),
(1577, 'Present (+)'),
(1578, 'Present (++)'),
(1579, 'Present (+++)'),
(1580, 'Present (++++)'),
(1581, 'None Seen'),
(1582, 'Scanty'),
(1583, 'Present (+)'),
(1584, 'Present (++)'),
(1585, 'Present (+++)'),
(1586, 'Present (++++)'),
(1587, 'None Seen'),
(1588, 'Scanty'),
(1589, 'Present (+)'),
(1590, 'Present (++)'),
(1591, 'Present (+++)'),
(1592, 'Present (++++)'),
(1593, 'None Seen'),
(1594, 'Scanty'),
(1595, 'Present (+)'),
(1596, 'Present (++)'),
(1597, 'Present (+++)'),
(1598, 'Present (++++)'),
(1599, 'None Seen'),
(1600, 'Scanty'),
(1601, 'Present (+)'),
(1602, 'Present (++)'),
(1603, 'Present (+++)'),
(1604, 'Present (++++)'),
(1605, 'None Seen'),
(1606, 'Scanty'),
(1607, 'Present (+)'),
(1608, 'Present (++)'),
(1609, 'Present (+++)'),
(1610, 'Present (++++)'),
(1611, 'None Seen'),
(1612, 'Scanty'),
(1613, 'Present (+)'),
(1614, 'Present (++)'),
(1615, 'Present (+++)'),
(1616, 'Present (++++)'),
(1617, 'None Seen'),
(1618, 'Scanty'),
(1619, 'Present (+)'),
(1620, 'Present (++)'),
(1621, 'Positive (+++)'),
(1622, 'Present (++++)'),
(1623, 'None Seen'),
(1624, 'Scanty'),
(1625, 'Present (+)'),
(1626, 'Present (++)'),
(1627, 'Present (+++)'),
(1628, 'Present (++++)'),
(1629, 'None Seen'),
(1630, 'Scanty'),
(1631, 'Present (+)'),
(1632, 'Present (++)'),
(1633, 'Present (+++)'),
(1634, 'Present (++++)'),
(1635, 'MP`s Present (++++)'),
(1636, 'MP`s Present (+++)'),
(1637, 'MP`s Present (++)'),
(1638, 'MP`s Present (+)'),
(1639, 'No MP`s Seen'),
(1640, 'No MP`s Seen'),
(1641, 'MP`s Present (+)'),
(1642, 'MP`s Present (++)'),
(1643, 'MP`s Present (+++)'),
(1644, 'MP`s Present (++++)'),
(1645, 'MP`s Present (++++)'),
(1646, 'MP`s Present (+++)'),
(1647, 'MP`s Present (++)'),
(1648, 'MP`s Present (+)'),
(1649, 'No MP`s Seen'),
(1650, 'No MP`s Seen'),
(1651, 'MP`s Present (+)'),
(1652, 'MP`s Present (++)'),
(1653, 'MP`s Present (+++)'),
(1654, 'MP`s Present (++++)'),
(1655, 'MP`s Present (++++)'),
(1656, 'MP`s Present (+++)'),
(1657, 'MP`s Present (++)'),
(1658, 'MP`s Present (+)'),
(1659, 'No MP`s Seen'),
(1660, 'No MP`s Seen'),
(1661, 'MP`s Present (+)'),
(1662, 'MP`s Present (++)'),
(1663, 'MP`s Present (+++)'),
(1664, 'MP`s Present (++++)'),
(1665, 'Opaque / Greyish'),
(1666, 'Negative'),
(1667, 'Positive'),
(1668, 'Salivary'),
(1669, 'Muco-Salivary'),
(1670, 'Muco-Purulent'),
(1671, 'Purulent'),
(1672, 'No AFB Seen'),
(1673, 'Scanty AFB Seen'),
(1674, 'AFB Present (+)'),
(1675, 'AFB Present (++)'),
(1676, 'AFB Present (+++)'),
(1677, 'AFB Present (++++)'),
(1678, 'Complete After 1 Hour'),
(1679, 'Partially After 1 Hour'),
(1680, 'Liqufied Within 1 Hour'),
(1681, 'Partially After 1 Hour'),
(1682, 'Complete After 1 Hour'),
(1683, 'Liqufied Within an Hour'),
(1684, 'Liqufied Within an Hour'),
(1685, 'Complete After 1 Hour'),
(1686, 'Partially After 1 Hour'),
(1687, 'Opaque / Greyish'),
(1688, 'Light Straw'),
(1689, 'Non-Reactive'),
(1690, 'Reactive'),
(1691, 'Negative'),
(1692, 'Positive'),
(1693, 'Equivocal (Repeat In 7 Days)'),
(1694, 'Negative'),
(1695, 'Positive'),
(1696, 'Equivocal (Repeat In 7 Days)'),
(1697, 'None Seen'),
(1698, 'Present (+)'),
(1699, 'Present (++)'),
(1700, 'Present (+++)'),
(1701, 'None Seen'),
(1702, 'None Seen'),
(1703, 'Present (+)'),
(1704, 'Present (++)'),
(1705, 'Present (+++)'),
(1706, 'None Seen'),
(1707, 'Present (+)'),
(1708, 'Present (++)'),
(1709, 'Present (+++)'),
(1710, 'Present (+++)'),
(1711, 'Present (++)'),
(1712, 'Present (+)'),
(1713, 'None Seen'),
(1714, 'Present (+++)'),
(1715, 'Present (++)'),
(1716, 'Present (+)'),
(1717, 'None Seen'),
(1718, 'Present (+++)'),
(1719, 'Present (++)'),
(1720, 'Present (+)'),
(1721, 'None Seen');

-- --------------------------------------------------------

--
-- Table structure for table `problem_options`
--

CREATE TABLE IF NOT EXISTS `problem_options` (
  `problem_id` int(11) NOT NULL AUTO_INCREMENT,
  `problem_name` varchar(255) NOT NULL,
  PRIMARY KEY (`problem_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `problem_options`
--

INSERT INTO `problem_options` (`problem_id`, `problem_name`) VALUES
(2, 'Headaches'),
(3, 'Vomiting');

-- --------------------------------------------------------

--
-- Table structure for table `procedure`
--

CREATE TABLE IF NOT EXISTS `procedure` (
  `code` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `procedure`
--

INSERT INTO `procedure` (`code`, `description`, `price`) VALUES
('DRESSING 1', 'Dressing Big Wound', 8),
('DRESSING 2', 'Dressing Normal Wound ', 5),
('SUTURING 1', 'Suturing Small Wound', 50),
('SUTURING 3', 'Nebulizing ', 10),
('SUTURING 4', 'Incision & Drainage ', 40),
('SUTURING 5', 'Foreign Body Removal', 8),
('SUTURING 6', 'Avulsion of Nail', 50),
('SUTURING 7', 'Ingrown Nail', 50),
('SUTURING 8', 'ECG', 35),
('SUTURING 9', 'Oxygen Therapy', 0);

-- --------------------------------------------------------

--
-- Table structure for table `procedureorders`
--

CREATE TABLE IF NOT EXISTS `procedureorders` (
  `orderid` int(11) NOT NULL AUTO_INCREMENT,
  `visitid` int(11) NOT NULL,
  `patientid` varchar(100) NOT NULL,
  `total` double NOT NULL,
  `amoutpaid` double NOT NULL,
  `status` varchar(50) NOT NULL,
  `orderdate` datetime NOT NULL,
  `orderedby` varchar(255) NOT NULL,
  `performedby` varchar(255) NOT NULL,
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `procedureorders`
--

INSERT INTO `procedureorders` (`orderid`, `visitid`, `patientid`, `total`, `amoutpaid`, `status`, `orderdate`, `orderedby`, `performedby`) VALUES
(1, 1, '13DC1', 8, 0, 'Cashier', '2013-12-09 04:29:57', 'ClaimSync0001', ''),
(2, 2, '13DC2', 45, 0, 'Cashier', '2013-12-09 07:14:45', 'ClaimSync0005', ''),
(3, 2, '13DC2', 8, 0, 'Cashier', '2013-12-09 07:28:27', 'ClaimSync0001', '');

-- --------------------------------------------------------

--
-- Table structure for table `procedureorderswalkin`
--

CREATE TABLE IF NOT EXISTS `procedureorderswalkin` (
  `orderid` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `total` double NOT NULL,
  `amoutpaid` double NOT NULL,
  `status` varchar(50) NOT NULL,
  `orderdate` datetime NOT NULL,
  `orderedby` varchar(255) NOT NULL,
  `performedby` varchar(255) NOT NULL,
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `procedureorderswalkin`
--


-- --------------------------------------------------------

--
-- Table structure for table `profile`
--

CREATE TABLE IF NOT EXISTS `profile` (
  `profile_id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_description` text NOT NULL,
  `profile_amount` double NOT NULL,
  PRIMARY KEY (`profile_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `profile`
--


-- --------------------------------------------------------

--
-- Table structure for table `profile_details`
--

CREATE TABLE IF NOT EXISTS `profile_details` (
  `detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `lab_id` int(11) NOT NULL,
  PRIMARY KEY (`detail_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `profile_details`
--


-- --------------------------------------------------------

--
-- Table structure for table `purchase_order`
--

CREATE TABLE IF NOT EXISTS `purchase_order` (
  `purchase_order_id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(100) NOT NULL,
  `approved_by_manager` varchar(255) DEFAULT NULL,
  `approved_by_account` varchar(255) DEFAULT NULL,
  `ordering_staff` varchar(255) NOT NULL,
  `date_of_order` date NOT NULL,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY (`purchase_order_id`),
  KEY `approved_by_manager` (`approved_by_manager`),
  KEY `approved_by_account` (`approved_by_account`),
  KEY `ordering_staff` (`ordering_staff`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `purchase_order`
--

INSERT INTO `purchase_order` (`purchase_order_id`, `location`, `approved_by_manager`, `approved_by_account`, `ordering_staff`, `date_of_order`, `status`) VALUES
(1, 'Warehouse', 'ClaimSync0009', 'ClaimSync0009', 'ClaimSync0009', '2013-11-26', 'Submitted');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_order_items`
--

CREATE TABLE IF NOT EXISTS `purchase_order_items` (
  `order_items_id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` int(11) NOT NULL,
  `item_code` varchar(255) NOT NULL,
  `quantity_ordered` int(11) NOT NULL,
  `quantity_delivered` int(11) NOT NULL,
  PRIMARY KEY (`order_items_id`),
  KEY `orderid` (`orderid`),
  KEY `item_code` (`item_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `purchase_order_items`
--

INSERT INTO `purchase_order_items` (`order_items_id`, `orderid`, `item_code`, `quantity_ordered`, `quantity_delivered`) VALUES
(1, 1, 'COARTE', 500, 0),
(2, 1, 'PARAINJE', 1000, 0);

-- --------------------------------------------------------

--
-- Table structure for table `qualification`
--

CREATE TABLE IF NOT EXISTS `qualification` (
  `quid` int(11) NOT NULL AUTO_INCREMENT,
  `qualification` varchar(255) NOT NULL,
  `startyear` varchar(4) DEFAULT NULL,
  `endyear` varchar(4) DEFAULT NULL,
  `institution` varchar(255) NOT NULL,
  `staffid` varchar(255) NOT NULL,
  PRIMARY KEY (`quid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=76 ;

--
-- Dumping data for table `qualification`
--

INSERT INTO `qualification` (`quid`, `qualification`, `startyear`, `endyear`, `institution`, `staffid`) VALUES
(1, 'SHS', '0000', '0000', 'N/A', 'ClaimSync0012'),
(2, 'HND', '0000', '0000', 'N/A', 'ClaimSync0012'),
(3, 'Bachelors', '0000', '0000', 'N/A', 'ClaimSync0012'),
(4, 'Masters', '0000', '0000', 'N/A', 'ClaimSync0012'),
(5, 'Doctorate', '0000', '0000', 'N/A', 'ClaimSync0012'),
(6, 'SHS', '0000', '0000', 'N/A', 'N/A'),
(7, 'HND', '0000', '0000', 'N/A', 'N/A'),
(8, 'Bachelors', '0000', '0000', 'N/A', 'N/A'),
(9, 'Masters', '0000', '0000', 'N/A', 'N/A'),
(10, 'Doctorate', '0000', '0000', 'N/A', 'N/A'),
(11, 'SHS', '0000', '0000', 'N/A', 'Danpong001'),
(12, 'HND', '0000', '0000', 'N/A', 'Danpong001'),
(13, 'Bachelors', '0000', '0000', 'N/A', 'Danpong001'),
(14, 'Masters', '0000', '0000', 'N/A', 'Danpong001'),
(15, 'Doctorate', '0000', '0000', 'N/A', 'Danpong001'),
(16, 'SHS', '0000', '0000', 'N/A', 'Danpong002'),
(17, 'HND', '0000', '0000', 'N/A', 'Danpong002'),
(18, 'Bachelors', '0000', '0000', 'N/A', 'Danpong002'),
(19, 'Masters', '0000', '0000', 'N/A', 'Danpong002'),
(20, 'Doctorate', '0000', '0000', 'N/A', 'Danpong002'),
(21, 'SHS', '0000', '0000', 'N/A', 'ClaimSync007'),
(22, 'HND', '0000', '0000', 'N/A', 'ClaimSync007'),
(23, 'Bachelors', '0000', '0000', 'N/A', 'ClaimSync007'),
(24, 'Masters', '0000', '0000', 'N/A', 'ClaimSync007'),
(25, 'Doctorate', '0000', '0000', 'N/A', 'ClaimSync007'),
(26, 'SHS', '0000', '0000', 'N/A', 'DL001'),
(27, 'HND', '0000', '0000', 'N/A', 'DL001'),
(28, 'Bachelors', '0000', '0000', 'N/A', 'DL001'),
(29, 'Masters', '0000', '0000', 'N/A', 'DL001'),
(30, 'Doctorate', '0000', '0000', 'N/A', 'DL001'),
(31, 'SHS', '0000', '0000', 'N/A', 'DL002'),
(32, 'HND', '0000', '0000', 'N/A', 'DL002'),
(33, 'Bachelors', '0000', '0000', 'N/A', 'DL002'),
(34, 'Masters', '0000', '0000', 'N/A', 'DL002'),
(35, 'Doctorate', '0000', '0000', 'N/A', 'DL002'),
(36, 'SHS', '0000', '0000', 'N/A', 'DL003'),
(37, 'HND', '0000', '0000', 'N/A', 'DL003'),
(38, 'Bachelors', '0000', '0000', 'N/A', 'DL003'),
(39, 'Masters', '0000', '0000', 'N/A', 'DL003'),
(40, 'Doctorate', '0000', '0000', 'N/A', 'DL003'),
(41, 'SHS', '0000', '0000', 'N/A', 'DL004'),
(42, 'HND', '0000', '0000', 'N/A', 'DL004'),
(43, 'Bachelors', '0000', '0000', 'N/A', 'DL004'),
(44, 'Masters', '0000', '0000', 'N/A', 'DL004'),
(45, 'Doctorate', '0000', '0000', 'N/A', 'DL004'),
(46, 'SHS', '0000', '0000', 'N/A', 'DL005'),
(47, 'HND', '0000', '0000', 'N/A', 'DL005'),
(48, 'Bachelors', '0000', '0000', 'N/A', 'DL005'),
(49, 'Masters', '0000', '0000', 'N/A', 'DL005'),
(50, 'Doctorate', '0000', '0000', 'N/A', 'DL005'),
(51, 'SHS', '0000', '0000', 'N/A', 'DL006'),
(52, 'HND', '0000', '0000', 'N/A', 'DL006'),
(53, 'Bachelors', '0000', '0000', 'N/A', 'DL006'),
(54, 'Masters', '0000', '0000', 'N/A', 'DL006'),
(55, 'Doctorate', '0000', '0000', 'N/A', 'DL006'),
(56, 'SHS', '0000', '0000', 'N/A', 'DL007'),
(57, 'HND', '0000', '0000', 'N/A', 'DL007'),
(58, 'Bachelors', '0000', '0000', 'N/A', 'DL007'),
(59, 'Masters', '0000', '0000', 'N/A', 'DL007'),
(60, 'Doctorate', '0000', '0000', 'N/A', 'DL007'),
(61, 'SHS', '0000', '0000', 'N/A', 'DL009'),
(62, 'HND', '0000', '0000', 'N/A', 'DL009'),
(63, 'Bachelors', '0000', '0000', 'N/A', 'DL009'),
(64, 'Masters', '0000', '0000', 'N/A', 'DL009'),
(65, 'Doctorate', '0000', '0000', 'N/A', 'DL009'),
(66, 'SHS', '0000', '0000', 'N/A', 'DL008'),
(67, 'HND', '0000', '0000', 'N/A', 'DL008'),
(68, 'Bachelors', '0000', '0000', 'N/A', 'DL008'),
(69, 'Masters', '0000', '0000', 'N/A', 'DL008'),
(70, 'Doctorate', '0000', '0000', 'N/A', 'DL008'),
(71, 'SHS', '0000', '0000', 'N/A', 'DL010'),
(72, 'HND', '0000', '0000', 'N/A', 'DL010'),
(73, 'Bachelors', '0000', '0000', 'N/A', 'DL010'),
(74, 'Masters', '0000', '0000', 'N/A', 'DL010'),
(75, 'Doctorate', '0000', '0000', 'N/A', 'DL010');

-- --------------------------------------------------------

--
-- Table structure for table `referring_doctors`
--

CREATE TABLE IF NOT EXISTS `referring_doctors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_name` text NOT NULL,
  `facility` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `referring_doctors`
--

INSERT INTO `referring_doctors` (`id`, `name_name`, `facility`) VALUES
(8, 'Dr. Maurice Dola', 'Danpong Clinic'),
(7, 'Comfort Lebi', 'Danpong Clinic'),
(6, 'Dr. Peter K. Fosu', 'Danpong Clinic'),
(9, 'Dr. Promise Sefogah', 'Danpong Clinic'),
(10, 'Dr. Chike', 'Danpong Clinic'),
(11, 'Dr. Dennis Walker', 'Danpong Clinic'),
(12, 'Dr. Obed Yao Agaho', 'Danpong Clinic'),
(13, 'Kwarteng', 'Danpong Clinic'),
(14, 'Doctor In-Charge', 'Private'),
(15, 'Doctor In-Charge', 'Nungua Collection Point');

-- --------------------------------------------------------

--
-- Table structure for table `ref_range_det`
--

CREATE TABLE IF NOT EXISTS `ref_range_det` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `detailedinv_refrange_type_id` int(11) NOT NULL,
  `det_from` varchar(11) NOT NULL,
  `det_to` varchar(11) NOT NULL,
  `m_lower` varchar(11) NOT NULL,
  `m_upper` varchar(11) NOT NULL,
  `f_lower` varchar(11) NOT NULL,
  `f_upper` varchar(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=195 ;

--
-- Dumping data for table `ref_range_det`
--

INSERT INTO `ref_range_det` (`id`, `detailedinv_refrange_type_id`, `det_from`, `det_to`, `m_lower`, `m_upper`, `f_lower`, `f_upper`) VALUES
(1, 3, '0', '12', '0', '10', '0', '10'),
(2, 3, '12', '120', '0', '15', '0', '20'),
(3, 55, '0', '125', '214', '458', '149', '405'),
(92, 62, '0', '999', '60', '125', '45', '102'),
(8, 85, '0', '125', '30', '128', '30', '100'),
(93, 87, '0', '1999', '10.0', '55.0', '7.0', '40.0'),
(91, 313, '0', '999', '0', '190', '0', '170'),
(124, 317, '6', '12', '3.00', '14.50', '3.00', '14.50'),
(123, 317, '12', '999', '4.00', '11.00', '4.00', '11.00'),
(127, 319, '6', '12', '4.00', '5.50', '4.00', '5.50'),
(126, 319, '12', '999', '4.50', '6.50', '3.80', '5.80'),
(131, 320, '12', '999', '13.0', '18.0', '11.5', '16.5'),
(130, 320, '6', '12', '11.5', '15.5', '11.5', '15.5'),
(129, 320, '0', '6', '11.1', '14.5', '11.1', '14.5'),
(134, 321, '12', '999', '40.0', '52.0', '35.0', '45.0'),
(133, 321, '6', '12', '35.0', '47.0', '35.0', '47.0'),
(132, 321, '0', '6', '32.0', '43.0', '32.0', '43.0'),
(137, 322, '12', '999', '76.0', '100.0', '76.0', '100.0'),
(136, 322, '6', '12', '77.0', '95.0', '77.0', '95.0'),
(135, 322, '0', '6', '70.0', '90.0', '70.0', '90.0'),
(140, 323, '12', '999', '27.0', '32.0', '26.0', '32.0'),
(139, 323, '6', '12', '25.0', '32.0', '25.0', '32.0'),
(138, 323, '0', '6', '25.0', '32.0', '25.0', '32.0'),
(143, 324, '12', '999', '31.0', '37.0', '31.0', '37.0'),
(146, 325, '12', '999', '150', '400', '150', '400'),
(145, 325, '6', '12', '150', '400', '150', '400'),
(144, 325, '0', '6', '150', '400', '150', '400'),
(149, 326, '12', '999', '37.0', '54.0', '37.0', '54.0'),
(148, 326, '6', '12', '37.0', '54.0', '37.0', '54.0'),
(147, 326, '0', '6', '37.0', '54.0', '37.0', '54.0'),
(152, 327, '12', '999', '11.0', '16.0', '11.0', '16.0'),
(151, 327, '6', '12', '11.0', '16.0', '11.0', '16.0'),
(150, 327, '0', '6', '11.0', '16.0', '11.0', '16.0'),
(155, 328, '12', '999', '9.0', '17.0', '9.0', '17.0'),
(154, 328, '6', '12', '9.0', '17.0', '9.0', '17.0'),
(153, 328, '0', '6', '9.0', '17.0', '9.0', '17.0'),
(158, 329, '12', '999', '9.0', '13.0', '9.0', '13.0'),
(157, 329, '6', '12', '9.0', '13.0', '9.0', '13.0'),
(156, 329, '0', '6', '9.0', '13.0', '9.0', '13.0'),
(161, 330, '12', '999', '13.0', '43.0', '13.0', '43.0'),
(160, 330, '6', '12', '13.0', '43.0', '13.0', '43.0'),
(159, 330, '0', '6', '13.0', '43.0', '13.0', '43.0'),
(164, 331, '12', '999', '0.17', '0.35', '0.17', '0.35'),
(163, 331, '6', '12', '0.17', '0.35', '0.17', '0.35'),
(162, 331, '0', '6', '0.17', '0.35', '0.17', '0.35'),
(167, 332, '12', '999', '40.0', '75.0', '40.0', '75.0'),
(166, 332, '6', '12', '35.0', '75.0', '35.0', '75.0'),
(165, 332, '0', '6', '15.0', '60.0', '15.0', '60.0'),
(170, 333, '12', '999', '15.0', '50.0', '15.0', '50.0'),
(169, 333, '6', '12', '20.0', '50.0', '20.0', '50.0'),
(168, 333, '0', '6', '30.0', '68.0', '30.0', '68.0'),
(173, 334, '12', '999', '0.0', '14.0', '0.0', '14.0'),
(172, 334, '6', '12', '0.0', '14.0', '0.0', '14.0'),
(171, 334, '0', '6', '0.0', '14.0', '0.0', '14.0'),
(176, 335, '12', '999', '0.0', '6.0', '0.0', '6.0'),
(175, 335, '6', '12', '0.0', '6.0', '0.0', '6.0'),
(174, 335, '0', '6', '0.0', '6.0', '0.0', '6.0'),
(179, 336, '12', '999', '0.0', '2.0', '0.0', '2.0'),
(178, 336, '6', '12', '0.0', '2.0', '0.0', '2.0'),
(177, 336, '0', '6', '0.0', '2.0', '0.0', '2.0'),
(182, 337, '12', '999', '1.50', '7.00', '1.50', '7.00'),
(181, 337, '6', '12', '1.50', '8.00', '1.50', '8.00'),
(180, 337, '0', '6', '1.50', '8.00', '1.50', '8.00'),
(185, 338, '12', '999', '0.80', '4.00', '0.80', '4.00'),
(184, 338, '6', '12', '1.00', '3.70', '1.00', '3.70'),
(183, 338, '0', '6', '1.00', '3.70', '1.00', '3.70'),
(188, 339, '12', '999', '0.00', '0.90', '0.00', '0.90'),
(187, 339, '6', '12', '0.00', '1.00', '0.00', '1.00'),
(186, 339, '0', '6', '0.00', '1.00', '0.00', '1.00'),
(191, 340, '12', '999', '0.00', '0.60', '0.00', '0.60'),
(190, 340, '6', '12', '0.00', '0.60', '0.00', '0.60'),
(189, 340, '0', '6', '0.00', '0.60', '0.00', '0.60'),
(194, 341, '12', '999', '0.00', '0.10', '0.00', '0.10'),
(193, 341, '6', '12', '0.00', '0.10', '0.00', '0.10'),
(192, 341, '0', '6', '0.00', '0.10', '0.00', '0.10'),
(142, 324, '6', '12', '31.0', '37.0', '31.0', '37.0'),
(141, 324, '0', '6', '31.0', '37.0', '31.0', '37.0'),
(97, 42, '0', '999', '3.5', '6.5', '3.5', '6.5'),
(98, 43, '0', '999', '3.5', '7.8', '3.5', '7.8'),
(99, 48, '0', '999', '3.5', '6.5', '3.5', '6.5'),
(100, 49, '0', '999', '3.5', '7.8', '3.5', '7.8'),
(101, 79, '0', '999', '0', '20', '0', '20'),
(102, 80, '0', '999', '0', '10', '0', '10'),
(103, 81, '0', '999', '60', '83', '60', '83'),
(104, 82, '0', '999', '35', '52', '35', '52'),
(105, 83, '0', '999', '0.0', '40.0', '0.0', '40.0'),
(106, 84, '0', '999', '0.0', '41.0', '0.0', '41.0'),
(107, 86, '0', '999', '225', '450', '225', '450'),
(108, 63, '0', '999', '2.2', '7.2', '2.2', '7,2'),
(109, 64, '0', '999', '3.5', '5.5', '3.5', '5.5'),
(110, 65, '0', '999', '135.0', '150.0', '135.0', '150.0'),
(111, 66, '0', '999', '98.0', '111.0', '98.0', '111.0'),
(112, 58, '0', '999', '2.10', '2.60', '2.10', '2.60'),
(113, 60, '0', '999', '0.66', '1.07', '0.66', '1.07'),
(114, 59, '0', '999', '0.81', '1.50', '0.81', '1.50'),
(115, 312, '0', '999', '0.0', '25.0', '0.0', '250.0'),
(116, 314, '0', '999', '225.0', '450.0', '225.0', '450.0'),
(117, 56, '0', '999', '0.0', '80.0', '0.0', '80.0'),
(118, 351, '0', '999', '0.3', '4.0', '0.3', '4.0'),
(119, 348, '0', '999', '0.3', '4.0', '0.3', '4.0'),
(120, 349, '0', '999', '0.8', '2.2', '0.8', '2.2'),
(121, 350, '0', '999', '1.4', '4.2', '1.4', '4.2'),
(122, 305, '0', '999', '0.0', '4.0', '0.0', '4.0'),
(125, 317, '0', '6', '3.00', '17.50', '3.00', '17.50'),
(128, 319, '0', '6', '2.50', '5.50', '2.50', '5.50');

-- --------------------------------------------------------

--
-- Table structure for table `ref_range_uni`
--

CREATE TABLE IF NOT EXISTS `ref_range_uni` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `detailedinv_refrange_type_id` int(11) NOT NULL,
  `selected` int(11) NOT NULL,
  `lower_ref_range` varchar(25) DEFAULT NULL,
  `upper_ref_range` varchar(25) DEFAULT NULL,
  `paragraphic` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=91 ;

--
-- Dumping data for table `ref_range_uni`
--

INSERT INTO `ref_range_uni` (`id`, `detailedinv_refrange_type_id`, `selected`, `lower_ref_range`, `upper_ref_range`, `paragraphic`) VALUES
(1, 16, 2, '3', '8', ''),
(2, 17, 2, '4', '10', ''),
(3, 20, 2, 'Titre: 1/80', '1/320', ''),
(4, 21, 2, 'Titre: 1/80', '1/320', ''),
(5, 22, 2, 'Titre: 1/80', '1/320', ''),
(6, 23, 2, 'Titre: 1/80', '1/320', ''),
(7, 24, 2, 'Titre: 1/80', '1/320', ''),
(8, 25, 2, 'Titre: 1/80', '1/320', ''),
(9, 26, 2, 'Titre: 1/80', '1/320', ''),
(10, 27, 2, 'Titre: 1/80', '1/320', ''),
(11, 38, 1, '', '', '[ Less than 8: Negative ] [Greater than 8: Positive ]         '),
(85, 346, 1, '', '', 'Negative [ <12 ]  Positive [ >12 ]'),
(84, 53, 1, '', '', 'Healthy [ Fasting: 3.5 - 6.5 ] [ 2 Hours: 3.5 - 7.8 ] \r\nDiabetic [ Fasting: >7.8 ] [ 2 Hours: >11.0] \r\nImpaired [ Fasting: <7.8 ] [ 2 Hours: 7.9 - 11.0] '),
(83, 54, 1, '', '', 'Non Diabetics [ 4.0 - 6.0 ]\r\nGood Glucose Control [ < 7.0 ]\r\nPoor Glucose Control [ > 7.0 ]'),
(90, 429, 1, '', '', '1st Week [ 10 - 30 ]  2nd Week [ 30 - 100 ]  3rd Week [ 100 - 1,000 ]  4th Week [ 1,000 - 10,000 ]  2nd - 3rd Month [ 30,000 - >100,000 ]  2nd Trimester [ 10,000 - 30,000 ]  3rd Trimester [ 5,000 - 15,000 ]'),
(72, 72, 1, '', '', '[ <5.2 Desirable ]\r\n[ 5.2 - 6.2 Borderline High ]\r\n[ >6.2 High ]'),
(73, 73, 1, '', '', '[ <1.0 Undesirable ]\r\n[ 1.0 - 1.6 Acceptable ]\r\n[ >1.6 Desirable ]'),
(74, 75, 1, '', '', '[ <2.6 Optimal ]\r\n[ 2.6 - 3.3 Near Optimal ]\r\n[ 3.4 - 4.1 Borderline High ]\r\n[ 4.2 -4.9 High ]\r\n[ >4.9 Very High ]'),
(75, 76, 1, '', '', '[ <1.7 Normal ]\r\n[ 1.7-2.3 Borderline High ]\r\n[ 2.4 - 5.6  High ]\r\n[ >5.6 Very High ]'),
(76, 77, 1, '', '', '[ <5.00 Desirable ]\r\n[ >5.00 Undesirable ]'),
(89, 293, 1, '', '', '>20 Million'),
(82, 299, 1, '', '', 'Non Pregnant Female [Follicular Phase: 0.2 -1.4 ] [ Luteal Phase: 4.0 - 25.0 ]\r\nMenopause [ 0.1 - 1.0 ]\r\nMale [ 0.1 - 1.0 ]'),
(78, 300, 1, '', '', 'Female [ Non Pregnant: 1.2 - 19.5 ] \r\n[ Postmenopausal: 1.5 -18.5 ] \r\n[ Pregnant: >20 ] \r\nMale [ 1.8 -17.0 ] '),
(42, 301, 1, '', '', 'Female [ Follicular Phase: 3.0 - 12.0 ]\r\n[ Mid - Cycle: 8.0 - 22.0 ]\r\n[ Luteal Phase: 2.0 -12.0 ]\r\nPost- Menopausal [ 35.0 - 151.0 ]\r\nMale [ 1.0 -14.0 ]'),
(81, 302, 1, '', '', 'Female [ Follicular Phase: 0.8 -10.5 ] [ Mid-Cycle: 18.4 - 61.2 ] [ Luteal Phase: 0.8 - 10.5 ]\r\nPost-Menopausal [ 8.2 - 40.8 ]\r\nMale [ 0.7 - 7.4 ] '),
(79, 303, 1, '', '', 'Female [ Follicular Phase: 30 -120 ] [ Ovulatory Peak: 130 - 370 ] [ Luteal Phase: 70 - 250 ]\r\nMenopause [15 - 60 ]\r\nMale [ 15 - 60 ] '),
(80, 304, 1, '', '', 'Sexually matured female [ <0.6 ]\r\nPost-menopause [ <0.8 ]\r\nAdult male [ 3.5 - 8.6 ]\r\nBoys before puberty [ 0.3 -1.2 ]'),
(88, 400, 1, '', '', '>20 Million'),
(57, 88, 2, '4', '14', '');

-- --------------------------------------------------------

--
-- Table structure for table `reg_fee`
--

CREATE TABLE IF NOT EXISTS `reg_fee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reg_fee` double NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `reg_fee`
--

INSERT INTO `reg_fee` (`id`, `reg_fee`, `user_id`, `date_added`, `status`) VALUES
(1, 15, 'ClaimSync0009', '2013-03-05 09:05:26', 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `relief_options`
--

CREATE TABLE IF NOT EXISTS `relief_options` (
  `relief_id` int(11) NOT NULL AUTO_INCREMENT,
  `relief` varchar(255) NOT NULL,
  PRIMARY KEY (`relief_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `relief_options`
--

INSERT INTO `relief_options` (`relief_id`, `relief`) VALUES
(2, 'Took a pill'),
(3, 'Slept');

-- --------------------------------------------------------

--
-- Table structure for table `requisition`
--

CREATE TABLE IF NOT EXISTS `requisition` (
  `request_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_code` varchar(255) NOT NULL,
  `quantity_requested` int(11) NOT NULL,
  `requested_by` varchar(255) NOT NULL,
  `request_approved_by` varchar(255) DEFAULT NULL,
  `date_of_request` date NOT NULL,
  `date_delivered` date DEFAULT NULL,
  `quantity_delivered` int(11) DEFAULT NULL,
  `delivered_by` varchar(255) DEFAULT NULL,
  `delivery_approved_by` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `location` varchar(100) NOT NULL,
  PRIMARY KEY (`request_id`),
  KEY `item_code` (`item_code`),
  KEY `requested_by` (`requested_by`),
  KEY `request_approved_by` (`request_approved_by`),
  KEY `delivered_by` (`delivered_by`),
  KEY `delivery_approved_by` (`delivery_approved_by`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `requisition`
--

INSERT INTO `requisition` (`request_id`, `item_code`, `quantity_requested`, `requested_by`, `request_approved_by`, `date_of_request`, `date_delivered`, `quantity_delivered`, `delivered_by`, `delivery_approved_by`, `status`, `location`) VALUES
(1, 'PARAINJE', 700, 'ClaimSync0009', NULL, '2013-11-26', NULL, NULL, NULL, NULL, 'Pending', 'Dispensary');

-- --------------------------------------------------------

--
-- Table structure for table `roletable`
--

CREATE TABLE IF NOT EXISTS `roletable` (
  `roleid` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(50) NOT NULL,
  `roledescription` varchar(255) NOT NULL,
  PRIMARY KEY (`roleid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `roletable`
--

INSERT INTO `roletable` (`roleid`, `rolename`, `roledescription`) VALUES
(1, 'Clinic Manager', 'Manages All Activities that occur in the Clinic'),
(2, 'Clinic Cashier ', 'Receives payments made in the clinic'),
(3, 'Doctor ', 'Attends to Patient during Patient Consultations'),
(4, 'System Adminstrator(IT department)', 'These category of users are responsible for system back up and system wide administration of the software'),
(5, 'Dispenser', 'Responsible for dispensing drugs to patients'),
(6, 'Laboratory Scientist', 'Responsible for taking care of patient investigations'),
(7, 'Nurse', 'Responsible for taking care patients, attending their to their needs and assisting physicians in their duties '),
(8, 'Records Personnel', 'Responsible for filing patients folder, searching for folders, registering new patients and logging patient visits'),
(9, 'Laboratory Reception / Cashier  ', 'Responsible for Recording Patient Information and Receiving Payments in the Laboratory'),
(13, 'Laboratory Manager', 'Manage the laboratory dashboard');

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE IF NOT EXISTS `room` (
  `roomid` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `number_of_beds` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `cost` double NOT NULL,
  `ward_id` int(11) NOT NULL,
  PRIMARY KEY (`roomid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`roomid`, `description`, `number_of_beds`, `status`, `cost`, `ward_id`) VALUES
(1, 'Room 1', 1, 1, 35, 2),
(2, 'Room 2', 1, 1, 35, 2),
(3, 'Room 3', 1, 1, 35, 2),
(4, 'Room 4', 1, 1, 35, 2);

-- --------------------------------------------------------

--
-- Table structure for table `social_histories`
--

CREATE TABLE IF NOT EXISTS `social_histories` (
  `social_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `social_history` varchar(255) NOT NULL,
  PRIMARY KEY (`social_history_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `social_histories`
--

INSERT INTO `social_histories` (`social_history_id`, `social_history`) VALUES
(2, 'Smoking'),
(3, 'Drinking'),
(4, 'Drugs / Narcotics');

-- --------------------------------------------------------

--
-- Table structure for table `specimen`
--

CREATE TABLE IF NOT EXISTS `specimen` (
  `specimen_id` int(11) NOT NULL AUTO_INCREMENT,
  `specimen` text NOT NULL,
  PRIMARY KEY (`specimen_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `specimen`
--

INSERT INTO `specimen` (`specimen_id`, `specimen`) VALUES
(1, 'BLOOD'),
(2, 'URINE'),
(3, 'SWAB'),
(4, 'STOOL'),
(5, 'SKIN'),
(6, 'SEMEN'),
(7, 'SPUTUM');

-- --------------------------------------------------------

--
-- Table structure for table `sponsorhipdetails`
--

CREATE TABLE IF NOT EXISTS `sponsorhipdetails` (
  `patientid` varchar(10) NOT NULL,
  `membershipid` varchar(50) DEFAULT NULL,
  `type` varchar(250) DEFAULT NULL,
  `benefitplan` varchar(200) DEFAULT NULL,
  `sponsorid` varchar(50) DEFAULT NULL,
  `dependentnumber` text,
  `secondary_sponsor` varchar(50) DEFAULT NULL,
  `secondary_type` text,
  `secondary_benefitplan` text,
  `secondary_membership` text,
  PRIMARY KEY (`patientid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sponsorhipdetails`
--

INSERT INTO `sponsorhipdetails` (`patientid`, `membershipid`, `type`, `benefitplan`, `sponsorid`, `dependentnumber`, `secondary_sponsor`, `secondary_type`, `secondary_benefitplan`, `secondary_membership`) VALUES
('13DC1', 'N/A', 'CASH', 'N/A', '11', NULL, '11', 'CASH', 'N/A', 'N/A'),
('13DC2', 'N/A', 'CASH', 'N/A', '11', NULL, '11', 'CASH', 'N/A', 'N/A');

-- --------------------------------------------------------

--
-- Table structure for table `sponsorship`
--

CREATE TABLE IF NOT EXISTS `sponsorship` (
  `sponshorshipid` varchar(50) NOT NULL,
  `sponsorname` varchar(150) DEFAULT NULL,
  `type` varchar(150) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  `contact` varchar(10) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `labmarkup` double DEFAULT NULL,
  `treatment_markup` double DEFAULT NULL,
  `markup_treat_percentage` double NOT NULL,
  `markup_lab_percentage` double NOT NULL,
  PRIMARY KEY (`sponshorshipid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sponsorship`
--

INSERT INTO `sponsorship` (`sponshorshipid`, `sponsorname`, `type`, `address`, `contact`, `email`, `labmarkup`, `treatment_markup`, `markup_treat_percentage`, `markup_lab_percentage`) VALUES
('937E8D', 'Mutual Alliance Health Plan', 'Private', '', '0264647746', '', 0, 0, 0, 0),
('9D2B71', 'Nationwide Insurance', 'Private', '', '0264647746', '@oko.com', 0, 0, 0, 0),
('25AFD9', 'First Fidelity Health', 'Private', '', '0264647746', '', 0, 0, 0, 0),
('ED53A4', 'Premier Mutual Health', 'Private', '', '0264647746', '', 0, 0, 0, 0),
('4301CA', 'Liberty Health', 'Private', '', '0264647746', '@oko.com', 0, 0, 0, 0),
('Nurevas', 'Nurevas', 'Cooperate', '', '0545454545', '', 0, 0, 0, 0),
('INTER', 'Interplast Staff', 'Cooperate', '', '0546212632', '', 0, 0, 0, 0),
('10', 'Cal Bank', 'Cooperate', 'Accra', '0264281623', 'info@calbank.com', 0, 0, 0, 0),
('11', 'Out of Pocket', 'CASH', 'NA', 'NA', 'NA', 0, 0, 0, 0),
('12', 'NHIS', 'NHIS', 'Dzorwulu', 'Nelson Per', 'info@nhia.gov.com', 0, 0, 0, 0),
('ACA', 'Acacia Health Insurance', 'Private', 'No. 19 Banana', '0546212632', 'acacia@gmail.com', 0, 0, 0, 0),
('CEO', 'CEO''s Protocol', 'Cooperate', '', '0546212632', '', 0, 0, 0, 0),
('Cob-A', 'Cob-A Industry Staff', 'Cooperate', '', '0546212632', '', 0, 0, 0, 0),
('Danadams', 'Danadams Staff', 'Cooperate', '', '0546212632', '', 0, 0, 0, 0),
('DA. PRE', 'Danadams Pre Employment Medicals', '', '', '0264757574', '', 10, 10, 10, 10),
('DP. PE', 'Danpong Pre Employment Medicals', 'Cooperate', '', '0264757574', '', 10, 10, 10, 10),
('Dan. Staff', 'Danpong Staff', 'Cooperate', '', '0264757574', '', 10, 10, 10, 10),
('EMP', 'Empire Mutual Health', 'Private', '', '0546212632', '', 10, 10, 10, 10),
('GLICO', 'Glico Health Plan', 'Private', '', '0546212632', '', 10, 10, 10, 10),
('K.O', 'K. Ofori Staff', 'Cooperate', '', '0264757574', '', 10, 10, 10, 10),
('Khameen', 'Khameen Professional Institute', 'Cooperate', '', '0545454545', '', 10, 10, 10, 10),
('Managed', 'Managed Health', 'Private', '', '0264757574', '', 10, 10, 10, 10),
('REGI', 'Regimanuel Gray Limited', 'Cooperate', '', '0264757574', '', 10, 10, 10, 10),
('USC', 'United Steel Staff', 'Cooperate', '', '0545454545', '', 10, 10, 10, 10),
('Vitality', 'Vitality Mutual Health', 'Private', '', '0264757574', '', 10, 10, 10, 10),
('Pro', 'Process & Plant Automation Ltd.', 'Cooperate', '', '0264757574', '', 10, 10, 10, 10),
('Wisconsin', 'Wisconsin Int. University Gh.', 'Cooperate', '', '0545454545', '', 10, 10, 10, 10),
('WWB', 'Women''s World Banking', 'Cooperate', '', '0546212632', '', 10, 10, 10, 10);

-- --------------------------------------------------------

--
-- Table structure for table `sponsor_labitem_price`
--

CREATE TABLE IF NOT EXISTS `sponsor_labitem_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sponsor_id` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `lab_item_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4551 ;

--
-- Dumping data for table `sponsor_labitem_price`
--

INSERT INTO `sponsor_labitem_price` (`id`, `sponsor_id`, `price`, `lab_item_id`) VALUES
(4538, '10', 15, 2),
(4539, '11', 15, 2),
(4540, '12', 10, 2),
(4537, '9', 15, 2),
(4532, '9D2B71', 15, 2),
(4533, '25AFD9', 15, 2),
(4536, 'D8663D', 15, 2),
(4505, '4301CA', 80, 28),
(4531, '937E8D', 15, 2),
(4509, '11', 80, 28),
(4508, '10', 80, 28),
(4507, '9', 80, 28),
(4506, 'D8663D', 80, 28),
(4500, '12', 15, 34),
(4501, '937E8D', 80, 28),
(4502, '9D2B71', 80, 28),
(4503, '25AFD9', 80, 28),
(4504, 'ED53A4', 80, 28),
(4491, '937E8D', 15, 34),
(4492, '9D2B71', 15, 34),
(4493, '25AFD9', 15, 34),
(4494, 'ED53A4', 15, 34),
(4495, '4301CA', 15, 34),
(4496, 'D8663D', 15, 34),
(4497, '9', 15, 34),
(4498, '10', 15, 34),
(4499, '11', 15, 34),
(4407, '9', 40, 120),
(4490, '12', 22, 33),
(4489, '11', 20, 33),
(4481, '937E8D', 20, 33),
(4482, '9D2B71', 20, 33),
(4483, '25AFD9', 20, 33),
(4484, 'ED53A4', 20, 33),
(4485, '4301CA', 20, 33),
(4486, 'D8663D', 20, 33),
(4487, '9', 20, 33),
(4488, '10', 20, 33),
(4402, '9D2B71', 40, 120),
(4403, '25AFD9', 40, 120),
(4404, 'ED53A4', 40, 120),
(4405, '4301CA', 40, 120),
(4406, 'D8663D', 40, 120),
(4397, '9', 10, 273),
(4398, '10', 10, 273),
(4399, '11', 10, 273),
(4400, '12', 10, 273),
(4401, '937E8D', 40, 120),
(4387, '9', 15, 55),
(4388, '10', 15, 55),
(4389, '11', 15, 55),
(4390, '12', 15, 55),
(4391, '937E8D', 10, 273),
(4392, '9D2B71', 10, 273),
(4393, '25AFD9', 10, 273),
(4394, 'ED53A4', 10, 273),
(4395, '4301CA', 10, 273),
(4396, 'D8663D', 10, 273),
(4377, '9', 40, 193),
(4378, '10', 40, 193),
(4379, '11', 40, 193),
(4380, '12', 40, 193),
(4381, '937E8D', 15, 55),
(4382, '9D2B71', 15, 55),
(4383, '25AFD9', 15, 55),
(4384, 'ED53A4', 15, 55),
(4385, '4301CA', 15, 55),
(4386, 'D8663D', 15, 55),
(4372, '9D2B71', 40, 193),
(4373, '25AFD9', 40, 193),
(4374, 'ED53A4', 40, 193),
(4375, '4301CA', 40, 193),
(4376, 'D8663D', 40, 193),
(4367, '9', 20, 41),
(4368, '10', 20, 41),
(4369, '11', 20, 41),
(4370, '12', 20, 41),
(4371, '937E8D', 40, 193),
(4357, '9', 40, 306),
(4358, '10', 40, 306),
(4359, '11', 40, 306),
(4360, '12', 40, 306),
(4361, '937E8D', 20, 41),
(4362, '9D2B71', 20, 41),
(4363, '25AFD9', 20, 41),
(4364, 'ED53A4', 20, 41),
(4365, '4301CA', 20, 41),
(4366, 'D8663D', 20, 41),
(4347, '9', 40, 249),
(4348, '10', 40, 249),
(4349, '11', 40, 249),
(4350, '12', 40, 249),
(4351, '937E8D', 40, 306),
(4352, '9D2B71', 40, 306),
(4353, '25AFD9', 40, 306),
(4354, 'ED53A4', 40, 306),
(4355, '4301CA', 40, 306),
(4356, 'D8663D', 40, 306),
(4342, '9D2B71', 40, 249),
(4343, '25AFD9', 40, 249),
(4344, 'ED53A4', 40, 249),
(4345, '4301CA', 40, 249),
(4346, 'D8663D', 40, 249),
(4337, '9', 35, 304),
(4338, '10', 35, 304),
(4339, '11', 35, 304),
(4340, '12', 35, 304),
(4341, '937E8D', 40, 249),
(4327, '9', 20, 36),
(4328, '10', 20, 36),
(4329, '11', 20, 36),
(4330, '12', 20, 36),
(4331, '937E8D', 35, 304),
(4332, '9D2B71', 35, 304),
(4333, '25AFD9', 35, 304),
(4334, 'ED53A4', 35, 304),
(4335, '4301CA', 35, 304),
(4336, 'D8663D', 35, 304),
(4317, '9', 55, 113),
(4318, '10', 55, 113),
(4319, '11', 55, 113),
(4320, '12', 55, 113),
(4321, '937E8D', 20, 36),
(4322, '9D2B71', 20, 36),
(4323, '25AFD9', 20, 36),
(4324, 'ED53A4', 20, 36),
(4325, '4301CA', 20, 36),
(4326, 'D8663D', 20, 36),
(4312, '9D2B71', 55, 113),
(4313, '25AFD9', 55, 113),
(4314, 'ED53A4', 55, 113),
(4315, '4301CA', 55, 113),
(4316, 'D8663D', 55, 113),
(4307, '9', 40, 148),
(4308, '10', 40, 148),
(4309, '11', 40, 148),
(4310, '12', 40, 148),
(4311, '937E8D', 55, 113),
(4297, '9', 40, 248),
(4298, '10', 40, 248),
(4299, '11', 40, 248),
(4300, '12', 40, 248),
(4301, '937E8D', 40, 148),
(4302, '9D2B71', 40, 148),
(4303, '25AFD9', 40, 148),
(4304, 'ED53A4', 40, 148),
(4305, '4301CA', 40, 148),
(4306, 'D8663D', 40, 148),
(4287, '9', 15, 309),
(4288, '10', 15, 309),
(4289, '11', 15, 309),
(4290, '12', 15, 309),
(4291, '937E8D', 40, 248),
(4292, '9D2B71', 40, 248),
(4293, '25AFD9', 40, 248),
(4294, 'ED53A4', 40, 248),
(4295, '4301CA', 40, 248),
(4296, 'D8663D', 40, 248),
(4282, '9D2B71', 15, 309),
(4283, '25AFD9', 15, 309),
(4284, 'ED53A4', 15, 309),
(4285, '4301CA', 15, 309),
(4286, 'D8663D', 15, 309),
(4277, '9', 30, 271),
(4278, '10', 30, 271),
(4279, '11', 30, 271),
(4280, '12', 30, 271),
(4281, '937E8D', 15, 309),
(4267, '9', 30, 272),
(4268, '10', 30, 272),
(4269, '11', 30, 272),
(4270, '12', 30, 272),
(4271, '937E8D', 30, 271),
(4272, '9D2B71', 30, 271),
(4273, '25AFD9', 30, 271),
(4274, 'ED53A4', 30, 271),
(4275, '4301CA', 30, 271),
(4276, 'D8663D', 30, 271),
(4257, '9', 30, 316),
(4258, '10', 30, 316),
(4259, '11', 30, 316),
(4260, '12', 30, 316),
(4261, '937E8D', 30, 272),
(4262, '9D2B71', 30, 272),
(4263, '25AFD9', 30, 272),
(4264, 'ED53A4', 30, 272),
(4265, '4301CA', 30, 272),
(4266, 'D8663D', 30, 272),
(4252, '9D2B71', 30, 316),
(4253, '25AFD9', 30, 316),
(4254, 'ED53A4', 30, 316),
(4255, '4301CA', 30, 316),
(4256, 'D8663D', 30, 316),
(4247, '9', 20, 315),
(4248, '10', 20, 315),
(4249, '11', 20, 315),
(4250, '12', 20, 315),
(4251, '937E8D', 30, 316),
(4237, '9', 15, 274),
(4238, '10', 15, 274),
(4239, '11', 15, 274),
(4240, '12', 15, 274),
(4241, '937E8D', 20, 315),
(4242, '9D2B71', 20, 315),
(4243, '25AFD9', 20, 315),
(4244, 'ED53A4', 20, 315),
(4245, '4301CA', 20, 315),
(4246, 'D8663D', 20, 315),
(4227, '9', 40, 297),
(4228, '10', 40, 297),
(4229, '11', 40, 297),
(4230, '12', 40, 297),
(4231, '937E8D', 15, 274),
(4232, '9D2B71', 15, 274),
(4233, '25AFD9', 15, 274),
(4234, 'ED53A4', 15, 274),
(4235, '4301CA', 15, 274),
(4236, 'D8663D', 15, 274),
(4222, '9D2B71', 40, 297),
(4223, '25AFD9', 40, 297),
(4224, 'ED53A4', 40, 297),
(4225, '4301CA', 40, 297),
(4226, 'D8663D', 40, 297),
(4217, '9', 40, 277),
(4218, '10', 40, 277),
(4219, '11', 40, 277),
(4220, '12', 40, 277),
(4221, '937E8D', 40, 297),
(4207, '9', 20, 38),
(4208, '10', 20, 38),
(4209, '11', 20, 38),
(4210, '12', 20, 38),
(4211, '937E8D', 40, 277),
(4212, '9D2B71', 40, 277),
(4213, '25AFD9', 40, 277),
(4214, 'ED53A4', 40, 277),
(4215, '4301CA', 40, 277),
(4216, 'D8663D', 40, 277),
(4197, '9', 45, 61),
(4198, '10', 45, 61),
(4199, '11', 45, 61),
(4200, '12', 45, 61),
(4201, '937E8D', 20, 38),
(4202, '9D2B71', 20, 38),
(4203, '25AFD9', 35, 38),
(4204, 'ED53A4', 20, 38),
(4205, '4301CA', 20, 38),
(4206, 'D8663D', 20, 38),
(4192, '9D2B71', 45, 61),
(4193, '25AFD9', 45, 61),
(4194, 'ED53A4', 45, 61),
(4195, '4301CA', 45, 61),
(4196, 'D8663D', 45, 61),
(4187, '9', 10, 43),
(4188, '10', 10, 43),
(4189, '11', 10, 43),
(4190, '12', 10, 43),
(4191, '937E8D', 45, 61),
(4177, '9', 40, 305),
(4178, '10', 40, 305),
(4179, '11', 40, 305),
(4180, '12', 40, 305),
(4181, '937E8D', 10, 43),
(4182, '9D2B71', 10, 43),
(4183, '25AFD9', 10, 43),
(4184, 'ED53A4', 10, 43),
(4185, '4301CA', 10, 43),
(4186, 'D8663D', 10, 43),
(4167, '9', 50, 12),
(4168, '10', 50, 12),
(4169, '11', 50, 12),
(4170, '12', 50, 12),
(4171, '937E8D', 40, 305),
(4172, '9D2B71', 40, 305),
(4173, '25AFD9', 40, 305),
(4174, 'ED53A4', 40, 305),
(4175, '4301CA', 40, 305),
(4176, 'D8663D', 40, 305),
(4162, '9D2B71', 50, 12),
(4163, '25AFD9', 50, 12),
(4164, 'ED53A4', 50, 12),
(4165, '4301CA', 50, 12),
(4166, 'D8663D', 50, 12),
(4157, '9', 35, 300),
(4158, '10', 35, 300),
(4159, '11', 35, 300),
(4160, '12', 35, 300),
(4161, '937E8D', 50, 12),
(4147, '9', 35, 299),
(4148, '10', 35, 299),
(4149, '11', 35, 299),
(4150, '12', 35, 299),
(4151, '937E8D', 35, 300),
(4152, '9D2B71', 35, 300),
(4153, '25AFD9', 35, 300),
(4154, 'ED53A4', 35, 300),
(4155, '4301CA', 35, 300),
(4156, 'D8663D', 35, 300),
(4137, '9', 20, 47),
(4138, '10', 20, 47),
(4139, '11', 20, 47),
(4140, '12', 20, 47),
(4141, '937E8D', 35, 299),
(4142, '9D2B71', 35, 299),
(4143, '25AFD9', 35, 299),
(4144, 'ED53A4', 35, 299),
(4145, '4301CA', 35, 299),
(4146, 'D8663D', 35, 299),
(4132, '9D2B71', 20, 47),
(4133, '25AFD9', 20, 47),
(4134, 'ED53A4', 20, 47),
(4135, '4301CA', 20, 47),
(4136, 'D8663D', 20, 47),
(4127, '9', 20, 59),
(4128, '10', 20, 59),
(4129, '11', 20, 59),
(4130, '12', 20, 59),
(4131, '937E8D', 20, 47),
(4117, '9', 40, 218),
(4118, '10', 40, 218),
(4119, '11', 40, 218),
(4120, '12', 40, 218),
(4121, '937E8D', 20, 59),
(4122, '9D2B71', 20, 59),
(4123, '25AFD9', 20, 59),
(4124, 'ED53A4', 20, 59),
(4125, '4301CA', 20, 59),
(4126, 'D8663D', 20, 59),
(4107, '9', 10, 1),
(4108, '10', 10, 1),
(4109, '11', 10, 1),
(4110, '12', 10, 1),
(4111, '937E8D', 40, 218),
(4112, '9D2B71', 40, 218),
(4113, '25AFD9', 40, 218),
(4114, 'ED53A4', 40, 218),
(4115, '4301CA', 40, 218),
(4116, 'D8663D', 40, 218),
(4102, '9D2B71', 10, 1),
(4103, '25AFD9', 10, 1),
(4104, 'ED53A4', 10, 1),
(4105, '4301CA', 10, 1),
(4106, 'D8663D', 10, 1),
(4097, '9', 15, 2),
(4098, '10', 15, 2),
(4099, '11', 15, 2),
(4100, '12', 15, 2),
(4101, '937E8D', 12, 1),
(4087, '9', 20, 60),
(4088, '10', 20, 60),
(4089, '11', 20, 60),
(4090, '12', 20, 60),
(4091, '937E8D', 15, 2),
(4092, '9D2B71', 15, 2),
(4093, '25AFD9', 15, 2),
(4094, 'ED53A4', 15, 2),
(4095, '4301CA', 15, 2),
(4096, 'D8663D', 15, 2),
(4077, '9', 35, 302),
(4078, '10', 35, 302),
(4079, '11', 35, 302),
(4080, '12', 35, 302),
(4081, '937E8D', 20, 60),
(4082, '9D2B71', 20, 60),
(4083, '25AFD9', 20, 60),
(4084, 'ED53A4', 20, 60),
(4085, '4301CA', 20, 60),
(4086, 'D8663D', 20, 60),
(4072, '9D2B71', 35, 302),
(4073, '25AFD9', 35, 302),
(4074, 'ED53A4', 35, 302),
(4075, '4301CA', 35, 302),
(4076, 'D8663D', 35, 302),
(4067, '9', 50, 78),
(4068, '10', 50, 78),
(4069, '11', 50, 78),
(4070, '12', 50, 78),
(4071, '937E8D', 35, 302),
(4057, '9', 40, 71),
(4058, '10', 40, 71),
(4059, '11', 40, 71),
(4060, '12', 40, 71),
(4061, '937E8D', 50, 78),
(4062, '9D2B71', 50, 78),
(4063, '25AFD9', 50, 78),
(4064, 'ED53A4', 50, 78),
(4065, '4301CA', 50, 78),
(4066, 'D8663D', 50, 78),
(4047, '9', 60, 57),
(4048, '10', 60, 57),
(4049, '11', 60, 57),
(4050, '12', 60, 57),
(4051, '937E8D', 40, 71),
(4052, '9D2B71', 40, 71),
(4053, '25AFD9', 40, 71),
(4054, 'ED53A4', 40, 71),
(4055, '4301CA', 40, 71),
(4056, 'D8663D', 40, 71),
(4042, '9D2B71', 60, 57),
(4043, '25AFD9', 60, 57),
(4044, 'ED53A4', 60, 57),
(4045, '4301CA', 60, 57),
(4046, 'D8663D', 60, 57),
(4037, '9', 20, 314),
(4038, '10', 20, 314),
(4039, '11', 20, 314),
(4040, '12', 20, 314),
(4041, '937E8D', 60, 57),
(4030, '12', 40, 158),
(4031, '937E8D', 20, 314),
(4032, '9D2B71', 20, 314),
(4033, '25AFD9', 20, 314),
(4034, 'ED53A4', 20, 314),
(4035, '4301CA', 20, 314),
(4036, 'D8663D', 20, 314),
(4027, '9', 40, 158),
(4026, 'D8663D', 40, 158),
(4023, '25AFD9', 40, 158),
(4024, 'ED53A4', 40, 158),
(4025, '4301CA', 40, 158),
(4028, '10', 40, 158),
(4029, '11', 40, 158),
(4017, '9', 20, 35),
(4018, '10', 20, 35),
(4019, '11', 20, 35),
(4020, '12', 20, 35),
(4021, '937E8D', 40, 158),
(4022, '9D2B71', 40, 158),
(4016, 'D8663D', 20, 35),
(4009, '11', 80, 28),
(4010, '12', 80, 28),
(4011, '937E8D', 20, 35),
(4012, '9D2B71', 20, 35),
(4013, '25AFD9', 20, 35),
(4014, 'ED53A4', 20, 35),
(4015, '4301CA', 20, 35),
(4008, '10', 80, 28),
(4007, '9', 80, 28),
(4003, '25AFD9', 80, 28),
(4004, 'ED53A4', 80, 28),
(4005, '4301CA', 80, 28),
(4006, 'D8663D', 80, 28),
(4002, '9D2B71', 80, 28),
(4001, '937E8D', 80, 28),
(4000, '12', 15, 34),
(3999, '11', 15, 34),
(3993, '25AFD9', 15, 34),
(3994, 'ED53A4', 15, 34),
(3995, '4301CA', 15, 34),
(3996, 'D8663D', 15, 34),
(3997, '9', 15, 34),
(3998, '10', 15, 34),
(3992, '9D2B71', 15, 34),
(3991, '937E8D', 15, 34),
(3985, '4301CA', 20, 33),
(3986, 'D8663D', 20, 33),
(3987, '9', 20, 33),
(3988, '10', 20, 33),
(3989, '11', 20, 33),
(3990, '12', 20, 33),
(3984, 'ED53A4', 20, 33),
(3979, '11', 40, 54),
(3980, '12', 40, 54),
(3981, '937E8D', 20, 33),
(3982, '9D2B71', 20, 33),
(3983, '25AFD9', 20, 33),
(3978, '10', 40, 54),
(3977, '9', 40, 54),
(3973, '25AFD9', 40, 54),
(3974, 'ED53A4', 40, 54),
(3975, '4301CA', 40, 54),
(3976, 'D8663D', 40, 54),
(3972, '9D2B71', 40, 54),
(3971, '937E8D', 40, 54),
(3970, '12', 40, 275),
(3969, '11', 40, 275),
(3963, '25AFD9', 40, 275),
(3964, 'ED53A4', 40, 275),
(3965, '4301CA', 40, 275),
(3966, 'D8663D', 40, 275),
(3967, '9', 40, 275),
(3968, '10', 40, 275),
(3962, '9D2B71', 40, 275),
(3961, '937E8D', 40, 275),
(3955, '4301CA', 20, 40),
(3956, 'D8663D', 20, 40),
(3957, '9', 20, 40),
(3958, '10', 20, 40),
(3959, '11', 20, 40),
(3960, '12', 20, 40),
(3954, 'ED53A4', 20, 40),
(3949, '11', 40, 50),
(3950, '12', 40, 50),
(3951, '937E8D', 20, 40),
(3952, '9D2B71', 20, 40),
(3953, '25AFD9', 20, 40),
(3948, '10', 40, 50),
(3947, '9', 40, 50),
(3943, '25AFD9', 40, 50),
(3944, 'ED53A4', 40, 50),
(3945, '4301CA', 40, 50),
(3946, 'D8663D', 40, 50),
(3942, '9D2B71', 40, 50),
(3941, '937E8D', 40, 50),
(3940, '12', 20, 8),
(3939, '11', 20, 8),
(3933, '25AFD9', 20, 8),
(3934, 'ED53A4', 20, 8),
(3935, '4301CA', 20, 8),
(3936, 'D8663D', 20, 8),
(3937, '9', 20, 8),
(3938, '10', 20, 8),
(3932, '9D2B71', 20, 8),
(3931, '937E8D', 20, 8),
(3925, '4301CA', 20, 18),
(3926, 'D8663D', 20, 18),
(3927, '9', 20, 18),
(3928, '10', 20, 18),
(3929, '11', 20, 18),
(3930, '12', 20, 18),
(3924, 'ED53A4', 20, 18),
(3919, '11', 35, 308),
(3920, '12', 35, 308),
(3921, '937E8D', 20, 18),
(3922, '9D2B71', 20, 18),
(3923, '25AFD9', 20, 18),
(3918, '10', 35, 308),
(3917, '9', 35, 308),
(3913, '25AFD9', 35, 308),
(3914, 'ED53A4', 35, 308),
(3915, '4301CA', 35, 308),
(3916, 'D8663D', 35, 308),
(3912, '9D2B71', 35, 308),
(3911, '937E8D', 35, 308),
(3910, '12', 35, 307),
(3909, '11', 35, 307),
(3903, '25AFD9', 35, 307),
(3904, 'ED53A4', 35, 307),
(3905, '4301CA', 35, 307),
(3906, 'D8663D', 35, 307),
(3907, '9', 35, 307),
(3908, '10', 35, 307),
(3902, '9D2B71', 35, 307),
(3901, '937E8D', 35, 307),
(3895, '4301CA', 35, 301),
(3896, 'D8663D', 35, 301),
(3897, '9', 35, 301),
(3898, '10', 35, 301),
(3899, '11', 35, 301),
(3900, '12', 35, 301),
(3894, 'ED53A4', 35, 301),
(3889, '11', 10, 42),
(3890, '12', 10, 42),
(3891, '937E8D', 35, 301),
(3892, '9D2B71', 35, 301),
(3893, '25AFD9', 35, 301),
(3888, '10', 10, 42),
(3887, '9', 10, 42),
(3883, '25AFD9', 10, 42),
(3884, 'ED53A4', 10, 42),
(3885, '4301CA', 10, 42),
(3886, 'D8663D', 10, 42),
(3882, '9D2B71', 10, 42),
(3881, '937E8D', 10, 42),
(3880, '12', 20, 276),
(3879, '11', 20, 276),
(3873, '25AFD9', 20, 276),
(3874, 'ED53A4', 20, 276),
(3875, '4301CA', 20, 276),
(3876, 'D8663D', 20, 276),
(3877, '9', 20, 276),
(3878, '10', 20, 276),
(3872, '9D2B71', 20, 276),
(3871, '937E8D', 20, 276),
(3865, '4301CA', 40, 228),
(3866, 'D8663D', 40, 228),
(3867, '9', 40, 228),
(3868, '10', 40, 228),
(3869, '11', 40, 228),
(3870, '12', 40, 228),
(3864, 'ED53A4', 40, 228),
(3859, '11', 35, 303),
(3860, '12', 35, 303),
(3861, '937E8D', 40, 228),
(3862, '9D2B71', 40, 228),
(3863, '25AFD9', 40, 228),
(3858, '10', 35, 303),
(3857, '9', 35, 303),
(3853, '25AFD9', 35, 303),
(3854, 'ED53A4', 35, 303),
(3855, '4301CA', 35, 303),
(3856, 'D8663D', 35, 303),
(3852, '9D2B71', 35, 303),
(3851, '937E8D', 35, 303),
(3850, '12', 15, 3),
(3849, '11', 15, 3),
(3848, '10', 15, 3),
(3847, '9', 15, 3),
(3846, 'D8663D', 15, 3),
(3839, '11', 30, 5),
(3840, '12', 30, 5),
(3841, '937E8D', 15, 3),
(3842, '9D2B71', 15, 3),
(3843, '25AFD9', 15, 3),
(3844, 'ED53A4', 15, 3),
(3845, '4301CA', 15, 3),
(3838, '10', 30, 5),
(3837, '9', 30, 5),
(3832, '9D2B71', 30, 5),
(3833, '25AFD9', 30, 5),
(3834, 'ED53A4', 30, 5),
(3835, '4301CA', 30, 5),
(3836, 'D8663D', 30, 5),
(3831, '937E8D', 30, 5),
(3830, '12', 40, 205),
(3829, '11', 40, 205),
(3828, '10', 40, 205),
(3827, '9', 40, 205),
(3826, 'D8663D', 40, 205),
(3825, '4301CA', 40, 205),
(3824, 'ED53A4', 40, 205),
(3823, '25AFD9', 40, 205),
(3822, '9D2B71', 40, 205),
(3821, '937E8D', 40, 205),
(3820, '12', 20, 313),
(3819, '11', 20, 313),
(3818, '10', 20, 313),
(3817, '9', 20, 313),
(3816, 'D8663D', 20, 313),
(3815, '4301CA', 20, 313),
(3814, 'ED53A4', 20, 313),
(3813, '25AFD9', 20, 313),
(3812, '9D2B71', 20, 313),
(3811, '937E8D', 20, 313),
(3810, '12', 20, 9),
(3809, '11', 20, 9),
(3808, '10', 20, 9),
(3807, '9', 20, 9),
(3806, 'D8663D', 20, 9),
(3805, '4301CA', 20, 9),
(3804, 'ED53A4', 20, 9),
(3803, '25AFD9', 20, 9),
(3802, '9D2B71', 20, 9),
(3801, '937E8D', 20, 9),
(3800, '12', 15, 17),
(3799, '11', 15, 17),
(3798, '10', 15, 17),
(3797, '9', 15, 17),
(3796, 'D8663D', 15, 17),
(3795, '4301CA', 15, 17),
(3794, 'ED53A4', 15, 17),
(3793, '25AFD9', 15, 17),
(3792, '9D2B71', 15, 17),
(3791, '937E8D', 15, 17),
(3790, '12', 30, 312),
(3789, '11', 30, 312),
(3788, '10', 30, 312),
(3787, '9', 30, 312),
(3786, 'D8663D', 30, 312),
(3785, '4301CA', 30, 312),
(3784, 'ED53A4', 30, 312),
(3783, '25AFD9', 30, 312),
(3782, '9D2B71', 30, 312),
(3781, '937E8D', 30, 312),
(3780, '12', 30, 39),
(3779, '11', 30, 39),
(3778, '10', 30, 39),
(3777, '9', 30, 39),
(3776, 'D8663D', 30, 39),
(3775, '4301CA', 30, 39),
(3774, 'ED53A4', 30, 39),
(3773, '25AFD9', 30, 39),
(3772, '9D2B71', 30, 39),
(3771, '937E8D', 30, 39),
(3770, '12', 40, 176),
(3769, '11', 40, 176),
(3768, '10', 40, 176),
(3767, '9', 40, 176),
(3766, 'D8663D', 40, 176),
(3765, '4301CA', 40, 176),
(3764, 'ED53A4', 40, 176),
(3763, '25AFD9', 40, 176),
(3762, '9D2B71', 40, 176),
(3761, '937E8D', 40, 176),
(3760, '12', 20, 58),
(3759, '11', 20, 58),
(3758, '10', 20, 58),
(3757, '9', 20, 58),
(3756, 'D8663D', 20, 58),
(3755, '4301CA', 20, 58),
(3754, 'ED53A4', 20, 58),
(3753, '25AFD9', 20, 58),
(3752, '9D2B71', 20, 58),
(3751, '937E8D', 20, 58),
(3750, '12', 15, 4),
(3749, '11', 15, 4),
(3748, '10', 15, 4),
(3747, '9', 15, 4),
(3746, 'D8663D', 15, 4),
(3745, '4301CA', 15, 4),
(3744, 'ED53A4', 15, 4),
(3743, '25AFD9', 15, 4),
(3742, '9D2B71', 15, 4),
(3741, '937E8D', 15, 4),
(3740, '12', 15, 16),
(3739, '11', 15, 16),
(3738, '10', 15, 16),
(3737, '9', 15, 16),
(3736, 'D8663D', 15, 16),
(3735, '4301CA', 15, 16),
(3734, 'ED53A4', 15, 16),
(3733, '25AFD9', 15, 16),
(3732, '9D2B71', 15, 16),
(3731, '937E8D', 15, 16),
(3730, '12', 20, 56),
(3729, '11', 20, 56),
(3728, '10', 20, 56),
(3727, '9', 20, 56),
(3726, 'D8663D', 20, 56),
(3725, '4301CA', 20, 56),
(3724, 'ED53A4', 20, 56),
(3723, '25AFD9', 20, 56),
(3722, '9D2B71', 20, 56),
(3721, '937E8D', 20, 56),
(4458, '10', 40, 238),
(4459, '11', 40, 238),
(4460, '12', 40, 238),
(4530, '12', 20, 38),
(4544, 'ED53A4', 10, 1),
(4545, '4301CA', 10, 1),
(4546, 'D8663D', 10, 1),
(4547, '9', 10, 1),
(4548, '10', 10, 1),
(4549, '11', 10, 1),
(4550, '12', 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `staffpermission`
--

CREATE TABLE IF NOT EXISTS `staffpermission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staffid` varchar(100) NOT NULL,
  `permissionid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=665 ;

--
-- Dumping data for table `staffpermission`
--

INSERT INTO `staffpermission` (`id`, `staffid`, `permissionid`) VALUES
(4, 'ClaimSync0003', 1),
(9, 'ClaimSync0001', 3),
(5, 'ClaimSync0009', 3),
(8, 'ClaimSync0001', 2),
(10, 'ClaimSync0001', 12),
(11, 'ClaimSync0001', 15),
(318, 'ClaimSync0008', 29),
(317, 'ClaimSync0008', 28),
(38, 'ClaimSync0007', 17),
(37, 'ClaimSync0007', 10),
(36, 'ClaimSync0007', 7),
(35, 'ClaimSync0007', 6),
(384, 'ClaimSync0006', 73),
(383, 'ClaimSync0006', 72),
(382, 'ClaimSync0006', 71),
(381, 'ClaimSync0006', 70),
(380, 'ClaimSync0006', 69),
(379, 'ClaimSync0006', 68),
(378, 'ClaimSync0006', 67),
(377, 'ClaimSync0006', 66),
(376, 'ClaimSync0006', 65),
(375, 'ClaimSync0006', 64),
(374, 'ClaimSync0006', 63),
(373, 'ClaimSync0006', 62),
(316, 'ClaimSync0008', 27),
(315, 'ClaimSync0008', 26),
(407, 'ClaimSync007', 26),
(406, 'ClaimSync007', 25),
(405, 'ClaimSync007', 24),
(404, 'ClaimSync007', 23),
(403, 'ClaimSync007', 22),
(372, 'ClaimSync0006', 61),
(371, 'ClaimSync0006', 60),
(370, 'ClaimSync0006', 59),
(369, 'ClaimSync0006', 58),
(368, 'ClaimSync0006', 57),
(367, 'ClaimSync0006', 56),
(366, 'ClaimSync0006', 55),
(365, 'ClaimSync0006', 54),
(364, 'ClaimSync0006', 53),
(363, 'ClaimSync0006', 52),
(362, 'ClaimSync0006', 51),
(361, 'ClaimSync0006', 50),
(360, 'ClaimSync0006', 49),
(359, 'ClaimSync0006', 48),
(358, 'ClaimSync0006', 47),
(357, 'ClaimSync0006', 46),
(356, 'ClaimSync0006', 45),
(355, 'ClaimSync0006', 44),
(354, 'ClaimSync0006', 43),
(353, 'ClaimSync0006', 42),
(352, 'ClaimSync0006', 41),
(351, 'ClaimSync0006', 40),
(350, 'ClaimSync0006', 39),
(349, 'ClaimSync0006', 38),
(348, 'ClaimSync0006', 37),
(347, 'ClaimSync0006', 36),
(346, 'ClaimSync0006', 35),
(345, 'ClaimSync0006', 34),
(344, 'ClaimSync0006', 33),
(343, 'ClaimSync0006', 32),
(342, 'ClaimSync0006', 31),
(341, 'ClaimSync0006', 30),
(340, 'ClaimSync0006', 29),
(339, 'ClaimSync0006', 28),
(338, 'ClaimSync0006', 27),
(337, 'ClaimSync0006', 26),
(336, 'ClaimSync0006', 25),
(335, 'ClaimSync0006', 24),
(334, 'ClaimSync0006', 23),
(333, 'ClaimSync0006', 22),
(332, 'ClaimSync0006', 21),
(331, 'ClaimSync0006', 18),
(330, 'ClaimSync0006', 17),
(329, 'ClaimSync0006', 16),
(328, 'ClaimSync0006', 15),
(327, 'ClaimSync0006', 14),
(326, 'ClaimSync0006', 12),
(325, 'ClaimSync0006', 11),
(324, 'ClaimSync0006', 10),
(323, 'ClaimSync0006', 9),
(322, 'ClaimSync0006', 8),
(321, 'ClaimSync0006', 7),
(320, 'ClaimSync0006', 6),
(402, 'ClaimSync007', 21),
(401, 'ClaimSync007', 15),
(400, 'ClaimSync007', 10),
(399, 'ClaimSync007', 8),
(398, 'ClaimSync007', 7),
(397, 'ClaimSync007', 6),
(314, 'ClaimSync0008', 25),
(313, 'ClaimSync0008', 24),
(312, 'ClaimSync0008', 23),
(311, 'ClaimSync0008', 22),
(310, 'ClaimSync0008', 21),
(309, 'ClaimSync0008', 15),
(308, 'ClaimSync0008', 10),
(307, 'ClaimSync0008', 9),
(306, 'ClaimSync0008', 8),
(305, 'ClaimSync0008', 7),
(304, 'ClaimSync0008', 6),
(319, 'ClaimSync0008', 75),
(385, 'ClaimSync0006', 74),
(386, 'ClaimSync0006', 75),
(387, 'ClaimSync0006', 76),
(388, 'ClaimSync0006', 77),
(389, 'ClaimSync0006', 78),
(390, 'ClaimSync0006', 79),
(391, 'ClaimSync0006', 80),
(392, 'ClaimSync0006', 81),
(393, 'ClaimSync0006', 82),
(394, 'ClaimSync0006', 83),
(395, 'ClaimSync0006', 84),
(396, 'ClaimSync0006', 85),
(408, 'ClaimSync007', 28),
(409, 'DL001', 6),
(410, 'DL001', 7),
(411, 'DL001', 8),
(412, 'DL001', 9),
(413, 'DL001', 11),
(414, 'DL001', 12),
(415, 'DL001', 14),
(416, 'DL001', 15),
(417, 'DL001', 16),
(418, 'DL001', 17),
(419, 'DL001', 18),
(420, 'DL001', 21),
(421, 'DL001', 22),
(422, 'DL001', 23),
(423, 'DL001', 24),
(424, 'DL001', 25),
(425, 'DL001', 26),
(426, 'DL001', 27),
(427, 'DL001', 28),
(428, 'DL001', 29),
(429, 'DL001', 30),
(430, 'DL001', 31),
(431, 'DL001', 32),
(432, 'DL001', 33),
(433, 'DL001', 34),
(434, 'DL001', 35),
(435, 'DL001', 36),
(436, 'DL001', 37),
(437, 'DL001', 38),
(438, 'DL001', 39),
(439, 'DL001', 40),
(440, 'DL001', 41),
(441, 'DL001', 42),
(442, 'DL001', 43),
(443, 'DL001', 44),
(444, 'DL001', 45),
(445, 'DL001', 46),
(446, 'DL001', 47),
(447, 'DL001', 48),
(448, 'DL001', 49),
(449, 'DL001', 50),
(450, 'DL001', 51),
(451, 'DL001', 52),
(452, 'DL001', 53),
(453, 'DL001', 54),
(454, 'DL001', 55),
(455, 'DL001', 56),
(456, 'DL001', 57),
(457, 'DL001', 58),
(458, 'DL001', 59),
(459, 'DL001', 60),
(460, 'DL001', 61),
(461, 'DL001', 62),
(462, 'DL001', 63),
(463, 'DL001', 64),
(464, 'DL001', 65),
(465, 'DL001', 66),
(466, 'DL001', 67),
(467, 'DL001', 68),
(468, 'DL001', 69),
(469, 'DL001', 70),
(470, 'DL001', 71),
(471, 'DL001', 72),
(472, 'DL001', 73),
(473, 'DL001', 74),
(474, 'DL001', 75),
(475, 'DL001', 76),
(476, 'DL001', 77),
(477, 'DL001', 78),
(478, 'DL001', 79),
(479, 'DL001', 80),
(480, 'DL001', 81),
(481, 'DL001', 82),
(482, 'DL001', 83),
(483, 'DL001', 84),
(484, 'DL001', 85),
(648, 'DL002', 33),
(647, 'DL002', 28),
(646, 'DL002', 27),
(645, 'DL002', 26),
(644, 'DL002', 25),
(643, 'DL002', 24),
(642, 'DL002', 23),
(641, 'DL002', 22),
(640, 'DL002', 21),
(639, 'DL002', 18),
(638, 'DL002', 17),
(637, 'DL002', 8),
(664, 'DL003', 29),
(663, 'DL003', 28),
(662, 'DL003', 27),
(661, 'DL003', 26),
(660, 'DL003', 25),
(659, 'DL003', 24),
(658, 'DL003', 23),
(657, 'DL003', 22),
(656, 'DL003', 21),
(655, 'DL003', 11),
(654, 'DL003', 9),
(653, 'DL003', 8),
(652, 'DL003', 7),
(651, 'DL003', 6),
(511, 'DL004', 6),
(512, 'DL004', 7),
(513, 'DL004', 8),
(514, 'DL004', 9),
(515, 'DL004', 14),
(516, 'DL004', 21),
(517, 'DL004', 22),
(518, 'DL004', 23),
(519, 'DL004', 24),
(520, 'DL004', 25),
(521, 'DL004', 26),
(522, 'DL004', 27),
(523, 'DL004', 28),
(524, 'DL004', 29),
(525, 'DL005', 6),
(526, 'DL005', 7),
(527, 'DL005', 8),
(528, 'DL005', 9),
(529, 'DL005', 21),
(530, 'DL005', 22),
(531, 'DL005', 23),
(532, 'DL005', 24),
(533, 'DL005', 25),
(534, 'DL005', 26),
(535, 'DL005', 27),
(536, 'DL005', 28),
(537, 'DL005', 29),
(538, 'DL006', 6),
(539, 'DL006', 7),
(540, 'DL006', 8),
(541, 'DL006', 9),
(542, 'DL006', 21),
(543, 'DL006', 22),
(544, 'DL006', 23),
(545, 'DL006', 24),
(546, 'DL006', 25),
(547, 'DL006', 26),
(548, 'DL006', 27),
(549, 'DL006', 28),
(550, 'DL006', 29),
(551, 'DL007', 6),
(552, 'DL007', 7),
(553, 'DL007', 8),
(554, 'DL007', 9),
(555, 'DL007', 11),
(556, 'DL007', 12),
(557, 'DL007', 14),
(558, 'DL007', 21),
(559, 'DL007', 22),
(560, 'DL007', 23),
(561, 'DL007', 24),
(562, 'DL007', 25),
(563, 'DL007', 26),
(564, 'DL007', 27),
(565, 'DL007', 28),
(566, 'DL007', 29),
(567, 'DL009', 6),
(568, 'DL009', 7),
(569, 'DL009', 8),
(570, 'DL009', 21),
(571, 'DL009', 22),
(572, 'DL009', 23),
(573, 'DL009', 24),
(574, 'DL009', 25),
(575, 'DL009', 26),
(576, 'DL009', 27),
(577, 'DL009', 28),
(607, 'DL010', 8),
(606, 'DL010', 7),
(605, 'DL010', 6),
(604, 'DL008', 28),
(603, 'DL008', 27),
(602, 'DL008', 26),
(601, 'DL008', 25),
(600, 'DL008', 24),
(599, 'DL008', 23),
(598, 'DL008', 22),
(597, 'DL008', 21),
(596, 'DL008', 9),
(595, 'DL008', 8),
(594, 'DL008', 7),
(593, 'DL008', 6),
(608, 'DL010', 9),
(609, 'DL010', 11),
(610, 'DL010', 17),
(611, 'DL010', 21),
(612, 'DL010', 22),
(613, 'DL010', 23),
(614, 'DL010', 24),
(615, 'DL010', 25),
(616, 'DL010', 26),
(617, 'DL010', 27),
(618, 'DL010', 28),
(619, 'DL010', 29),
(620, 'DL010', 75),
(636, 'DL002', 7),
(635, 'DL002', 6),
(649, 'DL002', 75),
(650, 'DL002', 76);

-- --------------------------------------------------------

--
-- Table structure for table `stafftable`
--

CREATE TABLE IF NOT EXISTS `stafftable` (
  `staffid` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `othername` varchar(255) DEFAULT NULL,
  `ssn` varchar(255) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `placeofbirth` varchar(255) DEFAULT NULL,
  `yearofemployment` varchar(4) DEFAULT NULL,
  `role` int(11) NOT NULL,
  `extraduty` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `nextofkin` varchar(255) DEFAULT NULL,
  `nextofkincontact` varchar(255) DEFAULT NULL,
  `unit` int(11) NOT NULL,
  `imglocation` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`staffid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stafftable`
--

INSERT INTO `stafftable` (`staffid`, `lastname`, `othername`, `ssn`, `gender`, `email`, `dob`, `placeofbirth`, `yearofemployment`, `role`, `extraduty`, `address`, `contact`, `nextofkin`, `nextofkincontact`, `unit`, `imglocation`, `active`) VALUES
('ClaimSync0001', 'McSey', 'Kofi', 'F178508250011', 'Male', 'N/A', '1985-08-25', 'Cape Coast', '2012', 3, 'Surgeon', 'St 19 Banana', '0264281623', 'Rebecca Osei', '0244500990', 1, '', 1),
('ClaimSync0002', 'Addo-Yirenkyi', 'Emmanuel', 'F178508250013', 'Male', 'emma.kombat@gmail.com', '1986-06-18', 'Switzerland', '2010', 8, 'Front Desk', 'La Paz', '0243333222', 'Lord Addo-Yirenkyi', '0243823458', 14, '', 1),
('ClaimSync0003', 'Nubuor', 'Ebenezer Isaac', 'F178508250012', 'Male', 'enubuor@gmail.com', '1983-10-14', 'Mepe', '2010', 2, 'Cashier', 'La', '0244555333', 'Princess', '0243823458', 14, '', 1),
('ClaimSync0004', 'Appah', 'Rosemary', 'F178508250014', 'Male', 'r.a@gamil.com', '1989-07-13', 'Accra', '2012', 5, 'Pharmacist', 'Nugua', '0244555333', 'Frederick Baidoo', '0243823458', 1, '', 1),
('ClaimSync0005', 'Nyamekye', 'Levitis', 'F178508250015', 'Female', 'lev@gmail.com', '1989-03-03', 'Kumasi', '2012', 7, 'OPD', 'Kumasi', '0264281623', 'Seth Akumani', '0243823458', 14, '', 1),
('ClaimSync0006', 'Akumani', 'Mawuse', 'F178508250016', 'Male', 'ak@gmail.com', '1982-07-07', 'Kaneshie', '2008', 13, 'Scrutiner', 'Lomena Va', '0231222333', 'Patienct Akumani', '0234985230', 3, '', 1),
('ClaimSync0008', 'Nathan', 'Aaron', 'F178508250018', 'Male', 'aaron@gmail.com', '1982-09-09', 'Accra', '2012', 6, 'Scrutizer', 'Sowotuom', '0264646464', 'Nathen Junior', '0243823458', 5, '', 1),
('ClaimSync0009', 'Edumadze', 'John', 'F178508250019', 'Male', 'edumadze@claimsync.com', '1976-06-06', 'Cape Coast', '2008', 1, 'IT Manager', 'Cape Coast', '0264444444', 'Janet Edumadze', '0243823458', 3, '', 1),
('ClaimSync007', 'Pablo', 'Adwoa', '0012143243', 'Female', 'eyirenkyi@claimsync.com', '1986-07-06', 'Accra', '2012', 9, '', 'No. 19 Banana Street', '0246002991', 'Ms. Baning', '0246002992', 5, '', 1),
('DL001', 'Antobre', 'Osei', 'N/A', 'Male', 'antobre@yahoo.com', '1980-06-04', 'Kumasi', '2000', 13, '', 'P.O.Box TS 73 Teshie', '0264757574', 'Mrs. Elizabeth Antobre', '0244452600', 5, '', 1),
('DL002', 'Sappor', 'Pearl', 'N/A', 'Female', 'N/A', '1990-05-26', 'Accra', '2013', 9, '', 'Danpong Clinic', '0266605907', 'Mr. Obed Sappor', '0234881287', 5, '', 1),
('DL003', 'Nsowah', 'Natalie ', 'N/A', 'Female', 'nathaliensowah@yahoo.com', '1980-12-01', 'Accra', '2013', 6, '', 'Danpong Clinic', '0248521743', 'Charles Twumasi', '0269060258', 5, '', 1),
('DL004', 'Zumakpeh', 'Jonathan', 'N/A', 'Male', 'herosmithj@gmail.com', '1988-07-30', 'Tamale', '2013', 6, '', 'Accra', '0208608863', 'Josephine Zumakpeh', '0264414716', 5, '', 1),
('DL005', 'Annang', 'Laud 0.', 'N/A', 'Male', 'N/A', '1975-04-11', 'Accra', '2008', 6, '', 'Accra', '0200624302', 'Salomey Borkeley', '0246046667', 5, '', 1),
('DL006', 'Akpablie', 'Wisdom K.', 'N/A', 'Male', 'N/A', '1975-04-05', 'accra', '2004', 6, '', 'Accra', '0542384154', 'Mavis Akpablie', '0546847807', 5, '', 1),
('DL007', 'Tetteh-Ocloo', 'Victor', 'N/A', 'Male', 'veeqtor@yahoo.com', '1979-04-09', 'Accra', '2006', 6, '', 'Accra', '0243138741', 'Aseye Tetteh-Ocloo', '0243269495', 5, '', 1),
('DL008', 'Annor', 'Gifty Nana Ama', 'N/A', 'Female', 'N/A', '1984-04-24', 'Accra', '2009', 9, '', 'Accra', '0276134033', 'Samuel Gyampoh', '0242747785', 5, '', 1),
('DL010', 'Patterson', 'Eric Anyetei', 'N/A', 'Male', '', '1977-11-17', 'accra', '2004', 6, '', 'accra', '0208983578', 'Abigail Patterson', '0277577214', 5, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `stock_control`
--

CREATE TABLE IF NOT EXISTS `stock_control` (
  `stock_control_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_code` varchar(100) NOT NULL,
  `quantity_on_hand` int(11) NOT NULL,
  `date` date NOT NULL,
  `staff_id` varchar(100) NOT NULL,
  PRIMARY KEY (`stock_control_id`),
  KEY `staff_id` (`staff_id`),
  KEY `item_code` (`item_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `stock_control`
--


-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE IF NOT EXISTS `supplier` (
  `supplierid` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `address` text NOT NULL,
  `telephone` text,
  `email` text,
  PRIMARY KEY (`supplierid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`supplierid`, `name`, `address`, `telephone`, `email`) VALUES
(1, 'Ernest Chemist', 'No. 15 Kwaku Street', '02446002991', 'eyirenkyi@claimsync.com');

-- --------------------------------------------------------

--
-- Table structure for table `symptoms`
--

CREATE TABLE IF NOT EXISTS `symptoms` (
  `symptomid` int(11) NOT NULL AUTO_INCREMENT,
  `symptomname` varchar(255) NOT NULL,
  PRIMARY KEY (`symptomid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=35 ;

--
-- Dumping data for table `symptoms`
--

INSERT INTO `symptoms` (`symptomid`, `symptomname`) VALUES
(1, 'Exhaustion'),
(2, 'Wheeziness'),
(3, 'Nausia');

-- --------------------------------------------------------

--
-- Table structure for table `therapeutic_group`
--

CREATE TABLE IF NOT EXISTS `therapeutic_group` (
  `theraid` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  PRIMARY KEY (`theraid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `therapeutic_group`
--

INSERT INTO `therapeutic_group` (`theraid`, `description`) VALUES
(2, 'Anti Malaria');

-- --------------------------------------------------------

--
-- Table structure for table `transferlocation`
--

CREATE TABLE IF NOT EXISTS `transferlocation` (
  `transferid` int(11) NOT NULL AUTO_INCREMENT,
  `visitid` int(11) NOT NULL,
  `visitdate` date NOT NULL,
  `location` varchar(255) NOT NULL,
  `doctorid` varchar(255) NOT NULL,
  `diagnosisid` int(11) NOT NULL,
  `note` text,
  PRIMARY KEY (`transferid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `transferlocation`
--


-- --------------------------------------------------------

--
-- Table structure for table `transition_order`
--

CREATE TABLE IF NOT EXISTS `transition_order` (
  `transition_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(255) NOT NULL,
  `patient_id` varchar(255) NOT NULL,
  `date_of_order` date NOT NULL,
  `pharmacy_id` varchar(255) NOT NULL,
  PRIMARY KEY (`transition_id`),
  KEY `pharmacy_id` (`pharmacy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `transition_order`
--


-- --------------------------------------------------------

--
-- Table structure for table `transit_clinic_labs`
--

CREATE TABLE IF NOT EXISTS `transit_clinic_labs` (
  `orderid` varchar(100) NOT NULL,
  `patientid` varchar(50) NOT NULL,
  `fromdoc` varchar(255) NOT NULL,
  `orderdate` datetime NOT NULL,
  `visitid` int(11) NOT NULL,
  `done` varchar(20) NOT NULL,
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transit_clinic_labs`
--

INSERT INTO `transit_clinic_labs` (`orderid`, `patientid`, `fromdoc`, `orderdate`, `visitid`, `done`) VALUES
('13TLA1', '13DC1', 'ClaimSync0009', '2013-11-06 15:31:11', 2, 'Forwarded'),
('13TLA10', '13DC17', 'ClaimSync0009', '2013-11-25 08:44:40', 10, 'Clinic'),
('13TLA11', '13DC1', 'ClaimSync0001', '2013-12-09 04:29:57', 1, 'Clinic'),
('13TLA12', '13DC2', 'ClaimSync0001', '2013-12-09 07:28:26', 2, 'Clinic'),
('13TLA2', '13DC9', 'ClaimSync0009', '2013-11-07 13:37:13', 4, 'Clinic'),
('13TLA3', '13DC1', 'ClaimSync0009', '2013-11-12 23:55:53', 2, 'Clinic'),
('13TLA4', '13DC1', 'ClaimSync0001', '2013-11-13 00:16:02', 2, 'Clinic'),
('13TLA5', '13DC9', 'ClaimSync0001', '2013-11-13 00:25:06', 4, 'Clinic'),
('13TLA6', '13DC8', 'ClaimSync0009', '2013-11-14 00:47:05', 6, 'Clinic'),
('13TLA7', '13dc10', 'ClaimSync0001', '2013-11-14 12:20:04', 7, 'Clinic'),
('13TLA8', '13DC18', 'ClaimSync0009', '2013-11-14 14:17:52', 11, 'Clinic'),
('13TLA9', '13DC15', 'ClaimSync0001', '2013-11-25 08:17:34', 9, 'Clinic');

-- --------------------------------------------------------

--
-- Table structure for table `treatment_options`
--

CREATE TABLE IF NOT EXISTS `treatment_options` (
  `treatment_id` int(11) NOT NULL AUTO_INCREMENT,
  `treatment` varchar(255) NOT NULL,
  PRIMARY KEY (`treatment_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `treatment_options`
--

INSERT INTO `treatment_options` (`treatment_id`, `treatment`) VALUES
(2, 'Sleep'),
(3, 'Took a pill');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE IF NOT EXISTS `units` (
  `unitid` int(11) NOT NULL AUTO_INCREMENT,
  `unitname` varchar(200) NOT NULL,
  `type` varchar(200) NOT NULL,
  PRIMARY KEY (`unitid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`unitid`, `unitname`, `type`) VALUES
(14, 'OPD', 'vitals'),
(5, 'Laboratory', 'lab'),
(8, 'Cashier', 'account'),
(7, 'Records', 'records'),
(21, 'Dispensary', 'pharmacy');

-- --------------------------------------------------------

--
-- Table structure for table `units_of_measure`
--

CREATE TABLE IF NOT EXISTS `units_of_measure` (
  `unit_id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(45) NOT NULL,
  `unit_description` text NOT NULL,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `units_of_measure`
--

INSERT INTO `units_of_measure` (`unit_id`, `unit_name`, `unit_description`) VALUES
(1, 'PACKS', 'Tablets'),
(2, 'CAPSULE', 'Capsule');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `username` varchar(100) NOT NULL,
  `password` varchar(512) NOT NULL,
  `staffid` varchar(100) NOT NULL,
  `temporal` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `password`, `staffid`, `temporal`) VALUES
('Addo-Yirenkyi21', 'jp4UtiVA1I0BzxtkAvTbUEHuFzpwOt3olaZuU2fiKhY=$NQNuueJaHLNlmJw6JVctaCHGGzrHh8UxLA2Hn6Znccs=', 'ClaimSync0002', 0),
('Akpablie151', 'WxZs3GdXfCzuhyIWNMGDa0f+HsuD1FQIxEBJErcqu14=$RDywFRGeBK6mY7JlGTELKVPCCVUuLRYOG8hKGHENgpU=', 'DL006', 0),
('Akumani61', 'mEG3aIKsC2J90xbUE4mrhKR5RpGq1n5qTDSqWC4Pac8=$NE354pPtGPtZSZ5ryYioe6qXn1enVGHsjKToJW96Chk=', 'ClaimSync0006', 0),
('Annang141', 'PcQXcqkF/RWJLIhsehoLAY9ebFEgPgXKrLl5kNMQB2Y=$1zC/A9o5tExTfqQeM2O+PA/qSeV/DGevdDTQ5hx/P7M=', 'DL005', 0),
('Annor171', 'nCc9UT7SMqm6dw7qJ4aWJqamXplGw4gpuCKlvC9IeOY=$xtJXP80LDFGIRJ3QydkIsNrp/mDAP9iOhlTHBJJFj1w=', 'DL008', 0),
('Antobre101', '2coWrVZ7/GvC5moyvO8P62u1t6r0ICz/HWA8QJnLomw=$s1HLDo37OeALowIahdJKbz2JCvO2QiqcpRS0rUFPTl0=', 'DL001', 0),
('Appah41', 'znZ4jxz4YQw57yQ/7nTz7M0TMQPxK7cowRQ4xtr1auA=$XssAD3zQfDq5rY4y6NbfHNUNNNy/7MfEK0i+hPmot5c=', 'ClaimSync0004', 0),
('Edumadze91', 'ASo01BOczVwAH0djeVsWKkiFM6q05qHsvhljrp02IlM=$IcsPV3eIpRLwY/NwMufKRgYt9YMCHlGey4DV8xz2aIE=', 'ClaimSync0009', 0),
('McSey11', 'kWal2fBi/UUG8OAvzCFLiNneiwOlHjIS0k2S8ExXB3o=$vkNLF6YQGu7ttHdf1PpmMyzqxZCicVxIDsBrJQnltAU=', 'ClaimSync0001', 0),
('Nathan81', 'M8IILmaL6YPAVa/rcgks5Ar/BaL4C8JBnbHpebmQw9M=$8T4X7udPiAPTh0kKv4W2QkOuTS5pWaIwr6RjTKUzUQs=', 'ClaimSync0008', 0),
('Nsowah121', 'w8Qh3RWZLAB2MseqvqiCHFK7Uahh5s+OIeYJYYu9rcc=$cTZ0s81FGxEW+d6J/yw6tv+LjI0IMXA36+9X2HghZUo=', 'DL003', 0),
('Nubuor31', 'D3xAAM1sEjJ9QQCWgpIkev1CVPc6feago9FlK2CS5TI=$C6MZS9SGnhKYg6YybjBo2H4miopRiH0wxNeU8DCwpVY=', 'ClaimSync0003', 0),
('Nyamekye51', 'rgUePHXnsTauMV7AOfgujdDbIgewLg32bvt3+O7yrGY=$eJzwmVq4qRyvGxSYCCXxQ2wIVrrJCRXWxJAEPwJY7YA=', 'ClaimSync0005', 0),
('Pablo91', 'qmYfEBM08CiqxJAhHhA7EKn+Qu2Z1p1w6xFFunHmTo4=$T5T3jGN+1OKuCrTYcxAFtfu6kkMziQ7Myfeio+IF95s=', 'ClaimSync007', 0),
('Patterson181', 'z0JoVpQjtaAyfY0HZe7T34JKQtWGT2MctNFBpR4HdqY=$E+SAAvo+9BAbb0iLptFw+udtYab8Cu/9H1XwNXBtoZM=', 'DL010', 0),
('Sappor111', 'uyRmR8Z0JF6wOfsczFqOKCZBiCDK9mP+GKcsmd+ySGw=$mGIR6kqoG8ouBBr/NXD2rTBv9id3uVMANpK43jLImCg=', 'DL002', 0),
('Tetteh-Ocloo161', 'mQk8YgKGvupBgfIP3BSViS9hh9AeIXO79jEmRtOxwwU=$Wib0mWG7i0/zxOkettFnToTsz2QSbFmTBoS+I7TTHOs=', 'DL007', 0),
('Zumakpeh131', 'xWOSZgXx+z4ZjT3KgsK2hssC5sEhYedKStoPSrTk6lE=$g8ChbMPPgGXWLO0e66uwT/t9ekCNGW6IOpgBqeztfM8=', 'DL004', 0);

-- --------------------------------------------------------

--
-- Table structure for table `visitationtable`
--

CREATE TABLE IF NOT EXISTS `visitationtable` (
  `visitid` int(11) NOT NULL AUTO_INCREMENT,
  `patientid` varchar(100) NOT NULL,
  `date` date DEFAULT NULL,
  `vitals` text,
  `doctor` varchar(100) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `patientstatus` varchar(255) DEFAULT NULL,
  `admissiondate` datetime DEFAULT NULL,
  `dischargedate` date DEFAULT NULL,
  `previouslocstion` varchar(255) DEFAULT NULL,
  `visittype` int(11) NOT NULL,
  `notes` text,
  `review` tinyint(1) NOT NULL,
  `month` varchar(100) NOT NULL,
  `year` varchar(100) NOT NULL,
  `total_bill` double NOT NULL,
  `total_amount_paid` double NOT NULL,
  `deposited_amount` double NOT NULL,
  PRIMARY KEY (`visitid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `visitationtable`
--

INSERT INTO `visitationtable` (`visitid`, `patientid`, `date`, `vitals`, `doctor`, `status`, `patientstatus`, `admissiondate`, `dischargedate`, `previouslocstion`, `visittype`, `notes`, `review`, `month`, `year`, `total_bill`, `total_amount_paid`, `deposited_amount`) VALUES
(1, '13DC1', '2013-12-09', '', 'ClaimSync0001', 'records', 'Out Patient', NULL, NULL, 'consultation', 1, '', 1, 'Dec', '2013', 95, 55, 0),
(2, '13DC2', '2013-12-09', '', 'ClaimSync0001', 'ward_1', 'In Patient', '2013-12-09 07:28:27', NULL, 'Clinic', 1, '', 1, 'Dec', '2013', 95, 55, 0);

-- --------------------------------------------------------

--
-- Table structure for table `visit_symptoms`
--

CREATE TABLE IF NOT EXISTS `visit_symptoms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visitid` int(11) NOT NULL,
  `patientid` text NOT NULL,
  `symptomid` int(11) NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `visit_symptoms`
--

INSERT INTO `visit_symptoms` (`id`, `visitid`, `patientid`, `symptomid`, `note`) VALUES
(1, 1, '13DC1', 1, ''),
(2, 4, '13DC4', 1, ''),
(3, 1, '13DC1', 1, ''),
(4, 2, '13DC2', 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `vitalcheck`
--

CREATE TABLE IF NOT EXISTS `vitalcheck` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visitid` int(11) NOT NULL,
  `pressure` double NOT NULL,
  `temperature` double NOT NULL,
  `systolic` double NOT NULL,
  `diatolic` double NOT NULL,
  `time` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `vitalcheck`
--

INSERT INTO `vitalcheck` (`id`, `visitid`, `pressure`, `temperature`, `systolic`, `diatolic`, `time`) VALUES
(1, 2, 120, 37.9, 100, 90, '07:58:01 AM');

-- --------------------------------------------------------

--
-- Table structure for table `vitaltable`
--

CREATE TABLE IF NOT EXISTS `vitaltable` (
  `vitalid` int(11) NOT NULL,
  `patientid` varchar(100) NOT NULL,
  `temperature` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `sistolic` double DEFAULT NULL,
  `diatolic` double DEFAULT NULL,
  `pulse` double DEFAULT NULL,
  `other_symptons` text,
  `date` date NOT NULL,
  PRIMARY KEY (`vitalid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vitaltable`
--

INSERT INTO `vitaltable` (`vitalid`, `patientid`, `temperature`, `height`, `weight`, `sistolic`, `diatolic`, `pulse`, `other_symptons`, `date`) VALUES
(1, '13DC1', 37, 90, 120, 129, 120, 120, NULL, '2013-12-09'),
(2, '13DC2', 35, 120, 200, 120, 90, 120, NULL, '2013-12-09');

-- --------------------------------------------------------

--
-- Table structure for table `ward`
--

CREATE TABLE IF NOT EXISTS `ward` (
  `wardid` int(11) NOT NULL AUTO_INCREMENT,
  `wardname` varchar(255) NOT NULL,
  `numberofbeds` int(11) NOT NULL DEFAULT '0',
  `occupied` int(11) NOT NULL DEFAULT '0',
  `cost` double NOT NULL,
  `type` varchar(200) NOT NULL,
  PRIMARY KEY (`wardid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `ward`
--

INSERT INTO `ward` (`wardid`, `wardname`, `numberofbeds`, `occupied`, `cost`, `type`) VALUES
(1, 'Female Ward', 8, 3, 25, 'ward'),
(2, 'Private Ward', 1, 4, 35, 'ward'),
(3, 'Male Ward', 6, 4, 25, 'ward'),
(4, 'Children Ward', 4, 0, 25, 'ward');

-- --------------------------------------------------------

--
-- Table structure for table `wardnote`
--

CREATE TABLE IF NOT EXISTS `wardnote` (
  `noteid` int(11) NOT NULL AUTO_INCREMENT,
  `wardid` int(11) NOT NULL,
  `nurseid` varchar(255) DEFAULT NULL,
  `note` text NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`noteid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `wardnote`
--


-- --------------------------------------------------------

--
-- Table structure for table `ware_house`
--

CREATE TABLE IF NOT EXISTS `ware_house` (
  `ware_house_id` int(11) NOT NULL AUTO_INCREMENT,
  `ware_house_name` varchar(45) NOT NULL,
  `ware_house_description` text NOT NULL,
  PRIMARY KEY (`ware_house_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ware_house`
--


--
-- Constraints for dumped tables
--

--
-- Constraints for table `dispensary_batch`
--
ALTER TABLE `dispensary_batch`
  ADD CONSTRAINT `dispensary_batch_ibfk_2` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dispensary_batch_ibfk_3` FOREIGN KEY (`item_code`) REFERENCES `dispensary_items` (`item_code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dispensary_items`
--
ALTER TABLE `dispensary_items`
  ADD CONSTRAINT `dispensary_items_ibfk_1` FOREIGN KEY (`item_code`) REFERENCES `inventory_items` (`item_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dispensary_items_ibfk_2` FOREIGN KEY (`form_id`) REFERENCES `item_form` (`form_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dispensary_items_ibfk_3` FOREIGN KEY (`unit_of_issue`) REFERENCES `units_of_measure` (`unit_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `dispensary_items_ibfk_4` FOREIGN KEY (`therapeutic_group`) REFERENCES `therapeutic_group` (`theraid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dosage`
--
ALTER TABLE `dosage`
  ADD CONSTRAINT `dosage_ibfk_2` FOREIGN KEY (`item_code`) REFERENCES `inventory_items` (`item_code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `general_stock_movement`
--
ALTER TABLE `general_stock_movement`
  ADD CONSTRAINT `general_stock_movement_ibfk_1` FOREIGN KEY (`pharmacy_batch_number`) REFERENCES `pharmacy_batch` (`item_batch`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `general_stock_movement_ibfk_2` FOREIGN KEY (`dispensary_batch_number`) REFERENCES `dispensary_batch` (`item_batch`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `general_stock_movement_ibfk_3` FOREIGN KEY (`issued_by`) REFERENCES `stafftable` (`staffid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `general_stock_movement_ibfk_4` FOREIGN KEY (`issued_to`) REFERENCES `stafftable` (`staffid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `inventory_items`
--
ALTER TABLE `inventory_items`
  ADD CONSTRAINT `inventory_items_ibfk_1` FOREIGN KEY (`form_id`) REFERENCES `item_form` (`form_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inventory_items_ibfk_2` FOREIGN KEY (`unit_of_issue`) REFERENCES `units_of_measure` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inventory_items_ibfk_3` FOREIGN KEY (`therapeutic_group`) REFERENCES `therapeutic_group` (`theraid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `inventory_transfer`
--
ALTER TABLE `inventory_transfer`
  ADD CONSTRAINT `inventory_transfer_ibfk_1` FOREIGN KEY (`initiating_staff`) REFERENCES `stafftable` (`staffid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inventory_transfer_ibfk_2` FOREIGN KEY (`reveiving_staff`) REFERENCES `stafftable` (`staffid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inventory_transfer_ibfk_3` FOREIGN KEY (`approved_by`) REFERENCES `stafftable` (`staffid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inventory_transfer_ibfk_4` FOREIGN KEY (`approve_by_second`) REFERENCES `stafftable` (`staffid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`orderid`) REFERENCES `purchase_order` (`purchase_order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoice_ibfk_2` FOREIGN KEY (`received_by`) REFERENCES `stafftable` (`staffid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoice_ibfk_3` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplierid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `item_batch`
--
ALTER TABLE `item_batch`
  ADD CONSTRAINT `item_batch_ibfk_1` FOREIGN KEY (`item_code`) REFERENCES `inventory_items` (`item_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `item_batch_ibfk_2` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `laboratory_batch`
--
ALTER TABLE `laboratory_batch`
  ADD CONSTRAINT `laboratory_batch_ibfk_1` FOREIGN KEY (`item_code`) REFERENCES `laboratory_item` (`item_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `laboratory_batch_ibfk_2` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `laboratory_item`
--
ALTER TABLE `laboratory_item`
  ADD CONSTRAINT `laboratory_item_ibfk_1` FOREIGN KEY (`item_code`) REFERENCES `inventory_items` (`item_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `laboratory_item_ibfk_2` FOREIGN KEY (`form_id`) REFERENCES `item_form` (`form_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `laboratory_item_ibfk_3` FOREIGN KEY (`unit_of_issue`) REFERENCES `units_of_measure` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `laboratory_item_ibfk_4` FOREIGN KEY (`therapeutic_group`) REFERENCES `therapeutic_group` (`theraid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `patienttreatment`
--
ALTER TABLE `patienttreatment`
  ADD CONSTRAINT `patienttreatment_ibfk_1` FOREIGN KEY (`dosage`) REFERENCES `dosage` (`dosage_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `patienttreatment_ibfk_2` FOREIGN KEY (`orderid`) REFERENCES `pharmorder` (`orderid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `patienttreatment_ibfk_3` FOREIGN KEY (`transition_id`) REFERENCES `transition_order` (`transition_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `patienttreatment_ibfk_4` FOREIGN KEY (`pharmacy_order_id`) REFERENCES `pharmacyorder` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `patienttreatment_ibfk_5` FOREIGN KEY (`pharmacy_item_code`) REFERENCES `pharmacy_item` (`item_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `patienttreatment_ibfk_6` FOREIGN KEY (`dispensary_item_code`) REFERENCES `dispensary_items` (`item_code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `patient_treatment_batch`
--
ALTER TABLE `patient_treatment_batch`
  ADD CONSTRAINT `patient_treatment_batch_ibfk_1` FOREIGN KEY (`patient_treatment_id`) REFERENCES `patienttreatment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `patient_treatment_batch_ibfk_2` FOREIGN KEY (`batch_number`) REFERENCES `dispensary_batch` (`item_batch`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pharmacyorder`
--
ALTER TABLE `pharmacyorder`
  ADD CONSTRAINT `pharmacyorder_ibfk_1` FOREIGN KEY (`dispensed_by`) REFERENCES `stafftable` (`staffid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pharmacyorder_ibfk_2` FOREIGN KEY (`pharmacist`) REFERENCES `stafftable` (`staffid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pharmacyorder_ibfk_3` FOREIGN KEY (`client_info_id`) REFERENCES `client_info` (`unique_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pharmacyorder_ibfk_4` FOREIGN KEY (`staff_id`) REFERENCES `stafftable` (`staffid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pharmacy_batch`
--
ALTER TABLE `pharmacy_batch`
  ADD CONSTRAINT `pharmacy_batch_ibfk_1` FOREIGN KEY (`item_code`) REFERENCES `pharmacy_item` (`item_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pharmacy_batch_ibfk_2` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pharmacy_item`
--
ALTER TABLE `pharmacy_item`
  ADD CONSTRAINT `pharmacy_item_ibfk_1` FOREIGN KEY (`item_code`) REFERENCES `inventory_items` (`item_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pharmacy_item_ibfk_2` FOREIGN KEY (`form_id`) REFERENCES `item_form` (`form_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pharmacy_item_ibfk_3` FOREIGN KEY (`unit_of_issue`) REFERENCES `units_of_measure` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pharmacy_item_ibfk_4` FOREIGN KEY (`therapeutic_group`) REFERENCES `therapeutic_group` (`theraid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `purchase_order`
--
ALTER TABLE `purchase_order`
  ADD CONSTRAINT `purchase_order_ibfk_1` FOREIGN KEY (`approved_by_manager`) REFERENCES `stafftable` (`staffid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `purchase_order_ibfk_2` FOREIGN KEY (`approved_by_account`) REFERENCES `stafftable` (`staffid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `purchase_order_ibfk_3` FOREIGN KEY (`ordering_staff`) REFERENCES `stafftable` (`staffid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `purchase_order_items`
--
ALTER TABLE `purchase_order_items`
  ADD CONSTRAINT `purchase_order_items_ibfk_1` FOREIGN KEY (`orderid`) REFERENCES `purchase_order` (`purchase_order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `purchase_order_items_ibfk_2` FOREIGN KEY (`item_code`) REFERENCES `inventory_items` (`item_code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `requisition`
--
ALTER TABLE `requisition`
  ADD CONSTRAINT `requisition_ibfk_1` FOREIGN KEY (`item_code`) REFERENCES `inventory_items` (`item_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `requisition_ibfk_2` FOREIGN KEY (`requested_by`) REFERENCES `stafftable` (`staffid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `requisition_ibfk_3` FOREIGN KEY (`request_approved_by`) REFERENCES `stafftable` (`staffid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `requisition_ibfk_4` FOREIGN KEY (`delivered_by`) REFERENCES `stafftable` (`staffid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `requisition_ibfk_5` FOREIGN KEY (`delivery_approved_by`) REFERENCES `stafftable` (`staffid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transition_order`
--
ALTER TABLE `transition_order`
  ADD CONSTRAINT `transition_order_ibfk_1` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmorder` (`orderid`) ON DELETE CASCADE ON UPDATE CASCADE;
