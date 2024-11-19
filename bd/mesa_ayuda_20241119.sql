-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: mesa_ayuda_pruebas2
-- ------------------------------------------------------
-- Server version	8.0.40-0ubuntu0.22.04.1

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
INSERT INTO `django_session` VALUES ('usritjjq9ak3e9617llg1i31yexlijef','.eJxVjEEOwiAQRe_C2hAYQKhL9z0DmWFAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERWpx-N8L0yG0HfMd2m2Wa27pMJHdFHrTLceb8vB7u30HFXr-1Cinls2FDGpRPFoALgidtzZA1YAikCrDDQRkOSYMlR0GjsiU7H0C8P9xdN4U:1t4M6H:CLASaiWaAJusMpVeBb9oXPAZ5IZdbyXWk_S-Q36osk8','2024-10-25 15:29:41.432678');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requerimientos_detallerequerimiento`
--

LOCK TABLES `requerimientos_detallerequerimiento` WRITE;
/*!40000 ALTER TABLE `requerimientos_detallerequerimiento` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requerimientos_requerimiento`
--

LOCK TABLES `requerimientos_requerimiento` WRITE;
/*!40000 ALTER TABLE `requerimientos_requerimiento` DISABLE KEYS */;
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
INSERT INTO `users_user` VALUES (1,'pbkdf2_sha256$870000$8Jy5DPQA4O6rFCr7BACIbn$ztnHQgjOFPKl+zRmX5psobCLH9lUoeakEsM0dB6+nBQ=','2024-11-19 19:57:13.833113',1,'admin11','','','soportesistemas@cootep.com.co',1,1,'2024-10-25 15:19:04.409796','','',''),(2,'pbkdf2_sha256$870000$9xuShYyM08qM4ZzGNJgpMV$7icsE7F7x8+CudxRDEuZlr1aDM5Hci4z0QrnSseqSvs=',NULL,0,'ACHAMO','','','credito@cootep.com.co',0,1,'2024-11-19 19:58:37.063086','18129966','ALFREDO RICARDO CHAMORRO BURBANO','MOCOA'),(3,'pbkdf2_sha256$870000$NwqxWQRBF6iYAUIdoZs4Qg$MTx38RSstDS9WHSqUb8KEjrHtpIVS3rfx8WPc6SnP8Y=',NULL,0,'ACAICE','','','agenciaorito@cootep.com.co',0,1,'2024-11-19 19:58:37.622178','41107839','AMILDA BERENICE CAICEDO CAICEDO','ORITO'),(4,'pbkdf2_sha256$870000$PzzrjKJNmvZiTZnxrgHXN9$RhSCc8WyMGXNV4DyVEsYEyn2bp3oWDMFVggrSwMY150=',NULL,0,'ASEGUR','','','agenciahormiga@cootep.com.co',0,1,'2024-11-19 19:58:38.154296','69029569','ANA MARLY SEGURA DIAZ','HORMIGA'),(5,'pbkdf2_sha256$870000$v83leKsCLQi3unxzumDEgD$j+prfHH6Zakhmry+16mzD1sfNXrcDAFdqeKKSLx08hU=',NULL,0,'MIRUAN','','','ana.ruano@cootep.com.co',0,1,'2024-11-19 19:58:38.687909','27389048','ANA MILENA RUANO CHAMORRO','HORMIGA'),(6,'pbkdf2_sha256$870000$TWSAiEgGE3i945ULOWKuL1$TUrH1VMjXtYUSA+pblhB9EtLsoMuPx+D9qDkVnOGV+E=',NULL,0,'AROSER','','','contabilidad@cootep.com.co',0,1,'2024-11-19 19:58:39.218828','69008647','ANA VIKY ROSERO ADARME','MOCOA'),(7,'pbkdf2_sha256$870000$F6XFKMcQHMxDtbUA72HXTD$Ee+9e8HjhX7PX/Mob5hXj1R/n3srpcEjT5CBPB3PR/s=',NULL,0,'ANVER','','','asiscontabilidad@cootep.com.co',0,1,'2024-11-19 19:58:39.760322','1124863181','ANDREA CAROLINA VERDUGO BENAVIDES','MOCOA'),(8,'pbkdf2_sha256$870000$9ZuKspybZTvhhsxA1O957M$lDVnE+uclZLZ6xFHrumKSX/7EaYCclGh0jx4pVIU1jk=',NULL,0,'DVALLE','','','asesororito1@cootep.com.co',0,1,'2024-11-19 19:58:40.289559','1006849014','ANDREA DANIELA VALLEJOS PULIDO','ORITO'),(9,'pbkdf2_sha256$870000$fK5Gf1LWDprOxVYnogZYa4$IchQH4fTJjdssPbkChGmTO9J5DXjDokHpate0KtFxx8=',NULL,0,'AURBAN','','','atencionalcliente@cootep.com.co',0,1,'2024-11-19 19:58:40.832955','1124849667','ANGELA MILENA URBANO NARVAEZ','MOCOA'),(10,'pbkdf2_sha256$870000$CdEHZBPIu0CNG29KhEIvpU$1hq+ZyeYe3dF6yKRJBJDJNYvp3kF9j+gv9KDZDh6ovY=',NULL,0,'BGUERR','','','asesorsibundoy1@cootep.com.co',0,1,'2024-11-19 19:58:41.366741','1006815937','BRANDON DANILO GUERRERO JAJOY','SIBUNDOY'),(11,'pbkdf2_sha256$870000$PNjkH85W49xM6zewPOJA42$VZU09+Zsq8cMYJIMDKWk71uZxB6Lq6VCEnxuppR3vlI=',NULL,0,'ACARVA','','','asesormocoa6@cootep.com.co',0,1,'2024-11-19 19:58:41.908985','1124862382','ELIAS ADIRVEY GALVIS CARVAJAL','MOCOA'),(12,'pbkdf2_sha256$870000$P6Q5h1hcIMWPQzYutJvlfL$UtokAw4Hsb+MbQkxFZ84UfmZ0GbgJqw6pS8bdqy1/Q0=',NULL,0,'CAAZAM','','','corresponsalvillagarzon@cootep.com.co',0,1,'2024-11-19 19:58:42.446417','1127073033','CAMILO ALEJANDRO ZAMBRANO HERNANDEZ','VILLA GARZON'),(13,'pbkdf2_sha256$870000$N8WY7CjykHMMneJZThgsQV$WuKcHxYOMX5waUA3fv4NLcHoOXn2Z2J2NccUwuCrFcU=',NULL,0,'CCAICE','','','auxcaja01@cootep.com.co',0,1,'2024-11-19 19:58:42.983142','18126364','CARLOS HERNAN CAICEDO RAMOS','MOCOA'),(14,'pbkdf2_sha256$870000$amABRmYt7slXESYmpHSaP3$Mqtu5X1BTDLEYl3fW2EDJl+Or2flBRf9y4tuTfuh4Lo=',NULL,0,'IVAROM','','','agenciamocoa@cootep.com.co',0,1,'2024-11-19 19:58:43.506260','1113643270','CARLOS IVAN ROMERO BASTIDAS','MOCOA'),(15,'pbkdf2_sha256$870000$2LjIEPNaOIJFfWcCAVPTnN$9tsSNMhgBfgLHGaTDeiN/EI9kXxh69KmT30B4+Mtj6E=',NULL,0,'CGARCI','','','riesgos@cootep.com.co',0,1,'2024-11-19 19:58:44.044973','1122782313','CARLOS REINALDO GARCIA NASTAR','MOCOA'),(16,'pbkdf2_sha256$870000$2EV1CkrRlciFUOCBNU7Z8D$CGRCZFw2JEvQSKXY0fIYNYPi/jpHFJrU0S6JLA11lug=',NULL,0,'ANDHER','','','cesar.herrera@cootep.com.co',0,1,'2024-11-19 19:58:44.571643','1122339758','CESAR ANDRES HERRERA PAZ','DORADA'),(17,'pbkdf2_sha256$870000$PwDhWsBfpcMhJrJcXZPuJV$b4XHhJQVDDuej+5nWul7vqRJ496FUI9ZRTRK502hprI=',NULL,0,'CGAVIR','','','auxagenciapuerto@cootep.com.co',0,1,'2024-11-19 19:58:45.102018','69028001','CLAUDIA PAOLA GAVIRIA DIAZ','PUERTO ASIS'),(18,'pbkdf2_sha256$870000$6pNk817XxAKYMh9s5znzDf$RPzocSpRJJNf2xRKy13mj+Efug+a1IGthZystSizApM=',NULL,0,'CCORDO','','','asesordeservicios@cootep.com.co',0,1,'2024-11-19 19:58:45.634887','1124862242','CRISTHIAN ANDRES OLARTE CORDOBA','MOCOA'),(19,'pbkdf2_sha256$870000$bBiV6saLRJ1lsw2NET3Hs2$cYLAUjhJredeqZVNJFBcQ9zMVz0HMo1GI0XPB/r2i0E=',NULL,0,'CROBLE','','','auxsistemas@cootep.com.co',0,1,'2024-11-19 19:58:46.170659','1006742709','CRISTIAN MANUEL ROBLES','MOCOA'),(20,'pbkdf2_sha256$870000$vREznbu3ZEvLEuuBg3s64z$dV/NO0blQhrFjHQ7MfF7nB8Fec39Jg5cziv/ycgaDkI=',NULL,0,'DTORRES','','','asistente.oym@cootep.com.co',0,1,'2024-11-19 19:58:46.701338','1117550697','DANNY YULIETH TORRES CASTRO','MOCOA'),(21,'pbkdf2_sha256$870000$IQMWCYzLlAAebhchc8rVGz$BFlBkj/otqiNtZbAlXGeQdCnWO27eo+1/iP012NXvVw=',NULL,0,'MQUENA','','','asesorapuertoasis@cootep.com.co',0,1,'2024-11-19 19:58:47.233119','39842101','DEYVY MILENA MUNOZ QUENAN','PUERTO ASIS'),(22,'pbkdf2_sha256$870000$9VEQAJdgTwP6MCQkexoVyR$OYwg8n6pUZHY7XWNVk6pJCEZlV73uYj9SR+9VV9oqqs=',NULL,0,'DACERO','','','subgerencia@cootep.com.co',0,1,'2024-11-19 19:58:47.774399','69009123','DIANA ALEJANDRA ACERO CARRILLO','MOCOA'),(23,'pbkdf2_sha256$870000$ggY1zMbWuhyZtjIjwLQxdr$DzmRwk2q8W4dKMrpISluSpOjSUIVJ8sdMPkpG7xDels=',NULL,0,'DREYES','','','diana.reyes@cootep.com.co',0,1,'2024-11-19 19:58:48.296768','1122782471','DIANA EMILSE REYES SOLARTE','SIBUNDOY'),(24,'pbkdf2_sha256$870000$5dXLmaxWydEePmjSZu4DUN$dbAkccmaadOUq69Em5qoWaJLfBgdJrIXyVa8W86jikU=',NULL,0,'DCONGO','','','asistenteriesgos@cootep.com.co',0,1,'2024-11-19 19:58:48.829342','1006850170','DIANA YADIRA CONGOTE ANDRADE','MOCOA'),(25,'pbkdf2_sha256$870000$Nxy2djFStGcY6zN0GOD4ic$eW4DZkXbYec7v7hLB5f0ryNrpNospbXYw/0rS3KexUE=',NULL,0,'XNARVA','','','auxleguizamo@cootep.com.co',0,1,'2024-11-19 19:58:49.360709','1122730223','EDNA XIMENA NARVAEZ RAMIREZ','PUERTO LEGUIZAMO'),(26,'pbkdf2_sha256$870000$1ubPVTnx3pmLwpWykLgR4b$WLwf7OIa70SkT3FR+JNQJi0IHQks2rdbVaHyPV+sFjg=',NULL,0,'ECUARA','','','microcreditoorito@cootep.com.co',0,1,'2024-11-19 19:58:49.906098','1123322023','EDUARDO CUARAN TIPAZ','HORMIGA'),(27,'pbkdf2_sha256$870000$k5cDjwaEQXmjy7xcR0wxfl$ggAnaH6UfRa6aKHrEfftXnrqmeSLxEKAxDUPSqhdHLk=',NULL,0,'DPEREZ','','','auxiliarptoasis2@cootep.com.co',0,1,'2024-11-19 19:58:50.436541','1126453097','SOLARTE PEREZ JERSON DAVID','PUERTO ASIS'),(28,'pbkdf2_sha256$870000$oruARO8RjBLqUP3o3VvntG$jA9tAq+Vb4xMiWfr056b16g4OLF3qwKSE136yY3imQg=',NULL,0,'MAELV','','','saludocupacional@cootep.com.co',0,1,'2024-11-19 19:58:50.977729','10754363','ELVER MAURICIO GRUESO VAINAS','MOCOA'),(29,'pbkdf2_sha256$870000$iDGqE2gZTozuXQuvHou3Sy$WQGTJUW4LHLWTpJe9rTbcuCy5q5Zg+CpumalYgQng48=',NULL,0,'FAGELO','','','jcomercial@cootep.com.co',0,1,'2024-11-19 19:58:51.505171','18128141','FABIAN LOPEZ GETIAL','MOCOA'),(30,'pbkdf2_sha256$870000$PJaR2bkCtANe1TZt9RW1sV$3K8t9TwJipj/fnTFtWZ4MJKb7/ez9OGxT0Cc8sAIYkg=',NULL,0,'FSOLAR','','','gsolarte@cootep.com.co',0,1,'2024-11-19 19:58:52.048903','30736113','FANNY GLORIA SOLARTE JARAMILLO','MOCOA'),(31,'pbkdf2_sha256$870000$16kyd5BtnGXDywzRk1XxiC$766RUPuUu51dlkDQlc0sbRT1vN7Au8fYMfga8fo3/40=',NULL,0,'FOJEDA','','','asesormocoa5@cootep.com.co',0,1,'2024-11-19 19:58:52.580090','18127239','FAVIO NELSON OJEDA GOMEZ','MOCOA'),(32,'pbkdf2_sha256$870000$uTJsNYreo8u8tz7W7FKKiu$iEcvca94atdr0aQHOKiBeDjY8RQVXrxQ5vKHi2zOUKE=',NULL,0,'FAGUIN','','','agenciaptoasis@cootep.com.co',0,1,'2024-11-19 19:58:53.114446','18188763','FREDDY ALBERTO GUINCHIN ESTRADA','PUERTO ASIS'),(33,'pbkdf2_sha256$870000$uCp9KoCJP7a6iJVVD8Dx9f$KpStcDUnJtb14gf2jWtakcxqjTaPof3OCddnJWbzGXQ=',NULL,0,'GRODRI','','','duvan.rodriguez@cootep.com.co',0,1,'2024-11-19 19:58:53.656983','1085324417','GERLIN DUVAN RODRIGUEZ PORTILLO','HORMIGA'),(34,'pbkdf2_sha256$870000$43Axd191lq3vEWMKz7PZyC$TX7ETH7B7wt922vPQwBwcVjkQHjNITBk3+4/kNGXIEo=',NULL,0,'GECRUZ','','','microcreditohormiga@cootep.com.co',0,1,'2024-11-19 19:58:54.189571','97435734','GERMAN DARIO DE LA CRUZ CHAVEZ','HORMIGA'),(35,'pbkdf2_sha256$870000$isQTTfhHJ4d1rtQH9YSIxE$TiSGW0r1U80HVqsMXGbCywlz5If61aeETWpIbmTYqsY=',NULL,0,'GLADAP','','','microcreditopuerto@cootep.com.co',0,1,'2024-11-19 19:58:54.731261','69022300','GLADIS YANET APRAEZ TAPIAS','PUERTO ASIS'),(36,'pbkdf2_sha256$870000$uGLXcRgpXU1OtQl56YPiuX$tpFd3uAx6W4Xzz2PxDb8qZMGx2wIadRw++SDQp+9Ce4=',NULL,0,'HPARRA','','','auxcontabilidad@cootep.com.co',0,1,'2024-11-19 19:58:55.267461','1007394461','HERNAN ANTURY PARRA','MOCOA'),(37,'pbkdf2_sha256$870000$4uPBAZEosd1gofLDKUZZvh$N2Gv5NgoRIhhKUW4BydM8nCZdAECx1zaJ0LSCFcjta0=',NULL,0,'HBURBA','','','agenciasibundoy@cootep.com.co',0,1,'2024-11-19 19:58:55.813246','97471182','HERNAN FROILAN BURBANO CAICEDO','SIBUNDOY'),(38,'pbkdf2_sha256$870000$W2D13NMFXRknbY4vpnsscU$wMa2sE2fO8YV7ugkmnb0gjyeaf7MeAUHkeV6SJn4Cuc=',NULL,0,'HGUTIE','','','auxiliarcobranza@cootep.com.co',0,1,'2024-11-19 19:58:56.342861','1124853742','HOLMER GUTIERREZ URBANO','MOCOA'),(39,'pbkdf2_sha256$870000$tODFk4iDpRFBco53zvOXup$ntTBjQOe03bw/FbYu9WOKhDiGED31fYdIFyNmuGTo1g=',NULL,0,'IOBAND','','','tesoreria@cootep.com.co',0,1,'2024-11-19 19:58:56.877215','69006967','IRMA YOLANDA OBANDO MORA','MOCOA'),(40,'pbkdf2_sha256$870000$AdJfdiGxcDdY4A4TFe2HgB$f6yTm5BNwvsM6z5tKhkKOSuKII5OgBGt/1zirY9/U4o=',NULL,0,'JGUERR','','','jaider.guerra@cootep.com.co',0,1,'2024-11-19 19:58:57.412089','1126451813','JAIDER ALFONSO GUERRA SANCHEZ','HORMIGA'),(41,'pbkdf2_sha256$870000$8iohyFHTi1jKcl8W5MdzXy$F8eNR/bUFlNBeatkBOvA4FYAaEi/mnLWWtlsFQv8e6E=',NULL,0,'JROCER','','','sistemas@cootep.com.co',0,1,'2024-11-19 19:58:57.946449','18129474','JAIME FERNANDO ROSERO SANCHEZ','MOCOA'),(42,'pbkdf2_sha256$870000$1PNnpeGYdYHGZLzB9QjBiX$YTcl7gy9j0uuq4QFrfTdzXSNLdVNRejkD7bUWRGT3v8=',NULL,0,'OROSER','','','olmedoacosta@outlook.com',0,1,'2024-11-19 19:58:58.471356','1124863480','JAVIER OLMEDO ACOSTA ROSERO','MOCOA'),(43,'pbkdf2_sha256$870000$GeXeKEK7iqCPKaODrnDJQM$Oj7dydfiuWsQhYL2TUg6ku89u7UnIJLfOc7rAGRGGM8=',NULL,0,'YVARGA','','','jeimykatevargas15@gmail.com',0,1,'2024-11-19 19:58:59.007232','1123207286','JEIMY KATERINE VARGAS ARENAS','PUERTO ASIS'),(44,'pbkdf2_sha256$870000$tH96Rdzq4PR3edeWhTCUpR$WXybwGI76r3PiJmAuLAyOu6TMerDwT4MGS/gv7IvsT0=',NULL,0,'JORTIZ','','','jenny.ortiz@cootep.com.co',0,1,'2024-11-19 19:58:59.543885','69007865','JENNY MARINA ORTIZ CARLOSAMA','SIBUNDOY'),(45,'pbkdf2_sha256$870000$gsH5oL8hhIDmW7vZjwbKT0$GrQN3Bz3bQgmEMua36W94F6rwicO9E0re100LsUz2Cw=',NULL,0,'JGARCI','','','auditoria@cootep.com.co',0,1,'2024-11-19 19:59:00.083495','18126921','JESUS ALBERTO GARCIA MU�OZ','MOCOA'),(46,'pbkdf2_sha256$870000$xmTwhuyV9CY9bw3ljRMdyK$7hXkuZFOoBLpEOgppQD3C1yZaSIt2KDg7rKz3SESLRs=',NULL,0,'JRIASC','','','organizacionymetodos@cootep.com.co',0,1,'2024-11-19 19:59:00.622943','1124862723','JHAN BRANDON RIASCOS MARTINEZ','MOCOA'),(47,'pbkdf2_sha256$870000$JJi0DSuLY64fPV6Q6gamtM$5jtahAtdWXfAze0Vf/rFwg1TeRzEP/Fm0ewkDeHOpfk=',NULL,0,'JMORAL','','','auxiliarptoasis4@cootep.com.co',0,1,'2024-11-19 19:59:01.156084','1123209938','JOHANA MARITZA MORALES CARDENAS','PUERTO ASIS'),(48,'pbkdf2_sha256$870000$zZLPEjzU33fToefBNgE021$v5BG4wI9skSfL5ibrki279RgJfWChAiBaRyrtLZrWF0=',NULL,0,'JOMAPE','','','microcreditosibundoy@cootep.com.co',0,1,'2024-11-19 19:59:01.689818','1124315666','JONATHAN MAURICIO PEJENDINO ROSERO','SIBUNDOY'),(49,'pbkdf2_sha256$870000$zrpjFEQO7ZbOlZLywLeuY5$HIu8YK3XXVOpi0RfpK0ufyrg/sPEhrMG8VMDipDSog8=',NULL,0,'JDELGA','','','karen.delgado@cootep.com.co',0,1,'2024-11-19 19:59:02.223386','1006847385','KAREN JACKELINE CAMPA�A DELGADO','ORITO'),(50,'pbkdf2_sha256$870000$l0vfaD9cCPuALqFF8SzUkQ$MW6fTfxgoQlUld3SwvnyJE/NqpZhHUfN3ZapSwHjMAo=',NULL,0,'KAVILL','','','juridico@cootep.com.co',0,1,'2024-11-19 19:59:02.755078','1061746233','KAREN LILIANA VILLOTA HERNANDEZ','MOCOA'),(51,'pbkdf2_sha256$870000$glc43sjCFIJcph8VsfcEg1$liPjenX+iarEDRGjh+6miut4cjpW+oyhAXaDpTUs/PY=',NULL,0,'KGUERR','','','carteraasis@cootep.com.co',0,1,'2024-11-19 19:59:03.284881','1075246591','KELY MABEL GUERRERO LAZO','PUERTO ASIS'),(52,'pbkdf2_sha256$870000$vodUbAXhIk29EBK33ik8jv$18jbk8wUq5BzCzbHETqa5xcmFbWjNLqClIbMamjnXFg=',NULL,0,'CGALA','','','auxsarlaft@cootep.com.co',0,1,'2024-11-19 19:59:03.820698','1124860932','KEVIN CAMILO GALARRAGA CORDOBA','MOCOA'),(53,'pbkdf2_sha256$870000$324aYD60GFy4SKrdK1zNnk$5JeymI7qY+i7saYCLsHndYVEyyeapnYi+QiIefz3yKY=',NULL,0,'KPANTO','','','karolina.pantoja@cootep.com.co',0,1,'2024-11-19 19:59:04.347864','1127072952','LICETH KAROLINA PANTOJA MORA','VILLA GARZON'),(54,'pbkdf2_sha256$870000$glxfM59f0UoGUjApoDDO7X$MBtSowRn3sO/Dx+/cb5hlpDAM2C+3GVYUCcQUHIHzYU=',NULL,0,'LHERRE','','','cartera@cootep.com.co',0,1,'2024-11-19 19:59:04.889584','1124857537','LORENA LISETH HERRERA MONCAYO','MOCOA'),(55,'pbkdf2_sha256$870000$FvlQlCHNsFvG7Gz10z7ZRA$0b1zBEmrDupLSzv7PKcRjv5feX4EsCzaBB7TWBYDHvk=',NULL,0,'LCHAMO','','','lorena.chamorro@cootep.com.co',0,1,'2024-11-19 19:59:05.420079','1006997143','LORENA LISSETH PAZ CHAMORRO','DORADA'),(56,'pbkdf2_sha256$870000$5jOspJcrNGMWNZPCjozblm$DK0PDkMOadPnnPbxmTWo9VPDM6qSL3GZTazGUCJzgTA=',NULL,0,'LJAMAU','','','luis.jamauca@cootep.com.co',0,1,'2024-11-19 19:59:05.987007','1124860712','LUIS JAIDE JAMAUCA CORREA','MOCOA'),(57,'pbkdf2_sha256$870000$no26P7r5EPy8NRsdjODdfF$xCUnV8l5cLjitA8vQCwGFqV2Epu3kvLicPQlhSwPnCY=',NULL,0,'FCRIOL','','','secretaria@cootep.com.co',0,1,'2024-11-19 19:59:06.521129','1124855204','LUISA FERNANDA CUERO CRIOLLO','MOCOA'),(58,'pbkdf2_sha256$870000$n88Ma8ogQ2uBV3Ci6G8WsA$o8D66eFba938sxkhn42W1oxX0GFaDhKApJ8xNFntmgQ=',NULL,0,'MSANAB','','','agencialeguizamo@cootep.com.co',0,1,'2024-11-19 19:59:07.060629','26638355','MAGDA JOHANA SANABRIA TEJADA','PUERTO LEGUIZAMO'),(59,'pbkdf2_sha256$870000$4HodVfKOVN9e4ZeBv8eOF2$lBLLYcdGBKpog58wLivhZnct0CgbX/+vd++WiggVq6o=',NULL,0,'ODIAZ','','','archivo@cootep.com.co',0,1,'2024-11-19 19:59:07.589254','69005166','MARIA OLGA DIAZ','MOCOA'),(60,'pbkdf2_sha256$870000$bhPZoQOVqVe1wNtsLpjR48$yA3TmkX3xqoW/sg3GElaMVRILu5c0LhUCQ6aLMlLfkk=',NULL,0,'MARDUE','','','asistente.auditoria@cootep.com.co',0,1,'2024-11-19 19:59:08.132342','1124858256','MARIO STEBAN DUE�AS DE LA CRUZ','MOCOA'),(61,'pbkdf2_sha256$870000$VrHlNy0w5fGwWOHcAgSjPM$Tddw7AZR9rheJ278gA1ZgpFnfN+CNqggxETnN4YIrAE=',NULL,0,'MGUERR','','','auxcartera01@cootep.com.co',0,1,'2024-11-19 19:59:08.673260','69006070','MARY LUCY GUERRON MADRO�ERO','MOCOA'),(62,'pbkdf2_sha256$870000$5Fsu700Ali9VJnoOsBSiGj$kNdt7f0HB7PoEaJDCFDLGjj93UErFnnP62y6FnMkIWQ=',NULL,0,'MYELA','','','soportesistemas@cootep.com.co',0,1,'2024-11-19 19:59:09.207806','1124857729','MICHAEL YELA VALENCIA','MOCOA'),(63,'pbkdf2_sha256$870000$dbYWuhuy2hfSDWpeHBu11a$2tGJGa8x6tMdAoQS8p1ApDDjzfu7TxJ//korxrnbAKM=',NULL,0,'MIPOCA','','','operacionesmocoa@cootep.com.co',0,1,'2024-11-19 19:59:09.749141','69009529','MYRIAM MILENA PORTILLO CASTRO','MOCOA'),(64,'pbkdf2_sha256$870000$uiUmeK8USfoAnb2fbQ1fdZ$aB2j4q1DvY8QlBERewn52VsqoQpBpZLZvyY6bRafaLE=',NULL,0,'NPIMEN','','','auxiliarleguizamo@cootep.com.co',0,1,'2024-11-19 19:59:10.286382','1122728836','NASSON PIMENTEL CRIOLLO','PUERTO LEGUIZAMO'),(65,'pbkdf2_sha256$870000$R6nReRerUnCAUK40MxogGJ$/LUsqdceDxVfIUBQNVwEydJWwsW5Dg5+y/e5LNNAlp0=',NULL,0,'JVILLA','','','johana1201@gmail.com',0,1,'2024-11-19 19:59:10.819639','1123308832','NINFA JHOJANA CANAMEJOY VILLAMUES','PUERTO ASIS'),(66,'pbkdf2_sha256$870000$fEo02PW6qoYBdWBjxgT5CQ$+UROCRYV7+KoEurhfQOuGGqK1/7fmS820saOdsKjy6I=',NULL,0,'ANARVA','','','auxiliarmocoa2@cootep.com.co',0,1,'2024-11-19 19:59:11.347712','1124863619','OSWALDO ALEJANDRO NARVAEZ ARAUJO','MOCOA'),(67,'pbkdf2_sha256$870000$19TYwVXMGcWJ2QqleycDG9$4N5ZVWe4tYbLl1/UfgbiFkzzDeoGYTpGf2pExS5Vg9w=',NULL,0,'RMALUA','','','gerencia@cootep.com.co',0,1,'2024-11-19 19:59:11.881572','69007052','RAQUEL MALUA SAYALPUD','MOCOA'),(68,'pbkdf2_sha256$870000$J3UZdvuYJygvGpMF2ATzKA$7YZ7PLUoC65Qm/tKl693BbzCLCAT4BvBYIE7LN6vJGw=',NULL,0,'ASOLAR','','','asesorhormiga1@cootep.com.co',0,1,'2024-11-19 19:59:12.407067','1126448136','RUTH ALEIDA CUARAN SOLARTE','HORMIGA'),(69,'pbkdf2_sha256$870000$fSCmgpEfjI2T66FiuGiV04$lOWWLiTjfWDPGdzgYqGP6Rh+Z9GrJRZRV7zy3NCkwz4=',NULL,0,'SCUBIL','','','sonia.cubillos@cootep.com.co',0,1,'2024-11-19 19:59:12.934974','53931401','SONIA YANETH CUBILLOS BELTRAN','HORMIGA'),(70,'pbkdf2_sha256$870000$KeSZMXeFObYtvgDJS4xxCB$Nv65gmyuYTS5hsQZrUcECdS21FM16akxjLQ+UR2cvoE=',NULL,0,'WMARC','','','wilbertmarcialperez@gmail.com',0,1,'2024-11-19 19:59:13.460666','1122723272','WILBER MARCIAL PEREZ MAYTAHUARI','PUERTO LEGUIZAMO'),(71,'pbkdf2_sha256$870000$z5Y8PQr4Uso7mnXFXicJI3$2z+trO/4d881tJPgcsTyw2kfenqsNoki6rcq5O4zRjQ=',NULL,0,'WMOREN','','','oficialseguridad@cootep.com.co',0,1,'2024-11-19 19:59:13.989500','1123202174','WILMER MORENO ESTRADA','MOCOA'),(72,'pbkdf2_sha256$870000$iwEUt8san8PSGXq7LB7mcz$tvYe9SQ5hO8sgILq+Wyh414fWPrFPXVU7a4Cg6MNk9Y=',NULL,0,'YMOREN','','','auxiliarptoasis1@cootep.com.co',0,1,'2024-11-19 19:59:14.520144','1006664783','YERZON DUVAN MORENO SANCHEZ','PUERTO ASIS'),(73,'pbkdf2_sha256$870000$xumzJ1iqOgHOFSMpqzZ4db$Q3hBY1wTTcj8p4M98dE82kPEILqGab0IpnYk9kRSsWs=',NULL,0,'YORDON','','','agenciadorada@cootep.com.co',0,1,'2024-11-19 19:59:15.066682','1026145875','YESICA OBANDO ORDONEZ','DORADA'),(74,'pbkdf2_sha256$870000$bMiBSyW8VUfug1Z3GPxz2k$BWGbbYfD5/2y/s8+ryhNqgBEGD3OJ5tzYP17yCyp6Ec=',NULL,0,'YHENAO','','','asistentecomercial@cootep.com.co',0,1,'2024-11-19 19:59:15.596739','1124851488','YUDY ANDREA HENAO LOPEZ','MOCOA'),(75,'pbkdf2_sha256$870000$Oa34fJx9BToUizmP0zwd24$7JSH/fN7U/Ac9K1LCdy+kyMPx7Z5LFHuTrGwV2ub91U=',NULL,0,'YRODRI','','','yurani.rodriguez@cootep.com.co',0,1,'2024-11-19 19:59:16.140247','69020695','YURANY DEL PILAR RODRIGUEZ CEBALLOS','ORITO');
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

-- Dump completed on 2024-11-19 15:00:43
