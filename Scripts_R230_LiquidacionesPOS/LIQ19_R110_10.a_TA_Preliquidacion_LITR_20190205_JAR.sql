-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			PRELIQUIDACION_LTR 
-- // OPERACION:		LIBERACION / TABLAS 
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		JESUS ARCINIEGA
-- // FECHA:		05/FEB/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PRELIQUIDACION_LTR]') AND type in (N'U'))
	DROP TABLE [dbo].[PRELIQUIDACION_LTR]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_PRELIQUIDACION_LTR]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_PRELIQUIDACION_LTR]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_PRELIQUIDACION_LTR]') AND type in (N'U'))
	DROP TABLE [dbo].[TIPO_PRELIQUIDACION_LTR]
GO



-- //////////////////////////////////////////////////////////////
-- // ESTATUS_PRELIQUIDACION_LTR
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTATUS_PRELIQUIDACION_LTR] (
	[K_ESTATUS_PRELIQUIDACION_LTR]	[INT]			NOT NULL,
	[D_ESTATUS_PRELIQUIDACION_LTR]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_PRELIQUIDACION_LTR]	[VARCHAR] (10)  NOT NULL,
	[O_ESTATUS_PRELIQUIDACION_LTR]	[INT]			NOT NULL,
	[C_ESTATUS_PRELIQUIDACION_LTR]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_PRELIQUIDACION_LTR]	[INT]			NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_PRELIQUIDACION_LTR]
	ADD CONSTRAINT [PK_ESTATUS_PRELIQUIDACION_LTR]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_PRELIQUIDACION_LTR])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_PRELIQUIDACION_LTR_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_PRELIQUIDACION_LTR] ( [D_ESTATUS_PRELIQUIDACION_LTR] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_PRELIQUIDACION_LTR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_PRELIQUIDACION_LTR]
GO

-- //////////////////////////////////////////////////////////////
-- //				CI-ESTATUS_PRELIQUIDACION_LTR
-- //////////////////////////////////////////////////////////////


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_PRELIQUIDACION_LTR]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ========================================
	@PP_K_ESTATUS_PRELIQUIDACION_LTR		INT,
	@PP_D_ESTATUS_PRELIQUIDACION_LTR		VARCHAR(100),
	@PP_S_ESTATUS_PRELIQUIDACION_LTR		VARCHAR(10),
	@PP_O_ESTATUS_PRELIQUIDACION_LTR		INT,
	@PP_C_ESTATUS_PRELIQUIDACION_LTR		VARCHAR(255),
	@PP_L_ESTATUS_PRELIQUIDACION_LTR		INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTATUS_PRELIQUIDACION_LTR
							FROM	ESTATUS_PRELIQUIDACION_LTR
							WHERE	K_ESTATUS_PRELIQUIDACION_LTR=@PP_K_ESTATUS_PRELIQUIDACION_LTR

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_PRELIQUIDACION_LTR	
			(	K_ESTATUS_PRELIQUIDACION_LTR,				D_ESTATUS_PRELIQUIDACION_LTR, 
				S_ESTATUS_PRELIQUIDACION_LTR,				O_ESTATUS_PRELIQUIDACION_LTR,
				C_ESTATUS_PRELIQUIDACION_LTR,
				L_ESTATUS_PRELIQUIDACION_LTR				)		
		VALUES	
			(	@PP_K_ESTATUS_PRELIQUIDACION_LTR,			@PP_D_ESTATUS_PRELIQUIDACION_LTR,	
				@PP_S_ESTATUS_PRELIQUIDACION_LTR,			@PP_O_ESTATUS_PRELIQUIDACION_LTR,
				@PP_C_ESTATUS_PRELIQUIDACION_LTR,
				@PP_L_ESTATUS_PRELIQUIDACION_LTR			)
	ELSE
		UPDATE	ESTATUS_PRELIQUIDACION_LTR
		SET		D_ESTATUS_PRELIQUIDACION_LTR	= @PP_D_ESTATUS_PRELIQUIDACION_LTR,	
				S_ESTATUS_PRELIQUIDACION_LTR	= @PP_S_ESTATUS_PRELIQUIDACION_LTR,			
				O_ESTATUS_PRELIQUIDACION_LTR	= @PP_O_ESTATUS_PRELIQUIDACION_LTR,
				C_ESTATUS_PRELIQUIDACION_LTR	= @PP_C_ESTATUS_PRELIQUIDACION_LTR,
				L_ESTATUS_PRELIQUIDACION_LTR	= @PP_L_ESTATUS_PRELIQUIDACION_LTR	
		WHERE	K_ESTATUS_PRELIQUIDACION_LTR=@PP_K_ESTATUS_PRELIQUIDACION_LTR

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_PRELIQUIDACION_LTR] 0, 0, 0, 'INACTIVO',	'INACT', 2, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_PRELIQUIDACION_LTR] 0, 0, 1, 'ACTIVO',		'ACTVO', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================





-- //////////////////////////////////////////////////////////////
-- // TIPO_PUNTO_VENTA
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[TIPO_PRELIQUIDACION_LTR] (
	[K_TIPO_PRELIQUIDACION_LTR]	[INT]			NOT NULL,
	[D_TIPO_PRELIQUIDACION_LTR]	[VARCHAR] (100) NOT NULL,
	[S_TIPO_PRELIQUIDACION_LTR]	[VARCHAR] (10)  NOT NULL,
	[O_TIPO_PRELIQUIDACION_LTR]	[INT]			NOT NULL,
	[C_TIPO_PRELIQUIDACION_LTR]	[VARCHAR] (255) NOT NULL,
	[L_TIPO_PRELIQUIDACION_LTR]	[INT]			NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_PRELIQUIDACION_LTR]
	ADD CONSTRAINT [PK_TIPO_PRELIQUIDACION_LTR]
		PRIMARY KEY CLUSTERED ([K_TIPO_PRELIQUIDACION_LTR])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_TIPO_PRELIQUIDACION_LTR_01_DESCRIPCION] 
	   ON [dbo].[TIPO_PRELIQUIDACION_LTR] ( [D_TIPO_PRELIQUIDACION_LTR] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_PRELIQUIDACION_LTR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_PRELIQUIDACION_LTR]
GO

-- //////////////////////////////////////////////////////////////
-- //				CI-TIPO_PRELIQUIDACION_LTR
-- //////////////////////////////////////////////////////////////

CREATE PROCEDURE [dbo].[PG_CI_TIPO_PRELIQUIDACION_LTR]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ========================================
	@PP_K_TIPO_PRELIQUIDACION_LTR			INT,
	@PP_D_TIPO_PRELIQUIDACION_LTR			VARCHAR(100),
	@PP_S_TIPO_PRELIQUIDACION_LTR			VARCHAR(10),
	@PP_O_TIPO_PRELIQUIDACION_LTR			INT,
	@PP_C_TIPO_PRELIQUIDACION_LTR			VARCHAR(255),
	@PP_L_TIPO_PRELIQUIDACION_LTR			INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_TIPO_PRELIQUIDACION_LTR
							FROM	TIPO_PRELIQUIDACION_LTR
							WHERE	K_TIPO_PRELIQUIDACION_LTR=@PP_K_TIPO_PRELIQUIDACION_LTR

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO TIPO_PRELIQUIDACION_LTR
			(	K_TIPO_PRELIQUIDACION_LTR,			D_TIPO_PRELIQUIDACION_LTR, 
				S_TIPO_PRELIQUIDACION_LTR,			O_TIPO_PRELIQUIDACION_LTR,
				C_TIPO_PRELIQUIDACION_LTR,
				L_TIPO_PRELIQUIDACION_LTR			)
		VALUES	
			(	@PP_K_TIPO_PRELIQUIDACION_LTR,			@PP_D_TIPO_PRELIQUIDACION_LTR,	
				@PP_S_TIPO_PRELIQUIDACION_LTR,			@PP_O_TIPO_PRELIQUIDACION_LTR,
				@PP_C_TIPO_PRELIQUIDACION_LTR,
				@PP_L_TIPO_PRELIQUIDACION_LTR		)
	ELSE
		UPDATE	TIPO_PRELIQUIDACION_LTR
		SET		D_TIPO_PRELIQUIDACION_LTR	= @PP_D_TIPO_PRELIQUIDACION_LTR,	
				S_TIPO_PRELIQUIDACION_LTR	= @PP_S_TIPO_PRELIQUIDACION_LTR,			
				O_TIPO_PRELIQUIDACION_LTR	= @PP_O_TIPO_PRELIQUIDACION_LTR,
				C_TIPO_PRELIQUIDACION_LTR	= @PP_C_TIPO_PRELIQUIDACION_LTR,
				L_TIPO_PRELIQUIDACION_LTR	= @PP_L_TIPO_PRELIQUIDACION_LTR
		WHERE	K_TIPO_PRELIQUIDACION_LTR=@PP_K_TIPO_PRELIQUIDACION_LTR

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================


EXECUTE [dbo].[PG_CI_TIPO_PRELIQUIDACION_LTR] 0, 0,  1, 'INICIAL',	'INI', 1, '', 1
EXECUTE [dbo].[PG_CI_TIPO_PRELIQUIDACION_LTR] 0, 0,  2, 'FINAL',	'FIN', 2, '', 1
GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- //////////////////////////////////////////////////////////////
-- // PRELIQUIDACION_LTR
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[PRELIQUIDACION_LTR] (
	[K_PRELIQUIDACION_LTR]				[INT]			NOT NULL,
	[D_PRELIQUIDACION_LTR]				[VARCHAR](100)	NOT NULL,
	[S_PRELIQUIDACION_LTR]				[VARCHAR](10)	NOT NULL,
	[O_PRELIQUIDACION_LTR]				[INT]			NOT NULL,
	[L_PRELIQUIDACION_LTR]				[INT]			NOT NULL,
	[F_PRELIQUIDACION_LTR]				[DATE]			NOT NULL,
	-- ============================	
	[K_TIPO_PRELIQUIDACION_LTR]			[INT]			NOT NULL,
	[K_ESTATUS_PRELIQUIDACION_LTR]		[INT]			NOT NULL,
	[K_PUNTO_VENTA]					[INT]			NOT NULL,
	-- ============================		
	[LITROMETRO_INICIAL]			[DECIMAL](19,4)		NOT NULL,
	[LITROMETRO_FINAL]				[DECIMAL](19,4)		NOT NULL,
	[PESO_INICIAL]					[DECIMAL](19,4)		NOT NULL,
	[PESO_FINAL]					[DECIMAL](19,4)		NOT NULL,
	[NIVEL_INICIAL]					[DECIMAL](19,4)		NOT NULL,
	[NIVEL_FINAL]					[DECIMAL](19,4)		NOT NULL
	-- ============================		
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[PRELIQUIDACION_LTR]
	ADD CONSTRAINT [PK_PRELIQUIDACION_LTR]
		PRIMARY KEY CLUSTERED ([K_PRELIQUIDACION_LTR])
GO

-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[PRELIQUIDACION_LTR] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[PRELIQUIDACION_LTR] ADD 
	CONSTRAINT [FK_PRELIQUIDACION_LTR_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_PRELIQUIDACION_LTR_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_PRELIQUIDACION_LTR_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
