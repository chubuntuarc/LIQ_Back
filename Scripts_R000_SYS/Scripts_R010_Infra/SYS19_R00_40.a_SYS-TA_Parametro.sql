-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	SYS19_BasicBD_20190319
-- // MODULO:			
-- // OPERACION:		LIBERACION // STORED PROCEDURE
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // DROPs 
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VALOR_PARAMETRO]') AND type in (N'U'))
	DROP TABLE [dbo].[VALOR_PARAMETRO] 
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AMBIENTE]') AND type in (N'U'))
	DROP TABLE [dbo].[AMBIENTE] 
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PARAMETRO]') AND type in (N'U'))
	DROP TABLE [dbo].[PARAMETRO] 
GO



/****************************************************************/
/*							PARAMETRO							*/
/****************************************************************/

CREATE TABLE [dbo].[PARAMETRO] (
	[K_PARAMETRO]	[INT] NOT NULL,
	[D_PARAMETRO]	[VARCHAR] (100) NOT NULL,
	[S_PARAMETRO]	[VARCHAR] (10) NOT NULL,
	[O_PARAMETRO]	[INT] NOT NULL,
	[C_PARAMETRO]	[VARCHAR] (255) NOT NULL,
	[L_PARAMETRO]	[INT] NOT NULL
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[PARAMETRO]
	ADD CONSTRAINT [PK_PARAMETRO]
		PRIMARY KEY CLUSTERED ([K_PARAMETRO])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_PARAMETRO_01_DESCRIPCION] 
	   ON [dbo].[PARAMETRO] ( [D_PARAMETRO] )
GO


ALTER TABLE [dbo].[PARAMETRO] ADD 
	CONSTRAINT [FK_PARAMETRO_01] 
		FOREIGN KEY ([L_PARAMETRO]) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ([K_ESTATUS_ACTIVO])
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_PARAMETRO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_PARAMETRO]
GO


CREATE PROCEDURE [dbo].[PG_CI_PARAMETRO]
	@PP_L_DEBUG			INT,
	@PP_K_SISTEMA_EXE	INT,
	@PP_K_PARAMETRO		INT,
	@PP_D_PARAMETRO		VARCHAR(100),
	@PP_S_PARAMETRO		VARCHAR(10),
	@PP_O_PARAMETRO		INT,
	@PP_C_PARAMETRO		VARCHAR(255),
	@PP_L_PARAMETRO		INT
AS

	INSERT INTO PARAMETRO
		(	K_PARAMETRO,			D_PARAMETRO, 
			S_PARAMETRO,			O_PARAMETRO,
			C_PARAMETRO,
			L_PARAMETRO				)
	VALUES	
		(	@PP_K_PARAMETRO,		@PP_D_PARAMETRO,	
			@PP_S_PARAMETRO,		@PP_O_PARAMETRO,
			@PP_C_PARAMETRO,
			@PP_L_PARAMETRO			)

	-- =============================================
GO


CREATE TABLE [dbo].[AMBIENTE] (
	[K_AMBIENTE]	[INT] NOT NULL,
	[D_AMBIENTE]	[VARCHAR] (100) NOT NULL,
	[S_AMBIENTE]	[VARCHAR] (10) NOT NULL,
	[O_AMBIENTE]	[INT] NOT NULL,
	[C_AMBIENTE]	[VARCHAR] (255) NOT NULL,
	[L_AMBIENTE]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[AMBIENTE]
	ADD CONSTRAINT [PK_AMBIENTE]
		PRIMARY KEY CLUSTERED ([K_AMBIENTE])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_AMBIENTE_01_DESCRIPCION] 
	   ON [dbo].[AMBIENTE] ( [D_AMBIENTE] )
GO


ALTER TABLE [dbo].[AMBIENTE] ADD 
	CONSTRAINT [FK_AMBIENTE_01] 
		FOREIGN KEY ( [L_AMBIENTE] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_AMBIENTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_AMBIENTE]
GO


CREATE PROCEDURE [dbo].[PG_CI_AMBIENTE]
	@PP_L_DEBUG			INT,
	@PP_K_SISTEMA_EXE	INT,
	@PP_K_AMBIENTE		INT,
	@PP_D_AMBIENTE		VARCHAR(100),
	@PP_S_AMBIENTE		VARCHAR(10),
	@PP_O_AMBIENTE		INT,
	@PP_C_AMBIENTE		VARCHAR(255),
	@PP_L_AMBIENTE		INT
AS
	
	INSERT INTO AMBIENTE
		(	K_AMBIENTE,			D_AMBIENTE, 
			S_AMBIENTE,			O_AMBIENTE,
			C_AMBIENTE,
			L_AMBIENTE			)		
	VALUES	
		(	@PP_K_AMBIENTE,		@PP_D_AMBIENTE,	
			@PP_S_AMBIENTE,		@PP_O_AMBIENTE,
			@PP_C_AMBIENTE,
			@PP_L_AMBIENTE		)

	-- =========================================================
GO



-- ===============================================
SET NOCOUNT ON
-- ===============================================


EXECUTE [dbo].[PG_CI_AMBIENTE]	0, 0, 00, 'NINGUNO',		'N/A',  00, 'NINGUNO', 1 
EXECUTE [dbo].[PG_CI_AMBIENTE]	0, 0, 01, 'PRODUCCION',		'PROD', 10, 'OPERACION PRODUCTIVO', 1 
EXECUTE [dbo].[PG_CI_AMBIENTE]	0, 0, 02, 'PERFORMANCE',	'PERF', 20, 'CLON PRODUCTIVO PARA TUNING', 1 
EXECUTE [dbo].[PG_CI_AMBIENTE]	0, 0, 03, 'UAT',			'UAT' , 30, 'PRUEBAS DE ACEPTACION USUARIO', 1 
EXECUTE [dbo].[PG_CI_AMBIENTE]	0, 0, 04, 'CERTIFICACION',	'CERT', 40, 'PRUEBAS CERTIFICACION', 1 
EXECUTE [dbo].[PG_CI_AMBIENTE]	0, 0, 05, 'LABORATORIO',	'LAB' , 50, 'REVISION PRELIMINAR', 1 
EXECUTE [dbo].[PG_CI_AMBIENTE]	0, 0, 06, 'UNITARIAS',		'UNIT', 60, 'PRUEBAS UNITARIAS / DESARROLLADOR', 1 
EXECUTE [dbo].[PG_CI_AMBIENTE]	0, 0, 07, 'DESARROLLO',		'DESA', 70, 'PROYECTOS / CODIFICACION', 1 
GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================




/****************************************************************/
/*						VALOR_PARAMETRO							*/
/****************************************************************/

CREATE TABLE [dbo].[VALOR_PARAMETRO] (
	[K_SISTEMA]							[INT] NOT NULL,	
	[K_VALOR_PARAMETRO]					[INT] NOT NULL,
	[D_VALOR_PARAMETRO]					[VARCHAR] (100) NOT NULL,
	[C_VALOR_PARAMETRO]					[VARCHAR] (255) NOT NULL,
	[K_AMBIENTE]						[INT] NOT NULL,	
	[K_PARAMETRO]						[INT] NOT NULL,	
	[VALOR_PARAMETRO_TXT_1]				[VARCHAR] (255) NOT NULL,
	[VALOR_PARAMETRO_TXT_2]				[VARCHAR] (255) NOT NULL,
	[VALOR_PARAMETRO_TXT_3]				[VARCHAR] (255) NOT NULL,
	[VALOR_PARAMETRO_INT_1]				[INT] NOT NULL,
	[VALOR_PARAMETRO_INT_2]				[INT] NOT NULL,
	[VALOR_PARAMETRO_INT_3]				[INT] NOT NULL,
	[VALOR_PARAMETRO_FLO_1]				[FLOAT] NOT NULL,
	[VALOR_PARAMETRO_FLO_2]				[FLOAT] NOT NULL,
	[VALOR_PARAMETRO_FLO_3]				[FLOAT] NOT NULL
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[VALOR_PARAMETRO]
	ADD CONSTRAINT [PK_VALOR_PARAMETRO]
		PRIMARY KEY CLUSTERED ([K_VALOR_PARAMETRO])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [IX_VALOR_PARAMETRO_01] 
	   ON [dbo].[VALOR_PARAMETRO] ( [K_SISTEMA], [K_AMBIENTE], [K_PARAMETRO] )
GO


	
ALTER TABLE [dbo].[VALOR_PARAMETRO] ADD 
	CONSTRAINT [FK_VALOR_PARAMETRO_01]  
		FOREIGN KEY ([K_SISTEMA]) 
		REFERENCES [dbo].[SISTEMA] ([K_SISTEMA]),
	CONSTRAINT [FK_VALOR_PARAMETRO_02]  
		FOREIGN KEY ([K_AMBIENTE]) 
		REFERENCES [dbo].[AMBIENTE] ([K_AMBIENTE]),
	CONSTRAINT [FK_VALOR_PARAMETRO_03]  
		FOREIGN KEY ([K_PARAMETRO]) 
		REFERENCES [dbo].[PARAMETRO] ([K_PARAMETRO])
GO



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_VALOR_PARAMETRO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_VALOR_PARAMETRO]
GO


CREATE PROCEDURE [dbo].[PG_CI_VALOR_PARAMETRO]
	@PP_L_DEBUG						[INT],
	@PP_K_SISTEMA_EXE				[INT],
	@PP_K_SISTEMA					[INT],
	@PP_K_VALOR_PARAMETRO			[INT],
	@PP_D_VALOR_PARAMETRO			[VARCHAR] (100),
	@PP_C_VALOR_PARAMETRO			[VARCHAR] (255),
	@PP_K_AMBIENTE					[INT],
	@PP_K_PARAMETRO					[INT],
	@PP_VALOR_PARAMETRO_TXT_1		[VARCHAR] (255),
	@PP_VALOR_PARAMETRO_TXT_2		[VARCHAR] (255),
	@PP_VALOR_PARAMETRO_TXT_3		[VARCHAR] (255),
	@PP_VALOR_PARAMETRO_INT_1		[INT],
	@PP_VALOR_PARAMETRO_INT_2		[INT],
	@PP_VALOR_PARAMETRO_INT_3		[INT],
	@PP_VALOR_PARAMETRO_FLO_1		[FLOAT],
	@PP_VALOR_PARAMETRO_FLO_2		[FLOAT],
	@PP_VALOR_PARAMETRO_FLO_3		[FLOAT]
AS

	INSERT INTO VALOR_PARAMETRO
		(	K_SISTEMA,
			K_VALOR_PARAMETRO,	D_VALOR_PARAMETRO, C_VALOR_PARAMETRO,
			K_AMBIENTE,			K_PARAMETRO,			
			VALOR_PARAMETRO_TXT_1, VALOR_PARAMETRO_TXT_2, VALOR_PARAMETRO_TXT_3,
			VALOR_PARAMETRO_INT_1, VALOR_PARAMETRO_INT_2, VALOR_PARAMETRO_INT_3,
			VALOR_PARAMETRO_FLO_1, VALOR_PARAMETRO_FLO_2, VALOR_PARAMETRO_FLO_3					)
	VALUES	
		(	@PP_K_SISTEMA,
			@PP_K_VALOR_PARAMETRO,	@PP_D_VALOR_PARAMETRO, @PP_C_VALOR_PARAMETRO,	
			@PP_K_AMBIENTE,			@PP_K_PARAMETRO,
			@PP_VALOR_PARAMETRO_TXT_1, @PP_VALOR_PARAMETRO_TXT_2, @PP_VALOR_PARAMETRO_TXT_3,
			@PP_VALOR_PARAMETRO_INT_1, @PP_VALOR_PARAMETRO_INT_2, @PP_VALOR_PARAMETRO_INT_3,
			@PP_VALOR_PARAMETRO_FLO_1, @PP_VALOR_PARAMETRO_FLO_2, @PP_VALOR_PARAMETRO_FLO_3		)

	-- =============================================
GO




-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////