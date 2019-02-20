-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_04.c_RN_Producto
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			PRODUCTO 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_PRODUCTO_ES_BORRABLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_PRODUCTO_ES_BORRABLE]
GO


CREATE PROCEDURE [dbo].[PG_RN_PRODUCTO_ES_BORRABLE]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_PRODUCTO						[INT],
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300)
	
	SET		@VP_RESULTADO	= ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_N_CONDICIONES_COMERCIALES_X_PRODUCTO	INT = 0

	DECLARE @VP_N_PRECIOS_X_PRODUCTO					INT = 0

	SELECT	@VP_N_CONDICIONES_COMERCIALES_X_PRODUCTO =	COUNT(PRODUCTO.K_PRODUCTO)
														FROM	PRODUCTO,CONDICION_COMERCIAL
														WHERE	PRODUCTO.K_PRODUCTO=CONDICION_COMERCIAL.K_PRODUCTO	
														AND		PRODUCTO.K_PRODUCTO=@PP_K_PRODUCTO	

	SELECT	@VP_N_PRECIOS_X_PRODUCTO				=	COUNT(PRODUCTO.K_PRODUCTO)
														FROM	PRODUCTO,PRECIO
														WHERE	PRODUCTO.K_PRODUCTO=PRECIO.K_PRODUCTO	
														AND		PRODUCTO.K_PRODUCTO=@PP_K_PRODUCTO	
					
	-- =============================
	IF @VP_RESULTADO=''
		IF (@VP_N_CONDICIONES_COMERCIALES_X_PRODUCTO > 0)
			SET @VP_RESULTADO =  'Existen [Condiciones Comerciales('+CONVERT(VARCHAR(10),@VP_N_CONDICIONES_COMERCIALES_X_PRODUCTO)+')] asignados a este [Producto].' 

	IF @VP_RESULTADO=''
		IF (@VP_N_PRECIOS_X_PRODUCTO > 0)
			SET @VP_RESULTADO =  'Existen [Precios('+CONVERT(VARCHAR(10),@VP_N_PRECIOS_X_PRODUCTO)+')] asignados a este [Producto].' 
			
	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_BORRABLE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_PRODUCTO_EXISTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_PRODUCTO_EXISTE]
GO


CREATE PROCEDURE [dbo].[PG_RN_PRODUCTO_EXISTE]
	@PP_L_DEBUG					[INT],
	@PP_K_SISTEMA_EXE			[INT],
	@PP_K_USUARIO_ACCION		[INT],
	-- ===========================		
	@PP_K_PRODUCTO				[INT],
	-- ===========================		
	@OU_RESULTADO_VALIDACION	[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300)
	
	SET		@VP_RESULTADO	= ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_K_PRODUCTO		INT
	DECLARE @VP_L_BORRADO		INT
		
	SELECT	@VP_K_PRODUCTO =	PRODUCTO.K_PRODUCTO,
			@VP_L_BORRADO =		PRODUCTO.L_BORRADO
								FROM	PRODUCTO
								WHERE	PRODUCTO.K_PRODUCTO=@PP_K_PRODUCTO 						

	-- ===========================

	IF @VP_RESULTADO=''
		IF ( @VP_K_PRODUCTO IS NULL )
			SET @VP_RESULTADO =  'El [PRODUCTO] no existe.' 
	
	-- ===========================

	IF @VP_RESULTADO=''
		IF @VP_L_BORRADO=1
			SET @VP_RESULTADO =  'El [PRODUCTO] fue dado de baja.' 
					
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_PRODUCTO_INSERT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_PRODUCTO_INSERT]
GO


CREATE PROCEDURE [dbo].[PG_RN_PRODUCTO_INSERT]
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_PRODUCTO_UPDATE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_PRODUCTO_UPDATE]
GO


CREATE PROCEDURE [dbo].[PG_RN_PRODUCTO_UPDATE]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_PRODUCTO						[INT],	
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
		EXECUTE [dbo].[PG_RN_PRODUCTO_EXISTE]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_PRODUCTO,	 
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_PRODUCTO_DELETE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_PRODUCTO_DELETE]
GO


CREATE PROCEDURE [dbo].[PG_RN_PRODUCTO_DELETE]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_PRODUCTO						[INT],	
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
		EXECUTE [dbo].[PG_RN_PRODUCTO_EXISTE]			@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_PRODUCTO,	 
														@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_PRODUCTO_ES_BORRABLE]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_PRODUCTO,	 
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
