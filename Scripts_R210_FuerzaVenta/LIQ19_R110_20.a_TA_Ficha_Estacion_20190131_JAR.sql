-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			FICHA_ESTACION_CARBURACION 
-- // OPERACION:		LIBERACION / TABLAS 
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		JESUS ARCINIEGA
-- // FECHA:		22/MAR/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FICHA_ESTACION_CARBURACION]') AND type in (N'U'))
	DROP TABLE [dbo].[FICHA_ESTACION_CARBURACION]
GO





-- //////////////////////////////////////////////////////////////
-- // FICHA_ESTACION_CARBURACION
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[FICHA_ESTACION_CARBURACION] (
	[K_FICHA_ESTACION_CARBURACION]	[INT]			NOT NULL,
	-- ============================	
	[K_PUNTO_VENTA]						[INT]			NOT NULL,
	-- ============================		
	[LECTURA_INICIAL]					[INT]			NOT NULL,
	[LECTURA_FINAL]						[INT]			NOT NULL,
	[DIRECCION]							[VARCHAR](100)	NOT NULL,
	[CAPACIDAD]							[INT]			NOT NULL,
	[PORCENTAJE]						[VARCHAR](100)	NOT NULL,
	[K_MEDIDOR]							[INT]			NOT NULL,
	[K_TIPO_MEDIDOR]					[INT]			NOT NULL
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[FICHA_ESTACION_CARBURACION]
	ADD CONSTRAINT [PK_FICHA_ESTACION_CARBURACION]
		PRIMARY KEY CLUSTERED ([K_FICHA_ESTACION_CARBURACION])
GO

-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[FICHA_ESTACION_CARBURACION] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[FICHA_ESTACION_CARBURACION] ADD 
	CONSTRAINT [FK_FICHA_ESTACION_CARBURACION_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_FICHA_ESTACION_CARBURACION_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_FICHA_ESTACION_CARBURACION_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
