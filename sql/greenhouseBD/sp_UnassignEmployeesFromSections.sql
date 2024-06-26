USE [Greenhouses_BD]
GO
/****** Object:  StoredProcedure [dbo].[sp_UnassignEmployeesFromSections]    Script Date: 01/06/2024 12:44:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Grupo 101
-- Create date: 01/06/2024
-- Description:	Vai remover o funcionário de todas as secções onde ele foi atribuído
-- =============================================
ALTER PROCEDURE [dbo].[sp_UnassignEmployeesFromSections] 
	@empNo char(7)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ExistEmployee int;
	SELECT @ExistEmployee = COUNT(*)
	FROM function_findEmployeeByNo(@empNo)

	IF @ExistEmployee = 0 BEGIN
		-- Plantacao nao foi colhida
        RAISERROR('Funcinoário com o número %s não existe.', 16, 1, @empNo);
        RETURN;
	END ELSE
	BEGIN
		DELETE FROM [Employee/Section]
		WHERE EmployeeNo = @empNo
	END

END
