DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `created` date DEFAULT NULL,
    `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `modified` datetime(6) DEFAULT NULL,
    `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `created` date DEFAULT NULL,
    `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `modified` datetime(6) DEFAULT NULL,
    `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
    `price` double NOT NULL,
    `category_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `FKog2rp4qthbtt2lfyhfo32lsw9` (`category_id`),
    CONSTRAINT `FKog2rp4qthbtt2lfyhfo32lsw9` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `created_at` datetime(6) DEFAULT NULL,
    `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `iteration_count` int(11) DEFAULT NULL,
    `password_hash` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `salt` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;