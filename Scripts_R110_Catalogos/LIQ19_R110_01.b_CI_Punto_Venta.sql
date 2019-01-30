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
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ===========================
	@PP_K_PUNTO_VENTA				INT,
	@PP_D_PUNTO_VENTA				VARCHAR(100),
	@PP_S_PUNTO_VENTA				VARCHAR(10),
	@PP_C_PUNTO_VENTA				VARCHAR(255),
	@PP_O_PUNTO_VENTA				INT,
	@PP_K_ESTATUS_PUNTO_VENTA		INT,
	@PP_K_TIPO_PUNTO_VENTA			INT,
	@PP_SUCURSAL					VARCHAR(100),
	@PP_PLACA						VARCHAR(100),
	@PP_DIRECCION					VARCHAR(100)
	
	-- ===========================
AS			
	-- K_USUARIO // 0	SYS/SETUP
	DECLARE @VP_K_USUARIO_ACCION		INT = 0 
	DECLARE @VP_O_PUNTO_VENTA			INT = 0

	-- ===========================

	INSERT INTO PUNTO_VENTA
			(	[K_PUNTO_VENTA],
				[D_PUNTO_VENTA], [S_PUNTO_VENTA], [O_PUNTO_VENTA],
				-- ===========================
				[K_ESTATUS_PUNTO_VENTA],
				[K_TIPO_PUNTO_VENTA],
				-- ===========================
				[SUCURSAL],
				[PLACA], [DIRECCION],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES	
			(	@PP_K_PUNTO_VENTA,
				@PP_D_PUNTO_VENTA, @PP_S_PUNTO_VENTA, @VP_O_PUNTO_VENTA,
				-- ===========================
				@PP_K_ESTATUS_PUNTO_VENTA,
				@PP_K_TIPO_PUNTO_VENTA,
				-- ===========================
				@PP_SUCURSAL,
				@PP_PLACA, @PP_DIRECCION,
				-- ===========================
				@VP_K_USUARIO_ACCION, GETDATE(), @VP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )
		
	-- //////////////////////////////////////////////////////////////
GO




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 1, 'BE201', 'BE2','', 1, 0, 1, 'BIOGAS', 'ABC123', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 2, 'C133', 'C13','', 2, 1, 3, 'BIOGAS', 'BCD456', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 3, 'BG29', 'BG2','', 3, 1, 2, 'MARKETING', 'N/A', 'Av. Independencia'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 4, 'BE03', 'BE0','', 4, 0, 3, 'BIOGAS', 'EDF678', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 5, 'BE04', 'BE0','', 5, 1, 3, 'BIOGAS', 'ABC123', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 6, 'BG03', 'BG0','', 6, 1, 3, 'BIOGAS', 'BCD456', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 8, 'BE01', 'BE0','', 7, 1, 3, 'BIOGAS', 'DRE345', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 9, 'BE02', 'BE0','', 8, 1, 2, 'BIOGAS', 'N/A', 'Oscar Flores'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 11, 'BE05', 'BE0','', 9, 1, 3, 'BIOGAS', 'ABC123', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 12, 'BG02', 'BG0','', 10, 1, 3, 'BIOGAS', 'BCD456', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 13, 'BG05', 'BG0','', 11, 0, 1, 'BIOGAS', 'DRE345', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 14, 'BG06', 'BG0','', 12, 1, 3, 'BIOGAS', 'EDF678', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 15, 'BG08', 'BG0','', 13, 1, 2, 'BIOGAS', 'N/A', 'Ejercito Nacional'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 16, 'BG09', 'BG0','', 14, 0, 3, 'BIOGAS', 'BCD456', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 17, 'BG10', 'BG1','', 15, 1, 3, 'BIOGAS', 'DRE345', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 18, 'BG11', 'BG1','', 16, 1, 3, 'BIOGAS', 'EDF678', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 19, 'BG18', 'BG1','', 17, 1, 3, 'BIOGAS', 'ABC123', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 20, 'BG12', 'BG1','', 18, 1, 2, 'BIOGAS', 'N/A', 'Paraje San Isidro'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 21, 'BG19', 'BG1','', 19, 1, 3, 'BIOGAS', 'DRE345', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 22, 'BG20', 'BG2','', 20, 1, 3, 'BIOGAS', 'EDF678', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 23, 'BG21', 'BG2','', 21, 0, 1, 'BIOGAS', 'ABC123', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 24, 'BG22', 'BG2','', 22, 1, 3, 'BIOGAS', 'BCD456', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 25, 'BG27', 'BG2','', 23, 1, 2, 'BIOGAS', 'N/A', 'Zaragoza'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 26, 'BG28', 'BG2','', 24, 0, 3, 'BIOGAS', 'EDF678', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 27, 'BG30', 'BG3','', 25, 1, 3, 'BIOGAS', 'ABC123', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 28, 'BG31', 'BG3','', 26, 1, 3, 'BIOGAS', 'BCD456', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 29, 'C135', 'C13','', 27, 1, 3, 'BIOGAS', 'DRE345', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 30, 'U55 EXP', 'U55','', 28, 1, 2, 'BIOGAS', 'N/A', 'Av. Talamas camanadari'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 31, 'C121', 'C12','', 29, 1, 3, 'BIOGAS', 'ABC123', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 32, 'C132', 'C13','', 30, 1, 3, 'BIOGAS', 'BCD456', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 33, 'C134', 'C13','', 31, 0, 1, 'BIOGAS', 'DRE345', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 34, 'C122', 'C12','', 32, 1, 3, 'BIOGAS', 'EDF678', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 35, 'C123', 'C12','', 33, 1, 2, 'BIOGAS', 'N/A', 'Yepomera'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 36, 'C124', 'C12','', 34, 0, 3, 'BIOGAS', 'BCD456', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 37, 'C125', 'C12','', 35, 1, 3, 'BIOGAS', 'DRE345', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 38, 'C126', 'C12','', 36, 1, 3, 'BIOGAS', 'EDF678', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 39, 'C127', 'C12','', 37, 1, 3, 'BIOGAS', 'ABC123', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 40, 'C128', 'C12','', 38, 1, 2, 'BIOGAS', 'N/A', 'Henequen'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 41, 'C129', 'C12','', 39, 1, 3, 'BIOGAS', 'DRE345', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 42, 'C130', 'C13','', 40, 1, 3, 'BIOGAS', 'EDF678', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 43, 'C131', 'C13','', 41, 0, 1, 'BIOGAS', 'ABC123', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 44, 'C136', 'C13','', 42, 1, 3, 'BIOGAS', 'BCD456', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 45, 'C02', 'C02','', 43, 1, 2, 'BIOGAS', 'N/A', 'Av. Gomez Morin'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 46, 'C43', 'C43','', 44, 0, 3, 'BIOGAS', 'EDF678', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 47, 'C116', 'C11','', 45, 1, 3, 'BIOGAS', 'ABC123', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 48, 'U02', 'U02','', 46, 1, 3, 'BIOGAS', 'BCD456', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 49, 'U46', 'U46','', 47, 1, 3, 'BIOGAS', 'DRE345', 'N/A'; 
EXECUTE [dbo].[PG_CI_PUNTO_VENTA] 0,0, 50, 'U53', 'U53','', 48, 1, 2, 'BIOGAS', 'N/A', 'Panamericana'; 





GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



