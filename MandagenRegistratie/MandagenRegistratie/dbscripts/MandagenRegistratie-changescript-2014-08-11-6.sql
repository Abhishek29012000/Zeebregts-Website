/****** Script for SelectTopNRows command from SSMS  ******/
Update [dbo].[Vakman]
Set BedrijfIdOrigineel = t2.BedrijfIdOrigineel
from        [dbo].[Vakman] t1
inner join  [dbo].[Bedrijf] t2
on          t1.BedrijfId = t2.BedrijfId
