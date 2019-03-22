-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_01.c_RN_FICHA_AUTOTANQUE
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidacioness
-- // MODULO:			FICHA_AUTOTANQUE 
-- // OPERACION:		LIBERACION / REGLAS NEGOCIO
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		JESUS ARCINIEGA
-- // FECHA:		29/ENE/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0]  
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_EXISTE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_FICHA_AUTOTANQUE_EXISTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_FICHA_AUTOTANQUE_EXISTE]
GO


CREATE PROCEDURE [dbo].[PG_RN_FICHA_AUTOTANQUE_EXISTE]
	@PP_L_DEBUG					[INT],
	@PP_K_SISTEMA_EXE			[INT],
	@PP_K_USUARIO_ACCION		[INT],
	-- ===========================		
	@PP_K_FICHA_AUTOTANQUE				[INT],
	-- ===========================		
	@OU_RESULTADO_VALIDACION	[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300)
	
	SET		@VP_RESULTADO	= ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_K_FICHA_AUTOTANQUE		INT
		
	SELECT	@VP_K_FICHA_AUTOTANQUE =	FICHA_AUTOTANQUE.K_FICHA_AUTOTANQUE
								FROM	FICHA_AUTOTANQUE
								WHERE	FICHA_AUTOTANQUE.K_FICHA_AUTOTANQUE=@PP_K_FICHA_AUTOTANQUE 						

	-- ===========================

	IF @VP_RESULTADO=''
		IF ( @VP_K_FICHA_AUTOTANQUE IS NULL )
			SET @VP_RESULTADO =  'El [FICHA_AUTOTANQUE] no existe.' 

					
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_FICHA_AUTOTANQUE_INSERT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_FICHA_AUTOTANQUE_INSERT]
GO


CREATE PROCEDURE [dbo].[PG_RN_FICHA_AUTOTANQUE_INSERT]
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_FICHA_AUTOTANQUE_UPDATE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_FICHA_AUTOTANQUE_UPDATE]
GO


CREATE PROCEDURE [dbo].[PG_RN_FICHA_AUTOTANQUE_UPDATE]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_FICHA_AUTOTANQUE			[INT],	
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
		EXECUTE [dbo].[PG_RN_FICHA_AUTOTANQUE_EXISTE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_FICHA_AUTOTANQUE,	 
													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- //////////////////////////////////////
	
	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //UPD//'
	
	-- ///////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////