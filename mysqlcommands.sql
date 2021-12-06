USE fcs_ecommerce;

-- NECESSARY
LOCK TABLES `auth_group` WRITE;
ALTER TABLE `auth_group` DISABLE KEYS;
INSERT INTO `auth_group` VALUES (4, 'admin'),(5, 'buyer'),(6,'seller');
ALTER TABLE `auth_group` ENABLE KEYS;
UNLOCK TABLES;

