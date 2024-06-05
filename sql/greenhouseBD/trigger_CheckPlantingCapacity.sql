SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Grupo 101
-- Create date: 27/05/2024
-- Description: Impede que o número de plantações exceda a capacidade máxima de uma secção
-- =============================================
CREATE OR ALTER TRIGGER trigger_CheckPlantingCapacity 
   ON dbo.Planting
   AFTER INSERT, UPDATE
AS 
BEGIN
    -- SET NOCOUNT ON adicionado para evitar conjuntos de resultados extras
    -- interferindo com instruções SELECT.
    SET NOCOUNT ON;

    DECLARE @ExceededCapacityCount INT;

    -- Verifica se o número de plantações em qualquer seção excede a capacidade máxima
	SELECT @ExceededCapacityCount = COUNT(*)
	FROM inserted
	INNER JOIN Section ON inserted.SectionNo = Section.SectionNo
	WHERE Section.MaximumCapacity < (
										SELECT COUNT(*)
										FROM Planting
										INNER JOIN inserted ON inserted.SectionNo = Planting.SectionNo
									)

    -- Se o número de plantações exceder a capacidade máxima, lança um erro
    IF @ExceededCapacityCount > 0
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('Número de plantações excede a capacidade máxima da seção.', 16, 1);
    END;
END;
GO