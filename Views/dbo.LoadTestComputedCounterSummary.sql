SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[LoadTestComputedCounterSummary] AS
SELECT run.LoadTestName, category.LoadTestRunId, category.MachineName, category.CategoryName, counter.CounterName, 
    counter.HigherIsBetter,instance.InstanceName, instance.CumulativeValue, instance.OverallThresholdRuleResult
FROM LoadTestRun as run
INNER JOIN LoadTestPerformanceCounterCategory AS category 
    ON run.LoadTestRunId = category.LoadTestRunId
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
WHERE instance.cumulativeValue IS NOT NULL
GO
GRANT SELECT ON  [dbo].[LoadTestComputedCounterSummary] TO [public]
GO
