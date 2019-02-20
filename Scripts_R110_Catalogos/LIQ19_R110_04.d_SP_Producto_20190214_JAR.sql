-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_04.d_SP_PRODUCTO
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			PRODUCTO 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_PRODUCTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_PRODUCTO]
GO


CREATE PROCEDURE [dbo].[PG_LI_PRODUCTO]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_BUSCAR						VARCHAR(255),
	-- ===========================
	@PP_K_ESTATUS_PRODUCTO			INT,
	@PP_K_TIPO_PRODUCTO				INT,
	@PP_K_UNIDAD					INT
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
			PRODUCTO.*,
			-- ==============================
			D_ESTATUS_PRODUCTO, D_TIPO_PRODUCTO, D_UNIDAD,
			S_ESTATUS_PRODUCTO, S_TIPO_PRODUCTO, S_UNIDAD,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	PRODUCTO, USUARIO, 
			ESTATUS_PRODUCTO, TIPO_PRODUCTO, UNIDAD
			-- ==============================
	WHERE	PRODUCTO.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
	AND		PRODUCTO.K_ESTATUS_PRODUCTO=ESTATUS_PRODUCTO.K_ESTATUS_PRODUCTO
	AND		PRODUCTO.K_TIPO_PRODUCTO=TIPO_PRODUCTO.K_TIPO_PRODUCTO
	AND		PRODUCTO.K_UNIDAD=UNIDAD.K_UNIDAD
			-- ==============================
	AND		(	D_PRODUCTO					LIKE '%'+@PP_BUSCAR+'%' 
			OR	S_PRODUCTO					LIKE '%'+@PP_BUSCAR+'%'
			OR	D_ESTATUS_PRODUCTO			LIKE '%'+@PP_BUSCAR+'%' 
			OR	D_TIPO_PRODUCTO				LIKE '%'+@PP_BUSCAR+'%' 
			OR	D_UNIDAD					LIKE '%'+@PP_BUSCAR+'%' 
			OR	PRODUCTO.K_PRODUCTO=@VP_K_FOLIO	)	
			-- ==============================
	AND		(	@PP_K_ESTATUS_PRODUCTO=-1	OR  PRODUCTO.K_ESTATUS_PRODUCTO=@PP_K_ESTATUS_PRODUCTO )
	AND		(	@PP_K_TIPO_PRODUCTO=-1		OR  PRODUCTO.K_TIPO_PRODUCTO=@PP_K_TIPO_PRODUCTO )
	AND		(	@PP_K_UNIDAD=-1				OR  PRODUCTO.K_UNIDAD=@PP_K_UNIDAD )
	AND		(	PRODUCTO.L_BORRADO=0		OR	@VP_L_VER_BORRADOS=1	)
			-- ==============================
	ORDER BY D_PRODUCTO ASC

	-- ////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_PRODUCTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_PRODUCTO]
GO


CREATE PROCEDURE [dbo].[PG_SK_PRODUCTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_PRODUCTO				INT
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
			PRODUCTO.*,
			-- ==============================
			D_ESTATUS_PRODUCTO, D_TIPO_PRODUCTO, D_UNIDAD,
			S_ESTATUS_PRODUCTO, S_TIPO_PRODUCTO, S_UNIDAD,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	PRODUCTO, USUARIO, 
			ESTATUS_PRODUCTO, TIPO_PRODUCTO, UNIDAD
			-- ==============================
	WHERE	PRODUCTO.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
	AND		PRODUCTO.K_ESTATUS_PRODUCTO=ESTATUS_PRODUCTO.K_ESTATUS_PRODUCTO
	AND		PRODUCTO.K_TIPO_PRODUCTO=TIPO_PRODUCTO.K_TIPO_PRODUCTO
	AND		PRODUCTO.K_UNIDAD=UNIDAD.K_UNIDAD
			-- ==============================
	AND		PRODUCTO.L_BORRADO=0
	AND		PRODUCTO.K_PRODUCTO=@PP_K_PRODUCTO

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	-- // NO ES REQUERIDA LA SECCION #3

	-- ////////////////////////////////////////////////
GO



	
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_PRODUCTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_PRODUCTO]
GO


CREATE PROCEDURE [dbo].[PG_IN_PRODUCTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================			
	@PP_D_PRODUCTO				VARCHAR(100),
	@PP_S_PRODUCTO				VARCHAR(10),
	@PP_O_PRODUCTO				INT,
	-- ===========================			
	@PP_K_ESTATUS_PRODUCTO		INT,
	@PP_K_TIPO_PRODUCTO			INT,
	@PP_K_UNIDAD				INT,
	-- ===========================	
	@PP_CANTIDAD				DECIMAL(19,4),	
	@PP_FACTOR_KILOS			DECIMAL(19,4),	
	@PP_FACTOR_LITROS			DECIMAL(19,4),
	@PP_CANTIDAD_KILOS			DECIMAL(19,4),	-- SE MANDARA EL VALOR DESDE EL FRONT?	
	@PP_CANTIDAD_LITROS			DECIMAL(19,4)	-- SE MANDARA EL VALOR DESDE EL FRONT?	
	-- ============================		
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''
	
	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	
	
	DECLARE @VP_K_PRODUCTO	INT = 0
	DECLARE @VP_O_PRODUCTO	INT = 0
	
	IF @VP_MENSAJE=''	
		EXECUTE [dbo].[PG_RN_PRODUCTO_INSERT]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												--	@VP_K_PRODUCTO, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN

		EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
													'PRODUCTO', 
													@OU_K_TABLA_DISPONIBLE = @VP_K_PRODUCTO	OUTPUT
		-- ====================================
		--DECLARE	@VP_CANTIDAD_KILOS		DECIMAL(19,4)		
		--DECLARE	@VP_CANTIDAD_LITROS		DECIMAL(19,4)	

		--SET @VP_CANTIDAD_KILOS	= @PP_CANTIDAD * @PP_FACTOR_KILOS	-- [CANTIDAD_KILOS] = [CANTIDAD] X [FACTOR_KILOS]	
		--SET @VP_CANTIDAD_LITROS = @PP_CANTIDAD * @PP_FACTOR_LITROS	-- [CANTIDAD_LITROS] = [CANTIDAD] X [FACTOR_LITROS]	
		
		-- ====================================
		INSERT INTO PRODUCTO
			(	[K_PRODUCTO],
				[D_PRODUCTO], [S_PRODUCTO], [O_PRODUCTO],
				-- ===========================
				[K_ESTATUS_PRODUCTO], [K_TIPO_PRODUCTO],
				[K_UNIDAD],
				-- ===========================
				[CANTIDAD], [FACTOR_KILOS], [FACTOR_LITROS],
				[CANTIDAD_KILOS], [CANTIDAD_LITROS],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES	
			(	@VP_K_PRODUCTO,
				@PP_D_PRODUCTO, @PP_S_PRODUCTO, @PP_O_PRODUCTO,
				-- ===========================
				@PP_K_ESTATUS_PRODUCTO, @PP_K_TIPO_PRODUCTO,
				@PP_K_UNIDAD,
				-- ===========================
				@PP_CANTIDAD, 
				@PP_FACTOR_KILOS, @PP_FACTOR_LITROS,
				@PP_CANTIDAD_KILOS, @PP_CANTIDAD_LITROS,
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )
		
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Crear] el [PRODUCTO]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PRO.'+CONVERT(VARCHAR(10),@VP_K_PRODUCTO)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
	
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_PRODUCTO AS CLAVE

	-- //////////////////////////////////////////////////////////////

GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ACTUALIZAR / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_PRODUCTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_PRODUCTO]
GO

CREATE PROCEDURE [dbo].[PG_UP_PRODUCTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_PRODUCTO				INT,
	@PP_D_PRODUCTO				VARCHAR(100),
	@PP_S_PRODUCTO				VARCHAR(10),
	@PP_O_PRODUCTO				INT,
	-- ===========================			
	@PP_K_ESTATUS_PRODUCTO		INT,
	@PP_K_TIPO_PRODUCTO			INT,
	@PP_K_UNIDAD				INT,
	-- ===========================	
	@PP_CANTIDAD				DECIMAL(19,4),	
	@PP_FACTOR_KILOS			DECIMAL(19,4),	
	@PP_FACTOR_LITROS			DECIMAL(19,4),
	@PP_CANTIDAD_KILOS			DECIMAL(19,4),	-- SE MANDARA EL VALOR DESDE EL FRONT?
	@PP_CANTIDAD_LITROS			DECIMAL(19,4)	-- SE MANDARA EL VALOR DESDE EL FRONT?
	-- ============================		
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_PRODUCTO_UPDATE]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_PRODUCTO, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN
		-- ===========================
		--DECLARE	@VP_CANTIDAD_KILOS		DECIMAL(19,4)		
		--DECLARE	@VP_CANTIDAD_LITROS		DECIMAL(19,4)	

		--SET @VP_CANTIDAD_KILOS	= @PP_CANTIDAD * @PP_FACTOR_KILOS	-- [CANTIDAD_KILOS] = [CANTIDAD] X [FACTOR_KILOS]	
		--SET @VP_CANTIDAD_LITROS = @PP_CANTIDAD * @PP_FACTOR_LITROS	-- [CANTIDAD_LITROS] = [CANTIDAD] X [FACTOR_LITROS]	
		-- ===========================
		UPDATE	PRODUCTO
		SET			
				[D_PRODUCTO]			= @PP_D_PRODUCTO, 
				[S_PRODUCTO]			= @PP_S_PRODUCTO, 
				[O_PRODUCTO]			= @PP_O_PRODUCTO,
				-- ===========================
				[K_ESTATUS_PRODUCTO]	= @PP_K_ESTATUS_PRODUCTO,
				[K_TIPO_PRODUCTO]		= @PP_K_TIPO_PRODUCTO,
				[K_UNIDAD]				= @PP_K_UNIDAD,
				-- ===========================
				[CANTIDAD]				= @PP_CANTIDAD,
				[FACTOR_KILOS]			= @PP_FACTOR_KILOS,
				[FACTOR_LITROS]			= @PP_FACTOR_LITROS,
				[CANTIDAD_KILOS]		= @PP_CANTIDAD_KILOS,
				[CANTIDAD_LITROS]		= @PP_CANTIDAD_LITROS,
				-- ===========================
			    [F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	K_PRODUCTO=@PP_K_PRODUCTO
	
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Actualizar] el [PRODUCTO]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PRO.'+CONVERT(VARCHAR(10),@PP_K_PRODUCTO)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_PRODUCTO AS CLAVE

	-- //////////////////////////////////////////////////////////////
	
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_PRODUCTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_PRODUCTO]
GO


CREATE PROCEDURE [dbo].[PG_DL_PRODUCTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_PRODUCTO				INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_PRODUCTO_DELETE]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_PRODUCTO, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR

	IF @VP_MENSAJE=''
		BEGIN

		UPDATE	PRODUCTO
		SET		
				[L_BORRADO]				= 1,
				-- ====================
				[F_BAJA]				= GETDATE(), 
				[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
		WHERE	K_PRODUCTO=@PP_K_PRODUCTO
	
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Borrar] el [PRODUCTO]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PRO.'+CONVERT(VARCHAR(10),@PP_K_PRODUCTO)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_PRODUCTO AS CLAVE

	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
