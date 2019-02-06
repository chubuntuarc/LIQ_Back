-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			PRELIQUIDACION 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PRELIQUIDACION]') AND type in (N'U'))
	DROP TABLE [dbo].[PRELIQUIDACION]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_PRELIQUIDACION]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_PRELIQUIDACION]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_PRELIQUIDACION]') AND type in (N'U'))
	DROP TABLE [dbo].[TIPO_PRELIQUIDACION]
GO



-- //////////////////////////////////////////////////////////////
-- // ESTATUS_PRELIQUIDACION
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTATUS_PRELIQUIDACION] (
	[K_ESTATUS_PRELIQUIDACION]	[INT]			NOT NULL,
	[D_ESTATUS_PRELIQUIDACION]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_PRELIQUIDACION]	[VARCHAR] (10)  NOT NULL,
	[O_ESTATUS_PRELIQUIDACION]	[INT]			NOT NULL,
	[C_ESTATUS_PRELIQUIDACION]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_PRELIQUIDACION]	[INT]			NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_PRELIQUIDACION]
	ADD CONSTRAINT [PK_ESTATUS_PRELIQUIDACION]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_PRELIQUIDACION])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_PRELIQUIDACION_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_PRELIQUIDACION] ( [D_ESTATUS_PRELIQUIDACION] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_PRELIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_PRELIQUIDACION]
GO

-- //////////////////////////////////////////////////////////////
-- //				CI-ESTATUS_PRELIQUIDACION
-- //////////////////////////////////////////////////////////////


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_PRELIQUIDACION]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ========================================
	@PP_K_ESTATUS_PRELIQUIDACION		INT,
	@PP_D_ESTATUS_PRELIQUIDACION		VARCHAR(100),
	@PP_S_ESTATUS_PRELIQUIDACION		VARCHAR(10),
	@PP_O_ESTATUS_PRELIQUIDACION		INT,
	@PP_C_ESTATUS_PRELIQUIDACION		VARCHAR(255),
	@PP_L_ESTATUS_PRELIQUIDACION		INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTATUS_PRELIQUIDACION
							FROM	ESTATUS_PRELIQUIDACION
							WHERE	K_ESTATUS_PRELIQUIDACION=@PP_K_ESTATUS_PRELIQUIDACION

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_PRELIQUIDACION	
			(	K_ESTATUS_PRELIQUIDACION,				D_ESTATUS_PRELIQUIDACION, 
				S_ESTATUS_PRELIQUIDACION,				O_ESTATUS_PRELIQUIDACION,
				C_ESTATUS_PRELIQUIDACION,
				L_ESTATUS_PRELIQUIDACION				)		
		VALUES	
			(	@PP_K_ESTATUS_PRELIQUIDACION,			@PP_D_ESTATUS_PRELIQUIDACION,	
				@PP_S_ESTATUS_PRELIQUIDACION,			@PP_O_ESTATUS_PRELIQUIDACION,
				@PP_C_ESTATUS_PRELIQUIDACION,
				@PP_L_ESTATUS_PRELIQUIDACION			)
	ELSE
		UPDATE	ESTATUS_PRELIQUIDACION
		SET		D_ESTATUS_PRELIQUIDACION	= @PP_D_ESTATUS_PRELIQUIDACION,	
				S_ESTATUS_PRELIQUIDACION	= @PP_S_ESTATUS_PRELIQUIDACION,			
				O_ESTATUS_PRELIQUIDACION	= @PP_O_ESTATUS_PRELIQUIDACION,
				C_ESTATUS_PRELIQUIDACION	= @PP_C_ESTATUS_PRELIQUIDACION,
				L_ESTATUS_PRELIQUIDACION	= @PP_L_ESTATUS_PRELIQUIDACION	
		WHERE	K_ESTATUS_PRELIQUIDACION=@PP_K_ESTATUS_PRELIQUIDACION

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_PRELIQUIDACION] 0, 0, 0, 'INACTIVO',	'INACT', 2, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_PRELIQUIDACION] 0, 0, 1, 'ACTIVO',		'ACTVO', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================





-- //////////////////////////////////////////////////////////////
-- // TIPO_PUNTO_VENTA
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[TIPO_PRELIQUIDACION] (
	[K_TIPO_PRELIQUIDACION]	[INT]			NOT NULL,
	[D_TIPO_PRELIQUIDACION]	[VARCHAR] (100) NOT NULL,
	[S_TIPO_PRELIQUIDACION]	[VARCHAR] (10)  NOT NULL,
	[O_TIPO_PRELIQUIDACION]	[INT]			NOT NULL,
	[C_TIPO_PRELIQUIDACION]	[VARCHAR] (255) NOT NULL,
	[L_TIPO_PRELIQUIDACION]	[INT]			NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_PRELIQUIDACION]
	ADD CONSTRAINT [PK_TIPO_PRELIQUIDACION]
		PRIMARY KEY CLUSTERED ([K_TIPO_PRELIQUIDACION])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_TIPO_PRELIQUIDACION_01_DESCRIPCION] 
	   ON [dbo].[TIPO_PRELIQUIDACION] ( [D_TIPO_PRELIQUIDACION] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_PRELIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_PRELIQUIDACION]
GO

-- //////////////////////////////////////////////////////////////
-- //				CI-TIPO_PRELIQUIDACION
-- //////////////////////////////////////////////////////////////

CREATE PROCEDURE [dbo].[PG_CI_TIPO_PRELIQUIDACION]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ========================================
	@PP_K_TIPO_PRELIQUIDACION			INT,
	@PP_D_TIPO_PRELIQUIDACION			VARCHAR(100),
	@PP_S_TIPO_PRELIQUIDACION			VARCHAR(10),
	@PP_O_TIPO_PRELIQUIDACION			INT,
	@PP_C_TIPO_PRELIQUIDACION			VARCHAR(255),
	@PP_L_TIPO_PRELIQUIDACION			INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_TIPO_PUNTO_VENTA
							FROM	TIPO_PUNTO_VENTA
							WHERE	K_TIPO_PUNTO_VENTA=@PP_K_TIPO_PRELIQUIDACION

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO TIPO_PUNTO_VENTA
			(	K_TIPO_PUNTO_VENTA,				D_TIPO_PUNTO_VENTA, 
				S_TIPO_PUNTO_VENTA,				O_TIPO_PUNTO_VENTA,
				C_TIPO_PUNTO_VENTA,
				L_TIPO_PUNTO_VENTA			)
		VALUES	
			(	@PP_K_TIPO_PRELIQUIDACION,			@PP_D_TIPO_PRELIQUIDACION,	
				@PP_S_TIPO_PRELIQUIDACION,			@PP_O_TIPO_PRELIQUIDACION,
				@PP_C_TIPO_PRELIQUIDACION,
				@PP_L_TIPO_PRELIQUIDACION		)
	ELSE
		UPDATE	TIPO_PUNTO_VENTA
		SET		D_TIPO_PUNTO_VENTA	= @PP_D_TIPO_PRELIQUIDACION,	
				S_TIPO_PUNTO_VENTA	= @PP_S_TIPO_PRELIQUIDACION,			
				O_TIPO_PUNTO_VENTA	= @PP_O_TIPO_PRELIQUIDACION,
				C_TIPO_PUNTO_VENTA	= @PP_C_TIPO_PRELIQUIDACION,
				L_TIPO_PUNTO_VENTA	= @PP_L_TIPO_PRELIQUIDACION
		WHERE	K_TIPO_PUNTO_VENTA=@PP_K_TIPO_PRELIQUIDACION

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================


EXECUTE [dbo].[PG_CI_TIPO_PUNTO_VENTA] 0, 0,  1, 'INICIAL',	'INI', 1, '', 1
EXECUTE [dbo].[PG_CI_TIPO_PUNTO_VENTA] 0, 0,  2, 'FINAL',	'FIN', 2, '', 1
GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- //////////////////////////////////////////////////////////////
-- // PRELIQUIDACION
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[PRELIQUIDACION] (
	[K_PRELIQUIDACION]				[INT]			NOT NULL,
	[D_PRELIQUIDACION]				[VARCHAR](100)	NOT NULL,
	[S_PRELIQUIDACION]				[VARCHAR](10)	NOT NULL,
	[O_PRELIQUIDACION]				[INT]			NOT NULL,
	[L_PRELIQUIDACION]				[INT]			NOT NULL,
	[F_PRELIQUIDACION]				[DATE]			NOT NULL,
	-- ============================	
	[K_TIPO_PRELIQUIDACION]			[INT]			NOT NULL,
	[K_ESTATUS_PRELIQUIDACION]		[INT]			NOT NULL,
	[K_PUNTO_VENTA]					[INT]			NOT NULL,
	-- ============================		
	[PESO_INICIAL]					[DECIMAL](19,4)	NOT NULL,
	[PESO_FINAL]					[DECIMAL](19,4)	NOT NULL,
	[NIVEL_INICIAL]					[INT]			NOT NULL,
	[NIVEL_FINAL]					[INT]			NOT NULL,
	[LECTURA_INICIAL]				[DECIMAL](19,4)	NOT NULL,
	[LECTURA_FINAL]					[DECIMAL](19,4)	NOT NULL,
	[CARBURACION_INICIAL]			[DECIMAL](19,4)	NOT NULL,
	[CARBURACION_FINAL]				[DECIMAL](19,4)	NOT NULL,
	[TANQUE_10_INICIAL]				[INT]			NOT NULL,
	[TANQUE_10_FINAL]				[INT]			NOT NULL,
	[TANQUE_20_INICIAL]				[INT]			NOT NULL,
	[TANQUE_20_FINAL]				[INT]			NOT NULL,
	[TANQUE_27_INICIAL]				[INT]			NOT NULL,
	[TANQUE_27_FINAL]				[INT]			NOT NULL,
	[TANQUE_30_INICIAL]				[INT]			NOT NULL,
	[TANQUE_30_FINAL]				[INT]			NOT NULL,
	[TANQUE_45_INICIAL]				[INT]			NOT NULL,
	[TANQUE_45_FINAL]				[INT]			NOT NULL
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[PRELIQUIDACION]
	ADD CONSTRAINT [PK_PRELIQUIDACION]
		PRIMARY KEY CLUSTERED ([K_PRELIQUIDACION])
GO

-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[PRELIQUIDACION] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[PRELIQUIDACION] ADD 
	CONSTRAINT [FK_PRELIQUIDACION_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_PRELIQUIDACION_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_PRELIQUIDACION_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
