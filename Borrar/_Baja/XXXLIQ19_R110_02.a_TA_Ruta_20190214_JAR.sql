-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			RUTA 
-- // OPERACION:		LIBERACION / TABLAS 
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		JESUS ARCINIEGA
-- // FECHA:		31/ENE/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RUTA]') AND type in (N'U'))
	DROP TABLE [dbo].[RUTA]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_RUTA]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_RUTA]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_RUTA]') AND type in (N'U'))
	DROP TABLE [dbo].[TIPO_RUTA]
GO




-- //////////////////////////////////////////////////////////////
-- // TIPO_RUTA
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[TIPO_RUTA] (
	[K_TIPO_RUTA]	[INT] NOT NULL,
	[D_TIPO_RUTA]	[VARCHAR] (100) NOT NULL,
	[S_TIPO_RUTA]	[VARCHAR] (10) NOT NULL,
	[O_TIPO_RUTA]	[INT] NOT NULL,
	[C_TIPO_RUTA]	[VARCHAR] (255) NOT NULL,
	[L_TIPO_RUTA]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_RUTA]
	ADD CONSTRAINT [PK_TIPO_RUTA]
		PRIMARY KEY CLUSTERED ([K_TIPO_RUTA])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_TIPO_RUTA_01_DESCRIPCION] 
	   ON [dbo].[TIPO_RUTA] ( [D_TIPO_RUTA] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_RUTA] ADD 
	CONSTRAINT [FK_TIPO_RUTA_01] 
		FOREIGN KEY ( [L_TIPO_RUTA] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO



-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_RUTA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_RUTA]
GO


CREATE PROCEDURE [dbo].[PG_CI_TIPO_RUTA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_TIPO_RUTA			INT,
	@PP_D_TIPO_RUTA			VARCHAR(100),
	@PP_S_TIPO_RUTA			VARCHAR(10),
	@PP_O_TIPO_RUTA			INT,
	@PP_C_TIPO_RUTA			VARCHAR(255),
	@PP_L_TIPO_RUTA			INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_TIPO_RUTA
							FROM	TIPO_RUTA
							WHERE	K_TIPO_RUTA=@PP_K_TIPO_RUTA

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO TIPO_RUTA
			(	K_TIPO_RUTA,				D_TIPO_RUTA, 
				S_TIPO_RUTA,				O_TIPO_RUTA,
				C_TIPO_RUTA,
				L_TIPO_RUTA					)
		VALUES	
			(	@PP_K_TIPO_RUTA,			@PP_D_TIPO_RUTA,	
				@PP_S_TIPO_RUTA,			@PP_O_TIPO_RUTA,
				@PP_C_TIPO_RUTA,
				@PP_L_TIPO_RUTA				)
	ELSE
		UPDATE	TIPO_RUTA
		SET		D_TIPO_RUTA	= @PP_D_TIPO_RUTA,	
				S_TIPO_RUTA	= @PP_S_TIPO_RUTA,			
				O_TIPO_RUTA	= @PP_O_TIPO_RUTA,
				C_TIPO_RUTA	= @PP_C_TIPO_RUTA,
				L_TIPO_RUTA	= @PP_L_TIPO_RUTA
		WHERE	K_TIPO_RUTA=@PP_K_TIPO_RUTA

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================


EXECUTE [dbo].[PG_CI_TIPO_RUTA] 0, 0,  1, 'TIPO CLIENTE 1',		'TCLI1', 1, '', 1
EXECUTE [dbo].[PG_CI_TIPO_RUTA] 0, 0,  2, 'TIPO CLIENTE 2',		'TCLI2', 1, '', 1
EXECUTE [dbo].[PG_CI_TIPO_RUTA] 0, 0,  3, 'TIPO CLIENTE 3',		'TCLI3', 1, '', 1
EXECUTE [dbo].[PG_CI_TIPO_RUTA] 0, 0,  4, 'TIPO CLIENTE 4',		'TCLI4', 1, '', 1
GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================







-- //////////////////////////////////////////////////////////////
-- // ESTATUS_RUTA
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTATUS_RUTA] (
	[K_ESTATUS_RUTA]	[INT] NOT NULL,
	[D_ESTATUS_RUTA]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_RUTA]	[VARCHAR] (10) NOT NULL,
	[O_ESTATUS_RUTA]	[INT] NOT NULL,
	[C_ESTATUS_RUTA]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_RUTA]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_RUTA]
	ADD CONSTRAINT [PK_ESTATUS_RUTA]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_RUTA])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_RUTA_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_RUTA] ( [D_ESTATUS_RUTA] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_RUTA] ADD 
	CONSTRAINT [FK_ESTATUS_RUTA_01] 
		FOREIGN KEY ( [L_ESTATUS_RUTA] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_RUTA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_RUTA]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_RUTA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_ESTATUS_RUTA		INT,
	@PP_D_ESTATUS_RUTA		VARCHAR(100),
	@PP_S_ESTATUS_RUTA		VARCHAR(10),
	@PP_O_ESTATUS_RUTA		INT,
	@PP_C_ESTATUS_RUTA		VARCHAR(255),
	@PP_L_ESTATUS_RUTA		INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTATUS_RUTA
							FROM	ESTATUS_RUTA
							WHERE	K_ESTATUS_RUTA=@PP_K_ESTATUS_RUTA

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_RUTA	
			(	K_ESTATUS_RUTA,				D_ESTATUS_RUTA, 
				S_ESTATUS_RUTA,				O_ESTATUS_RUTA,
				C_ESTATUS_RUTA,
				L_ESTATUS_RUTA				)		
		VALUES	
			(	@PP_K_ESTATUS_RUTA,			@PP_D_ESTATUS_RUTA,	
				@PP_S_ESTATUS_RUTA,			@PP_O_ESTATUS_RUTA,
				@PP_C_ESTATUS_RUTA,
				@PP_L_ESTATUS_RUTA			)
	ELSE
		UPDATE	ESTATUS_RUTA
		SET		D_ESTATUS_RUTA	= @PP_D_ESTATUS_RUTA,	
				S_ESTATUS_RUTA	= @PP_S_ESTATUS_RUTA,			
				O_ESTATUS_RUTA	= @PP_O_ESTATUS_RUTA,
				C_ESTATUS_RUTA	= @PP_C_ESTATUS_RUTA,
				L_ESTATUS_RUTA	= @PP_L_ESTATUS_RUTA	
		WHERE	K_ESTATUS_RUTA=@PP_K_ESTATUS_RUTA

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_RUTA] 0, 0, 0, 'INACTIVO',		'INACT', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_RUTA] 0, 0, 1, 'ACTIVO',		'ACTVO', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- //////////////////////////////////////////////////////////////
-- // RUTA
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[RUTA] (
	[K_RUTA]			[INT]			NOT NULL,
	[D_RUTA]			[VARCHAR] (100) NOT NULL,
	[S_RUTA]			[VARCHAR] (10)	NOT NULL,
	[O_RUTA]			[INT]			NOT NULL,
	[C_RUTA]			[VARCHAR] (255) NOT NULL,
	[L_RUTA]			[INT]			NOT NULL,
	-- ============================	
	[K_UNIDAD_OPERATIVA]	[INT]			NOT NULL
	-- ============================		
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[RUTA]
	ADD CONSTRAINT [PK_RUTA]
		PRIMARY KEY CLUSTERED ([K_RUTA])
GO

-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[RUTA] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[RUTA] ADD 
	CONSTRAINT [FK_RUTA_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_RUTA_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_RUTA_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
