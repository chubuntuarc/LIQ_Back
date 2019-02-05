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

-- EXEC [dbo].[PG_LI_PUNTO_VENTA] 0,0,0,'',-1,-1,-1

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
			PUNTO_VENTA.*,
			-- ==============================
			D_ESTATUS_PUNTO_VENTA, D_TIPO_PUNTO_VENTA,
			S_ESTATUS_PUNTO_VENTA, S_TIPO_PUNTO_VENTA,
			-- ==============================
			UNIDAD_OPERATIVA.D_UNIDAD_OPERATIVA,
			-- ==============================
			AUT.LECTURA_INICIAL,	AUT.LECTURA_FINAL,
			AUT.MATRICULA,			AUT.MARCA,			AUT.MODELO,
			AUT.KILOMETRAJE,		AUT.SERIE,
			AUT.CAPACIDAD,			AUT.PORCENTAJE,
			AUT.MEDIDOR,			AUT.TIPO_MEDIDOR,
			-- ==============================
			EST.LECTURA_INICIAL,	EST.LECTURA_FINAL,
			EST.DIRECCION,			EST.CAPACIDAD,		EST.PORCENTAJE,
			EST.MEDIDOR,			EST.TIPO_MEDIDOR,
			-- ==============================
			POR.MATRICULA,			POR.MARCA,			POR.MODELO,
			POR.KILOMETRAJE,		POR.SERIE,			POR.CAPACIDAD,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	PUNTO_VENTA
	LEFT JOIN UNIDAD_OPERATIVA
			ON UNIDAD_OPERATIVA.K_UNIDAD_OPERATIVA = PUNTO_VENTA.K_UNIDAD_OPERATIVA
	LEFT JOIN DETALLE_AUTOTANQUE AS AUT
			ON AUT.K_PUNTO_VENTA = PUNTO_VENTA.K_PUNTO_VENTA	
	LEFT JOIN DETALLE_ESTACION_CARBURACION AS EST
			ON EST.K_PUNTO_VENTA = PUNTO_VENTA.K_PUNTO_VENTA	
	LEFT JOIN DETALLE_PORTATIL AS POR
			ON POR.K_PUNTO_VENTA = PUNTO_VENTA.K_PUNTO_VENTA	
	LEFT JOIN ESTATUS_PUNTO_VENTA
			ON ESTATUS_PUNTO_VENTA.K_ESTATUS_PUNTO_VENTA = PUNTO_VENTA.K_ESTATUS_PUNTO_VENTA
	LEFT JOIN TIPO_PUNTO_VENTA
			ON TIPO_PUNTO_VENTA.K_TIPO_PUNTO_VENTA = PUNTO_VENTA.K_TIPO_PUNTO_VENTA
	JOIN	USUARIO
			ON USUARIO.K_USUARIO = PUNTO_VENTA.K_USUARIO_CAMBIO
			-- ==============================
	WHERE	PUNTO_VENTA.D_PUNTO_VENTA			LIKE '%'+@PP_BUSCAR+'%' 
	AND		(	PUNTO_VENTA.S_PUNTO_VENTA		LIKE '%'+@PP_BUSCAR+'%'
			OR	D_ESTATUS_PUNTO_VENTA			LIKE '%'+@PP_BUSCAR+'%' 
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

-- EXEC [dbo].[PG_SK_PUNTO_VENTA] 0,0,0,9

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
	
	DECLARE @VP_LI_N_REGISTROS INT = 10

	IF @VP_MENSAJE<>''
		SET @VP_LI_N_REGISTROS = 0
	
	SELECT  @VP_K_TIPO_PUNTO_VENTA = PUNTO_VENTA.K_TIPO_PUNTO_VENTA
			FROM	PUNTO_VENTA
			WHERE	PUNTO_VENTA.K_PUNTO_VENTA=@PP_K_PUNTO_VENTA

			-- ===========================

			IF @VP_K_TIPO_PUNTO_VENTA = 1
				EXECUTE [dbo].[PG_SK_DETALLE_AUTOTANQUE]			@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION, @PP_K_PUNTO_VENTA
			-- ===========================
			IF @VP_K_TIPO_PUNTO_VENTA = 2
				EXECUTE [dbo].[PG_SK_DETALLE_ESTACION_CARBURACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION, @PP_K_PUNTO_VENTA
			-- ===========================
			IF @VP_K_TIPO_PUNTO_VENTA = 3
				EXECUTE [dbo].[PG_SK_DETALLE_PORTATIL]				@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION, @PP_K_PUNTO_VENTA

	
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

--EXEC [dbo].[PG_IN_PUNTO_PUNTO_VENTA] 0,0,0,'Test tat','tat','',0,1,1,3
--,1000,2000,'','FORD','2006',150.0000,'ABCDER1345627',2000,'90','LITROMETRO','GASPAR G4S'
--,0,0,'','','','',''
--,'','','','','',0

CREATE PROCEDURE [dbo].[PG_IN_PUNTO_VENTA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================			
	@PP_D_PUNTO_VENTA			VARCHAR(100),
	@PP_S_PUNTO_VENTA			VARCHAR(10),
	@PP_C_PUNTO_VENTA			VARCHAR(255),
	@PP_O_PUNTO_VENTA			INT,
	-- ===========================			
	@PP_K_ESTATUS_PUNTO_VENTA	INT,
	@PP_K_TIPO_PUNTO_VENTA		INT,
	@PP_K_UNIDAD_OPERATIVA		INT,
	-- ===========================	
	@PP_LECTURA_INICIAL_AUT		INT,
	@PP_LECTURA_FINAL_AUT		INT,
	@PP_MATRICULA_AUT			VARCHAR(100),
	@PP_MARCA_AUT				VARCHAR(100),
	@PP_MODELO_AUT				VARCHAR(100),
	@PP_KILOMETRAJE_AUT			DECIMAL(19,4),
	@PP_SERIE_AUT				VARCHAR(100),
	@PP_CAPACIDAD_AUT			INT,
	@PP_PORCENTAJE_AUT			VARCHAR(100),
	@PP_MEDIDOR_AUT				VARCHAR(100),
	@PP_TIPO_MEDIDOR_AUT		VARCHAR(100),
	-- ===========================	
	@PP_LECTURA_INICIAL_EST		INT,
	@PP_LECTURA_FINAL_EST		INT,
	@PP_DIRECCION_EST			VARCHAR(100),
	@PP_CAPACIDAD_EST			VARCHAR(100),
	@PP_PORCENTAJE_EST			VARCHAR(100),
	@PP_MEDIDOR_EST				VARCHAR(100),
	@PP_TIPO_MEDIDOR_EST		VARCHAR(100),
	-- ===========================	
	@PP_MATRICULA_POR			VARCHAR(100),
	@PP_MARCA_POR				VARCHAR(100),
	@PP_MODELO_POR				VARCHAR(100),
	@PP_KILOMETRAJE_POR			VARCHAR(100),
	@PP_SERIE_POR				VARCHAR(100),
	@PP_CAPACIDAD_POR			INT
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
			( [K_PUNTO_VENTA],
			[D_PUNTO_VENTA], [S_PUNTO_VENTA], [C_PUNTO_VENTA], [O_PUNTO_VENTA],
			-- ===========================
			[K_ESTATUS_PUNTO_VENTA], [K_TIPO_PUNTO_VENTA], [K_UNIDAD_OPERATIVA],
			-- ===========================
			[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
			[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA] )
	VALUES
			( @VP_K_PUNTO_VENTA,
			@PP_D_PUNTO_VENTA, @PP_S_PUNTO_VENTA, @PP_C_PUNTO_VENTA, @PP_O_PUNTO_VENTA,
			-- ===========================
			@PP_K_ESTATUS_PUNTO_VENTA, @PP_K_TIPO_PUNTO_VENTA, @PP_K_UNIDAD_OPERATIVA,
			-- ===========================
			@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
			0, NULL, NULL )

	-- ====================================

	IF @PP_K_TIPO_PUNTO_VENTA=1
		EXECUTE [dbo].[PG_IN_DETALLE_AUTOTANQUE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION, @VP_K_PUNTO_VENTA,
													@PP_LECTURA_INICIAL_AUT, @PP_LECTURA_FINAL_AUT, @PP_MATRICULA_AUT, 
													@PP_MARCA_AUT, @PP_MODELO_AUT, @PP_KILOMETRAJE_AUT, @PP_SERIE_AUT,
													@PP_CAPACIDAD_AUT, @PP_PORCENTAJE_AUT, @PP_MEDIDOR_AUT, @PP_TIPO_MEDIDOR_AUT	
													
	-- ====================================			
	
	IF @PP_K_TIPO_PUNTO_VENTA=2
		EXECUTE [dbo].[PG_IN_DETALLE_ESTACION_CARBURACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION, @VP_K_PUNTO_VENTA,
															@PP_LECTURA_INICIAL_EST, @PP_LECTURA_FINAL_EST, @PP_DIRECCION_EST,
															@PP_CAPACIDAD_EST, @PP_PORCENTAJE_EST, @PP_MEDIDOR_EST, @PP_TIPO_MEDIDOR_EST	
															
	-- ====================================			
	
	IF @PP_K_TIPO_PUNTO_VENTA=3
		EXECUTE [dbo].[PG_IN_DETALLE_PORTATIL]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION, @VP_K_PUNTO_VENTA,
													@PP_MATRICULA_POR, @PP_MARCA_POR, @PP_MODELO_POR, @PP_KILOMETRAJE_POR,
													@PP_SERIE_POR, @PP_CAPACIDAD_POR

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA

	IF @VP_MENSAJE<>''
		BEGIN

		SET		@VP_MENSAJE = 'No es posible [Crear] el [PUNTO_VENTA]: ' + @VP_MENSAJE
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@VP_K_PUNTO_VENTA)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

	END

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
	@PP_S_PUNTO_VENTA			VARCHAR(10),
	@PP_C_PUNTO_VENTA			VARCHAR(255),
	@PP_O_PUNTO_VENTA			INT,
	-- ===========================			
	@PP_K_ESTATUS_PUNTO_VENTA	INT,
	@PP_K_TIPO_PUNTO_VENTA		INT,
	@PP_K_UNIDAD_OPERATIVA		INT,
	-- ============================		
	@PP_LECTURA_INICIAL			INT,
	@PP_LECTURA_FINAL			INT,
	@PP_DIRECCION				VARCHAR(100),
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
				[S_PUNTO_VENTA]			= @PP_S_PUNTO_VENTA, 
				[C_PUNTO_VENTA]			= @PP_C_PUNTO_VENTA, 
				[O_PUNTO_VENTA]			= @PP_O_PUNTO_VENTA,
				-- ===========================
				[K_ESTATUS_PUNTO_VENTA]	= @PP_K_ESTATUS_PUNTO_VENTA,
				[K_TIPO_PUNTO_VENTA]	= @PP_K_TIPO_PUNTO_VENTA,
				-- ===========================
				[K_UNIDAD_OPERATIVA]	= @PP_K_UNIDAD_OPERATIVA,
				-- ===========================
			    [F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	K_PUNTO_VENTA=@PP_K_PUNTO_VENTA
	
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
