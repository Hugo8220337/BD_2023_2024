SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Grupo 101
-- Create date: 27/05/2024
-- Description:	Data do uso do insumo não pode ser maior que a data da plantação do produto
-- =============================================
CREATE OR ALTER TRIGGER trigger_DateOfInputUsageShouldBeGreaterThanThePlantingDate
   ON  [Planting/Input]
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare @countInputDateLesserThanPlantingDate INT;

	SELECT @countInputDateLesserThanPlantingDate = COUNT(*)
	FROM inserted
	INNER JOIN Planting ON Planting.PlantingNo = inserted.PlantingNo
	WHERE inserted.Date < Planting.PlantingDate

	IF @countInputDateLesserThanPlantingDate > 0 BEGIN
		ROLLBACK;
		RAISERROR('Data é menor que a data da plantação!',16,1);
	END
END
GO
