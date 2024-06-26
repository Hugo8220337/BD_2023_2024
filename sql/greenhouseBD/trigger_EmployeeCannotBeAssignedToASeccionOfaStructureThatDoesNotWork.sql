USE [Greenhouses_BD]
GO
/****** Object:  Trigger [dbo].[trigger_EmployeeCannotBeAssignedToASeccionOfaStructureThatDoesNotWork]    Script Date: 01/06/2024 10:01:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Grupo 101
-- Create date: 27/05/2024
-- Description:	Verifica se a secção onde o funcionário está a ser atribuído pertence à estufa onde trabalha
--				Caso não seja, então dá erro
-- =============================================
ALTER   TRIGGER [dbo].[trigger_EmployeeCannotBeAssignedToASeccionOfaStructureThatDoesNotWork]
   ON [dbo].[Employee/Section]
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @count int;

	SELECT @count = COUNT(*)
	FROM inserted
	INNER JOIN Employee ON inserted.EmployeeNo = Employee.EmployeeNo
	WHERE inserted.StructureNo <> Employee.StructureNo
	

	IF (@count > 0) BEGIN
		ROLLBACK;
		RAISERROR('Não se pode atribuir um funcionário a uma secção de uma estufa onde não tabalha!', 16, 1);
	END

END
