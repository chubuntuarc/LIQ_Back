-- //////////////////////////////////////////////////////////////
-- /////////////////////////////////////////// HGF - v20180207 //
-- //////////////////////////////////////////////////////////////
-- // SERVIDOR:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_DocMatrix
-- // MODULO:			CREACION DE BASE DE DATOS 
-- //					  -INCLUYE TABLAS
-- //					  -STORED PROCEDURES
-- //					  -CARGA INICIAL
-- //					  -DATOS DE PRUEBA
-- // OPERACION:		LIBERACION (CARPETA COMPLETA)
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////

USE [master]
GO


/****************************************************************/
/*							RECONFIGURAR						*/
/****************************************************************/

SET NOCOUNT ON

EXEC master.dbo.sp_configure 'show advanced options', 1
RECONFIGURE
EXEC master.dbo.sp_configure 'xp_cmdshell', 1
RECONFIGURE


/****************************************************************/
/*				EJECUCION DE CARPETA DE LIBERACION				*/
/****************************************************************/

DECLARE @VP_ES_DESARROLLO	INT

SET @VP_ES_DESARROLLO	= 1

-- ========================================

DECLARE @VP_SQL_SERVIDOR	VARCHAR(100)
DECLARE @VP_SQL_USER		VARCHAR(100)
DECLARE @VP_SQL_PASSWORD	VARCHAR(100)

SET @VP_SQL_SERVIDOR	= 'DESKTOP-I0DN4KS\LOCAL'
SET @VP_SQL_USER		= 'SA'
SET @VP_SQL_PASSWORD	= '123456'

-- ========================================

DECLARE @VP_STR_BASE_DATOS				VARCHAR(MAX)
DECLARE @VP_STR_RUTA_PROYECTO			VARCHAR(MAX)
DECLARE @VP_STR_RUTA_CONSTRUCCION		VARCHAR(MAX)

SET @VP_STR_BASE_DATOS			= 'LIQ19_Liquidaciones_V9999_R0'
SET @VP_STR_RUTA_PROYECTO		= 'C:\1.Tomza_JAR\TI_TecnologiaInformacion\Workbook\'
--SET @VP_STR_RUTA_CONSTRUCCION	= 'LIQ19_Liquidaciones\4.Construccion\CodigoSQL\LIQ19_Liberacion_R0.00_Base_V0001\'
SET @VP_STR_RUTA_CONSTRUCCION	= 'BASE_PRUEBA\LIQ_Back\'

-- ========================================

DECLARE @VP_SQL_SQLCMD	VARCHAR(1000)

SET @VP_SQL_SQLCMD		= 'SQLCMD -S '+@VP_SQL_SERVIDOR+' -U '+@VP_SQL_USER+' -P '+@VP_SQL_PASSWORD+' -d ' 

-- ========================================

--Create the Folder- en filetables.
DECLARE @VP_TBL_SQLFolders				TABLE ( SQLFolderName VARCHAR(MAX) )
DECLARE @VP_TBL_SQLFiles				TABLE ( SQLFileName VARCHAR(MAX) )
DECLARE @VP_STR_ARCHIVO_SQL				VARCHAR(MAX)
DECLARE @VP_STR_CARPETA_LIBERACION		VARCHAR(MAX)
DECLARE @VP_STR_SENTENCIA_SQL			VARCHAR(2000)
DECLARE @VP_STR_ARCHIVO_CON_RUTA		VARCHAR(MAX)
DECLARE @VP_IN_PROCESAR_ARCHIVO			INT

-- ========================================

	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R000\')
	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R100_Biogas\')

	/*
	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R101_Estructura\')

	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R102_POV\')
	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R103\')
	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R104_Personal\')

	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R110_D0MA_SetUp\')
	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R111_D0MA_TA\')
	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R112_D0MA_SP\')
	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R113\')

	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R150_POV_CEMEC_FLUP\')

	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R201_FIN\')
	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R202\')


	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R300_AUT\')
	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R301\')

	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R400_Control\')
	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R500_PPTO\')
	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R600\')
	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R610_CXP\')

	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R700_FLU\')

	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R901_WFW\')
	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R902_Viaticos\')
	INSERT INTO @VP_TBL_SQLFolders VALUES ('Scripts_R903_Cuentas\')

	*/

-- ========================================

DECLARE cFolders	CURSOR	LOCAL FOR
					SELECT	[SQLFolderName]
					FROM	@VP_TBL_SQLFolders

-- ========================================

OPEN cFolders
FETCH NEXT FROM cFolders INTO @VP_STR_CARPETA_LIBERACION
WHILE @@FETCH_STATUS = 0
	BEGIN
    --Fill the file-table and loop through.

    SET @VP_STR_SENTENCIA_SQL = 'dir /b "' + @VP_STR_RUTA_PROYECTO + @VP_STR_RUTA_CONSTRUCCION + @VP_STR_CARPETA_LIBERACION + '*.sql"'

    INSERT INTO @VP_TBL_SQLFiles
    EXECUTE master.dbo.xp_cmdshell @VP_STR_SENTENCIA_SQL

	-- ========================================

    DECLARE cFiles	CURSOR	LOCAL FOR
					SELECT	DISTINCT [SQLFileName]
					FROM	@VP_TBL_SQLFiles
					WHERE	[SQLFileName] IS NOT NULL 
					AND		[SQLFileName] != 'NULL' 
					AND		[SQLFileName] != 'File Not Found'
					ORDER BY [SQLFileName]
					
	-- ========================================

    OPEN cFiles
    FETCH NEXT FROM cFiles INTO @VP_STR_ARCHIVO_SQL
    WHILE @@FETCH_STATUS = 0
		BEGIN
		
		SET @VP_IN_PROCESAR_ARCHIVO = 0

		-- ========================================

		IF LEFT(@VP_STR_ARCHIVO_SQL,5)='TRA19' 
			SET @VP_IN_PROCESAR_ARCHIVO = 1

		IF LEFT(@VP_STR_ARCHIVO_SQL,5)='SqlTI' 
			SET @VP_IN_PROCESAR_ARCHIVO = 1

		-- ========================================
		
		IF @VP_ES_DESARROLLO=0
			IF CHARINDEX('_DESARROLLO',@VP_STR_ARCHIVO_SQL)<>0 
				SET @VP_IN_PROCESAR_ARCHIVO = 0
	
		-- ========================================

		PRINT ' ' 
		PRINT ' ' 
		PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' 
		PRINT '> PROCESANDO '
		PRINT '>         SCRIPT: ' + @VP_STR_ARCHIVO_SQL
		PRINT '>  BASE DE DATOS: ' + @VP_STR_BASE_DATOS
		PRINT '> -------------------------------------------------------------------------'        
		PRINT '>       PROYECTO: ' + @VP_STR_RUTA_PROYECTO 
		PRINT '>   CONSTRUCCION: ' + @VP_STR_RUTA_CONSTRUCCION
		PRINT '>           RUTA: ' + @VP_STR_CARPETA_LIBERACION
		PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' 
		PRINT ' ' 
	    
	    -- ========================================

	     IF @VP_IN_PROCESAR_ARCHIVO = 0
			BEGIN
			PRINT '                  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
			PRINT '                  !! IMPORTANTE: NO SE PROCES� EL ARCHIVO !!' 
			PRINT '                  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
			PRINT ' '
			END
	     ELSE
			BEGIN	        
			SET @VP_STR_ARCHIVO_CON_RUTA = @VP_STR_RUTA_PROYECTO + @VP_STR_RUTA_CONSTRUCCION + @VP_STR_CARPETA_LIBERACION + @VP_STR_ARCHIVO_SQL
	        
			SET @VP_STR_SENTENCIA_SQL = @VP_SQL_SQLCMD + @VP_STR_BASE_DATOS + ' -i ' + @VP_STR_ARCHIVO_CON_RUTA 
	        
			PRINT @VP_STR_SENTENCIA_SQL
			PRINT ' ' 
	        
			EXECUTE master.dbo.xp_cmdshell @VP_STR_SENTENCIA_SQL
			END
			
        FETCH NEXT FROM cFiles INTO @VP_STR_ARCHIVO_SQL
		END

	-- ========================================

    DELETE 
    FROM	@VP_TBL_SQLFiles

	-- ========================================

    CLOSE cFiles
    DEALLOCATE cFiles
    FETCH NEXT FROM cFolders INTO @VP_STR_CARPETA_LIBERACION

	END

-- ========================================

PRINT ' ' 
PRINT ' ' 
PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' 
PRINT '> FIN DE PROCESO  '
PRINT '>  BASE DE DATOS: ' + @VP_STR_BASE_DATOS
PRINT '>       PROYECTO: ' + @VP_STR_RUTA_PROYECTO 
PRINT '>   CONSTRUCCION: ' + @VP_STR_RUTA_CONSTRUCCION
PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' 

-- ========================================

CLOSE cFolders
DEALLOCATE cFolders
GO


/****************************************************************/
/*					RESTAURAR RECONFIGURACION					*/
/****************************************************************/

EXEC master.dbo.sp_configure 'xp_cmdshell', 0
RECONFIGURE
EXEC master.dbo.sp_configure 'show advanced options', 0
RECONFIGURE


SET NOCOUNT OFF

