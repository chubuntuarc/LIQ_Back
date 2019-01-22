-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			OPERADOR 
-- // OPERACION:		LIBERACION / TABLAS
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		JESUS ARCINIEGA
-- // FECHA:		22/ENE/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V0000_R0]
GO

-- //////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OPERADOR]') AND type in (N'U'))
	DROP TABLE [dbo].[OPERADOR]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_OPERADOR]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_OPERADOR]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_OPERADOR]') AND type in (N'U'))
	DROP TABLE [dbo].[TIPO_OPERADOR]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CLASE_OPERADOR]') AND type in (N'U'))
	DROP TABLE [dbo].[CLASE_OPERADOR]
GO


-- //////////////////////////////////////////////////////////////
-- // CLASE_OPERADOR
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[CLASE_OPERADOR] (
	[K_CLASE_OPERADOR]	[INT] NOT NULL,
	[D_CLASE_OPERADOR]	[VARCHAR] (100) NOT NULL,
	[S_CLASE_OPERADOR]	[VARCHAR] (10) NOT NULL,
	[O_CLASE_OPERADOR]	[INT] NOT NULL,
	[C_CLASE_OPERADOR]	[VARCHAR] (255) NOT NULL,
	[L_CLASE_OPERADOR]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[CLASE_OPERADOR]
	ADD CONSTRAINT [PK_CLASE_OPERADOR]
		PRIMARY KEY CLUSTERED ([K_CLASE_OPERADOR])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_CLASE_OPERADOR_01_DESCRIPCION] 
	   ON [dbo].[CLASE_OPERADOR] ( [D_CLASE_OPERADOR] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[CLASE_OPERADOR] ADD 
	CONSTRAINT [FK_CLASE_OPERADOR_01] 
		FOREIGN KEY ( [L_CLASE_OPERADOR] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_CLASE_OPERADOR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_CLASE_OPERADOR]
GO


CREATE PROCEDURE [dbo].[PG_CI_CLASE_OPERADOR]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	-- ========================================
	@PP_K_CLASE_OPERADOR		INT,
	@PP_D_CLASE_OPERADOR		VARCHAR(100),
	@PP_S_CLASE_OPERADOR		VARCHAR(10),
	@PP_O_CLASE_OPERADOR		INT,
	@PP_C_CLASE_OPERADOR		VARCHAR(255),
	@PP_L_CLASE_OPERADOR		INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_CLASE_OPERADOR
							FROM	CLASE_OPERADOR
							WHERE	K_CLASE_OPERADOR=@PP_K_CLASE_OPERADOR

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO CLASE_OPERADOR
			(	K_CLASE_OPERADOR,			D_CLASE_OPERADOR, 
				S_CLASE_OPERADOR,			O_CLASE_OPERADOR,
				C_CLASE_OPERADOR,
				L_CLASE_OPERADOR			)		
		VALUES	
			(	@PP_K_CLASE_OPERADOR,		@PP_D_CLASE_OPERADOR,	
				@PP_S_CLASE_OPERADOR,		@PP_O_CLASE_OPERADOR,
				@PP_C_CLASE_OPERADOR,
				@PP_L_CLASE_OPERADOR		)
	ELSE
		UPDATE	CLASE_OPERADOR
		SET		D_CLASE_OPERADOR	= @PP_D_CLASE_OPERADOR,	
				S_CLASE_OPERADOR	= @PP_S_CLASE_OPERADOR,			
				O_CLASE_OPERADOR	= @PP_O_CLASE_OPERADOR,
				C_CLASE_OPERADOR	= @PP_C_CLASE_OPERADOR,
				L_CLASE_OPERADOR	= @PP_L_CLASE_OPERADOR	
		WHERE	K_CLASE_OPERADOR=@PP_K_CLASE_OPERADOR

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////





-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_CLASE_OPERADOR] 0, 0,  1, 'OPERADOR INTERNO',		'INT', 1, '', 1
EXECUTE [dbo].[PG_CI_CLASE_OPERADOR] 0, 0,  2, 'OPERADOR EXTERNO',		'EXT', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- //////////////////////////////////////////////////////////////
-- // TIPO_OPERADOR
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[TIPO_OPERADOR] (
	[K_TIPO_OPERADOR]	[INT] NOT NULL,
	[D_TIPO_OPERADOR]	[VARCHAR] (100) NOT NULL,
	[S_TIPO_OPERADOR]	[VARCHAR] (10) NOT NULL,
	[O_TIPO_OPERADOR]	[INT] NOT NULL,
	[C_TIPO_OPERADOR]	[VARCHAR] (255) NOT NULL,
	[L_TIPO_OPERADOR]	[INT] NOT NULL,
	[K_CLASE_OPERADOR]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_OPERADOR]
	ADD CONSTRAINT [PK_TIPO_OPERADOR]
		PRIMARY KEY CLUSTERED ([K_TIPO_OPERADOR])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_TIPO_OPERADOR_01_DESCRIPCION] 
	   ON [dbo].[TIPO_OPERADOR] ( [D_TIPO_OPERADOR] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_OPERADOR] ADD 
	CONSTRAINT [FK_TIPO_OPERADOR_01] 
		FOREIGN KEY ( [L_TIPO_OPERADOR] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] ),
	CONSTRAINT [FK_TIPO_OPERADOR_02] 
		FOREIGN KEY ( [K_CLASE_OPERADOR] ) 
		REFERENCES [dbo].[CLASE_OPERADOR] ( [K_CLASE_OPERADOR] )
GO



-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_OPERADOR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_OPERADOR]
GO


CREATE PROCEDURE [dbo].[PG_CI_TIPO_OPERADOR]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_TIPO_OPERADOR			INT,
	@PP_D_TIPO_OPERADOR			VARCHAR(100),
	@PP_S_TIPO_OPERADOR			VARCHAR(10),
	@PP_O_TIPO_OPERADOR			INT,
	@PP_C_TIPO_OPERADOR			VARCHAR(255),
	@PP_L_TIPO_OPERADOR			INT,
	@PP_K_CLASE_OPERADOR			INT		
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_TIPO_OPERADOR
							FROM	TIPO_OPERADOR
							WHERE	K_TIPO_OPERADOR=@PP_K_TIPO_OPERADOR

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO TIPO_OPERADOR
			(	K_TIPO_OPERADOR,				D_TIPO_OPERADOR, 
				S_TIPO_OPERADOR,				O_TIPO_OPERADOR,
				C_TIPO_OPERADOR,
				L_TIPO_OPERADOR,
				K_CLASE_OPERADOR				)
		VALUES	
			(	@PP_K_TIPO_OPERADOR,			@PP_D_TIPO_OPERADOR,	
				@PP_S_TIPO_OPERADOR,			@PP_O_TIPO_OPERADOR,
				@PP_C_TIPO_OPERADOR,
				@PP_L_TIPO_OPERADOR,
				@PP_K_CLASE_OPERADOR			)
	ELSE
		UPDATE	TIPO_OPERADOR
		SET		D_TIPO_OPERADOR	= @PP_D_TIPO_OPERADOR,	
				S_TIPO_OPERADOR	= @PP_S_TIPO_OPERADOR,			
				O_TIPO_OPERADOR	= @PP_O_TIPO_OPERADOR,
				C_TIPO_OPERADOR	= @PP_C_TIPO_OPERADOR,
				L_TIPO_OPERADOR	= @PP_L_TIPO_OPERADOR,
				K_CLASE_OPERADOR	= @PP_K_CLASE_OPERADOR	
		WHERE	K_TIPO_OPERADOR=@PP_K_TIPO_OPERADOR

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================


EXECUTE [dbo].[PG_CI_TIPO_OPERADOR] 0, 0,  1, 'VENDEDOR ESTACION',				'VEST', 1, '', 1, 1
EXECUTE [dbo].[PG_CI_TIPO_OPERADOR] 0, 0,  2, 'OPERADOR AUTOTANQUE',			'OAUT', 1, '', 1, 1
EXECUTE [dbo].[PG_CI_TIPO_OPERADOR] 0, 0,  3, 'OPERADOR CILINDRERA',			'OCIL', 1, '', 1, 1
EXECUTE [dbo].[PG_CI_TIPO_OPERADOR] 0, 0,  3, 'OPERADOR TRACTOCAMION INTERNO',	'OTRI', 1, '', 1, 1
EXECUTE [dbo].[PG_CI_TIPO_OPERADOR] 0, 0,  3, 'OPERADOR TRACTOCAMION EXTERNO',	'OTRE', 1, '', 1, 2
GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================



-- //////////////////////////////////////////////////////////////
-- // ESTATUS_OPERADOR
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTATUS_OPERADOR] (
	[K_ESTATUS_OPERADOR]	[INT] NOT NULL,
	[D_ESTATUS_OPERADOR]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_OPERADOR]	[VARCHAR] (10) NOT NULL,
	[O_ESTATUS_OPERADOR]	[INT] NOT NULL,
	[C_ESTATUS_OPERADOR]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_OPERADOR]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_OPERADOR]
	ADD CONSTRAINT [PK_ESTATUS_OPERADOR]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_OPERADOR])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_OPERADOR_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_OPERADOR] ( [D_ESTATUS_OPERADOR] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_OPERADOR] ADD 
	CONSTRAINT [FK_ESTATUS_OPERADOR_01] 
		FOREIGN KEY ( [L_ESTATUS_OPERADOR] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_OPERADOR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_OPERADOR]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_OPERADOR]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_ESTATUS_OPERADOR		INT,
	@PP_D_ESTATUS_OPERADOR		VARCHAR(100),
	@PP_S_ESTATUS_OPERADOR		VARCHAR(10),
	@PP_O_ESTATUS_OPERADOR		INT,
	@PP_C_ESTATUS_OPERADOR		VARCHAR(255),
	@PP_L_ESTATUS_OPERADOR		INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTATUS_OPERADOR
							FROM	ESTATUS_OPERADOR
							WHERE	K_ESTATUS_OPERADOR=@PP_K_ESTATUS_OPERADOR

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_OPERADOR	
			(	K_ESTATUS_OPERADOR,				D_ESTATUS_OPERADOR, 
				S_ESTATUS_OPERADOR,				O_ESTATUS_OPERADOR,
				C_ESTATUS_OPERADOR,
				L_ESTATUS_OPERADOR				)		
		VALUES	
			(	@PP_K_ESTATUS_OPERADOR,			@PP_D_ESTATUS_OPERADOR,	
				@PP_S_ESTATUS_OPERADOR,			@PP_O_ESTATUS_OPERADOR,
				@PP_C_ESTATUS_OPERADOR,
				@PP_L_ESTATUS_OPERADOR			)
	ELSE
		UPDATE	ESTATUS_OPERADOR
		SET		D_ESTATUS_OPERADOR	= @PP_D_ESTATUS_OPERADOR,	
				S_ESTATUS_OPERADOR	= @PP_S_ESTATUS_OPERADOR,			
				O_ESTATUS_OPERADOR	= @PP_O_ESTATUS_OPERADOR,
				C_ESTATUS_OPERADOR	= @PP_C_ESTATUS_OPERADOR,
				L_ESTATUS_OPERADOR	= @PP_L_ESTATUS_OPERADOR	
		WHERE	K_ESTATUS_OPERADOR=@PP_K_ESTATUS_OPERADOR

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_OPERADOR] 0, 0, 0, 'INACTIVO',		'INACT', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_OPERADOR] 0, 0, 1, 'ACTIVO',		'ACTVO', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- //////////////////////////////////////////////////////////////
-- // OPERADOR
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[OPERADOR] (
	[K_OPERADOR]				[INT]			NOT NULL,
	[D_OPERADOR]				[VARCHAR](100)	NOT NULL DEFAULT '',
	[S_OPERADOR]				[VARCHAR](10)	NOT NULL DEFAULT '',
	[O_OPERADOR]				[INT]			NOT NULL DEFAULT 0,
	-- ============================	
	[K_ESTATUS_OPERADOR]		[INT]			NOT NULL,
	-- ============================		
	[NOMBRE]				[VARCHAR](100)	NOT NULL DEFAULT '', 
	[APELLIDO_PATERNO]		[VARCHAR](100)	NOT NULL DEFAULT '', 
	[APELLIDO_MATERNO]		[VARCHAR](100)	NOT NULL DEFAULT '', 
	[RFC_OPERADOR]			[VARCHAR](100)	NOT NULL DEFAULT '',
	[CURP]					[VARCHAR](100)	NOT NULL DEFAULT '',
	[LICENCIA]				[VARCHAR](100)	NOT NULL DEFAULT '',
	[CORREO]				[VARCHAR](100)	NOT NULL DEFAULT '',
	[TELEFONO]				[VARCHAR](100)	NOT NULL DEFAULT '',
	-- ============================
	[CALLE]					[VARCHAR](255)	NOT NULL,
	[NUMERO_EXTERIOR]		[VARCHAR](10)	NOT NULL DEFAULT '',
	[NUMERO_INTERIOR]		[VARCHAR](10)	NOT NULL DEFAULT '',
	[COLONIA]				[VARCHAR](100)	NOT NULL DEFAULT '',
	[POBLACION]				[VARCHAR](100)	NOT NULL DEFAULT '',
	[CP]					[VARCHAR](10)	NOT NULL DEFAULT '',
	[MUNICIPIO]				[VARCHAR](100)	NOT NULL DEFAULT '',
	[K_REGION]				[INT]			NOT NULL DEFAULT 0
	-- ============================
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[OPERADOR]
	ADD CONSTRAINT [PK_OPERADOR]
		PRIMARY KEY CLUSTERED ([K_OPERADOR])
GO


-- //////////////////////////////////////////////////////////////

ALTER TABLE [dbo].[OPERADOR] ADD 
	CONSTRAINT [FK_OPERADOR_02]  
		FOREIGN KEY ([K_ESTATUS_OPERADOR]) 
		REFERENCES [dbo].[ESTATUS_OPERADOR] ([K_ESTATUS_OPERADOR]),
	CONSTRAINT [FK_OPERADOR_03]  
		FOREIGN KEY ([K_TIPO_OPERADOR]) 
		REFERENCES [dbo].[TIPO_OPERADOR] ([K_TIPO_OPERADOR])
GO



-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[OPERADOR] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[OPERADOR] ADD 
	CONSTRAINT [FK_OPERADOR_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_OPERADOR_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_OPERADOR_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
