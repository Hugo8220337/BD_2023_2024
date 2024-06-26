USE [Greenhouses_BD]
GO
/****** Object:  StoredProcedure [dbo].[sp_Replant]    Script Date: 01/06/2024 12:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Grupo 101
-- Create date: 01/06/2024
-- Description:	Replantar utilizando as mesmas scaracterísticas de uma determinada plantação
-- =============================================
ALTER   PROCEDURE [dbo].[sp_Replant]
	@plantingNo char(7),
	@newPlantingNo char(7),
	@numberOfSeeds numeric(5, 0),
	@replantingDate date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Verificar se a plantação existe
    DECLARE @ExistsPlanting INT;
    SELECT @ExistsPlanting = COUNT(*)
    FROM function_findPlantingByNo(@plantingNo)

    IF @ExistsPlanting = 0
    BEGIN
        -- Plantacao não existe
        RAISERROR('Plantacao com id %s nao encontrada.', 16, 1, @plantingNo);
        RETURN;
    END
    ELSE
    BEGIN
        -- Obter informacoes da plantacao
		DECLARE @structureNo char(7);
		DECLARE @sectionNo char(7);
		DECLARE @productNo char(7);
		DECLARE @type nvarchar(50);
		DECLARE @plantingEndDate date;

        SELECT @structureNo = StructureNo, @sectionNo = SectionNo, @productNo = ProductNo, @type = Type, @plantingEndDate = EndData
        FROM function_findPlantingByNo(@plantingNo)

        -- Verificar se a plantacao foi colhida

        IF @plantingEndDate IS NULL
        BEGIN
            -- Plantacao nao foi colhida
            RAISERROR('Plantacao não terminou, logo não pode ser replantada.', 16, 1);
            RETURN;
        END
        ELSE
        BEGIN
            -- Registrar nova plantacao
            INSERT INTO Planting(PlantingNo, StructureNo, SectionNo, ProductNo, Type, Quantity, PlantingDate)
            VALUES (@newPlantingNo, @structureNo, @sectionNo, @productNo, @type, @numberOfSeeds, @replantingDate);

            RETURN;
        END
    END
END
