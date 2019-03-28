-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	SYS19_BasicBD_20190319
-- // MODULO:			USUARIO_X_UNO 
-- // OPERACION:		LIBERACION / TABLAS 
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		FRANCISCO ESTEBAN
-- // FECHA:		21/FEB/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////

   
   
-- //////////////////////////////////////////////////////////////
--	SELECT *	FROM [dbo].[SYS3_ACCESO_USR_X_UNO]


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS3_ACCESO_USR_X_UNO]') AND type in (N'U'))
	DELETE	FROM [dbo].[SYS3_ACCESO_USR_X_UNO]
GO





-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



-- ===============================================
SET NOCOUNT ON
-- ===============================================
-- SELECT * FROM [SYS3_ACCESO_USR_X_UNO]



EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0, 2006, 0, 99, 13, 1		-- UNIGAS MATRIZ
EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0, 2006, 0, 99, 21, 1		-- GASOMATICO
EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0, 2006, 0, 99, 18, 1		-- GAS CHAPULTEPEC


EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0, 2006, 0, 169, 13, 1		-- UNIGAS MATRIZ
EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0, 2006, 0, 169, 21, 1		-- GASOMATICO
EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0, 2006, 0, 169, 18, 1		-- GAS CHAPULTEPEC
EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0, 2006, 0, 169, 14, 1		-- UNIGAS MATRIZ
EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0, 2006, 0, 169, 15, 1		-- GASOMATICO
EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0, 2006, 0, 169, 16, 1		-- GAS CHAPULTEPEC

EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0, 2006, 0, 169, 34, 1		-- UNIGAS MATRIZ
EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0, 2006, 0, 169, 35, 1		-- GASOMATICO
EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0, 2006, 0, 169, 36, 1		-- GAS CHAPULTEPEC
EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0, 2006, 0, 169, 37, 1		-- UNIGAS MATRIZ
EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0, 2006, 0, 169, 38, 1		-- GASOMATICO
EXECUTE [dbo].[PG_CI_SYS3_ACCESO_USR_X_UNO] 0, 2006, 0, 169, 39, 1		-- GAS CHAPULTEPEC


-- ===============================================
SET NOCOUNT OFF
-- ===============================================



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
