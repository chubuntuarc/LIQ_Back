-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	ADG18_AdministradoraGas
-- // MODULO:			
-- // OPERACION:		LIBERACION // STORED PROCEDURE
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_FILTRO_SI_NO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_FILTRO_SI_NO]
GO


CREATE PROCEDURE [dbo].[PG_CB_FILTRO_SI_NO]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT
AS

	SELECT	K_FILTRO_SI_NO		AS K_CATALOGO,
			D_FILTRO_SI_NO		AS D_CATALOGO
	FROM	FILTRO_SI_NO
	WHERE	K_FILTRO_SI_NO IN ( 0,1 )
	ORDER BY K_FILTRO_SI_NO

	-- ////////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_MES]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_MES]
GO


CREATE PROCEDURE [dbo].[PG_LI_MES]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT
AS

	SELECT	MES.*
	FROM	MES
	ORDER BY O_MES

	-- ////////////////////////////////////////////////////
GO



-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
