SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Grupo 101
-- Create date: 27/05/2024
-- Description: Impede a adição de plantações a uma estufa que não esteja operacional
-- =============================================
CREATE OR ALTER TRIGGER trigger_CheckOperationalGreenhouse 
   ON  dbo.Planting
   AFTER INSERT, UPDATE
AS 
BEGIN
    -- SET NOCOUNT ON adicionado para evitar conjuntos de resultados extras
    -- interferindo com instruções SELECT.
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN dbo.Section s ON i.SectionNo = s.SectionNo
        INNER JOIN dbo.Structure st ON s.StructureNo = st.StructureNo
        WHERE st.Operational = 0
    )
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('Não é possível adicionar plantações a uma estufa que não esteja operacional.', 16, 1);
    END
END;
GO

