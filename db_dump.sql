-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Gép: db:3306
-- Létrehozás ideje: 2026. Ápr 28. 18:37
-- Kiszolgáló verziója: 9.3.0
-- PHP verzió: 8.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `booklet`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `authors`
--

CREATE TABLE `authors` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `biography_en` text COLLATE utf8mb4_unicode_ci,
  `biography_hu` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `authors`
--

INSERT INTO `authors` (`id`, `name`, `biography_en`, `biography_hu`, `created_at`, `updated_at`, `deleted_at`) VALUES
('019dd53d-af0e-7166-861b-01b795bf83ff', 'J.R.R. Tolkien', NULL, NULL, '2026-04-28 15:58:02', '2026-04-28 15:58:02', NULL),
('019dd53d-af24-735a-a70c-21ae30eb7b2d', 'Frank Herbert', NULL, NULL, '2026-04-28 15:58:02', '2026-04-28 15:58:02', NULL),
('019dd53d-af38-7275-9ac4-c25c58932203', 'George Orwell', NULL, NULL, '2026-04-28 15:58:02', '2026-04-28 15:58:02', NULL),
('019dd53d-af46-7140-afae-a5f92e4884eb', 'Aldous Huxley', NULL, NULL, '2026-04-28 15:58:02', '2026-04-28 15:58:02', NULL),
('019dd53d-af4e-7375-8874-a93a2d33a2d4', 'Ray Bradbury', NULL, NULL, '2026-04-28 15:58:02', '2026-04-28 15:58:02', NULL),
('019dd53d-af56-71a9-aff8-e2aec60901aa', 'Patrick Rothfuss', NULL, NULL, '2026-04-28 15:58:02', '2026-04-28 15:58:02', NULL),
('019dd53d-af5c-7096-a659-eb4e28b0a4fd', 'Douglas Adams', NULL, NULL, '2026-04-28 15:58:02', '2026-04-28 15:58:02', NULL),
('019dd53d-af60-70b5-b609-dacb4b788a82', 'Orson Scott Card', NULL, NULL, '2026-04-28 15:58:02', '2026-04-28 15:58:02', NULL),
('019dd53d-af69-70f0-9ae3-6947ca75dd9c', 'Andy Weir', NULL, NULL, '2026-04-28 15:58:02', '2026-04-28 15:58:02', NULL),
('019dd53d-af6e-7391-9b02-6b2b1ddc9b13', 'Neal Stephenson', NULL, NULL, '2026-04-28 15:58:02', '2026-04-28 15:58:02', NULL),
('019dd53d-af72-71f2-8c7c-889a81713352', 'William Gibson', NULL, NULL, '2026-04-28 15:58:02', '2026-04-28 15:58:02', NULL),
('019dd53d-af76-7304-8521-018f33aecc2a', 'Ursula K. Le Guin', NULL, NULL, '2026-04-28 15:58:02', '2026-04-28 15:58:02', NULL),
('019dd53d-af7c-738e-878f-bdfb1af90c60', 'Dan Simmons', NULL, NULL, '2026-04-28 15:58:02', '2026-04-28 15:58:02', NULL),
('019dd53d-af81-7319-89bc-57501c2827d1', 'Isaac Asimov', NULL, NULL, '2026-04-28 15:58:02', '2026-04-28 15:58:02', NULL),
('019dd53d-af8b-739b-a059-05f2f14d525e', 'Brandon Sanderson', NULL, NULL, '2026-04-28 15:58:02', '2026-04-28 15:58:02', NULL),
('019dd53d-afb4-71fb-bed7-a3f2422b0bf1', 'George R.R. Martin', NULL, NULL, '2026-04-28 15:58:02', '2026-04-28 15:58:02', NULL),
('019dd53d-afda-71ce-a5f3-6635f98ef79a', 'Ernest Cline', NULL, NULL, '2026-04-28 15:58:02', '2026-04-28 15:58:02', NULL),
('019dd53d-b007-737e-a2cd-7ebe47fc9c19', 'Philip K. Dick', NULL, NULL, '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b01d-732c-8f73-f60767456c20', 'Arthur C. Clarke', NULL, NULL, '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b03a-706f-a3f4-ce03dbb86fb6', 'H.G. Wells', NULL, NULL, '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b04d-73b2-b021-271aafc5105f', 'Larry Niven', NULL, NULL, '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b062-719c-8ac7-15f3e774f51b', 'Jerry Pournelle', NULL, NULL, '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b077-7183-bd83-31849e13e57d', 'Gregory Benford', NULL, NULL, '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `author_book`
--

CREATE TABLE `author_book` (
  `author_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `book_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `author_book`
--

INSERT INTO `author_book` (`author_id`, `book_id`) VALUES
('019dd53d-af0e-7166-861b-01b795bf83ff', '019dd53d-c10f-703b-915d-6ff3b0349a0b'),
('019dd53d-b03a-706f-a3f4-ce03dbb86fb6', '019dd53d-c10f-703b-915d-6ff3b0349a0b'),
('019dd53d-af24-735a-a70c-21ae30eb7b2d', '019dd53d-c131-7079-b049-4b91ba4bd4c4'),
('019dd53d-af38-7275-9ac4-c25c58932203', '019dd53d-c149-7367-a3ff-24715f7f3a94'),
('019dd53d-af46-7140-afae-a5f92e4884eb', '019dd53d-c15f-711c-8600-6a3626a1628f'),
('019dd53d-af4e-7375-8874-a93a2d33a2d4', '019dd53d-c189-7204-b3b0-d46ebfdab90f'),
('019dd53d-af56-71a9-aff8-e2aec60901aa', '019dd53d-c19c-73b9-a3a3-1a603b186013'),
('019dd53d-af5c-7096-a659-eb4e28b0a4fd', '019dd53d-c1be-718f-b29e-71f3cb8e1550'),
('019dd53d-af60-70b5-b609-dacb4b788a82', '019dd53d-c1d9-705f-bf53-34568add8086'),
('019dd53d-af69-70f0-9ae3-6947ca75dd9c', '019dd53d-c1fa-73b0-8c60-dd1a4814e383'),
('019dd53d-af69-70f0-9ae3-6947ca75dd9c', '019dd53d-c218-70dd-99d4-c3bf27dfbf7a'),
('019dd53d-afda-71ce-a5f3-6635f98ef79a', '019dd53d-c230-73c2-b9ec-40d88f504308'),
('019dd53d-af6e-7391-9b02-6b2b1ddc9b13', '019dd53d-c248-71c3-aa37-50a0d85db859'),
('019dd53d-af72-71f2-8c7c-889a81713352', '019dd53d-c25e-713c-9c66-9ca19c76e481'),
('019dd53d-af76-7304-8521-018f33aecc2a', '019dd53d-c2aa-73bc-a016-9994eb133c8b'),
('019dd53d-af7c-738e-878f-bdfb1af90c60', '019dd53d-c2cc-71c8-aac0-b43135c44952'),
('019dd53d-af81-7319-89bc-57501c2827d1', '019dd53d-c2df-7029-85d3-54698f212432'),
('019dd53d-af8b-739b-a059-05f2f14d525e', '019dd53d-c2f7-7291-82b7-b1f38b02c5de'),
('019dd53d-af8b-739b-a059-05f2f14d525e', '019dd53d-c304-7178-976e-61880e8674e1'),
('019dd53d-afb4-71fb-bed7-a3f2422b0bf1', '019dd53d-c31c-73cf-84c2-ee5c9829e020'),
('019dd53d-b007-737e-a2cd-7ebe47fc9c19', '019dd53d-c334-730e-a0eb-e3a432aed96b'),
('019dd53d-b04d-73b2-b021-271aafc5105f', '019dd53d-c34b-7018-a046-143a3fd12a65'),
('019dd53d-b062-719c-8ac7-15f3e774f51b', '019dd53d-c34b-7018-a046-143a3fd12a65'),
('019dd53d-b04d-73b2-b021-271aafc5105f', '019dd53d-c35f-72e0-81f6-33729ace670c'),
('019dd53d-b062-719c-8ac7-15f3e774f51b', '019dd53d-c35f-72e0-81f6-33729ace670c'),
('019dd53d-b01d-732c-8f73-f60767456c20', '019dd53d-c371-72f6-812b-bd41b49f7e3c'),
('019dd53d-b077-7183-bd83-31849e13e57d', '019dd53d-c371-72f6-812b-bd41b49f7e3c');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `books`
--

CREATE TABLE `books` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `img_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL,
  `pages` int NOT NULL,
  `release_year` int NOT NULL,
  `stock` int NOT NULL,
  `publisher_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genre_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `books`
--

INSERT INTO `books` (`id`, `img_path`, `title`, `price`, `pages`, `release_year`, `stock`, `publisher_id`, `genre_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
('019dd53d-c10f-703b-915d-6ff3b0349a0b', NULL, 'A Hobbit', 3323, 310, 1937, 19, '019dd53d-b0ac-73e1-a51d-d9d7a89d08c5', '019dd53d-b1da-7100-a65b-f575f5fa96f2', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c131-7079-b049-4b91ba4bd4c4', NULL, 'Dűne', 5914, 688, 1965, 6, '019dd53d-b0cd-735c-bdcb-dab99654ffce', '019dd53d-b1ac-739d-9797-36e3cc290c4f', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c149-7367-a3ff-24715f7f3a94', NULL, '1984', 2793, 328, 1949, 21, '019dd53d-b0ac-73e1-a51d-d9d7a89d08c5', '019dd53d-b181-711f-8511-8bc985adb1bf', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c15f-711c-8600-6a3626a1628f', NULL, 'Szép új világ', 5430, 311, 1932, 38, '019dd53d-b10e-716e-898a-aada0a263b4a', '019dd53d-b181-711f-8511-8bc985adb1bf', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c189-7204-b3b0-d46ebfdab90f', NULL, '451 fok Fahrenheit', 5031, 256, 1953, 33, '019dd53d-b0ec-7389-b41e-45fc93093272', '019dd53d-b181-711f-8511-8bc985adb1bf', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c19c-73b9-a3a3-1a603b186013', NULL, 'A szél neve', 5509, 662, 2007, 2, '019dd53d-b0ac-73e1-a51d-d9d7a89d08c5', '019dd53d-b1da-7100-a65b-f575f5fa96f2', '2026-04-28 15:58:07', '2026-04-28 16:19:05', NULL),
('019dd53d-c1be-718f-b29e-71f3cb8e1550', NULL, 'Galaxis útikalauz stopposoknak', 2059, 224, 1979, 30, '019dd53d-b09b-70a8-b099-8f9bd3603b37', '019dd53d-b148-715b-92e8-c07cf4820ab8', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c1d9-705f-bf53-34568add8086', NULL, 'Ender játéka', 2014, 352, 1985, 31, '019dd53d-b08b-7020-ab2e-bc29f5235533', '019dd53d-b148-715b-92e8-c07cf4820ab8', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c1fa-73b0-8c60-dd1a4814e383', NULL, 'A marsi', 4269, 369, 2011, 13, '019dd53d-b09b-70a8-b099-8f9bd3603b37', '019dd53d-b148-715b-92e8-c07cf4820ab8', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c218-70dd-99d4-c3bf27dfbf7a', NULL, 'Projektem: Hail Mary', 4228, 476, 2021, 38, '019dd53d-b09b-70a8-b099-8f9bd3603b37', '019dd53d-b148-715b-92e8-c07cf4820ab8', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c230-73c2-b9ec-40d88f504308', NULL, 'Ready Player One', 4364, 374, 2011, 23, '019dd53d-b09b-70a8-b099-8f9bd3603b37', '019dd53d-b193-72cc-a108-21129eae62b2', '2026-04-28 15:58:07', '2026-04-28 16:18:37', NULL),
('019dd53d-c248-71c3-aa37-50a0d85db859', NULL, 'Hóomlás', 6198, 440, 1992, 31, '019dd53d-b0ec-7389-b41e-45fc93093272', '019dd53d-b193-72cc-a108-21129eae62b2', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c25e-713c-9c66-9ca19c76e481', NULL, 'Neurománc', 6277, 271, 1984, 1, '019dd53d-b0cd-735c-bdcb-dab99654ffce', '019dd53d-b193-72cc-a108-21129eae62b2', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c2aa-73bc-a016-9994eb133c8b', NULL, 'A sötétség bal keze', 5358, 286, 1969, 41, '019dd53d-b0cd-735c-bdcb-dab99654ffce', '019dd53d-b1ef-73a1-a6cd-52a83813d4c6', '2026-04-28 15:58:07', '2026-04-28 15:58:08', NULL),
('019dd53d-c2cc-71c8-aac0-b43135c44952', NULL, 'Hyperion', 5832, 482, 1989, 48, '019dd53d-b0ec-7389-b41e-45fc93093272', '019dd53d-b1ac-739d-9797-36e3cc290c4f', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c2df-7029-85d3-54698f212432', NULL, 'Alapítvány', 6985, 244, 1951, 1, '019dd53d-b0ec-7389-b41e-45fc93093272', '019dd53d-b148-715b-92e8-c07cf4820ab8', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c2f7-7291-82b7-b1f38b02c5de', NULL, 'A királyok útja', 6536, 1007, 2010, 24, '019dd53d-b08b-7020-ab2e-bc29f5235533', '019dd53d-b1da-7100-a65b-f575f5fa96f2', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c304-7178-976e-61880e8674e1', NULL, 'Acélinkvizíció', 2374, 541, 2006, 48, '019dd53d-b08b-7020-ab2e-bc29f5235533', '019dd53d-b1da-7100-a65b-f575f5fa96f2', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c31c-73cf-84c2-ee5c9829e020', NULL, 'A trónok harca', 3720, 694, 1996, 34, '019dd53d-b0ec-7389-b41e-45fc93093272', '019dd53d-b1da-7100-a65b-f575f5fa96f2', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c334-730e-a0eb-e3a432aed96b', NULL, 'Ubik', 6725, 224, 1969, 28, '019dd53d-b0ac-73e1-a51d-d9d7a89d08c5', '019dd53d-b148-715b-92e8-c07cf4820ab8', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c34b-7018-a046-143a3fd12a65', NULL, 'A jó öregek', 4288, 324, 1992, 28, '019dd53d-b08b-7020-ab2e-bc29f5235533', '019dd53d-b169-737e-b8db-ec68e98657a5', '2026-04-28 15:58:07', '2026-04-28 16:19:05', NULL),
('019dd53d-c35f-72e0-81f6-33729ace670c', NULL, 'Pokolcsillag', 4494, 544, 1974, 45, '019dd53d-b08b-7020-ab2e-bc29f5235533', '019dd53d-b148-715b-92e8-c07cf4820ab8', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL),
('019dd53d-c371-72f6-812b-bd41b49f7e3c', NULL, 'A jövő árnyéka', 2904, 413, 1999, 38, '019dd53d-b08b-7020-ab2e-bc29f5235533', '019dd53d-b148-715b-92e8-c07cf4820ab8', '2026-04-28 15:58:07', '2026-04-28 15:58:07', NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `books_receipts`
--

CREATE TABLE `books_receipts` (
  `receipt_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `book_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `price_at_purchase` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `books_receipts`
--

INSERT INTO `books_receipts` (`receipt_id`, `book_id`, `quantity`, `price_at_purchase`) VALUES
('019dd53d-ca95-7080-8fec-971d960ab406', '019dd53d-c149-7367-a3ff-24715f7f3a94', 3, 2793),
('019dd53d-ca95-7080-8fec-971d960ab406', '019dd53d-c230-73c2-b9ec-40d88f504308', 2, 4364),
('019dd53d-caa6-7386-bb00-3adc66dae979', '019dd53d-c19c-73b9-a3a3-1a603b186013', 3, 5509),
('019dd53d-caa6-7386-bb00-3adc66dae979', '019dd53d-c1fa-73b0-8c60-dd1a4814e383', 3, 4269),
('019dd53d-caa6-7386-bb00-3adc66dae979', '019dd53d-c230-73c2-b9ec-40d88f504308', 2, 4364),
('019dd53d-caa6-7386-bb00-3adc66dae979', '019dd53d-c2f7-7291-82b7-b1f38b02c5de', 3, 6536),
('019dd53d-caa6-7386-bb00-3adc66dae979', '019dd53d-c35f-72e0-81f6-33729ace670c', 2, 4494),
('019dd53d-cabe-70d3-a7c7-1eda2c3247b3', '019dd53d-c1be-718f-b29e-71f3cb8e1550', 1, 2059),
('019dd53d-cabe-70d3-a7c7-1eda2c3247b3', '019dd53d-c230-73c2-b9ec-40d88f504308', 3, 4364),
('019dd53d-cabe-70d3-a7c7-1eda2c3247b3', '019dd53d-c2aa-73bc-a016-9994eb133c8b', 1, 5358),
('019dd53d-cabe-70d3-a7c7-1eda2c3247b3', '019dd53d-c34b-7018-a046-143a3fd12a65', 3, 4288),
('019dd53d-cace-7211-94b9-cac1896f5ab2', '019dd53d-c19c-73b9-a3a3-1a603b186013', 3, 5509),
('019dd53d-cace-7211-94b9-cac1896f5ab2', '019dd53d-c2df-7029-85d3-54698f212432', 3, 6985),
('019dd53d-cace-7211-94b9-cac1896f5ab2', '019dd53d-c35f-72e0-81f6-33729ace670c', 2, 4494),
('019dd53d-cae9-721a-b44a-cfb6a7cd19c6', '019dd53d-c248-71c3-aa37-50a0d85db859', 3, 6198),
('019dd53d-cae9-721a-b44a-cfb6a7cd19c6', '019dd53d-c2f7-7291-82b7-b1f38b02c5de', 2, 6536),
('019dd53d-cae9-721a-b44a-cfb6a7cd19c6', '019dd53d-c34b-7018-a046-143a3fd12a65', 3, 4288),
('019dd53d-caff-724a-94d5-b292778f30c4', '019dd53d-c15f-711c-8600-6a3626a1628f', 2, 5430),
('019dd53d-caff-724a-94d5-b292778f30c4', '019dd53d-c1d9-705f-bf53-34568add8086', 1, 2014),
('019dd53d-cb12-7115-9d92-b888f208180a', '019dd53d-c10f-703b-915d-6ff3b0349a0b', 3, 3323),
('019dd53d-cb12-7115-9d92-b888f208180a', '019dd53d-c15f-711c-8600-6a3626a1628f', 3, 5430),
('019dd53d-cb12-7115-9d92-b888f208180a', '019dd53d-c189-7204-b3b0-d46ebfdab90f', 1, 5031),
('019dd53d-cb12-7115-9d92-b888f208180a', '019dd53d-c218-70dd-99d4-c3bf27dfbf7a', 3, 4228),
('019dd53d-cb12-7115-9d92-b888f208180a', '019dd53d-c2aa-73bc-a016-9994eb133c8b', 2, 5358),
('019dd53d-cb2a-737e-8f47-a83dfa781ec0', '019dd53d-c218-70dd-99d4-c3bf27dfbf7a', 3, 4228),
('019dd53d-cb42-733c-aac3-dfba899c0b27', '019dd53d-c248-71c3-aa37-50a0d85db859', 1, 6198),
('019dd53d-cb42-733c-aac3-dfba899c0b27', '019dd53d-c25e-713c-9c66-9ca19c76e481', 1, 6277),
('019dd53d-cb42-733c-aac3-dfba899c0b27', '019dd53d-c2f7-7291-82b7-b1f38b02c5de', 1, 6536),
('019dd53d-cb42-733c-aac3-dfba899c0b27', '019dd53d-c35f-72e0-81f6-33729ace670c', 3, 4494),
('019dd53d-cb62-7015-98c3-60ab4db93afb', '019dd53d-c1fa-73b0-8c60-dd1a4814e383', 1, 4269),
('019dd53d-cb62-7015-98c3-60ab4db93afb', '019dd53d-c2df-7029-85d3-54698f212432', 3, 6985),
('019dd53d-cb62-7015-98c3-60ab4db93afb', '019dd53d-c34b-7018-a046-143a3fd12a65', 3, 4288),
('019dd53d-cb78-70ca-a44d-117645e3baa3', '019dd53d-c1fa-73b0-8c60-dd1a4814e383', 2, 4269),
('019dd53d-cb78-70ca-a44d-117645e3baa3', '019dd53d-c230-73c2-b9ec-40d88f504308', 3, 4364),
('019dd53d-cb78-70ca-a44d-117645e3baa3', '019dd53d-c371-72f6-812b-bd41b49f7e3c', 2, 2904),
('019dd53d-cb8d-7324-ace7-a3b46e95bedf', '019dd53d-c1be-718f-b29e-71f3cb8e1550', 3, 2059),
('019dd53d-cb8d-7324-ace7-a3b46e95bedf', '019dd53d-c34b-7018-a046-143a3fd12a65', 2, 4288),
('019dd53d-cb9f-736c-8ed3-1e758555d218', '019dd53d-c19c-73b9-a3a3-1a603b186013', 3, 5509),
('019dd53d-cbae-70b6-b875-5a73691c097b', '019dd53d-c15f-711c-8600-6a3626a1628f', 3, 5430),
('019dd53d-cbae-70b6-b875-5a73691c097b', '019dd53d-c230-73c2-b9ec-40d88f504308', 2, 4364),
('019dd53d-cbae-70b6-b875-5a73691c097b', '019dd53d-c25e-713c-9c66-9ca19c76e481', 3, 6277),
('019dd53d-cbbd-726a-a8fc-5f92ebc4a0cb', '019dd53d-c149-7367-a3ff-24715f7f3a94', 2, 2793),
('019dd53d-cbbd-726a-a8fc-5f92ebc4a0cb', '019dd53d-c1be-718f-b29e-71f3cb8e1550', 2, 2059),
('019dd53d-cbbd-726a-a8fc-5f92ebc4a0cb', '019dd53d-c1fa-73b0-8c60-dd1a4814e383', 2, 4269),
('019dd53d-cbbd-726a-a8fc-5f92ebc4a0cb', '019dd53d-c304-7178-976e-61880e8674e1', 2, 2374),
('019dd53d-cbbd-726a-a8fc-5f92ebc4a0cb', '019dd53d-c371-72f6-812b-bd41b49f7e3c', 1, 2904),
('019dd54b-20db-7349-9efc-ae48274077c2', '019dd53d-c19c-73b9-a3a3-1a603b186013', 2, 5509),
('019dd54b-20db-7349-9efc-ae48274077c2', '019dd53d-c34b-7018-a046-143a3fd12a65', 5, 4288),
('019dd54b-d97a-70f3-a65e-9a9a2b02daa3', '019dd53d-c230-73c2-b9ec-40d88f504308', 3, 4364);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `coupons`
--

CREATE TABLE `coupons` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `book_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `genre_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount` int NOT NULL,
  `starts_at` datetime NOT NULL,
  `ends_at` datetime NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `coupons`
--

INSERT INTO `coupons` (`id`, `book_id`, `genre_id`, `user_id`, `discount`, `starts_at`, `ends_at`, `code`, `created_at`, `updated_at`, `deleted_at`) VALUES
('019dd53d-c8fd-73e5-9301-10327a13789e', NULL, '019dd53d-b148-715b-92e8-c07cf4820ab8', NULL, 6, '2026-03-31 11:22:03', '2027-01-28 19:11:40', NULL, '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-c939-7029-aa77-3faed7d263e8', '019dd53d-c10f-703b-915d-6ff3b0349a0b', NULL, NULL, 6, '2026-04-18 02:48:49', '2026-12-13 23:56:17', NULL, '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-c99a-71bc-a53c-5629e46e3721', NULL, '019dd53d-b181-711f-8511-8bc985adb1bf', NULL, 48, '2026-03-31 01:18:36', '2027-02-05 18:35:25', NULL, '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-c9aa-70e4-820d-57eb27b64a81', '019dd53d-c1be-718f-b29e-71f3cb8e1550', NULL, NULL, 32, '2026-03-31 03:20:10', '2026-07-01 13:05:30', NULL, '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-c9cb-7316-9783-b77d16305b1e', NULL, NULL, '019dd53d-b68e-7254-94cf-4ee742101a24', 10, '2026-04-28 17:58:09', '2026-04-28 18:12:43', 'COUPON10', '2026-04-28 15:58:09', '2026-04-28 16:12:43', NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `coupons_receipts`
--

CREATE TABLE `coupons_receipts` (
  `receipt_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coupon_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `coupons_receipts`
--

INSERT INTO `coupons_receipts` (`receipt_id`, `coupon_id`) VALUES
('019dd53d-cace-7211-94b9-cac1896f5ab2', '019dd53d-c8fd-73e5-9301-10327a13789e'),
('019dd53d-cb12-7115-9d92-b888f208180a', '019dd53d-c8fd-73e5-9301-10327a13789e'),
('019dd53d-cb42-733c-aac3-dfba899c0b27', '019dd53d-c8fd-73e5-9301-10327a13789e'),
('019dd53d-cb62-7015-98c3-60ab4db93afb', '019dd53d-c8fd-73e5-9301-10327a13789e'),
('019dd53d-cb78-70ca-a44d-117645e3baa3', '019dd53d-c8fd-73e5-9301-10327a13789e'),
('019dd53d-ca95-7080-8fec-971d960ab406', '019dd53d-c99a-71bc-a53c-5629e46e3721'),
('019dd53d-caff-724a-94d5-b292778f30c4', '019dd53d-c99a-71bc-a53c-5629e46e3721'),
('019dd53d-cbae-70b6-b875-5a73691c097b', '019dd53d-c99a-71bc-a53c-5629e46e3721'),
('019dd53d-cabe-70d3-a7c7-1eda2c3247b3', '019dd53d-c9aa-70e4-820d-57eb27b64a81'),
('019dd53d-cb8d-7324-ace7-a3b46e95bedf', '019dd53d-c9aa-70e4-820d-57eb27b64a81'),
('019dd53d-cbbd-726a-a8fc-5f92ebc4a0cb', '019dd53d-c9aa-70e4-820d-57eb27b64a81'),
('019dd53d-caa6-7386-bb00-3adc66dae979', '019dd53d-c9cb-7316-9783-b77d16305b1e'),
('019dd53d-cb2a-737e-8f47-a83dfa781ec0', '019dd53d-c9cb-7316-9783-b77d16305b1e'),
('019dd54b-20db-7349-9efc-ae48274077c2', '019dd53d-c9cb-7316-9783-b77d16305b1e');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `genres`
--

CREATE TABLE `genres` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_hu` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `genres`
--

INSERT INTO `genres` (`id`, `name_hu`, `name_en`, `created_at`, `updated_at`, `deleted_at`) VALUES
('019dd53d-b148-715b-92e8-c07cf4820ab8', 'Tudományos-fantasztikus', 'Science Fiction', '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b169-737e-b8db-ec68e98657a5', 'Fantasy', 'Fantasy', '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b181-711f-8511-8bc985adb1bf', 'Disztópia', 'Dystopian', '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b193-72cc-a108-21129eae62b2', 'Kiberpunk', 'Cyberpunk', '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b1ac-739d-9797-36e3cc290c4f', 'Űropera', 'Space Opera', '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b1da-7100-a65b-f575f5fa96f2', 'Epikus fantasy', 'Epic Fantasy', '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b1ef-73a1-a6cd-52a83813d4c6', 'Kaland', 'Adventure', '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_02_28_000942_create_personal_access_tokens_table', 1),
(5, '2026_03_23_000001_create_authors_table', 1),
(6, '2026_03_23_000002_create_publishers_table', 1),
(7, '2026_03_23_000003_create_genres_table', 1),
(8, '2026_03_23_000004_create_books_table', 1),
(9, '2026_03_23_000005_create_wishlists_table', 1),
(10, '2026_03_23_000006_create_receipts_table', 1),
(11, '2026_03_23_000007_create_coupons_table', 1),
(12, '2026_03_23_000008_create_pickups_table', 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', '019dd53d-b68e-7254-94cf-4ee742101a24', 'app', '876294d13ff4b15349db364b74a73ad3ac2c73d61f2d327b31529b8c0a3c613b', '[\"*\"]', '2026-04-28 16:02:59', NULL, '2026-04-28 15:59:19', '2026-04-28 16:02:59'),
(2, 'App\\Models\\User', '019dd53d-b68e-7254-94cf-4ee742101a24', 'app', '62703d815c000d917446b6b495823787118b2f1a6df7b0e16943be54434d863c', '[\"*\"]', '2026-04-28 16:19:44', NULL, '2026-04-28 16:03:19', '2026-04-28 16:19:44'),
(3, 'App\\Models\\User', '019dd53d-bf04-70c1-b4fb-2840cc53689e', 'app', 'bcbf0306b1673b25f115eb36b00abdda37e707f294a53defa482adbca7f8d9f6', '[\"*\"]', '2026-04-28 16:20:11', NULL, '2026-04-28 16:20:09', '2026-04-28 16:20:11');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `pickups`
--

CREATE TABLE `pickups` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receipt_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','ready','completed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `pickups`
--

INSERT INTO `pickups` (`id`, `receipt_id`, `status`, `completed_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
('019dd53d-cc3c-717d-ae1f-70da1e855aa1', '019dd53d-ca95-7080-8fec-971d960ab406', 'ready', NULL, '2026-04-28 15:58:10', '2026-04-28 15:58:10', NULL),
('019dd53d-cc9d-7001-b3b6-8d6e543915d9', '019dd53d-caa6-7386-bb00-3adc66dae979', 'cancelled', NULL, '2026-04-28 15:58:10', '2026-04-28 15:58:10', NULL),
('019dd53d-ccf2-7045-b34f-85a58a471389', '019dd53d-cabe-70d3-a7c7-1eda2c3247b3', 'cancelled', NULL, '2026-04-28 15:58:10', '2026-04-28 15:58:10', NULL),
('019dd53d-cd5d-73ea-bc5f-b3f29361ce65', '019dd53d-cace-7211-94b9-cac1896f5ab2', 'pending', NULL, '2026-04-28 15:58:10', '2026-04-28 15:58:10', NULL),
('019dd53d-cd96-703b-b7be-65602e0c4903', '019dd53d-cae9-721a-b44a-cfb6a7cd19c6', 'completed', NULL, '2026-04-28 15:58:10', '2026-04-28 15:58:10', NULL),
('019dd53d-cea7-73b5-9cf8-c2767b373c38', '019dd53d-caff-724a-94d5-b292778f30c4', 'completed', NULL, '2026-04-28 15:58:10', '2026-04-28 15:58:10', NULL),
('019dd53d-cf1a-73f7-b4ec-6478c58ea429', '019dd53d-cb12-7115-9d92-b888f208180a', 'ready', NULL, '2026-04-28 15:58:10', '2026-04-28 15:58:10', NULL),
('019dd53d-cf71-72d8-8e73-302f7fcae583', '019dd53d-cb2a-737e-8f47-a83dfa781ec0', 'cancelled', NULL, '2026-04-28 15:58:11', '2026-04-28 15:58:11', NULL),
('019dd53d-cfc5-7043-bd98-7e5116312e78', '019dd53d-cb42-733c-aac3-dfba899c0b27', 'pending', NULL, '2026-04-28 15:58:11', '2026-04-28 15:58:11', NULL),
('019dd53d-d01c-7346-963a-5c18a0059854', '019dd53d-cb62-7015-98c3-60ab4db93afb', 'cancelled', NULL, '2026-04-28 15:58:11', '2026-04-28 15:58:11', NULL),
('019dd53d-d088-72ae-8422-28ff873e597a', '019dd53d-cb78-70ca-a44d-117645e3baa3', 'ready', NULL, '2026-04-28 15:58:11', '2026-04-28 15:58:11', NULL),
('019dd53d-d0e2-72c5-b11d-df8a3df2768a', '019dd53d-cb8d-7324-ace7-a3b46e95bedf', 'cancelled', NULL, '2026-04-28 15:58:11', '2026-04-28 15:58:11', NULL),
('019dd53d-d11b-7333-9596-62425d625024', '019dd53d-cb9f-736c-8ed3-1e758555d218', 'completed', NULL, '2026-04-28 15:58:11', '2026-04-28 15:58:11', NULL),
('019dd53d-d16b-72f4-a718-319b0e0e6a78', '019dd53d-cbae-70b6-b875-5a73691c097b', 'ready', NULL, '2026-04-28 15:58:11', '2026-04-28 15:58:11', NULL),
('019dd53d-d1a0-71c7-ba37-bc8f9a56c928', '019dd53d-cbbd-726a-a8fc-5f92ebc4a0cb', 'pending', NULL, '2026-04-28 15:58:11', '2026-04-28 15:58:11', NULL),
('019dd54b-215e-7237-a724-fa63a645dbde', '019dd54b-20db-7349-9efc-ae48274077c2', 'cancelled', '2026-04-28 16:19:05', '2026-04-28 16:12:43', '2026-04-28 16:19:05', NULL),
('019dd54b-d9d0-737b-9839-e4af385bfe2a', '019dd54b-d97a-70f3-a65e-9a9a2b02daa3', 'cancelled', '2026-04-28 16:18:36', '2026-04-28 16:13:31', '2026-04-28 16:18:37', NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `publishers`
--

CREATE TABLE `publishers` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `publishers`
--

INSERT INTO `publishers` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
('019dd53d-b08b-7020-ab2e-bc29f5235533', 'Tor Books', '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b09b-70a8-b099-8f9bd3603b37', 'Del Rey Books', '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b0ac-73e1-a51d-d9d7a89d08c5', 'Gollancz', '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b0bd-70d7-8b2a-69aadc94e0e5', 'Orbit Books', '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b0cd-735c-bdcb-dab99654ffce', 'Ace Books', '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b0ec-7389-b41e-45fc93093272', 'Bantam Spectra', '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b10e-716e-898a-aada0a263b4a', 'HarperCollins', '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL),
('019dd53d-b129-736a-b6e4-b0b39863235f', 'Subterranean Press', '2026-04-28 15:58:03', '2026-04-28 15:58:03', NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `receipts`
--

CREATE TABLE `receipts` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `receipts`
--

INSERT INTO `receipts` (`id`, `user_id`, `date`) VALUES
('019dd53d-ca95-7080-8fec-971d960ab406', '019dd53d-b45c-70fb-bc53-ec0df168b938', '2025-09-12 00:32:15'),
('019dd53d-caa6-7386-bb00-3adc66dae979', '019dd53d-b68e-7254-94cf-4ee742101a24', '2025-08-14 03:52:56'),
('019dd53d-cabe-70d3-a7c7-1eda2c3247b3', '019dd53d-b47a-7249-871b-2632c70f638f', '2026-04-08 23:19:32'),
('019dd53d-cace-7211-94b9-cac1896f5ab2', '019dd53d-b44b-731a-92df-2d0b49536ac3', '2026-01-13 10:59:43'),
('019dd53d-cae9-721a-b44a-cfb6a7cd19c6', '019dd53d-b43f-71e9-a82b-280a75651ffa', '2026-01-24 20:28:32'),
('019dd53d-caff-724a-94d5-b292778f30c4', '019dd53d-b43f-71e9-a82b-280a75651ffa', '2025-05-21 12:04:24'),
('019dd53d-cb12-7115-9d92-b888f208180a', '019dd53d-b45c-70fb-bc53-ec0df168b938', '2026-04-03 23:50:11'),
('019dd53d-cb2a-737e-8f47-a83dfa781ec0', '019dd53d-b68e-7254-94cf-4ee742101a24', '2025-08-16 10:24:03'),
('019dd53d-cb42-733c-aac3-dfba899c0b27', '019dd53d-b47a-7249-871b-2632c70f638f', '2025-10-26 17:15:33'),
('019dd53d-cb62-7015-98c3-60ab4db93afb', '019dd53d-b68e-7254-94cf-4ee742101a24', '2025-09-14 07:07:24'),
('019dd53d-cb78-70ca-a44d-117645e3baa3', '019dd53d-b45c-70fb-bc53-ec0df168b938', '2026-02-09 16:43:28'),
('019dd53d-cb8d-7324-ace7-a3b46e95bedf', '019dd53d-b44b-731a-92df-2d0b49536ac3', '2026-02-17 02:59:55'),
('019dd53d-cb9f-736c-8ed3-1e758555d218', '019dd53d-b47a-7249-871b-2632c70f638f', '2025-08-07 03:32:51'),
('019dd53d-cbae-70b6-b875-5a73691c097b', '019dd53d-b416-737f-bb12-d1f8fb4b01c8', '2025-08-29 09:26:43'),
('019dd53d-cbbd-726a-a8fc-5f92ebc4a0cb', '019dd53d-b45c-70fb-bc53-ec0df168b938', '2026-02-01 15:20:36'),
('019dd54b-20db-7349-9efc-ae48274077c2', '019dd53d-b68e-7254-94cf-4ee742101a24', '2026-04-28 18:12:43'),
('019dd54b-d97a-70f3-a65e-9a9a2b02daa3', '019dd53d-b68e-7254-94cf-4ee742101a24', '2026-04-28 18:13:30');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('2ZNdDZFMxVPEbBwJvWqgLwEUihyZ8kkqJzgMm1Xj', NULL, '172.19.0.8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicDg5aWduMkZZbjIzVzB4R2dnMVJCUGhuN01Vd3FaTEJDZHBNcTNSaCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly93ZWJzZXJ2ZXIvZmlsZXMvYm9va3MvVVRqb1BDdlE0RlVCVEhSS1ZDSGRZclBzUDdmVHExNmpxYkx2RlBXUS5qcGciO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1777399367);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('customer','staff','manager','admin') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'customer',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `email_verified_at`, `password`, `role`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
('019dd53d-b416-737f-bb12-d1f8fb4b01c8', 'Zion', 'Schaden', 'schumm.agnes@example.com', '2026-04-28 15:58:03', '$2y$12$xe6jdV51wsMXmgLOHWgtMORIOv7oD3VWak3DcHPwx35nJlBX6aNkO', 'customer', 'HCJXCXd29k', '2026-04-28 15:58:04', '2026-04-28 15:58:04', NULL),
('019dd53d-b434-712f-8747-e68e42e648fd', 'Salvador', 'Rempel', 'anderson.antonette@example.net', '2026-04-28 15:58:04', '$2y$12$xe6jdV51wsMXmgLOHWgtMORIOv7oD3VWak3DcHPwx35nJlBX6aNkO', 'customer', 'jPwNGIPRpi', '2026-04-28 15:58:04', '2026-04-28 15:58:04', NULL),
('019dd53d-b43f-71e9-a82b-280a75651ffa', 'Sister', 'Mayert', 'cassie63@example.net', '2026-04-28 15:58:04', '$2y$12$xe6jdV51wsMXmgLOHWgtMORIOv7oD3VWak3DcHPwx35nJlBX6aNkO', 'customer', 'kUOp96jF09', '2026-04-28 15:58:04', '2026-04-28 15:58:04', NULL),
('019dd53d-b44b-731a-92df-2d0b49536ac3', 'Llewellyn', 'Gulgowski', 'pete08@example.net', '2026-04-28 15:58:04', '$2y$12$xe6jdV51wsMXmgLOHWgtMORIOv7oD3VWak3DcHPwx35nJlBX6aNkO', 'customer', 'XOtgeI2f9l', '2026-04-28 15:58:04', '2026-04-28 15:58:04', NULL),
('019dd53d-b45c-70fb-bc53-ec0df168b938', 'Susana', 'Sporer', 'ford.will@example.net', '2026-04-28 15:58:04', '$2y$12$xe6jdV51wsMXmgLOHWgtMORIOv7oD3VWak3DcHPwx35nJlBX6aNkO', 'customer', 'NzQK8mtXTg', '2026-04-28 15:58:04', '2026-04-28 15:58:04', NULL),
('019dd53d-b47a-7249-871b-2632c70f638f', 'Leonie', 'Grant', 'simonis.aidan@example.net', '2026-04-28 15:58:04', '$2y$12$xe6jdV51wsMXmgLOHWgtMORIOv7oD3VWak3DcHPwx35nJlBX6aNkO', 'customer', 'iEINuNciq5', '2026-04-28 15:58:04', '2026-04-28 15:58:04', NULL),
('019dd53d-b68e-7254-94cf-4ee742101a24', 'Customer', 'User', 'customer@customer.com', '2026-04-28 15:58:04', '$2y$12$kUiRFAzXeGPWpTO/c/AXP.EM5Qr3.ohUMG9W9y.gyuBMA.TIIRxNC', 'customer', NULL, '2026-04-28 15:58:04', '2026-04-28 15:58:04', NULL),
('019dd53d-b8d0-7039-9cff-d5776671734a', 'Staff', 'User', 'staff@staff.com', '2026-04-28 15:58:04', '$2y$12$jTB/FPIr3riTitGaK8W7QeaZV.nL9zchi.nDV.EZ4JqmxWDeVim42', 'staff', NULL, '2026-04-28 15:58:05', '2026-04-28 15:58:05', NULL),
('019dd53d-bca9-71a0-a24c-5013b0f8b411', 'Manager', 'User', 'manager@manager.com', '2026-04-28 15:58:05', '$2y$12$UolvYkuX/QAyk2wGCoM4HeyAahghn/A15k3Y0kTL4h3ImfWe2IcNy', 'manager', NULL, '2026-04-28 15:58:06', '2026-04-28 15:58:06', NULL),
('019dd53d-bf04-70c1-b4fb-2840cc53689e', 'Admin', 'User', 'admin@admin.com', '2026-04-28 15:58:06', '$2y$12$atLY1lqgOMjoidzFJV7zluzCtHEkx62a/oJxuibaciCyAX.jFe1mi', 'admin', NULL, '2026-04-28 15:58:06', '2026-04-28 15:58:06', NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `wishlists`
--

CREATE TABLE `wishlists` (
  `user_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `book_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `wishlists`
--

INSERT INTO `wishlists` (`user_id`, `book_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
('019dd53d-b416-737f-bb12-d1f8fb4b01c8', '019dd53d-c149-7367-a3ff-24715f7f3a94', '2026-04-28 15:58:08', '2026-04-28 15:58:08', NULL),
('019dd53d-b416-737f-bb12-d1f8fb4b01c8', '019dd53d-c230-73c2-b9ec-40d88f504308', '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-b416-737f-bb12-d1f8fb4b01c8', '019dd53d-c334-730e-a0eb-e3a432aed96b', '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-b434-712f-8747-e68e42e648fd', '019dd53d-c25e-713c-9c66-9ca19c76e481', '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-b434-712f-8747-e68e42e648fd', '019dd53d-c371-72f6-812b-bd41b49f7e3c', '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-b43f-71e9-a82b-280a75651ffa', '019dd53d-c1be-718f-b29e-71f3cb8e1550', '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-b43f-71e9-a82b-280a75651ffa', '019dd53d-c218-70dd-99d4-c3bf27dfbf7a', '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-b43f-71e9-a82b-280a75651ffa', '019dd53d-c2f7-7291-82b7-b1f38b02c5de', '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-b43f-71e9-a82b-280a75651ffa', '019dd53d-c371-72f6-812b-bd41b49f7e3c', '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-b44b-731a-92df-2d0b49536ac3', '019dd53d-c1be-718f-b29e-71f3cb8e1550', '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-b44b-731a-92df-2d0b49536ac3', '019dd53d-c2f7-7291-82b7-b1f38b02c5de', '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-b44b-731a-92df-2d0b49536ac3', '019dd53d-c31c-73cf-84c2-ee5c9829e020', '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-b45c-70fb-bc53-ec0df168b938', '019dd53d-c149-7367-a3ff-24715f7f3a94', '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-b47a-7249-871b-2632c70f638f', '019dd53d-c230-73c2-b9ec-40d88f504308', '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-b68e-7254-94cf-4ee742101a24', '019dd53d-c2cc-71c8-aac0-b43135c44952', '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-b8d0-7039-9cff-d5776671734a', '019dd53d-c189-7204-b3b0-d46ebfdab90f', '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-bca9-71a0-a24c-5013b0f8b411', '019dd53d-c2aa-73bc-a016-9994eb133c8b', '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL),
('019dd53d-bf04-70c1-b4fb-2840cc53689e', '019dd53d-c371-72f6-812b-bd41b49f7e3c', '2026-04-28 15:58:09', '2026-04-28 15:58:09', NULL);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `author_book`
--
ALTER TABLE `author_book`
  ADD PRIMARY KEY (`author_id`,`book_id`),
  ADD KEY `author_book_book_id_foreign` (`book_id`);

--
-- A tábla indexei `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `books_publisher_id_foreign` (`publisher_id`),
  ADD KEY `books_genre_id_foreign` (`genre_id`);

--
-- A tábla indexei `books_receipts`
--
ALTER TABLE `books_receipts`
  ADD PRIMARY KEY (`receipt_id`,`book_id`),
  ADD KEY `books_receipts_book_id_foreign` (`book_id`);

--
-- A tábla indexei `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- A tábla indexei `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- A tábla indexei `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coupons_book_id_foreign` (`book_id`),
  ADD KEY `coupons_genre_id_foreign` (`genre_id`),
  ADD KEY `coupons_user_id_foreign` (`user_id`);

--
-- A tábla indexei `coupons_receipts`
--
ALTER TABLE `coupons_receipts`
  ADD PRIMARY KEY (`receipt_id`,`coupon_id`),
  ADD KEY `coupons_receipts_coupon_id_foreign` (`coupon_id`);

--
-- A tábla indexei `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- A tábla indexei `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- A tábla indexei `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- A tábla indexei `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- A tábla indexei `pickups`
--
ALTER TABLE `pickups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pickups_receipt_id_foreign` (`receipt_id`);

--
-- A tábla indexei `publishers`
--
ALTER TABLE `publishers`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `receipts`
--
ALTER TABLE `receipts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `receipts_user_id_foreign` (`user_id`);

--
-- A tábla indexei `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_deleted_at_unique` (`email`,`deleted_at`);

--
-- A tábla indexei `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`user_id`,`book_id`),
  ADD KEY `wishlists_book_id_foreign` (`book_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT a táblához `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `author_book`
--
ALTER TABLE `author_book`
  ADD CONSTRAINT `author_book_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `author_book_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `books_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `books_publisher_id_foreign` FOREIGN KEY (`publisher_id`) REFERENCES `publishers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `books_receipts`
--
ALTER TABLE `books_receipts`
  ADD CONSTRAINT `books_receipts_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `books_receipts_receipt_id_foreign` FOREIGN KEY (`receipt_id`) REFERENCES `receipts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `coupons`
--
ALTER TABLE `coupons`
  ADD CONSTRAINT `coupons_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `coupons_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `coupons_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `coupons_receipts`
--
ALTER TABLE `coupons_receipts`
  ADD CONSTRAINT `coupons_receipts_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `coupons_receipts_receipt_id_foreign` FOREIGN KEY (`receipt_id`) REFERENCES `receipts` (`id`);

--
-- Megkötések a táblához `pickups`
--
ALTER TABLE `pickups`
  ADD CONSTRAINT `pickups_receipt_id_foreign` FOREIGN KEY (`receipt_id`) REFERENCES `receipts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `receipts`
--
ALTER TABLE `receipts`
  ADD CONSTRAINT `receipts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `wishlists`
--
ALTER TABLE `wishlists`
  ADD CONSTRAINT `wishlists_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wishlists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
