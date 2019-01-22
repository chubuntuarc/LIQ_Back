-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			PRODUCTO / PRECIO 
-- // OPERACION:		LIBERACION / TABLAS
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		JESUS ARCINIEGA
-- // FECHA:		22/ENE/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V0000_R0]  
GO

-- //////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CORTE_CAJA]') AND type in (N'U'))
	DROP TABLE [dbo].[CORTE_CAJA]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_CORTE_CAJA]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_CORTE_CAJA]
GO


-- //////////////////////////////////////////////////////////////
-- // ESTATUS_CORTE_CAJA
-- //////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[ESTATUS_CORTE_CAJA] (
	[K_ESTATUS_CORTE_CAJA]	[INT] NOT NULL,
	[D_ESTATUS_CORTE_CAJA]	[VARCHAR] (100) NOT NULL,
	[S_ESTATUS_CORTE_CAJA]	[VARCHAR] (10) NOT NULL,
	[O_ESTATUS_CORTE_CAJA]	[INT] NOT NULL,
	[C_ESTATUS_CORTE_CAJA]	[VARCHAR] (255) NOT NULL,
	[L_ESTATUS_CORTE_CAJA]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_CORTE_CAJA]
	ADD CONSTRAINT [PK_ESTATUS_CORTE_CAJA]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_CORTE_CAJA])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_ESTATUS_CORTE_CAJA_01_DESCRIPCION] 
	   ON [dbo].[ESTATUS_CORTE_CAJA] ( [D_ESTATUS_CORTE_CAJA] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[ESTATUS_CORTE_CAJA] ADD 
	CONSTRAINT [FK_ESTATUS_CORTE_CAJA_01] 
		FOREIGN KEY ( [L_ESTATUS_CORTE_CAJA] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_CORTE_CAJA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_CORTE_CAJA]
GO


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_CORTE_CAJA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ========================================
	@PP_K_ESTATUS_CORTE_CAJA		INT,
	@PP_D_ESTATUS_CORTE_CAJA		VARCHAR(100),
	@PP_S_ESTATUS_CORTE_CAJA		VARCHAR(10),
	@PP_O_ESTATUS_CORTE_CAJA		INT,
	@PP_C_ESTATUS_CORTE_CAJA		VARCHAR(255),
	@PP_L_ESTATUS_CORTE_CAJA		INT
AS
	
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_ESTATUS_CORTE_CAJA
							FROM	ESTATUS_CORTE_CAJA
							WHERE	K_ESTATUS_CORTE_CAJA=@PP_K_ESTATUS_CORTE_CAJA

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO ESTATUS_CORTE_CAJA	
			(	K_ESTATUS_CORTE_CAJA,				D_ESTATUS_CORTE_CAJA, 
				S_ESTATUS_CORTE_CAJA,				O_ESTATUS_CORTE_CAJA,
				C_ESTATUS_CORTE_CAJA,
				L_ESTATUS_CORTE_CAJA				)		
		VALUES	
			(	@PP_K_ESTATUS_CORTE_CAJA,			@PP_D_ESTATUS_CORTE_CAJA,	
				@PP_S_ESTATUS_CORTE_CAJA,			@PP_O_ESTATUS_CORTE_CAJA,
				@PP_C_ESTATUS_CORTE_CAJA,
				@PP_L_ESTATUS_CORTE_CAJA			)
	ELSE
		UPDATE	ESTATUS_CORTE_CAJA
		SET		D_ESTATUS_CORTE_CAJA	= @PP_D_ESTATUS_CORTE_CAJA,	
				S_ESTATUS_CORTE_CAJA	= @PP_S_ESTATUS_CORTE_CAJA,			
				O_ESTATUS_CORTE_CAJA	= @PP_O_ESTATUS_CORTE_CAJA,
				C_ESTATUS_CORTE_CAJA	= @PP_C_ESTATUS_CORTE_CAJA,
				L_ESTATUS_CORTE_CAJA	= @PP_L_ESTATUS_CORTE_CAJA	
		WHERE	K_ESTATUS_CORTE_CAJA	= @PP_K_ESTATUS_CORTE_CAJA

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////




-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_CORTE_CAJA] 0, 0, 0, 'INACTIVO','INACT', 1, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_CORTE_CAJA] 0, 0, 1, 'ACTIVO','ACTVO', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================







-- //////////////////////////////////////////////////////////////
-- // CORTE_CAJA
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[CORTE_CAJA] (
	[K_CORTE_CAJA]				[INT]			NOT NULL,
	[D_CORTE_CAJA]				[VARCHAR](100)	NOT NULL,
	[S_CORTE_CAJA]				[VARCHAR](10)	NOT NULL,
	[O_CORTE_CAJA]				[INT]			NOT NULL,
	-- ============================	
	[K_ESTATUS_CORTE_CAJA]		[INT]			NOT NULL,
	[K_CAJA]					[INT]			NOT NULL,
	-- ============================	
	[F_CORTE_CAJA]				[DATETIME]		NOT NULL,
	[IMPORTE]					[DECIMAL](19,4)	NOT NULL
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[CORTE_CAJA]
	ADD CONSTRAINT [PK_CORTE_CAJA]
		PRIMARY KEY CLUSTERED ([K_CORTE_CAJA])
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[CORTE_CAJA] ADD 
	CONSTRAINT [FK_CORTE_CAJA_01]  
		FOREIGN KEY ([K_ESTATUS_CORTE_CAJA]) 
		REFERENCES [dbo].[ESTATUS_CORTE_CAJA] ([K_ESTATUS_CORTE_CAJA]),
			CONSTRAINT [FK_CORTE_CAJA_02]  
				FOREIGN KEY ([K_CAJA]) 
				REFERENCES [dbo].[CAJA] ([K_CAJA])
GO



-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[CORTE_CAJA] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[CORTE_CAJA] ADD 
	CONSTRAINT [FK_PRECIO_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_PRECIO_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_PRECIO_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
