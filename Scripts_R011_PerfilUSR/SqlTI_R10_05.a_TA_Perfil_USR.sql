-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	ADG18_AdministradoraGas
-- // MODULO:			
-- // OPERACION:		LIBERACION // STORED PROCEDURE
-- ////////////////////////////////////////////////////////////// 

USE [ADG18_AdministradoraGas_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////

-- SELECT * FROM [SYS_PERFIL_ROL]


-- //////////////////////////////////////////////////////////////
-- // DROPS
-- //////////////////////////////////////////////////////////////



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_PERFIL_DEFINICION_ACCION]') AND type in (N'U'))
	DROP TABLE [dbo].[SYS_PERFIL_DEFINICION_ACCION]
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_PERFIL_DEFINICION]') AND type in (N'U'))
	DROP TABLE [dbo].[SYS_PERFIL_DEFINICION]
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_PERFIL_ROL]') AND type in (N'U'))
	DROP TABLE [dbo].[SYS_PERFIL_ROL]
GO





-- //////////////////////////////////////////////////////////////
-- // SYS_PERFIL_ROL
-- //////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[SYS_PERFIL_ROL] (
	[K_SYS_PERFIL_ROL]	[INT] NOT NULL,
	[D_SYS_PERFIL_ROL]	[VARCHAR] (100) NOT NULL,
	[S_SYS_PERFIL_ROL]	[VARCHAR] (10) NOT NULL,
	[O_SYS_PERFIL_ROL]	[INT] NOT NULL,
	[C_SYS_PERFIL_ROL]	[VARCHAR] (255) NOT NULL,
	[L_SYS_PERFIL_ROL]	[INT] NOT NULL
) ON [PRIMARY]
GO


-- //////////////////////////////////////////////////////////////


ALTER TABLE [dbo].[SYS_PERFIL_ROL]
	ADD CONSTRAINT [PK_SYS_PERFIL_ROL]
		PRIMARY KEY CLUSTERED ([K_SYS_PERFIL_ROL])
GO


CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_SYS_PERFIL_ROL_01_DESCRIPCION] 
	   ON [dbo].[SYS_PERFIL_ROL] ( [D_SYS_PERFIL_ROL] )
GO

-- //////////////////////////////////////////////////////////////

ALTER TABLE [dbo].[SYS_PERFIL_ROL] ADD 
	CONSTRAINT [FK_SYS_PERFIL_ROL_01] 
		FOREIGN KEY ( [L_SYS_PERFIL_ROL] ) 
		REFERENCES [dbo].[ESTATUS_ACTIVO] ( [K_ESTATUS_ACTIVO] )
GO


-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_SYS_PERFIL_ROL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_SYS_PERFIL_ROL]
GO


CREATE PROCEDURE [dbo].[PG_CI_SYS_PERFIL_ROL]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	-- ========================================
	@PP_K_SYS_PERFIL_ROL		INT,
	@PP_D_SYS_PERFIL_ROL		VARCHAR(100),
	@PP_S_SYS_PERFIL_ROL		VARCHAR(10),
	@PP_O_SYS_PERFIL_ROL		INT,
	@PP_C_SYS_PERFIL_ROL		VARCHAR(255),
	@PP_L_SYS_PERFIL_ROL		INT
AS
	-- ===============================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_SYS_PERFIL_ROL
							FROM	SYS_PERFIL_ROL
							WHERE	K_SYS_PERFIL_ROL=@PP_K_SYS_PERFIL_ROL

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO SYS_PERFIL_ROL
			(	K_SYS_PERFIL_ROL,			D_SYS_PERFIL_ROL, 
				S_SYS_PERFIL_ROL,			O_SYS_PERFIL_ROL,
				C_SYS_PERFIL_ROL,
				L_SYS_PERFIL_ROL			)		
		VALUES	
			(	@PP_K_SYS_PERFIL_ROL,		@PP_D_SYS_PERFIL_ROL,	
				@PP_S_SYS_PERFIL_ROL,		@PP_O_SYS_PERFIL_ROL,
				@PP_C_SYS_PERFIL_ROL,
				@PP_L_SYS_PERFIL_ROL		)
	ELSE
		UPDATE	SYS_PERFIL_ROL
		SET		D_SYS_PERFIL_ROL	= @PP_D_SYS_PERFIL_ROL,	
				S_SYS_PERFIL_ROL	= @PP_S_SYS_PERFIL_ROL,			
				O_SYS_PERFIL_ROL	= @PP_O_SYS_PERFIL_ROL,
				C_SYS_PERFIL_ROL	= @PP_C_SYS_PERFIL_ROL,
				L_SYS_PERFIL_ROL	= @PP_L_SYS_PERFIL_ROL	
		WHERE	K_SYS_PERFIL_ROL=@PP_K_SYS_PERFIL_ROL

	-- =========================================================
GO

-- //////////////////////////////////////////////////////////////





-- ===============================================
SET NOCOUNT ON
-- ===============================================
-- SELECT * FROM SYS_PERFIL_ROL

EXECUTE [dbo].[PG_CI_SYS_PERFIL_ROL] 0, 0,  0, 'NINGUNO',		'XXXX', 1, '', 1
EXECUTE [dbo].[PG_CI_SYS_PERFIL_ROL] 0, 0,  1, 'FULL CONTROL',	'FULL', 1, '', 1
EXECUTE [dbo].[PG_CI_SYS_PERFIL_ROL] 0, 0,  2, 'CORDINACION',	'CORD', 1, '', 1
EXECUTE [dbo].[PG_CI_SYS_PERFIL_ROL] 0, 0,  3, 'OPERACION',		'OPER', 1, '', 1
EXECUTE [dbo].[PG_CI_SYS_PERFIL_ROL] 0, 0,  4, 'CONSULTA',		'CONS', 1, '', 1
EXECUTE [dbo].[PG_CI_SYS_PERFIL_ROL] 0, 0,  5, 'ESPECIAL',		'XPEC', 1, '', 1
EXECUTE [dbo].[PG_CI_SYS_PERFIL_ROL] 0, 0,  6, 'GRID/EDIT',		'GRID', 1, '', 1
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================






-- ///////////////////////////////////////////////////////////////
-- // DATA_SISTEMA 							
-- ///////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[SYS_PERFIL_DEFINICION] (
	[K_SISTEMA]				[INT] NOT NULL,
	[K_USUARIO]				[INT] NOT NULL,
	[FO_NOMBRE]				VARCHAR(100) NOT NULL,
	-- ====================================
	[K_SYS_PERFIL_ROL]		[INT] NOT NULL,
	-- ====================================
	[L_BT_AGREGAR]			[INT] NOT NULL	DEFAULT  -1, 
	[L_BT_EDITAR]			[INT] NOT NULL	DEFAULT  -1, 
	[L_BT_CLONAR]			[INT] NOT NULL	DEFAULT  -1, 
	[L_BT_ELIMINAR]			[INT] NOT NULL	DEFAULT  -1, 
	-- ====================================
	[L_BT_GUARDAR]			[INT] NOT NULL	DEFAULT  -1, 
	[L_BT_CANCELAR]			[INT] NOT NULL	DEFAULT  -1, 
	-- ====================================
	[L_BT_EXPORTAR_EXCEL]	[INT] NOT NULL	DEFAULT  -1, 
	[L_BT_LISTADO]			[INT] NOT NULL	DEFAULT  -1, 
	[L_BT_LI_BUSCAR]		[INT] NOT NULL	DEFAULT  -1, 
) ON [PRIMARY]
GO

-- //////////////////////////////////////////////////////

ALTER TABLE [dbo].[SYS_PERFIL_DEFINICION]
	ADD CONSTRAINT [PK_SYS_PERFIL_DEFINICION]
		PRIMARY KEY CLUSTERED ([K_SISTEMA],[K_USUARIO],[FO_NOMBRE])
GO

/*

CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_DATA_SISTEMA_01_DESCRIPCION] 
	   ON [dbo].[DATA_SISTEMA] ( [D_DATA_SISTEMA] )
GO

*/


-- //////////////////////////////////////////////////////

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_SYS_PERFIL_DEFINICION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_SYS_PERFIL_DEFINICION]
GO


CREATE PROCEDURE [dbo].[PG_CI_SYS_PERFIL_DEFINICION]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_K_USUARIO_ACCION	INT,
	-- ========================================
	@PP_K_SYS_PERFIL_ROL	INT,
	@PP_FO_NOMBRE			VARCHAR(100)
	-- ========================================
AS

	DECLARE @VP_K_EXISTE	INT
/*
	SELECT	@VP_K_EXISTE =	K_SYS_SYS_PERFIL_DEFINICION
							FROM	SYS_SYS_PERFIL_DEFINICION
							WHERE	K_SYS_SYS_PERFIL_DEFINICION=@PP_K_SYS_SYS_PERFIL_DEFINICION
							*/
	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO SYS_PERFIL_DEFINICION
			(	K_SISTEMA, 
				K_USUARIO,				FO_NOMBRE,			K_SYS_PERFIL_ROL			)		
		VALUES	
			(	@PP_K_SISTEMA_EXE,	
				@PP_K_USUARIO_ACCION,	@PP_FO_NOMBRE,		@PP_K_SYS_PERFIL_ROL		)
	ELSE
		UPDATE	SYS_SYS_PERFIL_DEFINICION
		SET		FO_NOMBRE			= @PP_FO_NOMBRE,	
				K_SYS_PERFIL_ROL	= @PP_K_SYS_PERFIL_ROL
		WHERE	K_SISTEMA_EXE=@PP_K_SISTEMA_EXE
		AND		FO_NOMBRE=@PP_FO_NOMBRE
		AND		K_USUARIO_ACCION=@PP_K_USUARIO_ACCION

	-- =========================================================
GO





-- //////////////////////////////////////////////////////////////
-- // CARGA INICIAL
-- //////////////////////////////////////////////////////////////


-- K_SYS_PERFIL_ROL = #0 NINGUNO | #1 FULL CONTROL | #2 CORDINACION | #3 OPERACION | #4 CONSULTA

-- SELECT * FROM SYS_PERFIL_DEFINICION


-- ===============================================
SET NOCOUNT ON
-- ===============================================

EXECUTE [dbo].[PG_CI_SYS_PERFIL_DEFINICION]	0,0,0,	0, 'FO_PRODUCTO'
EXECUTE [dbo].[PG_CI_SYS_PERFIL_DEFINICION]	0,0,0,	2, 'FO_TASA_IMPUESTO'
EXECUTE [dbo].[PG_CI_SYS_PERFIL_DEFINICION]	0,0,0,	1, 'FO_PRECIO'
-- ===================================
EXECUTE [dbo].[PG_CI_SYS_PERFIL_DEFINICION]	0,0,0,	3, 'FO_SITIO'
EXECUTE [dbo].[PG_CI_SYS_PERFIL_DEFINICION]	0,0,0,	4, 'FO_CLIENTE'
EXECUTE [dbo].[PG_CI_SYS_PERFIL_DEFINICION]	0,0,0,	1, 'FO_CARGO'
EXECUTE [dbo].[PG_CI_SYS_PERFIL_DEFINICION]	0,0,0,	2, 'FO_CONDICION_COMERCIAL'
-- ===================================

EXECUTE [dbo].[PG_CI_SYS_PERFIL_DEFINICION]	0,0,0,	0, 'FO_ADMINISTRADOR'
-- ===================================
EXECUTE [dbo].[PG_CI_SYS_PERFIL_DEFINICION]	0,0,0,	3, 'FO_ALMACEN_SITIO'
-- ===================================

GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- ///////////////////////////////////////////////////////////////
-- // [SYS_PERFIL_DEFINICION_ACCION] 							
-- ///////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[SYS_PERFIL_DEFINICION_ACCION] (
	[K_SISTEMA]			[INT] NOT NULL,
	[K_USUARIO]			[INT] NOT NULL,
	[FO_NOMBRE]			VARCHAR(100) NOT NULL,
	[D_BOTON]			VARCHAR(200) NOT NULL,
	-- ====================================
	[L_VISIBLE]			[INT] NOT NULL	DEFAULT  1, 
	[L_ACTIVO]			[INT] NOT NULL	DEFAULT  1
) ON [PRIMARY]
GO



-- //////////////////////////////////////////////////////



ALTER TABLE [dbo].[SYS_PERFIL_DEFINICION_ACCION]
	ADD CONSTRAINT [PK_SYS_PERFIL_DEFINICION_ACCION]
		PRIMARY KEY CLUSTERED ([K_SISTEMA],[K_USUARIO],[FO_NOMBRE],[D_BOTON])
GO



-- ////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////


