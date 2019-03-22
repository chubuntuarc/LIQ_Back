-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			PRODUCTO 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PRODUCTO]') AND type in (N'U'))
	DROP TABLE [dbo].[PRODUCTO]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_PRODUCTO]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_PRODUCTO]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CLASE_PRODUCTO]') AND type in (N'U'))
	DROP TABLE [dbo].[CLASE_PRODUCTO]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_PRODUCTO]') AND type in (N'U'))
	DROP TABLE [dbo].[TIPO_PRODUCTO]
GO



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UNIDAD]') AND type in (N'U'))
	DROP TABLE [dbo].[UNIDAD]
GO





-- //////////////////////////////////////////////////////////////
-- // UNIDAD
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[UNIDAD] (
	[K_UNIDAD]	[INT] NOT NULL,
	[D_UNIDAD]	[VARCHAR] (100) NOT NULL,
	[S_UNIDAD]	[VARCHAR] (10) NOT NULL,
	[O_UNIDAD]	[INT] NOT NULL,
	[C_UNIDAD]	[VARCHAR] (255) NOT NULL,
	[L_UNIDAD]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[UNIDAD]
	ADD CONSTRAINT [PK_UNIDAD]
		PRIMARY KEY CLUSTERED ([K_UNIDAD])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_UNIDAD_01_DESCRIPCION] 
	   ON [dbo].[UNIDAD] ( [D_UNIDAD] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[UNIDAD] ADD 
	CONSTRAINT [FK_UNIDAD_01] 
		FOREIGN KEY ( [L_UNIDAD] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_UNIDAD]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_UNIDAD]
GO


CREATE PROCEDURE [dbo].[PG_CI_UNIDAD]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_UNIDAD		INT,
	@PP_D_UNIDAD		VARCHAR(100),
	@PP_S_UNIDAD		VARCHAR(10),
	@PP_O_UNIDAD		INT,
	@PP_C_UNIDAD		VARCHAR(255),
	@PP_L_UNIDAD		INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_UNIDAD
							FROM	UNIDAD
							WHERE	K_UNIDAD=@PP_K_UNIDAD

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO UNIDAD
			(	K_UNIDAD,			D_UNIDAD, 
				S_UNIDAD,			O_UNIDAD,
				C_UNIDAD,
				L_UNIDAD			)		
		VALUES	
			(	@PP_K_UNIDAD,		@PP_D_UNIDAD,	
				@PP_S_UNIDAD,		@PP_O_UNIDAD,
				@PP_C_UNIDAD,
				@PP_L_UNIDAD		)
	ELSE
		UPDATE	UNIDAD
		SET		D_UNIDAD	= @PP_D_UNIDAD,	
				S_UNIDAD	= @PP_S_UNIDAD,			
				O_UNIDAD	= @PP_O_UNIDAD,
				C_UNIDAD	= @PP_C_UNIDAD,
				L_UNIDAD	= @PP_L_UNIDAD	
		WHERE	K_UNIDAD=@PP_K_UNIDAD

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////





-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_UNIDAD] 0, 0,  1, 'KILO',		'CARB', 1, '', 1
EXECUTE [dbo].[PG_CI_UNIDAD] 0, 0,  2, 'LITRO',		'ESTC', 1, '', 1
EXECUTE [dbo].[PG_CI_UNIDAD] 0, 0,  3, 'PIEZA',		'PIEZ', 1, '', 1
EXECUTE [dbo].[PG_CI_UNIDAD] 0, 0,  4, 'SERVICIO',	'SERV', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================







-- //////////////////////////////////////////////////////////////
-- // CLASE_PRODUCTO
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[CLASE_PRODUCTO] (
	[K_CLASE_PRODUCTO]	[INT] NOT NULL,
	[D_CLASE_PRODUCTO]	[VARCHAR] (100) NOT NULL,
	[S_CLASE_PRODUCTO]	[VARCHAR] (10) NOT NULL,
	[O_CLASE_PRODUCTO]	[INT] NOT NULL,
	[C_CLASE_PRODUCTO]	[VARCHAR] (255) NOT NULL,
	[L_CLASE_PRODUCTO]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[CLASE_PRODUCTO]
	ADD CONSTRAINT [PK_CLASE_PRODUCTO]
		PRIMARY KEY CLUSTERED ([K_CLASE_PRODUCTO])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_CLASE_PRODUCTO_01_DESCRIPCION] 
	   ON [dbo].[CLASE_PRODUCTO] ( [D_CLASE_PRODUCTO] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[CLASE_PRODUCTO] ADD 
	CONSTRAINT [FK_CLASE_PRODUCTO_01] 
		FOREIGN KEY ( [L_CLASE_PRODUCTO] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_CLASE_PRODUCTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_CLASE_PRODUCTO]
GO


CREATE PROCEDURE [dbo].[PG_CI_CLASE_PRODUCTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_CLASE_PRODUCTO		INT,
	@PP_D_CLASE_PRODUCTO		VARCHAR(100),
	@PP_S_CLASE_PRODUCTO		VARCHAR(10),
	@PP_O_CLASE_PRODUCTO		INT,
	@PP_C_CLASE_PRODUCTO		VARCHAR(255),
	@PP_L_CLASE_PRODUCTO		INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_CLASE_PRODUCTO
							FROM	CLASE_PRODUCTO
							WHERE	K_CLASE_PRODUCTO=@PP_K_CLASE_PRODUCTO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO CLASE_PRODUCTO
			(	K_CLASE_PRODUCTO,			D_CLASE_PRODUCTO, 
				S_CLASE_PRODUCTO,			O_CLASE_PRODUCTO,
				C_CLASE_PRODUCTO,
				L_CLASE_PRODUCTO			)		
		VALUES	
			(	@PP_K_CLASE_PRODUCTO,		@PP_D_CLASE_PRODUCTO,	
				@PP_S_CLASE_PRODUCTO,		@PP_O_CLASE_PRODUCTO,
				@PP_C_CLASE_PRODUCTO,
				@PP_L_CLASE_PRODUCTO		)
	ELSE
		UPDATE	CLASE_PRODUCTO
		SET		D_CLASE_PRODUCTO	= @PP_D_CLASE_PRODUCTO,	
				S_CLASE_PRODUCTO	= @PP_S_CLASE_PRODUCTO,			
				O_CLASE_PRODUCTO	= @PP_O_CLASE_PRODUCTO,
				C_CLASE_PRODUCTO	= @PP_C_CLASE_PRODUCTO,
				L_CLASE_PRODUCTO	= @PP_L_CLASE_PRODUCTO	
		WHERE	K_CLASE_PRODUCTO=@PP_K_CLASE_PRODUCTO

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////





-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_CLASE_PRODUCTO] 0, 0,  1, 'GAS LP',	'GAS', 1, '', 1
EXECUTE [dbo].[PG_CI_CLASE_PRODUCTO] 0, 0,  2, 'PRODUCTOS',	'PRO', 1, '', 1
EXECUTE [dbo].[PG_CI_CLASE_PRODUCTO] 0, 0,  3, 'SERVICIOS',	'SER', 1, '', 1
GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- //////////////////////////////////////////////////////////////
-- // TIPO_PRODUCTO
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[TIPO_PRODUCTO] (
	[K_TIPO_PRODUCTO]	[INT] NOT NULL,
	[D_TIPO_PRODUCTO]	[VARCHAR] (100) NOT NULL,
	[S_TIPO_PRODUCTO]	[VARCHAR] (10) NOT NULL,
	[O_TIPO_PRODUCTO]	[INT] NOT NULL,
	[C_TIPO_PRODUCTO]	[VARCHAR] (255) NOT NULL,
	[L_TIPO_PRODUCTO]	[INT] NOT NULL,
	[K_CLASE_PRODUCTO]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_PRODUCTO]
	ADD CONSTRAINT [PK_TIPO_PRODUCTO]
		PRIMARY KEY CLUSTERED ([K_TIPO_PRODUCTO])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_TIPO_PRODUCTO_01_DESCRIPCION] 
	   ON [dbo].[TIPO_PRODUCTO] ( [D_TIPO_PRODUCTO] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[TIPO_PRODUCTO] ADD 
	CONSTRAINT [FK_TIPO_PRODUCTO_01] 
		FOREIGN KEY ( [L_TIPO_PRODUCTO] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] ),
	CONSTRAINT [FK_TIPO_PRODUCTO_02] 
		FOREIGN KEY ( [K_CLASE_PRODUCTO] ) 
		REFERENCES [dbo].[CLASE_PRODUCTO] ( [K_CLASE_PRODUCTO] )
GO



-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_PRODUCTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_PRODUCTO]
GO


CREATE PROCEDURE [dbo].[PG_CI_TIPO_PRODUCTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_TIPO_PRODUCTO			INT,
	@PP_D_TIPO_PRODUCTO			VARCHAR(100),
	@PP_S_TIPO_PRODUCTO			VARCHAR(10),
	@PP_O_TIPO_PRODUCTO			INT,
	@PP_C_TIPO_PRODUCTO			VARCHAR(255),
	@PP_L_TIPO_PRODUCTO			INT,
	@PP_K_CLASE_PRODUCTO		INT		
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_TIPO_PRODUCTO
							FROM	TIPO_PRODUCTO
							WHERE	K_TIPO_PRODUCTO=@PP_K_TIPO_PRODUCTO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO TIPO_PRODUCTO
			(	K_TIPO_PRODUCTO,				D_TIPO_PRODUCTO, 
				S_TIPO_PRODUCTO,				O_TIPO_PRODUCTO,
				C_TIPO_PRODUCTO,
				L_TIPO_PRODUCTO,
				K_CLASE_PRODUCTO				)
		VALUES	
			(	@PP_K_TIPO_PRODUCTO,			@PP_D_TIPO_PRODUCTO,	
				@PP_S_TIPO_PRODUCTO,			@PP_O_TIPO_PRODUCTO,
				@PP_C_TIPO_PRODUCTO,
				@PP_L_TIPO_PRODUCTO,
				@PP_K_CLASE_PRODUCTO			)
	ELSE
		UPDATE	TIPO_PRODUCTO
		SET		D_TIPO_PRODUCTO		= @PP_D_TIPO_PRODUCTO,	
				S_TIPO_PRODUCTO		= @PP_S_TIPO_PRODUCTO,			
				O_TIPO_PRODUCTO		= @PP_O_TIPO_PRODUCTO,
				C_TIPO_PRODUCTO		= @PP_C_TIPO_PRODUCTO,
				L_TIPO_PRODUCTO		= @PP_L_TIPO_PRODUCTO,
				K_CLASE_PRODUCTO	= @PP_K_CLASE_PRODUCTO	
		WHERE	K_TIPO_PRODUCTO=@PP_K_TIPO_PRODUCTO

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================


-- ========================================== #1, 'GAS LP',	'GAS'
EXECUTE [dbo].[PG_CI_TIPO_PRODUCTO] 0, 0,  1, 'CARBURACION',	'CAR', 1, '', 1, 1
EXECUTE [dbo].[PG_CI_TIPO_PRODUCTO] 0, 0,  2, 'ESTACIONARIO',	'EST', 1, '', 1, 1
EXECUTE [dbo].[PG_CI_TIPO_PRODUCTO] 0, 0,  3, 'PORTATIL',		'POR', 1, '', 1, 1
-- ========================================== #2, 'PRODUCTOS',	'PRO'
EXECUTE [dbo].[PG_CI_TIPO_PRODUCTO] 0, 0,  4, 'PRODUCTOS',		'PROD', 1, '', 1, 1
-- ========================================== #3, 'SERVICIOS',	'SER'
EXECUTE [dbo].[PG_CI_TIPO_PRODUCTO] 0, 0,  5, 'SERVICIOS',		'SERV', 1, '', 1, 1

GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================



-- //////////////////////////////////////////////////////////////
-- // ESTATUS_PRODUCTO
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTATUS_PRODUCTO] (
	[K_ESTATUS_PRODUCTO]	[INT] NOT NULL,
	[D_ESTATUS_PRODUCTO]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_PRODUCTO]	[VARCHAR] (10) NOT NULL,
	[O_ESTATUS_PRODUCTO]	[INT] NOT NULL,
	[C_ESTATUS_PRODUCTO]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_PRODUCTO]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_PRODUCTO]
	ADD CONSTRAINT [PK_ESTATUS_PRODUCTO]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_PRODUCTO])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_PRODUCTO_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_PRODUCTO] ( [D_ESTATUS_PRODUCTO] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_PRODUCTO] ADD 
	CONSTRAINT [FK_ESTATUS_PRODUCTO_01] 
		FOREIGN KEY ( [L_ESTATUS_PRODUCTO] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_PRODUCTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_PRODUCTO]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_PRODUCTO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_ESTATUS_PRODUCTO		INT,
	@PP_D_ESTATUS_PRODUCTO		VARCHAR(100),
	@PP_S_ESTATUS_PRODUCTO		VARCHAR(10),
	@PP_O_ESTATUS_PRODUCTO		INT,
	@PP_C_ESTATUS_PRODUCTO		VARCHAR(255),
	@PP_L_ESTATUS_PRODUCTO		INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTATUS_PRODUCTO
							FROM	ESTATUS_PRODUCTO
							WHERE	K_ESTATUS_PRODUCTO=@PP_K_ESTATUS_PRODUCTO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_PRODUCTO	
			(	K_ESTATUS_PRODUCTO,				D_ESTATUS_PRODUCTO, 
				S_ESTATUS_PRODUCTO,				O_ESTATUS_PRODUCTO,
				C_ESTATUS_PRODUCTO,
				L_ESTATUS_PRODUCTO				)		
		VALUES	
			(	@PP_K_ESTATUS_PRODUCTO,			@PP_D_ESTATUS_PRODUCTO,	
				@PP_S_ESTATUS_PRODUCTO,			@PP_O_ESTATUS_PRODUCTO,
				@PP_C_ESTATUS_PRODUCTO,
				@PP_L_ESTATUS_PRODUCTO			)
	ELSE
		UPDATE	ESTATUS_PRODUCTO
		SET		D_ESTATUS_PRODUCTO	= @PP_D_ESTATUS_PRODUCTO,	
				S_ESTATUS_PRODUCTO	= @PP_S_ESTATUS_PRODUCTO,			
				O_ESTATUS_PRODUCTO	= @PP_O_ESTATUS_PRODUCTO,
				C_ESTATUS_PRODUCTO	= @PP_C_ESTATUS_PRODUCTO,
				L_ESTATUS_PRODUCTO	= @PP_L_ESTATUS_PRODUCTO	
		WHERE	K_ESTATUS_PRODUCTO=@PP_K_ESTATUS_PRODUCTO

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_PRODUCTO] 0, 0, 0, 'INACTIVO','INACT', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_PRODUCTO] 0, 0, 1, 'ACTIVO','ACTVO', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================







-- //////////////////////////////////////////////////////////////
-- // PRODUCTO
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[PRODUCTO] (
	[K_PRODUCTO]				[INT]			NOT NULL,
	[D_PRODUCTO]				[VARCHAR](100)	NOT NULL,
	[S_PRODUCTO]				[VARCHAR](10)	NOT NULL,
	[O_PRODUCTO]				[INT]			NOT NULL,
	-- ============================	
	[K_ESTATUS_PRODUCTO]		[INT]			NOT NULL,
	[K_TIPO_PRODUCTO]			[INT]			NOT NULL,
	-- ================
	[K_UNIDAD]					[INT]			NOT NULL	DEFAULT 1,
	[CANTIDAD]					DECIMAL(19,4)	NOT NULL	DEFAULT 0,
	[FACTOR_KILOS]				DECIMAL(19,4)	NOT NULL	DEFAULT 1,
	[FACTOR_LITROS]				DECIMAL(19,4)	NOT NULL	DEFAULT 1,
	[CANTIDAD_KILOS]			DECIMAL(19,4)	NOT NULL	DEFAULT 0,		-- [CANTIDAD_KILOS] = [CANTIDAD] X [FACTOR_KILOS]				DECIMAL(19,8)	NOT NULL	DEFAULT 1,
	[CANTIDAD_LITROS]			DECIMAL(19,4)	NOT NULL	DEFAULT 0		-- [CANTIDAD_LITROS] = [CANTIDAD] X [FACTOR_LITROS]	
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[PRODUCTO]
	ADD CONSTRAINT [PK_PRODUCTO]
		PRIMARY KEY CLUSTERED ([K_PRODUCTO])
GO


ALTER TABLE [dbo].[PRODUCTO] ADD 
	CONSTRAINT [FK_PRODUCTO_01]  
		FOREIGN KEY ([K_ESTATUS_PRODUCTO]) 
		REFERENCES [dbo].[ESTATUS_PRODUCTO] ([K_ESTATUS_PRODUCTO]),
	CONSTRAINT [FK_PRODUCTO_02]  
		FOREIGN KEY ([K_TIPO_PRODUCTO]) 
		REFERENCES [dbo].[TIPO_PRODUCTO] ([K_TIPO_PRODUCTO]),
	CONSTRAINT [FK_PRODUCTO_03]  
		FOREIGN KEY ([K_UNIDAD]) 
		REFERENCES [dbo].[UNIDAD] ([K_UNIDAD])
GO


-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[PRODUCTO] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[PRODUCTO] ADD 
	CONSTRAINT [FK_PRODUCTO_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_PRODUCTO_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_PRODUCTO_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO



/* 

CARGA INICIAL PRODUCTOS

		PORT  // GAS LP X KILO
		ESTA // GAS LP X LITRO
		CARB // GAS LP X LITRO

*/


-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
