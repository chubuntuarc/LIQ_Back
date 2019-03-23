-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_01.b_CI_FICHA_AUTOTANQUE
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CARGA INICIAL - FICHA_AUTOTANQUE
-- // OPERACION:		LIBERACION
-- //////////////////////////////////////////////////////////////

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
--

DELETE
FROM [dbo].[FICHA_AUTOTANQUE]
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_FICHA_AUTOTANQUE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_FICHA_AUTOTANQUE]
GO


CREATE PROCEDURE [dbo].[PG_CI_FICHA_AUTOTANQUE]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ===========================
	@PP_K_FICHA_AUTOTANQUE			INT,
	@PP_K_PUNTO_VENTA				INT,
	-- ===========================
	@PP_K_MARCA						INT,
	-- ===========================
	@PP_LECTURA_INICIAL				INT,
	@PP_LECTURA_FINAL				INT,
	@PP_MATRICULA					VARCHAR(100),
	@PP_MODELO						VARCHAR(100),
	@PP_KILOMETRAJE					DECIMAL(19,4),
	@PP_SERIE						VARCHAR(100),
	@PP_CAPACIDAD					INT,
	@PP_PORCENTAJE					VARCHAR(100)
	-- ===========================
AS
	-- K_USUARIO // 0	SYS/SETUP
	DECLARE @VP_K_USUARIO_ACCION	INT = 0
	DECLARE @VP_O_FICHA_AUTOTANQUE	INT = 0

	-- ===========================

	INSERT INTO FICHA_AUTOTANQUE
			(	[K_FICHA_AUTOTANQUE],
				[K_PUNTO_VENTA],
				-- ===========================
				[K_MARCA],
				-- ===========================
				[LECTURA_INICIAL], [LECTURA_FINAL],
				[MATRICULA], [MODELO],
				[KILOMETRAJE], [SERIE],
				[CAPACIDAD], [PORCENTAJE],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES
			(	@PP_K_FICHA_AUTOTANQUE,
				@PP_K_PUNTO_VENTA,
				-- ===========================
				@PP_K_MARCA,
				-- ===========================
				@PP_LECTURA_FINAL, @PP_LECTURA_FINAL,
				@PP_MATRICULA, @PP_MODELO,
				@PP_KILOMETRAJE, @PP_SERIE,
				@PP_CAPACIDAD, @PP_PORCENTAJE,
				-- ===========================
				@VP_K_USUARIO_ACCION, GETDATE(), @VP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

	-- //////////////////////////////////////////////////////////////
GO




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_FICHA_AUTOTANQUE] 0,0, 1, 1,301, 0,914890,'ABC123','N/D',0,'N/D',0,'0'; 
EXECUTE [dbo].[PG_CI_FICHA_AUTOTANQUE] 0,0, 2, 11,302, 0,252087,'DX06774','N/D',0,'3GCM7HIMXVM501317',12500,'26'; 
EXECUTE [dbo].[PG_CI_FICHA_AUTOTANQUE] 0,0, 3, 21,303, 0,28466678,'N/D','1997',1978555,'1GBL7H1PXRJ1078',12500,'0'; 
EXECUTE [dbo].[PG_CI_FICHA_AUTOTANQUE] 0,0, 4, 31,301, 0,1899661,'N/D','N/D',0,'N/D',0,'0'; 
EXECUTE [dbo].[PG_CI_FICHA_AUTOTANQUE] 0,0, 5, 41,302, 0,0,'N/D','2010',31741,'0144S02470505EAB',0,'0'; 




GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



