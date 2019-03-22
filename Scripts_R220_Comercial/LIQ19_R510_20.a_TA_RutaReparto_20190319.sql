-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	
-- // MÓDULO:			CATÁLOGOS / RUTA_REPARTO
-- // OPERACIÓN:		LIBERACIÓN / TABLAS
-- ////////////////////////////////////////////////////////////// 
-- // Autor:			
-- // Fecha creación:	
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RUTA_REPARTO]') AND type in (N'U'))
	DROP TABLE [dbo].[RUTA_REPARTO]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_RUTA_REPARTO]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_RUTA_REPARTO]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_RUTA_REPARTO]') AND type in (N'U'))
	DROP TABLE [dbo].[TIPO_RUTA_REPARTO]
GO

-- //////////////////////////////////////////////////////////////


-- //////////////////////////////////////////////////////////////
-- // TIPO_RUTA_REPARTO 	
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[TIPO_RUTA_REPARTO] (
	[K_TIPO_RUTA_REPARTO]	INT				NOT NULL,
	[D_TIPO_RUTA_REPARTO]	VARCHAR (100)	NOT NULL,
	[S_TIPO_RUTA_REPARTO]	VARCHAR (10)	NOT NULL,
	[O_TIPO_RUTA_REPARTO]	INT				NOT NULL,
	[C_TIPO_RUTA_REPARTO]	VARCHAR (255)	NOT NULL,
	[L_TIPO_RUTA_REPARTO]	INT				NOT NULL	
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[TIPO_RUTA_REPARTO]
	ADD CONSTRAINT [PK_TIPO_RUTA_REPARTO]
		PRIMARY KEY CLUSTERED ([K_TIPO_RUTA_REPARTO])
GO

-- //////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_RUTA_REPARTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_RUTA_REPARTO]
GO


-- //////////////////////////////////////////////////////////////
-- //					CI - TIPO_RUTA_REPARTO
-- //////////////////////////////////////////////////////////////


CREATE PROCEDURE [dbo].[PG_CI_TIPO_RUTA_REPARTO]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	-- ===================================
	@PP_K_TIPO_RUTA_REPARTO		INT,
	@PP_D_TIPO_RUTA_REPARTO		VARCHAR(100),
	@PP_S_TIPO_RUTA_REPARTO		VARCHAR(10),
	@PP_O_TIPO_RUTA_REPARTO		INT,
	@PP_C_TIPO_RUTA_REPARTO		VARCHAR(255),
	@PP_L_TIPO_RUTA_REPARTO		INT
AS

	INSERT INTO TIPO_RUTA_REPARTO
		(	K_TIPO_RUTA_REPARTO,			D_TIPO_RUTA_REPARTO, 
			S_TIPO_RUTA_REPARTO,			O_TIPO_RUTA_REPARTO,
			C_TIPO_RUTA_REPARTO,
			L_TIPO_RUTA_REPARTO				)
	VALUES	
		(	@PP_K_TIPO_RUTA_REPARTO,		@PP_D_TIPO_RUTA_REPARTO,	
			@PP_S_TIPO_RUTA_REPARTO,		@PP_O_TIPO_RUTA_REPARTO,
			@PP_C_TIPO_RUTA_REPARTO,
			@PP_L_TIPO_RUTA_REPARTO			)

	-- ==============================================
GO


-- ///////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_TIPO_RUTA_REPARTO] 0, 0, 1, 'GEOGRÁFICO',	'GEOGR',	10, '', 1
EXECUTE [dbo].[PG_CI_TIPO_RUTA_REPARTO] 0, 0, 2, 'NEGOCIO',		'NEGCI',	20, '', 1
EXECUTE [dbo].[PG_CI_TIPO_RUTA_REPARTO] 0, 0, 3, 'CARTERA',		'CARTE',	20, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================


-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // ESTATUS_RUTA_REPARTO 	
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[ESTATUS_RUTA_REPARTO] (
	[K_ESTATUS_RUTA_REPARTO]		INT				NOT NULL,
	[D_ESTATUS_RUTA_REPARTO]		VARCHAR (100)	NOT NULL,
	[S_ESTATUS_RUTA_REPARTO]		VARCHAR (10)	NOT NULL,
	[O_ESTATUS_RUTA_REPARTO]		INT				NOT NULL,
	[C_ESTATUS_RUTA_REPARTO]		VARCHAR (255)	NOT NULL,
	[L_ESTATUS_RUTA_REPARTO]		INT				NOT NULL	
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[ESTATUS_RUTA_REPARTO]
	ADD CONSTRAINT [PK_ESTATUS_RUTA_REPARTO]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_RUTA_REPARTO])
GO






-- //////////////////////////////////////////////////////////////
-- //					CI - ESTATUS_RUTA_REPARTO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_RUTA_REPARTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_RUTA_REPARTO]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_RUTA_REPARTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ===================================
	@PP_K_ESTATUS_RUTA_REPARTO		INT,
	@PP_D_ESTATUS_RUTA_REPARTO		VARCHAR(100),
	@PP_S_ESTATUS_RUTA_REPARTO		VARCHAR(10),
	@PP_O_ESTATUS_RUTA_REPARTO		INT,
	@PP_C_ESTATUS_RUTA_REPARTO		VARCHAR(255),
	@PP_L_ESTATUS_RUTA_REPARTO		INT
AS

	INSERT INTO ESTATUS_RUTA_REPARTO
		(	K_ESTATUS_RUTA_REPARTO,			D_ESTATUS_RUTA_REPARTO, 
			S_ESTATUS_RUTA_REPARTO,			O_ESTATUS_RUTA_REPARTO,
			C_ESTATUS_RUTA_REPARTO,
			L_ESTATUS_RUTA_REPARTO				)
	VALUES	
		(	@PP_K_ESTATUS_RUTA_REPARTO,		@PP_D_ESTATUS_RUTA_REPARTO,	
			@PP_S_ESTATUS_RUTA_REPARTO,		@PP_O_ESTATUS_RUTA_REPARTO,
			@PP_C_ESTATUS_RUTA_REPARTO,
			@PP_L_ESTATUS_RUTA_REPARTO			)

	-- ==============================================
GO


-- ///////////////////////////////////////////////////////////////
-- HGF >> ESTO PUEDE SER POR ALERTA 

-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_RUTA_REPARTO] 0, 0, 0, 'INACTIVO',	'INAC', 20, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_RUTA_REPARTO] 0, 0, 1, 'ACTIVO',		'ACTI', 10, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================


-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // RUTA_REPARTO 	
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[RUTA_REPARTO] (
	[K_RUTA_REPARTO]			INT				NOT NULL,
	[D_RUTA_REPARTO]			VARCHAR (255)	NOT NULL,
	[C_RUTA_REPARTO]			VARCHAR (500)	NOT NULL,
	[S_RUTA_REPARTO]			VARCHAR (10)	NOT NULL,
	-- ==============================================
	[K_UNIDAD_OPERATIVA]		INT				NOT NULL,
	-- ==============================================
	[K_ESTATUS_RUTA_REPARTO]	INT				NOT NULL,
	[K_TIPO_RUTA_REPARTO]		INT				NOT NULL
	-- ==============================================
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[RUTA_REPARTO]
	ADD CONSTRAINT [PK_RUTA_REPARTO]
		PRIMARY KEY CLUSTERED ([K_RUTA_REPARTO])
GO

--CREATE UNIQUE NONCLUSTERED 
--	INDEX [UN_RUTA_REPARTO_01_DESCRIPCION] 
--	   ON [dbo].[RUTA_REPARTO] ( [D_RUTA_REPARTO] )
--GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[RUTA_REPARTO] ADD 
	CONSTRAINT [FK_RUTA_REPARTO_01] 
		FOREIGN KEY ([K_UNIDAD_OPERATIVA]) 
		REFERENCES [dbo].[UNIDAD_OPERATIVA] ([K_UNIDAD_OPERATIVA]),
	CONSTRAINT [FK_RUTA_REPARTO_02] 
		FOREIGN KEY ([K_ESTATUS_RUTA_REPARTO]) 
		REFERENCES [dbo].[ESTATUS_RUTA_REPARTO] ([K_ESTATUS_RUTA_REPARTO]),
	CONSTRAINT [FK_RUTA_REPARTO_03] 
		FOREIGN KEY ([K_TIPO_RUTA_REPARTO]) 
		REFERENCES [dbo].[TIPO_RUTA_REPARTO] ([K_TIPO_RUTA_REPARTO])
GO

-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[RUTA_REPARTO] 
	ADD		[K_USUARIO_ALTA]		[INT]		NOT NULL,
			[F_ALTA]				[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]		[INT]		NOT NULL,
			[F_CAMBIO]				[DATETIME]	NOT NULL,
			[L_BORRADO]				[INT]		NOT NULL,
			[K_USUARIO_BAJA]		[INT]		NULL,
			[F_BAJA]				[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[RUTA_REPARTO] ADD 
	CONSTRAINT [FK_RUTA_REPARTO_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_RUTA_REPARTO_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_RUTA_REPARTO_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO




-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////