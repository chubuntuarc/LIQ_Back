-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			PUNTO_VENTA 
-- // OPERACION:		LIBERACION / TABLAS 
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		JESUS ARCINIEGA
-- // FECHA:		29/ENE/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PUNTO_VENTA]') AND type in (N'U'))
	DROP TABLE [dbo].[PUNTO_VENTA]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_PUNTO_VENTA]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_PUNTO_VENTA]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_PUNTO_VENTA]') AND type in (N'U'))
	DROP TABLE [dbo].[TIPO_PUNTO_VENTA]
GO





-- //////////////////////////////////////////////////////////////
-- // TIPO_PUNTO_VENTA
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[TIPO_PUNTO_VENTA] (
	[K_TIPO_PUNTO_VENTA]	[INT] NOT NULL,
	[D_TIPO_PUNTO_VENTA]	[VARCHAR] (100) NOT NULL,
	[S_TIPO_PUNTO_VENTA]	[VARCHAR] (10) NOT NULL,
	[O_TIPO_PUNTO_VENTA]	[INT] NOT NULL,
	[C_TIPO_PUNTO_VENTA]	[VARCHAR] (255) NOT NULL,
	[L_TIPO_PUNTO_VENTA]	[INT] NOT NULL,
	[K_CLASE_PUNTO_VENTA]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_PUNTO_VENTA]
	ADD CONSTRAINT [PK_TIPO_PUNTO_VENTA]
		PRIMARY KEY CLUSTERED ([K_TIPO_PUNTO_VENTA])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_TIPO_PUNTO_VENTA_01_DESCRIPCION] 
	   ON [dbo].[TIPO_PUNTO_VENTA] ( [D_TIPO_PUNTO_VENTA] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_PUNTO_VENTA] ADD 
	CONSTRAINT [FK_TIPO_PUNTO_VENTA_01] 
		FOREIGN KEY ( [L_TIPO_PUNTO_VENTA] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO



-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_PUNTO_VENTA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_PUNTO_VENTA]
GO


CREATE PROCEDURE [dbo].[PG_CI_TIPO_PUNTO_VENTA]
	@PP_L_DEBUG							INT,
	@PP_K_SISTEMA_EXE					INT,
	-- ========================================
	@PP_K_TIPO_PUNTO_VENTA			INT,
	@PP_D_TIPO_PUNTO_VENTA			VARCHAR(100),
	@PP_S_TIPO_PUNTO_VENTA			VARCHAR(10),
	@PP_O_TIPO_PUNTO_VENTA			INT,
	@PP_C_TIPO_PUNTO_VENTA			VARCHAR(255),
	@PP_L_TIPO_PUNTO_VENTA			INT,
	@PP_K_CLASE_PUNTO_VENTA			INT		
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_TIPO_PUNTO_VENTA
							FROM	TIPO_PUNTO_VENTA
							WHERE	K_TIPO_PUNTO_VENTA=@PP_K_TIPO_PUNTO_VENTA

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO TIPO_PUNTO_VENTA
			(	K_TIPO_PUNTO_VENTA,				D_TIPO_PUNTO_VENTA, 
				S_TIPO_PUNTO_VENTA,				O_TIPO_PUNTO_VENTA,
				C_TIPO_PUNTO_VENTA,
				L_TIPO_PUNTO_VENTA,
				K_CLASE_PUNTO_VENTA				)
		VALUES	
			(	@PP_K_TIPO_PUNTO_VENTA,			@PP_D_TIPO_PUNTO_VENTA,	
				@PP_S_TIPO_PUNTO_VENTA,			@PP_O_TIPO_PUNTO_VENTA,
				@PP_C_TIPO_PUNTO_VENTA,
				@PP_L_TIPO_PUNTO_VENTA,
				@PP_K_CLASE_PUNTO_VENTA			)
	ELSE
		UPDATE	TIPO_PUNTO_VENTA
		SET		D_TIPO_PUNTO_VENTA	= @PP_D_TIPO_PUNTO_VENTA,	
				S_TIPO_PUNTO_VENTA	= @PP_S_TIPO_PUNTO_VENTA,			
				O_TIPO_PUNTO_VENTA	= @PP_O_TIPO_PUNTO_VENTA,
				C_TIPO_PUNTO_VENTA	= @PP_C_TIPO_PUNTO_VENTA,
				L_TIPO_PUNTO_VENTA	= @PP_L_TIPO_PUNTO_VENTA,
				K_CLASE_PUNTO_VENTA	= @PP_K_CLASE_PUNTO_VENTA	
		WHERE	K_TIPO_PUNTO_VENTA=@PP_K_TIPO_PUNTO_VENTA

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================


EXECUTE [dbo].[PG_CI_TIPO_PUNTO_VENTA] 0, 0,  1, 'AUTOTANQUE',				'AUT', 10, '', 1, 1
EXECUTE [dbo].[PG_CI_TIPO_PUNTO_VENTA] 0, 0,  2, 'ESTACION CARBURACION',	'EST', 20, '', 1, 2
EXECUTE [dbo].[PG_CI_TIPO_PUNTO_VENTA] 0, 0,  3, 'PORTATIL',				'POR', 30, '', 1, 1
GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================



-- //////////////////////////////////////////////////////////////
-- // ESTATUS_PUNTO_VENTA
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTATUS_PUNTO_VENTA] (
	[K_ESTATUS_PUNTO_VENTA]	[INT] NOT NULL,
	[D_ESTATUS_PUNTO_VENTA]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_PUNTO_VENTA]	[VARCHAR] (10) NOT NULL,
	[O_ESTATUS_PUNTO_VENTA]	[INT] NOT NULL,
	[C_ESTATUS_PUNTO_VENTA]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_PUNTO_VENTA]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_PUNTO_VENTA]
	ADD CONSTRAINT [PK_ESTATUS_PUNTO_VENTA]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_PUNTO_VENTA])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_PUNTO_VENTA_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_PUNTO_VENTA] ( [D_ESTATUS_PUNTO_VENTA] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_PUNTO_VENTA] ADD 
	CONSTRAINT [FK_ESTATUS_PUNTO_VENTA_01] 
		FOREIGN KEY ( [L_ESTATUS_PUNTO_VENTA] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_PUNTO_VENTA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_PUNTO_VENTA]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_PUNTO_VENTA]
	@PP_L_DEBUG							INT,
	@PP_K_SISTEMA_EXE					INT,
	-- ========================================
	@PP_K_ESTATUS_PUNTO_VENTA		INT,
	@PP_D_ESTATUS_PUNTO_VENTA		VARCHAR(100),
	@PP_S_ESTATUS_PUNTO_VENTA		VARCHAR(10),
	@PP_O_ESTATUS_PUNTO_VENTA		INT,
	@PP_C_ESTATUS_PUNTO_VENTA		VARCHAR(255),
	@PP_L_ESTATUS_PUNTO_VENTA		INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTATUS_PUNTO_VENTA
							FROM	ESTATUS_PUNTO_VENTA
							WHERE	K_ESTATUS_PUNTO_VENTA=@PP_K_ESTATUS_PUNTO_VENTA

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_PUNTO_VENTA	
			(	K_ESTATUS_PUNTO_VENTA,				D_ESTATUS_PUNTO_VENTA, 
				S_ESTATUS_PUNTO_VENTA,				O_ESTATUS_PUNTO_VENTA,
				C_ESTATUS_PUNTO_VENTA,
				L_ESTATUS_PUNTO_VENTA				)		
		VALUES	
			(	@PP_K_ESTATUS_PUNTO_VENTA,			@PP_D_ESTATUS_PUNTO_VENTA,	
				@PP_S_ESTATUS_PUNTO_VENTA,			@PP_O_ESTATUS_PUNTO_VENTA,
				@PP_C_ESTATUS_PUNTO_VENTA,
				@PP_L_ESTATUS_PUNTO_VENTA			)
	ELSE
		UPDATE	ESTATUS_PUNTO_VENTA
		SET		D_ESTATUS_PUNTO_VENTA	= @PP_D_ESTATUS_PUNTO_VENTA,	
				S_ESTATUS_PUNTO_VENTA	= @PP_S_ESTATUS_PUNTO_VENTA,			
				O_ESTATUS_PUNTO_VENTA	= @PP_O_ESTATUS_PUNTO_VENTA,
				C_ESTATUS_PUNTO_VENTA	= @PP_C_ESTATUS_PUNTO_VENTA,
				L_ESTATUS_PUNTO_VENTA	= @PP_L_ESTATUS_PUNTO_VENTA	
		WHERE	K_ESTATUS_PUNTO_VENTA=@PP_K_ESTATUS_PUNTO_VENTA

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_PUNTO_VENTA] 0, 0, 0, 'INACTIVO',		'INACT', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_PUNTO_VENTA] 0, 0, 1, 'ACTIVO',		'ACTVO', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================







-- //////////////////////////////////////////////////////////////
-- // PUNTO_VENTA
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[PUNTO_VENTA] (
	[K_PUNTO_VENTA]				[INT]			NOT NULL,
	[D_PUNTO_VENTA]				[VARCHAR](100)	NOT NULL,
	[S_PUNTO_VENTA]				[VARCHAR](10)	NOT NULL,
	[C_PUNTO_VENTA]				[VARCHAR](255)	,
	[O_PUNTO_VENTA]				[INT]			NOT NULL,
	-- ============================	
	[K_ESTATUS_PUNTO_VENTA]		[INT]			NOT NULL,
	[K_TIPO_PUNTO_VENTA]		[INT]			NOT NULL,
	-- ============================		
	[SUCURSAL]					[VARCHAR](100)	NOT NULL,
	[PLACA]						[VARCHAR](100)	NOT NULL DEFAULT 'N/A',
	[DIRECCION]					[VARCHAR](100)	NOT NULL DEFAULT 'N/A'
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[PUNTO_VENTA]
	ADD CONSTRAINT [PK_PUNTO_VENTA]
		PRIMARY KEY CLUSTERED ([K_PUNTO_VENTA])
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[PUNTO_VENTA] ADD 
	CONSTRAINT [FK_PUNTO_VENTA_01]  
		FOREIGN KEY ([K_ESTATUS_PUNTO_VENTA]) 
		REFERENCES [dbo].[ESTATUS_PUNTO_VENTA] ([K_ESTATUS_PUNTO_VENTA]),
	CONSTRAINT [FK_PUNTO_VENTA_02]  
		FOREIGN KEY ([K_TIPO_PUNTO_VENTA]) 
		REFERENCES [dbo].[TIPO_PUNTO_VENTA] ([K_TIPO_PUNTO_VENTA])
GO


-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[PUNTO_VENTA] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[PUNTO_VENTA] ADD 
	CONSTRAINT [FK_PUNTO_VENTA_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_PUNTO_VENTA_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_PUNTO_VENTA_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
