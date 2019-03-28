X`-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	SYS19_BasicBD_20190325
-- // MODULO:			
-- // OPERACION:		LIBERACION // STORED PROCEDURE
-- ////////////////////////////////////////////////////////////// 

USE [SYS19_BasicBD_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////




-- //////////////////////////////////////////////////////////////
-- // 
-- //////////////////////////////////////////////////////////////


DELETE FROM [SYS3_ACCESO_USR_X_RAS]

DELETE FROM [SYS3_ACCESO_USR_X_ZON]

GO

WIWI
-- ////////////////////////////////////////////////////////////////

INSERT INTO [SYS3_ACCESO_USR_X_RAS]
	(		[K_SISTEMA], [K_USUARIO], [K_RAZON_SOCIAL], 
			[L_ACCESO], 
			[K_USUARIO_ALTA], [F_ALTA], 
			[K_USUARIO_CAMBIO], [F_CAMBIO], 
			[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]		)
	SELECT	DISTINCT 
			SYS3.[K_SISTEMA], SYS3.[K_USUARIO], RAZON_SOCIAL.[K_RAZON_SOCIAL], 
			SYS3.[L_ACCESO], 
			0, GETDATE(), 
			0, GETDATE(), 
			0, 0, NULL
	FROM	SYS3_ACCESO_USR_X_UNO AS SYS3, 
			UNIDAD_OPERATIVA, RAZON_SOCIAL
	WHERE	UNIDAD_OPERATIVA.K_RAZON_SOCIAL=RAZON_SOCIAL.K_RAZON_SOCIAL
	AND		SYS3.K_UNIDAD_OPERATIVA=UNIDAD_OPERATIVA.K_UNIDAD_OPERATIVA

GO

WIWI

INSERT INTO [SYS3_ACCESO_USR_X_ZON]
	(		[K_SISTEMA], [K_USUARIO], [K_ZONA_UO], 
			[L_ACCESO], 
			[K_USUARIO_ALTA], [F_ALTA], 
			[K_USUARIO_CAMBIO], [F_CAMBIO], 
			[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]		)
	SELECT	DISTINCT 
			SYS3.[K_SISTEMA], SYS3.[K_USUARIO], ZONA_UO.[K_ZONA_UO], 
			SYS3.[L_ACCESO], 
			0, GETDATE(), 
			0, GETDATE(), 
			0, 0, NULL
	FROM	SYS3_ACCESO_USR_X_UNO AS SYS3, 
			UNIDAD_OPERATIVA, ZONA_UO
	WHERE	UNIDAD_OPERATIVA.K_ZONA_UO=ZONA_UO.K_ZONA_UO
	AND		SYS3.K_UNIDAD_OPERATIVA=UNIDAD_OPERATIVA.K_UNIDAD_OPERATIVA

GO




-- ===============================================
SET NOCOUNT ON
-- ===============================================

-- SELECT * FROM SYS2_ACCESO_USR_FRM_ACCIONES

-- SELECT * FROM [SYS2_ACCESO_USR_FRM_BTN]


DELETE 
FROM	SYS2_ACCESO_USR_FRM_BTN
WHERE	K_USUARIO>999
AND		K_SISTEMA=2006		-- K_SISTEMA = #2006 ADG18

DELETE 
FROM	SYS2_ACCESO_USR_FRM_ACCIONES
WHERE	K_USUARIO>999
AND		K_SISTEMA=2006		-- K_SISTEMA = #2006 ADG18

GO


GO

-- ===============================================
SET NOCOUNT OFF
-- ===============================================


-- ////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////
