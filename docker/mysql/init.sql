-- ==========================================
-- JPetStore 数据库初始化脚本
-- 用于 MySQL 8.0 Docker 容器首次启动时自动执行
-- ==========================================

CREATE DATABASE IF NOT EXISTS jpetstore
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE jpetstore;

-- ==========================================
-- 建表语句
-- ==========================================

DROP TABLE IF EXISTS `lineitem`;
DROP TABLE IF EXISTS `orderstatus`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `cart`;
DROP TABLE IF EXISTS `inventory`;
DROP TABLE IF EXISTS `item`;
DROP TABLE IF EXISTS `product`;
DROP TABLE IF EXISTS `bannerdata`;
DROP TABLE IF EXISTS `profile`;
DROP TABLE IF EXISTS `signon`;
DROP TABLE IF EXISTS `address`;
DROP TABLE IF EXISTS `account`;
DROP TABLE IF EXISTS `supplier`;
DROP TABLE IF EXISTS `category`;
DROP TABLE IF EXISTS `sequence`;

CREATE TABLE `category` (
  `catid` varchar(10) NOT NULL,
  `name` varchar(80) DEFAULT NULL,
  `descn` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`catid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `supplier` (
  `suppid` int NOT NULL,
  `name` varchar(80) DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `addr1` varchar(80) DEFAULT NULL,
  `addr2` varchar(80) DEFAULT NULL,
  `city` varchar(80) DEFAULT NULL,
  `state` varchar(80) DEFAULT NULL,
  `zip` varchar(5) DEFAULT NULL,
  `phone` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`suppid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `product` (
  `productid` varchar(10) NOT NULL,
  `category` varchar(10) NOT NULL,
  `name` varchar(80) DEFAULT NULL,
  `descn` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`productid`),
  KEY `productCat` (`category`),
  KEY `productName` (`name`),
  CONSTRAINT `fk_product_1` FOREIGN KEY (`category`) REFERENCES `category` (`catid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `item` (
  `itemid` varchar(10) NOT NULL,
  `productid` varchar(10) NOT NULL,
  `listprice` decimal(10,2) DEFAULT NULL,
  `unitcost` decimal(10,2) DEFAULT NULL,
  `supplier` int DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `attr1` varchar(80) DEFAULT NULL,
  `attr2` varchar(80) DEFAULT NULL,
  `attr3` varchar(80) DEFAULT NULL,
  `attr4` varchar(80) DEFAULT NULL,
  `attr5` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`itemid`),
  KEY `fk_item_2` (`supplier`),
  KEY `itemProd` (`productid`),
  CONSTRAINT `fk_item_1` FOREIGN KEY (`productid`) REFERENCES `product` (`productid`),
  CONSTRAINT `fk_item_2` FOREIGN KEY (`supplier`) REFERENCES `supplier` (`suppid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `inventory` (
  `itemid` varchar(10) NOT NULL,
  `qty` int NOT NULL,
  PRIMARY KEY (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `account` (
  `userid` varchar(80) NOT NULL,
  `email` varchar(80) NOT NULL,
  `firstname` varchar(80) NOT NULL,
  `lastname` varchar(80) NOT NULL,
  `status` varchar(2) DEFAULT NULL,
  `addr1` varchar(80) NOT NULL,
  `addr2` varchar(40) DEFAULT NULL,
  `city` varchar(80) NOT NULL,
  `state` varchar(80) NOT NULL,
  `zip` varchar(20) NOT NULL,
  `country` varchar(20) NOT NULL,
  `phone` varchar(80) NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `address` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(80) NOT NULL,
  `first_name` varchar(80) NOT NULL,
  `last_name` varchar(80) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address1` varchar(80) NOT NULL,
  `address2` varchar(80) DEFAULT NULL,
  `city` varchar(80) NOT NULL,
  `state` varchar(80) NOT NULL,
  `zip` varchar(20) NOT NULL,
  `country` varchar(20) NOT NULL,
  `is_default` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `signon` (
  `username` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `profile` (
  `userid` varchar(80) NOT NULL,
  `langpref` varchar(80) NOT NULL,
  `favcategory` varchar(30) DEFAULT NULL,
  `mylistopt` int DEFAULT NULL,
  `banneropt` int DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `bannerdata` (
  `favcategory` varchar(80) NOT NULL,
  `bannername` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`favcategory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `cart` (
  `user_id` varchar(80) NOT NULL,
  `item_id` varchar(10) NOT NULL,
  `product_id` varchar(10) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `in_stock` tinyint(1) DEFAULT '1',
  `quantity` int NOT NULL DEFAULT '1',
  `list_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`user_id`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `orders` (
  `orderid` int NOT NULL,
  `userid` varchar(80) NOT NULL,
  `orderdate` date NOT NULL,
  `shipaddr1` varchar(80) NOT NULL,
  `shipaddr2` varchar(80) DEFAULT NULL,
  `shipcity` varchar(80) NOT NULL,
  `shipstate` varchar(80) NOT NULL,
  `shipzip` varchar(20) NOT NULL,
  `shipcountry` varchar(20) NOT NULL,
  `billaddr1` varchar(80) NOT NULL,
  `billaddr2` varchar(80) DEFAULT NULL,
  `billcity` varchar(80) NOT NULL,
  `billstate` varchar(80) NOT NULL,
  `billzip` varchar(20) NOT NULL,
  `billcountry` varchar(20) NOT NULL,
  `courier` varchar(80) NOT NULL,
  `totalprice` decimal(10,2) NOT NULL,
  `billtofirstname` varchar(80) NOT NULL,
  `billtolastname` varchar(80) NOT NULL,
  `shiptofirstname` varchar(80) NOT NULL,
  `shiptolastname` varchar(80) NOT NULL,
  `creditcard` varchar(80) NOT NULL,
  `exprdate` varchar(7) NOT NULL,
  `cardtype` varchar(80) NOT NULL,
  `locale` varchar(80) NOT NULL,
  `status` varchar(2) DEFAULT 'P',
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `orderstatus` (
  `orderid` int NOT NULL,
  `linenum` int NOT NULL,
  `timestamp` date NOT NULL,
  `status` varchar(2) NOT NULL,
  PRIMARY KEY (`orderid`,`linenum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `lineitem` (
  `orderid` int NOT NULL,
  `linenum` int NOT NULL,
  `itemid` varchar(10) NOT NULL,
  `quantity` int NOT NULL,
  `unitprice` decimal(10,2) NOT NULL,
  PRIMARY KEY (`orderid`,`linenum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `sequence` (
  `name` varchar(30) NOT NULL,
  `nextid` int NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ==========================================
-- 初始数据
-- ==========================================

INSERT INTO `category` VALUES
('BIRDS','Birds','<image src=\"../images/birds_icon.gif\"><font size=\"5\" color=\"blue\"> Birds</font>'),
('CATS','Cats','<image src=\"../images/cats_icon.gif\"><font size=\"5\" color=\"blue\"> Cats</font>'),
('DOGS','Dogs','<image src=\"../images/dogs_icon.gif\"><font size=\"5\" color=\"blue\"> Dogs</font>'),
('FISH','Fish','<image src=\"../images/fish_icon.gif\"><font size=\"5\" color=\"blue\"> Fish</font>'),
('REPTILES','Reptiles','<image src=\"../images/reptiles_icon.gif\"><font size=\"5\" color=\"blue\"> Reptiles</font>');

INSERT INTO `supplier` VALUES
(1,'XYZ Pets','AC','600 Avon Way','','Los Angeles','CA','94024','212-947-0797'),
(2,'ABC Pets','AC','700 Abalone Way','','San Francisco ','CA','94024','415-947-0797');

INSERT INTO `product` VALUES
('AV-CB-01','BIRDS','Amazon Parrot','<image src=\"../images/bird2.gif\">Great companion for up to 75 years'),
('AV-SB-02','BIRDS','Finch','<image src=\"../images/bird1.gif\">Great stress reliever'),
('FI-FW-01','FISH','Koi','<image src=\"../images/fish3.gif\">Fresh Water fish from Japan'),
('FI-FW-02','FISH','Goldfish','<image src=\"../images/fish2.gif\">Fresh Water fish from China'),
('FI-SW-01','FISH','Angelfish','<image src=\"../images/fish1.gif\">Salt Water fish from Australia'),
('FI-SW-02','FISH','Tiger Shark','<image src=\"../images/fish4.gif\">Salt Water fish from Australia'),
('FL-DLH-02','CATS','Persian','<image src=\"../images/cat1.gif\">Friendly house cat, doubles as a princess'),
('FL-DSH-01','CATS','Manx','<image src=\"../images/cat2.gif\">Great for reducing mouse populations'),
('K9-BD-01','DOGS','Bulldog','<image src=\"../images/dog2.gif\">Friendly dog from England'),
('K9-CW-01','DOGS','Chihuahua','<image src=\"../images/dog4.gif\">Great companion dog'),
('K9-DL-01','DOGS','Dalmation','<image src=\"../images/dog5.gif\">Great dog for a Fire Station'),
('K9-PO-02','DOGS','Poodle','<image src=\"../images/dog6.gif\">Cute dog from France'),
('K9-RT-01','DOGS','Golden Retriever','<image src=\"../images/dog1.gif\">Great family dog'),
('K9-RT-02','DOGS','Labrador Retriever','<image src=\"../images/dog5.gif\">Great hunting dog'),
('RP-LI-02','REPTILES','Iguana','<image src=\"../images/lizard1.gif\">Friendly green friend'),
('RP-SN-01','REPTILES','Rattlesnake','<image src=\"../images/snake1.gif\">Doubles as a watch dog');

INSERT INTO `item` VALUES
('EST-1','FI-SW-01',16.50,10.00,1,'P','Large',NULL,NULL,NULL,NULL),
('EST-10','K9-DL-01',18.50,12.00,1,'P','Spotted Adult Female',NULL,NULL,NULL,NULL),
('EST-11','RP-SN-01',18.50,12.00,1,'P','Venomless',NULL,NULL,NULL,NULL),
('EST-12','RP-SN-01',18.50,12.00,1,'P','Rattleless',NULL,NULL,NULL,NULL),
('EST-13','RP-LI-02',18.50,12.00,1,'P','Green Adult',NULL,NULL,NULL,NULL),
('EST-14','FL-DSH-01',58.50,12.00,1,'P','Tailless',NULL,NULL,NULL,NULL),
('EST-15','FL-DSH-01',23.50,12.00,1,'P','With tail',NULL,NULL,NULL,NULL),
('EST-16','FL-DLH-02',93.50,12.00,1,'P','Adult Female',NULL,NULL,NULL,NULL),
('EST-17','FL-DLH-02',93.50,12.00,1,'P','Adult Male',NULL,NULL,NULL,NULL),
('EST-18','AV-CB-01',193.50,92.00,1,'P','Adult Male',NULL,NULL,NULL,NULL),
('EST-19','AV-SB-02',15.50,2.00,1,'P','Adult Male',NULL,NULL,NULL,NULL),
('EST-2','FI-SW-01',16.50,10.00,1,'P','Small',NULL,NULL,NULL,NULL),
('EST-20','FI-FW-02',5.50,2.00,1,'P','Adult Male',NULL,NULL,NULL,NULL),
('EST-21','FI-FW-02',5.29,1.00,1,'P','Adult Female',NULL,NULL,NULL,NULL),
('EST-22','K9-RT-02',135.50,100.00,1,'P','Adult Male',NULL,NULL,NULL,NULL),
('EST-23','K9-RT-02',145.49,100.00,1,'P','Adult Female',NULL,NULL,NULL,NULL),
('EST-24','K9-RT-02',255.50,92.00,1,'P','Adult Male',NULL,NULL,NULL,NULL),
('EST-25','K9-RT-02',325.29,90.00,1,'P','Adult Female',NULL,NULL,NULL,NULL),
('EST-26','K9-CW-01',125.50,92.00,1,'P','Adult Male',NULL,NULL,NULL,NULL),
('EST-27','K9-CW-01',155.29,90.00,1,'P','Adult Female',NULL,NULL,NULL,NULL),
('EST-28','K9-RT-01',155.29,90.00,1,'P','Adult Female',NULL,NULL,NULL,NULL),
('EST-3','FI-SW-02',18.50,12.00,1,'P','Toothless',NULL,NULL,NULL,NULL),
('EST-4','FI-FW-01',18.50,12.00,1,'P','Spotted',NULL,NULL,NULL,NULL),
('EST-5','FI-FW-01',18.50,12.00,1,'P','Spotless',NULL,NULL,NULL,NULL),
('EST-6','K9-BD-01',18.50,12.00,1,'P','Male Adult',NULL,NULL,NULL,NULL),
('EST-7','K9-BD-01',18.50,12.00,1,'P','Female Puppy',NULL,NULL,NULL,NULL),
('EST-8','K9-PO-02',18.50,12.00,1,'P','Male Puppy',NULL,NULL,NULL,NULL),
('EST-9','K9-DL-01',18.50,12.00,1,'P','Spotless Male Puppy',NULL,NULL,NULL,NULL);

INSERT INTO `inventory` VALUES
('EST-1',10000),('EST-10',10000),('EST-11',10000),('EST-12',10000),
('EST-13',10000),('EST-14',10000),('EST-15',10000),('EST-16',9997),
('EST-17',10000),('EST-18',10000),('EST-19',10000),('EST-2',10000),
('EST-20',10000),('EST-21',10000),('EST-22',10000),('EST-23',10000),
('EST-24',10000),('EST-25',10000),('EST-26',10000),('EST-27',10000),
('EST-28',10000),('EST-3',10000),('EST-4',10000),('EST-5',10000),
('EST-6',10000),('EST-7',10000),('EST-8',10000),('EST-9',10000);

INSERT INTO `account` VALUES
('ACID','acid@yourdomain.com','ABC','XYX','OK','901 San Antonio Road','MS UCUP02-206','Palo Alto','CA','94303','USA','555-555-5555'),
('j2ee','yourname@yourdomain.com','ABC','XYX','OK','901 San Antonio Road','MS UCUP02-206','Palo Alto','CA','94303','USA','555-555-5555'),
('lyf','2350254763@qq.com','李','悦菲','OK','中南大学岳麓山校区本部二舍','www','changsha','www','410083','中国香港特别行政区','18773248033'),
('testuser555','test555@test.com','Test','User','OK','123 Main St','','NYC','NY','10001','USA','13800138000');

INSERT INTO `address` VALUES
(1,'lyf','李','悦菲','18773248033','中南大学岳麓山校区本部二舍','www','changsha','www','410083','中国香港特别行政区',1);

INSERT INTO `signon` VALUES
('ACID','ACID'),('j2ee','j2ee'),('lyf','123456'),('testuser555','Test123456');

INSERT INTO `profile` VALUES
('ACID','english','CATS',1,1),
('j2ee','english','DOGS',1,1),
('lyf','zh_CN','FISH',1,1),
('testuser555','zh_CN','FISH',1,1);

INSERT INTO `bannerdata` VALUES
('BIRDS','<image src=\"../images/banner_birds.gif\">'),
('CATS','<image src=\"../images/banner_cats.gif\">'),
('DOGS','<image src=\"../images/banner_dogs.gif\">'),
('FISH','<image src=\"../images/banner_fish.gif\">'),
('REPTILES','<image src=\"../images/banner_reptiles.gif\">');

INSERT INTO `cart` VALUES
('lyf','EST-4','FI-FW-01','<image src=\"../images/fish3.gif\">Fresh Water fish from Japan',1,1,18.50),
('testuser555','EST-1','FI-SW-01','<image src=\"../images/fish1.gif\">Salt Water fish from Australia',1,1,16.50);

INSERT INTO `orders` VALUES
(1000,'lyf','2026-05-28','中南大学岳麓山校区本部二舍','www','changsha','www','410083','中国香港特别行政区','中南大学岳麓山校区本部二舍','www','changsha','www','410083','中国香港特别行政区','UPS',187.00,'李','悦菲','李','悦菲','1234567890123456','02/2222','Visa','CN','P'),
(1001,'lyf','2026-05-28','中南大学岳麓山校区本部二舍','www','changsha','www','410083','中国香港特别行政区','中南大学岳麓山校区本部二舍','www','changsha','www','410083','中国香港特别行政区','FedEx',93.50,'李','悦菲','李','悦菲','1234567890123456','09/2222','Visa','CN','P');

INSERT INTO `orderstatus` VALUES
(1000,0,'2026-05-28','P'),(1001,0,'2026-05-28','P');

INSERT INTO `lineitem` VALUES
(1000,1,'EST-16',2,93.50),(1001,1,'EST-16',1,93.50);

INSERT INTO `sequence` VALUES ('ordernum',1002);
