-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CLIENTE 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CLIENTE]') AND type in (N'U'))
	DROP TABLE [dbo].[CLIENTE]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_CLIENTE]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_CLIENTE]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_CLIENTE]') AND type in (N'U'))
	DROP TABLE [dbo].[TIPO_CLIENTE]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CLASE_CLIENTE]') AND type in (N'U'))
	DROP TABLE [dbo].[CLASE_CLIENTE]
GO


-- //////////////////////////////////////////////////////////////
-- // CLASE_CLIENTE
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[CLASE_CLIENTE] (
	[K_CLASE_CLIENTE]	[INT] NOT NULL,
	[D_CLASE_CLIENTE]	[VARCHAR] (100) NOT NULL,
	[S_CLASE_CLIENTE]	[VARCHAR] (10) NOT NULL,
	[O_CLASE_CLIENTE]	[INT] NOT NULL,
	[C_CLASE_CLIENTE]	[VARCHAR] (255) NOT NULL,
	[L_CLASE_CLIENTE]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[CLASE_CLIENTE]
	ADD CONSTRAINT [PK_CLASE_CLIENTE]
		PRIMARY KEY CLUSTERED ([K_CLASE_CLIENTE])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_CLASE_CLIENTE_01_DESCRIPCION] 
	   ON [dbo].[CLASE_CLIENTE] ( [D_CLASE_CLIENTE] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[CLASE_CLIENTE] ADD 
	CONSTRAINT [FK_CLASE_CLIENTE_01] 
		FOREIGN KEY ( [L_CLASE_CLIENTE] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_CLASE_CLIENTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_CLASE_CLIENTE]
GO


CREATE PROCEDURE [dbo].[PG_CI_CLASE_CLIENTE]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	-- ========================================
	@PP_K_CLASE_CLIENTE		INT,
	@PP_D_CLASE_CLIENTE		VARCHAR(100),
	@PP_S_CLASE_CLIENTE		VARCHAR(10),
	@PP_O_CLASE_CLIENTE		INT,
	@PP_C_CLASE_CLIENTE		VARCHAR(255),
	@PP_L_CLASE_CLIENTE		INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_CLASE_CLIENTE
							FROM	CLASE_CLIENTE
							WHERE	K_CLASE_CLIENTE=@PP_K_CLASE_CLIENTE

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO CLASE_CLIENTE
			(	K_CLASE_CLIENTE,			D_CLASE_CLIENTE, 
				S_CLASE_CLIENTE,			O_CLASE_CLIENTE,
				C_CLASE_CLIENTE,
				L_CLASE_CLIENTE			)		
		VALUES	
			(	@PP_K_CLASE_CLIENTE,		@PP_D_CLASE_CLIENTE,	
				@PP_S_CLASE_CLIENTE,		@PP_O_CLASE_CLIENTE,
				@PP_C_CLASE_CLIENTE,
				@PP_L_CLASE_CLIENTE		)
	ELSE
		UPDATE	CLASE_CLIENTE
		SET		D_CLASE_CLIENTE	= @PP_D_CLASE_CLIENTE,	
				S_CLASE_CLIENTE	= @PP_S_CLASE_CLIENTE,			
				O_CLASE_CLIENTE	= @PP_O_CLASE_CLIENTE,
				C_CLASE_CLIENTE	= @PP_C_CLASE_CLIENTE,
				L_CLASE_CLIENTE	= @PP_L_CLASE_CLIENTE	
		WHERE	K_CLASE_CLIENTE=@PP_K_CLASE_CLIENTE

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////





-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_CLASE_CLIENTE] 0, 0,  1, 'CLASE CLIENTE 1',		'CCLI1', 1, '', 1
EXECUTE [dbo].[PG_CI_CLASE_CLIENTE] 0, 0,  2, 'CLASE CLIENTE 2',		'CCLI2', 1, '', 1
EXECUTE [dbo].[PG_CI_CLASE_CLIENTE] 0, 0,  3, 'CLASE CLIENTE 3',		'CCLI3', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- //////////////////////////////////////////////////////////////
-- // TIPO_CLIENTE
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[TIPO_CLIENTE] (
	[K_TIPO_CLIENTE]	[INT] NOT NULL,
	[D_TIPO_CLIENTE]	[VARCHAR] (100) NOT NULL,
	[S_TIPO_CLIENTE]	[VARCHAR] (10) NOT NULL,
	[O_TIPO_CLIENTE]	[INT] NOT NULL,
	[C_TIPO_CLIENTE]	[VARCHAR] (255) NOT NULL,
	[L_TIPO_CLIENTE]	[INT] NOT NULL,
	[K_CLASE_CLIENTE]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_CLIENTE]
	ADD CONSTRAINT [PK_TIPO_CLIENTE]
		PRIMARY KEY CLUSTERED ([K_TIPO_CLIENTE])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_TIPO_CLIENTE_01_DESCRIPCION] 
	   ON [dbo].[TIPO_CLIENTE] ( [D_TIPO_CLIENTE] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_CLIENTE] ADD 
	CONSTRAINT [FK_TIPO_CLIENTE_01] 
		FOREIGN KEY ( [L_TIPO_CLIENTE] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] ),
	CONSTRAINT [FK_TIPO_CLIENTE_02] 
		FOREIGN KEY ( [K_CLASE_CLIENTE] ) 
		REFERENCES [dbo].[CLASE_CLIENTE] ( [K_CLASE_CLIENTE] )
GO



-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_CLIENTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_CLIENTE]
GO


CREATE PROCEDURE [dbo].[PG_CI_TIPO_CLIENTE]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_TIPO_CLIENTE			INT,
	@PP_D_TIPO_CLIENTE			VARCHAR(100),
	@PP_S_TIPO_CLIENTE			VARCHAR(10),
	@PP_O_TIPO_CLIENTE			INT,
	@PP_C_TIPO_CLIENTE			VARCHAR(255),
	@PP_L_TIPO_CLIENTE			INT,
	@PP_K_CLASE_CLIENTE			INT		
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_TIPO_CLIENTE
							FROM	TIPO_CLIENTE
							WHERE	K_TIPO_CLIENTE=@PP_K_TIPO_CLIENTE

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO TIPO_CLIENTE
			(	K_TIPO_CLIENTE,				D_TIPO_CLIENTE, 
				S_TIPO_CLIENTE,				O_TIPO_CLIENTE,
				C_TIPO_CLIENTE,
				L_TIPO_CLIENTE,
				K_CLASE_CLIENTE				)
		VALUES	
			(	@PP_K_TIPO_CLIENTE,			@PP_D_TIPO_CLIENTE,	
				@PP_S_TIPO_CLIENTE,			@PP_O_TIPO_CLIENTE,
				@PP_C_TIPO_CLIENTE,
				@PP_L_TIPO_CLIENTE,
				@PP_K_CLASE_CLIENTE			)
	ELSE
		UPDATE	TIPO_CLIENTE
		SET		D_TIPO_CLIENTE	= @PP_D_TIPO_CLIENTE,	
				S_TIPO_CLIENTE	= @PP_S_TIPO_CLIENTE,			
				O_TIPO_CLIENTE	= @PP_O_TIPO_CLIENTE,
				C_TIPO_CLIENTE	= @PP_C_TIPO_CLIENTE,
				L_TIPO_CLIENTE	= @PP_L_TIPO_CLIENTE,
				K_CLASE_CLIENTE	= @PP_K_CLASE_CLIENTE	
		WHERE	K_TIPO_CLIENTE=@PP_K_TIPO_CLIENTE

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================


EXECUTE [dbo].[PG_CI_TIPO_CLIENTE] 0, 0,  1, 'TIPO CLIENTE 1',		'TCLI1', 1, '', 1, 1
EXECUTE [dbo].[PG_CI_TIPO_CLIENTE] 0, 0,  2, 'TIPO CLIENTE 2',		'TCLI2', 1, '', 1, 2
EXECUTE [dbo].[PG_CI_TIPO_CLIENTE] 0, 0,  3, 'TIPO CLIENTE 3',		'TCLI3', 1, '', 1, 1
EXECUTE [dbo].[PG_CI_TIPO_CLIENTE] 0, 0,  4, 'TIPO CLIENTE 4',		'TCLI4', 1, '', 1, 1
GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================



-- //////////////////////////////////////////////////////////////
-- // ESTATUS_CLIENTE
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTATUS_CLIENTE] (
	[K_ESTATUS_CLIENTE]	[INT] NOT NULL,
	[D_ESTATUS_CLIENTE]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_CLIENTE]	[VARCHAR] (10) NOT NULL,
	[O_ESTATUS_CLIENTE]	[INT] NOT NULL,
	[C_ESTATUS_CLIENTE]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_CLIENTE]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_CLIENTE]
	ADD CONSTRAINT [PK_ESTATUS_CLIENTE]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_CLIENTE])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_CLIENTE_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_CLIENTE] ( [D_ESTATUS_CLIENTE] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_CLIENTE] ADD 
	CONSTRAINT [FK_ESTATUS_CLIENTE_01] 
		FOREIGN KEY ( [L_ESTATUS_CLIENTE] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_CLIENTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_CLIENTE]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_CLIENTE]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_ESTATUS_CLIENTE		INT,
	@PP_D_ESTATUS_CLIENTE		VARCHAR(100),
	@PP_S_ESTATUS_CLIENTE		VARCHAR(10),
	@PP_O_ESTATUS_CLIENTE		INT,
	@PP_C_ESTATUS_CLIENTE		VARCHAR(255),
	@PP_L_ESTATUS_CLIENTE		INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTATUS_CLIENTE
							FROM	ESTATUS_CLIENTE
							WHERE	K_ESTATUS_CLIENTE=@PP_K_ESTATUS_CLIENTE

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_CLIENTE	
			(	K_ESTATUS_CLIENTE,				D_ESTATUS_CLIENTE, 
				S_ESTATUS_CLIENTE,				O_ESTATUS_CLIENTE,
				C_ESTATUS_CLIENTE,
				L_ESTATUS_CLIENTE				)		
		VALUES	
			(	@PP_K_ESTATUS_CLIENTE,			@PP_D_ESTATUS_CLIENTE,	
				@PP_S_ESTATUS_CLIENTE,			@PP_O_ESTATUS_CLIENTE,
				@PP_C_ESTATUS_CLIENTE,
				@PP_L_ESTATUS_CLIENTE			)
	ELSE
		UPDATE	ESTATUS_CLIENTE
		SET		D_ESTATUS_CLIENTE	= @PP_D_ESTATUS_CLIENTE,	
				S_ESTATUS_CLIENTE	= @PP_S_ESTATUS_CLIENTE,			
				O_ESTATUS_CLIENTE	= @PP_O_ESTATUS_CLIENTE,
				C_ESTATUS_CLIENTE	= @PP_C_ESTATUS_CLIENTE,
				L_ESTATUS_CLIENTE	= @PP_L_ESTATUS_CLIENTE	
		WHERE	K_ESTATUS_CLIENTE=@PP_K_ESTATUS_CLIENTE

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_CLIENTE] 0, 0, 0, 'INACTIVO',		'INACT', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_CLIENTE] 0, 0, 1, 'ACTIVO',		'ACTVO', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- //////////////////////////////////////////////////////////////
-- // CLIENTE
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[CLIENTE] (
	[K_CLIENTE]				[INT]			NOT NULL,
	[D_CLIENTE]				[VARCHAR](100)	NOT NULL DEFAULT '',
	[S_CLIENTE]				[VARCHAR](10)	NOT NULL DEFAULT '',
	[O_CLIENTE]				[INT]			NOT NULL DEFAULT 0,
	-- ============================	
	[K_ESTATUS_CLIENTE]		[INT]			NOT NULL,
	[K_ESTATUS_CONEXION]	[INT]			NOT NULL,
	[K_TIPO_CLIENTE]		[INT]			NOT NULL,
	[K_SITIO]				[INT]			NOT NULL,
	[K_PERIODICIDAD]		[INT]			NOT NULL,
	-- ============================		
	[NOMBRE]				[VARCHAR](100)	NOT NULL DEFAULT '', 
	[APELLIDO_PATERNO]		[VARCHAR](100)	NOT NULL DEFAULT '', 
	[APELLIDO_MATERNO]		[VARCHAR](100)	NOT NULL DEFAULT '', 
	[RFC_CLIENTE]			[VARCHAR](100)	NOT NULL DEFAULT '',
	[CURP]					[VARCHAR](100)	NOT NULL DEFAULT '',
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
	[K_REGION]				[INT]			NOT NULL DEFAULT 0,
	--=================================
	[NUMERO_MEDIDOR]		[VARCHAR](100)	NOT NULL DEFAULT '' 
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[CLIENTE]
	ADD CONSTRAINT [PK_CLIENTE]
		PRIMARY KEY CLUSTERED ([K_CLIENTE])
GO


-- //////////////////////////////////////////////////////////////


/*
-- WIWI // HGF
ALTER TABLE [dbo].[CLIENTE] ADD 
	CONSTRAINT [FK_CLIENTE_01]  
		FOREIGN KEY ([K_SITIO]) 
		REFERENCES [dbo].[SITIO] ([K_SITIO])
GO

*/

ALTER TABLE [dbo].[CLIENTE] ADD 
	CONSTRAINT [FK_CLIENTE_02]  
		FOREIGN KEY ([K_ESTATUS_CLIENTE]) 
		REFERENCES [dbo].[ESTATUS_CLIENTE] ([K_ESTATUS_CLIENTE]),
	CONSTRAINT [FK_CLIENTE_03]  
		FOREIGN KEY ([K_TIPO_CLIENTE]) 
		REFERENCES [dbo].[TIPO_CLIENTE] ([K_TIPO_CLIENTE]),
	CONSTRAINT [FK_CLIENTE_04]  
		FOREIGN KEY ([K_PERIODICIDAD]) 
		REFERENCES [dbo].[PERIODICIDAD] ([K_PERIODICIDAD])
GO



-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[CLIENTE] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[CLIENTE] ADD 
	CONSTRAINT [FK_CLIENTE_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_CLIENTE_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_CLIENTE_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
