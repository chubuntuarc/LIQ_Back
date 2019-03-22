-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	CYC19_Crédito
-- // MÓDULO:			CATÁLOGOS / UNIDAD_RUTA
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UNIDAD_RUTA]') AND type in (N'U'))
	DROP TABLE [dbo].[UNIDAD_RUTA]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_UNIDAD_RUTA]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_UNIDAD_RUTA]
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // ESTATUS_UNIDAD_RUTA 	
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[ESTATUS_UNIDAD_RUTA] (
	[K_ESTATUS_UNIDAD_RUTA]		INT				NOT NULL,
	[D_ESTATUS_UNIDAD_RUTA]		VARCHAR (100)	NOT NULL,
	[S_ESTATUS_UNIDAD_RUTA]		VARCHAR (10)	NOT NULL,
	[O_ESTATUS_UNIDAD_RUTA]		INT				NOT NULL,
	[C_ESTATUS_UNIDAD_RUTA]		VARCHAR (255)	NOT NULL,
	[L_ESTATUS_UNIDAD_RUTA]		INT				NOT NULL	
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[ESTATUS_UNIDAD_RUTA]
	ADD CONSTRAINT [PK_ESTATUS_UNIDAD_RUTA]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_UNIDAD_RUTA])
GO

-- //////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_UNIDAD_RUTA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_UNIDAD_RUTA]
GO


-- //////////////////////////////////////////////////////////////
-- //					CI - ESTATUS_UNIDAD_RUTA
-- //////////////////////////////////////////////////////////////


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_UNIDAD_RUTA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ===================================
	@PP_K_ESTATUS_UNIDAD_RUTA		INT,
	@PP_D_ESTATUS_UNIDAD_RUTA		VARCHAR(100),
	@PP_S_ESTATUS_UNIDAD_RUTA		VARCHAR(10),
	@PP_O_ESTATUS_UNIDAD_RUTA		INT,
	@PP_C_ESTATUS_UNIDAD_RUTA		VARCHAR(255),
	@PP_L_ESTATUS_UNIDAD_RUTA		INT
AS

	INSERT INTO ESTATUS_UNIDAD_RUTA
		(	K_ESTATUS_UNIDAD_RUTA,			D_ESTATUS_UNIDAD_RUTA, 
			S_ESTATUS_UNIDAD_RUTA,			O_ESTATUS_UNIDAD_RUTA,
			C_ESTATUS_UNIDAD_RUTA,
			L_ESTATUS_UNIDAD_RUTA				)
	VALUES	
		(	@PP_K_ESTATUS_UNIDAD_RUTA,		@PP_D_ESTATUS_UNIDAD_RUTA,	
			@PP_S_ESTATUS_UNIDAD_RUTA,		@PP_O_ESTATUS_UNIDAD_RUTA,
			@PP_C_ESTATUS_UNIDAD_RUTA,
			@PP_L_ESTATUS_UNIDAD_RUTA			)

	-- ==============================================
GO


-- ///////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_UNIDAD_RUTA] 0, 0, 0, 'INACTIVO',	'INAC', 20, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_UNIDAD_RUTA] 0, 0, 1, 'ACTIVO',		'ACTI', 10, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================


-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // UNIDAD_RUTA 	
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[UNIDAD_RUTA] (
	[K_UNIDAD_RUTA]			INT				NOT NULL,
	[C_UNIDAD_RUTA]			VARCHAR (500)	NOT NULL,
	-- ==============================================
	[K_RUTA_REPARTO]		INT				NOT NULL,
	[K_PUNTO_VENTA]			INT				NOT NULL,
	-- ==============================================
	[K_ESTATUS_UNIDAD_RUTA]	INT				NOT NULL
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[UNIDAD_RUTA]
	ADD CONSTRAINT [PK_UNIDAD_RUTA]
		PRIMARY KEY CLUSTERED ( [K_UNIDAD_RUTA] )
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_UNIDAD_RUTA_K_PUNTO_VENTA_K_RUTA_REPARTO] 
	   ON [dbo].[UNIDAD_RUTA] ( [K_PUNTO_VENTA], [K_RUTA_REPARTO] )
GO



-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[UNIDAD_RUTA] ADD 
	CONSTRAINT [FK_UNIDAD_RUTA_01] 
		FOREIGN KEY ([K_PUNTO_VENTA]) 
		REFERENCES [dbo].[PUNTO_VENTA] ([K_PUNTO_VENTA]),
	CONSTRAINT [FK_UNIDAD_RUTA_02] 
		FOREIGN KEY ([K_RUTA_REPARTO]) 
		REFERENCES [dbo].[RUTA_REPARTO] ([K_RUTA_REPARTO]),
	CONSTRAINT [FK_UNIDAD_RUTA_03] 
		FOREIGN KEY ([K_ESTATUS_UNIDAD_RUTA]) 
		REFERENCES [dbo].[ESTATUS_UNIDAD_RUTA] ([K_ESTATUS_UNIDAD_RUTA])
GO

-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[UNIDAD_RUTA] 
	ADD		[K_USUARIO_ALTA]		[INT]		NOT NULL,
			[F_ALTA]				[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]		[INT]		NOT NULL,
			[F_CAMBIO]				[DATETIME]	NOT NULL,
			[L_BORRADO]				[INT]		NOT NULL,
			[K_USUARIO_BAJA]		[INT]		NULL,
			[F_BAJA]				[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[UNIDAD_RUTA] ADD 
	CONSTRAINT [FK_UNIDAD_RUTA_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_UNIDAD_RUTA_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_UNIDAD_RUTA_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO




-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////