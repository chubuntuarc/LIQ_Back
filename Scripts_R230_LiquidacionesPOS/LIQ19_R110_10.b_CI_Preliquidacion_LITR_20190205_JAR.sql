-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_05.b_CI_PRELIQUIDACION_LTR
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CARGA INICIAL - PRELIQUIDACION_LTR
-- // OPERACION:		LIBERACION
-- //////////////////////////////////////////////////////////////

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
--

DELETE
FROM [dbo].[PRELIQUIDACION_LTR]
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_PRELIQUIDACION_LTR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_PRELIQUIDACION_LTR]
GO


CREATE PROCEDURE [dbo].[PG_CI_PRELIQUIDACION_LTR]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ===========================
	@PP_K_PRELIQUIDACION_LTR			INT,
	@PP_D_PRELIQUIDACION_LTR			VARCHAR(100),
	@PP_S_PRELIQUIDACION_LTR			VARCHAR(10),
	@PP_O_PRELIQUIDACION_LTR			INT,
	@PP_L_PRELIQUIDACION_LTR			INT,
	@PP_F_PRELIQUIDACION_LTR			DATE,
	-- ===========================
	@PP_K_TIPO_PRELIQUIDACION_LTR		INT,
	@PP_K_ESTATUS_PRELIQUIDACION_LTR	INT,
	@PP_K_PUNTO_VENTA				INT
	-- ===========================
AS
	-- K_USUARIO // 0	SYS/SETUP
	DECLARE @VP_K_USUARIO_ACCION	INT = 0
	DECLARE @VP_O_PRELIQUIDACION_LTR	INT = 0

	-- ===========================

	INSERT INTO PRELIQUIDACION_LTR
			(	[K_PRELIQUIDACION_LTR],[D_PRELIQUIDACION_LTR], [S_PRELIQUIDACION_LTR],
				[O_PRELIQUIDACION_LTR], [L_PRELIQUIDACION_LTR], [F_PRELIQUIDACION_LTR],
				-- ===========================
				[K_TIPO_PRELIQUIDACION_LTR], [K_ESTATUS_PRELIQUIDACION_LTR], [K_PUNTO_VENTA],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES
			(	@PP_K_PRELIQUIDACION_LTR, @PP_D_PRELIQUIDACION_LTR, @PP_S_PRELIQUIDACION_LTR,
				@PP_O_PRELIQUIDACION_LTR, @PP_L_PRELIQUIDACION_LTR, @PP_F_PRELIQUIDACION_LTR,
				-- ===========================
				@PP_K_TIPO_PRELIQUIDACION_LTR, @PP_K_ESTATUS_PRELIQUIDACION_LTR, @PP_K_PUNTO_VENTA,
				-- ===========================
				@VP_K_USUARIO_ACCION, GETDATE(), @VP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

	-- //////////////////////////////////////////////////////////////
GO




-- ===============================================
SET NOCOUNT ON
-- ===============================================


/*

EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,1,'BG31','BG3','0',0,'2018-12-02',1,0,1; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,2,'BG31','BG3','0',0,'2018-12-03',2,1,1; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,3,'BG30','BG3','0',0,'2018-02-14',1,0,2; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,4,'BG30','BG3','0',0,'2018-02-15',2,1,2; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,5,'BE201','BE2','0',0,'2018-02-17',1,0,3; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,6,'BE201','BE2','0',0,'2018-02-05',2,0,3; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,7,'BE05','BE0','0',0,'2018-02-07',1,1,4; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,8,'BE05','BE0','0',0,'2018-02-09',2,0,4; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,9,'BG10','BG1','0',1,'2018-02-10',1,0,5; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,10,'BG10','BG1','0',1,'2018-02-11',2,1,5; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,11,'BG20','BG2','0',1,'2018-02-12',1,0,6; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,12,'BG20','BG2','0',1,'2018-03-10',2,1,6; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,13,'BG11','BG1','0',1,'2018-03-11',1,0,7; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,14,'BG11','BG1','0',1,'2018-03-13',2,1,7; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,15,'BG09','BG0','0',1,'2018-03-15',1,0,8; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,16,'BG09','BG0','0',1,'2018-03-16',2,0,8; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,17,'C02','C02','0',0,'2018-03-17',1,1,9; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,18,'C02','C02','0',0,'2018-03-18',2,0,9; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,19,'C126','C12','0',0,'2018-04-20',1,1,10; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,20,'C126','C12','0',0,'2018-04-21',2,0,10; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,21,'c129','c12','0',0,'2018-04-23',1,1,11; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,22,'c129','c12','0',0,'2018-04-25',2,0,11; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,23,'BG10','BG1','0',0,'2018-05-06',1,0,12; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,24,'BG10','BG1','0',0,'2018-05-07',2,1,12; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,25,'BG09','BG0','0',0,'2018-05-08',1,0,13; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,26,'BG09','BG0','0',1,'2018-05-10',2,1,13; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,27,'BE05','BE0','0',1,'2018-05-11',1,0,14; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,28,'BE05','BE0','0',1,'2018-07-13',2,1,14; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,29,'C126','C12','0',1,'2018-07-15',1,0,15; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,30,'C126','C12','0',1,'2018-07-16',2,0,15; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,31,'BE04','BE0','0',0,'2018-07-17',1,1,16; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,32,'BE04','BE0','0',0,'2018-07-18',2,0,16; 
EXECUTE [dbo].[PG_CI_PRELIQUIDACION_LTR] 0,0,33,'BG31','BG3','0',0,'2018-08-10',1,1,17; 

*/ 



GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



