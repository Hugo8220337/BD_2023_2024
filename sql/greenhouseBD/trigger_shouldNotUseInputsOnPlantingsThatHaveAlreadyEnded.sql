SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Grupo 101
-- Create date: 2705/2024
-- Description:	Verifica se a planta��o onde o insumo foi registado j� foi terminada,
--				se sim, salta fora
-- =============================================
CREATE OR ALTER TRIGGER trigger_shouldNotUseInputsOnPlantingsThatHaveAlreadyEnded 
   ON  [Planting/Input]
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @numberOfTerminatedPlantings int;

	SELECT @numberOfTerminatedPlantings = count(*)
	From inserted
	INNER JOIN Planting ON Planting.PlantingNo = inserted.PlantingNo
	WHERE Planting.EndData IS NOT NULL

	IF @numberOfTerminatedPlantings > 0 BEGIN
		ROLLBACK;
		RAISERROR('N�o se pode usar insumos em planta��es que j� acabaram!', 16, 1);
	END

END
GO
