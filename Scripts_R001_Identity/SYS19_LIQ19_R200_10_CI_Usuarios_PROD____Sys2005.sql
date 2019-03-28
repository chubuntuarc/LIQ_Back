-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			K_SISTEMA = #2006 ADG18
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	SYS19_BasicBD_20190325
-- // MODULO:			
-- // OPERACION:		LIBERACION // STORED PROCEDURE
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
-- // PASO 1 > PURGAR TABLAS [#PROD]
-- // PASO 2 > CARGA INICIAL [USUARIO#PROD]
-- // PASO 3 > CARGA INICIAL [ACCESO/UNO#PROD]
-- //////////////////////////////////////////////////////////////
-- SELECT * FROM USUARIO

-- SELECT * FROM [SYS3_ACCESO_USR_X_UNO] WHERE K_USUARIO>999
-- SELECT * FROM [SYS3_ACCESO_USR_X_RAS] WHERE K_USUARIO>999
-- SELECT * FROM [SYS3_ACCESO_USR_X_ZON] WHERE K_USUARIO>999



-- //////////////////////////////////////////////////////////////
-- // PASO 1 > PURGAR TABLAS [#PROD]
-- //////////////////////////////////////////////////////////////

DELETE 
FROM	[SYS3_ACCESO_USR_X_UNO]
WHERE	K_USUARIO>999
AND		K_SISTEMA=2005		-- K_SISTEMA = #2005 LIQ19

DELETE 
FROM	[SYS3_ACCESO_USR_X_RAS]
WHERE	K_USUARIO>999
AND		K_SISTEMA=2005		-- K_SISTEMA = #2005 LIQ19

DELETE 
FROM	[SYS3_ACCESO_USR_X_ZON]
WHERE	K_USUARIO>999
AND		K_SISTEMA=2005		-- K_SISTEMA = #2005 LIQ19

DELETE 
FROM	[USUARIO] 
WHERE	K_USUARIO>999
GO



-- //////////////////////////////////////////////////////////////
-- // PASO 2 > CARGA INICIAL [USUARIO#PROD]
-- //////////////////////////////////////////////////////////////

EXECUTE [dbo].[PG_CI_USUARIO]	0,2005,0, 1101, 'GERENTE#PROD',		'GERENTE',		'GER', 150, 1, 'ger.LIQ@tomza.com',	'GER', '123', '04/MAR/2019',	1, 1, NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,2005,0, 1102, 'CORDINADOR#PROD',	'CORDINADOR',	'COR', 160, 1, 'cor.LIQ@tomza.com',	'COR', '234', '04/MAR/2019',	1, 1, NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,2005,0, 1103, 'ANALISTA#PROD',	'ANALISTA',		'ANA', 170, 1, 'ana.LIQ@tomza.com', 'ANA', '345', '04/MAR/2019',	1, 1, NULL
GO

-- ==============================





-- //////////////////////////////////////////////////////////////
-- // PASO 3 > CARGA INICIAL [ACCESO/UNO#PROD]
-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================


EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0,2005,0, 2005, 1101, 13, 1		-- UNIGAS MATRIZ
EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0,2005,0, 2005, 1102, 13, 1		-- UNIGAS MATRIZ
EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0,2005,0, 2005, 1103, 13, 1		-- UNIGAS MATRIZ
GO

EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0,2005,0, 2005, 1102, 14, 1		-- 
EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0,2005,0, 2005, 1103, 14, 1		-- 
GO

EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0,2005,0, 2005, 1103, 15, 1		-- 
GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- /////////////////////////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////////////////////////
