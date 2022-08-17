-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 23, 2022 at 07:11 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `landmarks`
--

-- --------------------------------------------------------

--
-- Table structure for table `behaviour`
--

CREATE TABLE IF NOT EXISTS `behaviour` (
  `behaviour_id` int(11) NOT NULL,
  `behaviour_type_id` int(11) NOT NULL,
  `visit_id` int(11) NOT NULL,
  `behaviour_data` varchar(250) NOT NULL COMMENT 'this might be anything - e.g. the URL of a page returned to, the amount of scrolling, etc. Open ended now, might need to make it more structured later',
  `datetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`behaviour_id`),
  KEY `behaviour_type_id` (`behaviour_type_id`),
  KEY `visit_id` (`visit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='to track things like scrolling, clicking, etc';

-- --------------------------------------------------------

--
-- Table structure for table `behaviour_type`
--

CREATE TABLE IF NOT EXISTS `behaviour_type` (
  `behaviour_type_id` int(11) NOT NULL,
  `behaviour_description` int(11) NOT NULL,
  PRIMARY KEY (`behaviour_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `experiment`
--

CREATE TABLE IF NOT EXISTS `experiment` (
  `experiment_id` int(11) NOT NULL,
  `experiment_name` varchar(30) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `owner_id` int(11) NOT NULL,
  `text_id` int(11) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` int(11) NOT NULL,
  PRIMARY KEY (`experiment_id`),
  KEY `owner_id` (`owner_id`),
  KEY `text_id` (`text_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `experimental_treatment`
--

CREATE TABLE IF NOT EXISTS `experimental_treatment` (
  `treatment_id` int(11) NOT NULL,
  `experiment_id` int(11) NOT NULL,
  `ratio` int(11) NOT NULL COMMENT 'this can be any arbitrary number - the idea is to use it for a random seed to choose which experimental treatment is received for each visit',
  PRIMARY KEY (`treatment_id`,`experiment_id`),
  KEY `experiment_id` (`experiment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

CREATE TABLE IF NOT EXISTS `quiz` (
  `quiz_id` int(11) NOT NULL,
  `text_id` int(11) NOT NULL,
  `quiz_name` varchar(50) NOT NULL,
  PRIMARY KEY (`quiz_id`),
  KEY `text_id` (`text_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_answer`
--

CREATE TABLE IF NOT EXISTS `quiz_answer` (
  `qq_id` int(11) NOT NULL,
  `quiz_answer_id` int(11) NOT NULL,
  `answer` varchar(250) NOT NULL,
  `hint` varchar(250) NOT NULL,
  `correct` tinyint(1) NOT NULL,
  PRIMARY KEY (`quiz_answer_id`),
  KEY `qq_id` (`qq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_attempt`
--

CREATE TABLE IF NOT EXISTS `quiz_attempt` (
  `quiz_attempt_id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `visit_id` int(11) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`quiz_attempt_id`),
  KEY `quiz_id` (`quiz_id`),
  KEY `visit_id` (`visit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_question`
--

CREATE TABLE IF NOT EXISTS `quiz_question` (
  `quiz_id` int(11) NOT NULL,
  `qq_id` int(11) NOT NULL,
  `question` varchar(150) NOT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`qq_id`),
  KEY `quiz_id` (`quiz_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_response`
--

CREATE TABLE IF NOT EXISTS `quiz_response` (
  `quiz_response_id` int(11) NOT NULL,
  `qq_id` int(11) NOT NULL,
  `quiz_attempt_id` int(11) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `attempt_time` int(11) NOT NULL COMMENT 'seconds to complete',
  `quiz_answer_id` int(250) NOT NULL,
  PRIMARY KEY (`quiz_response_id`),
  KEY `qq_id` (`qq_id`),
  KEY `quiz_attempt_id` (`quiz_attempt_id`),
  KEY `quiz_answer_id` (`quiz_answer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `text`
--

CREATE TABLE IF NOT EXISTS `text` (
  `text_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `url` varchar(100) NOT NULL,
  `licence` varchar(30) NOT NULL,
  `subject` varchar(30) NOT NULL,
  `owner_id` int(11) NOT NULL,
  PRIMARY KEY (`text_id`),
  KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `treatment`
--

CREATE TABLE IF NOT EXISTS `treatment` (
  `treatment_id` int(11) NOT NULL,
  `treatment_type_id` int(11) NOT NULL,
  `treatment_name` varchar(20) NOT NULL,
  `treatment_scope` varchar(20) NOT NULL COMMENT 'this relates to whether it affects the whole document, a paragraph, a section, etc',
  PRIMARY KEY (`treatment_id`),
  KEY `treatment_type_id` (`treatment_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `treatment_parameter`
--

CREATE TABLE IF NOT EXISTS `treatment_parameter` (
  `parameter_id` int(11) NOT NULL,
  `treatment_id` int(11) NOT NULL,
  `parameter_type` varchar(30) NOT NULL COMMENT 'should align with whatever the code uses to identify different things that can change in a treatment',
  `text_parameter` varchar(30) NOT NULL COMMENT 'e.g. the algorithm or some other kind of textual way of describing a treatment',
  `num_parameter` int(11) NOT NULL COMMENT 'a numeric parameter such as transparency or weight',
  PRIMARY KEY (`parameter_id`),
  KEY `treatment_id` (`treatment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `treatment_scope`
--

CREATE TABLE IF NOT EXISTS `treatment_scope` (
  `treatment_scope_id` int(11) NOT NULL,
  `treatment_id` int(11) NOT NULL,
  `scope` varchar(20) NOT NULL COMMENT 'basically an HTML tag',
  PRIMARY KEY (`treatment_scope_id`),
  KEY `treatment_id` (`treatment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `treatment_type`
--

CREATE TABLE IF NOT EXISTS `treatment_type` (
  `treatment_type_id` int(11) NOT NULL,
  `treatment_type` varchar(100) NOT NULL,
  PRIMARY KEY (`treatment_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(11) NOT NULL,
  `username` int(20) NOT NULL,
  `user_full_name` varchar(50) NOT NULL,
  `user_role` varchar(30) NOT NULL,
  `password_hash` text NOT NULL,
  `password_salt` text NOT NULL,
  `last_login` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='mainly for researchers';

-- --------------------------------------------------------

--
-- Table structure for table `visit`
--

CREATE TABLE IF NOT EXISTS `visit` (
  `visit_id` int(11) NOT NULL,
  `visitor_id` int(11) NOT NULL,
  `treatment_id` int(11) NOT NULL,
  `experiment_id` int(11) NOT NULL,
  `browser` varchar(50) NOT NULL,
  `operating_system` varchar(50) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`visit_id`),
  KEY `visitor_id` (`visitor_id`),
  KEY `experiment_id` (`experiment_id`),
  KEY `treatment_id` (`treatment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor`
--

CREATE TABLE IF NOT EXISTS `visitor` (
  `visitor_id` int(11) NOT NULL,
  `last_visit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `behaviour`
--
ALTER TABLE `behaviour`
  ADD CONSTRAINT `behaviour_ibfk_1` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `behaviour_ibfk_2` FOREIGN KEY (`behaviour_type_id`) REFERENCES `behaviour_type` (`behaviour_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `experiment`
--
ALTER TABLE `experiment`
  ADD CONSTRAINT `experiment_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `experiment_ibfk_2` FOREIGN KEY (`text_id`) REFERENCES `text` (`text_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `experimental_treatment`
--
ALTER TABLE `experimental_treatment`
  ADD CONSTRAINT `experimental_treatment_ibfk_1` FOREIGN KEY (`treatment_id`) REFERENCES `treatment` (`treatment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `experimental_treatment_ibfk_2` FOREIGN KEY (`experiment_id`) REFERENCES `experiment` (`experiment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `quiz`
--
ALTER TABLE `quiz`
  ADD CONSTRAINT `quiz_ibfk_1` FOREIGN KEY (`text_id`) REFERENCES `text` (`text_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `quiz_answer`
--
ALTER TABLE `quiz_answer`
  ADD CONSTRAINT `quiz_answer_ibfk_1` FOREIGN KEY (`qq_id`) REFERENCES `quiz_question` (`qq_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `quiz_attempt`
--
ALTER TABLE `quiz_attempt`
  ADD CONSTRAINT `quiz_attempt_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`quiz_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `quiz_attempt_ibfk_2` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `quiz_question`
--
ALTER TABLE `quiz_question`
  ADD CONSTRAINT `quiz_question_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`quiz_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `quiz_response`
--
ALTER TABLE `quiz_response`
  ADD CONSTRAINT `quiz_response_ibfk_1` FOREIGN KEY (`qq_id`) REFERENCES `quiz_question` (`qq_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `quiz_response_ibfk_2` FOREIGN KEY (`quiz_attempt_id`) REFERENCES `quiz_attempt` (`quiz_attempt_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `quiz_response_ibfk_3` FOREIGN KEY (`quiz_answer_id`) REFERENCES `quiz_answer` (`quiz_answer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `treatment`
--
ALTER TABLE `treatment`
  ADD CONSTRAINT `treatment_ibfk_1` FOREIGN KEY (`treatment_type_id`) REFERENCES `treatment_type` (`treatment_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `treatment_parameter`
--
ALTER TABLE `treatment_parameter`
  ADD CONSTRAINT `treatment_parameter_ibfk_1` FOREIGN KEY (`treatment_id`) REFERENCES `treatment` (`treatment_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `treatment_scope`
--
ALTER TABLE `treatment_scope`
  ADD CONSTRAINT `treatment_scope_ibfk_1` FOREIGN KEY (`treatment_id`) REFERENCES `treatment` (`treatment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `visit`
--
ALTER TABLE `visit`
  ADD CONSTRAINT `visit_ibfk_2` FOREIGN KEY (`visitor_id`) REFERENCES `visitor` (`visitor_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `visit_ibfk_3` FOREIGN KEY (`treatment_id`) REFERENCES `experimental_treatment` (`treatment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `visit_ibfk_4` FOREIGN KEY (`experiment_id`) REFERENCES `experimental_treatment` (`experiment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
