-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_04.b_CI_Producto
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CARGA INICIAL - PRODUCTO
-- // OPERACION:		LIBERACION 
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
--	

DELETE  
FROM [dbo].[PRODUCTO]
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_PRODUCTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_PRODUCTO]
GO


CREATE PROCEDURE [dbo].[PG_CI_PRODUCTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ===========================
	@PP_K_PRODUCTO				INT,
	@PP_D_PRODUCTO				VARCHAR(100),
	@PP_S_PRODUCTO				VARCHAR(10),
	@PP_O_PRODUCTO				INT,
	@PP_K_ESTATUS_PRODUCTO		INT,
	@PP_K_TIPO_PRODUCTO			INT,
	@PP_K_UNIDAD				INT,
	@PP_CANTIDAD				DECIMAL(19,4),
	@PP_FACTOR_KILOS			DECIMAL(19,4),
	@PP_FACTOR_LITROS			DECIMAL(19,4),
	@PP_CANTIDAD_KILOS			DECIMAL(19,4),
	@PP_CANTIDAD_LITROS			DECIMAL(19,4)
	
	-- ===========================
AS			
	-- K_USUARIO // 0	SYS/SETUP
	DECLARE @VP_K_USUARIO_ACCION		INT = 0 
	DECLARE @VP_O_PRODUCTO				INT = 0

	-- ===========================

	INSERT INTO PRODUCTO
			(	[K_PRODUCTO],
				[D_PRODUCTO], [S_PRODUCTO], [O_PRODUCTO],
				-- ===========================
				[K_ESTATUS_PRODUCTO],
				[K_TIPO_PRODUCTO],
				[K_UNIDAD],
				-- ===========================
				[CANTIDAD],
				[FACTOR_KILOS], [FACTOR_LITROS],
				[CANTIDAD_KILOS], [CANTIDAD_LITROS],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES	
			(	@PP_K_PRODUCTO,
				@PP_D_PRODUCTO, @PP_S_PRODUCTO, @VP_O_PRODUCTO,
				-- ===========================
				@PP_K_ESTATUS_PRODUCTO,
				@PP_K_TIPO_PRODUCTO,
				@PP_K_UNIDAD,
				-- ===========================
				@PP_CANTIDAD,
				@PP_FACTOR_KILOS, @PP_FACTOR_LITROS,
				@PP_CANTIDAD_KILOS, @PP_CANTIDAD_LITROS,
				-- ===========================
				@VP_K_USUARIO_ACCION, GETDATE(), @VP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )
		
	-- //////////////////////////////////////////////////////////////
GO




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_PRODUCTO] 0,0, 1, 'GAS LP (LT)', 'LP.LT', 1, 0, 1, 2, 1, 0.54, 1, 0.54, 1; 
EXECUTE [dbo].[PG_CI_PRODUCTO] 0,0, 2, 'GASOLINA', 'GASO', 2, 1, 3, 2, 1, 0.54, 1, 0.54, 1; 
EXECUTE [dbo].[PG_CI_PRODUCTO] 0,0, 3, 'ESTACIONARIO', 'EST', 3, 1, 2, 2, 1, 0.54, 1, 0.54, 1; 
EXECUTE [dbo].[PG_CI_PRODUCTO] 0,0, 4, 'TANQUE 20KG', 'TAN20', 4, 0, 3, 1, 20, 1, 1.85185185185185, 20, 37.037037037037; 
EXECUTE [dbo].[PG_CI_PRODUCTO] 0,0, 5, 'TANQUE 30KG', 'TAN30', 5, 1, 3, 1, 30, 1, 1.85185185185185, 30, 55.5555555555556; 
EXECUTE [dbo].[PG_CI_PRODUCTO] 0,0, 6, 'TANQUE 50KG', 'TAN50', 6, 1, 3, 1, 50, 1, 1.85185185185185, 50, 92.5925925925926; 
EXECUTE [dbo].[PG_CI_PRODUCTO] 0,0, 8, 'MEDIDOR DE GAS', 'MEDGAS', 2, 1, 3, 3, 1, 1, 1, 1, 1; 
EXECUTE [dbo].[PG_CI_PRODUCTO] 0,0, 9, 'RECONEXION DE LINEA', 'RECLIN', 3, 1, 2, 4, 1, 1, 1, 1, 1; 
EXECUTE [dbo].[PG_CI_PRODUCTO] 0,0, 11, 'MANTENIMIENTO', 'MANTTO', 5, 1, 3, 4, 1, 1, 1, 1, 1; 
EXECUTE [dbo].[PG_CI_PRODUCTO] 0,0, 12, 'POR SERVICIO', 'PORSERV', 6, 1, 3, 4, 1, 1, 1, 1, 1; 


GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



