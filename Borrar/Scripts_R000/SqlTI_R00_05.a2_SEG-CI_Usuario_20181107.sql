-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	TRA19_Transportadora_V9999_R0
-- // MODULO:			USUARIO
-- // OPERACION:		LIBERACION / TABLA+CARGA 
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- //
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
	-- ===============================

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
		SET		D_USUARIO				= @PP_D_USUARIO,	
				C_USUARIO				= @PP_C_USUARIO,
				S_USUARIO				= @PP_S_USUARIO,	
				O_USUARIO				= @PP_O_USUARIO,	
				L_USUARIO				= @PP_L_USUARIO,
				CORREO					= @PP_CORREO,		
				LOGIN_ID				= @PP_LOGIN_ID,	
				CONTRASENA				= @PP_CONTRASENA,	
				F_CONTRASENA			= @PP_F_CONTRASENA,
				K_ESTATUS_USUARIO		= @PP_K_ESTATUS_USUARIO,		
				K_TIPO_USUARIO			= @PP_K_TIPO_USUARIO,
				K_PERSONAL_PREDEFINIDO	= @PP_K_PERSONAL_PREDEFINIDO,
				-- ===========================
 				[K_USUARIO_CAMBIO]		= @PP_K_USUARIO_ACCION,		
				[F_CAMBIO]				= GETDATE()
		WHERE	K_USUARIO=@PP_K_USUARIO

	--  ==========================================
GO





-- //////////////////////////////////////////////////////////////
-- //
-- //////////////////////////////////////////////////////////////


EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 000, 'SYS/SETUP', '',	'SET', 010,	1, '', 'SETUP', 'PWD000', '01/NOV/2017', 1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 001, 'SYS/JOBS',	'',		'SYS', 020,	1, '', 'SYSJOB', 'PWD001', '01/NOV/2017', 1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 111, 'C.ZAMARRON', '',	'CZG', 030,	1, '', 'CZG', 'PWD011', '01/NOV/2017',	1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 122, 'A.SALGADO', '',	'ASV', 040,	1, '', 'ASV','PWD022', '01/NOV/2017',	1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 133, 'D.PORTILLO', '',	'DPR', 050,	1, '', 'DPR','PWD033', '01/NOV/2017',	1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 144, 'T.RUIZ', '',		'TRE', 060, 1, '', 'TRE', 'PWD044', '01/NOV/2017',	1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 155, 'U155', '',		'155', 060, 1, '', '155', 'PWD044', '01/NOV/2017',	1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 166, 'L.BARRAZA', '',	'LBG', 160, 1, 'LBARRAZA.G@TOMZA.COM', 'LBG', 'PWD1001', '04/SEP/2018',	1, 1,NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 177, 'A.DELAROSA', '',	'ADR', 170, 1, 'ADELAROSA.R@TOMZA.COM', 'ADR', 'PWD1003', '04/SEP/2018',	1, 1,NULL


EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 169, 'H.GONZALEZ', '', 'HGF', 100,	1, '', 'HGF', 'PWD069', '01/NOV/2017',	1,	1,	NULL

EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 201, 'USR/CONS', '', 'CON', 110, 1, '', 'CON', 'PWDCON', '01/NOV/2017',	1,	1,	NULL 
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 202, 'USR/OPER', '', 'OPE', 120, 1, '', 'OPE', 'PWDOPE', '01/NOV/2017',	1,	1,	NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 203, 'USR/ADMON', '', 'ADM', 130, 1, '', 'ADM', 'PWDADM', '01/NOV/2017',	1,	1,	NULL


EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 1000,'OPERACION', '', 'PR3M4', 140, 1, '', 'PR3M4', 'PWD1000', '01/NOV/2017',	1,	1,	NULL


EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 300, 'ALL > QA/TESO' , '' ,		'TQA#ALL' , 140 ,1,'','TALL', 'TALL' ,'01/NOV/2017',1,1 ,10300
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 301, 'CHI > QA/TESO' , '' ,		'TQA#CHI' , 140 ,1,'','TCHI', 'TCHI' ,'01/NOV/2017',1,1 ,10301
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 302, 'JAL > QA/TESO' , '' ,		'TQA#JAL' , 140 ,1,'','TJAL', 'TJAL' ,'01/NOV/2017',1,1 ,10302
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 303, 'SUR > QA/TESO' , '' ,		'TQA#SUR' , 140 ,1,'','TSUR', 'TSUR' ,'01/NOV/2017',1,1 ,10303
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 304, 'MEX > QA/TESO' , '' ,		'TQA#MEX' , 140 ,1,'','TMEX', 'TMEX' ,'01/NOV/2017',1,1 ,10304
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 305, 'CEN > QA/TESO' , '' ,		'TQA#CEN' , 140 ,1,'','TCEN', 'TCEN' ,'01/NOV/2017',1,1 ,10305
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 306, 'SON > QA/TESO' , '' ,		'TQA#SON' , 140 ,1,'','TSON', 'TSON' ,'01/NOV/2017',1,1 ,10306
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 307, 'BJA > QA/TESO' , '' ,		'TQA#BJA' , 140 ,1,'','TBJA', 'TBJA' ,'01/NOV/2017',1,1 ,10307



--/////////////////////////////////////////////////////////////////////////////
-- USUARIOS PARA PRUEBAS DE AUTORIZACIONES

EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 401, 'FROBLES > QA/AUT' , '' ,	'QA#FROB' , 150 ,1,'','QAFR', 'QAFR' ,'07/11/2017',1,1 ,NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 402, 'OGONZALEZ > QA/AUT' , '',	'QA#OGON' , 150 ,1,'','QAOG', 'QAOG' ,'07/11/2017',1,1 ,NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 403, 'CSANTOS> QA/AUT' , '' ,	'QA#CSAN' , 150 ,1,'','QACS', 'QACS' ,'07/11/2017',1,1 ,NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 404, 'DIRECTIVO> QA/AUT' , '' ,	'QA#DIRE' , 150 ,1,'','QADI', 'QADI' ,'07/11/2017',1,1 ,NULL
EXECUTE [dbo].[PG_CI_USUARIO]	0,0,0, 405, 'TESORERIA> QA/AUT' , '' ,	'QA#TESO' , 150 ,1,'','QATE', 'QATE' ,'07/11/2017',1,1 ,NULL

--/////////////////////////////////////////////////////////////////////////////


GO


-- ///////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////





