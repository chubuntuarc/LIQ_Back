-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	TRA19_Transportadora_V9999_R0
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CF_TIPO_USUARIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CF_TIPO_USUARIO]
GO


CREATE PROCEDURE [dbo].[PG_CF_TIPO_USUARIO]
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


EXECUTE [dbo].[PG_CF_TIPO_USUARIO]	0, 0, 0, 'NINGUNO',	'',	'NINGN', 10, 1
EXECUTE [dbo].[PG_CF_TIPO_USUARIO]	0, 0, 1, 'TI/SISTEMAS', '',	'SYSTI', 20, 1 
EXECUTE [dbo].[PG_CF_TIPO_USUARIO]	0, 0, 2, 'OPERACION', '','OPERC', 30, 1 
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CF_ESTATUS_USUARIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CF_ESTATUS_USUARIO]
GO


CREATE PROCEDURE [dbo].[PG_CF_ESTATUS_USUARIO]
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


EXECUTE [dbo].[PG_CF_ESTATUS_USUARIO]	0, 0, 0, 'INACTIVO', '', 'INACT', 10, 1
EXECUTE [dbo].[PG_CF_ESTATUS_USUARIO]	0, 0, 1, 'ACTIVO', '', 'ACTVO', 20, 1
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


-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
-- //
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_USUARIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_USUARIO]
GO


CREATE PROCEDURE [dbo].[PG_CI_USUARIO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- =========================== 
	@PP_K_USUARIO				INT,
	@PP_D_USUARIO				VARCHAR(100),
	@PP_C_USUARIO				VARCHAR(500),
	@PP_S_USUARIO				VARCHAR(10),
	@PP_O_USUARIO				INT,
	@PP_L_USUARIO				INT,
	-- =========================== 
	@PP_CORREO					VARCHAR(100),
	@PP_LOGIN_ID				VARCHAR(25),
	@PP_CONTRASENA				VARCHAR(25),
	@PP_F_CONTRASENA			DATE,
	@PP_K_ESTATUS_USUARIO		INT,
	@PP_K_TIPO_USUARIO			INT,
	@PP_K_PERSONAL_PREDEFINIDO	INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_USUARIO
							FROM	USUARIO
							WHERE	K_USUARIO=@PP_K_USUARIO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO USUARIO
			(	K_USUARIO,	D_USUARIO,	C_USUARIO,
				S_USUARIO,	O_USUARIO,	L_USUARIO,
				CORREO,		
				LOGIN_ID,	CONTRASENA,	F_CONTRASENA,
				K_ESTATUS_USUARIO,		K_TIPO_USUARIO,
				K_PERSONAL_PREDEFINIDO,
				-- ===========================
				[K_USUARIO_ALTA],		[F_ALTA],
 				[K_USUARIO_CAMBIO],		[F_CAMBIO],
				[L_BORRADO],			[K_USUARIO_BAJA],
				[F_BAJA]		)		
		VALUES	
			(	@PP_K_USUARIO,	@PP_D_USUARIO,	@PP_C_USUARIO,
				@PP_S_USUARIO,	@PP_O_USUARIO,	@PP_L_USUARIO,
				@PP_CORREO,
				@PP_LOGIN_ID,	@PP_CONTRASENA, @PP_F_CONTRASENA,
				@PP_K_ESTATUS_USUARIO,			@PP_K_TIPO_USUARIO,
				@PP_K_PERSONAL_PREDEFINIDO,
				-- =========================== 
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL		)
	ELSE
		UPDATE	USUARIO
		SET		D_USUARIO				= @PP_D_USUARIO,	
				C_USUARIO				= @PP_C_USUARIO,
				S_USUARIO				= @PP_S_USUARIO,	
				O_USUARIO				= @PP_O_USUARIO,	
				L_USUARIO				= @PP_L_USUARIO,
				CORREO					= @PP_CORREO,		
				LOGIN_ID				= @PP_LOGIN_ID,	
				CONTRASENA				= @PP_CONTRASENA,	
				F_CONTRASENA			= @PP_F_CONTRASENA,
				K_ESTATUS_USUARIO		= @PP_K_ESTATUS_USUARIO,		
				K_TIPO_USUARIO			= @PP_K_TIPO_USUARIO,
				K_PERSONAL_PREDEFINIDO	= @PP_K_PERSONAL_PREDEFINIDO,
				-- ===========================
 				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION,		
				[F_CAMBIO]				= GETDATE()
		WHERE	K_USUARIO=@PP_K_USUARIO

	--  ==========================================
GO




EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 000, 'SYS/SETUP', '',	'SET', 010,	1, '', 'SETUP', 'PWD000', '01/NOV/2017', 1,	1,	NULL
GO





/****************************************************************/
/*							GRUPO_SYS 							*/
/****************************************************************/




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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CF_GRUPO_SYS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CF_GRUPO_SYS]
GO


CREATE PROCEDURE [dbo].[PG_CF_GRUPO_SYS]
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


EXECUTE [dbo].[PG_CF_GRUPO_SYS]		0, 0, 0.00, 'SIN GRUPO', '', 'NOGPO', 10, 1
EXECUTE [dbo].[PG_CF_GRUPO_SYS]		0, 0, 1.01, 'SISTEMAS', '', 'SISTM', 10, 1
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CF_USUARIO_GRUPO_SYS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CF_USUARIO_GRUPO_SYS]
GO


CREATE PROCEDURE [dbo].[PG_CF_USUARIO_GRUPO_SYS]
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



EXECUTE [dbo].[PG_CF_USUARIO_GRUPO_SYS]		0, 0, 000, 1.01
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


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CF_USUARIO_PERSONAL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CF_USUARIO_PERSONAL]
GO


CREATE PROCEDURE [dbo].[PG_CF_USUARIO_PERSONAL]
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





