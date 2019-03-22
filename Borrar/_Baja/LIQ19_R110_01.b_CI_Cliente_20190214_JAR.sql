-- //////////////////////////////////////////////////////////////
-- // ARCHIVO:			LIQ19_R110_01.b_CI_CLIENTE
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			CARGA INICIAL - CLIENTE
-- // OPERACION:		LIBERACION 
-- ////////////////////////////////////////////////////////////// 

USE [LIQ19_Liquidaciones_V9999_R0] 
GO

-- //////////////////////////////////////////////////////////////



-- //////////////////////////////////////////////////////////////
--	

DELETE  
FROM [dbo].[CLIENTE]
GO

-- //////////////////////////////////////////////////////////////


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_CLIENTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_CLIENTE]
GO


CREATE PROCEDURE [dbo].[PG_CI_CLIENTE]
	@PP_L_DEBUG					INT,
	@PP_K_SISTEMA_EXE			INT,
	-- ===========================
	@PP_K_CLIENTE				INT,
	@PP_D_CLIENTE				VARCHAR(100),
	@PP_S_CLIENTE				VARCHAR(10),
	@PP_O_CLIENTE				INT,
	@PP_K_ESTATUS_CLIENTE		INT,
	@PP_K_ESTATUS_CONEXION		INT,
	@PP_K_TIPO_CLIENTE			INT,
	@PP_K_SITIO					INT,
	@PP_K_PERODICIDAD			INT,
	@PP_NOMBRE					VARCHAR(100),
	@PP_APELLIDO_PATERNO		VARCHAR(100),
	@PP_APELLIDO_MATERNO		VARCHAR(100),
	@PP_RFC_CLIENTE				VARCHAR(100),
	@PP_CURP					VARCHAR(100),
	@PP_CORREO					VARCHAR(100),
	@PP_TELEFONO				VARCHAR(100),
	@PP_CALLE					VARCHAR(100),
	@PP_NUMERO_EXTERIOR			VARCHAR(10),
	@PP_NUMERO_INTERIOR			VARCHAR(10),
	@PP_COLONIA					VARCHAR(100),
	@PP_POBLACION				VARCHAR(100),
	@PP_CP						VARCHAR(10),
	@PP_MUNICIPIO				VARCHAR(100),
	@PP_K_REGION				INT,
	@PP_NUMERO_MEDIDOR			VARCHAR(100)
	
	-- ===========================
AS			
	-- K_USUARIO // 0	SYS/SETUP
	DECLARE @VP_K_USUARIO_ACCION		INT = 0 
	DECLARE @VP_O_CLIENTE				INT = 0

	-- ===========================

	INSERT INTO CLIENTE
			(	[K_CLIENTE],
				[D_CLIENTE], [S_CLIENTE], [O_CLIENTE],
				-- ===========================
				[K_ESTATUS_CLIENTE], [K_ESTATUS_CONEXION], [K_TIPO_CLIENTE],
				[K_SITIO], [K_PERIODICIDAD],
				-- ===========================
				[NOMBRE], [APELLIDO_PATERNO], [APELLIDO_MATERNO],
				[RFC_CLIENTE], [CURP], [CORREO], [TELEFONO],
				[CALLE], [NUMERO_EXTERIOR], [NUMERO_INTERIOR],
				[COLONIA], [POBLACION],
				[CP], [MUNICIPIO], [K_REGION], 
				[NUMERO_MEDIDOR],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
		VALUES	
			(	@PP_K_CLIENTE, 
				@PP_D_CLIENTE, @PP_S_CLIENTE, @PP_O_CLIENTE,
				-- ===========================
				@PP_K_ESTATUS_CLIENTE ,@PP_K_ESTATUS_CONEXION, @PP_K_TIPO_CLIENTE,
				@PP_K_SITIO, @PP_K_PERODICIDAD,
				-- ===========================
				@PP_NOMBRE, @PP_APELLIDO_PATERNO, @PP_APELLIDO_MATERNO,
				@PP_RFC_CLIENTE, @PP_CURP, @PP_CORREO, @PP_TELEFONO,
				@PP_CALLE, @PP_NUMERO_EXTERIOR, @PP_NUMERO_INTERIOR,
				@PP_COLONIA, @PP_POBLACION,
				@PP_CP, @PP_MUNICIPIO,@PP_K_REGION,
				@PP_NUMERO_MEDIDOR,
				-- ===========================
				@VP_K_USUARIO_ACCION, GETDATE(), @VP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )
		
	-- //////////////////////////////////////////////////////////////
GO



-- ===============================================
SET NOCOUNT ON
-- ===============================================


EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 0, '(SIN ASIGNAR)', '????', 1, 0,1 ,1, 0, 1, 'SIN ASIGNAR', 'SIN ASIGNAR', 'SIN ASIGNAR', 'SIN ASIGNAR', 'SIN ASIGNAR', 'SIN ASIGNAR', 'SIN ASIGNAR', 'SIN ASIGNAR','','','','','','', 0,'0';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 1, 'juanEsteban', 'juaEst', 6, 0,1 ,4, 1, 1, 'juan', 'Esteban', 'Gutierres', 'juEG0411', 'juEG0411HTCSTR0', 'juan.Esteban@gmail.com', '656  60411', 'Av. Las torres','','','','','','', 0,'MED-1';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 2, 'pedroPaz', 'pedPaz', 5, 1,1 ,1, 2, 1, 'pedro', 'Paz', 'Perez', 'pePP1121', 'pePP1121HTCSTR0', 'pedro.Paz@gmail.com', '656  51121', 'Av. Talamas camanadari','','','','','','', 0,'MED-2';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 3, 'luisEscobar', 'luiEsc', 7, 1,1 ,3, 2, 1, 'luis', 'Escobar', 'De Leon', 'luED1321', 'luED1321HTCSTR0', 'luis.Escobar@gmail.com', '656  71321', 'Av. Independencia','','','','','','', 0,'MED-3';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 4, 'marioDominguez', 'marDom', 6, 0,1 ,2, 3, 1, 'mario', 'Dominguez', 'Juarez', 'maDJ0231', 'maDJ0231HTCSTR0', 'mario.Dominguez@gmail.com', '656  60231', 'Av. Gomez Morin','','','','','','', 0,'MED-4';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 5, 'betyLopez', 'betLop', 10, 1,1 ,4, 4, 1, 'bety', 'Lopez', 'zamarripa', 'beLz1441', 'beLz1441HTCSTR0', 'bety.Lopez@gmail.com', '656  101441', 'Paraje San Isidro','','','','','','', 0,'MED-5';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 6, 'mariasandoval', 'marsan', 8, 1,1 ,1, 5, 1, 'maria', 'sandoval', 'tarango', 'mast1151', 'mast1151HTCSTR0', 'maria.sandoval@gmail.com', '656  81151', 'San Pancho','','','','','','', 0,'MED-6';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 7, 'renataperez', 'renper', 9, 0,1 ,3, 5, 1, 'renata', 'perez', 'cordero', 'repc0351', 'repc0351HTCSTR0', 'renata.perez@gmail.com', '656  90351', 'Yepomera','','','','','','', 0,'MED-7';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 8, 'juanmartinez', 'juamar', 9, 1,1 ,2, 5, 1, 'juan', 'martinez', 'portillo', 'jump1251', 'jump1251HTCSTR0', 'juan.martinez@gmail.com', '656  91251', 'Oscar Flores','','','','','','', 0,'MED-8';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 9, 'pedroescailla', 'pedesc', 12, 1,1 ,4, 6, 1, 'pedro', 'escailla', 'barraza', 'peeb1461', 'peeb1461HTCSTR0', 'pedro.escailla@gmail.com', '656  121461', 'Panamericana','','','','','','', 0,'MED-9';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 10, 'luisarreola', 'luiarr', 8, 0,1 ,1, 6, 1, 'luis', 'arreola', 'salgado', 'luas0161', 'luas0161HTCSTR0', 'luis.arreola@gmail.com', '656  80161', 'Zaragoza','','','','','','', 0,'MED-10';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 11, 'mariogonzalez', 'margon', 12, 1,1 ,3, 7, 1, 'mario', 'gonzalez', 'zamarron', 'magz1371', 'magz1371HTCSTR0', 'mario.gonzalez@gmail.com', '656  121371', 'Porvenir','','','','','','', 0,'MED-11';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 12, 'betyEsteban', 'betEst', 11, 1,1 ,2, 7, 1, 'bety', 'Esteban', 'p4edroza', 'beEp1271', 'beEp1271HTCSTR0', 'bety.Esteban@gmail.com', '656  111271', 'Henequen','','','','','','', 0,'MED-12';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 13, 'mariaPaz', 'marPaz', 12, 0,1 ,4, 7, 1, 'maria', 'Paz', 'narvaez', 'maPn0471', 'maPn0471HTCSTR0', 'maria.Paz@gmail.com', '656  120471', 'Ejercito Nacional','','','','','','', 0,'MED-13';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 14, 'renataEscobar', 'renEsc', 10, 1,1 ,1, 7, 1, 'renata', 'Escobar', 'Gutierres', 'reEG1171', 'reEG1171HTCSTR0', 'renata.Escobar@gmail.com', '656  101171', 'Av. Las torres','','','','','','', 0,'MED-14';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 15, 'juanDominguez', 'juaDom', 13, 1,1 ,3, 8, 1, 'juan', 'Dominguez', 'Perez', 'juDP1381', 'juDP1381HTCSTR0', 'juan.Dominguez@gmail.com', '656  131381', 'Av. Talamas camanadari','','','','','','', 0,'MED-15';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 16, 'pedroLopez', 'pedLop', 11, 0,1 ,2, 8, 1, 'pedro', 'Lopez', 'De Leon', 'peLD0281', 'peLD0281HTCSTR0', 'pedro.Lopez@gmail.com', '656  110281', 'Av. Independencia','','','','','','', 0,'MED-16';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 17, 'luissandoval', 'luisan', 15, 1,1 ,4, 9, 1, 'luis', 'sandoval', 'Juarez', 'lusJ1491', 'lusJ1491HTCSTR0', 'luis.sandoval@gmail.com', '656  151491', 'Av. Gomez Morin','','','','','','', 0,'MED-17';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 18, 'marioperez', 'marper', 4, 1,1 ,1, 1, 1, 'mario', 'perez', 'zamarripa', 'mapz1111', 'mapz1111HTCSTR0', 'mario.perez@gmail.com', '656  41111', 'Paraje San Isidro','','','','','','', 0,'MED-18';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 19, 'betymartinez', 'betmar', 6, 0,1 ,3, 2, 1, 'bety', 'martinez', 'tarango', 'bemt0321', 'bemt0321HTCSTR0', 'bety.martinez@gmail.com', '656  60321', 'San Pancho','','','','','','', 0,'MED-19';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 20, 'mariaescailla', 'maresc', 6, 1,1 ,2, 2, 1, 'maria', 'escailla', 'cordero', 'maec1221', 'maec1221HTCSTR0', 'maria.escailla@gmail.com', '656  61221', 'Yepomera','','','','','','', 0,'MED-20';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 21, 'renataarreola', 'renarr', 9, 1,1 ,4, 3, 1, 'renata', 'arreola', 'portillo', 'reap1431', 'reap1431HTCSTR0', 'renata.arreola@gmail.com', '656  91431', 'Oscar Flores','','','','','','', 0,'MED-21';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 22, 'juangonzalez', 'juagon', 6, 0,1 ,1, 4, 1, 'juan', 'gonzalez', 'barraza', 'jugb0141', 'jugb0141HTCSTR0', 'juan.gonzalez@gmail.com', '656  60141', 'Panamericana','','','','','','', 0,'MED-22';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 23, 'pedroEsteban', 'pedEst', 10, 1,1 ,3, 5, 1, 'pedro', 'Esteban', 'salgado', 'peEs1351', 'peEs1351HTCSTR0', 'pedro.Esteban@gmail.com', '656  101351', 'Zaragoza','','','','','','', 0,'MED-23';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 24, 'luisPaz', 'luiPaz', 9, 1,1 ,2, 5, 1, 'luis', 'Paz', 'zamarron', 'luPz1251', 'luPz1251HTCSTR0', 'luis.Paz@gmail.com', '656  91251', 'Porvenir','','','','','','', 0,'MED-24';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 25, 'marioEscobar', 'marEsc', 10, 0,1 ,4, 5, 1, 'mario', 'Escobar', 'p4edroza', 'maEp0451', 'maEp0451HTCSTR0', 'mario.Escobar@gmail.com', '656  100451', 'Henequen','','','','','','', 0,'MED-25';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 26, 'betyDominguez', 'betDom', 9, 1,1 ,1, 6, 1, 'bety', 'Dominguez', 'narvaez', 'beDn1161', 'beDn1161HTCSTR0', 'bety.Dominguez@gmail.com', '656  91161', 'Ejercito Nacional','','','','','','', 0,'MED-26';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 27, 'mariaLopez', 'marLop', 11, 1,1 ,3, 6, 1, 'maria', 'Lopez', 'Gutierres', 'maLG1361', 'maLG1361HTCSTR0', 'maria.Lopez@gmail.com', '656  111361', 'Av. Las torres','','','','','','', 0,'MED-27';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 28, 'renatasandoval', 'rensan', 10, 0,1 ,2, 7, 1, 'renata', 'sandoval', 'Perez', 'resP0271', 'resP0271HTCSTR0', 'renata.sandoval@gmail.com', '656  100271', 'Av. Talamas camanadari','','','','','','', 0,'MED-28';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 29, 'juanperez', 'juaper', 13, 1,1 ,4, 7, 1, 'juan', 'perez', 'De Leon', 'jupD1471', 'jupD1471HTCSTR0', 'juan.perez@gmail.com', '656  131471', 'Av. Independencia','','','','','','', 0,'MED-29';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 30, 'pedromartinez', 'pedmar', 10, 1,1 ,1, 7, 1, 'pedro', 'martinez', 'Juarez', 'pemJ1171', 'pemJ1171HTCSTR0', 'pedro.martinez@gmail.com', '656  101171', 'Av. Gomez Morin','','','','','','', 0,'MED-30';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 31, 'luisescailla', 'luiesc', 11, 0,1 ,3, 7, 1, 'luis', 'escailla', 'zamarripa', 'luez0371', 'luez0371HTCSTR0', 'luis.escailla@gmail.com', '656  110371', 'Paraje San Isidro','','','','','','', 0,'MED-31';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 32, 'marioarreola', 'mararr', 12, 1,1 ,2, 8, 1, 'mario', 'arreola', 'tarango', 'maat1281', 'maat1281HTCSTR0', 'mario.arreola@gmail.com', '656  121281', 'San Pancho','','','','','','', 0,'MED-32';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 33, 'betygonzalez', 'betgon', 14, 1,1 ,4, 8, 1, 'bety', 'gonzalez', 'cordero', 'begc1481', 'begc1481HTCSTR0', 'bety.gonzalez@gmail.com', '656  141481', 'Yepomera','','','','','','', 0,'MED-33';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 34, 'mariaEsteban', 'marEst', 11, 0,1 ,1, 9, 1, 'maria', 'Esteban', 'portillo', 'maEp0191', 'maEp0191HTCSTR0', 'maria.Esteban@gmail.com', '656  110191', 'Oscar Flores','','','','','','', 0,'MED-34';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 35, 'renataPaz', 'renPaz', 6, 1,1 ,3, 1, 1, 'renata', 'Paz', 'barraza', 'rePb1311', 'rePb1311HTCSTR0', 'renata.Paz@gmail.com', '656  61311', 'Panamericana','','','','','','', 0,'MED-35';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 36, 'juanEscobar', 'juaEsc', 6, 1,1 ,2, 2, 1, 'juan', 'Escobar', 'salgado', 'juEs1221', 'juEs1221HTCSTR0', 'juan.Escobar@gmail.com', '656  61221', 'Zaragoza','','','','','','', 0,'MED-36';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 37, 'pedroDominguez', 'pedDom', 7, 0,1 ,4, 2, 1, 'pedro', 'Dominguez', 'zamarron', 'peDz0421', 'peDz0421HTCSTR0', 'pedro.Dominguez@gmail.com', '656  70421', 'Porvenir','','','','','','', 0,'MED-37';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 38, 'luisLopez', 'luiLop', 6, 1,1 ,1, 3, 1, 'luis', 'Lopez', 'p4edroza', 'luLp1131', 'luLp1131HTCSTR0', 'luis.Lopez@gmail.com', '656  61131', 'Henequen','','','','','','', 0,'MED-38';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 39, 'mariosandoval', 'marsan', 9, 1,1 ,3, 4, 1, 'mario', 'sandoval', 'narvaez', 'masn1341', 'masn1341HTCSTR0', 'mario.sandoval@gmail.com', '656  91341', 'Ejercito Nacional','','','','','','', 0,'MED-39';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 40, 'betyperez', 'betper', 8, 0,1 ,2, 5, 1, 'bety', 'perez', 'Gutierres', 'bepG0251', 'bepG0251HTCSTR0', 'bety.perez@gmail.com', '656  80251', 'Av. Las torres','','','','','','', 0,'MED-40';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 41, 'mariamartinez', 'marmar', 11, 1,1 ,4, 5, 1, 'maria', 'martinez', 'Perez', 'mamP1451', 'mamP1451HTCSTR0', 'maria.martinez@gmail.com', '656  111451', 'Av. Talamas camanadari','','','','','','', 0,'MED-41';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 42, 'renataescailla', 'renesc', 8, 1,1 ,1, 5, 1, 'renata', 'escailla', 'De Leon', 'reeD1151', 'reeD1151HTCSTR0', 'renata.escailla@gmail.com', '656  81151', 'Av. Independencia','','','','','','', 0,'MED-42';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 43, 'juanarreola', 'juaarr', 10, 0,1 ,3, 6, 1, 'juan', 'arreola', 'Juarez', 'juaJ0361', 'juaJ0361HTCSTR0', 'juan.arreola@gmail.com', '656  100361', 'Av. Gomez Morin','','','','','','', 0,'MED-43';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 44, 'pedrogonzalez', 'pedgon', 10, 1,1 ,2, 6, 1, 'pedro', 'gonzalez', 'zamarripa', 'pegz1261', 'pegz1261HTCSTR0', 'pedro.gonzalez@gmail.com', '656  101261', 'Paraje San Isidro','','','','','','', 0,'MED-44';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 45, 'luisEsteban', 'luiEst', 13, 1,1 ,4, 7, 1, 'luis', 'Esteban', 'tarango', 'luEt1471', 'luEt1471HTCSTR0', 'luis.Esteban@gmail.com', '656  131471', 'San Pancho','','','','','','', 0,'MED-45';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 46, 'marioPaz', 'marPaz', 9, 0,1 ,1, 7, 1, 'mario', 'Paz', 'cordero', 'maPc0171', 'maPc0171HTCSTR0', 'mario.Paz@gmail.com', '656  90171', 'Yepomera','','','','','','', 0,'MED-46';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 47, 'betyEscobar', 'betEsc', 12, 1,1 ,3, 7, 1, 'bety', 'Escobar', 'portillo', 'beEp1371', 'beEp1371HTCSTR0', 'bety.Escobar@gmail.com', '656  121371', 'Oscar Flores','','','','','','', 0,'MED-47';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 48, 'mariaDominguez', 'marDom', 11, 1,1 ,2, 7, 1, 'maria', 'Dominguez', 'barraza', 'maDb1271', 'maDb1271HTCSTR0', 'maria.Dominguez@gmail.com', '656  111271', 'Panamericana','','','','','','', 0,'MED-48';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 49, 'renataLopez', 'renLop', 13, 0,1 ,4, 8, 1, 'renata', 'Lopez', 'salgado', 'reLs0481', 'reLs0481HTCSTR0', 'renata.Lopez@gmail.com', '656  130481', 'Zaragoza','','','','','','', 0,'MED-49';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 50, 'juansandoval', 'juasan', 11, 1,1 ,1, 8, 1, 'juan', 'sandoval', 'zamarron', 'jusz1181', 'jusz1181HTCSTR0', 'juan.sandoval@gmail.com', '656  111181', 'Porvenir','','','','','','', 0,'MED-50';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 51, 'pedroperez', 'pedper', 14, 1,1 ,3, 9, 1, 'pedro', 'perez', 'p4edroza', 'pepp1391', 'pepp1391HTCSTR0', 'pedro.perez@gmail.com', '656  141391', 'Henequen','','','','','','', 0,'MED-51';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 52, 'luismartinez', 'luimar', 4, 0,1 ,2, 1, 1, 'luis', 'martinez', 'narvaez', 'lumn0211', 'lumn0211HTCSTR0', 'luis.martinez@gmail.com', '656  40211', 'Ejercito Nacional','','','','','','', 0,'MED-52';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 53, 'marioescailla', 'maresc', 8, 1,1 ,4, 2, 1, 'mario', 'escailla', 'Gutierres', 'maeG1421', 'maeG1421HTCSTR0', 'mario.escailla@gmail.com', '656  81421', 'Av. Las torres','','','','','','', 0,'MED-53';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 54, 'betyarreola', 'betarr', 5, 1,1 ,1, 2, 1, 'bety', 'arreola', 'Perez', 'beaP1121', 'beaP1121HTCSTR0', 'bety.arreola@gmail.com', '656  51121', 'Av. Talamas camanadari','','','','','','', 0,'MED-54';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 55, 'mariagonzalez', 'margon', 7, 0,1 ,3, 3, 1, 'maria', 'gonzalez', 'De Leon', 'magD0331', 'magD0331HTCSTR0', 'maria.gonzalez@gmail.com', '656  70331', 'Av. Independencia','','','','','','', 0,'MED-55';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 56, 'renataEsteban', 'renEst', 8, 1,1 ,2, 4, 1, 'renata', 'Esteban', 'Juarez', 'reEJ1241', 'reEJ1241HTCSTR0', 'renata.Esteban@gmail.com', '656  81241', 'Av. Gomez Morin','','','','','','', 0,'MED-56';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 57, 'juanPaz', 'juaPaz', 11, 1,1 ,4, 5, 1, 'juan', 'Paz', 'zamarripa', 'juPz1451', 'juPz1451HTCSTR0', 'juan.Paz@gmail.com', '656  111451', 'Paraje San Isidro','','','','','','', 0,'MED-57';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 58, 'pedroEscobar', 'pedEsc', 7, 0,1 ,1, 5, 1, 'pedro', 'Escobar', 'tarango', 'peEt0151', 'peEt0151HTCSTR0', 'pedro.Escobar@gmail.com', '656  70151', 'San Pancho','','','','','','', 0,'MED-58';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 59, 'luisDominguez', 'luiDom', 10, 1,1 ,3, 5, 1, 'luis', 'Dominguez', 'cordero', 'luDc1351', 'luDc1351HTCSTR0', 'luis.Dominguez@gmail.com', '656  101351', 'Yepomera','','','','','','', 0,'MED-59';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 60, 'marioLopez', 'marLop', 10, 1,1 ,2, 6, 1, 'mario', 'Lopez', 'portillo', 'maLp1261', 'maLp1261HTCSTR0', 'mario.Lopez@gmail.com', '656  101261', 'Oscar Flores','','','','','','', 0,'MED-60';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 61, 'betysandoval', 'betsan', 11, 0,1 ,4, 6, 1, 'bety', 'sandoval', 'barraza', 'besb0461', 'besb0461HTCSTR0', 'bety.sandoval@gmail.com', '656  110461', 'Panamericana','','','','','','', 0,'MED-61';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 62, 'mariaperez', 'marper', 10, 1,1 ,1, 7, 1, 'maria', 'perez', 'salgado', 'maps1171', 'maps1171HTCSTR0', 'maria.perez@gmail.com', '656  101171', 'Zaragoza','','','','','','', 0,'MED-62';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 63, 'renatamartinez', 'renmar', 12, 1,1 ,3, 7, 1, 'renata', 'martinez', 'zamarron', 'remz1371', 'remz1371HTCSTR0', 'renata.martinez@gmail.com', '656  121371', 'Porvenir','','','','','','', 0,'MED-63';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 64, 'juanescailla', 'juaesc', 10, 0,1 ,2, 7, 1, 'juan', 'escailla', 'p4edroza', 'juep0271', 'juep0271HTCSTR0', 'juan.escailla@gmail.com', '656  100271', 'Henequen','','','','','','', 0,'MED-64';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 65, 'pedroarreola', 'pedarr', 13, 1,1 ,4, 7, 1, 'pedro', 'arreola', 'narvaez', 'pean1471', 'pean1471HTCSTR0', 'pedro.arreola@gmail.com', '656  131471', 'Ejercito Nacional','','','','','','', 0,'MED-65';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 66, 'luisgonzalez', 'luigon', 11, 1,1 ,1, 8, 1, 'luis', 'gonzalez', 'Gutierres', 'lugG1181', 'lugG1181HTCSTR0', 'luis.gonzalez@gmail.com', '656  111181', 'Av. Las torres','','','','','','', 0,'MED-66';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 67, 'marioEsteban', 'marEst', 12, 0,1 ,3, 8, 1, 'mario', 'Esteban', 'Perez', 'maEP0381', 'maEP0381HTCSTR0', 'mario.Esteban@gmail.com', '656  120381', 'Av. Talamas camanadari','','','','','','', 0,'MED-67';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 68, 'betyPaz', 'betPaz', 13, 1,1 ,2, 9, 1, 'bety', 'Paz', 'De Leon', 'bePD1291', 'bePD1291HTCSTR0', 'bety.Paz@gmail.com', '656  131291', 'Av. Independencia','','','','','','', 0,'MED-68';
EXECUTE [dbo].[PG_CI_CLIENTE] 0, 0, 69, 'mariaEscobar', 'marEsc', 7, 1,1 ,4, 1, 1, 'maria', 'Escobar', 'Juarez', 'maEJ1411', 'maEJ1411HTCSTR0', 'maria.Escobar@gmail.com', '656  71411', 'Av. Gomez Morin','','','','','','', 0,'MED-69';



GO




-- ===============================================
SET NOCOUNT OFF
-- ===============================================


-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////



