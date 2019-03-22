-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			ADG18_R100_15.a_SP_Sitio_Usuario_X_UO
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	ADG18_AdministradoraGas
-- // MODULO:			SITIO 
-- // OPERACION:		LIBERACION / STORED PROCEDURES 
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		FRANCISCO ESTEBAN
-- // FECHA:		21/FEB/2019
-- ////////////////////////////////////////////////////////////// 

USE [ADG18_AdministradoraGas_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
-- SELECT * FROM SITIO_USUARIO_X_UO

-- DELETE FROM SITIO_USUARIO_X_UO

-- EXECUTE [PG_IN_SITIO_USUARIO_X_UO_X_K_USUARIO] 0,0,0, 69

-- EXECUTE [PG_LI_SITIO_USUARIO_X_UO_X_K_USUARIO] 0,0,0, 69

-- SELECT * FROM SITIO_USUARIO_X_UO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_SITIO_USUARIO_X_UO_X_K_USUARIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_SITIO_USUARIO_X_UO_X_K_USUARIO]
GO


CREATE PROCEDURE [dbo].[PG_LI_SITIO_USUARIO_X_UO_X_K_USUARIO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================	
	@PP_K_USUARIO				INT
	-- ============================		
AS	
	DECLARE @VP_MENSAJE		VARCHAR(300)

	SET		@VP_MENSAJE		= ''
	
	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_SELECT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													1, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT	

	-- ///////////////////////////////////////////
		
	DECLARE @VP_L_APLICAR_MAX_ROWS	INT=1
	DECLARE @VP_LI_N_REGISTROS		INT

	EXECUTE [dbo].[PG_SK_CONFIGURACION_LI_N_REGISTROS_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
															@VP_L_APLICAR_MAX_ROWS,
															@OU_LI_N_REGISTROS = @VP_LI_N_REGISTROS		OUTPUT		
	-- =========================================	

	IF @VP_MENSAJE<>''
		SET @VP_LI_N_REGISTROS = 0
	
	-- =========================================		

	--DECLARE @VP_K_FOLIO		INT

	--EXECUTE [dbo].[PG_RN_OBTENER_ID_X_REFERENCIA]	@PP_BUSCAR, 
	--												@OU_K_ELEMENTO = @VP_K_FOLIO	OUTPUT
	-- =========================================
	
	DECLARE @VP_L_VER_BORRADOS		[INT]		
	
	EXECUTE [dbo].[PG_RN_DATA_VER_BORRADOS]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@OU_L_VER_BORRADOS = @VP_L_VER_BORRADOS			OUTPUT

	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	-- SELECT * FROM USUARIO
	SELECT	TOP ( @VP_LI_N_REGISTROS )
			SITIO_USUARIO_X_UO.*,
			-- ==============================
			D_UNIDAD_OPERATIVA, S_UNIDAD_OPERATIVA,
			-- ==============================
			(SELECT D_USUARIO AS D_USUARIO FROM USUARIO WHERE USUARIO.K_USUARIO= SITIO_USUARIO_X_UO.K_USUARIO),
			(SELECT D_USUARIO AS D_USUARIO_CAMBIO FROM USUARIO WHERE USUARIO.K_USUARIO= SITIO_USUARIO_X_UO.K_USUARIO_CAMBIO)
			-- ==============================
	FROM	SITIO_USUARIO_X_UO,
			UNIDAD_OPERATIVA, USUARIO
			-- ==============================
	WHERE	SITIO_USUARIO_X_UO.K_UNIDAD_OPERATIVA=UNIDAD_OPERATIVA.K_UNIDAD_OPERATIVA
	--AND		SITIO_USUARIO_X_UO.K_USUARIO=USUARIO.K_USUARIO
	--OR		SITIO_USUARIO_X_UO.K_USUARIO_CAMBIO=USUARIO.K_USUARIO_CAMBIO
			-- ==============================
	AND		(	@PP_K_USUARIO=-1			OR  SITIO_USUARIO_X_UO.K_USUARIO=@PP_K_USUARIO )

	ORDER BY K_UNIDAD_OPERATIVA ASC


GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
-- SELECT * FROM SITIO_USUARIO_X_UO

-- DELETE FROM SITIO_USUARIO_X_UO

-- EXECUTE [PG_IN_SITIO_USUARIO_X_UO_X_K_USUARIO] 0,0,0, 69

-- SELECT * FROM SITIO_USUARIO_X_UO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_SITIO_USUARIO_X_UO_X_K_USUARIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_SITIO_USUARIO_X_UO_X_K_USUARIO]
GO


CREATE PROCEDURE [dbo].[PG_IN_SITIO_USUARIO_X_UO_X_K_USUARIO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================	
	@PP_K_USUARIO				INT
	-- ============================		
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300) = ''
	
	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	
	
	/*
	IF @VP_MENSAJE=''	
		EXECUTE [dbo].[PG_RN_SITIO_USUARIO_X_UO_INSERT]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
															@PP_K_USUARIO, @PP_K_UNIDAD_OPERATIVA,
															@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
*/
	
	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN
		
		INSERT INTO [SITIO_USUARIO_X_UO]
				(	[K_USUARIO],
					[K_UNIDAD_OPERATIVA],
					-- ===========================
					[L_ACCESO],
					-- ===========================
					[K_USUARIO_ALTA], [F_ALTA], 
					[K_USUARIO_CAMBIO], [F_CAMBIO],
					[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
			SELECT	@PP_K_USUARIO,		
					UNO.K_UNIDAD_OPERATIVA,
					-- ===========================
					0,		-- @PP_L_ACCESO,
					-- ===========================
					@PP_K_USUARIO_ACCION, GETDATE(), 
					@PP_K_USUARIO_ACCION, GETDATE(),
					0, NULL, NULL 
			FROM	UNIDAD_OPERATIVA AS UNO
			WHERE	NOT (	UNO.K_UNIDAD_OPERATIVA IN	(	SELECT	UNO2.K_UNIDAD_OPERATIVA 
															FROM	[SITIO_USUARIO_X_UO] AS UNO2
															WHERE	UNO2.K_USUARIO=@PP_K_USUARIO	)	)
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Crear] el [Sitio_Usuario_UO]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#SIT_USU_UO.'+CONVERT(VARCHAR(10),@PP_K_USUARIO)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
	
		END
	
		SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_USUARIO AS CLAVE

	-- //////////////////////////////////////////////////////////////

GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
-- SELECT * FROM SITIO_USUARIO_X_UO

-- DELETE FROM SITIO_USUARIO_X_UO

-- EXECUTE [PG_DL_SITIO_USUARIO_X_UO_X_K_USUARIO] 0,0,0, 69

-- SELECT * FROM SITIO_USUARIO_X_UO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_SITIO_USUARIO_X_UO_X_K_USUARIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_SITIO_USUARIO_X_UO_X_K_USUARIO]
GO


CREATE PROCEDURE [dbo].[PG_DL_SITIO_USUARIO_X_UO_X_K_USUARIO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================	
	@PP_K_USUARIO				INT
	-- ============================		
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300) = ''
	
	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	
	
	/*
	IF @VP_MENSAJE=''	
		EXECUTE [dbo].[PG_RN_SITIO_USUARIO_X_UO_INSERT]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
															@PP_K_USUARIO, @PP_K_UNIDAD_OPERATIVA,
															@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
*/
	
	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN
		
		DELETE
		FROM	[SITIO_USUARIO_X_UO]
		WHERE	K_USUARIO=@PP_K_USUARIO
		
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Crear] el [Sitio_Usuario_UO]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#SIT_USU_UO.'+CONVERT(VARCHAR(10),@PP_K_USUARIO)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
	
		END
	
		SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_USUARIO AS CLAVE

	-- //////////////////////////////////////////////////////////////

GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
-- SELECT * FROM SITIO_USUARIO_X_UO

-- DELETE FROM SITIO_USUARIO_X_UO

-- EXECUTE [PG_IN_SITIO_USUARIO_X_UO_X_K_USUARIO] 0,0,0, 69

-- EXECUTE [PG_DL_SITIO_USUARIO_X_UO_X_K_USUARIO] 0,0,0, 69

-- SELECT * FROM SITIO_USUARIO_X_UO

-- EXECUTE [PG_UP_SITIO_USUARIO_X_UO] 0,0,0, 69, 10, 0


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_SITIO_USUARIO_X_UO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_SITIO_USUARIO_X_UO]
GO


CREATE PROCEDURE [dbo].[PG_UP_SITIO_USUARIO_X_UO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================	
	@PP_K_USUARIO				INT,
	@PP_K_UNIDAD_OPERATIVA		INT,
	@PP_L_ACCESO				INT
	-- ============================		
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300) = ''
	
	-- // SECCION#1 /////////////////////////////////////////////////////////// VALIDACIONES + REGLAS DE NEGOCIO 	
	
	/*
	IF @VP_MENSAJE=''	
		EXECUTE [dbo].[PG_RN_SITIO_USUARIO_X_UO_INSERT]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
															@PP_K_USUARIO, @PP_K_UNIDAD_OPERATIVA,
															@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
*/
	
	-- // SECCION#2 ////////////////////////////////////////////////////////// ACCION A REALIZAR
	
	IF @VP_MENSAJE=''
		BEGIN
		
		UPDATE	[SITIO_USUARIO_X_UO]
		SET		L_ACCESO=@PP_L_ACCESO
		WHERE	K_USUARIO=@PP_K_USUARIO
		AND		K_UNIDAD_OPERATIVA=@PP_K_UNIDAD_OPERATIVA
		
		END

	-- // SECCION#3 ////////////////////////////////////////////////////////// MENSAJE DE SALIDA
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible [Crear] el [Sitio_Usuario_UO]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#SIT_USU_UO.'+CONVERT(VARCHAR(10),@PP_K_USUARIO)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
	
		END
	
		SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_USUARIO AS CLAVE

	-- //////////////////////////////////////////////////////////////

GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////