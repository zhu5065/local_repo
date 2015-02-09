SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetCategories] @LoadTestRunId int
AS
SELECT CounterCategoryId, CategoryName, MachineName, StartTimeStamp100nSec
FROM LoadTestPerformanceCounterCategory
WHERE LoadTestRunId = @LoadTestRunId
ORDER BY CounterCategoryId
GO
GRANT EXECUTE ON  [dbo].[Prc_GetCategories] TO [public]
GO
