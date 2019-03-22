-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	
-- // MÓDULO:			CLIENTE_TMK
-- // OPERACIÓN:		LIBERACIÓN / STORED PROCEDURES
-- ////////////////////////////////////////////////////////////// 
-- // Autor:			D
-- // Fecha creación:	
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////
-- SELECT * FROM CLIENTE_TMK
-- EXECUTE [PG_LI_CLIENTE_TMK] 0,0,0, '', -1, -1

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_CLIENTE_TMK]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_CLIENTE_TMK]
GO

CREATE PROCEDURE [dbo].[PG_LI_CLIENTE_TMK]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- =============================	
	@PP_BUSCAR					VARCHAR(255),
	@PP_K_ESTATUS_CLIENTE_TMK	INT,
	@PP_K_ALERTA_VENTA		INT,
	@PP_K_TIPO_CLIENTE_TMK		INT
AS

	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	DECLARE @VP_L_APLICAR_MAX_ROWS	INT = 1
		
	-- ///////////////////////////////////////////

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_SELECT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													11, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- ///////////////////////////////////////////

	DECLARE @VP_INT_NUMERO_REGISTROS	INT

	EXECUTE [dbo].[PG_SK_CONFIGURACION_LISTADO_MAX_ROWS_PESADO_GET]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
																		@VP_L_APLICAR_MAX_ROWS,		
																		@OU_MAXROWS = @VP_INT_NUMERO_REGISTROS		OUTPUT	
	-- =========================================		

	DECLARE @VP_K_FOLIO		INT

	EXECUTE [dbo].[PG_RN_OBTENER_ID_X_REFERENCIA]	@PP_BUSCAR, 
													@OU_K_ELEMENTO = @VP_K_FOLIO	OUTPUT
	-- =========================================
	
	DECLARE @VP_L_VER_BORRADOS		INT		
	
	EXECUTE [dbo].[PG_RN_DATA_VER_BORRADOS]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@OU_L_VER_BORRADOS = @VP_L_VER_BORRADOS			OUTPUT
	-- =========================================
	
	IF @VP_MENSAJE<>''
		SET @VP_INT_NUMERO_REGISTROS = 0

	SELECT	TOP ( @VP_INT_NUMERO_REGISTROS )
				CLIENTE_TMK.*,
				S_ESTATUS_CLIENTE_TMK,	D_ESTATUS_CLIENTE_TMK, 
				S_ALERTA_VENTA,		D_ALERTA_VENTA, 
				S_TIPO_CLIENTE_TMK,		D_TIPO_CLIENTE_TMK,
				D_USUARIO AS D_USUARIO_CAMBIO			
				-- =====================
	FROM		CLIENTE_TMK
	INNER JOIN	ESTATUS_CLIENTE_TMK ON	CLIENTE_TMK.K_ESTATUS_CLIENTE_TMK=ESTATUS_CLIENTE_TMK.K_ESTATUS_CLIENTE_TMK
	INNER JOIN	ALERTA_VENTA		ON	CLIENTE_TMK.K_ALERTA_VENTA=ALERTA_VENTA.K_ALERTA_VENTA
	INNER JOIN	TIPO_CLIENTE_TMK	ON	CLIENTE_TMK.K_TIPO_CLIENTE_TMK=TIPO_CLIENTE_TMK.K_TIPO_CLIENTE_TMK
	INNER JOIN	USUARIO				ON	CLIENTE_TMK.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
				-- =====================
	WHERE	(	CLIENTE_TMK.L_BORRADO = 0	OR	@VP_L_VER_BORRADOS = 1	)
	AND		(		D_CLIENTE_TMK		LIKE '%'+ @PP_BUSCAR +'%' 
				OR	C_CLIENTE_TMK		LIKE '%'+ @PP_BUSCAR +'%'
				OR	NOMBRE				LIKE '%'+ @PP_BUSCAR +'%'
				OR	APELLIDO_PATERNO	LIKE '%'+ @PP_BUSCAR +'%'
				OR	APELLIDO_MATERNO	LIKE '%'+ @PP_BUSCAR +'%'
				OR	RFC					LIKE '%'+ @PP_BUSCAR +'%'
				OR	CALLE				LIKE '%'+ @PP_BUSCAR +'%'
				OR	ENTRE_CALLE			LIKE '%'+ @PP_BUSCAR +'%'
				OR	Y_CALLE				LIKE '%'+ @PP_BUSCAR +'%'
				OR	COLONIA				LIKE '%'+ @PP_BUSCAR +'%'
				OR	MUNICIPIO			LIKE '%'+ @PP_BUSCAR +'%'
				OR	ESTADO				LIKE '%'+ @PP_BUSCAR +'%'			
				OR	CLIENTE_TMK.K_CLIENTE_TMK=@VP_K_FOLIO 					)	
	AND		(	@PP_K_ESTATUS_CLIENTE_TMK=-1	OR	ESTATUS_CLIENTE_TMK.K_ESTATUS_CLIENTE_TMK=@PP_K_ESTATUS_CLIENTE_TMK	)
	AND		(	@PP_K_ALERTA_VENTA=-1		OR	ALERTA_VENTA.K_ALERTA_VENTA=@PP_K_ALERTA_VENTA	)
	AND		(	@PP_K_TIPO_CLIENTE_TMK=-1		OR	TIPO_CLIENTE_TMK.K_TIPO_CLIENTE_TMK=@PP_K_TIPO_CLIENTE_TMK	)
				-- =====================		
	ORDER BY	D_CLIENTE_TMK
	
	-- /////////////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													2,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'SELECT',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_LI_CLIENTE_TMK]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													0, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, @PP_BUSCAR, '' , 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '@PP_BUSCAR', '', '', ''

	-- /////////////////////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////
-- EXECUTE [PG_SK_CLIENTE_TMK] 0,0,0, 23

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_CLIENTE_TMK]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_CLIENTE_TMK]
GO

CREATE PROCEDURE [dbo].[PG_SK_CLIENTE_TMK]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- =============================
	@PP_K_CLIENTE_TMK			INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300) = ''
	
	-- ///////////////////////////////////////////

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_SEEK]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													11, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- ///////////////////////////////////////////
	
	DECLARE @VP_L_VER_BORRADOS		INT		
	
	EXECUTE [dbo].[PG_RN_DATA_VER_BORRADOS]			@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@OU_L_VER_BORRADOS = @VP_L_VER_BORRADOS		OUTPUT
	-- ///////////////////////////////////////////
	
	DECLARE @VP_INT_NUMERO_REGISTROS INT = 1

	IF @VP_MENSAJE<>''
		SET @VP_INT_NUMERO_REGISTROS = 0
	
	SELECT	TOP ( @VP_INT_NUMERO_REGISTROS )
				CLIENTE_TMK.*,
				S_ESTATUS_CLIENTE_TMK,	D_ESTATUS_CLIENTE_TMK, 
				S_ALERTA_VENTA,		D_ALERTA_VENTA, 
				S_TIPO_CLIENTE_TMK,		D_TIPO_CLIENTE_TMK,
				D_USUARIO AS D_USUARIO_CAMBIO			
				-- =====================
	FROM		CLIENTE_TMK
	INNER JOIN	ESTATUS_CLIENTE_TMK ON	CLIENTE_TMK.K_ESTATUS_CLIENTE_TMK=ESTATUS_CLIENTE_TMK.K_ESTATUS_CLIENTE_TMK
	INNER JOIN	ALERTA_VENTA		ON	CLIENTE_TMK.K_ALERTA_VENTA=ALERTA_VENTA.K_ALERTA_VENTA
	INNER JOIN	TIPO_CLIENTE_TMK	ON	CLIENTE_TMK.K_TIPO_CLIENTE_TMK=TIPO_CLIENTE_TMK.K_TIPO_CLIENTE_TMK
	INNER JOIN	USUARIO			ON	CLIENTE_TMK.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
				-- =====================
	WHERE	(	CLIENTE_TMK.L_BORRADO=0		OR		@VP_L_VER_BORRADOS=1	)
				-- =====================
	AND			CLIENTE_TMK.K_CLIENTE_TMK=@PP_K_CLIENTE_TMK		

	-- ////////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													2,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'SEEK',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_SK_CLIENTE_TMK]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_CLIENTE_TMK, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, '', '' , 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '', '', ''

	-- ////////////////////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_CLIENTE_TMK]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_CLIENTE_TMK]
GO

CREATE PROCEDURE [dbo].[PG_IN_CLIENTE_TMK]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ======================================
	@PP_D_CLIENTE_TMK			VARCHAR(255),
	@PP_C_CLIENTE_TMK			VARCHAR(500),
	@PP_S_CLIENTE_TMK			VARCHAR(10),	
	-- =====================================
	@PP_K_ESTATUS_CLIENTE_TMK	INT,
	@PP_K_ALERTA_VENTA		INT,
	@PP_K_TIPO_CLIENTE_TMK		INT,
	-- ======================================
	@PP_NOMBRE					VARCHAR(100),
	@PP_APELLIDO_PATERNO		VARCHAR(100),
	@PP_APELLIDO_MATERNO		VARCHAR(100),
	@PP_RFC						VARCHAR(100),
	-- ======================================
	@PP_CALLE					VARCHAR(100),
	@PP_NUMERO_EXTERIOR			VARCHAR(100),
	@PP_NUMERO_INTERIOR			VARCHAR(100),
	@PP_ENTRE_CALLE				VARCHAR(100),
	@PP_Y_CALLE					VARCHAR(100),
	@PP_COLONIA					VARCHAR(100),
	-- ======================================
	@PP_MUNICIPIO				VARCHAR(100),
	@PP_ESTADO					VARCHAR(100),
	@PP_CP						VARCHAR(100)
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300) = ''

	-- /////////////////////////////////////////////////////////////////////
	
	DECLARE @VP_K_CLIENTE_TMK		INT = 0

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_CLIENTE_TMK_INSERT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@VP_K_CLIENTE_TMK, @PP_D_CLIENTE_TMK, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- /////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		BEGIN
	
		EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
													'CLIENTE_TMK', 
													@OU_K_TABLA_DISPONIBLE = @VP_K_CLIENTE_TMK			OUTPUT
		-- /////////////////////////////////////////
		
		INSERT INTO CLIENTE_TMK
			(	K_CLIENTE_TMK,				D_CLIENTE_TMK,
				C_CLIENTE_TMK,				S_CLIENTE_TMK,	
				-- ========================================
				K_ESTATUS_CLIENTE_TMK,		K_ALERTA_VENTA,
				K_TIPO_CLIENTE_TMK,
				-- ========================================
				NOMBRE,					
				APELLIDO_PATERNO,			APELLIDO_MATERNO,		
				RFC,
				-- ========================================
				CALLE,
				NUMERO_EXTERIOR,			NUMERO_INTERIOR,
				ENTRE_CALLE,				Y_CALLE,
				COLONIA,					
				-- ========================================
				MUNICIPIO,					ESTADO,					
				CP,
				-- ========================================
				K_USUARIO_ALTA,				F_ALTA,
				K_USUARIO_CAMBIO,			F_CAMBIO,
				L_BORRADO,
				K_USUARIO_BAJA,				F_BAJA				)
		VALUES	
			(	@VP_K_CLIENTE_TMK,			@PP_D_CLIENTE_TMK,			
				@PP_C_CLIENTE_TMK,			@PP_S_CLIENTE_TMK,
				-- ========================================
				@PP_K_ESTATUS_CLIENTE_TMK,	@PP_K_ALERTA_VENTA,
				@PP_K_TIPO_CLIENTE_TMK,
				-- ========================================
				@PP_NOMBRE,				
				@PP_APELLIDO_PATERNO,		@PP_APELLIDO_MATERNO,	
				@PP_RFC,
				-- ========================================
				@PP_CALLE,
				@PP_NUMERO_EXTERIOR,		@PP_NUMERO_INTERIOR,
				@PP_ENTRE_CALLE,			@PP_Y_CALLE,
				@PP_COLONIA,			
				-- ========================================
				@PP_MUNICIPIO,				@PP_ESTADO,				
				@PP_CP,					
				-- ========================================
				@PP_K_USUARIO_ACCION,		GETDATE(),
				@PP_K_USUARIO_ACCION,		GETDATE(),
				0,
				NULL, NULL									)
			
		END

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible crear el [Cliente] de CYC: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Cli.'+CONVERT(VARCHAR(10),@VP_K_CLIENTE_TMK)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
		
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_CLIENTE_TMK AS CLAVE

	-- //////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													3,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'INSERT',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_IN_CLIENTE_TMK]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@VP_K_CLIENTE_TMK, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, @PP_D_CLIENTE_TMK, '', 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '@PP_CLIENTE_TMK', '', '', ''

	-- //////////////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> UPDATE / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_CLIENTE_TMK]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_CLIENTE_TMK]
GO

CREATE PROCEDURE [dbo].[PG_UP_CLIENTE_TMK]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ======================================
	@PP_K_CLIENTE_TMK			INT,
	-- =====================================
	@PP_D_CLIENTE_TMK			VARCHAR(255),
	@PP_C_CLIENTE_TMK			VARCHAR(500),
	@PP_S_CLIENTE_TMK			VARCHAR(10),	
	-- =====================================
	@PP_K_ESTATUS_CLIENTE_TMK	INT,
	@PP_K_ALERTA_VENTA		INT,
	@PP_K_TIPO_CLIENTE_TMK		INT,
	-- ======================================
	@PP_NOMBRE					VARCHAR(100),
	@PP_APELLIDO_PATERNO		VARCHAR(100),
	@PP_APELLIDO_MATERNO		VARCHAR(100),
	@PP_RFC						VARCHAR(100),
	-- ======================================
	@PP_CALLE					VARCHAR(100),
	@PP_NUMERO_EXTERIOR			VARCHAR(100),
	@PP_NUMERO_INTERIOR			VARCHAR(100),
	@PP_ENTRE_CALLE				VARCHAR(100),
	@PP_Y_CALLE					VARCHAR(100),
	@PP_COLONIA					VARCHAR(100),
	-- ======================================
	@PP_MUNICIPIO				VARCHAR(100),
	@PP_ESTADO					VARCHAR(100),
	@PP_CP						VARCHAR(100)
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300) = ''

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_CLIENTE_TMK_UPDATE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_CLIENTE_TMK, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- /////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		BEGIN

		UPDATE	CLIENTE_TMK
		SET		
				K_CLIENTE_TMK			= @PP_K_CLIENTE_TMK,				
				D_CLIENTE_TMK			= @PP_D_CLIENTE_TMK,
				C_CLIENTE_TMK			= @PP_C_CLIENTE_TMK,				
				S_CLIENTE_TMK			= @PP_S_CLIENTE_TMK,	
				-- ==========================================
				K_ESTATUS_CLIENTE_TMK	= @PP_K_ESTATUS_CLIENTE_TMK,
				K_ALERTA_VENTA		= @PP_K_ALERTA_VENTA,		
				K_TIPO_CLIENTE_TMK		= @PP_K_TIPO_CLIENTE_TMK,
				-- ==========================================
				NOMBRE					= @PP_NOMBRE,					
				APELLIDO_PATERNO		= @PP_APELLIDO_PATERNO,
				APELLIDO_MATERNO		= @PP_APELLIDO_MATERNO,	
				RFC						= @PP_RFC,
				-- ==========================================	
				CALLE					= @PP_CALLE,
				NUMERO_EXTERIOR			= @PP_NUMERO_EXTERIOR,		
				NUMERO_INTERIOR			= @PP_NUMERO_INTERIOR,
				ENTRE_CALLE				= @PP_ENTRE_CALLE,			
				Y_CALLE					= @PP_Y_CALLE,
				COLONIA					= @PP_COLONIA,	
				-- ==========================================			
				MUNICIPIO				= @PP_MUNICIPIO,
				ESTADO					= @PP_ESTADO,					
				CP						= @PP_CP,
				-- ==========================================
				K_USUARIO_CAMBIO		= @PP_K_USUARIO_ACCION, 
				F_CAMBIO				= GETDATE() 
		WHERE	K_CLIENTE_TMK=@PP_K_CLIENTE_TMK
	
		END

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible actualizar el [Cliente] de CYC: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Cli.'+CONVERT(VARCHAR(10),@PP_K_CLIENTE_TMK)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
			
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_CLIENTE_TMK AS CLAVE

	-- //////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													3,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'UPDATE',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_UP_CLIENTE_TMK]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_CLIENTE_TMK, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, @PP_D_CLIENTE_TMK, '', 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '@PP_D_CLIENTE_TMK', '', '', ''

	-- //////////////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_CLIENTE_TMK]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_CLIENTE_TMK]
GO


CREATE PROCEDURE [dbo].[PG_DL_CLIENTE_TMK]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- =============================
	@PP_K_CLIENTE_TMK			INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300) =	''

	-- //////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_CLIENTE_TMK_DELETE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_CLIENTE_TMK, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- /////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		BEGIN

		UPDATE	CLIENTE_TMK
		SET		
				L_BORRADO			= 1,
				-- ====================
				F_BAJA				= GETDATE(), 
				K_USUARIO_BAJA		= @PP_K_USUARIO_ACCION
		WHERE	K_CLIENTE_TMK=@PP_K_CLIENTE_TMK

		END

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible borrar el [Cliente] de CYC: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Cli.'+CONVERT(VARCHAR(10),@PP_K_CLIENTE_TMK)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
		
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_CLIENTE_TMK AS CLAVE

	-- /////////////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													5,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'DELETE',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_DL_CLIENTE_TMK]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_CLIENTE_TMK, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, '', '' , 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '', '', ''

	-- /////////////////////////////////////////////////////////////////////
GO




-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////

