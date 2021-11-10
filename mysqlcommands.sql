-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: fcs_ecommerce
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (4,'admin'),(2,'buyer'),(3,'seller');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (2,4,2),(5,4,16),(8,4,31),(1,4,32),(3,4,40),(6,4,55),(7,4,56);
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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add new product request',7,'add_newproductrequest'),(26,'Can change new product request',7,'change_newproductrequest'),(27,'Can delete new product request',7,'delete_newproductrequest'),(28,'Can view new product request',7,'view_newproductrequest'),(29,'Can add product',8,'add_product'),(30,'Can change product',8,'change_product'),(31,'Can delete product',8,'delete_product'),(32,'Can view product',8,'view_product'),(33,'Can add Category',9,'add_category'),(34,'Can change Category',9,'change_category'),(35,'Can delete Category',9,'delete_category'),(36,'Can view Category',9,'view_category'),(37,'Can add transaction',10,'add_transaction'),(38,'Can change transaction',10,'change_transaction'),(39,'Can delete transaction',10,'delete_transaction'),(40,'Can view transaction',10,'view_transaction'),(41,'Can add seller request',11,'add_sellerrequest'),(42,'Can change seller request',11,'change_sellerrequest'),(43,'Can delete seller request',11,'delete_sellerrequest'),(44,'Can view seller request',11,'view_sellerrequest'),(45,'Can add user_ profile',12,'add_user_profile'),(46,'Can change user_ profile',12,'change_user_profile'),(47,'Can delete user_ profile',12,'delete_user_profile'),(48,'Can view user_ profile',12,'view_user_profile'),(49,'Can add logged in user',13,'add_loggedinuser'),(50,'Can change logged in user',13,'change_loggedinuser'),(51,'Can delete logged in user',13,'delete_loggedinuser'),(52,'Can view logged in user',13,'view_loggedinuser'),(53,'Can add unverified_ user',14,'add_unverified_user'),(54,'Can change unverified_ user',14,'change_unverified_user'),(55,'Can delete unverified_ user',14,'delete_unverified_user'),(56,'Can view unverified_ user',14,'view_unverified_user');
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (19,'pbkdf2_sha256$260000$lsv8tcs7vCwz4DQ6awRXa3$LiaEgJEHV2GwK8LNgEJIPHYfa0fxnwgHc32yzstLCh8=','2021-11-10 11:26:23.515052',0,'TEST_BUYER','TEST','BUYER','etash19360@iiitd.ac.in',1,1,'2021-11-09 21:02:12.000000'),(21,'pbkdf2_sha256$260000$m3OWo7x3pWpfRXqfQ5Bg4P$so8Y281fdHzFRsOQ52+0L5t6dSA203TrCJ9HJ+54i0I=','2021-11-10 08:43:14.028447',1,'etash','','','etash18@gmail.com',1,1,'2021-11-10 05:57:05.000000'),(22,'pbkdf2_sha256$260000$Ts75wJe9o37XMRCgP9ivA9$VuQP1p/6RvBJwefhZJq/kst6cuAvEJymroV3Cgkdqto=',NULL,0,'TEST_UNVERIFIED','adsadasd','sadadad','asdasdadasd@adsa.a',0,1,'2021-11-10 10:34:05.480604');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (11,19,4),(14,21,3),(13,21,4);
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
-- Table structure for table `authentication_unverified_user`
--

DROP TABLE IF EXISTS `authentication_unverified_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authentication_unverified_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `auth_token` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `Authentication_user_profile_user_id_48841f7c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authentication_unverified_user`
--

LOCK TABLES `authentication_unverified_user` WRITE;
/*!40000 ALTER TABLE `authentication_unverified_user` DISABLE KEYS */;
INSERT INTO `authentication_unverified_user` VALUES (19,'086c834d-aa3b-452a-8389-72cfa0fd00da','2021-11-10 10:34:05.655897',22);
/*!40000 ALTER TABLE `authentication_unverified_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `user_id` int NOT NULL,
  `product_id` varchar(100) NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`user_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `store_product` (`stripe_prod_id`) ON DELETE CASCADE,
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
  `seller_id` int DEFAULT NULL,
  `item_id` varchar(100) DEFAULT NULL,
  `buyer_id` int DEFAULT NULL,
  `price` decimal(13,2) NOT NULL,
  `stripe_transaction_id` varchar(100) NOT NULL,
  `status` varchar(200) NOT NULL,
  PRIMARY KEY (`stripe_transaction_id`),
  KEY `purchases_ibfk_1` (`buyer_id`),
  KEY `purchases_ibfk_3` (`seller_id`),
  KEY `item_id_fk` (`item_id`),
  CONSTRAINT `item_id_fk` FOREIGN KEY (`item_id`) REFERENCES `store_product` (`stripe_prod_id`) ON DELETE SET NULL,
  CONSTRAINT `purchases_ibfk_1` FOREIGN KEY (`buyer_id`) REFERENCES `auth_user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `purchases_ibfk_3` FOREIGN KEY (`seller_id`) REFERENCES `auth_user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_transaction`
--

LOCK TABLES `cart_transaction` WRITE;
/*!40000 ALTER TABLE `cart_transaction` DISABLE KEYS */;
INSERT INTO `cart_transaction` VALUES (21,'prod_KYec7zgGZxuMHa',19,74990.00,'cs_test_a11YsqIdRIIHIGp94mB1Y6DlJpxR7xnHcR3RFwOQoTpAUVN0r31YYwOK6R','Successful'),(21,'prod_KYec7zgGZxuMHa',21,74990.00,'cs_test_a1LLDasS89lB4lZFfb4gtbcpFwai18FKNOtUDjw2Pf6kL5ClLO9M7I46M6','Failed'),(21,'prod_KYec7zgGZxuMHa',19,74990.00,'cs_test_a1pdg5VejnHqhOBDpwzlUGzbBDtxa9bB04ulNt7ATWRZCP5Rbp3zdsgRsV','Failed'),(21,'prod_KYec7zgGZxuMHa',19,74990.00,'cs_test_a1TcaN8YYczFrUXY1kPwkCqoUSTeZdeJnrQt2JLmRTyvvYIcVFUZExhqxW','Failed'),(21,'prod_KYec7zgGZxuMHa',21,74990.00,'cs_test_a1wlk6OWzR4LJPPawLygXb2yGoEXVWzYh66pxqGnFVzLuUFrG38ioc5Y5m','Successful');
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
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (83,'2021-11-10 05:51:22.852824','3','etash',3,'',4,19),(84,'2021-11-10 05:56:29.006179','20','etash',3,'',4,19),(85,'2021-11-10 06:00:07.650344','4','admin',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,21),(86,'2021-11-10 06:01:54.264435','21','etash',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,21);
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(14,'Authentication','unverified_user'),(12,'Authentication','user_profile'),(10,'Cart','transaction'),(5,'contenttypes','contenttype'),(13,'Main','loggedinuser'),(7,'Sell','newproductrequest'),(11,'Sell','sellerrequest'),(6,'sessions','session'),(9,'Store','category'),(8,'Store','product');
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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'Sell','0001_initial','2021-11-06 17:17:55.060045'),(2,'Store','0001_initial','2021-11-06 17:17:55.103691'),(3,'contenttypes','0001_initial','2021-11-06 17:17:55.170554'),(4,'auth','0001_initial','2021-11-06 17:17:56.085102'),(5,'admin','0001_initial','2021-11-06 17:17:56.386131'),(6,'admin','0002_logentry_remove_auto_add','2021-11-06 17:17:56.396435'),(7,'admin','0003_logentry_add_action_flag_choices','2021-11-06 17:17:56.406692'),(8,'contenttypes','0002_remove_content_type_name','2021-11-06 17:17:56.547594'),(9,'auth','0002_alter_permission_name_max_length','2021-11-06 17:17:56.634166'),(10,'auth','0003_alter_user_email_max_length','2021-11-06 17:17:56.683386'),(11,'auth','0004_alter_user_username_opts','2021-11-06 17:17:56.693525'),(12,'auth','0005_alter_user_last_login_null','2021-11-06 17:17:56.759798'),(13,'auth','0006_require_contenttypes_0002','2021-11-06 17:17:56.764629'),(14,'auth','0007_alter_validators_add_error_messages','2021-11-06 17:17:56.775699'),(15,'auth','0008_alter_user_username_max_length','2021-11-06 17:17:56.875390'),(16,'auth','0009_alter_user_last_name_max_length','2021-11-06 17:17:57.209941'),(17,'auth','0010_alter_group_name_max_length','2021-11-06 17:17:57.269423'),(18,'auth','0011_update_proxy_permissions','2021-11-06 17:17:57.286085'),(19,'auth','0012_alter_user_first_name_max_length','2021-11-06 17:17:57.443750'),(20,'sessions','0001_initial','2021-11-06 17:17:57.558490'),(21,'Store','0002_remove_product_quantity','2021-11-06 17:21:39.314106'),(22,'Sell','0002_remove_newproductrequest_quantity','2021-11-06 17:35:33.739515'),(23,'Store','0003_category','2021-11-06 17:51:16.860816'),(24,'Store','0004_auto_20211106_2332','2021-11-06 18:02:05.116456'),(25,'Sell','0003_newproductrequest_category','2021-11-06 20:37:21.010686'),(26,'Store','0005_product_seller_uid','2021-11-07 08:12:46.557742'),(27,'Sell','0004_auto_20211107_1424','2021-11-07 09:12:07.811109'),(28,'Sell','0005_auto_20211107_1442','2021-11-07 09:12:08.052946'),(29,'Sell','0006_remove_newproductrequest_pdf_name','2021-11-07 10:07:37.559857'),(30,'Store','0006_auto_20211107_1537','2021-11-07 10:07:37.726727'),(32,'Cart','0002_auto_20211107_2019','2021-11-07 14:49:27.946616'),(33,'Cart','0003_remove_transaction_quantity','2021-11-07 16:05:52.759197'),(34,'Sell','0007_sellerrequest','2021-11-07 18:10:07.342428'),(35,'Sell','0008_newproductrequest_message','2021-11-07 18:49:32.036684'),(36,'Store','0007_auto_20211108_1549','2021-11-08 10:19:52.747647'),(37,'Store','0008_auto_20211108_1614','2021-11-08 10:45:38.665949'),(38,'Store','0009_auto_20211108_1642','2021-11-08 11:13:18.852099'),(39,'Cart','0004_auto_20211109_0243','2021-11-08 21:14:23.321307'),(40,'Cart','0005_transaction_status','2021-11-08 21:15:43.434058'),(41,'Authentication','0001_initial','2021-11-09 09:27:53.466831'),(42,'Main','0001_initial','2021-11-09 13:24:06.603508'),(43,'Cart','0001_initial','2021-11-10 05:04:32.873170'),(44,'Cart','0002_alter_transaction_item_id','2021-11-10 06:56:45.162747');
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
INSERT INTO `django_session` VALUES ('43zees2zftnfwggwq3zn313smpv06x40','eyJyZWRpcmVjdF9mcm9tX3NpZ251cCI6dHJ1ZX0:1mkY9v:ITVYpnnt-o5bB3UutLrKOdllPzKx5vE_6sbGvBZRy1g','2021-11-23 20:55:59.752284'),('6v8bzcjmjarl2ae5shxb4qwgzbmenqof','.eJxVjDsOwyAQBe9CHSHEx0DK9DkDWnbXwUkEkrErK3ePLblI2jczbxMJ1qWktfOcJhJXYcTld8uAL64HoCfUR5PY6jJPWR6KPGmX90b8vp3u30GBXvZaURx9gOg8BeusDhkVeWY7BE04eDScKYA1BKMKGjNH9gh6r9CxjuLzBfOJOLU:1mkQY0:p-llTGwZAAay3-b5Q2E0rDzc71bezxwbAuY2QvFuJS8','2021-11-23 12:48:20.319470'),('6yooiqfx09eemdlkatxujwsn0y83xla6','e30:1mkQIs:BzC82PcnLGAHDAvTH9JbWYIJ9gNQTdVakSfYRgCSAas','2021-11-23 12:32:42.872884'),('82zjlvjjgrpi3kwdd88o1wp01wa0934w','.eJxVjDkOwjAUBe_iGlnfa2JKes5g2X8hAZRIcVIh7g6RUkD7Zua9VC7bOuSt8ZJHUmcV1Ol3qwUfPO2A7mW6zRrnaV3GqndFH7Tp60z8vBzu38FQ2vCtDQNEF1JMDgVMAQBhpBo8-kAVvDhnO-wcSEzkhaU32PVWrCeInNT7A9L5N58:1mjjut:peode9ifIZ1UEuf1hbXi9NLUPUmRRYZNCJIcHH1SRGs','2021-11-21 15:17:07.344780'),('8p4cjcbyoe5jpmcavfl3xxhnoyk4q7cj','e30:1mjxQu:-_q1TJ1CWHjYSH55ODwcpEk1uGUJO1qu4n0m7B9YRFs','2021-11-22 05:43:04.642971'),('cptvifuk1oz7klgidxkk3tfpicrk6gll','eyJyZWRpcmVjdF9mcm9tX3NpZ251cCI6dHJ1ZX0:1mkYCL:_oDfKX6USBZm0NqlIRyLx6AhLX1ZWibCcqROkg6QQqg','2021-11-23 20:58:29.702252'),('ctqedhgtghdhu54n7dyfnwwpfxsqr59g','eyJvdHBfdXNlcl9pZCI6Mywib3RwX2tleSI6IjIwMjEtMTEtMTA3TDdZTUlIRkc0In0:1mkXve:_mCrYEnmDG2R8JCw_x6wbbIIeWZhCAAByP-UbRL2VDE','2021-11-23 20:41:14.234568'),('d2wccunw2f3evofezre331685y4rw2gz','eyJsb2dpbl90b19jb250aW51ZV90byI6Ii9wcm9maWxlLyJ9:1mklkJ:UElr7ephLMuNhil-mxP6UhcH8q9z7FTsVaLHUHFV5iM','2021-11-24 11:26:27.420889'),('eksb19mf2d4qacg1hnsh1u2d4i052812','.eJxVjDsOwyAQBe9CHSHEx0DK9DkDWnbXwUkEkrErK3ePLblI2jczbxMJ1qWktfOcJhJXYcTld8uAL64HoCfUR5PY6jJPWR6KPGmX90b8vp3u30GBXvZaURx9gOg8BeusDhkVeWY7BE04eDScKYA1BKMKGjNH9gh6r9CxjuLzBfOJOLU:1mkQZi:-egewodvC-V5eji7PqP--WNsetPoE6jWVnNR3ArO1a0','2021-11-23 12:50:06.568162'),('fd37nxc3dap9yv17ul6b16lcu1i6qua7','.eJxVjDsOwyAQBe9CHSHEx0DK9DkDWnbXwUkEkrErK3ePLblI2jczbxMJ1qWktfOcJhJXYcTld8uAL64HoCfUR5PY6jJPWR6KPGmX90b8vp3u30GBXvZaURx9gOg8BeusDhkVeWY7BE04eDScKYA1BKMKGjNH9gh6r9CxjuLzBfOJOLU:1mkPb4:O5WJ2-OVke_3ZSwsXR85elHv65r6XMyqf_PBaoP9eH8','2021-11-23 11:47:26.078279'),('hl989vfv9vfhq2q0glsic4j3y7na7beg','eyJvdHBfdXNlcl9pZCI6Mywib3RwX2tleSI6IjIwMjEtMTEtMTA3TDdZTUlIRkc0In0:1mkXuS:T-Ln9IU-IPRGvk93MosO9eKP2sK3Yg1vtUxPyW5k2Z8','2021-11-23 20:40:00.663504'),('jqc3q83a5lmlmzrgik4t8hqkej36yvc7','.eJxVjDsOwyAQBe9CHSHEx0DK9DkDWnbXwUkEkrErK3ePLblI2jczbxMJ1qWktfOcJhJXYcTld8uAL64HoCfUR5PY6jJPWR6KPGmX90b8vp3u30GBXvZaURx9gOg8BeusDhkVeWY7BE04eDScKYA1BKMKGjNH9gh6r9CxjuLzBfOJOLU:1mjdsw:d8DQmfrUIEsOMa77AOAO1ODxxGrXTUOZIQmKfzqobdQ','2021-11-21 08:50:42.535855'),('kg6cipscu0kwo08xezols14l2sl08on3','e30:1mjQlF:XAIIqM1BwflVt8wNKmiWsaWUK38J5OQp-YZDuXeEKIw','2021-11-20 18:49:53.414199'),('l2gu82elubr2lonjmixo254qr9l3kxwz','.eJxVjDsOwyAQBe9CHSHEx0DK9DkDWnbXwUkEkrErK3ePLblI2jczbxMJ1qWktfOcJhJXYcTld8uAL64HoCfUR5PY6jJPWR6KPGmX90b8vp3u30GBXvZaURx9gOg8BeusDhkVeWY7BE04eDScKYA1BKMKGjNH9gh6r9CxjuLzBfOJOLU:1mjRug:pEmIInz1QtHQZbLZPGQQQpwCfyWgTYGcF9w-qe37PaY','2021-11-20 20:03:42.363556'),('m0680jhqbdwx9ugwhag23ynx7841biqb','eyJyZWRpcmVjdF9mcm9tX3NpZ251cCI6dHJ1ZX0:1mkYC9:JJcSOZZFFswUX8y6frSG1JQyG2-hFNnXoXJm6REAlb0','2021-11-23 20:58:17.677067'),('q2232e4ifcdwu14ns21bns99bgmw2r1t','.eJxVjL1uwjAYRd_FcxX536RjQRmQaGkG1LJY9mc7DgFHYAe1Qn33BomhXe8599yQNlOJesr-onuHnpFAT383a2Dw6Q7cwaRurGBM5dLb6q5UD5qrzej88eXh_gtEk-P8Jh5jyUQtawYBE4MxDh6cFRy4cBbzwBhVoBgOsnY8-LAgoBY0UO6w9PUchehh6FOnx6nMRci6-Fy0Iexq22kllo3cdvtm037GbWea3fV9n8o5EXqgw_njpPKXAiK_3Xp1VG-2ja_o5xfbY1RH:1mkCwi:23dw9YKSK4QH707Mlz0R-NmfaLEB-jq-jF00xRlU5fA','2021-11-22 22:16:56.905523'),('rebdna7hgx1hhm8nci9ikbf9k8mgdxej','.eJxVjDsOwyAQBe9CHSHEx0DK9DkDWnbXwUkEkrErK3ePLblI2jczbxMJ1qWktfOcJhJXYcTld8uAL64HoCfUR5PY6jJPWR6KPGmX90b8vp3u30GBXvZaURx9gOg8BeusDhkVeWY7BE04eDScKYA1BKMKGjNH9gh6r9CxjuLzBfOJOLU:1mkQaq:GOCmG2P_4VzHsUpzhPLibo0v-P7zM0-tNch1jtijnpE','2021-11-23 12:51:16.058572'),('sqi9p3bi1cus14pratz9fts81rw9nsq0','.eJxVjDsOwjAQBe_iGln-J0tJzxmsXa-NA8iR4qRC3B0ipYD2zcx7iYjbWuPW8xInFmehQZx-R8L0yG0nfMd2m2Wa27pMJHdFHrTL68z5eTncv4OKvX5rg5odjjkYNZCyCRkcZQ9YjKXBFgMEDEXzaDFZsMEXjUlpCpR8KU68PxxLOME:1mklve:0S1k2aBYc_Nht2ZUJfrQjIFCN_tjs5GqnLF2z580lU8','2021-11-24 11:38:10.137449'),('xo82j5uwpeyscijz6lb1e21gik0q8wab','.eJxVjDsOwyAQBe9CHSHEx0DK9DkDWnbXwUkEkrErK3ePLblI2jczbxMJ1qWktfOcJhJXYcTld8uAL64HoCfUR5PY6jJPWR6KPGmX90b8vp3u30GBXvZaURx9gOg8BeusDhkVeWY7BE04eDScKYA1BKMKGjNH9gh6r9CxjuLzBfOJOLU:1mk2lF:Nm4Ulo33FA7OWK93ivjMQ3V8Ig651YcI3248dykJsFM','2021-11-22 11:24:25.586845'),('yh06weo4nlcaq0n77n8biok5xt6rl4z7','eyJyZWRpcmVjdF9mcm9tX3NpZ251cCI6dHJ1ZX0:1mkYCs:F5LXoExK_Dj8GV1480DgA4uZrI084LdWmc0vviAcH9A','2021-11-23 20:59:02.598473');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_loggedinuser`
--

DROP TABLE IF EXISTS `main_loggedinuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_loggedinuser` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `session_key` varchar(32) DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `Main_loggedinuser_user_id_31a80d92_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_loggedinuser`
--

LOCK TABLES `main_loggedinuser` WRITE;
/*!40000 ALTER TABLE `main_loggedinuser` DISABLE KEYS */;
INSERT INTO `main_loggedinuser` VALUES (28,'sqi9p3bi1cus14pratz9fts81rw9nsq0',19);
/*!40000 ALTER TABLE `main_loggedinuser` ENABLE KEYS */;
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
INSERT INTO `phone_numbers` VALUES (19,'4456454545'),(22,'9999999999');
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
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sell_sellerrequest`
--

LOCK TABLES `sell_sellerrequest` WRITE;
/*!40000 ALTER TABLE `sell_sellerrequest` DISABLE KEYS */;
/*!40000 ALTER TABLE `sell_sellerrequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_product`
--

DROP TABLE IF EXISTS `store_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_product` (
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
  `stripe_price_id` varchar(100) NOT NULL,
  `stripe_prod_id` varchar(100) NOT NULL,
  PRIMARY KEY (`stripe_prod_id`),
  UNIQUE KEY `Store_product_stripe_prod_id_a8cdef85_uniq` (`stripe_prod_id`),
  KEY `fk_seller_prod_id` (`seller_uid`),
  CONSTRAINT `fk_seller_prod_id` FOREIGN KEY (`seller_uid`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_product`
--

LOCK TABLES `store_product` WRITE;
/*!40000 ALTER TABLE `store_product` DISABLE KEYS */;
INSERT INTO `store_product` VALUES ('MSI GF75 Thin','Intel i7-10750H, 17.3\" FHD IPS-Level 144Hz Panel Laptop (8GB/512GB NVMe SSD/Windows 10 Home/Nvidia GTX1650 4GB GDDR6/Black/2.2Kg), 10SC-087IN (9S7-17F612-087)','<ul>\r\n\r\n\r\n<li><span >\r\nProcessor: 10th Generation Intel Core i7-10750H Up To 5 GHz\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nOperating System: Pre-loaded Windows 10 Home with lifetime validity |Preinstalled Software: MSI BurnRecovery, MSI Battery Calibration, MSI Help Desk, Norton Internet Security (trail 60days) Norton Studio (Metro) (permanent free), Nvidia GeForce Experience, Nahimic 3, Dragon Center | In the box: Laptop, adapter\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nDisplay: 17.3\" FHD (1920*1080), IPS-Level 144Hz Thin Bezel, 45% NTSC\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nMemory &amp; Storage: 8 GB DDR4 3200MHz RAM, expandable to 64 GB | Storage: 512GB NVMe SSD.\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nNVIDIA GeForce GTX1650 GDDR6 4GB Dedicated Graphics\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nUltra Thin and light design | Laptop weight: 2.2 kg\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nKeyboard: Steelseries RED Backlit Keyboard | Camera: HD type (30fps@720p) | Microphone: Built-in microphone\r\n\r\n</span></li>\r\n\r\n</ul>',74990.00,'https://m.media-amazon.com/images/I/81lxm4dFfvL._SL1500_.jpg','laptop',21,82,'https://m.media-amazon.com/images/I/71cJDQBMnRS._SL1500_.jpg','https://m.media-amazon.com/images/I/61gmDdw2ukS._SL1500_.jpg','https://m.media-amazon.com/images/I/71lacyuYBhL._SL1500_.jpg','https://m.media-amazon.com/images/I/714mnz+UUYL._SL1500_.jpg','price_1JtXJ8SBGHFum3RMMg9FBbf0','prod_KYec7zgGZxuMHa'),('Victus by HP','Ryzen 5 5600H 16.1-inch(40.9 cm) FHD Gaming Laptop (8GB RAM/512GB SSD/4GB GTX 1650 Graphics/B&O Audio/Flicker Free Display/Windows 10/MS Office/2.48 Kg), 16-e0075AX','<ul>\r\n\r\n\r\n<li><span >\r\nProcessor: 5th Gen AMD Ryzen 5 5600H (3.3GHz base clock speed, up to 4.2 GHz Max Boost Clock, 16MB L3 cache, 6 core, 12 threads)\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nMemory &amp; Storage: 8 GB DDR4-3200 MHz RAM, Up to 32 GB DDR4-3200 SDRAM (2 x 16 GB) | Storage: 512 GB PCIe NVMe TLC M.2 SSD\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nDisplay: 40.9 cm (16.1\") diagonal, FHD (1920 x 1080), 60 Hz Refresh Rate, IPS, edge-to-edge, micro-edge, 250 nits, 137 ppi, Color Gamut: 45% NTSC\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nGraphics &amp; Networking: NVIDIA GeForce GTX 1650 (4 GB GDDR6 dedicated) | Realtek Wi-Fi 6 (2x2) and Bluetooth 5.2 combo (Supporting Gigabit data rate), MU-MIMO supported, Miracast Compatible\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nOperating System &amp; Software: Pre-loaded Windows 10 Home with lifetime validity, Free upgrade to Windows 11* when available(Refer Microsoft Website) | Pre-installed Microsoft Office Home &amp; Student 2019 | Alexa Built-in\r\n\r\n</span></li>\r\n\r\n</ul>',64990.00,'https://m.media-amazon.com/images/I/71h7F81EBoS._SL1500_.jpg','laptop',21,0,'https://m.media-amazon.com/images/I/51Wc0UVRo2L._SL1080_.jpg','https://m.media-amazon.com/images/I/61C5cnVRGZL._SL1080_.jpg','https://m.media-amazon.com/images/I/61PaWn1pq4L._SL1080_.jpg','','price_1JtXJ2SBGHFum3RMAIfNW8nG','prod_KYecfikDlgVoJ7'),('MSI Bravo 15','Ryzen 7 5800H, 15.6\" FHD IPS-Level 144Hz Panel Laptop (16GB/512GB NVMe SSD/Windows 10 Home/RX5500M, GDDR6 4GB/Black/2.35Kg), B5DD-077IN (Bravo 15 B5DD-077IN)','<ul>\r\n\r\n\r\n<li><span >\r\nProcessor: AMD Ryzen 7 5800H Up To 4.4 GHz\r\n\r\n</span></li>\r\n\r\n<li><span >\r\n\"Operating System: Pre-loaded Windows 10 Home with lifetime validity |Preinstalled Software: MSI BurnRecovery, MSI Battery Calibration, MSI Help Desk, Norton Internet Security (trail 60days) Norton Studio (Metro) (permanent free), Nvidia GeForce Experience, Nahimic 3, Dragon Center | In the box: Laptop, adapter\"\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nDisplay: 15.6\" FHD (1920*1080), IPS-Level 144Hz Thin Bezel, 45% NTSC\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nMemory &amp; Storage: 8 GB x2 DDR4 3200MHz RAM, expandable to 64 GB | Storage: 512GB NVMe SSD.\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nAMD Radeon RX5500M, GDDR6 4GB GDDR6 Dedicated Graphics\r\n\r\n</span></li>\r\n\r\n<li><span >\r\n\"Thin and light design | Laptop weight: 2.35 kg \"\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nKeyboard: Steelseries RED Backlit Keyboard | Camera: HD type (30fps@720p) | Microphone: Built-in microphone\r\n\r\n</span></li>\r\n\r\n</ul>',80990.00,'https://m.media-amazon.com/images/I/61T337xQtsS._SL1500_.jpg','laptop',21,0,'https://m.media-amazon.com/images/I/71SiBWl5gMS._SL1500_.jpg','https://m.media-amazon.com/images/I/61QNOJpmHyS._SL1500_.jpg','https://m.media-amazon.com/images/I/61jSvQ4C3CS._SL1500_.jpg','','price_1JtXJ6SBGHFum3RMS6UoiDw3','prod_KYecOl2IXjTEgH'),('HP Pavilion Gaming','10th Gen Intel Core i5 15.6-inch (39.6 cms) FHD Gaming Laptop (8GB/256GB SSD + 1TB HDD/144Hz/GTX 1650Ti 4GB Graphics/Windows 10/MS Office/2.28 kg), 15-dk1514TX, Black','<ul>\r\n\r\n\r\n<li><span >\r\nProcessor: 10th Gen Intel Core i5-10300H (2.5 GHz base frequency, up to 4.5 GHz with Intel Turbo Boost Technology, 8 MB L3 cache, 4 cores)\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nMemory &amp; Storage: 8 GB DDR4-2933 MHz RAM (1 x 8 GB), upgradable upto 32 GB(2x16GB)| Storage: 256 GB PCIe NVMe M.2 SSD + 1 TB 7200 rpm SATA HDD\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nGraphics: NVIDIA GeForce GTX 1650 Ti (4 GB GDDR6 dedicated) | Keyboard: Ultra Violet backlit keyboard\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nDisplay: 39.6 cm (15.6\") diagonal, FHD (1920 x 1080), IPS, micro-edge, anti-glare, 250 nits, 45% NTSC | Refresh rate: 144 Hz\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nOperating System &amp; Preinstalled Software: Pre-loaded Windows 10 Home with lifetime validity, FREE Upgrade to Windows 11* (when available, refer product description for more details) | Microsoft Office Home &amp; Student 2019\r\n\r\n</span></li>\r\n\r\n</ul>',69990.00,'https://m.media-amazon.com/images/I/611VHOvjkES._SL1080_.jpg','laptop',21,7,'https://m.media-amazon.com/images/I/61P+NkvytJS._SL1080_.jpg','','','','price_1JtXJ4SBGHFum3RMjzuw9hz2','prod_KYecvTijJIZXQd'),('MSI Modern 15','Ryzen 7 5700U, 15.6\" FHD IPS-Level 60Hz Panel Laptop (8GB/512GB NVMe SSD/Windows 10 Home/Carbon Grey/1.6Kg), A5M-066IN (Modern 15 A5M-066IN)','<ul>\r\n\r\n\r\n<li><span >\r\nProcessor: AMD Ryzen 7 5700U Up To 4.3 GHz\r\n\r\n</span></li>\r\n\r\n<li><span >\r\n\"Operating System: Pre-loaded Windows 10 Home with lifetime validity |Preinstalled Software: MSI BurnRecovery, MSI Battery Calibration, MSI Help Desk, Norton Internet Security (trail 60days) Norton Studio (Metro) (permanent free), Nvidia GeForce Experience, Nahimic 3, Dragon Center | In the box: Laptop, adapter\"\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nDisplay: 15.6\" FHD (1920*1080), IPS-Level 60Hz Thin Bezel, 45% NTSC\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nMemory &amp; Storage: 8 GB DDR4 3200MHz RAM, expandable to 64 GB | Storage: 512GB NVMe SSD.\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nAMD Radeon Integrated Graphics\r\n\r\n</span></li>\r\n\r\n<li><span >\r\n\"Thin and light design | Laptop weight: 1.6 kg \"\r\n\r\n</span></li>\r\n\r\n<li><span >\r\nKeyboard: Steelseries White Backlit Keyboard | Camera: HD type (30fps@720p) | Microphone: Built-in microphone\r\n\r\n</span></li>\r\n\r\n</ul>',62990.00,'https://m.media-amazon.com/images/I/61gziYVHJHL._SL1500_.jpg','laptop',21,1,'https://m.media-amazon.com/images/I/71NTHhZaeBL._SL1500_.jpg','https://m.media-amazon.com/images/I/61Wos1LPepL._SL1500_.jpg','','','price_1JtXJ7SBGHFum3RMogER7NcB','prod_KYecZ3Dcql1Fpz'),('I KALL Z5','3GB RAM | 16GB Storage | Blue','<ul >\r\n<li><span >\r\n8MP Rear Camera | 5MP Front Camera | Made in India, This phone has single rear camera and single front camera\r\n</span></li>\r\n<li><span >\r\n13.97 cm (5.5 inch) Display | multi-touch capacitive touch screen with 480x960 pixel resolution\r\n</span></li>\r\n<li><span >\r\n3GB ram, 16GB storage | Expandable Memory 64GB | Dual Sim | 4G Volte\r\n</span></li>\r\n<li><span >\r\nAndroid 10.0 with 1.3 Ghz Quad Core\r\n</span></li>\r\n<li><span >\r\n1 Year warranty for mobile and 6 Months for box accessories\r\n</span></li>\r\n</ul>',4985.00,'https://m.media-amazon.com/images/I/41+uQUoMp3L.jpg','mobile',21,1,'https://m.media-amazon.com/images/I/41mvSGlJOeL.jpg','https://m.media-amazon.com/images/I/316XFuTQJBL.jpg','https://m.media-amazon.com/images/I/314uIqrgFQL._SL1028_.jpg','','price_1JtX6YSBGHFum3RMIt8bqS9K','prod_KYePHb53PWjnGz'),('OPPO A74 5G','(Fluid Black,6GB RAM,128GB Storage) - 5G Android Smartphone | 5000 mAh Battery | 18W Fast Charge | 90Hz LCD Display','<ul>\r\n<li><span >\r\n6.49\" Inch (16.5cm) FHD+ Punch-hole Display with 2400x1080 pixels. Larger screen to body ratio of 90.5%.|Side Fingerprint Sensor.\r\n</span></li>\r\n<li><span >\r\nQualcomm Snapdragon 480 5G GPU 619 at 650 MHz Support 5G sim| Powerful 2 GHz Octa-core processor, support LPDDR4X memory and latest UFS 2.1 gear 3 storage\r\n</span></li>\r\n<li><span >\r\n5000 mAh lithium polymer battery\r\n</span></li>\r\n<li><span >\r\n48MP Quad Camera ( 48MP Main + 2MP Macro + 2MP Depth Lens) | 8MP Front Camera.\r\n</span></li>\r\n<li><span >\r\nMemory, Storage &amp; SIM: 6GB RAM | 128GB internal memory expandable up to 256GB | Dual SIM (nano+nano) dual-standby (5G+5G).| Color OS 11.1 based on Android v11.0 operating system.\r\n</span></li>\r\n<li><span >\r\nConnector type: USB Type C\r\n</span></li>\r\n</ul>',17990.00,'https://m.media-amazon.com/images/I/71poFSdDs5S._SL1500_.jpg','mobile',21,1,'https://m.media-amazon.com/images/I/71HPh61CS7S._SL1500_.jpg','https://m.media-amazon.com/images/I/714e4fXkQgL._SL1500_.jpg','https://m.media-amazon.com/images/I/61Stq2BWuBS._SL1500_.jpg','','price_1JtX6dSBGHFum3RMrMnT0Eci','prod_KYePPHZgmdbl8A'),('Samsung Galaxy M12','(Blue,4GB RAM, 64GB Storage) 6000 mAh with 8nm Processor | True 48 MP Quad Camera | 90Hz Refresh Rate','<ul>\r\n<li><span >\r\n48MP+5MP+2MP+2MP Quad camera setup- True 48MP (F 2.0) main camera + 5MP (F2.2) Ultra wide camera+ 2MP (F2.4) depth camera + 2MP (2.4) Macro Camera| 8MP (F2.2) front came\r\n</span></li>\r\n<li><span >\r\n6000mAH lithium-ion battery, 1 year manufacturer warranty for device and 6 months manufacturer warranty for in-box accessories including batteries from the date of purchase\r\n</span></li>\r\n<li><span >\r\nAndroid 11, v11.0 operating system,One UI 3.1, with 8nm Power Efficient Exynos850 (Octa Core 2.0GH\r\n</span></li>\r\n<li><span >\r\n16.55 centimeters (6.5-inch) HD+ TFT LCD - infinity v-cut display,90Hz screen refresh rate, HD+ resolution with 720 x 1600 pixels resolution, 269 PPI with 16M color\r\n</span></li>\r\n<li><span >\r\nMemory, Storage &amp; SIM: 4GB RAM | 64GB internal memory expandable up to 1TB| Dual SIM (nano+nano) dual-standby (4G+4\r\n</span></li>\r\n</ul>',11499.00,'https://m.media-amazon.com/images/I/71r69Y7BSeL._SL1500_.jpg','mobile',21,1,'https://m.media-amazon.com/images/I/61OvJLa3M8S._SL1040_.jpg','','','','price_1JtX6bSBGHFum3RMv3KKROt3','prod_KYePPvAsxAmWaT'),('Redmi 9A','(Nature Green, 2GB RAM, 32GB Storage) | 2GHz Octa-core Helio G25 Processor | 5000 mAh Battery','<ul>\r\n<li><span >\r\nCountry Of Origin - India\r\n</span></li>\r\n<li><span >\r\n13MP rear camera with AI portrait, AI scene recognition, HDR, pro mode | 5MP front camera. Hybrid Sim Slot : Yes\r\n</span></li>\r\n<li><span >\r\n16.58 centimeters (6.53 inch) HD+ multi-touch capacitive touchscreen with 1600 x 720 pixels resolution, 268 ppi pixel density and 20:9 aspect ratio\r\n</span></li>\r\n<li><span >\r\nMemory, Storage &amp; SIM: 2GB RAM, 32GB internal memory expandable up to 512GB | Dual SIM (nano+nano) + Dedicated SD card slot\r\n</span></li>\r\n<li><span >\r\nAndroid v10 operating system with upto 2.0GHz clock speed Mediatek Helio G25 octa core processor\r\n</span></li>\r\n<li><span >\r\n5000mAH lithium-polymer large battery with 10W wired charger in-box\r\n</span></li>\r\n<li><span >\r\n1 year manufacturer warranty for device and 6 months manufacturer warranty for in-box accessories including batteries from the date of purchase\r\n</span></li>\r\n<li><span >\r\nBox also includes: Power adapter, USB cable, sim eject tool, warranty card and user guide\r\n</span></li>\r\n</ul>',7999.00,'https://m.media-amazon.com/images/I/71sxlhYhKWL._SL1500_.jpg','mobile',21,1,'https://m.media-amazon.com/images/I/81QSmIEUsAL._SL1500_.jpg','https://m.media-amazon.com/images/I/71Uy0aI6GGL._SL1500_.jpg','https://m.media-amazon.com/images/I/61om8x3BVwL._SL1500_.jpg','','price_1JtX6aSBGHFum3RMtvopcqSo','prod_KYePx4q4rKTjsp'),('Apple iPhone 13','256GB | Pink | 6.1 inch | A15 Bionic | 12MP camera','<ul >\r\n<li><span>\r\n15 cm (6.1-inch) Super Retina XDR display\r\n</span></li>\r\n<li><span >\r\nCinematic mode adds shallow depth of field and shifts focus automatically in your videos\r\n</span></li>\r\n<li><span>\r\nAdvanced dual-camera system with 12MP Wide and Ultra Wide cameras; Photographic Styles, Smart HDR 4, Night mode, 4K Dolby Vision HDR recording\r\n</span></li>\r\n<li><span>\r\n12MP TrueDepth front camera with Night mode, 4K Dolby Vision HDR recording\r\n</span></li>\r\n<li><span>\r\nA15 Bionic chip for lightning-fast performance\r\n</span></li>\r\n<li><span>\r\nUp to 19 hours of video playback\r\n</span></li>\r\n<li><span>\r\nDurable design with Ceramic Shield\r\n</span></li>\r\n</ul>',89900.00,'https://m.media-amazon.com/images/I/61l9ppRIiqL._SL1500_.jpg','mobile',21,1,'https://m.media-amazon.com/images/I/61iTWldZ9qL._SL1500_.jpg','https://m.media-amazon.com/images/I/71uNkgYrWcL._SL1500_.jpg','https://m.media-amazon.com/images/I/8163F9RhOlL._SL1500_.jpg','https://m.media-amazon.com/images/I/61paF2JiudL._SL1500_.jpg','price_1JtX6WSBGHFum3RMkY9k4L6C','prod_KYePZGqndyqfI8');
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

-- Dump completed on 2021-11-10 17:11:43
