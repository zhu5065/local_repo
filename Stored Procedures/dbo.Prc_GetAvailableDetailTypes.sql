SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetAvailableDetailTypes]
    @LoadTestRunId INT	
AS

SET NOCOUNT ON

DECLARE @TestDetailExists  BIT
DECLARE @PageDetailExists  BIT
DECLARE @TransactionDetailExists  BIT

SET @TestDetailExists = 0
SET @PageDetailExists = 0
SET @TransactionDetailExists = 0

IF EXISTS 
(
    SELECT TOP 1 LoadTestRunId
    FROM   LoadTestPageDetail
    WHERE  LoadTestRunId = @LoadTestRunId
)
BEGIN
    SET @PageDetailExists = 1
END

IF EXISTS 
(
    SELECT TOP 1 LoadTestRunId
    FROM   LoadTestTransactionDetail
    WHERE  LoadTestRunId = @LoadTestRunId
)
BEGIN
    SET @TransactionDetailExists = 1
END

IF EXISTS 
(
    SELECT TOP 1 LoadTestRunId
    FROM   LoadTestTestDetail
    WHERE  LoadTestRunId = @LoadTestRunId
)
BEGIN
    SET @TestDetailExists = 1
END

SELECT @TestDetailExists AS TestDetailsExists,
       @PageDetailExists AS PageDetailExists, 
       @TransactionDetailExists AS TransactionDetailExists
GO
GRANT EXECUTE ON  [dbo].[Prc_GetAvailableDetailTypes] TO [public]
GO
