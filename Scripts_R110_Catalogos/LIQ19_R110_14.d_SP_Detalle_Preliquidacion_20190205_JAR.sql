-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R100_15.d_SP_DETALLE_PRELIQUIDACION
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			DETALLE_PRELIQUIDACION 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_DETALLE_PRELIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_DETALLE_PRELIQUIDACION]
GO

-- EXEC [dbo].[PG_LI_DETALLE_PRELIQUIDACION] 0,0,0,'',60

CREATE PROCEDURE [dbo].[PG_LI_DETALLE_PRELIQUIDACION]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_BUSCAR						VARCHAR(255),
	-- ===========================
	@PP_K_PRELIQUIDACION			INT
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
	
	DECLARE @VP_L_VER_BORRADOS		[INT]		
	
	EXECUTE [dbo].[PG_RN_DATA_VER_BORRADOS]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@OU_L_VER_BORRADOS = @VP_L_VER_BORRADOS			OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR

	SELECT	TOP ( @VP_LI_N_REGISTROS )
			DETALLE_PRELIQUIDACION.*,
			---- ==============================
			PRODUCTO.D_PRODUCTO,
			---- ==============================
			USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
	FROM	DETALLE_PRELIQUIDACION, USUARIO, PRODUCTO
			-- ==============================
	WHERE	DETALLE_PRELIQUIDACION.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
			-- ==============================
	AND		DETALLE_PRELIQUIDACION.K_PRELIQUIDACION=@PP_K_PRELIQUIDACION
	AND		DETALLE_PRELIQUIDACION.K_PRODUCTO=PRODUCTO.K_PRODUCTO
			-- ==============================
	ORDER BY K_PRODUCTO ASC

	-- ////////////////////////////////////////////////
GO



	
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_DETALLE_PRELIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_DETALLE_PRELIQUIDACION]
GO

-- EXECUTE [dbo].[PG_IN_DETALLE_PRELIQUIDACION] 0,0,0,60,4,0,0,1000,1000,90,90,80,80,1,1

CREATE PROCEDURE [dbo].[PG_IN_DETALLE_PRELIQUIDACION]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================			
	@PP_K_PRELIQUIDACION		INT,
	@PP_K_PRODUCTO				INT,
	-- ============================		
	@PP_LECTURA_INICIAL			DECIMAL(19,4),
	@PP_LECTURA_FINAL			DECIMAL(19,4),
	@PP_PESO_INICIAL			DECIMAL(19,4),
	@PP_PESO_FINAL				DECIMAL(19,4),
	@PP_NIVEL_INICIAL			INT,
	@PP_NIVEL_FINAL				INT,
	@PP_CARBURACION_INICIAL		DECIMAL(19,4),
	@PP_CARBURACION_FINAL		DECIMAL(19,4),
	@PP_TANQUE_INICIAL			INT,
	@PP_TANQUE_FINAL			INT
	-- ============================
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''
	
	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	
	
	DECLARE @VP_K_DETALLE_PRELIQUIDACION	INT = 0
	DECLARE @VP_O_DETALLE_PRELIQUIDACION	INT = 0
	
	IF @VP_MENSAJE=''	
		EXECUTE [dbo].[PG_RN_DETALLE_PRELIQUIDACION_INSERT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												--	@VP_K_DETALLE_PRELIQUIDACION, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN

		EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, 
													'DETALLE_PRELIQUIDACION', 
													@OU_K_TABLA_DISPONIBLE = @VP_K_DETALLE_PRELIQUIDACION	OUTPUT
		-- ====================================

		INSERT INTO DETALLE_PRELIQUIDACION
			( [K_DETALLE_PRELIQUIDACION],
			-- ===========================
			[K_PRELIQUIDACION], [K_PRODUCTO],
			-- ===========================
			[LECTURA_INICIAL], [LECTURA_FINAL],
			[PESO_INICIAL], [PESO_FINAL],
			[NIVEL_INICIAL], [NIVEL_FINAL],
			[CARBURACION_INICIAL], [CARBURACION_FINAL],
			[TANQUE_INICIAL], [TANQUE_FINAL],
			-- ===========================
			[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
			[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA] )
		VALUES
			( @VP_K_DETALLE_PRELIQUIDACION,
				-- ===========================
				@PP_K_PRELIQUIDACION, @PP_K_PRODUCTO,
				-- ===========================
				@PP_LECTURA_INICIAL, @PP_LECTURA_FINAL,
				@PP_PESO_INICIAL, @PP_PESO_FINAL,
				@PP_NIVEL_INICIAL, @PP_NIVEL_FINAL,
				@PP_CARBURACION_INICIAL, @PP_CARBURACION_FINAL,
				@PP_TANQUE_INICIAL, @PP_TANQUE_FINAL,
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL )

		END

		-- ====================================

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Crear] el [DETALLE_PRELIQUIDACION]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#PDV.'+CONVERT(VARCHAR(10),@VP_K_DETALLE_PRELIQUIDACION)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
	
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_DETALLE_PRELIQUIDACION AS CLAVE

	-- //////////////////////////////////////////////////////////////

GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ACTUALIZAR / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_DETALLE_PRELIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_DETALLE_PRELIQUIDACION]
GO

CREATE PROCEDURE [dbo].[PG_UP_DETALLE_PRELIQUIDACION]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================		
	@PP_K_DETALLE_PRELIQUIDACION INT,
	@PP_K_PRELIQUIDACION		INT,
	@PP_K_PRODUCTO				INT,
	-- ============================		
	@PP_LECTURA_INICIAL			DECIMAL(19,4),
	@PP_LECTURA_FINAL			DECIMAL(19,4),
	@PP_PESO_INICIAL			DECIMAL(19,4),
	@PP_PESO_FINAL				DECIMAL(19,4),
	@PP_NIVEL_INICIAL			INT,
	@PP_NIVEL_FINAL				INT,
	@PP_CARBURACION_INICIAL		DECIMAL(19,4),
	@PP_CARBURACION_FINAL		DECIMAL(19,4),
	@PP_TANQUE_INICIAL			INT,
	@PP_TANQUE_FINAL			INT
	-- ============================	
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300)
	
	SET		@VP_MENSAJE		= ''

	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	--IF @VP_MENSAJE=''
	--	EXECUTE [dbo].[PG_RN_DETALLE_PRELIQUIDACION_UPDATE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
	--													@VP_K_DETALLE_PRELIQUIDACION, 
	--													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN
		-- ===========================
		UPDATE	DETALLE_PRELIQUIDACION
		SET			
				[K_PRELIQUIDACION]		= @PP_K_PRELIQUIDACION, 
				[K_PRODUCTO]			= @PP_K_PRODUCTO,
				-- ===========================
				[LECTURA_INICIAL]		= @PP_LECTURA_INICIAL,
				[LECTURA_FINAL]			= @PP_LECTURA_FINAL,
				[PESO_INICIAL]			= @PP_PESO_INICIAL,
				[PESO_FINAL]			= @PP_PESO_FINAL,
				[NIVEL_INICIAL]			= @PP_NIVEL_INICIAL,
				[NIVEL_FINAL]			= @PP_NIVEL_FINAL,
				[CARBURACION_INICIAL]	= @PP_CARBURACION_INICIAL,
				[CARBURACION_FINAL]		= @PP_CARBURACION_FINAL,
				[TANQUE_INICIAL]		= @PP_TANQUE_INICIAL,
				[TANQUE_FINAL]			= @PP_TANQUE_FINAL,
				-- ===========================
			    [F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	K_DETALLE_PRELIQUIDACION=@PP_K_DETALLE_PRELIQUIDACION

		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Actualizar] el [DETALLE_PRELIQUIDACION]: ' + @VP_MENSAJE 
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
