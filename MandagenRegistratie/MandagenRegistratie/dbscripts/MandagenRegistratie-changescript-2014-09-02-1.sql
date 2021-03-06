/*
   dinsdag 2 september 201414:55:38
   User: 
   Server: SONYVAIO\SQLEXPRESS
   Database: MDRDEV
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
CREATE TABLE dbo.Tmp_Project
	(
	ProjectId int NOT NULL IDENTITY (1, 1),
	ProjectIdOrigineel int NOT NULL,
	ProjectNr int NULL,
	Naam nvarchar(MAX) NOT NULL,
	ProjectleiderId int NOT NULL,
	Actief bit NOT NULL,
	Mutatiedatum datetime NULL,
	Postcode nvarchar(50) NOT NULL,
	Huisnummer nvarchar(50) NOT NULL,
	Adres nvarchar(MAX) NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Project SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_Project ON
GO
IF EXISTS(SELECT * FROM dbo.Project)
	 EXEC('INSERT INTO dbo.Tmp_Project (ProjectId, ProjectIdOrigineel, Naam, ProjectleiderId, Actief, Mutatiedatum, Postcode, Huisnummer, Adres)
		SELECT ProjectId, ProjectIdOrigineel, Naam, ProjectleiderId, Actief, Mutatiedatum, Postcode, Huisnummer, Adres FROM dbo.Project WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_Project OFF
GO
ALTER TABLE dbo.Mandagen
	DROP CONSTRAINT FK_Mandagen_Project
GO
DROP TABLE dbo.Project
GO
EXECUTE sp_rename N'dbo.Tmp_Project', N'Project', 'OBJECT' 
GO
ALTER TABLE dbo.Project ADD CONSTRAINT
	PK_Project PRIMARY KEY CLUSTERED 
	(
	ProjectId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
select Has_Perms_By_Name(N'dbo.Project', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Project', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Project', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.Mandagen ADD CONSTRAINT
	FK_Mandagen_Project FOREIGN KEY
	(
	ProjectId
	) REFERENCES dbo.Project
	(
	ProjectId
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Mandagen SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.Mandagen', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Mandagen', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Mandagen', 'Object', 'CONTROL') as Contr_Per 