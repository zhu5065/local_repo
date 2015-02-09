SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE  VIEW [dbo].[LoadTestWebRequestCounterSummary] AS
SELECT category.LoadTestRunId, counter.CounterName,
    scenario.ScenarioName, testcase.TestCaseName, request.RequestUri, 
    instance.CumulativeValue
FROM LoadTestPerformanceCounterCategory AS category 
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
INNER JOIN WebLoadTestRequestMap AS request
    ON request.LoadTestRunId = instance.LoadTestRunId
    AND request.RequestId = instance.LoadTestItemId
INNER JOIN LoadTestCase As testcase
    ON request.LoadTestRunId = testcase.LoadTestRunId
    AND request.TestCaseId = testcase.TestCaseId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
WHERE category.CategoryName = 'LoadTest:Request' and instance.CumulativeValue IS NOT NULL
GO
GRANT SELECT ON  [dbo].[LoadTestWebRequestCounterSummary] TO [public]
GO
