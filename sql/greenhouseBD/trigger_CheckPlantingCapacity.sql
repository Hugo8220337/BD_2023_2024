SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Grupo 101
-- Create date: 27/05/2024
-- Description: Impede que o n�mero de planta��es exceda a capacidade m�xima de uma sec��o
-- =============================================
CREATE OR ALTER TRIGGER trigger_CheckPlantingCapacity 
   ON dbo.Planting
   AFTER INSERT, UPDATE
AS 
BEGIN
    -- SET NOCOUNT ON adicionado para evitar conjuntos de resultados extras
    -- interferindo com instru��es SELECT.
    SET NOCOUNT ON;

    DECLARE @ExceededCapacityCount INT;

    -- Verifica se o n�mero de planta��es em qualquer se��o excede a capacidade m�xima
	SELECT @ExceededCapacityCount = COUNT(*)
	FROM inserted
	INNER JOIN Section ON inserted.SectionNo = Section.SectionNo
	WHERE Section.MaximumCapacity < (
										SELECT COUNT(*)
										FROM Planting
										INNER JOIN inserted ON inserted.SectionNo = Planting.SectionNo
									)

    -- Se o n�mero de planta��es exceder a capacidade m�xima, lan�a um erro
    IF @ExceededCapacityCount > 0
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('N�mero de planta��es excede a capacidade m�xima da se��o.', 16, 1);
    END;
END;
GO