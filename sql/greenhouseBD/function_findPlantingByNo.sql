SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Grupo 101
-- Create date: 01/06/2024
-- Description:	Encontra uma planta��o pelo n�mero da planta��o
-- =============================================
CREATE OR ALTER FUNCTION function_findPlantingByNo
(	
	@plantingNo char(7)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT * FROM Planting WHERE PlantingNo = @plantingNo
)
