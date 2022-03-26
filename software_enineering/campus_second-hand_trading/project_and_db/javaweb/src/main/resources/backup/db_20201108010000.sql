-- MySQL dump 10.13  Distrib 5.6.22, for Win64 (x86_64)
--
-- Host: localhost    Database: db
-- ------------------------------------------------------
-- Server version	5.6.22-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `barter_comment`
--

DROP TABLE IF EXISTS `barter_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barter_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `content` varchar(1024) NOT NULL,
  `reply_to` varchar(64) DEFAULT NULL,
  `goods_id` bigint(20) DEFAULT NULL,
  `student_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKd13x6263vve7vpi8svtrrfqn6` (`goods_id`),
  KEY `FKc7lpfyok24cugnnu08xkm9e6t` (`student_id`),
  CONSTRAINT `FKc7lpfyok24cugnnu08xkm9e6t` FOREIGN KEY (`student_id`) REFERENCES `barter_student` (`id`),
  CONSTRAINT `FKd13x6263vve7vpi8svtrrfqn6` FOREIGN KEY (`goods_id`) REFERENCES `barter_goods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barter_comment`
--

LOCK TABLES `barter_comment` WRITE;
/*!40000 ALTER TABLE `barter_comment` DISABLE KEYS */;
INSERT INTO `barter_comment` VALUES (4,'2020-11-07 22:38:40','2020-11-07 22:38:40','你好，价格可以便宜一些嘛',NULL,11,1),(5,'2020-11-07 22:53:15','2020-11-07 22:53:15','可以再便宜点嘛',NULL,11,1),(6,'2020-11-08 00:16:16','2020-11-08 00:16:16','回复：“你好，价格可以便宜一些嘛\"<br>1111','zz',11,1);
/*!40000 ALTER TABLE `barter_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barter_database_bak`
--

DROP TABLE IF EXISTS `barter_database_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barter_database_bak` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `filename` varchar(32) NOT NULL,
  `filepath` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barter_database_bak`
--

LOCK TABLES `barter_database_bak` WRITE;
/*!40000 ALTER TABLE `barter_database_bak` DISABLE KEYS */;
INSERT INTO `barter_database_bak` VALUES (1,'2020-11-08 01:00:00','2020-11-08 01:00:00','db_20201108010000.sql','E:/javaweb/src/main/resources/backup/');
/*!40000 ALTER TABLE `barter_database_bak` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barter_goods`
--

DROP TABLE IF EXISTS `barter_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barter_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `buy_price` float NOT NULL,
  `content` varchar(1024) DEFAULT NULL,
  `flag` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `photo` varchar(128) NOT NULL,
  `recommend` int(11) NOT NULL,
  `sell_price` float NOT NULL,
  `status` int(11) NOT NULL,
  `goods_category_id` bigint(20) DEFAULT NULL,
  `student_id` bigint(20) DEFAULT NULL,
  `view_number` int(11) NOT NULL,
  `review` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9s4ngbaivk4vwtcjjhj47xh2t` (`goods_category_id`),
  KEY `FKi048jopympxuq3jbf9gckdrn8` (`student_id`),
  CONSTRAINT `FK9s4ngbaivk4vwtcjjhj47xh2t` FOREIGN KEY (`goods_category_id`) REFERENCES `barter_goods_category` (`id`),
  CONSTRAINT `FKi048jopympxuq3jbf9gckdrn8` FOREIGN KEY (`student_id`) REFERENCES `barter_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barter_goods`
--

LOCK TABLES `barter_goods` WRITE;
/*!40000 ALTER TABLE `barter_goods` DISABLE KEYS */;
INSERT INTO `barter_goods` VALUES (1,'2020-10-30 23:34:45','2020-11-06 22:39:52',1111,' 测试所用1111111111111\r\n                            ',0,'1111','20201030/1604072060303.jpg',1,1111,3,10,1,32,0),(2,'2020-10-31 11:33:33','2020-11-06 22:39:58',1,'刚买的，想来赚一手外块，看有没有傻子上当',1,'我的二手ihone','20201031/1604115153400.jpg',0,1000,3,11,1,8,0),(3,'2020-10-31 22:44:34','2020-11-04 16:05:59',1000,'新买的电脑，有钱任性，二手转让',0,'笔记本电脑','20201031/1604155420668.jpg',1,50,2,15,2,3,0),(5,'2020-11-01 13:40:41','2020-11-06 22:39:37',122,'看起来很清晰，带着很舒服，没有磨损',0,'眼镜','20201101/1604209176530.png',0,10,3,15,1,2,0),(6,'2020-11-01 15:50:17','2020-11-01 15:50:49',222,'                                111111111111111111111111111\r\n                            ',0,'chair','20201101/1604217003974.png',0,111,2,31,4,0,0),(7,'2020-11-04 17:31:03','2020-11-06 22:42:13',2312,'2312312333333333',0,'大表哥','20201104/1604482243181.png',0,3213,3,11,1,0,0),(8,'2020-11-05 17:10:41','2020-11-07 00:27:16',432423,'3422222222444444444',0,'431','20201105/1604567429347.png',0,432,1,10,1,1,0),(10,'2020-11-05 17:11:12','2020-11-07 00:27:24',23423,'4324244444444444',0,'4324','20201105/1604567462637.png',1,23423,1,11,1,0,0),(11,'2020-11-05 17:11:26','2020-11-08 00:49:16',3214,'32222222222222222222222222222',0,'241','20201105/1604567478541.png',0,342,1,10,1,147,0),(12,'2020-11-05 17:11:37','2020-11-07 00:33:11',234,'5555555555555555555',0,'42342','20201105/1604567490325.png',0,324,2,16,1,0,0),(13,'2020-11-05 17:11:55','2020-11-07 00:31:06',989,'999999999999999999999999',0,'87987','20201105/1604567504977.png',0,7987,2,16,1,13,0);
/*!40000 ALTER TABLE `barter_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barter_goods_category`
--

DROP TABLE IF EXISTS `barter_goods_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barter_goods_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `icon` varchar(32) DEFAULT NULL,
  `name` varchar(18) NOT NULL,
  `sort` int(11) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKkbi8714k65bs9dihfy4jc174w` (`parent_id`),
  CONSTRAINT `FKkbi8714k65bs9dihfy4jc174w` FOREIGN KEY (`parent_id`) REFERENCES `barter_goods_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barter_goods_category`
--

LOCK TABLES `barter_goods_category` WRITE;
/*!40000 ALTER TABLE `barter_goods_category` DISABLE KEYS */;
INSERT INTO `barter_goods_category` VALUES (6,'2020-10-27 23:12:15','2020-10-27 23:46:59','20201027/1603811524835.png','手机',0,NULL),(10,'2020-10-27 23:19:09','2020-10-27 23:48:04','20201027/1603811943971.png','手机配件',2,6),(11,'2020-10-27 23:47:16','2020-10-27 23:47:16','20201027/1603813629646.png','智能机',1,6),(12,'2020-10-27 23:47:57','2020-10-27 23:47:57','20201027/1603813671857.png','滑盖机',3,6),(13,'2020-10-27 23:48:27','2020-10-27 23:48:27','20201027/1603813696792.png','翻盖机',4,6),(14,'2020-10-27 23:48:52','2020-10-27 23:48:52','20201027/1603813719482.png','电脑',5,NULL),(15,'2020-10-27 23:49:10','2020-10-27 23:49:10','20201027/1603813745209.png','笔记本',6,14),(16,'2020-10-27 23:49:40','2020-10-27 23:49:40','20201027/1603813765314.png','台式机',7,14),(20,'2020-11-01 12:12:32','2020-11-01 12:53:05','20201101/1604203949247.jpg','图书',8,NULL),(23,'2020-11-01 12:16:05','2020-11-01 12:53:46','20201101/1604204161500.png','衣物',11,NULL),(24,'2020-11-01 12:16:45','2020-11-01 12:53:27','20201101/1604204195657.png','生活',12,NULL),(26,'2020-11-01 12:18:13','2020-11-01 12:53:36','20201101/1604204289659.png','交通',14,NULL),(28,'2020-11-01 12:19:26','2020-11-01 12:19:26','20201101/1604204360139.png','其他',16,NULL),(29,'2020-11-01 13:43:50','2020-11-01 13:43:50','20201101/1604209422966.png','计算机类',0,20),(30,'2020-11-01 13:44:48','2020-11-01 13:44:48','20201101/1604209476408.png','女装',0,23),(31,'2020-11-01 13:45:24','2020-11-01 13:45:24','20201101/1604209521475.png','日用品',0,24),(32,'2020-11-01 13:45:41','2020-11-01 13:45:41','20201101/1604209538980.png','自行车',0,26),(33,'2020-11-01 13:46:02','2020-11-01 13:46:02','20201101/1604209559418.png','其它',0,28);
/*!40000 ALTER TABLE `barter_goods_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barter_menu`
--

DROP TABLE IF EXISTS `barter_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barter_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `icon` varchar(32) DEFAULT NULL,
  `is_bitton` bit(1) NOT NULL,
  `is_show` bit(1) NOT NULL,
  `name` varchar(18) NOT NULL,
  `sort` int(11) NOT NULL,
  `url` varchar(128) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4gq2fatv8fkg65cbbmdl9ir8p` (`parent_id`),
  CONSTRAINT `FK4gq2fatv8fkg65cbbmdl9ir8p` FOREIGN KEY (`parent_id`) REFERENCES `barter_menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barter_menu`
--

LOCK TABLES `barter_menu` WRITE;
/*!40000 ALTER TABLE `barter_menu` DISABLE KEYS */;
INSERT INTO `barter_menu` VALUES (2,'2020-10-01 14:26:03','2020-11-01 10:57:54','mdi-settings','\0','','系统设置',0,'',NULL),(3,'2020-10-02 16:58:55','2020-11-01 18:26:02','mdi-view-list','\0','','菜单管理',1,'/admin/menu/list',2),(5,'2020-10-03 17:04:44','2020-11-01 18:27:53','mdi-plus','\0','','新增',2,'/admin/menu/add',3),(7,'2020-10-05 17:07:43','2020-11-01 12:11:25','mdi-account-settings-variant','\0','','角色管理',5,'/admin/role/list',2),(8,'2020-10-06 18:28:48','2020-11-01 22:04:45','mdi-grease-pencil','','','编辑',3,'edit(\'/admin/menu/edit\')',3),(9,'2020-10-07 18:30:00','2020-11-01 22:08:20','mdi-close','','','删除',4,'del(\'/admin/menu/delete\')',3),(10,'2020-10-08 12:12:00','2020-11-01 12:12:00','mdi-account-plus','\0','','添加',6,'/admin/role/add',7),(11,'2020-10-09 12:12:36','2020-11-01 22:10:45','mdi-account-edit','','','编辑',7,'edit(\'/admin/role/edit\')',7),(12,'2020-10-09 12:13:19','2020-11-01 22:15:27','mdi-account-remove','','','删除',8,'del(\'/admin/role/delete\')',7),(13,'2020-10-10 12:14:52','2020-11-01 12:17:00','mdi-account-multiple','\0','','用户管理',9,'/admin/user/list',2),(14,'2020-10-10 12:15:22','2020-11-01 12:17:27','mdi-account-plus','\0','','添加',10,'/admin/user/add',13),(15,'2020-10-11 17:18:14','2020-11-01 22:11:19','mdi-account-edit','','','编辑',11,'edit(\'/admin/user/edit\')',13),(16,'2020-10-11 17:19:01','2020-11-01 22:15:36','mdi-account-remove','','','删除',12,'del(\'/admin/user/delete\')',13),(19,'2020-10-12 11:24:36','2020-11-01 11:26:00','mdi-arrow-up-bold-circle','\0','\0','上传图片',0,'/admin/upload/upload_photo',13),(20,'2020-10-12 14:09:35','2020-11-01 14:09:47','mdi-tag-multiple','\0','','日志管理',13,'/system/operator_log_list',2),(21,'2020-10-12 14:11:39','2020-11-01 14:11:39','mdi-tag-remove','','','删除',14,'del(\'/system/delete_operator_log\')',20),(22,'2020-10-13 14:12:57','2020-11-01 14:46:55','mdi-delete-circle','','','清空日志',15,'delAll(\'/system/delete_all_operator_log\')',20),(23,'2020-10-14 14:46:40','2020-11-01 14:47:09','mdi-database','\0','','数据备份',16,'/admin/database_bak/list',2),(24,'2020-10-14 14:48:07','2020-11-01 15:13:41','mdi-database-plus','','','备份',17,'add(\'/admin/database_bak/add\')',23),(25,'2020-10-15 14:49:03','2020-11-01 14:49:03','mdi-database-minus','','','删除',18,'del(\'/admin/database_bak/delete\')',23),(26,'2020-10-15 19:36:20','2020-11-01 19:36:20','mdi-database-minus','','','还原',19,'restore(\'/database_bak/restore\')',23),(27,'2020-10-27 20:31:07','2020-10-27 20:31:07','mdi-dialpad','\0','','物品管理',0,'/admin/goods_category/list',NULL),(28,'2020-10-27 20:31:50','2020-10-27 20:31:50','mdi-android-head','\0','','分类管理',0,'/admin/goods_category/list',27),(30,'2020-10-27 20:36:21','2020-10-27 20:36:21','mdi-cart','\0','','物品管理',0,'/admin/goods/list',27),(31,'2020-10-27 20:39:46','2020-10-27 22:12:33','mdi-plus','\0','','添加',0,'/admin/goods_category/add',28),(32,'2020-10-27 20:41:11','2020-10-27 23:38:06','mdi-border-color','','','编辑',0,'edit(\'/admin/goods_category/edit\')',28),(33,'2020-10-27 20:42:21','2020-10-27 20:42:21','mdi-close','','','删除',0,'del(\'/admin/goods_category/delete\')',28),(34,'2020-11-03 22:03:29','2020-11-03 22:06:39','mdi-arrow-expand-up','','','上架',0,'up(\'/admin/goods/up_down\')',30),(35,'2020-11-03 22:04:48','2020-11-03 22:04:48','mdi-arrow-collapse-down','','','下架',0,'down(\'admin/goods/up_down\')',30),(36,'2020-11-03 22:06:14','2020-11-04 16:00:45','mdi-close-outline','','','删除',0,'del(\'/admin/goods/delete\')',30),(37,'2020-11-04 15:48:50','2020-11-04 15:48:50','mdi-thumb-up','','','推荐',0,'recommend(\'/admin/goods/recommend\')',30),(38,'2020-11-04 15:50:07','2020-11-07 00:14:19','mdi-thumb-down','','','取消推荐',0,'unrecommend(\'/admin/goods/recommend\')',30),(39,'2020-11-05 19:58:19','2020-11-05 19:58:19','mdi-account-multiple','\0','','学生管理',0,'/admin/student/list',NULL),(40,'2020-11-05 20:02:09','2020-11-05 20:02:09','mdi-account-multiple','\0','','学生列表',0,'/admin/student/list',39),(41,'2020-11-05 20:08:51','2020-11-05 20:08:51','mdi-account-key','','','冻结',0,'freeze(\'/admin/student/update_status\')',40),(42,'2020-11-05 20:11:36','2020-11-06 14:16:22','mdi-account-star','','','激活',0,'openStudent(\'/admin/student/update_status\')',40),(43,'2020-11-05 20:12:54','2020-11-05 20:12:54','mdi-account-multiple-minus','','','删除',0,'del(\'/admin/student/delete\')',40);
/*!40000 ALTER TABLE `barter_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barter_operater_log`
--

DROP TABLE IF EXISTS `barter_operater_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barter_operater_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `content` varchar(512) NOT NULL,
  `operator` varchar(18) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barter_operater_log`
--

LOCK TABLES `barter_operater_log` WRITE;
/*!40000 ALTER TABLE `barter_operater_log` DISABLE KEYS */;
INSERT INTO `barter_operater_log` VALUES (60,'2020-11-01 12:05:45','2020-11-01 12:05:45','用户【superuser】于【2020-11-01 12:05:45】登录系统！','superuser'),(61,'2020-11-01 12:06:54','2020-11-01 12:06:54','用户【superuser】于【2020-11-01 12:06:54】登录系统！','superuser'),(62,'2020-11-01 12:07:15','2020-11-01 12:07:15','数据库成功备份，备份文件信息：DatabaseBak [filename=db_20201101120715.sql, filepath=E:/javaweb/src/main/resources/backup/]','superuser'),(63,'2020-11-01 12:35:57','2020-11-01 12:35:57','用户【superuser】于【2020-11-01 12:35:57】登录系统！','superuser'),(64,'2020-11-01 12:36:47','2020-11-01 12:36:47','用户【superuser】于【2020-11-01 12:36:46】登录系统！','superuser'),(65,'2020-11-01 12:45:47','2020-11-01 12:45:47','用户【superuser】于【2020-11-01 12:45:47】登录系统！','superuser'),(66,'2020-11-01 12:46:37','2020-11-01 12:46:37','用户【superuser】于【2020-11-01 12:46:37】登录系统！','superuser'),(67,'2020-11-01 12:52:01','2020-11-01 12:52:01','用户【superuser】于【2020-11-01 12:52:01】登录系统！','superuser'),(68,'2020-11-01 13:20:18','2020-11-01 13:20:18','用户【superuser】于【2020-11-01 13:20:17】登录系统！','superuser'),(69,'2020-11-01 13:20:48','2020-11-01 13:20:48','用户【superuser】于【2020-11-01 13:20:48】登录系统！','superuser'),(70,'2020-11-01 13:20:54','2020-11-01 13:20:54','数据库成功备份，备份文件信息：DatabaseBak [filename=db_20201101132053.sql, filepath=C://Users/zz/IdeaProjects/javaweb/src/main/resources/backup/]','superuser'),(71,'2020-11-01 13:22:42','2020-11-01 13:22:42','用户【superuser】于【2020-11-01 13:22:42】登录系统！','superuser'),(72,'2020-11-01 13:42:54','2020-11-01 13:42:54','用户【superuser】于【2020-11-01 13:42:53】登录系统！','superuser'),(73,'2020-11-01 13:48:42','2020-11-01 13:48:42','添加用户，用户名：测试角色','superuser'),(74,'2020-11-01 13:49:04','2020-11-01 13:49:04','编辑用户，用户名：测试角色','superuser'),(75,'2020-11-01 14:22:29','2020-11-01 14:22:29','用户【superuser】于【2020-11-01 14:22:28】登录系统！','superuser'),(76,'2020-11-01 15:13:18','2020-11-01 15:13:18','用户【superuser】于【2020-11-01 15:13:17】登录系统！','superuser'),(77,'2020-11-01 15:13:50','2020-11-01 15:13:50','用户【superuser】于【2020-11-01 15:13:49】登录系统！','superuser'),(78,'2020-11-01 15:14:21','2020-11-01 15:14:21','添加用户，用户名：测试用户','superuser'),(79,'2020-11-01 15:52:16','2020-11-01 15:52:16','用户【superuser】于【2020-11-01 15:52:16】登录系统！','superuser'),(80,'2020-11-01 16:00:03','2020-11-01 16:00:03','用户【superuser】于【2020-11-01 16:00:02】登录系统！','superuser'),(81,'2020-11-02 20:31:18','2020-11-02 20:31:18','用户【superuser】于【2020-11-02 20:31:17】登录系统！','superuser'),(82,'2020-11-03 21:58:49','2020-11-03 21:58:49','用户【superuser】于【2020-11-03 21:58:48】登录系统！','superuser'),(83,'2020-11-03 21:59:04','2020-11-03 21:59:04','编辑用户，用户名：superuser','superuser'),(84,'2020-11-03 22:01:18','2020-11-03 22:01:18','用户【superuser】于【2020-11-03 22:01:17】登录系统！','superuser'),(85,'2020-11-03 22:03:29','2020-11-03 22:03:29','添加菜单信息【Menu [name=上架, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=up(\'/admin/goods_category/up_down\'), icon=mdi-arrow-expand-up, sort=0, isButton=true, isShow=true]】','superuser'),(86,'2020-11-03 22:04:48','2020-11-03 22:04:48','添加菜单信息【Menu [name=下架, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=down(\'admin/goods/up_down\'), icon=mdi-arrow-collapse-down, sort=0, isButton=true, isShow=true]】','superuser'),(87,'2020-11-03 22:06:14','2020-11-03 22:06:14','添加菜单信息【Menu [name=删除, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=delete(\'/admin/goods/delete\'), icon=mdi-close-outline, sort=0, isButton=true, isShow=true]】','superuser'),(88,'2020-11-03 22:06:39','2020-11-03 22:06:39','编辑菜单信息【Menu [name=上架, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=up(\'/admin/goods/up_down\'), icon=mdi-arrow-expand-up, sort=0, isButton=true, isShow=true]】','superuser'),(89,'2020-11-03 22:07:43','2020-11-03 22:07:43','编辑角色【超级管理员】','superuser'),(90,'2020-11-03 22:26:24','2020-11-03 22:26:24','用户【superuser】于【2020-11-03 22:26:23】登录系统！','superuser'),(91,'2020-11-04 15:46:17','2020-11-04 15:46:17','用户【superuser】于【2020-11-04 15:46:16】登录系统！','superuser'),(92,'2020-11-04 15:48:50','2020-11-04 15:48:50','添加菜单信息【Menu [name=推荐, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=recommend(\'/admin/goods/recommend\'), icon=mdi-thumb-up, sort=0, isButton=true, isShow=true]】','superuser'),(93,'2020-11-04 15:50:07','2020-11-04 15:50:07','添加菜单信息【Menu [name=取消推荐, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=unrecommend(\'/admin/goods/recommend, icon=mdi-thumb-down, sort=0, isButton=true, isShow=true]】','superuser'),(94,'2020-11-04 15:50:20','2020-11-04 15:50:20','编辑角色【超级管理员】','superuser'),(95,'2020-11-04 16:00:46','2020-11-04 16:00:46','编辑菜单信息【Menu [name=删除, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=del(\'/admin/goods/delete\'), icon=mdi-close-outline, sort=0, isButton=true, isShow=true]】','superuser'),(96,'2020-11-04 16:04:50','2020-11-04 16:04:50','编辑菜单信息【Menu [name=取消推荐, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=unrecommend(\'/admin/goods/recommend), icon=mdi-thumb-down, sort=0, isButton=true, isShow=true]】','superuser'),(97,'2020-11-04 16:05:44','2020-11-04 16:05:44','用户【superuser】于【2020-11-04 16:05:43】登录系统！','superuser'),(98,'2020-11-04 22:26:36','2020-11-04 22:26:36','用户【superuser】于【2020-11-04 22:26:35】登录系统！','superuser'),(99,'2020-11-05 19:43:42','2020-11-05 19:43:42','用户【superuser】于【2020-11-05 19:43:41】登录系统！','superuser'),(100,'2020-11-05 19:58:19','2020-11-05 19:58:19','添加菜单信息【Menu [name=学生管理, parent=null, url=/admin/student/list, icon=mdi-account-multiple, sort=0, isButton=false, isShow=true]】','superuser'),(101,'2020-11-05 20:02:09','2020-11-05 20:02:09','添加菜单信息【Menu [name=学生列表, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=/admin/student/list, icon=mdi-account-multiple, sort=0, isButton=false, isShow=true]】','superuser'),(102,'2020-11-05 20:08:51','2020-11-05 20:08:51','添加菜单信息【Menu [name=冻结, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=freeze(\'/admin/student/update_status\'), icon=mdi-account-key, sort=0, isButton=true, isShow=true]】','superuser'),(103,'2020-11-05 20:11:36','2020-11-05 20:11:36','添加菜单信息【Menu [name=激活, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=open(\'/admin/student/update_status\'), icon=mdi-account-star, sort=0, isButton=true, isShow=true]】','superuser'),(104,'2020-11-05 20:12:54','2020-11-05 20:12:54','添加菜单信息【Menu [name=删除, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=del(\'/admin/student/delete\'), icon=mdi-account-multiple-minus, sort=0, isButton=true, isShow=true]】','superuser'),(105,'2020-11-05 20:13:27','2020-11-05 20:13:27','编辑角色【超级管理员】','superuser'),(106,'2020-11-06 13:54:52','2020-11-06 13:54:52','用户【superuser】于【2020-11-06 13:54:51】登录系统！','superuser'),(107,'2020-11-06 14:16:22','2020-11-06 14:16:22','编辑菜单信息【Menu [name=激活, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=openStudent(\'/admin/student/update_status\'), icon=mdi-account-star, sort=0, isButton=true, isShow=true]】','superuser'),(108,'2020-11-06 14:18:47','2020-11-06 14:18:47','用户【superuser】于【2020-11-06 14:18:47】登录系统！','superuser'),(109,'2020-11-06 20:38:55','2020-11-06 20:38:55','用户【superuser】于【2020-11-06 20:38:54】登录系统！','superuser'),(110,'2020-11-07 00:00:32','2020-11-07 00:00:32','用户【superuser】于【2020-11-07 00:00:32】登录系统！','superuser'),(111,'2020-11-07 00:12:01','2020-11-07 00:12:01','用户【superuser】于【2020-11-07 00:12:00】登录系统！','superuser'),(112,'2020-11-07 00:14:19','2020-11-07 00:14:19','编辑菜单信息【Menu [name=取消推荐, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=unrecommend(\'/admin/goods/recommend\'), icon=mdi-thumb-down, sort=0, isButton=true, isShow=true]】','superuser'),(113,'2020-11-07 00:14:34','2020-11-07 00:14:34','编辑菜单信息【Menu [name=下架, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=down(\'admin/goods/up_down\'), icon=mdi-arrow-collapse-down, sort=0, isButton=true, isShow=true]】','superuser'),(114,'2020-11-07 00:15:25','2020-11-07 00:15:25','用户【superuser】于【2020-11-07 00:15:24】登录系统！','superuser'),(115,'2020-11-07 00:27:43','2020-11-07 00:27:43','用户【superuser】于【2020-11-07 00:27:43】登录系统！','superuser'),(116,'2020-11-07 11:52:23','2020-11-07 11:52:23','用户【superuser】于【2020-11-07 11:52:23】登录系统！','superuser'),(117,'2020-11-07 18:59:12','2020-11-07 18:59:12','用户【superuser】于【2020-11-07 18:59:12】登录系统！','superuser'),(118,'2020-11-07 19:06:30','2020-11-07 19:06:30','用户【superuser】于【2020-11-07 19:06:29】登录系统！','superuser'),(119,'2020-11-07 19:54:12','2020-11-07 19:54:12','用户【superuser】于【2020-11-07 19:54:12】登录系统！','superuser'),(120,'2020-11-07 23:30:53','2020-11-07 23:30:53','用户【superuser】于【2020-11-07 23:30:52】登录系统！','superuser'),(121,'2020-11-08 01:00:00','2020-11-08 01:00:00','数据库成功备份，备份文件信息：DatabaseBak [filename=db_20201108010000.sql, filepath=E:/javaweb/src/main/resources/backup/]','未知(获取登录用户失败)');
/*!40000 ALTER TABLE `barter_operater_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barter_role`
--

DROP TABLE IF EXISTS `barter_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barter_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `name` varchar(18) NOT NULL,
  `remark` varchar(128) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barter_role`
--

LOCK TABLES `barter_role` WRITE;
/*!40000 ALTER TABLE `barter_role` DISABLE KEYS */;
INSERT INTO `barter_role` VALUES (1,'2020-10-04 13:16:38','2020-11-05 20:13:27','超级管理员','超级管理员拥有最高权限。',1),(2,'2020-11-01 13:18:57','2020-11-01 22:18:43','普通管理员','普通管理员只有部分权限',1),(4,'2020-11-01 20:11:00','2020-11-01 22:20:57','测试角色','sadsa',1);
/*!40000 ALTER TABLE `barter_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barter_role_authorities`
--

DROP TABLE IF EXISTS `barter_role_authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barter_role_authorities` (
  `role_id` bigint(20) NOT NULL,
  `authorities_id` bigint(20) NOT NULL,
  KEY `FKkfb64s3r39d4d1jmj88gkje62` (`authorities_id`),
  KEY `FKhck0grl05057vw9h5g0hqs72` (`role_id`),
  CONSTRAINT `FKhck0grl05057vw9h5g0hqs72` FOREIGN KEY (`role_id`) REFERENCES `barter_role` (`id`),
  CONSTRAINT `FKkfb64s3r39d4d1jmj88gkje62` FOREIGN KEY (`authorities_id`) REFERENCES `barter_menu` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barter_role_authorities`
--

LOCK TABLES `barter_role_authorities` WRITE;
/*!40000 ALTER TABLE `barter_role_authorities` DISABLE KEYS */;
INSERT INTO `barter_role_authorities` VALUES (2,2),(2,3),(2,5),(2,7),(2,11),(2,13),(2,16),(4,2),(4,13),(4,15),(1,2),(1,3),(1,5),(1,8),(1,9),(1,7),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,19),(1,20),(1,21),(1,22),(1,23),(1,24),(1,25),(1,26),(1,27),(1,28),(1,31),(1,32),(1,33),(1,30),(1,34),(1,35),(1,36),(1,37),(1,38),(1,39),(1,40),(1,41),(1,42),(1,43);
/*!40000 ALTER TABLE `barter_role_authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barter_student`
--

DROP TABLE IF EXISTS `barter_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barter_student` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `academe` varchar(18) DEFAULT NULL,
  `grade` varchar(18) DEFAULT NULL,
  `head_pic` varchar(128) DEFAULT NULL,
  `mobile` varchar(18) DEFAULT NULL,
  `nickname` varchar(32) DEFAULT NULL,
  `password` varchar(18) NOT NULL,
  `qq` varchar(18) DEFAULT NULL,
  `school` varchar(18) DEFAULT NULL,
  `sn` varchar(18) NOT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_q70mqq1mpukkorhsr4o2xxn9w` (`sn`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barter_student`
--

LOCK TABLES `barter_student` WRITE;
/*!40000 ALTER TABLE `barter_student` DISABLE KEYS */;
INSERT INTO `barter_student` VALUES (1,'2020-10-30 12:46:55','2020-11-07 11:45:43','计算机','111','20201106/1604673721478.png','18628033928','zz','123456','961296023','电子科技大学','2018081309003',1),(2,'2020-10-31 22:38:35','2020-10-31 22:41:05','计算机','大三',NULL,'15612456466','小小','123456','1085266008','电子科技大学','1085266008',1),(3,'2020-11-01 15:33:12','2020-11-01 15:33:12',NULL,NULL,NULL,NULL,NULL,'123456',NULL,NULL,'111111',1),(4,'2020-11-01 15:48:53','2020-11-06 14:20:34','计算机','大三',NULL,'18628033928','zz','123456','961296023','电子科技大学','123456',1);
/*!40000 ALTER TABLE `barter_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barter_user`
--

DROP TABLE IF EXISTS `barter_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barter_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `email` varchar(32) DEFAULT NULL,
  `head_pic` varchar(128) DEFAULT NULL,
  `mobile` varchar(12) DEFAULT NULL,
  `password` varchar(32) NOT NULL,
  `sex` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `username` varchar(18) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_89rchxo8bexb84qe4vvurnmlg` (`username`),
  KEY `FKij8shewhodccrb8wokpavqkwk` (`role_id`),
  CONSTRAINT `FKij8shewhodccrb8wokpavqkwk` FOREIGN KEY (`role_id`) REFERENCES `barter_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barter_user`
--

LOCK TABLES `barter_user` WRITE;
/*!40000 ALTER TABLE `barter_user` DISABLE KEYS */;
INSERT INTO `barter_user` VALUES (1,'2020-10-04 19:18:53','2020-11-03 21:59:04','1085266008@qq.com','20201103/1604411942148.png','15612456466','dwl666',1,1,'superuser',1),(2,'2020-11-01 19:20:36','2020-11-01 10:54:17','11111111@qq.com','20201101/1604199252122.jpg','11111111','123456',2,1,'测试账号',2),(5,'2020-11-01 20:42:19','2020-11-01 11:12:07','yw@qq.com','20201101/1604200311679.jpg','12345678','123456',0,0,'123456',1),(6,'2020-11-01 13:48:42','2020-11-01 13:49:04','961296023@qq.com','','18628033928','123456',1,0,'测试角色',4),(7,'2020-11-01 15:14:21','2020-11-01 15:14:21','','','','123456',1,1,'测试用户',1);
/*!40000 ALTER TABLE `barter_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barter_wanted_goods`
--

DROP TABLE IF EXISTS `barter_wanted_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barter_wanted_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `content` varchar(1024) DEFAULT NULL,
  `name` varchar(32) NOT NULL,
  `sell_price` float NOT NULL,
  `trade_place` varchar(128) NOT NULL,
  `view_number` int(11) NOT NULL,
  `student_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKp1lq8xs4o8kwftljc8ikbmtgg` (`student_id`),
  CONSTRAINT `FKp1lq8xs4o8kwftljc8ikbmtgg` FOREIGN KEY (`student_id`) REFERENCES `barter_student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barter_wanted_goods`
--

LOCK TABLES `barter_wanted_goods` WRITE;
/*!40000 ALTER TABLE `barter_wanted_goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `barter_wanted_goods` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-08  1:00:00
