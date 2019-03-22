-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:		CYC19_Credito_y_Cobranza
-- // MÓDULO:				REMISIÓN_CYC
-- // OPERACIÓN:			LIBERACIÓN / STORED PROCEDURES
-- ////////////////////////////////////////////////////////////// 
-- // Autor:				DANIEL PORTILLO ROMERO
-- // Fecha creación:		31/ENE/2019
-- // Modificador:			DANIEL PORTILLO ROMERO
-- // Fecha modificación:	06/FEB/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0]
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////
-- SELECT * FROM REMISION_CYC
-- EXECUTE [PG_LI_REMISION_CYC] 0,0,0, '', -1, -1

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_REMISION_CYC]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_REMISION_CYC]
GO

CREATE PROCEDURE [dbo].[PG_LI_REMISION_CYC]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- =========================================	
	@PP_BUSCAR						VARCHAR(255),
	@PP_K_ORIGEN_REMISION			INT,
	@PP_K_CLIENTE_CYC				INT,
	@PP_K_ESTATUS_REMISION_CYC		INT,
	@PP_K_UNIDAD_OPERATIVA			INT,
	@PP_K_TIPO_TRANSACCION			INT,
	@PP_K_PRODUCTO					INT,
	-- =========================================	
	@PP_F_INICIO					DATE,
	@PP_F_FIN						DATE
AS

	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	DECLARE @VP_L_APLICAR_MAX_ROWS	INT = 1
		
	-- ///////////////////////////////////////////

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_SELECT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													11, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- ///////////////////////////////////////////

	DECLARE @VP_INT_NUMERO_REGISTROS	INT

	EXECUTE [dbo].[PG_SK_CONFIGURACION_LISTADO_MAX_ROWS_PESADO_GET]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
																		@VP_L_APLICAR_MAX_ROWS,		
																		@OU_MAXROWS = @VP_INT_NUMERO_REGISTROS		OUTPUT	
	-- =========================================		

	DECLARE @VP_K_FOLIO		INT

	EXECUTE [dbo].[PG_RN_OBTENER_ID_X_REFERENCIA]	@PP_BUSCAR, 
													@OU_K_ELEMENTO = @VP_K_FOLIO	OUTPUT
	-- =========================================
	
	DECLARE @VP_L_VER_BORRADOS		INT		
	
	EXECUTE [dbo].[PG_RN_DATA_VER_BORRADOS]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@OU_L_VER_BORRADOS = @VP_L_VER_BORRADOS			OUTPUT
	-- =========================================
	
	IF @VP_MENSAJE<>''
		SET @VP_INT_NUMERO_REGISTROS = 0

	SELECT	TOP ( @VP_INT_NUMERO_REGISTROS )				
				REMISION_CYC.*,
				S_ORIGEN_REMISION,		D_ORIGEN_REMISION,	
				S_CLIENTE_CYC,			D_CLIENTE_CYC,
				S_ESTATUS_REMISION_CYC,	D_ESTATUS_REMISION_CYC,
				S_UNIDAD_OPERATIVA,		D_UNIDAD_OPERATIVA,	
				S_TIPO_TRANSACCION,		D_TIPO_TRANSACCION,
				S_PRODUCTO,				D_PRODUCTO,	
				(TASA_IVA * 100) AS TASA_IVA_100,
				D_TIEMPO_FECHA	AS F_REMISION_CYC_DDMMMYYYY,
				D_USUARIO		AS D_USUARIO_CAMBIO			
				-- =====================
	FROM		REMISION_CYC
	INNER JOIN	ORIGEN_REMISION			ON	REMISION_CYC.K_ORIGEN_REMISION=ORIGEN_REMISION.K_ORIGEN_REMISION
	INNER JOIN	CLIENTE_CYC				ON	REMISION_CYC.K_CLIENTE_CYC=CLIENTE_CYC.K_CLIENTE_CYC
	INNER JOIN	ESTATUS_REMISION_CYC	ON	REMISION_CYC.K_ESTATUS_REMISION_CYC=ESTATUS_REMISION_CYC.K_ESTATUS_REMISION_CYC
	INNER JOIN	UNIDAD_OPERATIVA		ON	REMISION_CYC.K_UNIDAD_OPERATIVA=UNIDAD_OPERATIVA.K_UNIDAD_OPERATIVA
	INNER JOIN	TIPO_TRANSACCION		ON	REMISION_CYC.K_TIPO_TRANSACCION=TIPO_TRANSACCION.K_TIPO_TRANSACCION
	INNER JOIN	PRODUCTO				ON	REMISION_CYC.K_PRODUCTO=PRODUCTO.K_PRODUCTO
	INNER JOIN	USUARIO					ON	REMISION_CYC.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
	INNER JOIN	TIEMPO_FECHA			ON	REMISION_CYC.F_REMISION_CYC=TIEMPO_FECHA.F_TIEMPO_FECHA
				-- =====================
	WHERE	(	REMISION_CYC.L_BORRADO = 0	OR	@VP_L_VER_BORRADOS = 1	)
	AND		(		CLIENTE_CYC.D_CLIENTE_CYC				LIKE '%'+ @PP_BUSCAR +'%' 
				OR	CLIENTE_CYC.C_CLIENTE_CYC				LIKE '%'+ @PP_BUSCAR +'%'
				OR	CLIENTE_CYC.S_CLIENTE_CYC				LIKE '%'+ @PP_BUSCAR +'%'	
				OR	CLIENTE_CYC.NOMBRE						LIKE '%'+ @PP_BUSCAR +'%'
				OR	CLIENTE_CYC.APELLIDO_PATERNO			LIKE '%'+ @PP_BUSCAR +'%'
				OR	CLIENTE_CYC.APELLIDO_MATERNO			LIKE '%'+ @PP_BUSCAR +'%'
				-- =====================
				OR	REMISION_CYC.SERIE_REMISION				LIKE '%'+ @PP_BUSCAR +'%' 
				OR	REMISION_CYC.FOLIO_REMISION				LIKE '%'+ @PP_BUSCAR +'%'
				OR	REMISION_CYC.C_REMISION_CYC				LIKE '%'+ @PP_BUSCAR +'%' 
				-- =====================
				OR	ORIGEN_REMISION.D_ORIGEN_REMISION		LIKE '%'+ @PP_BUSCAR +'%'
				OR	UNIDAD_OPERATIVA.D_UNIDAD_OPERATIVA		LIKE '%'+ @PP_BUSCAR +'%'		
				OR	TIPO_TRANSACCION.D_TIPO_TRANSACCION		LIKE '%'+ @PP_BUSCAR +'%'
				OR	PRODUCTO.D_PRODUCTO						LIKE '%'+ @PP_BUSCAR +'%'
				-- =====================
				OR	REMISION_CYC.PRECIO_UNITARIO			LIKE '%'+ @PP_BUSCAR +'%'
				OR	REMISION_CYC.TOTAL_REM					LIKE '%'+ @PP_BUSCAR +'%'
				-- =====================
				OR	REMISION_CYC.K_REMISION_CYC=@VP_K_FOLIO 
				OR	REMISION_CYC.K_REMISION_LIQ=@VP_K_FOLIO	
				OR	REMISION_CYC.K_LIQUIDACION=@VP_K_FOLIO 
				OR	REMISION_CYC.K_PRODUCTO=@VP_K_FOLIO 
				OR	REMISION_CYC.K_CLIENTE_CYC=@VP_K_FOLIO 
				OR	REMISION_CYC.K_UNIDAD_OPERATIVA=@VP_K_FOLIO 								)	
				-- =====================
	AND			( @PP_K_ORIGEN_REMISION=-1			OR	ORIGEN_REMISION.K_ORIGEN_REMISION = @PP_K_ORIGEN_REMISION		)
	AND			( @PP_K_CLIENTE_CYC=-1				OR	CLIENTE_CYC.K_CLIENTE_CYC = @PP_K_CLIENTE_CYC					)
	AND			( @PP_K_ESTATUS_REMISION_CYC=-1		OR	PRODUCTO.K_PRODUCTO = @PP_K_ESTATUS_REMISION_CYC				)
	AND			( @PP_K_UNIDAD_OPERATIVA=-1			OR	UNIDAD_OPERATIVA.K_UNIDAD_OPERATIVA	= @PP_K_UNIDAD_OPERATIVA	)
	AND			( @PP_K_TIPO_TRANSACCION=-1			OR	TIPO_TRANSACCION.K_TIPO_TRANSACCION	= @PP_K_TIPO_TRANSACCION	)
	AND			( @PP_K_PRODUCTO=-1					OR	ESTATUS_REMISION_CYC.K_ESTATUS_REMISION_CYC = @PP_K_PRODUCTO	)
				-- =====================
	AND			( @PP_F_INICIO IS NULL				OR	@PP_F_INICIO<=F_REMISION_CYC	)
	AND			( @PP_F_FIN	IS NULL					OR	@PP_F_FIN>=F_REMISION_CYC		)
				-- =====================
	ORDER BY	F_REMISION_CYC DESC
	
	-- /////////////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													2,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'SELECT',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_LI_REMISION_CYC]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													0, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, @PP_BUSCAR, '' , 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '@PP_BUSCAR', '', '', ''

	-- /////////////////////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////
-- EXECUTE [PG_SK_REMISION_CYC] 0,0,0, 23

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_REMISION_CYC]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_REMISION_CYC]
GO

CREATE PROCEDURE [dbo].[PG_SK_REMISION_CYC]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- =============================
	@PP_K_REMISION_CYC			INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300) = ''
	
	-- ///////////////////////////////////////////

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_SEEK]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													11, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- ///////////////////////////////////////////
	
	DECLARE @VP_L_VER_BORRADOS		INT		
	
	EXECUTE [dbo].[PG_RN_DATA_VER_BORRADOS]			@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@OU_L_VER_BORRADOS = @VP_L_VER_BORRADOS		OUTPUT
	-- ///////////////////////////////////////////
	
	DECLARE @VP_INT_NUMERO_REGISTROS INT = 1

	IF @VP_MENSAJE<>''
		SET @VP_INT_NUMERO_REGISTROS = 0
	
	SELECT	TOP ( @VP_INT_NUMERO_REGISTROS )
				REMISION_CYC.*,
				S_ORIGEN_REMISION,		D_ORIGEN_REMISION,	
				S_CLIENTE_CYC,			D_CLIENTE_CYC,
				S_ESTATUS_REMISION_CYC,	D_ESTATUS_REMISION_CYC,
				S_UNIDAD_OPERATIVA,		D_UNIDAD_OPERATIVA,	
				S_TIPO_TRANSACCION,		D_TIPO_TRANSACCION,
				S_PRODUCTO,				D_PRODUCTO,	
				(TASA_IVA * 100) AS TASA_IVA_100,
				D_USUARIO AS D_USUARIO_CAMBIO	
				-- =====================
	FROM		REMISION_CYC
	INNER JOIN	ORIGEN_REMISION			ON	REMISION_CYC.K_ORIGEN_REMISION=ORIGEN_REMISION.K_ORIGEN_REMISION
	INNER JOIN	CLIENTE_CYC				ON	REMISION_CYC.K_CLIENTE_CYC=CLIENTE_CYC.K_CLIENTE_CYC
	INNER JOIN	ESTATUS_REMISION_CYC	ON	REMISION_CYC.K_ESTATUS_REMISION_CYC=ESTATUS_REMISION_CYC.K_ESTATUS_REMISION_CYC
	INNER JOIN	UNIDAD_OPERATIVA		ON	REMISION_CYC.K_UNIDAD_OPERATIVA=UNIDAD_OPERATIVA.K_UNIDAD_OPERATIVA
	INNER JOIN	TIPO_TRANSACCION		ON	REMISION_CYC.K_TIPO_TRANSACCION=TIPO_TRANSACCION.K_TIPO_TRANSACCION
	INNER JOIN	PRODUCTO				ON	REMISION_CYC.K_PRODUCTO=PRODUCTO.K_PRODUCTO
	INNER JOIN	USUARIO					ON	REMISION_CYC.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
				-- =====================
	WHERE	(	REMISION_CYC.L_BORRADO=0		OR		@VP_L_VER_BORRADOS=1	)
				-- =====================
	AND			REMISION_CYC.K_REMISION_CYC=@PP_K_REMISION_CYC		

	-----////////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													2,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'SEEK',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_SK_REMISION_CYC]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_REMISION_CYC, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, '', '' , 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '', '', ''

	-- ////////////////////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_REMISION_CYC]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_REMISION_CYC]
GO

CREATE PROCEDURE [dbo].[PG_IN_REMISION_CYC]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- =================================
	@PP_K_ORIGEN_REMISION			INT,	
	@PP_K_CLIENTE_CYC				INT,	
	@PP_F_REMISION_CYC				DATE,	
	@PP_K_ESTATUS_REMISION_CYC		INT,	
	@PP_L_FACTURADO					INT,	
	@PP_L_PAGADO					INT,	
	@PP_D_REMISION_CYC				VARCHAR(255),	
	@PP_C_REMISION_CYC				VARCHAR(500),	
	-- =================================			
	@PP_K_UNIDAD_OPERATIVA			INT,		
--	@PP_K_REMISION_LIQ				INT,		
	-- =================================			
--	@PP_K_CLIENTE_LIQ				INT,		
	@PP_K_TIPO_TRANSACCION			INT,	
--	@PP_K_ESTATUS_REMISION_LIQ		INT,	
	-- =================================
--	@PP_K_LIQUIDACION				INT,	
--	@PP_F_REMISION_LIQ				DATE,	
	@PP_SERIE_REMISION				VARCHAR(20),	
	@PP_FOLIO_REMISION				VARCHAR(20),	
	-- =================================
	@PP_K_PRODUCTO					INT,	
	@PP_CANTIDAD					DECIMAL(19, 4),	
	@PP_PRECIO_UNITARIO				DECIMAL(19, 4),
	-- =================================
	@PP_TASA_IVA					DECIMAL(19, 4)
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300) = ''

	-- /////////////////////////////////////////////////////////////////////
	
	DECLARE @VP_K_REMISION_CYC		INT = 0

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_REMISION_CYC_INSERT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@VP_K_REMISION_CYC, @PP_D_REMISION_CYC, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- /////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		BEGIN

		DECLARE @VP_TASA_IVA		DECIMAL(19, 4) = 0
		DECLARE @VP_SUBTOTAL_REM	DECIMAL(19, 4) = 0
		DECLARE @VP_IVA_REM			DECIMAL(19, 4) = 0
		DECLARE @VP_TOTAL_REM		DECIMAL(19, 4) = 0

		SET @VP_TASA_IVA		= ( @PP_TASA_IVA / 100 )
		SET @VP_TOTAL_REM		= ( @PP_CANTIDAD * @PP_PRECIO_UNITARIO )
		SET @VP_SUBTOTAL_REM	= ( @VP_TOTAL_REM / (1 + @VP_TASA_IVA) )
		SET @VP_IVA_REM			= ( @VP_TOTAL_REM - @VP_SUBTOTAL_REM )

		-- /////////////////////////////////////////

		DECLARE @VP_K_REMISION_LIQ			INT = 0
		DECLARE @VP_K_CLIENTE_LIQ			INT = 0
		DECLARE @VP_K_ESTATUS_REMISION_LIQ	INT = 1
		DECLARE @VP_K_LIQUIDACION			INT = 0
		DECLARE @VP_F_REMISION_LIQ			DATE = @PP_F_REMISION_CYC

		-- /////////////////////////////////////////
	
		EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
													'REMISION_CYC', 
													@OU_K_TABLA_DISPONIBLE = @VP_K_REMISION_CYC			OUTPUT
		-- /////////////////////////////////////////
		
		INSERT INTO REMISION_CYC
			(	K_REMISION_CYC,				
				K_ORIGEN_REMISION,			K_CLIENTE_CYC,	
				F_REMISION_CYC,				K_ESTATUS_REMISION_CYC,					
				L_FACTURADO,				L_PAGADO,				
				D_REMISION_CYC,				C_REMISION_CYC,			
				-- ================================================
				K_UNIDAD_OPERATIVA,			K_REMISION_LIQ,			
				-- ================================================
				K_CLIENTE_LIQ,			
				K_TIPO_TRANSACCION,			K_ESTATUS_REMISION_LIQ,
				-- ================================================
				K_LIQUIDACION,				F_REMISION_LIQ,			
				SERIE_REMISION,				FOLIO_REMISION,			
				-- ================================================
				K_PRODUCTO,				
				CANTIDAD,					PRECIO_UNITARIO,		
				-- ================================================
				TASA_IVA,					SUBTOTAL_REM,
				IVA_REM,					TOTAL_REM,									
				-- ================================================
				K_USUARIO_ALTA,				F_ALTA,
				K_USUARIO_CAMBIO,			F_CAMBIO,
				L_BORRADO,
				K_USUARIO_BAJA,				F_BAJA					)
		VALUES	
			(	@VP_K_REMISION_CYC,			
				@PP_K_ORIGEN_REMISION,		@PP_K_CLIENTE_CYC,			
				@PP_F_REMISION_CYC,			@PP_K_ESTATUS_REMISION_CYC,	
				@PP_L_FACTURADO,			@PP_L_PAGADO,				
				@PP_D_REMISION_CYC,			@PP_C_REMISION_CYC,			
				-- =====================================================
				@PP_K_UNIDAD_OPERATIVA,		@VP_K_REMISION_LIQ,			
				-- =====================================================
				@VP_K_CLIENTE_LIQ,			
				@PP_K_TIPO_TRANSACCION,		@VP_K_ESTATUS_REMISION_LIQ,	
				-- =====================================================
				@VP_K_LIQUIDACION,			@VP_F_REMISION_LIQ,		
				@PP_SERIE_REMISION,			@PP_FOLIO_REMISION,			
				-- =====================================================
				@PP_K_PRODUCTO,				
				@PP_CANTIDAD,				@PP_PRECIO_UNITARIO,			
				-- =====================================================
				@VP_TASA_IVA,				@VP_SUBTOTAL_REM,
				@VP_IVA_REM,				@VP_TOTAL_REM,											
				-- =====================================================
				@PP_K_USUARIO_ACCION,		GETDATE(),
				@PP_K_USUARIO_ACCION,		GETDATE(),
				0,
				NULL, NULL											)			
		END

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible crear la [Remisión]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Rem.'+CONVERT(VARCHAR(10),@VP_K_REMISION_CYC)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
		
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_REMISION_CYC AS CLAVE

	-- //////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													3,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'INSERT',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_IN_REMISION_CYC]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@VP_K_REMISION_CYC, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, @PP_D_REMISION_CYC, '', 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '@PP_REMISION_CYC', '', '', ''

	-- //////////////////////////////////////////////////////////////
GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> UPDATE / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_REMISION_CYC]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_REMISION_CYC]
GO

CREATE PROCEDURE [dbo].[PG_UP_REMISION_CYC]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- =================================
	@PP_K_REMISION_CYC				INT,
	-- =================================
	@PP_K_ORIGEN_REMISION			INT,	
	@PP_K_CLIENTE_CYC				INT,	
	@PP_F_REMISION_CYC				DATE,	
	@PP_K_ESTATUS_REMISION_CYC		INT,	
	@PP_L_FACTURADO					INT,	
	@PP_L_PAGADO					INT,	
	@PP_D_REMISION_CYC				VARCHAR(255),	
	@PP_C_REMISION_CYC				VARCHAR(500),	
	-- =================================
	@PP_K_UNIDAD_OPERATIVA			INT,
	-- =================================
	@PP_K_TIPO_TRANSACCION			INT,	
	-- =================================
	@PP_SERIE_REMISION				VARCHAR(20),	
	@PP_FOLIO_REMISION				VARCHAR(20),		
	-- =================================
	@PP_K_PRODUCTO					INT,	
	@PP_CANTIDAD					DECIMAL(19, 4),	
	@PP_PRECIO_UNITARIO				DECIMAL(19, 4),
	-- =================================
	@PP_TASA_IVA					DECIMAL(19, 4)
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300) = ''

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_REMISION_CYC_UPDATE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_REMISION_CYC, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- /////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		BEGIN

		DECLARE @VP_TASA_IVA		DECIMAL(19, 4) = 0
		DECLARE @VP_TOTAL_REM		DECIMAL(19, 4) = 0
		DECLARE @VP_SUBTOTAL_REM	DECIMAL(19, 4) = 0
		DECLARE @VP_IVA_REM			DECIMAL(19, 4) = 0

		SET @VP_TASA_IVA		= ( @PP_TASA_IVA / 100 )
		SET @VP_TOTAL_REM		= ( @PP_CANTIDAD * @PP_PRECIO_UNITARIO )
		SET @VP_SUBTOTAL_REM	= ( @VP_TOTAL_REM / (1 + @VP_TASA_IVA) )
		SET @VP_IVA_REM			= ( @VP_TOTAL_REM - @VP_SUBTOTAL_REM )

		-- /////////////////////////////////////////

--		DECLARE @VP_K_REMISION_LIQ			INT = 0
--		DECLARE @VP_K_CLIENTE_LIQ			INT = 0
--		DECLARE @VP_K_ESTATUS_REMISION_LIQ	INT = 0
--		DECLARE @VP_K_LIQUIDACION			INT = 0
--		DECLARE @VP_F_REMISION_LIQ			DATE = NULL

		-- /////////////////////////////////////////

		UPDATE	REMISION_CYC
		SET		
				K_REMISION_CYC			= @PP_K_REMISION_CYC,			
				-- ==================================================
				K_ORIGEN_REMISION		= @PP_K_ORIGEN_REMISION,		
				K_CLIENTE_CYC			= @PP_K_CLIENTE_CYC,			
				F_REMISION_CYC			= @PP_F_REMISION_CYC,					
				K_ESTATUS_REMISION_CYC	= @PP_K_ESTATUS_REMISION_CYC,			
				L_FACTURADO				= @PP_L_FACTURADO,							
				L_PAGADO				= @PP_L_PAGADO,					
				D_REMISION_CYC			= @PP_D_REMISION_CYC,				
				C_REMISION_CYC			= @PP_C_REMISION_CYC,	
				-- ==================================================	
				K_UNIDAD_OPERATIVA		= @PP_K_UNIDAD_OPERATIVA,				
				-- ==================================================	
				K_TIPO_TRANSACCION		= @PP_K_TIPO_TRANSACCION,				
				-- ==================================================							
				SERIE_REMISION			= @PP_SERIE_REMISION,			
				FOLIO_REMISION			= @PP_FOLIO_REMISION,			
				-- ==================================================
				K_PRODUCTO				= @PP_K_PRODUCTO,				
				CANTIDAD				= @PP_CANTIDAD,				
				PRECIO_UNITARIO			= @PP_PRECIO_UNITARIO,			
				-- ================================================== 
				TASA_IVA				= @VP_TASA_IVA,
				SUBTOTAL_REM			= @VP_SUBTOTAL_REM,
				IVA_REM					= @VP_IVA_REM,
				TOTAL_REM				= @VP_TOTAL_REM,
				-- ==================================================	
				K_USUARIO_CAMBIO		= @PP_K_USUARIO_ACCION, 
				F_CAMBIO				= GETDATE() 
		WHERE	K_REMISION_CYC=@PP_K_REMISION_CYC
	
		END

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible actualizar la [Remisión]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Rem.'+CONVERT(VARCHAR(10),@PP_K_REMISION_CYC)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
			
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_REMISION_CYC AS CLAVE

	-- //////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													3,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'UPDATE',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_UP_REMISION_CYC]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_REMISION_CYC, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, @PP_K_ESTATUS_REMISION_CYC, '', 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '@PP_D_REMISION_CYC', '', '', ''

	-- //////////////////////////////////////////////////////////////

GO




-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> UPDATE / FICHA CLIENTE
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_REMISION_CYC_CLIENTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_REMISION_CYC_CLIENTE]
GO

CREATE PROCEDURE [dbo].[PG_UP_REMISION_CYC_CLIENTE]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- =============================
	@PP_K_REMISION_CYC			INT,
	-- =============================
	@PP_K_CLIENTE_CYC			INT
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300) = ''

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_REMISION_CYC_UPDATE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_REMISION_CYC, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- /////////////////////////////////////////
		
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_REMISION_CYC_PENDIENTE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_REMISION_CYC,	 
														@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- ///////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		BEGIN

		UPDATE	REMISION_CYC
		SET		
				K_CLIENTE_CYC		= @PP_K_CLIENTE_CYC,	
				-- ==========================================
				K_USUARIO_CAMBIO	= @PP_K_USUARIO_ACCION, 
				F_CAMBIO			= GETDATE() 
		WHERE	K_REMISION_CYC=@PP_K_REMISION_CYC
	
		END

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible actualizar el Cliente de la [Remisión]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Rem.'+CONVERT(VARCHAR(10),@PP_K_REMISION_CYC)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
			
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_REMISION_CYC AS CLAVE

	-- //////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													3,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'UPDATE',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_UP_REMISION_CYC_CLIENTE]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_REMISION_CYC, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, @PP_K_REMISION_CYC, '', 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '@PP_K_CLIENTE_CYC', '', '', ''

	-- //////////////////////////////////////////////////////////////
GO





-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> UPDATE / FICHA FECHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_REMISION_CYC_FECHA]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_REMISION_CYC_FECHA]
GO

CREATE PROCEDURE [dbo].[PG_UP_REMISION_CYC_FECHA]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- =============================
	@PP_K_REMISION_CYC			INT,
	-- =============================
	@PP_F_REMISION_CYC			DATE
AS			

	DECLARE @VP_MENSAJE		VARCHAR(300) = ''

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_REMISION_CYC_UPDATE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_REMISION_CYC, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- /////////////////////////////////////////
		
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_REMISION_CYC_PENDIENTE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_REMISION_CYC,	 
														@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- ///////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		BEGIN

		UPDATE	REMISION_CYC
		SET		
				F_REMISION_CYC		= @PP_F_REMISION_CYC,	
				-- ========================================
				K_USUARIO_CAMBIO	= @PP_K_USUARIO_ACCION, 
				F_CAMBIO			= GETDATE() 
		WHERE	K_REMISION_CYC=@PP_K_REMISION_CYC
	
		END

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible actualizar la Fecha de la [Remisión]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Rem.'+CONVERT(VARCHAR(10),@PP_K_REMISION_CYC)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
			
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_REMISION_CYC AS CLAVE

	-- //////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													3,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'UPDATE',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_UP_REMISION_CYC_FECHA]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_REMISION_CYC, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, @PP_K_REMISION_CYC, '', 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '@PP_F_REMISION_CYC', '', '', ''

	-- //////////////////////////////////////////////////////////////
GO





-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_REMISION_CYC]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_REMISION_CYC]
GO


CREATE PROCEDURE [dbo].[PG_DL_REMISION_CYC]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- =============================
	@PP_K_REMISION_CYC			INT
AS

	DECLARE @VP_MENSAJE		VARCHAR(300) =	''

	-- //////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_REMISION_CYC_DELETE]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@PP_K_REMISION_CYC, 
												@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- /////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		BEGIN

		UPDATE	REMISION_CYC
		SET		
				L_BORRADO			= 1,
				-- ====================
				F_BAJA				= GETDATE(), 
				K_USUARIO_BAJA		= @PP_K_USUARIO_ACCION
		WHERE	K_REMISION_CYC=@PP_K_REMISION_CYC

		END

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible borrar la [Remisión]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Rem.'+CONVERT(VARCHAR(10),@PP_K_REMISION_CYC)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
		
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_REMISION_CYC AS CLAVE

	-- /////////////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													5,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'DELETE',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_DL_REMISION_CYC]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_REMISION_CYC, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, '', '' , 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '', '', ''

	-- /////////////////////////////////////////////////////////////////////
GO




-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////

