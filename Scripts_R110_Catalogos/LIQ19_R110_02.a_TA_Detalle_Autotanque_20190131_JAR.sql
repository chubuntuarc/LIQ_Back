-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			DETALLE_AUTOTANQUE 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DETALLE_AUTOTANQUE]') AND type in (N'U'))
	DROP TABLE [dbo].[DETALLE_AUTOTANQUE]
GO





-- //////////////////////////////////////////////////////////////
-- // DETALLE_AUTOTANQUE
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[DETALLE_AUTOTANQUE] (
	[K_DETALLE_AUTOTANQUE]				[INT]			NOT NULL,
	-- ============================	
	[K_PUNTO_VENTA]						[INT]			NOT NULL,
	-- ============================		
	[LECTURA_INICIAL]					[INT]			NOT NULL,
	[LECTURA_FINAL]						[INT]			NOT NULL,
	[MATRICULA]							[VARCHAR](100)	NOT NULL,
	[MARCA]								[VARCHAR](100)	NOT NULL,
	[MODELO]							[VARCHAR](100)	NOT NULL,
	[KILOMETRAJE]						[DECIMAL](19,4)	NOT NULL,
	[SERIE]								[VARCHAR](100)	NOT NULL,
	[CAPACIDAD]							[INT]			NOT NULL,
	[PORCENTAJE]						[VARCHAR](100)	NOT NULL,
	[MEDIDOR]							[VARCHAR](100)	NOT NULL,
	[TIPO_MEDIDOR]						[VARCHAR](100)	NOT NULL
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[DETALLE_AUTOTANQUE]
	ADD CONSTRAINT [PK_DETALLE_AUTOTANQUE]
		PRIMARY KEY CLUSTERED ([K_DETALLE_AUTOTANQUE])
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[DETALLE_AUTOTANQUE] ADD 
	CONSTRAINT [FK_DETALLE_AUTOTANQUE_01]  
		FOREIGN KEY ([K_PUNTO_VENTA]) 
		REFERENCES [dbo].[PUNTO_VENTA] ([K_PUNTO_VENTA])
GO


-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[DETALLE_AUTOTANQUE] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[DETALLE_AUTOTANQUE] ADD 
	CONSTRAINT [FK_DETALLE_AUTOTANQUE_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_DETALLE_AUTOTANQUE_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_DETALLE_AUTOTANQUE_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
