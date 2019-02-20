-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_01.NN.b_RN_Cliente
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CLIENTE 
-- // OPERACION:		LIBERACION / REGLAS NEGOCIO
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		JESUS ARCINIEGA
-- // FECHA:		14/FEB/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////


-- //////////////////////////////////////////////////////////////






-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_BORRABLE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_CLIENTE_ES_BORRABLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_CLIENTE_ES_BORRABLE]
GO


CREATE PROCEDURE [dbo].[PG_RN_CLIENTE_ES_BORRABLE]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_CLIENTE						[INT],
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300)
	
	SET		@VP_RESULTADO	= ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_N_CARGOS_X_CLIENTE			INT = 0
	DECLARE @VP_N_RECIBOS_X_CLIENTE			INT = 0
	DECLARE @VP_N_PAGOS_X_CLIENTE			INT = 0

	SELECT	@VP_N_CARGOS_X_CLIENTE =		COUNT(CLIENTE.K_CLIENTE)
											FROM	CLIENTE,CARGO
											WHERE	CLIENTE.K_CLIENTE=CARGO.K_CLIENTE	
											AND		CLIENTE.K_CLIENTE=@PP_K_CLIENTE	
											AND		K_ESTATUS_CARGO =1 -- ACTIVO

	SELECT	@VP_N_RECIBOS_X_CLIENTE =		COUNT(CLIENTE.K_CLIENTE)
											FROM	CLIENTE,RECIBO
											WHERE	CLIENTE.K_CLIENTE=RECIBO.K_CLIENTE	
											AND		CLIENTE.K_CLIENTE=@PP_K_CLIENTE	
											AND		K_ESTATUS_RECIBO=1 -- ACTIVO

	SELECT	@VP_N_PAGOS_X_CLIENTE =			COUNT(CLIENTE.K_CLIENTE)
											FROM	CLIENTE,PAGO
											WHERE	CLIENTE.K_CLIENTE=PAGO.K_CLIENTE	
											AND		CLIENTE.K_CLIENTE=@PP_K_CLIENTE	
											AND		K_ESTATUS_PAGO=1 -- ACTIVO
					
	-- =============================

	IF @VP_RESULTADO=''
		IF (@VP_N_CARGOS_X_CLIENTE > 0)
			SET @VP_RESULTADO =  'Existen [Cargos('+CONVERT(VARCHAR(10),@VP_N_CARGOS_X_CLIENTE)+')] asignados a este [CLIENTE].' 

	IF @VP_RESULTADO=''
		IF (@VP_N_RECIBOS_X_CLIENTE > 0)
			SET @VP_RESULTADO =  'Existen [Recibos('+CONVERT(VARCHAR(10),@VP_N_RECIBOS_X_CLIENTE)+')] asignados a este [CLIENTE].' 
	
	IF @VP_RESULTADO=''
		IF (@VP_N_PAGOS_X_CLIENTE > 0)
			SET @VP_RESULTADO =  'Existen [Pagos('+CONVERT(VARCHAR(10),@VP_N_PAGOS_X_CLIENTE)+')] asignados a este [CLIENTE].'
	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_BORRABLE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_CLIENTE_EXISTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_CLIENTE_EXISTE]
GO


CREATE PROCEDURE [dbo].[PG_RN_CLIENTE_EXISTE]
	@PP_L_DEBUG					[INT],
	@PP_K_SISTEMA_EXE			[INT],
	@PP_K_USUARIO_ACCION		[INT],
	-- ===========================		
	@PP_K_CLIENTE				[INT],
	-- ===========================		
	@OU_RESULTADO_VALIDACION	[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300)
	
	SET		@VP_RESULTADO	= ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_K_CLIENTE		INT
	DECLARE @VP_L_BORRADO		INT
		
	SELECT	@VP_K_CLIENTE =		CLIENTE.K_CLIENTE,
			@VP_L_BORRADO =		CLIENTE.L_BORRADO
								FROM	CLIENTE
								WHERE	CLIENTE.K_CLIENTE=@PP_K_CLIENTE 						

	-- ===========================

	IF @VP_RESULTADO=''
		IF ( @VP_K_CLIENTE IS NULL )
			SET @VP_RESULTADO =  'El [CLIENTE] no existe.' 
	
	-- ===========================

	IF @VP_RESULTADO=''
		IF @VP_L_BORRADO=1
			SET @VP_RESULTADO =  'El [CLIENTE] fue dado de baja.' 
					
	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO



-- ====================================================================================================
-- ====================================================================================================
-- ////////////////////////////////////////////////////////////////////////////////////////////////////
-- ====================================================================================================
-- ====================================================================================================



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> VALIDACION INSERT
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_CLIENTE_INSERT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_CLIENTE_INSERT]
GO


CREATE PROCEDURE [dbo].[PG_RN_CLIENTE_INSERT]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300)
	
	SET		@VP_RESULTADO	= ''
		
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_INSERT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													1, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////



	-- ///////////////////////////////////////////
	
	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //INS//'
	
	-- ///////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> VALIDACION UPDATE
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_CLIENTE_UPDATE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_CLIENTE_UPDATE]
GO


CREATE PROCEDURE [dbo].[PG_RN_CLIENTE_UPDATE]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_CLIENTE						[INT],	
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300)
	
	SET		@VP_RESULTADO	= ''
		
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_UPDATE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													1, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- //////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_CLIENTE_EXISTE]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_CLIENTE,	 
													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- //////////////////////////////////////
	
	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //UPD//'
	
	-- ///////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> VALIDACION DELETE
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_CLIENTE_DELETE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_CLIENTE_DELETE]
GO


CREATE PROCEDURE [dbo].[PG_RN_CLIENTE_DELETE]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_CLIENTE						[INT],	
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300)
	
	SET		@VP_RESULTADO	= ''
		
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_DELETE]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
														1, -- @PP_K_DATA_SISTEMA,	
														@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_CLIENTE_EXISTE]			@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_CLIENTE,	 
														@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_CLIENTE_ES_BORRABLE]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_CLIENTE,	 
														@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////

	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //DEL//'
	
	-- ///////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO



-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
