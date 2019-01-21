-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	ADG18_AdministradoraGas
-- // MODULO:			TRANSACCION 
-- // OPERACION:		LIBERACION / REGLAS NEGOCIO
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		HECTOR GONZALEZ DE LA FUENTE
-- // FECHA:		25/OCT/2018
-- ////////////////////////////////////////////////////////////// 

USE [ADG18_AdministradoraGas_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////


-- //////////////////////////////////////////////////////////////






-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_BORRABLE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_TRANSACCION_ES_BORRABLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_TRANSACCION_ES_BORRABLE]
GO


CREATE PROCEDURE [dbo].[PG_RN_TRANSACCION_ES_BORRABLE]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_TRANSACCION					[INT],
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300)
	
	SET		@VP_RESULTADO	= ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_N_CASOS_X_TRANSACCION					INT = 0
/*		
	SELECT	@VP_N_UNIDAD_OPERATIVA_X_TRANSACCION =		COUNT(XXXX)
														FROM	TRANSACCION, UNIDAD_OPERATIVA
														WHERE	UNIDAD_OPERATIVA.K_TRANSACCION=TRANSACCION.K_TRANSACCION	
														AND		TRANSACCION.K_TRANSACCION=@PP_K_TRANSACCION										
*/
	-- =============================

	IF @VP_RESULTADO=''
		IF @VP_N_CASOS_X_TRANSACCION>0
			SET @VP_RESULTADO =  'Existen [Sucursales] asignadas a esta Transacción.' 
			
	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_BORRABLE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_TRANSACCION_EXISTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_TRANSACCION_EXISTE]
GO


CREATE PROCEDURE [dbo].[PG_RN_TRANSACCION_EXISTE]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_TRANSACCION					[INT],
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300)
	
	SET		@VP_RESULTADO	= ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_K_TRANSACCION		INT
	DECLARE @VP_L_BORRADO			INT
		
	SELECT	@VP_K_TRANSACCION =		TRANSACCION.K_TRANSACCION,
			@VP_L_BORRADO =			TRANSACCION.L_BORRADO
									FROM	TRANSACCION
									WHERE	TRANSACCION.K_TRANSACCION=@PP_K_TRANSACCION										

	-- ===========================

	IF @VP_RESULTADO=''
		IF ( @VP_K_TRANSACCION IS NULL )
			SET @VP_RESULTADO =  'La [Transacción] no existe.' 
	
	-- ===========================

	IF @VP_RESULTADO=''
		IF @VP_L_BORRADO=1
			SET @VP_RESULTADO =  'La [Transacción] fue dada de baja.' 
					
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_TRANSACCION_INSERT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_TRANSACCION_INSERT]
GO


CREATE PROCEDURE [dbo].[PG_RN_TRANSACCION_INSERT]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_TRANSACCION					[INT],	
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_TRANSACCION_UPDATE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_TRANSACCION_UPDATE]
GO


CREATE PROCEDURE [dbo].[PG_RN_TRANSACCION_UPDATE]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_TRANSACCION					[INT],	
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
		EXECUTE [dbo].[PG_RN_TRANSACCION_EXISTE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_TRANSACCION,	 
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_TRANSACCION_DELETE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_TRANSACCION_DELETE]
GO


CREATE PROCEDURE [dbo].[PG_RN_TRANSACCION_DELETE]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_TRANSACCION					[INT],	
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
		EXECUTE [dbo].[PG_RN_TRANSACCION_EXISTE]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_TRANSACCION,	 
														@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_TRANSACCION_ES_BORRABLE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_TRANSACCION,	 
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
