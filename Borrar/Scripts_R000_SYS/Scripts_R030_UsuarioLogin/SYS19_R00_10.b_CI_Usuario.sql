-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	SYS19_BasicBD_20190319
-- // MODULO:			USUARIO
-- // OPERACION:		LIBERACION / TABLA+CARGA 
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_USUARIO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_USUARIO]
GO


CREATE PROCEDURE [dbo].[PG_CI_USUARIO]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- =========================== 
	@PP_K_USUARIO				INT,
	@PP_D_USUARIO				VARCHAR(100),
	@PP_C_USUARIO				VARCHAR(500),
	@PP_S_USUARIO				VARCHAR(10),
	@PP_O_USUARIO				INT,
	@PP_L_USUARIO				INT,
	-- =========================== 
	@PP_CORREO					VARCHAR(100),
	@PP_LOGIN_ID				VARCHAR(25),
	@PP_CONTRASENA				VARCHAR(25),
	@PP_F_CONTRASENA			DATE,
	@PP_K_ESTATUS_USUARIO		INT,
	@PP_K_TIPO_USUARIO			INT,
	@PP_K_PERSONAL_PREDEFINIDO	INT
AS

	-- ===========================

	DECLARE @VP_K_EXISTE	INT

	SELECT	@VP_K_EXISTE =	K_USUARIO
							FROM	USUARIO
							WHERE	K_USUARIO=@PP_K_USUARIO

	-- ===============================

	IF @VP_K_EXISTE IS NULL
		INSERT INTO USUARIO
			(	K_USUARIO,	D_USUARIO,	C_USUARIO,
				S_USUARIO,	O_USUARIO,	L_USUARIO,
				CORREO,		
				LOGIN_ID,	CONTRASENA,	F_CONTRASENA,
				K_ESTATUS_USUARIO,		K_TIPO_USUARIO,
				K_PERSONAL_PREDEFINIDO,
				-- ===========================
				[K_USUARIO_ALTA],		[F_ALTA],
 				[K_USUARIO_CAMBIO],		[F_CAMBIO],
				[L_BORRADO],			[K_USUARIO_BAJA],
				[F_BAJA]		)		
		VALUES	
			(	@PP_K_USUARIO,	@PP_D_USUARIO,	@PP_C_USUARIO,
				@PP_S_USUARIO,	@PP_O_USUARIO,	@PP_L_USUARIO,
				@PP_CORREO,
				@PP_LOGIN_ID,	@PP_CONTRASENA, @PP_F_CONTRASENA,
				@PP_K_ESTATUS_USUARIO,			@PP_K_TIPO_USUARIO,
				@PP_K_PERSONAL_PREDEFINIDO,
				-- =========================== 
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL		)
	ELSE
		UPDATE	USUARIO
		SET		D_USUARIO =				@PP_D_USUARIO,
				CORREO =				@PP_CORREO,		
				LOGIN_ID =				@PP_LOGIN_ID,	
				CONTRASENA =			@PP_CONTRASENA,	
				K_ESTATUS_USUARIO =		@PP_K_ESTATUS_USUARIO	
		WHERE	K_USUARIO=@PP_K_USUARIO
	--  ==========================================
GO




-- //////////////////////////////////////////////////////////////
-- // CARGA INICIAL
-- //////////////////////////////////////////////////////////////



-- ===============================================
SET NOCOUNT ON
-- ===============================================


EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 000, 'SYS/SETUP', '', 'SET', 10,	1, '', 'SETUP', 'PWD000', '01/NOV/2017', 1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 001, 'SYS/JOBS',	'', 'SYS', 20,	1, '', 'SYSJOB', 'PWD001', '01/NOV/2017', 1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 022, 'A.SALGADO', '',	'ASV', 40,	1, '', 'ASV','PWD022', '01/NOV/2017',	1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 033, 'D.PORTILLO', '', 'DPR', 50,	1, '', 'DPR','PWD033', '01/NOV/2017',	1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 044, 'T.RUIZ', '', 'TRE', 60, 1, '', 'TRE', 'PWD044', '01/NOV/2017',	1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 055, 'E.RODRIGUEZ', '', 'EROD', 70, 1, '', 'EROD',	'PWD055', '01/NOV/2017',	1,	1,	NULL 
EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 066, 'B.HINOJOSA', '', 'BHIN', 80, 1, '', 'BHIN',	'PWD066', '01/NOV/2017',	1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 077, 'A.OCHOA',	'',	'AOCH', 90,	1, '', 'AOCH',	'PWD077', '01/NOV/2017',	1,	1,	NULL 
EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 014, 'A.CASTAÑENA', '', 'ACG', 100,	1, '', 'ACG', 'ANA123', '01/NOV/2017',	1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 099, 'F.ESTEBAN', '', 'FEG', 100,	1, '', 'FEG', 'PWD099', '01/NOV/2017',	1,	1,	NULL


EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 111, 'C.ZAMARRON', '', 'CZG', 30,	1, '', 'CZG', '123456', '01/NOV/2017',	1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 169, 'H.GONZALEZ', '', 'HGF', 100,	1, '', 'HGF', '123456', '01/NOV/2017',	1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 177, 'J.PEDROZA', '',  'JPP', 100,	1, '', 'JPP', '123456', '01/NOV/2017',	1,	1,	NULL

EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 201, 'USR/CONS', '', 'CON', 110, 1, '', 'CON', 'PWDCON', '01/NOV/2017',	1,	1,	NULL 
EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 202, 'USR/OPER', '', 'OPE', 120, 1, '', 'OPE', 'PWDOPE', '01/NOV/2017',	1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 203, 'USR/ADMON', '', 'ADM', 130, 1, '', 'ADM', 'PWDADM', '01/NOV/2017',	1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 1000,'OPERACION', '', 'PR3M4', 140, 1, '', 'PR3M4', 'PWD1000', '01/NOV/2017',	1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 1001, 'M.OLIVO', '', 'MOR', 150, 1, 'MOLIVO.R@TOMZA.COM', 'MOR', 'QWERTY', '04/SEP/2018',	1, 1,NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 1002, 'L.BARRAZA', '', 'LBG', 160, 1, 'LBARRAZA.G@TOMZA.COM', 'LBG', 'PWD1001', '04/SEP/2018',	1, 1,NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,2006,0, 1003, 'A.DELAROSA', '', 'ADR', 170, 1, 'ADELAROSA.R@TOMZA.COM', 'ADR', 'PWD1003', '04/SEP/2018',	1, 1,NULL


GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================



-- ///////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////





