USE [Greenhouses_BD]
GO
/****** Object:  StoredProcedure [dbo].[sp_ChangeEmployeeStructure]    Script Date: 01/06/2024 12:45:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Grupo 101
-- Create date: 01/06/2024
-- Description:	Muda a estrutura onde um determinado funcionário trabalha
-- =============================================
ALTER PROCEDURE [dbo].[sp_ChangeEmployeeStructure]
	@empNo char(7),
	@newStructureToAssignEmp char(7)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ExistsEmployeeNo INT;
	DECLARE @ExistsStructureNo INT;
	
	-- verifica se o funcionário exite
	SELECT @ExistsEmployeeNo = COUNT(*)
	FROM function_findEmployeeByNo(@empNo)

	IF @ExistsEmployeeNo = 0 BEGIN
		RAISERROR('Funcionário com id %s nao existe.', 16, 1, @empNo);
        RETURN;
	END

	-- verifica se a estrutura existe
	SELECT @ExistsStructureNo = COUNT(*)
	FROM function_findStructureByNo(@empNo)

	IF @ExistsStructureNo = 0 BEGIN
		RAISERROR('Estrutura com id %s nao existe.', 16, 1, @newStructureToAssignEmp);
        RETURN;
	END

	-- remove o funcionário de todas as secções onde foi atribuído
    EXEC [dbo].[sp_UnassignEmployeesFromSections] @empNo = @empNo;

	-- atualiza a estrutura onde o funcionário trabalha
	UPDATE Employee
	SET StructureNo = @newStructureToAssignEmp
	WHERE EmployeeNo = @empNo
END
