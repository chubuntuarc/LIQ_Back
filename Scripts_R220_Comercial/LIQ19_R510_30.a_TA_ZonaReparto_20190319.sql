-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	
-- // MÓDULO:			CATÁLOGOS / ZONA_REPARTO
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZONA_REPARTO]') AND type in (N'U'))
	DROP TABLE [dbo].[ZONA_REPARTO]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_ZONA_REPARTO]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_ZONA_REPARTO]
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // ESTATUS_ZONA_REPARTO 	
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[ESTATUS_ZONA_REPARTO] (
	[K_ESTATUS_ZONA_REPARTO]		INT				NOT NULL,
	[D_ESTATUS_ZONA_REPARTO]		VARCHAR (100)	NOT NULL,
	[S_ESTATUS_ZONA_REPARTO]		VARCHAR (10)	NOT NULL,
	[O_ESTATUS_ZONA_REPARTO]		INT				NOT NULL,
	[C_ESTATUS_ZONA_REPARTO]		VARCHAR (255)	NOT NULL,
	[L_ESTATUS_ZONA_REPARTO]		INT				NOT NULL	
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[ESTATUS_ZONA_REPARTO]
	ADD CONSTRAINT [PK_ESTATUS_ZONA_REPARTO]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_ZONA_REPARTO])
GO

-- //////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_ZONA_REPARTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_ZONA_REPARTO]
GO


-- //////////////////////////////////////////////////////////////
-- //					CI - ESTATUS_ZONA_REPARTO
-- //////////////////////////////////////////////////////////////


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_ZONA_REPARTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ===================================
	@PP_K_ESTATUS_ZONA_REPARTO		INT,
	@PP_D_ESTATUS_ZONA_REPARTO		VARCHAR(100),
	@PP_S_ESTATUS_ZONA_REPARTO		VARCHAR(10),
	@PP_O_ESTATUS_ZONA_REPARTO		INT,
	@PP_C_ESTATUS_ZONA_REPARTO		VARCHAR(255),
	@PP_L_ESTATUS_ZONA_REPARTO		INT
AS

	INSERT INTO ESTATUS_ZONA_REPARTO
		(	K_ESTATUS_ZONA_REPARTO,			D_ESTATUS_ZONA_REPARTO, 
			S_ESTATUS_ZONA_REPARTO,			O_ESTATUS_ZONA_REPARTO,
			C_ESTATUS_ZONA_REPARTO,
			L_ESTATUS_ZONA_REPARTO				)
	VALUES	
		(	@PP_K_ESTATUS_ZONA_REPARTO,		@PP_D_ESTATUS_ZONA_REPARTO,	
			@PP_S_ESTATUS_ZONA_REPARTO,		@PP_O_ESTATUS_ZONA_REPARTO,
			@PP_C_ESTATUS_ZONA_REPARTO,
			@PP_L_ESTATUS_ZONA_REPARTO			)

	-- ==============================================
GO


-- ///////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_ZONA_REPARTO] 0, 0, 0, 'INACTIVO',	'INAC', 20, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_ZONA_REPARTO] 0, 0, 1, 'ACTIVO',		'ACTI', 10, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================


-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // ZONA_REPARTO 	
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[ZONA_REPARTO] (
	[K_ZONA_REPARTO]			INT				NOT NULL,
	[C_ZONA_REPARTO]			VARCHAR (500)	NOT NULL,
	-- ==============================================
--	[K_COBRADOR]				INT				NOT NULL,
	[K_RUTA_REPARTO]			INT				NOT NULL,
	-- ==============================================
	[K_ESTATUS_ZONA_REPARTO]	INT				NOT NULL
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[ZONA_REPARTO]
	ADD CONSTRAINT [PK_ZONA_REPARTO]
		PRIMARY KEY CLUSTERED ( [K_ZONA_REPARTO] )
GO


/*

CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ZONA_REPARTO_K_COBRADOR_K_RUTA_REPARTO] 
	   ON [dbo].[ZONA_REPARTO] ( [K_COBRADOR], [K_RUTA_REPARTO] )
GO

*/

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[ZONA_REPARTO] ADD 
	CONSTRAINT [FK_ZONA_REPARTO_01] 
		FOREIGN KEY ([K_RUTA_REPARTO]) 
		REFERENCES [dbo].[RUTA_REPARTO] ([K_RUTA_REPARTO]),
	CONSTRAINT [FK_ZONA_REPARTO_02] 
		FOREIGN KEY ([K_ESTATUS_ZONA_REPARTO]) 
		REFERENCES [dbo].[ESTATUS_ZONA_REPARTO] ([K_ESTATUS_ZONA_REPARTO])
GO

-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[ZONA_REPARTO] 
	ADD		[K_USUARIO_ALTA]		[INT]		NOT NULL,
			[F_ALTA]				[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]		[INT]		NOT NULL,
			[F_CAMBIO]				[DATETIME]	NOT NULL,
			[L_BORRADO]				[INT]		NOT NULL,
			[K_USUARIO_BAJA]		[INT]		NULL,
			[F_BAJA]				[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[ZONA_REPARTO] ADD 
	CONSTRAINT [FK_ZONA_REPARTO_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_ZONA_REPARTO_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_ZONA_REPARTO_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO




-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////