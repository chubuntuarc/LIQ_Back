-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			PRODUCTO / PRECIO 
-- // OPERACION:		LIBERACION / TABLAS
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		JESUS ARCINIEGA
-- // FECHA:		14/FEB/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0]  
GO

-- //////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PRECIO]') AND type in (N'U'))
	DROP TABLE [dbo].[PRECIO]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_PRECIO]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_PRECIO]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_PRECIO]') AND type in (N'U'))
	DROP TABLE [dbo].[TIPO_PRECIO]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CLASE_PRECIO]') AND type in (N'U'))
	DROP TABLE [dbo].[CLASE_PRECIO]
GO





-- //////////////////////////////////////////////////////////////
-- // CLASE_PRECIO
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[CLASE_PRECIO] (
	[K_CLASE_PRECIO]	[INT] NOT NULL,
	[D_CLASE_PRECIO]	[VARCHAR] (100) NOT NULL,
	[S_CLASE_PRECIO]	[VARCHAR] (10) NOT NULL,
	[O_CLASE_PRECIO]	[INT] NOT NULL,
	[C_CLASE_PRECIO]	[VARCHAR] (255) NOT NULL,
	[L_CLASE_PRECIO]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[CLASE_PRECIO]
	ADD CONSTRAINT [PK_CLASE_PRECIO]
		PRIMARY KEY CLUSTERED ([K_CLASE_PRECIO])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_CLASE_PRECIO_01_DESCRIPCION] 
	   ON [dbo].[CLASE_PRECIO] ( [D_CLASE_PRECIO] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[CLASE_PRECIO] ADD 
	CONSTRAINT [FK_CLASE_PRECIO_01] 
		FOREIGN KEY ( [L_CLASE_PRECIO] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_CLASE_PRECIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_CLASE_PRECIO]
GO


CREATE PROCEDURE [dbo].[PG_CI_CLASE_PRECIO]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	-- ========================================
	@PP_K_CLASE_PRECIO		INT,
	@PP_D_CLASE_PRECIO		VARCHAR(100),
	@PP_S_CLASE_PRECIO		VARCHAR(10),
	@PP_O_CLASE_PRECIO		INT,
	@PP_C_CLASE_PRECIO		VARCHAR(255),
	@PP_L_CLASE_PRECIO		INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_CLASE_PRECIO
							FROM	CLASE_PRECIO
							WHERE	K_CLASE_PRECIO=@PP_K_CLASE_PRECIO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO CLASE_PRECIO
			(	K_CLASE_PRECIO,			D_CLASE_PRECIO, 
				S_CLASE_PRECIO,			O_CLASE_PRECIO,
				C_CLASE_PRECIO,
				L_CLASE_PRECIO			)		
		VALUES	
			(	@PP_K_CLASE_PRECIO,		@PP_D_CLASE_PRECIO,	
				@PP_S_CLASE_PRECIO,		@PP_O_CLASE_PRECIO,
				@PP_C_CLASE_PRECIO,
				@PP_L_CLASE_PRECIO		)
	ELSE
		UPDATE	CLASE_PRECIO
		SET		D_CLASE_PRECIO	= @PP_D_CLASE_PRECIO,	
				S_CLASE_PRECIO	= @PP_S_CLASE_PRECIO,			
				O_CLASE_PRECIO	= @PP_O_CLASE_PRECIO,
				C_CLASE_PRECIO	= @PP_C_CLASE_PRECIO,
				L_CLASE_PRECIO	= @PP_L_CLASE_PRECIO	
		WHERE	K_CLASE_PRECIO	= @PP_K_CLASE_PRECIO

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////





-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_CLASE_PRECIO] 0, 0,  1, 'CLASE PRECIO 1','CPRE1', 1, '', 1
EXECUTE [dbo].[PG_CI_CLASE_PRECIO] 0, 0,  2, 'CLASE PRECIO 2','CPRE2', 1, '', 1
EXECUTE [dbo].[PG_CI_CLASE_PRECIO] 0, 0,  3, 'CLASE PRECIO 3','CPRE3', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- //////////////////////////////////////////////////////////////
-- // TIPO_PRECIO
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[TIPO_PRECIO] (
	[K_TIPO_PRECIO]	[INT] NOT NULL,
	[D_TIPO_PRECIO]	[VARCHAR] (100) NOT NULL,
	[S_TIPO_PRECIO]	[VARCHAR] (10) NOT NULL,
	[O_TIPO_PRECIO]	[INT] NOT NULL,
	[C_TIPO_PRECIO]	[VARCHAR] (255) NOT NULL,
	[L_TIPO_PRECIO]	[INT] NOT NULL,
	[K_CLASE_PRECIO]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_PRECIO]
	ADD CONSTRAINT [PK_TIPO_PRECIO]
		PRIMARY KEY CLUSTERED ([K_TIPO_PRECIO])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_TIPO_PRECIO_01_DESCRIPCION] 
	   ON [dbo].[TIPO_PRECIO] ( [D_TIPO_PRECIO] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_PRECIO] ADD 
	CONSTRAINT [FK_TIPO_PRECIO_01] 
		FOREIGN KEY ( [L_TIPO_PRECIO] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] ),
	CONSTRAINT [FK_TIPO_PRECIO_02] 
		FOREIGN KEY ( [K_CLASE_PRECIO] ) 
		REFERENCES [dbo].[CLASE_PRECIO] ( [K_CLASE_PRECIO] )
GO



-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_PRECIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_PRECIO]
GO


CREATE PROCEDURE [dbo].[PG_CI_TIPO_PRECIO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_TIPO_PRECIO			INT,
	@PP_D_TIPO_PRECIO			VARCHAR(100),
	@PP_S_TIPO_PRECIO			VARCHAR(10),
	@PP_O_TIPO_PRECIO			INT,
	@PP_C_TIPO_PRECIO			VARCHAR(255),
	@PP_L_TIPO_PRECIO			INT,
	@PP_K_CLASE_PRECIO			INT		
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_TIPO_PRECIO
							FROM	TIPO_PRECIO
							WHERE	K_TIPO_PRECIO=@PP_K_TIPO_PRECIO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO TIPO_PRECIO
			(	K_TIPO_PRECIO,				D_TIPO_PRECIO, 
				S_TIPO_PRECIO,				O_TIPO_PRECIO,
				C_TIPO_PRECIO,
				L_TIPO_PRECIO,
				K_CLASE_PRECIO				)
		VALUES	
			(	@PP_K_TIPO_PRECIO,			@PP_D_TIPO_PRECIO,	
				@PP_S_TIPO_PRECIO,			@PP_O_TIPO_PRECIO,
				@PP_C_TIPO_PRECIO,
				@PP_L_TIPO_PRECIO,
				@PP_K_CLASE_PRECIO			)
	ELSE
		UPDATE	TIPO_PRECIO
		SET		D_TIPO_PRECIO	= @PP_D_TIPO_PRECIO,	
				S_TIPO_PRECIO	= @PP_S_TIPO_PRECIO,			
				O_TIPO_PRECIO	= @PP_O_TIPO_PRECIO,
				C_TIPO_PRECIO	= @PP_C_TIPO_PRECIO,
				L_TIPO_PRECIO	= @PP_L_TIPO_PRECIO,
				K_CLASE_PRECIO	= @PP_K_CLASE_PRECIO	
		WHERE	K_TIPO_PRECIO=@PP_K_TIPO_PRECIO

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================


EXECUTE [dbo].[PG_CI_TIPO_PRECIO] 0, 0,  1, 'PESOS','PES', 1, '', 1, 1
EXECUTE [dbo].[PG_CI_TIPO_PRECIO] 0, 0,  2, 'DOLARES','DOL', 2, '', 1, 2
EXECUTE [dbo].[PG_CI_TIPO_PRECIO] 0, 0,  3, 'EUROS','EUR', 3, '', 1, 1
GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================



-- //////////////////////////////////////////////////////////////
-- // ESTATUS_PRECIO
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTATUS_PRECIO] (
	[K_ESTATUS_PRECIO]	[INT] NOT NULL,
	[D_ESTATUS_PRECIO]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_PRECIO]	[VARCHAR] (10) NOT NULL,
	[O_ESTATUS_PRECIO]	[INT] NOT NULL,
	[C_ESTATUS_PRECIO]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_PRECIO]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_PRECIO]
	ADD CONSTRAINT [PK_ESTATUS_PRECIO]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_PRECIO])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_PRECIO_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_PRECIO] ( [D_ESTATUS_PRECIO] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_PRECIO] ADD 
	CONSTRAINT [FK_ESTATUS_PRECIO_01] 
		FOREIGN KEY ( [L_ESTATUS_PRECIO] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_PRECIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_PRECIO]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_PRECIO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_ESTATUS_PRECIO		INT,
	@PP_D_ESTATUS_PRECIO		VARCHAR(100),
	@PP_S_ESTATUS_PRECIO		VARCHAR(10),
	@PP_O_ESTATUS_PRECIO		INT,
	@PP_C_ESTATUS_PRECIO		VARCHAR(255),
	@PP_L_ESTATUS_PRECIO		INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTATUS_PRECIO
							FROM	ESTATUS_PRECIO
							WHERE	K_ESTATUS_PRECIO=@PP_K_ESTATUS_PRECIO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_PRECIO	
			(	K_ESTATUS_PRECIO,				D_ESTATUS_PRECIO, 
				S_ESTATUS_PRECIO,				O_ESTATUS_PRECIO,
				C_ESTATUS_PRECIO,
				L_ESTATUS_PRECIO				)		
		VALUES	
			(	@PP_K_ESTATUS_PRECIO,			@PP_D_ESTATUS_PRECIO,	
				@PP_S_ESTATUS_PRECIO,			@PP_O_ESTATUS_PRECIO,
				@PP_C_ESTATUS_PRECIO,
				@PP_L_ESTATUS_PRECIO			)
	ELSE
		UPDATE	ESTATUS_PRECIO
		SET		D_ESTATUS_PRECIO	= @PP_D_ESTATUS_PRECIO,	
				S_ESTATUS_PRECIO	= @PP_S_ESTATUS_PRECIO,			
				O_ESTATUS_PRECIO	= @PP_O_ESTATUS_PRECIO,
				C_ESTATUS_PRECIO	= @PP_C_ESTATUS_PRECIO,
				L_ESTATUS_PRECIO	= @PP_L_ESTATUS_PRECIO	
		WHERE	K_ESTATUS_PRECIO	= @PP_K_ESTATUS_PRECIO

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_PRECIO] 0, 0, 0, 'INACTIVO','INACT', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_PRECIO] 0, 0, 1, 'ACTIVO','ACTVO', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================







-- //////////////////////////////////////////////////////////////
-- // PRECIO
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[PRECIO] (
	[K_PRECIO]				[INT]			NOT NULL,
	[D_PRECIO]				[VARCHAR](100)	NOT NULL,
	[S_PRECIO]				[VARCHAR](10)	NOT NULL,
	[O_PRECIO]				[INT]			NOT NULL,
	-- ============================	
	[K_ESTATUS_PRECIO]		[INT]			NOT NULL,
	[K_TIPO_PRECIO]			[INT]			NOT NULL,
	[K_PRODUCTO]			[INT]			NOT NULL,
	[K_TASA_IMPUESTO]		[INT]			NOT NULL DEFAULT 0,
	-- ============================		
	[F_VIGENCIA_INICIO]		[DATETIME]		NOT NULL,
	[F_VIGENCIA_FIN]		[DATETIME]		NOT NULL,
	[PRECIO_SIN_IVA]		[DECIMAL](19,4)	NOT NULL,	-- DEL PRODUCTO
	[PRECIO_IVA]			[DECIMAL](19,4)	NOT NULL,	-- [PRECIO_IVA] = [PRECIO_CON_IVA] - [PRECIO_SIN_IVA]
	[PRECIO_CON_IVA]		[DECIMAL](19,4)	NOT NULL 
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[PRECIO]
	ADD CONSTRAINT [PK_PRECIO]
		PRIMARY KEY CLUSTERED ([K_PRECIO])
GO

-- //////////////////////////////////////////////////////////////

/*
-- WIWI // HGF

ALTER TABLE [dbo].[PRECIO] ADD 
	CONSTRAINT [FK_PRECIO_01]  
		FOREIGN KEY ([K_PRODUCTO]) 
		REFERENCES [dbo].[PRODUCTO] ([K_PRODUCTO])
GO

*/

ALTER TABLE [dbo].[PRECIO] ADD 
	CONSTRAINT [FK_PRECIO_02]  
		FOREIGN KEY ([K_ESTATUS_PRECIO]) 
		REFERENCES [dbo].[ESTATUS_PRECIO] ([K_ESTATUS_PRECIO]),
	CONSTRAINT [FK_PRECIO_03]  
		FOREIGN KEY ([K_TIPO_PRECIO]) 
		REFERENCES [dbo].[TIPO_PRECIO] ([K_TIPO_PRECIO])
GO



-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[PRECIO] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[PRECIO] ADD 
	CONSTRAINT [FK_PRECIO_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_PRECIO_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_PRECIO_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
