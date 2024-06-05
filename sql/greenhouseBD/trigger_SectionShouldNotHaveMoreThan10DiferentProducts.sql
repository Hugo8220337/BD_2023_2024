SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Grupo  101
-- Create date: 27/05/2024
-- Description:	Verifica se existem com a inser��o ou altera��o v�o haver mais que 10 produtos
--				diferentes numa planta��o, se sim, salta fora
-- =============================================
CREATE OR ALTER TRIGGER trigger_SectionShouldNotHaveMoreThan10DiferentProducts
   ON  Planting
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @numOfDiferentProducts INT;

	SELECT @numOfDiferentProducts = COUNT(DISTINCT Planting.ProductNo)
	FROM inserted
	INNER JOIN Section ON Section.SectionNo = inserted.SectionNo
	INNER JOIN Planting ON Planting.SectionNo = inserted.SectionNo

	IF @numOfDiferentProducts > 10 BEGIN
		ROLLBACK;
		RAISERROR('N�o pode hvaer mais que 10 produtos diferentes numa sec��o!', 16, 1);
	END

END
GO
