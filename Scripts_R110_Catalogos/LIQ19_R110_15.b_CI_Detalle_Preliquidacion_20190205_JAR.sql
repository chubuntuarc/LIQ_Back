-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_15.b_CI_DETALLE_PRELIQUIDACION
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CARGA INICIAL - DETALLE_PRELIQUIDACION
-- // OPERACION:		LIBERACION
-- //////////////////////////////////////////////////////////////

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
--

DELETE
FROM [dbo].[DETALLE_PRELIQUIDACION]
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_DETALLE_PRELIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_DETALLE_PRELIQUIDACION]
GO


CREATE PROCEDURE [dbo].[PG_CI_DETALLE_PRELIQUIDACION]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ===========================
	@PP_K_DETALLE_PRELIQUIDACION	INT,
	-- ===========================
	@PP_K_PRELIQUIDACION			INT,
	@PP_K_PRODUCTO					INT,
	-- ===========================
	@PP_LECTURA_INICIAL				DECIMAL(19,4),
	@PP_LECTURA_FINAL				DECIMAL(19,4),
	@PP_PESO_INICIAL				DECIMAL(19,4),
	@PP_PESO_FINAL					DECIMAL(19,4),
	@PP_NIVEL_INICIAL				INT,
	@PP_NIVEL_FINAL					INT,
	@PP_CARBURACION_INICIAL			DECIMAL(19,4),
	@PP_CARBURACION_FINAL			DECIMAL(19,4),
	@PP_TANQUE_INICIAL				INT,
	@PP_TANQUE_FINAL				INT
AS
	-- K_USUARIO // 0	SYS/SETUP
	DECLARE @VP_K_USUARIO_ACCION	INT = 0
	DECLARE @VP_O_DETALLE_PRELIQUIDACION	INT = 0

	-- ===========================

	INSERT INTO DETALLE_PRELIQUIDACION
			(	[K_DETALLE_PRELIQUIDACION],
				-- ===========================
				[K_PRELIQUIDACION], [K_PRODUCTO],
				-- ===========================
				[LECTURA_INICIAL], [LECTURA_FINAL],
				[PESO_INICIAL], [PESO_FINAL],
				[NIVEL_INICIAL], [NIVEL_FINAL],
				[CARBURACION_INICIAL], [CARBURACION_FINAL],
				[TANQUE_INICIAL], [TANQUE_FINAL],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES
			(	@PP_K_DETALLE_PRELIQUIDACION,
				-- ===========================
				@PP_K_PRELIQUIDACION, @PP_K_PRODUCTO,
				-- ===========================
				@PP_LECTURA_INICIAL, @PP_LECTURA_FINAL,
				@PP_PESO_INICIAL, @PP_PESO_FINAL,
				@PP_NIVEL_INICIAL, @PP_NIVEL_FINAL,
				@PP_CARBURACION_INICIAL, @PP_CARBURACION_FINAL,
				@PP_TANQUE_INICIAL, @PP_TANQUE_FINAL,
				-- ===========================
				@VP_K_USUARIO_ACCION, GETDATE(), @VP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

	-- //////////////////////////////////////////////////////////////
GO



-- ===============================================
SET NOCOUNT ON
-- ===============================================


EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 1,1,1,1000,2000, 1000,500,90,45,90,45,0,0; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 2,4,4,0,0, 1000,500,90,45,0,0,10,5; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 3,4,5,0,0, 1000,500,90,45,0,0,6,4; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 4,4,6,0,0, 1000,500,90,45,0,0,8,0; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 5,7,4,0,0, 1000,500,90,45,0,0,11,6; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 6,7,5,0,0, 1000,500,90,45,0,0,12,8; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 7,7,6,0,0, 1000,500,90,45,0,0,8,4; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 8,10,4,0,0, 1000,500,90,45,0,0,10,5; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 9,10,5,0,0, 1000,500,90,45,0,0,10,5; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 10,12,4,0,0, 1000,500,90,45,0,0,10,5; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 11,12,5,0,0, 1000,500,90,45,0,0,6,4; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 12,12,6,0,0, 1000,500,90,45,0,0,8,0; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 13,17,4,0,0, 1000,500,90,45,0,0,11,6; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 14,17,5,0,0, 1000,500,90,45,0,0,12,8; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 15,17,6,0,0, 1000,500,90,45,0,0,8,4; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 16,21,1,2000,3000, 1000,750,90,60,90,60,0,0; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 17,24,4,0,0, 1000,500,90,45,0,0,10,5; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 18,24,5,0,0, 1000,500,90,45,0,0,6,4; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 19,24,6,0,0, 1000,500,90,45,0,0,8,0; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 20,26,1,1000,2000, 1000,500,90,45,90,45,0,0; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 21,28,4,0,0, 1000,500,90,45,0,0,10,5; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 22,28,5,0,0, 1000,500,90,45,0,0,10,5; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 23,31,6,0,0, 1000,500,90,45,0,0,10,5; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 24,33,4,0,0, 1000,500,90,45,0,0,10,5; 
EXECUTE [dbo].[PG_CI_DETALLE_PRELIQUIDACION] 0,0, 25,33,5,0,0, 1000,500,90,45,0,0,10,5; 



GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



