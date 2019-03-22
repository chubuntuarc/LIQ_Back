-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			ADG18_R410_NN.c_SP_Precio
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	ADG18_AdministradoraGas
-- // MODULO:			PRECIO 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_PRECIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_PRECIO]
GO

CREATE PROCEDURE [dbo].[PG_LI_PRECIO]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_BUSCAR						VARCHAR(255),
	-- ===========================
	@PP_K_ESTATUS_PRECIO			INT,
	@PP_K_TIPO_PRECIO				INT,
	@PP_K_PRODUCTO					INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300)

	SET		@VP_MENSAJE		= ''
	
	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_SELECT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													1, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT	

	-- ///////////////////////////////////////////
		
	DECLARE @VP_L_APLICAR_MAX_ROWS	INT=1
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
			PRECIO.*,
			-- ==============================
			D_ESTATUS_PRECIO, D_TIPO_PRECIO, D_PRODUCTO,
			S_ESTATUS_PRECIO, S_TIPO_PRECIO, S_PRODUCTO,
			VALOR_TASA_IMPUESTO,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	PRECIO, USUARIO,
			ESTATUS_PRECIO, TIPO_PRECIO, PRODUCTO,
			TASA_IMPUESTO
			-- ==============================
	WHERE	PRECIO.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
	AND		PRECIO.K_ESTATUS_PRECIO=ESTATUS_PRECIO.K_ESTATUS_PRECIO
	AND		PRECIO.K_TIPO_PRECIO=TIPO_PRECIO.K_TIPO_PRECIO
	AND		PRECIO.K_PRODUCTO=PRODUCTO.K_PRODUCTO
	AND		PRECIO.K_TASA_IMPUESTO=TASA_IMPUESTO.K_TASA_IMPUESTO
			-- ==============================
	AND		(	D_PRECIO					LIKE '%'+@PP_BUSCAR+'%' 
			OR	S_PRECIO					LIKE '%'+@PP_BUSCAR+'%'
			OR	D_ESTATUS_PRECIO			LIKE '%'+@PP_BUSCAR+'%' 
			OR	D_TIPO_PRECIO				LIKE '%'+@PP_BUSCAR+'%' 
			OR	D_PRODUCTO					LIKE '%'+@PP_BUSCAR+'%' 
			OR	PRECIO.K_PRECIO=@VP_K_FOLIO	)	
			-- ==============================
	AND		(	@PP_K_ESTATUS_PRECIO=-1		OR  PRECIO.K_ESTATUS_PRECIO=@PP_K_ESTATUS_PRECIO )
	AND		(	@PP_K_TIPO_PRECIO=-1		OR  PRECIO.K_TIPO_PRECIO=@PP_K_TIPO_PRECIO )
	AND		(	@PP_K_PRODUCTO=-1			OR  PRECIO.K_PRODUCTO=@PP_K_PRODUCTO )
	AND		(	PRECIO.L_BORRADO=0			OR	@VP_L_VER_BORRADOS=1	)
			-- ==============================
	ORDER BY D_PRECIO ASC

	-- ////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_PRECIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_PRECIO]
GO


CREATE PROCEDURE [dbo].[PG_SK_PRECIO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_PRECIO				INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''
	
	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_SEEK]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													1, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	
	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	DECLARE @VP_LI_N_REGISTROS INT = 10

	IF @VP_MENSAJE<>''
		SET @VP_LI_N_REGISTROS = 0
	
	SELECT	TOP ( @VP_LI_N_REGISTROS )
			PRECIO.*,
			-- ==============================
			D_ESTATUS_PRECIO, D_TIPO_PRECIO, D_PRODUCTO,
			S_ESTATUS_PRECIO, S_TIPO_PRECIO, S_PRODUCTO,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	PRECIO, USUARIO, 
			ESTATUS_PRECIO, TIPO_PRECIO, PRODUCTO
			-- ==============================
	WHERE	PRECIO.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
	AND		PRECIO.K_ESTATUS_PRECIO=ESTATUS_PRECIO.K_ESTATUS_PRECIO
	AND		PRECIO.K_TIPO_PRECIO=TIPO_PRECIO.K_TIPO_PRECIO
	AND		PRECIO.K_PRODUCTO=PRODUCTO.K_PRODUCTO
			-- ==============================
	AND		PRECIO.L_BORRADO=0
	AND		PRECIO.K_PRECIO=@PP_K_PRECIO

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	-- // NO ES REQUERIDA LA SECCION #3

	-- ////////////////////////////////////////////////
GO



	
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_PRECIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_PRECIO]
GO


CREATE PROCEDURE [dbo].[PG_IN_PRECIO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================			
	@PP_D_PRECIO				VARCHAR(100),
	@PP_S_PRECIO				VARCHAR(10),
	@PP_O_PRECIO				INT,
	-- ===========================			
	@PP_K_ESTATUS_PRECIO		INT,
	@PP_K_TIPO_PRECIO			INT,
	@PP_K_PRODUCTO				INT,
	-- ===========================	
	@PP_F_VIGENCIA_INICIO		DATETIME,	
	@PP_F_VIGENCIA_FIN			DATETIME,	
	@PP_PRECIO_SIN_IVA			DECIMAL(19,4)
	--@PP_PRECIO_IVA				DECIMAL(19,4),	-- SE SOLICITARA?
	--@PP_PRECIO_CON_IVA			DECIMAL(19,4)		
	-- ============================		
AS			
	
	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''
	
	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	
	
	DECLARE @VP_K_PRECIO	INT = 0
	DECLARE @VP_O_PRECIO	INT = 0
	-- /////////////////////////////////////////////////////

	IF @VP_MENSAJE=''	
		EXECUTE [dbo].[PG_RN_PRECIO_INSERT]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- /////////////////////////////////////////////////////

	IF @VP_MENSAJE=''
	EXECUTE	[PG_RN_TASA_IMPUESTO_VIGENTE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
											@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN

		EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
													'PRECIO', 
													@OU_K_TABLA_DISPONIBLE = @VP_K_PRECIO	OUTPUT
		-- ====================================

		DECLARE @VP_VALOR_TASA_IMPUESTO	DECIMAL(19,4)
		DECLARE	@VP_K_TASA_IMPUESTO		INT

		SELECT	@VP_K_TASA_IMPUESTO		= K_TASA_IMPUESTO,
				@VP_VALOR_TASA_IMPUESTO = VALOR_TASA_IMPUESTO
		FROM	TASA_IMPUESTO
		WHERE	F_VIGENCIA_INICIO<=GETDATE()
		AND		F_VIGENCIA_FIN>=GETDATE()		
		-- ====================================

		DECLARE @VP_PRECIO_IVA DECIMAL(19,2)

		SET	@VP_PRECIO_IVA = @PP_PRECIO_SIN_IVA * @VP_VALOR_TASA_IMPUESTO

		-- ====================================

		DECLARE @VP_PRECIO_CON_IVA DECIMAL(19,2)

		SET	@VP_PRECIO_CON_IVA = @PP_PRECIO_SIN_IVA + @VP_PRECIO_IVA

		-- ====================================

		INSERT INTO PRECIO
			(	[K_PRECIO],
				[D_PRECIO], [S_PRECIO], [O_PRECIO],
				-- ===========================
				[K_ESTATUS_PRECIO], [K_TIPO_PRECIO],
				[K_PRODUCTO],
				[K_TASA_IMPUESTO],
				-- ===========================
				[F_VIGENCIA_INICIO], [F_VIGENCIA_FIN],
				[PRECIO_SIN_IVA], [PRECIO_IVA],
				[PRECIO_CON_IVA],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES	
			(	@VP_K_PRECIO,
				@PP_D_PRECIO, @PP_S_PRECIO, @PP_O_PRECIO,
				-- ===========================
				@PP_K_ESTATUS_PRECIO, @PP_K_TIPO_PRECIO,
				@PP_K_PRODUCTO,
				@VP_K_TASA_IMPUESTO,
				-- ===========================
				@PP_F_VIGENCIA_INICIO,@PP_F_VIGENCIA_FIN,
				@PP_PRECIO_SIN_IVA,
				@VP_PRECIO_IVA,
				@VP_PRECIO_CON_IVA,
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )
		
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Crear] el [PRECIO]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PRE.'+CONVERT(VARCHAR(10),@VP_K_PRECIO)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
	
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_PRECIO AS CLAVE

	-- //////////////////////////////////////////////////////////////

GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ACTUALIZAR / FICHA NO SE USA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_PRECIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_PRECIO]
GO

CREATE PROCEDURE [dbo].[PG_UP_PRECIO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_PRECIO				INT,
	@PP_D_PRECIO				VARCHAR(100),
	@PP_S_PRECIO				VARCHAR(10),
	@PP_O_PRECIO				INT,
	-- ===========================			
	@PP_K_ESTATUS_PRECIO		INT,
	@PP_K_TIPO_PRECIO			INT,
	@PP_K_PRODUCTO				INT,
	-- ===========================	
	@PP_F_VIGENCIA_INICIO		DATETIME,	
	@PP_F_VIGENCIA_FIN			DATETIME,	
	@PP_PRECIO_SIN_IVA			DECIMAL(19,4),
	@PP_PRECIO_IVA				DECIMAL(19,4),	
	@PP_PRECIO_CON_IVA			DECIMAL(19,4)	
	-- ============================		
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_PRECIO_UPDATE]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@PP_K_PRECIO, 
												@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN
		
		UPDATE	PRECIO
		SET			
				[D_PRECIO]			= @PP_D_PRECIO, 
				[S_PRECIO]			= @PP_S_PRECIO, 
				[O_PRECIO]			= @PP_O_PRECIO,
				-- ===========================
				[K_ESTATUS_PRECIO]	= @PP_K_ESTATUS_PRECIO,
				[K_TIPO_PRECIO]		= @PP_K_TIPO_PRECIO,
				[K_PRODUCTO]		= @PP_K_PRODUCTO,
				-- ===========================
				[F_VIGENCIA_INICIO]	= @PP_F_VIGENCIA_INICIO,
				[F_VIGENCIA_FIN]	= @PP_F_VIGENCIA_FIN,
				[PRECIO_SIN_IVA]	= @PP_PRECIO_SIN_IVA,
				[PRECIO_IVA]		= @PP_PRECIO_IVA,
				[PRECIO_CON_IVA]	= @PP_PRECIO_CON_IVA,
				-- ===========================
			    [F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	K_PRECIO=@PP_K_PRECIO
	
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Actualizar] el [PRECIO]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PRE.'+CONVERT(VARCHAR(10),@PP_K_PRECIO)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_PRECIO AS CLAVE

	-- //////////////////////////////////////////////////////////////
	
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_PRECIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_PRECIO]
GO


CREATE PROCEDURE [dbo].[PG_DL_PRECIO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_PRECIO				INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_PRECIO_DELETE]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@PP_K_PRECIO, 
												@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR

	IF @VP_MENSAJE=''
		BEGIN

		UPDATE	PRECIO
		SET		
				[L_BORRADO]				= 1,
				-- ====================
				[F_BAJA]				= GETDATE(), 
				[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
		WHERE	K_PRECIO=@PP_K_PRECIO
	
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Borrar] el [PRECIO]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PRE.'+CONVERT(VARCHAR(10),@PP_K_PRECIO)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_PRECIO AS CLAVE

	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
