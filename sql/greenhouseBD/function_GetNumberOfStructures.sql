-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Grupo 101
-- Create date: 01/06/2024
-- Description:	Retorna o número de estruturas na base de dados
-- =============================================
CREATE OR ALTER FUNCTION function_GetNumberOfStructures()
RETURNS INT 
AS
BEGIN
	DECLARE @NumOfStructures INT;

	SELECT @numOfStructures = COUNT(*)
	FROM Structure;
	
	RETURN @NumOfStructures;
END

