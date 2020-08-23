drop database if exists products;
create database products;
use products;



drop table if exists country;
create table country (
  `country_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(50) NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`country_id`)
);

drop table if exists cities;
create table cities (
  `city_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(50) NOT NULL,
  `country_id` SMALLINT UNSIGNED NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (city_id),
  KEY idx_fk_country_id (country_id),
  CONSTRAINT `fk_country_city` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

drop table if exists address;
CREATE TABLE `address` (
  `address_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(50) NOT NULL,
  `district` varchar(20) NOT NULL,
  `city_id` bigint unsigned NOT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`address_id`),
  KEY `idx_fk_city_id` (`city_id`),
  CONSTRAINT `fk_address_city` FOREIGN KEY (`city_id`) REFERENCES `cities` (`city_id`) ON DELETE RESTRICT ON UPDATE CASCADE
);


drop table if exists customers;
create table customers ( 
    `customer_id` bigint unsigned NOT NULL AUTO_INCREMENT, 
    `firstname` VARCHAR(100)comment 'Фамилия',
    `lastname` VARCHAR(100) comment 'Имя',
    `email` VARCHAR(100) UNIQUE,
    `address_id` bigint UNSIGNED NOT NULL,
    `active` BOOLEAN NOT NULL DEFAULT TRUE,
    `create_date` DATETIME NOT NULL,
    `last_update` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `password_hash` VARCHAR(100), 
    `phone` BIGINT unsigned,
    PRIMARY KEY (`customer_id`),
    KEY `idx_fk_address_id` (`address_id`),
    KEY `idx_fk_phone_id` (`phone`),
    KEY `idx_lastname` (`lastname`),
    CONSTRAINT `fk_customer_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE RESTRICT ON UPDATE CASCADE
    
);


drop table if exists additions;
create table additions (
     `customer_id` bigint unsigned NOT NULL AUTO_INCREMENT, 
     `gender` char(1) comment 'Пол',
     `birthday` date,
     `home` varchar(100),
     `create_at` datetime default now(),
     PRIMARY KEY (`customer_id`),
     CONSTRAINT `fk_customer_additions` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE
);


drop table if exists categories;
create table categories (
  `category_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (category_id)
  
);



drop table if exists products;
CREATE TABLE `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Название',
  `desription` text COMMENT 'Описание',
  `price` decimal(11,2) DEFAULT NULL COMMENT 'Цена',
  `quantity` INT NOT null COMMENT 'Количество',
  `category_id` bigint unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_of_category_id` (`category_id`),
  CONSTRAINT `fk_products_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
   
);

drop table if exists orders_products;
CREATE TABLE `orders_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned DEFAULT NULL,
  `product_id` bigint unsigned DEFAULT NULL,
  `total` decimal (11,2),  
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `index_of_product_id` (`order_id`),
  CONSTRAINT `fk_or_prod_categ` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

drop table if exists orders;
CREATE TABLE `orders`  (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned DEFAULT NULL,
  `status` enum('waiting pay','new','canceled','completed') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `index_of_customer_id` (`customer_id`),
  CONSTRAINT `fk_or_prod_orders` FOREIGN KEY (`id`) REFERENCES `orders_products` (`order_id`) ON DELETE RESTRICT ON UPDATE cascade,
  CONSTRAINT `fk_orders_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE
);


drop table if exists accounts;
create table accounts (
       `id` bigint unsigned NOT NULL AUTO_INCREMENT,
       `order_id` bigint unsigned DEFAULT NULL,
       `customer_id` bigint unsigned DEFAULT NULL,
       `total` decimal (11,2) comment 'Счет',
       `status` enum('waiting pay','success','error pay') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
       `created_at` datetime default current_timestamp,
       `updated_at` datetime default current_timestamp on update current_timestamp,
       PRIMARY KEY (`id`),
       KEY `index_of_customer_id` (`customer_id`),
       KEY `index_of_order_id` (`order_id`),
       CONSTRAINT `fk_accounts_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE RESTRICT ON UPDATE cascade,
       CONSTRAINT `fk_accounts_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
       
) comment = 'Счета пользователей';

































