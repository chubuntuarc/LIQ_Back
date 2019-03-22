-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_01.b_CI_RUTA
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CARGA INICIAL - RUTA
-- // OPERACION:		LIBERACION
-- //////////////////////////////////////////////////////////////

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
--

DELETE
FROM [dbo].[RUTA]
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_RUTA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_RUTA]
GO


CREATE PROCEDURE [dbo].[PG_CI_RUTA]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ===========================
	@PP_K_RUTA						INT,
	@PP_D_RUTA						VARCHAR(100),
	@PP_S_RUTA						VARCHAR(10),
	@PP_O_RUTA						INT,
	@PP_C_RUTA						VARCHAR(255),
	@PP_L_RUTA						INT,
	-- ===========================
	@PP_K_UNIDAD_OPERATIVA			INT
	-- ===========================
AS
	-- K_USUARIO // 0	SYS/SETUP
	DECLARE @VP_K_USUARIO_ACCION	INT = 0
	DECLARE @VP_O_RUTA				INT = 0

	-- ===========================

	INSERT INTO RUTA
			(	[K_RUTA],
				[D_RUTA],	[S_RUTA], [O_RUTA],
				[C_RUTA],	[L_RUTA],
				-- ===========================
				[K_UNIDAD_OPERATIVA],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES
			(	@PP_K_RUTA,
				@PP_D_RUTA,	@PP_S_RUTA,	@PP_O_RUTA,
				@PP_C_RUTA,	@PP_L_RUTA,
				-- ===========================
				@PP_K_UNIDAD_OPERATIVA, 
				-- ===========================
				@VP_K_USUARIO_ACCION, GETDATE(), @VP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

	-- //////////////////////////////////////////////////////////////
GO




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_RUTA] 0,0, 1, 'RUTA UNO', 'UNO',0,'',0,2; 
EXECUTE [dbo].[PG_CI_RUTA] 0,0, 2, 'RUTA DOS', 'DOS',1,'',0,4; 
EXECUTE [dbo].[PG_CI_RUTA] 0,0, 3, 'RUTA TRES', 'TRES',2,'',0,6; 
EXECUTE [dbo].[PG_CI_RUTA] 0,0, 4, 'RUTA CUATRO', 'CUATRO',3,'',1,8; 
EXECUTE [dbo].[PG_CI_RUTA] 0,0, 5, 'RUA CINCO', 'CINCO',4,'',1,10; 


GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



