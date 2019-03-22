-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	ADG18_AdministradoraGas
-- // MODULO:			
-- // OPERACION:		LIBERACION // STORED PROCEDURE
-- ////////////////////////////////////////////////////////////// 

USE [ADG18_AdministradoraGas_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////

-- SELECT * FROM [SYS_PERFIL_ROL]


-- //////////////////////////////////////////////////////////////
-- // 
-- //////////////////////////////////////////////////////////////







-- //////////////////////////////////////////////////////////////
-- // 
-- //////////////////////////////////////////////////////////////

-- SELECT * FROM [SYS_PERFIL_DEFINICION_ACCION]

-- EXECUTE [PG_LI_PERMISO_FUNCION_X_K_USUARIO] 0,0,0,	'FO_PRODUCTO'

-- EXECUTE [PG_LI_PERMISO_FUNCION_X_K_USUARIO] 0,0,0,	'XFO_PRODUCTO'


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_SYS_PERFIL_DEFINICION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_SYS_PERFIL_DEFINICION]
GO


CREATE PROCEDURE [dbo].[PG_SK_SYS_PERFIL_DEFINICION]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_K_USUARIO_ACCION	INT,
	-- ===========================
	@PP_FO_NOMBRE			VARCHAR(255)
	-- ===========================
AS

	SELECT	SYS_PERFIL_DEFINICION.*,
			D_SYS_PERFIL_ROL
	FROM	SYS_PERFIL_DEFINICION, SYS_PERFIL_ROL
	WHERE	SYS_PERFIL_DEFINICION.K_SYS_PERFIL_ROL=SYS_PERFIL_ROL.K_SYS_PERFIL_ROL
	AND		K_SISTEMA=@PP_K_SISTEMA_EXE
	AND		K_USUARIO=@PP_K_USUARIO_ACCION
	AND		FO_NOMBRE=@PP_FO_NOMBRE	

	-- //////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]
GO


CREATE PROCEDURE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_K_USUARIO_ACCION	INT,
	-- ===========================
	@PP_FO_NOMBRE			VARCHAR(255),
	@PP_D_BOTON				VARCHAR(200),
	-- ===========================
	@PP_L_VISIBLE			INT,
	@PP_L_ACTIVO			INT
AS

	UPDATE	SYS_PERFIL_DEFINICION_ACCION
	SET		L_VISIBLE	= @PP_L_VISIBLE,
			L_ACTIVO	= @PP_L_ACTIVO
	WHERE	K_SISTEMA=@PP_K_SISTEMA_EXE
	AND		K_USUARIO=@PP_K_USUARIO_ACCION
	AND		FO_NOMBRE=@PP_FO_NOMBRE	
	AND		D_BOTON=@PP_D_BOTON

	-- ================================================
GO



-- /////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_PERMISO_FUNCION_PERFIL_0_NINGUNO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_0_NINGUNO]
GO


CREATE PROCEDURE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_0_NINGUNO]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_K_USUARIO_ACCION	INT,
	-- ===========================
	@PP_FO_NOMBRE			VARCHAR(255)
AS
	-- =======================================================
	-- K_SYS_PERFIL_ROL = #0 NINGUNO | #1 FULL CONTROL | #2 CORDINACION | #3 OPERACION | #4 CONSULTA
	-- >>>>>> SE QUITAN TODOS LOS BOTONES
	
	DELETE 
	FROM	SYS_PERFIL_DEFINICION_ACCION
	WHERE	K_USUARIO=@PP_K_USUARIO_ACCION
	AND		FO_NOMBRE=@PP_FO_NOMBRE	

	-- =======================================================
GO




-- /////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_PERMISO_FUNCION_PERFIL_1_FULL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_1_FULL]
GO


CREATE PROCEDURE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_1_FULL]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_K_USUARIO_ACCION	INT,
	-- ===========================
	@PP_FO_NOMBRE			VARCHAR(255)
AS
	-- =======================================================
	-- K_SYS_PERFIL_ROL = #0 NINGUNO | #1 FULL CONTROL | #2 CORDINACION | #3 OPERACION | #4 CONSULTA

	-- >>>>>>> NO SE DESACTIVA NADA

	-- =======================================================
GO



-- /////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_PERMISO_FUNCION_PERFIL_2_CORDINACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_2_CORDINACION]
GO


CREATE PROCEDURE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_2_CORDINACION]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_K_USUARIO_ACCION	INT,
	-- ===========================
	@PP_FO_NOMBRE			VARCHAR(255)
AS
	-- =======================================================
	-- K_SYS_PERFIL_ROL = #0 NINGUNO | #1 FULL CONTROL | #2 CORDINACION | #3 OPERACION | #4 CONSULTA

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_EDITAR', 0, 0

	-- =======================================================
GO



-- /////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_PERMISO_FUNCION_PERFIL_3_OPERACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_3_OPERACION]
GO


CREATE PROCEDURE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_3_OPERACION]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_K_USUARIO_ACCION	INT,
	-- ===========================
	@PP_FO_NOMBRE			VARCHAR(255)
AS
	-- =======================================================
	-- K_SYS_PERFIL_ROL = #0 NINGUNO | #1 FULL CONTROL | #2 CORDINACION | #3 OPERACION | #4 CONSULTA

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_ELIMINAR', 0, 0

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_EDITAR', 0, 0

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_CLONAR', 0, 0

	-- =======================================================
GO




-- /////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_PERMISO_FUNCION_PERFIL_6_GRIDEDIT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_6_GRIDEDIT]
GO


CREATE PROCEDURE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_6_GRIDEDIT]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_K_USUARIO_ACCION	INT,
	-- ===========================
	@PP_FO_NOMBRE			VARCHAR(255)
AS
	-- =======================================================
	-- K_SYS_PERFIL_ROL = #0 NINGUNO | #1 FULL CONTROL | #2 CORDINACION | #3 OPERACION | #4 CONSULTA
	
	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_AGREGAR', 0, 0

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_EDITAR', 0, 0

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_CLONAR', 0, 0

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_ELIMINAR', 0, 0

--	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
--																@PP_FO_NOMBRE, 'BT_CANCELAR', 0, 0

--	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
--																@PP_FO_NOMBRE, 'BT_EXPORTAR_EXCEL', 0, 0

--	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
--																@PP_FO_NOMBRE, 'BT_GUARDAR', 0, 0

--	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
--																@PP_FO_NOMBRE, 'BT_LISTADO', 0, 0
	-- =======================================================
GO


-- /////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_PERMISO_FUNCION_PERFIL_5_ESPECIAL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_5_ESPECIAL]
GO


CREATE PROCEDURE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_5_ESPECIAL]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_K_USUARIO_ACCION	INT,
	-- ===========================
	@PP_FO_NOMBRE			VARCHAR(255)
AS
	-- =======================================================
	-- K_SYS_PERFIL_ROL = #0 NINGUNO | #1 FULL CONTROL | #2 CORDINACION | #3 OPERACION | #4 CONSULTA
	
	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_AGREGAR', 0, 0

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_EDITAR', 0, 0

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_CLONAR', 0, 0

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_ELIMINAR', 0, 0

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_CANCELAR', 0, 0

--	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
--																@PP_FO_NOMBRE, 'BT_EXPORTAR_EXCEL', 0, 0

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_GUARDAR', 0, 0

--	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
--																@PP_FO_NOMBRE, 'BT_LISTADO', 0, 0
	-- =======================================================
GO



-- /////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_PERMISO_FUNCION_PERFIL_4_CONSULTA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_4_CONSULTA]
GO


CREATE PROCEDURE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_4_CONSULTA]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_K_USUARIO_ACCION	INT,
	-- ===========================
	@PP_FO_NOMBRE			VARCHAR(255)
AS
	-- =======================================================
	-- K_SYS_PERFIL_ROL = #0 NINGUNO | #1 FULL CONTROL | #2 CORDINACION | #3 OPERACION | #4 CONSULTA
	
	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_AGREGAR', 0, 0

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_EDITAR', 0, 0

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_CLONAR', 0, 0

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_ELIMINAR', 0, 0

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_CANCELAR', 0, 0

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_EXPORTAR_EXCEL', 0, 0

	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_FO_NOMBRE, 'BT_GUARDAR', 0, 0

--	EXECUTE [dbo].[PG_UP_SYS_PERFIL_DEFINICION_ACCION_L_Y_L]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
--																@PP_FO_NOMBRE, 'BT_LISTADO', 0, 0
	-- =======================================================
GO



-- /////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_PERMISO_FUNCION_PERFIL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL]
GO


CREATE PROCEDURE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_K_USUARIO_ACCION	INT,
	-- ===========================
	@PP_FO_NOMBRE			VARCHAR(255),
	@PP_K_SYS_PERFIL_ROL	INT
AS
	-- =======================================================
	-- K_SYS_PERFIL_ROL = #0 NINGUNO | #1 FULL CONTROL | #2 CORDINACION | #3 OPERACION | #4 CONSULTA

	IF @PP_K_SYS_PERFIL_ROL IN (6)
		EXECUTE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_6_GRIDEDIT]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																	@PP_FO_NOMBRE 

	IF @PP_K_SYS_PERFIL_ROL IN (5)
		EXECUTE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_5_ESPECIAL]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																	@PP_FO_NOMBRE 

	IF @PP_K_SYS_PERFIL_ROL IN (4)
		EXECUTE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_4_CONSULTA]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																	@PP_FO_NOMBRE 

	IF @PP_K_SYS_PERFIL_ROL IN (3)
		EXECUTE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_3_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																	@PP_FO_NOMBRE 

	IF @PP_K_SYS_PERFIL_ROL IN (2)
		EXECUTE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_2_CORDINACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																	@PP_FO_NOMBRE 

	IF @PP_K_SYS_PERFIL_ROL IN (1)
		EXECUTE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_1_FULL]			@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																	@PP_FO_NOMBRE 
																	
	IF @PP_K_SYS_PERFIL_ROL IN (0)
		EXECUTE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL_0_NINGUNO]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																	@PP_FO_NOMBRE 

	-- =======================================================
GO



-- //////////////////////////////////////////////////////////////
-- // 
-- //////////////////////////////////////////////////////////////

-- SELECT * FROM [SYS_PERFIL_DEFINICION_ACCION]

-- EXECUTE [PG_LI_PERMISO_FUNCION_X_K_USUARIO] 0,0,0,	'FO_PRODUCTO'

-- EXECUTE [PG_LI_PERMISO_FUNCION_X_K_USUARIO] 0,0,0,	'XFO_PRODUCTO'


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]
GO


CREATE PROCEDURE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_K_USUARIO_ACCION	INT,
	-- ===========================
	@PP_FO_NOMBRE			VARCHAR(255)
	-- ===========================
AS

	DECLARE @VP_FO_NOMBRE			VARCHAR(100)
	DECLARE	@VP_K_SYS_PERFIL_ROL	INT
	DECLARE	@VP_D_SYS_PERFIL_ROL	VARCHAR(100)

	SELECT	@VP_FO_NOMBRE =			FO_NOMBRE,
			@VP_K_SYS_PERFIL_ROL =	SYS_PERFIL_ROL.K_SYS_PERFIL_ROL,
			@VP_D_SYS_PERFIL_ROL =	SYS_PERFIL_ROL.D_SYS_PERFIL_ROL
									FROM	SYS_PERFIL_DEFINICION, SYS_PERFIL_ROL
									WHERE	SYS_PERFIL_DEFINICION.K_SYS_PERFIL_ROL=SYS_PERFIL_ROL.K_SYS_PERFIL_ROL
									AND		K_SISTEMA=@PP_K_SISTEMA_EXE
									AND		K_USUARIO=@PP_K_USUARIO_ACCION
									AND		FO_NOMBRE=@PP_FO_NOMBRE									
	-- =======================

	IF NOT ( @VP_FO_NOMBRE IS NULL )
		BEGIN
		
		DELETE
		FROM	SYS_PERFIL_DEFINICION_ACCION 
		WHERE	K_SISTEMA=@PP_K_SISTEMA_EXE
		AND		K_USUARIO=@PP_K_USUARIO_ACCION
		AND		FO_NOMBRE=@PP_FO_NOMBRE		

		-- ==========================================

		INSERT INTO SYS_PERFIL_DEFINICION_ACCION 
			(	[K_SISTEMA],
				[K_USUARIO], [FO_NOMBRE],
				[L_VISIBLE], [L_ACTIVO], [D_BOTON]	)
		VALUES		
			-- ===========================================
			(	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	@VP_FO_NOMBRE,	1,1,	'BT_AGREGAR'	),
			(	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	@VP_FO_NOMBRE,	1,1,	'BT_EDITAR'		),
			(	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	@VP_FO_NOMBRE,	1,1,	'BT_CLONAR'		),
			(	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	@VP_FO_NOMBRE,	1,1,	'BT_ELIMINAR'	),
			(	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	@VP_FO_NOMBRE,	1,1,	'BT_GUARDAR'	),
			(	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	@VP_FO_NOMBRE,	1,1,	'BT_CANCELAR'	),
			-- ===========================================
			(	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	@VP_FO_NOMBRE,	1,1,	'BT_EXPORTAR_EXCEL'	),
			(	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	@VP_FO_NOMBRE,	1,1,	'BT_LISTADO'		),	
			(	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	@VP_FO_NOMBRE,	1,1,	'BT_LI_BUSCAR'		)

		END

	-- ==========================================

	EXECUTE [dbo].[PG_UP_PERMISO_FUNCION_PERFIL]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_FO_NOMBRE, @VP_K_SYS_PERFIL_ROL
	-- ==========================================

	SELECT	@VP_K_SYS_PERFIL_ROL AS K_SYS_PERFIL_ROL,
			@VP_D_SYS_PERFIL_ROL AS D_SYS_PERFIL_ROL,
			-- =========================
			K_USUARIO		AS K_FUNCION, 
			FO_NOMBRE		AS D_FUNCION, 
			L_VISIBLE		AS L_VISIBLE, 
			L_ACTIVO		AS L_ACTIVO,
			D_BOTON			AS D_PROCESO	
	FROM	SYS_PERFIL_DEFINICION_ACCION 
	WHERE	K_SISTEMA=@PP_K_SISTEMA_EXE
	AND		K_USUARIO=@PP_K_USUARIO_ACCION
	AND		FO_NOMBRE=@PP_FO_NOMBRE	

	-- //////////////////////////////////////////
GO




-- ////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////


-- //////////////////////////////////////////////////////////////
-- // 
-- //////////////////////////////////////////////////////////////

-- SELECT * FROM [SYS_PERFIL_DEFINICION_ACCION]

-- EXECUTE [PG_LI_PERMISO_FUNCION_X_K_USUARIO] 0,0,99,	'FO_PRODUCTO'

-- EXECUTE [PG_LI_PERMISO_FUNCION_X_K_USUARIO] 0,0,0,	'XFO_PRODUCTO'


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO]
GO


CREATE PROCEDURE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_K_USUARIO_ACCION	INT,
	-- ===========================
	@PP_FO_NOMBRE			VARCHAR(255)
	-- ===========================
AS

	EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
															@PP_FO_NOMBRE		
																
	-- ///////////////////////////////////////////////
GO





/*

-- 

EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO] 0,2006,99,	'FO_PRODUCTO'

-- =================================== CATALOGOS
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_PRODUCTO'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_TASA_IMPUESTO'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_PRECIO'
-- =================================== GESTION
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_SITIO'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_CLIENTE'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_CARGO'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_CONDICION_COMERCIAL'
-- =================================== COMERCIALIZACION
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_LECTURA'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_SITIO_CONTROL_RECIBO'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_RENGLON_RECIBO'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_RECIBO'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_GENERA_RECIBO_PDF'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_GENERA_ESDTADO_CUENTA'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_PAGO'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_APLICAR_PAGO_CLIENTE'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_PAGO_RECIBO'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_CLIENTE_DESCONEXION_RECONEXION'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_BITACORA_DESCONEXION_RECONEXION'
-- =================================== INVENTARIOS
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_ALMACEN_SITIO'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_MOVIMIENTO_ALMACEN'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_HISTORIA_ALMACEN'
-- =================================== COMISIONES
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_ADMINISTRADOR'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_SITIO_ADMINISTRADOR'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_GENERAR_COMISION'
EXECUTE [dbo].[PG_LI_PERMISO_FUNCION_X_K_USUARIO_V2]	0,0,99,	'FO_BITACORA_COMISION'

*/




-- ////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////


