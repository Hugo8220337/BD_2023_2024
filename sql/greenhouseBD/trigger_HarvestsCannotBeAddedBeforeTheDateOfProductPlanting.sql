SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Grupo 101
-- Create date: 28/05/2024
-- Description:	Não pode haver colheitas anteriores à data da plantação do produto
-- =============================================
CREATE OR ALTER TRIGGER trigger_HarvestsCannotBeAddedBeforeTheDateOfProductPlanting
   ON  Harvest
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @countHarvestPriorThanPlanting INT;

	SELECT @countHarvestPriorThanPlanting = count(*)
	FROM inserted
	INNER JOIN Planting ON inserted.PlantingNo = Planting.PlantingNo
	WHERE inserted.Date < Planting.PlantingDate;

	IF @countHarvestPriorThanPlanting > 0 BEGIN
		ROLLBACK;
		RAISERROR('Não pode haver plantações anteriores à data de plantação!', 16, 1);
	END
END
GO