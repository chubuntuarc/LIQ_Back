-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			ADG18_R100_10.a_TA_Sitio_Usuario_X_UO
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	ADG18_AdministradoraGas
-- // MODULO:			USUARIO_X_UO 
-- // OPERACION:		LIBERACION / TABLAS 
-- ////////////////////////////////////////////////////////////// 
-- // AUTOR:		FRANCISCO ESTEBAN
-- // FECHA:		21/FEB/2019
-- ////////////////////////////////////////////////////////////// 

USE [ADG18_AdministradoraGas_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////

   



-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SITIO_USUARIO_X_UO]') AND type in (N'U'))
	DROP TABLE [dbo].[SITIO_USUARIO_X_UO]
GO


-- //////////////////////////////////////////////////////////////
-- // USUARIO_X_UO
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[SITIO_USUARIO_X_UO] (
	[K_USUARIO]				[INT]	NOT NULL,
	[K_UNIDAD_OPERATIVA]	[INT]	NOT NULL,
	[L_ACCESO]				[INT]	NOT NULL DEFAULT 0
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[SITIO_USUARIO_X_UO]
	ADD CONSTRAINT [PK_USUARIO_X_UO]
		PRIMARY KEY CLUSTERED ([K_USUARIO], [K_UNIDAD_OPERATIVA])
GO

-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[SITIO_USUARIO_X_UO] ADD 
	CONSTRAINT [FK_SITIO_USUARIO_X_UO]  
		FOREIGN KEY ([K_UNIDAD_OPERATIVA]) 
		REFERENCES [dbo].[UNIDAD_OPERATIVA] ([K_UNIDAD_OPERATIVA])
GO



ALTER TABLE [dbo].[SITIO_USUARIO_X_UO] ADD 
	CONSTRAINT [FK_SITIO_USUARIO_X_UO_01]  
		FOREIGN KEY ([K_USUARIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
	
GO


-- //////////////////////////////////////////////////////


ALTER TABLE [dbo].[SITIO_USUARIO_X_UO] 
	ADD		[K_USUARIO_ALTA]				[INT]		NOT NULL,
			[F_ALTA]						[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]				[INT]		NOT NULL,
			[F_CAMBIO]						[DATETIME]	NOT NULL,
			[L_BORRADO]						[INT]		NOT NULL,
			[K_USUARIO_BAJA]				[INT]		NULL,
			[F_BAJA]						[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[SITIO_USUARIO_X_UO] ADD 
	CONSTRAINT [FK_SITIO_USUARIO_X_UO_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_SITIO_USUARIO_X_UO_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_SITIO_USUARIO_X_UO_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
