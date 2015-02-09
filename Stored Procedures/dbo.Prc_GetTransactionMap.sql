SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


CREATE  PROCEDURE [dbo].[Prc_GetTransactionMap] @LoadTestRunId int
AS
SELECT 
TransactionId,
TestCaseId,
TransactionName
FROM WebLoadTestTransaction
WHERE LoadTestRunId = @LoadTestRunId
ORDER BY TransactionId
GO
GRANT EXECUTE ON  [dbo].[Prc_GetTransactionMap] TO [public]
GO
