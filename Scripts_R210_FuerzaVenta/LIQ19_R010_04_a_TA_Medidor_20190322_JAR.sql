-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			MEDIDOR 
-- // OPERACION:		LIBERACION / TABLAS 
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		JESUS ARCINIEGA
-- // FECHA:		22/MAR/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MEDIDOR]') AND type in (N'U'))
	DROP TABLE [dbo].[MEDIDOR]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_MEDIDOR]') AND type in (N'U'))
	DROP TABLE [dbo].[TIPO_MEDIDOR]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_MEDIDOR]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_MEDIDOR]
GO




-- //////////////////////////////////////////////////////////////
-- // TIPO_MEDIDOR
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[TIPO_MEDIDOR] (
	[K_TIPO_MEDIDOR]	[INT] NOT NULL,
	[D_TIPO_MEDIDOR]	[VARCHAR] (100) NOT NULL,
	[S_TIPO_MEDIDOR]	[VARCHAR] (10) NOT NULL,
	[O_TIPO_MEDIDOR]	[INT] NOT NULL,
	[C_TIPO_MEDIDOR]	[VARCHAR] (255) NOT NULL,
	[L_TIPO_MEDIDOR]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_MEDIDOR]
	ADD CONSTRAINT [PK_TIPO_MEDIDOR]
		PRIMARY KEY CLUSTERED ([K_TIPO_MEDIDOR])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_TIPO_MEDIDOR_01_DESCRIPCION] 
	   ON [dbo].[TIPO_MEDIDOR] ( [D_TIPO_MEDIDOR] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_MEDIDOR] ADD 
	CONSTRAINT [FK_TIPO_MEDIDOR_01] 
		FOREIGN KEY ( [L_TIPO_MEDIDOR] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO



-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_MEDIDOR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_MEDIDOR]
GO


CREATE PROCEDURE [dbo].[PG_CI_TIPO_MEDIDOR]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_TIPO_MEDIDOR			INT,
	@PP_D_TIPO_MEDIDOR			VARCHAR(100),
	@PP_S_TIPO_MEDIDOR			VARCHAR(10),
	@PP_O_TIPO_MEDIDOR			INT,
	@PP_C_TIPO_MEDIDOR			VARCHAR(255),
	@PP_L_TIPO_MEDIDOR			INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_TIPO_MEDIDOR
							FROM	TIPO_MEDIDOR
							WHERE	K_TIPO_MEDIDOR=@PP_K_TIPO_MEDIDOR

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO TIPO_MEDIDOR
			(	K_TIPO_MEDIDOR,				D_TIPO_MEDIDOR, 
				S_TIPO_MEDIDOR,				O_TIPO_MEDIDOR,
				C_TIPO_MEDIDOR,
				L_TIPO_MEDIDOR				)
		VALUES	
			(	@PP_K_TIPO_MEDIDOR,			@PP_D_TIPO_MEDIDOR,	
				@PP_S_TIPO_MEDIDOR,			@PP_O_TIPO_MEDIDOR,
				@PP_C_TIPO_MEDIDOR,
				@PP_L_TIPO_MEDIDOR			)
	ELSE
		UPDATE	TIPO_MEDIDOR
		SET		D_TIPO_MEDIDOR		= @PP_D_TIPO_MEDIDOR,	
				S_TIPO_MEDIDOR		= @PP_S_TIPO_MEDIDOR,			
				O_TIPO_MEDIDOR		= @PP_O_TIPO_MEDIDOR,
				C_TIPO_MEDIDOR		= @PP_C_TIPO_MEDIDOR,
				L_TIPO_MEDIDOR		= @PP_L_TIPO_MEDIDOR
		WHERE	K_TIPO_MEDIDOR=@PP_K_TIPO_MEDIDOR

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================


-- ==========================================
EXECUTE [dbo].[PG_CI_TIPO_MEDIDOR] 0, 0,  1, 'NINGUNO',				'NIN', 1, '', 1
EXECUTE [dbo].[PG_CI_TIPO_MEDIDOR] 0, 0,  2, 'GASPAR G4S',			'G4S', 1, '', 1
EXECUTE [dbo].[PG_CI_TIPO_MEDIDOR] 0, 0,  3, 'GASPAR TRADICIONAL',	'TRA', 1, '', 1

GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- //////////////////////////////////////////////////////////////
-- // ESTATUS_MEDIDOR
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTATUS_MEDIDOR] (
	[K_ESTATUS_MEDIDOR]	[INT] NOT NULL,
	[D_ESTATUS_MEDIDOR]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_MEDIDOR]	[VARCHAR] (10) NOT NULL,
	[O_ESTATUS_MEDIDOR]	[INT] NOT NULL,
	[C_ESTATUS_MEDIDOR]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_MEDIDOR]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_MEDIDOR]
	ADD CONSTRAINT [PK_ESTATUS_MEDIDOR]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_MEDIDOR])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_MEDIDOR_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_MEDIDOR] ( [D_ESTATUS_MEDIDOR] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_MEDIDOR] ADD 
	CONSTRAINT [FK_ESTATUS_MEDIDOR_01] 
		FOREIGN KEY ( [L_ESTATUS_MEDIDOR] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_MEDIDOR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_MEDIDOR]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_MEDIDOR]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_ESTATUS_MEDIDOR		INT,
	@PP_D_ESTATUS_MEDIDOR		VARCHAR(100),
	@PP_S_ESTATUS_MEDIDOR		VARCHAR(10),
	@PP_O_ESTATUS_MEDIDOR		INT,
	@PP_C_ESTATUS_MEDIDOR		VARCHAR(255),
	@PP_L_ESTATUS_MEDIDOR		INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTATUS_MEDIDOR
							FROM	ESTATUS_MEDIDOR
							WHERE	K_ESTATUS_MEDIDOR=@PP_K_ESTATUS_MEDIDOR

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_MEDIDOR	
			(	K_ESTATUS_MEDIDOR,				D_ESTATUS_MEDIDOR, 
				S_ESTATUS_MEDIDOR,				O_ESTATUS_MEDIDOR,
				C_ESTATUS_MEDIDOR,
				L_ESTATUS_MEDIDOR				)		
		VALUES	
			(	@PP_K_ESTATUS_MEDIDOR,			@PP_D_ESTATUS_MEDIDOR,	
				@PP_S_ESTATUS_MEDIDOR,			@PP_O_ESTATUS_MEDIDOR,
				@PP_C_ESTATUS_MEDIDOR,
				@PP_L_ESTATUS_MEDIDOR			)
	ELSE
		UPDATE	ESTATUS_MEDIDOR
		SET		D_ESTATUS_MEDIDOR	= @PP_D_ESTATUS_MEDIDOR,	
				S_ESTATUS_MEDIDOR	= @PP_S_ESTATUS_MEDIDOR,			
				O_ESTATUS_MEDIDOR	= @PP_O_ESTATUS_MEDIDOR,
				C_ESTATUS_MEDIDOR	= @PP_C_ESTATUS_MEDIDOR,
				L_ESTATUS_MEDIDOR	= @PP_L_ESTATUS_MEDIDOR	
		WHERE	K_ESTATUS_MEDIDOR=@PP_K_ESTATUS_MEDIDOR

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_MEDIDOR] 0, 0, 0, 'INACTIVO','INACT', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_MEDIDOR] 0, 0, 1, 'ACTIVO','ACTVO', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- //////////////////////////////////////////////////////////////
-- // MEDIDOR
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[MEDIDOR] (
	[K_MEDIDOR]							[INT]			NOT NULL,
	-- ============================	
	[D_MEDIDOR]							[VARCHAR](255)  NOT NULL,
	[S_MEDIDOR]							[VARCHAR](10)   NOT NULL,
	[O_MEDIDOR]							[INT]			NOT NULL,
	[L_MEDIDOR]							[INT]			NOT NULL,
	-- ============================		
	[K_ESTATUS_MEDIDOR]					[INT]			NOT NULL,
	[K_TIPO_MEDIDOR]					[INT]			NOT NULL
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[MEDIDOR]
	ADD CONSTRAINT [PK_MEDIDOR]
		PRIMARY KEY CLUSTERED ([K_MEDIDOR])
GO

-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[MEDIDOR] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[MEDIDOR] ADD 
	CONSTRAINT [FK_MEDIDOR_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_MEDIDOR_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_MEDIDOR_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_MEDIDOR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_MEDIDOR]
GO


CREATE PROCEDURE [dbo].[PG_CI_TIPO_MEDIDOR]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_MEDIDOR			INT,
	@PP_D_MEDIDOR			VARCHAR(100),
	@PP_S_MEDIDOR			VARCHAR(10),
	@PP_O_MEDIDOR			INT,
	@PP_L_MEDIDOR			INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_TIPO_MEDIDOR
							FROM	TIPO_MEDIDOR
							WHERE	K_TIPO_MEDIDOR=@PP_K_MEDIDOR

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO MEDIDOR
			(	K_MEDIDOR,				D_MEDIDOR, 
				S_MEDIDOR,				O_MEDIDOR,
				L_MEDIDOR		)
		VALUES	
			(	@PP_K_MEDIDOR,			@PP_D_MEDIDOR,	
				@PP_S_MEDIDOR,			@PP_O_MEDIDOR,
				@PP_L_MEDIDOR		)
	ELSE
		UPDATE	MEDIDOR
		SET		D_MEDIDOR		= @PP_D_MEDIDOR,	
				S_MEDIDOR		= @PP_S_MEDIDOR,			
				O_MEDIDOR		= @PP_O_MEDIDOR,
				L_MEDIDOR		= @PP_L_MEDIDOR
		WHERE	K_MEDIDOR=@PP_K_MEDIDOR

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================


-- ==========================================
EXECUTE [dbo].[PG_CI_TIPO_MEDIDOR] 0, 0,  1, 'NINGUNO',				'NIN',0, 1
EXECUTE [dbo].[PG_CI_TIPO_MEDIDOR] 0, 0,  2, 'GASPAR G4S',			'G4S',0, 1
EXECUTE [dbo].[PG_CI_TIPO_MEDIDOR] 0, 0,  3, 'GASPAR TRADICIONAL',	'TRA',0, 1

GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
