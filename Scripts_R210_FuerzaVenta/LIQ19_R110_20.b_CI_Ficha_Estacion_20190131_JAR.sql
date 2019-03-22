-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_01.b_CI_FICHA_ESTACION_CARBURACION
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CARGA INICIAL - FICHA_ESTACION_CARBURACION
-- // OPERACION:		LIBERACION
-- //////////////////////////////////////////////////////////////

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
--

DELETE
FROM [dbo].[FICHA_ESTACION_CARBURACION]
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_FICHA_ESTACION_CARBURACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_FICHA_ESTACION_CARBURACION]
GO


CREATE PROCEDURE [dbo].[PG_CI_FICHA_ESTACION_CARBURACION]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ===========================
	@PP_K_FICHA_ESTACION_CARBURACION		INT,
	@PP_K_PUNTO_VENTA				INT,
	-- ===========================
	@PP_LECTURA_INICIAL				INT,
	@PP_LECTURA_FINAL				INT,
	@PP_DIRECCION					VARCHAR(100),
	@PP_CAPACIDAD					INT,
	@PP_PORCENTAJE					VARCHAR(100),
	@PP_MEDIDOR						VARCHAR(100),
	@PP_TIPO_MEDIDOR				VARCHAR(100)
	-- ===========================
AS
	-- K_USUARIO // 0	SYS/SETUP
	DECLARE @VP_K_USUARIO_ACCION		INT = 0
	DECLARE @VP_O_FICHA_ESTACION_CARBURACION	INT = 0

	-- ===========================

	INSERT INTO FICHA_ESTACION_CARBURACION
			(	[K_FICHA_ESTACION_CARBURACION],
				[K_PUNTO_VENTA],
				-- ===========================
				[LECTURA_INICIAL], [LECTURA_FINAL],
				[DIRECCION],
				[CAPACIDAD], [PORCENTAJE],
				[MEDIDOR], [TIPO_MEDIDOR],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES
			(	@PP_K_FICHA_ESTACION_CARBURACION,
				@PP_K_PUNTO_VENTA,
				-- ===========================
				@PP_LECTURA_FINAL, @PP_LECTURA_FINAL,
				@PP_DIRECCION,
				@PP_CAPACIDAD, @PP_PORCENTAJE,
				@PP_MEDIDOR, @PP_TIPO_MEDIDOR,
				-- ===========================
				@VP_K_USUARIO_ACCION, GETDATE(), @VP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

	-- //////////////////////////////////////////////////////////////
GO




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_FICHA_ESTACION_CARBURACION] 0,0, 1, 3, 0,901407,'LAS TORRES',5000,'73','MAS ALTO','GASPAR G4S';
EXECUTE [dbo].[PG_CI_FICHA_ESTACION_CARBURACION] 0,0, 2, 8, 0,1311155,'ZARAGOZA',12200,'22','LITROMETRO','GASPAR G4S';
EXECUTE [dbo].[PG_CI_FICHA_ESTACION_CARBURACION] 0,0, 3, 13, 0,2136581,'PANAMERICANA',10000,'20','MAS ALTO','GASPAR G4S';
EXECUTE [dbo].[PG_CI_FICHA_ESTACION_CARBURACION] 0,0, 4, 18, 0,3998929,'LAS TORRES',12500,'90.5','MAS ALTO','GASPAR G4S';
EXECUTE [dbo].[PG_CI_FICHA_ESTACION_CARBURACION] 0,0, 5, 23, 0,136286,'ZARAGOZA',10500,'73.5','MAS ALTO','GASPAR G4S';
EXECUTE [dbo].[PG_CI_FICHA_ESTACION_CARBURACION] 0,0, 6, 28, 0,468176,'PANAMERICANA',0,'0','NINGUNO','NINGUNO';
EXECUTE [dbo].[PG_CI_FICHA_ESTACION_CARBURACION] 0,0, 7, 33, 0,2379843,'LAS TORRES',0,'0','NINGUNO','NINGUNO';
EXECUTE [dbo].[PG_CI_FICHA_ESTACION_CARBURACION] 0,0, 8, 38, 0,148707,'ZARAGOZA',0,'0','NINGUNO','NINGUNO';
EXECUTE [dbo].[PG_CI_FICHA_ESTACION_CARBURACION] 0,0, 9, 43, 0,436731,'PANAMERICANA',0,'0','NINGUNO','NINGUNO';
EXECUTE [dbo].[PG_CI_FICHA_ESTACION_CARBURACION] 0,0, 10, 48, 0,2042134,'TECNOLOGICO',5000,'10','MAS ALTO','GASPAR TRAD'; 


GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



