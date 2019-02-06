-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_05.b_CI_LIQUIDACION
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CARGA INICIAL - LIQUIDACION
-- // OPERACION:		LIBERACION
-- //////////////////////////////////////////////////////////////

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
--

DELETE
FROM [dbo].[LIQUIDACION]
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_LIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_LIQUIDACION]
GO


CREATE PROCEDURE [dbo].[PG_CI_LIQUIDACION]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ===========================
	@PP_K_LIQUIDACION			INT,
	@PP_D_LIQUIDACION			VARCHAR(100),
	@PP_S_LIQUIDACION			VARCHAR(10),
	@PP_O_LIQUIDACION			INT,
	@PP_C_LIQUIDACION			VARCHAR(255),
	@PP_L_LIQUIDACION			INT,
	@PP_F_LIQUIDACION			DATE,
	-- ===========================
	@PP_K_PRELIQUIDACION		INT,
	@PP_K_ESTATUS_LIQUIDACION	INT,
	@PP_K_TIPO_LIQUIDACION		INT,
	-- ===========================
	@PP_SUBTOTAL				DECIMAL(19,4),
	@PP_IVA						DECIMAL(19,4),
	@PP_TOTAL					DECIMAL(19,4)
	-- ===========================
AS
	-- K_USUARIO // 0	SYS/SETUP
	DECLARE @VP_K_USUARIO_ACCION	INT = 0
	DECLARE @VP_O_LIQUIDACION		INT = 0

	-- ===========================

	INSERT INTO LIQUIDACION
			(	[K_LIQUIDACION],
				[D_LIQUIDACION], [S_LIQUIDACION], [O_LIQUIDACION], 
				[C_LIQUIDACION], [L_LIQUIDACION], [F_LIQUIDACION],
				-- ===========================
				[K_PRELIQUIDACION], [K_ESTATUS_LIQUIDACION], [K_TIPO_LIQUIDACION], 
				-- ===========================
				[SUBTOTAL], [IVA], [TOTAL], 
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES
			(	@PP_K_LIQUIDACION, 
				@PP_D_LIQUIDACION, @PP_S_LIQUIDACION, @PP_O_LIQUIDACION, 
				@PP_C_LIQUIDACION, @PP_L_LIQUIDACION, @PP_F_LIQUIDACION,
				-- ===========================
				@PP_K_PRELIQUIDACION, @PP_K_ESTATUS_LIQUIDACION, @PP_K_TIPO_LIQUIDACION, 
				-- ===========================
				@PP_SUBTOTAL, @PP_IVA, @PP_TOTAL, 
				-- ===========================
				@VP_K_USUARIO_ACCION, GETDATE(), @VP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

	-- //////////////////////////////////////////////////////////////
GO




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,1,'BG31','BG3',0,'',0,'2018-02-12',0,1,1,100,8,108; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,2,'BG31','BG3',0,'',0,'2018-02-13',1,2,2,200,16,216; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,3,'BG30','BG3',0,'',0,'2018-02-14',0,1,3,300,24,324; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,4,'BG30','BG3',0,'',0,'2018-02-15',1,2,4,400,32,432; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,5,'BE201','BE2',0,'',0,'2018-02-17',0,1,5,500,40,540; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,6,'BE201','BE2',0,'',0,'2018-02-05',1,2,6,600,48,648; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,7,'BE05','BE0',0,'',0,'2018-02-07',0,1,7,700,56,756; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,8,'BE05','BE0',0,'',0,'2018-02-09',1,2,8,800,64,864; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,9,'BG10','BG1',0,'',0,'2018-02-10',0,1,9,900,72,972; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,10,'BG10','BG1',0,'',0,'2018-02-11',1,2,10,1000,80,1080; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,11,'BG20','BG2',0,'',0,'2018-02-12',0,1,11,1100,88,1188; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,12,'BG20','BG2',0,'',0,'2018-03-10',1,2,12,1200,96,1296; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,13,'BG11','BG1',0,'',0,'2018-03-11',0,1,13,1300,104,1404; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,14,'BG11','BG1',0,'',0,'2018-03-13',1,2,14,1400,112,1512; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,15,'BG09','BG0',0,'',0,'2018-03-15',0,1,15,1500,120,1620; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,16,'BG09','BG0',0,'',0,'2018-03-16',1,2,16,1600,128,1728; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,17,'C02','C02',0,'',0,'2018-03-17',0,1,17,1700,136,1836; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,18,'C02','C02',0,'',0,'2018-03-18',1,2,18,1800,144,1944; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,19,'C126','C12',0,'',0,'2018-04-20',0,1,19,1900,152,2052; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,20,'C126','C12',0,'',0,'2018-04-21',1,2,20,2000,160,2160; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,21,'c129','c12',0,'',0,'2018-04-23',0,1,21,2100,168,2268; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,22,'c129','c12',0,'',0,'2018-04-25',1,2,22,2200,176,2376; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,23,'BG10','BG1',0,'',0,'2018-05-06',0,1,23,2300,184,2484; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,24,'BG10','BG1',0,'',0,'2018-05-07',1,2,24,2400,192,2592; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,25,'BG09','BG0',0,'',0,'2018-05-08',0,1,25,2500,200,2700; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,26,'BG09','BG0',0,'',0,'2018-05-10',1,2,26,2600,208,2808; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,27,'BE05','BE0',0,'',0,'2018-05-11',0,1,27,2700,216,2916; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,28,'BE05','BE0',0,'',0,'2018-07-13',1,2,28,2800,224,3024; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,29,'C126','C12',0,'',0,'2018-07-15',0,1,29,2900,232,3132; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,30,'C126','C12',0,'',0,'2018-07-16',1,2,30,3000,240,3240; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,31,'BE04','BE0',0,'',0,'2018-07-17',0,1,31,3100,248,3348; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,32,'BE04','BE0',0,'',0,'2018-07-18',1,2,32,3200,256,3456; 
EXECUTE [dbo].[PG_CI_LIQUIDACION] 0,0,33,'BG31','BG3',0,'',0,'2018-01-01',0,1,33,3300,264,3564; 
 



GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



