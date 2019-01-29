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

Date: 2019-01-21 10:21:15
*/

--SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for llenado
-- ----------------------------
DROP TABLE IF EXISTS [BD_Biogas_Liqsys_llenado];
GO

CREATE TABLE [BD_Biogas_Liqsys_llenado] (
  [idLiqLlenado] int NOT NULL,
  [idPreLiq] int NOT NULL DEFAULT 0,
  [idUnidad] int NOT NULL,
  [numPuesto] int NOT NULL,
  [idLlenador] int NOT NULL,
  [tipoLlenado] int NOT NULL DEFAULT 1,
  [inicioLlenado] datetime NOT NULL DEFAULT '2011-01-01 00:00:00',
  [finLlenado] datetime NOT NULL DEFAULT '2011-01-01 00:00:00',
  [litrosSurtidos] decimal(19,4) NOT NULL DEFAULT 0.0000,
  [kgsSurtidos] decimal(19,4) NOT NULL DEFAULT 0.0000,
  [densidad] decimal(19,4) NOT NULL DEFAULT 0.0000,
  [temperatura] decimal(19,4) NOT NULL DEFAULT 0.0000,
  [estadoLlenadoM] int NOT NULL DEFAULT 1,
	PRIMARY KEY ([idLiqLlenado])	
)

-- ----------------------------
-- Records of llenado
-- ----------------------------
--SET FOREIGN_KEY_CHECKS=1;
