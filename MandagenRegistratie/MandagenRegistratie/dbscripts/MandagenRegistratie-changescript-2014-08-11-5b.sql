
/* LET OP:
EERST  HANDMATIG VAKMAN verwijderen en TMP_Vakman RENAMEN naar Vakman 
*/

ALTER TABLE dbo.Vakman ADD CONSTRAINT
	PK_Persoon PRIMARY KEY CLUSTERED 
	(
	VakmanId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Vakman ADD CONSTRAINT
	FK_Vakman_Bedrijf FOREIGN KEY
	(
	BedrijfId
	) REFERENCES dbo.Bedrijf
	(
	BedrijfId
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO


select Has_Perms_By_Name(N'dbo.Vakman', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Vakman', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Vakman', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.Mandagen ADD CONSTRAINT
	FK_Mandagen_Vakman FOREIGN KEY
	(
	VakmanId
	) REFERENCES dbo.Vakman
	(
	VakmanId
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Mandagen SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.Mandagen', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Mandagen', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Mandagen', 'Object', 'CONTROL') as Contr_Per 