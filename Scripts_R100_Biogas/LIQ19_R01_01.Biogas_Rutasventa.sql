USE [LIQ19_Liquidaciones_V9999_R0] 
GO
/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 100137
Source Host           : localhost:3306
Source Database       : Liqsys

Target Server Type    : MYSQL
Target Server Version : 100137
File Encoding         : 65001

Date: 2019-01-29 09:59:54
*/

--SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for rutasventa
-- ----------------------------
DROP TABLE IF EXISTS [BD_Biogas_Liqsys_rutasventa];
GO

CREATE TABLE [BD_Biogas_Liqsys_rutasventa] (
  [idRuta] int NOT NULL, --AUTO_INCREMENT,
  [ruta] varchar(50) NOT NULL DEFAULT 'N/D',
  [division] varchar(25) NOT NULL DEFAULT 'ESTACIONARIO',
  [tipoR] varchar(50) NOT NULL DEFAULT 'PROPIA',
  [sucursal] varchar(50) NOT NULL DEFAULT 'MARKETING',
  [recargaLts] decimal(19,4) NOT NULL DEFAULT 0.0000,
  [recargaCarb] decimal(19,4) NOT NULL DEFAULT 0.0000,
  [celular] varchar(10) NOT NULL DEFAULT '0',
  [tiempoEntrega] int NOT NULL DEFAULT 60,
  [estadoR] int NOT NULL DEFAULT 1,
  [fechaAlta] datetime NOT NULL DEFAULT '2011-01-01 00:00:00',
  [usuarioAlta] varchar(50) NOT NULL DEFAULT 'N/D',
  PRIMARY KEY ([idRuta])
)

GO


-- ----------------------------
-- Records of rutasventa
-- ----------------------------

-- //////////////////////////////////////////////////////////////
-- // CARGA INICIAL
-- //////////////////////////////////////////////////////////////

-- ===============================================
SET NOCOUNT ON
-- ===============================================


INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('1', 'BE201', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('2', 'C133', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('3', '0', 'AUTOTANQUE', 'PROPIA', 'MARKETING', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('4', 'BE03', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('5', 'BE04', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('6', 'BG03', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('7', 'BE01', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('8', 'BE02', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('9', 'BE05', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('10', 'BG02', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('11', 'BG05', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('12', 'BG06', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('13', 'BG08', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('14', 'BG09', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('15', 'BG10', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('16', 'BG11', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('17', 'BG18', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('18', 'BG12', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('19', 'BG19', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('20', 'BG20', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('21', 'BG21', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('22', 'BG22', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('23', 'BG27', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('24', 'BG28', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('25', 'BG30', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('26', 'BG31', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('27', 'C135', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('28', 'U55 EXP', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('29', 'C121', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('30', 'C132', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('31', 'C134', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('32', 'C122', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('33', 'C123', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('34', 'C124', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('35', 'C125', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('36', 'C126', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('37', 'C127', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('38', 'C128', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('39', 'C129', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('40', 'C130', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('41', 'C131', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('42', 'C136', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('43', 'C02', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('44', 'C43', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('45', 'C116', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('46', 'U02', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('47', 'U46', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('48', 'U53', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('49', 'U100', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '0', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('50', 'BG29', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '0', '60', '1', '2012-10-25 16:31:32', 'robot');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('51', 'N02', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2012-10-29 14:10:50', 'rgonzalez');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('52', 'TTEST', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2012-10-29 17:21:12', 'rgonzalez');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('53', 'TEST', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2012-10-29 17:21:17', 'rgonzalez');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('54', 'BG23GLP', 'AUTOTANQUE', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '0', '2012-12-06 09:51:47', 'rgonzalez');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('55', 'BG07GLP', 'AUTOTANQUE', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '0', '2012-12-06 09:52:12', 'rgonzalez');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('56', 'PORVENIR', 'PORTATIL', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '0', '2012-12-06 09:54:02', 'rgonzalez');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('57', 'BG17', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2012-12-21 17:23:45', 'earaujo');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('58', 'BG23', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2012-12-26 16:35:14', 'azavala');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('59', 'BG07', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2012-12-26 16:35:26', 'azavala');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('60', 'CG1', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2012-12-26 16:36:20', 'azavala');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('61', 'BE09', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2013-04-09 13:31:35', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('62', 'BE08', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2013-04-09 13:31:43', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('63', 'BG32', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2013-04-09 13:32:04', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('64', 'BG33', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2013-07-04 13:50:02', 'jpedroza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('65', 'C137', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2013-08-29 10:52:53', 'jpedroza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('66', 'C138', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2013-12-26 11:33:11', 'jpedroza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('67', 'C139', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2013-12-26 11:33:18', 'jpedroza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('68', 'C140', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2013-12-26 11:33:24', 'jpedroza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('69', 'C141', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2013-12-26 11:33:31', 'jpedroza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('70', 'N01', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2013-12-26 11:33:52', 'jpedroza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('71', 'U54 EXP', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2013-12-26 11:33:59', 'jpedroza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('72', 'U-11', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2013-12-26 11:34:05', 'jpedroza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('73', 'BG34', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '9173.0000', '143.0000', '', '60', '1', '2013-12-30 09:52:01', 'jpedroza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('74', 'BG35', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2014-01-25 13:32:18', 'jpedroza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('75', 'BG36', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2014-06-27 15:37:15', 'azavala');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('76', 'GUA-CG1', 'AUTOTANQUE', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '1', '2014-08-26 12:09:32', 'jpedroza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('77', 'GUACG1', 'PORTATIL', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '1', '2014-08-26 12:35:21', 'jpedroza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('78', 'GUA-BG23', 'AUTOTANQUE', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '1', '2014-08-26 12:35:42', 'jpedroza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('79', 'GUA-BG07', 'AUTOTANQUE', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '1', '2014-08-26 12:36:06', 'jpedroza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('80', 'BG37', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2015-01-20 09:33:37', 'azavala');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('81', 'PORTALES', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2015-03-30 16:24:29', 'jpedroza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('82', 'GUA-BG33', 'AUTOTANQUE', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '1', '2015-06-20 13:40:22', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('83', 'COCA-COLA JRZ', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2015-07-09 09:10:13', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('84', 'DEL RIO 184', 'PORTATIL', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '1', '2015-08-25 16:12:54', 'jpedroza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('85', '13', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 13:19:47', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('86', '15', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:06:03', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('87', '74', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:06:49', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('88', '93', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:07:02', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('89', '108', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:07:23', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('90', '112', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:07:32', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('91', '132', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:08:00', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('92', '146', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:08:09', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('93', '147', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:08:17', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('94', '163', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:08:37', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('95', '164', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:08:44', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('96', '178', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:08:59', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('97', '187', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:09:07', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('98', '192', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:09:14', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('99', '193', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:09:20', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('100', '199', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:09:28', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('101', '201', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:09:33', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('102', '206', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:09:41', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('103', '128', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-01 14:09:48', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('104', 'GRANJERO', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-05 11:05:24', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('105', 'DELRIO 141', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-05 13:09:14', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('106', 'DELRIO 35', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-05 13:09:24', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('107', 'DELRIO 162', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-05 13:35:56', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('108', 'DEL RIO 37', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-15 15:19:18', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('109', 'DEL RIO 11', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-15 15:22:46', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('110', 'DEL RIO 40', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-24 14:36:59', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('111', 'DEL RIO 73', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-24 14:38:45', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('112', 'DEL RIO 106', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-24 14:38:57', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('113', 'DEL RIO 29', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-09-26 11:54:51', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('114', '123', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-10-20 15:24:34', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('115', '49', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-10-20 15:24:52', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('116', '131', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-10-20 15:25:09', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('117', '90', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-10-20 15:25:35', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('118', 'MINI-SUP-OSCARIN', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-10-20 15:26:12', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('119', 'DEL RIO 105', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-10-24 11:42:07', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('120', 'DEL RIO 69', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-10-24 11:42:23', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('121', 'DEL RIO 31', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-10-24 11:42:34', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('122', 'DEL RIO 182', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-10-24 11:42:46', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('123', 'DEL RIO 96', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-10-24 11:42:58', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('124', 'COM.AUT-SERV.JUAREZ', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-10-24 11:43:53', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('125', 'DEL RIO 32', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:09:34', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('126', 'DEL RIO 155', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:10:46', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('127', 'DEL RIO 167', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:10:55', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('128', 'DEL RIO 174', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:11:05', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('129', 'DEL RIO 172', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:11:16', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('130', 'DEL RIO 110', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:11:32', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('131', 'DEL RIO 36', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:11:42', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('132', 'DEL RIO 116', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:11:53', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('133', 'DEL RIO 25', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:12:03', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('134', 'DEL RIO 143', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:12:11', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('135', 'DEL RIO 149', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:12:20', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('136', 'ABRR LA PILA', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:21:35', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('137', 'ABRR CHILINDRINO', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:21:53', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('138', 'SN PEDRO ET.4', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:22:18', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('139', 'SUP. DEL VALLE SONETO', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:22:50', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('140', 'ABRR. TENIENTE', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:23:06', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('141', 'ABRR. ERKA', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:26:12', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('142', 'ABRR. SARITA', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:26:25', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('143', 'CHICH. JUAN JARAMILLO', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:26:56', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('144', 'ABRR. ANGEL', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:27:07', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('145', 'ABRR. DEL VALLE', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:27:33', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('146', 'HIPOCAMPO R.ANAPRA', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-03 12:27:53', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('147', 'ESTACION TORRES', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-12 12:24:54', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('148', 'ESTACION ANAPRA', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-12 12:25:11', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('149', 'BG-36', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-18 15:44:23', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('150', 'DEL RIO 07', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-26 13:46:05', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('151', 'DEL RIO 19', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-26 13:46:14', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('152', 'DEL RIO 113', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-26 13:46:22', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('153', 'DEL RIO 215', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-26 13:46:29', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('154', 'DEL RIO 203', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-11-26 13:46:38', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('155', 'DEL RIO 115', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-12-14 16:28:22', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('156', 'DEL 209', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-12-14 16:31:04', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('157', 'DEL RIO 148', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2015-12-14 16:31:52', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('158', 'DEL RIO 64', 'PORTATIL', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '1', '2015-12-18 09:28:09', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('159', 'BARRIALES', 'PORTATIL', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '1', '2016-01-13 13:47:09', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('160', 'PRAXEDIS', 'PORTATIL', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '1', '2016-01-13 13:47:27', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('161', 'SAN AGUSTIN II', 'PORTATIL', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '1', '2016-03-23 11:38:20', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('162', 'BG38', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2016-06-24 12:49:48', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('163', 'EJIDO GPE VICTORIA', 'PORTATIL', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '1', '2016-06-28 12:41:33', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('164', 'CONULADO INN', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2016-07-30 11:37:53', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('165', 'LOMA BLCA', 'PORTATIL', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '1', '2016-08-01 11:58:17', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('166', 'ISTORR-B', 'CARBURACION', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2016-08-15 11:55:29', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('167', 'ISTORR', 'CARBURACION', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2016-08-15 11:55:44', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('168', 'ISTORR A', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2016-08-15 16:25:26', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('169', 'ISTORR B', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2016-08-15 16:25:37', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('170', 'JRZ Y REFORMA II', 'PORTATIL', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '1', '2016-08-30 13:29:21', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('171', 'LA MOLINERA', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2016-09-01 10:50:10', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('172', 'ISHENE', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2016-09-02 14:42:07', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('173', 'ISCORO', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2016-09-30 09:58:43', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('174', 'N-11', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2016-10-11 14:26:19', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('175', 'N11', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2016-10-11 14:39:29', 'azavala');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('176', 'DEL RIO 142', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2016-10-24 13:26:32', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('177', 'DEL RIO 208', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2016-10-24 13:27:10', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('178', 'DEL RIO 219', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2016-10-24 13:27:27', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('179', 'N-01 EXPENDIDOS', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2016-11-16 10:27:44', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('180', 'N 01 EXPENDIDOS', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2016-11-16 10:39:26', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('181', 'BE202', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2016-12-06 14:51:19', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('182', 'IZARA-B', 'CARBURACION', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2016-12-15 15:32:55', 'azavala');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('183', 'ISRAAN-B', 'CARBURACION', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2016-12-22 12:25:13', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('184', 'ISRAAN', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2016-12-22 17:18:25', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('185', 'MONTACARGAS 301', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-01-03 14:50:23', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('186', 'MONTACARGAS 302', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-01-03 14:50:36', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('187', 'GASVEHICULAR', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-01-20 10:38:19', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('188', 'BE203', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-02-08 10:14:07', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('189', 'BE204', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-02-08 10:14:21', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('190', 'BE205', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-02-08 10:14:30', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('191', 'BE206', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-02-10 11:15:37', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('192', 'BE207', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-02-13 15:13:20', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('193', 'ISAEROX', 'CARBURACION', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-02-15 11:27:27', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('194', 'ISAERO', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-02-15 11:32:46', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('195', 'ISLIBE', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-02-17 10:28:22', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('196', 'C142', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-03-09 16:01:23', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('197', 'C143', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-03-09 16:01:41', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('198', 'C144', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-03-09 16:01:48', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('199', 'C145', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-03-09 16:01:56', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('200', 'C146', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-03-09 16:02:05', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('201', 'C147', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-03-09 16:02:13', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('202', 'ISMEZ', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-03-15 16:02:20', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('203', 'GUA-BG36', 'AUTOTANQUE', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '1', '2017-03-30 10:55:08', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('204', 'ACUARIO', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 12:35:45', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('205', 'COL.ESPERANZA', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 12:36:15', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('206', 'DELRIO-45', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 12:36:36', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('207', 'DELRIO-63', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 12:36:49', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('208', 'DELRIO-64', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 12:36:59', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('209', 'DELRIO-184', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 12:37:09', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('210', 'EJ-GPE-VICTO', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 12:37:42', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('211', 'EMIL-ZAPATA', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 12:37:58', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('212', 'JRZ Y REF-2', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 12:38:11', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('213', 'JRZ Y REF.', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 12:38:26', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('214', 'LOMA BCA', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 12:38:39', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('215', 'MIMBRE', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 12:39:05', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('216', 'PRAJEDIS', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 12:41:13', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('217', 'SAN-AGUSTIN', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 12:41:42', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('218', 'SAN-AGUSTIN-2', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 12:42:00', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('219', 'SAN-ISIDRO', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 12:42:18', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('220', 'SAN JOSE PAREDES', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 12:47:54', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('221', 'SAN ISIDRO-2', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '0', '2017-04-05 13:00:30', 'iperaza');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('222', 'ASC02', 'AUTOTANQUE', 'PROPIA', 'ASCENSION', '0.0000', '0.0000', '', '60', '1', '2017-06-05 12:18:06', 'dcabrera');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('223', 'ASC03', 'AUTOTANQUE', 'PROPIA', 'ASCENSION', '0.0000', '0.0000', '', '60', '1', '2017-06-05 12:18:15', 'dcabrera');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('224', 'ASC04', 'AUTOTANQUE', 'PROPIA', 'ASCENSION', '0.0000', '0.0000', '', '60', '1', '2017-06-05 12:18:21', 'dcabrera');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('225', 'ASC05', 'AUTOTANQUE', 'PROPIA', 'ASCENSION', '0.0000', '0.0000', '', '60', '1', '2017-06-05 12:18:29', 'dcabrera');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('226', 'ASC EST', 'AUTOTANQUE', 'PROPIA', 'ASCENSION', '0.0000', '0.0000', '', '60', '1', '2017-06-05 12:18:43', 'dcabrera');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('227', 'AS01', 'PORTATIL', 'PROPIA', 'ASCENSION', '0.0000', '0.0000', '', '60', '1', '2017-06-05 12:31:40', 'dcabrera');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('228', 'ANDEN JANOS', 'PORTATIL', 'PROPIA', 'ASCENSION', '0.0000', '0.0000', '', '60', '1', '2017-06-05 12:31:51', 'dcabrera');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('229', 'ANDEN ASC', 'PORTATIL', 'PROPIA', 'ASCENSION', '0.0000', '0.0000', '', '60', '1', '2017-06-05 12:32:05', 'dcabrera');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('230', 'ISPARAJ', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-07-26 16:42:36', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('231', 'ISMEZQ', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-10-14 12:41:48', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('232', 'ALMACEN 1', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-10-27 10:28:56', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('233', 'PUE01', 'AUTOTANQUE', 'PROPIA', 'PUEBLO', '0.0000', '0.0000', '', '60', '1', '2017-11-29 09:18:26', 'dcabrera');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('234', 'PUE02', 'AUTOTANQUE', 'PROPIA', 'PUEBLO', '0.0000', '0.0000', '', '60', '1', '2017-11-29 09:18:33', 'dcabrera');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('235', 'CARB VILLA', 'AUTOTANQUE', 'PROPIA', 'PUEBLO', '0.0000', '0.0000', '', '60', '1', '2017-11-29 09:18:39', 'dcabrera');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('236', 'ISPARAJ2', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-12-06 16:59:25', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('237', 'ISZARA-B', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2017-12-09 11:10:43', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('238', 'PORFIRIO', 'PORTATIL', 'PROPIA', 'GUADALUPE', '0.0000', '0.0000', '', '60', '1', '2018-02-19 10:32:17', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('239', 'ISCARBINT', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2018-03-15 09:39:19', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('240', 'N01 EXP', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2018-04-05 14:07:05', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('241', 'ISKM20B', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2018-06-01 13:39:12', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('242', 'ISKM20-B', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2018-06-01 16:23:33', 'jruiz.c');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('243', 'ISRAYON2', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2018-07-02 14:43:59', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('244', 'ISPASEO', 'AUTOTANQUE', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2018-10-13 12:43:53', 'arojas');
INSERT INTO [BD_Biogas_Liqsys_rutasventa] VALUES ('245', 'C301', 'PORTATIL', 'PROPIA', 'BIOGAS', '0.0000', '0.0000', '', '60', '1', '2018-12-21 11:11:50', 'arojas');
--SET FOREIGN_KEY_CHECKS=1


GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================
GO

