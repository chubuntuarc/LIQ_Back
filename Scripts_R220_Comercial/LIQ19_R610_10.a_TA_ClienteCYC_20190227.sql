-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	
-- // MÓDULO:			CATÁLOGOS / CLIENTE_TMK
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CLIENTE_TMK]') AND type in (N'U'))
	DROP TABLE [dbo].[CLIENTE_TMK]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_CLIENTE_TMK]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_CLIENTE_TMK]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_CLIENTE_TMK]') AND type in (N'U'))
	DROP TABLE [dbo].[TIPO_CLIENTE_TMK]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ALERTA_VENTA]') AND type in (N'U'))
	DROP TABLE [dbo].[ALERTA_VENTA]
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // ALERTA_VENTA 	
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[ALERTA_VENTA] (
	[K_ALERTA_VENTA]		INT				NOT NULL,
	[D_ALERTA_VENTA]		VARCHAR (100)	NOT NULL,
	[S_ALERTA_VENTA]		VARCHAR (10)	NOT NULL,
	[O_ALERTA_VENTA]		INT				NOT NULL,
	[C_ALERTA_VENTA]		VARCHAR (255)	NOT NULL,
	[L_ALERTA_VENTA]		INT				NOT NULL	
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[ALERTA_VENTA]
	ADD CONSTRAINT [PK_ALERTA_VENTA]
		PRIMARY KEY CLUSTERED ([K_ALERTA_VENTA])
GO

-- //////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ALERTA_VENTA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ALERTA_VENTA]
GO


-- //////////////////////////////////////////////////////////////
-- //					CI - ALERTA_VENTA
-- //////////////////////////////////////////////////////////////


CREATE PROCEDURE [dbo].[PG_CI_ALERTA_VENTA]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ===================================
	@PP_K_ALERTA_VENTA		INT,
	@PP_D_ALERTA_VENTA		VARCHAR(100),
	@PP_S_ALERTA_VENTA		VARCHAR(10),
	@PP_O_ALERTA_VENTA		INT,
	@PP_C_ALERTA_VENTA		VARCHAR(255),
	@PP_L_ALERTA_VENTA		INT
AS

	INSERT INTO ALERTA_VENTA
		(	K_ALERTA_VENTA,			D_ALERTA_VENTA, 
			S_ALERTA_VENTA,			O_ALERTA_VENTA,
			C_ALERTA_VENTA,
			L_ALERTA_VENTA				)
	VALUES	
		(	@PP_K_ALERTA_VENTA,		@PP_D_ALERTA_VENTA,	
			@PP_S_ALERTA_VENTA,		@PP_O_ALERTA_VENTA,
			@PP_C_ALERTA_VENTA,
			@PP_L_ALERTA_VENTA			)

	-- ==============================================
GO


-- ///////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ALERTA_VENTA] 0, 0, 0, 'INACTIVO',			'INAC', 00, '', 1
EXECUTE [dbo].[PG_CI_ALERTA_VENTA] 0, 0, 1, '-4W VERDE',		'VRDE', 10, '', 1
EXECUTE [dbo].[PG_CI_ALERTA_VENTA] 0, 0, 2, '04W AMARILLO',		'AMAR', 20, '', 1
EXECUTE [dbo].[PG_CI_ALERTA_VENTA] 0, 0, 3, '06W NARANJA',		'NARA', 30, '', 1
EXECUTE [dbo].[PG_CI_ALERTA_VENTA] 0, 0, 4, '08W ROJO',			'ROJO', 40, '', 1
EXECUTE [dbo].[PG_CI_ALERTA_VENTA] 0, 0, 5, '10W NEGRO',		'NEGR', 50, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================


-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // TIPO_CLIENTE_TMK 	
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[TIPO_CLIENTE_TMK] (
	[K_TIPO_CLIENTE_TMK]	INT				NOT NULL,
	[D_TIPO_CLIENTE_TMK]	VARCHAR (100)	NOT NULL,
	[S_TIPO_CLIENTE_TMK]	VARCHAR (10)	NOT NULL,
	[O_TIPO_CLIENTE_TMK]	INT				NOT NULL,
	[C_TIPO_CLIENTE_TMK]	VARCHAR (255)	NOT NULL,
	[L_TIPO_CLIENTE_TMK]	INT				NOT NULL	
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[TIPO_CLIENTE_TMK]
	ADD CONSTRAINT [PK_TIPO_CLIENTE_TMK]
		PRIMARY KEY CLUSTERED ([K_TIPO_CLIENTE_TMK])
GO

-- //////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_CLIENTE_TMK]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_CLIENTE_TMK]
GO


-- //////////////////////////////////////////////////////////////
-- //					CI - TIPO_CLIENTE_TMK
-- //////////////////////////////////////////////////////////////


CREATE PROCEDURE [dbo].[PG_CI_TIPO_CLIENTE_TMK]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	-- ===================================
	@PP_K_TIPO_CLIENTE_TMK		INT,
	@PP_D_TIPO_CLIENTE_TMK		VARCHAR(100),
	@PP_S_TIPO_CLIENTE_TMK		VARCHAR(10),
	@PP_O_TIPO_CLIENTE_TMK		INT,
	@PP_C_TIPO_CLIENTE_TMK		VARCHAR(255),
	@PP_L_TIPO_CLIENTE_TMK		INT
AS

	INSERT INTO TIPO_CLIENTE_TMK
		(	K_TIPO_CLIENTE_TMK,			D_TIPO_CLIENTE_TMK, 
			S_TIPO_CLIENTE_TMK,			O_TIPO_CLIENTE_TMK,
			C_TIPO_CLIENTE_TMK,
			L_TIPO_CLIENTE_TMK				)
	VALUES	
		(	@PP_K_TIPO_CLIENTE_TMK,		@PP_D_TIPO_CLIENTE_TMK,	
			@PP_S_TIPO_CLIENTE_TMK,		@PP_O_TIPO_CLIENTE_TMK,
			@PP_C_TIPO_CLIENTE_TMK,
			@PP_L_TIPO_CLIENTE_TMK			)

	-- ==============================================
GO


-- ///////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_TIPO_CLIENTE_TMK] 0, 0, 1, 'CONTADO',	'CONT', 10, '', 1
EXECUTE [dbo].[PG_CI_TIPO_CLIENTE_TMK] 0, 0, 2, 'CRÉDITO',	'CRED', 20, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================


-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // ESTATUS_CLIENTE_TMK 	
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[ESTATUS_CLIENTE_TMK] (
	[K_ESTATUS_CLIENTE_TMK]		INT				NOT NULL,
	[D_ESTATUS_CLIENTE_TMK]		VARCHAR (100)	NOT NULL,
	[S_ESTATUS_CLIENTE_TMK]		VARCHAR (10)	NOT NULL,
	[O_ESTATUS_CLIENTE_TMK]		INT				NOT NULL,
	[C_ESTATUS_CLIENTE_TMK]		VARCHAR (255)	NOT NULL,
	[L_ESTATUS_CLIENTE_TMK]		INT				NOT NULL	
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[ESTATUS_CLIENTE_TMK]
	ADD CONSTRAINT [PK_ESTATUS_CLIENTE_TMK]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_CLIENTE_TMK])
GO

-- //////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_CLIENTE_TMK]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_CLIENTE_TMK]
GO


-- //////////////////////////////////////////////////////////////
-- //					CI - ESTATUS_CLIENTE_TMK
-- //////////////////////////////////////////////////////////////


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_CLIENTE_TMK]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ===================================
	@PP_K_ESTATUS_CLIENTE_TMK		INT,
	@PP_D_ESTATUS_CLIENTE_TMK		VARCHAR(100),
	@PP_S_ESTATUS_CLIENTE_TMK		VARCHAR(10),
	@PP_O_ESTATUS_CLIENTE_TMK		INT,
	@PP_C_ESTATUS_CLIENTE_TMK		VARCHAR(255),
	@PP_L_ESTATUS_CLIENTE_TMK		INT
AS

	INSERT INTO ESTATUS_CLIENTE_TMK
		(	K_ESTATUS_CLIENTE_TMK,			D_ESTATUS_CLIENTE_TMK, 
			S_ESTATUS_CLIENTE_TMK,			O_ESTATUS_CLIENTE_TMK,
			C_ESTATUS_CLIENTE_TMK,
			L_ESTATUS_CLIENTE_TMK				)
	VALUES	
		(	@PP_K_ESTATUS_CLIENTE_TMK,		@PP_D_ESTATUS_CLIENTE_TMK,	
			@PP_S_ESTATUS_CLIENTE_TMK,		@PP_O_ESTATUS_CLIENTE_TMK,
			@PP_C_ESTATUS_CLIENTE_TMK,
			@PP_L_ESTATUS_CLIENTE_TMK			)

	-- ==============================================
GO


-- ///////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_CLIENTE_TMK] 0, 0, 0, 'INACTIVO',	'INAC', 00, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_CLIENTE_TMK] 0, 0, 1, 'ACTIVO',	'ACTI', 10, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================


-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // CLIENTE_TMK 	
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[CLIENTE_TMK] (
	[K_CLIENTE_TMK]				INT				NOT NULL,
	[D_CLIENTE_TMK]				VARCHAR (255)	NOT NULL,
	[C_CLIENTE_TMK]				VARCHAR (500)	NOT NULL,
	[S_CLIENTE_TMK]				VARCHAR (10)	NOT NULL,
	-- ==============================================
	[K_ESTATUS_CLIENTE_TMK]		INT				NOT NULL,
	[K_ALERTA_VENTA]			INT				NOT NULL,
	[K_TIPO_CLIENTE_TMK]		INT				NOT NULL,
	[K_ZONA_REPARTO]			INT				NOT NULL,
	-- ==============================================
	[NOMBRE]					VARCHAR(100)	NOT NULL,	
	[APELLIDO_PATERNO]			VARCHAR(100)	NOT NULL,
	[APELLIDO_MATERNO]			VARCHAR(100)	NOT NULL,
	[RFC]						VARCHAR(100)	NOT NULL,	-- rfc
	-- ==============================================
	[CALLE]						VARCHAR(100)	NOT NULL,
	[NUMERO_EXTERIOR]			VARCHAR(100)	NOT NULL,
	[NUMERO_INTERIOR]			VARCHAR(100)	NOT NULL,
	[ENTRE_CALLE]				VARCHAR(100)	NOT NULL,
	[Y_CALLE]					VARCHAR(100)	NOT NULL,
	[COLONIA]					VARCHAR(100)	NOT NULL,
	-- ==============================================
	[MUNICIPIO]					VARCHAR(100)	NOT NULL,
	[ESTADO]					VARCHAR(100)	NOT NULL,
	[CP]						VARCHAR(100)	NOT NULL
	-- ==============================================
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[CLIENTE_TMK]
	ADD CONSTRAINT [PK_CLIENTE_TMK]
		PRIMARY KEY CLUSTERED ([K_CLIENTE_TMK])
GO

CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_CLIENTE_TMK_01_DESCRIPCION] 
	   ON [dbo].[CLIENTE_TMK] ( [D_CLIENTE_TMK] )
GO

-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[CLIENTE_TMK] ADD 
	CONSTRAINT [FK_CLIENTE_TMK_01] 
		FOREIGN KEY ([K_ESTATUS_CLIENTE_TMK]) 
		REFERENCES [dbo].[ESTATUS_CLIENTE_TMK] ([K_ESTATUS_CLIENTE_TMK]),
	CONSTRAINT [FK_CLIENTE_TMK_02] 
		FOREIGN KEY ([K_ALERTA_VENTA]) 
		REFERENCES [dbo].[ALERTA_VENTA] ([K_ALERTA_VENTA]),
	CONSTRAINT [FK_CLIENTE_TMK_03] 
		FOREIGN KEY ([K_TIPO_CLIENTE_TMK]) 
		REFERENCES [dbo].[TIPO_CLIENTE_TMK] ([K_TIPO_CLIENTE_TMK]),
	CONSTRAINT [FK_CLIENTE_TMK_04] 
		FOREIGN KEY ([K_ZONA_REPARTO]) 
		REFERENCES [dbo].[ZONA_REPARTO] ([K_ZONA_REPARTO])
GO


-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[CLIENTE_TMK] 
	ADD		[K_USUARIO_ALTA]		[INT]		NOT NULL,
			[F_ALTA]				[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]		[INT]		NOT NULL,
			[F_CAMBIO]				[DATETIME]	NOT NULL,
			[L_BORRADO]				[INT]		NOT NULL,
			[K_USUARIO_BAJA]		[INT]		NULL,
			[F_BAJA]				[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[CLIENTE_TMK] ADD 
	CONSTRAINT [FK_CLIENTE_TMK_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_CLIENTE_TMK_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_CLIENTE_TMK_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO




-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////