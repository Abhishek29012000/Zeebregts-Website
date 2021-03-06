USE [MandagenRegistratieBeta]
GO
/****** Object:  StoredProcedure [dbo].[p_DeleteMandagenVoorVakmanId]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[p_DeleteMandagenVoorVakmanId]
	@VakmanId int,
	@Datum datetime,
	@DatumEind datetime,
	@ProjectleiderId int,
	@CheckDatum datetime

AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @ReturnId as int
	DECLARE @Count as int
 SET @Count = (SELECT COUNT(*) FROM Mandagen 
      WHERE VakmanId = @VakmanId 
     AND Begintijd > @Datum 
     AND Eindtijd < @DatumEind 
     AND ProjectleiderId = @ProjectleiderId 
     AND Status = 1
     AND Mutatiedatum > @CheckDatum)

IF @Count = 0
BEGIN
DELETE FROM  Mandagen
     WHERE VakmanId = @VakmanId 
     AND Begintijd > @Datum 
     AND Eindtijd < @DatumEind 
     AND ProjectleiderId = @ProjectleiderId 
     AND Status = 1
     --AND Mutatiedatum < @CheckDatum

SET @ReturnId = 1
END
ELSE
BEGIN
SET @ReturnId = -1
END

RETURN @ReturnId

END


GO
/****** Object:  StoredProcedure [dbo].[p_DeleteMandagenVoorVakmanIdByProject]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[p_DeleteMandagenVoorVakmanIdByProject]
	@VakmanId int,
	@ProjectId int,
	@Datum datetime,
	@DatumEind datetime,
	@ProjectleiderId int,
	@CheckDatum datetime

AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @ReturnId as int
	DECLARE @Count as int
 SET @Count = (SELECT COUNT(*) FROM Mandagen 
      WHERE VakmanId = @VakmanId
     AND ProjectId = @ProjectId
     AND Begintijd > @Datum 
     AND Eindtijd < @DatumEind 
     AND ProjectleiderId = @ProjectleiderId 
     AND Status = 1
     AND Mutatiedatum > @CheckDatum)

IF @Count = 0
BEGIN
DELETE FROM  Mandagen
     WHERE VakmanId = @VakmanId 
     AND ProjectId = @ProjectId
     AND Begintijd > @Datum 
     AND Eindtijd < @DatumEind 
     AND ProjectleiderId = @ProjectleiderId 
     AND Status = 1
     --AND Mutatiedatum < @CheckDatum

SET @ReturnId = 1
END
ELSE
BEGIN
SET @ReturnId = -1
END

RETURN @ReturnId

END


GO
/****** Object:  Table [dbo].[Bedrijf]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bedrijf](
	[BedrijfId] [int] IDENTITY(1,1) NOT NULL,
	[BedrijfIdOrigineel] [int] NOT NULL,
 CONSTRAINT [PK_Bedrijf] PRIMARY KEY CLUSTERED 
(
	[BedrijfId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Gebruiker]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gebruiker](
	[GebruikerId] [int] IDENTITY(1,1) NOT NULL,
	[Gebruikersnaam] [nvarchar](max) NOT NULL,
	[Windowsidentity] [nvarchar](max) NOT NULL,
	[Gebruikersrol] [int] NOT NULL,
 CONSTRAINT [PK_Gebruiker] PRIMARY KEY CLUSTERED 
(
	[GebruikerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Mandagen]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mandagen](
	[ProjectId] [int] NOT NULL,
	[VakmanId] [int] NOT NULL,
	[VakmanstatusId] [int] NOT NULL,
	[Begintijd] [datetime] NOT NULL,
	[Eindtijd] [datetime] NOT NULL,
	[Status] [bit] NOT NULL,
	[Uren] [int] NOT NULL,
	[Minuten] [int] NOT NULL,
	[UrenGewijzigd] [int] NOT NULL,
	[MinutenGewijzigd] [int] NOT NULL,
	[VakmansoortId] [int] NOT NULL,
	[ProjectleiderId] [int] NOT NULL,
	[Geannulleerd] [bit] NOT NULL,
	[Gewijzigd] [bit] NOT NULL,
	[Bevestigd] [bit] NOT NULL,
	[Bevestigingsdatum] [datetime] NULL,
	[IsChauffeurHeen] [bit] NOT NULL,
	[IsChauffeurTerug] [bit] NOT NULL,
	[KentekenHeen] [nvarchar](50) NULL,
	[KentekenTerug] [nvarchar](50) NULL,
	[Definitief] [bit] NOT NULL,
	[Mutatiedatum] [datetime] NOT NULL,
	[MutatieDoorProjectleiderId] [int] NOT NULL,
 CONSTRAINT [PK_Mandagen_1] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC,
	[VakmanId] ASC,
	[VakmanstatusId] ASC,
	[Begintijd] ASC,
	[Eindtijd] ASC,
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MandagenArchief]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MandagenArchief](
	[MandagenArchiefId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[VakmanId] [int] NOT NULL,
	[VakmanstatusId] [int] NOT NULL,
	[Begintijd] [datetime] NOT NULL,
	[Eindtijd] [datetime] NOT NULL,
	[Uren] [int] NOT NULL,
	[Minuten] [int] NOT NULL,
	[VakmansoortId] [int] NOT NULL,
	[ProjectleiderId] [int] NOT NULL,
	[Bevestigd] [bit] NOT NULL,
	[Bevestigingsdatum] [datetime] NULL,
	[IsChauffeurHeen] [bit] NOT NULL,
	[IsChauffeurTerug] [bit] NOT NULL,
	[KentekenHeen] [nvarchar](50) NULL,
	[KentekenTerug] [nvarchar](50) NULL,
	[Mutatiedatum] [datetime] NOT NULL,
	[MutatieDoorProjectleiderId] [int] NOT NULL,
	[Archiefdatum] [datetime] NOT NULL,
 CONSTRAINT [PK_MandagenArchief] PRIMARY KEY CLUSTERED 
(
	[MandagenArchiefId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Mutatie]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mutatie](
	[MutatieId] [int] IDENTITY(1,1) NOT NULL,
	[MutatietypeId] [int] NOT NULL,
	[AanvraagpersoonId] [int] NOT NULL,
	[AcceptatiepersoonId] [int] NOT NULL,
	[Aanvraagdatum] [datetime] NOT NULL,
	[Geaccepteerd] [bit] NOT NULL,
	[Acceptatiedatum] [datetime] NULL,
	[Originelewaarde] [nvarchar](max) NOT NULL,
	[Nieuwewaarde] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Mutaties] PRIMARY KEY CLUSTERED 
(
	[MutatieId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Mutatietype]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mutatietype](
	[MutatietypeId] [int] NOT NULL,
	[Naam] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Mutatietype] PRIMARY KEY CLUSTERED 
(
	[MutatietypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Project]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[ProjectId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectIdOrigineel] [int] NOT NULL,
	[Naam] [nvarchar](max) NOT NULL,
	[ProjectleiderId] [int] NOT NULL,
	[Actief] [bit] NOT NULL,
	[Mutatiedatum] [datetime] NULL,
	[Postcode] [nvarchar](50) NOT NULL,
	[Huisnummer] [nvarchar](50) NOT NULL,
	[Adres] [nvarchar](max) NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Projectleider]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projectleider](
	[ProjectleiderId] [int] IDENTITY(1,1) NOT NULL,
	[ContactIdOrigineel] [int] NOT NULL,
	[Actief] [bit] NULL,
 CONSTRAINT [PK_Projectleider] PRIMARY KEY CLUSTERED 
(
	[ProjectleiderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Projectplanning]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projectplanning](
	[ProjectId] [int] NOT NULL,
	[Fase] [int] NOT NULL,
	[Begin] [datetime] NOT NULL,
	[Eind] [datetime] NULL,
	[ProjectleiderId] [int] NOT NULL,
	[Aantalvakmannen] [int] NOT NULL,
 CONSTRAINT [PK_Projectplanning] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC,
	[Fase] ASC,
	[Begin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectProjectleider]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectProjectleider](
	[ProjectId] [int] NOT NULL,
	[ProjectleiderId] [int] NOT NULL,
	[Begin] [datetime] NOT NULL,
	[Eind] [datetime] NULL,
 CONSTRAINT [PK_ProjectProjectleider] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC,
	[ProjectleiderId] ASC,
	[Begin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectVakman]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectVakman](
	[ProjectId] [int] NOT NULL,
	[VakmanId] [int] NOT NULL,
	[VakmanstatusId] [int] NOT NULL,
	[Begin] [datetime] NOT NULL,
	[Eind] [datetime] NULL,
 CONSTRAINT [PK_ProjectVakman] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC,
	[VakmanId] ASC,
	[VakmanstatusId] ASC,
	[Begin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Route]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Route](
	[ProjectId] [int] NOT NULL,
	[ChauffeurId] [int] NOT NULL,
	[VakmanId] [int] NOT NULL,
	[Kenteken] [nvarchar](50) NOT NULL,
	[Datum] [datetime] NOT NULL,
	[Heen] [bit] NOT NULL,
	[Volgorde] [int] NOT NULL,
	[PostcodeVan] [nvarchar](50) NOT NULL,
	[HuisnummerVan] [nvarchar](50) NOT NULL,
	[AdresVan] [nvarchar](max) NULL,
	[PostcodeNaar] [nvarchar](50) NOT NULL,
	[HuisnummerNaar] [nvarchar](50) NOT NULL,
	[AdresNaar] [nvarchar](max) NULL,
	[AfstandInKm] [decimal](6, 3) NOT NULL,
 CONSTRAINT [PK_Route] PRIMARY KEY CLUSTERED 
(
	[ChauffeurId] ASC,
	[VakmanId] ASC,
	[ProjectId] ASC,
	[Kenteken] ASC,
	[Datum] ASC,
	[Heen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vakman]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Vakman](
	[VakmanId] [int] IDENTITY(1,1) NOT NULL,
	[ContactIdOrigineel] [int] NOT NULL,
	[BedrijfId] [int] NULL,
	[Actief] [bit] NOT NULL,
	[Intern] [bit] NOT NULL,
	[ZZP] [bit] NULL,
	[Bsn] [nvarchar](50) NULL,
	[Loonkosten] [decimal](6, 2) NULL,
	[Var] [varbinary](max) NULL,
	[Kvk] [varbinary](max) NULL,
	[ProjectleiderId] [int] NULL,
	[Adres] [nvarchar](max) NOT NULL,
	[Postcode] [nvarchar](50) NOT NULL,
	[Huisnummer] [nvarchar](50) NOT NULL,
	[Ophaaladres] [nvarchar](max) NULL,
	[Ophaalpostcode] [nvarchar](50) NULL,
	[Ophaalhuisnummer] [nvarchar](50) NULL,
	[IsChauffeur] [bit] NOT NULL,
	[Kenteken] [nvarchar](50) NULL,
	[Ma] [int] NULL,
	[Di] [int] NULL,
	[Wo] [int] NULL,
	[Do] [int] NULL,
	[Vr] [int] NULL,
	[Za] [int] NULL,
	[Zo] [int] NULL,
	[Werkweek] [int] NULL,
	[DefaultBeginuur] [int] NULL,
	[DefaultBeginminuut] [int] NULL,
 CONSTRAINT [PK_Persoon] PRIMARY KEY CLUSTERED 
(
	[VakmanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Vakmanplanning]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vakmanplanning](
	[VakmanplanningId] [int] IDENTITY(1,1) NOT NULL,
	[VakmanId] [int] NOT NULL,
	[VakmanstatusId] [int] NOT NULL,
	[Begin] [datetime] NULL,
	[Eind] [datetime] NULL,
 CONSTRAINT [PK_Vakmanplanning] PRIMARY KEY CLUSTERED 
(
	[VakmanplanningId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vakmansoort]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vakmansoort](
	[VakmansoortId] [int] NOT NULL,
	[Omschrijving] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Vakmansoort] PRIMARY KEY CLUSTERED 
(
	[VakmansoortId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vakmanstatus]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vakmanstatus](
	[VakmanstatusId] [int] NOT NULL,
	[Omschrijving] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Vakmanstatus] PRIMARY KEY CLUSTERED 
(
	[VakmanstatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[View_1]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_1]
AS
SELECT        MProject.ProjectId, MProject.ProjectIdOrigineel, MProject.Naam, MProject.ProjectleiderId, MProject.Actief, MProject.Mutatiedatum, MProject.Postcode, 
                         MProject.Huisnummer, MProject.Adres, ZPersoon.voornaam, ZPersoon.tussenvoegsel, ZPersoon.achternaam
FROM            dbo.Project AS MProject CROSS JOIN
                         ZeebregtsTest.dbo.persoon AS ZPersoon INNER JOIN
                         dbo.Projectleider AS MProjectleider ON MProjectleider.ProjectleiderId = MProject.ProjectleiderId INNER JOIN
                         dbo.Projectleider AS MProjectleider_1 ON MProjectleider_1.ContactIdOrigineel = ZPersoon.persoon_ID


GO
/****** Object:  View [dbo].[vwProject]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwProject]
AS
SELECT        MProject.ProjectId, MProject.ProjectIdOrigineel, MProject.Naam, MProject.ProjectleiderId, MProject.Actief, MProject.Mutatiedatum, MProject.Postcode, 
                         MProject.Huisnummer, MProject.Adres, ZPersoon.persoon_ID, ZPersoon.persoon_nr, ZPersoon.taak_id, ZPersoon.bedrijf_nr, ZPersoon.man, 
                         ZPersoon.voorletters, ZPersoon.voornaam, ZPersoon.tussenvoegsel, ZPersoon.achternaam, ZPersoon.zamobiel, ZPersoon.zatelefoonvast, ZPersoon.zafax, 
                         ZPersoon.zaemail, ZPersoon.geboortedatum, ZPersoon.vastevrijedag1, ZPersoon.vastevrijedag2, ZPersoon.vastevrijedag3, ZPersoon.NIETactief, 
                         ZPersoon.adres_id, ZPersoon.telefoon_nr_settings, ZPersoon.telefoon_nr_1, ZPersoon.telefoon_nr_2, ZPersoon.telefoon_nr_3, 
                         ZBedrijf.naam AS Bedrijfsnaam, ZProject.project_NR AS ProjectNrOrigineel
FROM            dbo.Project AS MProject CROSS JOIN
                         [OFFICE-SERVER].ZeebregtsDb.dbo.persoon AS ZPersoon INNER JOIN
                         dbo.Projectleider AS MProjectleider ON MProject.ProjectleiderId = MProjectleider.ProjectleiderId AND 
                         MProjectleider.ContactIdOrigineel = ZPersoon.persoon_ID INNER JOIN
                         [OFFICE-SERVER].ZeebregtsDb.dbo.Project AS ZProject ON ZProject.project_ID = MProject.ProjectIdOrigineel INNER JOIN
                         [OFFICE-SERVER].ZeebregtsDb.dbo.bedrijf AS ZBedrijf ON ZProject.opdrachtgeverZEEBREGTS_nr = ZBedrijf.bedrijf_nr

GO
/****** Object:  View [dbo].[vwVakman]    Script Date: 17-5-2013 16:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwVakman]
AS
SELECT        MVakman.VakmanId, MVakman.ContactIdOrigineel, MVakman.BedrijfId, MVakman.Actief, MVakman.Intern, MVakman.ZZP, MVakman.Bsn, 
                         MVakman.Loonkosten, MVakman.[Var], MVakman.Kvk, MVakman.ProjectleiderId, MVakman.Adres, MVakman.Postcode, MVakman.Huisnummer, 
                         MVakman.Ophaaladres, MVakman.Ophaalpostcode, MVakman.Ophaalhuisnummer, MVakman.IsChauffeur, MVakman.Kenteken, MVakman.Ma, MVakman.Di, 
                         MVakman.Wo, MVakman.Do, MVakman.Vr, MVakman.Za, MVakman.Zo, MVakman.Werkweek, MVakman.DefaultBeginuur, MVakman.DefaultBeginminuut, 
                         ZPersoon.voornaam, ZPersoon.tussenvoegsel, ZPersoon.achternaam, ZBedrijf.naam AS bedrijfnaam, ZBedrijf.zoeknaam AS bedrijfzoeknaam, 
                         ZBedrijf.plaats AS bedrijfplaats
FROM            dbo.Vakman AS MVakman INNER JOIN
                         ZeebregtsTest.dbo.persoon AS ZPersoon ON MVakman.ContactIdOrigineel = ZPersoon.persoon_ID INNER JOIN
                         ZeebregtsTest.dbo.bedrijf AS ZBedrijf ON ZPersoon.bedrijf_nr = ZBedrijf.bedrijf_nr


GO
SET IDENTITY_INSERT [dbo].[Bedrijf] ON 

INSERT [dbo].[Bedrijf] ([BedrijfId], [BedrijfIdOrigineel]) VALUES (1, 537)
INSERT [dbo].[Bedrijf] ([BedrijfId], [BedrijfIdOrigineel]) VALUES (2, 261)
INSERT [dbo].[Bedrijf] ([BedrijfId], [BedrijfIdOrigineel]) VALUES (3, 4)
INSERT [dbo].[Bedrijf] ([BedrijfId], [BedrijfIdOrigineel]) VALUES (4, 4)
INSERT [dbo].[Bedrijf] ([BedrijfId], [BedrijfIdOrigineel]) VALUES (5, 5)
INSERT [dbo].[Bedrijf] ([BedrijfId], [BedrijfIdOrigineel]) VALUES (6, 8)
INSERT [dbo].[Bedrijf] ([BedrijfId], [BedrijfIdOrigineel]) VALUES (7, 98)
INSERT [dbo].[Bedrijf] ([BedrijfId], [BedrijfIdOrigineel]) VALUES (8, 11)
INSERT [dbo].[Bedrijf] ([BedrijfId], [BedrijfIdOrigineel]) VALUES (9, 11)
INSERT [dbo].[Bedrijf] ([BedrijfId], [BedrijfIdOrigineel]) VALUES (10, 211)
INSERT [dbo].[Bedrijf] ([BedrijfId], [BedrijfIdOrigineel]) VALUES (11, 261)
INSERT [dbo].[Bedrijf] ([BedrijfId], [BedrijfIdOrigineel]) VALUES (12, 577)
SET IDENTITY_INSERT [dbo].[Bedrijf] OFF
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (1, 1, 1, CAST(0x0000A1B600000000 AS DateTime), CAST(0x0000A1B600000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B600C8F5BF AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B600C8F5BF AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (1, 3, 1, CAST(0x0000A1B600000000 AS DateTime), CAST(0x0000A1B600000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B6012206C6 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B6012206C6 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (1, 5, 1, CAST(0x0000A1B600000000 AS DateTime), CAST(0x0000A1B600000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B601232099 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B601232099 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (1, 28, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B7010B562F AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B7010B562F AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (2, 1, 1, CAST(0x0000A1B600000000 AS DateTime), CAST(0x0000A1B600000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B6011A03F4 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B6011A03F3 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (2, 9, 1, CAST(0x0000A1BD00000000 AS DateTime), CAST(0x0000A1BD00000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1BD00E5FAF3 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1BD00E5FAF3 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (2, 29, 1, CAST(0x0000A1C000000000 AS DateTime), CAST(0x0000A1C000000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C0013714CA AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C0013714CA AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (2, 29, 1, CAST(0x0000A1C0009450C0 AS DateTime), CAST(0x0000A1C000F73140 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C001372033 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C001372033 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (3, 1, 1, CAST(0x0000A1B600000000 AS DateTime), CAST(0x0000A1B600000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B6011A8A83 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B6011A8A83 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (3, 4, 1, CAST(0x0000A1B600000000 AS DateTime), CAST(0x0000A1B600000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B601230186 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B601230185 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (3, 7, 1, CAST(0x0000A1C000000000 AS DateTime), CAST(0x0000A1C000000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C00136F22E AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C00136F22D AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 1, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B70D26 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B70D26 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 1, 1, CAST(0x0000A1B70062E080 AS DateTime), CAST(0x0000A1B7009C8E20 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700CF4B31 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700CF4B31 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 1, 1, CAST(0x0000A1B7009C8E20 AS DateTime), CAST(0x0000A1B700A4CB80 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700CF4B81 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700CF4B81 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 1, 1, CAST(0x0000A1B700A4CB80 AS DateTime), CAST(0x0000A1B700B54640 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700CF4BC7 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700CF4BC7 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 3, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B73057 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B73057 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 3, 1, CAST(0x0000A1B700B54640 AS DateTime), CAST(0x0000A1B700C5C100 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700D75863 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700D75863 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 3, 1, CAST(0x0000A1B700C5C100 AS DateTime), CAST(0x0000A1B700F73140 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700D7587E AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700D7587E AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 3, 1, CAST(0x0000A1C100A4CB80 AS DateTime), CAST(0x0000A1C100AD08E0 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100BE8479 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100BE8479 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 3, 1, CAST(0x0000A1C100B12790 AS DateTime), CAST(0x0000A1C100B54640 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100BE849C AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100BE849C AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 3, 1, CAST(0x0000A1C100B54640 AS DateTime), CAST(0x0000A1C100B964F0 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100BE84B2 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100BE84B2 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 4, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B6C80F AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B6C80F AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 5, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B6CBFD AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B6CBFD AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 5, 1, CAST(0x0000A1B7009C8E20 AS DateTime), CAST(0x0000A1B700B54640 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700C1CA3F AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700C1CA3F AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 5, 1, CAST(0x0000A1B700B54640 AS DateTime), CAST(0x0000A1B700C5C100 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700C1CA6A AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700C1CA6A AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 5, 1, CAST(0x0000A1C1009450C0 AS DateTime), CAST(0x0000A1C1011826C0 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100937424 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100937424 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 6, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B6DE0D AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B6DE0D AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 6, 1, CAST(0x0000A1B800B54640 AS DateTime), CAST(0x0000A1B800FB4FF0 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700D23B36 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700D23B36 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 6, 1, CAST(0x0000A1C1009450C0 AS DateTime), CAST(0x0000A1C100B964F0 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C10093967E AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C10093967E AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 7, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B75408 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B75408 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 7, 1, CAST(0x0000A1B700B54640 AS DateTime), CAST(0x0000A1B700C5C100 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700D06887 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700D06887 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 7, 1, CAST(0x0000A1B700C5C100 AS DateTime), CAST(0x0000A1B700F73140 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700D068CF AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700D068CF AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 7, 1, CAST(0x0000A1BD00A4CB80 AS DateTime), CAST(0x0000A1BD00B964F0 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1BD00F2472A AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1BD00F2472A AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 8, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B71C7B AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B71C7B AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 8, 1, CAST(0x0000A1B7005265C0 AS DateTime), CAST(0x0000A1B70062E080 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700C98C73 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700C98C73 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 8, 1, CAST(0x0000A1B70062E080 AS DateTime), CAST(0x0000A1B7007779F0 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700C98CBE AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700C98CBE AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 8, 1, CAST(0x0000A1B7007779F0 AS DateTime), CAST(0x0000A1B70083D600 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700C98D4F AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700C98D4F AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 8, 1, CAST(0x0000A1BD00B54640 AS DateTime), CAST(0x0000A1BD00D63BC0 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1BD00E52DE7 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1BD00E52DE7 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 11, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B6D34D AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B6D34D AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 11, 1, CAST(0x0000A1C100B54640 AS DateTime), CAST(0x0000A1C100B964F0 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100BEB4C4 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100BEB4C4 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 11, 1, CAST(0x0000A1C100B964F0 AS DateTime), CAST(0x0000A1C100C5C100 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100BEB4D9 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100BEB4D9 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 11, 1, CAST(0x0000A1C100D21D10 AS DateTime), CAST(0x0000A1C100E6B680 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100BEB4F2 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100BEB4F2 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 11, 1, CAST(0x0000A1C100E6B680 AS DateTime), CAST(0x0000A1C100F73140 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100BEB512 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100BEB512 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 12, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B6D73F AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B6D73F AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 12, 1, CAST(0x0000A1B700A4CB80 AS DateTime), CAST(0x0000A1B700B54640 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700C98FFF AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700C98FFF AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 12, 1, CAST(0x0000A1BD00B54640 AS DateTime), CAST(0x0000A1BD00D63BC0 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1BD00E48A5C AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1BD00E48A5C AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 13, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B6CF7F AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B6CF7F AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 13, 1, CAST(0x0000A1B700735B40 AS DateTime), CAST(0x0000A1B700B54640 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700D3D8B7 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700D3D8B7 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 13, 1, CAST(0x0000A1B700B54640 AS DateTime), CAST(0x0000A1B700F73140 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700D3D8D4 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700D3D8D4 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 13, 1, CAST(0x0000A1B700F73140 AS DateTime), CAST(0x0000A1B701206420 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700D3D8FA AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700D3D8FA AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 14, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B74C6B AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B74C6B AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 14, 1, CAST(0x0000A1B700735B40 AS DateTime), CAST(0x0000A1B7009C8E20 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700C94D32 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700C94D32 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 14, 1, CAST(0x0000A1B7009C8E20 AS DateTime), CAST(0x0000A1B700A4CB80 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700C94D92 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700C94D92 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 14, 1, CAST(0x0000A1B700A4CB80 AS DateTime), CAST(0x0000A1B700B54640 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700C94DEF AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700C94DEF AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 14, 1, CAST(0x0000A1B800B54640 AS DateTime), CAST(0x0000A1B800FB4FF0 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700D246D4 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700D246D4 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 14, 1, CAST(0x0000A1C10083D600 AS DateTime), CAST(0x0000A1C1009450C0 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100A75D2F AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100A75D2F AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 14, 1, CAST(0x0000A1C1009450C0 AS DateTime), CAST(0x0000A1C100B54640 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100A75D4B AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100A75D4B AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 14, 1, CAST(0x0000A1C100C5C100 AS DateTime), CAST(0x0000A1C100E6B680 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100A75D6C AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100A75D6C AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 16, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B6E9D8 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B6E9D8 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 17, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B7245A AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B7245A AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 18, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B70713 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B70713 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 19, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B6F510 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B6F510 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 20, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B700B8 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B700B8 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 21, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B7704C AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B7704C AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 21, 1, CAST(0x0000A1C100AD08E0 AS DateTime), CAST(0x0000A1C100B12790 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100BF529B AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100BF529B AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 21, 1, CAST(0x0000A1C100B12790 AS DateTime), CAST(0x0000A1C100B964F0 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100BF52B1 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100BF52B1 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 21, 1, CAST(0x0000A1C100B964F0 AS DateTime), CAST(0x0000A1C100C5C100 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100BF52CE AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100BF52CE AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 21, 1, CAST(0x0000A1C100C9DFB0 AS DateTime), CAST(0x0000A1C100D21D10 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100BF52E3 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100BF52E3 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 21, 1, CAST(0x0000A1C100D21D10 AS DateTime), CAST(0x0000A1C100D63BC0 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100BF52F7 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100BF52F7 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 21, 1, CAST(0x0000A1C100DE7920 AS DateTime), CAST(0x0000A1C100F73140 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100BF530B AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100BF530B AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 21, 1, CAST(0x0000A1C100F73140 AS DateTime), CAST(0x0000A1C10107AC00 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1C100BF531F AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1C100BF531F AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 22, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B781BB AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B781BB AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 24, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700B7A397 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700B7A397 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 25, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700C069BC AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700C069BC AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 26, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700C0AC34 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700C0AC34 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 27, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B700D53685 AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B700D53684 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (4, 28, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B7010B427A AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B7010B4275 AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (5, 9, 1, CAST(0x0000A1BF00000000 AS DateTime), CAST(0x0000A1BF00000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1BF012AC60D AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1BF012AC60D AS DateTime), 1)
INSERT [dbo].[Mandagen] ([ProjectId], [VakmanId], [VakmanstatusId], [Begintijd], [Eindtijd], [Status], [Uren], [Minuten], [UrenGewijzigd], [MinutenGewijzigd], [VakmansoortId], [ProjectleiderId], [Geannulleerd], [Gewijzigd], [Bevestigd], [Bevestigingsdatum], [IsChauffeurHeen], [IsChauffeurTerug], [KentekenHeen], [KentekenTerug], [Definitief], [Mutatiedatum], [MutatieDoorProjectleiderId]) VALUES (5, 28, 1, CAST(0x0000A1B700000000 AS DateTime), CAST(0x0000A1B700000000 AS DateTime), 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, CAST(0x0000A1B7010BCC5E AS DateTime), 0, 0, N'', N'', 0, CAST(0x0000A1B7010BCC59 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Project] ON 

INSERT [dbo].[Project] ([ProjectId], [ProjectIdOrigineel], [Naam], [ProjectleiderId], [Actief], [Mutatiedatum], [Postcode], [Huisnummer], [Adres]) VALUES (0, 0, N'ProjectFictief', 1, 1, CAST(0x0000A11500000000 AS DateTime), N'6512HC', N'20', N'')
INSERT [dbo].[Project] ([ProjectId], [ProjectIdOrigineel], [Naam], [ProjectleiderId], [Actief], [Mutatiedatum], [Postcode], [Huisnummer], [Adres]) VALUES (1, 1168, N'Tilburg Talent Square', 1, 1, CAST(0x0000A1B600C8A798 AS DateTime), N'', N'', N'')
INSERT [dbo].[Project] ([ProjectId], [ProjectIdOrigineel], [Naam], [ProjectleiderId], [Actief], [Mutatiedatum], [Postcode], [Huisnummer], [Adres]) VALUES (2, 5, N'Plan Andreas', 1, 1, CAST(0x0000A1B601021964 AS DateTime), N'', N'', N'')
INSERT [dbo].[Project] ([ProjectId], [ProjectIdOrigineel], [Naam], [ProjectleiderId], [Actief], [Mutatiedatum], [Postcode], [Huisnummer], [Adres]) VALUES (3, 14, N'El Mundo 39 huurwoningen', 1, 1, CAST(0x0000A1B601022636 AS DateTime), N'', N'', N'')
INSERT [dbo].[Project] ([ProjectId], [ProjectIdOrigineel], [Naam], [ProjectleiderId], [Actief], [Mutatiedatum], [Postcode], [Huisnummer], [Adres]) VALUES (4, 4, N'Kantoor Quion Fascinatio', 1, 1, CAST(0x0000A1B601225725 AS DateTime), N'', N'', N'')
INSERT [dbo].[Project] ([ProjectId], [ProjectIdOrigineel], [Naam], [ProjectleiderId], [Actief], [Mutatiedatum], [Postcode], [Huisnummer], [Adres]) VALUES (5, 11, N'Reviustoren', 1, 1, CAST(0x0000A1B7010BC9CA AS DateTime), N'', N'', N'')
SET IDENTITY_INSERT [dbo].[Project] OFF
SET IDENTITY_INSERT [dbo].[Projectleider] ON 

INSERT [dbo].[Projectleider] ([ProjectleiderId], [ContactIdOrigineel], [Actief]) VALUES (1, 1, 1)
INSERT [dbo].[Projectleider] ([ProjectleiderId], [ContactIdOrigineel], [Actief]) VALUES (2, 7, 1)
INSERT [dbo].[Projectleider] ([ProjectleiderId], [ContactIdOrigineel], [Actief]) VALUES (3, 6, 1)
INSERT [dbo].[Projectleider] ([ProjectleiderId], [ContactIdOrigineel], [Actief]) VALUES (4, 8, 1)
INSERT [dbo].[Projectleider] ([ProjectleiderId], [ContactIdOrigineel], [Actief]) VALUES (5, 16, 1)
INSERT [dbo].[Projectleider] ([ProjectleiderId], [ContactIdOrigineel], [Actief]) VALUES (6, 20, 1)
SET IDENTITY_INSERT [dbo].[Projectleider] OFF
SET IDENTITY_INSERT [dbo].[Vakman] ON 

INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (1, 1408, 1, 1, 0, NULL, N'Jeroen v/d Broek', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (2, 1526, 1, 1, 1, NULL, N'Dave de Hondt', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (3, 5, 2, 1, 0, NULL, N'Peter Reizevoort', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (4, 19, 1, 1, 1, NULL, N'Harrie van Gorp', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (5, 28, 1, 1, 1, NULL, N'Patrick Meewis', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (6, 72, 3, 1, 0, NULL, N'Ronald Pleijster', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (7, 29, 1, 1, 1, NULL, N' Mihalcea', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (8, 39, 1, 1, 1, NULL, N'Jan Verbruggen', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (9, 67, 4, 1, 0, NULL, N'Sarah Bakker', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (10, 49, 2, 1, 0, NULL, N'Leon Sevriens', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (11, 47, 1, 1, 1, NULL, N'Guus Vriens', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (12, 65, 4, 1, 0, NULL, N'Marlies Groenhof', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (13, 41, 1, 1, 1, NULL, N'Hans Versantvoort', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (14, 61, 3, 1, 0, NULL, N'Marc van Hoof', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (15, 63, 4, 1, 0, NULL, N'Anita Aarts', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (16, 78, 4, 1, 0, NULL, N'Jasper Schut', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (17, 43, 1, 1, 1, NULL, N'Wil Wolsleger', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (18, 74, 4, 1, 0, NULL, N'René van der Salm', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (19, 112, 5, 1, 0, NULL, N'Peter Bol', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (20, 71, 4, 1, 0, NULL, N'Randal Wapkes', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (21, 125, 6, 1, 0, NULL, N'Jurjen Sonnenberg', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (22, 1215, 7, 1, 0, NULL, N'Stijn Schreuder', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (23, 138, 8, 1, 0, NULL, N'Bennie Struker', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (24, 137, 9, 1, 0, NULL, N'Tom Peters', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (25, 10, 10, 1, 0, NULL, N'Roy van Gorkom', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (26, 103, 5, 1, 0, NULL, N'Anja de Leeuw', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (27, 113, 7, 1, 0, NULL, N'Kees van der List', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (28, 4, 11, 1, 0, NULL, N'Martijn Ansems', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
INSERT [dbo].[Vakman] ([VakmanId], [ContactIdOrigineel], [BedrijfId], [Actief], [Intern], [ZZP], [Bsn], [Loonkosten], [Var], [Kvk], [ProjectleiderId], [Adres], [Postcode], [Huisnummer], [Ophaaladres], [Ophaalpostcode], [Ophaalhuisnummer], [IsChauffeur], [Kenteken], [Ma], [Di], [Wo], [Do], [Vr], [Za], [Zo], [Werkweek], [DefaultBeginuur], [DefaultBeginminuut]) VALUES (29, 1378, 12, 1, 0, NULL, N'Juraci van Mulier', NULL, NULL, NULL, 1, N'', N'', N'', NULL, NULL, NULL, 0, NULL, 8, 8, 8, 8, 8, 0, 0, 40, 8, 0)
SET IDENTITY_INSERT [dbo].[Vakman] OFF
INSERT [dbo].[Vakmansoort] ([VakmansoortId], [Omschrijving]) VALUES (1, N'Intern')
INSERT [dbo].[Vakmansoort] ([VakmansoortId], [Omschrijving]) VALUES (2, N'Extern bedrijf')
INSERT [dbo].[Vakmansoort] ([VakmansoortId], [Omschrijving]) VALUES (3, N'ZZP')
INSERT [dbo].[Vakmanstatus] ([VakmanstatusId], [Omschrijving]) VALUES (1, N'Ingepland')
INSERT [dbo].[Vakmanstatus] ([VakmanstatusId], [Omschrijving]) VALUES (2, N'Ziek')
INSERT [dbo].[Vakmanstatus] ([VakmanstatusId], [Omschrijving]) VALUES (3, N'Vakantie')
INSERT [dbo].[Vakmanstatus] ([VakmanstatusId], [Omschrijving]) VALUES (4, N'Vrij')
ALTER TABLE [dbo].[Mandagen] ADD  CONSTRAINT [DF_Mandagen_UrenGewijzigd]  DEFAULT ((0)) FOR [UrenGewijzigd]
GO
ALTER TABLE [dbo].[Mandagen] ADD  CONSTRAINT [DF_Mandagen_MinutenGewijzigd]  DEFAULT ((0)) FOR [MinutenGewijzigd]
GO
ALTER TABLE [dbo].[Mandagen] ADD  CONSTRAINT [DF_Mandagen_Geannulleerd]  DEFAULT ((0)) FOR [Geannulleerd]
GO
ALTER TABLE [dbo].[Mandagen] ADD  CONSTRAINT [DF_Mandagen_Gewijzigd]  DEFAULT ((1)) FOR [Gewijzigd]
GO
ALTER TABLE [dbo].[Mandagen] ADD  CONSTRAINT [DF_Mandagen_Definitief]  DEFAULT ((0)) FOR [Definitief]
GO
ALTER TABLE [dbo].[Mandagen] ADD  CONSTRAINT [DF_Mandagen_Mutatiedatum]  DEFAULT (getdate()) FOR [Mutatiedatum]
GO
ALTER TABLE [dbo].[MandagenArchief] ADD  CONSTRAINT [DF_MandagenArchief_Archiefdatum]  DEFAULT (getdate()) FOR [Archiefdatum]
GO
ALTER TABLE [dbo].[Vakman] ADD  CONSTRAINT [DF_Persoon_Loonkosten]  DEFAULT ((0)) FOR [BedrijfId]
GO
ALTER TABLE [dbo].[Vakman] ADD  CONSTRAINT [DF_Persoon_Actief]  DEFAULT ((1)) FOR [Actief]
GO
ALTER TABLE [dbo].[Vakman] ADD  CONSTRAINT [DF_Persoon_Eigenvervoer]  DEFAULT ((0)) FOR [Kenteken]
GO
ALTER TABLE [dbo].[Vakman] ADD  CONSTRAINT [DF_Vakman_DefaultBeginuur]  DEFAULT ((8)) FOR [DefaultBeginuur]
GO
ALTER TABLE [dbo].[Vakman] ADD  CONSTRAINT [DF_Vakman_DefaultBeginminuut]  DEFAULT ((0)) FOR [DefaultBeginminuut]
GO
ALTER TABLE [dbo].[Mandagen]  WITH CHECK ADD  CONSTRAINT [FK_Mandagen_Project] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([ProjectId])
GO
ALTER TABLE [dbo].[Mandagen] CHECK CONSTRAINT [FK_Mandagen_Project]
GO
ALTER TABLE [dbo].[Mandagen]  WITH CHECK ADD  CONSTRAINT [FK_Mandagen_Vakman] FOREIGN KEY([VakmanId])
REFERENCES [dbo].[Vakman] ([VakmanId])
GO
ALTER TABLE [dbo].[Mandagen] CHECK CONSTRAINT [FK_Mandagen_Vakman]
GO
ALTER TABLE [dbo].[Mandagen]  WITH CHECK ADD  CONSTRAINT [FK_Mandagen_Vakmansoort] FOREIGN KEY([VakmansoortId])
REFERENCES [dbo].[Vakmansoort] ([VakmansoortId])
GO
ALTER TABLE [dbo].[Mandagen] CHECK CONSTRAINT [FK_Mandagen_Vakmansoort]
GO
ALTER TABLE [dbo].[Mandagen]  WITH CHECK ADD  CONSTRAINT [FK_Mandagen_Vakmanstatus] FOREIGN KEY([VakmanstatusId])
REFERENCES [dbo].[Vakmanstatus] ([VakmanstatusId])
GO
ALTER TABLE [dbo].[Mandagen] CHECK CONSTRAINT [FK_Mandagen_Vakmanstatus]
GO
ALTER TABLE [dbo].[Projectplanning]  WITH CHECK ADD  CONSTRAINT [FK_Projectplanning_Project] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([ProjectId])
GO
ALTER TABLE [dbo].[Projectplanning] CHECK CONSTRAINT [FK_Projectplanning_Project]
GO
ALTER TABLE [dbo].[Projectplanning]  WITH CHECK ADD  CONSTRAINT [FK_Projectplanning_Projectleider] FOREIGN KEY([ProjectleiderId])
REFERENCES [dbo].[Projectleider] ([ProjectleiderId])
GO
ALTER TABLE [dbo].[Projectplanning] CHECK CONSTRAINT [FK_Projectplanning_Projectleider]
GO
ALTER TABLE [dbo].[ProjectProjectleider]  WITH CHECK ADD  CONSTRAINT [FK_ProjectProjectleider_Project] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([ProjectId])
GO
ALTER TABLE [dbo].[ProjectProjectleider] CHECK CONSTRAINT [FK_ProjectProjectleider_Project]
GO
ALTER TABLE [dbo].[ProjectProjectleider]  WITH CHECK ADD  CONSTRAINT [FK_ProjectProjectleider_Projectleider] FOREIGN KEY([ProjectleiderId])
REFERENCES [dbo].[Projectleider] ([ProjectleiderId])
GO
ALTER TABLE [dbo].[ProjectProjectleider] CHECK CONSTRAINT [FK_ProjectProjectleider_Projectleider]
GO
ALTER TABLE [dbo].[ProjectVakman]  WITH CHECK ADD  CONSTRAINT [FK_ProjectVakman_Project] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([ProjectId])
GO
ALTER TABLE [dbo].[ProjectVakman] CHECK CONSTRAINT [FK_ProjectVakman_Project]
GO
ALTER TABLE [dbo].[ProjectVakman]  WITH CHECK ADD  CONSTRAINT [FK_ProjectVakman_Vakman] FOREIGN KEY([VakmanId])
REFERENCES [dbo].[Vakman] ([VakmanId])
GO
ALTER TABLE [dbo].[ProjectVakman] CHECK CONSTRAINT [FK_ProjectVakman_Vakman]
GO
ALTER TABLE [dbo].[ProjectVakman]  WITH CHECK ADD  CONSTRAINT [FK_ProjectVakman_Vakmanstatus] FOREIGN KEY([VakmanstatusId])
REFERENCES [dbo].[Vakmanstatus] ([VakmanstatusId])
GO
ALTER TABLE [dbo].[ProjectVakman] CHECK CONSTRAINT [FK_ProjectVakman_Vakmanstatus]
GO
ALTER TABLE [dbo].[Route]  WITH CHECK ADD  CONSTRAINT [FK_Route_Project] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([ProjectId])
GO
ALTER TABLE [dbo].[Route] CHECK CONSTRAINT [FK_Route_Project]
GO
ALTER TABLE [dbo].[Route]  WITH CHECK ADD  CONSTRAINT [FK_Route_Vakman] FOREIGN KEY([VakmanId])
REFERENCES [dbo].[Vakman] ([VakmanId])
GO
ALTER TABLE [dbo].[Route] CHECK CONSTRAINT [FK_Route_Vakman]
GO
ALTER TABLE [dbo].[Route]  WITH CHECK ADD  CONSTRAINT [FK_Route_Vakman1] FOREIGN KEY([ChauffeurId])
REFERENCES [dbo].[Vakman] ([VakmanId])
GO
ALTER TABLE [dbo].[Route] CHECK CONSTRAINT [FK_Route_Vakman1]
GO
ALTER TABLE [dbo].[Vakman]  WITH CHECK ADD  CONSTRAINT [FK_Vakman_Bedrijf] FOREIGN KEY([BedrijfId])
REFERENCES [dbo].[Bedrijf] ([BedrijfId])
GO
ALTER TABLE [dbo].[Vakman] CHECK CONSTRAINT [FK_Vakman_Bedrijf]
GO
ALTER TABLE [dbo].[Vakmanplanning]  WITH CHECK ADD  CONSTRAINT [FK_Vakmanplanning_Vakman] FOREIGN KEY([VakmanId])
REFERENCES [dbo].[Vakman] ([VakmanId])
GO
ALTER TABLE [dbo].[Vakmanplanning] CHECK CONSTRAINT [FK_Vakmanplanning_Vakman]
GO
ALTER TABLE [dbo].[Vakmanplanning]  WITH CHECK ADD  CONSTRAINT [FK_Vakmanplanning_Vakmanstatus] FOREIGN KEY([VakmanstatusId])
REFERENCES [dbo].[Vakmanstatus] ([VakmanstatusId])
GO
ALTER TABLE [dbo].[Vakmanplanning] CHECK CONSTRAINT [FK_Vakmanplanning_Vakmanstatus]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[26] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "MProject"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 222
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MProjectleider"
            Begin Extent = 
               Top = 17
               Left = 351
               Bottom = 130
               Right = 540
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ZPersoon"
            Begin Extent = 
               Top = 6
               Left = 578
               Bottom = 136
               Right = 773
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MProjectleider_1"
            Begin Extent = 
               Top = 6
               Left = 811
               Bottom = 119
               Right = 1000
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 5445
         Width = 5460
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2115
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 13' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'50
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[39] 4[9] 2[24] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "MProject"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 261
               Right = 222
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ZPersoon"
            Begin Extent = 
               Top = 6
               Left = 578
               Bottom = 278
               Right = 773
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MProjectleider"
            Begin Extent = 
               Top = 17
               Left = 351
               Bottom = 130
               Right = 540
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ZProject"
            Begin Extent = 
               Top = 132
               Left = 260
               Bottom = 262
               Right = 556
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ZBedrijf"
            Begin Extent = 
               Top = 6
               Left = 811
               Bottom = 136
               Right = 1013
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 33
         Width = 284
         Width = 5445
         Width = 5460
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'    Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[9] 2[26] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "MVakman"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 234
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ZPersoon"
            Begin Extent = 
               Top = 6
               Left = 260
               Bottom = 136
               Right = 455
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ZBedrijf"
            Begin Extent = 
               Top = 6
               Left = 493
               Bottom = 136
               Right = 695
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 33
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwVakman'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwVakman'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwVakman'
GO
