-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	PYF18_Planeacion
-- // MODULO:			
-- // OPERACION:		LIBERACION / TABLA+CARGA 
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		JESUS ARCINIEGA
-- // FECHA:		13/MAR/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SUBMENU]') AND type in (N'U'))
	DROP TABLE [dbo].[SUBMENU]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MENU]') AND type in (N'U'))
	DROP TABLE [dbo].[MENU]
GO







-- //////////////////////////////////////////////////////////////
-- // MENU
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[MENU] (
	[K_MENU]	[INT] NOT NULL,
	[D_MENU]	[VARCHAR] (100) NOT NULL,
	[S_MENU]	[VARCHAR] (10) NOT NULL,
	[O_MENU]	[INT] NOT NULL,
	[C_MENU]	[VARCHAR] (255) NOT NULL,
	[L_MENU]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[MENU]
	ADD CONSTRAINT [PK_MENU]
		PRIMARY KEY CLUSTERED ([K_MENU])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_MENU_01_DESCRIPCION] 
	   ON [dbo].[MENU] ( [D_MENU] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[MENU] ADD 
	CONSTRAINT [FK_MENU_01] 
		FOREIGN KEY ( [L_MENU] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_MENU]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_MENU]
GO


CREATE PROCEDURE [dbo].[PG_CI_MENU]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_MENU		INT,
	@PP_D_MENU		VARCHAR(100),
	@PP_S_MENU		VARCHAR(10),
	@PP_O_MENU		INT,
	@PP_C_MENU		VARCHAR(255),
	@PP_L_MENU		INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_MENU
							FROM	MENU
							WHERE	K_MENU=@PP_K_MENU

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO MENU
			(	K_MENU,			D_MENU, 
				S_MENU,			O_MENU,
				C_MENU,
				L_MENU			)		
		VALUES	
			(	@PP_K_MENU,		@PP_D_MENU,	
				@PP_S_MENU,		@PP_O_MENU,
				@PP_C_MENU,
				@PP_L_MENU		)
	ELSE
		UPDATE	MENU
		SET		D_MENU	= @PP_D_MENU,	
				S_MENU	= @PP_S_MENU,			
				O_MENU	= @PP_O_MENU,
				C_MENU	= @PP_C_MENU,
				L_MENU	= @PP_L_MENU	
		WHERE	K_MENU=@PP_K_MENU

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////





-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_MENU] 0, 0,  1, 'SUBMENU_1', 'SUB1', 0, '', 1
EXECUTE [dbo].[PG_CI_MENU] 0, 0,  2, 'SUBMENU_2', 'SUB2', 1, '', 1
EXECUTE [dbo].[PG_CI_MENU] 0, 0,  3, 'SUBMENU_3', 'SUB3', 2, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================







-- //////////////////////////////////////////////////////////////
-- // SUBMENU
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[SUBMENU] (
	[K_SUBMENU]			[INT] NOT NULL,
	-- ============================	
	[K_MENU]			[INT] NOT NULL,
	-- ============================	
	[D_SUBMENU]			[VARCHAR] (100) NOT NULL,
	[S_SUBMENU]			[VARCHAR] (10) NOT NULL,
	[O_SUBMENU]			[INT] NOT NULL,
	[C_SUBMENU]			[VARCHAR] (255) NOT NULL,
	[L_SUBMENU]			[INT] NOT NULL,
	-- ============================	
	[TITULO_SUBMENU]	[VARCHAR](100) NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[SUBMENU]
	ADD CONSTRAINT [PK_SUBMENU]
		PRIMARY KEY CLUSTERED ([K_SUBMENU])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_SUBMENU_01_DESCRIPCION] 
	   ON [dbo].[SUBMENU] ( [D_SUBMENU] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[SUBMENU] ADD 
	CONSTRAINT [FK_SUBMENU_01] 
		FOREIGN KEY ( [K_MENU] ) 
		REFERENCES [dbo].[MENU] ( [K_MENU] ),
	CONSTRAINT [FK_SUBMENU_02] 
		FOREIGN KEY ( [L_SUBMENU] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_SUBMENU]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_SUBMENU]
GO


CREATE PROCEDURE [dbo].[PG_CI_SUBMENU]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_SUBMENU				INT,
	-- ============================	
	@PP_K_MENU					INT,
	-- ============================	
	@PP_D_SUBMENU				VARCHAR(100),
	@PP_S_SUBMENU				VARCHAR(10),
	@PP_O_SUBMENU				INT,
	@PP_C_SUBMENU				VARCHAR(255),
	@PP_L_SUBMENU				INT,
	-- ============================	
	@PP_TITULO_SUBMENU			VARCHAR(100)
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_SUBMENU
							FROM	SUBMENU
							WHERE	K_SUBMENU=@PP_K_SUBMENU

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO SUBMENU
			(	K_SUBMENU,			L_SUBMENU, 
				K_MENU,				D_SUBMENU,
				S_SUBMENU,			O_SUBMENU,
				C_SUBMENU,			TITULO_SUBMENU )		
		VALUES	
			(	@PP_K_SUBMENU,		@PP_L_SUBMENU,	
				@PP_K_MENU,			@PP_D_SUBMENU,
				@PP_S_SUBMENU,		@PP_O_SUBMENU,
				@PP_C_SUBMENU,		@PP_TITULO_SUBMENU )
	ELSE
		UPDATE	SUBMENU
		SET		D_SUBMENU			= @PP_D_SUBMENU,	
				S_SUBMENU			= @PP_S_SUBMENU,			
				O_SUBMENU			= @PP_O_SUBMENU,
				C_SUBMENU			= @PP_C_SUBMENU,
				L_SUBMENU			= @PP_L_SUBMENU,	
				TITULO_SUBMENU		= @PP_TITULO_SUBMENU	
		WHERE	K_SUBMENU=@PP_K_SUBMENU

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////





-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_SUBMENU] 0, 0,  1, 1, 'PRODUCTO',			'PRODUCTO', 1, '', 1, 'Productos'
EXECUTE [dbo].[PG_CI_SUBMENU] 0, 0,  2, 1, 'OPERADOR',			'OPE', 1, '', 1, 'Operadores'
EXECUTE [dbo].[PG_CI_SUBMENU] 0, 0,  3, 1, 'FICHA_AUTOTANQUE',	'AUT', 1, '', 1, 'Puntos de venta | Autotanque'
EXECUTE [dbo].[PG_CI_SUBMENU] 0, 0,  4, 1, 'FICHA_ESTACION_CARBURACION',	'EST', 1, '', 1, 'Puntos de venta | Estación de carburación'
EXECUTE [dbo].[PG_CI_SUBMENU] 0, 0,  5, 1, 'FICHA_PORTATIL',	'POR', 1, '', 1, 'Puntos de venta | Portatil'
EXECUTE [dbo].[PG_CI_SUBMENU] 0, 0,  6, 1, 'RUTA_REPARTO',		'RUT', 1, '', 1, 'Rutas de reparto'
--EXECUTE [dbo].[PG_CI_SUBMENU] 0, 0,  6, 1, 'PRELIQUIDACION',	'PRE', 1, '', 1, 'Preliquidaciones'

EXECUTE [dbo].[PG_CI_SUBMENU] 0, 0,  7, 2, 'SUB_1',				'SU1', 1, '', 1, 'SUB2_1'
EXECUTE [dbo].[PG_CI_SUBMENU] 0, 0,  8, 2, 'SUB_2',				'SU2', 1, '', 1, 'SUB2_2'
GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================




