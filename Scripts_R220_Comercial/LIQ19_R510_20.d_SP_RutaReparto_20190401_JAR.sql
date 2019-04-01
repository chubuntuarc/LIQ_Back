-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_......d_SP_RUTA_REPARTO
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			RUTA_REPARTO 
-- // OPERACION:		LIBERACION / STORED PROCEDURES 
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		JESUS ARCINIEGA
-- // FECHA:		01/ABR/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_RUTA_REPARTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_RUTA_REPARTO]
GO

-- EXEC [dbo].[PG_LI_RUTA_REPARTO] 0,0,0,'',-1,-1,-1

CREATE PROCEDURE [dbo].[PG_LI_RUTA_REPARTO]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_BUSCAR						VARCHAR(255),
	-- ===========================
	@PP_K_UNIDAD_OPERATIVA			INT,
	-- ===========================
	@PP_K_ESTATUS_RUTA_REPARTO		INT,
	@PP_K_TIPO_RUTA_REPARTO			INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300)

	SET		@VP_MENSAJE		= ''
	
	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_SELECT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													1, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT	

	-- ///////////////////////////////////////////
		
	DECLARE @VP_L_APLICAR_MAX_ROWS	INT=0
	DECLARE @VP_LI_N_REGISTROS		INT

	EXECUTE [dbo].[PG_SK_CONFIGURACION_LI_N_REGISTROS_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
															@VP_L_APLICAR_MAX_ROWS,
															@OU_LI_N_REGISTROS = @VP_LI_N_REGISTROS		OUTPUT		
	-- =========================================	

	IF @VP_MENSAJE<>''
		SET @VP_LI_N_REGISTROS = 0
	
	-- =========================================		

	DECLARE @VP_K_FOLIO		INT

	EXECUTE [dbo].[PG_RN_OBTENER_ID_X_REFERENCIA]	@PP_BUSCAR, 
													@OU_K_ELEMENTO = @VP_K_FOLIO	OUTPUT
	-- =========================================
	
	DECLARE @VP_L_VER_BORRADOS		[INT]		
	
	EXECUTE [dbo].[PG_RN_DATA_VER_BORRADOS]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@OU_L_VER_BORRADOS = @VP_L_VER_BORRADOS			OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR

	SELECT	TOP ( @VP_LI_N_REGISTROS )
			RUTA_REPARTO.*,
			---- ==============================
			UNIDAD_OPERATIVA.D_UNIDAD_OPERATIVA,
			ESTATUS_RUTA_REPARTO.D_ESTATUS_RUTA_REPARTO,
			TIPO_RUTA_REPARTO.D_TIPO_RUTA_REPARTO,
			---- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	RUTA_REPARTO, USUARIO, UNIDAD_OPERATIVA, ESTATUS_RUTA_REPARTO, TIPO_RUTA_REPARTO
			-- ==============================
	WHERE	RUTA_REPARTO.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
	AND		RUTA_REPARTO.K_UNIDAD_OPERATIVA=UNIDAD_OPERATIVA.K_UNIDAD_OPERATIVA
	AND		RUTA_REPARTO.K_ESTATUS_RUTA_REPARTO=ESTATUS_RUTA_REPARTO.K_ESTATUS_RUTA_REPARTO
	AND		RUTA_REPARTO.K_TIPO_RUTA_REPARTO=TIPO_RUTA_REPARTO.K_TIPO_RUTA_REPARTO
			-- ==============================
	AND		(	D_RUTA_REPARTO			LIKE '%'+@PP_BUSCAR+'%' 
			OR	D_UNIDAD_OPERATIVA		LIKE '%'+@PP_BUSCAR+'%'
			OR	D_TIPO_RUTA_REPARTO		LIKE '%'+@PP_BUSCAR+'%' 
			OR	K_RUTA_REPARTO=@VP_K_FOLIO	)	
			-- ==============================
	AND		(	@PP_K_ESTATUS_RUTA_REPARTO=-1	OR  RUTA_REPARTO.K_ESTATUS_RUTA_REPARTO=@PP_K_ESTATUS_RUTA_REPARTO )
	AND		(	@PP_K_TIPO_RUTA_REPARTO=-1		OR  RUTA_REPARTO.K_TIPO_RUTA_REPARTO=@PP_K_TIPO_RUTA_REPARTO )
	AND		(	@PP_K_UNIDAD_OPERATIVA=-1		OR  RUTA_REPARTO.K_UNIDAD_OPERATIVA=@PP_K_UNIDAD_OPERATIVA )
			-- ==============================
	AND		(	RUTA_REPARTO.L_BORRADO=0		OR	@VP_L_VER_BORRADOS=1	)

	ORDER BY K_RUTA_REPARTO ASC

	-- ////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_RUTA_REPARTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_RUTA_REPARTO]
GO

-- EXEC [dbo].[PG_SK_RUTA_REPARTO] 0,0,0,21

CREATE PROCEDURE [dbo].[PG_SK_RUTA_REPARTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_RUTA_REPARTO			INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''
	
	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_SEEK]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													1, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	
	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	DECLARE @VP_LI_N_REGISTROS INT = 1

	IF @VP_MENSAJE<>''
		SET @VP_LI_N_REGISTROS = 0
	
	SELECT	TOP ( @VP_LI_N_REGISTROS )
			RUTA_REPARTO.*,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	RUTA_REPARTO, USUARIO, PUNTO_VENTA, UNIDAD_OPERATIVA, 
			ESTATUS_RUTA_REPARTO, TIPO_RUTA_REPARTO
			-- ==============================
	WHERE	RUTA_REPARTO.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
	AND		RUTA_REPARTO.K_UNIDAD_OPERATIVA=UNIDAD_OPERATIVA.K_UNIDAD_OPERATIVA
	AND		RUTA_REPARTO.K_ESTATUS_RUTA_REPARTO=ESTATUS_RUTA_REPARTO.K_ESTATUS_RUTA_REPARTO
	AND		RUTA_REPARTO.K_TIPO_RUTA_REPARTO=TIPO_RUTA_REPARTO.K_TIPO_RUTA_REPARTO
			-- ==============================
	AND		PUNTO_VENTA.L_BORRADO=0
	AND		RUTA_REPARTO.K_RUTA_REPARTO=@PP_K_RUTA_REPARTO

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	-- // NO ES REQUERIDA LA SECCION #3

	-- ////////////////////////////////////////////////
GO


	
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_RUTA_REPARTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_RUTA_REPARTO]
GO

-- EXEC [dbo].[PG_IN_RUTA_REPARTO] 0,2005,18,'Ruta 21','','R21',3,1,1

CREATE PROCEDURE [dbo].[PG_IN_RUTA_REPARTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================			
	--@PP_K_RUTA_REPARTO		INT,
	@PP_D_RUTA_REPARTO			VARCHAR(255),
	@PP_C_RUTA_REPARTO			VARCHAR(500),
	@PP_S_RUTA_REPARTO			VARCHAR(10),
	-- ============================	
	@PP_K_UNIDAD_OPERATIVA		INT,	
	-- ============================		
	@PP_K_ESTATUS_RUTA_REPARTO	INT,
	@PP_K_TIPO_RUTA_REPARTO		INT
	-- ============================		
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''
	
	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	
	
	DECLARE @VP_K_RUTA_REPARTO	INT = 0
	DECLARE @VP_O_RUTA_REPARTO	INT = 0
	
	IF @VP_MENSAJE=''	
		EXECUTE [dbo].[PG_RN_RUTA_REPARTO_INSERT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												--	@VP_K_RUTA_REPARTO, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN

		EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, 
													'RUTA_REPARTO', 
													@OU_K_TABLA_DISPONIBLE = @VP_K_RUTA_REPARTO	OUTPUT
		-- ====================================

		INSERT INTO RUTA_REPARTO
			( [K_RUTA_REPARTO], [D_RUTA_REPARTO],
			[C_RUTA_REPARTO],	[S_RUTA_REPARTO],
			-- ===========================
			[K_UNIDAD_OPERATIVA],
			-- ===========================
			[K_ESTATUS_RUTA_REPARTO], [K_TIPO_RUTA_REPARTO],
			-- ===========================
			[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
			[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA] )
		VALUES
			( @VP_K_RUTA_REPARTO, @PP_D_RUTA_REPARTO,
				@PP_C_RUTA_REPARTO, @PP_S_RUTA_REPARTO,
				-- ===========================
				@PP_K_UNIDAD_OPERATIVA,
				-- ===========================
				@PP_K_ESTATUS_RUTA_REPARTO, @PP_K_TIPO_RUTA_REPARTO,
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )

		END

		-- ====================================

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Crear] el [RUTA_REPARTO]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@VP_K_RUTA_REPARTO)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
	
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_RUTA_REPARTO AS CLAVE

	-- //////////////////////////////////////////////////////////////

GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ACTUALIZAR / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_RUTA_REPARTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_RUTA_REPARTO]
GO

-- EXEC [dbo].[PG_UP_RUTA_REPARTO] 0,2005,18,21,'Ruta 21XX','XX','R21XX',3,1,1

CREATE PROCEDURE [dbo].[PG_UP_RUTA_REPARTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================			
	@PP_K_RUTA_REPARTO			INT,
	@PP_D_RUTA_REPARTO			VARCHAR(255),
	@PP_C_RUTA_REPARTO			VARCHAR(500),
	@PP_S_RUTA_REPARTO			VARCHAR(10),
	-- ============================	
	@PP_K_UNIDAD_OPERATIVA		INT,	
	-- ============================		
	@PP_K_ESTATUS_RUTA_REPARTO	INT,
	@PP_K_TIPO_RUTA_REPARTO		INT
	-- ============================		
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_RUTA_REPARTO_UPDATE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_RUTA_REPARTO, 
														@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN
		-- ===========================
		UPDATE	RUTA_REPARTO
		SET			
				[K_RUTA_REPARTO]			= @PP_K_RUTA_REPARTO, 
				[D_RUTA_REPARTO]			= @PP_D_RUTA_REPARTO,
				[C_RUTA_REPARTO]			= @PP_C_RUTA_REPARTO,
				[S_RUTA_REPARTO]			= @PP_S_RUTA_REPARTO,
				-- ===========================
				[K_UNIDAD_OPERATIVA]		= @PP_K_UNIDAD_OPERATIVA,
				-- ===========================
				[K_ESTATUS_RUTA_REPARTO]	=@PP_K_ESTATUS_RUTA_REPARTO,
				[K_TIPO_RUTA_REPARTO]		= @PP_K_TIPO_RUTA_REPARTO,
				-- ===========================
			    [F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	K_RUTA_REPARTO=@PP_K_RUTA_REPARTO

		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Actualizar] el [RUTA_REPARTO]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@PP_K_RUTA_REPARTO)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_RUTA_REPARTO AS CLAVE

	-- //////////////////////////////////////////////////////////////
	
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_RUTA_REPARTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_RUTA_REPARTO]
GO

-- EXEC [dbo].[PG_DL_RUTA_REPARTO] 0,2005,18,21

CREATE PROCEDURE [dbo].[PG_DL_RUTA_REPARTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_RUTA_REPARTO				INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_RUTA_REPARTO_DELETE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_RUTA_REPARTO, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR

	IF @VP_MENSAJE=''
		BEGIN

		UPDATE	RUTA_REPARTO
		SET		
				[L_BORRADO]				= 1,
				-- ====================
				[F_BAJA]				= GETDATE(), 
				[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
		WHERE	K_RUTA_REPARTO=@PP_K_RUTA_REPARTO
	
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Borrar] el [RUTA_REPARTO]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@PP_K_RUTA_REPARTO)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_RUTA_REPARTO AS CLAVE

	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
