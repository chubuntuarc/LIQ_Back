-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	SYS19_BasicBD_20190325
-- // MODULO:			USUARIO
-- // OPERACION:		LIBERACION / TABLA+CARGA 
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USUARIO]') AND type in (N'U'))
	DROP TABLE [dbo].[USUARIO] 
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_USUARIO]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_USUARIO] 
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_USUARIO]') AND type in (N'U'))
	DROP TABLE [dbo].[TIPO_USUARIO] 
GO



/****************************************************************/
/*							TIPO_USUARIO						*/
/****************************************************************/

CREATE TABLE [dbo].[TIPO_USUARIO] (
	[K_TIPO_USUARIO]	[INT]			NOT NULL,
	[D_TIPO_USUARIO]	[VARCHAR] (100) NOT NULL,
	[C_TIPO_USUARIO]	[VARCHAR] (500) NOT NULL,
	[S_TIPO_USUARIO]	[VARCHAR] (10)	NOT NULL,
	[O_TIPO_USUARIO]	[INT]			NOT NULL,
	[L_TIPO_USUARIO]	[INT]			NOT NULL
	
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[TIPO_USUARIO]
	ADD CONSTRAINT [PK_TIPO_USUARIO]
		PRIMARY KEY CLUSTERED ([K_TIPO_USUARIO])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_TIPO_USUARIO_01_DESCRIPCION] 
	   ON [dbo].[TIPO_USUARIO] ( [D_TIPO_USUARIO] )
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_USUARIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_USUARIO]
GO


CREATE PROCEDURE [dbo].[PG_CI_TIPO_USUARIO]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_K_TIPO_USUARIO		INT,
	@PP_D_TIPO_USUARIO		VARCHAR(100),
	@PP_C_TIPO_USUARIO		VARCHAR(500),
	@PP_S_TIPO_USUARIO		VARCHAR(10),
	@PP_O_TIPO_USUARIO		INT,
	@PP_L_TIPO_USUARIO		INT
	
AS

	INSERT INTO TIPO_USUARIO
		(	K_TIPO_USUARIO,		D_TIPO_USUARIO, 
			C_TIPO_USUARIO,		S_TIPO_USUARIO,
			O_TIPO_USUARIO,		L_TIPO_USUARIO		)
	VALUES	
		(	@PP_K_TIPO_USUARIO,		@PP_D_TIPO_USUARIO,
			@PP_C_TIPO_USUARIO,		@PP_S_TIPO_USUARIO,
			@PP_O_TIPO_USUARIO,		@PP_L_TIPO_USUARIO		)

	--  ==========================================
GO


EXECUTE [dbo].[PG_CI_TIPO_USUARIO]	0, 0, 0, 'NINGUNO',	'',	'NINGN', 10, 1
EXECUTE [dbo].[PG_CI_TIPO_USUARIO]	0, 0, 1, 'TI/SISTEMAS', '',	'SYSTI', 20, 1 
EXECUTE [dbo].[PG_CI_TIPO_USUARIO]	0, 0, 2, 'OPERACION', '','OPERC', 30, 1 
GO



/****************************************************************/
/*						ESTATUS_USUARIO							*/
/****************************************************************/

CREATE TABLE [dbo].[ESTATUS_USUARIO] (
	[K_ESTATUS_USUARIO]		[INT]			NOT NULL,
	[D_ESTATUS_USUARIO]		[VARCHAR] (100) NOT NULL,
	[C_ESTATUS_USUARIO]		[VARCHAR] (500) NOT NULL,
	[S_ESTATUS_USUARIO]		[VARCHAR] (10)	NOT NULL,
	[O_ESTATUS_USUARIO]		[INT]			NOT NULL,
	[L_ESTATUS_USUARIO]		[INT]			NOT NULL
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[ESTATUS_USUARIO]
	ADD CONSTRAINT [PK_ESTATUS_USUARIO]
	PRIMARY KEY CLUSTERED ([K_ESTATUS_USUARIO])
GO

CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_USUARIO_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_USUARIO] ( [D_ESTATUS_USUARIO] )
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_USUARIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_USUARIO]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_USUARIO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_ESTATUS_USUARIO		INT,
	@PP_D_ESTATUS_USUARIO		VARCHAR(100),
	@PP_C_ESTATUS_USUARIO		VARCHAR(500),
	@PP_S_ESTATUS_USUARIO		VARCHAR(10),
	@PP_O_ESTATUS_USUARIO		INT,
	@PP_L_ESTATUS_USUARIO		INT
AS

	INSERT INTO ESTATUS_USUARIO
		(	K_ESTATUS_USUARIO,		D_ESTATUS_USUARIO, 
			C_ESTATUS_USUARIO,		S_ESTATUS_USUARIO,
			O_ESTATUS_USUARIO,		L_ESTATUS_USUARIO		)
	VALUES	
		(	@PP_K_ESTATUS_USUARIO,		@PP_D_ESTATUS_USUARIO,	
			@PP_C_ESTATUS_USUARIO,		@PP_S_ESTATUS_USUARIO,
			@PP_O_ESTATUS_USUARIO,		@PP_L_ESTATUS_USUARIO	)

	--  ==========================================
GO


EXECUTE [dbo].[PG_CI_ESTATUS_USUARIO]	0, 0, 0, 'INACTIVO', '', 'INACT', 10, 1
EXECUTE [dbo].[PG_CI_ESTATUS_USUARIO]	0, 0, 1, 'ACTIVO', '', 'ACTVO', 20, 1
GO



/****************************************************************/
/*							USUARIO								*/
/****************************************************************/

CREATE TABLE [dbo].[USUARIO] (
	[K_USUARIO]					[INT]			NOT NULL,
	[D_USUARIO]					[VARCHAR] (100) NOT NULL,
	[C_USUARIO]					[VARCHAR] (500) NOT NULL,
	[S_USUARIO]					[VARCHAR] (10)	NOT NULL,
	[O_USUARIO]					[INT]			NOT NULL,
	[L_USUARIO]					[INT]			NOT NULL,
	-- ====================================================	
	[CORREO]					[VARCHAR] (100) NOT NULL DEFAULT '',
	[LOGIN_ID]					[VARCHAR] (25)	NOT NULL,
	[CONTRASENA]				[VARCHAR] (25)	NOT NULL,
	[F_CONTRASENA]				[DATE],
	-- ====================================================
	[K_ESTATUS_USUARIO]			[INT]			NOT NULL,
	[K_TIPO_USUARIO]			[INT]			NOT NULL,
	[K_PERSONAL_PREDEFINIDO]	[INT]			NULL,
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[USUARIO]
	ADD CONSTRAINT [PK_USUARIO]
		PRIMARY KEY CLUSTERED ([K_USUARIO])
GO

CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_USUARIO_01_DESCRIPCION] 
	   ON [dbo].[USUARIO] ( [D_USUARIO] )
GO

CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_USUARIO_02_LOGIN_ID] 
	   ON [dbo].[USUARIO] ( [LOGIN_ID] )
GO


ALTER TABLE [dbo].[USUARIO] ADD 
	CONSTRAINT [FK_USUARIO_01] 
		FOREIGN KEY ([K_ESTATUS_USUARIO]) 
		REFERENCES [dbo].[ESTATUS_USUARIO] ([K_ESTATUS_USUARIO]),
	CONSTRAINT [FK_USUARIO_02] 
		FOREIGN KEY ([K_TIPO_USUARIO]) 
		REFERENCES [dbo].[TIPO_USUARIO] ([K_TIPO_USUARIO])
GO



/*
-- WIWI
ALTER TABLE [dbo].[USUARIO] ADD 
	CONSTRAINT [FK_USUARIO_PREDEFINIDO] 
		FOREIGN KEY ([K_PERSONAL_PREDEFINIDO]) 
		REFERENCES [dbo].[PERSONAL] ([K_PERSONAL])
GO
*/

-- //////////////////////////////////////////////////////////////
--ALTER TABLE [dbo].[USUARIO]
--	ADD		[CORREO]			[VARCHAR] (100)	NOT NULL DEFAULT ''
--GO

-- //////////////////////////////////////////////////////////////
ALTER TABLE [dbo].[USUARIO] 
	ADD		[K_USUARIO_ALTA]	[INT]		NOT NULL,
			[F_ALTA]			[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]	[INT]		NOT NULL,
			[F_CAMBIO]			[DATETIME]	NOT NULL,
			[L_BORRADO]			[INT]		NOT NULL,
			[K_USUARIO_BAJA]	[INT]		NULL,
			[F_BAJA]			[DATETIME]	NULL;
GO


--ALTER TABLE [dbo].[USUARIO] ADD 
--	CONSTRAINT [FK_USUARIO_USUARIO_ALTA]  
--		FOREIGN KEY ([K_USUARIO_ALTA]) 
--		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
--	CONSTRAINT [FK_USUARIO_USUARIO_CAMBIO]  
--		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
--		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
--	CONSTRAINT [FK_USUARIO_USUARIO_BAJA]  
--		FOREIGN KEY ([K_USUARIO_BAJA]) 
--		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
--GO







-- ///////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////





