/*
   maandag 30 september 201315:33:35
   User: 
   Server: SONYVAIO\SQLEXPRESS
   Database: MandagenRegistratieBeta
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Gebruiker
	DROP CONSTRAINT DF_Gebruiker_Updaten
GO
ALTER TABLE dbo.Gebruiker
	DROP CONSTRAINT DF_Gebruiker_Write
GO
ALTER TABLE dbo.Gebruiker
	DROP CONSTRAINT DF_Gebruiker_Admin
GO
ALTER TABLE dbo.Gebruiker
	DROP CONSTRAINT DF_Gebruiker_ContactIdOrigineel
GO
CREATE TABLE dbo.Tmp_Gebruiker
	(
	GebruikerId int NOT NULL IDENTITY (1, 1),
	Gebruikersnaam nvarchar(MAX) NOT NULL,
	Windowsidentity nvarchar(MAX) NOT NULL,
	Gebruikersrol int NOT NULL,
	ProjectleiderId int NOT NULL,
	IsProjectleider bit NOT NULL,
	CanLoginAsProjectleider bit NOT NULL,
	IsAdministrator bit NOT NULL,
	ContactIdOrigineel int NOT NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Gebruiker SET (LOCK_ESCALATION = TABLE)
GO
ALTER TABLE dbo.Tmp_Gebruiker ADD CONSTRAINT
	DF_Gebruiker_Updaten DEFAULT ((0)) FOR IsProjectleider
GO
ALTER TABLE dbo.Tmp_Gebruiker ADD CONSTRAINT
	DF_Gebruiker_Write DEFAULT ((0)) FOR CanLoginAsProjectleider
GO
ALTER TABLE dbo.Tmp_Gebruiker ADD CONSTRAINT
	DF_Gebruiker_Admin DEFAULT ((0)) FOR IsAdministrator
GO
ALTER TABLE dbo.Tmp_Gebruiker ADD CONSTRAINT
	DF_Gebruiker_ContactIdOrigineel DEFAULT ((1)) FOR ContactIdOrigineel
GO
SET IDENTITY_INSERT dbo.Tmp_Gebruiker ON
GO
IF EXISTS(SELECT * FROM dbo.Gebruiker)
	 EXEC('INSERT INTO dbo.Tmp_Gebruiker (GebruikerId, Gebruikersnaam, Windowsidentity, Gebruikersrol, ProjectleiderId, IsProjectleider, CanLoginAsProjectleider, IsAdministrator, ContactIdOrigineel)
		SELECT GebruikerId, Gebruikersnaam, Windowsidentity, Gebruikersrol, ProjectleiderId, IsProjectleider, CanLoginAsProjectleider, IsAdministrator, ContactIdOrigineel FROM dbo.Gebruiker WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_Gebruiker OFF
GO
DROP TABLE dbo.Gebruiker
GO
EXECUTE sp_rename N'dbo.Tmp_Gebruiker', N'Gebruiker', 'OBJECT' 
GO
ALTER TABLE dbo.Gebruiker ADD CONSTRAINT
	PK_Gebruiker PRIMARY KEY CLUSTERED 
	(
	GebruikerId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
select Has_Perms_By_Name(N'dbo.Gebruiker', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Gebruiker', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Gebruiker', 'Object', 'CONTROL') as Contr_Per 