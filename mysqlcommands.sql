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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add product',7,'add_product'),(26,'Can change product',7,'change_product'),(27,'Can delete product',7,'delete_product'),(28,'Can view product',7,'view_product');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (8,'pbkdf2_sha256$260000$mudPftLt63GfqavBmnikBj$cOf+DSz3Z0Uyblu4EeGzMy5bgQZbUqohJmnp6b8gKKE=','2021-10-27 19:46:12.747061',1,'etash','','','etash18@gmail.com',1,1,'2021-10-15 18:11:05.671965');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
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
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`user_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `cart_chk_1` CHECK ((`quantity` between 1 and 99))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (8,1,1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (7,'2021-10-15 18:11:20.313722','5','etash18@gmail.com',3,'',4,8),(8,'2021-10-15 18:11:23.870762','2','etash19360@iiitd.ac.in',3,'',4,8),(9,'2021-10-15 18:16:52.405797','9','et420911',3,'',4,8),(10,'2021-10-15 18:16:58.668910','10','etash19360@iiitd.ac.in',3,'',4,8),(11,'2021-10-15 18:20:53.118462','11','et420911',3,'',4,8),(12,'2021-10-15 18:20:57.264153','13','etash19360@iiitd.ac.i',3,'',4,8),(13,'2021-10-15 18:21:00.906826','12','etash19360@iiitd.ac.in',3,'',4,8),(14,'2021-10-15 18:21:36.745319','14','et420911',3,'',4,8),(15,'2021-10-15 18:39:30.336707','15','et420911',3,'',4,8),(16,'2021-10-20 06:47:51.508313','16','dummy',3,'',4,8);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'Main','product'),(6,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2021-10-15 16:48:27.621288'),(2,'auth','0001_initial','2021-10-15 16:48:29.792927'),(3,'admin','0001_initial','2021-10-15 16:48:30.167566'),(4,'admin','0002_logentry_remove_auto_add','2021-10-15 16:48:30.183230'),(5,'admin','0003_logentry_add_action_flag_choices','2021-10-15 16:48:30.198848'),(6,'contenttypes','0002_remove_content_type_name','2021-10-15 16:48:30.714345'),(7,'auth','0002_alter_permission_name_max_length','2021-10-15 16:48:31.042361'),(8,'auth','0003_alter_user_email_max_length','2021-10-15 16:48:31.089226'),(9,'auth','0004_alter_user_username_opts','2021-10-15 16:48:31.104879'),(10,'auth','0005_alter_user_last_login_null','2021-10-15 16:48:31.229817'),(11,'auth','0006_require_contenttypes_0002','2021-10-15 16:48:31.229817'),(12,'auth','0007_alter_validators_add_error_messages','2021-10-15 16:48:31.261085'),(13,'auth','0008_alter_user_username_max_length','2021-10-15 16:48:31.589108'),(14,'auth','0009_alter_user_last_name_max_length','2021-10-15 16:48:32.339072'),(15,'auth','0010_alter_group_name_max_length','2021-10-15 16:48:32.370216'),(16,'auth','0011_update_proxy_permissions','2021-10-15 16:48:32.385797'),(17,'auth','0012_alter_user_first_name_max_length','2021-10-15 16:48:32.589161'),(18,'sessions','0001_initial','2021-10-15 16:48:32.713845');
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
INSERT INTO `django_session` VALUES ('01an90jeg2ytiq4urlzd2av7erv83izi','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbsOh:OHbXrR4ZiDpUfUeYemWfo_fAjb1AtmoWZ5KSaWwiQ6E','2021-10-30 22:43:23.170552'),('3vzudl1a54gueeqr1gtu426utzio6got','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbVjv:W-OJPsIQfojGwKUH4Ju4vWU0Xil-lW1l4xSdlG4TBSE','2021-10-29 22:31:47.450315'),('4v92icf4dwudshryln72hg8jdaefynpr','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbsSr:Vg0f5FOm3Wi1A0uGC1C0-KoQb4nvIgzee-hs4hGnKQ0','2021-10-30 22:47:41.212737'),('56yhzij9gh00npqu1yi6t9anvrlfcc2l','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbogd:1LfQkKEBSM94ms-w5bXCmdeUXD8fDAZ8V-BQaYb32iY','2021-10-30 18:45:39.811342'),('5bk112ved56nh4q5qmyo8qu2j5k9dk5a','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbsLR:LPkoDRRZgy7tp8oxgHfEhpu0QvkCIGtogvrhsYoWL28','2021-10-30 22:40:01.002399'),('5s52xaj0jiicsijfdijglm8efv09n3aa','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbSZN:Pw6SBoHev1JR8evF5-x7S3BgdOplXOl7I3W0MIVHcX8','2021-10-29 19:08:41.855701'),('768bfqmal5qqn0bv6v1gigyygolga98s','e30:1md51J:ipFUfYfkIXB3JzgwgHDnS6l2C5f52nsWKrrtLBdSDL8','2021-11-03 06:24:13.136827'),('axmlg58994veyhr43g7by3xgb5kk2jrs','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbsJd:lLReYTcciUQ9SeuCq2IYNK16DXJyzD4zGWIt0ouWjeg','2021-10-30 22:38:09.032788'),('buev6lzfw1i3llnalouc8x3gnso0j32d','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbsGy:yJKop2N_fVg4zBc3QRrJpK3BbTZJLAYm3o33y8HFxps','2021-10-30 22:35:24.086063'),('eook3uhprbixokr9b68ocb7cpusgjcd6','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mcrTI:61CwLRy7W10WdAQ2KZLaEeGZ7ONLpj43JC9DjJwS46U','2021-11-02 15:56:12.228833'),('f9gayl5aizt0yq28ow0pzj5li4odyb2c','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbsR3:iGPa4O0G06LZQelffCKYvsQ_lKt6QdreXc70f3s8mrU','2021-10-30 22:45:49.922903'),('fy78k7hjbv3tqn1c5nflxdd2gtna24yt','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbSzf:AxdwLDH5Rnu3AEkJM7N70uoRCN4SYdX1HQb-jwjExRc','2021-10-29 19:35:51.024299'),('hmbaq1uvcf9tr3gzweqyzm9ysdmva7cv','e30:1mbTMZ:0lfilLc41gfR71PbciTG69yAff7VxGF2CzaRbgqMqX8','2021-10-29 19:59:31.896769'),('io37j9jj9jpqabnsn5i5oe5bfoulm87g','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbT2h:c7wUNordHBnfPqD1wX3kAN8CT63dfNKWb9VMOIeAxsw','2021-10-29 19:38:59.025292'),('iwbh0kiphmvl4ygl46o06tg45dilewlk','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mdmzV:uuZJDCBvnEcseBIPAyXBbvOoIpRY4VjIln-TsQWGYLc','2021-11-05 05:21:17.823734'),('q8f34lpb4yje81mg4taprrq2ovrd8no8','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbs7v:iF7snox7zCIscCAeQK7gJRJaJzQG0Bz05k-Wehx2atY','2021-10-30 22:26:03.864391'),('rhfho1ht7nhdfpy9ve2m1srhuixbmhxc','e30:1mbWa9:Ob77EzIScSXbmo8bnm6_GubJDZADOfvGCtj66oyM1fA','2021-10-29 23:25:45.847101'),('s93hckngtncy33c1op31bnux76xl1fux','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1md6FH:hN89bxDv0HpNlOT_e5_CKAn_muPJtXG699Ym1Yd2RWc','2021-11-03 07:42:43.773300'),('ssp753mtb9p1hcn32jpnn4ads79e8km2','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbrrq:I-ljpRycU3Vp8mMrD3ySUs01U2abZamK9WexH044eL0','2021-10-30 22:09:26.133763'),('v00x42uyk9z1bhkibnlxizadd3iextbp','eyJsb2dpbl90b19jb250aW51ZV90byI6Ii9jYXJ0In0:1mct1h:dw4xUNLnZvhRKshdXsKeuXIIW898_rsTo3ouWmhfO1Y','2021-11-02 17:35:49.527693'),('vaj3bak36epdjoperqaz53pbprelos7x','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mfosG:CUkvO4CdGp_krrETXcAm6ZJwqTrOY9aIWSB8HZ3Bw9I','2021-11-10 19:46:12.785733'),('wid0otojkpbu1c8iugjupznzmafi97sz','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbRfn:uK33fDR0XC0Up9CB8l-m4IZ4HwMie996bBOvQ3UvOlI','2021-10-29 18:11:15.769257'),('wm9v9lmya6i68pwy5v6daummc4nroudf','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbhOr:0RBAdf5DsA0ALuKnwibKDdEkHjv47XNh9q5nM3XX9QY','2021-10-30 10:58:49.197716'),('x4oqtpjjf0tdz48dfw6fxakikqu87q2x','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbr6Q:BOX3gC_5pCwFAGvlHNfbkNOV6cvfW3m4RdQN4AsLdyk','2021-10-30 21:20:26.882422'),('xnyaqw6nz1xix5xta0n3y69mwdkwe3on','eyJsb2dpbl90b19jb250aW51ZV90byI6Ii9jYXJ0In0:1mctif:nOvYNdf6aneOwkQfQolsprsTF8xNIthfrvvsGCXLv6g','2021-11-02 18:20:13.187566'),('xwu52ezbaex3s4oqyyr5zbmtzl1udreu','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1md5Ns:2SsFvML8jPhBmlqTMoqAsByQ-9bel09Af2TnXPUHlQQ','2021-11-03 06:47:32.715025'),('zcv6010nkwi5yaphelww2l4h52i92q9q','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbsBG:baw-xrIbJjKJ8hdF4tpLVPSTAradnCdhT7FfI8xqBAQ','2021-10-30 22:29:30.930184'),('zzahrblietsf9ky7pa6j16ohli5had4t','.eJxVjMEOwiAQRP-FsyGVsoAevfcbyC7LStXQpLQn47_bJj3oaZJ5b-atIq5LiWvLcxxZXVVQp9-OMD1z3QE_sN4nnaa6zCPpXdEHbXqYOL9uh_t3ULCVbX0WFEFkEusph5C8APYI3joXnAExvXgWctkAAV88dAxdsrKlOHHq8wUdzjjg:1mbsPr:al7FCRFFWtXMEuHpBANqViKZgEhjYIEEHtRI3fxzFrQ','2021-10-30 22:44:35.372672');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `new_product_requests`
--

DROP TABLE IF EXISTS `new_product_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `new_product_requests` (
  `req_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(25) NOT NULL,
  `short_description` varchar(200) DEFAULT NULL,
  `description` varchar(5000) DEFAULT NULL,
  `price` decimal(13,2) DEFAULT NULL,
  `image` varchar(1000) DEFAULT NULL,
  `seller_uid` int NOT NULL,
  `pdf_name` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`req_id`),
  KEY `seller_uid` (`seller_uid`),
  CONSTRAINT `new_product_requests_ibfk_1` FOREIGN KEY (`seller_uid`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `new_product_requests`
--

LOCK TABLES `new_product_requests` WRITE;
/*!40000 ALTER TABLE `new_product_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `new_product_requests` ENABLE KEYS */;
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
/*!40000 ALTER TABLE `phone_numbers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `title` varchar(25) NOT NULL,
  `short_description` varchar(200) DEFAULT NULL,
  `description` varchar(5000) DEFAULT NULL,
  `price` decimal(13,2) DEFAULT NULL,
  `image` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'MSI GF75 Thin','10th Generation Intel Core i7-10750H Up To 5GHz, 17.3\" FHD IPS-Level 144Hz Panel Laptop (8GB/512GB NVMe SSD/Windows 10 Home/Nvidia GTX1650 4GB GDDR6/Black/2.2Kg)','<ul><li><b>Processor:</b> 10th Generation Intel Core i7-10750H Up To 5GHz</li><li><b>Operating System:</b> Pre-loaded Windows 10 Home with lifetime validity | Preinstalled Software: MSI BurnRecovery, MSI Battery Calibration, MSI Help Desk, Norton Internet Security (trail 60days) Norton Studio (Metro) (permanent free), Nvidia GeForce Experience, Nahimic 3, Dragon Center | In the box: Laptop, adapter</li><li><b>Display:</b> 17.3\" (43.9 cm) FHD (1920*1080), IPS-Level 144Hz Thin Bezel, 45% NTSC</li><li><b>Memory & Storage:</b> 8 GB DDR4 2666MHz RAM, expandable to 64 GB | Storage: 512GB NVMe SSD</li><li>NVIDIA GeForce GTX 1650 GDDR6 4GB Dedicated Graphics</li><li>Ultra Thin and light design | Laptop weight: 2.2 kg | Cooling: CoolerBoost 5</li><li><b>Keyboard:</b> Steelseries RED Backlit Keyboard</li><li><b>Camera:</b> HD type (30fps@720p) | Microphone: Built-in microphone</li><li>1x Type-C USB3.2 Gen1, 3x Type-A USB3.2 Gen1, 1x RJ45, 1x (4K @ 30Hz) HDMI</li></ul>',994.80,'https://m.media-amazon.com/images/I/81DR+J7JxkL._AC_UY327_FMwebp_QL65_.jpg'),(2,'Samsung Galaxy M12','Black, 4GB RAM, 64GB Storage 6000 mAh with 8nm Processor | True 48 MP Quad Camera | 90Hz Refresh Rate','<ul><li>48MP+5MP+2MP+2MP Quad camera setup- True 48MP (F 2.0) main camera + 5MP (F2.2) Ultra wide camera+ 2MP (F2.4) depth camera + 2MP (2.4) Macro Camera| 8MP (F2.2) front came</li><li>6000mAH lithium-ion battery, 1 year manufacturer warranty for device and 6 months manufacturer warranty for in-box accessories including batteries from the date of purchase</li><li>Android 11, v11.0 operating system,One UI 3.1, with 8nm Power Efficient Exynos850 (Octa Core 2.0GH</li><li>16.55 centimeters (6.5-inch) HD+ TFT LCD - infinity v-cut display,90Hz screen refresh rate, HD+ resolution with 720 x 1600 pixels resolution, 269 PPI with 16M color</li><li>Memory, Storage & SIM: 4GB RAM | 64GB internal memory expandable up to 1TB| Dual SIM (nano+nano) dual-standby (4G+4G)</li><ul>',136.81,'https://m.media-amazon.com/images/I/71r69Y7BSeL._AC_UY327_FMwebp_QL65_.jpg'),(3,'Acer Aspire 5','Acer Aspire 5 A515-46-R14K Slim Laptop | 15.6 Full HD IPS | AMD Ryzen 3 3350U Quad-Core Mobile Processor | 4GB DDR4 | 128GB NVMe SSD | WiFi 6 | Backlit KB | Amazon Alexa | Windows 10 Home (S mode)\"','Powerful Productivity: AMD Ryzen 3 3350U delivers desktop-class performance and amazing battery life in a slim notebook. With Precision Boost, get up to 3.5GHz for your high-demand applications',399.99,'https://m.media-amazon.com/images/I/71+2H96GHZL._AC_SL1500_.jpg'),(4,'ASUS Zenbook 13','ASUS ZenBook 13 Ultra-Slim Laptop, 13.3” OLED FHD NanoEdge Bezel Display, Intel Core i7-1165G7, 8GB LPDDR4X RAM, 512GB SSD, NumberPad, Thunderbolt 4, Wi-Fi 6, Windows 10 Home, Pine Grey, UX325EA-ES71','13.3 inch OLED 400nits Full HD (1920 x 1080) Wide View 4-way NanoEdge bezel display',919.99,'https://m.media-amazon.com/images/I/81NbyNDC8eS._AC_SL1500_.jpg'),(5,'HP Stream','HP Stream 11.6-inch HD Laptop, Intel Celeron N4000, 4 GB RAM, 32 GB eMMC, Windows 10 Home in S Mode with Office 365 Personal for 1 Year (11-ak0010nr, Royal Blue)','STUDY, STREAM, SHARE: Between home, school and work, you need a PC that won\'t quit. Post, play and stay productive all day with the affordable and portable HP Stream 11',233.48,'https://m.media-amazon.com/images/I/71idFa2cEuL._AC_SL1500_.jpg'),(6,'HP Chromebook','HP Chromebook 14 Laptop, Dual-core Intel Celeron Processor N3350, 4 GB RAM, 32 GB eMMC Storage, 14-inch FHD IPS Display, Google Chrome OS, Dual Speakers and Audio by B&O (14-ca051nr, 2020)','FOR WORK AND PLAY – Expect a full day of productivity for work with a powerful dual-core processor, plenty of storage, and long-lasting battery life. Once the workday is done, dive into the perfect PC for your daily dose of entertainment with dual HP speakers, Audio by B&O, and a 180° hinge for comfortable viewing and easier collaboration with others.',289.00,'https://m.media-amazon.com/images/I/61EaSVhVe8L._AC_SL1500_.jpg'),(7,'Lenovo Chromebook S330','Lenovo Chromebook S330 14in Laptop Computer, Mediatek MT8173C up to 1.7 Ghz, 4GB RAM, 32GB eMMC SSD, Bluetooth, HDMI, USB-C, SD Card Reader, Chrome OS, Black (Renewed)','This pre-owned product has been professionally inspected, tested and cleaned by Amazon-qualified suppliers.',169.00,'https://m.media-amazon.com/images/I/61BvlCvbRJL._AC_SL1500_.jpg'),(8,'Dell Inspiron','2021 Dell Inspiron 15.6 FHD Touchscreen Laptop','Intel i5-1035G1(up to 3.6 GHz)|16GB RAM |1TB PCIe SSD |Online Meeting Ready|WebcamHDMI |Windows 10 S Black\"  |10th Generation Intel Core i5-1035G| Base 1.0GHz Up to 3.60GHz 4 cores 6MB Cache 8 Threads with Intel UHD Graphics. It can respond to your basic demands to the intensive ones and handles your tasks for each day',799.99,'https://m.media-amazon.com/images/I/618JrdYSvnL._AC_SL1500_.jpg'),(9,'ASUS VivoBook F512','ASUS VivoBook F512 Thin and Lightweight Laptop, 15.6” FHD WideView NanoEdge , AMD R5-3500U CPU, 8GB RAM, 128GB SSD + 1TB HDD, Backlit KB, Fingerprint Reader, Windows 10, Peacock Blue, F512DA-EB51','15.6 inch FHD 4 way NanoEdge bezel display with a stunning 88% screen-to-body ratio',519.99,'https://m.media-amazon.com/images/I/81fstJkUlaL._AC_SL1500_.jpg'),(10,'Acer Predator Helios 300','Acer Predator Helios 300 PH315-54-760S Gaming Laptop | Intel i7-11800H | NVIDIA GeForce RTX 3060 Laptop GPU | 15.6 Full HD 144Hz 3ms IPS Display | 16GB DDR4 | 512GB SSD | Killer WiFi 6 | RGB Keyboard\"','Extreme Performance: Crush the competition with the impressive power and speed of the 11th Generation Intel Core i7-11800H processor, featuring 8 cores and 16 threads to divide and conquer any task or run your most intensive games',1230.68,'https://m.media-amazon.com/images/I/71Nly9vPapL._AC_SL1500_.jpg'),(11,'MSI GE66 Raider','MSI GE66 Raider Gaming Laptop: 15.6 240Hz Display','Intel Core i7-10750H | NVIDIA GeForce RTX 2070 Super|32GB RAM|1TB NVMe SSD|Win10 |Black (10SFS-670)\"|Smooth Display: The 15.6” 240Hz display delivers a high refresh rate for smooth and vibrant gameplay so you don\'t miss a frame of the game.',1773.99,'https://m.media-amazon.com/images/I/61mOsrtFjLL._AC_SL1200_.jpg'),(12,'Razer Blade 14','Razer Blade 14 Gaming Laptop: AMD Ryzen 9 5900HX 8 Core, NVIDIA GeForce RTX 3070, 14 QHD 165Hz','16GB RAM | 1TB SSD - CNC Aluminum - Chroma RGB - THX Spatial Audio - Vapor Chamber Cooling\"| NVIDIA GeForce RTX 30 Series Graphics for Stunning Visuals: Built on NVIDIA’s award-winning 2nd-gen RTX architecture these GPUs provide the most realistic ray-traced graphics and cutting-edge AI features for the most powerful graphics in a gaming laptop',2199.99,'https://m.media-amazon.com/images/I/611VQf95rxL._AC_SL1500_.jpg'),(13,'Apple iPhone 11 Pro Max','512GB, Space Gray - Unlocked (Renewed Premium)','<b>A like-new experience. Backed by a one-year satisfaction guarantee.</b><br>\r\n<ul>\r\n<li>This pre-owned product is not Apple certified, but has been professionally inspected, tested and cleaned by Amazon-qualified suppliers.</li>\r\n<li>There will be no visible cosmetic imperfections when held at an arm’s length</li>\r\n<li>This product will have a battery which exceeds 80% capacity relative to new</li>\r\n<li> Accessories may not be original, but will be compatible and fully functional. Product may come in generic Box.</li>\r\n<li> Product will come with a SIM removal tool, a charger and a charging cable. Headphones and SIM card are not included.</li>\r\n<li> This product is eligible for a replacement or refund within 90 days of receipt if you are not satisfied under the Amazon Renewed Guarantee.</li>\r\n</ul>',849.00,'https://m.media-amazon.com/images/I/81LmL94PUvS._AC_SL1500_.jpg');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-28  3:16:23
