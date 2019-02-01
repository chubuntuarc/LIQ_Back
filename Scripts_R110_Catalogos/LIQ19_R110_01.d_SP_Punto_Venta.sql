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

-- EXEC [dbo].[PG_LI_PUNTO_VENTA] 0,0,0,'',-1,-1,''

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
	@PP_SUCURSAL					VARCHAR(100)
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
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	PUNTO_VENTA, USUARIO, 
			ESTATUS_PUNTO_VENTA, TIPO_PUNTO_VENTA
			-- ==============================
	WHERE	PUNTO_VENTA.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
	AND		PUNTO_VENTA.K_ESTATUS_PUNTO_VENTA=ESTATUS_PUNTO_VENTA.K_ESTATUS_PUNTO_VENTA
	AND		PUNTO_VENTA.K_TIPO_PUNTO_VENTA=TIPO_PUNTO_VENTA.K_TIPO_PUNTO_VENTA
			-- ==============================
	AND		(	D_PUNTO_VENTA					LIKE '%'+@PP_BUSCAR+'%' 
			OR	S_PUNTO_VENTA					LIKE '%'+@PP_BUSCAR+'%'
			OR	D_ESTATUS_PUNTO_VENTA			LIKE '%'+@PP_BUSCAR+'%' 
			OR	D_TIPO_PUNTO_VENTA				LIKE '%'+@PP_BUSCAR+'%' 
			OR	PUNTO_VENTA.K_PUNTO_VENTA=@VP_K_FOLIO	)	
			-- ==============================
	AND		(	@PP_K_ESTATUS_PUNTO_VENTA=-1	OR  PUNTO_VENTA.K_ESTATUS_PUNTO_VENTA=@PP_K_ESTATUS_PUNTO_VENTA )
	AND		(	@PP_K_TIPO_PUNTO_VENTA=-1		OR  PUNTO_VENTA.K_TIPO_PUNTO_VENTA=@PP_K_TIPO_PUNTO_VENTA )
	AND		(	PUNTO_VENTA.L_BORRADO=0		OR	@VP_L_VER_BORRADOS=1	)
			-- ==============================
	ORDER BY D_PUNTO_VENTA ASC

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
			D_ESTATUS_PUNTO_VENTA, D_TIPO_PUNTO_VENTA,
			S_ESTATUS_PUNTO_VENTA, S_TIPO_PUNTO_VENTA,
			-- ==============================
			DETALLE_PUNTO_VENTA.LECTURA_INICIAL, DETALLE_PUNTO_VENTA.LECTURA_FINAL,
			DETALLE_PUNTO_VENTA.DIRECCION, DETALLE_PUNTO_VENTA.MATRICULA,
			DETALLE_PUNTO_VENTA.MARCA, DETALLE_PUNTO_VENTA.MODELO,
			DETALLE_PUNTO_VENTA.KILOMETRAJE, DETALLE_PUNTO_VENTA.SERIE,
			DETALLE_PUNTO_VENTA.CAPACIDAD, DETALLE_PUNTO_VENTA.PORCENTAJE,
			DETALLE_PUNTO_VENTA.MEDIDOR, DETALLE_PUNTO_VENTA.TIPO_MEDIDOR,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	PUNTO_VENTA, USUARIO, 
			ESTATUS_PUNTO_VENTA, TIPO_PUNTO_VENTA,
			DETALLE_PUNTO_VENTA
			-- ==============================
	WHERE	PUNTO_VENTA.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
	AND		PUNTO_VENTA.K_ESTATUS_PUNTO_VENTA=ESTATUS_PUNTO_VENTA.K_ESTATUS_PUNTO_VENTA
	AND		PUNTO_VENTA.K_TIPO_PUNTO_VENTA=TIPO_PUNTO_VENTA.K_TIPO_PUNTO_VENTA
	AND		PUNTO_VENTA.K_PUNTO_VENTA=DETALLE_PUNTO_VENTA.K_PUNTO_VENTA
			-- ==============================
	AND		PUNTO_VENTA.L_BORRADO=0
	AND		PUNTO_VENTA.K_PUNTO_VENTA=@PP_K_PUNTO_VENTA

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	-- // NO ES REQUERIDA LA SECCION #3

	-- ////////////////////////////////////////////////
GO



	
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_PUNTO_VENTA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_PUNTO_VENTA]
GO

-- EXEC [dbo].[PG_IN_PUNTO_VENTA] 0,0,0,'TEST POS','TEST', '', 0, 1, 1,'JUAREZ', 0, 1000, '', 'TEST123', 'FORD', '2019', 0.0000, 'AFHSYTD1876', 8000, '90', 'LITROMETRO', 'GASPAR G4S'

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
	-- ===========================	
	@PP_SUCURSAL				VARCHAR(100),
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
	
	DECLARE @VP_K_PUNTO_VENTA	INT = 0
	DECLARE @VP_K_DETALLE_PUNTO_VENTA	INT = 0
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
			(	[K_PUNTO_VENTA],
				[D_PUNTO_VENTA], [S_PUNTO_VENTA], [C_PUNTO_VENTA], [O_PUNTO_VENTA],
				-- ===========================
				[K_ESTATUS_PUNTO_VENTA], [K_TIPO_PUNTO_VENTA],
				-- ===========================
				[SUCURSAL],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES	
			(	@VP_K_PUNTO_VENTA,
				@PP_D_PUNTO_VENTA, @PP_S_PUNTO_VENTA, @PP_C_PUNTO_VENTA, @PP_O_PUNTO_VENTA,
				-- ===========================
				@PP_K_ESTATUS_PUNTO_VENTA, @PP_K_TIPO_PUNTO_VENTA,
				-- ===========================
				@PP_SUCURSAL, 
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )

		-- ====================================//INSERTAR DETALLE_PUNTO_VENTA

		EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
													'DETALLE_PUNTO_VENTA', 
													@OU_K_TABLA_DISPONIBLE = @VP_K_DETALLE_PUNTO_VENTA	OUTPUT

		INSERT INTO DETALLE_PUNTO_VENTA
			(	[K_DETALLE_PUNTO_VENTA],
				-- ===========================
				[K_PUNTO_VENTA],
				-- ===========================
				[LECTURA_INICIAL], [LECTURA_FINAL],
				[DIRECCION], [MATRICULA],
				[MARCA], [MODELO],
				[KILOMETRAJE], [SERIE],
				[CAPACIDAD], [PORCENTAJE],
				[MEDIDOR], [TIPO_MEDIDOR],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES	
			(	@VP_K_DETALLE_PUNTO_VENTA,
				-- ===========================
				@VP_K_PUNTO_VENTA,
				-- ===========================
				@PP_LECTURA_INICIAL, @PP_LECTURA_FINAL,
				@PP_DIRECCION, @PP_MATRICULA, 
				@PP_MARCA, @PP_MODELO,
				@PP_KILOMETRAJE, @PP_SERIE,
				@PP_CAPACIDAD, @PP_PORCENTAJE,
				@PP_MEDIDOR, @PP_TIPO_MEDIDOR, 
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
	
	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_PUNTO_VENTA AS CLAVE

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
	@PP_K_PUNTO_VENTA				INT,
	@PP_D_PUNTO_VENTA				VARCHAR(100),
	@PP_S_PUNTO_VENTA				VARCHAR(10),
	@PP_C_PUNTO_VENTA				VARCHAR(255),
	@PP_O_PUNTO_VENTA				INT,
	-- ===========================			
	@PP_K_ESTATUS_PUNTO_VENTA		INT,
	@PP_K_TIPO_PUNTO_VENTA			INT,
	-- ===========================	
	@PP_SUCURSAL				VARCHAR(100),
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
				[SUCURSAL]				= @PP_SUCURSAL,
				-- ===========================
			    [F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	K_PUNTO_VENTA=@PP_K_PUNTO_VENTA

		-- ===========================
		UPDATE	DETALLE_PUNTO_VENTA
		SET			
				[LECTURA_INICIAL]		= @PP_LECTURA_INICIAL,
				[LECTURA_FINAL]			= @PP_LECTURA_FINAL,
				[DIRECCION]				= @PP_DIRECCION,
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
