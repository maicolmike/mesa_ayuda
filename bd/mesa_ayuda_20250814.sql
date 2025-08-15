-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: mesa_ayuda
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.22.04.1

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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add requerimiento',7,'add_requerimiento'),(26,'Can change requerimiento',7,'change_requerimiento'),(27,'Can delete requerimiento',7,'delete_requerimiento'),(28,'Can view requerimiento',7,'view_requerimiento'),(29,'Can add detalle requerimiento',8,'add_detallerequerimiento'),(30,'Can change detalle requerimiento',8,'change_detallerequerimiento'),(31,'Can delete detalle requerimiento',8,'delete_detallerequerimiento'),(32,'Can view detalle requerimiento',8,'view_detallerequerimiento');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
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
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_users_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(8,'requerimientos','detallerequerimiento'),(7,'requerimientos','requerimiento'),(5,'sessions','session'),(6,'users','user');
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-10-25 15:13:54.174909'),(2,'contenttypes','0002_remove_content_type_name','2024-10-25 15:13:54.242431'),(3,'auth','0001_initial','2024-10-25 15:13:54.438823'),(4,'auth','0002_alter_permission_name_max_length','2024-10-25 15:13:54.488719'),(5,'auth','0003_alter_user_email_max_length','2024-10-25 15:13:54.493148'),(6,'auth','0004_alter_user_username_opts','2024-10-25 15:13:54.498378'),(7,'auth','0005_alter_user_last_login_null','2024-10-25 15:13:54.506656'),(8,'auth','0006_require_contenttypes_0002','2024-10-25 15:13:54.509020'),(9,'auth','0007_alter_validators_add_error_messages','2024-10-25 15:13:54.514193'),(10,'auth','0008_alter_user_username_max_length','2024-10-25 15:13:54.522533'),(11,'auth','0009_alter_user_last_name_max_length','2024-10-25 15:13:54.527883'),(12,'auth','0010_alter_group_name_max_length','2024-10-25 15:13:54.545673'),(13,'auth','0011_update_proxy_permissions','2024-10-25 15:13:54.553313'),(14,'auth','0012_alter_user_first_name_max_length','2024-10-25 15:13:54.560624'),(15,'users','0001_initial','2024-10-25 15:13:54.761898'),(16,'admin','0001_initial','2024-10-25 15:13:54.863263'),(17,'admin','0002_logentry_remove_auto_add','2024-10-25 15:13:54.869864'),(18,'admin','0003_logentry_add_action_flag_choices','2024-10-25 15:13:54.876509'),(19,'sessions','0001_initial','2024-10-25 15:13:54.908860'),(20,'requerimientos','0001_initial','2024-10-25 15:15:57.016789');
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
INSERT INTO `django_session` VALUES ('008hwyjbuuuz8hzs1n452fwt1j3xo22j','.eJxVjEEOwiAQRe_C2hCmrTC4dO8ZyAwMUjU0Ke3KeHfbpAvdvvf-f6tA61LC2mQOY1IXBYM6_UKm-JS6m_Sgep90nOoyj6z3RB-26duU5HU92r-DQq1sayuOs3UesMuIxNB7cGItnQlTb5LlwWUnzor3kTJyl41hgQSRN4zq8wUK_TiH:1umass:tCGq849Nr4oixZREm9A00DEVB1Kp8xfJv-4RWwI8-z8','2025-08-14 16:42:58.560971'),('0gycx2le89lsn3xjdtzsgfug2o4a89hi','.eJxVjMsOwiAQRf-FtSEDQ4W6dN9vIDM8pGogKe3K-O_apAvd3nPOfQlP21r81tPi5yguQonT78YUHqnuIN6p3poMra7LzHJX5EG7nFpMz-vh_h0U6uVb66SssYPjMzsGjDCyymAshxyRkUY3gDUmAwIagqgdUgCVmAwGq5N4fwDPhTeA:1ula41:0Vb74Dt5Ml3KBw0FcBqE3Q_pCsLDVdXBDD7AA6MYN2s','2025-08-11 21:38:17.525469'),('0oyicnopj0st05zhk3w8o70b3szxv1xi','.eJxVjDsOwjAQBe_iGln-rm1Kes5g7fqDA8iR4qRC3B0ipYD2zcx7sYjb2uI2yhKnzM5MGXb6HQnTo_Sd5Dv228zT3NdlIr4r_KCDX-dcnpfD_TtoONq3Nll6ETJhsNoL4QCdAue0rrq4hMlKEiqBsAI0EHhtVA6BsNYqJYFj7w_iaTdF:1umJ5t:_SR9BC_mCEANvqHaQk7jfU9IOVatcFVzfZ1HLcMh-tY','2025-08-13 21:43:13.273842'),('1m825c1181eu5mvqqxe7vsl39qvqctjw','.eJxVjDsOwjAQBe_iGllO1r-lpOcM1npt4wBypDipEHeHSCmgfTPzXiLQttaw9byEKYmzsKM4_Y6R-JHbTtKd2m2WPLd1maLcFXnQLq9zys_L4f4dVOr1W_viwVlGp8BoMCZSjh6pIHpNzicPZUCbCItjBU6T4iHbaK2DkcmgeH8A9ew3ow:1umacx:Olc6L9b8RbzyvIjOQ3AgnqtT3LyhBhUiee5Gr6aC3lk','2025-08-14 16:26:31.415645'),('2k0f7kj4zc5rpdolro0ffm79jr0t0jyh','.eJxVjEEOwiAQRe_C2hCmrTC4dO8ZyAwMUjU0Ke3KeHfbpAvdvvf-f6tA61LC2mQOY1IXBYM6_UKm-JS6m_Sgep90nOoyj6z3RB-26duU5HU92r-DQq1sayuOs3UesMuIxNB7cGItnQlTb5LlwWUnzor3kTJyl41hgQSRN4zq8wUK_TiH:1umdeB:bkWBwBuTqDVGvbEpTILF_6LMZLYmMcr67lgrzT_E8TU','2025-08-14 19:39:59.176430'),('4pxh5m5wr4bts1mtxw48v7rrl3x3p1wx','.eJxVjLsOwjAMAP8lM4pa50UZ2fmGyE5sUkCN1LQT4t9RpA6w3p3urSLuW4l74zXOWV3UGNTpFxKmJy_d5Acu96pTXbZ1Jt0TfdimbzXz63q0f4OCrfSvRXJytiYbRyg8TEBskjeQgwnkaRIBCwI-U0oMgWUafQC0FgZxRn2-Hqo4ZA:1umZwM:-QOBKT2IycpDffCwxmZL2IHLN_MgvZdoR7uxljMLerw','2025-08-14 15:42:30.008479'),('5bu8zllalstfmrk5r4fwvrrxtc5m4xcf','.eJxVjEEOwiAQRe_C2hCBDrQu3fcMZGYAqRpISrsy3l1JutDte-__l_C4b9nvLa5-CeIirBanX0jIj1i6CXcstyq5lm1dSPZEHrbJuYb4vB7t30HGlr9rjA7IEgWwQZmkHEcyCsANY9I0oQUme-5cQ5x0lwYGJqUdp3Fw4v0BHcQ4Ng:1ujmRa:uVOYDwjvUtdEObNIVaWBUzzgLQx3r1wSUAsBqaTbKvg','2025-08-06 22:27:10.358407'),('5rcs9b1yakqbhmud7chdejqkshmksco5','.eJxVjEEOwiAQRe_C2hCmrTC4dO8ZyAwMUjU0Ke3KeHfbpAvdvvf-f6tA61LC2mQOY1IXBYM6_UKm-JS6m_Sgep90nOoyj6z3RB-26duU5HU92r-DQq1sayuOs3UesMuIxNB7cGItnQlTb5LlwWUnzor3kTJyl41hgQSRN4zq8wUK_TiH:1umaT7:osSPMDCdBch8V_8whROA2-YBPEsAikFcwwgoJqd_Zu0','2025-08-14 16:16:21.399514'),('6lgpufwzxhxybo0f0dt0pqug5xfm0xwn','.eJxVjDsOwjAQBe_iGlms_6Gk5wzRrr3GAWRLcVIh7o4spYD2zcx7ixn3rcx753VekrgImMTpdySMT66DpAfWe5Ox1W1dSA5FHrTLW0v8uh7u30HBXkad2ClgiF5Dzso7sBOFQFk7VhTJgmdCnSGAyRZUYkM5KDwnMOzQis8XHQI4jw:1umZ5F:DHtqQVuULI87smOm_vY2pKFsr4IGP0uanSOIyiy65pI','2025-08-14 14:47:37.682705'),('7m0fm06vyonsa157zxdjghz6kitpk1dx','.eJxVjMsOwiAQRf-FtSEDQ4W6dN9vIDM8pGogKe3K-O_apAvd3nPOfQlP21r81tPi5yguQonT78YUHqnuIN6p3poMra7LzHJX5EG7nFpMz-vh_h0U6uVb66SssYPjMzsGjDCyymAshxyRkUY3gDUmAwIagqgdUgCVmAwGq5N4fwDPhTeA:1ujlYJ:uXfKhQvDNy62ANtBujZP0Yo_XJxXLIc6VOmqK37SoQc','2025-08-06 21:30:03.405772'),('7q3tyncfez3glu22n3rn65r7guavgb7v','.eJxVjMEOwiAQRP-FsyGwtIAevfsNZBcWqRqalPZk_Hdp0oMeZ96beYuA21rC1ngJUxIXoZU4_ZaE8cl1J-mB9T7LONd1mUjuijxok7c58et6uH8HBVvpa0fKMGYP7M4Wsso9ggVvB52TcUYbiCMZ7RP0RMoB226PA2XMmkB8vuwjN2Y:1umYXF:PpcssIaz_aIoWN1JxMwvcoGXUYxZojZYZgRp2HrU7c4','2025-08-14 14:12:29.352800'),('7s462ki9gc525pr4jk4we1jchqet26f6','.eJxVjMsOwiAQRf-FtSEDQ4W6dN9vIDM8pGogKe3K-O_apAvd3nPOfQlP21r81tPi5yguQonT78YUHqnuIN6p3poMra7LzHJX5EG7nFpMz-vh_h0U6uVb66SssYPjMzsGjDCyymAshxyRkUY3gDUmAwIagqgdUgCVmAwGq5N4fwDPhTeA:1uluy9:YJUiQ2PatPnjAaU6N9Edpn6bU0snDbBZW2NCshVwigw','2025-08-12 19:57:37.017995'),('9dg0apvbef9w445zzgl9y4s6eww7b4m7','.eJxVjDsOwjAQBe_iGlms_6Gk5wzRrr3GAWRLcVIh7o4spYD2zcx7ixn3rcx753VekrgImMTpdySMT66DpAfWe5Ox1W1dSA5FHrTLW0v8uh7u30HBXkad2ClgiF5Dzso7sBOFQFk7VhTJgmdCnSGAyRZUYkM5KDwnMOzQis8XHQI4jw:1umJUz:3CEjZ2rfhg1Gy77Un_Lu5vLsXOwJfOGXeeX61FJLRcg','2025-08-13 22:09:09.901282'),('9et72cp7hcqj46592mv9a5stclj04im2','.eJxVjDsOwjAQBe_iGllO1r-lpOcM1npt4wBypDipEHeHSCmgfTPzXiLQttaw9byEKYmzsKM4_Y6R-JHbTtKd2m2WPLd1maLcFXnQLq9zys_L4f4dVOr1W_viwVlGp8BoMCZSjh6pIHpNzicPZUCbCItjBU6T4iHbaK2DkcmgeH8A9ew3ow:1umdnI:xei2oYGqGL8es1mU4OYI5RjzaVFCwHCA4tC5ihvn3Fc','2025-08-14 19:49:24.037779'),('9g03306nukixr3ymrqwxksz17z4qxbie','.eJxVjDsOwjAQBe_iGlms_6Gk5wzRrr3GAWRLcVIh7o4spYD2zcx7ixn3rcx753VekrgImMTpdySMT66DpAfWe5Ox1W1dSA5FHrTLW0v8uh7u30HBXkad2ClgiF5Dzso7sBOFQFk7VhTJgmdCnSGAyRZUYkM5KDwnMOzQis8XHQI4jw:1umaQo:OxaKdMI9QJ0fUrWw_Qnn06583AeZAL1ok-SF5U3loJI','2025-08-14 16:13:58.617434'),('a0sxeefg2ysa5pskrvzzdoig1fpghbsb','.eJxVjEEOwiAQRe_C2hAYQKhL9z0DmWFAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERWpx-N8L0yG0HfMd2m2Wa27pMJHdFHrTLceb8vB7u30HFXr-1Cinls2FDGpRPFoALgidtzZA1YAikCrDDQRkOSYMlR0GjsiU7H0C8P9xdN4U:1tDVAT:zTDoWyIvTTZEf_tHXeiZkDoUk2zF0d4katU4hDAjQQc','2024-11-19 20:59:49.302112'),('azmg76my6gs6rl5edc3la82wj6umjpzd','.eJxVjMEOwiAQRP-FsyG1C6V49O43kGUXpGogKe3J-O9C0oMmu8nMzpt9C4f7ltxew-oWFhehtTj9Hj3SM-Se8APzvUgqeVsXLzsij7TKW-Hwuh7s34OENfU2w4TqPNhIbKPXM2iveVBmipZAWYojQVsbmgKjIMLcrAHCNn4Uny8g1zjS:1umeck:D9hrCCeFDbbe0QiMYh89aQIN-XVt8WqsXB2tOj5wtsc','2025-08-14 20:42:34.174867'),('bd91zpsrdrbxuhoor5c2b476qyv8flda','.eJxVjEsOwjAMBe-SNYqcyGltluw5Q-Q0Di2gROpnhbg7VOoCtm9m3stE2dYxbovOccrmbHwwp98xyfDQupN8l3prdmh1nadkd8UedLHXlvV5Ody_g1GW8VsTMxTqAqOSQyHoAFISYK_qsEAQJHQIOkAPpSf2Ap1Hzj7nQo7N-wPaPDbv:1umZs9:V9Jsw43U-NeXB29QVz2jneiqVF96Gk2CaXrB--wR3u8','2025-08-14 15:38:09.565105'),('cpewt3ls2mks9731f17ddb6rzmqa1je4','.eJxVjDsOwjAQBe_iGllO1r-lpOcM1npt4wBypDipEHeHSCmgfTPzXiLQttaw9byEKYmzsKM4_Y6R-JHbTtKd2m2WPLd1maLcFXnQLq9zys_L4f4dVOr1W_viwVlGp8BoMCZSjh6pIHpNzicPZUCbCItjBU6T4iHbaK2DkcmgeH8A9ew3ow:1umZBc:vZ-3IAdZfWHGSHAXVbobbaf14gjAOWlqEzezAjhSlKE','2025-08-14 14:54:12.529572'),('el04aqskwoqzichidf0jv7o3g4s4cyy7','.eJxVjEEOwiAQRe_C2hAYQKhL9z0DmWFAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERWpx-N8L0yG0HfMd2m2Wa27pMJHdFHrTLceb8vB7u30HFXr-1Cinls2FDGpRPFoALgidtzZA1YAikCrDDQRkOSYMlR0GjsiU7H0C8P9xdN4U:1tWMTy:fgKpeFiz_qffl-vDJTgyUk3sToxnHrsgnOsRwwaTwMo','2025-01-10 21:33:54.216926'),('g7zikra3pc1yg1ug9qt0bnpjtvgbx9e3','.eJxVjDsOwjAQBe_iGllO1r-lpOcM1npt4wBypDipEHeHSCmgfTPzXiLQttaw9byEKYmzsKM4_Y6R-JHbTtKd2m2WPLd1maLcFXnQLq9zys_L4f4dVOr1W_viwVlGp8BoMCZSjh6pIHpNzicPZUCbCItjBU6T4iHbaK2DkcmgeH8A9ew3ow:1ulZ1Y:UYX0wPH9fbKlALG_pxkFnylc48MCZ3Wf0p8Wo_MW2qY','2025-08-11 20:31:40.867810'),('gdsie99npv8bnp0zmdtc3erfv1475zn5','.eJxVjEEOwiAQRe_C2hAYoFCX7j0DYYZBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xyuIsvBan3xETPbjtJN9Tu82S5rYuE8pdkQft8jpnfl4O9--gpl6_NQIzGY2KHQ7KYTAQrFE8estFW7QjqiEkRu9zAEUKCKAgOCjFEAXx_gAKSDgm:1umJpU:4X4xvmlXZFP4-G2eCwszluYOW7izWQui8fhiw8hLNLw','2025-08-13 22:30:20.657015'),('hjrrkvc5fvh3l5py09w2jv3p3aba77gk','.eJxVjEEOwiAQRe_C2hAYoFCX7j0DYYZBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xyuIsvBan3xETPbjtJN9Tu82S5rYuE8pdkQft8jpnfl4O9--gpl6_NQIzGY2KHQ7KYTAQrFE8estFW7QjqiEkRu9zAEUKCKAgOCjFEAXx_gAKSDgm:1umIkD:567frGFZNoL405oCnNpT0yLb7HNZoU9W5KzKHJQJUwI','2025-08-13 21:20:49.519291'),('kgrak69qpuylcviwybycr1mxof1ta4k7','.eJxVjDsOwjAQBe_iGllO1r-lpOcM1npt4wBypDipEHeHSCmgfTPzXiLQttaw9byEKYmzsKM4_Y6R-JHbTtKd2m2WPLd1maLcFXnQLq9zys_L4f4dVOr1W_viwVlGp8BoMCZSjh6pIHpNzicPZUCbCItjBU6T4iHbaK2DkcmgeH8A9ew3ow:1ulYl5:PW1lNKB8xF32N95UJybQMmjSOgWyRHNeuHNTp0FPU08','2025-08-11 20:14:39.346520'),('lre28cvmjymcyx6c5xem7zomsc7hm35v','.eJxVjDsOwyAQRO9CHSHAmE_K9D4DYnchOIlAMnYV5e6xJRdJN5r3Zt4sxG0tYetpCTOxKzOeXX5LiPhM9SD0iPXeOLa6LjPwQ-En7XxqlF630_07KLGXfa1HnUxWJEcLGVAJ6QeHDkBZdAK0l560FdoM2UuVnbJSkEox7RnJWvb5Av2ZN7g:1umdWL:EdOMVMVA0EvMEZAu7Aj1l0xnvy8GzvRP_Vx5WmdGdtI','2025-08-14 19:31:53.428708'),('lwa4whv5nkmnln5szm7k6ek3qrsazf1c','.eJxVjEEOwiAQRe_C2hApwxRcuu8ZyAwMUjVtUtqV8e7apAvd_vfef6lI21rj1mSJY1YXhV6dfkem9JBpJ_lO023WaZ7WZWS9K_qgTQ9zluf1cP8OKrX6rdkEX9hLVzBw56F3AXpTMBXLFJCCA0SbC2OSfDZOQBBc58kmAPRWvT8NqzfS:1umdzt:uzgDiSPvppcQ6WxRJRc06I3P4vf3Em6bFk-tyOTI2Q8','2025-08-14 20:02:25.227874'),('lz89jy83dvg6iueusocdfa5yz1p3qpoe','.eJxVjEEOgjAQRe_StWkYplDq0r1nINOZqaCmTSisjHdXEha6_e-9_zIjbes0blWXcRZzNh2a0-8YiR-adyJ3yrdiueR1maPdFXvQaq9F9Hk53L-Dier0rTkFkL4BZUDvAoQETWToFX1Eh-SGtk8cPCdNXuIg0EEi9OqkaYGieX8ACWk4YA:1umIom:zs8ARbTFO7oTX3gzeMfp4Px9U6i2XnPJRh0jkRwbCQ8','2025-08-13 21:25:32.198056'),('m48uq6t4eac57mvrh5s1gd9m4w3lpzza','.eJxVjEEOwiAQRe_C2hAYQKhL9z0DmWFAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERWpx-N8L0yG0HfMd2m2Wa27pMJHdFHrTLceb8vB7u30HFXr-1Cinls2FDGpRPFoALgidtzZA1YAikCrDDQRkOSYMlR0GjsiU7H0C8P9xdN4U:1tFg94:WW-J6iGcTbCin_7R448OLWywU5mu8oWhrbs2tz9Jf-8','2024-11-25 21:07:22.670588'),('m95ipp4g2rhxs30yl6hz9mbglgi5ws2v','.eJxVjDsOgzAQRO_iOrLA-EfK9JzBWu-uY5LIljBUUe4ekCiSKee9mbcIsK05bI2XMJO4CuXE5beMgE8uB6EHlHuVWMu6zFEeijxpk1Mlft1O9-8gQ8v7ekwcPUEaFGvnNHJvuxG8d8kYrQwSarRx2OOAOkMDKps0Rut7ZDJJfL4dNTim:1umaNs:6m0CIvZBoivsmurnuD9keugr20e6KRb3TeciDO7gCEs','2025-08-14 16:10:56.929526'),('mk2dfwkg4t82e9yy3fgcskics7vpapm1','.eJxVjMsOwiAQRf-FtSEDQ4W6dN9vIDM8pGogKe3K-O_apAvd3nPOfQlP21r81tPi5yguQonT78YUHqnuIN6p3poMra7LzHJX5EG7nFpMz-vh_h0U6uVb66SssYPjMzsGjDCyymAshxyRkUY3gDUmAwIagqgdUgCVmAwGq5N4fwDPhTeA:1ujgbc:-yy_9OM8lmcoH6cf1CVzMfPG0xzZ8f8etMW62UxEvx0','2025-08-06 16:13:08.410687'),('n15r23zzk6f8nnl5bbc3rdazbsvlhouz','.eJxVjDsOwjAQBe_iGlms_6Gk5wzRrr3GAWRLcVIh7o4spYD2zcx7ixn3rcx753VekrgImMTpdySMT66DpAfWe5Ox1W1dSA5FHrTLW0v8uh7u30HBXkad2ClgiF5Dzso7sBOFQFk7VhTJgmdCnSGAyRZUYkM5KDwnMOzQis8XHQI4jw:1umY7X:LqTcpGPU0Kbk7qnuQ8dIc207jkneq27MRQvY2SYOBqA','2025-08-14 13:45:55.204014'),('n5w7h48ee2lbye2gxzi2dwr0yfnekokm','.eJxVjDsOwjAQBe_iGln-4B8lPWew1rsbHECOFCcV4u4kUgpo38y8t8iwLjWvnec8krgI48XpdyyAT247oQe0-yRxass8Frkr8qBd3ibi1_Vw_w4q9LrVNiYV4FxwQCbrgDyDDoG8UyZyIscYXCzoi45Go3I4GJs2GU1QbJP4fAEiTjii:1umYkV:7t6z0BDo-J6F2P4dcPgNBGoQv1UWAnl8CubokcE7r6k','2025-08-14 14:26:11.762051'),('nvk351oq4a7fnxyavjbahq6slx5bvxzc','.eJxVjMsOwiAQRf-FtSEDQ4W6dN9vIDM8pGogKe3K-O_apAvd3nPOfQlP21r81tPi5yguQonT78YUHqnuIN6p3poMra7LzHJX5EG7nFpMz-vh_h0U6uVb66SssYPjMzsGjDCyymAshxyRkUY3gDUmAwIagqgdUgCVmAwGq5N4fwDPhTeA:1uJXbI:LBpsOlztJrXtfssaqagj2iO6O6DkAjIj5FUd-SoiFqg','2025-05-26 13:20:44.551561'),('o800mk44vu76v2q7xpggbnds0ft5aksp','.eJxVjEsOwjAMBe-SNYpitwXCkn3PENmxTQoolfpZIe4OlbqA7ZuZ93KJ1qWkddYpDeIurkF3-B2Z8kPrRuRO9Tb6PNZlGthvit_p7PtR9Hnd3b-DQnP51tQqa0tnMWEh1U4RyI6R-RQicAyEEBG0MwZrBAIYmhFiGynkgO79AU7BOS8:1umYxp:MIF11un9tt6FgZub6j6WR-rfffg7-wrgMpId8Q3wtTA','2025-08-14 14:39:57.978976'),('oje96757xsxovnjtvm0w4ugv32aphgbd','.eJxVjDsOwjAQBe_iGllO1r-lpOcM1npt4wBypDipEHeHSCmgfTPzXiLQttaw9byEKYmzsKM4_Y6R-JHbTtKd2m2WPLd1maLcFXnQLq9zys_L4f4dVOr1W_viwVlGp8BoMCZSjh6pIHpNzicPZUCbCItjBU6T4iHbaK2DkcmgeH8A9ew3ow:1umIaJ:mr5BIS7dxyfJfEU69mQ53AVvVrtAgjUfO2QTzFY_V34','2025-08-13 21:10:35.248477'),('okr38stgc8jv9uq1y6nzlco1selqa83v','.eJxVjEEOwiAQRe_C2hAYQKhL9z0DmWFAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERWpx-N8L0yG0HfMd2m2Wa27pMJHdFHrTLceb8vB7u30HFXr-1Cinls2FDGpRPFoALgidtzZA1YAikCrDDQRkOSYMlR0GjsiU7H0C8P9xdN4U:1tWLjF:oFZZk2t2Qo4TpInwWcBd6G_hU_rf4k-YtycXXOtL_b0','2025-01-10 20:45:37.543678'),('oodljlvkgyz0twket8jvcuwzny6zjom1','.eJxVjEEOgjAQRe_StWkYplDq0r1nINOZqaCmTSisjHdXEha6_e-9_zIjbes0blWXcRZzNh2a0-8YiR-adyJ3yrdiueR1maPdFXvQaq9F9Hk53L-Dier0rTkFkL4BZUDvAoQETWToFX1Eh-SGtk8cPCdNXuIg0EEi9OqkaYGieX8ACWk4YA:1umJYV:dx43X9Y5I1rYGKgxLgsqM91tVfgsjEfQe6twNQD_nlk','2025-08-13 22:12:47.870913'),('pbl34bt4m3wddswr9hvvgrspk3o5u5wg','.eJxVjMEOwiAQRP-FsyG1C6V49O43kGUXpGogKe3J-O9C0oMmu8nMzpt9C4f7ltxew-oWFhehtTj9Hj3SM-Se8APzvUgqeVsXLzsij7TKW-Hwuh7s34OENfU2w4TqPNhIbKPXM2iveVBmipZAWYojQVsbmgKjIMLcrAHCNn4Uny8g1zjS:1umaSD:aS0Sk_yDSaPSsTsQHyypvr0hKQM29f9LcQRZO6yCW30','2025-08-14 16:15:25.679972'),('qvvmrpfotxub7h0itecmeuudg2hfwipw','.eJxVjEEKwyAQAP_iuYhGF7XH3vsGWbNrTVsUYnIK_XsRcmivM8McIuK-lbh3XuNC4iqsEZdfmHB-cR2GnlgfTc6tbuuS5Ejkabu8N-L37Wz_BgV7GV835WySJ0saWWEAo7MHTSo75cmEzGDBZAhqUppZgdXGeYc-eZtsEJ8v_us3Ug:1umdEb:O7seAPpc1LpD0SBuwclqfIg7faKX2ox1L7bJPCyWpsE','2025-08-14 19:13:33.475230'),('ravel8sxspm4y9ssnswhgqqw7bh0jim0','.eJxVjDsOwjAQBe_iGllO1r-lpOcM1npt4wBypDipEHeHSCmgfTPzXiLQttaw9byEKYmzsKM4_Y6R-JHbTtKd2m2WPLd1maLcFXnQLq9zys_L4f4dVOr1W_viwVlGp8BoMCZSjh6pIHpNzicPZUCbCItjBU6T4iHbaK2DkcmgeH8A9ew3ow:1umIw3:7aCBH3O-ppsabFXdOXcZ6Cdk3WophpoCOoAE7Q0DsKs','2025-08-13 21:33:03.435103'),('sm03mshvnvgwfwfd17iq6p46lts1s356','.eJxVjMsOwiAUBf-FtSG8Cy7d9xvIBS5SNZCUdmX8d2nShW5n5pw38bBvxe8dV78kciWckcsvDBCfWA-THlDvjcZWt3UJ9EjoaTudW8LX7Wz_Dgr0MtY6gZyMksqEILhxQhvMSRjGBwVlnRUJNCCPw1ucstNZS8mMdtZCQPL5AuetN4M:1umYWD:pNooxUH6E7qL91eke5BoGDZSF3bjq-QbGcM9jWmwBME','2025-08-14 14:11:25.381191'),('u16b10e3sfar36nifxmqehranfzjhx93','.eJxVjMsOwiAQRf-FtSEDQ4W6dN9vIDM8pGogKe3K-O_apAvd3nPOfQlP21r81tPi5yguQonT78YUHqnuIN6p3poMra7LzHJX5EG7nFpMz-vh_h0U6uVb66SssYPjMzsGjDCyymAshxyRkUY3gDUmAwIagqgdUgCVmAwGq5N4fwDPhTeA:1ujeYu:j7HqoI1_bwh8lVGQekQ1YIDkoWARg08B3kaEK8egjRY','2025-08-06 14:02:12.741167'),('usritjjq9ak3e9617llg1i31yexlijef','.eJxVjEEOwiAQRe_C2hAYQKhL9z0DmWFAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERWpx-N8L0yG0HfMd2m2Wa27pMJHdFHrTLceb8vB7u30HFXr-1Cinls2FDGpRPFoALgidtzZA1YAikCrDDQRkOSYMlR0GjsiU7H0C8P9xdN4U:1t4M6H:CLASaiWaAJusMpVeBb9oXPAZ5IZdbyXWk_S-Q36osk8','2024-10-25 15:29:41.432678'),('uy4hsc4ahhgca06gmewys9hhjgp76xjp','.eJxVjMsOwiAQRf-FtSHyBpfu-w1kmAGpGkhKuzL-uzbpQrf3nHNfLMK21riNvMSZ2IVpzU6_YwJ85LYTukO7dY69rcuc-K7wgw4-dcrP6-H-HVQY9VsbY6QuRGSKslA0iJCcQF18OIPHoigJDF4GRCFF8FaRsQhOORe8M8TeHxTRN_g:1umd90:Zz4evkMTegdSVHtR3td89RMF91I-HynjQLOdcHhTGLI','2025-08-14 19:07:46.101951'),('vas4gpye8c2lznwzyb9pbglfwa6ptjxr','.eJxVjEEOwiAQRe_C2hAYQKhL9z0DmWFAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERWpx-N8L0yG0HfMd2m2Wa27pMJHdFHrTLceb8vB7u30HFXr-1Cinls2FDGpRPFoALgidtzZA1YAikCrDDQRkOSYMlR0GjsiU7H0C8P9xdN4U:1tx7GK:Vso9CBqA0DJnY6bbHNCcsx_6LTcZV9i6aly1VPTplyY','2025-03-25 16:46:24.735225'),('vdlwzmjxdkfrthykcnw5l28pwolosa5x','.eJxVjMsOwiAQRf-FtSEDQ4W6dN9vIDM8pGogKe3K-O_apAvd3nPOfQlP21r81tPi5yguQonT78YUHqnuIN6p3poMra7LzHJX5EG7nFpMz-vh_h0U6uVb66SssYPjMzsGjDCyymAshxyRkUY3gDUmAwIagqgdUgCVmAwGq5N4fwDPhTeA:1uMngK:tnT5a-AJ97skEkddV8ankSU2inB4d2qdnXm6IK8x9g8','2025-06-04 13:07:24.279205'),('wgfkc4ea47cmp6dc1ly2upnc36srl6kg','.eJxVjDsOwjAQBe_iGln-xbumpM8ZrLXXxgGUSPlUiLuTSCmgfTPz3iLStra4LWWOA4ur8EpcfsdE-VnGg_CDxvsk8zSu85DkociTLrKfuLxup_t30Ghpe22dMpYBAmJFYwE0sXOdqQF1hzvNCkhbyNWmDBaQ0FVG9gGrIvLi8wXK1DcD:1umav4:a46daxafwq84iZn6BCoghFAr0o8Gn0WEPoyN1x1Mk40','2025-08-14 16:45:14.766533'),('zhiwz0j4qwpizgd8z98dlapvr5g0xo20','.eJxVjDsOwyAQBe9CHSH-4JTpfQa0sEtwEmHJ2FWUu0dILpL2zcx7swjHXuPRaYsLsivTml1-xwT5SW0QfEC7rzyvbd-WxIfCT9r5vCK9bqf7d1Ch11GbIARMVCYRkrLWe0WmlOxJGB2CVNalAM5lqbwRpCUaqzBJQNQlYWafL_M7OAE:1umdSr:2coeFMDPoyvanfIgOJ4DHV_Dmg5diGvmTdAjNR6wQdQ','2025-08-14 19:28:17.601278');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requerimientos_detallerequerimiento`
--

DROP TABLE IF EXISTS `requerimientos_detallerequerimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requerimientos_detallerequerimiento` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `comentario` longtext NOT NULL,
  `fecha` datetime(6) NOT NULL,
  `adjunto` varchar(100) DEFAULT NULL,
  `usuario_id` bigint NOT NULL,
  `requerimiento_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `requerimientos_detal_usuario_id_a8729853_fk_users_use` (`usuario_id`),
  KEY `requerimientos_detal_requerimiento_id_1d5c36f4_fk_requerimi` (`requerimiento_id`),
  CONSTRAINT `requerimientos_detal_requerimiento_id_1d5c36f4_fk_requerimi` FOREIGN KEY (`requerimiento_id`) REFERENCES `requerimientos_requerimiento` (`id`),
  CONSTRAINT `requerimientos_detal_usuario_id_a8729853_fk_users_use` FOREIGN KEY (`usuario_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requerimientos_detallerequerimiento`
--

LOCK TABLES `requerimientos_detallerequerimiento` WRITE;
/*!40000 ALTER TABLE `requerimientos_detallerequerimiento` DISABLE KEYS */;
INSERT INTO `requerimientos_detallerequerimiento` VALUES (1,'Cordial saludo, se realiza el ajuste requerido, por favor revisar y cualquier novedad o inconveniente nos informa por este mismo medio.','2025-08-13 21:22:59.099912','',62,1),(2,'Se dio respuesta y solución a lo solicitado','2025-08-13 22:02:47.805032','',53,1),(3,'Buenos días, se realiza explicación de reporte 138 para visualización de la información solicitada. Quedo atento al cierre de requerimiento.','2025-08-14 14:37:37.622757','',19,2),(4,'se dio respuesta a la solicitud ','2025-08-14 14:46:52.455698','',32,2),(5,'Cordial saludo compañero, será que nos puede decir de que corte necesita el plano.','2025-08-14 16:16:31.350331','',62,3),(6,'CON CORTE AL MES ANTERIOR ES DECIR MES DE JULIO DE 2025','2025-08-14 16:32:58.475260','',14,3),(7,'cordial saludo, se hace envio de la información solicitada, tener encuentra que se envía encriptada por lo cual a su WhatsApp personal se envía la contraseña de desencriptación, cualquier duda nos la comenta y si el envio de esta respuesta soluciona su requerimiento por favor marcar como cerrado el caso, quedamos atentos a cualquier información.','2025-08-14 19:28:28.419445','adjuntos/plano_juridicos.zip',62,3);
/*!40000 ALTER TABLE `requerimientos_detallerequerimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requerimientos_requerimiento`
--

DROP TABLE IF EXISTS `requerimientos_requerimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requerimientos_requerimiento` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha` datetime(6) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` longtext NOT NULL,
  `agencia` varchar(100) NOT NULL,
  `clasificacion` varchar(100) NOT NULL,
  `sub_clasificacion` varchar(100) NOT NULL,
  `adjunto` varchar(100) DEFAULT NULL,
  `estado` varchar(50) NOT NULL,
  `usuario_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `requerimientos_reque_usuario_id_4a0e9464_fk_users_use` (`usuario_id`),
  CONSTRAINT `requerimientos_reque_usuario_id_4a0e9464_fk_users_use` FOREIGN KEY (`usuario_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requerimientos_requerimiento`
--

LOCK TABLES `requerimientos_requerimiento` WRITE;
/*!40000 ALTER TABLE `requerimientos_requerimiento` DISABLE KEYS */;
INSERT INTO `requerimientos_requerimiento` VALUES (1,'2025-08-13 21:14:47.537027','Actualización de fecha asociado en linix','Cordial saludo.\r\n\r\nPor favor me colabora compañero cambiando en la fecha de actualización en LINIX del asociado LOPEZ ZAMBRANO KEYNER DAMIR R.C. 1127081496. EL 23 de abril de 2025.\r\n\r\nAtenta a sus comentarios.','VILLA GARZON','Solicitud de actualizacion de informacion','ultima fecha de actualizacion de datos (asociados - terceros)','','CERRADO',53),(2,'2025-08-14 14:28:27.841984','SOLICITUD DE REPORTE','Cordial saludo,\r\n\r\nPara solicitar un reporte general de asociado Agencia Pto Asís en archivo Excel para gestión comercial, con los siguientes datos: \r\n - nombres\r\n- numero de documento\r\n- dirección\r\n- teléfono\r\n- tipo de asociado\r\n- edad\r\n\r\nAgradezco la atención.','PUERTO ASIS','Solicitud de reportes de informacion','listado de asociados afiliados','','CERRADO',32),(3,'2025-08-14 16:06:17.288381','PLANO ASOCIADOS JURIDICOS','Según solicitud de gerencia, se solicita enviar plano con los siguientes datos:\r\n\r\nNOMBRES COMPLETOS \r\nTIPO Y  NUMERO DE IDENTIFICACION\r\nDIRECCION\r\nTELEFONOS\r\nREPRESENTANTE LEGAL\r\nNUMERO DE TELEFONO REPRESENTANTE LEGAL','MOCOA','Solicitud de reportes de informacion','listado de asociados afiliados','','ACTIVO',14);
/*!40000 ALTER TABLE `requerimientos_requerimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user`
--

DROP TABLE IF EXISTS `users_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
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
  `identificacion` varchar(100) NOT NULL,
  `nombres` varchar(255) NOT NULL,
  `agencia` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `identificacion` (`identificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user`
--

LOCK TABLES `users_user` WRITE;
/*!40000 ALTER TABLE `users_user` DISABLE KEYS */;
INSERT INTO `users_user` VALUES (1,'pbkdf2_sha256$1000000$nsfWaPwoDFkKqotnnTainv$MK43yscdrYhJDaXd8ws609UOOWNNRZfmbOgzydA8MEc=','2025-08-12 20:33:37.623225',1,'admin11','','','soportesistemas@cootep.com.co',1,1,'2024-10-25 15:19:04.409796','','',''),(2,'pbkdf2_sha256$1000000$b2aEU1nOt1BxRclHXsQA9K$ICRTpK7GGWX0spqY+opf+CxT+wECUMIkQ/HorMDIZu8=','2025-06-04 13:08:34.839590',0,'ACHAMO','','','credito@cootep.com.co',0,1,'2024-11-19 19:58:37.063086','18129966','ALFREDO RICARDO CHAMORRO BURBANO','MOCOA'),(3,'pbkdf2_sha256$1000000$M7mrbKXN73MWgNxZiMzXqq$Wf0t0mqCShGTkNRCR1lcYxrlXHatm8kI4wgZfJUT2RI=','2025-08-13 21:23:00.885096',0,'ACAICE','','','agenciaorito@cootep.com.co',0,1,'2024-11-19 19:58:37.622178','41107839','AMILDA BERENICE CAICEDO CAICEDO','ORITO'),(4,'pbkdf2_sha256$870000$PzzrjKJNmvZiTZnxrgHXN9$RhSCc8WyMGXNV4DyVEsYEyn2bp3oWDMFVggrSwMY150=',NULL,0,'ASEGUR','','','agenciahormiga@cootep.com.co',0,1,'2024-11-19 19:58:38.154296','69029569','ANA MARLY SEGURA DIAZ','HORMIGA'),(5,'pbkdf2_sha256$1000000$51ucGYuV5sF1rPGO7fuYoP$T7o9cgIgbeybrB1ORdkJqZtB/iZzM2+3rcF0h9ztRmQ=','2025-05-12 21:14:12.785872',0,'MIRUAN','','','ana.ruano@cootep.com.co',0,1,'2024-11-19 19:58:38.687909','27389048','ANA MILENA RUANO CHAMORRO','HORMIGA'),(6,'pbkdf2_sha256$870000$TWSAiEgGE3i945ULOWKuL1$TUrH1VMjXtYUSA+pblhB9EtLsoMuPx+D9qDkVnOGV+E=',NULL,0,'AROSER','','','contabilidad@cootep.com.co',0,1,'2024-11-19 19:58:39.218828','69008647','ANA VIKY ROSERO ADARME','MOCOA'),(7,'pbkdf2_sha256$870000$F6XFKMcQHMxDtbUA72HXTD$Ee+9e8HjhX7PX/Mob5hXj1R/n3srpcEjT5CBPB3PR/s=',NULL,0,'ANVER','','','asiscontabilidad@cootep.com.co',0,1,'2024-11-19 19:58:39.760322','1124863181','ANDREA CAROLINA VERDUGO BENAVIDES','MOCOA'),(8,'pbkdf2_sha256$870000$9ZuKspybZTvhhsxA1O957M$lDVnE+uclZLZ6xFHrumKSX/7EaYCclGh0jx4pVIU1jk=',NULL,0,'DVALLE','','','asesororito1@cootep.com.co',0,1,'2024-11-19 19:58:40.289559','1006849014','ANDREA DANIELA VALLEJOS PULIDO','ORITO'),(9,'pbkdf2_sha256$870000$fK5Gf1LWDprOxVYnogZYa4$IchQH4fTJjdssPbkChGmTO9J5DXjDokHpate0KtFxx8=',NULL,0,'AURBAN','','','atencionalcliente@cootep.com.co',0,1,'2024-11-19 19:58:40.832955','1124849667','ANGELA MILENA URBANO NARVAEZ','MOCOA'),(10,'pbkdf2_sha256$1000000$YyG3ErGhjIl9xLjwnBmWwL$f0qkKL6x/P3YSHCxjOvDlhHTkRY0sY/ayk+bSrvq5uA=','2025-08-14 14:01:26.604465',0,'BGUERR','','','asesorsibundoy1@cootep.com.co',0,1,'2024-11-19 19:58:41.366741','1006815937','BRANDON DANILO GUERRERO JAJOY','SIBUNDOY'),(11,'pbkdf2_sha256$870000$PNjkH85W49xM6zewPOJA42$VZU09+Zsq8cMYJIMDKWk71uZxB6Lq6VCEnxuppR3vlI=',NULL,0,'ACARVA','','','asesormocoa6@cootep.com.co',0,1,'2024-11-19 19:58:41.908985','1124862382','ELIAS ADIRVEY GALVIS CARVAJAL','MOCOA'),(12,'pbkdf2_sha256$870000$P6Q5h1hcIMWPQzYutJvlfL$UtokAw4Hsb+MbQkxFZ84UfmZ0GbgJqw6pS8bdqy1/Q0=',NULL,0,'CAAZAM','','','corresponsalvillagarzon@cootep.com.co',0,1,'2024-11-19 19:58:42.446417','1127073033','CAMILO ALEJANDRO ZAMBRANO HERNANDEZ','VILLA GARZON'),(13,'pbkdf2_sha256$870000$N8WY7CjykHMMneJZThgsQV$WuKcHxYOMX5waUA3fv4NLcHoOXn2Z2J2NccUwuCrFcU=',NULL,0,'CCAICE','','','auxcaja01@cootep.com.co',0,1,'2024-11-19 19:58:42.983142','18126364','CARLOS HERNAN CAICEDO RAMOS','MOCOA'),(14,'pbkdf2_sha256$1000000$eY0rTdhvMPPyAMpEhruoWl$Rv25MK+RSw8VjSghs8iOdXDRm5nzPW0QtKGUq/Kd+Cc=','2025-08-14 19:29:41.605464',0,'IVAROM','','','agenciamocoa@cootep.com.co',0,1,'2024-11-19 19:58:43.506260','1113643270','CARLOS IVAN ROMERO BASTIDAS','MOCOA'),(15,'pbkdf2_sha256$870000$2LjIEPNaOIJFfWcCAVPTnN$9tsSNMhgBfgLHGaTDeiN/EI9kXxh69KmT30B4+Mtj6E=',NULL,0,'CGARCI','','','riesgos@cootep.com.co',0,1,'2024-11-19 19:58:44.044973','1122782313','CARLOS REINALDO GARCIA NASTAR','MOCOA'),(16,'pbkdf2_sha256$1000000$MPldop628jA1CYaRNGoVpn$oQiLMvZSK5rAHJNkoopwvesXAIf3mP1d3XDP8NllVZw=',NULL,0,'HZAMBR','','','microcreditosibundoy@cootep.com.co',0,1,'2024-11-19 19:58:44.571643','1193405930','HERNAN SANTIAGO ZAMBRANO ENRIQUEZ','SIBUNDOY'),(17,'pbkdf2_sha256$1000000$v4NOoXXOqzd3BRX1d1zUij$3uGzZ+tfnRTFUoLaQY8G0OpkilcwUiGzELzTazAEdeY=','2025-08-14 15:31:02.296647',0,'CGAVIR','','','auxagenciapuerto@cootep.com.co',0,1,'2024-11-19 19:58:45.102018','69028001','CLAUDIA PAOLA GAVIRIA DIAZ','PUERTO ASIS'),(18,'pbkdf2_sha256$870000$6pNk817XxAKYMh9s5znzDf$RPzocSpRJJNf2xRKy13mj+Efug+a1IGthZystSizApM=',NULL,0,'CCORDO','','','asesordeservicios@cootep.com.co',0,1,'2024-11-19 19:58:45.634887','1124862242','CRISTHIAN ANDRES OLARTE CORDOBA','MOCOA'),(19,'pbkdf2_sha256$1000000$MJNiBPlupNrURKEPycAhrg$HImucEsWbADGA40UCIwWQt8SZTki/lCdS7MxWmYtmbA=','2025-08-14 16:03:56.537885',1,'CROBLE','','','auxsistemas@cootep.com.co',0,1,'2024-11-19 19:58:46.170659','1006742709','CRISTIAN MANUEL ROBLES','MOCOA'),(20,'pbkdf2_sha256$870000$vREznbu3ZEvLEuuBg3s64z$dV/NO0blQhrFjHQ7MfF7nB8Fec39Jg5cziv/ycgaDkI=',NULL,0,'DTORRES','','','asistente.oym@cootep.com.co',0,1,'2024-11-19 19:58:46.701338','1117550697','DANNY YULIETH TORRES CASTRO','MOCOA'),(21,'pbkdf2_sha256$870000$IQMWCYzLlAAebhchc8rVGz$BFlBkj/otqiNtZbAlXGeQdCnWO27eo+1/iP012NXvVw=',NULL,0,'MQUENA','','','asesorapuertoasis@cootep.com.co',0,1,'2024-11-19 19:58:47.233119','39842101','DEYVY MILENA MUÑOZ QUENAN','PUERTO ASIS'),(22,'pbkdf2_sha256$870000$9VEQAJdgTwP6MCQkexoVyR$OYwg8n6pUZHY7XWNVk6pJCEZlV73uYj9SR+9VV9oqqs=',NULL,0,'DACERO','','','subgerencia@cootep.com.co',0,1,'2024-11-19 19:58:47.774399','69009123','DIANA ALEJANDRA ACERO CARRILLO','MOCOA'),(23,'pbkdf2_sha256$870000$ggY1zMbWuhyZtjIjwLQxdr$DzmRwk2q8W4dKMrpISluSpOjSUIVJ8sdMPkpG7xDels=',NULL,0,'DREYES','','','diana.reyes@cootep.com.co',0,1,'2024-11-19 19:58:48.296768','1122782471','DIANA EMILSE REYES SOLARTE','SIBUNDOY'),(24,'pbkdf2_sha256$1000000$LIxofdUYeFMzvXO4A9fjOA$Zns63sLnUV1ex3R/Izatc3JZXIfv5brL19dBrZcJESQ=','2025-08-13 21:32:33.238901',0,'DCONGO','','','asistenteriesgos@cootep.com.co',0,1,'2024-11-19 19:58:48.829342','1006850170','DIANA YADIRA CONGOTE ANDRADE','MOCOA'),(25,'pbkdf2_sha256$1000000$AJd8x8eLq6RBmqNlV3SSlC$bgtTK2VxvtrqKlKeg+5nXXeQUsRFTFK4eXLHYrKqyRQ=','2025-08-14 15:23:40.530132',0,'XNARVA','','','auxleguizamo@cootep.com.co',0,1,'2024-11-19 19:58:49.360709','1122730223','EDNA XIMENA NARVAEZ RAMIREZ','PUERTO LEGUIZAMO'),(26,'pbkdf2_sha256$1000000$KDZ8zEUeeTJF85XzZDVf2X$twKCQ5LOmER9Y9Tc4DngWnVusEYsKzNeE7pwAUbSYgc=','2025-08-14 14:16:11.698861',0,'ECUARA','','','microcreditoorito@cootep.com.co',0,1,'2024-11-19 19:58:49.906098','1123322023','EDUARDO CUARAN TIPAZ','HORMIGA'),(27,'pbkdf2_sha256$1000000$yzu33lkGh3BiDgmLmOySuf$uKZRtCV8M4BQgE21cureSnx2EK37MK3FNtauFyxXz04=','2025-08-14 15:59:17.687710',0,'DPEREZ','','','coordinadordorada@cootep.com.co',0,1,'2024-11-19 19:58:50.436541','1126453097','JERSON DAVID SOLARTE PEREZ','PUERTO ASIS'),(28,'pbkdf2_sha256$870000$oruARO8RjBLqUP3o3VvntG$jA9tAq+Vb4xMiWfr056b16g4OLF3qwKSE136yY3imQg=',NULL,0,'MAELV','','','saludocupacional@cootep.com.co',0,1,'2024-11-19 19:58:50.977729','10754363','ELVER MAURICIO GRUESO VAINAS','MOCOA'),(29,'pbkdf2_sha256$870000$iDGqE2gZTozuXQuvHou3Sy$WQGTJUW4LHLWTpJe9rTbcuCy5q5Zg+CpumalYgQng48=',NULL,0,'FAGELO','','','jcomercial@cootep.com.co',0,1,'2024-11-19 19:58:51.505171','18128141','FABIAN LOPEZ GETIAL','MOCOA'),(30,'pbkdf2_sha256$1000000$jbLSlynK15NyVSxCu9tXJO$TTcslTO8emjKW/KLpXx3ySGtRQyTquYV5ukeg1/5Sk8=',NULL,0,'LBENAV','','','lauraalvarado9511@gmail.com',0,1,'2024-11-19 19:58:52.048903','1024668030','LAURA SOFIA ALVARADO BENAVIDES','MOCOA'),(31,'pbkdf2_sha256$870000$16kyd5BtnGXDywzRk1XxiC$766RUPuUu51dlkDQlc0sbRT1vN7Au8fYMfga8fo3/40=',NULL,0,'FOJEDA','','','asesormocoa5@cootep.com.co',0,1,'2024-11-19 19:58:52.580090','18127239','FAVIO NELSON OJEDA GOMEZ','MOCOA'),(32,'pbkdf2_sha256$1000000$LMpF1zGRIDMS43tShcwTSS$FYL1lw/jEaX8V3nKKWrlLvW2nYE3nYAc/mYH7UFUXUw=','2025-08-14 14:44:36.291173',0,'FAGUIN','','','agenciaptoasis@cootep.com.co',0,1,'2024-11-19 19:58:53.114446','18188763','FREDDY ALBERTO GUINCHIN ESTRADA','PUERTO ASIS'),(33,'pbkdf2_sha256$1000000$oa5x56M5KL7UvOm6bPbOkR$aHaH6EtLVk+aWkm7rbGOtWMwTteJ2Tq8Qn7Px6lv3SQ=','2025-08-14 19:18:07.442791',0,'GRODRI','','','asesorhormiga2@cootep.com.co',0,1,'2024-11-19 19:58:53.656983','1085324417','GERLIN DUVAN RODRIGUEZ PORTILLO','HORMIGA'),(34,'pbkdf2_sha256$870000$43Axd191lq3vEWMKz7PZyC$TX7ETH7B7wt922vPQwBwcVjkQHjNITBk3+4/kNGXIEo=',NULL,0,'GECRUZ','','','microcreditohormiga@cootep.com.co',0,1,'2024-11-19 19:58:54.189571','97435734','GERMAN DARIO DE LA CRUZ CHAVEZ','HORMIGA'),(35,'pbkdf2_sha256$870000$isQTTfhHJ4d1rtQH9YSIxE$TiSGW0r1U80HVqsMXGbCywlz5If61aeETWpIbmTYqsY=',NULL,0,'GLADAP','','','microcreditopuerto@cootep.com.co',0,1,'2024-11-19 19:58:54.731261','69022300','GLADIS YANET APRAEZ TAPIAS','PUERTO ASIS'),(36,'pbkdf2_sha256$870000$uGLXcRgpXU1OtQl56YPiuX$tpFd3uAx6W4Xzz2PxDb8qZMGx2wIadRw++SDQp+9Ce4=',NULL,0,'HPARRA','','','auxcontabilidad@cootep.com.co',0,1,'2024-11-19 19:58:55.267461','1007394461','HERNAN ANTURY PARRA','MOCOA'),(37,'pbkdf2_sha256$870000$4uPBAZEosd1gofLDKUZZvh$N2Gv5NgoRIhhKUW4BydM8nCZdAECx1zaJ0LSCFcjta0=',NULL,0,'HBURBA','','','agenciasibundoy@cootep.com.co',0,1,'2024-11-19 19:58:55.813246','97471182','HERNAN FROILAN BURBANO CAICEDO','SIBUNDOY'),(38,'pbkdf2_sha256$870000$W2D13NMFXRknbY4vpnsscU$wMa2sE2fO8YV7ugkmnb0gjyeaf7MeAUHkeV6SJn4Cuc=',NULL,0,'HGUTIE','','','asistentecartera@cootep.com.co',0,1,'2024-11-19 19:58:56.342861','1124853742','HOLMER GUTIERREZ URBANO','MOCOA'),(39,'pbkdf2_sha256$870000$tODFk4iDpRFBco53zvOXup$ntTBjQOe03bw/FbYu9WOKhDiGED31fYdIFyNmuGTo1g=',NULL,0,'IOBAND','','','tesoreria@cootep.com.co',0,1,'2024-11-19 19:58:56.877215','69006967','IRMA YOLANDA OBANDO MORA','MOCOA'),(40,'pbkdf2_sha256$870000$AdJfdiGxcDdY4A4TFe2HgB$f6yTm5BNwvsM6z5tKhkKOSuKII5OgBGt/1zirY9/U4o=',NULL,0,'JGUERR','','','jaider.guerra@cootep.com.co',0,1,'2024-11-19 19:58:57.412089','1126451813','JAIDER ALFONSO GUERRA SANCHEZ','HORMIGA'),(41,'pbkdf2_sha256$870000$8iohyFHTi1jKcl8W5MdzXy$F8eNR/bUFlNBeatkBOvA4FYAaEi/mnLWWtlsFQv8e6E=',NULL,1,'JROCER','','','sistemas@cootep.com.co',0,1,'2024-11-19 19:58:57.946449','18129474','JAIME FERNANDO ROSERO SANCHEZ','MOCOA'),(42,'pbkdf2_sha256$870000$1PNnpeGYdYHGZLzB9QjBiX$YTcl7gy9j0uuq4QFrfTdzXSNLdVNRejkD7bUWRGT3v8=',NULL,0,'OROSER','','','olmedoacosta@outlook.com',0,1,'2024-11-19 19:58:58.471356','1124863480','JAVIER OLMEDO ACOSTA ROSERO','MOCOA'),(43,'pbkdf2_sha256$1000000$JGaq7md5aSQd0LS6Bcdc8A$TheEF/2cX3a4eXCk9gpDSl4Wal43Gc4qBr615NMyNwU=','2025-08-14 18:55:00.635255',0,'YVARGA','','','auxiliarptoasis2@cootep.com.co',0,1,'2024-11-19 19:58:59.007232','1123207286','JEIMY KATERINE VARGAS ARENAS','PUERTO ASIS'),(44,'pbkdf2_sha256$1000000$vDdPkrVtGdKRYhixOOMC8f$LPTyOWQNRZ2cwX+rldyalInNrhIL69FQ8yrO6CUF3N0=','2025-08-14 18:55:52.515600',0,'JORTIZ','','','coordinadorsibundoy@cootep.com.co',0,1,'2024-11-19 19:58:59.543885','69007865','JENNY MARINA ORTIZ CARLOSAMA','SIBUNDOY'),(45,'pbkdf2_sha256$870000$gsH5oL8hhIDmW7vZjwbKT0$GrQN3Bz3bQgmEMua36W94F6rwicO9E0re100LsUz2Cw=',NULL,0,'JGARCI','','','auditoria@cootep.com.co',0,1,'2024-11-19 19:59:00.083495','18126921','JESUS ALBERTO GARCIA MUÑOZ','MOCOA'),(46,'pbkdf2_sha256$870000$xmTwhuyV9CY9bw3ljRMdyK$7hXkuZFOoBLpEOgppQD3C1yZaSIt2KDg7rKz3SESLRs=',NULL,0,'JRIASC','','','organizacionymetodos@cootep.com.co',0,1,'2024-11-19 19:59:00.622943','1124862723','JHAN BRANDON RIASCOS MARTINEZ','MOCOA'),(47,'pbkdf2_sha256$870000$JJi0DSuLY64fPV6Q6gamtM$5jtahAtdWXfAze0Vf/rFwg1TeRzEP/Fm0ewkDeHOpfk=',NULL,0,'JMORAL','','','auxiliarptoasis4@cootep.com.co',0,1,'2024-11-19 19:59:01.156084','1123209938','JOHANA MARITZA MORALES CARDENAS','PUERTO ASIS'),(48,'pbkdf2_sha256$870000$zZLPEjzU33fToefBNgE021$v5BG4wI9skSfL5ibrki279RgJfWChAiBaRyrtLZrWF0=',NULL,0,'JOMAPE','','','talentohumano@cootep.com.co',0,1,'2024-11-19 19:59:01.689818','1124315666','JONATHAN MAURICIO PEJENDINO ROSERO','SIBUNDOY'),(49,'pbkdf2_sha256$1000000$QsSea9PCqRX2YTEgCafthc$oTIzw92RHhHB90jbxOok3eq2+VMVb3jeeSJiPO8PQjE=','2025-08-13 21:22:24.084054',0,'JDELGA','','','karen.delgado@cootep.com.co',0,1,'2024-11-19 19:59:02.223386','1006847385','KAREN JACKELINE CAMPAÑA DELGADO','ORITO'),(50,'pbkdf2_sha256$870000$l0vfaD9cCPuALqFF8SzUkQ$MW6fTfxgoQlUld3SwvnyJE/NqpZhHUfN3ZapSwHjMAo=',NULL,0,'KAVILL','','','juridico@cootep.com.co',0,1,'2024-11-19 19:59:02.755078','1061746233','KAREN LILIANA VILLOTA HERNANDEZ','MOCOA'),(51,'pbkdf2_sha256$870000$glc43sjCFIJcph8VsfcEg1$liPjenX+iarEDRGjh+6miut4cjpW+oyhAXaDpTUs/PY=',NULL,0,'KGUERR','','','asesorptoasis5@cootep.com.co',0,1,'2024-11-19 19:59:03.284881','1075246591','KELY MABEL GUERRERO LAZO','PUERTO ASIS'),(52,'pbkdf2_sha256$870000$vodUbAXhIk29EBK33ik8jv$18jbk8wUq5BzCzbHETqa5xcmFbWjNLqClIbMamjnXFg=',NULL,0,'CGALA','','','oficialdecumplimiento@cootep.com.co',0,1,'2024-11-19 19:59:03.820698','1124860932','KEVIN CAMILO GALARRAGA CORDOBA','MOCOA'),(53,'pbkdf2_sha256$1000000$qVTA31OmNB4TelDtvj6I9E$G7tfBHLBw1xlYheTKplNMO7qNGJ3mPKqqgrzcUNe+ik=','2025-08-13 22:02:03.602742',0,'KPANTO','','','karolina.pantoja@cootep.com.co',0,1,'2024-11-19 19:59:04.347864','1127072952','LICETH KAROLINA PANTOJA MORA','VILLA GARZON'),(54,'pbkdf2_sha256$870000$glxfM59f0UoGUjApoDDO7X$MBtSowRn3sO/Dx+/cb5hlpDAM2C+3GVYUCcQUHIHzYU=',NULL,0,'LHERRE','','','cartera@cootep.com.co',0,1,'2024-11-19 19:59:04.889584','1124857537','LORENA LISETH HERRERA MONCAYO','MOCOA'),(55,'pbkdf2_sha256$1000000$43pZK5sVl9nL5NxBJy77CT$+aP6EnJNC2tDI1VOchdghBUDcMDH64xhvgIeAnsFTXA=','2025-08-14 20:32:34.105812',0,'LCHAMO','','','asesordorada1@cootep.com.co',0,1,'2024-11-19 19:59:05.420079','1006997143','LORENA LISSETH PAZ CHAMORRO','DORADA'),(56,'pbkdf2_sha256$870000$5jOspJcrNGMWNZPCjozblm$DK0PDkMOadPnnPbxmTWo9VPDM6qSL3GZTazGUCJzgTA=',NULL,0,'LJAMAU','','','luis.jamauca@cootep.com.co',0,1,'2024-11-19 19:59:05.987007','1124860712','LUIS JAIDE JAMAUCA CORREA','MOCOA'),(57,'pbkdf2_sha256$870000$no26P7r5EPy8NRsdjODdfF$xCUnV8l5cLjitA8vQCwGFqV2Epu3kvLicPQlhSwPnCY=',NULL,0,'FCRIOL','','','secretaria@cootep.com.co',0,1,'2024-11-19 19:59:06.521129','1124855204','LUISA FERNANDA CUERO CRIOLLO','MOCOA'),(58,'pbkdf2_sha256$870000$n88Ma8ogQ2uBV3Ci6G8WsA$o8D66eFba938sxkhn42W1oxX0GFaDhKApJ8xNFntmgQ=',NULL,0,'MSANAB','','','agencialeguizamo@cootep.com.co',0,1,'2024-11-19 19:59:07.060629','26638355','MAGDA JOHANA SANABRIA TEJADA','PUERTO LEGUIZAMO'),(59,'pbkdf2_sha256$870000$4HodVfKOVN9e4ZeBv8eOF2$lBLLYcdGBKpog58wLivhZnct0CgbX/+vd++WiggVq6o=',NULL,0,'ODIAZ','','','archivo@cootep.com.co',0,1,'2024-11-19 19:59:07.589254','69005166','MARIA OLGA DIAZ','MOCOA'),(60,'pbkdf2_sha256$1000000$t8hx2lzHNjRpD71LM1F2AZ$NE7xmgaviMPp9epjO3vOFpt/wsRfw/vuS7wG2E6hXHw=','2025-08-14 16:35:14.712850',0,'MARDUE','','','asistente.auditoria@cootep.com.co',0,1,'2024-11-19 19:59:08.132342','1124858256','MARIO STEBAN DUEÑAS DE LA CRUZ','MOCOA'),(61,'pbkdf2_sha256$870000$VrHlNy0w5fGwWOHcAgSjPM$Tddw7AZR9rheJ278gA1ZgpFnfN+CNqggxETnN4YIrAE=',NULL,0,'MGUERR','','','auxcartera01@cootep.com.co',0,1,'2024-11-19 19:59:08.673260','69006070','MARY LUCY GUERRON MADROÑERO','MOCOA'),(62,'pbkdf2_sha256$1000000$o4TfrWhsakF3PTbdPqS8Vb$+RLK70nVKqY3L0B6DjP2XAFRbPmyB201QmWWpmdW5b4=','2025-08-14 19:26:32.115846',1,'MYELA','','','soportesistemas@cootep.com.co',0,1,'2024-11-19 19:59:09.207806','1124857729','MICHAEL YELA VALENCIA','MOCOA'),(63,'pbkdf2_sha256$870000$dbYWuhuy2hfSDWpeHBu11a$2tGJGa8x6tMdAoQS8p1ApDDjzfu7TxJ//korxrnbAKM=',NULL,0,'MIPOCA','','','operacionesmocoa@cootep.com.co',0,1,'2024-11-19 19:59:09.749141','69009529','MYRIAM MILENA PORTILLO CASTRO','MOCOA'),(64,'pbkdf2_sha256$870000$uiUmeK8USfoAnb2fbQ1fdZ$aB2j4q1DvY8QlBERewn52VsqoQpBpZLZvyY6bRafaLE=',NULL,0,'NPIMEN','','','auxiliarleguizamo@cootep.com.co',0,1,'2024-11-19 19:59:10.286382','1122728836','NASSON PIMENTEL CRIOLLO','PUERTO LEGUIZAMO'),(65,'pbkdf2_sha256$870000$R6nReRerUnCAUK40MxogGJ$/LUsqdceDxVfIUBQNVwEydJWwsW5Dg5+y/e5LNNAlp0=',NULL,0,'JVILLA','','','johana1201@gmail.com',0,1,'2024-11-19 19:59:10.819639','1123308832','NINFA JHOJANA CANAMEJOY VILLAMUES','PUERTO ASIS'),(66,'pbkdf2_sha256$870000$fEo02PW6qoYBdWBjxgT5CQ$+UROCRYV7+KoEurhfQOuGGqK1/7fmS820saOdsKjy6I=',NULL,0,'ANARVA','','','auxiliarmocoa2@cootep.com.co',0,1,'2024-11-19 19:59:11.347712','1124863619','OSWALDO ALEJANDRO NARVAEZ ARAUJO','MOCOA'),(67,'pbkdf2_sha256$870000$19TYwVXMGcWJ2QqleycDG9$4N5ZVWe4tYbLl1/UfgbiFkzzDeoGYTpGf2pExS5Vg9w=',NULL,0,'RMALUA','','','gerencia@cootep.com.co',0,1,'2024-11-19 19:59:11.881572','69007052','RAQUEL MALUA SAYALPUD','MOCOA'),(68,'pbkdf2_sha256$1000000$AMeBkD0QvJB8FqYd1OVGME$lyvkcjdDBRwDOUQakKnlRAk5LFKirRKRGom8HMpLjgc=','2025-08-14 19:51:42.052051',0,'ASOLAR','','','asesorhormiga1@cootep.com.co',0,1,'2024-11-19 19:59:12.407067','1126448136','RUTH ALEIDA CUARAN SOLARTE','HORMIGA'),(69,'pbkdf2_sha256$1000000$yJd1RlFSJ2Z2dLoma2m25K$3+GgEuo8cFI7DulL1SXdUe7AcTfLdJv9espxgAm+crU=','2025-08-14 19:21:47.644969',0,'SCUBIL','','','asesorhormiga3@cootep.com.co',0,1,'2024-11-19 19:59:12.934974','53931401','SONIA YANETH CUBILLOS BELTRAN','HORMIGA'),(70,'pbkdf2_sha256$870000$KeSZMXeFObYtvgDJS4xxCB$Nv65gmyuYTS5hsQZrUcECdS21FM16akxjLQ+UR2cvoE=',NULL,0,'WMARC','','','wilbertmarcialperez@gmail.com',0,1,'2024-11-19 19:59:13.460666','1122723272','WILBER MARCIAL PEREZ MAYTAHUARI','PUERTO LEGUIZAMO'),(71,'pbkdf2_sha256$1000000$ycneUYB0mIVq2DVjqoo8Jo$S708Tb3RUmNI6mcT+D/gkSMxroaVjOlGxyhHFGCqMwc=','2025-08-13 22:15:27.670078',0,'WMOREN','','','oficialseguridad@cootep.com.co',0,1,'2024-11-19 19:59:13.989500','1123202174','WILMER MORENO ESTRADA','MOCOA'),(72,'pbkdf2_sha256$870000$iwEUt8san8PSGXq7LB7mcz$tvYe9SQ5hO8sgILq+Wyh414fWPrFPXVU7a4Cg6MNk9Y=',NULL,0,'YMOREN','','','auxiliarptoasis1@cootep.com.co',0,1,'2024-11-19 19:59:14.520144','1006664783','YERZON DUVAN MORENO SANCHEZ','PUERTO ASIS'),(73,'pbkdf2_sha256$870000$xumzJ1iqOgHOFSMpqzZ4db$Q3hBY1wTTcj8p4M98dE82kPEILqGab0IpnYk9kRSsWs=',NULL,0,'YORDON','','','agenciadorada@cootep.com.co',0,1,'2024-11-19 19:59:15.066682','1026145875','YESICA OBANDO ORDOÑEZ','DORADA'),(74,'pbkdf2_sha256$870000$bMiBSyW8VUfug1Z3GPxz2k$BWGbbYfD5/2y/s8+ryhNqgBEGD3OJ5tzYP17yCyp6Ec=',NULL,0,'YHENAO','','','asistentecomercial@cootep.com.co',0,1,'2024-11-19 19:59:15.596739','1124851488','YUDY ANDREA HENAO LOPEZ','MOCOA'),(75,'pbkdf2_sha256$870000$Oa34fJx9BToUizmP0zwd24$7JSH/fN7U/Ac9K1LCdy+kyMPx7Z5LFHuTrGwV2ub91U=',NULL,0,'YRODRI','','','coordinadororito@cootep.com.co',0,1,'2024-11-19 19:59:16.140247','69020695','YURANY DEL PILAR RODRIGUEZ CEBALLOS','ORITO');
/*!40000 ALTER TABLE `users_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user_groups`
--

DROP TABLE IF EXISTS `users_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_groups_user_id_group_id_b88eab82_uniq` (`user_id`,`group_id`),
  KEY `users_user_groups_group_id_9afc8d0e_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_user_groups_group_id_9afc8d0e_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `users_user_groups_user_id_5f6f5a90_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user_groups`
--

LOCK TABLES `users_user_groups` WRITE;
/*!40000 ALTER TABLE `users_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user_user_permissions`
--

DROP TABLE IF EXISTS `users_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_user_permissions_user_id_permission_id_43338c45_uniq` (`user_id`,`permission_id`),
  KEY `users_user_user_perm_permission_id_0b93982e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `users_user_user_perm_permission_id_0b93982e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `users_user_user_permissions_user_id_20aca447_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user_user_permissions`
--

LOCK TABLES `users_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `users_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-14 22:33:07
