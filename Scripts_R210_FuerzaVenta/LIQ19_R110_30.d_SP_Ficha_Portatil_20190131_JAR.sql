-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R100_01.d_SP_FICHA_PORTATIL
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			FICHA_PORTATIL 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_FICHA_PORTATIL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_FICHA_PORTATIL]
GO

-- EXEC [dbo].[PG_LI_FICHA_PORTATIL] 0,0,0,''

CREATE PROCEDURE [dbo].[PG_LI_FICHA_PORTATIL]
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
			FICHA_PORTATIL.*,
			---- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	FICHA_PORTATIL, USUARIO
			-- ==============================
	WHERE	FICHA_PORTATIL.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
			-- ==============================
	AND		(	MATRICULA				LIKE '%'+@PP_BUSCAR+'%' 
			OR	K_MARCA					LIKE '%'+@PP_BUSCAR+'%'
			OR	MODELO					LIKE '%'+@PP_BUSCAR+'%' 
			OR	FICHA_PORTATIL.K_FICHA_PORTATIL=@VP_K_FOLIO	)	
			-- ==============================
	ORDER BY MATRICULA ASC

	-- ////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_FICHA_PORTATIL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_FICHA_PORTATIL]
GO

-- EXEC [dbo].[PG_SK_FICHA_PORTATIL] 0,0,0,41

CREATE PROCEDURE [dbo].[PG_SK_FICHA_PORTATIL]
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
			FICHA_PORTATIL.*,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	FICHA_PORTATIL, USUARIO, PUNTO_VENTA
			-- ==============================
	WHERE	FICHA_PORTATIL.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
	AND		FICHA_PORTATIL.K_PUNTO_VENTA=PUNTO_VENTA.K_PUNTO_VENTA
			-- ==============================
	AND		PUNTO_VENTA.L_BORRADO=0
	AND		FICHA_PORTATIL.K_PUNTO_VENTA=@PP_K_PUNTO_VENTA

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	-- // NO ES REQUERIDA LA SECCION #3

	-- ////////////////////////////////////////////////
GO


	
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_FICHA_PORTATIL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_FICHA_PORTATIL]
GO

-- EXEC [dbo].[PG_IN_FICHA_PORTATIL] 0,0,0,53,'ABC123','CHEVROLET','2018',2000,'CHGBDYT156218',4000

CREATE PROCEDURE [dbo].[PG_IN_FICHA_PORTATIL]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================			
	@PP_K_PUNTO_VENTA			INT,
	-- ============================	
	@PP_K_MARCA 				INT,	
	-- ============================		
	@PP_MATRICULA				VARCHAR(100),
	@PP_MODELO					VARCHAR(100),
	@PP_KILOMETRAJE				DECIMAL(19,4),
	@PP_SERIE					VARCHAR(100),
	@PP_CAPACIDAD				INT
	-- ============================		
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''
	
	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	
	
	DECLARE @VP_K_FICHA_PORTATIL	INT = 0
	DECLARE @VP_O_FICHA_PORTATIL	INT = 0
	
	IF @VP_MENSAJE=''	
		EXECUTE [dbo].[PG_RN_FICHA_PORTATIL_INSERT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												--	@VP_K_FICHA_PORTATIL, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN

		EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, 
													'FICHA_PORTATIL', 
													@OU_K_TABLA_DISPONIBLE = @VP_K_FICHA_PORTATIL	OUTPUT
		-- ====================================

		INSERT INTO FICHA_PORTATIL
			( [K_FICHA_PORTATIL],
			-- ===========================
			[K_PUNTO_VENTA],
			-- ===========================
			[K_MARCA],
			-- ===========================
			[MATRICULA], [MODELO],
			[KILOMETRAJE], [SERIE],
			[CAPACIDAD],
			-- ===========================
			[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
			[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA] )
		VALUES
			( @VP_K_FICHA_PORTATIL,
				-- ===========================
				@PP_K_PUNTO_VENTA,
				-- ===========================
				@PP_K_MARCA,
				-- ===========================
				@PP_MATRICULA, @PP_MODELO,
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
		
		SET		@VP_MENSAJE = 'No es posible [Crear] el [FICHA_PORTATIL]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@VP_K_FICHA_PORTATIL)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
	
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_FICHA_PORTATIL AS CLAVE

	-- //////////////////////////////////////////////////////////////

GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ACTUALIZAR / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_FICHA_PORTATIL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_FICHA_PORTATIL]
GO

-- EXEC [dbo].[PG_UP_FICHA_PORTATIL] 0,2005,0,'N/D',204,1995,2099804.0000, '1GO17H1P45J520018',12500
CREATE PROCEDURE [dbo].[PG_UP_FICHA_PORTATIL]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================		
	@PP_K_PUNTO_VENTA			INT,
	-- ============================		
	@PP_K_MARCA 				INT,
	-- ============================		
	@PP_MATRICULA				VARCHAR(100),
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
	--	EXECUTE [dbo].[PG_RN_FICHA_PORTATIL_UPDATE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
	--													@VP_K_FICHA_PORTATIL, 
	--													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN
		-- ===========================
		UPDATE	FICHA_PORTATIL
		SET			
				[K_PUNTO_VENTA]			= @PP_K_PUNTO_VENTA, 
				-- ===========================
				[K_MARCA]					= @PP_K_MARCA,
				-- ===========================
				[MATRICULA]				= @PP_MATRICULA,
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
		
		SET		@VP_MENSAJE = 'No es posible [Actualizar] el [FICHA_PORTATIL]: ' + @VP_MENSAJE 
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
