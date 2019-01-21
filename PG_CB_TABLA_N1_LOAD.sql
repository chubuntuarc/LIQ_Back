-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter USE [LIQ19_Liquidaciones_V0000_R0]

GO
/****** Object:  StoredProcedure [dbo].[PG_CB_TABLA_N1_Load]    Script Date: 10/31/2018 12:18:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[PG_CB_TABLA_N1_Load]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	@PP_NOMBRE_TABLA			VARCHAR(255),
	@PP_L_CON_TODOS				INT,
	@PP_L_USAR_ORDEN			INT
AS

	DECLARE @VP_INT_SHOW_K		INT

	EXECUTE [dbo].[PG_SK_CONFIGURACION_COMBO_SHOW_K_GET]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
																@OU_SHOW_K = @VP_INT_SHOW_K			OUTPUT
	-- ==========================================
		
	CREATE TABLE	#VP_TA_CATALOGO	
					(	TA_K_CATALOGO		INT,
						TA_D_CATALOGO		VARCHAR(200),
						TA_O_CATALOGO		INT,
						TA_L_DELETED		INT,	
						TA_L_ACTIVO			INT			 )

	DECLARE @VP_STR_SQL		NVARCHAR(MAX)

	IF @PP_L_USAR_ORDEN=1
		SET @VP_STR_SQL = 'INSERT INTO #VP_TA_CATALOGO EXEC [dbo].[PG_CB_TABLA_N1_X_ORDEN_Select] 0, 0, '+ '''' +@PP_NOMBRE_TABLA+ '''' 
	ELSE
		SET @VP_STR_SQL = 'INSERT INTO #VP_TA_CATALOGO EXEC [dbo].[PG_CB_TABLA_N1_Select] 0, 0, '+ '''' +@PP_NOMBRE_TABLA+ '''' 
	
	-- ==========================================
									
	EXECUTE sp_executesql @VP_STR_SQL 
	
	-- ==========================================

	IF @PP_L_CON_TODOS=1
		INSERT INTO #VP_TA_CATALOGO
				( TA_K_CATALOGO,	TA_D_CATALOGO,	TA_O_CATALOGO, TA_L_DELETED, TA_L_ACTIVO	)
			VALUES
				( -1,				'( TODOS )',	-999,		   0,			 1				)

	-- ==========================================
	
	IF @VP_INT_SHOW_K=1
		SELECT	TA_K_CATALOGO	AS K_COMBOBOX,
			  ( (CASE WHEN (TA_L_ACTIVO=1 AND TA_L_DELETED=0) THEN '' ELSE '<X> ' END ) +
				TA_D_CATALOGO + ' [#' + CONVERT(VARCHAR(100), TA_K_CATALOGO) + ']' ) 
								AS D_COMBOBOX
		FROM	#VP_TA_CATALOGO
		ORDER BY TA_O_CATALOGO, TA_D_CATALOGO 
	ELSE
		SELECT	TA_K_CATALOGO	AS K_COMBOBOX,
				TA_D_CATALOGO	AS D_COMBOBOX
		FROM	#VP_TA_CATALOGO
		ORDER BY TA_O_CATALOGO, TA_D_CATALOGO 

	-- ==========================================

	DROP TABLE #VP_TA_CATALOGO
