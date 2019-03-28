-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	SYS19_BasicBD_20190325
-- // MODULO:			
-- // OPERACION:		LIBERACION / 
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
-- // DROPs 
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BITACORA_SYS]') AND type in (N'U'))
	DROP TABLE [dbo].[BITACORA_SYS] 
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CLASE_BITACORA_SYS]') AND type in (N'U'))
	DROP TABLE [dbo].[GRUPO_BITACORA_SYS] 
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CLASE_BITACORA_SYS]') AND type in (N'U'))
	DROP TABLE [dbo].[CLASE_BITACORA_SYS] 
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IMPORTANCIA_BITACORA_SYS]') AND type in (N'U'))
	DROP TABLE [dbo].[IMPORTANCIA_BITACORA_SYS] 
GO



/****************************************************************/
/*					IMPORTANCIA_BITACORA_SYS					*/
/****************************************************************/

CREATE TABLE [dbo].[IMPORTANCIA_BITACORA_SYS] (
	[K_IMPORTANCIA_BITACORA_SYS]	[INT] NOT NULL ,
	[D_IMPORTANCIA_BITACORA_SYS]	[VARCHAR] (100) NOT NULL,
	[S_IMPORTANCIA_BITACORA_SYS]	[VARCHAR] (10) NOT NULL,
	[O_IMPORTANCIA_BITACORA_SYS]	[INT] NOT NULL,
	[C_IMPORTANCIA_BITACORA_SYS]	[VARCHAR] (255) NOT NULL
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[IMPORTANCIA_BITACORA_SYS]
	ADD CONSTRAINT [PK_IMPORTANCIA_BITACORA_SYS]
	PRIMARY KEY CLUSTERED ( [K_IMPORTANCIA_BITACORA_SYS] )
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_IMPORTANCIA_BITACORA_SYS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_IMPORTANCIA_BITACORA_SYS]
GO


CREATE PROCEDURE [dbo].[PG_CI_IMPORTANCIA_BITACORA_SYS]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_IMPORTANCIA_BITACORA_SYS	INT,
	@PP_D_IMPORTANCIA_BITACORA_SYS	VARCHAR(100),
	@PP_S_IMPORTANCIA_BITACORA_SYS	VARCHAR(10),
	@PP_O_IMPORTANCIA_BITACORA_SYS	INT,
	@PP_C_IMPORTANCIA_BITACORA_SYS	VARCHAR(255)
AS

	INSERT INTO IMPORTANCIA_BITACORA_SYS
		(	K_IMPORTANCIA_BITACORA_SYS,			D_IMPORTANCIA_BITACORA_SYS, 
			S_IMPORTANCIA_BITACORA_SYS,			O_IMPORTANCIA_BITACORA_SYS,
			C_IMPORTANCIA_BITACORA_SYS			)
	VALUES	
		(	@PP_K_IMPORTANCIA_BITACORA_SYS,		@PP_D_IMPORTANCIA_BITACORA_SYS,	
			@PP_S_IMPORTANCIA_BITACORA_SYS,		@PP_O_IMPORTANCIA_BITACORA_SYS,
			@PP_C_IMPORTANCIA_BITACORA_SYS		)

GO




-- //////////////////////////////////////////////////////////////
-- // CARGA INICIAL
-- //////////////////////////////////////////////////////////////



-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_IMPORTANCIA_BITACORA_SYS]	0, 0, 0, 'NULA',		'NULA',  00, '' 
EXECUTE [dbo].[PG_CI_IMPORTANCIA_BITACORA_SYS] 	0, 0, 1, 'MUY BAJA',	'MYBJA', 10, '' 
EXECUTE [dbo].[PG_CI_IMPORTANCIA_BITACORA_SYS] 	0, 0, 2, 'BAJA',		'BAJA',  20, 'SELECT/SEEK' 
EXECUTE [dbo].[PG_CI_IMPORTANCIA_BITACORA_SYS] 	0, 0, 3, 'MODERADA',	'MODRD', 30, 'INSERT/UPDATE' 
EXECUTE [dbo].[PG_CI_IMPORTANCIA_BITACORA_SYS] 	0, 0, 4, 'ALTA',		'ALTA',  40, '' 
EXECUTE [dbo].[PG_CI_IMPORTANCIA_BITACORA_SYS] 	0, 0, 5, 'MUY ALTA',	'MYALT', 50, 'DELETE' 
EXECUTE [dbo].[PG_CI_IMPORTANCIA_BITACORA_SYS] 	0, 0, 6, 'CRITICA',		'CRITC', 60, '' 
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================




/****************************************************************/
/*						CLASE_BITACORA_SYS						*/
/****************************************************************/

CREATE TABLE [dbo].[CLASE_BITACORA_SYS] (
	[K_CLASE_BITACORA_SYS]	[INT] NOT NULL,
	[D_CLASE_BITACORA_SYS]	[VARCHAR] (100) NOT NULL,
	[S_CLASE_BITACORA_SYS]	[VARCHAR] (10) NOT NULL,
	[O_CLASE_BITACORA_SYS]	[INT] NOT NULL,
	[C_CLASE_BITACORA_SYS]	[VARCHAR] (255) NOT NULL
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[CLASE_BITACORA_SYS]
	ADD CONSTRAINT [PK_CLASE_BITACORA_SYS]
		PRIMARY KEY CLUSTERED ( [K_CLASE_BITACORA_SYS] )
GO



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_CLASE_BITACORA_SYS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_CLASE_BITACORA_SYS]
GO


CREATE PROCEDURE [dbo].[PG_CI_CLASE_BITACORA_SYS]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_CLASE_BITACORA_SYS	INT,
	@PP_D_CLASE_BITACORA_SYS	VARCHAR(100),
	@PP_S_CLASE_BITACORA_SYS	VARCHAR(10),
	@PP_O_CLASE_BITACORA_SYS	INT,
	@PP_C_CLASE_BITACORA_SYS	VARCHAR(255)
AS

	INSERT INTO CLASE_BITACORA_SYS
		(	K_CLASE_BITACORA_SYS,		D_CLASE_BITACORA_SYS, 
			S_CLASE_BITACORA_SYS,		O_CLASE_BITACORA_SYS,
			C_CLASE_BITACORA_SYS		)
	VALUES	
		(	@PP_K_CLASE_BITACORA_SYS,	@PP_D_CLASE_BITACORA_SYS,	
			@PP_S_CLASE_BITACORA_SYS,	@PP_O_CLASE_BITACORA_SYS,
			@PP_C_CLASE_BITACORA_SYS	)

GO




-- //////////////////////////////////////////////////////////////
-- // CARGA INICIAL
-- //////////////////////////////////////////////////////////////



-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_CLASE_BITACORA_SYS]	0, 0, 0, 'DEBUGEO',			'DEBUG', 20, '' 
EXECUTE [dbo].[PG_CI_CLASE_BITACORA_SYS]	0, 0, 1, 'NINGUNO',			'NINGN', 20, '' 
EXECUTE [dbo].[PG_CI_CLASE_BITACORA_SYS]	0, 0, 2, 'MONITOREO',		'MONIT', 10, '' 
EXECUTE [dbo].[PG_CI_CLASE_BITACORA_SYS]	0, 0, 3, 'AUTORIZACION',	'AUTRZ', 10, '' 
EXECUTE [dbo].[PG_CI_CLASE_BITACORA_SYS]	0, 0, 4, 'ALERTA',			'ALERT', 20, '' 
EXECUTE [dbo].[PG_CI_CLASE_BITACORA_SYS]	0, 0, 5, 'BD/SQL',			'SQLBD', 20, '' 
EXECUTE [dbo].[PG_CI_CLASE_BITACORA_SYS]	0, 0, 6, 'TRANSACCION/USR',	'TRANS', 20, '' 
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================





/****************************************************************/
/*						GRUPO_BITACORA_SYS						*/
/****************************************************************/

CREATE TABLE [dbo].[GRUPO_BITACORA_SYS] (
	[K_GRUPO_BITACORA_SYS]	[INT] NOT NULL,
	[D_GRUPO_BITACORA_SYS]	[VARCHAR] (100) NOT NULL,
	[S_GRUPO_BITACORA_SYS]	[VARCHAR] (10) NOT NULL,
	[O_GRUPO_BITACORA_SYS]	[INT] NOT NULL,
	[C_GRUPO_BITACORA_SYS]	[VARCHAR] (255) NOT NULL
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[GRUPO_BITACORA_SYS]
	ADD CONSTRAINT [PK_GRUPO_BITACORA_SYS]
		PRIMARY KEY CLUSTERED ( [K_GRUPO_BITACORA_SYS] )
GO



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_GRUPO_BITACORA_SYS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_GRUPO_BITACORA_SYS]
GO


CREATE PROCEDURE [dbo].[PG_CI_GRUPO_BITACORA_SYS]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_GRUPO_BITACORA_SYS	INT,
	@PP_D_GRUPO_BITACORA_SYS	VARCHAR(100),
	@PP_S_GRUPO_BITACORA_SYS	VARCHAR(10),
	@PP_O_GRUPO_BITACORA_SYS	INT,
	@PP_C_GRUPO_BITACORA_SYS	VARCHAR(255)
AS

	INSERT INTO GRUPO_BITACORA_SYS
		(	K_GRUPO_BITACORA_SYS,		D_GRUPO_BITACORA_SYS, 
			S_GRUPO_BITACORA_SYS,		O_GRUPO_BITACORA_SYS,
			C_GRUPO_BITACORA_SYS		)
	VALUES	
		(	@PP_K_GRUPO_BITACORA_SYS,	@PP_D_GRUPO_BITACORA_SYS,	
			@PP_S_GRUPO_BITACORA_SYS,	@PP_O_GRUPO_BITACORA_SYS,
			@PP_C_GRUPO_BITACORA_SYS	)

GO




-- //////////////////////////////////////////////////////////////
-- // CARGA INICIAL
-- //////////////////////////////////////////////////////////////



-- ===============================================
SET NOCOUNT ON
-- ===============================================


EXECUTE [dbo].[PG_CI_GRUPO_BITACORA_SYS] 0, 0, 1, 'BACKUP',		'BCKUP', 10, '' 
EXECUTE [dbo].[PG_CI_GRUPO_BITACORA_SYS] 0, 0, 2, 'GRUPO 2',	'GPO2',  20, '' 
EXECUTE [dbo].[PG_CI_GRUPO_BITACORA_SYS] 0, 0, 3, 'OPERACION',	'OPERA', 20, '' 
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================




/****************************************************************/
/*							BITACORA_SYS						*/
/****************************************************************/

CREATE TABLE [dbo].[BITACORA_SYS] (
	[K_SISTEMA]					[INT] NOT NULL,
	[K_BITACORA_SYS]			[INT] IDENTITY(1,1),
	[F_BITACORA_SYS]			[DATE] NOT NULL,
	[F_BITACORA_SYS_EVENTO]		[DATETIME] NOT NULL,
	[K_USUARIO]					[INT] NULL,
	-- ===========================================
	[K_CLASE_BITACORA_SYS]			[INT] NOT NULL,
	[K_IMPORTANCIA_BITACORA_SYS]	[INT] NOT NULL,	
	[K_GRUPO_BITACORA_SYS]			[INT] NOT NULL,	
	[D_BITACORA_SYS]				[VARCHAR] (100) NOT NULL,
	[C_BITACORA_SYS]				[VARCHAR] (1000) NOT NULL,
	-- ===========================================
	[STORED_PROCEDURE]			[VARCHAR] (100) NOT NULL,
	[K_FOLIO_1]					[INT] NULL,
	[K_FOLIO_2]					[INT] NULL,
	-- ===========================================
	[VALOR_1_INT]				[INT] NOT NULL,
	[VALOR_2_INT]				[INT] NOT NULL,	
	[VALOR_3_STR]				[VARCHAR] (100) NOT NULL,
	[VALOR_4_STR]				[VARCHAR] (100) NOT NULL,
	[VALOR_5_DEC]				DECIMAL(19,4) NOT NULL,
	[VALOR_6_DEC]				DECIMAL(19,4) NOT NULL,
	-- ===========================================
	[VALOR_1_DATO]				[VARCHAR] (20) NOT NULL,
	[VALOR_2_DATO]				[VARCHAR] (20) NOT NULL,
	[VALOR_3_DATO]				[VARCHAR] (20) NOT NULL,
	[VALOR_4_DATO]				[VARCHAR] (20) NOT NULL,
	[VALOR_5_DATO]				[VARCHAR] (20) NOT NULL,
	[VALOR_6_DATO]				[VARCHAR] (20) NOT NULL
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[BITACORA_SYS]
	ADD CONSTRAINT [PK_BITACORA_SYS]
		PRIMARY KEY CLUSTERED ( [K_SISTEMA], [K_BITACORA_SYS] )
GO

	
ALTER TABLE [dbo].[BITACORA_SYS] ADD 
	CONSTRAINT [FK_BITACORA_SYS_01]  
		FOREIGN KEY ( [K_SISTEMA] ) 
		REFERENCES [dbo].[SISTEMA] ( [K_SISTEMA] ),
	CONSTRAINT [FK_BITACORA_SYS_02]  
		FOREIGN KEY ( [K_IMPORTANCIA_BITACORA_SYS] ) 
		REFERENCES [dbo].[IMPORTANCIA_BITACORA_SYS] ( [K_IMPORTANCIA_BITACORA_SYS] ),
	CONSTRAINT [FK_BITACORA_SYS_03] 
		FOREIGN KEY ( [K_CLASE_BITACORA_SYS] ) 
		REFERENCES [dbo].[CLASE_BITACORA_SYS] ( [K_CLASE_BITACORA_SYS] ),
	CONSTRAINT [FK_BITACORA_SYS_04] 
		FOREIGN KEY ( [K_GRUPO_BITACORA_SYS] ) 
		REFERENCES [dbo].[GRUPO_BITACORA_SYS] ( [K_GRUPO_BITACORA_SYS] )
GO



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_BITACORA_SYS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_BITACORA_SYS]
GO


CREATE PROCEDURE [dbo].[PG_CI_BITACORA_SYS]
	@PP_L_DEBUG						[INT],
	@PP_K_SISTEMA_EXE				[INT],
	@PP_K_USUARIO					[INT],
	-- ===========================================
	@PP_K_CLASE_BITACORA_SYS		[INT],
	@PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
	@PP_K_GRUPO_BITACORA_SYS		[INT],
	@PP_D_BITACORA_SYS				[VARCHAR] (100),
	@PP_C_BITACORA_SYS				[VARCHAR] (100),
	-- ===========================================
	@PP_STORED_PROCEDURE			[VARCHAR] (100),
	@PP_K_FOLIO_1					[INT],
	@PP_K_FOLIO_2					[INT],
	-- ===========================================
	@PP_VALOR_1_INT					[INT],
	@PP_VALOR_2_INT					[INT],
	@PP_VALOR_3_STR					[VARCHAR] (100),
	@PP_VALOR_4_STR					[VARCHAR] (100),
	@PP_VALOR_5_DEC					DECIMAL(19,4),
	@PP_VALOR_6_DEC					DECIMAL(19,4),
	-- ===========================================
	@PP_VALOR_1_DATO				[VARCHAR] (20),
	@PP_VALOR_2_DATO				[VARCHAR] (20),
	@PP_VALOR_3_DATO				[VARCHAR] (20),
	@PP_VALOR_4_DATO				[VARCHAR] (20),
	@PP_VALOR_5_DATO				[VARCHAR] (20),
	@PP_VALOR_6_DATO				[VARCHAR] (20)
AS

	DECLARE @VP_F_BITACORA_SYS			[DATETIME] 
	
	SET @VP_F_BITACORA_SYS = GETDATE()

	-- ========================================

	INSERT INTO F_BITACORA_SYS
		(	K_SISTEMA,
			F_BITACORA_SYS, F_BITACORA_SYS_EVENTO,
			K_USUARIO,
			-- ===========================================
			K_CLASE_BITACORA_SYS, K_IMPORTANCIA_BITACORA_SYS, K_GRUPO_BITACORA_SYS,
			D_BITACORA_SYS, C_BITACORA_SYS,
			-- ===========================================
			STORED_PROCEDURE, K_FOLIO_1, K_FOLIO_2,
			-- ===========================================
			VALOR_1_INT,	VALOR_2_INT,
			VALOR_3_STR,	VALOR_4_STR,
			VALOR_5_DEC,	VALOR_6_DEC,
			-- ===========================================
			VALOR_1_DATO,	VALOR_2_DATO,
			VALOR_3_DATO,	VALOR_4_DATO,
			VALOR_5_DATO,	VALOR_6_DATO		)

	VALUES	
		(	@PP_K_SISTEMA_EXE,
			@VP_F_BITACORA_SYS, @VP_F_BITACORA_SYS, 
			@PP_K_USUARIO,
			-- ===========================================
			@PP_K_CLASE_BITACORA_SYS, @PP_K_IMPORTANCIA_BITACORA_SYS, @PP_K_GRUPO_BITACORA_SYS,
			@PP_D_BITACORA_SYS, @PP_C_BITACORA_SYS,
			-- ===========================================
			@PP_STORED_PROCEDURE, @PP_K_FOLIO_1, @PP_K_FOLIO_2,
			-- ===========================================
			@PP_VALOR_1_INT,	@PP_VALOR_2_INT,
			@PP_VALOR_3_STR,	@PP_VALOR_4_STR,
			@PP_VALOR_5_DEC,	@PP_VALOR_6_DEC,
			-- ===========================================
			@PP_VALOR_1_DATO,	@PP_VALOR_2_DATO,
			@PP_VALOR_3_DATO,	@PP_VALOR_4_DATO,
			@PP_VALOR_5_DATO,	@PP_VALOR_6_DATO		)

	-- ============================================
GO



-- //////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////
