-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R100_01.d_SP_DETALLE_AUTOTANQUE
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			DETALLE_AUTOTANQUE 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_DETALLE_AUTOTANQUE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_AUTOTANQUE]
GO

-- EXEC [dbo].[PG_LI_DETALLE_AUTOTANQUE] 0,0,0,''

CREATE PROCEDURE [dbo].[PG_LI_DETALLE_AUTOTANQUE]
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
			DETALLE_AUTOTANQUE.*,
			---- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	DETALLE_AUTOTANQUE, USUARIO
			-- ==============================
	WHERE	DETALLE_AUTOTANQUE.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
			-- ==============================
	AND		(	LECTURA_INICIAL				LIKE '%'+@PP_BUSCAR+'%' 
			OR	LECTURA_FINAL					LIKE '%'+@PP_BUSCAR+'%'
			OR	MATRICULA					LIKE '%'+@PP_BUSCAR+'%' 
			OR	DETALLE_AUTOTANQUE.K_DETALLE_AUTOTANQUE=@VP_K_FOLIO	)	
			-- ==============================
	ORDER BY MATRICULA ASC

	-- ////////////////////////////////////////////////
GO
	
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_DETALLE_AUTOTANQUE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_DETALLE_AUTOTANQUE]
GO

-- EXEC [dbo].[PG_IN_DETALLE_AUTOTANQUE] 0,0,0,'TEST POS','TEST', '', 0, 1, 1,'JUAREZ', 0, 1000, '', 'TEST123', 'FORD', '2019', 0.0000, 'AFHSYTD1876', 8000, '90', 'LITROMETRO', 'GASPAR G4S'

CREATE PROCEDURE [dbo].[PG_IN_DETALLE_AUTOTANQUE]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================			
	@PP_K_PUNTO_VENTA			INT,
	-- ============================		
	@PP_LECTURA_INICIAL			INT,
	@PP_LECTURA_FINAL			INT,
	@PP_MATRICULA				VARCHAR(100),
	@PP_MARCA 					VARCHAR(100),
	@PP_MODELO					VARCHAR(100),
	@PP_KILOMETRAJE				DECIMAL(19,4),
	@PP_SERIE					VARCHAR(100),
	@PP_CAPACIDAD				INT,
	@PP_PORCENTAJE				VARCHAR(100),
	@PP_MEDIDOR					VARCHAR(100),
	@PP_TIPO_MEDIDOR			VARCHAR(100)
	-- ============================		
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''
	
	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	
	
	DECLARE @VP_K_DETALLE_AUTOTANQUE	INT = 0
	DECLARE @VP_O_DETALLE_AUTOTANQUE	INT = 0
	
	IF @VP_MENSAJE=''	
		EXECUTE [dbo].[PG_RN_DETALLE_AUTOTANQUE_INSERT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												--	@VP_K_DETALLE_AUTOTANQUE, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN

		EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, 
													'DETALLE_AUTOTANQUE', 
													@OU_K_TABLA_DISPONIBLE = @VP_K_DETALLE_AUTOTANQUE	OUTPUT
		-- ====================================

		INSERT INTO DETALLE_AUTOTANQUE
				( [K_DETALLE_AUTOTANQUE],
				-- ===========================
				[K_PUNTO_VENTA],
				-- ===========================
				[LECTURA_INICIAL], [LECTURA_FINAL],
				[MATRICULA], [MARCA], [MODELO],
				[KILOMETRAJE], [SERIE],
				[CAPACIDAD], [PORCENTAJE],
				[MEDIDOR], [TIPO_MEDIDOR],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA] )
		VALUES
			( @VP_K_DETALLE_AUTOTANQUE,
				-- ===========================
				@PP_K_PUNTO_VENTA,
				-- ===========================
				@PP_LECTURA_INICIAL, @PP_LECTURA_FINAL,
				@PP_MATRICULA, @PP_MARCA, @PP_MODELO,
				@PP_KILOMETRAJE, @PP_SERIE,
				@PP_CAPACIDAD, @PP_PORCENTAJE,
				@PP_MEDIDOR, @PP_TIPO_MEDIDOR,
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )

		END

		-- ====================================

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Crear] el [DETALLE_AUTOTANQUE]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@VP_K_DETALLE_AUTOTANQUE)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
	
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_DETALLE_AUTOTANQUE AS CLAVE

	-- //////////////////////////////////////////////////////////////

GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ACTUALIZAR / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_DETALLE_AUTOTANQUE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_DETALLE_AUTOTANQUE]
GO

CREATE PROCEDURE [dbo].[PG_UP_DETALLE_AUTOTANQUE]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================			
	@PP_K_DETALLE_AUTOTANQUE	INT,
	@PP_K_PUNTO_VENTA			INT,
	-- ============================		
	@PP_LECTURA_INICIAL			INT,
	@PP_LECTURA_FINAL			INT,
	@PP_MATRICULA				VARCHAR(100),
	@PP_MARCA 					VARCHAR(100),
	@PP_MODELO					VARCHAR(100),
	@PP_KILOMETRAJE				DECIMAL(19,4),
	@PP_SERIE					VARCHAR(100),
	@PP_CAPACIDAD				INT,
	@PP_PORCENTAJE				VARCHAR(100),
	@PP_MEDIDOR					VARCHAR(100),
	@PP_TIPO_MEDIDOR			VARCHAR(100)
	-- ============================		
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_DETALLE_AUTOTANQUE_UPDATE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_DETALLE_AUTOTANQUE,
														@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN
		-- ===========================
		UPDATE	DETALLE_AUTOTANQUE
		SET			
				[K_PUNTO_VENTA]			= @PP_K_PUNTO_VENTA, 
				-- ===========================
				[LECTURA_INICIAL]		= @PP_LECTURA_INICIAL,
				[LECTURA_FINAL]			= @PP_LECTURA_FINAL,
				[MATRICULA]				= @PP_MATRICULA,
				[MARCA]					= @PP_MARCA,
				[MODELO]				= @PP_MODELO,
				[KILOMETRAJE]			= @PP_KILOMETRAJE,
				[SERIE]					= @PP_SERIE,
				[CAPACIDAD]				= @PP_CAPACIDAD,
				[PORCENTAJE]			= @PP_PORCENTAJE,
				[MEDIDOR]				= @PP_MEDIDOR,
				[TIPO_MEDIDOR]			= @PP_TIPO_MEDIDOR,
				-- ===========================
			    [F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	K_DETALLE_AUTOTANQUE=@PP_K_DETALLE_AUTOTANQUE

		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Actualizar] el [DETALLE_AUTOTANQUE]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@PP_K_PUNTO_VENTA)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_DETALLE_AUTOTANQUE AS CLAVE

	-- //////////////////////////////////////////////////////////////
	
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
