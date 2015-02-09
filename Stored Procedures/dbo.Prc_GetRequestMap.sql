SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Prc_GetRequestMap] @LoadTestRunId int
AS
SELECT 
RequestId,
TestCaseId,
RequestUri
FROM WebLoadTestRequestMap
WHERE LoadTestRunId = @LoadTestRunId
ORDER BY RequestId
GO
GRANT EXECUTE ON  [dbo].[Prc_GetRequestMap] TO [public]
GO
