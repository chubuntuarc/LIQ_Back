-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_03.b_CI_OPERADOR
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CARGA INICIAL - OPERADOR
-- // OPERACION:		LIBERACION
-- //////////////////////////////////////////////////////////////

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////


-- //////////////////////////////////////////////////////////////
--

DELETE
FROM [dbo].[OPERADOR]
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_OPERADOR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_OPERADOR]
GO


CREATE PROCEDURE [dbo].[PG_CI_OPERADOR]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ===========================
	@PP_K_OPERADOR					INT,
	@PP_D_OPERADOR					VARCHAR(100),
	@PP_S_OPERADOR					VARCHAR(10),
	@PP_O_OPERADOR					INT,
	@PP_C_OPERADOR					VARCHAR(255),
	@PP_L_OPERADOR					INT,
	-- ===========================
	@PP_K_UNIDAD_OPERATIVA			INT,
	-- ===========================
	@PP_NOMBRE						VARCHAR(100),
	@PP_APATERNO					VARCHAR(100),
	@PP_AMATERNO					VARCHAR(100),
	@PP_LICENCIA					VARCHAR(100),
	@PP_DOMICILIO_COLONIA			VARCHAR(100),
	@PP_DOMICILIO_CALLE				VARCHAR(100),
	@PP_DOMICILIO_NUMERO			VARCHAR(100)
	-- ===========================
AS
	-- K_USUARIO // 0	SYS/SETUP
	DECLARE @VP_K_USUARIO_ACCION	INT = 0
	DECLARE @VP_O_OPERADOR			INT = 0

	-- ===========================

	INSERT INTO OPERADOR
			(	[K_OPERADOR],
				[D_OPERADOR],	[S_OPERADOR], [O_OPERADOR],
				[C_OPERADOR],	[L_OPERADOR],
				-- ===========================
				[K_UNIDAD_OPERATIVA],
				-- ===========================
				[NOMBRE], [APATERNO], [AMATERNO],
				[LICENCIA],
				[DOMICILIO_COLONIA], [DOMICILIO_CALLE], [DOMICILIO_NUMERO],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES
			(	@PP_K_OPERADOR,
				@PP_D_OPERADOR,	@PP_S_OPERADOR,	@PP_O_OPERADOR,
				@PP_C_OPERADOR,	@PP_L_OPERADOR,
				-- ===========================
				@PP_K_UNIDAD_OPERATIVA, 
				-- ===========================
				@PP_NOMBRE, @PP_AMATERNO, @PP_APATERNO, 
				@PP_LICENCIA, 
				@PP_DOMICILIO_COLONIA, @PP_DOMICILIO_CALLE, @PP_DOMICILIO_NUMERO,
				-- ===========================
				@VP_K_USUARIO_ACCION, GETDATE(), @VP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

	-- //////////////////////////////////////////////////////////////
GO




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_OPERADOR] 0,0, 1, 'OPERADOR UNO', 'UNO',0,'',1,2, 'JESUS', 'ARCINIEGA', 'REYNOSO', 'ABH2235', 'Torres', 'Calle muestra','100'; 
EXECUTE [dbo].[PG_CI_OPERADOR] 0,0, 2, 'OPERADOR DOS', 'DOS',1,'',1,4, 'ALEJANDRO', 'DE LA ROSA', 'MARTTINEZ', 'ABG5864', 'Aeropuerto', 'Calle muestra 2','200'; 
EXECUTE [dbo].[PG_CI_OPERADOR] 0,0, 3, 'AYUDANTE UNO', 'TRES',2,'',1,6, 'SERGIO', 'SEGOVIA', 'GARCIA', 'BGH7896', 'Panamericana', 'Calle muestra 3','300'; 
EXECUTE [dbo].[PG_CI_OPERADOR] 0,0, 4, 'AYUDANTE DOS', 'CUATRO',3,'',1,8, 'FRANCISCO', 'ESTEBAN', 'GONZALEZ', 'AHE5687', 'Torres', 'Calle muestra 4','400'; 
EXECUTE [dbo].[PG_CI_OPERADOR] 0,0, 5, 'AYUDANTE TRES', 'CINCO',4,'',1,10, 'ANTONIO', 'ARCINIEGA', 'REYNOSO', 'CDE1234', 'Aeropuerto', 'Calle muestra 5','500'; 

GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



