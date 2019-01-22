-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			PRODUCTO / DETALLE_LIQUIDACION 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DETALLE_LIQUIDACION]') AND type in (N'U'))
	DROP TABLE [dbo].[DETALLE_LIQUIDACION]
GO



-- //////////////////////////////////////////////////////////////
-- // DETALLE_LIQUIDACION
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[DETALLE_LIQUIDACION] (
	[K_DETALLE_LIQUIDACION]				[INT]			NOT NULL,
	[D_DETALLE_LIQUIDACION]				[VARCHAR](100)	NOT NULL,
	[S_DETALLE_LIQUIDACION]				[VARCHAR](10)	NOT NULL,
	[O_DETALLE_LIQUIDACION]				[INT]			NOT NULL,
	-- ============================	
	[K_LIQUIDACION]						[INT]			NOT NULL,
	-- ============================		
	[TOTAL_CREDITO]						[DECIMAL](19,4)		NOT NULL,
	[TOTAL_VALE_GAS]					[DECIMAL](19,4)		NOT NULL,
	[TOTAL_EFECTIVO]					[DECIMAL](19,4)		NOT NULL
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[DETALLE_LIQUIDACION]
	ADD CONSTRAINT [PK_DETALLE_LIQUIDACION]
		PRIMARY KEY CLUSTERED ([K_DETALLE_LIQUIDACION])
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[DETALLE_LIQUIDACION] ADD 
	CONSTRAINT [FK_LIQUIDACION_01]  
		FOREIGN KEY ([K_LIQUIDACION]) 
		REFERENCES [dbo].[LIQUIDACION] ([K_LIQUIDACION])
GO



-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[DETALLE_LIQUIDACION] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[DETALLE_LIQUIDACION] ADD 
	CONSTRAINT [FK_DETALLE_LIQUIDACION_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_DETALLE_LIQUIDACION_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_DETALLE_LIQUIDACION_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
