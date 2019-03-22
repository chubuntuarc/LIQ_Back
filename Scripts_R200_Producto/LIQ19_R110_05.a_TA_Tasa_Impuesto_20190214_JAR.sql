-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_05.a_TA_Tasa_Impuesto
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CLIENTE / CONDICION COMERCIAL 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TASA_IMPUESTO]') AND type in (N'U'))
	DROP TABLE [dbo].[TASA_IMPUESTO]
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IMPUESTO]') AND type in (N'U'))
	DROP TABLE [dbo].[IMPUESTO]
GO





-- //////////////////////////////////////////////////////////////
-- // IMPUESTO
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[IMPUESTO] (
	[K_IMPUESTO]	[INT] NOT NULL,
	[D_IMPUESTO]	[VARCHAR] (100) NOT NULL,
	[S_IMPUESTO]	[VARCHAR] (10) NOT NULL,
	[O_IMPUESTO]	[INT] NOT NULL,
	[C_IMPUESTO]	[VARCHAR] (255) NOT NULL,
	[L_IMPUESTO]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[IMPUESTO]
	ADD CONSTRAINT [PK_IMPUESTO]
		PRIMARY KEY CLUSTERED ([K_IMPUESTO])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_IMPUESTO_01_DESCRIPCION] 
	   ON [dbo].[IMPUESTO] ( [D_IMPUESTO] )
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[IMPUESTO] ADD 
	CONSTRAINT [FK_IMPUESTO_01] 
		FOREIGN KEY ( [L_IMPUESTO] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO



-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_IMPUESTO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_IMPUESTO]
GO


CREATE PROCEDURE [dbo].[PG_CI_IMPUESTO]
	@PP_L_DEBUG								INT,
	@PP_K_SISTEMA_EXE						INT,
	-- ========================================
	@PP_K_IMPUESTO			INT,
	@PP_D_IMPUESTO			VARCHAR(100),
	@PP_S_IMPUESTO			VARCHAR(10),
	@PP_O_IMPUESTO			INT,
	@PP_C_IMPUESTO			VARCHAR(255),
	@PP_L_IMPUESTO			INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_IMPUESTO
							FROM	IMPUESTO
							WHERE	K_IMPUESTO=@PP_K_IMPUESTO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO IMPUESTO
			(	K_IMPUESTO,				D_IMPUESTO, 
				S_IMPUESTO,				O_IMPUESTO,
				C_IMPUESTO,
				L_IMPUESTO				)
		VALUES	
			(	@PP_K_IMPUESTO,			@PP_D_IMPUESTO,	
				@PP_S_IMPUESTO,			@PP_O_IMPUESTO,
				@PP_C_IMPUESTO,
				@PP_L_IMPUESTO	)
	ELSE
		UPDATE	IMPUESTO
		SET		D_IMPUESTO	= @PP_D_IMPUESTO,	
				S_IMPUESTO	= @PP_S_IMPUESTO,			
				O_IMPUESTO	= @PP_O_IMPUESTO,
				C_IMPUESTO	= @PP_C_IMPUESTO,
				L_IMPUESTO	= @PP_L_IMPUESTO	
		WHERE	K_IMPUESTO=@PP_K_IMPUESTO

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================


EXECUTE [dbo].[PG_CI_IMPUESTO] 0, 0,  1, 'IVA',			'IVA', 1, '', 1 
--EXECUTE [dbo].[PG_CI_IMPUESTO] 0, 0,  2, 'DESCUENTO',	'DESC', 1, '', 1
--EXECUTE [dbo].[PG_CI_IMPUESTO] 0, 0,  3, 'SUBSIDIO',	'SUBS', 1, '', 1
--EXECUTE [dbo].[PG_CI_IMPUESTO] 0, 0,  4, 'COMISION',	'COMI', 1, '', 1
GO
--SELECT * FROM IMPUESTO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- //////////////////////////////////////////////////////////////
-- // TASA_IMPUESTO
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[TASA_IMPUESTO] (
	[K_TASA_IMPUESTO]				[INT]		NOT NULL,
	-- ============================	
	[K_IMPUESTO]					[INT]		NOT NULL,
	-- ============================	
	[F_VIGENCIA_INICIO]				[DATE]		NOT NULL,
	[F_VIGENCIA_FIN]				[DATE]		NOT NULL,
	[VALOR_TASA_IMPUESTO]			[DECIMAL](19,4) NOT NULL	-- VALOR PORCENTAJE 12.5% = 0.125 (SE GUARDA COMO NUMERO ENTRE CERO Y UNO) // 1 EQUIVALE A 100%
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[TASA_IMPUESTO]
	ADD CONSTRAINT [PK_TASA_IMPUESTO]
		PRIMARY KEY CLUSTERED ([K_TASA_IMPUESTO])
GO

-- //////////////////////////////////////////////////////////////




ALTER TABLE [dbo].[TASA_IMPUESTO] ADD 
	CONSTRAINT [FK_TASA_IMPUESTO_05]  
		FOREIGN KEY ([K_IMPUESTO]) 
		REFERENCES [dbo].[IMPUESTO] ([K_IMPUESTO])
GO


-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[TASA_IMPUESTO] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO



ALTER TABLE [dbo].[TASA_IMPUESTO] ADD 
	CONSTRAINT [FK_TASA_IMPUESTO_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_TASA_IMPUESTO_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_TASA_IMPUESTO_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
