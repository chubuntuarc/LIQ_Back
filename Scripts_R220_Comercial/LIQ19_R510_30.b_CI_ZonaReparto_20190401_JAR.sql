-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_01.b_CI_ZONA_REPARTO
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CARGA INICIAL - ZONA_REPARTO
-- // OPERACION:		LIBERACION
-- //////////////////////////////////////////////////////////////

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
--

DELETE
FROM [dbo].[ZONA_REPARTO]
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ZONA_REPARTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ZONA_REPARTO]
GO


CREATE PROCEDURE [dbo].[PG_CI_ZONA_REPARTO]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ===========================
	@PP_K_ZONA_REPARTO				INT,
	@PP_C_ZONA_REPARTO				VARCHAR(100),
	-- ===========================
	@PP_K_RUTA_REPARTO				INT,
	-- ===========================
	@PP_K_ESTATUS_ZONA_REPARTO		INT
	-- ===========================
AS
	-- K_USUARIO // 0	SYS/SETUP
	DECLARE @VP_K_USUARIO_ACCION	INT = 0
	DECLARE @VP_O_ZONA_REPARTO		INT = 0

	-- ===========================

	INSERT INTO ZONA_REPARTO
			(	[K_ZONA_REPARTO],[C_ZONA_REPARTO],
				-- ===========================
				[K_RUTA_REPARTO],
				-- ===========================
				[K_ESTATUS_ZONA_REPARTO],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES
			(	@PP_K_ZONA_REPARTO, @PP_C_ZONA_REPARTO,
				-- ===========================
				@PP_K_RUTA_REPARTO,
				-- ===========================
				@PP_K_ESTATUS_ZONA_REPARTO,
				-- ===========================
				@VP_K_USUARIO_ACCION, GETDATE(), @VP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

	-- //////////////////////////////////////////////////////////////
GO




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 1,'Cerrada del parque',1,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 2,'Infonavit Tecnológico',1,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 3,'Vistas de Zaragoza',1,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 4,'Jardines Residencial',2,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 5,'Cerrada Basalto',2,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 6,'Hacienda Las Lajas',2,0; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 7,'Praderas de los Alamos',3,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 8,'Los Cisnes',3,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 9,'Del Rosario',3,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 10,'De Los Mécanicos',4,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 11,'Cumbres',4,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 12,'Villas Primavera',4,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 13,'Vista del Sol',5,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 14,'Rincón del Seminario',5,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 15,'Valdez',6,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 16,'Oasis Oriente II',6,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 17,'De Las Torres III, IV',7,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 18,'Los Álamos',7,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 19,'Rincón de Waterfill',7,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 20,'Parajes del Valle',8,0; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 21,'Los Cardenales',8,0; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 22,'Villas Adlih',8,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 23,'Campeste Ma. Isabel',9,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 24,'Estera',9,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 25,'Fraccionamiento San Patricio',10,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 26,'Residencial la Florida II',10,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 27,'Desierto',11,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 28,'De Las Torres V',11,0; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 29,'Oasis Oriente I',11,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 30,'Adriana',12,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 31,'Electricistas',13,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 32,'Mayas Sur',14,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 33,'Mesita',14,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 34,'Del Agua',15,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 35,'Pradera Dorada',15,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 36,'Bugambilias',15,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 37,'Satélite',16,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 38,'La Plata',16,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 39,'Del Norte',16,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 40,'Fraccionamiento División del Norte',18,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 41,'Insurgentes',18,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 42,'Río Grande',19,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 43,'Alegre',19,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 44,'Rincón del Rio',19,0; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 45,'Catalán',20,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 46,'Panamá',20,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 47,'Del Maestro',20,1; 
EXECUTE [dbo].[PG_CI_ZONA_REPARTO] 0,0, 48,'La Villa',20,0; 
 


GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



