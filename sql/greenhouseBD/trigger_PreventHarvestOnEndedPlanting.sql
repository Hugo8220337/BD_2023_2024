SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Grupo 101
-- Create date: 27/05/2024
-- Description: Impede a adição de colheitas em plantações que já acabaram
-- =============================================
CREATE OR ALTER TRIGGER trigger_PreventHarvestOnEndedPlanting 
   ON  dbo.Harvest
   AFTER INSERT, UPDATE
AS 
BEGIN
    -- SET NOCOUNT ON adicionado para evitar conjuntos de resultados extras
    -- interferindo com instruções SELECT.
    SET NOCOUNT ON;

    DECLARE @EndedPlantingCount int;

    -- Conta o número de colheitas associadas a plantações que já acabaram
    SELECT @EndedPlantingCount = COUNT(*)
    FROM inserted i
    INNER JOIN dbo.Planting p ON i.PlantingNo = p.PlantingNo
    WHERE p.EndData IS NOT NULL;

    -- Se houver colheitas associadas a plantações que já acabaram, lança um erro
    IF @EndedPlantingCount > 0
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('Não é possível adicionar colheitas em plantações que já acabaram.', 16, 1);
        RETURN;
    END;
END;
GO