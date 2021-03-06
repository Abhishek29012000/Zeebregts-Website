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
ALTER TABLE dbo.Projectplanning
	DROP CONSTRAINT FK_Projectplanning_Projectleider
GO
ALTER TABLE dbo.ProjectProjectleider
	DROP CONSTRAINT FK_ProjectProjectleider_Projectleider
GO
ALTER TABLE dbo.Projectleider SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.Projectleider', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Projectleider', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Projectleider', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.ProjectProjectleider SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.ProjectProjectleider', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.ProjectProjectleider', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.ProjectProjectleider', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.Projectplanning SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.Projectplanning', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Projectplanning', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Projectplanning', 'Object', 'CONTROL') as Contr_Per 

Drop table Projectleider