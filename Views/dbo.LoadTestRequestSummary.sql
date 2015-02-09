SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[LoadTestRequestSummary] AS
SELECT run.LoadTestName, 
       category.LoadTestRunId, 
       counter.CounterName,
       ISNULL(scenario.ScenarioName,'_Total') as ScenarioName,
       ISNULL(testcase.TestCaseName,'_Total') as TestCaseName, 
       ISNULL(request.RequestUri,'_Total') as RequestUri, 
    instance.CumulativeValue
FROM       LoadTestRun AS run
INNER JOIN LoadTestPerformanceCounterCategory AS category 
    ON run.LoadTestRunId = category.LoadTestRunId
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
LEFT JOIN WebLoadTestRequestMap AS request
    ON request.LoadTestRunId = instance.LoadTestRunId
    AND request.RequestId = instance.LoadTestItemId
LEFT JOIN LoadTestCase As testcase
    ON request.LoadTestRunId = testcase.LoadTestRunId
    AND request.TestCaseId = testcase.TestCaseId
LEFT JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
WHERE category.CategoryName = 'LoadTest:Request' and instance.CumulativeValue IS NOT NULL

GO
GRANT SELECT ON  [dbo].[LoadTestRequestSummary] TO [public]
GO
