INSERT INTO `categories` (`id`, `name`, `description`, `created`, `modified`) VALUES
(1, 'Smartphone', 'Not a stupid phone', '2015-08-02 23:56:46', '2016-12-20 06:51:25'),
(2, 'Tablet', 'A small smartphone-laptop mix', '2015-08-02 23:56:46', '2016-12-20 06:51:42'),
(3, 'Ultrabook', 'Ultra portable and powerful laptop', '2016-12-20 13:51:15', '2016-12-20 06:51:52');

INSERT INTO `products` (`id`, `name`, `description`, `price`, `category_id`, `created`, `modified`) VALUES
(1, 'ASUS Zenbook 3', 'The most powerful and ultraportable Zenbook ever', 1799, 3, '2016-12-20 13:53:00', '2016-12-20 06:53:00'),
(2, 'Dell XPS 13', 'Super powerful and portable ultrabook with ultra thin bezel infinity display', 2199, 3, '2016-12-20 13:53:34', '2016-12-20 06:53:34'),
(3, 'Samsung Galaxy S7', 'Define what a phone can do', 649, 1, '2016-12-20 13:54:16', '2016-12-20 06:54:16'),
(4, 'Samsung Galaxy Tab S2', 'Latest Generation of Samsung Galaxy Tab Series tablet', 599, 2, '2016-12-20 13:54:43', '2016-12-20 06:54:43'),
(5, 'Apple iPad Pro', 'Powerful, thin, and light tablet from Apple', 899, 2, '2016-12-20 13:55:02', '2016-12-20 06:55:02'),
(6, 'Google Pixel', 'World''s leading smartphone camera, first phone by Google.', 649, 1, '2016-12-20 13:55:23', '2016-12-20 06:55:23'),
(7, 'Oneplus 3T', 'Never Settle', 439, 1, '2016-12-20 13:59:06', '2016-12-20 06:59:06'),
(8, 'Asus Zenfone 3 Deluxe', 'Super powerful and gorgeously designed phablet', 799, 1, '2016-12-20 13:59:37', '2016-12-20 06:59:37'),
(9, 'Xiaomi Mi Mix', 'Bezelless. Powerful. Gorgeous.', 699, 1, '2016-12-20 14:00:20', '2016-12-20 07:00:20'),
(10, 'Huawei P9', 'First Leica Branded Dual-camera Smartphone', 499, 1, '2016-12-20 14:00:45', '2016-12-20 07:00:45'),
(11, 'Xiaomi Mi 5S', 'First Xiaomi smartphone to come with light-sensitive camera', 349, 1, '2016-12-20 14:01:40', '2016-12-20 07:10:14'),
(12, 'LG V20', 'Superb dual camera, Space-grade Aluminum build, fantastic sound quality', 749, 1, '2016-12-20 14:02:28', '2016-12-20 07:02:28');

INSERT INTO `users` (`id`, `email`, `password_hash`, `salt`, `iteration_count`, `created_at`) VALUES
(1, 'demo@demo.com', '/TVyvAPSryEfGlyEFmNq14Q/prbJU7U=', 'YYONLJPUCmUeISgDxyTREg==', 10, '2019-11-23 02:54:42');
