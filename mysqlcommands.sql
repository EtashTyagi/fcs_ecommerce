-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: fcs_ecommerce
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (2,'buyer'),(3,'seller');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add new product request',7,'add_newproductrequest'),(26,'Can change new product request',7,'change_newproductrequest'),(27,'Can delete new product request',7,'delete_newproductrequest'),(28,'Can view new product request',7,'view_newproductrequest'),(29,'Can add product',8,'add_product'),(30,'Can change product',8,'change_product'),(31,'Can delete product',8,'delete_product'),(32,'Can view product',8,'view_product'),(33,'Can add Category',9,'add_category'),(34,'Can change Category',9,'change_category'),(35,'Can delete Category',9,'delete_category'),(36,'Can view Category',9,'view_category'),(37,'Can add transaction',10,'add_transaction'),(38,'Can change transaction',10,'change_transaction'),(39,'Can delete transaction',10,'delete_transaction'),(40,'Can view transaction',10,'view_transaction'),(41,'Can add seller request',11,'add_sellerrequest'),(42,'Can change seller request',11,'change_sellerrequest'),(43,'Can delete seller request',11,'delete_sellerrequest'),(44,'Can view seller request',11,'view_sellerrequest');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (3,'pbkdf2_sha256$260000$F5qwytTlxXLzkb0a8PM73S$NxGeSoJSAquE11VdIJGsv48x/JGnXEOUMVzBwfv7QJo=','2021-11-07 20:18:58.869391',1,'etash','','','etash18@gmail.com',1,1,'2021-11-06 17:31:39.000000'),(4,'pbkdf2_sha256$260000$5xncceUsFgnaXqzmfufo9F$Jb70Yo4Qqre17PX/M+LUyrVPv5/wyuKjALctNlScQaY=','2021-11-07 16:13:35.357755',0,'temp','','','',0,1,'2021-11-07 06:48:05.000000'),(5,'pbkdf2_sha256$260000$FijfBZjgn2Ui32D3WyeJ4F$51IYW1zfe9nyrzdQmTQ8AhCnoIZtflqOgqZGf4hHAio=','2021-11-07 20:18:44.000000',0,'buyer','a','a','etash18@gmail.coma',0,1,'2021-11-07 12:12:43.000000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (3,3,3),(5,4,3),(7,5,2);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `user_id` int NOT NULL,
  `product_id` bigint NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`user_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `store_product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_chk_1` CHECK ((`quantity` between 1 and 99))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_transaction`
--

DROP TABLE IF EXISTS `cart_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_transaction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `seller_id` int DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `buyer_id` int DEFAULT NULL,
  `price` decimal(13,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `purchases_ibfk_1` (`buyer_id`),
  KEY `purchases_ibfk_2` (`item_id`),
  KEY `purchases_ibfk_3` (`seller_id`),
  CONSTRAINT `purchases_ibfk_1` FOREIGN KEY (`buyer_id`) REFERENCES `auth_user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `purchases_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `store_product` (`id`) ON DELETE SET NULL,
  CONSTRAINT `purchases_ibfk_3` FOREIGN KEY (`seller_id`) REFERENCES `auth_user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_transaction`
--

LOCK TABLES `cart_transaction` WRITE;
/*!40000 ALTER TABLE `cart_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (3,'2021-11-06 17:46:10.122492','3','a',3,'',7,3),(4,'2021-11-06 17:46:10.129103','2','a',3,'',7,3),(5,'2021-11-06 18:02:54.643865','13','Apple iPhone 11 Pro Max',2,'[{\"changed\": {\"fields\": [\"Description\", \"Category\"]}}]',8,3),(6,'2021-11-06 18:03:08.176719','12','Razer Blade 14',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',8,3),(7,'2021-11-06 18:03:14.953194','11','MSI GE66 Raider',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',8,3),(8,'2021-11-06 18:03:21.187845','10','Acer Predator Helios 300',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',8,3),(9,'2021-11-06 18:03:26.027692','9','ASUS VivoBook F512',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',8,3),(10,'2021-11-06 18:03:30.357124','8','Dell Inspiron',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',8,3),(11,'2021-11-06 18:03:34.919086','7','Lenovo Chromebook S330',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',8,3),(12,'2021-11-06 18:03:38.410748','6','HP Chromebook',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',8,3),(13,'2021-11-06 18:03:42.349876','5','HP Stream',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',8,3),(14,'2021-11-06 18:03:46.062763','4','ASUS Zenbook 13',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',8,3),(15,'2021-11-06 18:03:49.889143','3','Acer Aspire 5',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',8,3),(16,'2021-11-06 18:03:57.346370','2','Samsung Galaxy M12',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',8,3),(17,'2021-11-06 18:04:02.009058','1','MSI GF75 Thin',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',8,3),(18,'2021-11-06 18:04:08.211131','13','Apple iPhone 11 Pro Max',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',8,3),(19,'2021-11-06 18:04:22.181074','2','Samsung Galaxy M12',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',8,3),(20,'2021-11-06 18:12:22.153782','13','Apple iPhone 11 Pro Max',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',8,3),(21,'2021-11-06 18:12:38.544943','2','Samsung Galaxy M12',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',8,3),(22,'2021-11-06 20:43:24.848163','14','a',3,'',8,3),(23,'2021-11-07 06:47:45.104737','1','test',1,'[{\"added\": {}}]',3,3),(24,'2021-11-07 06:48:06.057394','4','temp',1,'[{\"added\": {}}]',4,3),(25,'2021-11-07 06:48:15.747137','4','temp',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,3),(26,'2021-11-07 10:45:23.058755','15','a',3,'',8,3),(27,'2021-11-07 11:10:29.965182','2','buyer',1,'[{\"added\": {}}]',3,3),(28,'2021-11-07 11:10:43.221216','1','test',3,'',3,3),(29,'2021-11-07 11:10:51.570939','3','seller',1,'[{\"added\": {}}]',3,3),(30,'2021-11-07 11:11:21.090615','4','temp',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,3),(31,'2021-11-07 11:13:35.630929','3','etash',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,3),(32,'2021-11-07 13:55:40.689291','17','a',3,'',8,3),(33,'2021-11-07 14:19:04.768740','4','temp',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,3),(34,'2021-11-07 16:15:50.003987','19','rand',3,'',8,3),(35,'2021-11-07 16:15:50.008627','18','a',3,'',8,3),(36,'2021-11-07 20:19:31.700941','5','buyer',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,3),(37,'2021-11-07 20:27:22.166900','20','a',3,'',8,3),(38,'2021-11-08 05:38:54.645789','21','Test',3,'',8,3);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(10,'Cart','transaction'),(5,'contenttypes','contenttype'),(7,'Sell','newproductrequest'),(11,'Sell','sellerrequest'),(6,'sessions','session'),(9,'Store','category'),(8,'Store','product');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'Sell','0001_initial','2021-11-06 17:17:55.060045'),(2,'Store','0001_initial','2021-11-06 17:17:55.103691'),(3,'contenttypes','0001_initial','2021-11-06 17:17:55.170554'),(4,'auth','0001_initial','2021-11-06 17:17:56.085102'),(5,'admin','0001_initial','2021-11-06 17:17:56.386131'),(6,'admin','0002_logentry_remove_auto_add','2021-11-06 17:17:56.396435'),(7,'admin','0003_logentry_add_action_flag_choices','2021-11-06 17:17:56.406692'),(8,'contenttypes','0002_remove_content_type_name','2021-11-06 17:17:56.547594'),(9,'auth','0002_alter_permission_name_max_length','2021-11-06 17:17:56.634166'),(10,'auth','0003_alter_user_email_max_length','2021-11-06 17:17:56.683386'),(11,'auth','0004_alter_user_username_opts','2021-11-06 17:17:56.693525'),(12,'auth','0005_alter_user_last_login_null','2021-11-06 17:17:56.759798'),(13,'auth','0006_require_contenttypes_0002','2021-11-06 17:17:56.764629'),(14,'auth','0007_alter_validators_add_error_messages','2021-11-06 17:17:56.775699'),(15,'auth','0008_alter_user_username_max_length','2021-11-06 17:17:56.875390'),(16,'auth','0009_alter_user_last_name_max_length','2021-11-06 17:17:57.209941'),(17,'auth','0010_alter_group_name_max_length','2021-11-06 17:17:57.269423'),(18,'auth','0011_update_proxy_permissions','2021-11-06 17:17:57.286085'),(19,'auth','0012_alter_user_first_name_max_length','2021-11-06 17:17:57.443750'),(20,'sessions','0001_initial','2021-11-06 17:17:57.558490'),(21,'Store','0002_remove_product_quantity','2021-11-06 17:21:39.314106'),(22,'Sell','0002_remove_newproductrequest_quantity','2021-11-06 17:35:33.739515'),(23,'Store','0003_category','2021-11-06 17:51:16.860816'),(24,'Store','0004_auto_20211106_2332','2021-11-06 18:02:05.116456'),(25,'Sell','0003_newproductrequest_category','2021-11-06 20:37:21.010686'),(26,'Store','0005_product_seller_uid','2021-11-07 08:12:46.557742'),(27,'Sell','0004_auto_20211107_1424','2021-11-07 09:12:07.811109'),(28,'Sell','0005_auto_20211107_1442','2021-11-07 09:12:08.052946'),(29,'Sell','0006_remove_newproductrequest_pdf_name','2021-11-07 10:07:37.559857'),(30,'Store','0006_auto_20211107_1537','2021-11-07 10:07:37.726727'),(31,'Cart','0001_initial','2021-11-07 14:45:49.420501'),(32,'Cart','0002_auto_20211107_2019','2021-11-07 14:49:27.946616'),(33,'Cart','0003_remove_transaction_quantity','2021-11-07 16:05:52.759197'),(34,'Sell','0007_sellerrequest','2021-11-07 18:10:07.342428'),(35,'Sell','0008_newproductrequest_message','2021-11-07 18:49:32.036684');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('53h1cn85dr5dzczxh57ak6vt441g64nx','.eJxVjDsOwyAQBe9CHSHEx0DK9DkDWnbXwUkEkrErK3ePLblI2jczbxMJ1qWktfOcJhJXYcTld8uAL64HoCfUR5PY6jJPWR6KPGmX90b8vp3u30GBXvZaURx9gOg8BeusDhkVeWY7BE04eDScKYA1BKMKGjNH9gh6r9CxjuLzBfOJOLU:1mjod0:wbkNLeK6CMB9UqC618nCi39kRLvidy3xj-pmM4iFR5I','2021-11-21 20:18:58.875121'),('82zjlvjjgrpi3kwdd88o1wp01wa0934w','.eJxVjDkOwjAUBe_iGlnfa2JKes5g2X8hAZRIcVIh7g6RUkD7Zua9VC7bOuSt8ZJHUmcV1Ol3qwUfPO2A7mW6zRrnaV3GqndFH7Tp60z8vBzu38FQ2vCtDQNEF1JMDgVMAQBhpBo8-kAVvDhnO-wcSEzkhaU32PVWrCeInNT7A9L5N58:1mjjut:peode9ifIZ1UEuf1hbXi9NLUPUmRRYZNCJIcHH1SRGs','2021-11-21 15:17:07.344780'),('8p4cjcbyoe5jpmcavfl3xxhnoyk4q7cj','e30:1mjxQu:-_q1TJ1CWHjYSH55ODwcpEk1uGUJO1qu4n0m7B9YRFs','2021-11-22 05:43:04.642971'),('jqc3q83a5lmlmzrgik4t8hqkej36yvc7','.eJxVjDsOwyAQBe9CHSHEx0DK9DkDWnbXwUkEkrErK3ePLblI2jczbxMJ1qWktfOcJhJXYcTld8uAL64HoCfUR5PY6jJPWR6KPGmX90b8vp3u30GBXvZaURx9gOg8BeusDhkVeWY7BE04eDScKYA1BKMKGjNH9gh6r9CxjuLzBfOJOLU:1mjdsw:d8DQmfrUIEsOMa77AOAO1ODxxGrXTUOZIQmKfzqobdQ','2021-11-21 08:50:42.535855'),('kg6cipscu0kwo08xezols14l2sl08on3','e30:1mjQlF:XAIIqM1BwflVt8wNKmiWsaWUK38J5OQp-YZDuXeEKIw','2021-11-20 18:49:53.414199'),('l2gu82elubr2lonjmixo254qr9l3kxwz','.eJxVjDsOwyAQBe9CHSHEx0DK9DkDWnbXwUkEkrErK3ePLblI2jczbxMJ1qWktfOcJhJXYcTld8uAL64HoCfUR5PY6jJPWR6KPGmX90b8vp3u30GBXvZaURx9gOg8BeusDhkVeWY7BE04eDScKYA1BKMKGjNH9gh6r9CxjuLzBfOJOLU:1mjRug:pEmIInz1QtHQZbLZPGQQQpwCfyWgTYGcF9w-qe37PaY','2021-11-20 20:03:42.363556');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paymentgateway_price`
--

DROP TABLE IF EXISTS `paymentgateway_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paymentgateway_price` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stripe_price_id` varchar(100) NOT NULL,
  `price` decimal(13,2) NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PaymentGateway_price_product_id_a8f39958_fk_PaymentGa` (`product_id`),
  CONSTRAINT `PaymentGateway_price_product_id_a8f39958_fk_PaymentGa` FOREIGN KEY (`product_id`) REFERENCES `paymentgateway_stripe_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymentgateway_price`
--

LOCK TABLES `paymentgateway_price` WRITE;
/*!40000 ALTER TABLE `paymentgateway_price` DISABLE KEYS */;
INSERT INTO `paymentgateway_price` VALUES (1,'price_1JtFN9SBGHFum3RMrBqjmmvI',994.80,1),(2,'price_1JtQrsSBGHFum3RMCFOMFNfM',136.81,2),(3,'price_1JtQt7SBGHFum3RMu0WbPp3o',399.99,3),(4,'price_1JtQuSSBGHFum3RMFixfVPpn',919.99,4),(5,'price_1JtQviSBGHFum3RMDKbad3vA',233.48,5),(6,'price_1JtQwhSBGHFum3RMU1NrPayy',289.00,6),(7,'price_1JtQxkSBGHFum3RMkGHgBE1t',169.00,7),(8,'price_1JtQz2SBGHFum3RMSfK0Vjmi',799.99,8),(9,'price_1JtR0FSBGHFum3RMUFN6aU4X',519.99,9),(10,'price_1JtR1ESBGHFum3RM9oBDSyQN',1230.68,10),(11,'price_1JtR28SBGHFum3RM53qK9Ow2',1773.99,11),(12,'price_1JtR31SBGHFum3RM2GFfHZRV',2199.99,12),(13,'price_1JtR46SBGHFum3RMMyINbio1',849.00,13),(14,'price_1JtR5wSBGHFum3RMnK0FOWty',299.00,14);
/*!40000 ALTER TABLE `paymentgateway_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paymentgateway_stripe_product`
--

DROP TABLE IF EXISTS `paymentgateway_stripe_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paymentgateway_stripe_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `stripe_product_id` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymentgateway_stripe_product`
--

LOCK TABLES `paymentgateway_stripe_product` WRITE;
/*!40000 ALTER TABLE `paymentgateway_stripe_product` DISABLE KEYS */;
INSERT INTO `paymentgateway_stripe_product` VALUES (1,'MSI GF75 Thin','prod_KYM5S1pq1SUlYl'),(2,'Samsung Galaxy M12','prod_KYXxRrqpNYKgdC'),(3,'Acer Aspire 5','prod_KYXzZAnZtLDP6y'),(4,'ASUS Zenbook 13','prod_KYY0QJrd6iNEvT'),(5,'HP Stream','prod_KYY13R8Yh6ef5H'),(6,'HP Chromebook','prod_KYY2cjzxVF59Vs'),(7,'Lenovo Chromebook S330','prod_KYY34UBwG8HIqw'),(8,'Dell Inspiron','prod_KYY5XvLvQ2eQ44'),(9,'ASUS VivoBook F512','prod_KYY61OP0sNaZaO'),(10,'Acer Predator Helios 300','prod_KYY7VP57Pe9wRX'),(11,'MSI GE66 Raider','prod_KYY8a86CRyiQoi'),(12,'Razer Blade 14','prod_KYY9NXWCEgPQmR'),(13,'Apple iPhone 11 Pro Max','prod_KYYACU2SmCl6BC'),(14,'Oculus Quest 2','prod_KYYC0eomQzGAQL');
/*!40000 ALTER TABLE `paymentgateway_stripe_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone_numbers`
--

DROP TABLE IF EXISTS `phone_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phone_numbers` (
  `user_id` int NOT NULL,
  `phone_number` char(10) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `phone_numbers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone_numbers`
--

LOCK TABLES `phone_numbers` WRITE;
/*!40000 ALTER TABLE `phone_numbers` DISABLE KEYS */;
INSERT INTO `phone_numbers` VALUES (5,'9205401464');
/*!40000 ALTER TABLE `phone_numbers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sell_newproductrequest`
--

DROP TABLE IF EXISTS `sell_newproductrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sell_newproductrequest` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `seller_uid` int NOT NULL,
  `title` varchar(25) NOT NULL,
  `short_description` varchar(200) NOT NULL,
  `description` varchar(5000) NOT NULL,
  `price` decimal(13,2) NOT NULL,
  `category` varchar(100) NOT NULL,
  `image_1` varchar(1000) NOT NULL,
  `image_2` varchar(1000) NOT NULL,
  `image_3` varchar(1000) DEFAULT NULL,
  `image_4` varchar(1000) DEFAULT NULL,
  `image_5` varchar(1000) DEFAULT NULL,
  `message` varchar(2000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seller_new_id` (`seller_uid`),
  CONSTRAINT `fk_seller_new_id` FOREIGN KEY (`seller_uid`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sell_newproductrequest`
--

LOCK TABLES `sell_newproductrequest` WRITE;
/*!40000 ALTER TABLE `sell_newproductrequest` DISABLE KEYS */;
/*!40000 ALTER TABLE `sell_newproductrequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sell_sellerrequest`
--

DROP TABLE IF EXISTS `sell_sellerrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sell_sellerrequest` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `buyer_id` int NOT NULL,
  `message` varchar(2000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sellerrequest_ibfk_1` (`buyer_id`),
  CONSTRAINT `sellerrequest_ibfk_1` FOREIGN KEY (`buyer_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sell_sellerrequest`
--

LOCK TABLES `sell_sellerrequest` WRITE;
/*!40000 ALTER TABLE `sell_sellerrequest` DISABLE KEYS */;
INSERT INTO `sell_sellerrequest` VALUES (9,5,'ye kya tatti submit kia hai, galat hai firse kar abhi ke abhi jaldi se jaldi, ye wrap hua kya, plis hoja plzzzzzzzzzzzz');
/*!40000 ALTER TABLE `sell_sellerrequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_product`
--

DROP TABLE IF EXISTS `store_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(25) NOT NULL,
  `short_description` varchar(200) NOT NULL,
  `description` varchar(5000) NOT NULL,
  `price` decimal(13,2) NOT NULL,
  `image_1` varchar(1000) NOT NULL,
  `category` varchar(100) NOT NULL,
  `seller_uid` int NOT NULL,
  `available_quantity` int NOT NULL,
  `image_2` varchar(1000) NOT NULL,
  `image_3` varchar(1000) DEFAULT NULL,
  `image_4` varchar(1000) DEFAULT NULL,
  `image_5` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seller_prod_id` (`seller_uid`),
  CONSTRAINT `fk_seller_prod_id` FOREIGN KEY (`seller_uid`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_product`
--

LOCK TABLES `store_product` WRITE;
/*!40000 ALTER TABLE `store_product` DISABLE KEYS */;
INSERT INTO `store_product` VALUES (1,'MSI GF75 Thin','10th Generation Intel Core i7-10750H Up To 5GHz, 17.3\" FHD IPS-Level 144Hz Panel Laptop (8GB/512GB NVMe SSD/Windows 10 Home/Nvidia GTX1650 4GB GDDR6/Black/2.2Kg)','<ul><li><b>Processor:</b> 10th Generation Intel Core i7-10750H Up To 5GHz</li><li><b>Operating System:</b> Pre-loaded Windows 10 Home with lifetime validity | Preinstalled Software: MSI BurnRecovery, MSI Battery Calibration, MSI Help Desk, Norton Internet Security (trail 60days) Norton Studio (Metro) (permanent free), Nvidia GeForce Experience, Nahimic 3, Dragon Center | In the box: Laptop, adapter</li><li><b>Display:</b> 17.3\" (43.9 cm) FHD (1920*1080), IPS-Level 144Hz Thin Bezel, 45% NTSC</li><li><b>Memory & Storage:</b> 8 GB DDR4 2666MHz RAM, expandable to 64 GB | Storage: 512GB NVMe SSD</li><li>NVIDIA GeForce GTX 1650 GDDR6 4GB Dedicated Graphics</li><li>Ultra Thin and light design | Laptop weight: 2.2 kg | Cooling: CoolerBoost 5</li><li><b>Keyboard:</b> Steelseries RED Backlit Keyboard</li><li><b>Camera:</b> HD type (30fps@720p) | Microphone: Built-in microphone</li><li>1x Type-C USB3.2 Gen1, 3x Type-A USB3.2 Gen1, 1x RJ45, 1x (4K @ 30Hz) HDMI</li></ul>',994.80,'https://m.media-amazon.com/images/I/81DR+J7JxkL._AC_UY327_FMwebp_QL65_.jpg','laptop',3,268,'',NULL,NULL,NULL),(2,'Samsung Galaxy M12','Black, 4GB RAM, 64GB Storage 6000 mAh with 8nm Processor | True 48 MP Quad Camera | 90Hz Refresh Rate','<ul><li>48MP+5MP+2MP+2MP Quad camera setup- True 48MP (F 2.0) main camera + 5MP (F2.2) Ultra wide camera+ 2MP (F2.4) depth camera + 2MP (2.4) Macro Camera| 8MP (F2.2) front came</li><li>6000mAH lithium-ion battery, 1 year manufacturer warranty for device and 6 months manufacturer warranty for in-box accessories including batteries from the date of purchase</li><li>Android 11, v11.0 operating system,One UI 3.1, with 8nm Power Efficient Exynos850 (Octa Core 2.0GH</li><li>16.55 centimeters (6.5-inch) HD+ TFT LCD - infinity v-cut display,90Hz screen refresh rate, HD+ resolution with 720 x 1600 pixels resolution, 269 PPI with 16M color</li><li>Memory, Storage & SIM: 4GB RAM | 64GB internal memory expandable up to 1TB| Dual SIM (nano+nano) dual-standby (4G+4G)</li><ul>',136.81,'https://m.media-amazon.com/images/I/71r69Y7BSeL._AC_UY327_FMwebp_QL65_.jpg','mobile',3,12,'',NULL,NULL,NULL),(3,'Acer Aspire 5','Acer Aspire 5 A515-46-R14K Slim Laptop | 15.6 Full HD IPS | AMD Ryzen 3 3350U Quad-Core Mobile Processor | 4GB DDR4 | 128GB NVMe SSD | WiFi 6 | Backlit KB | Amazon Alexa | Windows 10 Home (S mode)\"','Powerful Productivity: AMD Ryzen 3 3350U delivers desktop-class performance and amazing battery life in a slim notebook. With Precision Boost, get up to 3.5GHz for your high-demand applications',399.99,'https://m.media-amazon.com/images/I/71+2H96GHZL._AC_SL1500_.jpg','laptop',3,69,'',NULL,NULL,NULL),(4,'ASUS Zenbook 13','ASUS ZenBook 13 Ultra-Slim Laptop, 13.3\" OLED FHD NanoEdge Bezel Display, Intel Core i7-1165G7, 8GB LPDDR4X RAM, 512GB SSD, NumberPad, Thunderbolt 4, Wi-Fi 6, Windows 10 Home, Pine Grey, UX325EA-ES71','13.3 inch OLED 400nits Full HD (1920 x 1080) Wide View 4-way NanoEdge bezel display',919.99,'https://m.media-amazon.com/images/I/81NbyNDC8eS._AC_SL1500_.jpg','laptop',3,0,'',NULL,NULL,NULL),(5,'HP Stream','HP Stream 11.6-inch HD Laptop, Intel Celeron N4000, 4 GB RAM, 32 GB eMMC, Windows 10 Home in S Mode with Office 365 Personal for 1 Year (11-ak0010nr, Royal Blue)','STUDY, STREAM, SHARE: Between home, school and work, you need a PC that won\'t quit. Post, play and stay productive all day with the affordable and portable HP Stream 11',233.48,'https://m.media-amazon.com/images/I/71idFa2cEuL._AC_SL1500_.jpg','laptop',3,0,'',NULL,NULL,NULL),(6,'HP Chromebook','HP Chromebook 14 Laptop, Dual-core Intel Celeron Processor N3350, 4 GB RAM, 32 GB eMMC Storage, 14-inch FHD IPS Display, Google Chrome OS, Dual Speakers and Audio by B&O (14-ca051nr, 2020)','FOR WORK AND PLAY - Expect a full day of productivity for work with a powerful dual-core processor, plenty of storage, and long-lasting battery life. Once the workday is done, dive into the perfect PC for your daily dose of entertainment with dual HP speakers, Audio by B&O, and a 180° hinge for comfortable viewing and easier collaboration with others.',289.00,'https://m.media-amazon.com/images/I/61EaSVhVe8L._AC_SL1500_.jpg','laptop',3,0,'',NULL,NULL,NULL),(7,'Lenovo Chromebook S330','Lenovo Chromebook S330 14in Laptop Computer, Mediatek MT8173C up to 1.7 Ghz, 4GB RAM, 32GB eMMC SSD, Bluetooth, HDMI, USB-C, SD Card Reader, Chrome OS, Black (Renewed)','This pre-owned product has been professionally inspected, tested and cleaned by Amazon-qualified suppliers.',169.00,'https://m.media-amazon.com/images/I/61BvlCvbRJL._AC_SL1500_.jpg','laptop',3,0,'',NULL,NULL,NULL),(8,'Dell Inspiron','2021 Dell Inspiron 15.6 FHD Touchscreen Laptop','Intel i5-1035G1(up to 3.6 GHz)|16GB RAM |1TB PCIe SSD |Online Meeting Ready|WebcamHDMI |Windows 10 S Black\"  |10th Generation Intel Core i5-1035G| Base 1.0GHz Up to 3.60GHz 4 cores 6MB Cache 8 Threads with Intel UHD Graphics. It can respond to your basic demands to the intensive ones and handles your tasks for each day',799.99,'https://m.media-amazon.com/images/I/618JrdYSvnL._AC_SL1500_.jpg','laptop',3,0,'',NULL,NULL,NULL),(9,'ASUS VivoBook F512','ASUS VivoBook F512 Thin and Lightweight Laptop, 15.6\" FHD WideView NanoEdge , AMD R5-3500U CPU, 8GB RAM, 128GB SSD + 1TB HDD, Backlit KB, Fingerprint Reader, Windows 10, Peacock Blue, F512DA-EB51','15.6 inch FHD 4 way NanoEdge bezel display with a stunning 88% screen-to-body ratio',519.99,'https://m.media-amazon.com/images/I/81fstJkUlaL._AC_SL1500_.jpg','laptop',3,0,'',NULL,NULL,NULL),(10,'Acer Predator Helios 300','Acer Predator Helios 300 PH315-54-760S Gaming Laptop | Intel i7-11800H | NVIDIA GeForce RTX 3060 Laptop GPU | 15.6 Full HD 144Hz 3ms IPS Display | 16GB DDR4 | 512GB SSD | Killer WiFi 6 | RGB Keyboard\"','Extreme Performance: Crush the competition with the impressive power and speed of the 11th Generation Intel Core i7-11800H processor, featuring 8 cores and 16 threads to divide and conquer any task or run your most intensive games',1230.68,'https://m.media-amazon.com/images/I/71Nly9vPapL._AC_SL1500_.jpg','laptop',3,0,'',NULL,NULL,NULL),(11,'MSI GE66 Raider','MSI GE66 Raider Gaming Laptop: 15.6 240Hz Display','Intel Core i7-10750H | NVIDIA GeForce RTX 2070 Super|32GB RAM|1TB NVMe SSD|Win10 |Black (10SFS-670)\"|Smooth Display: The 15.6\" 240Hz display delivers a high refresh rate for smooth and vibrant gameplay so you don\'t miss a frame of the game.',1773.99,'https://m.media-amazon.com/images/I/61mOsrtFjLL._AC_SL1200_.jpg','laptop',3,0,'',NULL,NULL,NULL),(12,'Razer Blade 14','Razer Blade 14 Gaming Laptop: AMD Ryzen 9 5900HX 8 Core, NVIDIA GeForce RTX 3070, 14 QHD 165Hz','16GB RAM | 1TB SSD - CNC Aluminum - Chroma RGB - THX Spatial Audio - Vapor Chamber Cooling\"| NVIDIA GeForce RTX 30 Series Graphics for Stunning Visuals: Built on NVIDIA?s award-winning 2nd-gen RTX architecture these GPUs provide the most realistic ray-traced graphics and cutting-edge AI features for the most powerful graphics in a gaming laptop',2199.99,'https://m.media-amazon.com/images/I/611VQf95rxL._AC_SL1500_.jpg','laptop',3,0,'',NULL,NULL,NULL),(13,'Apple iPhone 11 Pro Max','512GB, Space Gray - Unlocked (Renewed Premium)','<b>A like-new experience. Backed by a one-year satisfaction guarantee.</b><br><ul><li>This pre-owned product is not Apple certified, but has been professionally inspected, tested and cleaned by Amazon-qualified suppliers.</li><li>There will be no visible cosmetic imperfections when held at an arm?s length</li><li>This product will have a battery which exceeds 80% capacity relative to new</li><li> Accessories may not be original, but will be compatible and fully functional. Product may come in generic Box.</li><li> Product will come with a SIM removal tool, a charger and a charging cable. Headphones and SIM card are not included.</li><li> This product is eligible for a replacement or refund within 90 days of receipt if you are not satisfied under the Amazon Renewed Guarantee.</li></ul>',849.00,'https://m.media-amazon.com/images/I/81LmL94PUvS._AC_SL1500_.jpg','mobile',3,0,'',NULL,NULL,NULL),(16,'Oculus Quest 2','Advanced All-In-One Virtual Reality Headset — 128 GB','<ul>\r\n<li><span>\r\nNext-level Hardware - Make every move count with a blazing-fast processor and our highest-resolution display\r\n</span></li>\r\n<li><span>\r\nAll-In-One Gaming - With backward compatibility, you can explore new titles and old favorites in the expansive Quest content library\r\n</span></li>\r\n<li><span>\r\nImmersive Entertainment - Get the best seat in the house to live concerts, groundbreaking films, exclusive events and more\r\n</span></li>\r\n<li><span>\r\nEasy Setup - Just open the box, set up with the smartphone app and jump into VR. No PC or console needed. Requires wireless internet access and the Oculus app (free download) to set up device\r\n</span></li>\r\n<li><span>\r\nPremium Display - Catch every detail with a stunning display that features 50% more pixels than the original Quest\r\n</span></li>\r\n<li><span>\r\nUltimate Control - Redesigned Oculus Touch controllers transport your movements directly into VR with intuitive controls\r\n</span></li>\r\n<li><span>\r\nPC VR Compatible - Step into incredible Oculus Rift titles by connecting an Oculus Link cable to a compatible gaming PC. Oculus Link Cable sold separately\r\n</span></li>\r\n<li><span>\r\n3D Cinematic Sound - Hear in all directions with built-in speakers that deliver cinematic 3D positional audio\r\n</span></li>\r\n</ul>',299.00,'https://m.media-amazon.com/images/I/615YaAiA-ML._SL1500_.jpg','game',3,0,'https://m.media-amazon.com/images/I/710qhPDDwDL._SL1500_.jpg','https://m.media-amazon.com/images/I/81K73lRYB3L._SL1500_.jpg','',''),(22,'TEST','test','test',69.69,'https://lh3.googleusercontent.com/fife/AAWUweVhp4mAe196bLr7vYzdB8Zv-jgDwgPGJ933-NBX2sbOo8nMxHI2pFfB8_ZPLcmTlZWg2A7cnWZDiZbDQV2Mx538QyiYyeFB1wrPcifDizyGjn032oV3Ks9Wxpx0nl57sW9hZ6JUmOpkzGYEE1spyIPhspOD8gSlhwhXG7XpGRurhxS2c_L5nKa34ZxG7voWxMPHUgPeJ0YmyufkRjr6f0cnDXviV8mqRJCEVTwRy5ji-sFow0gYznnaXgO9B1Hc97SJlOYJuMIQfeEdpgsEjVu71LwoOlgnUiI0J_Dzn1SQ7mAnEUpxrl0XBJ36iP6HF_asB2LhK__cZVheK3ien1UJ05TIXrblplmLNx9G61xynXGUxqdq33peQt-H4ETwpSbREblUs-lfUo3qRntffUzllJP8eHfaOnqo34C7qOAnLfwaL_8a4Nf6sx-43RuUtW0pqeHvl2Ck1By3DRBrSInhyHy0MZIX0k3-4eNgiVMp4voyyfu1vEVmAKmT5ncilB8WWkzTuHtQZ9SDYu_00PNU56QPZ0c4XP2pcCXj9MIohUZuIDAcoSkFF2nFVMMCn7QHFSRfP8GCZ1Iko7de9fESuctt9n-0kTaey0-SRZzHvqDWqrCFgi5GQeV1NGCbcMzxAmZbU-n2IOk1aptVzcPvKwPfeVDTP0NTnSArBbVYbg6KZeBx7QRJ-QFKeFlQ0uiQRkmmcaW_TQKgvS1BtS2BG7SiKkN0fw=w1920-h942-ft','test',3,0,'https://lh3.googleusercontent.com/fife/AAWUweVhp4mAe196bLr7vYzdB8Zv-jgDwgPGJ933-NBX2sbOo8nMxHI2pFfB8_ZPLcmTlZWg2A7cnWZDiZbDQV2Mx538QyiYyeFB1wrPcifDizyGjn032oV3Ks9Wxpx0nl57sW9hZ6JUmOpkzGYEE1spyIPhspOD8gSlhwhXG7XpGRurhxS2c_L5nKa34ZxG7voWxMPHUgPeJ0YmyufkRjr6f0cnDXviV8mqRJCEVTwRy5ji-sFow0gYznnaXgO9B1Hc97SJlOYJuMIQfeEdpgsEjVu71LwoOlgnUiI0J_Dzn1SQ7mAnEUpxrl0XBJ36iP6HF_asB2LhK__cZVheK3ien1UJ05TIXrblplmLNx9G61xynXGUxqdq33peQt-H4ETwpSbREblUs-lfUo3qRntffUzllJP8eHfaOnqo34C7qOAnLfwaL_8a4Nf6sx-43RuUtW0pqeHvl2Ck1By3DRBrSInhyHy0MZIX0k3-4eNgiVMp4voyyfu1vEVmAKmT5ncilB8WWkzTuHtQZ9SDYu_00PNU56QPZ0c4XP2pcCXj9MIohUZuIDAcoSkFF2nFVMMCn7QHFSRfP8GCZ1Iko7de9fESuctt9n-0kTaey0-SRZzHvqDWqrCFgi5GQeV1NGCbcMzxAmZbU-n2IOk1aptVzcPvKwPfeVDTP0NTnSArBbVYbg6KZeBx7QRJ-QFKeFlQ0uiQRkmmcaW_TQKgvS1BtS2BG7SiKkN0fw=w1920-h942-ft','https://lh3.googleusercontent.com/fife/AAWUweVhp4mAe196bLr7vYzdB8Zv-jgDwgPGJ933-NBX2sbOo8nMxHI2pFfB8_ZPLcmTlZWg2A7cnWZDiZbDQV2Mx538QyiYyeFB1wrPcifDizyGjn032oV3Ks9Wxpx0nl57sW9hZ6JUmOpkzGYEE1spyIPhspOD8gSlhwhXG7XpGRurhxS2c_L5nKa34ZxG7voWxMPHUgPeJ0YmyufkRjr6f0cnDXviV8mqRJCEVTwRy5ji-sFow0gYznnaXgO9B1Hc97SJlOYJuMIQfeEdpgsEjVu71LwoOlgnUiI0J_Dzn1SQ7mAnEUpxrl0XBJ36iP6HF_asB2LhK__cZVheK3ien1UJ05TIXrblplmLNx9G61xynXGUxqdq33peQt-H4ETwpSbREblUs-lfUo3qRntffUzllJP8eHfaOnqo34C7qOAnLfwaL_8a4Nf6sx-43RuUtW0pqeHvl2Ck1By3DRBrSInhyHy0MZIX0k3-4eNgiVMp4voyyfu1vEVmAKmT5ncilB8WWkzTuHtQZ9SDYu_00PNU56QPZ0c4XP2pcCXj9MIohUZuIDAcoSkFF2nFVMMCn7QHFSRfP8GCZ1Iko7de9fESuctt9n-0kTaey0-SRZzHvqDWqrCFgi5GQeV1NGCbcMzxAmZbU-n2IOk1aptVzcPvKwPfeVDTP0NTnSArBbVYbg6KZeBx7QRJ-QFKeFlQ0uiQRkmmcaW_TQKgvS1BtS2BG7SiKkN0fw=w1920-h942-ft','https://lh3.googleusercontent.com/fife/AAWUweVhp4mAe196bLr7vYzdB8Zv-jgDwgPGJ933-NBX2sbOo8nMxHI2pFfB8_ZPLcmTlZWg2A7cnWZDiZbDQV2Mx538QyiYyeFB1wrPcifDizyGjn032oV3Ks9Wxpx0nl57sW9hZ6JUmOpkzGYEE1spyIPhspOD8gSlhwhXG7XpGRurhxS2c_L5nKa34ZxG7voWxMPHUgPeJ0YmyufkRjr6f0cnDXviV8mqRJCEVTwRy5ji-sFow0gYznnaXgO9B1Hc97SJlOYJuMIQfeEdpgsEjVu71LwoOlgnUiI0J_Dzn1SQ7mAnEUpxrl0XBJ36iP6HF_asB2LhK__cZVheK3ien1UJ05TIXrblplmLNx9G61xynXGUxqdq33peQt-H4ETwpSbREblUs-lfUo3qRntffUzllJP8eHfaOnqo34C7qOAnLfwaL_8a4Nf6sx-43RuUtW0pqeHvl2Ck1By3DRBrSInhyHy0MZIX0k3-4eNgiVMp4voyyfu1vEVmAKmT5ncilB8WWkzTuHtQZ9SDYu_00PNU56QPZ0c4XP2pcCXj9MIohUZuIDAcoSkFF2nFVMMCn7QHFSRfP8GCZ1Iko7de9fESuctt9n-0kTaey0-SRZzHvqDWqrCFgi5GQeV1NGCbcMzxAmZbU-n2IOk1aptVzcPvKwPfeVDTP0NTnSArBbVYbg6KZeBx7QRJ-QFKeFlQ0uiQRkmmcaW_TQKgvS1BtS2BG7SiKkN0fw=w1920-h942-ft','https://lh3.googleusercontent.com/fife/AAWUweVhp4mAe196bLr7vYzdB8Zv-jgDwgPGJ933-NBX2sbOo8nMxHI2pFfB8_ZPLcmTlZWg2A7cnWZDiZbDQV2Mx538QyiYyeFB1wrPcifDizyGjn032oV3Ks9Wxpx0nl57sW9hZ6JUmOpkzGYEE1spyIPhspOD8gSlhwhXG7XpGRurhxS2c_L5nKa34ZxG7voWxMPHUgPeJ0YmyufkRjr6f0cnDXviV8mqRJCEVTwRy5ji-sFow0gYznnaXgO9B1Hc97SJlOYJuMIQfeEdpgsEjVu71LwoOlgnUiI0J_Dzn1SQ7mAnEUpxrl0XBJ36iP6HF_asB2LhK__cZVheK3ien1UJ05TIXrblplmLNx9G61xynXGUxqdq33peQt-H4ETwpSbREblUs-lfUo3qRntffUzllJP8eHfaOnqo34C7qOAnLfwaL_8a4Nf6sx-43RuUtW0pqeHvl2Ck1By3DRBrSInhyHy0MZIX0k3-4eNgiVMp4voyyfu1vEVmAKmT5ncilB8WWkzTuHtQZ9SDYu_00PNU56QPZ0c4XP2pcCXj9MIohUZuIDAcoSkFF2nFVMMCn7QHFSRfP8GCZ1Iko7de9fESuctt9n-0kTaey0-SRZzHvqDWqrCFgi5GQeV1NGCbcMzxAmZbU-n2IOk1aptVzcPvKwPfeVDTP0NTnSArBbVYbg6KZeBx7QRJ-QFKeFlQ0uiQRkmmcaW_TQKgvS1BtS2BG7SiKkN0fw=w1920-h942-ft');
/*!40000 ALTER TABLE `store_product` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-08 15:03:13
