-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			DETALLE_ESTACION_CARBURACION 
-- // OPERACION:		LIBERACION / TABLAS 
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		JESUS ARCINIEGA
-- // FECHA:		31/ENE/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DETALLE_ESTACION_CARBURACION]') AND type in (N'U'))
	DROP TABLE [dbo].[DETALLE_ESTACION_CARBURACION]
GO





-- //////////////////////////////////////////////////////////////
-- // DETALLE_ESTACION_CARBURACION
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[DETALLE_ESTACION_CARBURACION] (
	[K_DETALLE_ESTACION_CARBURACION]	[INT]			NOT NULL,
	-- ============================	
	[K_PUNTO_VENTA]						[INT]			NOT NULL,
	-- ============================		
	[LECTURA_INICIAL]					[INT]			NOT NULL,
	[LECTURA_FINAL]						[INT]			NOT NULL,
	[DIRECCION]							[VARCHAR](100)	NOT NULL,
	[CAPACIDAD]							[INT]			NOT NULL,
	[PORCENTAJE]						[VARCHAR](100)	NOT NULL,
	[MEDIDOR]							[VARCHAR](100)	NOT NULL,
	[TIPO_MEDIDOR]						[VARCHAR](100)	NOT NULL
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[DETALLE_ESTACION_CARBURACION]
	ADD CONSTRAINT [PK_DETALLE_ESTACION_CARBURACION]
		PRIMARY KEY CLUSTERED ([K_DETALLE_ESTACION_CARBURACION])
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[DETALLE_ESTACION_CARBURACION] ADD 
	CONSTRAINT [FK_DETALLE_ESTACION_CARBURACION_01]  
		FOREIGN KEY ([K_PUNTO_VENTA]) 
		REFERENCES [dbo].[PUNTO_VENTA] ([K_PUNTO_VENTA])
GO


-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[DETALLE_ESTACION_CARBURACION] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[DETALLE_ESTACION_CARBURACION] ADD 
	CONSTRAINT [FK_DETALLE_ESTACION_CARBURACION_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_DETALLE_ESTACION_CARBURACION_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_DETALLE_ESTACION_CARBURACION_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
