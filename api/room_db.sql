-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Mar 31, 2026 at 08:49 AM
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
-- Database: `roomshare_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `api_appnotification`
--

CREATE TABLE `api_appnotification` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `notification_type` varchar(20) NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `related_id` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_appnotification`
--

INSERT INTO `api_appnotification` (`id`, `title`, `message`, `notification_type`, `is_read`, `created_at`, `user_id`, `related_id`) VALUES
(2, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-24 04:03:00', 9, NULL),
(3, 'Account Settings Updated', 'Your account settings were changed.', 'ACCOUNT', 1, '2026-03-24 04:33:47', 9, NULL),
(4, 'Account Settings Updated', 'Your account settings were changed.', 'ACCOUNT', 1, '2026-03-24 04:33:50', 9, NULL),
(5, 'Room Booked', 'Room E101 at Skyline Business Hotel booked. Ref: RS-7A78AD98', 'ROOM', 1, '2026-03-24 19:22:58', 9, NULL),
(6, 'Account Settings Updated', 'Your account settings were changed.', 'ACCOUNT', 1, '2026-03-24 19:47:39', 9, NULL),
(7, 'Account Settings Updated', 'Your account settings were changed.', 'ACCOUNT', 1, '2026-03-24 19:47:41', 9, NULL),
(8, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-24 19:50:08', 9, NULL),
(9, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-24 19:51:12', 9, NULL),
(10, 'Booking Confirmed! 🎉', 'Your booking at The Grand Chennai (Room 101) is confirmed! Ref: RS-73F7FD6C. Check-in: 2026-03-25, Check-out: 2026-03-27. Total: ₹5000', 'ROOM', 1, '2026-03-24 20:09:55', 9, NULL),
(11, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-24 20:17:27', 12, NULL),
(12, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-24 20:22:36', 12, NULL),
(13, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-24 20:24:26', 12, NULL),
(14, 'Booking Confirmed! 🎉', 'Your booking at Chennai Comfort Inn (Room A1) is confirmed! Ref: RS-5A3909B2. Check-in: 2026-03-25, Check-out: 2026-03-27. Total: ₹2400', 'ROOM', 1, '2026-03-24 20:32:03', 9, NULL),
(15, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-24 21:43:39', 9, NULL),
(16, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-24 21:44:04', 9, NULL),
(17, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-25 05:35:33', 9, NULL),
(18, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-25 16:12:30', 11, NULL),
(19, 'Account Settings Updated', 'Your account settings were changed.', 'ACCOUNT', 1, '2026-03-26 18:07:38', 11, NULL),
(20, 'Account Settings Updated', 'Your account settings were changed.', 'ACCOUNT', 1, '2026-03-26 18:07:46', 11, NULL),
(21, 'Booking Confirmed! 🎉', 'Your booking at Heritage Palace (Room 3205) is confirmed.', 'BOOKING', 1, '2026-03-26 19:10:25', 9, '7'),
(22, 'Booking Confirmed! 🎉', 'Your booking at Heritage Palace (Room 8304) is confirmed.', 'BOOKING', 1, '2026-03-26 19:10:30', 9, '8'),
(23, 'Booking Confirmed! 🎉', 'Your booking at Heritage Palace (Room 4104) is confirmed.', 'BOOKING', 1, '2026-03-26 19:10:33', 9, '9'),
(24, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-26 19:47:44', 9, NULL),
(25, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-26 19:47:56', 9, NULL),
(26, 'Booking Confirmed! 🎉', 'Your booking at The Grand Chennai (Room 101) is confirmed.', 'BOOKING', 0, '2026-03-26 21:43:34', 13, '10'),
(27, 'Booking Confirmed! 🎉', 'Your booking at The Grand Chennai (Room 102) is confirmed.', 'BOOKING', 0, '2026-03-26 22:02:14', 14, '11'),
(28, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 0, '2026-03-26 22:03:22', 14, NULL),
(29, 'Booking Confirmed! 🎉', 'Your booking at The Grand Chennai (Room 201) is confirmed.', 'BOOKING', 0, '2026-03-26 22:04:53', 14, '12'),
(30, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 0, '2026-03-26 22:39:45', 16, NULL),
(31, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 0, '2026-03-26 23:34:48', 16, NULL),
(32, 'Booking Confirmed! 🎉', 'Your booking at Marina Bay Resort (Room S1) is confirmed.', 'BOOKING', 1, '2026-03-27 04:32:52', 17, '13'),
(33, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-27 04:34:14', 17, NULL),
(34, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-27 04:37:11', 17, NULL),
(35, 'Booking Confirmed! 🎉', 'Your booking at The Grand Chennai (Room 102) is confirmed.', 'BOOKING', 0, '2026-03-27 04:51:23', 17, '14'),
(36, 'Booking Confirmed! 🎉', 'Your booking at Marina Bay Resort (Room D1) is confirmed.', 'BOOKING', 0, '2026-03-27 04:56:40', 17, '15'),
(37, 'Booking Confirmed! 🎉', 'Your booking at Beachside Suites (Room 3104) is confirmed.', 'BOOKING', 0, '2026-03-27 05:02:05', 17, '16'),
(38, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 0, '2026-03-27 05:05:48', 17, NULL),
(39, 'Booking Confirmed! 🎉', 'Your booking at The Grand Chennai (Room 301) is confirmed.', 'BOOKING', 1, '2026-03-27 05:09:11', 9, '17'),
(40, 'Booking Confirmed! 🎉', 'Your booking at Chennai Comfort Inn (Room A1) is confirmed.', 'BOOKING', 0, '2026-03-27 07:12:26', 17, '18'),
(41, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-27 07:14:45', 9, NULL),
(42, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-27 07:14:55', 9, NULL),
(43, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-27 07:15:10', 9, NULL),
(44, 'Booking Confirmed! 🎉', 'Your booking at The Grand Chennai (Room 101) is confirmed.', 'BOOKING', 0, '2026-03-27 07:21:26', 18, '19'),
(45, 'Booking Confirmed! 🎉', 'Your booking at Heritage Palace (Room 5205) is confirmed.', 'BOOKING', 1, '2026-03-27 08:33:04', 9, '20'),
(46, 'Booking Confirmed! 🎉', 'Your booking at The Grand Chennai (Room 202) is confirmed.', 'BOOKING', 1, '2026-03-27 08:37:47', 9, '21'),
(47, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-27 08:55:46', 9, NULL),
(48, 'Booking Confirmed! 🎉', 'Your booking at Chennai Comfort Inn (Room A2) is confirmed.', 'BOOKING', 0, '2026-03-27 09:21:11', 21, '22'),
(49, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 0, '2026-03-27 09:29:22', 21, NULL),
(50, 'Partner Room Inquiry Sent', 'Your inquiry for this verified partner listing has been sent. Our team will contact you soon.', 'ROOM', 1, '2026-03-27 18:06:46', 9, NULL),
(51, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-27 18:12:09', 9, NULL),
(52, 'Account Settings Updated', 'Your account settings were changed.', 'ACCOUNT', 1, '2026-03-27 18:28:02', 9, NULL),
(53, 'Account Settings Updated', 'Your account settings were changed.', 'ACCOUNT', 1, '2026-03-27 18:28:04', 9, NULL),
(54, 'Partner Room Inquiry Sent', 'Your inquiry for this verified partner listing has been sent. Our team will contact you soon.', 'ROOM', 1, '2026-03-27 18:32:37', 9, NULL),
(55, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 0, '2026-03-27 19:32:18', 22, NULL),
(56, 'Booking Confirmed! 🎉', 'Your booking at The Grand Chennai (Room 101) is confirmed.', 'BOOKING', 0, '2026-03-27 19:55:55', 22, '23'),
(57, 'Partner Room Inquiry Sent', 'Your inquiry for this verified partner listing has been sent. Our team will contact you soon.', 'ROOM', 1, '2026-03-28 03:50:36', 9, NULL),
(58, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 1, '2026-03-28 04:00:04', 23, NULL),
(59, 'Room Share Interest', 'talapanenidivya6@gmail.com is interested in sharing your room: Test Room for vdjksvdiebd', 'ROOM', 0, '2026-03-28 05:02:24', 19, NULL),
(60, 'Partner Room Inquiry Sent', 'Your inquiry for this verified partner listing has been sent. Our team will contact you soon.', 'ROOM', 1, '2026-03-28 05:30:20', 23, NULL),
(61, 'Partner Room Inquiry Sent', 'Your inquiry for this verified partner listing has been sent. Our team will contact you soon.', 'ROOM', 1, '2026-03-28 05:44:17', 23, NULL),
(62, 'Room Share Interest', 'talapanenidivya6@gmail.com is interested in sharing your room: Test Room for vdjksvdiebd', 'ROOM', 0, '2026-03-28 07:28:05', 19, NULL),
(63, 'Partner Room Inquiry Sent', 'Your inquiry for this verified partner listing has been sent. Our team will contact you soon.', 'ROOM', 1, '2026-03-28 08:34:20', 9, NULL),
(64, 'Partner Room Inquiry Sent', 'Your inquiry for this verified partner listing has been sent. Our team will contact you soon.', 'ROOM', 1, '2026-03-31 04:59:42', 9, NULL),
(65, 'Profile Updated', 'Your profile information was updated successfully.', 'PROFILE', 0, '2026-03-31 05:02:57', 25, NULL),
(66, 'Partner Room Inquiry Sent', 'Your inquiry for this verified partner listing has been sent. Our team will contact you soon.', 'ROOM', 0, '2026-03-31 05:03:32', 25, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `api_bookinghistory`
--

CREATE TABLE `api_bookinghistory` (
  `id` int(11) NOT NULL,
  `room_title` varchar(200) NOT NULL,
  `location` varchar(200) NOT NULL,
  `booking_date` date NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_hotel` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_bookinghistory`
--

INSERT INTO `api_bookinghistory` (`id`, `room_title`, `location`, `booking_date`, `amount`, `user_id`, `status`, `created_at`, `is_hotel`) VALUES
(28, 'KOLAS Hotel (External)', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', '2026-06-01', 6236, 9, 'CONFIRMED', '2026-03-26 20:34:16.681176', 1),
(29, 'KOLAS Hotel (External)', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', '2026-06-01', 6236, 9, 'CONFIRMED', '2026-03-26 20:49:43.073654', 1),
(30, 'Mohan Lodge (External)', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', '2026-06-01', 7848, 9, 'CONFIRMED', '2026-03-26 20:53:35.806729', 1),
(31, 'The Grand Chennai - SINGLE', '123 Anna Salai, Guindy, Chennai', '2026-06-01', 10000, 13, 'CONFIRMED', '2026-03-26 21:43:34.035209', 1),
(32, 'The Grand Chennai - DOUBLE', '123 Anna Salai, Guindy, Chennai', '2026-06-01', 14000, 14, 'CONFIRMED', '2026-03-26 22:02:14.382884', 1),
(33, 'The Grand Chennai - DELUXE', '123 Anna Salai, Guindy, Chennai', '2026-06-01', 22000, 14, 'CONFIRMED', '2026-03-26 22:04:53.517753', 1),
(34, 'KOLAS Hotel (External)', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', '2026-06-01', 6236, 16, 'CONFIRMED', '2026-03-26 22:38:42.093184', 1),
(35, 'KOLAS Hotel (External)', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', '2026-06-01', 6236, 16, 'CONFIRMED', '2026-03-26 22:44:17.610685', 1),
(36, 'krishna lodge (External)', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', '2026-06-01', 7760, 16, 'CONFIRMED', '2026-03-26 22:52:43.793605', 1),
(37, 'ajantha hotel (External)', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', '2026-06-01', 6900, 16, 'CONFIRMED', '2026-03-26 23:09:04.147041', 1),
(38, 'Marina Bay Resort - DELUXE', '78 Kamarajar Salai, Marina, Chennai', '2026-03-28', 4000, 17, 'CONFIRMED', '2026-03-27 04:32:52.321000', 1),
(39, 'The Grand Chennai - DOUBLE', '123 Anna Salai, Guindy, Chennai', '2026-03-28', 3500, 17, 'CONFIRMED', '2026-03-27 04:51:23.259341', 1),
(40, 'Marina Bay Resort - DOUBLE', '78 Kamarajar Salai, Marina, Chennai', '2026-03-28', 3000, 17, 'CONFIRMED', '2026-03-27 04:56:40.347067', 1),
(41, 'Beachside Suites - SINGLE', 'ECR, Chennai, Tamil Nadu', '2026-03-28', 1901, 17, 'CONFIRMED', '2026-03-27 05:02:05.381964', 1),
(42, 'The Grand Chennai - SUITE', '123 Anna Salai, Guindy, Chennai', '2026-03-27', 5091500, 9, 'CONFIRMED', '2026-03-27 05:09:11.254100', 1),
(43, 'Mission District Apartment', 'chennai ', '2026-03-27', 2249, 17, 'CONFIRMED', '2026-03-27 07:10:13.373159', 0),
(44, 'Chennai Comfort Inn - SINGLE', '45 Usman Road, T. Nagar, Chennai', '2026-03-28', 1200, 17, 'CONFIRMED', '2026-03-27 07:12:26.392279', 1),
(45, 'The Grand Chennai - SINGLE', '123 Anna Salai, Guindy, Chennai', '2026-03-28', 2500, 18, 'CONFIRMED', '2026-03-27 07:21:26.858997', 1),
(46, 'Heritage Palace - SINGLE', 'Near Palace, Mysore, Karnataka', '2026-03-28', 1792, 9, 'CONFIRMED', '2026-03-27 08:33:04.371035', 1),
(47, 'The Grand Chennai - DOUBLE', '123 Anna Salai, Guindy, Chennai', '2026-03-28', 3800, 9, 'CONFIRMED', '2026-03-27 08:37:47.411754', 1),
(48, 'Chennai Comfort Inn - SINGLE', '45 Usman Road, T. Nagar, Chennai', '2026-03-28', 1200, 21, 'CONFIRMED', '2026-03-27 09:21:11.721964', 1),
(49, 'krishna lodge (External)', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', '2026-03-28', 1940, 21, 'CONFIRMED', '2026-03-27 09:31:08.775346', 1),
(50, 'ajantha hotel (External)', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', '2026-03-28', 8576, 9, 'CONFIRMED', '2026-03-27 18:34:22.674597', 1),
(51, 'The Grand Chennai - SINGLE', '123 Anna Salai, Guindy, Chennai', '2026-03-29', 5000, 22, 'CONFIRMED', '2026-03-27 19:55:55.366765', 1),
(52, 'Mohan Lodge (External)', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', '2026-03-28', 1962, 9, 'CONFIRMED', '2026-03-27 20:13:12.381585', 1),
(53, 'MATHI RESIDENCY (External)', 'Kumarappa Chetty Street, Chennai', '2026-03-29', 2021, 23, 'CONFIRMED', '2026-03-28 03:58:50.547346', 1),
(54, 'Saravana Inn (External)', 'Chennai Corporation, Chennai, Tamil Nadu, India', '2026-03-28', 5946, 9, 'CONFIRMED', '2026-03-28 05:02:41.426631', 1),
(55, 'Modern Central Lodge (External)', 'Chennai Corporation, Chennai, Tamil Nadu, India', '2026-03-29', 2169, 23, 'CONFIRMED', '2026-03-28 07:34:13.406336', 1),
(56, 'Mohan Lodge (External)', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', '2026-03-29', 1962, 9, 'CONFIRMED', '2026-03-28 08:18:15.135487', 1),
(57, 'Grand Oliver (External)', 'Chennai Corporation, Chennai, Tamil Nadu, India', '2026-03-28', 8636, 23, 'CONFIRMED', '2026-03-28 08:39:13.922391', 1),
(58, 'Hotel Mourya Grand, Ongole (External)', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', '2026-03-29', 1673, 9, 'CONFIRMED', '2026-03-28 09:12:12.792366', 1),
(59, 'Sunrise Boys Hostel (External)', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', '2026-03-31', 7413, 9, 'CONFIRMED', '2026-03-31 04:58:44.589980', 1);

-- --------------------------------------------------------

--
-- Table structure for table `api_chatmessage`
--

CREATE TABLE `api_chatmessage` (
  `id` bigint(20) NOT NULL,
  `role` varchar(10) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_chatmessage`
--

INSERT INTO `api_chatmessage` (`id`, `role`, `content`, `created_at`, `user_id`) VALUES
(57, 'user', 'How do I find a good roommate?', '2026-03-25 06:45:59.698860', 11),
(58, 'assistant', '- **Define Expectations**: Before you start looking, decide what you hope from your new roommate.\n- **Research Each Person**: Look into their background, values, and personal goals. Consider what makes them interesting or what areas might need improvement.\n- **Discuss Goals and Preferences**: Have a frank conversation about what each of you is looking for in a roommate. This could be physical aspects (e.g., noise levels) or non-physical aspects (e.g., mutual respect).\n- **Meet and Greet**: Schedule an early meeting to get a better sense of how they will interact with the other person.\n- **Prepare for Differences**: Anticipate common challenges that may arise but also appreciate some flexibility in their living arrangement.\n\n**Additional Tips**:\n- Be open to compromise. Sometimes, it’s not about being perfect; it\'s about finding someone who fits both parties’ needs and expectations.\n- Set clear boundaries early on.\n- Maintain a positive attitude towards the move.\n- Practice active listening when discussing conflicts or disagreements.\n\nHow do I find a good roommate?\n- **Define Expectations**: Before you start looking, decide what you hope from your new roommate.\n- **Research Each Person**: Look into their background, values, and personal goals. Consider what makes them interesting or what areas might need improvement.\n- **Discuss Goals and Preferences**: Have a frank conversation about what each of you is looking for in a roommate. This could be physical aspects (e.g., noise levels) or non-physical aspects (e.g., mutual respect).\n- **Meet and Greet**: Schedule an early meeting to get a better sense of how they will interact with the other person.\n- **Prepare for Differences**: Anticipate common challenges that may arise but also appreciate some flexibility in their living arrangement.\n- **Set Clear Boundaries Early**: Make sure you understand what each individual is looking for so you can agree on clear boundaries early on.\n\nBy following these steps, you\'ll be better equipped to find a roommate who aligns with your personal values and lifestyle.', '2026-03-25 06:46:15.813830', 11),
(116, 'user', 'hi', '2026-03-26 21:31:39.309706', 11),
(117, 'assistant', 'Hello! I\'m here to help you with your queries. Are you looking for information on a specific location? If so, please let me know and we can discuss it together. Otherwise, I\'d be happy to assist you with any inquiries or questions you might have. Is there anything in particular you\'re trying to learn about that I can help with?', '2026-03-26 21:32:04.165610', 11),
(118, 'user', 'rooms in ongole', '2026-03-26 21:32:37.508222', 11),
(119, 'assistant', 'Certainly! To help you with your query \"rooms in Onego,\" I\'ll need to gather more specific information such as cost of living and vibe while discussing potential options. Could you please provide some details on what specific areas or types of rooms you\'re interested in? This will allow me to tailor the recommendations based on local preferences and current market conditions.', '2026-03-26 21:32:55.546272', 11),
(122, 'user', 'Tell be about Ongole in Andhrapradesh', '2026-03-26 21:37:07.203977', 9),
(123, 'assistant', 'Ongole is an Indian city located in the state of Andhra Pradesh in India. It\'s situated in the southeastern part of the state and known for its rich cultural heritage, history, and vibrant economy.\n\nOngole has a population of around 40 million people, making it one of the largest cities in India. The city is famous for its historical sites, including the Fort of Ongol and the Temple of Indravati. It\'s also known as \"Chota Nagpur\" due to its proximity to the town of Nagpur.\n\nOngole has a diverse population with a wide range of languages spoken by residents, including English, Telugu, Kannada, Hindi, and other local dialects.\n\nThe cost of living in Ongole can vary depending on individual circumstances. For example, it might be more expensive for students to live in the city compared to their homes in nearby cities or rural areas. The area can also experience significant seasonal changes that affect prices, such as hot summer months when temperatures can soar during the day and cool off at night.\n\nEconomic activity and business conditions tend to be strong in Ongole. With a growing economy, it\'s essential for residents to keep up with industry trends and investment opportunities.\n\nAdditionally, Ongole is a popular tourist destination known for its beautiful landscapes, festivals, and cultural attractions. The city also hosts several international events annually, including the Andhra Pradesh Film Festival and the Chennai International Film Festival.\n\nIf you\'re looking for more detailed information or specific details about Ongole\'s location or culture, I would recommend consulting official government websites, travel guides, or local tour operators.', '2026-03-26 21:37:23.871563', 9),
(124, 'user', 'Hi', '2026-03-26 22:40:41.761003', 16),
(125, 'assistant', 'Hello! How can I assist you today? Is there anything specific you would like to know or discuss regarding RoomShare AI or any other topics related to Alibaba Cloud services?', '2026-03-26 22:40:51.451681', 16),
(126, 'user', 'Rooms in Ongole', '2026-03-26 22:41:09.712746', 16),
(127, 'assistant', 'RoomShare AI does not currently have direct access to information about specific locations like Ongole. However, I can provide some general insights on how to find and use RoomShare services:\n\n1. **Marketplace**: Explore different types of rooms available in your desired area or city. You might find listings on platforms such as Airbnb, Booking.com, or local property websites.\n\n2. **Local Services**: Check with hotels and accommodation providers that are familiar with Ongole. They can provide you with more specific information about rooms suitable for this location.\n\n3. **RoomShare AI**: If you\'re interested in staying at a specific room in Ongole, RoomShare AI has resources available to help book rooms directly through their platform or search it online.\n\n4. **Vibes and Ratings**: Check reviews and ratings of hotels and accommodations in Ongole on websites like TripAdvisor, Booking.com, or Yelp for insights into the general quality of staying in that area.\n\n5. **Special Offers**: Stay informed about any special deals or promotions related to rooms in Ongole offered by RoomShare AI.\n\nIf you have specific questions regarding Ongole or need help with booking rooms there, I\'m here to assist.', '2026-03-26 22:41:26.645699', 16),
(128, 'user', 'Tell me about chennai', '2026-03-26 22:41:45.602749', 16),
(129, 'assistant', 'Thank you! Chennai, also known as Madras, is a vibrant city located in India\'s southern coastal region. Here are some key points to know about Chennai:\n\n### **General Information:**\n- **Population:** Approximately 6 million people live in Chennai.\n- **Geography:** It is situated on the banks of the Tungabhadra River and is surrounded by the Western Ghats and the Indian state of Tamil Nadu.\n- **Cultural Heritage:** Known for its rich history, cultural richness, and diverse heritage sites.\n\n### **Major Cities Nearby:**\n- **Kollam:** A coastal city known for its beachfront locations, popular for swimming and surfing activities.\n- **Chennai (formerly Madras):** Famous for its modern architecture, food, and fashion scenes. It is also home to the University of Chennai, which is considered one of India’s top research institutions.\n\n### **Transportation:**\n- **Railway:** Offers direct connections from major cities like Delhi and Mumbai via Chennai.\n- **Airports:** The city has several major airports including the Chennai International Airport and Thirumalai Mahadevi International Airport.\n- **Buses:** Various bus routes connect Chennas, providing easy access to both urban and suburban areas.\n\n### **Local Shopping:**\n- **Fashion**: Chennai is famous for its boutiques like the Samskara Fashion Institute, offering a variety of clothing brands and designers.\n- **Hopping Street:** Known for its eclectic marketplaces where you can find unique handicrafts, spices, and other local goods.\n\n### **Food & Cuisine:**\n- **Street Food:** Chennai is famous for its street food scenes, with dishes like chettinadi (a type of curry), idli (dried lentils), and urad dal (spicy dosas).\n- **Indian Cuisine:** The city has a rich culinary tradition, offering a wide array of Indian dishes such as masala rice, thali, and bhaji.\n\n### **Festival Season:**\n- **Holi:** One of the most popular festivals in Chennai, marking the end of winter.\n- **Thamarajamurthi Festival (Dharmavasara):** A celebration held on the last day of April, where people come out to watch a fireworks display.\n\n### **Local Attractions:**\n- **Temple:** The iconic Kumbakonam Temple is a significant attraction known for its golden idol and scenic views.\n- **Park Life:** Chennai has a number of parks like Thimavathi Park and Kottayam Park, where you can enjoy leisurely walks, yoga, or sports activities.\n\n### **Cost of Living:**\n- **Income Levels:** Generally lower than other major cities in India, with average incomes around INR 30,000 to 60,000 per year.\n- **Living Conditions:** Chennai is known for its cleanliness and affordability; however, it can be more expensive compared to other Indian cities.\n\nIf you have specific questions about particular areas or activities in Chennai, feel free to ask!', '2026-03-26 22:42:26.791983', 16),
(130, 'user', 'hi', '2026-03-27 04:35:15.252555', 17),
(131, 'assistant', 'Hello! How can I assist you today? Please let me know if there\'s anything specific you\'d like to ask or discuss.', '2026-03-27 04:35:22.236156', 17),
(132, 'user', 'hotels in chennai', '2026-03-27 04:35:37.350825', 17),
(133, 'assistant', 'Certainly! For your query on \"hotels in Chennai,\" I can provide you with basic information. Chennai, also known as Madras, is a bustling city located in south-central India. Here are some key points to consider:\n\n1. Population: The population of Chennai has grown significantly over the years due to its industrial and economic activities.\n2. Economy: It\'s one of the major cities in South Asia with a rich manufacturing sector.\n3. Amenities: Chennai is renowned for its vibrant nightlife, shopping scenes, and various tourist attractions.\n4. Transportation: Being a central city, it offers efficient public transportation options like buses and metro services.\n5. Cost of Living: Chennai has an average cost of living similar to that in Mumbai, with prices ranging from low to medium depending on the region.\n\nIf you have any specific areas or types of hotels in particular (e.g., luxury, budget, international), I can provide more detailed insights based on those preferences. Alternatively, if you\'re looking for a general overview of Chennai\'s current hotel offerings, let me know!', '2026-03-27 04:35:50.377881', 17),
(134, 'user', 'hotels in ongole', '2026-03-27 04:54:27.806017', 17),
(135, 'assistant', 'For your query regarding \"hotels in Ongole,\" I can assist you by providing the following information:\n\n1. Population: Ongole, commonly known as Ongola, is a city and district in South India located in Tamil Nadu state. The city has an estimated population of around 6 million people.\n2. Economy: Chennai\'s neighboring city, Ongole, also known as Ongula or Onda, plays a significant role in the regional economy due to its proximity to both Bangalore and Madurai.\n3. Amenities: Chennai is renowned for its vibrant nightlife, shopping scenes, and various tourist attractions throughout the city.\n4. Transportation: Being situated on the western side of Chennai, it has efficient public transportation options including buses, metro systems, and a train line.\n5. Cost of Living: Chennai has an average cost of living similar to that in Mumbai, with prices ranging from low to medium depending on the region.\n\nIf you have any specific areas or types of hotels you are interested in, I can provide more detailed insights based on those preferences. If you\'re looking for a general overview of Ongole\'s current hotel offerings, please let me know!', '2026-03-27 04:54:44.407185', 17),
(136, 'user', 'rooms suitable for me', '2026-03-27 07:22:03.787582', 18),
(137, 'assistant', 'As an AI agent, I can\'t directly access your personal preferences or locations like you do. However, based on common suggestions and areas with better reviews:\n\n- For places to stay, many options are available online through platforms like Airbnb, Couchsurfing, or travel agencies.\n- For budget-friendly accommodations, consider staying in cities where cost of living is lower, such as Beijing, Tokyo, or New York City.\n- If you\'re looking for a specific location with more positive feedback, I\'d be happy to recommend cities or neighborhoods that have excellent reviews.\n\nIf you could provide more context about your needs and preferences, I can offer more tailored recommendations.', '2026-03-27 07:22:13.790499', 18),
(138, 'user', 'I need rooms in chennai', '2026-03-27 07:22:32.531470', 18),
(139, 'assistant', 'Certainly! Let\'s consider Chennai as your ideal base for finding suitable rooms.\n\n### **1. Online Travel Agreements: Airbnb, Couchsurfing**\n   - **Airbnb**: This platform allows you to book shared spaces with others who are looking for them. You can search by location and see reviews from other users.\n     - **Pros**: \n       - Personalized recommendations based on your preferences.\n       - Versatility: Can be used for various activities like reading, cooking, or gaming.\n     - **Cons**:\n       - Not always available for all amenities, especially in rural areas.\n\n   - **Couchsurfing**: This service allows you to stay with locals who live nearby. It’s not just about staying; it can also involve socializing and meeting new people.\n     - **Pros**: \n       - Personalized experience: More personal interaction than a traditional hotel.\n       - Offers opportunities for local activity and socialization.\n   - **Travel Agencies**: Websites like Expedia, Booking.com, or Travelocity offer personalized suggestions based on your travel preferences.\n\n### **2. Cost of Living Considerations:**\n\n#### **General Areas in Chennai**\n   - **Central Business District (CBD) with High Costs**:\n     - **Pros**: Generally better service quality and facilities.\n     - **Cons**: Higher prices for accommodations, dining, and public transport services due to the city\'s bustling atmosphere.\n\n   - **Southside and Eastern Area**:\n     - **Pros**: Lower costs compared to Central Business District areas.\n     - **Cons**: Less tourist-friendly, but can be a good option for sightseeing or exploring other parts of the city.\n\n#### **Specific Areas with Better Reviews**\n- **Chennai Hills (Central)**\n  - **Pros**: \n    - Offers scenic views and historical landmarks like the Gandhi National Museum.\n    - Lower cost compared to suburban areas.\n  - **Cons**:\n    - Less tourist-friendly than high-end areas but still enjoyable for leisure activities.\n\n- **Kumbakondam (Southside)**\n  - **Pros**:\n    - More pedestrianized, ideal for walking and exploring the city\'s historical districts.\n    - Lower cost compared to the CBD.\n  - **Cons**:\n    - Less tourist-friendly compared to other areas of Chennai but highly recommended for shopping and dining.\n\n- **Kadurapettai (Eastern Area)**\n  - **Pros**: \n    - Offers a mix of new developments, modern buildings, and traditional landmarks.\n    - Better service quality with more restaurants and coffee shops.\n  - **Cons**:\n    - Less tourist-friendly than Central Business District areas but offers many dining options.\n\n- **East Central Area (Central)**\n  - **Pros**: \n    - Offers a blend of city views and historical sites like the Colaba Centre, Gandhi National Museum, and the Gandhi Memorial.\n    - Lower cost compared to the East-West area.\n  - **Cons**:\n    - Less tourist-friendly than other areas but still enjoyable for sightseeing.\n\n- **East West Area (Central)**\n  - **Pros**: \n    - Offers a diverse range of activities like museums, cultural sites, and restaurants.\n    - Lower cost compared to Central Business District areas.\n  - **Cons**:\n    - Less tourist-friendly than East Central area but still offers many dining options.\n\n### **3. Local Attractions and Amenities:**\n\n- **City Parks**: Chennai has several parks like Nagarhole National Park, Nataraj Wildlife Sanctuary, and Thiruvallur Lake. These are ideal for walking, hiking, or just relaxing.\n  - **Pros**:\n    - Provides a peaceful backdrop to enjoy natural beauty.\n    - Often free of charge.\n\n- **Restaurants**: Chennai is known for its diverse cuisine and food options. Here are some popular places to visit:\n\n  - **North Andaman (Chennai)**:\n     - **Pros**: Offers a variety of Indian, Pakistani, and Asian dishes with a focus on vegetarian fare.\n     - **Cons**:\n       - Not all restaurants offer this option; it can be challenging to find quality food in the city.\n  - **Eastside**: Known for its seafood restaurant chain. Consider visiting some restaurants like The Seafood Café, South India Restaurant, or Kamarupa.\n  - **Central Market (Chennai)**: One of Chennai’s most iconic sights and a great place to buy local goods.\n  - **Panchayati Ashram (Kuttyadai)**: A beautiful temple complex located in the center of the city. You can visit the temple, temples, and learn about Hinduism.\n\n### **4. Public Transportation Options:**\n\n- **CNG Bus System**: Chennai is served by a public bus system operated by Chennai Metro.\n  - **Pros**:\n    - Convenient for getting around the city easily.\n    - Offers a variety of routes that include tourist stops, making it easy to explore different parts of the city.\n\n- **Tranquil Areas (Central):**\n  - **Pros**: Less crowded and quieter than the CBD areas. Popular options include:\n    - **Rajpathi Road** (Kandy Avenue) for shopping.\n    - **Tamarind Park** (Shahadur Bazar) for leisure activities.\n\n- **Eastside and East Central Areas (Central):**\n  - **Pros**: More pedestrianized than the central business district. Popular options include:\n    - **Thiruvallur Lake** (Cushie Avenue) for swimming.\n    - **Kudala Avenue** (Chennai Town Hall) for shopping.\n\n- **North Andaman Park (Chennai)**: Located in the North and Bengal regions of Chennai, this park offers a serene environment with some attractions like:\n  - **South India Museum** (Stadium Complex) or\n  - **Panchayati Ashram (Kuttyadai)**\n\n### **5. Cultural Attitudes and Activities:**\n\n- **Chennai’s Urban Culture**: Chennai has many cultural attractions, museums, and festivals. Some popular ones include:\n  - **Village Art Festivals** (e.g., Nataraj Wildlife Sanctuary Art Festival)\n  - **Cinema** (with options like Cinemacamp Cinema in Andaman or Chennai Film City) which offers a variety of films.\n  - **Shopping Malls**: Amlapakkam, Kamarupa, and Gajanan (Chennai Town Hall).\n\n### **6. Budget-Friendly Accommodations:**\n\n- **Central Business District Areas**:\n  - **Pros**:\n    - Lower costs for accommodation compared to the high-end areas.\n  - **Cons**:\n    - Not as desirable due to its bustling atmosphere, but can be a good option for leisure and sightseeing.\n\n### **Additional Tips:**\n- Check reviews online before making your reservation. Many platforms offer free shipping or discounts based on your review history.\n\nBy considering these factors, you should find comfortable and affordable accommodation in Chennai that suits your needs and preferences. Remember to have fun exploring the city and its diverse attractions!', '2026-03-27 07:23:27.800473', 18),
(140, 'user', 'Hii', '2026-03-27 09:21:34.894846', 21),
(141, 'assistant', 'Hello! How can I assist you today?', '2026-03-27 09:21:42.730845', 21),
(142, 'user', 'Resorts near beach', '2026-03-27 09:22:02.777895', 21),
(143, 'assistant', 'Absolutely! To find resorts near the beach, we can start by focusing on areas with convenient access to beaches or nearby popular destinations. Here are some suggestions:\n\n1. **Barcelona (Spain)**: Barcelona is known for its Mediterranean beaches and bustling culture. Many top hotels in the city center have well-positioned beaches within easy reach.\n\n2. **Miami Beach**: Miami is a major tourist destination with several resorts that offer beautiful beachfront properties. Be aware of potential safety concerns, especially during high tide times.\n\n3. **Oslo (Norway)**: Oslo is renowned for its stunning coastline and extensive array of luxury resorts. Many resorts are situated near the harbor and close to the city center.\n\n4. **Tokyo**: Tokyo has a wealth of beach options. Some hotels and resorts can be found along popular beaches, making it convenient for those seeking easy access to the ocean.\n\n5. **Sydney (Australia)**: Sydney is known for its outdoor activities and vibrant urban environment. Many resorts in the city center offer beautiful beach locations and prime beachfront properties.\n\n6. **Hong Kong**: Hong Kong offers several resorts near public beaches and bustling neighborhoods like Kowloon Bay or Tsim Sha Tsui. These areas are ideal for those looking to immerse themselves in local culture while enjoying the beach.\n\n7. **Paris (France)**: Paris has a plethora of accommodations within easy reach from its famous tourist destinations, including nearby beaches such as Montmartre, Montmartres Park, and the Champs-Élysées.\n\n8. **Miami Beach (Florida, USA)**: Miami is renowned for its vibrant nightlife and beachfront properties. Many resorts are close to the city center and offer easy access to the iconic beaches of Fort Lauderdale and Miami Beach.\n\nEach of these locations provides a diverse range of services including accommodations, dining options, shopping, and entertainment within a short distance from key tourist attractions or local beaches. If you have any specific preferences or requirements, please let me know!', '2026-03-27 09:22:23.353308', 21),
(144, 'user', 'In chennai', '2026-03-27 09:22:40.550883', 21),
(145, 'assistant', 'Hello! To help you find a suitable resort in Chennai, I\'ll start by discussing some general considerations.\n\n### 1. Cost of Living\nThe cost of living in Chennai can vary depending on your specific needs and budget:\n\n- **Central City**: If you\'re primarily interested in urban areas like the heart of the city or major business districts, you might find it more affordable.\n- **East Coast**: Areas near sea fronts or CBDs (City Centers) can be more expensive due to higher traffic congestion and potential issues with public transportation.\n\n### 2. Local Vibe\nChennai is known for its laid-back yet vibrant atmosphere. Here are some key factors that contribute to the local vibe:\n\n- **Public Transportation**: Chennai offers a variety of buses, metro, and taxis, making it convenient for all types of travel.\n- **Local Attractions**: Areas like Taramani Beach, Guntur, and Chidambaram are popular tourist spots with good facilities and amenities.\n- **Sights**: Places such as Koyilkondamalai Temple, the Collyer Museum, and the Tirupattur Elephant Fort are notable but not always on a high-end list.\n\n### 3. Accommodation\nGiven that Chennai is primarily known for its beach options and urban areas, it can be challenging to find hotels specifically in proximity to beaches:\n\n- **High-Risk Areas**: If you\'re looking for safer accommodations near the beaches, consider properties like those found in the western parts of the city or newer locations.\n- **Offshore Resorts**: For more exclusive experiences, you might want to consider offshore areas that are not directly close to coastal resorts.\n\n### 4. Transportation\n- **Public Transport**: Chennai offers several bus routes and metros, making it easier to reach most destinations by public transport.\n- **Taxis and Ride-Sharing Apps**: With the rise of ride-sharing services like Uber and Lyft in recent years, you might find more options for transportation within the city.\n\n### 5. Attractions\nChennai is a great destination for outdoor activities such as:\n- **Hiking & Snorkeling**: Enjoy scenic beaches with easy access.\n- **Sailing**: The sea offers opportunities to see stunning sunsets and coastal views.\n- **Water Sports**: Water-based activities like kayaking, canoeing, or jet-skiing are popular.\n\n### 6. Budget\nIf cost of living is a priority:\n- **Central City (like Chennai)**: A good balance between affordability and amenities.\n- **East Coast (like Mumbai, Goa, or Bangalore)**: Known for its laid-back vibe with options that cater to budget-conscious travelers.\n\n### Conclusion\nChennai can be an exciting destination with both local attractions and vibrant nightlife. Depending on your specific needs, you might want to focus on specific areas or amenities such as beachside properties near major tourist spots.\n\nWould you like more detailed information on a particular area or need assistance in planning a trip?', '2026-03-27 09:23:18.708880', 21),
(146, 'user', 'Rooms in chennai', '2026-03-27 09:23:41.071444', 21),
(147, 'assistant', 'Hello! To help you find rooms in Chennai, let\'s break down some key factors related to cost, local atmosphere, and amenities.\n\n### 1. **Cost of Living**\nChennai offers a blend of luxury and affordability due to its strategic location relative to major cities like Mumbai, Kolkata (formerly known as Calcutta), and Bangalore. However, prices can vary based on specific locations and the type of property you\'re considering:\n\n- **Central City**: If your primary goal is central areas with convenient transportation options such as buses or metros, you might find it more cost-effective.\n- **East Coast**: Areas near sea fronts like Koyilkondamalai Temple, Guntur, and Chidambaram offer good facilities and amenities.\n\n### 2. **Local Atmosphere**\nChennai has a laid-back yet vibrant atmosphere that appeals to travelers interested in exploring the city\'s unique features:\n\n- **Public Transportation**: The city offers efficient public transportation options such as buses, metro, and taxis, making it convenient for all types of travel.\n- **Local Attractions**: Areas like Taramani Beach, Guntur, and Chidambaram are known for their good facilities and amenities.\n\n### 3. **Accommodation**\nGiven the mix of local attractions and high-end experiences, here are some general tips for finding affordable yet comfortable accommodation:\n\n- **Offshore Reservations**: For more exclusive options, consider offshore resorts that offer private villas or larger accommodations.\n- **Private Accommodations**: If budget allows, staying in a luxurious private villa can be a great value.\n\n### 4. **Transportation**\nChennai offers convenient public transport for all types of travel:\n- **Public Transport**: Several buses and metros serve the city, making it easy to reach most destinations.\n- **Taxis and Ride-Sharing Apps**: With the rise in ride-sharing services like Uber and Lyft, you might find more options for transportation within the city.\n\n### 5. **Attractions**\nChennai is famous for its beaches, urban areas, and tourist attractions:\n\n- **Hiking & Snorkeling**: Enjoy scenic beaches with easy access.\n- **Sailing**: Throngs of tourists cruise the bay at various times of the day.\n- **Water Sports**: The sea offers opportunities to see stunning sunsets and coastal views.\n\n### 6. **Budget**\nIf cost of living is a priority, consider the following areas:\n- **Central City (like Chennai)**: A good balance between affordability and amenities.\n- **East Coast (like Mumbai, Goa, or Bangalore)**: Known for its laid-back vibe with options that cater to budget-conscious travelers.\n\n### Conclusion\nChennai offers a range of options based on your specific needs such as cost of living, local atmosphere, and available accommodations. Depending on your personal preferences and goals, you might find the city\'s attractions more appealing or just easier to accommodate.\n\nWould you like more detailed information on a particular area, pricing breakdowns for specific amenities, or any other aspects of finding rooms in Chennai?', '2026-03-27 09:24:30.756508', 21),
(148, 'user', 'hi', '2026-03-27 19:10:59.163098', 9),
(149, 'assistant', 'Hello! How may I assist you today?', '2026-03-27 19:11:10.012862', 9),
(150, 'user', 'Hi', '2026-03-27 19:56:29.926512', 22),
(151, 'assistant', 'Hi! How can I assist you today?', '2026-03-27 19:56:41.046711', 22),
(152, 'user', 'hi', '2026-03-31 04:43:13.153089', 9),
(153, 'assistant', '**Hello again! 😊**\n\nHow can I assist you today? Here are a few ways I can help based on our previous conversation about **Ongole, Andhra Pradesh**—or feel free to ask something new!\n\n### **If you’d like more about Ongole:**\n- **Cost of Living:** Ongole is relatively affordable compared to major Indian cities. A 1BHK rental can range from **₹5,000–₹12,000/month**, while groceries and dining out are budget-friendly.\n- **Vibe:** A mix of traditional Andhra culture and modern growth, with bustling markets, temples, and a growing IT/agricultural economy.\n- **Key Attractions:** *Kothapatnam Beach, Vodarevu Beach, Sri Shirdi Sai Baba Temple, and the historic Ongole Fort*.\n- **Local Insight:** Famous for its *Ongole cattle breed* (a prized dairy variety) and delicious *spicy Andhra cuisine* (try *natukodi pulusu* or *gongura mutton*).\n\n### **Other ways I can help:**\n- **RoomShare Assistance:** Need help finding a PG, flat, or roommate in Ongole? I can guide you on safe areas, rental trends, or verification tips.\n- **Travel/Relocation:** Planning a move? I can share tips on local transport, best neighborhoods, or cultural norms.\n- **General Queries:** From weather updates to job opportunities, ask away!\n\n**What’s on your mind today?** 🚀\n\n*(P.S. If you’re exploring other cities in Andhra Pradesh—like Vijayawada, Visakhapatnam, or Tirupati—I’ve got insights on those too!)*', '2026-03-31 04:43:29.809210', 9);

-- --------------------------------------------------------

--
-- Table structure for table `api_customuser`
--

CREATE TABLE `api_customuser` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `email` varchar(254) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_customuser`
--

INSERT INTO `api_customuser` (`id`, `password`, `last_login`, `is_superuser`, `is_staff`, `is_active`, `email`) VALUES
(9, 'pbkdf2_sha256$1200000$T7XdGnipcN3GuC7ajeSley$GMUvE+VL+6rgaiF7Xnst7C8rCEcfkO70i9YkvdsuN+8=', NULL, 0, 0, 1, 'talapanenidivya6@gmail.com'),
(17, 'pbkdf2_sha256$1200000$zem39cNbSZ5msfOJIuIv1g$R8OmHzs+u8npYXbkczUb9+YqRmir1a1/q3KZegvJpLU=', NULL, 0, 0, 1, 'vinaykumarreddyramala197@gmail.com'),
(18, 'pbkdf2_sha256$1200000$QKBhjKXpLoE8tD8jRg1iDb$8ziuTVX9X0pdgQ38bMUy1rcCbdBBX4j0ME7my6xvx7Q=', NULL, 0, 0, 1, 'vasanthi12@gmail.com'),
(19, 'pbkdf2_sha256$1200000$5VDpLlv8Flhh26dbM5OIEH$g6CmxmZxnHjSyqY0WuKaMRZe423fRWieqH1//lJ+J+c=', NULL, 0, 0, 0, 'vdjksvdiebd@gmail.com'),
(20, 'pbkdf2_sha256$1200000$NwL8QLgvNywGFmv69TkEIU$HiFft+XRmEFKVzkR6b+kVIf9armhrEEZLOuJ6jIfx5o=', NULL, 0, 0, 0, 'jsbsbs@gmail.com'),
(21, 'pbkdf2_sha256$1200000$Bp4AbEmRqfHMSR3SYmlsjJ$7Nvq1LZc7LI+vjwMsyqIR/LShrvulzCECL8aa4qx1oY=', NULL, 0, 0, 1, 'shunushunu91@gmail.com'),
(23, 'pbkdf2_sha256$1200000$AM2LMz6UciQp77fTgTOza8$YtpeDjcs4Xu1rNZ+1OjXdkKCdlHysddMUqQoGMLU3UU=', NULL, 0, 0, 1, 'eswarch2004y@gmail.com'),
(24, 'pbkdf2_sha256$1200000$1KCMmWkcLMhcRPL2VZL8Fq$D0ic5Xx4QoW7oGob61lW9fVPHTjN4P8M1vDApFMyD+U=', NULL, 0, 0, 1, 'chaitanyachanda06@gmail.com'),
(25, 'pbkdf2_sha256$1200000$tJVtgbTd0kmrbunreuG1fQ$daZ6HDEhabEQVyz8NbvFbUPM7iMB7k/bT1sB6VZyHUw=', NULL, 0, 0, 1, 'divyachandrikat1908.sse@saveetha.com');

-- --------------------------------------------------------

--
-- Table structure for table `api_customuser_groups`
--

CREATE TABLE `api_customuser_groups` (
  `id` int(11) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `api_customuser_user_permissions`
--

CREATE TABLE `api_customuser_user_permissions` (
  `id` int(11) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `api_directchat`
--

CREATE TABLE `api_directchat` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `user1_id` bigint(20) NOT NULL,
  `user2_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_directchat`
--

INSERT INTO `api_directchat` (`id`, `created_at`, `user1_id`, `user2_id`) VALUES
(1, '2026-03-24 19:14:14', 9, 10),
(2, '2026-03-24 21:28:55', 9, 11),
(3, '2026-03-24 21:31:04', 9, 12),
(4, '2026-03-26 22:03:35', 9, 14),
(5, '2026-03-26 22:40:13', 15, 16),
(6, '2026-03-26 23:04:43', 9, 16),
(7, '2026-03-27 04:38:38', 9, 17),
(8, '2026-03-28 04:37:04', 9, 19),
(9, '2026-03-28 04:57:54', 17, 23),
(10, '2026-03-28 04:58:39', 9, 21),
(11, '2026-03-31 05:03:52', 21, 25);

-- --------------------------------------------------------

--
-- Table structure for table `api_directchatmessage`
--

CREATE TABLE `api_directchatmessage` (
  `id` int(11) NOT NULL,
  `sender_name` varchar(100) NOT NULL,
  `content` longtext DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `chat_id` bigint(20) NOT NULL,
  `sender_id` bigint(20) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `message_type` varchar(20) NOT NULL,
  `room_baths` varchar(50) DEFAULT NULL,
  `room_beds` varchar(50) DEFAULT NULL,
  `room_price` varchar(100) DEFAULT NULL,
  `room_title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_directchatmessage`
--

INSERT INTO `api_directchatmessage` (`id`, `sender_name`, `content`, `is_read`, `created_at`, `chat_id`, `sender_id`, `image`, `message_type`, `room_baths`, `room_beds`, `room_price`, `room_title`) VALUES
(1, 'eggedgdgdhgddh', 'Hi! I received your request for the room share.', 1, '2026-03-24 19:14:14', 1, 10, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(2, 'Divyakk', 'hi', 0, '2026-03-24 19:14:20', 1, 9, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(3, 'Eswar', 'Hi! I received your request for the room share.', 1, '2026-03-24 21:28:55', 2, 11, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(4, 'Divya', 'hi', 1, '2026-03-24 21:30:03', 2, 9, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(5, 'Divya', 'Hi! I received your request for the room share.', 1, '2026-03-24 21:31:04', 3, 9, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(6, 'Eswar', 'hi', 1, '2026-03-24 21:31:17', 3, 12, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(7, 'Divya', 'How\'s 6 PM tomorrow?', 0, '2026-03-25 07:54:43', 3, 9, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(8, 'Divya', 'How\'s 6 PM tomorrow?', 0, '2026-03-25 18:17:46', 1, 9, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(9, 'Divya', 'How\'s 6 PM tomorrow?', 0, '2026-03-26 18:03:50', 3, 9, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(10, 'Divya', 'Is deposit negotiable?', 1, '2026-03-26 18:04:11', 2, 9, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(11, 'Eswar', 'yes', 1, '2026-03-26 18:04:30', 2, 11, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(12, 'Divya', 'Is deposit negotiable?', 0, '2026-03-26 20:48:47', 2, 9, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(13, 'Divya', 'Hi! I received your request for the room share.', 0, '2026-03-26 22:03:35', 4, 9, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(14, 'Eswar', 'How\'s 6 PM tomorrow?', 0, '2026-03-26 22:03:37', 4, 14, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(15, 'Eswar', 'Hi! I received your request for the room share.', 1, '2026-03-26 22:40:13', 5, 15, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(16, 'Divya', 'Hi! I received your request for the room share.', 1, '2026-03-26 23:04:43', 6, 9, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(17, 'Divya', 'Hi! I received your request for the room share.', 1, '2026-03-27 04:38:38', 7, 9, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(18, 'vinay', 'hi', 1, '2026-03-27 04:52:45', 7, 17, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(19, 'Divya', 'hlo', 1, '2026-03-27 05:12:29', 7, 9, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(20, 'vinay', 'How\'s 6 PM tomorrow?', 0, '2026-03-27 07:15:41', 7, 9, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(21, 'vinay', 'how are you', 0, '2026-03-27 08:30:25', 7, 9, NULL, 'TEXT', NULL, NULL, NULL, NULL),
(22, 'Eswar', 'Hi vinaykumarreddyramala197@gmail.com, I\'d like to connect regarding a potential room share!', 0, '2026-03-28 04:57:54', 9, 23, '', 'TEXT', NULL, NULL, NULL, NULL),
(23, 'Eswar', 'How\'s 6 PM tomorrow?', 0, '2026-03-28 04:58:09', 9, 23, '', 'TEXT', NULL, NULL, NULL, NULL),
(24, 'DIVYA', 'Hi shunushunu91@gmail.com, I\'d like to connect regarding a potential room share!', 0, '2026-03-28 04:58:39', 10, 9, '', 'TEXT', NULL, NULL, NULL, NULL),
(25, 'DIVYA', 'Hi vdjksvdiebd@gmail.com, I\'d like to connect regarding a potential room share!', 0, '2026-03-28 04:59:29', 8, 9, '', 'TEXT', NULL, NULL, NULL, NULL),
(26, 'DIVYA', 'Hi vinaykumarreddyramala197@gmail.com, I\'d like to connect regarding a potential room share!', 0, '2026-03-28 08:19:00', 7, 9, '', 'TEXT', NULL, NULL, NULL, NULL),
(27, 'divya', 'Hi shunushunu91@gmail.com, I\'d like to connect regarding a potential room share!', 0, '2026-03-31 05:03:52', 11, 25, '', 'TEXT', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `api_favoritehotel`
--

CREATE TABLE `api_favoritehotel` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `api_favoritematch`
--

CREATE TABLE `api_favoritematch` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `matched_user_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_favoritematch`
--

INSERT INTO `api_favoritematch` (`id`, `created_at`, `matched_user_id`, `user_id`) VALUES
(5, '2026-03-26 20:54:04', 12, 9),
(6, '2026-03-26 23:04:08', 9, 16),
(8, '2026-03-27 07:16:21', 17, 9),
(9, '2026-03-27 19:30:29', 17, 22),
(10, '2026-03-27 19:33:31', 21, 22),
(13, '2026-03-28 04:17:52', 21, 9),
(14, '2026-03-28 04:18:45', 19, 9),
(15, '2026-03-28 04:35:28', 18, 9),
(16, '2026-03-28 05:31:29', 17, 23);

-- --------------------------------------------------------

--
-- Table structure for table `api_favoriteroom`
--

CREATE TABLE `api_favoriteroom` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `room_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_favoriteroom`
--

INSERT INTO `api_favoriteroom` (`id`, `created_at`, `room_id`, `user_id`) VALUES
(1, '2026-03-28 08:30:10.912345', 1, 9);

-- --------------------------------------------------------

--
-- Table structure for table `api_hotel`
--

CREATE TABLE `api_hotel` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `address` longtext NOT NULL,
  `city` varchar(100) NOT NULL,
  `stars` double NOT NULL,
  `rating` double NOT NULL,
  `review_count` int(11) NOT NULL,
  `amenities` longtext DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `website` varchar(500) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_hotel`
--

INSERT INTO `api_hotel` (`id`, `name`, `description`, `address`, `city`, `stars`, `rating`, `review_count`, `amenities`, `image_url`, `phone`, `email`, `website`, `latitude`, `longitude`, `is_active`, `created_at`) VALUES
(1, 'The Grand Chennai', 'A luxury 5-star hotel in the heart of Chennai with stunning views of the Bay of Bengal.', '123 Anna Salai, Guindy, Chennai', 'Chennai', 5, 4.8, 342, 'WiFi,Pool,Gym,Spa,Restaurant,Bar,Parking,Room Service,AC,Laundry', NULL, '+91-44-2345-6789', NULL, NULL, NULL, NULL, 1, '2026-03-24 23:24:56.000000'),
(2, 'Chennai Comfort Inn', 'Affordable and comfortable stay in T. Nagar, perfect for business travelers.', '45 Usman Road, T. Nagar, Chennai', 'Chennai', 3, 4.2, 187, 'WiFi,AC,Restaurant,Parking,Laundry', NULL, '+91-44-2890-1234', NULL, NULL, NULL, NULL, 1, '2026-03-24 23:24:56.000000'),
(3, 'Marina Bay Resort', 'A beachfront resort near Marina Beach with spectacular ocean views.', '78 Kamarajar Salai, Marina, Chennai', 'Chennai', 4, 4.5, 256, 'WiFi,Pool,Gym,Spa,Restaurant,Beach Access,Parking,Room Service,AC', NULL, '+91-44-2567-8901', NULL, NULL, NULL, NULL, 1, '2026-03-24 23:24:56.000000'),
(4, 'Budget Stay Chennai', 'No-frills budget accommodation near Chennai Central. Perfect for backpackers.', '12 Poonamallee High Road, Chennai Central', 'Chennai', 2, 3.8, 95, 'WiFi,AC,Parking', NULL, '+91-44-2345-0000', NULL, NULL, NULL, NULL, 1, '2026-03-24 23:24:56.000000'),
(5, 'Skyline Business Hotel', 'Premium business hotel in OMR IT corridor with modern conference rooms.', '200 Old Mahabalipuram Road, Sholinganallur, Chennai', 'Chennai', 4, 4.3, 178, 'WiFi,Gym,Restaurant,Business Center,Parking,Room Service,AC', NULL, '+91-44-4567-8901', NULL, NULL, NULL, NULL, 1, '2026-03-24 23:24:56.000000'),
(6, 'Indira Residency', 'Comfortable stay near Adyar. Perfect for business travelers and families.', 'Indira Nagar, Adyar, Chennai', 'Chennai', 4, 4.5, 0, 'WiFi, AC, Breakfast, Parking', 'https://images.unsplash.com/photo-1551882547-ff43c33ff78e?auto=format&fit=crop&q=80&w=800', NULL, NULL, NULL, NULL, NULL, 1, '2026-03-24 21:04:28.498585'),
(7, 'Beachside Suites', 'Relax with stunning ocean views on the East Coast Road.', 'ECR, Chennai, Tamil Nadu', 'Chennai', 4, 4.2, 0, 'WiFi, Beach View, Pool, Bar', 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&q=80&w=800', NULL, NULL, NULL, NULL, NULL, 1, '2026-03-24 21:04:28.529765'),
(8, 'Silicon Valley Hub', 'Modern suites for tech professionals in Bangalore\'s IT hub.', 'Whitefield, Bangalore, Karnataka', 'Bangalore', 4, 4.6, 0, 'WiFi, Gym, Conference Room, AC', 'https://images.unsplash.com/photo-1561501900-3701fa6a0864?auto=format&fit=crop&q=80&w=800', NULL, NULL, NULL, NULL, NULL, 1, '2026-03-24 21:04:28.559579'),
(9, 'Heritage Palace', 'Stay like royalty in our heritage-inspired palace rooms.', 'Near Palace, Mysore, Karnataka', 'Mysore', 5, 4.9, 0, 'WiFi, Heritage Decor, Spa, Fine Dining', 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&q=80&w=800', NULL, NULL, NULL, NULL, NULL, 1, '2026-03-24 21:04:28.583548');

-- --------------------------------------------------------

--
-- Table structure for table `api_hotelresult`
--

CREATE TABLE `api_hotelresult` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `city` varchar(100) NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `stars` double DEFAULT NULL,
  `dist_km` double DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `website` varchar(500) DEFAULT NULL,
  `source` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_hotelresult`
--

INSERT INTO `api_hotelresult` (`id`, `title`, `address`, `city`, `price`, `stars`, `dist_km`, `phone`, `website`, `source`, `created_at`) VALUES
(1, 'The Park Avenue Hotel', 'Nabikhan Street, Chennai', 'Chennai', 2487, NULL, 0.03, '07305010423', NULL, 'Hotel', '2026-03-23 19:05:45'),
(2, 'White Park', 'Chennai Corporation, Chennai, Tamil Nadu, India', 'Chennai', 2031, NULL, 0.06, NULL, NULL, 'Hotel', '2026-03-23 19:05:45'),
(3, 'MATHI RESIDENCY', 'Kumarappa Chetty Street, Chennai', 'Chennai', 2021, NULL, 0.08, '+919363756780', 'https://www.mathiresidency.com/', 'Motel', '2026-03-23 19:05:45'),
(4, 'Grand Oliver', 'Chennai Corporation, Chennai, Tamil Nadu, India', 'Chennai', 2159, NULL, 0.13, NULL, NULL, 'Hotel', '2026-03-23 19:05:45'),
(5, 'Greens Suite', 'Varasidhi Vinayakar Koil Street', 'Chennai', 2394, NULL, 0.25, '+91 44 4262 9405', 'greenssuite2021@gmail.com', 'Hotel', '2026-03-23 19:05:45'),
(6, '4U', 'Chennai Corporation, Chennai, Tamil Nadu, India', 'Chennai', 2082, NULL, 0.26, NULL, NULL, 'Hotel', '2026-03-23 19:05:45'),
(7, 'Bell Central', 'Chennai Corporation, Chennai, Tamil Nadu, India', 'Chennai', 1627, NULL, 0.35, NULL, NULL, 'Hotel', '2026-03-23 19:05:45'),
(8, 'Unnamed Accommodation', 'Chennai Corporation, Chennai, Tamil Nadu, India', 'Chennai', 2146, NULL, 0.36, NULL, NULL, 'Hotel', '2026-03-23 19:05:45'),
(9, 'Modern Central Lodge', 'Chennai Corporation, Chennai, Tamil Nadu, India', 'Chennai', 2169, NULL, 0.65, NULL, NULL, 'Hotel', '2026-03-23 19:05:45'),
(10, 'Saravana Inn', 'Chennai Corporation, Chennai, Tamil Nadu, India', 'Chennai', 1982, NULL, 0.65, NULL, NULL, 'Hotel', '2026-03-23 19:05:45'),
(11, 'Jaishankar Lodge', 'Chennai Corporation, Chennai, Tamil Nadu, India', 'Chennai', 1717, NULL, 0.65, NULL, NULL, 'Hotel', '2026-03-23 19:05:45'),
(12, 'Hotel home town', 'Mumbai, Mumbai Suburban District, Maharashtra, 400051, India', 'Mumbai', 1501, NULL, 0.4, NULL, NULL, 'Hotel', '2026-03-23 19:07:01'),
(13, 'Maitri Classic Bldg', 'Mumbai, Mumbai Suburban District, Maharashtra, 400051, India', 'Mumbai', 2134, NULL, 0.79, NULL, NULL, 'Apartment', '2026-03-23 19:07:01'),
(14, 'Unnamed Accommodation', 'Mumbai, Mumbai Suburban District, Maharashtra, 400051, India', 'Mumbai', 1613, NULL, 1.17, NULL, NULL, 'Hotel', '2026-03-23 19:07:01'),
(15, 'Shangrila', 'Mumbai, Mumbai Suburban District, Maharashtra, 400051, India', 'Mumbai', 1860, NULL, 1.26, NULL, NULL, 'Hotel', '2026-03-23 19:07:01'),
(16, 'Trident Hotel', 'Bandra Kurla Complex Road, Mumbai', 'Mumbai', 2401, NULL, 1.31, NULL, NULL, 'Hotel', '2026-03-23 19:07:01'),
(17, 'Sofitel', 'Bandra Kurla Complex, Bandra East, Mumbai', 'Mumbai', 2072, NULL, 1.41, '+91 (22) 6117 5000', 'https://www.sofitel-mumbai-bkc.com/', 'Hotel', '2026-03-23 19:07:01'),
(18, 'Sagar Restaurant', 'Mumbai, Mumbai Suburban District, Maharashtra, 400051, India', 'Mumbai', 1899, NULL, 1.68, NULL, NULL, 'Hotel', '2026-03-23 19:07:01'),
(19, 'triveni bar', 'Mumbai, Mumbai Suburban District, Maharashtra, 400051, India', 'Mumbai', 1847, NULL, 1.9, NULL, NULL, 'Hotel', '2026-03-23 19:07:01'),
(20, 'Hotel T-Junction', 'Mumbai, Mumbai Suburban District, Maharashtra, 400051, India', 'Mumbai', 1692, NULL, 1.95, NULL, NULL, 'Hotel', '2026-03-23 19:07:01'),
(21, 'ibis Mumbai BKC', 'CST Road, Kolevery Village, Kalina, Mumbai', 'Mumbai', 1715, NULL, 2.12, '+91-22-3129-3600', 'https://all.accor.com/hotel/6830/index.en.shtml', 'Hotel', '2026-03-23 19:07:01'),
(22, 'Anita Mahal', 'Mumbai, Mumbai Suburban District, Maharashtra, 400051, India', 'Mumbai', 2438, NULL, 2.21, NULL, NULL, 'Hotel', '2026-03-23 19:07:01'),
(23, 'Janata Tawa Grill', 'Mumbai, Mumbai Suburban District, Maharashtra, 400051, India', 'Mumbai', 2197, NULL, 2.52, NULL, NULL, 'Hotel', '2026-03-23 19:07:01'),
(24, 'KOLAS Hotel', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', 'Ongole', 1559, NULL, 0.91, NULL, NULL, 'Hotel', '2026-03-23 19:40:18'),
(25, 'Mohan Lodge', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', 'Ongole', 1962, NULL, 0.95, NULL, NULL, 'Hotel', '2026-03-23 19:40:18'),
(26, 'krishna lodge', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', 'Ongole', 1940, NULL, 1.02, NULL, NULL, 'Motel', '2026-03-23 19:40:18'),
(27, 'ajantha hotel', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', 'Ongole', 1725, NULL, 1.02, NULL, NULL, 'Motel', '2026-03-23 19:40:18'),
(28, 'Hotel Mourya Grand, Ongole', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', 'Ongole', 1673, NULL, 1.04, NULL, NULL, 'Motel', '2026-03-23 19:40:18'),
(29, 'Ajantha', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', 'Ongole', 2147, NULL, 1.06, NULL, NULL, 'Hotel', '2026-03-23 19:40:18'),
(30, 'SOWMYA RESIDENCY', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', 'Ongole', 2116, NULL, 1.06, NULL, NULL, 'Motel', '2026-03-23 19:40:18'),
(31, 'Mourya Inn, Ongole', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', 'Ongole', 2180, NULL, 1.07, NULL, NULL, 'Motel', '2026-03-23 19:40:18'),
(32, 'Yallamandaiah Residency & Lodge', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', 'Ongole', 2343, NULL, 1.13, NULL, NULL, 'Hotel', '2026-03-23 19:40:18'),
(33, 'Sunrise Boys Hostel', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', 'Ongole', 2471, NULL, 1.13, NULL, NULL, 'Hostel', '2026-03-23 19:40:18'),
(34, 'Manorama Lodge', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', 'Ongole', 2084, NULL, 1.15, NULL, NULL, 'Motel', '2026-03-23 19:40:18'),
(35, 'Unnamed Accommodation', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', 'Ongole', 1613, NULL, 1.18, NULL, NULL, 'Hotel', '2026-03-23 19:40:18'),
(36, 'New Apsara Lodge', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', 'Ongole', 1884, NULL, 1.2, NULL, NULL, 'Hotel', '2026-03-23 19:40:18'),
(37, 'Government womens hostel', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', 'Ongole', 1963, NULL, 1.21, NULL, NULL, 'Hostel', '2026-03-23 19:40:18'),
(38, 'Srikanya Lodge', 'Ongole, Prakasam, Andhra Pradesh, 523002, India', 'Ongole', 2035, NULL, 1.28, NULL, NULL, 'Hotel', '2026-03-23 19:40:18'),
(39, 'TAJ Lodge', 'Chirala, Bapatla, Andhra Pradesh, 523155, India', 'Chirala', 2188, NULL, 1.11, NULL, NULL, 'Hotel', '2026-03-23 19:40:36'),
(40, 'Bala Residency', 'Chirala, Bapatla, Andhra Pradesh, 523155, India', 'Chirala', 2094, NULL, 1.14, NULL, NULL, 'Hotel', '2026-03-23 19:40:36'),
(41, 'Aruna Residency Lodge', 'Chirala, Bapatla, Andhra Pradesh, 523155, India', 'Chirala', 1888, NULL, 1.18, NULL, NULL, 'Hotel', '2026-03-23 19:40:36'),
(42, 'TULIP RESIDENCY', 'Muntha vari Centre, Chirala', 'Chirala', 2004, NULL, 1.73, NULL, NULL, 'Motel', '2026-03-23 19:40:36'),
(43, 'Sri Sapthagiri Lodge', 'High School Road, Chirala', 'Chirala', 1696, NULL, 1.78, '08594232806', NULL, 'Motel', '2026-03-23 19:40:36'),
(44, 'Girls Hostel', 'Chirala, Bapatla, Andhra Pradesh, 523155, India', 'Chirala', 1658, NULL, 7.73, NULL, NULL, 'Hostel', '2026-03-23 19:40:36'),
(45, 'Gopi hostel', 'kukkalavaripalem 6-169, Malleswar, Bapatla', 'Chirala', 2486, NULL, 10.56, NULL, NULL, 'Hostel', '2026-03-23 19:40:36'),
(46, 'divya ladies hostel', 'Chirala, Bapatla, Andhra Pradesh, 523155, India', 'Chirala', 1961, NULL, 11.55, NULL, NULL, 'Hostel', '2026-03-23 19:40:36'),
(47, 'Ayyappa Tiffin Center', 'Chirala, Bapatla, Andhra Pradesh, 523155, India', 'Chirala', 1974, NULL, 13.59, NULL, NULL, 'Hotel', '2026-03-23 19:40:36'),
(48, 'vemana boys hostel', 'Chirala, Bapatla, Andhra Pradesh, 523155, India', 'Chirala', 2185, NULL, 13.68, NULL, NULL, 'Hostel', '2026-03-23 19:40:36'),
(49, 'Kona Bhavan', 'Chirala, Bapatla, Andhra Pradesh, 523155, India', 'Chirala', 1825, NULL, 14.62, NULL, NULL, 'Hotel', '2026-03-23 19:40:36'),
(50, 'Kerala Lodge', 'Chennai Corporation, Chennai, Tamil Nadu, India', 'Chennai', 1971, NULL, 0.65, NULL, NULL, 'Hotel', '2026-03-23 21:00:24'),
(51, 'Central Lodge Deluxe', 'Chennai Corporation, Chennai, Tamil Nadu, India', 'Chennai', 1853, NULL, 0.66, '+914442053383', NULL, 'Hotel', '2026-03-23 21:00:24'),
(52, 'Hotel City Tower', 'Chennai Corporation, Chennai, Tamil Nadu, India', 'Chennai', 1510, NULL, 0.66, NULL, NULL, 'Hotel', '2026-03-23 21:00:24'),
(53, 'City Home', 'Chennai Corporation, Chennai, Tamil Nadu, India', 'Chennai', 1530, NULL, 0.67, NULL, NULL, 'Hotel', '2026-03-23 21:00:24'),
(54, 'Hotel Sakthi', 'Chennai Corporation, Chennai, Tamil Nadu, India', 'Chennai', 1868, NULL, 0.67, NULL, NULL, 'Hotel', '2026-03-23 21:00:24'),
(55, 'Royal Inn', 'SRM University, Meerut Road, Modinagar, Ghaziabad, Uttar Pradesh, 201204, India', 'Srm university', 1988, NULL, 2.17, NULL, NULL, 'Hotel', '2026-03-24 04:34:23'),
(56, 'Chanakya', 'SRM University, Meerut Road, Modinagar, Ghaziabad, Uttar Pradesh, 201204, India', 'Srm university', 2314, NULL, 6.23, NULL, NULL, 'Hostel', '2026-03-24 04:34:23'),
(57, 'Chanakya/Kanoja', 'SRM University, Meerut Road, Modinagar, Ghaziabad, Uttar Pradesh, 201204, India', 'Srm university', 2051, NULL, 6.24, NULL, NULL, 'Hostel', '2026-03-24 04:34:23'),
(58, 'Unnamed Accommodation', 'Galand', 'Srm university', 1917, NULL, 13.64, NULL, NULL, 'Guest_house', '2026-03-24 04:34:23'),
(59, 'Raj Hostel', 'MDA, Meerut', 'Srm university', 2410, NULL, 16.5, NULL, NULL, 'Hostel', '2026-03-24 04:34:23'),
(60, 'OYO', 'SRM University, Meerut Road, Modinagar, Ghaziabad, Uttar Pradesh, 201204, India', 'Srm university', 2415, NULL, 17.89, NULL, NULL, 'Hotel', '2026-03-24 04:34:23'),
(61, 'Best Guest House', 'Halcyon Technologies, CIT Nagar 1st Main Road, CMWSSB Division 141, Ward 141, Zone 10 Kodambakkam, Chennai Corporation, Chennai, Tamil Nadu, 600022, India', 'T nagar', 1866, NULL, 0.45, NULL, NULL, 'Hotel', '2026-03-24 04:48:35'),
(62, 'XLNC Women\'s Hostel', 'South Usman Road, Chennai', 'T nagar', 2012, NULL, 0.45, NULL, NULL, 'Hostel', '2026-03-24 04:48:35'),
(63, 'Unnamed Accommodation', 'Halcyon Technologies, CIT Nagar 1st Main Road, CMWSSB Division 141, Ward 141, Zone 10 Kodambakkam, Chennai Corporation, Chennai, Tamil Nadu, 600022, India', 'T nagar', 1917, NULL, 0.85, NULL, NULL, 'Hotel', '2026-03-24 04:48:35'),
(64, 'GLM Meridian', 'Halcyon Technologies, CIT Nagar 1st Main Road, CMWSSB Division 141, Ward 141, Zone 10 Kodambakkam, Chennai Corporation, Chennai, Tamil Nadu, 600022, India', 'T nagar', 2362, NULL, 1, NULL, NULL, 'Hotel', '2026-03-24 04:48:35'),
(65, 'Murugan idly kadai', 'Kodambakkam Rd, Chennai', 'T nagar', 2466, NULL, 1.16, NULL, NULL, 'Hotel', '2026-03-24 04:48:35'),
(66, 'Kuber Inn', 'Duraiswamy Road, Chennai', 'T nagar', 1598, NULL, 1.27, NULL, NULL, 'Hotel', '2026-03-24 04:48:35'),
(67, 'Amma Unavagam', 'Kodambakkam Road', 'T nagar', 1564, NULL, 1.3, NULL, NULL, 'Hotel', '2026-03-24 04:48:35'),
(68, 'Vistana', 'Halcyon Technologies, CIT Nagar 1st Main Road, CMWSSB Division 141, Ward 141, Zone 10 Kodambakkam, Chennai Corporation, Chennai, Tamil Nadu, 600022, India', 'T nagar', 2448, NULL, 1.34, '04424356074', NULL, 'Hotel', '2026-03-24 04:48:35'),
(69, 'Arul home', 'Elumalai Street, Saidapet', 'T nagar', 1953, NULL, 1.35, NULL, NULL, 'Guest_house', '2026-03-24 04:48:35'),
(70, 'OYO 2527 Lake View Park', 'Halcyon Technologies, CIT Nagar 1st Main Road, CMWSSB Division 141, Ward 141, Zone 10 Kodambakkam, Chennai Corporation, Chennai, Tamil Nadu, 600022, India', 'T nagar', 2270, NULL, 1.35, NULL, NULL, 'Hotel', '2026-03-24 04:48:35'),
(71, 'Kavi Home', 'Elumalai Street, Saidapet', 'T nagar', 1709, NULL, 1.38, NULL, NULL, 'Guest_house', '2026-03-24 04:48:35'),
(72, 'Novotel', 'Halcyon Technologies, CIT Nagar 1st Main Road, CMWSSB Division 141, Ward 141, Zone 10 Kodambakkam, Chennai Corporation, Chennai, Tamil Nadu, 600022, India', 'T nagar', 2249, NULL, 1.45, '+914424302333', NULL, 'Hotel', '2026-03-24 04:48:35'),
(73, 'VIGNESH', 'Subramaniya Salai, Saidapet', 'T nagar', 2306, NULL, 1.47, NULL, NULL, 'Guest_house', '2026-03-24 04:48:35'),
(74, 'The Raintree Hotel', 'Halcyon Technologies, CIT Nagar 1st Main Road, CMWSSB Division 141, Ward 141, Zone 10 Kodambakkam, Chennai Corporation, Chennai, Tamil Nadu, 600022, India', 'T nagar', 1664, NULL, 1.49, NULL, NULL, 'Hotel', '2026-03-24 04:48:35');

-- --------------------------------------------------------

--
-- Table structure for table `api_hotelroom`
--

CREATE TABLE `api_hotelroom` (
  `id` bigint(20) NOT NULL,
  `room_number` varchar(20) NOT NULL,
  `room_type` varchar(20) NOT NULL,
  `capacity` int(10) UNSIGNED NOT NULL CHECK (`capacity` >= 0),
  `price_per_night` decimal(10,2) NOT NULL,
  `amenities` longtext DEFAULT NULL,
  `bed_type` varchar(50) NOT NULL,
  `floor` int(10) UNSIGNED NOT NULL CHECK (`floor` >= 0),
  `image_url` varchar(500) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `hotel_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_hotelroom`
--

INSERT INTO `api_hotelroom` (`id`, `room_number`, `room_type`, `capacity`, `price_per_night`, `amenities`, `bed_type`, `floor`, `image_url`, `is_active`, `created_at`, `hotel_id`) VALUES
(1, '101', 'SINGLE', 1, 2500.00, 'AC,WiFi,TV', 'Single Bed', 1, NULL, 1, '2026-03-24 23:24:56.000000', 1),
(2, '102', 'DOUBLE', 2, 3500.00, 'AC,WiFi,TV,Minibar', 'Queen Bed', 1, NULL, 1, '2026-03-24 23:24:56.000000', 1),
(3, '201', 'DELUXE', 2, 5500.00, 'AC,WiFi,TV,Minibar,Balcony', 'King Bed', 2, NULL, 1, '2026-03-24 23:24:56.000000', 1),
(4, '301', 'SUITE', 3, 8500.00, 'AC,WiFi,TV,Minibar,Balcony,Jacuzzi', 'King Bed', 3, NULL, 1, '2026-03-24 23:24:56.000000', 1),
(5, '103', 'SINGLE', 1, 2500.00, 'AC,WiFi,TV', 'Single Bed', 1, NULL, 1, '2026-03-24 23:24:56.000000', 1),
(6, '202', 'DOUBLE', 2, 3800.00, 'AC,WiFi,TV,Minibar,Sea View', 'Queen Bed', 2, NULL, 1, '2026-03-24 23:24:56.000000', 1),
(7, 'A1', 'SINGLE', 1, 1200.00, 'AC,WiFi,TV', 'Single Bed', 1, NULL, 1, '2026-03-24 23:24:56.000000', 2),
(8, 'A2', 'SINGLE', 1, 1200.00, 'AC,WiFi,TV', 'Single Bed', 1, NULL, 1, '2026-03-24 23:24:56.000000', 2),
(9, 'B1', 'DOUBLE', 2, 1800.00, 'AC,WiFi,TV', 'Double Bed', 2, NULL, 1, '2026-03-24 23:24:56.000000', 2),
(10, 'B2', 'DOUBLE', 2, 1800.00, 'AC,WiFi,TV', 'Double Bed', 2, NULL, 1, '2026-03-24 23:24:56.000000', 2),
(11, 'C1', 'FAMILY', 4, 2500.00, 'AC,WiFi,TV,Fridge', 'King Bed + Bunk', 3, NULL, 1, '2026-03-24 23:24:56.000000', 2),
(12, 'S1', 'DELUXE', 2, 4000.00, 'AC,WiFi,TV,Sea View,Balcony', 'King Bed', 1, NULL, 1, '2026-03-24 23:24:56.000000', 3),
(13, 'S2', 'DELUXE', 2, 4000.00, 'AC,WiFi,TV,Sea View,Balcony', 'King Bed', 1, NULL, 1, '2026-03-24 23:24:56.000000', 3),
(14, 'S3', 'SUITE', 3, 7000.00, 'AC,WiFi,TV,Sea View,Balcony,Jacuzzi', 'King Bed', 2, NULL, 1, '2026-03-24 23:24:56.000000', 3),
(15, 'D1', 'DOUBLE', 2, 3000.00, 'AC,WiFi,TV,Garden View', 'Queen Bed', 1, NULL, 1, '2026-03-24 23:24:56.000000', 3),
(16, 'R1', 'DORMITORY', 1, 500.00, 'Fan,WiFi', 'Bunk Bed', 1, NULL, 1, '2026-03-24 23:24:56.000000', 4),
(17, 'R2', 'DORMITORY', 1, 500.00, 'Fan,WiFi', 'Bunk Bed', 1, NULL, 1, '2026-03-24 23:24:56.000000', 4),
(18, 'R3', 'SINGLE', 1, 800.00, 'AC,WiFi', 'Single Bed', 2, NULL, 1, '2026-03-24 23:24:56.000000', 4),
(19, 'R4', 'DOUBLE', 2, 1200.00, 'AC,WiFi,TV', 'Double Bed', 2, NULL, 1, '2026-03-24 23:24:56.000000', 4),
(20, 'E101', 'SINGLE', 1, 2000.00, 'AC,WiFi,TV,Work Desk', 'Single Bed', 1, NULL, 1, '2026-03-24 23:24:56.000000', 5),
(21, 'E201', 'DOUBLE', 2, 3200.00, 'AC,WiFi,TV,Work Desk,Minibar', 'Queen Bed', 2, NULL, 1, '2026-03-24 23:24:56.000000', 5),
(22, 'E301', 'DELUXE', 2, 4500.00, 'AC,WiFi,TV,Work Desk,Minibar', 'King Bed', 3, NULL, 1, '2026-03-24 23:24:56.000000', 5),
(23, 'E401', 'SUITE', 3, 7500.00, 'AC,WiFi,TV,Work Desk,Minibar,Living Room', 'King Bed', 4, NULL, 1, '2026-03-24 23:24:56.000000', 5),
(24, '7105', 'SINGLE', 1, 1978.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.502749', 6),
(25, '5202', 'SINGLE', 1, 1823.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.505727', 6),
(26, '9305', 'SINGLE', 1, 1770.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.507439', 6),
(27, '1109', 'DOUBLE', 2, 2783.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.509192', 6),
(28, '5206', 'DOUBLE', 2, 2658.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.512227', 6),
(29, '8304', 'DOUBLE', 2, 2855.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.515472', 6),
(30, '7108', 'DELUXE', 2, 4535.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.517371', 6),
(31, '4205', 'DELUXE', 2, 4741.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.519278', 6),
(32, '8304', 'DELUXE', 2, 4501.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.521654', 6),
(33, '4102', 'SUITE', 4, 8887.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.523084', 6),
(34, '6209', 'SUITE', 4, 8947.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.524597', 6),
(35, '9307', 'SUITE', 4, 8911.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.526056', 6),
(36, '3104', 'SINGLE', 1, 1901.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.531970', 7),
(37, '2209', 'SINGLE', 1, 1746.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.533492', 7),
(38, '9304', 'SINGLE', 1, 1614.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.535363', 7),
(39, '8107', 'DOUBLE', 2, 2661.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.536899', 7),
(40, '9208', 'DOUBLE', 2, 2600.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.538586', 7),
(41, '5303', 'DOUBLE', 2, 2704.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.540261', 7),
(42, '4106', 'DELUXE', 2, 4731.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.542078', 7),
(43, '1201', 'DELUXE', 2, 4908.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.546611', 7),
(44, '4309', 'DELUXE', 2, 4973.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.549157', 7),
(45, '1108', 'SUITE', 4, 8555.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.550948', 7),
(46, '9207', 'SUITE', 4, 8790.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.553025', 7),
(47, '8303', 'SUITE', 4, 8815.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.556051', 7),
(48, '4101', 'SINGLE', 1, 1916.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.562568', 8),
(49, '5202', 'SINGLE', 1, 1594.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.564543', 8),
(50, '6304', 'SINGLE', 1, 1636.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.566127', 8),
(51, '8102', 'DOUBLE', 2, 2633.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.568132', 8),
(52, '5205', 'DOUBLE', 2, 2529.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.569863', 8),
(53, '2301', 'DOUBLE', 2, 2586.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.571626', 8),
(54, '9109', 'DELUXE', 2, 4679.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.573593', 8),
(55, '7206', 'DELUXE', 2, 4929.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.574946', 8),
(56, '1309', 'DELUXE', 2, 4590.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.576395', 8),
(57, '1102', 'SUITE', 4, 8521.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.578024', 8),
(58, '6208', 'SUITE', 4, 8714.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.579749', 8),
(59, '1303', 'SUITE', 4, 8904.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.581105', 8),
(60, '4104', 'SINGLE', 1, 1759.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.585232', 9),
(61, '5205', 'SINGLE', 1, 1792.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.586483', 9),
(62, '2301', 'SINGLE', 1, 1925.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.587909', 9),
(63, '5101', 'DOUBLE', 2, 2683.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.589105', 9),
(64, '3205', 'DOUBLE', 2, 2911.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.590660', 9),
(65, '8304', 'DOUBLE', 2, 2736.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.592621', 9),
(66, '7101', 'DELUXE', 2, 4528.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.594863', 9),
(67, '7202', 'DELUXE', 2, 4665.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.596919', 9),
(68, '8307', 'DELUXE', 2, 4694.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.598664', 9),
(69, '3103', 'SUITE', 4, 8739.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.600376', 9),
(70, '9201', 'SUITE', 4, 8882.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.601952', 9),
(71, '5307', 'SUITE', 4, 8967.00, NULL, 'Queen Bed', 1, NULL, 1, '2026-03-24 21:04:28.603176', 9);

-- --------------------------------------------------------

--
-- Table structure for table `api_hotelroombooking`
--

CREATE TABLE `api_hotelroombooking` (
  `id` bigint(20) NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `guests` int(10) UNSIGNED NOT NULL CHECK (`guests` >= 0),
  `total_price` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `booking_reference` varchar(20) NOT NULL,
  `special_requests` longtext DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `room_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_hotelroombooking`
--

INSERT INTO `api_hotelroombooking` (`id`, `check_in`, `check_out`, `guests`, `total_price`, `status`, `booking_reference`, `special_requests`, `created_at`, `hotel_id`, `room_id`, `user_id`) VALUES
(1, '2026-03-25', '2026-03-28', 1, 6000.00, 'CONFIRMED', 'RS-7A78AD98', '', '2026-03-24 19:22:58.925478', 5, 20, 9),
(2, '2026-03-25', '2026-03-27', 1, 5000.00, 'CONFIRMED', 'RS-73F7FD6C', '', '2026-03-24 20:09:55.876517', 1, 1, 9),
(3, '2026-03-25', '2026-03-27', 3, 2400.00, 'CONFIRMED', 'RS-5A3909B2', '', '2026-03-24 20:32:03.928698', 2, 7, 9),
(7, '2026-06-01', '2026-06-05', 1, 11644.00, 'CONFIRMED', 'RS-E98928BD', '', '2026-03-26 19:10:25.688225', 9, 64, 9),
(8, '2026-06-01', '2026-06-05', 1, 10944.00, 'CONFIRMED', 'RS-1886348E', '', '2026-03-26 19:10:30.457374', 9, 65, 9),
(9, '2026-06-01', '2026-06-05', 1, 7036.00, 'CONFIRMED', 'RS-6A5AC9BF', '', '2026-03-26 19:10:33.766566', 9, 60, 9),
(10, '2026-06-01', '2026-06-05', 1, 10000.00, 'CONFIRMED', 'RS-7BC1BAD7', '', '2026-03-26 21:43:34.032572', 1, 1, 13),
(11, '2026-06-01', '2026-06-05', 1, 14000.00, 'CONFIRMED', 'RS-6B0D95C3', '', '2026-03-26 22:02:14.381513', 1, 2, 14),
(12, '2026-06-01', '2026-06-05', 1, 22000.00, 'CONFIRMED', 'RS-8C1301B1', '', '2026-03-26 22:04:53.516027', 1, 3, 14),
(13, '2026-03-28', '2026-03-29', 1, 4000.00, 'CONFIRMED', 'RS-DDE2F709', '', '2026-03-27 04:32:52.319461', 3, 12, 17),
(14, '2026-03-28', '2026-03-29', 1, 3500.00, 'CONFIRMED', 'RS-D4CE4312', '', '2026-03-27 04:51:23.239234', 1, 2, 17),
(15, '2026-03-28', '2026-03-29', 1, 3000.00, 'CONFIRMED', 'RS-16321743', '', '2026-03-27 04:56:40.321837', 3, 15, 17),
(16, '2026-03-28', '2026-03-29', 1, 1901.00, 'CONFIRMED', 'RS-0ACE87BF', '', '2026-03-27 05:02:05.357151', 7, 36, 17),
(17, '2026-03-27', '2027-11-16', 1, 5091500.00, 'CONFIRMED', 'RS-DE6495EC', '', '2026-03-27 05:09:11.250236', 1, 4, 9),
(18, '2026-03-28', '2026-03-29', 1, 1200.00, 'CONFIRMED', 'RS-B99574B6', '', '2026-03-27 07:12:26.390854', 2, 7, 17),
(19, '2026-03-28', '2026-03-29', 1, 2500.00, 'CONFIRMED', 'RS-92A21097', '', '2026-03-27 07:21:26.846268', 1, 1, 18),
(20, '2026-03-28', '2026-03-29', 1, 1792.00, 'CONFIRMED', 'RS-B76EFD51', '', '2026-03-27 08:33:04.369011', 9, 61, 9),
(21, '2026-03-28', '2026-03-29', 1, 3800.00, 'CONFIRMED', 'RS-4EF7EE1C', '', '2026-03-27 08:37:47.410478', 1, 6, 9),
(22, '2026-03-28', '2026-03-29', 1, 1200.00, 'CONFIRMED', 'RS-AB92111E', '', '2026-03-27 09:21:11.719480', 2, 8, 21),
(23, '2026-03-29', '2026-03-31', 1, 5000.00, 'CONFIRMED', 'RS-F07C0C5A', '', '2026-03-27 19:55:55.360011', 1, 1, 22);

-- --------------------------------------------------------

--
-- Table structure for table `api_listedroom`
--

CREATE TABLE `api_listedroom` (
  `id` int(11) NOT NULL,
  `apartment_title` varchar(255) NOT NULL,
  `monthly_rent` decimal(10,0) NOT NULL,
  `description` text NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `bathroom_type` varchar(20) NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `entry_type` varchar(20) NOT NULL,
  `roommate_count` int(10) UNSIGNED NOT NULL CHECK (`roommate_count` >= 0),
  `status` varchar(20) NOT NULL,
  `available_from` date NOT NULL,
  `tags` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_listedroom`
--

INSERT INTO `api_listedroom` (`id`, `apartment_title`, `monthly_rent`, `description`, `is_active`, `created_at`, `user_id`, `address`, `bathroom_type`, `city`, `entry_type`, `roommate_count`, `status`, `available_from`, `tags`) VALUES
(1, 'Test Room for vdjksvdiebd', 1500, 'A nice test room', 1, '2026-03-28 05:02:24', 19, NULL, 'PRIVATE_BATH', NULL, 'KEYLESS', 1, 'AVAILABLE', '2026-03-28', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `api_listedroomphoto`
--

CREATE TABLE `api_listedroomphoto` (
  `id` int(11) NOT NULL,
  `image` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL,
  `room_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `api_matchresult`
--

CREATE TABLE `api_matchresult` (
  `id` int(11) NOT NULL,
  `ai_explanation` text DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `matched_user_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `compatibility_score` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_matchresult`
--

INSERT INTO `api_matchresult` (`id`, `ai_explanation`, `created_at`, `matched_user_id`, `user_id`, `compatibility_score`) VALUES
(143, 'AI found moderate compatibility based on available lifestyle and budget data.', '2026-03-25 19:26:53', 9, 11, 60),
(144, 'AI found moderate compatibility based on available lifestyle and budget data.', '2026-03-25 19:26:53', 12, 11, 60),
(181, 'AI found moderate compatibility based on available lifestyle and budget data.', '2026-03-26 21:43:06', 9, 13, 60),
(182, 'AI found moderate compatibility based on available lifestyle and budget data.', '2026-03-26 21:43:06', 11, 13, 60),
(183, 'AI found moderate compatibility based on available lifestyle and budget data.', '2026-03-26 21:43:06', 12, 13, 60),
(186, 'AI found moderate compatibility based on available lifestyle and budget data.', '2026-03-26 22:01:28', 9, 14, 60),
(211, 'AI found moderate compatibility based on available lifestyle and budget data.', '2026-03-26 23:32:43', 9, 16, 60),
(212, 'AI found moderate compatibility based on available lifestyle and budget data.', '2026-03-26 23:32:43', 15, 16, 60),
(224, 'AI found moderate compatibility based on available lifestyle and budget data.', '2026-03-27 07:09:40', 9, 17, 60),
(228, 'AI found moderate compatibility based on available lifestyle and budget data.', '2026-03-27 07:18:56', 9, 18, 60),
(229, 'AI predicts minimal risk based on compatible schedules, shared cleanliness expectations, similar communication and social styles.', '2026-03-27 07:18:56', 17, 18, 82),
(265, 'AI found moderate compatibility based on available lifestyle and budget data.', '2026-03-27 09:20:27', 9, 21, 60),
(266, 'AI predicts minimal risk based on compatible schedules, similar communication and social styles.', '2026-03-27 09:20:27', 17, 21, 72),
(267, 'AI predicts minimal risk based on similar communication and social styles.', '2026-03-27 09:20:27', 18, 21, 67),
(268, 'AI found moderate compatibility based on available lifestyle and budget data.', '2026-03-27 09:20:27', 19, 21, 60),
(269, 'AI found moderate compatibility based on available lifestyle and budget data.', '2026-03-27 09:20:27', 20, 21, 60),
(396, 'AI found moderate compatibility based on available lifestyle and budget data.', '2026-03-27 19:33:48', 9, 22, 66),
(397, 'AI predicts minimal risk based on compatible schedules, similar communication and social styles.', '2026-03-27 19:33:48', 21, 22, 76),
(438, 'AI predicts minimal risk based on compatible schedules, shared cleanliness expectations, similar communication and social styles.', '2026-03-28 07:50:12', 17, 24, 85),
(439, 'AI predicts minimal risk based on compatible schedules, shared cleanliness expectations, similar communication and social styles, close monthly budget range.', '2026-03-28 07:50:12', 23, 24, 94),
(443, 'AI predicts minimal risk based on compatible schedules, shared cleanliness expectations, similar communication and social styles.', '2026-03-28 08:32:07', 17, 23, 91),
(446, 'AI found moderate compatibility based on available lifestyle and budget data.', '2026-03-28 09:11:10', 21, 9, 66),
(459, 'AI found moderate compatibility based on available lifestyle and budget data.', '2026-03-31 05:03:45', 9, 25, 66),
(460, 'AI predicts minimal risk based on shared cleanliness expectations, similar communication and social styles.', '2026-03-31 05:03:45', 21, 25, 80);

-- --------------------------------------------------------

--
-- Table structure for table `api_notification`
--

CREATE TABLE `api_notification` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_notification`
--

INSERT INTO `api_notification` (`id`, `title`, `message`, `is_read`, `created_at`, `user_id`) VALUES
(1, 'Booking Confirmed! 🎉', 'Your booking at Skyline Business Hotel (Room E101) is confirmed! Ref: RS-7A78AD98. Check-in: 2026-03-25, Check-out: 2026-03-28. Total: ₹6000', 0, '2026-03-24 19:22:58', 9);

-- --------------------------------------------------------

--
-- Table structure for table `api_otp`
--

CREATE TABLE `api_otp` (
  `id` int(11) NOT NULL,
  `code` varchar(6) NOT NULL,
  `created_at` datetime NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_otp`
--

INSERT INTO `api_otp` (`id`, `code`, `created_at`, `user_id`) VALUES
(1, '564062', '2026-03-24 20:00:56', 11),
(3, '177932', '2026-03-26 21:40:11', 13),
(9, '627963', '2026-03-26 22:14:30', 14),
(11, '821754', '2026-03-26 22:35:05', 15),
(16, '677610', '2026-03-27 08:18:43', 19),
(17, '268143', '2026-03-27 08:26:45', 20);

-- --------------------------------------------------------

--
-- Table structure for table `api_passwordresetotp`
--

CREATE TABLE `api_passwordresetotp` (
  `id` int(11) NOT NULL,
  `otp` varchar(6) NOT NULL,
  `created_at` datetime NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_passwordresetotp`
--

INSERT INTO `api_passwordresetotp` (`id`, `otp`, `created_at`, `user_id`) VALUES
(2, '558833', '2026-03-26 22:11:25', 14),
(6, '195550', '2026-03-26 22:57:42', 16),
(8, '157935', '2026-03-27 08:28:14', 9);

-- --------------------------------------------------------

--
-- Table structure for table `api_room`
--

CREATE TABLE `api_room` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `location` varchar(255) NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `image` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `api_roomsharerequest`
--

CREATE TABLE `api_roomsharerequest` (
  `id` int(11) NOT NULL,
  `intro_message` text DEFAULT NULL,
  `preferred_move_in_date` date DEFAULT NULL,
  `duration_of_stay` varchar(20) DEFAULT NULL,
  `employment_status` varchar(20) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `requester_id` bigint(20) NOT NULL,
  `room_id` bigint(20) NOT NULL,
  `room_owner_id` bigint(20) NOT NULL,
  `ai_background_check_completed` tinyint(1) NOT NULL,
  `group_security_deposit` decimal(10,0) DEFAULT NULL,
  `identity_document` varchar(100) DEFAULT NULL,
  `identity_upload_source` varchar(20) DEFAULT NULL,
  `identity_verified` tinyint(1) NOT NULL,
  `total_move_in` decimal(10,0) DEFAULT NULL,
  `your_share_monthly` decimal(10,0) DEFAULT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_roomsharerequest`
--

INSERT INTO `api_roomsharerequest` (`id`, `intro_message`, `preferred_move_in_date`, `duration_of_stay`, `employment_status`, `created_at`, `requester_id`, `room_id`, `room_owner_id`, `ai_background_check_completed`, `group_security_deposit`, `identity_document`, `identity_upload_source`, `identity_verified`, `total_move_in`, `your_share_monthly`, `status`) VALUES
(1, 'Hi vdjksvdiebd@gmail.com, I\'m interested in sharing a room with you!', '2026-03-28', '12 Months', 'Full-time', '2026-03-28 05:02:24', 9, 1, 19, 1, 3000, '', NULL, 0, 4500, 1500, 'PENDING');

-- --------------------------------------------------------

--
-- Table structure for table `api_useraccountsettings`
--

CREATE TABLE `api_useraccountsettings` (
  `id` int(11) NOT NULL,
  `notifications_enabled` tinyint(1) NOT NULL,
  `language` varchar(50) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `privacy_settings` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_useraccountsettings`
--

INSERT INTO `api_useraccountsettings` (`id`, `notifications_enabled`, `language`, `user_id`, `privacy_settings`) VALUES
(4, 1, 'English (US)', 9, 'Default'),
(5, 1, 'English (US)', 10, 'Default'),
(6, 1, 'English (US)', 12, 'Default'),
(7, 1, 'English (US)', 11, 'Default'),
(8, 1, 'English (US)', 13, 'Default'),
(9, 1, 'English (US)', 14, 'Default'),
(10, 1, 'English (US)', 15, 'Default'),
(11, 1, 'English (US)', 16, 'Default'),
(12, 1, 'English (US)', 17, 'Default'),
(13, 1, 'English (US)', 18, 'Default'),
(14, 1, 'English (US)', 19, 'Default'),
(15, 1, 'English (US)', 20, 'Default'),
(16, 1, 'English (US)', 21, 'Default'),
(17, 1, 'English (US)', 22, 'Default'),
(18, 1, 'English (US)', 23, 'Default'),
(19, 1, 'English (US)', 24, 'Default'),
(20, 1, 'English (US)', 25, 'Default');

-- --------------------------------------------------------

--
-- Table structure for table `api_userbudgetlocation`
--

CREATE TABLE `api_userbudgetlocation` (
  `id` int(11) NOT NULL,
  `monthly_budget` decimal(10,0) NOT NULL,
  `created_at` datetime NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `preferred_city` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_userbudgetlocation`
--

INSERT INTO `api_userbudgetlocation` (`id`, `monthly_budget`, `created_at`, `user_id`, `preferred_city`) VALUES
(4, 5000, '2026-03-24 04:39:23', 10, 'himchal '),
(5, 2022, '2026-03-26 21:40:34', 13, 'Chennai'),
(6, 6121, '2026-03-26 22:00:35', 14, 'Chennai'),
(7, 6115, '2026-03-26 22:37:11', 16, 'Ongole'),
(8, 34515, '2026-03-27 04:30:11', 17, 'chennai '),
(9, 19704, '2026-03-27 07:18:52', 18, 'chennai'),
(10, 10773, '2026-03-27 09:17:48', 21, 'Chennai'),
(11, 15000, '2026-03-27 18:59:31', 22, 'Chennai'),
(12, 15000, '2026-03-28 03:56:04', 23, 'Chennai'),
(13, 15000, '2026-03-28 07:50:08', 24, 'Chennai'),
(14, 17087, '2026-03-31 04:53:24', 25, 'chennai');

-- --------------------------------------------------------

--
-- Table structure for table `api_userlifestyle`
--

CREATE TABLE `api_userlifestyle` (
  `id` int(11) NOT NULL,
  `sleep_schedule` varchar(20) NOT NULL,
  `cleanliness` varchar(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `social_interaction` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_userlifestyle`
--

INSERT INTO `api_userlifestyle` (`id`, `sleep_schedule`, `cleanliness`, `user_id`, `social_interaction`) VALUES
(4, 'Night Owl', 'Minimalist', 10, 'Extrovert'),
(5, 'Balanced', 'Organized', 13, 'Moderate'),
(6, 'Balanced', 'Organized', 14, 'Moderate'),
(7, 'Balanced', 'Organized', 16, 'Moderate'),
(8, 'Balanced', 'Organized', 17, 'Moderate'),
(9, 'Early Bird', 'Minimalist', 18, 'Moderate'),
(10, 'Night Owl', 'Relaxed', 21, 'Introvert'),
(11, 'Balanced', 'Organized', 22, 'Moderate'),
(12, 'Balanced', 'Organized', 23, 'Moderate'),
(13, 'Balanced', 'Organized', 24, 'Moderate'),
(14, 'Early Bird', 'Relaxed', 25, 'Introvert');

-- --------------------------------------------------------

--
-- Table structure for table `api_userprofile`
--

CREATE TABLE `api_userprofile` (
  `id` int(11) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `about_me` text DEFAULT NULL,
  `address` text DEFAULT NULL,
  `age` int(10) UNSIGNED DEFAULT NULL CHECK (`age` >= 0),
  `bookings` int(11) NOT NULL,
  `budget_range` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `move_in_date` date DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `profile_photo` varchar(100) DEFAULT NULL,
  `room_status` varchar(20) NOT NULL,
  `saved_rooms` int(11) NOT NULL,
  `target_area` varchar(255) DEFAULT NULL,
  `trust_score` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `is_premium` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_userprofile`
--

INSERT INTO `api_userprofile` (`id`, `user_id`, `about_me`, `address`, `age`, `bookings`, `budget_range`, `created_at`, `gender`, `move_in_date`, `occupation`, `photo`, `profile_photo`, `room_status`, `saved_rooms`, `target_area`, `trust_score`, `full_name`, `is_premium`) VALUES
(4, 9, 'Hi', 'Ongole', 21, 0, '1000', '2026-03-24 03:36:11', NULL, '2026-03-25', 'Student', '', '', 'SEEKING_ROOM', 0, 'ongole', 98, 'DIVYA', 1),
(6, 11, 'hi', 'Chennai', 21, 0, '1000', '2026-03-24 19:56:32', 'Male', '2026-03-25', 'Student', '', '', 'SEEKING_ROOM', 0, 'chennai', 98, 'Eswar', 0),
(7, 12, 'hi', 'Chennai', 21, 0, '1000', '2026-03-24 20:02:17', NULL, '2026-03-25', 'Student', '', '', 'SEEKING_ROOM', 0, 'chennai', 98, 'Eswar', 0),
(8, 13, NULL, 'Chennai', 21, 0, NULL, '2026-03-26 21:40:11', 'Male', NULL, 'Job', '', '', 'SEEKING_ROOM', 0, NULL, 98, 'Eswar', 0),
(9, 14, 'Hi', 'Chennai', 20, 0, '1000', '2026-03-26 22:00:01', 'Male', NULL, 'Job', '', '', 'SEEKING_ROOM', 0, 'Chennai', 98, 'Eswar', 0),
(10, 15, NULL, 'Ongole', 21, 0, NULL, '2026-03-26 22:32:12', 'Male', NULL, 'Job', '', '', 'SEEKING_ROOM', 0, NULL, 98, 'Eswar', 0),
(11, 16, 'Hi', 'Ongole', 21, 0, '1000', '2026-03-26 22:36:30', 'Male', NULL, 'Job', '', '', 'SEEKING_ROOM', 0, 'Ongole', 98, 'Eswar', 0),
(12, 17, '', 'chennai', 21, 0, '10000', '2026-03-27 04:27:54', 'Male', NULL, 'student', '', '', 'SEEKING_ROOM', 0, 'chennai', 98, 'Divya', 0),
(13, 18, NULL, 'chennai', 22, 0, NULL, '2026-03-27 07:17:29', 'Female', NULL, 'software Engineer', '', '', 'SEEKING_ROOM', 0, NULL, 98, 'vasanthi', 0),
(14, 19, NULL, '12839302', 22, 0, NULL, '2026-03-27 08:18:43', 'Female', NULL, '12479403373', '', '', 'SEEKING_ROOM', 0, NULL, 98, '123', 0),
(15, 20, NULL, 'ks sks', 22, 0, NULL, '2026-03-27 08:26:45', 'Female', NULL, 'vsksn spa', '', '', 'SEEKING_ROOM', 0, NULL, 98, 'sjs dj', 0),
(16, 21, 'Hi', 'Chennai', 20, 0, '10000', '2026-03-27 09:16:47', 'Male', NULL, 'analyst', '', '', 'SEEKING_ROOM', 0, 'ongole', 98, 'shunu', 0),
(17, 22, 'Hi', 'chennai', 21, 0, '10000', '2026-03-27 18:59:01', 'Male', NULL, 'student', '', '', 'SEEKING_ROOM', 0, 'Ongole', 98, 'Eswar', 1),
(18, 23, 'Hi', 'chennai', 21, 0, '10000', '2026-03-28 03:55:21', 'Male', NULL, 'student', '', '', 'SEEKING_ROOM', 0, 'Chennai', 98, 'Eswar', 1),
(19, 24, NULL, 'Chennai', 21, 0, NULL, '2026-03-28 07:49:39', 'Male', NULL, 'student', '', '', 'SEEKING_ROOM', 0, NULL, 98, 'Chaitanya', 1),
(20, 25, 'hi', 'chennai', 18, 0, '10000', '2026-03-31 04:52:34', 'Female', NULL, 'software Engineer', '', '', 'SEEKING_ROOM', 0, 'ongole', 98, 'divya', 1);

-- --------------------------------------------------------

--
-- Table structure for table `api_usersearchhistory`
--

CREATE TABLE `api_usersearchhistory` (
  `id` bigint(20) NOT NULL,
  `query` varchar(255) NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `budget` decimal(10,2) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_usersearchhistory`
--

INSERT INTO `api_usersearchhistory` (`id`, `query`, `city`, `budget`, `created_at`, `user_id`) VALUES
(1, 'Find roommates in Chennai', 'chennai', NULL, '2026-03-24 21:32:36.357975', 9),
(2, 'Rooms near Anna Nagar', 'anna nagar', NULL, '2026-03-24 21:58:49.365418', 9),
(3, 'PG near SRM University', 'anna nagar', NULL, '2026-03-24 21:59:20.214512', 9),
(4, 'rooms in ongole', 'ongole', NULL, '2026-03-24 22:00:07.922828', 9),
(5, 'rooms in chennai', 'chennai', NULL, '2026-03-24 22:00:27.746673', 9),
(6, 'Hotels in Chennai under ₹2000', 'chennai', NULL, '2026-03-24 22:00:52.547609', 9),
(7, 'rooms in Ongole', 'ongole', NULL, '2026-03-24 22:02:07.953246', 9),
(8, 'hotels near ongole', 'ongole', NULL, '2026-03-24 22:02:33.480662', 9),
(9, 'roomates', 'roomates', NULL, '2026-03-24 22:02:56.757981', 9),
(10, 'roomates in Ongole', 'ongole', NULL, '2026-03-24 22:03:26.040754', 9),
(11, 'Find roommates in Chennai', 'chennai', NULL, '2026-03-25 04:34:03.768814', 9),
(12, 'hotels in chirala', 'chirala', NULL, '2026-03-25 04:40:32.808042', 9),
(13, 'PG near SRM University', 'near ramanujah', 10000.00, '2026-03-25 04:43:14.312861', 9),
(14, 'PG near SRM University', 'near srm university', NULL, '2026-03-25 04:43:34.822722', 9),
(15, 'Find roommates in Chennai', 'chennai', NULL, '2026-03-25 05:33:31.584463', 9),
(16, 'hotels in chennai', 'chennai', NULL, '2026-03-25 05:34:45.163679', 9),
(17, 'Rooms near Anna Nagar', 'anna nagar', NULL, '2026-03-25 16:13:34.417541', 11),
(18, 'Hotels in Chennai under ₹2000', 'chennai', 2000.00, '2026-03-25 16:14:34.756373', 11),
(19, 'Hotels in Chennai under ₹2000', 'chennai', NULL, '2026-03-25 18:01:35.013293', 11),
(20, 'hotels in chennai', 'chennai', NULL, '2026-03-25 18:01:58.625883', 11),
(21, 'Hotels in Chennai under ₹2000', 'chennai', 2000.00, '2026-03-26 18:08:15.769975', 11),
(22, 'rooms in ongole', 'ongole', NULL, '2026-03-26 21:35:51.605475', 11),
(23, 'hotels in ongole', 'ongole', NULL, '2026-03-26 21:36:18.687605', 11),
(24, 'Hotels in Chennai under ₹2000', 'chennai', NULL, '2026-03-27 05:08:01.124295', 9),
(25, 'Rooms near Anna Nagar', 'anna nagar', NULL, '2026-03-27 17:43:10.748104', 9),
(26, 'romms in anna nagar, chennai', 'anna nagar', NULL, '2026-03-27 17:43:41.638222', 9),
(27, 'Find roommates in Chennai', 'chennai', NULL, '2026-03-27 18:13:06.156114', 9),
(28, 'Hotels in Chennai under ₹2000', 'chennai', NULL, '2026-03-28 05:02:21.694824', 9),
(29, 'Hotels in Chennai under ₹2000', 'chennai', 2000.00, '2026-03-31 04:56:45.729876', 9),
(30, 'hotels in anna nagar', 'anna nagar', NULL, '2026-03-31 04:57:18.434076', 9),
(31, 'rooms in ongole', 'ongole', NULL, '2026-03-31 04:57:47.511183', 9),
(32, 'hotels in ongole', 'ongole', NULL, '2026-03-31 04:58:11.674666', 9);

-- --------------------------------------------------------

--
-- Table structure for table `authtoken_token`
--

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `authtoken_token`
--

INSERT INTO `authtoken_token` (`key`, `created`, `user_id`) VALUES
('5b6074f79b94fdbefc32b1ff94006b6988217c93', '2026-03-28 08:30:58', 23),
('6fd58cf9164662a3c558f464a4d1eea4ac1994dd', '2026-03-24 20:16:27', 12),
('b4ddc767507fa1e830839aab3a737e9ea06e0bb4', '2026-03-24 03:38:42', 9),
('b64b1d8ab9518096ea22c5fa6a4440b301dfa466', '2026-03-26 23:00:44', 16),
('dd462277c8da6e73fd0af703556282b030c727cc', '2026-03-26 22:16:08', 14);

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES
(1, 1, 'add_logentry', 'Can add log entry'),
(2, 1, 'change_logentry', 'Can change log entry'),
(3, 1, 'delete_logentry', 'Can delete log entry'),
(4, 1, 'view_logentry', 'Can view log entry'),
(5, 2, 'add_permission', 'Can add permission'),
(6, 2, 'change_permission', 'Can change permission'),
(7, 2, 'delete_permission', 'Can delete permission'),
(8, 2, 'view_permission', 'Can view permission'),
(9, 3, 'add_group', 'Can add group'),
(10, 3, 'change_group', 'Can change group'),
(11, 3, 'delete_group', 'Can delete group'),
(12, 3, 'view_group', 'Can view group'),
(13, 4, 'add_contenttype', 'Can add content type'),
(14, 4, 'change_contenttype', 'Can change content type'),
(15, 4, 'delete_contenttype', 'Can delete content type'),
(16, 4, 'view_contenttype', 'Can view content type'),
(17, 5, 'add_session', 'Can add session'),
(18, 5, 'change_session', 'Can change session'),
(19, 5, 'delete_session', 'Can delete session'),
(20, 5, 'view_session', 'Can view session'),
(21, 6, 'add_customuser', 'Can add user'),
(22, 6, 'change_customuser', 'Can change user'),
(23, 6, 'delete_customuser', 'Can delete user'),
(24, 6, 'view_customuser', 'Can view user'),
(25, 7, 'add_otp', 'Can add otp'),
(26, 7, 'change_otp', 'Can change otp'),
(27, 7, 'delete_otp', 'Can delete otp'),
(28, 7, 'view_otp', 'Can view otp'),
(29, 8, 'add_passwordresetotp', 'Can add password reset otp'),
(30, 8, 'change_passwordresetotp', 'Can change password reset otp'),
(31, 8, 'delete_passwordresetotp', 'Can delete password reset otp'),
(32, 8, 'view_passwordresetotp', 'Can view password reset otp'),
(33, 9, 'add_token', 'Can add Token'),
(34, 9, 'change_token', 'Can change Token'),
(35, 9, 'delete_token', 'Can delete Token'),
(36, 9, 'view_token', 'Can view Token'),
(37, 10, 'add_tokenproxy', 'Can add Token'),
(38, 10, 'change_tokenproxy', 'Can change Token'),
(39, 10, 'delete_tokenproxy', 'Can delete Token'),
(40, 10, 'view_tokenproxy', 'Can view Token'),
(41, 29, 'add_userlifestyle', 'Can add user lifestyle'),
(42, 29, 'change_userlifestyle', 'Can change user lifestyle'),
(43, 29, 'delete_userlifestyle', 'Can delete user lifestyle'),
(44, 29, 'view_userlifestyle', 'Can view user lifestyle'),
(45, 28, 'add_userbudgetlocation', 'Can add user budget location'),
(46, 28, 'change_userbudgetlocation', 'Can change user budget location'),
(47, 28, 'delete_userbudgetlocation', 'Can delete user budget location'),
(48, 28, 'view_userbudgetlocation', 'Can view user budget location'),
(49, 21, 'add_matchresult', 'Can add match result'),
(50, 21, 'change_matchresult', 'Can change match result'),
(51, 21, 'delete_matchresult', 'Can delete match result'),
(52, 21, 'view_matchresult', 'Can view match result'),
(53, 30, 'add_userprofile', 'Can add user profile'),
(54, 30, 'change_userprofile', 'Can change user profile'),
(55, 30, 'delete_userprofile', 'Can delete user profile'),
(56, 30, 'view_userprofile', 'Can view user profile'),
(57, 15, 'add_favoritematch', 'Can add favorite match'),
(58, 15, 'change_favoritematch', 'Can change favorite match'),
(59, 15, 'delete_favoritematch', 'Can delete favorite match'),
(60, 15, 'view_favoritematch', 'Can view favorite match'),
(61, 16, 'add_groupchat', 'Can add group chat'),
(62, 16, 'change_groupchat', 'Can change group chat'),
(63, 16, 'delete_groupchat', 'Can delete group chat'),
(64, 16, 'view_groupchat', 'Can view group chat'),
(65, 18, 'add_groupchatmessage', 'Can add group chat message'),
(66, 18, 'change_groupchatmessage', 'Can change group chat message'),
(67, 18, 'delete_groupchatmessage', 'Can delete group chat message'),
(68, 18, 'view_groupchatmessage', 'Can view group chat message'),
(69, 17, 'add_groupchatmember', 'Can add group chat member'),
(70, 17, 'change_groupchatmember', 'Can change group chat member'),
(71, 17, 'delete_groupchatmember', 'Can delete group chat member'),
(72, 17, 'view_groupchatmember', 'Can view group chat member'),
(73, 26, 'add_roomtourschedule', 'Can add room tour schedule'),
(74, 26, 'change_roomtourschedule', 'Can change room tour schedule'),
(75, 26, 'delete_roomtourschedule', 'Can delete room tour schedule'),
(76, 26, 'view_roomtourschedule', 'Can view room tour schedule'),
(77, 24, 'add_roombooking', 'Can add room booking'),
(78, 24, 'change_roombooking', 'Can change room booking'),
(79, 24, 'delete_roombooking', 'Can delete room booking'),
(80, 24, 'view_roombooking', 'Can view room booking'),
(81, 13, 'add_directchat', 'Can add direct chat'),
(82, 13, 'change_directchat', 'Can change direct chat'),
(83, 13, 'delete_directchat', 'Can delete direct chat'),
(84, 13, 'view_directchat', 'Can view direct chat'),
(85, 14, 'add_directchatmessage', 'Can add direct chat message'),
(86, 14, 'change_directchatmessage', 'Can change direct chat message'),
(87, 14, 'delete_directchatmessage', 'Can delete direct chat message'),
(88, 14, 'view_directchatmessage', 'Can view direct chat message'),
(89, 19, 'add_listedroom', 'Can add listed room'),
(90, 19, 'change_listedroom', 'Can change listed room'),
(91, 19, 'delete_listedroom', 'Can delete listed room'),
(92, 19, 'view_listedroom', 'Can view listed room'),
(93, 27, 'add_useraccountsettings', 'Can add user account settings'),
(94, 27, 'change_useraccountsettings', 'Can change user account settings'),
(95, 27, 'delete_useraccountsettings', 'Can delete user account settings'),
(96, 27, 'view_useraccountsettings', 'Can view user account settings'),
(97, 20, 'add_listedroomphoto', 'Can add listed room photo'),
(98, 20, 'change_listedroomphoto', 'Can change listed room photo'),
(99, 20, 'delete_listedroomphoto', 'Can delete listed room photo'),
(100, 20, 'view_listedroomphoto', 'Can view listed room photo'),
(101, 11, 'add_appnotification', 'Can add app notification'),
(102, 11, 'change_appnotification', 'Can change app notification'),
(103, 11, 'delete_appnotification', 'Can delete app notification'),
(104, 11, 'view_appnotification', 'Can view app notification'),
(105, 25, 'add_roomsharerequest', 'Can add room share request'),
(106, 25, 'change_roomsharerequest', 'Can change room share request'),
(107, 25, 'delete_roomsharerequest', 'Can delete room share request'),
(108, 25, 'view_roomsharerequest', 'Can view room share request'),
(109, 22, 'add_notification', 'Can add notification'),
(110, 22, 'change_notification', 'Can change notification'),
(111, 22, 'delete_notification', 'Can delete notification'),
(112, 22, 'view_notification', 'Can view notification'),
(113, 12, 'add_bookinghistory', 'Can add booking history'),
(114, 12, 'change_bookinghistory', 'Can change booking history'),
(115, 12, 'delete_bookinghistory', 'Can delete booking history'),
(116, 12, 'view_bookinghistory', 'Can view booking history'),
(117, 23, 'add_room', 'Can add room'),
(118, 23, 'change_room', 'Can change room'),
(119, 23, 'delete_room', 'Can delete room'),
(120, 23, 'view_room', 'Can view room'),
(121, 31, 'add_hotelresult', 'Can add hotel result'),
(122, 31, 'change_hotelresult', 'Can change hotel result'),
(123, 31, 'delete_hotelresult', 'Can delete hotel result'),
(124, 31, 'view_hotelresult', 'Can view hotel result'),
(125, 33, 'add_hotel', 'Can add hotel'),
(126, 33, 'change_hotel', 'Can change hotel'),
(127, 33, 'delete_hotel', 'Can delete hotel'),
(128, 33, 'view_hotel', 'Can view hotel'),
(129, 32, 'add_chatmessage', 'Can add chat message'),
(130, 32, 'change_chatmessage', 'Can change chat message'),
(131, 32, 'delete_chatmessage', 'Can delete chat message'),
(132, 32, 'view_chatmessage', 'Can view chat message'),
(133, 34, 'add_hotelroom', 'Can add hotel room'),
(134, 34, 'change_hotelroom', 'Can change hotel room'),
(135, 34, 'delete_hotelroom', 'Can delete hotel room'),
(136, 34, 'view_hotelroom', 'Can view hotel room'),
(137, 35, 'add_hotelroombooking', 'Can add hotel room booking'),
(138, 35, 'change_hotelroombooking', 'Can change hotel room booking'),
(139, 35, 'delete_hotelroombooking', 'Can delete hotel room booking'),
(140, 35, 'view_hotelroombooking', 'Can view hotel room booking'),
(141, 36, 'add_usersearchhistory', 'Can add user search history'),
(142, 36, 'change_usersearchhistory', 'Can change user search history'),
(143, 36, 'delete_usersearchhistory', 'Can delete user search history'),
(144, 36, 'view_usersearchhistory', 'Can view user search history'),
(145, 37, 'add_favoritehotel', 'Can add favorite hotel'),
(146, 37, 'change_favoritehotel', 'Can change favorite hotel'),
(147, 37, 'delete_favoritehotel', 'Can delete favorite hotel'),
(148, 37, 'view_favoritehotel', 'Can view favorite hotel'),
(149, 38, 'add_favoriteroom', 'Can add favorite room'),
(150, 38, 'change_favoriteroom', 'Can change favorite room'),
(151, 38, 'delete_favoriteroom', 'Can delete favorite room'),
(152, 38, 'view_favoriteroom', 'Can view favorite room');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `object_id` text DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` text NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `action_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(11, 'api', 'appnotification'),
(12, 'api', 'bookinghistory'),
(32, 'api', 'chatmessage'),
(6, 'api', 'customuser'),
(13, 'api', 'directchat'),
(14, 'api', 'directchatmessage'),
(37, 'api', 'favoritehotel'),
(15, 'api', 'favoritematch'),
(38, 'api', 'favoriteroom'),
(16, 'api', 'groupchat'),
(17, 'api', 'groupchatmember'),
(18, 'api', 'groupchatmessage'),
(33, 'api', 'hotel'),
(31, 'api', 'hotelresult'),
(34, 'api', 'hotelroom'),
(35, 'api', 'hotelroombooking'),
(19, 'api', 'listedroom'),
(20, 'api', 'listedroomphoto'),
(21, 'api', 'matchresult'),
(22, 'api', 'notification'),
(7, 'api', 'otp'),
(8, 'api', 'passwordresetotp'),
(23, 'api', 'room'),
(24, 'api', 'roombooking'),
(25, 'api', 'roomsharerequest'),
(26, 'api', 'roomtourschedule'),
(27, 'api', 'useraccountsettings'),
(28, 'api', 'userbudgetlocation'),
(29, 'api', 'userlifestyle'),
(30, 'api', 'userprofile'),
(36, 'api', 'usersearchhistory'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(9, 'authtoken', 'token'),
(10, 'authtoken', 'tokenproxy'),
(4, 'contenttypes', 'contenttype'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-03-02 04:42:46'),
(2, 'contenttypes', '0002_remove_content_type_name', '2026-03-02 04:42:47'),
(3, 'auth', '0001_initial', '2026-03-02 04:42:47'),
(4, 'auth', '0002_alter_permission_name_max_length', '2026-03-02 04:42:47'),
(5, 'auth', '0003_alter_user_email_max_length', '2026-03-02 04:42:47'),
(6, 'auth', '0004_alter_user_username_opts', '2026-03-02 04:42:47'),
(7, 'auth', '0005_alter_user_last_login_null', '2026-03-02 04:42:47'),
(8, 'auth', '0006_require_contenttypes_0002', '2026-03-02 04:42:47'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2026-03-02 04:42:47'),
(10, 'auth', '0008_alter_user_username_max_length', '2026-03-02 04:42:47'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2026-03-02 04:42:47'),
(12, 'auth', '0010_alter_group_name_max_length', '2026-03-02 04:42:47'),
(13, 'auth', '0011_update_proxy_permissions', '2026-03-02 04:42:47'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2026-03-02 04:42:47'),
(15, 'api', '0001_initial', '2026-03-02 04:42:47'),
(16, 'admin', '0001_initial', '2026-03-02 04:42:47'),
(17, 'admin', '0002_logentry_remove_auto_add', '2026-03-02 04:42:47'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2026-03-02 04:42:47'),
(19, 'sessions', '0001_initial', '2026-03-02 04:42:47'),
(20, 'api', '0002_alter_customuser_options_alter_customuser_managers_and_more', '2026-03-02 07:28:49'),
(21, 'api', '0003_passwordresetotp', '2026-03-02 08:41:38'),
(22, 'api', '0004_userlifestyle', '2026-03-22 19:07:25'),
(23, 'api', '0005_alter_userlifestyle_cleanliness', '2026-03-22 19:07:25'),
(24, 'api', '0006_userbudgetlocation', '2026-03-22 19:07:25'),
(25, 'api', '0007_matchresult', '2026-03-22 19:07:25'),
(26, 'api', '0008_remove_userlifestyle_created_at_and_more', '2026-03-22 19:07:25'),
(27, 'api', '0009_alter_matchresult_matched_user_and_more', '2026-03-22 19:07:25'),
(28, 'api', '0010_userprofile', '2026-03-22 19:07:25'),
(29, 'api', '0011_favoritematch', '2026-03-22 19:07:26'),
(30, 'api', '0012_groupchat_groupchatmessage_groupchatmember', '2026-03-22 19:07:26'),
(31, 'api', '0013_groupchatmessage_image_groupchatmessage_image_source_and_more', '2026-03-22 19:07:26'),
(32, 'api', '0014_roomtourschedule_roombooking', '2026-03-22 19:07:26'),
(33, 'api', '0015_directchat_directchatmessage', '2026-03-22 19:07:26'),
(34, 'api', '0016_listedroom_userprofile_about_me_and_more', '2026-03-22 19:07:26'),
(35, 'api', '0017_customuser_address_customuser_age_and_more', '2026-03-22 19:07:26'),
(36, 'api', '0018_rename_uploaded_at_listedroomphoto_created_at_and_more', '2026-03-22 19:07:28'),
(37, 'api', '0019_roomsharerequest', '2026-03-22 19:07:28'),
(38, 'api', '0020_roomsharerequest_ai_background_check_completed_and_more', '2026-03-22 19:07:28'),
(39, 'api', '0021_rename_photo_userprofile_profile_photo_and_more', '2026-03-22 19:07:29'),
(40, 'api', '0022_userprofile_address_userprofile_gender_and_more', '2026-03-22 19:07:29'),
(41, 'api', '0023_room_remove_userprofile_about_me_and_more', '2026-03-22 19:07:30'),
(42, 'api', '0024_remove_userprofile_profile_pic_userprofile_about_me_and_more', '2026-03-22 19:07:31'),
(43, 'api', '0025_alter_matchresult_ai_explanation_and_more', '2026-03-22 19:07:31'),
(44, 'authtoken', '0001_initial', '2026-03-22 19:07:31'),
(45, 'authtoken', '0002_auto_20160226_1747', '2026-03-22 19:07:31'),
(46, 'authtoken', '0003_tokenproxy', '2026-03-22 19:07:31'),
(47, 'authtoken', '0004_alter_tokenproxy_options', '2026-03-22 19:07:31'),
(48, 'api', '0026_hotelresult', '2026-03-23 18:45:08'),
(51, 'api', '0028_listedroom_available_from_listedroom_tags', '2026-03-24 20:26:34'),
(52, 'api', '0029_favoritehotel', '2026-03-24 21:58:35'),
(53, 'api', '0027_hotel_chatmessage_hotelroom_hotelroombooking_and_more', '2026-03-25 23:04:02'),
(54, 'api', '0030_bookinghistory_created_at_bookinghistory_is_hotel_and_more', '2026-03-25 17:37:28'),
(55, 'api', '0031_appnotification_related_id', '2026-03-26 17:59:13'),
(56, 'api', '0032_alter_appnotification_notification_type', '2026-03-26 18:02:38'),
(57, 'api', '0033_userprofile_is_premium', '2026-03-27 16:38:30'),
(58, 'api', '0034_directchatmessage_image_and_more', '2026-03-28 04:56:14'),
(59, 'api', '0035_remove_groupchatmessage_chat_remove_roombooking_chat_and_more', '2026-03-28 08:03:31');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` text NOT NULL,
  `expire_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('5rltnhodqctw6rqvs9ls5atuembnsdya', '.eJxVjEEOwiAQRe_C2hBmoFBcuvcMZIBRqgaS0q6Md7dNutDte-__twi0LiWsnecwZXEWRpx-WaT05LqL_KB6bzK1usxTlHsiD9vltWV-XY7276BQL9t6MAgKHRBb58HYZIxCIDXmhIw37RxaB-NgUwQfSbMn9opBe96IseLzBalANtc:1vxFzN:kxat7p34DqJ4-ydLtl4uGdBBum7LBlyG_67EOSU5fuE', '2026-03-17 03:00:01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `api_appnotification`
--
ALTER TABLE `api_appnotification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_bookinghistory`
--
ALTER TABLE `api_bookinghistory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_chatmessage`
--
ALTER TABLE `api_chatmessage`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_customuser`
--
ALTER TABLE `api_customuser`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `api_customuser_groups`
--
ALTER TABLE `api_customuser_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `api_customuser_groups_customuser_id_group_id_d5b0c2ab_uniq` (`customuser_id`,`group_id`),
  ADD KEY `api_customuser_groups_customuser_id_9eb4b783` (`customuser_id`),
  ADD KEY `api_customuser_groups_group_id_f049027c` (`group_id`);

--
-- Indexes for table `api_customuser_user_permissions`
--
ALTER TABLE `api_customuser_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `api_customuser_user_permissions_customuser_id_5365c9ba` (`customuser_id`);

--
-- Indexes for table `api_directchat`
--
ALTER TABLE `api_directchat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_directchatmessage`
--
ALTER TABLE `api_directchatmessage`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_favoritehotel`
--
ALTER TABLE `api_favoritehotel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `api_favoritehotel_user_id_hotel_id_bcf0d252_uniq` (`user_id`,`hotel_id`),
  ADD KEY `api_favoritehotel_hotel_id_bd5ff719_fk_api_hotel_id` (`hotel_id`);

--
-- Indexes for table `api_favoritematch`
--
ALTER TABLE `api_favoritematch`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_favoriteroom`
--
ALTER TABLE `api_favoriteroom`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `api_favoriteroom_user_id_room_id_351e9d15_uniq` (`user_id`,`room_id`);

--
-- Indexes for table `api_hotel`
--
ALTER TABLE `api_hotel`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_hotelresult`
--
ALTER TABLE `api_hotelresult`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_hotelroom`
--
ALTER TABLE `api_hotelroom`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_hotelroombooking`
--
ALTER TABLE `api_hotelroombooking`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `booking_reference` (`booking_reference`);

--
-- Indexes for table `api_listedroom`
--
ALTER TABLE `api_listedroom`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_listedroomphoto`
--
ALTER TABLE `api_listedroomphoto`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_matchresult`
--
ALTER TABLE `api_matchresult`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_notification`
--
ALTER TABLE `api_notification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_otp`
--
ALTER TABLE `api_otp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_passwordresetotp`
--
ALTER TABLE `api_passwordresetotp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_room`
--
ALTER TABLE `api_room`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_roomsharerequest`
--
ALTER TABLE `api_roomsharerequest`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_useraccountsettings`
--
ALTER TABLE `api_useraccountsettings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `api_userbudgetlocation`
--
ALTER TABLE `api_userbudgetlocation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `api_userlifestyle`
--
ALTER TABLE `api_userlifestyle`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `api_userprofile`
--
ALTER TABLE `api_userprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `api_usersearchhistory`
--
ALTER TABLE `api_usersearchhistory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD PRIMARY KEY (`key`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  ADD KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  ADD KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `api_appnotification`
--
ALTER TABLE `api_appnotification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `api_bookinghistory`
--
ALTER TABLE `api_bookinghistory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `api_chatmessage`
--
ALTER TABLE `api_chatmessage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=154;

--
-- AUTO_INCREMENT for table `api_customuser`
--
ALTER TABLE `api_customuser`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `api_customuser_groups`
--
ALTER TABLE `api_customuser_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `api_customuser_user_permissions`
--
ALTER TABLE `api_customuser_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `api_directchat`
--
ALTER TABLE `api_directchat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `api_directchatmessage`
--
ALTER TABLE `api_directchatmessage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `api_favoritehotel`
--
ALTER TABLE `api_favoritehotel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `api_favoritematch`
--
ALTER TABLE `api_favoritematch`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `api_favoriteroom`
--
ALTER TABLE `api_favoriteroom`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `api_hotel`
--
ALTER TABLE `api_hotel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `api_hotelresult`
--
ALTER TABLE `api_hotelresult`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `api_hotelroom`
--
ALTER TABLE `api_hotelroom`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `api_hotelroombooking`
--
ALTER TABLE `api_hotelroombooking`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `api_listedroom`
--
ALTER TABLE `api_listedroom`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `api_listedroomphoto`
--
ALTER TABLE `api_listedroomphoto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `api_matchresult`
--
ALTER TABLE `api_matchresult`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=461;

--
-- AUTO_INCREMENT for table `api_notification`
--
ALTER TABLE `api_notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `api_otp`
--
ALTER TABLE `api_otp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `api_passwordresetotp`
--
ALTER TABLE `api_passwordresetotp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `api_room`
--
ALTER TABLE `api_room`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `api_roomsharerequest`
--
ALTER TABLE `api_roomsharerequest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `api_useraccountsettings`
--
ALTER TABLE `api_useraccountsettings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `api_userbudgetlocation`
--
ALTER TABLE `api_userbudgetlocation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `api_userlifestyle`
--
ALTER TABLE `api_userlifestyle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `api_userprofile`
--
ALTER TABLE `api_userprofile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `api_usersearchhistory`
--
ALTER TABLE `api_usersearchhistory`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `api_favoritehotel`
--
ALTER TABLE `api_favoritehotel`
  ADD CONSTRAINT `api_favoritehotel_hotel_id_bd5ff719_fk_api_hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `api_hotel` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
