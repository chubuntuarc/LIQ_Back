-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			DETALLE_DETALLE_PRELIQUIDACION 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].DETALLE_PRELIQUIDACION]') AND type in (N'U'))
	DROP TABLE [dbo].[DETALLE_PRELIQUIDACION]
GO




-- //////////////////////////////////////////////////////////////
-- // DETALLE_PRELIQUIDACION
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[DETALLE_PRELIQUIDACION] (
	[K_DETALLE_PRELIQUIDACION]		[INT]			NOT NULL,
	-- ============================	
	[K_PRELIQUIDACION]				[INT]			NOT NULL,
	[K_PRODUCTO]					[INT]			NOT NULL,
	-- ============================		
	[LECTURA_INICIAL]				[DECIMAL](19,4)	NOT NULL,
	[LECTURA_FINAL]					[DECIMAL](19,4)	NOT NULL,
	[PESO_INICIAL]					[DECIMAL](19,4)	NOT NULL,
	[PESO_FINAL]					[DECIMAL](19,4)	NOT NULL,
	[NIVEL_INICIAL]					[INT]			NOT NULL,
	[NIVEL_FINAL]					[INT]			NOT NULL,
	[CARBURACION_INICIAL]			[DECIMAL](19,4)	NOT NULL,
	[CARBURACION_FINAL]				[DECIMAL](19,4)	NOT NULL,
	[TANQUE_INICIAL]				[INT]			NOT NULL,
	[TANQUE_FINAL]					[INT]			NOT NULL
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[DETALLE_PRELIQUIDACION]
	ADD CONSTRAINT [PK_DETALLE_PRELIQUIDACION]
		PRIMARY KEY CLUSTERED ([K_DETALLE_PRELIQUIDACION])
GO

-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[DETALLE_PRELIQUIDACION] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[DETALLE_PRELIQUIDACION] ADD 
	CONSTRAINT [FK_DETALLE_PRELIQUIDACION_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_DETALLE_PRELIQUIDACION_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_DETALLE_PRELIQUIDACION_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
