-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R100_01.d_SP_Punto_Venta
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			PUNTO_VENTA 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_PUNTO_VENTA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_PUNTO_VENTA]
GO

-- EXEC [dbo].[PG_LI_PUNTO_VENTA] 0,0,0,'',-1,1,-1

CREATE PROCEDURE [dbo].[PG_LI_PUNTO_VENTA]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_BUSCAR						VARCHAR(255),
	-- ===========================
	@PP_K_ESTATUS_PUNTO_VENTA		INT,
	@PP_K_TIPO_PUNTO_VENTA			INT,
	-- ===========================
	@PP_K_UNIDAD_OPERATIVA			INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300)

	SET		@VP_MENSAJE		= ''
	
	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_SELECT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													1, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT	
														  
	-- ///////////////////////////////////////////
		
	DECLARE @VP_L_APLICAR_MAX_ROWS	INT=10
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

	-- ========================================= TABLA TEMPORAL FICHA AUTOTANQUE
	DECLARE @VP_TBL_FICHA_AUTOTANQUE
	TABLE
			(K_FICHA_AUTOTANQUE		INT,
			 K_PUNTO_VENTA			INT,
			 D_MARCA				VARCHAR(100),
			 LECTURA_INICIAL		INT,
			 LECTURA_FINAL			INT,
			 MATRICULA				VARCHAR(100),
			 MODELO					VARCHAR(100),
			 KILOMETRAJE			DECIMAL(19,4),
			 SERIE					VARCHAR(100),
			 CAPACIDAD				INT,
			 PORCENTAJE				VARCHAR(100))

	INSERT INTO @VP_TBL_FICHA_AUTOTANQUE
			(K_FICHA_AUTOTANQUE, K_PUNTO_VENTA, D_MARCA, LECTURA_INICIAL, LECTURA_FINAL, MATRICULA,
			 MODELO, KILOMETRAJE, SERIE, CAPACIDAD, PORCENTAJE)
	SELECT	K_FICHA_AUTOTANQUE  , FICHA_AUTOTANQUE.K_PUNTO_VENTA, D_MARCA_UNIDAD, LECTURA_INICIAL, LECTURA_FINAL, 
			MATRICULA, MODELO, KILOMETRAJE, SERIE, CAPACIDAD, PORCENTAJE
	FROM	FICHA_AUTOTANQUE , PUNTO_VENTA, MARCA_UNIDAD
	WHERE	FICHA_AUTOTANQUE.K_PUNTO_VENTA=PUNTO_VENTA.K_PUNTO_VENTA
	AND		MARCA_UNIDAD.K_MARCA_UNIDAD=FICHA_AUTOTANQUE.K_MARCA
	

	-- ========================================= TABLA TEMPORAL FICHA ESTACION DE CARBURACION
	DECLARE @VP_TBL_FICHA_ESTACION_CARBURACION
	TABLE
			(K_FICHA_ESTACION_CARBURACION		INT,
			 K_PUNTO_VENTA						INT,
			 LECTURA_INICIAL					INT,
			 LECTURA_FINAL						INT,
			 DIRECCION							VARCHAR(100),
			 CAPACIDAD							INT,
			 PORCENTAJE							VARCHAR(100),
			 K_MEDIDOR							INT,
			 K_TIPO_MEDIDOR						INT )

	INSERT INTO @VP_TBL_FICHA_ESTACION_CARBURACION
			(K_FICHA_ESTACION_CARBURACION, K_PUNTO_VENTA, LECTURA_INICIAL, LECTURA_FINAL, DIRECCION,
			 CAPACIDAD, PORCENTAJE, K_MEDIDOR, K_TIPO_MEDIDOR )
	SELECT	K_FICHA_ESTACION_CARBURACION, FICHA_ESTACION_CARBURACION.K_PUNTO_VENTA, LECTURA_INICIAL, LECTURA_FINAL, DIRECCION,
			CAPACIDAD, PORCENTAJE, K_MEDIDOR, K_TIPO_MEDIDOR
	FROM	FICHA_ESTACION_CARBURACION , PUNTO_VENTA
	WHERE	FICHA_ESTACION_CARBURACION.K_PUNTO_VENTA=PUNTO_VENTA.K_PUNTO_VENTA

	-- ========================================= TABLA TEMPORAL FICHA PORTATIL
	DECLARE @VP_TBL_FICHA_PORTATIL
	TABLE
			(K_FICHA_PORTATIL					INT,
			 K_PUNTO_VENTA						INT,
			 K_MARCA							INT,
			 MATRICULA							VARCHAR(100),
			 MODELO								VARCHAR(100),
			 KILOMETRAJE						DECIMAL(19,4),
			 SERIE								VARCHAR(100),
			 CAPACIDAD							INT )

	INSERT INTO @VP_TBL_FICHA_PORTATIL
			(K_FICHA_PORTATIL, K_PUNTO_VENTA, K_MARCA, MATRICULA, MODELO,
			 KILOMETRAJE, SERIE, CAPACIDAD )
	SELECT	K_FICHA_PORTATIL, FICHA_PORTATIL.K_PUNTO_VENTA, K_MARCA, MATRICULA, MODELO,
			KILOMETRAJE, SERIE, CAPACIDAD
	FROM	FICHA_PORTATIL , PUNTO_VENTA
	WHERE	FICHA_PORTATIL.K_PUNTO_VENTA=PUNTO_VENTA.K_PUNTO_VENTA

	-- ////////////////////////////////////////////////

	SELECT	TOP ( @VP_LI_N_REGISTROS )
			PUNTO_VENTA.*,
			-- ==============================
			D_ESTATUS_PUNTO_VENTA, D_TIPO_PUNTO_VENTA,
			S_ESTATUS_PUNTO_VENTA, S_TIPO_PUNTO_VENTA,
			-- ==============================
			AUT.*, EST.*, POR.*,
			-- ==============================
			UNIDAD_OPERATIVA.K_UNIDAD_OPERATIVA,UNIDAD_OPERATIVA.D_UNIDAD_OPERATIVA,
			-- ==============================
			CONCAT(OPERADOR.NOMBRE, ' ' +  OPERADOR.APELLIDO_PATERNO) AS OPERADOR_NOMBRE,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	PUNTO_VENTA
	LEFT JOIN UNIDAD_OPERATIVA
			ON UNIDAD_OPERATIVA.K_UNIDAD_OPERATIVA = PUNTO_VENTA.K_UNIDAD_OPERATIVA	
	LEFT JOIN @VP_TBL_FICHA_AUTOTANQUE AS AUT
			ON AUT.K_PUNTO_VENTA = PUNTO_VENTA.K_PUNTO_VENTA
	LEFT JOIN @VP_TBL_FICHA_ESTACION_CARBURACION AS EST
			ON EST.K_PUNTO_VENTA = PUNTO_VENTA.K_PUNTO_VENTA	
	LEFT JOIN @VP_TBL_FICHA_PORTATIL AS POR
			ON POR.K_PUNTO_VENTA = PUNTO_VENTA.K_PUNTO_VENTA	
	LEFT JOIN ESTATUS_PUNTO_VENTA
			ON ESTATUS_PUNTO_VENTA.K_ESTATUS_PUNTO_VENTA = PUNTO_VENTA.K_ESTATUS_PUNTO_VENTA
	LEFT JOIN TIPO_PUNTO_VENTA
			ON TIPO_PUNTO_VENTA.K_TIPO_PUNTO_VENTA = PUNTO_VENTA.K_TIPO_PUNTO_VENTA
	LEFT JOIN OPERADOR
			ON OPERADOR.K_OPERADOR = PUNTO_VENTA.K_OPERADOR
	JOIN	USUARIO
			ON USUARIO.K_USUARIO = PUNTO_VENTA.K_USUARIO_CAMBIO
			-- ==============================
	WHERE	PUNTO_VENTA.D_PUNTO_VENTA			LIKE '%'+@PP_BUSCAR+'%' 
	AND		(	D_ESTATUS_PUNTO_VENTA			LIKE '%'+@PP_BUSCAR+'%' 
			OR	D_TIPO_PUNTO_VENTA				LIKE '%'+@PP_BUSCAR+'%' 
			OR	PUNTO_VENTA.K_PUNTO_VENTA=@VP_K_FOLIO	)
			-- ==============================
	AND		(	@PP_K_ESTATUS_PUNTO_VENTA=-1	OR  PUNTO_VENTA.K_ESTATUS_PUNTO_VENTA=@PP_K_ESTATUS_PUNTO_VENTA )
	AND		(	@PP_K_TIPO_PUNTO_VENTA=-1		OR  PUNTO_VENTA.K_TIPO_PUNTO_VENTA=@PP_K_TIPO_PUNTO_VENTA )
	AND		(	@PP_K_UNIDAD_OPERATIVA=-1		OR  PUNTO_VENTA.K_UNIDAD_OPERATIVA=@PP_K_UNIDAD_OPERATIVA )
			-- ==============================
	AND		(	PUNTO_VENTA.L_BORRADO=0			OR	@VP_L_VER_BORRADOS=1	)
					-- ==============================
	ORDER BY PUNTO_VENTA.D_PUNTO_VENTA ASC

	-- ////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_PUNTO_VENTA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_PUNTO_VENTA]
GO

-- EXEC [dbo].[PG_SK_PUNTO_VENTA] 0,0,0,51

CREATE PROCEDURE [dbo].[PG_SK_PUNTO_VENTA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_PUNTO_VENTA			INT
AS

	DECLARE @VP_MENSAJE				VARCHAR(300)
	DECLARE @VP_K_TIPO_PUNTO_VENTA	INT
	
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
	
	SELECT  @VP_K_TIPO_PUNTO_VENTA = PUNTO_VENTA.K_TIPO_PUNTO_VENTA
			FROM	PUNTO_VENTA
			WHERE	PUNTO_VENTA.K_PUNTO_VENTA=@PP_K_PUNTO_VENTA
	
	SELECT	TOP ( @VP_LI_N_REGISTROS )
			PUNTO_VENTA.*,
			-- ==============================
			UNIDAD_OPERATIVA.D_UNIDAD_OPERATIVA,
			OPERADOR.D_OPERADOR AS OPERADOR,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	PUNTO_VENTA, USUARIO, UNIDAD_OPERATIVA, OPERADOR
			-- ==============================
	WHERE	PUNTO_VENTA.K_PUNTO_VENTA=@PP_K_PUNTO_VENTA
	AND		UNIDAD_OPERATIVA.K_UNIDAD_OPERATIVA=PUNTO_VENTA.K_UNIDAD_OPERATIVA
	AND		OPERADOR.K_OPERADOR=PUNTO_VENTA.K_OPERADOR
			-- ==============================
	AND		PUNTO_VENTA.L_BORRADO=0

			-- ===========================
	
	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	-- // NO ES REQUERIDA LA SECCION #3

	-- ////////////////////////////////////////////////
GO





-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT *FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_PUNTO_VENTA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_PUNTO_VENTA]
GO

--EXEC [dbo].[PG_IN_PUNTO_VENTA] 0,0,0,'JJ' , 1 , 1 , 2 , 333 , 333 , 333 

CREATE PROCEDURE [dbo].[PG_IN_PUNTO_VENTA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================			
	@PP_D_PUNTO_VENTA			VARCHAR(100),
	-- ===========================			
	@PP_K_ESTATUS_PUNTO_VENTA	INT,
	@PP_K_TIPO_PUNTO_VENTA		INT,
	@PP_K_UNIDAD_OPERATIVA		INT,
	-- ===========================	
	@PP_K_OPERADOR				INT,
	@PP_K_AYUDANTE_1			INT,
	@PP_K_AYUDANTE_2			INT
	-- ===========================	
AS

	DECLARE @VP_MENSAJE		VARCHAR(300)

	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	DECLARE @VP_K_PUNTO_VENTA	INT = 0
	DECLARE @VP_O_PUNTO_VENTA	INT = 0

	IF @VP_MENSAJE=''	
		EXECUTE [dbo].[PG_RN_PUNTO_VENTA_INSERT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													--	@VP_K_PUNTO_VENTA, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR

	IF @VP_MENSAJE=''
		BEGIN

		EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
													'PUNTO_VENTA', 
													@OU_K_TABLA_DISPONIBLE = @VP_K_PUNTO_VENTA	OUTPUT
		-- ====================================

		INSERT INTO PUNTO_VENTA
				( [K_PUNTO_VENTA], [D_PUNTO_VENTA],
				-- ===========================
				[K_ESTATUS_PUNTO_VENTA], [K_TIPO_PUNTO_VENTA], [K_UNIDAD_OPERATIVA],
				-- ===========================
				[K_OPERADOR], [K_AYUDANTE_1], [K_AYUDANTE_2],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA] )
		VALUES
				( @VP_K_PUNTO_VENTA, @PP_D_PUNTO_VENTA,
				-- ===========================
				@PP_K_ESTATUS_PUNTO_VENTA, @PP_K_TIPO_PUNTO_VENTA, @PP_K_UNIDAD_OPERATIVA,
				-- ===========================
				@PP_K_OPERADOR, @PP_K_AYUDANTE_1, @PP_K_AYUDANTE_2,
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA

	IF @VP_MENSAJE<>''
		BEGIN

		SET		@VP_MENSAJE = 'No es posible [Crear] el [PUNTO_VENTA]: ' + @VP_MENSAJE
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@VP_K_PUNTO_VENTA)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END

	SELECT @VP_MENSAJE AS MENSAJE, @VP_K_PUNTO_VENTA AS CLAVE

	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ACTUALIZAR / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_PUNTO_VENTA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_PUNTO_VENTA]
GO

CREATE PROCEDURE [dbo].[PG_UP_PUNTO_VENTA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_PUNTO_VENTA			INT,
	@PP_D_PUNTO_VENTA			VARCHAR(100),
	-- ===========================			
	@PP_K_ESTATUS_PUNTO_VENTA	INT,
	@PP_K_TIPO_PUNTO_VENTA		INT,
	@PP_K_UNIDAD_OPERATIVA		INT,
	-- ===========================	
	@PP_K_OPERADOR				INT,
	@PP_K_AYUDANTE_1			INT,
	@PP_K_AYUDANTE_2			INT
	-- ===========================	
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_PUNTO_VENTA_UPDATE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_PUNTO_VENTA, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN
		-- ===========================
		UPDATE	PUNTO_VENTA
		SET			
				[D_PUNTO_VENTA]			= @PP_D_PUNTO_VENTA, 
				-- ===========================
				[K_ESTATUS_PUNTO_VENTA]	= @PP_K_ESTATUS_PUNTO_VENTA,
				[K_TIPO_PUNTO_VENTA]	= @PP_K_TIPO_PUNTO_VENTA,
				[K_UNIDAD_OPERATIVA]	= @PP_K_UNIDAD_OPERATIVA,
				-- ===========================
				[K_OPERADOR]			= @PP_K_OPERADOR,
				[K_AYUDANTE_1]			= @PP_K_AYUDANTE_1,
				[K_AYUDANTE_2]			= @PP_K_AYUDANTE_2,
				-- ===========================
			    [F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	K_PUNTO_VENTA=@PP_K_PUNTO_VENTA

			-- ====================================
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Actualizar] el [PUNTO_VENTA]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@PP_K_PUNTO_VENTA)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_PUNTO_VENTA AS CLAVE

	-- //////////////////////////////////////////////////////////////
	
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_PUNTO_VENTA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_PUNTO_VENTA]
GO


CREATE PROCEDURE [dbo].[PG_DL_PUNTO_VENTA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_PUNTO_VENTA				INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_PUNTO_VENTA_DELETE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_PUNTO_VENTA, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR

	IF @VP_MENSAJE=''
		BEGIN

		UPDATE	PUNTO_VENTA
		SET		
				[L_BORRADO]				= 1,
				-- ====================
				[F_BAJA]				= GETDATE(), 
				[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
		WHERE	K_PUNTO_VENTA=@PP_K_PUNTO_VENTA
	
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Borrar] el [PUNTO_VENTA]: ' + @VP_MENSAJE 
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
