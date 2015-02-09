SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetRequestMap2] @LoadTestRunId int
AS
SELECT 
RequestId,
TestCaseId,
RequestUri,
ResponseTimeGoal
FROM WebLoadTestRequestMap
WHERE LoadTestRunId = @LoadTestRunId
ORDER BY RequestId
GO
GRANT EXECUTE ON  [dbo].[Prc_GetRequestMap2] TO [public]
GO
