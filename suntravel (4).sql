-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Апр 10 2026 г., 06:58
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `suntravel`
--

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_type` enum('tour','service','promotion') NOT NULL,
  `item_id` int(11) NOT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  `quantity` int(11) DEFAULT 1,
  `price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `status` enum('new','confirmed','paid','cancelled') DEFAULT 'new',
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `discount_applied` decimal(10,2) DEFAULT 0.00,
  `notes` text DEFAULT NULL,
  `contact_name` varchar(100) DEFAULT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  `contact_email` varchar(100) DEFAULT NULL,
  `related_tour_id` int(11) DEFAULT NULL,
  `desired_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `item_type`, `item_id`, `unit_price`, `total_price`, `quantity`, `price`, `total`, `status`, `order_date`, `discount_applied`, `notes`, `contact_name`, `contact_phone`, `contact_email`, `related_tour_id`, `desired_date`) VALUES
(10, 1, 'tour', 1, NULL, 106250.00, 1, 0.00, 0.00, 'new', '2026-04-09 23:09:26', 18750.00, '', 'Дарья', '+7 (9195922656)', 'Pilipchak@gmail.com', NULL, '2026-09-22'),
(11, 1, 'service', 2, NULL, 0.00, 1, 0.00, 0.00, 'new', '2026-04-09 23:09:39', 0.00, 'Добавление услуги к туру ID 1. ', 'Дарья', '+7 (9195922656)', 'Pilipchak@gmail.com', 1, NULL),
(12, 1, 'service', 3, NULL, 1500.00, 1, 0.00, 0.00, 'new', '2026-04-09 23:09:54', 0.00, 'Добавление услуги к туру ID 1. ', 'Дарья', '+7 (9195922656)', 'Pilipchak@gmail.com', 1, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `promotions`
--

CREATE TABLE `promotions` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `full_description` text DEFAULT NULL,
  `discount_percent` int(11) NOT NULL,
  `valid_from` date NOT NULL,
  `valid_to` date NOT NULL,
  `conditions` text DEFAULT NULL,
  `included` text DEFAULT NULL,
  `excluded` text DEFAULT NULL,
  `how_to_participate` text DEFAULT NULL,
  `additional_info` text DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `promotions`
--

INSERT INTO `promotions` (`id`, `title`, `description`, `full_description`, `discount_percent`, `valid_from`, `valid_to`, `conditions`, `included`, `excluded`, `how_to_participate`, `additional_info`, `image_url`, `is_active`, `created_at`) VALUES
(1, 'Раннее бронирование - скидки до 40%', 'Бронируйте туры на лето 2026 заранее и получайте максимальные скидки!', 'Акция \"Раннее бронирование - скидки до 40%\": Бронируйте туры на лето 2026 заранее и получайте максимальные скидки! Успейте воспользоваться!', 40, '2025-11-25', '2026-03-01', 'Действует на туры в любые направления при бронировании от 7 дней.', 'Скидка применяется автоматически', 'Не суммируется с другими акциями', 'Выберите тур, нажмите \"Применить скидку\" и оформите заказ.', 'Количество мест ограничено', './image/пальмы.jpg', 1, '2026-01-28 14:37:30'),
(2, 'Семейные туры - минус 15%', 'Специальное предложение для семей с детьми. Дети до 12 лет размещаются бесплатно!', 'Акция \"Семейные туры - минус 15%\": Специальное предложение для семей с детьми. Дети до 12 лет размещаются бесплатно! Успейте воспользоваться!', 15, '2025-12-01', '2026-12-31', 'Действует на туры в выбранные направления при бронировании от 7 дней.', 'Скидка применяется автоматически', 'Не суммируется с другими акциями', 'Выберите тур, нажмите \"Применить скидку\" и оформите заказ.', 'Количество мест ограничено', './image/семья на море.jpg', 1, '2026-01-28 14:37:30'),
(3, 'Горящие туры по Европе', 'Еженедельные скидки на туры в ближайшие даты. Вылет через 7-14 дней.', 'Акция \"Горящие туры по Европе\": Еженедельные скидки на туры в ближайшие даты. Вылет через 7-14 дней. Успейте воспользоваться!', 30, '2025-12-01', '2026-12-31', 'Действует на туры в любые направления при бронировании от 7 дней.', 'Скидка применяется автоматически', 'Не суммируется с другими акциями', 'Выберите тур, нажмите \"Применить скидку\" и оформите заказ.', 'Количество мест ограничено', './image/италия.jpg', 1, '2026-01-28 14:37:30'),
(4, 'Туры в Испанию с прямыми вылетами', 'Эксклюзивные предложения от нашего офиса в Барселоне. Без пересадок!', 'Акция \"Туры в Испанию с прямыми вылетами\": Эксклюзивные предложения от нашего офиса в Барселоне. Без пересадок! Успейте воспользоваться!', 25, '2025-12-01', '2026-10-31', 'Действует на туры в любые направления при бронировании от 7 дней.', 'Скидка применяется автоматически', 'Не суммируется с другими акциями', 'Выберите тур, нажмите \"Применить скидку\" и оформите заказ.', 'Количество мест ограничено', './image/ИспанияМост2.jpg', 1, '2026-01-28 14:37:30');

-- --------------------------------------------------------

--
-- Структура таблицы `requests`
--

CREATE TABLE `requests` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `request_type` varchar(50) NOT NULL,
  `destination` varchar(100) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `status` varchar(50) DEFAULT 'new',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `client_name` varchar(100) NOT NULL,
  `client_email` varchar(100) DEFAULT NULL,
  `rating` int(11) NOT NULL,
  `comment` text NOT NULL,
  `admin_response` text DEFAULT NULL,
  `admin_response_date` timestamp NULL DEFAULT NULL,
  `tour_id` int(11) DEFAULT NULL,
  `destination` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT 'Москва',
  `title` varchar(255) DEFAULT NULL,
  `tags` text DEFAULT NULL,
  `is_approved` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_id` int(11) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `reviews`
--

INSERT INTO `reviews` (`id`, `client_name`, `client_email`, `rating`, `comment`, `admin_response`, `admin_response_date`, `tour_id`, `destination`, `location`, `title`, `tags`, `is_approved`, `created_at`, `user_id`, `avatar`) VALUES
(1, 'Анна Петрова', 'anna@mail.ru', 5, 'Отличная организация тура в Барселону! Все продумано до мелочей. Особенно понравился индивидуальный гид.', NULL, NULL, NULL, 'Испания', 'Москва', 'Отзыв о поездке в Испания', 'отдых, море, солнце', 1, '2026-01-28 14:37:30', 1, './image/женщина в машине.jpg'),
(2, 'Иван Смирнов', 'ivan@yandex.ru', 5, 'Спасибо за прекрасный медовый месяц в Италии. Учли все наши пожелания, отель выше всех похвал!', NULL, NULL, NULL, 'Италия', 'Москва', 'Отзыв о поездке в Италия', 'отдых, море, солнце', 1, '2026-01-28 14:37:30', 1, './image/мужчина в очках.jpg'),
(3, 'Ольга Козлова', 'olga@gmail.com', 4, 'Хороший семейный отдых в Турции. Единственный минус - долгий перелет с пересадкой.', 'Ольга, спасибо за отзыв! Рады, что отдых понравился. По поводу перелета - учтем ваши пожелания при следующем бронировании. Будем рады видеть вас снова!', '2026-01-09 09:00:00', NULL, 'Турция', 'Москва', 'Отзыв о поездке в Турция', 'отдых, море, солнце', 1, '2026-01-28 14:37:30', 1, './image/блондинка.jpg'),
(4, 'Дмитрий Волков', 'dima@mail.ru', 5, 'Быстро оформили визу, помогли с документами. Профессиональный подход!', NULL, NULL, NULL, 'Франция', 'Москва', 'Отзыв о поездке в Франция', 'отдых, море, солнце', 1, '2026-01-28 14:37:30', 1, './image/мужчина в белом худи.jpg'),
(5, 'Анна Петрова', 'anna@mail.ru', 5, 'Хочу выразить огромную благодарность команде SunTravel за организацию нашего медового месяца! Спасибо менеджеру Марии за индивидуальный подход - она учла все наши пожелания: от отеля с видом на море до столика в лучшем ресторане города. Отдельное спасибо за экскурсию по Гауди с русскоговорящим гидом - это было невероятно! Обязательно обратимся снова.', NULL, NULL, NULL, 'Испания, Барселона', 'Москва', 'Отзыв о поездке в Испания, Барселона', 'отдых, море, солнце', 1, '2026-01-15 07:00:00', 1, './image/ии на солнце щатенка.jpg'),
(6, 'Иван Смирнов', 'ivan@mail.ru', 5, 'Мы с женой - большие любители итальянской кухни, поэтому выбрали гастрономический тур по Тоскане. SunTravel предложили уникальный маршрут: мы посетили частные винодельни, научились готовить пасту у местных шефов и даже поучаствовали в сборе оливок. Организация на высшем уровне, все трансферы вовремя, гиды - настоящие профессионалы. Цены оказались даже ниже, чем мы рассчитывали!', NULL, NULL, NULL, 'Италия, Тоскана', 'Москва', 'Отзыв о поездке в Италия, Тоскана', 'отдых, море, солнце', 1, '2026-01-12 07:00:00', 1, './image/мужчина в машине.jpg'),
(7, 'Ольга Козлова', 'olga@mail.ru', 4, 'Ездили семьей (двое детей 5 и 8 лет) на Пхукет. Отель выбрали по рекомендации менеджера - и не пожалели! Детский клуб, анимация, бассейны с горками. Особенно хочу отметить поддержку во время поездки: когда у младшего поднялась температура, менеджер оперативно связал нас с русскоговорящим врачом. Единственный минус - перелет был с длительной стыковкой, но это авиакомпании, а не SunTravel.', NULL, NULL, NULL, 'Таиланд, Пхукет', 'Москва', 'Отзыв о поездке в Таиланд, Пхукет', 'отдых, море, солнце', 1, '2026-01-08 07:00:00', 1, './image/женщина в машине.jpg'),
(8, 'Дмитрий Волков', 'dima@mail.ru', 5, 'Заказал сюрприз для жены - романтические выходные в Париже. Спасибо команде SunTravel за помощь в организации! Они не только забронировали отель у Эйфелевой башни и билеты на круиз по Сене, но и помогли заказать столик в ресторане с видом на город (что очень сложно сделать самостоятельно). Жена была в восторге! Отдельное спасибо за быструю визовую поддержку - визу сделали за 3 дня.', NULL, NULL, NULL, 'Франция, Париж', 'Москва', 'Отзыв о поездке в Франция, Париж', 'отдых, море, солнце', 1, '2026-01-05 07:00:00', 1, './image/мужчина в белом худи.jpg');

-- --------------------------------------------------------

--
-- Структура таблицы `review_likes`
--

CREATE TABLE `review_likes` (
  `id` int(11) NOT NULL,
  `review_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `review_likes`
--

INSERT INTO `review_likes` (`id`, `review_id`, `user_id`, `created_at`) VALUES
(1, 5, 1, '2026-04-09 20:10:59'),
(2, 6, 1, '2026-04-10 00:16:37');

-- --------------------------------------------------------

--
-- Структура таблицы `review_tags`
--

CREATE TABLE `review_tags` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `icon` varchar(50) DEFAULT 'fa-tag'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `review_tags`
--

INSERT INTO `review_tags` (`id`, `name`, `icon`) VALUES
(1, 'Аквапарк', 'fa-water'),
(2, 'Все включено', 'fa-utensils'),
(3, 'Для детей', 'fa-child'),
(4, 'Гастрономия', 'fa-utensil-spoon'),
(5, 'Винные туры', 'fa-wine-glass-alt'),
(6, 'Индивидуальный гид', 'fa-user-tie'),
(7, 'Пляж', 'fa-umbrella-beach'),
(8, 'Шопинг', 'fa-shopping-bag'),
(9, 'Экскурсии', 'fa-landmark'),
(10, 'Романтика', 'fa-heart');

-- --------------------------------------------------------

--
-- Структура таблицы `review_tag_relations`
--

CREATE TABLE `review_tag_relations` (
  `review_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `review_tag_relations`
--

INSERT INTO `review_tag_relations` (`review_id`, `tag_id`) VALUES
(1, 6),
(1, 9),
(2, 4),
(2, 5),
(3, 1),
(3, 2),
(3, 3),
(4, 6),
(4, 9),
(5, 1),
(5, 2),
(5, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `full_description` text DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `price_type` varchar(50) DEFAULT NULL,
  `duration` varchar(100) DEFAULT NULL,
  `category` varchar(50) NOT NULL,
  `features` text DEFAULT NULL,
  `included` text DEFAULT NULL,
  `excluded` text DEFAULT NULL,
  `meeting_point` varchar(255) DEFAULT NULL,
  `what_to_bring` text DEFAULT NULL,
  `important_info` text DEFAULT NULL,
  `is_popular` tinyint(1) DEFAULT 0,
  `image_url` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `services`
--

INSERT INTO `services` (`id`, `name`, `description`, `full_description`, `price`, `price_type`, `duration`, `category`, `features`, `included`, `excluded`, `meeting_point`, `what_to_bring`, `important_info`, `is_popular`, `image_url`, `created_at`) VALUES
(1, 'Визовая поддержка', 'Полное сопровождение оформления визы: консультация, подготовка документов, запись в консульство.', 'Полное описание услуги \"Визовая поддержка\": Полное сопровождение оформления визы: консультация, подготовка документов, запись в консульство. Мы гарантируем профессиональное выполнение в срок.', 5000.00, 'за визу', '7-14 дней', 'Документы', 'Особенности: Заполнение анкет, бронирование отелей, перевод документов', 'Все необходимые консультации и сопровождение', 'Государственные пошлины, нотариальные услуги (если требуются)', 'Офис SunTravel или онлайн', 'Паспорт, копии документов', 'Услуга предоставляется после 100% предоплаты', 1, './image/два паспорта.jpg', '2026-01-28 14:37:30'),
(2, 'Индивидуальный подбор тура', 'Персональный менеджер подберет тур по вашим критериям: бюджет, даты, предпочтения.', 'Полное описание услуги \"Индивидуальный подбор тура\": Персональный менеджер подберет тур по вашим критериям: бюджет, даты, предпочтения. Мы гарантируем профессиональное выполнение в срок.', NULL, 'бесплатно', '2 часа', 'Консультации', 'Особенности: Подбор отелей, перелетов, составление маршрута', 'Все необходимые консультации и сопровождение', 'Государственные пошлины, нотариальные услуги (если требуются)', 'Офис SunTravel или онлайн', 'Паспорт, копии документов', 'Услуга предоставляется после 100% предоплаты', 1, './image/красивый вид и шеслонги.jpg', '2026-01-28 14:37:30'),
(3, 'Страхование путешественников', 'Медицинская страховка с покрытием €100,000, страховка от невыезда.', 'Полное описание услуги \"Страхование путешественников\": Медицинская страховка с покрытием €100,000, страховка от невыезда. Мы гарантируем профессиональное выполнение в срок.', 1500.00, 'за человека', 'на время поездки', 'Страхование', 'Особенности: Медицинская помощь, эвакуация, отмена поездки', 'Все необходимые консультации и сопровождение', 'Государственные пошлины, нотариальные услуги (если требуются)', 'Офис SunTravel или онлайн', 'Паспорт, копии документов', 'Услуга предоставляется после 100% предоплаты', 1, './image/чемодан.jpg', '2026-01-28 14:37:30'),
(4, 'Трансферы', 'Встреча в аэропорту, трансфер отель-аэропорт-отель на комфортабельном автомобиле.', 'Полное описание услуги \"Трансферы\": Встреча в аэропорту, трансфер отель-аэропорт-отель на комфортабельном автомобиле. Мы гарантируем профессиональное выполнение в срок.', 3000.00, 'за трансфер', 'по запросу', 'Транспорт', 'Особенности: Встреча с табличкой, помощь с багажом, русскоговорящий водитель', 'Все необходимые консультации и сопровождение', 'Государственные пошлины, нотариальные услуги (если требуются)', 'Офис SunTravel или онлайн', 'Паспорт, копии документов', 'Услуга предоставляется после 100% предоплаты', 0, './image/катера.jpg', '2026-01-28 14:37:30'),
(5, 'Экскурсии с гидом', 'Индивидуальные и групповые экскурсии с профессиональным русскоговорящим гидом.', 'Полное описание услуги \"Экскурсии с гидом\": Индивидуальные и групповые экскурсии с профессиональным русскоговорящим гидом. Мы гарантируем профессиональное выполнение в срок.', 8000.00, 'за экскурсию', '3-8 часов', 'Экскурсии', 'Особенности: Исторические, гастрономические, авторские маршруты', 'Все необходимые консультации и сопровождение', 'Государственные пошлины, нотариальные услуги (если требуются)', 'Офис SunTravel или онлайн', 'Паспорт, копии документов', 'Услуга предоставляется после 100% предоплаты', 1, './image/аквалангист.jpg', '2026-01-28 14:37:30'),
(6, 'Корпоративный туризм', 'Организация MICE-мероприятий, тимбилдингов, деловых поездок для компаний.', 'Полное описание услуги \"Корпоративный туризм\": Организация MICE-мероприятий, тимбилдингов, деловых поездок для компаний. Мы гарантируем профессиональное выполнение в срок.', 5000.00, 'по запросу', 'индивидуально', 'Корпоративные', 'Особенности: Переговоры с партнерами, организация мероприятий', 'Все необходимые консультации и сопровождение', 'Государственные пошлины, нотариальные услуги (если требуются)', 'Офис SunTravel или онлайн', 'Паспорт, копии документов', 'Услуга предоставляется после 100% предоплаты', 0, './image/Прага.jpg', '2026-01-28 14:37:30');

-- --------------------------------------------------------

--
-- Структура таблицы `subscribers`
--

CREATE TABLE `subscribers` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `subscribed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `subscribers`
--

INSERT INTO `subscribers` (`id`, `email`, `subscribed_at`) VALUES
(1, 'Pilipchak@gmail.com', '2026-04-09 22:28:27');

-- --------------------------------------------------------

--
-- Структура таблицы `tours`
--

CREATE TABLE `tours` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `full_description` text DEFAULT NULL,
  `destination` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `duration_days` int(11) NOT NULL,
  `category` varchar(50) NOT NULL,
  `hotel_rating` int(11) DEFAULT NULL,
  `meals_type` varchar(50) DEFAULT NULL,
  `meeting_point` varchar(255) DEFAULT NULL,
  `guide` varchar(255) DEFAULT NULL,
  `itinerary` text DEFAULT NULL,
  `included` text DEFAULT NULL,
  `excluded` text DEFAULT NULL,
  `departure_city` varchar(100) DEFAULT 'Москва',
  `accommodation` text DEFAULT NULL,
  `departure_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `available_seats` int(11) DEFAULT 0,
  `is_hot` tinyint(1) DEFAULT 0,
  `is_exclusive` tinyint(1) DEFAULT 0,
  `discount_percent` int(11) DEFAULT 0,
  `image_url` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `tours`
--

INSERT INTO `tours` (`id`, `title`, `description`, `full_description`, `destination`, `country`, `price`, `duration_days`, `category`, `hotel_rating`, `meals_type`, `meeting_point`, `guide`, `itinerary`, `included`, `excluded`, `departure_city`, `accommodation`, `departure_date`, `return_date`, `available_seats`, `is_hot`, `is_exclusive`, `discount_percent`, `image_url`, `created_at`, `updated_at`) VALUES
(1, 'Эксклюзивный тур по Барселоне', 'Авторский маршрут от нашего представительства в Барселоне. Посещение Саграда Фамилия, парка Гуэль, готического квартала с русскоговорящим гидом.', 'Откройте для себя Барселону с авторским маршрутом от нашего представительства. Вы посетите Саграда Фамилию, парк Гуэль, готический квартал, а также насладитесь видами со смотровой площадки Монжуик. В стоимость входит проживание в отеле 4* с завтраками, экскурсии с русскоговорящим гидом и медицинская страховка. Дополнительно можно заказать гастрономический ужин с фламенко.', 'Барселона', 'Испания', 125000.00, 7, 'Авторские маршруты', 4, 'BB', NULL, NULL, NULL, NULL, NULL, 'Москва', NULL, NULL, NULL, 15, 1, 0, 15, './image/испания.jpg', '2026-01-28 14:37:30', '2026-04-09 16:48:49'),
(2, 'Романтическая Италия: Рим+Венеция', 'Идеальный тур для влюбленных пар. Римские каникулы и романтические гондолы в Венеции.', 'Идеальный тур для влюбленных пар. 4 дня в Риме с посещением Колизея, Ватикана и фонтана Треви, затем переезд в Венецию на 6 дней с проживанием в отеле на острове Джудекка. Вас ждет романтическая прогулка на гондоле, посещение собора Святого Марка и Дворца дожей. Включены завтраки и трансферы.', 'Рим+Венеция', 'Италия', 189000.00, 10, 'Романтические туры', 5, 'HB', NULL, NULL, NULL, NULL, NULL, 'Москва', NULL, NULL, NULL, 8, 0, 0, 10, './image/рим снизу.jpg', '2026-01-28 14:37:30', '2026-04-09 16:48:49'),
(3, 'Пляжный отдых на Пхукете', 'Все включено в отеле 5* на первой линии. Прямой перелет, трансфер, экскурсии.', 'Пхукет ждёт вас! Отдых на лучших пляжах, бирюзовая вода, вкуснейшая кухня. Отель 5* с системой \"все включено\" расположен на первой линии. Для детей – мини-клуб и анимация. Прямой перелет из Москвы, групповой трансфер. В стоимость включены медицинская страховка и встреча в аэропорту.', 'Пхукет', 'Таиланд', 95000.00, 14, 'Пляжный отдых', 5, 'AI', NULL, NULL, NULL, NULL, NULL, 'Москва', NULL, NULL, NULL, 25, 1, 0, 20, './image/красивое место с пальмами.jpg', '2026-01-28 14:37:30', '2026-04-09 19:16:51'),
(4, 'Гастрономический тур по Франции', 'Винные дегустации, кулинарные мастер-классы, посещение лучших ресторанов Парижа и Прованса.', 'Гастрономическое путешествие по Франции: Париж, Бордо, Прованс. Вас ждут мастер-классы от шеф-поваров, дегустации сыров и вин, ужины в Michelin-ресторанах. Проживание в бутик-отелях 4*. Гид – сертифицированный сомелье. Тур на 12 дней с завтраками и 4 ужинами с винами.', 'Париж+Прованс', 'Франция', 210000.00, 12, 'Гастрономические туры', 4, 'BB', NULL, NULL, NULL, NULL, NULL, 'Москва', NULL, NULL, NULL, 10, 0, 0, 5, './image/2Франция.jpg', '2026-01-28 14:37:30', '2026-04-09 19:16:51'),
(5, 'Горнолыжный курорт в Сочи', 'Красная Поляна, ски-пасс на 6 дней, оборудование, инструктор для начинающих.', 'Красная Поляна – идеальное место для горнолыжного отдыха. В пакет входит: проживание в отеле у подъёмника, ски-пасс на 6 дней, аренда оборудования, 3 занятия с инструктором для начинающих. Трансфер из аэропорта Сочи. Банный комплекс после катания.', 'Сочи', 'Россия', 65000.00, 7, 'Горнолыжный отдых', 4, 'HB', NULL, NULL, NULL, NULL, NULL, 'Москва', NULL, NULL, NULL, 30, 1, 0, 15, './image/Сочи.jpg', '2026-01-28 14:37:30', '2026-04-09 19:16:51'),
(6, 'Экскурсионный тур по Чехии и Австрии', 'Прага, Вена, Зальцбург. Автобусный тур с проживанием в отелях 4*.', 'Знакомство с жемчужинами Европы: Прага, Вена, Зальцбург. Автобусный тур с русскоговорящим гидом. Включено: проживание в отелях 4* в центре городов, завтраки, экскурсии: Пражский Град, дворец Шёнбрунн, дом Моцарта. Свободное время для шопинга и самостоятельных прогулок.', 'Прага+Вена', 'Европа', 78000.00, 8, 'Экскурсионные туры', 4, 'BB', NULL, NULL, NULL, NULL, NULL, 'Москва', NULL, NULL, NULL, 20, 0, 0, 0, './image/Прага.jpg', '2026-01-28 14:37:30', '2026-04-09 19:16:51');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `avatar` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `password`, `role`, `created_at`, `updated_at`, `avatar`) VALUES
(1, 'Дарья', 'Pilipchak@gmail.com', '+7 (9195922656)', '$2y$10$IAFDOFK46wW.v13.AGawFeqjAAX4G6Jd4T05T4YO.5oDdd5sxZEuG', 'user', '2026-04-07 22:27:40', '2026-04-09 22:21:10', './image/avatar-placeholder.jpg');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `promotions`
--
ALTER TABLE `promotions`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `review_likes`
--
ALTER TABLE `review_likes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_like` (`review_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `review_tags`
--
ALTER TABLE `review_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индексы таблицы `review_tag_relations`
--
ALTER TABLE `review_tag_relations`
  ADD PRIMARY KEY (`review_id`,`tag_id`),
  ADD KEY `tag_id` (`tag_id`);

--
-- Индексы таблицы `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Индексы таблицы `tours`
--
ALTER TABLE `tours`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT для таблицы `promotions`
--
ALTER TABLE `promotions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `requests`
--
ALTER TABLE `requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `review_likes`
--
ALTER TABLE `review_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `review_tags`
--
ALTER TABLE `review_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `tours`
--
ALTER TABLE `tours`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `review_likes`
--
ALTER TABLE `review_likes`
  ADD CONSTRAINT `review_likes_ibfk_1` FOREIGN KEY (`review_id`) REFERENCES `reviews` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `review_likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `review_tag_relations`
--
ALTER TABLE `review_tag_relations`
  ADD CONSTRAINT `review_tag_relations_ibfk_1` FOREIGN KEY (`review_id`) REFERENCES `reviews` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `review_tag_relations_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `review_tags` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
