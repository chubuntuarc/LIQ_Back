-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	CYC19_Credito_y_Cobranza
-- // MÓDULO:			CATÁLOGOS / REMISIÓN_CYC
-- // OPERACIÓN:		LIBERACIÓN / TABLAS
-- ////////////////////////////////////////////////////////////// 
-- // Autor:				DANIEL PORTILLO ROMERO
-- // Fecha creación:		30/ENE/2019
-- // Modificador:			DANIEL PORTILLO ROMERO 
-- // Fecha modificación:	06/FEB/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[REMISION_LIQ]') AND type in (N'U'))
	DROP TABLE [dbo].[REMISION_LIQ]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_REMISION_CYC]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_REMISION_CYC]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ESTATUS_REMISION_LIQ]') AND type in (N'U'))
	DROP TABLE [dbo].[ESTATUS_REMISION_LIQ]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_TRANSACCION]') AND type in (N'U'))
	DROP TABLE [dbo].[TIPO_TRANSACCION]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ORIGEN_REMISION]') AND type in (N'U'))
	DROP TABLE [dbo].[ORIGEN_REMISION]
GO


-- //////////////////////////////////////////////////////////////
--	//						ORIGEN_REMISION 	
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[ORIGEN_REMISION] (
	[K_ORIGEN_REMISION]	INT				NOT NULL,
	[D_ORIGEN_REMISION]	VARCHAR (100)	NOT NULL,
	[S_ORIGEN_REMISION]	VARCHAR (10)	NOT NULL,
	[O_ORIGEN_REMISION]	INT				NOT NULL,
	[C_ORIGEN_REMISION]	VARCHAR (255)	NOT NULL,
	[L_ORIGEN_REMISION]	INT				NOT NULL	
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[ORIGEN_REMISION]
	ADD CONSTRAINT [PK_ORIGEN_REMISION]
		PRIMARY KEY CLUSTERED ([K_ORIGEN_REMISION])
GO

-- //////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ORIGEN_REMISION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ORIGEN_REMISION]
GO


-- //////////////////////////////////////////////////////////////
-- //					CI - ORIGEN_REMISION
-- //////////////////////////////////////////////////////////////


CREATE PROCEDURE [dbo].[PG_CI_ORIGEN_REMISION]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ===================================
	@PP_K_ORIGEN_REMISION	INT,
	@PP_D_ORIGEN_REMISION	VARCHAR(100),
	@PP_S_ORIGEN_REMISION	VARCHAR(10),
	@PP_O_ORIGEN_REMISION	INT,
	@PP_C_ORIGEN_REMISION	VARCHAR(255),
	@PP_L_ORIGEN_REMISION	INT
AS

	INSERT INTO ORIGEN_REMISION
		(	K_ORIGEN_REMISION,			D_ORIGEN_REMISION, 
			S_ORIGEN_REMISION,			O_ORIGEN_REMISION,
			C_ORIGEN_REMISION,
			L_ORIGEN_REMISION				)
	VALUES	
		(	@PP_K_ORIGEN_REMISION,		@PP_D_ORIGEN_REMISION,	
			@PP_S_ORIGEN_REMISION,		@PP_O_ORIGEN_REMISION,
			@PP_C_ORIGEN_REMISION,
			@PP_L_ORIGEN_REMISION			)

	-- ==============================================
GO


-- ///////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ORIGEN_REMISION] 0, 0, 1, 'POR LIQUIDACIÓN',	'XLIQUI', 10, '', 1
EXECUTE [dbo].[PG_CI_ORIGEN_REMISION] 0, 0, 2, 'CAPTURA MANUAL',	'MANUAL', 20, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================


-- //////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////
--	//						TIPO_TRANSACCION 	
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[TIPO_TRANSACCION] (
	[K_TIPO_TRANSACCION]	INT				NOT NULL,
	[D_TIPO_TRANSACCION]	VARCHAR (100)	NOT NULL,
	[S_TIPO_TRANSACCION]	VARCHAR (10)	NOT NULL,
	[O_TIPO_TRANSACCION]	INT				NOT NULL,
	[C_TIPO_TRANSACCION]	VARCHAR (255)	NOT NULL,
	[L_TIPO_TRANSACCION]	INT				NOT NULL	
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[TIPO_TRANSACCION]
	ADD CONSTRAINT [PK_TIPO_TRANSACCION]
		PRIMARY KEY CLUSTERED ([K_TIPO_TRANSACCION])
GO

-- //////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIPO_TRANSACCION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIPO_TRANSACCION]
GO


-- //////////////////////////////////////////////////////////////
-- //					CI - TIPO_TRANSACCION
-- //////////////////////////////////////////////////////////////


CREATE PROCEDURE [dbo].[PG_CI_TIPO_TRANSACCION]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ===================================
	@PP_K_TIPO_TRANSACCION	INT,
	@PP_D_TIPO_TRANSACCION	VARCHAR(100),
	@PP_S_TIPO_TRANSACCION	VARCHAR(10),
	@PP_O_TIPO_TRANSACCION	INT,
	@PP_C_TIPO_TRANSACCION	VARCHAR(255),
	@PP_L_TIPO_TRANSACCION	INT
AS

	INSERT INTO TIPO_TRANSACCION
		(	K_TIPO_TRANSACCION,			D_TIPO_TRANSACCION, 
			S_TIPO_TRANSACCION,			O_TIPO_TRANSACCION,
			C_TIPO_TRANSACCION,
			L_TIPO_TRANSACCION				)
	VALUES	
		(	@PP_K_TIPO_TRANSACCION,		@PP_D_TIPO_TRANSACCION,	
			@PP_S_TIPO_TRANSACCION,		@PP_O_TIPO_TRANSACCION,
			@PP_C_TIPO_TRANSACCION,
			@PP_L_TIPO_TRANSACCION			)

	-- ==============================================
GO


-- ///////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_TIPO_TRANSACCION] 0, 0, 1, 'VENTA CONTADO',		'VTACONT', 10, '', 1
EXECUTE [dbo].[PG_CI_TIPO_TRANSACCION] 0, 0, 2, 'VENTA CRÉDITO',		'VTACRED', 20, '', 1
EXECUTE [dbo].[PG_CI_TIPO_TRANSACCION] 0, 0, 3, 'VENTA COMISIONISTA',	'VTACOMI', 30, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================


-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- //						ESTATUS_REMISION_LIQ 	
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[ESTATUS_REMISION_LIQ] (
	[K_ESTATUS_REMISION_LIQ]		INT				NOT NULL,
	[D_ESTATUS_REMISION_LIQ]		VARCHAR (100)	NOT NULL,
	[S_ESTATUS_REMISION_LIQ]		VARCHAR (10)	NOT NULL,
	[O_ESTATUS_REMISION_LIQ]		INT				NOT NULL,
	[C_ESTATUS_REMISION_LIQ]		VARCHAR (255)	NOT NULL,
	[L_ESTATUS_REMISION_LIQ]		INT				NOT NULL	
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[ESTATUS_REMISION_LIQ]
	ADD CONSTRAINT [PK_ESTATUS_REMISION_LIQ]
		PRIMARY KEY CLUSTERED ([K_ESTATUS_REMISION_LIQ])
GO

-- //////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_REMISION_LIQ]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_REMISION_LIQ]
GO


-- //////////////////////////////////////////////////////////////
-- //					CI - ESTATUS_REMISION_LIQ
-- //////////////////////////////////////////////////////////////


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_REMISION_LIQ]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ===================================
	@PP_K_ESTATUS_REMISION_LIQ		INT,
	@PP_D_ESTATUS_REMISION_LIQ		VARCHAR(100),
	@PP_S_ESTATUS_REMISION_LIQ		VARCHAR(10),
	@PP_O_ESTATUS_REMISION_LIQ		INT,
	@PP_C_ESTATUS_REMISION_LIQ		VARCHAR(255),
	@PP_L_ESTATUS_REMISION_LIQ		INT
AS

	INSERT INTO ESTATUS_REMISION_LIQ
		(	K_ESTATUS_REMISION_LIQ,			D_ESTATUS_REMISION_LIQ, 
			S_ESTATUS_REMISION_LIQ,			O_ESTATUS_REMISION_LIQ,
			C_ESTATUS_REMISION_LIQ,
			L_ESTATUS_REMISION_LIQ				)
	VALUES	
		(	@PP_K_ESTATUS_REMISION_LIQ,		@PP_D_ESTATUS_REMISION_LIQ,	
			@PP_S_ESTATUS_REMISION_LIQ,		@PP_O_ESTATUS_REMISION_LIQ,
			@PP_C_ESTATUS_REMISION_LIQ,
			@PP_L_ESTATUS_REMISION_LIQ			)

	-- ==============================================
GO


-- ///////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_REMISION_LIQ] 0, 0, 1, 'LIQ-PENDIENTE',	'PENDT',	10, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_REMISION_LIQ] 0, 0, 2, 'LIQ-AUTORIZADA',	'AUTRZ',	20, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_REMISION_LIQ] 0, 0, 3, 'LIQ-CANCELADA',	'CANCL',	30, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================


-- //////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////
-- //						ESTATUS_REMISION_LIQ 	
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[ESTATUS_REMISION_CYC] (
	[K_ESTATUS_REMISION_CYC]		INT				NOT NULL,
	[D_ESTATUS_REMISION_CYC]		VARCHAR (100)	NOT NULL,
	[S_ESTATUS_REMISION_CYC]		VARCHAR (10)	NOT NULL,
	[O_ESTATUS_REMISION_CYC]		INT				NOT NULL,
	[C_ESTATUS_REMISION_CYC]		VARCHAR (255)	NOT NULL,
	[L_ESTATUS_REMISION_CYC]		INT				NOT NULL	
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[ESTATUS_REMISION_CYC]
	ADD CONSTRAINT [PK_ESTATUS_REMISION_CYC]
		PRIMARY KEY CLUSTERED ( [K_ESTATUS_REMISION_CYC] )
GO

-- //////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_ESTATUS_REMISION_CYC]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_ESTATUS_REMISION_CYC]
GO



-- //////////////////////////////////////////////////////////////
-- // CI - ESTATUS_REMISION_CYC
-- //////////////////////////////////////////////////////////////


CREATE PROCEDURE [dbo].[PG_CI_ESTATUS_REMISION_CYC]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	-- ===================================
	@PP_K_ESTATUS_REMISION_CYC		INT,
	@PP_D_ESTATUS_REMISION_CYC		VARCHAR(100),
	@PP_S_ESTATUS_REMISION_CYC		VARCHAR(10),
	@PP_O_ESTATUS_REMISION_CYC		INT,
	@PP_C_ESTATUS_REMISION_CYC		VARCHAR(255),
	@PP_L_ESTATUS_REMISION_CYC		INT
AS

	INSERT INTO ESTATUS_REMISION_CYC
		(	K_ESTATUS_REMISION_CYC,			D_ESTATUS_REMISION_CYC, 
			S_ESTATUS_REMISION_CYC,			O_ESTATUS_REMISION_CYC,
			C_ESTATUS_REMISION_CYC,
			L_ESTATUS_REMISION_CYC				)
	VALUES	
		(	@PP_K_ESTATUS_REMISION_CYC,		@PP_D_ESTATUS_REMISION_CYC,	
			@PP_S_ESTATUS_REMISION_CYC,		@PP_O_ESTATUS_REMISION_CYC,
			@PP_C_ESTATUS_REMISION_CYC,
			@PP_L_ESTATUS_REMISION_CYC			)

	-- ==============================================
GO


-- ///////////////////////////////////////////////////////////////


-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_ESTATUS_REMISION_CYC] 0, 0, 1, 'CYC-PENDIENTE',	'PENDT',	10, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_REMISION_CYC] 0, 0, 2, 'CYC-AUTORIZADA',	'AUTRZ',	20, '', 1
EXECUTE [dbo].[PG_CI_ESTATUS_REMISION_CYC] 0, 0, 3, 'CYC-CANCELADA',	'CANCL',	30, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================


-- //////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////
-- // REMISION_LIQ
-- ////////////////////////////////////////////////////////////// 

CREATE TABLE [dbo].[REMISION_LIQ] (
	-- ===========================================	ID LOCAL / BD_CYC
	[K_UNIDAD_OPERATIVA]			INT				NOT NULL,		
	[K_LIQUIDACION]					INT				NOT NULL,	
	[K_REMISION_LIQ]				INT				NOT NULL,		
	-- ===========================================		
	[K_TIPO_TRANSACCION]			INT				NOT NULL,	--	#1 VENTA CONTADO // #2 VENTA CREDITO // .....#3 VENTA COMISIONISTA 
	[K_CLIENTE_TMK]					INT				NOT NULL,	--	CLIENTE DE LIQUIDACION // NUNCA CAMBIA	
	[K_ORIGEN_REMISION]				INT				NOT NULL,	--	#1 X LIQUIDACION // #2 CAPTURA MANUAL
	[SERIE_REMISION]				VARCHAR(20)		NOT NULL,	
	[FOLIO_REMISION]				VARCHAR(20)		NOT NULL,	
	[D_REMISION]					VARCHAR(255)	NOT NULL,	-- SERIE-FOLIO // EJEMPLO BIO-25415
	-- ===========================================
	[L_FACTURADO]					INT				NOT NULL,	
	[L_PAGADO]						INT				NOT NULL,	
	[C_REMISION]					VARCHAR(500)	NOT NULL,	-- TEXTO PARA FACTURAS
	-- ===========================================
	[F_REMISION_LIQ]				DATE			NOT NULL,	--  FECHA DE LIQUIDACION // NUNCA CAMBIA
	[K_CLIENTE_CYC_LIQ]				INT				NOT NULL,	--	CLIENTE DE LIQUIDACION // NUNCA CAMBIA	
	[K_ESTATUS_REMISION_LIQ]		INT				NOT NULL,	
	-- ===========================================		
	[F_REMISION_CYC]				DATE			NOT NULL,	--	VALOR ORIGINAL // [F_REMISION_LIQ]
	[K_CLIENTE_CYC_CYC]				INT				NOT NULL,	--	VALOR ORIGINAL // [K_CLIENTE_LIQ]
	[K_ESTATUS_REMISION_CYC]		INT				NOT NULL,	
	-- ===========================================	VENTA CREDITO					
	[K_CLIENTE_CYC_SUCURSAL]		INT				NOT NULL,	--	CLIENTE DE LIQUIDACION // NUNCA CAMBIA	
	[K_CONTRATO]					INT				NOT NULL,	--	CLIENTE DE LIQUIDACION // NUNCA CAMBIA	
	-- ===========================================	DESGLOSE VENTA					
	[K_PRODUCTO]					INT				NOT NULL,	
	[CANTIDAD]						DECIMAL(19, 4)	NOT NULL,	
	[PRECIO_POF]					DECIMAL(19, 4)	NOT NULL,	--	PRECIO OFICIAL CON IVA Y SIN DESCUENTO
	[TASA_IVA]						DECIMAL(19, 4)	NOT NULL,	--	0 a 1 // EJEMPLO 16% = 0.16	
	-- ===========================================	VENTA BRUTA
	[SUBTOTAL_REM_BRUTO]			DECIMAL(19, 4)	NOT NULL,	--	(2) TOTAL / ( 1+TASA_IVA )
	[IVA_REM_BRUTO]					DECIMAL(19, 4)	NOT NULL,	--	(3) TOTAL - SUBTOTAL
	[TOTAL_REM_BRUTO]				DECIMAL(19, 4)	NOT NULL,	--	(1) CANTIDAD X [PRECIO_POF]
	-- ===========================================	DESCUENTO
	[DESCUENTO_X_KG]				DECIMAL(19, 4)	NOT NULL,	--	PRECIO OFICIAL CON IVA Y SIN DESCUENTO
	[DESCUENTO_TOTAL]				DECIMAL(19, 4)	NOT NULL,	--	(1) CANTIDAD X [DESCUENTO_X_KG]
	-- ===========================================	VENTA NETA
	[SUBTOTAL_REM_NETO]				DECIMAL(19, 4)	NOT NULL,	--	(2) TOTAL / ( 1+TASA_IVA )
	[IVA_REM_NETO]					DECIMAL(19, 4)	NOT NULL,	--	(3) TOTAL - SUBTOTAL
	[TOTAL_REM_NETO]				DECIMAL(19, 4)	NOT NULL,	--	(1) [TOTAL_REM_BRUTO] - [DESCUENTO_TOTAL]
	-- ===========================================	METRICAS PRECIO/VENTA
	[CANTIDAD_KG]					DECIMAL(19, 4)	NOT NULL,	
	[CANTIDAD_LT]					DECIMAL(19, 4)	NOT NULL,	
	[PRECIO_BTO_KG]					DECIMAL(19, 4)	NOT NULL,	--	PRECIO UNITARIO BRUTO	
	[PRECIO_BTO_LT]					DECIMAL(19, 4)	NOT NULL,	--	PRECIO UNITARIO BRUTO		
	[PRECIO_NTO_KG]					DECIMAL(19, 4)	NOT NULL,	--	[TOTAL_REM_NETO] / CANTIDAD_KG
	[PRECIO_NTO_LT]					DECIMAL(19, 4)	NOT NULL	--	[TOTAL_REM_NETO] / CANTIDAD_LT
/*	
	[DESCUENTO]						DECIMAL(19, 4)	NOT NULL,	--	[dscto]								DECIMAL(10,6)	NOT NULL DEFAULT '0.000000',
	[SUBSIDIO]						DECIMAL(19, 4)	NOT NULL,	--	[subsidio]							DECIMAL(10,6)	NOT NULL DEFAULT '0.000000',
	[SALDO]							DECIMAL(19, 4)	NOT NULL,
	[D_REMISION]					VARCHAR(255)	NOT NULL,
	[C_REMISION]					VARCHAR(500)	NOT NULL,
	-- =================================
	[K_FOLIO_FISCAL]				INT				NOT NULL,	--	[idFolioF]							INT				NOT NULL DEFAULT '-1',
	[K_FORMA_PAGO_REMISION]			INT				NOT NULL,	--	[formaPago]							VARCHAR(15)		NOT NULL DEFAULT 'CONTADO',
--	[F_C]							DATETIME		NOT NULL,	--	[fechaC]							DATETIME		NOT NULL DEFAULT '2011-03-01 00:00:00',
	-- =================================
	[DESCUENTO]						DECIMAL(19, 4)	NOT NULL,	--	[dscto]								DECIMAL(10,6)	NOT NULL DEFAULT '0.000000',
	[SUBSIDIO]						DECIMAL(19, 4)	NOT NULL,	--	[subsidio]							DECIMAL(10,6)	NOT NULL DEFAULT '0.000000',
	[SALDO]							DECIMAL(19, 4)	NOT NULL

--	[producto]						VARCHAR(12)		NOT NULL DEFAULT 'ESTACIONARIO',
--	[sector]						DECIMAL(3,2)	DEFAULT NULL,
--	[sincro]						INT				NOT NULL DEFAULT '0'
*/
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[REMISION_LIQ]
	ADD CONSTRAINT [PK_REMISION_LIQ]
		PRIMARY KEY CLUSTERED ( [K_REMISION_LIQ] )
GO

--CREATE UNIQUE NONCLUSTERED 
--	INDEX [UN_REMISION_LIQ_01_BD_LIQ] 
--	   ON [dbo].[REMISION_LIQ] ( [K_UNIDAD_OPERATIVA], [K_REMISION_LIQ] )
--GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[REMISION_LIQ] ADD 
	CONSTRAINT [FK_REMISION_LIQ_01] 
		FOREIGN KEY ([K_ORIGEN_REMISION]) 
		REFERENCES [dbo].[ORIGEN_REMISION] ( [K_ORIGEN_REMISION] )
GO


ALTER TABLE [dbo].[REMISION_LIQ] ADD 
	CONSTRAINT [FK_REMISION_LIQ_02] 
		FOREIGN KEY ([K_CLIENTE_TMK]) 
		REFERENCES [dbo].[CLIENTE_TMK] ( [K_CLIENTE_TMK] )
GO


ALTER TABLE [dbo].[REMISION_LIQ] ADD 
	CONSTRAINT [FK_REMISION_LIQ_03] 
		FOREIGN KEY ([K_ESTATUS_REMISION_LIQ]) 
		REFERENCES [dbo].[ESTATUS_REMISION_LIQ] ([K_ESTATUS_REMISION_LIQ])
GO

ALTER TABLE [dbo].[REMISION_LIQ] ADD 
	CONSTRAINT [FK_REMISION_LIQ_04] 
		FOREIGN KEY ([K_UNIDAD_OPERATIVA]) 
		REFERENCES [dbo].[UNIDAD_OPERATIVA] ([K_UNIDAD_OPERATIVA])
GO

--ALTER TABLE [dbo].[REMISION_LIQ] ADD 
--	CONSTRAINT [FK_REMISION_LIQ_05] 
--		FOREIGN KEY ([K_CLIENTE_LIQ]) 
--		REFERENCES [dbo].[CLIENTE] ([K_CLIENTE])
--GO

ALTER TABLE [dbo].[REMISION_LIQ] ADD 
	CONSTRAINT [FK_REMISION_LIQ_06] 
		FOREIGN KEY ([K_TIPO_TRANSACCION]) 
		REFERENCES [dbo].[TIPO_TRANSACCION] ([K_TIPO_TRANSACCION])
GO

ALTER TABLE [dbo].[REMISION_LIQ] ADD 
	CONSTRAINT [FK_REMISION_LIQ_07] 
		FOREIGN KEY ([K_ESTATUS_REMISION_LIQ]) 
		REFERENCES [dbo].[ESTATUS_REMISION_LIQ] ([K_ESTATUS_REMISION_LIQ])
GO

ALTER TABLE [dbo].[REMISION_LIQ] ADD 
	CONSTRAINT [FK_REMISION_LIQ_08] 
		FOREIGN KEY ([K_PRODUCTO]) 
		REFERENCES [dbo].[PRODUCTO] ([K_PRODUCTO])
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[REMISION_LIQ] 
	ADD		[K_USUARIO_ALTA]		[INT]		NOT NULL,
			[F_ALTA]				[DATETIME]	NOT NULL,
			[K_USUARIO_CAMBIO]		[INT]		NOT NULL,
			[F_CAMBIO]				[DATETIME]	NOT NULL,
			[L_BORRADO]				[INT]		NOT NULL,
			[K_USUARIO_BAJA]		[INT]		NULL,
			[F_BAJA]				[DATETIME]	NULL;
GO


ALTER TABLE [dbo].[REMISION_LIQ] ADD 
	CONSTRAINT [FK_REMISION_LIQ_USUARIO_ALTA]  
		FOREIGN KEY ([K_USUARIO_ALTA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_REMISION_LIQ_USUARIO_CAMBIO]  
		FOREIGN KEY ([K_USUARIO_CAMBIO]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO]),
	CONSTRAINT [FK_REMISION_LIQ_USUARIO_BAJA]  
		FOREIGN KEY ([K_USUARIO_BAJA]) 
		REFERENCES [dbo].[USUARIO] ([K_USUARIO])
GO




-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////