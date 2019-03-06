-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R100_02.d_SP_PRELIQUIDACION
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			PRELIQUIDACION 
-- // OPERACION:		LIBERACION / STORED PROCEDURES 
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		JESUS ARCINIEGA
-- // FECHA:		05/FEB/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_PRELIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_PRELIQUIDACION]
GO

-- EXEC [dbo].[PG_LI_PRELIQUIDACION] 0,0,0,'',-1

CREATE PROCEDURE [dbo].[PG_LI_PRELIQUIDACION]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_BUSCAR						VARCHAR(255),
	-- ===========================
	@PP_K_ESTATUS_PRELIQUIDACION	INT
	-- ===========================
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
			PRELIQUIDACION.*,
			-- ==============================
			D_ESTATUS_PRELIQUIDACION, D_TIPO_PRELIQUIDACION,
			S_ESTATUS_PRELIQUIDACION, S_TIPO_PRELIQUIDACION,
			-- ==============================
			PUNTO_VENTA.D_PUNTO_VENTA, 
			-- ==============================
			CONCAT(OPERADOR.NOMBRE, ' ' + OPERADOR.APATERNO) AS D_OPERADOR,
			-- ==============================
			UNIDAD_OPERATIVA.D_UNIDAD_OPERATIVA,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	PRELIQUIDACION	
	LEFT JOIN ESTATUS_PRELIQUIDACION
			ON ESTATUS_PRELIQUIDACION.K_ESTATUS_PRELIQUIDACION = PRELIQUIDACION.K_ESTATUS_PRELIQUIDACION
	LEFT JOIN TIPO_PRELIQUIDACION
			ON TIPO_PRELIQUIDACION.K_TIPO_PRELIQUIDACION = PRELIQUIDACION.K_TIPO_PRELIQUIDACION
	LEFT JOIN PUNTO_VENTA
			ON PUNTO_VENTA.K_PUNTO_VENTA = PRELIQUIDACION.K_PUNTO_VENTA
	LEFT JOIN OPERADOR
			ON OPERADOR.K_OPERADOR = PUNTO_VENTA.K_OPERADOR
	LEFT JOIN UNIDAD_OPERATIVA
			ON UNIDAD_OPERATIVA.K_UNIDAD_OPERATIVA = PUNTO_VENTA.K_UNIDAD_OPERATIVA
	JOIN	USUARIO
			ON USUARIO.K_USUARIO = PRELIQUIDACION.K_USUARIO_CAMBIO
			-- ==============================
	WHERE	PRELIQUIDACION.D_PRELIQUIDACION			LIKE '%'+@PP_BUSCAR+'%' 
	AND		(	PRELIQUIDACION.S_PRELIQUIDACION		LIKE '%'+@PP_BUSCAR+'%'
			OR	D_ESTATUS_PRELIQUIDACION			LIKE '%'+@PP_BUSCAR+'%' 
			OR	PRELIQUIDACION.K_PRELIQUIDACION=@VP_K_FOLIO	)
			-- ==============================
	AND		(	@PP_K_ESTATUS_PRELIQUIDACION=-1	OR  PRELIQUIDACION.K_ESTATUS_PRELIQUIDACION=@PP_K_ESTATUS_PRELIQUIDACION )
			-- ==============================
	AND		(	PRELIQUIDACION.L_BORRADO=0			OR	@VP_L_VER_BORRADOS=1	)
			-- ==============================
	ORDER BY PRELIQUIDACION.D_PRELIQUIDACION ASC

	-- ////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_PRELIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_PRELIQUIDACION]
GO

-- EXEC [dbo].[PG_SK_PRELIQUIDACION] 0,0,0,9

CREATE PROCEDURE [dbo].[PG_SK_PRELIQUIDACION]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_PRELIQUIDACION			INT
AS

	DECLARE @VP_MENSAJE				VARCHAR(300)
	DECLARE @VP_K_TIPO_PRELIQUIDACION	INT
	
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
			PRELIQUIDACION.*,
			-- ==============================
			PUNTO_VENTA.D_PUNTO_VENTA,
			-- ==============================
			OPERADOR.K_OPERADOR ,CONCAT(OPERADOR.NOMBRE, ' ' + OPERADOR.APATERNO) AS D_OPERADOR,
			-- ==============================
			UNIDAD_OPERATIVA.K_UNIDAD_OPERATIVA,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	PRELIQUIDACION, USUARIO, PUNTO_VENTA, OPERADOR, UNIDAD_OPERATIVA
			-- ==============================
	WHERE	PRELIQUIDACION.L_BORRADO=0
	AND		PRELIQUIDACION.K_PRELIQUIDACION = @PP_K_PRELIQUIDACION
	AND		PRELIQUIDACION.K_PUNTO_VENTA=PUNTO_VENTA.K_PUNTO_VENTA
	AND		PUNTO_VENTA.K_OPERADOR=OPERADOR.K_OPERADOR
	AND		UNIDAD_OPERATIVA.K_UNIDAD_OPERATIVA=PUNTO_VENTA.K_UNIDAD_OPERATIVA
			-- ==============================
	
	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	-- // NO ES REQUERIDA LA SECCION #3

	-- ////////////////////////////////////////////////
GO





-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT *FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_PRELIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_PRELIQUIDACION]
GO

--EXEC [dbo].[PG_IN_PRELIQUIDACION] 0,0,0,'PRE','PRE',0,1,1,1,8 

CREATE PROCEDURE [dbo].[PG_IN_PRELIQUIDACION]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================	
	@PP_D_PRELIQUIDACION		VARCHAR(100),
	@PP_S_PRELIQUIDACION		VARCHAR(10),
	@PP_O_PRELIQUIDACION		INT,
	@PP_L_PRELIQUIDACION		INT,
	-- ===========================		
	@PP_K_TIPO_PRELIQUIDACION	INT,	
	@PP_K_ESTATUS_PRELIQUIDACION INT,
	@PP_K_PUNTO_VENTA			INT
	-- ============================
AS

DECLARE @VP_MENSAJE		VARCHAR(300)

SET		@VP_MENSAJE		= ''

-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

DECLARE @VP_K_PRELIQUIDACION	INT = 0
DECLARE @VP_O_PRELIQUIDACION	INT = 0

IF @VP_MENSAJE=''	
		EXECUTE [dbo].[PG_RN_PRELIQUIDACION_INSERT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													--	@VP_K_PRELIQUIDACION, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR

IF @VP_MENSAJE=''
		BEGIN

	EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
												'PRELIQUIDACION', 
												@OU_K_TABLA_DISPONIBLE = @VP_K_PRELIQUIDACION	OUTPUT
	-- ====================================

	INSERT INTO PRELIQUIDACION
			( [K_PRELIQUIDACION],
			[D_PRELIQUIDACION], [S_PRELIQUIDACION], [O_PRELIQUIDACION], [L_PRELIQUIDACION], [F_PRELIQUIDACION], 
			-- ===========================
			[K_TIPO_PRELIQUIDACION], [K_ESTATUS_PRELIQUIDACION], [K_PUNTO_VENTA],
			-- ===========================
			[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
			[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA] )
	VALUES
			( @VP_K_PRELIQUIDACION,
			@PP_D_PRELIQUIDACION, @PP_S_PRELIQUIDACION, @PP_O_PRELIQUIDACION, @PP_L_PRELIQUIDACION, GETDATE(),
			-- ===========================
			@PP_K_ESTATUS_PRELIQUIDACION, @PP_K_TIPO_PRELIQUIDACION, @PP_K_PUNTO_VENTA,
			-- ===========================
			@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
			0, NULL, NULL )
	

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA

	IF @VP_MENSAJE<>''
		BEGIN

		SET		@VP_MENSAJE = 'No es posible [Crear] el [PRELIQUIDACION]: ' + @VP_MENSAJE
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@VP_K_PRELIQUIDACION)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

	END

	END

	SELECT @VP_MENSAJE AS MENSAJE, @VP_K_PRELIQUIDACION AS CLAVE

	-- //////////////////////////////////////////////////////////////

GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ACTUALIZAR / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_PRELIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_PRELIQUIDACION]
GO

CREATE PROCEDURE [dbo].[PG_UP_PRELIQUIDACION]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================			
	@PP_K_PRELIQUIDACION		INT,
	@PP_D_PRELIQUIDACION		VARCHAR(100),
	@PP_S_PRELIQUIDACION		VARCHAR(10),
	@PP_O_PRELIQUIDACION		INT,
	@PP_L_PRELIQUIDACION		INT,
	@PP_F_PRELIQUIDACION		DATE,
	-- ===========================		
	@PP_K_TIPO_PRELIQUIDACION	INT,	
	@PP_K_ESTATUS_PRELIQUIDACION INT,
	@PP_K_PUNTO_VENTA			INT
	-- ============================
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_PRELIQUIDACION_UPDATE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_PRELIQUIDACION, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN
		-- ===========================
		UPDATE	PRELIQUIDACION
		SET			
				[D_PRELIQUIDACION]			= @PP_D_PRELIQUIDACION, 
				[S_PRELIQUIDACION]			= @PP_S_PRELIQUIDACION, 
				[O_PRELIQUIDACION]			= @PP_O_PRELIQUIDACION,
				[L_PRELIQUIDACION]			= @PP_L_PRELIQUIDACION,
				[F_PRELIQUIDACION]			= @PP_F_PRELIQUIDACION,
				-- ===========================
				[K_TIPO_PRELIQUIDACION]		= @PP_K_TIPO_PRELIQUIDACION,
				[K_ESTATUS_PRELIQUIDACION]	= @PP_K_ESTATUS_PRELIQUIDACION,
				[K_PUNTO_VENTA]				= @PP_K_PUNTO_VENTA,
				-- ===========================
			    [F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	K_PRELIQUIDACION=@PP_K_PRELIQUIDACION
	
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Actualizar] el [PRELIQUIDACION]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@PP_K_PRELIQUIDACION)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_PRELIQUIDACION AS CLAVE

	-- //////////////////////////////////////////////////////////////
	
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_PRELIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_PRELIQUIDACION]
GO


CREATE PROCEDURE [dbo].[PG_DL_PRELIQUIDACION]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_PRELIQUIDACION				INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_PRELIQUIDACION_DELETE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_PRELIQUIDACION, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR

	IF @VP_MENSAJE=''
		BEGIN

		UPDATE	PRELIQUIDACION
		SET		
				[L_BORRADO]				= 1,
				-- ====================
				[F_BAJA]				= GETDATE(), 
				[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
		WHERE	K_PRELIQUIDACION=@PP_K_PRELIQUIDACION
	
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Borrar] el [PRELIQUIDACION]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PRE.'+CONVERT(VARCHAR(10),@PP_K_PRELIQUIDACION)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_PRELIQUIDACION AS CLAVE

	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
