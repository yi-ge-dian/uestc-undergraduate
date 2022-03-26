/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : localhost:3306
 Source Schema         : hotal_data

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : 65001

 Date: 28/11/2019 20:26:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `uID` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `uName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户姓名',
  PRIMARY KEY (`uID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 201904 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (201901, '李四');
INSERT INTO `customer` VALUES (201902, '张三');
INSERT INTO `customer` VALUES (201903, '王五');

-- ----------------------------
-- Table structure for hotel
-- ----------------------------
DROP TABLE IF EXISTS `hotel`;
CREATE TABLE `hotel`  (
  `hotel_id` int(11) NOT NULL,
  `hotel_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`hotel_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hotel
-- ----------------------------
INSERT INTO `hotel` VALUES (1, '惠民旅馆');
INSERT INTO `hotel` VALUES (2, '度假旅馆');
INSERT INTO `hotel` VALUES (3, '商务旅馆');
INSERT INTO `hotel` VALUES (4, '四川惠民酒店');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `order_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自动递增的主键',
  `room_id` int(11) NULL DEFAULT NULL,
  `start_date` date NULL DEFAULT NULL,
  `leave_date` date NULL DEFAULT NULL,
  `amount` int(11) NULL DEFAULT NULL,
  `payment` decimal(10, 2) NULL DEFAULT NULL,
  `create_date` date NOT NULL,
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `room_order_id`(`room_id`) USING BTREE,
  CONSTRAINT `room_order_id` FOREIGN KEY (`room_id`) REFERENCES `room_type` (`room_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, 5, '2018-11-14', '2018-11-16', 2, 2100.00, '2018-11-01');
INSERT INTO `order` VALUES (2, 1, '2018-11-14', '2018-11-14', 5, 2500.00, '2018-11-01');
INSERT INTO `order` VALUES (3, 8, '2018-11-14', '2018-11-16', 2, 1296.00, '2018-11-01');
INSERT INTO `order` VALUES (4, 4, '2018-11-14', '2018-11-16', 2, 2400.00, '2018-11-01');
INSERT INTO `order` VALUES (5, 2, '2018-11-14', '2018-11-16', 4, 4000.00, '2018-11-01');
INSERT INTO `order` VALUES (6, 2, '2018-11-14', '2018-11-16', 4, 4000.00, '2018-11-01');

-- ----------------------------
-- Table structure for rating
-- ----------------------------
DROP TABLE IF EXISTS `rating`;
CREATE TABLE `rating`  (
  `rID` int(11) NOT NULL AUTO_INCREMENT COMMENT '评分表主键',
  `stars` int(11) NOT NULL COMMENT '0-5分',
  `room_id` int(11) NOT NULL COMMENT '房型编号',
  `uID` int(11) NULL DEFAULT NULL COMMENT '顾客ID',
  PRIMARY KEY (`rID`) USING BTREE,
  INDEX `room_id`(`room_id`) USING BTREE,
  INDEX `uID`(`uID`) USING BTREE,
  CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `room_type` (`room_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`uID`) REFERENCES `customer` (`uID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rating
-- ----------------------------
INSERT INTO `rating` VALUES (1, 3, 9, 201901);
INSERT INTO `rating` VALUES (2, 4, 8, 201901);
INSERT INTO `rating` VALUES (3, 2, 8, 201901);
INSERT INTO `rating` VALUES (4, 4, 6, 201901);
INSERT INTO `rating` VALUES (5, 0, 4, 201901);
INSERT INTO `rating` VALUES (6, 4, 4, 201901);
INSERT INTO `rating` VALUES (7, 5, 4, 201901);
INSERT INTO `rating` VALUES (8, 1, 5, 201901);
INSERT INTO `rating` VALUES (9, 1, 4, 201901);
INSERT INTO `rating` VALUES (10, 5, 5, 201901);
INSERT INTO `rating` VALUES (11, 1, 1, 201901);
INSERT INTO `rating` VALUES (12, 5, 1, 201901);
INSERT INTO `rating` VALUES (13, 4, 1, 201901);
INSERT INTO `rating` VALUES (14, 4, 3, 201901);
INSERT INTO `rating` VALUES (15, 2, 5, 201901);
INSERT INTO `rating` VALUES (16, 2, 5, 201901);
INSERT INTO `rating` VALUES (17, 2, 3, 201901);
INSERT INTO `rating` VALUES (18, 4, 2, 201901);
INSERT INTO `rating` VALUES (19, 3, 2, 201901);
INSERT INTO `rating` VALUES (20, 5, 2, 201901);
INSERT INTO `rating` VALUES (21, 4, 2, 201901);
INSERT INTO `rating` VALUES (22, 3, 7, 201901);
INSERT INTO `rating` VALUES (23, 2, 7, 201901);
INSERT INTO `rating` VALUES (24, 1, 7, 201901);
INSERT INTO `rating` VALUES (25, 5, 7, 201901);
INSERT INTO `rating` VALUES (26, 4, 8, 201901);
INSERT INTO `rating` VALUES (27, 2, 8, 201901);
INSERT INTO `rating` VALUES (28, 3, 8, 201901);
INSERT INTO `rating` VALUES (29, 1, 9, 201901);
INSERT INTO `rating` VALUES (30, 2, 6, 201903);
INSERT INTO `rating` VALUES (31, 3, 7, 201902);

-- ----------------------------
-- Table structure for room_info
-- ----------------------------
DROP TABLE IF EXISTS `room_info`;
CREATE TABLE `room_info`  (
  `info_id` int(11) NOT NULL,
  `date` date NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `remain` int(11) NULL DEFAULT NULL,
  `room_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `room_info_key`(`room_id`) USING BTREE,
  CONSTRAINT `room_info_key` FOREIGN KEY (`room_id`) REFERENCES `room_type` (`room_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of room_info
-- ----------------------------
INSERT INTO `room_info` VALUES (1, '2018-11-14', 500.00, 5, 1);
INSERT INTO `room_info` VALUES (2, '2018-11-15', 500.00, 4, 1);
INSERT INTO `room_info` VALUES (3, '2018-11-16', 600.00, 6, 1);
INSERT INTO `room_info` VALUES (4, '2018-11-14', 300.00, -6, 2);
INSERT INTO `room_info` VALUES (5, '2018-11-15', 300.00, -7, 2);
INSERT INTO `room_info` VALUES (6, '2018-11-16', 400.00, -7, 2);
INSERT INTO `room_info` VALUES (7, '2018-11-14', 200.00, 4, 3);
INSERT INTO `room_info` VALUES (8, '2018-11-15', 200.00, 3, 3);
INSERT INTO `room_info` VALUES (9, '2018-11-16', 300.00, 4, 3);
INSERT INTO `room_info` VALUES (10, '2018-11-14', 450.00, 5, 4);
INSERT INTO `room_info` VALUES (11, '2018-11-15', 300.00, 5, 4);
INSERT INTO `room_info` VALUES (12, '2018-11-16', 450.00, 5, 4);
INSERT INTO `room_info` VALUES (13, '2018-11-14', 400.00, 2, 5);
INSERT INTO `room_info` VALUES (14, '2018-11-15', 250.00, 2, 5);
INSERT INTO `room_info` VALUES (15, '2018-11-16', 400.00, 2, 5);
INSERT INTO `room_info` VALUES (16, '2018-11-14', 300.00, 1, 6);
INSERT INTO `room_info` VALUES (17, '2018-11-15', 200.00, 1, 6);
INSERT INTO `room_info` VALUES (18, '2018-11-16', 300.00, 5, 6);
INSERT INTO `room_info` VALUES (19, '2018-11-14', 300.00, 2, 7);
INSERT INTO `room_info` VALUES (20, '2018-11-15', 250.00, 3, 7);
INSERT INTO `room_info` VALUES (21, '2018-11-16', 300.00, 8, 7);
INSERT INTO `room_info` VALUES (22, '2018-11-14', 250.00, 1, 8);
INSERT INTO `room_info` VALUES (23, '2018-11-15', 200.00, 1, 8);
INSERT INTO `room_info` VALUES (24, '2018-11-16', 200.00, 5, 8);
INSERT INTO `room_info` VALUES (25, '2018-11-14', 200.00, 2, 9);
INSERT INTO `room_info` VALUES (26, '2018-11-15', 150.00, 4, 9);
INSERT INTO `room_info` VALUES (27, '2018-11-16', 150.00, 4, 9);

-- ----------------------------
-- Table structure for room_type
-- ----------------------------
DROP TABLE IF EXISTS `room_type`;
CREATE TABLE `room_type`  (
  `room_id` int(11) NOT NULL,
  `room_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `hotel_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`room_id`) USING BTREE,
  INDEX `hotel_room_key`(`hotel_id`) USING BTREE,
  CONSTRAINT `hotel_room_key` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of room_type
-- ----------------------------
INSERT INTO `room_type` VALUES (1, '大床房', 1);
INSERT INTO `room_type` VALUES (2, '双人房', 1);
INSERT INTO `room_type` VALUES (3, '三人房', 1);
INSERT INTO `room_type` VALUES (4, '海景房', 2);
INSERT INTO `room_type` VALUES (5, '园景房', 2);
INSERT INTO `room_type` VALUES (6, '山景房', 2);
INSERT INTO `room_type` VALUES (7, '总统套房', 3);
INSERT INTO `room_type` VALUES (8, '豪华套房', 3);
INSERT INTO `room_type` VALUES (9, '普通套房', 3);

-- ----------------------------
-- Triggers structure for table order
-- ----------------------------
DROP TRIGGER IF EXISTS `after_order_update`;
delimiter ;;
CREATE TRIGGER `after_order_update` AFTER INSERT ON `order` FOR EACH ROW UPDATE room_info SET remain = remain-NEW.amount WHERE room_id = new.room_id AND date BETWEEN NEW.start_date AND NEW.leave_date
;
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
