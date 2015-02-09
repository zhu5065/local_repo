SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


-- Create views

CREATE VIEW [dbo].[LoadTestComputedCounterSample] AS
SELECT category.LoadTestRunId, category.MachineName, category.CategoryName, counter.CounterName, 
    instance.InstanceName, interval.IntervalStartTime, interval.IntervalEndTime, 
    countersample.CounterType, countersample.ComputedValue, countersample.RawValue, countersample.ThresholdRuleResult
FROM LoadTestPerformanceCounterCategory AS category 
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
INNER JOIN LoadTestPerformanceCounterSample AS countersample 
    ON countersample.InstanceId = instance.InstanceId
    AND countersample.LoadTestRunId = instance.LoadTestRunId
INNER JOIN LoadTestRunInterval AS interval 
    ON interval.LoadTestRunId = countersample.LoadTestRunId
    AND interval.TestRunIntervalId = countersample.TestRunIntervalId
WHERE countersample.ComputedValue IS NOT NULL
GO
GRANT SELECT ON  [dbo].[LoadTestComputedCounterSample] TO [public]
GO
