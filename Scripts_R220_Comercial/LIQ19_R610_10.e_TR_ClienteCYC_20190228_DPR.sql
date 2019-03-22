-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	
-- // MÓDULO:			CLIENTE_TMK
-- // OPERACIÓN:		LIBERACIÓN / TRANSICIÓN
-- ////////////////////////////////////////////////////////////// 
-- // Autor:			
-- // Fecha creación:	
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0]
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN CLIENTE_TMK INACTIVABLE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_CLIENTE_TMK_ES_INACTIVABLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_ES_INACTIVABLE]
GO

CREATE PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_ES_INACTIVABLE]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ==========================
	@PP_K_CLIENTE_TMK			INT,
	-- ==========================
	@OU_RESULTADO_VALIDACION	VARCHAR (300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_K_ESTATUS_CLIENTE_TMK	INT
	DECLARE	@VP_D_ESTATUS_CLIENTE_TMK	VARCHAR(100)
	
	SELECT	@VP_K_ESTATUS_CLIENTE_TMK =	ESTATUS_CLIENTE_TMK.K_ESTATUS_CLIENTE_TMK,
			@VP_D_ESTATUS_CLIENTE_TMK =	ESTATUS_CLIENTE_TMK.D_ESTATUS_CLIENTE_TMK
										FROM	CLIENTE_TMK, ESTATUS_CLIENTE_TMK
										WHERE	CLIENTE_TMK.K_ESTATUS_CLIENTE_TMK=ESTATUS_CLIENTE_TMK.K_ESTATUS_CLIENTE_TMK
										AND		CLIENTE_TMK.K_CLIENTE_TMK=@PP_K_CLIENTE_TMK
	-- =============================

	IF @VP_RESULTADO=''
		IF @VP_K_ESTATUS_CLIENTE_TMK IS NULL
			SET @VP_RESULTADO =  'No se localizó el [Cliente] de CYC.' 

	-- =============================
	-- K_ESTATUS_CLIENTE_TMK	
	-- #0 INACTIVO | #1 ACTIVO | #2 DEUDOR | 

	IF @VP_RESULTADO=''
		IF NOT ( @VP_K_ESTATUS_CLIENTE_TMK IN ( 1 ) ) 
			SET @VP_RESULTADO =  'El [Estatus#'+CONVERT(VARCHAR(10),@VP_K_ESTATUS_CLIENTE_TMK)+'-'+@VP_D_ESTATUS_CLIENTE_TMK+'] del [Cliente] de CYC no lo permite.' 
			
	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO
-- /////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN CLIENTE_TMK INACTIVAR
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_CLIENTE_TMK_INACTIVADO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_INACTIVADO]
GO

CREATE PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_INACTIVADO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ==========================	
	@PP_K_CLIENTE_TMK			INT,	
	-- ==========================	
	@OU_RESULTADO_VALIDACION	VARCHAR (300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- //////////////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_CLIENTE_TMK_ES_INACTIVABLE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
															@PP_K_CLIENTE_TMK,	 
															@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- //////////////////////////////////////////////////

	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //INAC//'

	-- //////////////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- //////////////////////////////////////////////////
GO
-- //////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> TR CLIENTE_TMK INACTIVAR
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_TR_CLIENTE_TMK_INACTIVADO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_TR_CLIENTE_TMK_INACTIVADO]
GO

CREATE PROCEDURE [dbo].[PG_TR_CLIENTE_TMK_INACTIVADO]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_K_USUARIO_ACCION	INT,
	-- ==========================
	@PP_L_CONTESTA			INT,
	-- ===========================
	@PP_K_CLIENTE_TMK		INT
AS

	DECLARE	@VP_MENSAJE		VARCHAR(300) = ''

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_CLIENTE_TMK_INACTIVADO]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_CLIENTE_TMK,
														@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- /////////////////////////////////////////////////////////////////////

	IF @VP_MENSAJE=''
		BEGIN
		-- K_ESTATUS_CLIENTE_TMK = 0-INACTIVO / 1-ACTIVO / 2-DEUDOR

		UPDATE	CLIENTE_TMK
		SET		K_ESTATUS_CLIENTE_TMK	= 0,		-- INACTIVO
				-- ====================
				[F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	CLIENTE_TMK.K_CLIENTE_TMK=@PP_K_CLIENTE_TMK
		
		END


	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible inactivar el Cliente de CYC: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Cli.'+CONVERT(VARCHAR(10),@PP_K_CLIENTE_TMK)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
				
		END

	IF @PP_L_CONTESTA=1
		SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_CLIENTE_TMK AS CLAVE

	-- /////////////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													5,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'INACTIVADO',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_TR_CLIENTE_TMK_INACTIVADO]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_CLIENTE_TMK, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, '', '' , 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '', '', ''

	-- /////////////////////////////////////////////////////////////////////
GO
-- /////////////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN CLIENTE_TMK ACTIVAR
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_CLIENTE_TMK_ES_ACTIVABLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_ES_ACTIVABLE]
GO

CREATE PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_ES_ACTIVABLE]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ==========================
	@PP_K_CLIENTE_TMK			INT,
	-- ==========================
	@OU_RESULTADO_VALIDACION	VARCHAR (300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_K_ESTATUS_CLIENTE_TMK	INT
	DECLARE	@VP_D_ESTATUS_CLIENTE_TMK	VARCHAR(100)
	
	SELECT	@VP_K_ESTATUS_CLIENTE_TMK =	ESTATUS_CLIENTE_TMK.K_ESTATUS_CLIENTE_TMK,
			@VP_D_ESTATUS_CLIENTE_TMK =	ESTATUS_CLIENTE_TMK.D_ESTATUS_CLIENTE_TMK
										FROM	CLIENTE_TMK, ESTATUS_CLIENTE_TMK
										WHERE	CLIENTE_TMK.K_ESTATUS_CLIENTE_TMK=ESTATUS_CLIENTE_TMK.K_ESTATUS_CLIENTE_TMK
										AND		CLIENTE_TMK.K_CLIENTE_TMK=@PP_K_CLIENTE_TMK
	-- =============================

	IF @VP_RESULTADO=''
		IF @VP_K_ESTATUS_CLIENTE_TMK IS NULL
			SET @VP_RESULTADO =  'No se localizó el [Cliente] de CYC.' 

	-- =============================
	-- K_ESTATUS_CLIENTE_TMK	
	-- #0 INACTIVO | #1 ACTIVO | #2 DEUDOR | 

	IF @VP_RESULTADO=''
		IF NOT ( @VP_K_ESTATUS_CLIENTE_TMK IN ( 0 ) ) 
			SET @VP_RESULTADO =  'El [Estatus#'+CONVERT(VARCHAR(10),@VP_K_ESTATUS_CLIENTE_TMK)+'-'+@VP_D_ESTATUS_CLIENTE_TMK+'] del [Cliente] de CYC no lo permite.' 
			
	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO
-- /////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN CLIENTE_TMK ACTIVAR
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_CLIENTE_TMK_ACTIVADO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_ACTIVADO]
GO

CREATE PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_ACTIVADO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ==========================	
	@PP_K_CLIENTE_TMK			INT,	
	-- ==========================	
	@OU_RESULTADO_VALIDACION	VARCHAR (300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- //////////////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_CLIENTE_TMK_ES_ACTIVABLE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_CLIENTE_TMK,	 
														@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- //////////////////////////////////////////////////

	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //ACT//'

	-- //////////////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- //////////////////////////////////////////////////
GO
-- //////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> TR CLIENTE_TMK DECODIFICAR
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_TR_CLIENTE_TMK_ACTIVADO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_TR_CLIENTE_TMK_ACTIVADO]
GO

CREATE PROCEDURE [dbo].[PG_TR_CLIENTE_TMK_ACTIVADO]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_K_USUARIO_ACCION	INT,
	-- ===========================
	@PP_L_CONTESTA			INT,
	-- ===========================
	@PP_K_CLIENTE_TMK		INT
AS

	DECLARE	@VP_MENSAJE		VARCHAR(300) = ''

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_CLIENTE_TMK_ACTIVADO]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_CLIENTE_TMK,
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- /////////////////////////////////////////////////////////////////////

	IF @VP_MENSAJE=''
		BEGIN
		-- K_ESTATUS_CLIENTE_TMK = 0-INACTIVO / 1-ACTIVO / 2-DEUDOR

		UPDATE	CLIENTE_TMK
		SET		K_ESTATUS_CLIENTE_TMK	= 1,		-- ACTIVO
				-- ====================
				[F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	CLIENTE_TMK.K_CLIENTE_TMK=@PP_K_CLIENTE_TMK
		
		END


	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible activar el Cliente de CYC: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Cli.'+CONVERT(VARCHAR(10),@PP_K_CLIENTE_TMK)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
				
		END

	IF @PP_L_CONTESTA=1
		SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_CLIENTE_TMK AS CLAVE

	-- /////////////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													5,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'ACTIVADO',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_TR_CLIENTE_TMK_ACTIVADO]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_CLIENTE_TMK, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, '', '' , 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '', '', ''

	-- /////////////////////////////////////////////////////////////////////
GO
-- /////////////////////////////////////////////////////////////////////




-- /////////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////////