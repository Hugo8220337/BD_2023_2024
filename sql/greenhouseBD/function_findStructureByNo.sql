SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Grupo 101
-- Create date: 01/06/2024
-- Description:	Encontra uma estrutura pelo número de estrutura
-- =============================================
CREATE OR ALTER FUNCTION function_findStructureByNo
(	
	@StructureNo char(7)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT * FROM Structure WHERE StructureNo = @StructureNo
)
GO
