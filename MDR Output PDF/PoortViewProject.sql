use PdfOutput
select 
	  ProjectId as ProjectID
	, project_NR as ProjectNR
	, Naam
	, projectleiderID
	, bouw_straat
	, plaats
from 
MandagenRegistratie	.dbo.project MPR INNER JOIN
ZeebregtsDB	.dbo.project ZPR ON ZPR.project_ID = MPR.ProjectIdOrigineel


