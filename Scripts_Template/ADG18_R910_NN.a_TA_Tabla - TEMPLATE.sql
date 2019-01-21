-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	ADG18_AdministradoraGas
-- // MODULO:			TRANSACCION 
-- // OPERACION:		LIBERACION / TABLAS 
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		HECTOR GONZALEZ DE LA FUENTE
-- // FECHA:		25/OCT/2018
-- ////////////////////////////////////////////////////////////// 

USE [ADG18_AdministradoraGas_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TRANSACCION]') AND type in (N'U'))
	DROP TABLE [dbo].[TRANSACCION]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_TRANSACCION]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_TRANSACCION]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_TRANSACCION]') AND type in (N'U'))
	DROP TABLE [dbo].[TIPO_TRANSACCION]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CLASE_TRANSACCION]') AND type in (N'U'))
	DROP TABLE [dbo].[CLASE_TRANSACCION]
GO





-- //////////////////////////////////////////////////////////////
-- // CLASE_TRANSACCION
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[CLASE_TRANSACCION] (
	[K_CLASE_TRANSACCION]	[INT] NOT NULL,
	[D_CLASE_TRANSACCION]	[VARCHAR] (100) NOT NULL,
	[S_CLASE_TRANSACCION]	[VARCHAR] (10) NOT NULL,
	[O_CLASE_TRANSACCION]	[INT] NOT NULL,
	[C_CLASE_TRANSACCION]	[VARCHAR] (255) NOT NULL,
	[L_CLASE_TRANSACCION]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[CLASE_TRANSACCION]
	ADD CONSTRAINT [PK_CLASE_TRANSACCION]
		PRIMARY KEY CLUSTERED ([K_CLASE_TRANSACCION])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_CLASE_TRANSACCION_01_DESCRIPCION] 
	   ON [dbo].[CLASE_TRANSACCION] ( [D_CLASE_TRANSACCION] )
GO

-- //////////////////////////////////////////////////////////////

ALTER TABLE [dbo].[CLASE_TRANSACCION] ADD 
	CONSTRAINT [FK_CLASE_TRANSACCION_01] 
		FOREIGN KEY ( [L_CLASE_TRANSACCION] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_CLASE_TRANSACCION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_CLASE_TRANSACCION]
GO


CREATE PROCEDURE [dbo].[PG_CI_CLASE_TRANSACCION]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	-- ========================================
	@PP_K_CLASE_TRANSACCION		INT,
	@PP_D_CLASE_TRANSACCION		VARCHAR(100),
	@PP_S_CLASE_TRANSACCION		VARCHAR(10),
	@PP_O_CLASE_TRANSACCION		INT,
	@PP_C_CLASE_TRANSACCION		VARCHAR(255),
	@PP_L_CLASE_TRANSACCION		INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_CLASE_TRANSACCION
							FROM	CLASE_TRANSACCION
							WHERE	K_CLASE_TRANSACCION=@PP_K_CLASE_TRANSACCION

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO CLASE_TRANSACCION
			(	K_CLASE_TRANSACCION,			D_CLASE_TRANSACCION, 
				S_CLASE_TRANSACCION,			O_CLASE_TRANSACCION,
				C_CLASE_TRANSACCION,
				L_CLASE_TRANSACCION			)		
		VALUES	
			(	@PP_K_CLASE_TRANSACCION,		@PP_D_CLASE_TRANSACCION,	
				@PP_S_CLASE_TRANSACCION,		@PP_O_CLASE_TRANSACCION,
				@PP_C_CLASE_TRANSACCION,
				@PP_L_CLASE_TRANSACCION		)
	ELSE
		UPDATE	CLASE_TRANSACCION
		SET		D_CLASE_TRANSACCION	= @PP_D_CLASE_TRANSACCION,	
				S_CLASE_TRANSACCION	= @PP_S_CLASE_TRANSACCION,			
				O_CLASE_TRANSACCION	= @PP_O_CLASE_TRANSACCION,
				C_CLASE_TRANSACCION	= @PP_C_CLASE_TRANSACCION,
				L_CLASE_TRANSACCION	= @PP_L_CLASE_TRANSACCION	
		WHERE	K_CLASE_TRANSACCION=@PP_K_CLASE_TRANSACCION

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////





-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_CLASE_TRANSACCION] 0, 0,  1, 'CLASE 1',		'CL1', 10, '', 1
EXECUTE [dbo].[PG_CI_CLASE_TRANSACCION] 0, 0,  2, 'CLASE 2',		'CL2', 20, '', 1
EXECUTE [dbo].[PG_CI_CLASE_TRANSACCION] 0, 0,  3, 'CLASE 3',		'CL3', 30, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- //////////////////////////////////////////////////////////////
-- // TIPO_TRANSACCION
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[TIPO_TRANSACCION] (
	[K_TIPO_TRANSACCION]	[INT] NOT NULL,
	[D_TIPO_TRANSACCION]	[VARCHAR] (100) NOT NULL,
	[S_TIPO_TRANSACCION]	[VARCHAR] (10) NOT NULL,
	[O_TIPO_TRANSACCION]	[INT] NOT NULL,
	[C_TIPO_TRANSACCION]	[VARCHAR] (255) NOT NULL,
	[L_TIPO_TRANSACCION]	[INT] NOT NULL,
	[K_CLASE_TRANSACCION]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_TRANSACCION]
	ADD CONSTRAINT [PK_TIPO_TRANSACCION]
		PRIMARY KEY CLUSTERED ([K_TIPO_TRANSACCION])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_TIPO_TRANSACCION_01_DESCRIPCION] 
	   ON [dbo].[TIPO_TRANSACCION] ( [D_TIPO_TRANSACCION] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_TRANSACCION] ADD 
	CONSTRAINT [FK_TIPO_TRANSACCION_01] 
		FOREIGN KEY ( [L_TIPO_TRANSACCION] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] ),
	CONSTRAINT [FK_TIPO_TRANSACCION_02] 
		FOREIGN KEY ( [K_CLASE_TRANSACCION] ) 
		REFERENCES [dbo].[CLASE_TRANSACCION] ( [K_CLASE_TRANSACCION] )
GO



-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_TRANSACCION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_TRANSACCION]
GO


CREATE PROCEDURE [dbo].[PG_CI_TIPO_TRANSACCION]
	@PP_L_DEBUG							INT,
	@PP_K_SISTEMA_EXE					INT,
	-- ========================================
	@PP_K_TIPO_TRANSACCION			INT,
	@PP_D_TIPO_TRANSACCION			VARCHAR(100),
	@PP_S_TIPO_TRANSACCION			VARCHAR(10),
	@PP_O_TIPO_TRANSACCION			INT,
	@PP_C_TIPO_TRANSACCION			VARCHAR(255),
	@PP_L_TIPO_TRANSACCION			INT,
	@PP_K_CLASE_TRANSACCION			INT		
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_TIPO_TRANSACCION
							FROM	TIPO_TRANSACCION
							WHERE	K_TIPO_TRANSACCION=@PP_K_TIPO_TRANSACCION

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO TIPO_TRANSACCION
			(	K_TIPO_TRANSACCION,				D_TIPO_TRANSACCION, 
				S_TIPO_TRANSACCION,				O_TIPO_TRANSACCION,
				C_TIPO_TRANSACCION,
				L_TIPO_TRANSACCION,
				K_CLASE_TRANSACCION				)
		VALUES	
			(	@PP_K_TIPO_TRANSACCION,			@PP_D_TIPO_TRANSACCION,	
				@PP_S_TIPO_TRANSACCION,			@PP_O_TIPO_TRANSACCION,
				@PP_C_TIPO_TRANSACCION,
				@PP_L_TIPO_TRANSACCION,
				@PP_K_CLASE_TRANSACCION			)
	ELSE
		UPDATE	TIPO_TRANSACCION
		SET		D_TIPO_TRANSACCION	= @PP_D_TIPO_TRANSACCION,	
				S_TIPO_TRANSACCION	= @PP_S_TIPO_TRANSACCION,			
				O_TIPO_TRANSACCION	= @PP_O_TIPO_TRANSACCION,
				C_TIPO_TRANSACCION	= @PP_C_TIPO_TRANSACCION,
				L_TIPO_TRANSACCION	= @PP_L_TIPO_TRANSACCION,
				K_CLASE_TRANSACCION	= @PP_K_CLASE_TRANSACCION	
		WHERE	K_TIPO_TRANSACCION=@PP_K_TIPO_TRANSACCION

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================


EXECUTE [dbo].[PG_CI_TIPO_TRANSACCION] 0, 0,  1, 'TIPO 1',		'TI1', 10, '', 1, 1
EXECUTE [dbo].[PG_CI_TIPO_TRANSACCION] 0, 0,  2, 'TIPO 2',		'TI2', 20, '', 1, 2
EXECUTE [dbo].[PG_CI_TIPO_TRANSACCION] 0, 0,  3, 'TIPO 3',		'TI3', 30, '', 1, 1
GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================



-- //////////////////////////////////////////////////////////////
-- // ESTATUS_TRANSACCION
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTATUS_TRANSACCION] (
	[K_ESTATUS_TRANSACCION]	[INT] NOT NULL,
	[D_ESTATUS_TRANSACCION]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_TRANSACCION]	[VARCHAR] (10) NOT NULL,
	[O_ESTATUS_TRANSACCION]	[INT] NOT NULL,
	[C_ESTATUS_TRANSACCION]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_TRANSACCION]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_TRANSACCION]
	ADD CONSTRAINT [PK_ESTATUS_TRANSACCION]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_TRANSACCION])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_TRANSACCION_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_TRANSACCION] ( [D_ESTATUS_TRANSACCION] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_TRANSACCION] ADD 
	CONSTRAINT [FK_ESTATUS_TRANSACCION_01] 
		FOREIGN KEY ( [L_ESTATUS_TRANSACCION] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_TRANSACCION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_TRANSACCION]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_TRANSACCION]
	@PP_L_DEBUG							INT,
	@PP_K_SISTEMA_EXE					INT,
	-- ========================================
	@PP_K_ESTATUS_TRANSACCION		INT,
	@PP_D_ESTATUS_TRANSACCION		VARCHAR(100),
	@PP_S_ESTATUS_TRANSACCION		VARCHAR(10),
	@PP_O_ESTATUS_TRANSACCION		INT,
	@PP_C_ESTATUS_TRANSACCION		VARCHAR(255),
	@PP_L_ESTATUS_TRANSACCION		INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTATUS_TRANSACCION
							FROM	ESTATUS_TRANSACCION
							WHERE	K_ESTATUS_TRANSACCION=@PP_K_ESTATUS_TRANSACCION

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_TRANSACCION	
			(	K_ESTATUS_TRANSACCION,				D_ESTATUS_TRANSACCION, 
				S_ESTATUS_TRANSACCION,				O_ESTATUS_TRANSACCION,
				C_ESTATUS_TRANSACCION,
				L_ESTATUS_TRANSACCION				)		
		VALUES	
			(	@PP_K_ESTATUS_TRANSACCION,			@PP_D_ESTATUS_TRANSACCION,	
				@PP_S_ESTATUS_TRANSACCION,			@PP_O_ESTATUS_TRANSACCION,
				@PP_C_ESTATUS_TRANSACCION,
				@PP_L_ESTATUS_TRANSACCION			)
	ELSE
		UPDATE	ESTATUS_TRANSACCION
		SET		D_ESTATUS_TRANSACCION	= @PP_D_ESTATUS_TRANSACCION,	
				S_ESTATUS_TRANSACCION	= @PP_S_ESTATUS_TRANSACCION,			
				O_ESTATUS_TRANSACCION	= @PP_O_ESTATUS_TRANSACCION,
				C_ESTATUS_TRANSACCION	= @PP_C_ESTATUS_TRANSACCION,
				L_ESTATUS_TRANSACCION	= @PP_L_ESTATUS_TRANSACCION	
		WHERE	K_ESTATUS_TRANSACCION=@PP_K_ESTATUS_TRANSACCION

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_TRANSACCION] 0, 0, 0, 'INACTIVO',		'INACT', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_TRANSACCION] 0, 0, 1, 'ACTIVO',		'ACTVO', 1, '', 1
GO
-- ===============================================
SET NOCOUNT OFF
-- ===============================================







-- //////////////////////////////////////////////////////////////
-- // TRANSACCION
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[TRANSACCION] (
	[K_TRANSACCION]				[INT]			NOT NULL,
	[D_TRANSACCION]				[VARCHAR](100)	NOT NULL,
	[S_TRANSACCION]				[VARCHAR](10)	NOT NULL,
	[O_TRANSACCION]				[INT]			NOT NULL,
	-- ============================	
	[K_ESTATUS_TRANSACCION]		[INT]			NOT NULL,
	[K_TIPO_TRANSACCION]		[INT]			NOT NULL,
	-- ============================		
	[DATO_VAR]				[VARCHAR](100)		NOT NULL, 
	[DATO_DEC]				DECIMAL(19,4)		NOT NULL,
	[DATO_INT]				[INT]				NOT NULL
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[TRANSACCION]
	ADD CONSTRAINT [PK_TRANSACCION]
		PRIMARY KEY CLUSTERED ([K_TRANSACCION])
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TRANSACCION] ADD 
	CONSTRAINT [FK_TRANSACCION_01]  
		FOREIGN KEY ([K_ESTATUS_TRANSACCION]) 
		REFERENCES [dbo].[ESTATUS_TRANSACCION] ([K_ESTATUS_TRANSACCION]),
	CONSTRAINT [FK_TRANSACCION_02]  
		FOREIGN KEY ([K_TIPO_TRANSACCION]) 
		REFERENCES [dbo].[TIPO_TRANSACCION] ([K_TIPO_TRANSACCION])
GO


-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[TRANSACCION] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[TRANSACCION] ADD 
	CONSTRAINT [FK_TRANSACCION_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_TRANSACCION_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_TRANSACCION_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
