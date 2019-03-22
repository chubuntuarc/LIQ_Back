-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_06.b1_CI_Precio
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CARGA INICIAL - PRECIO
-- // OPERACION:		LIBERACION 
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
--	

DELETE  
FROM [dbo].[PRECIO]
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_PRECIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_PRECIO]
GO


CREATE PROCEDURE [dbo].[PG_CI_PRECIO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ===========================
	@PP_K_PRECIO				INT,
	@PP_D_PRECIO				VARCHAR(100),
	@PP_S_PRECIO				VARCHAR(10),
	@PP_O_PRECIO				INT,
	@PP_K_ESTATUS_PRECIO		INT,
	@PP_K_TIPO_PRECIO			INT,
	@PP_K_PRODUCTO				INT,
	@PP_K_TASA_IMPUESTO			INT,
	@PP_F_VIGENCIA_INICIO		DATETIME,
	@PP_F_VIGENCIA_FIN			DATETIME,
	@PP_PRECIO_SIN_IVA			DECIMAL(19,4),
	@PP_PRECIO_IVA				DECIMAL(19,4),
	@PP_PRECIO_CON_IVA			DECIMAL(19,4)
	
	-- ===========================
AS			
	-- K_USUARIO // 0	SYS/SETUP
	DECLARE @VP_K_USUARIO_ACCION		INT = 0 
	DECLARE @VP_O_PRECIO				INT = 0

	-- ===========================

	INSERT INTO PRECIO
			(	[K_PRECIO],
				[D_PRECIO], [S_PRECIO], [O_PRECIO],
				-- ===========================
				[K_ESTATUS_PRECIO],
				[K_TIPO_PRECIO],
				[K_PRODUCTO],
				[K_TASA_IMPUESTO],
				-- ===========================
				[F_VIGENCIA_INICIO], [F_VIGENCIA_FIN],
				[PRECIO_SIN_IVA],
				[PRECIO_IVA], 
				[PRECIO_CON_IVA],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES	
			(	@PP_K_PRECIO,
				@PP_D_PRECIO, @PP_S_PRECIO, @VP_O_PRECIO,
				-- ===========================
				@PP_K_ESTATUS_PRECIO,
				@PP_K_TIPO_PRECIO,
				@PP_K_PRODUCTO,
				@PP_K_TASA_IMPUESTO,
				-- ===========================
				@PP_F_VIGENCIA_INICIO, @PP_F_VIGENCIA_FIN, 
				@PP_PRECIO_SIN_IVA,
				@PP_PRECIO_IVA, 
				@PP_PRECIO_CON_IVA,
				-- ===========================
				@VP_K_USUARIO_ACCION, GETDATE(), @VP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )
		
	-- //////////////////////////////////////////////////////////////
GO


-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_PRECIO] 0, 0,102, 'LPxLT', 'LPxLT#102', 1,1,1,1,101,'2000-01-01','2017-12-31',17.2413793103448,2.75862068965517,20; 
EXECUTE [dbo].[PG_CI_PRECIO] 0, 0,103, 'LPxLT', 'LPxLT#103', 1,1,1,1,102,'2018-01-01','2018-01-31',18.3035714285714,2.19642857142857,20.5; 
EXECUTE [dbo].[PG_CI_PRECIO] 0, 0,104, 'LPxLT', 'LPxLT#104', 1,1,1,1,103,'2018-02-01','2018-03-03',18.4210526315789,2.57894736842105,21; 
EXECUTE [dbo].[PG_CI_PRECIO] 0, 0,105, 'LPxLT', 'LPxLT#105', 1,1,1,1,104,'2018-03-04','2018-04-03',19.5454545454545,1.95454545454546,21.5; 
EXECUTE [dbo].[PG_CI_PRECIO] 0, 0,106, 'LPxLT', 'LPxLT#106', 1,1,1,1,105,'2018-04-04','2018-05-04',18.9655172413793,3.03448275862069,22; 
EXECUTE [dbo].[PG_CI_PRECIO] 0, 0,107, 'LPxLT', 'LPxLT#107', 1,1,1,1,106,'2018-05-05','2018-06-04',20.8333333333333,1.66666666666667,22.5; 
EXECUTE [dbo].[PG_CI_PRECIO] 0, 0,108, 'LPxLT', 'LPxLT#108', 1,1,1,1,101,'2018-06-05','2018-07-05',19.8275862068966,3.17241379310345,23; 
EXECUTE [dbo].[PG_CI_PRECIO] 0, 0,109, 'LPxLT', 'LPxLT#109', 1,1,1,1,102,'2018-07-06','2018-08-05',20.9821428571429,2.51785714285715,23.5; 
EXECUTE [dbo].[PG_CI_PRECIO] 0, 0,110, 'LPxLT', 'LPxLT#110', 1,1,1,1,103,'2018-08-06','2018-09-05',21.0526315789474,2.94736842105263,24; 
EXECUTE [dbo].[PG_CI_PRECIO] 0, 0,111, 'LPxLT', 'LPxLT#111', 1,1,1,1,104,'2018-09-06','2018-10-06',22.2727272727273,2.22727272727273,24.5; 
EXECUTE [dbo].[PG_CI_PRECIO] 0, 0,112, 'LPxLT', 'LPxLT#112', 1,1,1,1,105,'2018-10-07','2018-11-06',21.551724137931,3.44827586206896,25; 
EXECUTE [dbo].[PG_CI_PRECIO] 0, 0,113, 'LPxLT', 'LPxLT#113', 1,1,1,1,106,'2018-11-07','2018-12-07',23.6111111111111,1.88888888888889,25.5; 
EXECUTE [dbo].[PG_CI_PRECIO] 0, 0,114, 'LPxLT', 'LPxLT#114', 1,1,1,1,101,'2018-12-08','2019-01-07',22.4137931034483,3.58620689655172,26; 
EXECUTE [dbo].[PG_CI_PRECIO] 0, 0,122, 'MEDGAS', 'MEDGAS#122', 1,1,1,8,102,'2018-04-05','2018-12-31',446.428571428571,53.5714285714286,500; 
EXECUTE [dbo].[PG_CI_PRECIO] 0, 0,124, 'RECLIN', 'RECLIN#124', 1,1,1,9,103,'2018-02-02','2018-12-29',175.438596491228,24.5614035087719,200; 
EXECUTE [dbo].[PG_CI_PRECIO] 0, 0,127, 'MANTTO', 'MANTTO#127', 1,1,1,11,104,'2018-03-05','2018-12-30',105.454545454545,10.5454545454546,116; 
EXECUTE [dbo].[PG_CI_PRECIO] 0, 0,129, 'PSERV', 'PSERV#129', 1,1,1,12,105,'2018-03-05','2018-12-30',10.3448275862069,1.6551724137931,12; 





GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



