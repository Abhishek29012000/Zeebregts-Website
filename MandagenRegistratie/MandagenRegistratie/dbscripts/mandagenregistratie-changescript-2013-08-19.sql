USE [MandagenRegistratie]
GO
/****** Object:  StoredProcedure [dbo].[p_DeleteMandagenVoorVakmanIdByProject]    Script Date: 19-8-2013 13:32:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[p_DeleteMandagenVoorVakmanIdByProject]
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
     AND Begintijd >= @Datum 
     AND Eindtijd <= @DatumEind 
	 AND Eindtijd > Begintijd
     AND ProjectleiderId = @ProjectleiderId 
     AND Status = 1
     AND Mutatiedatum > @CheckDatum)

	 --SET @Count = 0

IF @Count = 0
BEGIN
DELETE FROM  Mandagen
     WHERE VakmanId = @VakmanId 
     AND ProjectId = @ProjectId
     AND Begintijd >= @Datum 
     AND Eindtijd <= @DatumEind 
	 AND Eindtijd > Begintijd
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



