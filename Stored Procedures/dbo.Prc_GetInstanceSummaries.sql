SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetInstanceSummaries] @LoadTestRunId int
AS
SELECT 
instance.InstanceId, 
category.MachineName, 
category.CategoryName, 
counter.CounterName, 
instance.InstanceName,
instance.CumulativeValue,
instance.OverallThresholdRuleResult
FROM LoadTestPerformanceCounterCategory AS category 
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
WHERE category.LoadTestRunId = @LoadTestRunId
ORDER BY category.MachineName, category.CategoryName, counter.CounterName, instance.InstanceName
GO
GRANT EXECUTE ON  [dbo].[Prc_GetInstanceSummaries] TO [public]
GO
