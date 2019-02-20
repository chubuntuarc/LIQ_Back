-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_05.b1_CI_TASA_IMPUESTO
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CARGA INICIAL - TASA_IMPUESTO
-- // OPERACION:		LIBERACION 
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
--	

DELETE  
FROM [dbo].[TASA_IMPUESTO]
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TASA_IMPUESTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TASA_IMPUESTO]
GO


CREATE PROCEDURE [dbo].[PG_CI_TASA_IMPUESTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ===========================
	@PP_K_TASA_IMPUESTO			INT,
	-- ===========================
	@PP_K_IMPUESTO				INT,
	@PP_F_VIGENCIA_INICIO		DATE,
	@PP_F_VIGENCIA_FIN			DATE,
	@PP_VALOR_TASA_IMPUESTO		DECIMAL(19,4)
	-- ===========================
AS			
	-- K_USUARIO // 0	SYS/SETUP
	DECLARE @VP_K_USUARIO_ACCION		INT = 0 
	DECLARE @VP_O_TASA_IMPUESTO			INT = 0

	-- ===========================

	INSERT INTO TASA_IMPUESTO
			(	[K_TASA_IMPUESTO],
				-- ===========================
				[K_IMPUESTO],
				-- ===========================
				[F_VIGENCIA_INICIO], [F_VIGENCIA_FIN],
				[VALOR_TASA_IMPUESTO],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES	
			(	@PP_K_TASA_IMPUESTO,
				-- ===========================
				@PP_K_IMPUESTO,
				-- ===========================
				@PP_F_VIGENCIA_INICIO, @PP_F_VIGENCIA_FIN, 
				@PP_VALOR_TASA_IMPUESTO,
				-- ===========================
				@VP_K_USUARIO_ACCION, GETDATE(), @VP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )
		
	-- //////////////////////////////////////////////////////////////
GO


-- ===============================================
SET NOCOUNT ON
-- ===============================================


EXECUTE [dbo].[PG_CI_TASA_IMPUESTO] 0, 0,101,1,'2018-01-01','2018-03-02',0.16; 
EXECUTE [dbo].[PG_CI_TASA_IMPUESTO] 0, 0,102,1,'2018-03-03','2018-05-02',0.16; 
EXECUTE [dbo].[PG_CI_TASA_IMPUESTO] 0, 0,103,1,'2018-05-03','2018-07-02',0.16; 
EXECUTE [dbo].[PG_CI_TASA_IMPUESTO] 0, 0,104,1,'2018-07-03','2018-09-01',0.16; 
EXECUTE [dbo].[PG_CI_TASA_IMPUESTO] 0, 0,105,1,'2018-09-02','2018-11-01',0.16; 
EXECUTE [dbo].[PG_CI_TASA_IMPUESTO] 0, 0,106,1,'2018-11-02','2019-01-01',0.16; 





GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



