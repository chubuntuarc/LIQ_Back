-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS: 	
-- // MODULO:			CONFIGURACION - SPs MANEJO DE FECHAS   		
-- // OPERACION:		LIBERACION    
-- //////////////////////////////////////////////////////////////

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////


SET DATEFIRST 7; 
GO

-- //////////////////////////////////////////////////////////////
-- SELECT * FROM TIEMPO_FECHA
-- EXECUTE [PG_CI_TIEMPO_FECHA_X_RANGO] '2015-01-01', '2025-01-01'


-- //////////////////////////////////////////////////////////////
-- // DROPs 
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIEMPO_FECHA]') AND type in (N'U'))
	DROP TABLE [dbo].[TIEMPO_FECHA] 
GO



/****************************************************************/
/*						TIEMPO_FECHA							*/
/****************************************************************/

CREATE TABLE [dbo].[TIEMPO_FECHA] (
	[F_TIEMPO_FECHA]		[DATE] NOT NULL,
	[D_TIEMPO_FECHA]		[VARCHAR] (100) NOT NULL,
	[S_TIEMPO_FECHA]		[VARCHAR] (20) NOT NULL,
	[O_TIEMPO_FECHA]		[INT] NOT NULL,
	[C_TIEMPO_FECHA]		[VARCHAR] (255) NOT NULL,
	-- ================================
	[FECHA_YYYY]			[INT] NOT NULL,
	[FECHA_DD]				[INT] NOT NULL,
	[K_TIEMPO_MES]			[INT] NOT NULL,
	[K_TIEMPO_DIA_SEMANA]	[INT] NOT NULL,
	[K_TIEMPO_QUINCENA]		[INT] NOT NULL,
	-- ================================
	[N_SEMANA]				[INT] NOT NULL,
	[N_SEMANA_YYYY]			[INT] NOT NULL,
	-- ================================
	[L_ASUETO]				[INT] NOT NULL
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[TIEMPO_FECHA]
	ADD CONSTRAINT [PK_TIEMPO_FECHA]
		PRIMARY KEY CLUSTERED ( [F_TIEMPO_FECHA] )
GO


ALTER TABLE [dbo].[TIEMPO_FECHA] ADD 
	CONSTRAINT [FK_TIEMPO_FECHA_01]  
		FOREIGN KEY ( [K_TIEMPO_MES] ) 
		REFERENCES [dbo].[TIEMPO_MES] ( [K_TIEMPO_MES] ),
	CONSTRAINT [FK_TIEMPO_FECHA_02] 
		FOREIGN KEY ( [K_TIEMPO_DIA_SEMANA] ) 
		REFERENCES [dbo].[TIEMPO_DIA_SEMANA] ( [K_TIEMPO_DIA_SEMANA] ),
	CONSTRAINT [FK_TIEMPO_FECHA_03] 
		FOREIGN KEY ( [K_TIEMPO_QUINCENA] ) 
		REFERENCES [dbo].[TIEMPO_QUINCENA] ( [K_TIEMPO_QUINCENA] ),
	CONSTRAINT [FK_TIEMPO_FECHA_04] 
		FOREIGN KEY ( [FECHA_DD] ) 
		REFERENCES [dbo].[TIEMPO_DIA_MES] ( [K_TIEMPO_DIA_MES] )
GO







IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_TIEMPO_FECHA_X_FECHA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_TIEMPO_FECHA_X_FECHA]
GO


CREATE PROCEDURE [dbo].[PG_IN_TIEMPO_FECHA_X_FECHA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_F_TIEMPO_FECHA			DATE,
	@PP_N_SEMANA				INT
AS
	-- ========================================================
	
	DECLARE @VP_D_TIEMPO_FECHA		[VARCHAR] (100)
	DECLARE @VP_S_TIEMPO_FECHA		[VARCHAR] (20)
	DECLARE @VP_O_TIEMPO_FECHA		[INT] 
	DECLARE @VP_C_TIEMPO_FECHA		[VARCHAR] (255)
	
	SET		@VP_D_TIEMPO_FECHA =	''
	SET		@VP_S_TIEMPO_FECHA =	''
	SET		@VP_C_TIEMPO_FECHA =	''
	
	-- ========================================================
	
	DECLARE @VP_FECHA_YYYY				INT
	DECLARE @VP_FECHA_DD				INT
	DECLARE @VP_K_TIEMPO_MES			INT
	DECLARE @VP_K_TIEMPO_DIA_SEMANA		INT
	DECLARE @VP_K_TIEMPO_QUINCENA		INT
		
	SET		@VP_FECHA_YYYY =			YEAR(@PP_F_TIEMPO_FECHA)
	SET		@VP_FECHA_DD =				DAY(@PP_F_TIEMPO_FECHA)	
	SET		@VP_K_TIEMPO_MES =			MONTH(@PP_F_TIEMPO_FECHA)

	-- ====================================

	SET		@VP_O_TIEMPO_FECHA =	0	
	SET		@VP_O_TIEMPO_FECHA =	@VP_O_TIEMPO_FECHA + ( @VP_FECHA_YYYY*10000 )
	SET		@VP_O_TIEMPO_FECHA =	@VP_O_TIEMPO_FECHA + ( @VP_K_TIEMPO_MES*100 )
	SET		@VP_O_TIEMPO_FECHA =	@VP_O_TIEMPO_FECHA + ( @VP_FECHA_DD*1 )

	-- ====================================

	SET		@VP_K_TIEMPO_DIA_SEMANA =	DATEPART(DW, @PP_F_TIEMPO_FECHA) - 1		

	IF @VP_K_TIEMPO_DIA_SEMANA=0
		SET	 @VP_K_TIEMPO_DIA_SEMANA =	7
		
	-- ========================================================

	IF @VP_FECHA_DD<16
		SET		@VP_K_TIEMPO_QUINCENA =	1
	ELSE
		SET		@VP_K_TIEMPO_QUINCENA =	2

	-- ========================================================
	
	DECLARE	@VP_S_TIEMPO_MES		[VARCHAR] (100)
	
	SELECT	@VP_S_TIEMPO_MES =		S_TIEMPO_MES
									FROM	TIEMPO_MES
									WHERE	K_TIEMPO_MES=@VP_K_TIEMPO_MES
	IF @VP_S_TIEMPO_MES IS NULL
		SET @VP_S_TIEMPO_MES = '???'

	SET		@VP_D_TIEMPO_FECHA = CONVERT(VARCHAR(10),@VP_FECHA_DD)+'/'+@VP_S_TIEMPO_MES+'/'+CONVERT(VARCHAR(10),@VP_FECHA_YYYY)

	SET		@VP_S_TIEMPO_FECHA = CONVERT(VARCHAR(10),@VP_FECHA_DD)+'/'+CONVERT(VARCHAR(10),@VP_K_TIEMPO_MES)+'/'+CONVERT(VARCHAR(10),@VP_FECHA_YYYY)
	
	-- ========================================================
	
	INSERT INTO TIEMPO_FECHA
		(	[F_TIEMPO_FECHA],
			[D_TIEMPO_FECHA], [S_TIEMPO_FECHA], [O_TIEMPO_FECHA],
			[C_TIEMPO_FECHA],
			-- ================================
			[FECHA_YYYY], [FECHA_DD], 
			[K_TIEMPO_MES], [K_TIEMPO_DIA_SEMANA], [K_TIEMPO_QUINCENA],
			-- ================================
			[N_SEMANA], [N_SEMANA_YYYY],	[L_ASUETO]	)
	VALUES	
		(	@PP_F_TIEMPO_FECHA,
			@VP_D_TIEMPO_FECHA, @VP_S_TIEMPO_FECHA, @VP_O_TIEMPO_FECHA,
			@VP_C_TIEMPO_FECHA,
			-- ================================
			@VP_FECHA_YYYY, @VP_FECHA_DD, 
			@VP_K_TIEMPO_MES, @VP_K_TIEMPO_DIA_SEMANA, @VP_K_TIEMPO_QUINCENA,
			-- ================================
			@PP_N_SEMANA, @PP_N_SEMANA,		0			)

	-- ========================================================

GO



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_TIEMPO_FECHA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_TIEMPO_FECHA]
GO


CREATE PROCEDURE [dbo].[PG_DL_TIEMPO_FECHA]
	@PP_L_DEBUG				INT,
	@PP_K_SISTEMA_EXE		INT,
	@PP_F_TIEMPO_FECHA		DATE
AS

	DELETE
	FROM	TIEMPO_FECHA
	WHERE	F_TIEMPO_FECHA=@PP_F_TIEMPO_FECHA

GO


-- //////////////////////////////////////////////////////////////
-- // PROCESAR 
-- //////////////////////////////////////////////////////////////
-- EXECUTE [PG_CI_TIEMPO_FECHA_X_RANGO] '2015-01-01', '2015-01-10'

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]
GO


CREATE PROCEDURE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]
	@PP_L_DEBUG			INT,
	@PP_K_SISTEMA_EXE	INT,
	@PP_F_INICIO		DATE,
	@PP_F_FIN			DATE
AS

	DECLARE @VP_K_TIEMPO_DIA_SEMANA		INT
	DECLARE @VP_N_SEMANA				INT

	SET @VP_N_SEMANA = 1

	-- ==============================

	IF @PP_F_INICIO<@PP_F_FIN	
		BEGIN
		-- ==============================

		DECLARE @VP_F_PIVOTE	DATE

		SET @VP_F_PIVOTE =	@PP_F_INICIO
		
		-- ==============================
	
		PRINT	'/////////////////////////////////////////////////////////////'
		PRINT	@PP_F_INICIO

		WHILE ( @VP_F_PIVOTE<=@PP_F_FIN )
			BEGIN
			
			IF @PP_L_DEBUG=1
				PRINT	@VP_F_PIVOTE

			-- ==============================	

			SET	 @VP_K_TIEMPO_DIA_SEMANA =	DATEPART(DW, @VP_F_PIVOTE)	

			IF @VP_K_TIEMPO_DIA_SEMANA=2
				SET @VP_N_SEMANA = @VP_N_SEMANA+1

			-- ==============================	
			
			EXECUTE [dbo].[PG_DL_TIEMPO_FECHA] 			@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @VP_F_PIVOTE
		
			EXECUTE [dbo].[PG_IN_TIEMPO_FECHA_X_FECHA] 	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @VP_F_PIVOTE, @VP_N_SEMANA

			-- ==============================	
	
			SET @VP_F_PIVOTE  = DATEADD( d, 1, @VP_F_PIVOTE )
	
			END
	
		IF @PP_L_DEBUG=1
			PRINT	'/////////////////////////////////////////////////////////////'

		END
	
	-- ==============================	

GO


-- ===============================================



-- ===============================================
SET NOCOUNT ON
-- ===============================================
--//////////////////////////////////////  AX 20190131   //   SE AGREGAN FECHAS
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1940-01-01', '1941-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1941-01-01', '1942-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1942-01-01', '1943-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1943-01-01', '1944-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1944-01-01', '1945-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1945-01-01', '1946-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1946-01-01', '1947-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1947-01-01', '1948-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1948-01-01', '1949-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1949-01-01', '1950-01-01'
--================================================
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1950-01-01', '1951-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1951-01-01', '1952-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1952-01-01', '1953-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1953-01-01', '1954-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1954-01-01', '1955-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1955-01-01', '1956-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1956-01-01', '1957-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1957-01-01', '1958-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1958-01-01', '1959-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1959-01-01', '1960-01-01'
--================================================
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1960-01-01', '1961-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1961-01-01', '1962-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1962-01-01', '1963-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1963-01-01', '1964-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1964-01-01', '1965-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1965-01-01', '1966-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1966-01-01', '1967-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1967-01-01', '1968-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1968-01-01', '1969-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1969-01-01', '1970-01-01'
--================================================
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1970-01-01', '1971-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1971-01-01', '1972-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1972-01-01', '1973-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1973-01-01', '1974-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1974-01-01', '1975-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1975-01-01', '1976-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1976-01-01', '1977-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1977-01-01', '1978-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1978-01-01', '1979-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1979-01-01', '1980-01-01'
--================================================
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1980-01-01', '1981-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1981-01-01', '1982-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1982-01-01', '1983-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1983-01-01', '1984-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1984-01-01', '1985-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1985-01-01', '1986-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1986-01-01', '1987-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1987-01-01', '1988-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1988-01-01', '1989-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1989-01-01', '1990-01-01'
--================================================
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1990-01-01', '1991-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1991-01-01', '1992-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1992-01-01', '1993-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1993-01-01', '1994-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1994-01-01', '1995-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1995-01-01', '1996-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1996-01-01', '1997-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1997-01-01', '1998-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1998-01-01', '1999-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '1999-01-01', '2000-01-01'
--================================================
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2000-01-01', '2001-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2001-01-01', '2002-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2002-01-01', '2003-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2003-01-01', '2004-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2004-01-01', '2005-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2005-01-01', '2006-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2006-01-01', '2007-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2007-01-01', '2008-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2008-01-01', '2009-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2009-01-01', '2010-01-01'
--================================================
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2010-01-01', '2011-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2011-01-01', '2012-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2012-01-01', '2013-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2013-01-01', '2014-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2014-01-01', '2015-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2015-01-01', '2016-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2016-01-01', '2017-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2017-01-01', '2018-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2018-01-01', '2019-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2019-01-01', '2020-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2020-01-01', '2021-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2021-01-01', '2022-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2022-01-01', '2023-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2023-01-01', '2024-01-01'
EXECUTE [dbo].[PG_CI_TIEMPO_FECHA_X_RANGO]	0, 0, '2024-01-01', '2025-01-01'
GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================




-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
