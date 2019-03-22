-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R100_02.d_SP_PRELIQUIDACION_LTR
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			PRELIQUIDACION_LTR 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_PRELIQUIDACION_LTR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_PRELIQUIDACION_LTR]
GO

-- EXEC [dbo].[PG_LI_PRELIQUIDACION_LTR] 0,0,0,'',-1

CREATE PROCEDURE [dbo].[PG_LI_PRELIQUIDACION_LTR]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_BUSCAR						VARCHAR(255),
	-- ===========================
	@PP_K_ESTATUS_PRELIQUIDACION_LTR	INT
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
			PRELIQUIDACION_LTR.*,
			-- ==============================
			D_ESTATUS_PRELIQUIDACION_LTR, D_TIPO_PRELIQUIDACION_LTR,
			S_ESTATUS_PRELIQUIDACION_LTR, S_TIPO_PRELIQUIDACION_LTR,
			-- ==============================
			PUNTO_VENTA.D_PUNTO_VENTA, 
			-- ==============================
			CONCAT(OPERADOR.NOMBRE, ' ' + OPERADOR.APELLIDO_PATERNO) AS D_OPERADOR,
			-- ==============================
			UNIDAD_OPERATIVA.D_UNIDAD_OPERATIVA,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	PRELIQUIDACION_LTR	
	LEFT JOIN ESTATUS_PRELIQUIDACION_LTR
			ON ESTATUS_PRELIQUIDACION_LTR.K_ESTATUS_PRELIQUIDACION_LTR = PRELIQUIDACION_LTR.K_ESTATUS_PRELIQUIDACION_LTR
	LEFT JOIN TIPO_PRELIQUIDACION_LTR
			ON TIPO_PRELIQUIDACION_LTR.K_TIPO_PRELIQUIDACION_LTR = PRELIQUIDACION_LTR.K_TIPO_PRELIQUIDACION_LTR
	LEFT JOIN PUNTO_VENTA
			ON PUNTO_VENTA.K_PUNTO_VENTA = PRELIQUIDACION_LTR.K_PUNTO_VENTA
	LEFT JOIN OPERADOR
			ON OPERADOR.K_OPERADOR = PUNTO_VENTA.K_OPERADOR
	LEFT JOIN UNIDAD_OPERATIVA
			ON UNIDAD_OPERATIVA.K_UNIDAD_OPERATIVA = PUNTO_VENTA.K_UNIDAD_OPERATIVA
	JOIN	USUARIO
			ON USUARIO.K_USUARIO = PRELIQUIDACION_LTR.K_USUARIO_CAMBIO
			-- ==============================
	WHERE	PRELIQUIDACION_LTR.D_PRELIQUIDACION_LTR			LIKE '%'+@PP_BUSCAR+'%' 
	AND		(	PRELIQUIDACION_LTR.S_PRELIQUIDACION_LTR		LIKE '%'+@PP_BUSCAR+'%'
			OR	D_ESTATUS_PRELIQUIDACION_LTR			LIKE '%'+@PP_BUSCAR+'%' 
			OR	PRELIQUIDACION_LTR.K_PRELIQUIDACION_LTR=@VP_K_FOLIO	)
			-- ==============================
	AND		(	@PP_K_ESTATUS_PRELIQUIDACION_LTR=-1	OR  PRELIQUIDACION_LTR.K_ESTATUS_PRELIQUIDACION_LTR=@PP_K_ESTATUS_PRELIQUIDACION_LTR )
			-- ==============================
	AND		(	PRELIQUIDACION_LTR.L_BORRADO=0			OR	@VP_L_VER_BORRADOS=1	)
			-- ==============================
	ORDER BY PRELIQUIDACION_LTR.D_PRELIQUIDACION_LTR ASC

	-- ////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_PRELIQUIDACION_LTR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_PRELIQUIDACION_LTR]
GO

-- EXEC [dbo].[PG_SK_PRELIQUIDACION_LTR] 0,0,0,9

CREATE PROCEDURE [dbo].[PG_SK_PRELIQUIDACION_LTR]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_PRELIQUIDACION_LTR			INT
AS

	DECLARE @VP_MENSAJE				VARCHAR(300)
	DECLARE @VP_K_TIPO_PRELIQUIDACION_LTR	INT
	
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
			PRELIQUIDACION_LTR.*,
			-- ==============================
			PUNTO_VENTA.D_PUNTO_VENTA,
			-- ==============================
			OPERADOR.K_OPERADOR ,CONCAT(OPERADOR.NOMBRE, ' ' + OPERADOR.APELLIDO_PATERNO) AS D_OPERADOR,
			-- ==============================
			UNIDAD_OPERATIVA.K_UNIDAD_OPERATIVA,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	PRELIQUIDACION_LTR, USUARIO, PUNTO_VENTA, OPERADOR, UNIDAD_OPERATIVA
			-- ==============================
	WHERE	PRELIQUIDACION_LTR.L_BORRADO=0
	AND		PRELIQUIDACION_LTR.K_PRELIQUIDACION_LTR = @PP_K_PRELIQUIDACION_LTR
	AND		PRELIQUIDACION_LTR.K_PUNTO_VENTA=PUNTO_VENTA.K_PUNTO_VENTA
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


IF EXISTS (SELECT *FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_PRELIQUIDACION_LTR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_PRELIQUIDACION_LTR]
GO

--EXEC [dbo].[PG_IN_PRELIQUIDACION_LTR] 0,0,0,'PRE','PRE',0,1,1,1,8 

CREATE PROCEDURE [dbo].[PG_IN_PRELIQUIDACION_LTR]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================	
	@PP_D_PRELIQUIDACION_LTR		VARCHAR(100),
	@PP_S_PRELIQUIDACION_LTR		VARCHAR(10),
	@PP_O_PRELIQUIDACION_LTR		INT,
	@PP_L_PRELIQUIDACION_LTR		INT,
	-- ===========================		
	@PP_K_TIPO_PRELIQUIDACION_LTR	INT,	
	@PP_K_ESTATUS_PRELIQUIDACION_LTR INT,
	@PP_K_PUNTO_VENTA			INT
	-- ============================
AS

DECLARE @VP_MENSAJE		VARCHAR(300)

SET		@VP_MENSAJE		= ''

-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

DECLARE @VP_K_PRELIQUIDACION_LTR	INT = 0
DECLARE @VP_O_PRELIQUIDACION_LTR	INT = 0

IF @VP_MENSAJE=''	
		EXECUTE [dbo].[PG_RN_PRELIQUIDACION_LTR_INSERT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													--	@VP_K_PRELIQUIDACION_LTR, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR

IF @VP_MENSAJE=''
		BEGIN

	EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
												'PRELIQUIDACION_LTR', 
												@OU_K_TABLA_DISPONIBLE = @VP_K_PRELIQUIDACION_LTR	OUTPUT
	-- ====================================

	INSERT INTO PRELIQUIDACION_LTR
			( [K_PRELIQUIDACION_LTR],
			[D_PRELIQUIDACION_LTR], [S_PRELIQUIDACION_LTR], [O_PRELIQUIDACION_LTR], [L_PRELIQUIDACION_LTR], [F_PRELIQUIDACION_LTR], 
			-- ===========================
			[K_TIPO_PRELIQUIDACION_LTR], [K_ESTATUS_PRELIQUIDACION_LTR], [K_PUNTO_VENTA],
			-- ===========================
			[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
			[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA] )
	VALUES
			( @VP_K_PRELIQUIDACION_LTR,
			@PP_D_PRELIQUIDACION_LTR, @PP_S_PRELIQUIDACION_LTR, @PP_O_PRELIQUIDACION_LTR, @PP_L_PRELIQUIDACION_LTR, GETDATE(),
			-- ===========================
			@PP_K_ESTATUS_PRELIQUIDACION_LTR, @PP_K_TIPO_PRELIQUIDACION_LTR, @PP_K_PUNTO_VENTA,
			-- ===========================
			@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
			0, NULL, NULL )
	

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA

	IF @VP_MENSAJE<>''
		BEGIN

		SET		@VP_MENSAJE = 'No es posible [Crear] el [PRELIQUIDACION_LTR]: ' + @VP_MENSAJE
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@VP_K_PRELIQUIDACION_LTR)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

	END

	END

	SELECT @VP_MENSAJE AS MENSAJE, @VP_K_PRELIQUIDACION_LTR AS CLAVE

	-- //////////////////////////////////////////////////////////////

GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ACTUALIZAR / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_PRELIQUIDACION_LTR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_PRELIQUIDACION_LTR]
GO

CREATE PROCEDURE [dbo].[PG_UP_PRELIQUIDACION_LTR]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================			
	@PP_K_PRELIQUIDACION_LTR		INT,
	@PP_D_PRELIQUIDACION_LTR		VARCHAR(100),
	@PP_S_PRELIQUIDACION_LTR		VARCHAR(10),
	@PP_O_PRELIQUIDACION_LTR		INT,
	@PP_L_PRELIQUIDACION_LTR		INT,
	@PP_F_PRELIQUIDACION_LTR		DATE,
	-- ===========================		
	@PP_K_TIPO_PRELIQUIDACION_LTR	INT,	
	@PP_K_ESTATUS_PRELIQUIDACION_LTR INT,
	@PP_K_PUNTO_VENTA			INT
	-- ============================
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_PRELIQUIDACION_LTR_UPDATE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_PRELIQUIDACION_LTR, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN
		-- ===========================
		UPDATE	PRELIQUIDACION_LTR
		SET			
				[D_PRELIQUIDACION_LTR]			= @PP_D_PRELIQUIDACION_LTR, 
				[S_PRELIQUIDACION_LTR]			= @PP_S_PRELIQUIDACION_LTR, 
				[O_PRELIQUIDACION_LTR]			= @PP_O_PRELIQUIDACION_LTR,
				[L_PRELIQUIDACION_LTR]			= @PP_L_PRELIQUIDACION_LTR,
				[F_PRELIQUIDACION_LTR]			= @PP_F_PRELIQUIDACION_LTR,
				-- ===========================
				[K_TIPO_PRELIQUIDACION_LTR]		= @PP_K_TIPO_PRELIQUIDACION_LTR,
				[K_ESTATUS_PRELIQUIDACION_LTR]	= @PP_K_ESTATUS_PRELIQUIDACION_LTR,
				[K_PUNTO_VENTA]				= @PP_K_PUNTO_VENTA,
				-- ===========================
			    [F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	K_PRELIQUIDACION_LTR=@PP_K_PRELIQUIDACION_LTR
	
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Actualizar] el [PRELIQUIDACION_LTR]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@PP_K_PRELIQUIDACION_LTR)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_PRELIQUIDACION_LTR AS CLAVE

	-- //////////////////////////////////////////////////////////////
	
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_PRELIQUIDACION_LTR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_PRELIQUIDACION_LTR]
GO


CREATE PROCEDURE [dbo].[PG_DL_PRELIQUIDACION_LTR]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_PRELIQUIDACION_LTR				INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_PRELIQUIDACION_LTR_DELETE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_PRELIQUIDACION_LTR, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR

	IF @VP_MENSAJE=''
		BEGIN

		UPDATE	PRELIQUIDACION_LTR
		SET		
				[L_BORRADO]				= 1,
				-- ====================
				[F_BAJA]				= GETDATE(), 
				[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
		WHERE	K_PRELIQUIDACION_LTR=@PP_K_PRELIQUIDACION_LTR
	
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Borrar] el [PRELIQUIDACION_LTR]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PRE.'+CONVERT(VARCHAR(10),@PP_K_PRELIQUIDACION_LTR)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_PRELIQUIDACION_LTR AS CLAVE

	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
