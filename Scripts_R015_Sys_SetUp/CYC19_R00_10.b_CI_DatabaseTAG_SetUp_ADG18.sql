-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	
-- // MODULO:			
-- // OPERACION:		LIBERACION / DATOS
-- //////////////////////////////////////////////////////////////

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////
-- K_SISTEMA | #0 DEFAULT | #10 ICS | #20 ERM | #40 PPT0
-- K_SISTEMA | #1001 PREMA | #2001 INV19 | #2002 CYC19 | #2003 TRA19 | #2004 RHU19 | #2005 LIQ19 | #2006 ADG18

DECLARE @VP_K_SISTEMA INT

SET		@VP_K_SISTEMA =	2005		-- #2002 CYC19


-- //////////////////////////////////////////////////////////////
-- SELECT * FROM [dbo].[SISTEMA] 
-- SELECT * FROM [dbo].[VALOR_PARAMETRO] 

UPDATE	VALOR_PARAMETRO 
SET		K_SISTEMA = @VP_K_SISTEMA


-- //////////////////////////////////////////////////////////////

DECLARE @VP_S_SISTEMA		VARCHAR(200)

SELECT	@VP_S_SISTEMA =		S_SISTEMA
							FROM	SISTEMA
							WHERE	K_SISTEMA=@VP_K_SISTEMA

IF @VP_S_SISTEMA IS NULL
	SET @VP_S_SISTEMA = '?????'


DECLARE @VP_D_TEXTO VARCHAR(200)
DECLARE @VP_C_TEXTO VARCHAR(200)

-- //////////////////////////////////////////////////////////////
-- SELECT * FROM DATABASE_TAG

-- ========================================================
-- LIBERACION // VERSION // BASE DE DATOS
SET @VP_D_TEXTO = @VP_S_SISTEMA+' > BD/RELEASE'
SET @VP_C_TEXTO = '11/MAR/2019'
SET @VP_C_TEXTO = 'BD/RELASE ['+ @VP_C_TEXTO +']'

EXECUTE [dbo].[PG_CI_DATABASE_TAG] 0,@VP_K_SISTEMA,	20190311.1,	@VP_D_TEXTO, 'BD.V999A', 1, @VP_C_TEXTO, 1


-- ========================================================
-- LIBERACION // VERSION // EJECUTABLE
SET @VP_D_TEXTO = @VP_S_SISTEMA+' > EXE/RELEASE'
SET @VP_C_TEXTO = GETDATE()
SET @VP_C_TEXTO = 'EXE/RELASE ['+ @VP_C_TEXTO +']'

EXECUTE [dbo].[PG_CI_DATABASE_TAG] 0, @VP_K_SISTEMA,	20190311.2,	@VP_D_TEXTO, 'EXE.V0005D', 1, @VP_C_TEXTO, 1

-- ========================================================
-- LIBERACION // VERSION // EJECUTABLE
SET @VP_D_TEXTO = @VP_S_SISTEMA+' > EXE/RELEASE'
SET @VP_C_TEXTO = GETDATE()
SET @VP_C_TEXTO = 'EXE/RELASE ['+ @VP_C_TEXTO +']'

EXECUTE [dbo].[PG_CI_DATABASE_TAG] 0, @VP_K_SISTEMA,	20190304.2,	@VP_D_TEXTO, 'EXE.V0110', 1, @VP_C_TEXTO, 0

-- ========================================================
-- LIBERACION // VERSION // EJECUTABLE
SET @VP_D_TEXTO = @VP_S_SISTEMA+' > EXE/RELEASE'
SET @VP_C_TEXTO = GETDATE()
SET @VP_C_TEXTO = 'EXE/RELASE ['+ @VP_C_TEXTO +']'

EXECUTE [dbo].[PG_CI_DATABASE_TAG] 0, @VP_K_SISTEMA,	20190227.2,	@VP_D_TEXTO, 'EXE.V0100', 1, @VP_C_TEXTO, 0

-- ========================================================
-- LIBERACION // VERSION // BASE DE DATOS
SET @VP_D_TEXTO = @VP_S_SISTEMA+' > BD/RELEASE'
SET @VP_C_TEXTO = '27/FEB/2019'
SET @VP_C_TEXTO = 'BD/RELASE ['+ @VP_C_TEXTO +']'

EXECUTE [dbo].[PG_CI_DATABASE_TAG] 0,@VP_K_SISTEMA,	20190227.1,	@VP_D_TEXTO, 'BD.V0106B', 1, @VP_C_TEXTO, 0


-- ========================================================
-- LIBERACION // VERSION // EJECUTABLE
SET @VP_D_TEXTO = @VP_S_SISTEMA+' > EXE/RELEASE'
SET @VP_C_TEXTO = GETDATE()
SET @VP_C_TEXTO = 'EXE/RELASE ['+ @VP_C_TEXTO +']'

EXECUTE [dbo].[PG_CI_DATABASE_TAG] 0,@VP_K_SISTEMA,	20190201.2,	@VP_D_TEXTO, 'EXE.V0000', 1, @VP_C_TEXTO, 0

-- ========================================================
-- EJECUCION SCRIPT
SET @VP_D_TEXTO = @VP_S_SISTEMA+' > EJECUCION SCRIPT'

SET @VP_C_TEXTO = GETDATE()
SET @VP_C_TEXTO = 'EJECUCION ['+ @VP_C_TEXTO +']'

EXECUTE [dbo].[PG_CI_DATABASE_TAG] 0,@VP_K_SISTEMA,	1000,	@VP_D_TEXTO, 'INIT/SQL', 1, @VP_C_TEXTO, 1


-- ========================================================

-- ========================================================
-- SELECT * FROM DATABASE_TAG



-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////