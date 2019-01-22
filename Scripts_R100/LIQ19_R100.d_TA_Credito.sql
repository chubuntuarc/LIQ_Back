-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			PRODUCTO / PRECIO 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CREDITO]') AND type in (N'U'))
	DROP TABLE [dbo].[CREDITO]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_CREDITO]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_CREDITO]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_CREDITO]') AND type in (N'U'))
	DROP TABLE [dbo].[TIPO_CREDITO]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CLASE_CREDITO]') AND type in (N'U'))
	DROP TABLE [dbo].[CLASE_CREDITO]
GO





-- //////////////////////////////////////////////////////////////
-- // CLASE_CREDITO
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[CLASE_CREDITO] (
	[K_CLASE_CREDITO]	[INT] NOT NULL,
	[D_CLASE_CREDITO]	[VARCHAR] (100) NOT NULL,
	[S_CLASE_CREDITO]	[VARCHAR] (10) NOT NULL,
	[O_CLASE_CREDITO]	[INT] NOT NULL,
	[C_CLASE_CREDITO]	[VARCHAR] (255) NOT NULL,
	[L_CLASE_CREDITO]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[CLASE_CREDITO]
	ADD CONSTRAINT [PK_CLASE_CREDITO]
		PRIMARY KEY CLUSTERED ([K_CLASE_CREDITO])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_CLASE_CREDITO_01_DESCRIPCION] 
	   ON [dbo].[CLASE_CREDITO] ( [D_CLASE_CREDITO] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[CLASE_CREDITO] ADD 
	CONSTRAINT [FK_CLASE_CREDITO_01] 
		FOREIGN KEY ( [L_CLASE_CREDITO] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_CLASE_CREDITO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_CLASE_CREDITO]
GO


CREATE PROCEDURE [dbo].[PG_CI_CLASE_CREDITO]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	-- ========================================
	@PP_K_CLASE_CREDITO		INT,
	@PP_D_CLASE_CREDITO		VARCHAR(100),
	@PP_S_CLASE_CREDITO		VARCHAR(10),
	@PP_O_CLASE_CREDITO		INT,
	@PP_C_CLASE_CREDITO		VARCHAR(255),
	@PP_L_CLASE_CREDITO		INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_CLASE_CREDITO
							FROM	CLASE_CREDITO
							WHERE	K_CLASE_CREDITO=@PP_K_CLASE_CREDITO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO CLASE_CREDITO
			(	K_CLASE_CREDITO,			D_CLASE_CREDITO, 
				S_CLASE_CREDITO,			O_CLASE_CREDITO,
				C_CLASE_CREDITO,
				L_CLASE_CREDITO			)		
		VALUES	
			(	@PP_K_CLASE_CREDITO,		@PP_D_CLASE_CREDITO,	
				@PP_S_CLASE_CREDITO,		@PP_O_CLASE_CREDITO,
				@PP_C_CLASE_CREDITO,
				@PP_L_CLASE_CREDITO		)
	ELSE
		UPDATE	CLASE_CREDITO
		SET		D_CLASE_CREDITO	= @PP_D_CLASE_CREDITO,	
				S_CLASE_CREDITO	= @PP_S_CLASE_CREDITO,			
				O_CLASE_CREDITO	= @PP_O_CLASE_CREDITO,
				C_CLASE_CREDITO	= @PP_C_CLASE_CREDITO,
				L_CLASE_CREDITO	= @PP_L_CLASE_CREDITO	
		WHERE	K_CLASE_CREDITO	= @PP_K_CLASE_CREDITO

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////





-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_CLASE_CREDITO] 0, 0,  1, 'CLASE CREDITO 1','CPRE1', 1, '', 1
EXECUTE [dbo].[PG_CI_CLASE_CREDITO] 0, 0,  2, 'CLASE CREDITO 2','CPRE2', 1, '', 1
EXECUTE [dbo].[PG_CI_CLASE_CREDITO] 0, 0,  3, 'CLASE CREDITO 3','CPRE3', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- //////////////////////////////////////////////////////////////
-- // TIPO_CREDITO
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[TIPO_CREDITO] (
	[K_TIPO_CREDITO]	[INT] NOT NULL,
	[D_TIPO_CREDITO]	[VARCHAR] (100) NOT NULL,
	[S_TIPO_CREDITO]	[VARCHAR] (10) NOT NULL,
	[O_TIPO_CREDITO]	[INT] NOT NULL,
	[C_TIPO_CREDITO]	[VARCHAR] (255) NOT NULL,
	[L_TIPO_CREDITO]	[INT] NOT NULL,
	[K_CLASE_CREDITO]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_CREDITO]
	ADD CONSTRAINT [PK_TIPO_CREDITO]
		PRIMARY KEY CLUSTERED ([K_TIPO_CREDITO])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_TIPO_CREDITO_01_DESCRIPCION] 
	   ON [dbo].[TIPO_CREDITO] ( [D_TIPO_CREDITO] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_CREDITO] ADD 
	CONSTRAINT [FK_TIPO_CREDITO_01] 
		FOREIGN KEY ( [L_TIPO_CREDITO] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] ),
	CONSTRAINT [FK_TIPO_CREDITO_02] 
		FOREIGN KEY ( [K_CLASE_CREDITO] ) 
		REFERENCES [dbo].[CLASE_CREDITO] ( [K_CLASE_CREDITO] )
GO



-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_CREDITO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_CREDITO]
GO


CREATE PROCEDURE [dbo].[PG_CI_TIPO_CREDITO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_TIPO_CREDITO			INT,
	@PP_D_TIPO_CREDITO			VARCHAR(100),
	@PP_S_TIPO_CREDITO			VARCHAR(10),
	@PP_O_TIPO_CREDITO			INT,
	@PP_C_TIPO_CREDITO			VARCHAR(255),
	@PP_L_TIPO_CREDITO			INT,
	@PP_K_CLASE_CREDITO			INT		
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_TIPO_CREDITO
							FROM	TIPO_CREDITO
							WHERE	K_TIPO_CREDITO=@PP_K_TIPO_CREDITO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO TIPO_CREDITO
			(	K_TIPO_CREDITO,				D_TIPO_CREDITO, 
				S_TIPO_CREDITO,				O_TIPO_CREDITO,
				C_TIPO_CREDITO,
				L_TIPO_CREDITO,
				K_CLASE_CREDITO				)
		VALUES	
			(	@PP_K_TIPO_CREDITO,			@PP_D_TIPO_CREDITO,	
				@PP_S_TIPO_CREDITO,			@PP_O_TIPO_CREDITO,
				@PP_C_TIPO_CREDITO,
				@PP_L_TIPO_CREDITO,
				@PP_K_CLASE_CREDITO			)
	ELSE
		UPDATE	TIPO_CREDITO
		SET		D_TIPO_CREDITO	= @PP_D_TIPO_CREDITO,	
				S_TIPO_CREDITO	= @PP_S_TIPO_CREDITO,			
				O_TIPO_CREDITO	= @PP_O_TIPO_CREDITO,
				C_TIPO_CREDITO	= @PP_C_TIPO_CREDITO,
				L_TIPO_CREDITO	= @PP_L_TIPO_CREDITO,
				K_CLASE_CREDITO	= @PP_K_CLASE_CREDITO	
		WHERE	K_TIPO_CREDITO=@PP_K_TIPO_CREDITO

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================


EXECUTE [dbo].[PG_CI_TIPO_CREDITO] 0, 0,  1, 'CREDITO','CRE', 1, '', 1, 1
EXECUTE [dbo].[PG_CI_TIPO_CREDITO] 0, 0,  2, 'VALE GAS','VAL', 2, '', 1, 2
EXECUTE [dbo].[PG_CI_TIPO_CREDITO] 0, 0,  3, 'CREDICONTADO','CRO', 3, '', 1, 1
GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================



-- //////////////////////////////////////////////////////////////
-- // ESTATUS_CREDITO
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTATUS_CREDITO] (
	[K_ESTATUS_CREDITO]	[INT] NOT NULL,
	[D_ESTATUS_CREDITO]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_CREDITO]	[VARCHAR] (10) NOT NULL,
	[O_ESTATUS_CREDITO]	[INT] NOT NULL,
	[C_ESTATUS_CREDITO]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_CREDITO]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_CREDITO]
	ADD CONSTRAINT [PK_ESTATUS_CREDITO]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_CREDITO])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_CREDITO_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_CREDITO] ( [D_ESTATUS_CREDITO] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_CREDITO] ADD 
	CONSTRAINT [FK_ESTATUS_CREDITO_01] 
		FOREIGN KEY ( [L_ESTATUS_CREDITO] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_CREDITO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_CREDITO]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_CREDITO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_ESTATUS_CREDITO		INT,
	@PP_D_ESTATUS_CREDITO		VARCHAR(100),
	@PP_S_ESTATUS_CREDITO		VARCHAR(10),
	@PP_O_ESTATUS_CREDITO		INT,
	@PP_C_ESTATUS_CREDITO		VARCHAR(255),
	@PP_L_ESTATUS_CREDITO		INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTATUS_CREDITO
							FROM	ESTATUS_CREDITO
							WHERE	K_ESTATUS_CREDITO=@PP_K_ESTATUS_CREDITO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_CREDITO	
			(	K_ESTATUS_CREDITO,				D_ESTATUS_CREDITO, 
				S_ESTATUS_CREDITO,				O_ESTATUS_CREDITO,
				C_ESTATUS_CREDITO,
				L_ESTATUS_CREDITO				)		
		VALUES	
			(	@PP_K_ESTATUS_CREDITO,			@PP_D_ESTATUS_CREDITO,	
				@PP_S_ESTATUS_CREDITO,			@PP_O_ESTATUS_CREDITO,
				@PP_C_ESTATUS_CREDITO,
				@PP_L_ESTATUS_CREDITO			)
	ELSE
		UPDATE	ESTATUS_CREDITO
		SET		D_ESTATUS_CREDITO	= @PP_D_ESTATUS_CREDITO,	
				S_ESTATUS_CREDITO	= @PP_S_ESTATUS_CREDITO,			
				O_ESTATUS_CREDITO	= @PP_O_ESTATUS_CREDITO,
				C_ESTATUS_CREDITO	= @PP_C_ESTATUS_CREDITO,
				L_ESTATUS_CREDITO	= @PP_L_ESTATUS_CREDITO	
		WHERE	K_ESTATUS_CREDITO	= @PP_K_ESTATUS_CREDITO

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_CREDITO] 0, 0, 0, 'INACTIVO','INACT', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_CREDITO] 0, 0, 1, 'ACTIVO','ACTVO', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================







-- //////////////////////////////////////////////////////////////
-- // PRECIO
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[CREDITO] (
	[K_CREDITO]				[INT]			NOT NULL,
	[D_CREDITO]				[VARCHAR](100)	NOT NULL,
	[S_CREDITO]				[VARCHAR](10)	NOT NULL,
	[O_CREDITO]				[INT]			NOT NULL,
	-- ============================	
	[K_ESTATUS_CREDITO]		[INT]			NOT NULL,
	[K_TIPO_CREDITO]		[INT]			NOT NULL,
	[K_CLIENTE]				[INT]			NOT NULL,
	-- ============================		
	[F_VIGENCIA_INICIO]		[DATETIME]		NOT NULL,
	[F_VIGENCIA_FIN]		[DATETIME]		NOT NULL
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

ALTER TABLE [dbo].[CREDITO] ADD 
	CONSTRAINT [FK_CREDITO_02]  
		FOREIGN KEY ([K_ESTATUS_CREDITO]) 
		REFERENCES [dbo].[ESTATUS_CREDITO] ([K_ESTATUS_CREDITO]),
	CONSTRAINT [FK_PRECIO_03]  
		FOREIGN KEY ([K_TIPO_CREDITO]) 
		REFERENCES [dbo].[TIPO_CREDITO] ([K_TIPO_CREDITO])
GO



-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[CREDITO] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[CREDITO] ADD 
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
