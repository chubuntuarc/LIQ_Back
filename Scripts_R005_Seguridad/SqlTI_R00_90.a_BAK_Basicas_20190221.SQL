-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	PYF18_Finanzas
-- // MODULO:			STORED PROCEDURES - BASICOS
-- // OPERACION:		LIBERACION
-- //////////////////////////////////////////////////////////////

USE [RHU19_Humanos_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////





-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ESPECIAL
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SQ_EXECUTE_configure_xp_cmdshell_1]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SQ_EXECUTE_configure_xp_cmdshell_1]
GO



CREATE PROCEDURE [dbo].[PG_SQ_EXECUTE_configure_xp_cmdshell_1]
	@PP_L_DEBUG					[INT],
	@PP_K_SISTEMA_EXE			[INT],
	@PP_K_USUARIO				[INT]
AS
	-- ===============================================

	IF @PP_L_DEBUG>0
		PRINT '----------------------------- [PG_SQ_EXECUTE_configure_xp_cmdshell_1]'
	
	-- ===============================================

	EXECUTE master.dbo.sp_configure 'show advanced options', 1
	RECONFIGURE

	-- ===============================================

	EXECUTE master.dbo.sp_configure 'xp_cmdshell', 1
	RECONFIGURE

	-- ===============================================
	
	IF @PP_L_DEBUG>0
		PRINT '======================================================='
	
	-- ///////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ESPECIAL
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SQ_EXECUTE_configure_xp_cmdshell_0]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SQ_EXECUTE_configure_xp_cmdshell_0]
GO



CREATE PROCEDURE [dbo].[PG_SQ_EXECUTE_configure_xp_cmdshell_0]
	@PP_L_DEBUG					[INT],
	@PP_K_SISTEMA_EXE			[INT],
	@PP_K_USUARIO				[INT]
AS
	-- ===============================================

	IF @PP_L_DEBUG>0
		PRINT '----------------------------- [PG_SQ_EXECUTE_configure_xp_cmdshell_0]'
	
	-- ===============================================

	EXECUTE master.dbo.sp_configure 'xp_cmdshell', 0
	RECONFIGURE

	-- ===============================================

	EXECUTE master.dbo.sp_configure 'show advanced options', 0
	RECONFIGURE

	-- ===============================================
	
	IF @PP_L_DEBUG>0
		PRINT '======================================================='
	
	-- ///////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ESPECIAL
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SQ_EXECUTE_sp_addumpdevice]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SQ_EXECUTE_sp_addumpdevice]
GO


CREATE PROCEDURE [dbo].[PG_SQ_EXECUTE_sp_addumpdevice]
	@PP_L_DEBUG					[INT],
	@PP_K_SISTEMA_EXE			[INT],
	@PP_K_USUARIO				[INT],
	@PP_DISPOSITIVO				VARCHAR (200),
	@PP_RUTA_Y_DISPOSITIVO		VARCHAR (200)
AS
	-- ===============================================

	EXECUTE	[dbo].[PG_IN_BITACORA_SYS_BASICO]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO,												
									--			K_CLASE, K_IMPORTANCIA, K_GRUPO
												5, 6, 1,		-- #5-BD/SQL | #6-CRITICA | #1-BACKUP
												'EXEC sp_addumpdevice', @PP_RUTA_Y_DISPOSITIVO,
												'[PG_SQ_EXECUTE_sp_addumpdevice]', 0, 0
	-- ====================================
	-- CREA DISPOSITIVO/ARCHIVO DE RESPALDO 
	-- USE master
	EXEC sp_addumpdevice 
		@devtype		= 'disk', 
		@logicalname	= @PP_DISPOSITIVO, 
		@physicalname	= @PP_RUTA_Y_DISPOSITIVO

	-- ///////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ESPECIAL
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SQ_EXECUTE_xp_cmdshell]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SQ_EXECUTE_xp_cmdshell]
GO


CREATE PROCEDURE [dbo].[PG_SQ_EXECUTE_xp_cmdshell]
	@PP_L_DEBUG					[INT],
	@PP_K_SISTEMA_EXE			[INT],
	@PP_K_USUARIO				[INT],
	@PP_SENTENCIA_DOS			VARCHAR (500)
AS
	-- ===============================================

	IF @PP_L_DEBUG>0
		PRINT	@PP_SENTENCIA_DOS

	-- ===============================================

	EXECUTE	[dbo].[PG_IN_BITACORA_SYS_BASICO]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO,												
									--			K_CLASE, K_IMPORTANCIA, K_GRUPO
												5, 6, 1,		-- #5-BD/SQL | #6-CRITICA | #1-BACKUP
												'EXECUTE master.dbo.xp_cmdshell @VP_SENTENCIA_DOS', @PP_SENTENCIA_DOS,
												'PG_SQ_EXECUTE_xp_cmdshell', 0, 0
	-- ======================================

    EXECUTE master.dbo.xp_cmdshell @PP_SENTENCIA_DOS

	-- ///////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> ESPECIAL
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_BD_DIRECTORIO_BACKUP_DEPURAR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_BD_DIRECTORIO_BACKUP_DEPURAR]
GO


CREATE PROCEDURE [dbo].[PG_BD_DIRECTORIO_BACKUP_DEPURAR]
	@PP_L_DEBUG					[INT],
	@PP_K_SISTEMA_EXE			[INT],
	@PP_K_USUARIO				[INT],
	@PP_RUTA_RESPALDOS			[VARCHAR] (255),
	@PP_FECHA_PIVOTE			[DATETIME],
	@PP_N_DIAS					[INT]
AS
	-- ===============================================
	
	DECLARE @VP_SENTENCIA_DOS VARCHAR (500)

	-- ===============================================

	DECLARE @VP_FECHA_A_DEPURAR		[DATETIME]

	SET @VP_FECHA_A_DEPURAR = DATEADD( day, @PP_N_DIAS, @PP_FECHA_PIVOTE )

	-- ===============================================

	DECLARE @VP_FECHA_A_DEPURAR_YYYYMMDD AS VARCHAR(100)
	
	SET @VP_FECHA_A_DEPURAR_YYYYMMDD = ''
	SET @VP_FECHA_A_DEPURAR_YYYYMMDD = @VP_FECHA_A_DEPURAR_YYYYMMDD +				CONVERT( VARCHAR(10), YEAR(@VP_FECHA_A_DEPURAR) )
	SET @VP_FECHA_A_DEPURAR_YYYYMMDD = @VP_FECHA_A_DEPURAR_YYYYMMDD +	RIGHT( ('0'+CONVERT( VARCHAR(10), MONTH(@VP_FECHA_A_DEPURAR))), 2 )
	SET @VP_FECHA_A_DEPURAR_YYYYMMDD = @VP_FECHA_A_DEPURAR_YYYYMMDD +	RIGHT( ('0'+CONVERT( VARCHAR(10), DAY(@VP_FECHA_A_DEPURAR))), 2 )

	-- ===============================================

	EXECUTE [dbo].[PG_SQ_EXECUTE_configure_xp_cmdshell_1]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO	

	-- ===============================================
	
	SET @VP_SENTENCIA_DOS = 'DEL "' + @PP_RUTA_RESPALDOS + 'RESPALDO_*'+@VP_FECHA_A_DEPURAR_YYYYMMDD+'*.bak"'

	EXECUTE [dbo].[PG_SQ_EXECUTE_xp_cmdshell]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO, 
												@VP_SENTENCIA_DOS
	-- =======================================

	SET @VP_SENTENCIA_DOS = 'DEL "' + @PP_RUTA_RESPALDOS + 'RESPALDO_*'+@VP_FECHA_A_DEPURAR_YYYYMMDD+'*.zip"'

	EXECUTE [dbo].[PG_SQ_EXECUTE_xp_cmdshell]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO, 
												@VP_SENTENCIA_DOS
	-- =======================================

	EXECUTE [dbo].[PG_SQ_EXECUTE_configure_xp_cmdshell_0]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO	

	-- ===============================================
GO





-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
