-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_05.c_SP_TASA_IMPUESTO
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			TASA_IMPUESTO 
-- // OPERACION:		LIBERACION / STORED PROCEDURES 
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		JESUS ARCINIEGA
-- // FECHA:		14/FEB/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_TASA_IMPUESTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_TASA_IMPUESTO]
GO

CREATE PROCEDURE [dbo].[PG_LI_TASA_IMPUESTO]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_BUSCAR						VARCHAR(255),
	-- ===========================
	@PP_K_IMPUESTO					INT
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
	-- SELECT * FROM TASA_IMPUESTO
	SELECT	TOP ( @VP_LI_N_REGISTROS )
			TASA_IMPUESTO.*,
			-- ==============================
			D_IMPUESTO,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	TASA_IMPUESTO, USUARIO, 
			IMPUESTO
			-- ==============================
	WHERE	TASA_IMPUESTO.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
	AND		TASA_IMPUESTO.K_IMPUESTO=IMPUESTO.K_IMPUESTO
			-- ==============================
	AND		(	D_IMPUESTO					LIKE '%'+@PP_BUSCAR+'%' 
			OR	VALOR_TASA_IMPUESTO			LIKE '%'+@PP_BUSCAR+'%'
			OR	TASA_IMPUESTO.K_TASA_IMPUESTO=@VP_K_FOLIO	)	
			-- ==============================
	AND		(	@PP_K_IMPUESTO=-1			OR  TASA_IMPUESTO.K_IMPUESTO=@PP_K_IMPUESTO )
	AND		(	TASA_IMPUESTO.L_BORRADO=0	OR	@VP_L_VER_BORRADOS=1	)
			-- ==============================
	ORDER BY K_TASA_IMPUESTO ASC

	-- ////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_TASA_IMPUESTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_TASA_IMPUESTO]
GO


CREATE PROCEDURE [dbo].[PG_SK_TASA_IMPUESTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_TASA_IMPUESTO			INT
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
			TASA_IMPUESTO.*,
			-- ==============================
			D_IMPUESTO,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	TASA_IMPUESTO, USUARIO, 
			IMPUESTO
			-- ==============================
	WHERE	TASA_IMPUESTO.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
	AND		TASA_IMPUESTO.K_IMPUESTO=IMPUESTO.K_IMPUESTO
			-- ==============================
	AND		TASA_IMPUESTO.L_BORRADO=0
	AND		TASA_IMPUESTO.K_TASA_IMPUESTO=@PP_K_TASA_IMPUESTO

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	-- // NO ES REQUERIDA LA SECCION #3

	-- ////////////////////////////////////////////////
GO



	
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_TASA_IMPUESTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_TASA_IMPUESTO]
GO


CREATE PROCEDURE [dbo].[PG_IN_TASA_IMPUESTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================			
	@PP_K_IMPUESTO				INT,
	-- ===========================	
	@PP_F_VIGENCIA_INICIO		DATETIME,	
	@PP_F_VIGENCIA_FIN			DATETIME,	
	@PP_VALOR_TASA_IMPUESTO		DECIMAL(19,4)		
	-- ============================		
AS			
	
	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''
	
	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	
	
	DECLARE @VP_K_TASA_IMPUESTO	INT = 0
	DECLARE @VP_O_TASA_IMPUESTO	INT = 0
	
	IF @VP_MENSAJE=''	
		EXECUTE [dbo].[PG_RN_TASA_IMPUESTO_INSERT]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_F_VIGENCIA_INICIO, @PP_F_VIGENCIA_FIN,
														@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN

		EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
													'TASA_IMPUESTO', 
													@OU_K_TABLA_DISPONIBLE = @VP_K_TASA_IMPUESTO	OUTPUT
		
		-- ====================================
		INSERT INTO TASA_IMPUESTO
			(	[K_TASA_IMPUESTO],
				-- ===========================
				[K_IMPUESTO],
				-- ===========================
				[F_VIGENCIA_INICIO], [F_VIGENCIA_FIN],
				[VALOR_TASA_IMPUESTO],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES	
			(	@VP_K_TASA_IMPUESTO,
				-- ===========================
				@PP_K_IMPUESTO,
				-- ===========================
				@PP_F_VIGENCIA_INICIO,@PP_F_VIGENCIA_FIN,
				@PP_VALOR_TASA_IMPUESTO,
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )
		
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Crear] la [TASA_IMPUESTO]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Tas.'+CONVERT(VARCHAR(10),@VP_K_TASA_IMPUESTO)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
	
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_TASA_IMPUESTO AS CLAVE

	-- //////////////////////////////////////////////////////////////

GO







-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ACTUALIZAR / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_PRECIO_PRECIO_IVA_PRECIO_CON_IVA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_PRECIO_PRECIO_IVA_PRECIO_CON_IVA]
GO

CREATE PROCEDURE [dbo].[PG_UP_PRECIO_PRECIO_IVA_PRECIO_CON_IVA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_TASA_IMPUESTO			INT,
	@PP_VALOR_TASA_IMPUESTO		DECIMAL(19,4)	
	-- ============================		
AS			

	UPDATE PRECIO

	SET		PRECIO_IVA			= PRECIO_SIN_IVA * @PP_VALOR_TASA_IMPUESTO,
			F_CAMBIO			= GETDATE(),
			K_USUARIO_CAMBIO	= @PP_K_USUARIO_ACCION

	WHERE	K_TASA_IMPUESTO=@PP_K_TASA_IMPUESTO

	-- //////////////////////////////////////////////////////////////

	UPDATE PRECIO

	SET		PRECIO_CON_IVA		= PRECIO_SIN_IVA + PRECIO_IVA,
			F_CAMBIO			= GETDATE(),
			K_USUARIO_CAMBIO	= @PP_K_USUARIO_ACCION

	WHERE K_TASA_IMPUESTO=@PP_K_TASA_IMPUESTO

	-- //////////////////////////////////////////////////////////////

	
GO





-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ACTUALIZAR / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_TASA_IMPUESTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_TASA_IMPUESTO]
GO

CREATE PROCEDURE [dbo].[PG_UP_TASA_IMPUESTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_TASA_IMPUESTO			INT,
	@PP_K_IMPUESTO				INT,
	-- ===========================		
	@PP_F_VIGENCIA_INICIO		DATETIME,	
	@PP_F_VIGENCIA_FIN			DATETIME,	
	@PP_VALOR_TASA_IMPUESTO		DECIMAL(19,4)	
	-- ============================		
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_TASA_IMPUESTO_UPDATE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_TASA_IMPUESTO, @PP_F_VIGENCIA_INICIO, @PP_F_VIGENCIA_FIN,
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN
		
		UPDATE	TASA_IMPUESTO
		SET			
				[K_IMPUESTO]			= @PP_K_IMPUESTO,
				-- ===========================
				[F_VIGENCIA_INICIO]		= @PP_F_VIGENCIA_INICIO,
				[F_VIGENCIA_FIN]		= @PP_F_VIGENCIA_FIN,
				[VALOR_TASA_IMPUESTO]	= @PP_VALOR_TASA_IMPUESTO,
				-- ===========================
			    [F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	K_TASA_IMPUESTO=@PP_K_TASA_IMPUESTO

		-- //////////////////////////////////////////////////////////////

		EXECUTE [dbo].[PG_UP_PRECIO_PRECIO_IVA_PRECIO_CON_IVA]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																	@PP_K_TASA_IMPUESTO, @PP_VALOR_TASA_IMPUESTO

		-- //////////////////////////////////////////////////////////////
		END
		--SELECT * FROM PRECIO WHERE K_TASA_IMPUESTO=101
	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Actualizar] la [TASA_IMPUESTO]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Tas.'+CONVERT(VARCHAR(10),@PP_K_TASA_IMPUESTO)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_TASA_IMPUESTO AS CLAVE

	-- //////////////////////////////////////////////////////////////
	
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_TASA_IMPUESTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_TASA_IMPUESTO]
GO


CREATE PROCEDURE [dbo].[PG_DL_TASA_IMPUESTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_TASA_IMPUESTO			INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_TASA_IMPUESTO_DELETE]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_TASA_IMPUESTO, 
														@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR

	IF @VP_MENSAJE=''
		BEGIN

		UPDATE	TASA_IMPUESTO
		SET		
				[L_BORRADO]				= 1,
				-- ====================
				[F_BAJA]				= GETDATE(), 
				[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
		WHERE	K_TASA_IMPUESTO=@PP_K_TASA_IMPUESTO
	
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Borrar] la [TASA_IMPUESTO]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Tas.'+CONVERT(VARCHAR(10),@PP_K_TASA_IMPUESTO)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_TASA_IMPUESTO AS CLAVE

	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
