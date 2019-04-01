-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_01.b_CI_RUTA_REPARTO
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CARGA INICIAL - RUTA_REPARTO
-- // OPERACION:		LIBERACION
-- //////////////////////////////////////////////////////////////

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
--

DELETE
FROM [dbo].[RUTA_REPARTO]
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_RUTA_REPARTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_RUTA_REPARTO]
GO


CREATE PROCEDURE [dbo].[PG_CI_RUTA_REPARTO]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ===========================
	@PP_K_RUTA_REPARTO				INT,
	@PP_D_RUTA_REPARTO				VARCHAR(255),
	@PP_C_RUTA_REPARTO				VARCHAR(500),
	@PP_S_RUTA_REPARTO				VARCHAR(10),
	-- ===========================
	@PP_K_UNIDAD_OPERATIVA			INT,
	-- ===========================
	@PP_K_ESTATUS_RUTA_REPARTO		INT,
	@PP_K_TIPO_RUTA_REPARTO			INT
	-- ===========================
AS
	-- K_USUARIO // 0	SYS/SETUP
	DECLARE @VP_K_USUARIO_ACCION	INT = 0
	DECLARE @VP_O_RUTA_REPARTO		INT = 0

	-- ===========================

	INSERT INTO RUTA_REPARTO
			(	[K_RUTA_REPARTO],[D_RUTA_REPARTO],
				[C_RUTA_REPARTO], [S_RUTA_REPARTO],
				-- ===========================
				[K_UNIDAD_OPERATIVA],
				-- ===========================
				[K_ESTATUS_RUTA_REPARTO], [K_TIPO_RUTA_REPARTO],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES
			(	@PP_K_RUTA_REPARTO, @PP_D_RUTA_REPARTO,
				@PP_C_RUTA_REPARTO, @PP_S_RUTA_REPARTO,
				-- ===========================
				@PP_K_UNIDAD_OPERATIVA,
				-- ===========================
				@PP_K_ESTATUS_RUTA_REPARTO, @PP_K_TIPO_RUTA_REPARTO,
				-- ===========================
				@VP_K_USUARIO_ACCION, GETDATE(), @VP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

	-- //////////////////////////////////////////////////////////////
GO




-- ===============================================
SET NOCOUNT ON
-- ===============================================
 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 1,'Ruta 1','','R01',3,1,1; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 2,'Ruta 2','','R02',3,1,2; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 3,'Ruta 3','','R03',3,1,3; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 4,'Ruta 4','','R04',3,1,1; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 5,'Ruta 5','','R05',3,1,2; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 6,'Ruta 6','','R06',3,1,3; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 7,'Ruta 7','','R07',3,1,1; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 8,'Ruta 8','','R08',3,1,2; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 9,'Ruta 9','','R09',3,1,3; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 10,'Ruta 10','','R10',3,1,1; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 11,'Ruta 11','','R11',3,1,2; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 12,'Ruta 12','','R12',3,1,3; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 13,'Ruta 13','','R13',3,1,1; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 14,'Ruta 14','','R14',3,1,2; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 15,'Ruta 15','','R15',3,1,3; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 16,'Ruta 16','','R16',3,1,1; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 17,'Ruta 17','','R17',3,1,2; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 18,'Ruta 18','','R18',3,1,3; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 19,'Ruta 19','','R19',3,1,1; 
EXECUTE [dbo].[PG_CI_RUTA_REPARTO] 0,0, 20,'Ruta 20','','R20',3,1,2; 


GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



