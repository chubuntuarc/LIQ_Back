-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			ADG18_R100_10.a_TA_Sitio_Usuario_X_UO
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	ADG18_AdministradoraGas
-- // MODULO:			USUARIO_X_UO 
-- // OPERACION:		LIBERACION / TABLAS 
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		FRANCISCO ESTEBAN
-- // FECHA:		21/FEB/2019
-- ////////////////////////////////////////////////////////////// 

USE [ADG18_AdministradoraGas_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////

   
   
-- //////////////////////////////////////////////////////////////
--	SELECT *	FROM [dbo].[SITIO_USUARIO_X_UO]


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SITIO_USUARIO_X_UO]') AND type in (N'U'))
	DELETE	FROM [dbo].[SITIO_USUARIO_X_UO]
GO


-- //////////////////////////////////////////////////////



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_SITIO_USUARIO_X_UO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_SITIO_USUARIO_X_UO]
GO


CREATE PROCEDURE [dbo].[PG_CI_SITIO_USUARIO_X_UO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- =============================
	@PP_K_USUARIO				INT,
	@PP_K_UNIDAD_OPERATIVA		INT,
	@PP_L_ACCESO				INT
AS	

	INSERT INTO SITIO_USUARIO_X_UO
		(	[K_USUARIO],
			[K_UNIDAD_OPERATIVA],
			[L_ACCESO],	
			-- ===========================
			[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], 
			[F_CAMBIO], [L_BORRADO], [K_USUARIO_BAJA], [F_BAJA] 		)	
	VALUES	
		(	@PP_K_USUARIO,
			@PP_K_UNIDAD_OPERATIVA,
			@PP_L_ACCESO,
			-- ===========================
			@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
			0, NULL, NULL		)			

	-- ==============================================
GO




-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



-- ===============================================
SET NOCOUNT ON
-- ===============================================
-- SELECT * FROM [SITIO_USUARIO_X_UO]



EXECUTE [dbo].[PG_CI_SITIO_USUARIO_X_UO] 0, 2006, 0, 99, 13, 1		-- UNIGAS MATRIZ
EXECUTE [dbo].[PG_CI_SITIO_USUARIO_X_UO] 0, 2006, 0, 99, 21, 1		-- GASOMATICO
EXECUTE [dbo].[PG_CI_SITIO_USUARIO_X_UO] 0, 2006, 0, 99, 18, 1		-- GAS CHAPULTEPEC


-- ===============================================
SET NOCOUNT OFF
-- ===============================================



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
