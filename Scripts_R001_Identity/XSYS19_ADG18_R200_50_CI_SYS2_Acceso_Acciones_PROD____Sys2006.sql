-- //////////////////////////////////////////////////////////////
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
-- // SYS2_ACCESO_USR_FRM_ACCIONES
-- //////////////////////////////////////////////////////////////
-- SELECT * FROM [SYS2_ACCESO_USR_FRM_ACCIONES]
-- //////////////////////////////////////////////////////////////
-- K_SYS2_PERFIL_ACCESO = #0 NINGUNO | #1 FULL CONTROL | #2 CORDINACION | #3 OPERACION | #4 CONSULTA


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


 -- =========================================== CARGA INICIAL X USUARIO >> #1001/VIGO >> VICTOR GONZALEZ
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 4, 'FO_NOMBRE';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 4, 'FO_PRODUCTO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 4, 'FO_TASA_IMPUESTO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 2, 'FO_PRECIO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 1, 'FO_SITIO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 1, 'FO_CLIENTE';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 2, 'FO_CARGO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 2, 'FO_CONDICION_COMERCIAL';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 6, 'FO_LECTURA';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 5, 'FO_SITIO_CONTROL_RECIBO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 4, 'FO_RENGLON_RECIBO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 4, 'FO_RECIBO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 5, 'FO_GENERA_RECIBO_PDF';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 5, 'FO_GENERA_ESTADO_CUENTA_PDF';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 1, 'FO_PAGO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 5, 'FO_APLICAR_PAGO_CLIENTE';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 4, 'FO_PAGO_RECIBO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 5, 'FO_CLIENTE_DESCONEXION_RECONEXION';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 4, 'FO_BITACORA_DESCONEXION_RECONEXION';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 1, 'FO_ALMACEN_SITIO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 2, 'FO_MOVIMIENTO_ALMACEN';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 4, 'FO_HISTORIA_ALMACEN';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 1, 'FO_ADMINISTRADOR';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 1, 'FO_SITIO_ADMINISTRADOR';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 5, 'FO_GENERAR_COMISION';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1001, 4, 'FO_BITACORA_COMISION';
GO

 -- =========================================== CARGA INICIAL X USUARIO >> #1002/TOQI >> MIGUEL TOQUICA
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 4, 'FO_NOMBRE';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 4, 'FO_PRODUCTO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 4, 'FO_TASA_IMPUESTO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 2, 'FO_PRECIO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 1, 'FO_SITIO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 1, 'FO_CLIENTE';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 2, 'FO_CARGO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 2, 'FO_CONDICION_COMERCIAL';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 6, 'FO_LECTURA';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 5, 'FO_SITIO_CONTROL_RECIBO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 4, 'FO_RENGLON_RECIBO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 4, 'FO_RECIBO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 5, 'FO_GENERA_RECIBO_PDF';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 5, 'FO_GENERA_ESTADO_CUENTA_PDF';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 2, 'FO_PAGO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 5, 'FO_APLICAR_PAGO_CLIENTE';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 4, 'FO_PAGO_RECIBO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 5, 'FO_CLIENTE_DESCONEXION_RECONEXION';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 4, 'FO_BITACORA_DESCONEXION_RECONEXION';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 1, 'FO_ALMACEN_SITIO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 2, 'FO_MOVIMIENTO_ALMACEN';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 4, 'FO_HISTORIA_ALMACEN';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 1, 'FO_ADMINISTRADOR';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 1, 'FO_SITIO_ADMINISTRADOR';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 5, 'FO_GENERAR_COMISION';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1002, 4, 'FO_BITACORA_COMISION';
GO

 -- =========================================== CARGA INICIAL X USUARIO >> #1003/AROM >> ALEJANDRA ROMERO
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 4, 'FO_NOMBRE';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 4, 'FO_PRODUCTO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 4, 'FO_TASA_IMPUESTO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 3, 'FO_PRECIO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 3, 'FO_SITIO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 3, 'FO_CLIENTE';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 3, 'FO_CARGO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 3, 'FO_CONDICION_COMERCIAL';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 6, 'FO_LECTURA';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 5, 'FO_SITIO_CONTROL_RECIBO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 4, 'FO_RENGLON_RECIBO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 4, 'FO_RECIBO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 5, 'FO_GENERA_RECIBO_PDF';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 5, 'FO_GENERA_ESTADO_CUENTA_PDF';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 3, 'FO_PAGO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 5, 'FO_APLICAR_PAGO_CLIENTE';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 4, 'FO_PAGO_RECIBO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 5, 'FO_CLIENTE_DESCONEXION_RECONEXION';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 4, 'FO_BITACORA_DESCONEXION_RECONEXION';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 3, 'FO_ALMACEN_SITIO';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 3, 'FO_MOVIMIENTO_ALMACEN';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 4, 'FO_HISTORIA_ALMACEN';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 3, 'FO_ADMINISTRADOR';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 3, 'FO_SITIO_ADMINISTRADOR';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 5, 'FO_GENERAR_COMISION';
EXECUTE [dbo].[PG_CI_SYS2_ACCESO_USR_FRM_ACCIONES] 0, 2006,    1003, 4, 'FO_BITACORA_COMISION';
GO


-- ===============================================
SET NOCOUNT OFF
-- ===============================================



-- ////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////
