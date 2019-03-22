-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_05.b_RN_TASA_IMPUESTO
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			TASA_IMPUESTO 
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
-- // STORED PROCEDURE ---> RN PARA VALIDAR QUE SE ENCUENTE UNA TASA_IMPUESTO VIGENTE PARA LA TABLA PRECIO/RECIBO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_TASA_IMPUESTO_VIGENTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_TASA_IMPUESTO_VIGENTE]
GO


CREATE PROCEDURE [dbo].[PG_RN_TASA_IMPUESTO_VIGENTE]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],	
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300)
	
	SET		@VP_RESULTADO	= ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_N_TASA_IMPUESTO_VIGENTE	INT
	--DECLARE @GETDATE DATE
	--SET @GETDATE ='2019-08-21'
	SET @VP_N_TASA_IMPUESTO_VIGENTE = (		SELECT	COUNT(K_TASA_IMPUESTO)
											FROM	TASA_IMPUESTO
											WHERE	F_VIGENCIA_INICIO<=GETDATE()
											AND		F_VIGENCIA_FIN>=GETDATE()		)

	-- =============================
	IF @VP_RESULTADO=''
		IF @VP_N_TASA_IMPUESTO_VIGENTE = 0
			SET @VP_RESULTADO =  '[No Existen Tasa de impuesto vigentes.]' 

	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO







-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_VALIDA_FECHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_TASA_IMPUESTO_VALIDA_FECHA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_TASA_IMPUESTO_VALIDA_FECHA]
GO


CREATE PROCEDURE [dbo].[PG_RN_TASA_IMPUESTO_VALIDA_FECHA]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_F_VIGENCIA_INICIO				[DATE],
	@PP_F_VIGENCIA_FIN					[DATE],
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300)
	
	SET		@VP_RESULTADO	= ''
		
	-- /////////////////////////////////////////////////////

	


	-- =============================
	IF @VP_RESULTADO=''
		IF @PP_F_VIGENCIA_INICIO > @PP_F_VIGENCIA_FIN
			SET @VP_RESULTADO =  'La [Fecha Inicio:('+CONVERT(VARCHAR(10),@PP_F_VIGENCIA_INICIO)+')] no debe ser mayor a la Fecha Fin.' 

	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO






-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_BORRABLE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_TASA_IMPUESTO_ES_BORRABLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_TASA_IMPUESTO_ES_BORRABLE]
GO


CREATE PROCEDURE [dbo].[PG_RN_TASA_IMPUESTO_ES_BORRABLE]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_TASA_IMPUESTO					[INT],
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300)
	
	SET		@VP_RESULTADO	= ''
		
	-- /////////////////////////////////////////////////////

	DECLARE @VP_N_VIGENCIA_X_TASA_IMPUESTO	INT = 0

	SELECT	@VP_N_VIGENCIA_X_TASA_IMPUESTO	=	COUNT(K_TASA_IMPUESTO)
												FROM	TASA_IMPUESTO
												WHERE	F_VIGENCIA_INICIO>=GETDATE()
												AND		F_VIGENCIA_FIN<=GETDATE()
												AND		K_TASA_IMPUESTO=@PP_K_TASA_IMPUESTO			
	-- =============================
	IF @VP_RESULTADO=''
		IF (@VP_N_VIGENCIA_X_TASA_IMPUESTO > 0) 
			SET @VP_RESULTADO =  'La [Tasa('+CONVERT(VARCHAR(10),@PP_K_TASA_IMPUESTO)+')] se encuentra vigente.' 
	-- /////////////////////////////////////////////////////
	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_BORRABLE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_TASA_IMPUESTO_EXISTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_TASA_IMPUESTO_EXISTE]
GO


CREATE PROCEDURE [dbo].[PG_RN_TASA_IMPUESTO_EXISTE]
	@PP_L_DEBUG					[INT],
	@PP_K_SISTEMA_EXE			[INT],
	@PP_K_USUARIO_ACCION		[INT],
	-- ===========================		
	@PP_K_TASA_IMPUESTO			[INT],
	-- ===========================		
	@OU_RESULTADO_VALIDACION	[VARCHAR] (200)		OUTPUT
AS

	DECLARE @VP_RESULTADO	VARCHAR(300)
	
	SET		@VP_RESULTADO	= ''
		
	-- /////////////////////////////////////////////////////
	
	DECLARE @VP_K_TASA_IMPUESTO		INT
	DECLARE @VP_L_BORRADO			INT
		
	SELECT	@VP_K_TASA_IMPUESTO =	TASA_IMPUESTO.K_TASA_IMPUESTO,
			@VP_L_BORRADO		=	TASA_IMPUESTO.L_BORRADO
									FROM	TASA_IMPUESTO
									WHERE	TASA_IMPUESTO.K_TASA_IMPUESTO=@PP_K_TASA_IMPUESTO 						

	-- ===========================

	IF @VP_RESULTADO=''
		IF ( @VP_K_TASA_IMPUESTO IS NULL )
			SET @VP_RESULTADO =  'El [TASA_IMPUESTO] no existe.' 
	
	-- ===========================

	IF @VP_RESULTADO=''
		IF @VP_L_BORRADO=1
			SET @VP_RESULTADO =  'El [TASA_IMPUESTO] fue dado de baja.' 
					
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_TASA_IMPUESTO_INSERT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_TASA_IMPUESTO_INSERT]
GO


CREATE PROCEDURE [dbo].[PG_RN_TASA_IMPUESTO_INSERT]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================
	@PP_F_VIGENCIA_INICIO				DATE,
	@PP_F_VIGENCIA_FIN					DATE,
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
	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_TASA_IMPUESTO_VALIDA_FECHA]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
															@PP_F_VIGENCIA_INICIO, @PP_F_VIGENCIA_FIN,	
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_TASA_IMPUESTO_UPDATE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_TASA_IMPUESTO_UPDATE]
GO


CREATE PROCEDURE [dbo].[PG_RN_TASA_IMPUESTO_UPDATE]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_TASA_IMPUESTO					[INT],	
	@PP_F_VIGENCIA_INICIO				DATE,
	@PP_F_VIGENCIA_FIN					DATE,
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
		EXECUTE [dbo].[PG_RN_TASA_IMPUESTO_EXISTE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_TASA_IMPUESTO,	 
													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- //////////////////////////////////////
	IF @VP_RESULTADO=''
	EXECUTE [dbo].[PG_RN_TASA_IMPUESTO_VALIDA_FECHA]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
														@PP_F_VIGENCIA_INICIO, @PP_F_VIGENCIA_FIN,	
														@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT

	-- ///////////////////////////////////////////
	
	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //UPD//'
	
	-- ///////////////////////////////////////////
		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO

	-- /////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> VALIDACION DELETE
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_TASA_IMPUESTO_DELETE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_TASA_IMPUESTO_DELETE]
GO


CREATE PROCEDURE [dbo].[PG_RN_TASA_IMPUESTO_DELETE]
	@PP_L_DEBUG							[INT],
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_TASA_IMPUESTO					[INT],	
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
		EXECUTE [dbo].[PG_RN_TASA_IMPUESTO_EXISTE]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_TASA_IMPUESTO,	 
														@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////

	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_TASA_IMPUESTO_ES_BORRABLE]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
															@PP_K_TASA_IMPUESTO,	 
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
