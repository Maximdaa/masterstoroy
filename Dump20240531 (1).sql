-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: store
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,1,2,1),(2,1,1,3),(4,2,2,13),(5,3,1,1),(9,2,4,2),(11,2,20,7),(12,2,10,3);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `client_id` int NOT NULL AUTO_INCREMENT,
  `username` tinytext,
  `Phone_number` text,
  `Address` text,
  `password` text,
  `email` text,
  `isAdmin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Maxim','+79815672345','ул.Пушкина д.1','123','123@mail.ru',1),(2,'Андрей','+79214562367','ул.Пушкина д.2','1234','333@yandex.ru',0),(3,'Михаил','+78213562387','ул.Пушкина д.3','456','456@mail.ru',0),(4,'Федор','+79673452356','ул.Пушкина д.4','123','nsjfnkasd@mail.ru',0),(5,'Андрей','+79818223556','ул.Пушкина д.5','213','fghdfdg@yandex.ru',1),(6,'Федор','+79812453334','ул.Ленина д.3','132','gfdkjbgd@yandex.ru',0),(7,'Максим','+79871242233','ул.Вербная д.2','123','dfgdfgh@yandex.ru',0),(8,'Анатолий','+79812452233','ул.Ломоносова д.8','213','hbfjdhg@yandex.ru',0),(9,'Сергей','+79876543210','ул.Ленина д.1','password1','sergey@mail.ru',0),(10,'Дмитрий','+79871234567','ул.Лермонтова д.2','password2','dmitry@mail.ru',0),(11,'Анна','+79812345678','ул.Толстого д.3','password3','anna@mail.ru',0),(12,'Ольга','+79817654321','ул.Достоевского д.4','password4','olga@mail.ru',0),(13,'Иван','+79813216548','ул.Гоголя д.5','password5','ivan@mail.ru',0),(14,'Николай','+79812654879','ул.Чехова д.6','password6','nikolay@mail.ru',0),(15,'Мария','+79817625489','ул.Маяковского д.7','password7','maria@mail.ru',0),(16,'Екатерина','+79813425678','ул.Есенина д.8','password8','ekaterina@mail.ru',0),(17,'Алексей','+79813425789','ул.Шолохова д.9','password9','alexey@mail.ru',0),(18,'Наталья','+79813254687','ул.Тургенева д.10','password10','natalya@mail.ru',0),(19,'Юлия','+79812348765','ул.Шекспира д.11','password11','yulia@mail.ru',0),(20,'Петр','+79812458763','ул.Пастернака д.12','password12','petr@mail.ru',0),(21,'Андрей','+78882223344','ул. Дудина','222','Andrei@yandex.ru',0),(22,'Елена','+1','1','111','elena@yandex.ru',0),(23,'Андрей','1','1','3456','1',0);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_invoice`
--

DROP TABLE IF EXISTS `delivery_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_invoice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `request_id` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quntity` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_invoice`
--

LOCK TABLES `delivery_invoice` WRITE;
/*!40000 ALTER TABLE `delivery_invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `client_id` int DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  `full_price` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,1,1,'2024-01-05',1,2,5,NULL),(2,2,1,'2023-11-02',6,3,2,NULL),(3,3,2,'2024-02-15',2,2,4,NULL),(4,1,1,'2024-01-05',8,1,5,NULL),(5,4,2,'2024-03-12',1,1,1,NULL),(6,2,3,'2024-04-23',3,3,2,NULL),(7,3,1,'2024-05-10',7,2,4,NULL),(8,5,3,'2024-06-01',7,1,5,NULL),(9,1,2,'2024-07-14',12,2,5,NULL),(10,2,1,'2024-08-19',9,3,2,NULL),(11,3,3,'2024-09-25',12,2,4,NULL),(12,4,2,'2024-10-05',19,1,1,NULL),(13,5,1,'2024-11-13',13,2,5,NULL),(14,1,3,'2024-12-20',20,3,5,NULL),(15,2,2,'2024-01-03',5,1,2,NULL),(16,3,1,'2024-02-14',15,2,4,NULL),(17,4,3,'2024-03-17',17,1,1,NULL),(18,5,2,'2024-04-22',15,3,5,NULL),(19,1,1,'2024-05-09',18,2,5,NULL),(20,2,2,'2024-06-18',2,3,2,NULL);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `Name` text,
  `Price` double DEFAULT NULL,
  `Category_id` int DEFAULT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Кирпич',30,1,'Кирпич красный, размер 250x120x65 мм.','brick'),(2,'Цемент',400,2,'Портландцемент, марка М500.','cement'),(3,'Краска',1500,3,'Акриловая краска в асс.','paint'),(4,'Доски',100,4,'Доски хвойных пород, размер 50x150 мм, длина 2 м.','planks'),(5,'Керамическая плитка',2000,5,'Керамическая плитка для напольного покрытия.','tiles'),(6,'Монтажная пена',1000,6,'Монтажная пена для утепления.','faom'),(7,'Щебень',500,1,'Щебень фракции 5-20 мм.','scheben'),(8,'Гравий',600,1,'Гравий речной, фракции 10-40 мм.','gravel'),(9,'Песок',300,2,'Речной песок, мелкий.','sand'),(10,'Арматура',700,2,'Арматура стальная, диаметр 12 мм.','rebar'),(11,'Лак',1200,3,'Лак акриловый, прозрачный.','varnish'),(12,'Шпаклевка',800,3,'Шпаклевка финишная.','putty'),(13,'Брус',150,4,'Брус хвойных пород, размер 100x100 мм, длина 3 м.','timber'),(14,'Фанера',900,4,'Фанера влагостойкая, толщина 18 мм.','plywood'),(15,'Керамическая плитка настенная',2500,5,'Керамическая плитка для стен.','wallTiles'),(16,'Мозаика',3000,5,'Мозаичная плитка для декоративного оформления.','mosaic'),(17,'Утеплитель',1800,6,'Утеплитель рулонный, минеральная вата.','insulation'),(18,'Клей монтажный',1100,6,'Клей для монтажа плит и панелей.','adhesive'),(19,'Цементно-песчаная смесь',450,2,'Смесь цемента и песка для строительных работ.','sand_cement_mix'),(20,'Гипсокартон',1300,4,'Листы гипсокартона, размер 2500x1200x12.5 мм.','drywall');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider`
--

DROP TABLE IF EXISTS `provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider` (
  `provider_id` int NOT NULL,
  `provider_name` text,
  `provider_phone_number` text,
  `email` text,
  `executive_respon` text,
  PRIMARY KEY (`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider`
--

LOCK TABLES `provider` WRITE;
/*!40000 ALTER TABLE `provider` DISABLE KEYS */;
INSERT INTO `provider` VALUES (1,'Поставщик','+79817205522','iampostavshic@yandex.ru','Анатолий Генадьевич'),(2,'Поставщик2','+79214452355','idntknow@mail.ru','Генадий Анатольевич');
/*!40000 ALTER TABLE `provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request`
--

DROP TABLE IF EXISTS `request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `request_id` int NOT NULL,
  `provider_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request`
--

LOCK TABLES `request` WRITE;
/*!40000 ALTER TABLE `request` DISABLE KEYS */;
INSERT INTO `request` VALUES (1,1,1,1,2),(2,1,1,2,1),(3,1,1,3,4),(4,1,1,5,3),(5,2,2,2,1),(6,2,2,5,3);
/*!40000 ALTER TABLE `request` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-31 23:55:20
