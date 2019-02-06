-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R100_02.d_SP_LIQUIDACION
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			LIQUIDACION 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_LIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_LIQUIDACION]
GO

-- EXEC [dbo].[PG_LI_LIQUIDACION] 0,0,0,'',-1,-1

CREATE PROCEDURE [dbo].[PG_LI_LIQUIDACION]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_BUSCAR						VARCHAR(255),
	-- ===========================
	@PP_K_ESTATUS_LIQUIDACION		INT,
	@PP_K_TIPO_LIQUIDACION			INT
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
			LIQUIDACION.*,
			-- ==============================
			D_ESTATUS_LIQUIDACION, D_TIPO_LIQUIDACION,
			S_ESTATUS_LIQUIDACION, S_TIPO_LIQUIDACION,
			-- ==============================
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	LIQUIDACION	
	LEFT JOIN ESTATUS_LIQUIDACION
			ON ESTATUS_LIQUIDACION.K_ESTATUS_LIQUIDACION = LIQUIDACION.K_ESTATUS_LIQUIDACION
	LEFT JOIN TIPO_LIQUIDACION
			ON TIPO_LIQUIDACION.K_TIPO_LIQUIDACION = LIQUIDACION.K_TIPO_LIQUIDACION
	JOIN	USUARIO
			ON USUARIO.K_USUARIO = LIQUIDACION.K_USUARIO_CAMBIO
			-- ==============================
	WHERE	LIQUIDACION.D_LIQUIDACION			LIKE '%'+@PP_BUSCAR+'%' 
	AND		(	LIQUIDACION.S_LIQUIDACION		LIKE '%'+@PP_BUSCAR+'%'
			OR	D_ESTATUS_LIQUIDACION			LIKE '%'+@PP_BUSCAR+'%' 
			OR	D_TIPO_LIQUIDACION				LIKE '%'+@PP_BUSCAR+'%' 
			OR	LIQUIDACION.K_LIQUIDACION=@VP_K_FOLIO	)
			-- ==============================
	AND		(	@PP_K_ESTATUS_LIQUIDACION=-1	OR  LIQUIDACION.K_ESTATUS_LIQUIDACION=@PP_K_ESTATUS_LIQUIDACION )
			-- ==============================
	AND		(	LIQUIDACION.L_BORRADO=0			OR	@VP_L_VER_BORRADOS=1	)
					-- ==============================
	ORDER BY LIQUIDACION.D_LIQUIDACION ASC

	-- ////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_LIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_LIQUIDACION]
GO

-- EXEC [dbo].[PG_SK_LIQUIDACION] 0,0,0,9

CREATE PROCEDURE [dbo].[PG_SK_LIQUIDACION]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_LIQUIDACION			INT
AS

	DECLARE @VP_MENSAJE				VARCHAR(300)
	DECLARE @VP_K_TIPO_LIQUIDACION	INT
	
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
			LIQUIDACION.*,
			-- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	LIQUIDACION, USUARIO, PRELIQUIDACION
			-- ==============================
	WHERE	LIQUIDACION.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
	AND		LIQUIDACION.K_PRELIQUIDACION=PRELIQUIDACION.K_PRELIQUIDACION
			-- ==============================
	AND		LIQUIDACION.L_BORRADO=0
	AND		LIQUIDACION.K_LIQUIDACION=@PP_K_LIQUIDACION

			-- ===========================
	
	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	-- // NO ES REQUERIDA LA SECCION #3

	-- ////////////////////////////////////////////////
GO





-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT *FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_LIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_LIQUIDACION]
GO

--EXEC [dbo].[PG_IN_LIQUIDACION] 000,,,,

CREATE PROCEDURE [dbo].[PG_IN_LIQUIDACION]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================	
	@PP_D_LIQUIDACION			VARCHAR(100),
	@PP_S_LIQUIDACION			VARCHAR(10),
	@PP_O_LIQUIDACION			INT,
	@PP_C_LIQUIDACION			VARCHAR(255),
	@PP_L_LIQUIDACION			INT,
	@PP_F_LIQUIDACION			DATE,
	-- ===========================		
	@PP_K_PRELIUIDACION			INT,	
	@PP_K_ESTATUS_LIQUIDACION	INT,
	@PP_K_TIPO_LIQUIDACION		INT,
	-- ===========================	
	@PP_SUBTOTAL				DECIMAL(19,4),
	@PP_IVA						DECIMAL(19,4),
	@PP_TOTAL					DECIMAL(19,4)
	-- ============================
AS

DECLARE @VP_MENSAJE		VARCHAR(300)

SET		@VP_MENSAJE		= ''

-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

DECLARE @VP_K_LIQUIDACION	INT = 0
DECLARE @VP_O_LIQUIDACION	INT = 0

IF @VP_MENSAJE=''	
		EXECUTE [dbo].[PG_RN_LIQUIDACION_INSERT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													--	@VP_K_LIQUIDACION, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR

IF @VP_MENSAJE=''
		BEGIN

	EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
												'LIQUIDACION', 
												@OU_K_TABLA_DISPONIBLE = @VP_K_LIQUIDACION	OUTPUT
	-- ====================================

	INSERT INTO LIQUIDACION
			( [K_LIQUIDACION],
			[D_LIQUIDACION], [S_LIQUIDACION], [O_LIQUIDACION], [C_LIQUIDACION], [L_LIQUIDACION], [F_LIQUIDACION], 
			-- ===========================
			[K_PRELIQUIDACION], [K_ESTATUS_LIQUIDACION], [K_TIPO_LIQUIDACION],
			-- ===========================
			[SUBTOTAL], [IVA], [TOTAL], 
			-- ===========================
			[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
			[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA] )
	VALUES
			( @VP_K_LIQUIDACION,
			@PP_D_LIQUIDACION, @PP_S_LIQUIDACION, @PP_O_LIQUIDACION, @PP_C_LIQUIDACION, @PP_L_LIQUIDACION, @PP_F_LIQUIDACION,
			-- ===========================
			@PP_K_PRELIUIDACION, @PP_K_ESTATUS_LIQUIDACION, @PP_K_TIPO_LIQUIDACION, 
			-- ===========================
			@PP_SUBTOTAL, @PP_IVA, @PP_TOTAL, 
			-- ===========================
			@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
			0, NULL, NULL )
	

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA

	IF @VP_MENSAJE<>''
		BEGIN

		SET		@VP_MENSAJE = 'No es posible [Crear] el [LIQUIDACION]: ' + @VP_MENSAJE
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@VP_K_LIQUIDACION)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

	END

	END

	SELECT @VP_MENSAJE AS MENSAJE, @VP_K_LIQUIDACION AS CLAVE

	-- //////////////////////////////////////////////////////////////

GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ACTUALIZAR / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_LIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_LIQUIDACION]
GO

CREATE PROCEDURE [dbo].[PG_UP_LIQUIDACION]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================			
	@PP_K_LIQUIDACION			INT,
	@PP_D_LIQUIDACION			VARCHAR(100),
	@PP_S_LIQUIDACION			VARCHAR(10),
	@PP_O_LIQUIDACION			INT,
	@PP_C_LIQUIDACION			VARCHAR(255),
	@PP_L_LIQUIDACION			INT,
	@PP_F_LIQUIDACION			DATE,
	-- ===========================		
	@PP_K_PRELIQUIDACION			INT,	
	@PP_K_ESTATUS_LIQUIDACION	INT,
	@PP_K_TIPO_LIQUIDACION		INT,
	-- ===========================	
	@PP_SUBTOTAL				DECIMAL(19,4),
	@PP_IVA						DECIMAL(19,4),
	@PP_TOTAL					DECIMAL(19,4)
	-- ============================
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_LIQUIDACION_UPDATE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_LIQUIDACION, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN
		-- ===========================
		UPDATE	LIQUIDACION
		SET			
				[D_LIQUIDACION]			= @PP_D_LIQUIDACION, 
				[S_LIQUIDACION]			= @PP_S_LIQUIDACION, 
				[O_LIQUIDACION]			= @PP_O_LIQUIDACION,
				[C_LIQUIDACION]			= @PP_C_LIQUIDACION,
				[L_LIQUIDACION]			= @PP_L_LIQUIDACION,
				[F_LIQUIDACION]			= @PP_F_LIQUIDACION,
				-- ===========================
				[K_PRELIQUIDACION]		= @PP_K_PRELIQUIDACION,
				[K_ESTATUS_LIQUIDACION]	= @PP_K_ESTATUS_LIQUIDACION,
				[K_TIPO_LIQUIDACION]	= @PP_K_TIPO_LIQUIDACION,
				-- ===========================
				[SUBTOTAL]				= @PP_SUBTOTAL,
				[IVA]					= @PP_IVA,
				[TOTAL]					= @PP_TOTAL,
				-- ===========================
			    [F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	K_LIQUIDACION=@PP_K_LIQUIDACION
	
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Actualizar] el [LIQUIDACION]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@PP_K_LIQUIDACION)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_LIQUIDACION AS CLAVE

	-- //////////////////////////////////////////////////////////////
	
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_LIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_LIQUIDACION]
GO


CREATE PROCEDURE [dbo].[PG_DL_LIQUIDACION]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_K_LIQUIDACION				INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_LIQUIDACION_DELETE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_LIQUIDACION, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR

	IF @VP_MENSAJE=''
		BEGIN

		UPDATE	LIQUIDACION
		SET		
				[L_BORRADO]				= 1,
				-- ====================
				[F_BAJA]				= GETDATE(), 
				[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
		WHERE	K_LIQUIDACION=@PP_K_LIQUIDACION
	
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Borrar] el [LIQUIDACION]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PRE.'+CONVERT(VARCHAR(10),@PP_K_LIQUIDACION)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_LIQUIDACION AS CLAVE

	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
