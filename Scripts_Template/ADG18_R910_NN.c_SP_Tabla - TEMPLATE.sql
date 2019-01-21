-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	ADG18_AdministradoraGas
-- // MODULO:			TRANSACCION 
-- // OPERACION:		LIBERACION / STORED PROCEDURES 
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		HECTOR GONZALEZ DE LA FUENTE
-- // FECHA:		25/OCT/2018
-- ////////////////////////////////////////////////////////////// 

USE [ADG18_AdministradoraGas_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_TRANSACCION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_TRANSACCION]
GO


CREATE PROCEDURE [dbo].[PG_LI_TRANSACCION]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_D_TRANSACCION				VARCHAR(255),
	@PP_K_ESTATUS_TRANSACCION		INT,
	@PP_K_TIPO_TRANSACCION			INT,
	@PP_K_REGION					INT
	-- ===========================
AS

	DECLARE @VP_MENSAJE		VARCHAR(300)
	DECLARE @VP_L_APLICAR_MAX_ROWS	INT=1
	SET		@VP_MENSAJE		= ''
	
	-- ///////////////////////////////////////////

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_SELECT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													1, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT	

	-- ///////////////////////////////////////////
		
	DECLARE @VP_LI_N_REGISTROS		INT

	EXECUTE [dbo].[PG_SK_CONFIGURACION_LI_N_REGISTROS_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
															@VP_L_APLICAR_MAX_ROWS,
															@OU_LI_N_REGISTROS = @VP_LI_N_REGISTROS		OUTPUT		
	-- =========================================	

	IF @VP_MENSAJE<>''
		SET @VP_LI_N_REGISTROS = 0
	
	-- =========================================		

	DECLARE @VP_K_FOLIO		INT

	EXECUTE [dbo].[PG_RN_OBTENER_ID_X_REFERENCIA]	@PP_D_TRANSACCION, 
													@OU_K_ELEMENTO = @VP_K_FOLIO	OUTPUT
	-- =========================================
		
	DECLARE @VP_L_VER_BORRADOS		[INT]		
	
	EXECUTE [dbo].[PG_RN_DATA_VER_BORRADOS]			@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@OU_L_VER_BORRADOS = @VP_L_VER_BORRADOS			OUTPUT
	-- =========================================

	SELECT	TOP ( @VP_LI_N_REGISTROS )
			TRANSACCION.*,
			-- ==============================
			D_ESTATUS_TRANSACCION, D_TIPO_TRANSACCION,
			S_ESTATUS_TRANSACCION, S_TIPO_TRANSACCION,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	TRANSACCION, USUARIO, 
			ESTATUS_TRANSACCION, TIPO_TRANSACCION
			-- ==============================
	WHERE	TRANSACCION.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
	AND		TRANSACCION.K_ESTATUS_TRANSACCION=ESTATUS_TRANSACCION.K_ESTATUS_TRANSACCION
	AND		TRANSACCION.K_TIPO_TRANSACCION=TIPO_TRANSACCION.K_TIPO_TRANSACCION
			-- ==============================
	AND		(	D_TRANSACCION			LIKE '%'+@PP_D_TRANSACCION+'%' 
			OR	D_TIPO_TRANSACCION		LIKE '%'+@PP_D_TRANSACCION+'%' 
			OR	D_ESTATUS_TRANSACCION	LIKE '%'+@PP_D_TRANSACCION+'%' 
			OR	K_TRANSACCION=@VP_K_FOLIO	)	
			-- ==============================
	AND		(	@PP_K_ESTATUS_TRANSACCION=-1	OR  TRANSACCION.K_ESTATUS_TRANSACCION=@PP_K_ESTATUS_TRANSACCION )
	AND		(	@PP_K_TIPO_TRANSACCION=-1		OR  TRANSACCION.K_TIPO_TRANSACCION=@PP_K_TIPO_TRANSACCION )
	AND		(	TRANSACCION.L_BORRADO=0		OR	@VP_L_VER_BORRADOS=1	)
			-- ==============================
	ORDER BY D_TRANSACCION ASC

	-- ////////////////////////////////////////////////

GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_TRANSACCION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_TRANSACCION]
GO


CREATE PROCEDURE [dbo].[PG_SK_TRANSACCION]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_TRANSACCION				INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''
	
	-- ///////////////////////////////////////////

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_SEEK]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													1, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- ///////////////////////////////////////////

	IF @VP_MENSAJE=''
		BEGIN
	
		SELECT	TRANSACCION.*, 
				-- ==============================
				D_ESTATUS_TRANSACCION, D_TIPO_TRANSACCION, D_REGION,
				S_ESTATUS_TRANSACCION, S_TIPO_TRANSACCION, S_REGION
				-- ==============================
		FROM	TRANSACCION, USUARIO, 
				ESTATUS_TRANSACCION, TIPO_TRANSACCION, REGION
				-- ==============================
		WHERE	TRANSACCION.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
		AND		TRANSACCION.K_ESTATUS_TRANSACCION=ESTATUS_TRANSACCION.K_ESTATUS_TRANSACCION
		AND		TRANSACCION.K_TIPO_TRANSACCION=TIPO_TRANSACCION.K_TIPO_TRANSACCION
		AND		TRANSACCION.K_REGION=REGION.K_REGION
				-- ==============================
		AND		TRANSACCION.K_TRANSACCION=@PP_K_TRANSACCION

		END

	-- ////////////////////////////////////////////////
GO


	
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_TRANSACCION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_TRANSACCION]
GO


CREATE PROCEDURE [dbo].[PG_IN_TRANSACCION]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================				
	@PP_D_TRANSACCION			VARCHAR(100),
	@PP_S_TRANSACCION			VARCHAR(100),
	@PP_O_TRANSACCION			INT,
	-- ============================	
	@PP_K_ESTATUS_TRANSACCION	INT,	
	@PP_K_TIPO_TRANSACCION		INT,	
	-- ============================		
	@PP_DATO_VAR				VARCHAR(100), 
	@PP_DATO_DEC				DECIMAL(19,4),
	@PP_DATO_INT				INT			
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''
	
	-- /////////////////////////////////////////////////////////////////////
	
	DECLARE @VP_K_TRANSACCION	INT = 0
	DECLARE @VP_O_TRANSACCION	INT = 0
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_TRANSACCION_INSERT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@VP_K_TRANSACCION, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- /////////////////////////////////////////////////////////////////////
		
	IF @VP_MENSAJE=''
		BEGIN
	
		EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
													'TRANSACCION', 
													@OU_K_TABLA_DISPONIBLE = @VP_K_TRANSACCION	OUTPUT

		-- //////////////////////////////////////////////////////////////
		
		INSERT INTO TRANSACCION
			(	[K_TRANSACCION],
				[D_TRANSACCION], [S_TRANSACCION], [O_TRANSACCION],
				[K_ESTATUS_TRANSACCION], [K_TIPO_TRANSACCION],
				-- ===========================
				[DATO_VAR], [DATO_DEC], [DATO_INT],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES	
			(	@VP_K_TRANSACCION,
				@PP_D_TRANSACCION, @PP_S_TRANSACCION, @PP_O_TRANSACCION,
				@PP_K_ESTATUS_TRANSACCION, @PP_K_TIPO_TRANSACCION,	
				@PP_DATO_VAR, @PP_DATO_DEC, @PP_DATO_INT,
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )
		
		END

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Crear] la [Transacción]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#TRA.'+CONVERT(VARCHAR(10),@VP_K_TRANSACCION)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
	
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_TRANSACCION AS CLAVE

	-- //////////////////////////////////////////////////////////////

GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ACTUALIZAR / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_TRANSACCION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_TRANSACCION]
GO

CREATE PROCEDURE [dbo].[PG_UP_TRANSACCION]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_TRANSACCION			INT,
	@PP_D_TRANSACCION			VARCHAR(100),
	@PP_S_TRANSACCION			VARCHAR(100),
	@PP_O_TRANSACCION			INT,
	-- ============================	
	@PP_K_ESTATUS_TRANSACCION	INT,	
	@PP_K_TIPO_TRANSACCION		INT,	
	-- ============================		
	@PP_DATO_VAR				VARCHAR(100), 
	@PP_DATO_DEC				DECIMAL(19,4),
	@PP_DATO_INT				INT			
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- /////////////////////////////////////////////////////////////////////

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_TRANSACCION_UPDATE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_TRANSACCION, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		BEGIN

		UPDATE	TRANSACCION
		SET				
				[D_TRANSACCION]			= @PP_D_TRANSACCION,
				[S_TRANSACCION]			= @PP_S_TRANSACCION,
				[O_TRANSACCION]			= @PP_O_TRANSACCION,
				-- ===========================
				[K_ESTATUS_TRANSACCION] = @PP_K_ESTATUS_TRANSACCION,	
				[K_TIPO_TRANSACCION]	= @PP_K_TIPO_TRANSACCION,
				-- ===========================
				[DATO_VAR]				= @PP_DATO_VAR,
				[DATO_DEC]				= @PP_DATO_DEC,
				[DATO_INT]				= @PP_DATO_INT,
				-- ===========================
			    [F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	K_TRANSACCION=@PP_K_TRANSACCION
	
		END

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Actualizar] la [Transacción]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#TRA.'+CONVERT(VARCHAR(10),@PP_K_TRANSACCION)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_TRANSACCION AS CLAVE

	-- //////////////////////////////////////////////////////////////
	
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_TRANSACCION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_TRANSACCION]
GO


CREATE PROCEDURE [dbo].[PG_DL_TRANSACCION]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_TRANSACCION			INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	--/////////////////////////////////////////////////////////////

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_TRANSACCION_DELETE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_TRANSACCION, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	--////////////////////////////////////////////////////////////

	IF @VP_MENSAJE=''
		BEGIN
		
	--	DELETE
	--	FROM	EMPRESA
	--	WHERE	EMPRESA.K_EMPRESA=@PP_K_EMPRESA

		UPDATE	TRANSACCION
		SET		
				[L_BORRADO]				= 1,
				-- ====================
				[F_BAJA]				= GETDATE(), 
				[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
		WHERE	K_TRANSACCION=@PP_K_TRANSACCION
	
		END

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Borrar] la [Transacción]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#TRA.'+CONVERT(VARCHAR(10),@PP_K_TRANSACCION)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_TRANSACCION AS CLAVE

	-- //////////////////////////////////////////////////////////////
	
GO




-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
