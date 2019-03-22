-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	TRA19
-- // MODULO:			OPERADOR
-- // OPERACION:		LIBERACION / TABLAS
-- //////////////////////////////////////////////////////////////
-- // Autor:					JESUS ARCINIEGA
-- // Fecha creación:	20/MAR/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OPERADOR]') AND type in (N'U'))
	DROP TABLE [dbo].[OPERADOR]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_OPERADOR]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_OPERADOR]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SEXO]') AND type in (N'U'))
	DROP TABLE [dbo].[SEXO]
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTADO_CIVIL]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTADO_CIVIL]
GO



-- //////////////////////////////////////////////////////////////
-- // ESTADO_CIVIL
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTADO_CIVIL] (
	[K_ESTADO_CIVIL]					[INT] NOT NULL,
	[D_ESTADO_CIVIL]					[VARCHAR] (100) NOT NULL,
	[S_ESTADO_CIVIL]					[VARCHAR] (10) NOT NULL,
	[O_ESTADO_CIVIL]					[INT] NOT NULL,
	[C_ESTADO_CIVIL]					[VARCHAR] (255) NOT NULL,
	[L_ESTADO_CIVIL]					[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTADO_CIVIL]
	ADD CONSTRAINT [PK_ESTADO_CIVIL]
		PRIMARY KEY CLUSTERED ([K_ESTADO_CIVIL])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTADO_CIVIL_01_DESCRIPCION] 
	   ON [dbo].[ESTADO_CIVIL] ( [D_ESTADO_CIVIL] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTADO_CIVIL] ADD 
	CONSTRAINT [FK_ESTADO_CIVIL_01] 
		FOREIGN KEY ( [L_ESTADO_CIVIL] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTADO_CIVIL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTADO_CIVIL]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTADO_CIVIL]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ========================================
	@PP_K_ESTADO_CIVIL				INT,
	@PP_D_ESTADO_CIVIL				VARCHAR(100),
	@PP_S_ESTADO_CIVIL				VARCHAR(10),
	@PP_O_ESTADO_CIVIL				INT,
	@PP_C_ESTADO_CIVIL				VARCHAR(255),
	@PP_L_ESTADO_CIVIL				INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTADO_CIVIL
							FROM	ESTADO_CIVIL
							WHERE	K_ESTADO_CIVIL=@PP_K_ESTADO_CIVIL

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTADO_CIVIL	
			(	K_ESTADO_CIVIL,				D_ESTADO_CIVIL, 
				S_ESTADO_CIVIL,				O_ESTADO_CIVIL,
				C_ESTADO_CIVIL,
				L_ESTADO_CIVIL				)		
		VALUES	
			(	@PP_K_ESTADO_CIVIL,			@PP_D_ESTADO_CIVIL,	
				@PP_S_ESTADO_CIVIL,			@PP_O_ESTADO_CIVIL,
				@PP_C_ESTADO_CIVIL,
				@PP_L_ESTADO_CIVIL			)
	ELSE
		UPDATE	ESTADO_CIVIL
		SET		D_ESTADO_CIVIL	= @PP_D_ESTADO_CIVIL,	
				S_ESTADO_CIVIL	= @PP_S_ESTADO_CIVIL,			
				O_ESTADO_CIVIL	= @PP_O_ESTADO_CIVIL,
				C_ESTADO_CIVIL	= @PP_C_ESTADO_CIVIL,
				L_ESTADO_CIVIL	= @PP_L_ESTADO_CIVIL	
		WHERE	K_ESTADO_CIVIL=@PP_K_ESTADO_CIVIL

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTADO_CIVIL] 0, 0, 0, 'SIN DEFINIR',		'?????', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTADO_CIVIL] 0, 0, 1, 'SOLTERO/A',		'SOLTE', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTADO_CIVIL] 0, 0, 2, 'CASADO/A',			'CASAD', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTADO_CIVIL] 0, 0, 3, 'UNION LIBRE',		'ULIBR', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTADO_CIVIL] 0, 0, 4, 'DIVORCIADO/A',		'DIVOR', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTADO_CIVIL] 0, 0, 5, 'VIUDO/A',			'VIUD@', 1, '', 1
GO
-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- //////////////////////////////////////////////////////////////
-- // SEXO
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[SEXO] (
	[K_SEXO]					[INT] NOT NULL,
	[D_SEXO]					[VARCHAR] (100) NOT NULL,
	[S_SEXO]					[VARCHAR] (10) NOT NULL,
	[O_SEXO]					[INT] NOT NULL,
	[C_SEXO]					[VARCHAR] (255) NOT NULL,
	[L_SEXO]					[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[SEXO]
	ADD CONSTRAINT [PK_SEXO]
		PRIMARY KEY CLUSTERED ([K_SEXO])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_SEXO_01_DESCRIPCION] 
	   ON [dbo].[SEXO] ( [D_SEXO] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[SEXO] ADD 
	CONSTRAINT [FK_SEXO_01] 
		FOREIGN KEY ( [L_SEXO] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_SEXO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_SEXO]
GO


CREATE PROCEDURE [dbo].[PG_CI_SEXO]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ========================================
	@PP_K_SEXO						INT,
	@PP_D_SEXO						VARCHAR(100),
	@PP_S_SEXO						VARCHAR(10),
	@PP_O_SEXO						INT,
	@PP_C_SEXO						VARCHAR(255),
	@PP_L_SEXO						INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_SEXO
							FROM	SEXO
							WHERE	K_SEXO=@PP_K_SEXO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO SEXO	
			(	K_SEXO,				D_SEXO, 
				S_SEXO,				O_SEXO,
				C_SEXO,
				L_SEXO				)		
		VALUES	
			(	@PP_K_SEXO,			@PP_D_SEXO,	
				@PP_S_SEXO,			@PP_O_SEXO,
				@PP_C_SEXO,
				@PP_L_SEXO			)
	ELSE
		UPDATE	SEXO
		SET		D_SEXO	= @PP_D_SEXO,	
				S_SEXO	= @PP_S_SEXO,			
				O_SEXO	= @PP_O_SEXO,
				C_SEXO	= @PP_C_SEXO,
				L_SEXO	= @PP_L_SEXO	
		WHERE	K_SEXO=@PP_K_SEXO

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_SEXO] 0, 0, 1, 'FEMENINO',			'FEMEN',  1, '', 1
EXECUTE [dbo].[PG_CI_SEXO] 0, 0, 2, 'MASCULINO',		'MASCUL', 1, '', 1
GO
-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- //////////////////////////////////////////////////////////////
-- // ESTATUS_OPERADOR
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTATUS_OPERADOR] (
	[K_ESTATUS_OPERADOR]	[INT] NOT NULL,
	[D_ESTATUS_OPERADOR]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_OPERADOR]	[VARCHAR] (10) NOT NULL,
	[O_ESTATUS_OPERADOR]	[INT] NOT NULL,
	[C_ESTATUS_OPERADOR]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_OPERADOR]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_OPERADOR]
	ADD CONSTRAINT [PK_ESTATUS_OPERADOR]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_OPERADOR])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_OPERADOR_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_OPERADOR] ( [D_ESTATUS_OPERADOR] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_OPERADOR] ADD 
	CONSTRAINT [FK_ESTATUS_OPERADOR_01] 
		FOREIGN KEY ( [L_ESTATUS_OPERADOR] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_OPERADOR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_OPERADOR]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_OPERADOR]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ========================================
	@PP_K_ESTATUS_OPERADOR			INT,
	@PP_D_ESTATUS_OPERADOR			VARCHAR(100),
	@PP_S_ESTATUS_OPERADOR			VARCHAR(10),
	@PP_O_ESTATUS_OPERADOR			INT,
	@PP_C_ESTATUS_OPERADOR			VARCHAR(255),
	@PP_L_ESTATUS_OPERADOR			INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTATUS_OPERADOR
							FROM	ESTATUS_OPERADOR
							WHERE	K_ESTATUS_OPERADOR=@PP_K_ESTATUS_OPERADOR

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_OPERADOR	
			(	K_ESTATUS_OPERADOR,				D_ESTATUS_OPERADOR, 
				S_ESTATUS_OPERADOR,				O_ESTATUS_OPERADOR,
				C_ESTATUS_OPERADOR,
				L_ESTATUS_OPERADOR				)		
		VALUES	
			(	@PP_K_ESTATUS_OPERADOR,			@PP_D_ESTATUS_OPERADOR,	
				@PP_S_ESTATUS_OPERADOR,			@PP_O_ESTATUS_OPERADOR,
				@PP_C_ESTATUS_OPERADOR,
				@PP_L_ESTATUS_OPERADOR			)
	ELSE
		UPDATE	ESTATUS_OPERADOR
		SET		D_ESTATUS_OPERADOR	= @PP_D_ESTATUS_OPERADOR,	
				S_ESTATUS_OPERADOR	= @PP_S_ESTATUS_OPERADOR,			
				O_ESTATUS_OPERADOR	= @PP_O_ESTATUS_OPERADOR,
				C_ESTATUS_OPERADOR	= @PP_C_ESTATUS_OPERADOR,
				L_ESTATUS_OPERADOR	= @PP_L_ESTATUS_OPERADOR	
		WHERE	K_ESTATUS_OPERADOR=@PP_K_ESTATUS_OPERADOR

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_OPERADOR] 0, 0, 0, 'SIN DEFINIR',	'?????', 1, '', 0
EXECUTE [dbo].[PG_CI_ESTATUS_OPERADOR] 0, 0, 1, 'ACTIVO',			'ACTIV', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_OPERADOR] 0, 0, 2, 'INACTIVO',		'INACT', 1, '', 0
GO
-- ===============================================
SET NOCOUNT OFF
-- ===============================================







-- //////////////////////////////////////////////////////////////
-- // OPERADOR
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[OPERADOR] (
	[K_OPERADOR]							[INT]			NOT NULL,
	[D_OPERADOR]							[VARCHAR](255)	NOT NULL,
	[C_OPERADOR]							[VARCHAR](500)	NOT NULL,
	[O_OPERADOR]							[INT]			NOT NULL,
    -- ============================
	[K_ESTATUS_OPERADOR]					[INT]			NOT NULL,
	[K_ESTADO_CIVIL]						[INT]			NOT NULL,
	[K_SEXO]								[INT]			NOT NULL,
    -- ============================
	[NOMBRE]								[VARCHAR](100)	NOT NULL, 
	[APELLIDO_PATERNO]						[VARCHAR](100)	NOT NULL, 
	[APELLIDO_MATERNO]						[VARCHAR](100)	NOT NULL,
	[RFC]									[VARCHAR](100)	NOT NULL, 
	[CURP]									[VARCHAR](100)	NOT NULL, 
	[NSS]									[VARCHAR](100)	NOT NULL,
	[F_NACIMIENTO]							[DATE]			NOT NULL,
	[F_INGRESO]								[DATE]			NOT NULL,
    -- ============================
	[TELEFONO]								[VARCHAR](100)	NOT NULL,
	[CORREO]								[VARCHAR](100)	NOT NULL,
	[CALLE]									[VARCHAR](100)	NOT NULL,
	[NUMERO_EXTERIOR]						[VARCHAR](100)	NOT NULL,
	[NUMERO_INTERIOR]						[VARCHAR](100)	NOT NULL,
	[COLONIA]								[VARCHAR](100)	NOT NULL,
	[CP]									[VARCHAR](100)  NOT NULL,
	[MUNICIPIO]								[VARCHAR](100)  NOT NULL,
    -- ============================
	[NUMERO_LICENCIA_OPERADOR]				[VARCHAR](100)	NOT NULL,
	[F_VIGENCIA_LICENCIA]					[DATE]			NOT NULL,
	[SALARIO_DIARIO]						[DECIMAL](10,4) NOT NULL,
	[SALARIO_DIARIO_INTEGRADO]				[DECIMAL](10,4) NOT NULL
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[OPERADOR]
	ADD CONSTRAINT [PK_OPERADOR]
		PRIMARY KEY CLUSTERED ([K_OPERADOR])
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[OPERADOR] ADD 
	CONSTRAINT [FK_OPERADOR_01]  
		FOREIGN KEY ([K_ESTATUS_OPERADOR]) 
		REFERENCES [dbo].[ESTATUS_OPERADOR] ([K_ESTATUS_OPERADOR]),
	CONSTRAINT [FK_OPERADOR_02]  
		FOREIGN KEY ([K_ESTADO_CIVIL]) 
		REFERENCES [dbo].[ESTADO_CIVIL] ([K_ESTADO_CIVIL])
GO


-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[OPERADOR] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[OPERADOR] ADD 
	CONSTRAINT [FK_OPERADOR_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_OPERADOR_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_OPERADOR_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO










-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
