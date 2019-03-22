-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	CYC19_Credito_y_Cobranza
-- // MÓDULO:			REMISION_CYC
-- // OPERACIÓN:		LIBERACIÓN / REGLAS DE NEGOCIO
-- ////////////////////////////////////////////////////////////// 
-- // Autor:			DANIEL PORTILLO ROMERO
-- // Fecha creación:	06/FEB/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> VALIDACIÓN
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_REMISION_CYC_PENDIENTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_REMISION_CYC_PENDIENTE]
GO

CREATE PROCEDURE [dbo].[PG_RN_REMISION_CYC_PENDIENTE]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- =================================		
	@PP_K_REMISION_CYC				INT,
	-- =================================	
	@OU_RESULTADO_VALIDACION		VARCHAR(300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_K_REMISION_CYC			INT
	DECLARE @VP_D_REMISION_CYC			VARCHAR(100)
	
	SELECT	@VP_K_REMISION_CYC =			REMISION_CYC.K_REMISION_CYC,
			@VP_D_REMISION_CYC =			REMISION_CYC.D_REMISION_CYC
											FROM		REMISION_CYC 
											WHERE		REMISION_CYC.K_REMISION_CYC = @PP_K_REMISION_CYC
																
	-- =============================

	IF @VP_RESULTADO = ''
		IF @VP_K_REMISION_CYC IS NULL 
			SET @VP_RESULTADO =  'No se localizó la [Remisión].' 

	-- /////////////////////////////////////////////////////

	DECLARE @VP_K_ESTATUS_REMISION_CYC	INT
	DECLARE @VP_D_ESTATUS_REMISION_CYC	VARCHAR(100)
	
	SELECT	@VP_K_ESTATUS_REMISION_CYC =	ESTATUS_REMISION_CYC.K_ESTATUS_REMISION_CYC,
			@VP_D_ESTATUS_REMISION_CYC =	ESTATUS_REMISION_CYC.D_ESTATUS_REMISION_CYC
											FROM		REMISION_CYC 
											INNER JOIN	ESTATUS_REMISION_CYC ON REMISION_CYC.K_ESTATUS_REMISION_CYC = ESTATUS_REMISION_CYC.K_ESTATUS_REMISION_CYC
											WHERE		REMISION_CYC.K_REMISION_CYC = @PP_K_REMISION_CYC
																
	-- =============================
	-- K_ESTATUS_REMISION_CYC	
	-- // 1 PENDIENTE / 2 AUTORIZADA / 3 CANCELADA
	IF @VP_RESULTADO = ''
		IF NOT ( @VP_K_ESTATUS_REMISION_CYC IN ( 1 ) ) 
			SET @VP_RESULTADO =  'El [Estatus#'+CONVERT(VARCHAR(10),@VP_K_ESTATUS_REMISION_CYC)+'-'+@VP_D_ESTATUS_REMISION_CYC+'] de la [Remisión '+CONVERT(VARCHAR(10),@VP_D_REMISION_CYC)+'] no lo permite.' 
			
	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO





-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_BORRABLE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_REMISION_CYC_EXISTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_REMISION_CYC_EXISTE]
GO

CREATE PROCEDURE [dbo].[PG_RN_REMISION_CYC_EXISTE]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ==================================		
	@PP_K_REMISION_CYC				INT,
	-- ==================================		
	@OU_RESULTADO_VALIDACION		VARCHAR(300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_K_REMISION_CYC		INT
	DECLARE @VP_L_BORRADO			INT
		
	SELECT	@VP_K_REMISION_CYC =	REMISION_CYC.K_REMISION_CYC,
			@VP_L_BORRADO =			REMISION_CYC.L_BORRADO
									FROM	REMISION_CYC
									WHERE	REMISION_CYC.K_REMISION_CYC = @PP_K_REMISION_CYC										
	-- ===========================

	IF @VP_RESULTADO=''
		IF ( @VP_K_REMISION_CYC IS NULL )
			SET @VP_RESULTADO =  'La [Remisión] no existe.' 
	
	-- ===========================

	IF @VP_RESULTADO=''
		IF @VP_L_BORRADO=1
			SET @VP_RESULTADO =  'La [Remisión] fue dada de baja.' 
					
	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> VALIDACIÓN DESCRIPCIÓN
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_REMISION_CYC_DESCRIPCION_EXISTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_REMISION_CYC_DESCRIPCION_EXISTE]
GO

CREATE PROCEDURE [dbo].[PG_RN_REMISION_CYC_DESCRIPCION_EXISTE]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- =================================		
	@PP_K_REMISION_CYC				INT,	
	@PP_D_REMISION_CYC				VARCHAR(255),
	-- =================================	
	@OU_RESULTADO_VALIDACION		VARCHAR(300)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300) = ''
		
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO='' 
		BEGIN
			DECLARE @VP_EXISTE_DESC		INT = 0

			SELECT	@VP_EXISTE_DESC =	COUNT(	D_REMISION_CYC	)
										FROM	REMISION_CYC 
										WHERE	D_REMISION_CYC = @PP_D_REMISION_CYC
										AND		K_REMISION_CYC <> @PP_K_REMISION_CYC
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_REMISION_CYC_DELETE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_REMISION_CYC_DELETE]
GO

CREATE PROCEDURE [dbo].[PG_RN_REMISION_CYC_DELETE]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- =================================		
	@PP_K_REMISION_CYC				INT,	
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
		EXECUTE [dbo].[PG_RN_REMISION_CYC_EXISTE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_REMISION_CYC,	 
													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_REMISION_CYC_PENDIENTE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_REMISION_CYC,	 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_REMISION_CYC_INSERT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_REMISION_CYC_INSERT]
GO

CREATE PROCEDURE [dbo].[PG_RN_REMISION_CYC_INSERT]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- =================================		
	@PP_K_REMISION_CYC				INT,
	@PP_D_REMISION_CYC				VARCHAR(255),
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
		EXECUTE [dbo].[PG_RN_REMISION_CYC_DESCRIPCION_EXISTE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
																@PP_K_REMISION_CYC, @PP_D_REMISION_CYC,	 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_REMISION_CYC_UPDATE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_REMISION_CYC_UPDATE]
GO

CREATE PROCEDURE [dbo].[PG_RN_REMISION_CYC_UPDATE]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- =================================		
	@PP_K_REMISION_CYC				INT,	
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
		EXECUTE [dbo].[PG_RN_REMISION_CYC_EXISTE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_REMISION_CYC,	 
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
