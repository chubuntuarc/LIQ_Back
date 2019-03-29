-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19
-- // MODULO:			OPERADOR
-- // OPERACION:		LIBERACION / STORED PROCEDURES
-- //////////////////////////////////////////////////////////////
-- // Autor:			AX DE LA ROSA
-- // Fecha creación:	01/FEB/2019
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////



-- EXECUTE [dbo].[PG_LI_OPERADOR] 0,0,0,'',-1,-1,-1,NULL,NULL
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_OPERADOR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_OPERADOR]
GO


CREATE PROCEDURE [dbo].[PG_LI_OPERADOR]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ==============================================
	@PP_BUSCAR						VARCHAR(200),
	-- ==============================================
	@PP_K_ESTATUS_OPERADOR			INT,
	@PP_F_INICIO					DATE,
	@PP_F_FIN						DATE
AS

	DECLARE @VP_MENSAJE					VARCHAR(300) = ''
	DECLARE @VP_L_APLICAR_MAX_ROWS		INT = 0
	
	-- ///////////////////////////////////////////

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_SELECT]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													1, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- ///////////////////////////////////////////

	DECLARE @VP_LI_N_REGISTROS	INT

	EXECUTE [dbo].[PG_SK_CONFIGURACION_LISTADO_MAX_ROWS_PESADO_GET]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
																		@VP_L_APLICAR_MAX_ROWS,		
																		@OU_MAXROWS = @VP_LI_N_REGISTROS		OUTPUT	
	-- =========================================		

	DECLARE @VP_K_FOLIO		INT

	EXECUTE [dbo].[PG_RN_OBTENER_ID_X_REFERENCIA]		@PP_BUSCAR, 
														@OU_K_ELEMENTO = @VP_K_FOLIO	OUTPUT
	-- =========================================
	
	DECLARE @VP_L_VER_BORRADOS		INT		
	
	EXECUTE [dbo].[PG_RN_DATA_VER_BORRADOS]			@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@OU_L_VER_BORRADOS = @VP_L_VER_BORRADOS			OUTPUT
	-- =========================================

	IF @VP_MENSAJE<>''
		SET @VP_LI_N_REGISTROS = 0

	-- =========================================
		
	SELECT	TOP (@VP_LI_N_REGISTROS)
				''												AS F_NACIMIENTO_DDMMMYYYY,
				TIEMPO_F_INGRESO.D_TIEMPO_FECHA					AS F_INGRESO_DDMMMYYYY,
				TIEMPO_F_VIGENCIA_LICENCIA.D_TIEMPO_FECHA		AS F_VIGENCIA_LICENCIA_DDMMMYYYY,
				OPERADOR.*,
				ESTATUS_OPERADOR.D_ESTATUS_OPERADOR, ESTATUS_OPERADOR.S_ESTATUS_OPERADOR,
				ESTADO_CIVIL.D_ESTADO_CIVIL, ESTADO_CIVIL.S_ESTADO_CIVIL,
				SEXO.D_SEXO, SEXO.S_SEXO,
				USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
			-- =====================
	FROM		OPERADOR, USUARIO,
				ESTATUS_OPERADOR, ESTADO_CIVIL,
				SEXO,
			--	TIEMPO_FECHA AS TIEMPO_F_NACIMIENTO,
				TIEMPO_FECHA AS TIEMPO_F_INGRESO,
				TIEMPO_FECHA AS TIEMPO_F_VIGENCIA_LICENCIA
			-- =====================
	WHERE		OPERADOR.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
			-- =====================
	AND			OPERADOR.K_ESTATUS_OPERADOR=ESTATUS_OPERADOR.K_ESTATUS_OPERADOR
	AND			OPERADOR.K_ESTADO_CIVIL=ESTADO_CIVIL.K_ESTADO_CIVIL
	AND			OPERADOR.K_SEXO=SEXO.K_SEXO
			-- =====================
	AND			OPERADOR.F_INGRESO=TIEMPO_F_INGRESO.F_TIEMPO_FECHA
	AND			OPERADOR.F_VIGENCIA_LICENCIA=TIEMPO_F_VIGENCIA_LICENCIA.F_TIEMPO_FECHA		
				-- =====================
	AND		(		OPERADOR.D_OPERADOR							LIKE '%'+@PP_BUSCAR+'%' 
				OR	OPERADOR.C_OPERADOR							LIKE '%'+@PP_BUSCAR+'%' 
				OR	OPERADOR.RFC								LIKE '%'+@PP_BUSCAR+'%'
				OR	OPERADOR.CURP								LIKE '%'+@PP_BUSCAR+'%'
				OR	OPERADOR.NSS								LIKE '%'+@PP_BUSCAR+'%'
				OR	OPERADOR.TELEFONO							LIKE '%'+@PP_BUSCAR+'%'
				OR	OPERADOR.CORREO							LIKE '%'+@PP_BUSCAR+'%'
				OR	OPERADOR.CALLE							LIKE '%'+@PP_BUSCAR+'%'
				OR	OPERADOR.COLONIA							LIKE '%'+@PP_BUSCAR+'%'
				OR	OPERADOR.MUNICIPIO						LIKE '%'+@PP_BUSCAR+'%'
				OR	OPERADOR.K_OPERADOR=@VP_K_FOLIO 
			)	
			-- =====================
	AND		(	
				(( @PP_F_INICIO IS NULL				OR	@PP_F_INICIO<=OPERADOR.F_VIGENCIA_LICENCIA )
				AND
				( @PP_F_FIN	IS NULL					OR	@PP_F_FIN>=OPERADOR.F_VIGENCIA_LICENCIA )		)
			OR	(( @PP_F_INICIO IS NULL				OR	@PP_F_INICIO<=OPERADOR.F_INGRESO )
				AND
				( @PP_F_FIN	IS NULL					OR	@PP_F_FIN>=OPERADOR.F_INGRESO  )				)
			OR
				(( @PP_F_INICIO IS NULL				OR	@PP_F_INICIO<=OPERADOR.F_NACIMIENTO )
				AND
				( @PP_F_FIN	IS NULL					OR	@PP_F_FIN>=OPERADOR.F_NACIMIENTO )			)

			)
			-- =====================
	AND		( @PP_K_ESTATUS_OPERADOR=-1				OR	OPERADOR.K_ESTATUS_OPERADOR=@PP_K_ESTATUS_OPERADOR )
			-- =====================
	AND		( OPERADOR.L_BORRADO=0					OR	@VP_L_VER_BORRADOS=1 )	
			-- =====================		
	ORDER BY K_OPERADOR DESC
			
	-- /////////////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													2,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'SELECT',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_LI_OPERADOR]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													0, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, @PP_BUSCAR, '' , 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '@PP_BUSCAR', '', '', ''

	-- /////////////////////////////////////////////////////////////////////
GO


--EXECUTE [dbo].[PG_SK_OPERADOR] 0,0,0,400

-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_OPERADOR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_OPERADOR]
GO

-- EXEC [dbo].[PG_SK_OPERADOR] 0,2005,18,430

CREATE PROCEDURE [dbo].[PG_SK_OPERADOR]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_OPERADOR					INT
AS

	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	
	-- ///////////////////////////////////////////

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_DATA_ACCESO_SEEK]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,	
													1, -- @PP_K_DATA_SISTEMA,	
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- ///////////////////////////////////////////
	
	DECLARE @VP_L_VER_BORRADOS		INT		
	
	EXECUTE [dbo].[PG_RN_DATA_VER_BORRADOS]			@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@OU_L_VER_BORRADOS = @VP_L_VER_BORRADOS			OUTPUT
	-- ///////////////////////////////////////////

	DECLARE @VP_LI_N_REGISTROS		INT = 10

	IF @VP_MENSAJE<>''
		SET @VP_LI_N_REGISTROS = 0

	-- =========================================
		
	SELECT	TOP (@VP_LI_N_REGISTROS)
				''												AS F_NACIMIENTO_DDMMMYYYY,
				TIEMPO_F_INGRESO.D_TIEMPO_FECHA					AS F_INGRESO_DDMMMYYYY,
				TIEMPO_F_VIGENCIA_LICENCIA.D_TIEMPO_FECHA		AS F_VIGENCIA_LICENCIA_DDMMMYYYY,
				OPERADOR.*,
				ESTATUS_OPERADOR.D_ESTATUS_OPERADOR, ESTATUS_OPERADOR.S_ESTATUS_OPERADOR,
				ESTADO_CIVIL.D_ESTADO_CIVIL, ESTADO_CIVIL.S_ESTADO_CIVIL,
				SEXO.D_SEXO, SEXO.S_SEXO,
				USUARIO.D_USUARIO AS D_USUARIO_CAMBIO
			-- =====================
	FROM		OPERADOR, USUARIO,
				ESTATUS_OPERADOR, ESTADO_CIVIL,
				SEXO,
				TIEMPO_FECHA AS TIEMPO_F_INGRESO,
			--	TIEMPO_FECHA AS TIEMPO_F_NACIMIENTO,
				TIEMPO_FECHA AS TIEMPO_F_VIGENCIA_LICENCIA
			-- =====================
	WHERE		OPERADOR.K_USUARIO_CAMBIO=USUARIO.K_USUARIO
			-- =====================
	AND			OPERADOR.K_ESTATUS_OPERADOR=ESTATUS_OPERADOR.K_ESTATUS_OPERADOR
	AND			OPERADOR.K_ESTADO_CIVIL=ESTADO_CIVIL.K_ESTADO_CIVIL
	AND			OPERADOR.K_SEXO=SEXO.K_SEXO
			-- =====================
	AND			OPERADOR.F_INGRESO=TIEMPO_F_INGRESO.F_TIEMPO_FECHA
	AND			OPERADOR.F_VIGENCIA_LICENCIA=TIEMPO_F_VIGENCIA_LICENCIA.F_TIEMPO_FECHA
			-- =====================
	AND			OPERADOR.K_OPERADOR=@PP_K_OPERADOR
			-- =====================
		
	-----////////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													2,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'SEEK',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_SK_OPERADOR]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_OPERADOR, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, '', '' , 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '', '', ''

	-- ////////////////////////////////////////////////////////////////////
GO

--SELECT * FROM OPERADOR
--EXECUTE [dbo].[PG_IN_OPERADOR] 0, 0, 0, 'TEST 20190131' , 20 , 2 , 0, 2,'TEST', 'TEST', 'USUARIO PRUEBA' , 'AARA560301K62', 'USUARIOPRUEBA2019', '6755623565', '08-27-2012', '03-01-1956','04455 19761014','','GUARANA','MZ-13','LT-129','SANTA FE HOMEX','55600','ZUMPANGO','MOR05244','12-18-2018', 110.59,116.04

-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_OPERADOR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_OPERADOR]
GO


CREATE PROCEDURE [dbo].[PG_IN_OPERADOR]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================			
	@PP_C_OPERADOR					VARCHAR(500),	
	-- ============================			
	@PP_K_ESTATUS_OPERADOR			INT,			
	@PP_K_ESTADO_CIVIL				INT,			
	@PP_K_SEXO						INT,			
	-- ============================
	@PP_NOMBRE						VARCHAR(100),	
	@PP_APELLIDO_PATERNO			VARCHAR(100),	
	@PP_APELLIDO_MATERNO			VARCHAR(100),	
	@PP_RFC							VARCHAR(100),	
	@PP_CURP						VARCHAR(100),	
	@PP_NSS							VARCHAR(100),	
	@PP_F_NACIMIENTO				DATE,			
	@PP_F_INGRESO					DATE,			
	-- ============================
	@PP_TELEFONO					VARCHAR(100),	
	@PP_CORREO						VARCHAR(100),	
	@PP_CALLE						VARCHAR(100),	
	@PP_NUMERO_EXTERIOR				VARCHAR(100),	
	@PP_NUMERO_INTERIOR				VARCHAR(100),	
	@PP_COLONIA						VARCHAR(100),	
	@PP_CP							VARCHAR(100),  
	@PP_MUNICIPIO					VARCHAR(100),  
	-- ============================
	@PP_NUMERO_LICENCIA_OPERADOR		VARCHAR(100),	
	@PP_F_VIGENCIA_LICENCIA			DATE,			
	@PP_SALARIO_DIARIO				DECIMAL(10,4),
	@PP_SALARIO_DIARIO_INTEGRADO	DECIMAL(10,4)
AS			

	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	DECLARE @VP_D_OPERADOR VARCHAR(255)=CONCAT(@PP_APELLIDO_PATERNO,' ',@PP_APELLIDO_MATERNO,', ',@PP_NOMBRE)

	-- /////////////////////////////////////////////////////////////////////
	
	DECLARE @VP_K_OPERADOR		INT = 0
	
	EXECUTE [dbo].[PG_SK_CATALOGO_K_MAX_GET]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE,
												'OPERADOR', 
												@OU_K_TABLA_DISPONIBLE = @VP_K_OPERADOR			OUTPUT
	-- ==================================

	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_OPERADOR_INSERT]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@VP_K_OPERADOR, @PP_CURP,
												@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
															
	-- /////////////////////////////////////////////////////////////////////
	

	IF @VP_MENSAJE=''
		BEGIN	
				
		INSERT INTO OPERADOR
		(	[K_OPERADOR],							
			[D_OPERADOR], [O_OPERADOR], [C_OPERADOR],
			-- ============================
			[K_ESTATUS_OPERADOR],
			[K_ESTADO_CIVIL], [K_SEXO],
			-- ============================
			[NOMBRE], [APELLIDO_PATERNO],
			[APELLIDO_MATERNO], [RFC],								
			[CURP], [NSS],								
			[F_NACIMIENTO], [F_INGRESO], 					
			-- ============================
			[TELEFONO], [CORREO],							
			[CALLE], [NUMERO_EXTERIOR],					
			[NUMERO_INTERIOR], [COLONIA],							
			[CP], [MUNICIPIO],							
			-- ============================
			[NUMERO_LICENCIA_OPERADOR],			
			[F_VIGENCIA_LICENCIA],				
			[SALARIO_DIARIO],					
			[SALARIO_DIARIO_INTEGRADO],			
		-- ============================================
			[K_USUARIO_ALTA], [F_ALTA], 
			[K_USUARIO_CAMBIO], [F_CAMBIO],
			[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES	
		(	@VP_K_OPERADOR,					
			@VP_D_OPERADOR, 1,@PP_C_OPERADOR,					
			-- ============================
			@PP_K_ESTATUS_OPERADOR,			
			@PP_K_ESTADO_CIVIL, @PP_K_SEXO,						
			-- ============================
			@PP_NOMBRE, @PP_APELLIDO_PATERNO,			
			@PP_APELLIDO_MATERNO, @PP_RFC,							
			@PP_CURP, @PP_NSS,							
			@PP_F_NACIMIENTO, @PP_F_INGRESO,				
			-- ============================
			@PP_TELEFONO, @PP_CORREO,						
			@PP_CALLE, @PP_NUMERO_EXTERIOR,				
			@PP_NUMERO_INTERIOR, @PP_COLONIA,						
			@PP_CP, @PP_MUNICIPIO,					
			-- ============================
			@PP_NUMERO_LICENCIA_OPERADOR,		
			@PP_F_VIGENCIA_LICENCIA,		
			@PP_SALARIO_DIARIO,				
			@PP_SALARIO_DIARIO_INTEGRADO,
			-- ============================================
			@PP_K_USUARIO_ACCION, GETDATE(), 
			@PP_K_USUARIO_ACCION, GETDATE(),
			0, NULL, NULL )		
		END

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible insertar el [OPERADOR]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Cho.'+CONVERT(VARCHAR(10),@VP_K_OPERADOR)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
		
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_OPERADOR AS CLAVE
	
	-- //////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													3,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'INSERT',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_IN_OPERADOR]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@VP_K_OPERADOR, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													--0, 0, @PP_C_OPERADOR, '', 0.00, 0.00,
													0, 0, '', '', 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '', '', ''

	-- //////////////////////////////////////////////////////////////
GO


--EXECUTE [dbo].[PG_UP_OPERADOR] 0, 0, 0, 430,'TEST 20190131' , 20 , 2 , 0, 2,'USUARIO PRUEBA' ,'TEST', 'TEST', 'AARA560301K62', 'USUARIOPRUEBA2019', '6755623565', '08-27-2012', '03-01-1956','04455 19761014','','GUARANA','MZ-13','LT-129','SANTA FE HOMEX','55600','ZUMPANGO','MOR05244','12-18-2018', 110.59,116.04
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> UPDATE / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_OPERADOR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_OPERADOR]
GO

CREATE PROCEDURE [dbo].[PG_UP_OPERADOR]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_OPERADOR					INT,
	@PP_C_OPERADOR					VARCHAR(500),	
	-- ============================			
	@PP_K_ESTATUS_OPERADOR			INT,			
	@PP_K_ESTADO_CIVIL				INT,			
	@PP_K_SEXO						INT,			
	-- ============================
	@PP_NOMBRE						VARCHAR(100),	
	@PP_APELLIDO_PATERNO			VARCHAR(100),	
	@PP_APELLIDO_MATERNO			VARCHAR(100),	
	@PP_RFC							VARCHAR(100),	
	@PP_CURP						VARCHAR(100),	
	@PP_NSS							VARCHAR(100),	
	@PP_F_NACIMIENTO				DATE,			
	@PP_F_INGRESO					DATE,			
	-- ============================
	@PP_TELEFONO					VARCHAR(100),	
	@PP_CORREO						VARCHAR(100),	
	@PP_CALLE						VARCHAR(100),	
	@PP_NUMERO_EXTERIOR				VARCHAR(100),	
	@PP_NUMERO_INTERIOR				VARCHAR(100),	
	@PP_COLONIA						VARCHAR(100),	
	@PP_CP							VARCHAR(100),  
	@PP_MUNICIPIO					VARCHAR(100),  
	-- ============================
	@PP_NUMERO_LICENCIA_OPERADOR		VARCHAR(100),	
	@PP_F_VIGENCIA_LICENCIA			DATE,			
	@PP_SALARIO_DIARIO				DECIMAL(10,4),
	@PP_SALARIO_DIARIO_INTEGRADO	DECIMAL(10,4)
AS			

	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	
	DECLARE @VP_D_OPERADOR			VARCHAR(255)=CONCAT(@PP_APELLIDO_PATERNO,' ',@PP_APELLIDO_MATERNO,', ',@PP_NOMBRE)

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_OPERADOR_UPDATE]		@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@PP_K_OPERADOR, @PP_CURP, 
												@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		BEGIN
				
		-- ==================================

		UPDATE	OPERADOR
		SET		
				[K_OPERADOR]					= @PP_K_OPERADOR,					
				[D_OPERADOR]					= @VP_D_OPERADOR,						
				[C_OPERADOR]					= @PP_C_OPERADOR,						
				-- =========================-- ===============================						
				[K_ESTATUS_OPERADOR]		= @PP_K_ESTATUS_OPERADOR,					
				[K_ESTADO_CIVIL]			= @PP_K_ESTADO_CIVIL,						
				[K_SEXO]					= @PP_K_SEXO,								
				-- =========================-- ===============================
				[NOMBRE]					= @PP_NOMBRE,								
				[APELLIDO_PATERNO]			= @PP_APELLIDO_PATERNO,					
				[APELLIDO_MATERNO]			= @PP_APELLIDO_MATERNO,					
				[RFC]						= @PP_RFC,									
				[CURP]						= @PP_CURP,								
				[NSS]						= @PP_NSS,									
				[F_NACIMIENTO]				= @PP_F_NACIMIENTO,						
				[F_INGRESO]					= @PP_F_INGRESO,							
				-- =========================-- ===============================
				[TELEFONO]					= @PP_TELEFONO,							
				[CORREO]					= @PP_CORREO,								
				[CALLE]						= @PP_CALLE,								
				[NUMERO_EXTERIOR]			= @PP_NUMERO_EXTERIOR,						
				[NUMERO_INTERIOR]			= @PP_NUMERO_INTERIOR,						
				[COLONIA]					= @PP_COLONIA,								
				[CP]						= @PP_CP,									
				[MUNICIPIO]					= @PP_MUNICIPIO,							
				-- =========================-- ===============================
				[NUMERO_LICENCIA_OPERADOR]	= @PP_NUMERO_LICENCIA_OPERADOR,				
				[F_VIGENCIA_LICENCIA]		= @PP_F_VIGENCIA_LICENCIA,					
				[SALARIO_DIARIO]			= @PP_SALARIO_DIARIO,						
				[SALARIO_DIARIO_INTEGRADO]	= @PP_SALARIO_DIARIO_INTEGRADO,
				-- ===========================
				[K_USUARIO_CAMBIO]			= @PP_K_USUARIO_ACCION, 
				[F_CAMBIO]					= GETDATE() 
		WHERE	K_OPERADOR=@PP_K_OPERADOR
	
		END

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible actualizar el [OPERADOR]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Cho.'+CONVERT(VARCHAR(10),@PP_K_OPERADOR)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'
		
		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_OPERADOR AS CLAVE

	-- //////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													3,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'UPDATE',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_UP_OPERADOR]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_OPERADOR, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													--0, 0, @PP_C_OPERADOR, '', 0.00, 0.00,
													0, 0, '', '', 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '', '', ''

	-- //////////////////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_OPERADOR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_OPERADOR]
GO


CREATE PROCEDURE [dbo].[PG_DL_OPERADOR]
	@PP_L_DEBUG						INT,
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_OPERADOR					INT
AS

	DECLARE @VP_MENSAJE				VARCHAR(300) = ''

	-- //////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		EXECUTE [dbo].[PG_RN_OPERADOR_DELETE]			@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_OPERADOR, 
													@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- //////////////////////////////////////////////
	
	IF @VP_MENSAJE=''
		BEGIN

		UPDATE	OPERADOR
		SET		
				[L_BORRADO]				= 1,
				-- ====================
				[F_BAJA]				= GETDATE(), 
				[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
		WHERE	K_OPERADOR=@PP_K_OPERADOR

		END

	-- /////////////////////////////////////////////////////////////////////
	
	IF @VP_MENSAJE<>''
		BEGIN
		
		SET		@VP_MENSAJE = 'No es posible borrar el [OPERADOR]: ' + @VP_MENSAJE 
		SET		@VP_MENSAJE = @VP_MENSAJE + ' ( '
		SET		@VP_MENSAJE = @VP_MENSAJE + '[#Cho.'+CONVERT(VARCHAR(10),@PP_K_OPERADOR)+']'
		SET		@VP_MENSAJE = @VP_MENSAJE + ' )'

		END
	
	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_OPERADOR AS CLAVE

	-- /////////////////////////////////////////////////////////////////////

	EXECUTE [dbo].[PG_IN_BITACORA_SYS_OPERACION]	@PP_L_DEBUG, @PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													-- ===========================================
													5,		-- 0 al 6 // @PP_K_IMPORTANCIA_BITACORA_SYS	[INT],	
													'DELETE',
													@VP_MENSAJE,
													-- ===========================================
													'[PG_DL_OPERADOR]', -- @PP_STORED_PROCEDURE			[VARCHAR] (100),
													@PP_K_OPERADOR, 0, 		-- @PP_K_FOLIO_1, @PP_K_FOLIO_2,
													-- === [INT], [INT], [VARCHAR](100), [VARCHAR](100), DECIMAL(19,4), DECIMAL(19,4),
													0, 0, '', '' , 0.00, 0.00,
													-- === @PP_VALOR_1 al 6_DATO
													'', '', '', '', '', ''

	-- /////////////////////////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
