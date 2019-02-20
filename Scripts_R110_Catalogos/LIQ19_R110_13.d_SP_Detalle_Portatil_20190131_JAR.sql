-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R100_01.d_SP_DETALLE_PORTATIL
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			DETALLE_PORTATIL 
-- // OPERACION:		LIBERACION / STORED PROCEDURES 
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		JESUS ARCINIEGA
-- // FECHA:		29/ENE/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_DETALLE_PORTATIL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_DETALLE_PORTATIL]
GO

-- EXEC [dbo].[PG_LI_DETALLE_PORTATIL] 0,0,0,''

CREATE PROCEDURE [dbo].[PG_LI_DETALLE_PORTATIL]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_BUSCAR						VARCHAR(255)
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
			DETALLE_PORTATIL.*,
			---- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	DETALLE_PORTATIL, USUARIO
			-- ==============================
	WHERE	DETALLE_PORTATIL.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
			-- ==============================
	AND		(	MATRICULA				LIKE '%'+@PP_BUSCAR+'%' 
			OR	MARCA					LIKE '%'+@PP_BUSCAR+'%'
			OR	MODELO					LIKE '%'+@PP_BUSCAR+'%' 
			OR	DETALLE_PORTATIL.K_DETALLE_PORTATIL=@VP_K_FOLIO	)	
			-- ==============================
	ORDER BY MATRICULA ASC

	-- ////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_DETALLE_PORTATIL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_DETALLE_PORTATIL]
GO

-- EXEC [dbo].[PG_SK_DETALLE_PORTATIL] 0,0,0,41

CREATE PROCEDURE [dbo].[PG_SK_DETALLE_PORTATIL]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_PUNTO_VENTA			INT
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
			PUNTO_VENTA.*,
			-- ==============================
			DETALLE_PORTATIL.*,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	DETALLE_PORTATIL, USUARIO, PUNTO_VENTA
			-- ==============================
	WHERE	DETALLE_PORTATIL.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
	AND		DETALLE_PORTATIL.K_PUNTO_VENTA=PUNTO_VENTA.K_PUNTO_VENTA
			-- ==============================
	AND		PUNTO_VENTA.L_BORRADO=0
	AND		DETALLE_PORTATIL.K_PUNTO_VENTA=@PP_K_PUNTO_VENTA

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	-- // NO ES REQUERIDA LA SECCION #3

	-- ////////////////////////////////////////////////
GO


	
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_DETALLE_PORTATIL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_DETALLE_PORTATIL]
GO

-- EXEC [dbo].[PG_IN_DETALLE_PORTATIL] 0,0,0,53,'ABC123','CHEVROLET','2018',2000,'CHGBDYT156218',4000

CREATE PROCEDURE [dbo].[PG_IN_DETALLE_PORTATIL]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================			
	@PP_K_PUNTO_VENTA			INT,
	-- ============================		
	@PP_MATRICULA				VARCHAR(100),
	@PP_MARCA 					VARCHAR(100),
	@PP_MODELO					VARCHAR(100),
	@PP_KILOMETRAJE				DECIMAL(19,4),
	@PP_SERIE					VARCHAR(100),
	@PP_CAPACIDAD				INT
	-- ============================		
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''
	
	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	
	
	DECLARE @VP_K_DETALLE_PORTATIL	INT = 0
	DECLARE @VP_O_DETALLE_PORTATIL	INT = 0
	
	IF @VP_MENSAJE=''	
		EXECUTE [dbo].[PG_RN_DETALLE_PORTATIL_INSERT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												--	@VP_K_DETALLE_PORTATIL, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN

		EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, 
													'DETALLE_PORTATIL', 
													@OU_K_TABLA_DISPONIBLE = @VP_K_DETALLE_PORTATIL	OUTPUT
		-- ====================================

		INSERT INTO DETALLE_PORTATIL
			( [K_DETALLE_PORTATIL],
			-- ===========================
			[K_PUNTO_VENTA],
			-- ===========================
			[MATRICULA], [MARCA], [MODELO],
			[KILOMETRAJE], [SERIE],
			[CAPACIDAD],
			-- ===========================
			[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
			[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA] )
		VALUES
			( @VP_K_DETALLE_PORTATIL,
				-- ===========================
				@PP_K_PUNTO_VENTA,
				-- ===========================
				@PP_MATRICULA, @PP_MARCA, @PP_MODELO,
				@PP_KILOMETRAJE, @PP_SERIE,
				@PP_CAPACIDAD,
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )

		END

		-- ====================================

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Crear] el [DETALLE_PORTATIL]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@VP_K_DETALLE_PORTATIL)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
	
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_DETALLE_PORTATIL AS CLAVE

	-- //////////////////////////////////////////////////////////////

GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ACTUALIZAR / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_DETALLE_PORTATIL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_DETALLE_PORTATIL]
GO

CREATE PROCEDURE [dbo].[PG_UP_DETALLE_PORTATIL]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================		
	@PP_K_PUNTO_VENTA			INT,
	-- ============================		
	@PP_MATRICULA				VARCHAR(100),
	@PP_MARCA 					VARCHAR(100),
	@PP_MODELO					VARCHAR(100),
	@PP_KILOMETRAJE				DECIMAL(19,4),
	@PP_SERIE					VARCHAR(100),
	@PP_CAPACIDAD				INT
	-- ============================		
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	--IF @VP_MENSAJE=''
	--	EXECUTE [dbo].[PG_RN_DETALLE_PORTATIL_UPDATE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
	--													@VP_K_DETALLE_PORTATIL, 
	--													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN
		-- ===========================
		UPDATE	DETALLE_PORTATIL
		SET			
				[K_PUNTO_VENTA]			= @PP_K_PUNTO_VENTA, 
				-- ===========================
				[MATRICULA]				= @PP_MATRICULA,
				[MARCA]					= @PP_MARCA,
				[MODELO]				= @PP_MODELO,
				[KILOMETRAJE]			= @PP_KILOMETRAJE,
				[SERIE]					= @PP_SERIE,
				[CAPACIDAD]				= @PP_CAPACIDAD,
				-- ===========================
			    [F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	K_PUNTO_VENTA=@PP_K_PUNTO_VENTA

		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Actualizar] el [DETALLE_PORTATIL]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@PP_K_PUNTO_VENTA)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_PUNTO_VENTA AS CLAVE

	-- //////////////////////////////////////////////////////////////
	
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
