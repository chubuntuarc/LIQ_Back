-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	
-- // MÓDULO:			CLIENTE_TMK
-- // OPERACIÓN:		LIBERACIÓN / REGLAS DE NEGOCIO
-- ////////////////////////////////////////////////////////////// 
-- // Autor:			
-- // Fecha creación:
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> VALIDACIÓN
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_CLIENTE_TMK_ACTIVO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_ACTIVO]
GO

CREATE PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_ACTIVO]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- =================================		
	@PP_K_CLIENTE_TMK				INT,
	-- =================================	
	@OU_RESULTADO_VALIDACION		VARCHAR(300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_K_CLIENTE_TMK			INT
	DECLARE @VP_D_CLIENTE_TMK			VARCHAR(100)
	DECLARE @VP_K_ESTATUS_CLIENTE_TMK	INT
	DECLARE @VP_D_ESTATUS_CLIENTE_TMK	VARCHAR(100)
	
	SELECT	@VP_K_CLIENTE_TMK =			CLIENTE_TMK.K_CLIENTE_TMK,
			@VP_D_CLIENTE_TMK =			CLIENTE_TMK.D_CLIENTE_TMK,
			@VP_K_ESTATUS_CLIENTE_TMK = ESTATUS_CLIENTE_TMK.K_ESTATUS_CLIENTE_TMK,
			@VP_D_ESTATUS_CLIENTE_TMK = ESTATUS_CLIENTE_TMK.D_ESTATUS_CLIENTE_TMK
										FROM		CLIENTE_TMK 
										INNER JOIN	ESTATUS_CLIENTE_TMK ON CLIENTE_TMK.K_ESTATUS_CLIENTE_TMK = ESTATUS_CLIENTE_TMK.K_ESTATUS_CLIENTE_TMK
										WHERE		CLIENTE_TMK.K_ESTATUS_CLIENTE_TMK = 1 -- 1 = ACTIVA
										AND			CLIENTE_TMK.K_CLIENTE_TMK = @PP_K_CLIENTE_TMK
																
	-- =============================

	IF @VP_RESULTADO = ''
		IF @VP_K_CLIENTE_TMK IS NULL 
			SET @VP_RESULTADO =  'No se localizó el [Cliente] de CYC.' 

	-- =============================
	-- K_ESTATUS_CLIENTE_TMK	
	-- // 0 INACTIVO / 1 ACTIVO / 2 DEUDOR
	IF @VP_RESULTADO = ''
		IF NOT ( @VP_K_ESTATUS_CLIENTE_TMK IN ( 1 ) ) 
			SET @VP_RESULTADO =  'El [Estatus#'+CONVERT(VARCHAR(10),@VP_K_ESTATUS_CLIENTE_TMK)+'-'+@VP_D_ESTATUS_CLIENTE_TMK+'] del [Cliente '+CONVERT(VARCHAR(10),@VP_D_CLIENTE_TMK)+'] de CYC no lo permite.' 
			
	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_BORRABLE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_CLIENTE_TMK_EXISTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_EXISTE]
GO

CREATE PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_EXISTE]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ==================================		
	@PP_K_CLIENTE_TMK				INT,
	-- ==================================		
	@OU_RESULTADO_VALIDACION		VARCHAR(300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_K_CLIENTE_TMK	INT
	DECLARE @VP_L_BORRADO		INT
		
	SELECT	@VP_K_CLIENTE_TMK =	CLIENTE_TMK.K_CLIENTE_TMK,
			@VP_L_BORRADO =		CLIENTE_TMK.L_BORRADO
								FROM	CLIENTE_TMK
								WHERE	CLIENTE_TMK.K_CLIENTE_TMK = @PP_K_CLIENTE_TMK										
	-- ===========================

	IF @VP_RESULTADO=''
		IF ( @VP_K_CLIENTE_TMK IS NULL )
			SET @VP_RESULTADO =  'El [Cliente] de CYC no existe.' 
	
	-- ===========================

	IF @VP_RESULTADO=''
		IF @VP_L_BORRADO=1
			SET @VP_RESULTADO =  'El [Cliente] de CYC fue dado de baja.' 
					
	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> VALIDACIÓN DESCRIPCIÓN
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_CLIENTE_TMK_DESCRIPCION_EXISTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_DESCRIPCION_EXISTE]
GO

CREATE PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_DESCRIPCION_EXISTE]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- =================================		
	@PP_K_CLIENTE_TMK				INT,	
	@PP_D_CLIENTE_TMK				VARCHAR(255),
	-- =================================	
	@OU_RESULTADO_VALIDACION		VARCHAR(300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO='' 
		BEGIN
			DECLARE @VP_EXISTE_DESC		INT = 0

			SELECT	@VP_EXISTE_DESC =	COUNT(	D_CLIENTE_TMK	)
										FROM	CLIENTE_TMK 
										WHERE	D_CLIENTE_TMK = @PP_D_CLIENTE_TMK
										AND		K_CLIENTE_TMK <> @PP_K_CLIENTE_TMK
			IF @VP_EXISTE_DESC > 0
				SET	@VP_RESULTADO = @VP_RESULTADO +CHAR(13)+CHAR(10) + 'La descripción ya existe'
		END	
		
	-- ///////////////////////////////////////////
	
	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //DESC//'
	
	-- ///////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> VALIDACIÓN DELETE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_CLIENTE_TMK_DELETE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_DELETE]
GO

CREATE PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_DELETE]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- =================================		
	@PP_K_CLIENTE_TMK				INT,	
	-- =================================
	@OU_RESULTADO_VALIDACION		VARCHAR(300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''

	-- ///////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_DELETE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													11, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT		
	-- ///////////////////////////////////////////
	
	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_CLIENTE_TMK_EXISTE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_CLIENTE_TMK,	 
													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_CLIENTE_TMK_ACTIVO]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_CLIENTE_TMK,	 
													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////

	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //DEL//'
	
	-- ///////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> VALIDACION INSERT
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_CLIENTE_TMK_INSERT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_INSERT]
GO

CREATE PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_INSERT]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- =================================		
	@PP_K_CLIENTE_TMK				INT,
	@PP_D_CLIENTE_TMK				VARCHAR(255),
	-- =================================
	@OU_RESULTADO_VALIDACION		VARCHAR(300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
	
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_INSERT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													11, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT		
	-- ///////////////////////////////////////////
	
	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_CLIENTE_TMK_DESCRIPCION_EXISTE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_K_CLIENTE_TMK, @PP_D_CLIENTE_TMK,	 
																@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT	
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_CLIENTE_TMK_UPDATE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_UPDATE]
GO

CREATE PROCEDURE [dbo].[PG_RN_CLIENTE_TMK_UPDATE]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- =================================		
	@PP_K_CLIENTE_TMK				INT,	
	-- =================================
	@OU_RESULTADO_VALIDACION		VARCHAR(300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
	
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_UPDATE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													11, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT		
	-- ///////////////////////////////////////////
	
	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_CLIENTE_TMK_EXISTE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_CLIENTE_TMK,	 
													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////
	
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
