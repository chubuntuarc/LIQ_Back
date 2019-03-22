-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_01.b_CI_FICHA_PORTATIL
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CARGA INICIAL - FICHA_PORTATIL
-- // OPERACION:		LIBERACION
-- //////////////////////////////////////////////////////////////

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
--

DELETE
FROM [dbo].[FICHA_PORTATIL]
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_FICHA_PORTATIL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_FICHA_PORTATIL]
GO


CREATE PROCEDURE [dbo].[PG_CI_FICHA_PORTATIL]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ===========================
	@PP_K_FICHA_PORTATIL			INT,
	@PP_K_PUNTO_VENTA				INT,
	-- ===========================
	@PP_MATRICULA					VARCHAR(100),
	@PP_MARCA						VARCHAR(100),
	@PP_MODELO						VARCHAR(100),
	@PP_KILOMETRAJE					DECIMAL(19,4),
	@PP_SERIE						VARCHAR(100),
	@PP_CAPACIDAD					INT
	-- ===========================
AS
	-- K_USUARIO // 0	SYS/SETUP
	DECLARE @VP_K_USUARIO_ACCION	INT = 0
	DECLARE @VP_O_FICHA_PORTATIL	INT = 0

	-- ===========================

	INSERT INTO FICHA_PORTATIL
			(	[K_FICHA_PORTATIL],
				[K_PUNTO_VENTA],
				-- ===========================
				[MATRICULA], [MARCA], [MODELO],
				[KILOMETRAJE], [SERIE], [CAPACIDAD],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES
			(	@PP_K_FICHA_PORTATIL,
				@PP_K_PUNTO_VENTA,
				-- ===========================
				@PP_MATRICULA, @PP_MARCA, @PP_MODELO,
				@PP_KILOMETRAJE, @PP_SERIE, @PP_CAPACIDAD,
				-- ===========================
				@VP_K_USUARIO_ACCION, GETDATE(), @VP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

	-- //////////////////////////////////////////////////////////////
GO




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 1, 2,'BCD345','CHEVROLET','2006',233859,'3GBKC34G55M118806',5000;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 2, 4,'FEFE889','GMC','2002',1522039,'1GDJ7H1E4J901664',11315;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 3, 5,'MAT123','GENERAL MOTORSS','2005',0,'3GBKC34GX5M101984',5000;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 4, 6,'N/D','CHEVROLET','2006',164292,'3GBKC34G55M118837',4300;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 5, 7,'DV10365','CHEVROLET','2006',141076,'3GBKC34GX5M118915',5000;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 6, 9,'ZTV6503','GMC','1997',1578795,'1GDG6H1P9RJ519414',12500;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 7, 10,'DW31616','N/D','N/D',0,'N/D',12500;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 8, 12,'DV10363','GMC','1990',61784,'1GBM7H1P2PJ101461',12500;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 9, 14,'N/D','G.M.KODIAK','2005',0,'3GBJ6H1E45M105516',8250;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 10, 15,'N/D','GMC','1995',2099804,'1G017H1P45J520018',12500;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 11, 16,'DV10362','GMC','1992',1881350,'1GDG6H1T7PJ504326',8670;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 12, 17,'N/D','CHEVROLET','2002',2443861,'3GBM7H1E62M104342',12500;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 13, 19,'DY-2983','N/D','N/D',0,'N/D',12500;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 14, 20,'N/D','GMC','N/D',0,'N/D',12500;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 15, 22,'DV10456','GMC','1995',1276028,'1GDG6H1P6TJ504599',12500;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 16, 24,'N/D','GMC','N/D',0,'N/D',6850;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 17, 25,'N/D','NISSAN','2010',29056,'013FB0473C4F544B',0;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 18, 26,'N/D','NISSAN','2010',17711,'0136B07390508612',0;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 19, 27,'DV10419','CHEVROLET HEAVY DUTY','N/D',0,'N/D',0;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 20, 29,'N/D','NISSAN','2010',0,'0136B07390508612',0;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 21, 30,'N/D','NISSAN','2010',22098,'013AB067801076420',0;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 22, 32,'N/D','N/D','N/D',0,'N/D',0;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 23, 34,'N/D','N/D','N/D',0,'N/D',0;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 24, 35,'N/D','NISSAN','2007',1.3,'3N6DD14547K040525',0;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 25, 36,'N/D','N/D','N/D',0,'N/D',0;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 26, 37,'N/D','NISSAN','2007',228.6,'3N6DD14568K002327',0;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 27, 39,'N/D','N/D','N/D',0,'N/D',0;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 28, 40,'DV10353','N/D','N/D',0,'N/D',0;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 29, 42,'DV10359','N/D','N/D',0,'N/D',0;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 30, 44,'N/D','CHEVROLET HEAVY DUTY','N/D',8911979,'N/D',0;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 31, 45,'N/D','N/D','N/D',0,'N/D',4750;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 32, 46,'N/D','N/D','N/D',0,'N/D',3500;
EXECUTE [dbo].[PG_CI_FICHA_PORTATIL] 0,0, 33, 47,'N/D','NISSAN VPM','2008',56309,'3NGDD14528K021599',1866; 


GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



