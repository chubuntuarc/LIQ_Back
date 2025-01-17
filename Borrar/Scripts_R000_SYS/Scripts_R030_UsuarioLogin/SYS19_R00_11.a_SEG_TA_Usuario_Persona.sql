-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	SYS19_BasicBD_20190319
-- // MODULO:			USUARIO
-- // OPERACION:		LIBERACION / TABLA+CARGA 
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USUARIO_PERSONAL]') AND type in (N'U'))
	DROP TABLE [dbo].[USUARIO_PERSONAL]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USUARIO_GRUPO_SYS]') AND type in (N'U'))
	DROP TABLE [dbo].[USUARIO_GRUPO_SYS] 
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GRUPO_SYS]') AND type in (N'U'))
	DROP TABLE [dbo].[GRUPO_SYS] 
GO






/****************************************************************/
/*							GRUPO_SYS 							*/
/****************************************************************/

/*
DECLARE @FLOAT AS DECIMAL(12,2)
SET @FLOAT = 1234567890.12
PRINT @FLOAT 
*/


CREATE TABLE [dbo].[GRUPO_SYS] (
	[K_GRUPO_SYS]	[DECIMAL] (12,2)NOT NULL,
	[D_GRUPO_SYS]	[VARCHAR] (100) NOT NULL,
	[C_GRUPO_SYS]	[VARCHAR] (500) NOT NULL,
	[S_GRUPO_SYS]	[VARCHAR] (10)	NOT NULL,
	[O_GRUPO_SYS]	[INT]			NOT NULL,
	[L_GRUPO_SYS]	[INT]			NOT NULL	
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[GRUPO_SYS]
	ADD CONSTRAINT [PK_GRUPO_SYS]
		PRIMARY KEY CLUSTERED ([K_GRUPO_SYS])
GO

CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_GRUPO_SYS_01_DESCRIPCION] 
	   ON [dbo].[GRUPO_SYS] ( [D_GRUPO_SYS] )
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_GRUPO_SYS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_GRUPO_SYS]
GO


CREATE PROCEDURE [dbo].[PG_CI_GRUPO_SYS]
	@PP_L_DEBUG			INT,
	@PP_K_SISTEMA_EXE	INT,
	@PP_K_GRUPO_SYS		DECIMAL(12,2),
	@PP_D_GRUPO_SYS		VARCHAR(100),
	@PP_C_GRUPO_SYS		VARCHAR(500),
	@PP_S_GRUPO_SYS		VARCHAR(10),
	@PP_O_GRUPO_SYS		INT,
	@PP_L_GRUPO_SYS		INT
	
AS

	INSERT INTO [dbo].[GRUPO_SYS]
		(	K_GRUPO_SYS,	D_GRUPO_SYS, 
			C_GRUPO_SYS,	S_GRUPO_SYS,
			O_GRUPO_SYS,	L_GRUPO_SYS		)
	VALUES	
		(	@PP_K_GRUPO_SYS,	@PP_D_GRUPO_SYS,	
			@PP_C_GRUPO_SYS,	@PP_S_GRUPO_SYS,
			@PP_O_GRUPO_SYS,	@PP_L_GRUPO_SYS		)

	--  ==========================================
GO


EXECUTE [dbo].[PG_CI_GRUPO_SYS]		0, 0, 0.00, 'SIN GRUPO', '', 'NOGPO', 10, 1
EXECUTE [dbo].[PG_CI_GRUPO_SYS]		0, 0, 1.01, 'SISTEMAS', '', 'SISTM', 10, 1
GO



/****************************************************************/
/*						USUARIO_GRUPO_SYS						*/
/****************************************************************/

CREATE TABLE [dbo].[USUARIO_GRUPO_SYS] (
	[K_USUARIO]			[INT] NOT NULL,
	[K_GRUPO_SYS]		DECIMAL(12,2) NOT NULL
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[USUARIO_GRUPO_SYS]
	ADD CONSTRAINT [PK_USUARIO_GRUPO_SYS]
		PRIMARY KEY CLUSTERED ( [K_USUARIO], [K_GRUPO_SYS] )
GO



ALTER TABLE [dbo].[USUARIO_GRUPO_SYS] ADD 
	CONSTRAINT [FK_USUARIO_GRUPO_SYS_01] 
		FOREIGN KEY ([K_USUARIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_USUARIO_GRUPO_SYS_02] 
		FOREIGN KEY ([K_GRUPO_SYS]) 
		REFERENCES [dbo].[GRUPO_SYS] ([K_GRUPO_SYS])
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_USUARIO_GRUPO_SYS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_USUARIO_GRUPO_SYS]
GO


CREATE PROCEDURE [dbo].[PG_CI_USUARIO_GRUPO_SYS]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_K_USUARIO			INT,
	@PP_K_GRUPO_SYS			DECIMAL(12,2)	
AS

	DELETE
	FROM	[dbo].[USUARIO_GRUPO_SYS]
	WHERE	K_USUARIO=@PP_K_USUARIO 
	AND		K_GRUPO_SYS=@PP_K_GRUPO_SYS
	
	-- ===========================================

	INSERT INTO [dbo].[USUARIO_GRUPO_SYS]
		( K_USUARIO,		K_GRUPO_SYS			)
	VALUES	
		( @PP_K_USUARIO,	@PP_K_GRUPO_SYS		)

	--  ==========================================
GO



EXECUTE [dbo].[PG_CI_USUARIO_GRUPO_SYS]		0, 0, 000, 1.01
GO


/****************************************************************/
/*						USUARIO_PERSONAL						*/
/****************************************************************/

CREATE TABLE [dbo].[USUARIO_PERSONAL] (
	[K_USUARIO]		[INT] NOT NULL,
	[K_PERSONAL]	[INT] NOT NULL
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[USUARIO_PERSONAL]
	ADD CONSTRAINT [PK_USUARIO_PERSONAL]
		PRIMARY KEY CLUSTERED ( [K_USUARIO], [K_PERSONAL] )
GO


ALTER TABLE [dbo].[USUARIO_PERSONAL] ADD 
	CONSTRAINT [FK_USUARIO_PERSONAL_01] 
		FOREIGN KEY ([K_USUARIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])	
GO

/*
ALTER TABLE [dbo].[USUARIO_PERSONAL] ADD 
	CONSTRAINT [FK_USUARIO_PERSONAL_02] 
		FOREIGN KEY ([K_PERSONAL]) 
		REFERENCES [dbo].[PERSONAL] ([K_PERSONAL]) 
GO
*/


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_USUARIO_PERSONAL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_USUARIO_PERSONAL]
GO


CREATE PROCEDURE [dbo].[PG_CI_USUARIO_PERSONAL]
	@PP_L_DEBUG			INT,
	@PP_K_SISTEMA_EXE	INT,
	@PP_K_USUARIO		INT,
	@PP_K_PERSONAL		INT	
AS

	DELETE
	FROM	[dbo].[USUARIO_PERSONAL]
	WHERE	K_USUARIO=@PP_K_USUARIO 
	AND		K_PERSONAL=@PP_K_PERSONAL
	
	-- ===========================================

	INSERT INTO [dbo].[USUARIO_PERSONAL]
		( K_USUARIO,		K_PERSONAL		)
	VALUES	
		( @PP_K_USUARIO,	@PP_K_PERSONAL	)

	--  ==========================================
GO


-- ///////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////



