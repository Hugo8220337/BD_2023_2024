USE [Greenhouses_BD]
GO
/****** Object:  UserDefinedFunction [dbo].[function_findEmployeeByNo]    Script Date: 01/06/2024 12:35:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Grupo 101
-- Create date: 01/06/2024
-- Description:	Encontra um funcionário pelo número de funcionário
-- =============================================
ALTER FUNCTION [dbo].[function_findEmployeeByNo]
(	
	@empNo char(7)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT * FROM Employee WHERE EmployeeNo = @empNo
)
