SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Grupo 101
-- Create date: 27/05/2024
-- Description: Impede a adi��o de colheitas em planta��es que j� acabaram
-- =============================================
CREATE OR ALTER TRIGGER trigger_PreventHarvestOnEndedPlanting 
   ON  dbo.Harvest
   AFTER INSERT, UPDATE
AS 
BEGIN
    -- SET NOCOUNT ON adicionado para evitar conjuntos de resultados extras
    -- interferindo com instru��es SELECT.
    SET NOCOUNT ON;

    DECLARE @EndedPlantingCount int;

    -- Conta o n�mero de colheitas associadas a planta��es que j� acabaram
    SELECT @EndedPlantingCount = COUNT(*)
    FROM inserted i
    INNER JOIN dbo.Planting p ON i.PlantingNo = p.PlantingNo
    WHERE p.EndData IS NOT NULL;

    -- Se houver colheitas associadas a planta��es que j� acabaram, lan�a um erro
    IF @EndedPlantingCount > 0
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('N�o � poss�vel adicionar colheitas em planta��es que j� acabaram.', 16, 1);
        RETURN;
    END;
END;
GO