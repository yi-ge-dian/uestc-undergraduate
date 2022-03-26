/*
Navicat MySQL Data Transfer

Source Server         : learnbatis
Source Server Version : 50622
Source Host           : localhost:3306
Source Database       : db

Target Server Type    : MYSQL
Target Server Version : 50622
File Encoding         : 65001

Date: 2020-12-17 18:27:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for barter_comment
-- ----------------------------
DROP TABLE IF EXISTS `barter_comment`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of barter_comment
-- ----------------------------

-- ----------------------------
-- Table structure for barter_database_bak
-- ----------------------------
DROP TABLE IF EXISTS `barter_database_bak`;
CREATE TABLE `barter_database_bak` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `filename` varchar(32) NOT NULL,
  `filepath` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of barter_database_bak
-- ----------------------------

-- ----------------------------
-- Table structure for barter_goods
-- ----------------------------
DROP TABLE IF EXISTS `barter_goods`;
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of barter_goods
-- ----------------------------
INSERT INTO `barter_goods` VALUES ('3', '2020-10-31 22:44:34', '2020-11-04 16:05:59', '1000', '新买的电脑，有钱任性，二手转让', '0', '笔记本电脑', '20201031/1604155420668.jpg', '1', '50', '2', '15', '2', '3', '0');
INSERT INTO `barter_goods` VALUES ('6', '2020-11-01 15:50:17', '2020-11-01 15:50:49', '222', '                                111111111111111111111111111\r\n                            ', '0', 'chair', '20201101/1604217003974.png', '0', '111', '2', '31', '4', '0', '0');
INSERT INTO `barter_goods` VALUES ('7', '2020-11-04 17:31:03', '2020-11-06 22:42:13', '2312', '2312312333333333', '0', '大表哥', '20201104/1604482243181.png', '0', '3213', '3', '11', '1', '0', '0');
INSERT INTO `barter_goods` VALUES ('8', '2020-11-05 17:10:41', '2020-11-09 12:58:34', '432423', '3422222222444444444', '0', '431', '20201105/1604567429347.png', '2', '432', '2', '10', '1', '3', '0');
INSERT INTO `barter_goods` VALUES ('10', '2020-11-05 17:11:12', '2020-11-09 16:37:29', '23423', '4324244444444444', '0', '4324', '20201105/1604567462637.png', '2', '23423', '1', '11', '1', '30', '0');
INSERT INTO `barter_goods` VALUES ('12', '2020-11-05 17:11:37', '2020-11-08 16:51:30', '234', '5555555555555555555', '0', '42342', '20201105/1604567490325.png', '1', '324', '2', '16', '1', '0', '0');
INSERT INTO `barter_goods` VALUES ('13', '2020-11-05 17:11:55', '2020-11-08 17:25:10', '989', '999999999999999999999999', '0', '87987', '20201105/1604567504977.png', '2', '7987', '2', '16', '1', '13', '0');
INSERT INTO `barter_goods` VALUES ('14', '2020-11-08 21:21:20', '2020-11-09 18:58:30', '124312', '                                244444444444444444444\r\n                            ', '0', '大表哥', '20201108/1604841672482.png', '2', '4214', '1', '15', '1', '2', '0');
INSERT INTO `barter_goods` VALUES ('17', '2020-11-09 18:59:25', '2020-11-09 21:48:01', '123', '3213333333333333333333', '0', 'chair', '20201109/1604919553541.png', '2', '2312', '1', '29', '1', '3', '0');

-- ----------------------------
-- Table structure for barter_goods_category
-- ----------------------------
DROP TABLE IF EXISTS `barter_goods_category`;
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

-- ----------------------------
-- Records of barter_goods_category
-- ----------------------------
INSERT INTO `barter_goods_category` VALUES ('6', '2020-10-27 23:12:15', '2020-10-27 23:46:59', '20201027/1603811524835.png', '手机', '0', null);
INSERT INTO `barter_goods_category` VALUES ('10', '2020-10-27 23:19:09', '2020-10-27 23:48:04', '20201027/1603811943971.png', '手机配件', '2', '6');
INSERT INTO `barter_goods_category` VALUES ('11', '2020-10-27 23:47:16', '2020-10-27 23:47:16', '20201027/1603813629646.png', '智能机', '1', '6');
INSERT INTO `barter_goods_category` VALUES ('12', '2020-10-27 23:47:57', '2020-10-27 23:47:57', '20201027/1603813671857.png', '滑盖机', '3', '6');
INSERT INTO `barter_goods_category` VALUES ('13', '2020-10-27 23:48:27', '2020-10-27 23:48:27', '20201027/1603813696792.png', '翻盖机', '4', '6');
INSERT INTO `barter_goods_category` VALUES ('14', '2020-10-27 23:48:52', '2020-10-27 23:48:52', '20201027/1603813719482.png', '电脑', '5', null);
INSERT INTO `barter_goods_category` VALUES ('15', '2020-10-27 23:49:10', '2020-10-27 23:49:10', '20201027/1603813745209.png', '笔记本', '6', '14');
INSERT INTO `barter_goods_category` VALUES ('16', '2020-10-27 23:49:40', '2020-10-27 23:49:40', '20201027/1603813765314.png', '台式机', '7', '14');
INSERT INTO `barter_goods_category` VALUES ('20', '2020-11-01 12:12:32', '2020-11-01 12:53:05', '20201101/1604203949247.jpg', '图书', '8', null);
INSERT INTO `barter_goods_category` VALUES ('23', '2020-11-01 12:16:05', '2020-11-01 12:53:46', '20201101/1604204161500.png', '衣物', '11', null);
INSERT INTO `barter_goods_category` VALUES ('24', '2020-11-01 12:16:45', '2020-11-01 12:53:27', '20201101/1604204195657.png', '生活', '12', null);
INSERT INTO `barter_goods_category` VALUES ('26', '2020-11-01 12:18:13', '2020-11-01 12:53:36', '20201101/1604204289659.png', '交通', '14', null);
INSERT INTO `barter_goods_category` VALUES ('28', '2020-11-01 12:19:26', '2020-11-01 12:19:26', '20201101/1604204360139.png', '其他', '16', null);
INSERT INTO `barter_goods_category` VALUES ('29', '2020-11-01 13:43:50', '2020-11-01 13:43:50', '20201101/1604209422966.png', '计算机类', '0', '20');
INSERT INTO `barter_goods_category` VALUES ('30', '2020-11-01 13:44:48', '2020-11-01 13:44:48', '20201101/1604209476408.png', '女装', '0', '23');
INSERT INTO `barter_goods_category` VALUES ('31', '2020-11-01 13:45:24', '2020-11-01 13:45:24', '20201101/1604209521475.png', '日用品', '0', '24');
INSERT INTO `barter_goods_category` VALUES ('32', '2020-11-01 13:45:41', '2020-11-01 13:45:41', '20201101/1604209538980.png', '自行车', '0', '26');
INSERT INTO `barter_goods_category` VALUES ('33', '2020-11-01 13:46:02', '2020-11-01 13:46:02', '20201101/1604209559418.png', '其它', '0', '28');

-- ----------------------------
-- Table structure for barter_menu
-- ----------------------------
DROP TABLE IF EXISTS `barter_menu`;
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
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of barter_menu
-- ----------------------------
INSERT INTO `barter_menu` VALUES ('2', '2020-10-01 14:26:03', '2020-11-01 10:57:54', 'mdi-settings', '\0', '', '系统设置', '0', '', null);
INSERT INTO `barter_menu` VALUES ('3', '2020-10-02 16:58:55', '2020-11-01 18:26:02', 'mdi-view-list', '\0', '', '菜单管理', '1', '/admin/menu/list', '2');
INSERT INTO `barter_menu` VALUES ('5', '2020-10-03 17:04:44', '2020-11-01 18:27:53', 'mdi-plus', '\0', '', '新增', '2', '/admin/menu/add', '3');
INSERT INTO `barter_menu` VALUES ('7', '2020-10-05 17:07:43', '2020-11-01 12:11:25', 'mdi-account-settings-variant', '\0', '', '角色管理', '5', '/admin/role/list', '2');
INSERT INTO `barter_menu` VALUES ('8', '2020-10-06 18:28:48', '2020-11-01 22:04:45', 'mdi-grease-pencil', '', '', '编辑', '3', 'edit(\'/admin/menu/edit\')', '3');
INSERT INTO `barter_menu` VALUES ('9', '2020-10-07 18:30:00', '2020-11-01 22:08:20', 'mdi-close', '', '', '删除', '4', 'del(\'/admin/menu/delete\')', '3');
INSERT INTO `barter_menu` VALUES ('10', '2020-10-08 12:12:00', '2020-11-01 12:12:00', 'mdi-account-plus', '\0', '', '添加', '6', '/admin/role/add', '7');
INSERT INTO `barter_menu` VALUES ('11', '2020-10-09 12:12:36', '2020-11-01 22:10:45', 'mdi-account-edit', '', '', '编辑', '7', 'edit(\'/admin/role/edit\')', '7');
INSERT INTO `barter_menu` VALUES ('12', '2020-10-09 12:13:19', '2020-11-01 22:15:27', 'mdi-account-remove', '', '', '删除', '8', 'del(\'/admin/role/delete\')', '7');
INSERT INTO `barter_menu` VALUES ('13', '2020-10-10 12:14:52', '2020-11-01 12:17:00', 'mdi-account-multiple', '\0', '', '用户管理', '9', '/admin/user/list', '2');
INSERT INTO `barter_menu` VALUES ('14', '2020-10-10 12:15:22', '2020-11-01 12:17:27', 'mdi-account-plus', '\0', '', '添加', '10', '/admin/user/add', '13');
INSERT INTO `barter_menu` VALUES ('15', '2020-10-11 17:18:14', '2020-11-01 22:11:19', 'mdi-account-edit', '', '', '编辑', '11', 'edit(\'/admin/user/edit\')', '13');
INSERT INTO `barter_menu` VALUES ('16', '2020-10-11 17:19:01', '2020-11-01 22:15:36', 'mdi-account-remove', '', '', '删除', '12', 'del(\'/admin/user/delete\')', '13');
INSERT INTO `barter_menu` VALUES ('19', '2020-10-12 11:24:36', '2020-11-01 11:26:00', 'mdi-arrow-up-bold-circle', '\0', '\0', '上传图片', '0', '/admin/upload/upload_photo', '13');
INSERT INTO `barter_menu` VALUES ('20', '2020-10-12 14:09:35', '2020-11-01 14:09:47', 'mdi-tag-multiple', '\0', '', '日志管理', '13', '/system/operator_log_list', '2');
INSERT INTO `barter_menu` VALUES ('21', '2020-10-12 14:11:39', '2020-11-01 14:11:39', 'mdi-tag-remove', '', '', '删除', '14', 'del(\'/system/delete_operator_log\')', '20');
INSERT INTO `barter_menu` VALUES ('22', '2020-10-13 14:12:57', '2020-11-01 14:46:55', 'mdi-delete-circle', '', '', '清空日志', '15', 'delAll(\'/system/delete_all_operator_log\')', '20');
INSERT INTO `barter_menu` VALUES ('23', '2020-10-14 14:46:40', '2020-11-01 14:47:09', 'mdi-database', '\0', '', '数据备份', '16', '/admin/database_bak/list', '2');
INSERT INTO `barter_menu` VALUES ('24', '2020-10-14 14:48:07', '2020-11-01 15:13:41', 'mdi-database-plus', '', '', '备份', '17', 'add(\'/admin/database_bak/add\')', '23');
INSERT INTO `barter_menu` VALUES ('25', '2020-10-15 14:49:03', '2020-11-01 14:49:03', 'mdi-database-minus', '', '', '删除', '18', 'del(\'/admin/database_bak/delete\')', '23');
INSERT INTO `barter_menu` VALUES ('26', '2020-10-15 19:36:20', '2020-11-01 19:36:20', 'mdi-database-minus', '', '', '还原', '19', 'restore(\'/database_bak/restore\')', '23');
INSERT INTO `barter_menu` VALUES ('27', '2020-10-27 20:31:07', '2020-10-27 20:31:07', 'mdi-dialpad', '\0', '', '物品管理', '0', '/admin/goods_category/list', null);
INSERT INTO `barter_menu` VALUES ('28', '2020-10-27 20:31:50', '2020-10-27 20:31:50', 'mdi-android-head', '\0', '', '分类管理', '0', '/admin/goods_category/list', '27');
INSERT INTO `barter_menu` VALUES ('30', '2020-10-27 20:36:21', '2020-11-08 16:10:21', 'mdi-cart', '\0', '', '物品管理', '0', '/admin/commodity/list', '27');
INSERT INTO `barter_menu` VALUES ('31', '2020-10-27 20:39:46', '2020-10-27 22:12:33', 'mdi-plus', '\0', '', '添加', '0', '/admin/goods_category/add', '28');
INSERT INTO `barter_menu` VALUES ('32', '2020-10-27 20:41:11', '2020-10-27 23:38:06', 'mdi-border-color', '', '', '编辑', '0', 'edit(\'/admin/goods_category/edit\')', '28');
INSERT INTO `barter_menu` VALUES ('33', '2020-10-27 20:42:21', '2020-10-27 20:42:21', 'mdi-close', '', '', '删除', '0', 'del(\'/admin/goods_category/delete\')', '28');
INSERT INTO `barter_menu` VALUES ('34', '2020-11-03 22:03:29', '2020-11-08 16:40:29', 'mdi-arrow-expand-up', '', '', '上架', '0', 'up(\'/admin/commodity/up_down\')', '30');
INSERT INTO `barter_menu` VALUES ('35', '2020-11-03 22:04:48', '2020-11-08 16:40:48', 'mdi-arrow-collapse-down', '', '', '下架', '0', 'down(\'admin/commodity/up_down\')', '30');
INSERT INTO `barter_menu` VALUES ('36', '2020-11-03 22:06:14', '2020-11-08 16:41:04', 'mdi-close-outline', '', '', '删除', '0', 'del(\'/admin/commodity/delete\')', '30');
INSERT INTO `barter_menu` VALUES ('37', '2020-11-04 15:48:50', '2020-11-08 16:42:21', 'mdi-thumb-up', '', '', '通过审核', '0', 'recommend(\'/admin/commodity/recommend\')', '30');
INSERT INTO `barter_menu` VALUES ('38', '2020-11-04 15:50:07', '2020-11-08 16:42:05', 'mdi-thumb-down', '', '', '审核不通过', '0', 'unrecommend(\'/admin/commodity/recommend\')', '30');
INSERT INTO `barter_menu` VALUES ('39', '2020-11-05 19:58:19', '2020-11-05 19:58:19', 'mdi-account-multiple', '\0', '', '学生管理', '0', '/admin/student/list', null);
INSERT INTO `barter_menu` VALUES ('40', '2020-11-05 20:02:09', '2020-11-05 20:02:09', 'mdi-account-multiple', '\0', '', '学生列表', '0', '/admin/student/list', '39');
INSERT INTO `barter_menu` VALUES ('41', '2020-11-05 20:08:51', '2020-11-05 20:08:51', 'mdi-account-key', '', '', '冻结', '0', 'freeze(\'/admin/student/update_status\')', '40');
INSERT INTO `barter_menu` VALUES ('42', '2020-11-05 20:11:36', '2020-11-06 14:16:22', 'mdi-account-star', '', '', '激活', '0', 'openStudent(\'/admin/student/update_status\')', '40');
INSERT INTO `barter_menu` VALUES ('43', '2020-11-05 20:12:54', '2020-11-05 20:12:54', 'mdi-account-multiple-minus', '', '', '删除', '0', 'del(\'/admin/student/delete\')', '40');
INSERT INTO `barter_menu` VALUES ('44', '2020-11-08 10:59:08', '2020-11-08 11:01:37', 'mdi-tooltip-outline', '\0', '', '评论管理', '0', '/admin/comment/list', null);
INSERT INTO `barter_menu` VALUES ('45', '2020-11-08 11:00:33', '2020-11-08 11:06:06', 'mdi-close', '', '', '删除', '0', 'del(\'/admin/comment/delete\')', '46');
INSERT INTO `barter_menu` VALUES ('46', '2020-11-08 11:05:42', '2020-11-08 11:06:26', 'mdi-view-headline', '\0', '', '评论列表', '0', '/admin/comment/list', '44');

-- ----------------------------
-- Table structure for barter_operater_log
-- ----------------------------
DROP TABLE IF EXISTS `barter_operater_log`;
CREATE TABLE `barter_operater_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `content` varchar(512) NOT NULL,
  `operator` varchar(18) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of barter_operater_log
-- ----------------------------
INSERT INTO `barter_operater_log` VALUES ('60', '2020-11-01 12:05:45', '2020-11-01 12:05:45', '用户【superuser】于【2020-11-01 12:05:45】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('61', '2020-11-01 12:06:54', '2020-11-01 12:06:54', '用户【superuser】于【2020-11-01 12:06:54】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('63', '2020-11-01 12:35:57', '2020-11-01 12:35:57', '用户【superuser】于【2020-11-01 12:35:57】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('64', '2020-11-01 12:36:47', '2020-11-01 12:36:47', '用户【superuser】于【2020-11-01 12:36:46】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('65', '2020-11-01 12:45:47', '2020-11-01 12:45:47', '用户【superuser】于【2020-11-01 12:45:47】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('66', '2020-11-01 12:46:37', '2020-11-01 12:46:37', '用户【superuser】于【2020-11-01 12:46:37】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('67', '2020-11-01 12:52:01', '2020-11-01 12:52:01', '用户【superuser】于【2020-11-01 12:52:01】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('68', '2020-11-01 13:20:18', '2020-11-01 13:20:18', '用户【superuser】于【2020-11-01 13:20:17】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('69', '2020-11-01 13:20:48', '2020-11-01 13:20:48', '用户【superuser】于【2020-11-01 13:20:48】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('71', '2020-11-01 13:22:42', '2020-11-01 13:22:42', '用户【superuser】于【2020-11-01 13:22:42】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('72', '2020-11-01 13:42:54', '2020-11-01 13:42:54', '用户【superuser】于【2020-11-01 13:42:53】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('73', '2020-11-01 13:48:42', '2020-11-01 13:48:42', '添加用户，用户名：测试角色', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('74', '2020-11-01 13:49:04', '2020-11-01 13:49:04', '编辑用户，用户名：测试角色', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('75', '2020-11-01 14:22:29', '2020-11-01 14:22:29', '用户【superuser】于【2020-11-01 14:22:28】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('76', '2020-11-01 15:13:18', '2020-11-01 15:13:18', '用户【superuser】于【2020-11-01 15:13:17】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('77', '2020-11-01 15:13:50', '2020-11-01 15:13:50', '用户【superuser】于【2020-11-01 15:13:49】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('78', '2020-11-01 15:14:21', '2020-11-01 15:14:21', '添加用户，用户名：测试用户', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('79', '2020-11-01 15:52:16', '2020-11-01 15:52:16', '用户【superuser】于【2020-11-01 15:52:16】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('80', '2020-11-01 16:00:03', '2020-11-01 16:00:03', '用户【superuser】于【2020-11-01 16:00:02】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('81', '2020-11-02 20:31:18', '2020-11-02 20:31:18', '用户【superuser】于【2020-11-02 20:31:17】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('82', '2020-11-03 21:58:49', '2020-11-03 21:58:49', '用户【superuser】于【2020-11-03 21:58:48】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('83', '2020-11-03 21:59:04', '2020-11-03 21:59:04', '编辑用户，用户名：superuser', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('84', '2020-11-03 22:01:18', '2020-11-03 22:01:18', '用户【superuser】于【2020-11-03 22:01:17】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('85', '2020-11-03 22:03:29', '2020-11-03 22:03:29', '添加菜单信息【Menu [name=上架, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=up(\'/admin/goods_category/up_down\'), icon=mdi-arrow-expand-up, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('86', '2020-11-03 22:04:48', '2020-11-03 22:04:48', '添加菜单信息【Menu [name=下架, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=down(\'admin/goods/up_down\'), icon=mdi-arrow-collapse-down, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('87', '2020-11-03 22:06:14', '2020-11-03 22:06:14', '添加菜单信息【Menu [name=删除, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=delete(\'/admin/goods/delete\'), icon=mdi-close-outline, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('88', '2020-11-03 22:06:39', '2020-11-03 22:06:39', '编辑菜单信息【Menu [name=上架, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=up(\'/admin/goods/up_down\'), icon=mdi-arrow-expand-up, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('89', '2020-11-03 22:07:43', '2020-11-03 22:07:43', '编辑角色【超级管理员】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('90', '2020-11-03 22:26:24', '2020-11-03 22:26:24', '用户【superuser】于【2020-11-03 22:26:23】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('91', '2020-11-04 15:46:17', '2020-11-04 15:46:17', '用户【superuser】于【2020-11-04 15:46:16】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('92', '2020-11-04 15:48:50', '2020-11-04 15:48:50', '添加菜单信息【Menu [name=推荐, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=recommend(\'/admin/goods/recommend\'), icon=mdi-thumb-up, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('93', '2020-11-04 15:50:07', '2020-11-04 15:50:07', '添加菜单信息【Menu [name=取消推荐, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=unrecommend(\'/admin/goods/recommend, icon=mdi-thumb-down, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('94', '2020-11-04 15:50:20', '2020-11-04 15:50:20', '编辑角色【超级管理员】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('95', '2020-11-04 16:00:46', '2020-11-04 16:00:46', '编辑菜单信息【Menu [name=删除, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=del(\'/admin/goods/delete\'), icon=mdi-close-outline, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('96', '2020-11-04 16:04:50', '2020-11-04 16:04:50', '编辑菜单信息【Menu [name=取消推荐, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=unrecommend(\'/admin/goods/recommend), icon=mdi-thumb-down, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('97', '2020-11-04 16:05:44', '2020-11-04 16:05:44', '用户【superuser】于【2020-11-04 16:05:43】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('98', '2020-11-04 22:26:36', '2020-11-04 22:26:36', '用户【superuser】于【2020-11-04 22:26:35】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('99', '2020-11-05 19:43:42', '2020-11-05 19:43:42', '用户【superuser】于【2020-11-05 19:43:41】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('100', '2020-11-05 19:58:19', '2020-11-05 19:58:19', '添加菜单信息【Menu [name=学生管理, parent=null, url=/admin/student/list, icon=mdi-account-multiple, sort=0, isButton=false, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('101', '2020-11-05 20:02:09', '2020-11-05 20:02:09', '添加菜单信息【Menu [name=学生列表, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=/admin/student/list, icon=mdi-account-multiple, sort=0, isButton=false, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('102', '2020-11-05 20:08:51', '2020-11-05 20:08:51', '添加菜单信息【Menu [name=冻结, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=freeze(\'/admin/student/update_status\'), icon=mdi-account-key, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('103', '2020-11-05 20:11:36', '2020-11-05 20:11:36', '添加菜单信息【Menu [name=激活, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=open(\'/admin/student/update_status\'), icon=mdi-account-star, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('104', '2020-11-05 20:12:54', '2020-11-05 20:12:54', '添加菜单信息【Menu [name=删除, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=del(\'/admin/student/delete\'), icon=mdi-account-multiple-minus, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('105', '2020-11-05 20:13:27', '2020-11-05 20:13:27', '编辑角色【超级管理员】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('106', '2020-11-06 13:54:52', '2020-11-06 13:54:52', '用户【superuser】于【2020-11-06 13:54:51】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('107', '2020-11-06 14:16:22', '2020-11-06 14:16:22', '编辑菜单信息【Menu [name=激活, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=openStudent(\'/admin/student/update_status\'), icon=mdi-account-star, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('108', '2020-11-06 14:18:47', '2020-11-06 14:18:47', '用户【superuser】于【2020-11-06 14:18:47】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('109', '2020-11-06 20:38:55', '2020-11-06 20:38:55', '用户【superuser】于【2020-11-06 20:38:54】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('110', '2020-11-07 00:00:32', '2020-11-07 00:00:32', '用户【superuser】于【2020-11-07 00:00:32】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('111', '2020-11-07 00:12:01', '2020-11-07 00:12:01', '用户【superuser】于【2020-11-07 00:12:00】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('112', '2020-11-07 00:14:19', '2020-11-07 00:14:19', '编辑菜单信息【Menu [name=取消推荐, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=unrecommend(\'/admin/goods/recommend\'), icon=mdi-thumb-down, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('113', '2020-11-07 00:14:34', '2020-11-07 00:14:34', '编辑菜单信息【Menu [name=下架, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=down(\'admin/goods/up_down\'), icon=mdi-arrow-collapse-down, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('114', '2020-11-07 00:15:25', '2020-11-07 00:15:25', '用户【superuser】于【2020-11-07 00:15:24】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('115', '2020-11-07 00:27:43', '2020-11-07 00:27:43', '用户【superuser】于【2020-11-07 00:27:43】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('116', '2020-11-07 11:52:23', '2020-11-07 11:52:23', '用户【superuser】于【2020-11-07 11:52:23】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('117', '2020-11-07 18:59:12', '2020-11-07 18:59:12', '用户【superuser】于【2020-11-07 18:59:12】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('118', '2020-11-07 19:06:30', '2020-11-07 19:06:30', '用户【superuser】于【2020-11-07 19:06:29】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('119', '2020-11-07 19:54:12', '2020-11-07 19:54:12', '用户【superuser】于【2020-11-07 19:54:12】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('120', '2020-11-07 23:30:53', '2020-11-07 23:30:53', '用户【superuser】于【2020-11-07 23:30:52】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('121', '2020-11-08 01:00:00', '2020-11-08 01:00:00', '数据库成功备份，备份文件信息：DatabaseBak [filename=db_20201108010000.sql, filepath=E:/javaweb/src/main/resources/backup/]', '未知(获取登录用户失败)');
INSERT INTO `barter_operater_log` VALUES ('122', '2020-11-08 10:57:32', '2020-11-08 10:57:32', '用户【superuser】于【2020-11-08 10:57:31】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('123', '2020-11-08 10:59:08', '2020-11-08 10:59:08', '添加菜单信息【Menu [name=评论管理, parent=null, url=/admin/comment/list, icon=mdi-table-column-remove, sort=0, isButton=false, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('124', '2020-11-08 11:00:33', '2020-11-08 11:00:33', '添加菜单信息【Menu [name=s删除, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=del(\'/admin/comment/delete\'), icon=mdi-close, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('125', '2020-11-08 11:00:47', '2020-11-08 11:00:47', '编辑菜单信息【Menu [name=删除, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=del(\'/admin/comment/delete\'), icon=mdi-close, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('126', '2020-11-08 11:01:37', '2020-11-08 11:01:37', '编辑菜单信息【Menu [name=评论管理, parent=null, url=/admin/comment/list, icon=mdi-tooltip-outline, sort=0, isButton=false, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('127', '2020-11-08 11:01:56', '2020-11-08 11:01:56', '编辑角色【超级管理员】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('128', '2020-11-08 11:04:23', '2020-11-08 11:04:23', '用户【superuser】于【2020-11-08 11:04:22】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('129', '2020-11-08 11:05:42', '2020-11-08 11:05:42', '添加菜单信息【Menu [name=菜单列表, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=/admin/comment/list, icon=mdi-view-headline, sort=0, isButton=false, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('130', '2020-11-08 11:06:06', '2020-11-08 11:06:06', '编辑菜单信息【Menu [name=删除, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=del(\'/admin/comment/delete\'), icon=mdi-close, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('131', '2020-11-08 11:06:26', '2020-11-08 11:06:26', '编辑菜单信息【Menu [name=评论列表, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=/admin/comment/list, icon=mdi-view-headline, sort=0, isButton=false, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('132', '2020-11-08 11:06:45', '2020-11-08 11:06:45', '用户【superuser】于【2020-11-08 11:06:45】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('133', '2020-11-08 11:07:01', '2020-11-08 11:07:01', '编辑角色【超级管理员】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('134', '2020-11-08 11:07:19', '2020-11-08 11:07:19', '用户【superuser】于【2020-11-08 11:07:18】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('135', '2020-11-08 15:17:14', '2020-11-08 15:17:14', '用户【superuser】于【2020-11-08 15:17:13】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('136', '2020-11-08 16:03:22', '2020-11-08 16:03:22', '用户【superuser】于【2020-11-08 16:03:21】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('137', '2020-11-08 16:03:44', '2020-11-08 16:03:44', '编辑菜单信息【Menu [name=物品管理, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=/admin/list/list, icon=mdi-cart, sort=0, isButton=false, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('138', '2020-11-08 16:04:25', '2020-11-08 16:04:25', '用户【superuser】于【2020-11-08 16:04:25】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('139', '2020-11-08 16:07:10', '2020-11-08 16:07:10', '用户【superuser】于【2020-11-08 16:07:10】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('140', '2020-11-08 16:07:29', '2020-11-08 16:07:29', '编辑菜单信息【Menu [name=物品管理, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=/admin/wupin/wupin, icon=mdi-cart, sort=0, isButton=false, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('141', '2020-11-08 16:08:12', '2020-11-08 16:08:12', '用户【superuser】于【2020-11-08 16:08:11】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('142', '2020-11-08 16:10:21', '2020-11-08 16:10:21', '编辑菜单信息【Menu [name=物品管理, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=/admin/commodity/list, icon=mdi-cart, sort=0, isButton=false, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('143', '2020-11-08 16:10:47', '2020-11-08 16:10:47', '用户【superuser】于【2020-11-08 16:10:46】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('144', '2020-11-08 16:25:58', '2020-11-08 16:25:58', '用户【superuser】于【2020-11-08 16:25:57】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('145', '2020-11-08 16:28:22', '2020-11-08 16:28:22', '编辑角色【超级管理员】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('146', '2020-11-08 16:36:33', '2020-11-08 16:36:33', '用户【superuser】于【2020-11-08 16:36:33】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('147', '2020-11-08 16:40:29', '2020-11-08 16:40:29', '编辑菜单信息【Menu [name=上架, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=up(\'/admin/commodity/up_down\'), icon=mdi-arrow-expand-up, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('148', '2020-11-08 16:40:48', '2020-11-08 16:40:48', '编辑菜单信息【Menu [name=下架, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=down(\'admin/commodity/up_down\'), icon=mdi-arrow-collapse-down, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('149', '2020-11-08 16:41:04', '2020-11-08 16:41:04', '编辑菜单信息【Menu [name=删除, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=del(\'/admin/commodity/delete\'), icon=mdi-close-outline, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('150', '2020-11-08 16:41:24', '2020-11-08 16:41:24', '编辑菜单信息【Menu [name=推荐, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=recommend(\'/admin/commodity/recommend\'), icon=mdi-thumb-up, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('151', '2020-11-08 16:42:05', '2020-11-08 16:42:05', '编辑菜单信息【Menu [name=审核不通过, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=unrecommend(\'/admin/commodity/recommend\'), icon=mdi-thumb-down, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('152', '2020-11-08 16:42:21', '2020-11-08 16:42:21', '编辑菜单信息【Menu [name=通过审核, parent=Menu [name=null, parent=null, url=null, icon=null, sort=0, isButton=false, isShow=true], url=recommend(\'/admin/commodity/recommend\'), icon=mdi-thumb-up, sort=0, isButton=true, isShow=true]】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('153', '2020-11-08 16:43:04', '2020-11-08 16:43:04', '用户【superuser】于【2020-11-08 16:43:03】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('154', '2020-11-08 21:54:38', '2020-11-08 21:54:38', '用户【superuser】于【2020-11-08 21:54:37】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('155', '2020-11-08 22:03:18', '2020-11-08 22:03:18', '用户【superuser】于【2020-11-08 22:03:18】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('156', '2020-11-08 22:06:01', '2020-11-08 22:06:01', '用户【superuser】于【2020-11-08 22:06:00】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('157', '2020-11-09 16:43:35', '2020-11-09 16:43:35', '用户【superuser】于【2020-11-09 16:43:34】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('158', '2020-11-09 16:52:11', '2020-11-09 16:52:11', '添加角色【超普通管理员】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('159', '2020-11-09 16:52:29', '2020-11-09 16:52:29', '编辑角色【超普通管理员】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('160', '2020-11-09 16:52:39', '2020-11-09 16:52:39', '删除角色ID【5】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('161', '2020-11-09 16:54:21', '2020-11-09 16:54:21', '添加用户，用户名：777777', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('162', '2020-11-09 16:54:44', '2020-11-09 16:54:44', '用户【777777】于【2020-11-09 16:54:44】登录系统！', '777777');
INSERT INTO `barter_operater_log` VALUES ('163', '2020-11-09 16:55:19', '2020-11-09 16:55:19', '编辑角色【超级管理员】', '777777');
INSERT INTO `barter_operater_log` VALUES ('164', '2020-11-09 16:55:51', '2020-11-09 16:55:51', '用户【superuser】于【2020-11-09 16:55:51】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('165', '2020-11-09 17:47:37', '2020-11-09 17:47:37', '用户【superuser】于【2020-11-09 17:47:37】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('166', '2020-11-09 17:50:15', '2020-11-09 17:50:15', '用户【superuser】于【2020-11-09 17:50:15】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('167', '2020-11-09 17:53:50', '2020-11-09 17:53:50', '用户【superuser】于【2020-11-09 17:53:50】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('168', '2020-11-09 18:04:36', '2020-11-09 18:04:36', '用户【superuser】于【2020-11-09 18:04:35】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('169', '2020-11-09 19:00:25', '2020-11-09 19:00:25', '用户【superuser】于【2020-11-09 19:00:25】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('170', '2020-11-09 19:39:02', '2020-11-09 19:39:02', '用户【superuser】于【2020-11-09 19:39:02】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('171', '2020-11-09 20:12:52', '2020-11-09 20:12:52', '用户【superuser】于【2020-11-09 20:12:52】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('172', '2020-11-09 20:13:01', '2020-11-09 20:13:01', '添加用户，用户名：2018081309003', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('173', '2020-11-09 20:16:49', '2020-11-09 20:16:49', '添加用户，用户名：20180813090031', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('174', '2020-11-09 21:41:20', '2020-11-09 21:41:20', '用户【superuser】于【2020-11-09 21:41:20】登录系统！', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('175', '2020-11-09 21:44:58', '2020-11-09 21:44:58', '编辑角色【普通管理员】', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('176', '2020-11-09 21:46:45', '2020-11-09 21:46:45', '编辑用户，用户名：777777', 'superuser');
INSERT INTO `barter_operater_log` VALUES ('177', '2020-11-09 21:47:00', '2020-11-09 21:47:00', '用户【777777】于【2020-11-09 21:47:00】登录系统！', '777777');
INSERT INTO `barter_operater_log` VALUES ('178', '2020-12-17 15:59:53', '2020-12-17 15:59:53', '用户【superuser】于【2020-12-17 15:59:53】登录系统！', 'superuser');

-- ----------------------------
-- Table structure for barter_role
-- ----------------------------
DROP TABLE IF EXISTS `barter_role`;
CREATE TABLE `barter_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `name` varchar(18) NOT NULL,
  `remark` varchar(128) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of barter_role
-- ----------------------------
INSERT INTO `barter_role` VALUES ('1', '2020-10-04 13:16:38', '2020-11-09 16:55:19', '超级管理员', '超级管理员拥有最高权限。', '1');
INSERT INTO `barter_role` VALUES ('2', '2020-11-01 13:18:57', '2020-11-09 21:44:58', '普通管理员', '普通管理员只有部分权限', '1');
INSERT INTO `barter_role` VALUES ('4', '2020-11-01 20:11:00', '2020-11-01 22:20:57', '测试角色', 'sadsa', '1');

-- ----------------------------
-- Table structure for barter_role_authorities
-- ----------------------------
DROP TABLE IF EXISTS `barter_role_authorities`;
CREATE TABLE `barter_role_authorities` (
  `role_id` bigint(20) NOT NULL,
  `authorities_id` bigint(20) NOT NULL,
  KEY `FKkfb64s3r39d4d1jmj88gkje62` (`authorities_id`),
  KEY `FKhck0grl05057vw9h5g0hqs72` (`role_id`),
  CONSTRAINT `FKhck0grl05057vw9h5g0hqs72` FOREIGN KEY (`role_id`) REFERENCES `barter_role` (`id`),
  CONSTRAINT `FKkfb64s3r39d4d1jmj88gkje62` FOREIGN KEY (`authorities_id`) REFERENCES `barter_menu` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of barter_role_authorities
-- ----------------------------
INSERT INTO `barter_role_authorities` VALUES ('4', '2');
INSERT INTO `barter_role_authorities` VALUES ('4', '13');
INSERT INTO `barter_role_authorities` VALUES ('4', '15');
INSERT INTO `barter_role_authorities` VALUES ('1', '2');
INSERT INTO `barter_role_authorities` VALUES ('1', '3');
INSERT INTO `barter_role_authorities` VALUES ('1', '5');
INSERT INTO `barter_role_authorities` VALUES ('1', '8');
INSERT INTO `barter_role_authorities` VALUES ('1', '9');
INSERT INTO `barter_role_authorities` VALUES ('1', '7');
INSERT INTO `barter_role_authorities` VALUES ('1', '10');
INSERT INTO `barter_role_authorities` VALUES ('1', '11');
INSERT INTO `barter_role_authorities` VALUES ('1', '12');
INSERT INTO `barter_role_authorities` VALUES ('1', '13');
INSERT INTO `barter_role_authorities` VALUES ('1', '14');
INSERT INTO `barter_role_authorities` VALUES ('1', '15');
INSERT INTO `barter_role_authorities` VALUES ('1', '16');
INSERT INTO `barter_role_authorities` VALUES ('1', '19');
INSERT INTO `barter_role_authorities` VALUES ('1', '20');
INSERT INTO `barter_role_authorities` VALUES ('1', '21');
INSERT INTO `barter_role_authorities` VALUES ('1', '22');
INSERT INTO `barter_role_authorities` VALUES ('1', '23');
INSERT INTO `barter_role_authorities` VALUES ('1', '24');
INSERT INTO `barter_role_authorities` VALUES ('1', '25');
INSERT INTO `barter_role_authorities` VALUES ('1', '26');
INSERT INTO `barter_role_authorities` VALUES ('1', '27');
INSERT INTO `barter_role_authorities` VALUES ('1', '28');
INSERT INTO `barter_role_authorities` VALUES ('1', '31');
INSERT INTO `barter_role_authorities` VALUES ('1', '32');
INSERT INTO `barter_role_authorities` VALUES ('1', '33');
INSERT INTO `barter_role_authorities` VALUES ('1', '30');
INSERT INTO `barter_role_authorities` VALUES ('1', '34');
INSERT INTO `barter_role_authorities` VALUES ('1', '35');
INSERT INTO `barter_role_authorities` VALUES ('1', '36');
INSERT INTO `barter_role_authorities` VALUES ('1', '37');
INSERT INTO `barter_role_authorities` VALUES ('1', '38');
INSERT INTO `barter_role_authorities` VALUES ('1', '39');
INSERT INTO `barter_role_authorities` VALUES ('1', '40');
INSERT INTO `barter_role_authorities` VALUES ('1', '41');
INSERT INTO `barter_role_authorities` VALUES ('1', '42');
INSERT INTO `barter_role_authorities` VALUES ('1', '43');
INSERT INTO `barter_role_authorities` VALUES ('1', '44');
INSERT INTO `barter_role_authorities` VALUES ('1', '46');
INSERT INTO `barter_role_authorities` VALUES ('1', '45');
INSERT INTO `barter_role_authorities` VALUES ('2', '2');
INSERT INTO `barter_role_authorities` VALUES ('2', '3');
INSERT INTO `barter_role_authorities` VALUES ('2', '5');
INSERT INTO `barter_role_authorities` VALUES ('2', '7');
INSERT INTO `barter_role_authorities` VALUES ('2', '11');
INSERT INTO `barter_role_authorities` VALUES ('2', '13');
INSERT INTO `barter_role_authorities` VALUES ('2', '14');
INSERT INTO `barter_role_authorities` VALUES ('2', '16');
INSERT INTO `barter_role_authorities` VALUES ('2', '20');
INSERT INTO `barter_role_authorities` VALUES ('2', '21');
INSERT INTO `barter_role_authorities` VALUES ('2', '22');

-- ----------------------------
-- Table structure for barter_student
-- ----------------------------
DROP TABLE IF EXISTS `barter_student`;
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of barter_student
-- ----------------------------
INSERT INTO `barter_student` VALUES ('1', '2020-10-30 12:46:55', '2020-11-09 20:09:31', '计算机', '221', '20201108/1604842337278.png', '18628033923', '34234', '123456', '961296023', '电子科技大学', '2018081309003', '1');
INSERT INTO `barter_student` VALUES ('2', '2020-10-31 22:38:35', '2020-10-31 22:41:05', '计算机', '大三', null, '15612456466', '小小', '123456', '1085266008', '电子科技大学', '1085266008', '1');
INSERT INTO `barter_student` VALUES ('3', '2020-11-01 15:33:12', '2020-11-01 15:33:12', null, null, null, null, null, '123456', null, null, '111111', '1');
INSERT INTO `barter_student` VALUES ('4', '2020-11-01 15:48:53', '2020-11-06 14:20:34', '计算机', '大三', null, '18628033928', 'zz', '123456', '961296023', '电子科技大学', '123456', '1');
INSERT INTO `barter_student` VALUES ('5', '2020-11-09 10:31:31', '2020-11-09 10:31:31', null, null, null, null, null, '111111', null, null, '123123', '1');
INSERT INTO `barter_student` VALUES ('8', '2020-11-09 19:15:20', '2020-11-09 19:15:20', null, null, null, null, null, '123456', null, null, '898989', '1');
INSERT INTO `barter_student` VALUES ('9', '2020-11-09 19:21:40', '2020-11-09 19:21:40', null, null, null, null, null, '999999', null, null, '999999', '1');
INSERT INTO `barter_student` VALUES ('10', '2020-11-09 19:25:55', '2020-11-09 19:25:55', null, null, null, null, null, '111111', null, null, '101010', '1');
INSERT INTO `barter_student` VALUES ('11', '2020-11-09 19:50:14', '2020-11-09 19:50:14', null, null, null, null, null, '111111', null, null, '131313', '1');
INSERT INTO `barter_student` VALUES ('12', '2020-11-09 21:39:46', '2020-11-09 21:40:06', '计算机', '大三', '20201109/1604929198701.png', '18628033928', 'zz', '111111', '961296023', '电子科技大学', '676767', '1');

-- ----------------------------
-- Table structure for barter_user
-- ----------------------------
DROP TABLE IF EXISTS `barter_user`;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of barter_user
-- ----------------------------
INSERT INTO `barter_user` VALUES ('1', '2020-10-04 19:18:53', '2020-11-09 19:40:06', '1085266008@qq.com', '20201109/1604922000863.png', '15612456466', 'dwl666', '1', '1', 'superuser', '1');
INSERT INTO `barter_user` VALUES ('2', '2020-11-01 19:20:36', '2020-11-01 10:54:17', '11111111@qq.com', '20201101/1604199252122.jpg', '11111111', '123456', '2', '1', '测试账号', '2');
INSERT INTO `barter_user` VALUES ('5', '2020-11-01 20:42:19', '2020-11-01 11:12:07', 'yw@qq.com', '20201101/1604200311679.jpg', '12345678', '123456', '0', '0', '123456', '1');
INSERT INTO `barter_user` VALUES ('6', '2020-11-01 13:48:42', '2020-11-01 13:49:04', '961296023@qq.com', '', '18628033928', '123456', '1', '0', '测试角色', '4');
INSERT INTO `barter_user` VALUES ('7', '2020-11-01 15:14:21', '2020-11-01 15:14:21', '', '', '', '123456', '1', '1', '测试用户', '1');
INSERT INTO `barter_user` VALUES ('8', '2020-11-09 16:54:21', '2020-11-09 21:46:45', '', '20201109/1604912013467.png', '18628033928', '111111', '1', '1', '777777', '2');
INSERT INTO `barter_user` VALUES ('9', '2020-11-09 20:13:01', '2020-11-09 20:13:01', '', '', '1111111', '123456', '1', '1', '2018081309003', '1');
INSERT INTO `barter_user` VALUES ('10', '2020-11-09 20:16:49', '2020-11-09 20:16:49', '', '', '18628033928', '123456', '1', '1', '20180813090031', '1');

-- ----------------------------
-- Table structure for barter_wanted_goods
-- ----------------------------
DROP TABLE IF EXISTS `barter_wanted_goods`;
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

-- ----------------------------
-- Records of barter_wanted_goods
-- ----------------------------
