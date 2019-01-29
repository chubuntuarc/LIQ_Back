-- //////////////////////////////////////////////////////////////
-- /////////////////////////////////////////// HGF - v20171012 //
-- //////////////////////////////////////////////////////////////
-- // BASE DE DATOS:	LIQ19_Liquidaciones
-- // MODULO:			BASE DE DATOS (CREAR VACIA)
-- // OPERACION:		LIBERACION / BASE DE DATOS
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////

USE [master]
GO

 
/****************************************************************/
/*			           BORRADO DE BASE			            	*/
/****************************************************************/

-- DROP DATABASE [LIQ19_Liquidaciones_V9999_R0] 
 

/****************************************************************/
/*			          CREACION DE LA BASE		            	*/
/****************************************************************/

CREATE DATABASE [LIQ19_Liquidaciones_V9999_R0] ON  PRIMARY 
	(	NAME =		N'LIQ19_Liquidaciones_V0001_R0_DAT',	
		FILENAME =	N'C:\SQL_ServerDBs\LIQ19\LIQ19_Liquidaciones_V0001_R0_DAT.mdf', 
		SIZE = 6072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB						)
 LOG ON 
	(	NAME =		N'LIQ19_Liquidaciones_V0001_R0_LOG',	
		FILENAME =	N'C:\SQL_ServerDBs\LIQ19\LIQ19_Liquidaciones_V0001_R0_LOG.ldf',  
		SIZE = 1280KB , MAXSIZE = 2048GB , FILEGROWTH = 10%								)
GO 


ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET COMPATIBILITY_LEVEL = 100
GO



IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LIQ19_Liquidaciones_V9999_R0].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO


ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0]SET ANSI_NULLS OFF 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET ANSI_PADDING OFF
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET ARITHABORT OFF 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET  DISABLE_BROKER 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE[LIQ19_Liquidaciones_V9999_R0] SET  READ_WRITE 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET  MULTI_USER 
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [LIQ19_Liquidaciones_V9999_R0] SET DB_CHAINING OFF 
GO

