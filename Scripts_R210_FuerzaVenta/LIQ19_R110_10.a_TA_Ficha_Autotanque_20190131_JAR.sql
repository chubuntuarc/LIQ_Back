-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			FICHA_AUTOTANQUE 
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FICHA_AUTOTANQUE]') AND type in (N'U'))
	DROP TABLE [dbo].[FICHA_AUTOTANQUE]
GO





-- //////////////////////////////////////////////////////////////
-- // FICHA_AUTOTANQUE
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[FICHA_AUTOTANQUE] (
	[K_FICHA_AUTOTANQUE]				[INT]			NOT NULL,
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
	[PORCENTAJE]						[VARCHAR](100)	NOT NULL
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[FICHA_AUTOTANQUE]
	ADD CONSTRAINT [PK_FICHA_AUTOTANQUE]
		PRIMARY KEY CLUSTERED ([K_FICHA_AUTOTANQUE])
GO

-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[FICHA_AUTOTANQUE] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[FICHA_AUTOTANQUE] ADD 
	CONSTRAINT [FK_FICHA_AUTOTANQUE_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_FICHA_AUTOTANQUE_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_FICHA_AUTOTANQUE_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
