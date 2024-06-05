SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Grupo 101
-- Create date: 27/05/2024
-- Description: Impede a adi��o de planta��es a uma estufa que n�o esteja operacional
-- =============================================
CREATE OR ALTER TRIGGER trigger_CheckOperationalGreenhouse 
   ON  dbo.Planting
   AFTER INSERT, UPDATE
AS 
BEGIN
    -- SET NOCOUNT ON adicionado para evitar conjuntos de resultados extras
    -- interferindo com instru��es SELECT.
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
        RAISERROR('N�o � poss�vel adicionar planta��es a uma estufa que n�o esteja operacional.', 16, 1);
    END
END;
GO

