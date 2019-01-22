	-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			LIQUIDACION 
-- // OPERACION:		LIBERACION / TABLAS
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		JESUS ARCINIEGA REYNOSO
-- // FECHA:		22/ENE/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V0000_R0] 
GO

-- //////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LIQUIDACION]') AND type in (N'U'))
	DROP TABLE [dbo].[LIQUIDACION]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_LIQUIDACION]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_LIQUIDACION]
GO



-- //////////////////////////////////////////////////////////////
-- // ESTATUS_LIQUIDACION
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTATUS_LIQUIDACION] (
	[K_ESTATUS_LIQUIDACION]	[INT] NOT NULL,
	[D_ESTATUS_LIQUIDACION]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_LIQUIDACION]	[VARCHAR] (10) NOT NULL,
	[O_ESTATUS_LIQUIDACION]	[INT] NOT NULL,
	[C_ESTATUS_LIQUIDACION]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_LIQUIDACION]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_LIQUIDACION]
	ADD CONSTRAINT [PK_ESTATUS_LIQUIDACION]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_LIQUIDACION])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_LIQUIDACION_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_LIQUIDACION] ( [D_ESTATUS_LIQUIDACION] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_LIQUIDACION] ADD 
	CONSTRAINT [FK_ESTATUS_LIQUIDACION_01] 
		FOREIGN KEY ( [L_ESTATUS_LIQUIDACION] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_LIQUIDACION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_LIQUIDACION]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_LIQUIDACION]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_ESTATUS_LIQUIDACION		INT,
	@PP_D_ESTATUS_LIQUIDACION		VARCHAR(100),
	@PP_S_ESTATUS_LIQUIDACION		VARCHAR(10),
	@PP_O_ESTATUS_LIQUIDACION		INT,
	@PP_C_ESTATUS_LIQUIDACION		VARCHAR(255),
	@PP_L_ESTATUS_LIQUIDACION		INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTATUS_LIQUIDACION
							FROM	ESTATUS_LIQUIDACION
							WHERE	K_ESTATUS_LIQUIDACION=@PP_K_ESTATUS_LIQUIDACION

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_LIQUIDACION	
			(	K_ESTATUS_LIQUIDACION,				D_ESTATUS_LIQUIDACION, 
				S_ESTATUS_LIQUIDACION,				O_ESTATUS_LIQUIDACION,
				C_ESTATUS_LIQUIDACION,
				L_ESTATUS_LIQUIDACION				)		
		VALUES	
			(	@PP_K_ESTATUS_LIQUIDACION,			@PP_D_ESTATUS_LIQUIDACION,	
				@PP_S_ESTATUS_LIQUIDACION,			@PP_O_ESTATUS_LIQUIDACION,
				@PP_C_ESTATUS_LIQUIDACION,
				@PP_L_ESTATUS_LIQUIDACION			)
	ELSE
		UPDATE	ESTATUS_LIQUIDACION
		SET		D_ESTATUS_LIQUIDACION	= @PP_D_ESTATUS_LIQUIDACION,	
				S_ESTATUS_LIQUIDACION	= @PP_S_ESTATUS_LIQUIDACION,			
				O_ESTATUS_LIQUIDACION	= @PP_O_ESTATUS_LIQUIDACION,
				C_ESTATUS_LIQUIDACION	= @PP_C_ESTATUS_LIQUIDACION,
				L_ESTATUS_LIQUIDACION	= @PP_L_ESTATUS_LIQUIDACION	
		WHERE	K_ESTATUS_LIQUIDACION=@PP_K_ESTATUS_LIQUIDACION

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_LIQUIDACION] 0, 0, 0, 'INACTIVO','INACT', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_LIQUIDACION] 0, 0, 1, 'ACTIVO','ACTVO', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================







-- //////////////////////////////////////////////////////////////
-- // LIQUIDACION
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[LIQUIDACION] (
	[K_LIQUIDACION]				[INT]			NOT NULL,
	[D_LIQUIDACION]				[VARCHAR](100)	NOT NULL,
	[S_LIQUIDACION]				[VARCHAR](10)	NOT NULL,
	[O_LIQUIDACION]				[INT]			NOT NULL,
	-- ============================	
	[K_ESTATUS_LIQUIDACION]		[INT]			NOT NULL,
	[K_PRELIQUIDACION]			[INT]			NOT NULL,	
	-- ================
	[SUBTOTAL_LIQUIDACION]		[DECIMAL](19,4)	NOT NULL,
	[IVA_LIQUIDACION]			[DECIMAL](19,4)	NOT NULL,
	[TOTAL_LIQUIDACION]			[DECIMAL](19,4)	NOT NULL
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[LIQUIDACION]
	ADD CONSTRAINT [PK_LIQUIDACION]
		PRIMARY KEY CLUSTERED ([K_LIQUIDACION])
GO


ALTER TABLE [dbo].[LIQUIDACION] ADD 
	CONSTRAINT [FK_LIQUIDACION_01]  
		FOREIGN KEY ([K_ESTATUS_LIQUIDACION]) 
		REFERENCES [dbo].[ESTATUS_LIQUIDACION] ([K_ESTATUS_LIQUIDACION]),
	CONSTRAINT [FK_LIQUIDACION_02]  
		FOREIGN KEY ([K_TIPO_LIQUIDACION]) 
		REFERENCES [dbo].[TIPO_LIQUIDACION] ([K_TIPO_LIQUIDACION]),
	CONSTRAINT [FK_LIQUIDACION_03]  
		FOREIGN KEY ([K_PRELIQUIDACION]) 
		REFERENCES [dbo].[PRELIQUIDACION] ([K_PRELIQUIDACION])
GO


-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[LIQUIDACION] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[LIQUIDACION] ADD 
	CONSTRAINT [FK_LIQUIDACION_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_LIQUIDACION_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_LIQUIDACION_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
