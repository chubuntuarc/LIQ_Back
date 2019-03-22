-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_01.b_CI_Punto_Venta
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CARGA INICIAL - PUNTO_VENTA
-- // OPERACION:		LIBERACION 
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
--	

DELETE  
FROM [dbo].[PUNTO_VENTA]
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_PUNTO_VENTA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_PUNTO_VENTA]
GO


CREATE PROCEDURE [dbo].[PG_CI_PUNTO_VENTA]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ===========================
	@PP_K_PUNTO_VENTA				INT,
	@PP_D_PUNTO_VENTA				VARCHAR(100),
	-- ===========================
	@PP_K_ESTATUS_PUNTO_VENTA		INT,
	@PP_K_TIPO_PUNTO_VENTA			INT,
	@PP_K_UNIDAD_OPERATIVA			INT,
	-- ===========================
	@PP_K_OPERADOR					INT,
	@PP_K_AYUDANTE_1				INT,
	@PP_K_AYUDANTE_2				INT
	-- ===========================
AS			
	-- K_USUARIO // 0	SYS/SETUP
	DECLARE @VP_K_USUARIO_ACCION		INT = 0 
	DECLARE @VP_O_PUNTO_VENTA			INT = 0

	-- ===========================

	INSERT INTO PUNTO_VENTA
			(	[K_PUNTO_VENTA], [D_PUNTO_VENTA],
				-- ===========================
				[K_ESTATUS_PUNTO_VENTA], [K_TIPO_PUNTO_VENTA], [K_UNIDAD_OPERATIVA],
				-- ===========================
				[K_OPERADOR], [K_AYUDANTE_1], [K_AYUDANTE_2],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES	
			(	@PP_K_PUNTO_VENTA, @PP_D_PUNTO_VENTA,
				-- ===========================
				@PP_K_ESTATUS_PUNTO_VENTA, @PP_K_TIPO_PUNTO_VENTA, @PP_K_UNIDAD_OPERATIVA,
				-- ===========================
				@PP_K_OPERADOR, @PP_K_AYUDANTE_1, @PP_K_AYUDANTE_2,
				-- ===========================
				@VP_K_USUARIO_ACCION, GETDATE(), @VP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )
		
	-- //////////////////////////////////////////////////////////////
GO




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 1, 'BE201', 0, 1, 1, 333, 382, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 2, 'C133', 1, 3, 1, 334, 383, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 3, 'BG29', 1, 2, 2, 335, 384, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 4, 'BE03', 0, 3, 1, 336, 385, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 5, 'BE04', 1, 3, 1, 337, 386, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 6, 'BG03', 1, 3, 1, 338, 387, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 8, 'BE01', 1, 2, 1, 339, 388, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 9, 'BE02', 1, 3, 1, 340, 389, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 11, 'BE05', 1, 1, 1, 341, 390, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 12, 'BG02', 1, 3, 1, 342, 391, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 13, 'BG05', 0, 2, 1, 343, 392, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 14, 'BG06', 1, 3, 1, 344, 393, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 15, 'BG08', 1, 3, 1, 345, 394, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 16, 'BG09', 0, 3, 1, 346, 395, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 17, 'BG10', 1, 3, 2, 347, 396, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 18, 'BG11', 1, 2, 3, 348, 397, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 19, 'BG18', 1, 3, 2, 349, 398, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 20, 'BG12', 1, 3, 1, 350, 400, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 21, 'BG19', 1, 1, 1, 351, 401, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 22, 'BG20', 1, 3, 1, 352, 402, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 23, 'BG21', 0, 2, 1, 353, 403, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 24, 'BG22', 1, 3, 1, 354, 404, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 25, 'BG27', 1, 3, 1, 355, 405, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 26, 'BG28', 0, 3, 1, 356, 406, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 27, 'BG30', 1, 3, 1, 357, 407, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 28, 'BG31', 1, 2, 1, 358, 408, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 29, 'C135', 1, 3, 1, 359, 409, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 30, 'U55 EXP', 1, 3, 1, 361, 410, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 31, 'C121', 1, 1, 1, 362, 411, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 32, 'C132', 1, 3, 1, 363, 412, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 33, 'C134', 0, 3, 1, 364, 413, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 34, 'C122', 1, 2, 2, 365, 414, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 35, 'C123', 1, 3, 2, 366, 415, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 36, 'C124', 0, 3, 2, 367, 416, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 37, 'C125', 1, 3, 2, 368, 419, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 38, 'C126', 1, 2, 2, 369, 421, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 39, 'C127', 1, 3, 2, 370, 422, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 40, 'C128', 1, 3, 1, 371, 423, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 41, 'C129', 1, 1, 1, 372, 425, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 42, 'C130', 1, 3, 1, 373, 426, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 43, 'C131', 0, 2, 1, 374, 428, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 44, 'C136', 1, 3, 1, 375, 429, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 45, 'C02', 1, 3, 1, 376, 0, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 46, 'C43', 0, 3, 1, 377, 0, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 47, 'C116', 1, 3, 1, 378, 0, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 48, 'U02', 1, 2, 1, 379, 0, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 49, 'U46', 1, 2, 2, 380, 0, 0; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 50, 'U53', 1, 2, 2, 381, 0, 0; 







GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



