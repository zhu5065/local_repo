SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[LoadTestTestCaseSample] AS
SELECT category.LoadTestRunId, counter.CounterName,
    scenario.ScenarioName, testcase.TestCaseName,  
    interval.IntervalStartTime, interval.IntervalEndTime,
    countersample.ComputedValue
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
INNER JOIN LoadTestCase As testcase
    ON testcase.LoadTestRunId = instance.LoadTestRunId
    AND testcase.TestCaseId = instance.LoadTestItemId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
WHERE category.CategoryName = 'LoadTest:Test' and countersample.ComputedValue IS NOT NULL
GO
GRANT SELECT ON  [dbo].[LoadTestTestCaseSample] TO [public]
GO
