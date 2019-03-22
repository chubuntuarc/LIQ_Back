-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	CYC19_Crédito_y_Cobranza
-- // MÓDULO:			REMISIÓN CYC
-- // OPERACIÓN:		LIBERACIÓN / TRANSICIÓN
-- ////////////////////////////////////////////////////////////// 
-- // Autor:			Daniel Portillo Romero
-- // Fecha creación:	09/FEB/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0]
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN REMISION_CYC CODIFICABLE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_REMISION_CYC_ES_CODIFICABLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_REMISION_CYC_ES_CODIFICABLE]
GO

CREATE PROCEDURE [dbo].[PG_RN_REMISION_CYC_ES_CODIFICABLE]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ==========================
	@PP_K_REMISION_CYC			INT,
	-- ==========================
	@OU_RESULTADO_VALIDACION	VARCHAR (300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_K_ESTATUS_REMISION_CYC		INT
	DECLARE	@VP_D_ESTATUS_REMISION_CYC		VARCHAR(100)
	
	SELECT	@VP_K_ESTATUS_REMISION_CYC =	ESTATUS_REMISION_CYC.K_ESTATUS_REMISION_CYC,
			@VP_D_ESTATUS_REMISION_CYC =	ESTATUS_REMISION_CYC.D_ESTATUS_REMISION_CYC
											FROM	REMISION_CYC, ESTATUS_REMISION_CYC
											WHERE	REMISION_CYC.K_ESTATUS_REMISION_CYC=ESTATUS_REMISION_CYC.K_ESTATUS_REMISION_CYC
											AND		REMISION_CYC.K_REMISION_CYC=@PP_K_REMISION_CYC
	-- =============================

	IF @VP_RESULTADO=''
		IF @VP_K_ESTATUS_REMISION_CYC IS NULL
			SET @VP_RESULTADO =  'No se localizó la [Remisión].' 

	-- =============================
	-- K_ESTATUS_REMISION_CYC	
	-- #1 PENDIENTE | #2 AUTORIZADA | #3 CANCELADA | 

	IF @VP_RESULTADO=''
		IF NOT ( @VP_K_ESTATUS_REMISION_CYC IN ( 1 ) ) 
			SET @VP_RESULTADO =  'El [Estatus#'+CONVERT(VARCHAR(10),@VP_K_ESTATUS_REMISION_CYC)+'-'+@VP_D_ESTATUS_REMISION_CYC+'] de la [Remisión] no lo permite.' 
			
	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO
-- /////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN REMISION_CYC CODIFICAR
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_REMISION_CYC_CODIFICADA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_REMISION_CYC_CODIFICADA]
GO

CREATE PROCEDURE [dbo].[PG_RN_REMISION_CYC_CODIFICADA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ==========================	
	@PP_K_REMISION_CYC			INT,	
	-- ==========================	
	@OU_RESULTADO_VALIDACION	VARCHAR (300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- //////////////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_REMISION_CYC_ES_CODIFICABLE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
															@PP_K_REMISION_CYC,	 
															@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- //////////////////////////////////////////////////

	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //COD//'

	-- //////////////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- //////////////////////////////////////////////////
GO
-- //////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> TR REMISION_CYC CODIFICAR
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_TR_REMISION_CYC_CODIFICADA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_TR_REMISION_CYC_CODIFICADA]
GO

CREATE PROCEDURE [dbo].[PG_TR_REMISION_CYC_CODIFICADA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_L_CONTESTA				INT,
	-- ===========================
	@PP_K_REMISION_CYC			INT
AS

	DECLARE	@VP_MENSAJE		VARCHAR(300) = ''

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_REMISION_CYC_CODIFICADA]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_REMISION_CYC,
														@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- /////////////////////////////////////////////////////////////////////

	IF @VP_MENSAJE=''
		BEGIN
		-- K_ESTATUS_REMISION_CYC = 1-PENDIENTE / 2-AUTORIZADA / 3-CANCELADA

		UPDATE	REMISION_CYC
		SET		K_ESTATUS_REMISION_CYC	= 2,		-- AUTORIZADA
				-- ====================
				[F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	REMISION_CYC.K_REMISION_CYC=@PP_K_REMISION_CYC
		
		END


	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible Codificar la Remisión: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Rem.'+CONVERT(VARCHAR(10),@PP_K_REMISION_CYC)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
				
		END

	IF @PP_L_CONTESTA=1
		SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_REMISION_CYC AS CLAVE

	-- /////////////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													5,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'CODIFICADA',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_TR_REMISION_CYC_CODIFICADA]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_REMISION_CYC, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, '', '' , 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '', '', ''

	-- /////////////////////////////////////////////////////////////////////
GO
-- /////////////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN REMISION_CYC DECODIFICAR
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_REMISION_CYC_ES_DECODIFICABLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_REMISION_CYC_ES_DECODIFICABLE]
GO

CREATE PROCEDURE [dbo].[PG_RN_REMISION_CYC_ES_DECODIFICABLE]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ==========================
	@PP_K_REMISION_CYC			INT,
	-- ==========================
	@OU_RESULTADO_VALIDACION	VARCHAR (300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_K_ESTATUS_REMISION_CYC		INT
	DECLARE	@VP_D_ESTATUS_REMISION_CYC		VARCHAR(100)
	
	SELECT	@VP_K_ESTATUS_REMISION_CYC =	ESTATUS_REMISION_CYC.K_ESTATUS_REMISION_CYC,
			@VP_D_ESTATUS_REMISION_CYC =	ESTATUS_REMISION_CYC.D_ESTATUS_REMISION_CYC
											FROM	REMISION_CYC, ESTATUS_REMISION_CYC
											WHERE	REMISION_CYC.K_ESTATUS_REMISION_CYC=ESTATUS_REMISION_CYC.K_ESTATUS_REMISION_CYC
											AND		REMISION_CYC.K_REMISION_CYC=@PP_K_REMISION_CYC
	-- =============================

	IF @VP_RESULTADO=''
		IF @VP_K_ESTATUS_REMISION_CYC IS NULL
			SET @VP_RESULTADO =  'No se localizó la [Remisión].' 

	-- =============================
	-- K_ESTATUS_REMISION_CYC	
	-- #1 PENDIENTE | #2 AUTORIZADA | #3 CANCELADA | 

	IF @VP_RESULTADO=''
		IF NOT ( @VP_K_ESTATUS_REMISION_CYC IN ( 2 ) ) 
			SET @VP_RESULTADO =  'El [Estatus#'+CONVERT(VARCHAR(10),@VP_K_ESTATUS_REMISION_CYC)+'-'+@VP_D_ESTATUS_REMISION_CYC+'] de la [Remisión] no lo permite.' 
			
	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO
-- /////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN REMISION_CYC DECODIFICAR
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_REMISION_CYC_DECODIFICADA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_REMISION_CYC_DECODIFICADA]
GO

CREATE PROCEDURE [dbo].[PG_RN_REMISION_CYC_DECODIFICADA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ==========================	
	@PP_K_REMISION_CYC			INT,	
	-- ==========================	
	@OU_RESULTADO_VALIDACION	VARCHAR (300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- //////////////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_REMISION_CYC_ES_DECODIFICABLE]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_K_REMISION_CYC,	 
																@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- //////////////////////////////////////////////////

	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //DCD//'

	-- //////////////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- //////////////////////////////////////////////////
GO
-- //////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> TR REMISION_CYC DECODIFICAR
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_TR_REMISION_CYC_DECODIFICADA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_TR_REMISION_CYC_DECODIFICADA]
GO

CREATE PROCEDURE [dbo].[PG_TR_REMISION_CYC_DECODIFICADA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_L_CONTESTA				INT,
	-- ===========================
	@PP_K_REMISION_CYC			INT
AS

	DECLARE	@VP_MENSAJE		VARCHAR(300) = ''

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_REMISION_CYC_DECODIFICADA]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
															@PP_K_REMISION_CYC,
															@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- /////////////////////////////////////////////////////////////////////

	IF @VP_MENSAJE=''
		BEGIN
		-- K_ESTATUS_REMISION_CYC = 1-PENDIENTE / 2-AUTORIZADA / 3-CANCELADA

		UPDATE	REMISION_CYC
		SET		K_ESTATUS_REMISION_CYC	= 1,		-- PENDIENTE
				-- ====================
				[F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	REMISION_CYC.K_REMISION_CYC=@PP_K_REMISION_CYC
		
		END


	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible Decodificar la Remisión: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Rem.'+CONVERT(VARCHAR(10),@PP_K_REMISION_CYC)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
				
		END

	IF @PP_L_CONTESTA=1
		SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_REMISION_CYC AS CLAVE

	-- /////////////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													5,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'DECODIFICADA',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_TR_REMISION_CYC_DECODIFICADA]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_REMISION_CYC, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, '', '' , 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '', '', ''

	-- /////////////////////////////////////////////////////////////////////
GO
-- /////////////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN REMISION_CYC CANCELABLE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_REMISION_CYC_ES_CANCELABLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_REMISION_CYC_ES_CANCELABLE]
GO

CREATE PROCEDURE [dbo].[PG_RN_REMISION_CYC_ES_CANCELABLE]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ==========================
	@PP_K_REMISION_CYC			INT,
	-- ==========================
	@OU_RESULTADO_VALIDACION	VARCHAR (300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_K_ESTATUS_REMISION_CYC		INT
	DECLARE	@VP_D_ESTATUS_REMISION_CYC		VARCHAR(100)
	
	SELECT	@VP_K_ESTATUS_REMISION_CYC =	ESTATUS_REMISION_CYC.K_ESTATUS_REMISION_CYC,
			@VP_D_ESTATUS_REMISION_CYC =	ESTATUS_REMISION_CYC.D_ESTATUS_REMISION_CYC
											FROM	REMISION_CYC, ESTATUS_REMISION_CYC
											WHERE	REMISION_CYC.K_ESTATUS_REMISION_CYC=ESTATUS_REMISION_CYC.K_ESTATUS_REMISION_CYC
											AND		REMISION_CYC.K_REMISION_CYC=@PP_K_REMISION_CYC
	-- =============================

	IF @VP_RESULTADO=''
		IF @VP_K_ESTATUS_REMISION_CYC IS NULL
			SET @VP_RESULTADO =  'No se localizó la [Remisión].' 

	-- =============================
	-- K_ESTATUS_REMISION_CYC	
	-- #1 PENDIENTE | #2 AUTORIZADA | #3 CANCELADA | 

	IF @VP_RESULTADO=''
		IF NOT ( @VP_K_ESTATUS_REMISION_CYC IN ( 1 ) ) 
			SET @VP_RESULTADO =  'El [Estatus#'+CONVERT(VARCHAR(10),@VP_K_ESTATUS_REMISION_CYC)+'-'+@VP_D_ESTATUS_REMISION_CYC+'] de la [Remisión] no lo permite.' 
			
	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO
-- /////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN REMISION_CYC CANCELAR
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_REMISION_CYC_CANCELADA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_REMISION_CYC_CANCELADA]
GO

CREATE PROCEDURE [dbo].[PG_RN_REMISION_CYC_CANCELADA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ==========================	
	@PP_K_REMISION_CYC			INT,	
	-- ==========================	
	@OU_RESULTADO_VALIDACION	VARCHAR (300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- //////////////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_REMISION_CYC_ES_CANCELABLE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
															@PP_K_REMISION_CYC,	 
															@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- //////////////////////////////////////////////////

	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //CNC//'

	-- //////////////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- //////////////////////////////////////////////////
GO
-- //////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> TR REMISION_CYC CANCELAR
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_TR_REMISION_CYC_CANCELADA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_TR_REMISION_CYC_CANCELADA]
GO

CREATE PROCEDURE [dbo].[PG_TR_REMISION_CYC_CANCELADA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_L_CONTESTA				INT,
	-- ===========================
	@PP_K_REMISION_CYC			INT
AS

	DECLARE	@VP_MENSAJE		VARCHAR(300) = ''

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_REMISION_CYC_CANCELADA]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_REMISION_CYC,
														@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- /////////////////////////////////////////////////////////////////////

	IF @VP_MENSAJE=''
		BEGIN
		-- K_ESTATUS_REMISION_CYC = 1-PENDIENTE / 2-AUTORIZADA / 3-CANCELADA

		UPDATE	REMISION_CYC
		SET		K_ESTATUS_REMISION_CYC	= 3,		-- CANCELADA
				-- ====================
				[F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	REMISION_CYC.K_REMISION_CYC=@PP_K_REMISION_CYC
		
		END


	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible Cancelar la Remisión: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Rem.'+CONVERT(VARCHAR(10),@PP_K_REMISION_CYC)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
				
		END

	IF @PP_L_CONTESTA=1
		SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_REMISION_CYC AS CLAVE

	-- /////////////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													5,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'CANCELADA',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_TR_REMISION_CYC_CANCELADA]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_REMISION_CYC, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, '', '' , 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '', '', ''

	-- /////////////////////////////////////////////////////////////////////
GO
-- /////////////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN REMISION_CYC DESCANCELAR
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_REMISION_CYC_ES_DESCANCELABLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_REMISION_CYC_ES_DESCANCELABLE]
GO

CREATE PROCEDURE [dbo].[PG_RN_REMISION_CYC_ES_DESCANCELABLE]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ==========================
	@PP_K_REMISION_CYC			INT,
	-- ==========================
	@OU_RESULTADO_VALIDACION	VARCHAR (300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_K_ESTATUS_REMISION_CYC		INT
	DECLARE	@VP_D_ESTATUS_REMISION_CYC		VARCHAR(100)
	
	SELECT	@VP_K_ESTATUS_REMISION_CYC =	ESTATUS_REMISION_CYC.K_ESTATUS_REMISION_CYC,
			@VP_D_ESTATUS_REMISION_CYC =	ESTATUS_REMISION_CYC.D_ESTATUS_REMISION_CYC
											FROM	REMISION_CYC, ESTATUS_REMISION_CYC
											WHERE	REMISION_CYC.K_ESTATUS_REMISION_CYC=ESTATUS_REMISION_CYC.K_ESTATUS_REMISION_CYC
											AND		REMISION_CYC.K_REMISION_CYC=@PP_K_REMISION_CYC
	-- =============================

	IF @VP_RESULTADO=''
		IF @VP_K_ESTATUS_REMISION_CYC IS NULL
			SET @VP_RESULTADO =  'No se localizó la [Remisión].' 

	-- =============================
	-- K_ESTATUS_REMISION_CYC	
	-- #1 PENDIENTE | #2 AUTORIZADA | #3 CANCELADA | 

	IF @VP_RESULTADO=''
		IF NOT ( @VP_K_ESTATUS_REMISION_CYC IN ( 3 ) ) 
			SET @VP_RESULTADO =  'El [Estatus#'+CONVERT(VARCHAR(10),@VP_K_ESTATUS_REMISION_CYC)+'-'+@VP_D_ESTATUS_REMISION_CYC+'] de la [Remisión] no lo permite.' 
			
	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO
-- /////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN REMISION_CYC DESCANCELAR
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_REMISION_CYC_DESCANCELADA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_REMISION_CYC_DESCANCELADA]
GO

CREATE PROCEDURE [dbo].[PG_RN_REMISION_CYC_DESCANCELADA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ==========================	
	@PP_K_REMISION_CYC			INT,	
	-- ==========================	
	@OU_RESULTADO_VALIDACION	VARCHAR (300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- //////////////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_REMISION_CYC_ES_DESCANCELABLE]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_K_REMISION_CYC,	 
																@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- //////////////////////////////////////////////////

	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //DCN//'

	-- //////////////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- //////////////////////////////////////////////////
GO
-- //////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> TR REMISION_CYC DESCANCELAR
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_TR_REMISION_CYC_DESCANCELADA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_TR_REMISION_CYC_DESCANCELADA]
GO

CREATE PROCEDURE [dbo].[PG_TR_REMISION_CYC_DESCANCELADA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================
	@PP_L_CONTESTA				INT,
	-- ===========================
	@PP_K_REMISION_CYC			INT
AS

	DECLARE	@VP_MENSAJE		VARCHAR(300) = ''

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_REMISION_CYC_DESCANCELADA]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																	@PP_K_REMISION_CYC,
																	@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- /////////////////////////////////////////////////////////////////////

	IF @VP_MENSAJE=''
		BEGIN
		-- K_ESTATUS_REMISION_CYC = 1-PENDIENTE / 2-AUTORIZADA / 3-CANCELADA

		UPDATE	REMISION_CYC
		SET		K_ESTATUS_REMISION_CYC	= 1,		-- PENDIENTE
				-- ====================
				[F_CAMBIO]				= GETDATE(), 
				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION
		WHERE	REMISION_CYC.K_REMISION_CYC=@PP_K_REMISION_CYC
		
		END


	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible Descancelar la Remisión: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Rem.'+CONVERT(VARCHAR(10),@PP_K_REMISION_CYC)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
				
		END

	IF @PP_L_CONTESTA=1
		SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_REMISION_CYC AS CLAVE

	-- /////////////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													5,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'DESCANCELADA',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_TR_REMISION_CYC_DESCANCELADA]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_REMISION_CYC, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
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