/*
Navicat MySQL Data Transfer

Source Server         : mysql5.6
Source Server Version : 50620
Source Host           : localhost:3306
Source Database       : gouwuwang_db

Target Server Type    : MYSQL
Target Server Version : 50620
File Encoding         : 65001

Date: 2023-11-21 02:36:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_comment`
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `commentId` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `productObj` int(11) NOT NULL COMMENT '被评商品',
  `content` varchar(1000) NOT NULL COMMENT '评论内容',
  `userObj` varchar(30) NOT NULL COMMENT '评论用户',
  `commentTime` varchar(20) DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`commentId`),
  KEY `productObj` (`productObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_comment_ibfk_1` FOREIGN KEY (`productObj`) REFERENCES `t_product` (`productId`),
  CONSTRAINT `t_comment_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES ('1', '1', '很好用,不错', 'user1', '2018-03-27 14:15:13');
INSERT INTO `t_comment` VALUES ('2', '1', '非常好用很流畅', 'user1', '2018-03-27 22:31:11');
INSERT INTO `t_comment` VALUES ('3', '2', '我想要这个手机！', 'user2', '2018-03-31 13:58:26');
INSERT INTO `t_comment` VALUES ('4', '2', '我同学也是用的这款手机！', 'user2', '2018-03-31 13:59:14');

-- ----------------------------
-- Table structure for `t_leaveword`
-- ----------------------------
DROP TABLE IF EXISTS `t_leaveword`;
CREATE TABLE `t_leaveword` (
  `leaveWordId` int(11) NOT NULL AUTO_INCREMENT COMMENT '留言id',
  `leaveTitle` varchar(80) NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000) NOT NULL COMMENT '留言内容',
  `userObj` varchar(30) NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20) DEFAULT NULL COMMENT '留言时间',
  `replyContent` varchar(1000) DEFAULT NULL COMMENT '管理回复',
  `replyTime` varchar(20) DEFAULT NULL COMMENT '回复时间',
  PRIMARY KEY (`leaveWordId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_leaveword_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_leaveword
-- ----------------------------
INSERT INTO `t_leaveword` VALUES ('1', '111', '222', 'user1', '2018-03-25 23:46:29', '333', '2018-03-28 23:46:33');
INSERT INTO `t_leaveword` VALUES ('2', 'aa', 'bb', 'user1', '2018-03-25 23:08:02', '很好', '2018-03-28 23:28:01');
INSERT INTO `t_leaveword` VALUES ('3', '太好了，我可以买宝贝了', '这个网站我有很多喜欢的宝贝，太高兴了！', 'user2', '2018-03-31 14:04:17', '你喜欢就好！', '2018-03-31 14:09:07');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `content` varchar(5000) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', 'aaaa', '<p>bbbb</p>', '2018-03-27 23:47:02');

-- ----------------------------
-- Table structure for `t_orderinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_orderinfo`;
CREATE TABLE `t_orderinfo` (
  `orderNo` varchar(30) NOT NULL COMMENT 'orderNo',
  `userObj` varchar(30) NOT NULL COMMENT '下单用户',
  `totalMoney` float NOT NULL COMMENT '订单总金额',
  `payWay` varchar(20) NOT NULL COMMENT '支付方式',
  `orderStateObj` varchar(20) NOT NULL COMMENT '订单状态',
  `orderTime` varchar(20) DEFAULT NULL COMMENT '下单时间',
  `receiveName` varchar(20) NOT NULL COMMENT '收货人',
  `telephone` varchar(20) NOT NULL COMMENT '收货人电话',
  `address` varchar(80) NOT NULL COMMENT '收货人地址',
  `orderMemo` varchar(500) DEFAULT NULL COMMENT '订单备注',
  PRIMARY KEY (`orderNo`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_orderinfo_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_orderinfo
-- ----------------------------
INSERT INTO `t_orderinfo` VALUES ('user120180331140642', 'user1', '10517', '支付宝', '已付款', '2018-03-31 14:06:42', '双鱼林', '13598308394', '四川成都红星路13号', 'test');
INSERT INTO `t_orderinfo` VALUES ('user120180918154447', 'user1', '898', '支付宝', '已发货', '2018-09-18 15:44:47', '双鱼林', '13598308394', '四川成都红星路13号', '麻烦老板快点发货哦');
INSERT INTO `t_orderinfo` VALUES ('user220180331140236', 'user2', '2899', '支付宝', '已发货', '2018-03-31 14:02:36', '王小琴', '13598039934', '四川南充海阳路12号', '赶快发货哦！');
INSERT INTO `t_orderinfo` VALUES ('user220180331140256', 'user2', '49', '支付宝', '已付款', '2018-03-31 14:02:56', '王小琴', '13598039934', '四川南充海阳路12号', '我要这个用于学习');
INSERT INTO `t_orderinfo` VALUES ('user320231116182818', 'user3', '1299', '支付宝', '已付款', '2023-11-16 18:28:18', '王晓婷', '13512983942', '成都火车北站', '发货吧');
INSERT INTO `t_orderinfo` VALUES ('user420231118025914', 'user4', '2599', '支付宝', '已付款', '2023-11-18 02:59:14', '王兵', '13451099023', '南京', '11');
INSERT INTO `t_orderinfo` VALUES ('user520231118025933', 'user5', '2599', '支付宝', '已付款', '2023-11-18 02:59:33', '李茜', '13598099834', '西安', '33');

-- ----------------------------
-- Table structure for `t_orderitem`
-- ----------------------------
DROP TABLE IF EXISTS `t_orderitem`;
CREATE TABLE `t_orderitem` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT '条目id',
  `orderObj` varchar(30) NOT NULL COMMENT '所属订单',
  `productObj` int(11) NOT NULL COMMENT '订单商品',
  `price` float NOT NULL COMMENT '商品单价',
  `orderNumer` int(11) NOT NULL COMMENT '购买数量',
  PRIMARY KEY (`itemId`),
  KEY `orderObj` (`orderObj`),
  KEY `productObj` (`productObj`),
  CONSTRAINT `t_orderitem_ibfk_1` FOREIGN KEY (`orderObj`) REFERENCES `t_orderinfo` (`orderNo`),
  CONSTRAINT `t_orderitem_ibfk_2` FOREIGN KEY (`productObj`) REFERENCES `t_product` (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_orderitem
-- ----------------------------
INSERT INTO `t_orderitem` VALUES ('8', 'user220180331140236', '1', '1299', '3');
INSERT INTO `t_orderitem` VALUES ('9', 'user220180331140236', '2', '800', '1');
INSERT INTO `t_orderitem` VALUES ('12', 'user120180331140642', '1', '2599', '2');
INSERT INTO `t_orderitem` VALUES ('13', 'user120180918154447', '1', '800', '3');
INSERT INTO `t_orderitem` VALUES ('14', 'user320231116182818', '1', '49', '4');
INSERT INTO `t_orderitem` VALUES ('16', 'user120180331140642', '2', '0', '3');
INSERT INTO `t_orderitem` VALUES ('17', 'user120180331140642', '3', '22', '4');
INSERT INTO `t_orderitem` VALUES ('18', 'user120180331140642', '4', '33', '3');
INSERT INTO `t_orderitem` VALUES ('19', 'user220180331140256', '4', '55', '3');
INSERT INTO `t_orderitem` VALUES ('20', 'user220180331140256', '5', '66', '5');
INSERT INTO `t_orderitem` VALUES ('21', 'user320231116182818', '2', '88', '2');
INSERT INTO `t_orderitem` VALUES ('23', 'user320231116182818', '3', '66', '4');
INSERT INTO `t_orderitem` VALUES ('24', 'user420231118025914', '1', '2599', '4');
INSERT INTO `t_orderitem` VALUES ('26', 'user420231118025914', '2', '55', '3');
INSERT INTO `t_orderitem` VALUES ('28', 'user420231118025914', '4', '35', '5');
INSERT INTO `t_orderitem` VALUES ('29', 'user420231118025914', '5', '341', '2');
INSERT INTO `t_orderitem` VALUES ('30', 'user520231118025933', '2', '241', '3');
INSERT INTO `t_orderitem` VALUES ('31', 'user520231118025933', '3', '341', '5');
INSERT INTO `t_orderitem` VALUES ('32', 'user520231118025933', '4', '5323', '4');
INSERT INTO `t_orderitem` VALUES ('33', 'user120180331140642', '5', '341', '1');
INSERT INTO `t_orderitem` VALUES ('34', 'user320231116182818', '5', '34', '5');
INSERT INTO `t_orderitem` VALUES ('38', 'user520231118025933', '4', '34', '4');

-- ----------------------------
-- Table structure for `t_product`
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `productId` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `productClassObj` int(11) NOT NULL COMMENT '商品类别',
  `productName` varchar(50) NOT NULL COMMENT '商品名称',
  `mainPhoto` varchar(60) NOT NULL COMMENT '商品图片',
  `productNum` int(11) NOT NULL COMMENT '商品库存',
  `price` float NOT NULL COMMENT '商品价格',
  `recommandFlag` varchar(20) NOT NULL COMMENT '是否推荐',
  `recipeFlag` varchar(20) NOT NULL COMMENT '是否处方药',
  `productDesc` varchar(5000) NOT NULL COMMENT '商品描述',
  `addTime` varchar(20) DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`productId`),
  KEY `productClassObj` (`productClassObj`),
  CONSTRAINT `t_product_ibfk_1` FOREIGN KEY (`productClassObj`) REFERENCES `t_productclass` (`classId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('1', '1', '苹果5s手机', 'upload/049477b5-1fcb-419c-8df2-5813acea0423.jpg', '99', '800', '是', '否', '<p>品牌名称：Apple/苹果</p><p>更多参数产品参数：</p><p>证书编号：2013011606639987证书状态：有效申请人名称：美国苹果公司制造商名称：美国苹果公司产品名称：TD-LTE 数字移动电话机3C产品型号：A1530（电源适配器：A1443,输出:5.0VDC,1.0A）（电源适配器为可选部件）3C规格型号：A1530（电源适配器：A1443,输出:5.0VDC,1.0A）（电源适配器为可选部件）产品名称：Apple/苹果 iPhone 5sCPU型号: A7Apple型号: iPhone 5s机身颜色: 金色运行内存RAM: 1GB存储容量: 16GB网络模式: 单卡多模</p><p><br/></p>', '2018-03-25 23:43:22');
INSERT INTO `t_product` VALUES ('2', '1', '小米5X 变焦双摄拍照智能手机', 'upload/b0169c8b-4851-41eb-97c2-2b0fda10cba8.jpg', '99', '1299', '是', '否', '<p>证书编号：2017011606972569证书状态：有效产品名称：TD-LTE数字移动电话机3C规格型号：MDE2（电源适配器：MDY-08-EV 输出：5VDC 2.0A）产品名称：Xiaomi/小米 小米5XCPU型号: 骁龙625 型号: 小米5X机身颜色: 金色 玫瑰金 黑色 红色运行内存RAM: 4GB存储容量: 32GB 64GB网络模式: 双卡多模</p>', '2018-03-25 22:57:14');
INSERT INTO `t_product` VALUES ('3', '2', 'Dell/戴尔 成就Vostro 15.6英寸四核笔记本', 'upload/e3e514fa-6eab-4892-8f0e-b36ec69a6015.jpg', '198', '2599', '是', '否', '<p>证书编号：2015010902754843证书状态：有效申请人名称：仁宝电脑工业股份有限公司制造商名称：戴尔(中国)有限公司产品名称：便携式计算机3C产品型号：P64G;P51F;P65G;P52F;P64G...;P51F...;P65G...;P52F.....3C规格型号：P64G;P51F;P65G;P52F;P64G...;P51F...;P65G...;P52F.....产品名称：Dell/戴尔 成就Vostro 15品牌: Dell/戴尔型号: 15屏幕尺寸: 15.6英寸CPU: 英特尔 赛扬 N3450显卡类型: AMD Radeon HD显存容量: 2G机械硬盘容量: 1TB内存容量: 4G操作系统: windows 10</p>', '2018-03-25 16:47:30');
INSERT INTO `t_product` VALUES ('4', '3', 'Canon/佳能 入门单反数码', 'upload/1a825f55-1637-45cc-bb32-54eef87a96c9.jpg', '240', '1773', '是', '否', '<p>产品名称: Canon/佳能 EOS 1300D套机(18-55mm)单反级别: 入门级是否支持机身防抖: 机身不防抖屏幕尺寸: 3英寸及以上像素: 1800万储存介质: SD卡成色: 全新电池类型: 锂电池售后服务: 店铺三包上市时间: 2015年颜色分类: 1300D单机标配不带镜头有带配件 佳能18-55Ⅲ套机 佳能50 1.8STM套机 佳能18-135mm STM套机 单机+腾龙18-200VC防抖镜头 佳能18-55Ⅲ+55-250IS双头套机 佳能18-55STM套机 ★套餐6+1元换购套餐八★套餐: 官方标配 套餐一 套餐二 套餐三 套餐四 套餐五 套餐六 套餐七 套餐八单反画幅: APS-C画幅感光元件类型: CMOS对焦点数: 9点重量: 401g(含)-500g(含)取景器类型: 光学取景器是否支持外接闪光灯: 支持是否支持机身除尘: 支持是否支持机身马达: 不支持反光装置: 五面镜传感器尺寸: 22.3mmx14.9mm品牌: Canon/佳能佳能单反系列: EOS 1300D套机(18-55m</p>', '2018-03-25 16:52:54');
INSERT INTO `t_product` VALUES ('5', '4', '保视力护眼充电式LED台灯', 'upload/aef140a2-4095-4dd4-b80d-ae01779ea8ce.jpg', '258', '49', '是', '是', '<p>品牌名称：<span class=\"J_EbrandLogo\" style=\"margin: 0px; padding: 0px; color: rgb(51, 51, 51);\">ESAER</span></p><p class=\"attr-list-hd tm-clear\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 5px 20px; line-height: 22px; color: rgb(153, 153, 153); font-family: tahoma, arial, 微软雅黑, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; font-weight: 700; float: left;\">产品参数：</span></p><ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p>证书编号：2017011001012865</p></li><li><p>证书状态：有效</p></li><li><p>产品名称：可移式灯具（LED台灯，台式/夹式，LED 模块用交流电子控制装置，带调光开关，Ⅱ类，IP20，适宜直接安装在普通可燃材料表面）</p></li><li><p>3C规格型号：见附件。100-240V～ 50/60Hz</p></li><li><p>品牌:&nbsp;ESAER</p></li><li><p>型号:&nbsp;LY699</p></li><li><p>开关类型:&nbsp;触摸开关</p></li><li><p>质保年限:&nbsp;5年</p></li><li><p>颜色分类:&nbsp;插电【不带电池】款 调光调色-7W功率&nbsp;充电【2000MAH】款 调光调色-7W功率</p></li><li><p>光源类型:&nbsp;LED</p></li><li><p>灯具是否带光源:&nbsp;带光源</p></li><li><p>材质:&nbsp;ABS</p></li><li><p>功率:&nbsp;1W(含)-10W(含)</p></li><li><p>电压:&nbsp;≤36V(含)</p></li></ul><p><br/></p>', '2018-03-25 16:55:19');

-- ----------------------------
-- Table structure for `t_productclass`
-- ----------------------------
DROP TABLE IF EXISTS `t_productclass`;
CREATE TABLE `t_productclass` (
  `classId` int(11) NOT NULL AUTO_INCREMENT COMMENT '类别id',
  `className` varchar(40) NOT NULL COMMENT '类别名称',
  `classDesc` varchar(500) NOT NULL COMMENT '类别描述',
  PRIMARY KEY (`classId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_productclass
-- ----------------------------
INSERT INTO `t_productclass` VALUES ('1', '手机相关', '卖所有的手机');
INSERT INTO `t_productclass` VALUES ('2', '电脑相关', '所有的电脑产品');
INSERT INTO `t_productclass` VALUES ('3', '数码产品', '各种数码产品');
INSERT INTO `t_productclass` VALUES ('4', '学习用品', '学习相关的');

-- ----------------------------
-- Table structure for `t_recharge`
-- ----------------------------
DROP TABLE IF EXISTS `t_recharge`;
CREATE TABLE `t_recharge` (
  `rechargeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '充值id',
  `userObj` varchar(30) NOT NULL COMMENT '充值用户',
  `rechargeMoney` float NOT NULL COMMENT '充值金额',
  `rechargeMemo` varchar(500) DEFAULT NULL COMMENT '充值备注',
  `rechargeTime` varchar(20) DEFAULT NULL COMMENT '充值时间',
  PRIMARY KEY (`rechargeId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_recharge_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_recharge
-- ----------------------------
INSERT INTO `t_recharge` VALUES ('1', 'user1', '100', 'test', '2018-03-27 23:46:49');
INSERT INTO `t_recharge` VALUES ('2', 'user1', '50', 'test22', '2018-03-27 23:31:50');
INSERT INTO `t_recharge` VALUES ('3', 'user1', '50', '333', '2018-03-27 23:33:05');
INSERT INTO `t_recharge` VALUES ('4', 'user2', '3000', '给用户充值', '2018-03-31 14:01:58');
INSERT INTO `t_recharge` VALUES ('5', 'user3', '2000', '测试', '2023-11-16 18:27:19');

-- ----------------------------
-- Table structure for `t_recipel`
-- ----------------------------
DROP TABLE IF EXISTS `t_recipel`;
CREATE TABLE `t_recipel` (
  `recipelId` int(11) NOT NULL AUTO_INCREMENT COMMENT '处方id',
  `recipelPhoto` varchar(60) NOT NULL COMMENT '处方照片',
  `userObj` varchar(30) NOT NULL COMMENT '上传用户',
  `recipelMemo` varchar(500) DEFAULT NULL COMMENT '处方备注',
  `handState` varchar(20) NOT NULL COMMENT '处理状态',
  `addTime` varchar(20) DEFAULT NULL COMMENT '上传时间',
  PRIMARY KEY (`recipelId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_recipel_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_recipel
-- ----------------------------
INSERT INTO `t_recipel` VALUES ('1', 'upload/NoImage.jpg', 'user1', '二医院医院开的处方', '待处理', '2018-01-14 23:46:00');
INSERT INTO `t_recipel` VALUES ('2', 'upload/NoImage.jpg', 'user1', '开点青霉素', '已处理', '2018-01-23 22:51:44');

-- ----------------------------
-- Table structure for `t_recommend`
-- ----------------------------
DROP TABLE IF EXISTS `t_recommend`;
CREATE TABLE `t_recommend` (
  `recommend_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) DEFAULT NULL,
  `item_id` varchar(30) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  PRIMARY KEY (`recommend_id`)
) ENGINE=InnoDB AUTO_INCREMENT=306 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_recommend
-- ----------------------------

-- ----------------------------
-- Table structure for `t_shopcart`
-- ----------------------------
DROP TABLE IF EXISTS `t_shopcart`;
CREATE TABLE `t_shopcart` (
  `cartId` int(11) NOT NULL AUTO_INCREMENT COMMENT '购物车id',
  `productObj` int(11) NOT NULL COMMENT '商品',
  `userObj` varchar(30) NOT NULL COMMENT '用户',
  `price` float NOT NULL COMMENT '单价',
  `buyNum` int(11) NOT NULL COMMENT '购买数量',
  PRIMARY KEY (`cartId`),
  KEY `productObj` (`productObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_shopcart_ibfk_1` FOREIGN KEY (`productObj`) REFERENCES `t_product` (`productId`),
  CONSTRAINT `t_shopcart_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_shopcart
-- ----------------------------
INSERT INTO `t_shopcart` VALUES ('4', '2', 'user3', '1299', '1');

-- ----------------------------
-- Table structure for `t_similar_item`
-- ----------------------------
DROP TABLE IF EXISTS `t_similar_item`;
CREATE TABLE `t_similar_item` (
  `similar_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录id',
  `item_id` varchar(255) NOT NULL COMMENT '物品id',
  `similar_item_id` varchar(255) NOT NULL COMMENT '相似物品id',
  `similar` float NOT NULL COMMENT '相似度',
  PRIMARY KEY (`similar_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_similar_item
-- ----------------------------

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) DEFAULT NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) DEFAULT NULL COMMENT '家庭地址',
  `userMoney` float NOT NULL COMMENT '账户余额',
  `regTime` varchar(20) DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('user1', '123', '双鱼林', '男', '2018-03-24', 'upload/2a4f0e05-2407-44d0-b510-0b04a8cfa620.jpg', '13598308394', 'dashen@163.com', '四川成都红星路13号', '9200.4', '2018-03-25 23:41:53');
INSERT INTO `t_userinfo` VALUES ('user2', '123', '王小琴', '女', '2018-03-30', 'upload/5623884d-dacc-455d-8ec7-2ff9148dc228.jpg', '13598039934', 'xiaoqin@163.com', '四川南充海阳路12号', '52', '2018-03-31 13:58:00');
INSERT INTO `t_userinfo` VALUES ('user3', '123', '王晓婷', '女', '2009-06-11', 'upload/NoImage.jpg', '13512983942', 'xiaoting@163.com', '成都火车北站', '701', '2023-11-16 18:02:46');
INSERT INTO `t_userinfo` VALUES ('user4', '123', '王兵', '男', '2023-11-07', 'upload/NoImage.jpg', '13451099023', 'wangbin@163.com', '南京', '2401', '2023-11-18 02:57:47');
INSERT INTO `t_userinfo` VALUES ('user5', '123', '李茜', '女', '2023-11-08', 'upload/NoImage.jpg', '13598099834', 'liqian@163.com', '西安', '2401', '2023-11-18 02:58:23');
