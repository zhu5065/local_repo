SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[LoadTestTransactionSummary] AS
SELECT run.LoadTestName, 
       category.LoadTestRunId, 
       counter.CounterName,
       ISNULL(scenario.ScenarioName,'_Total') as ScenarioName,
       ISNULL(testcase.TestCaseName,'_Total') as TestCaseName, 
       ISNULL(transactions.TransactionName,'_Total') as TransactionName,       
       instance.CumulativeValue
FROM  LoadTestRun as run
INNER JOIN LoadTestPerformanceCounterCategory AS category 
    ON run.LoadTestRunId = category.LoadTestRunId
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
LEFT JOIN WebLoadTestTransaction AS transactions
    ON transactions.LoadTestRunId = instance.LoadTestRunId
    AND transactions.TransactionId = instance.LoadTestItemId
LEFT JOIN LoadTestCase As testcase
    ON transactions.LoadTestRunId = testcase.LoadTestRunId
    AND transactions.TestCaseId = testcase.TestCaseId
LEFT JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
WHERE category.CategoryName = 'LoadTest:Transaction' and instance.CumulativeValue IS NOT NULL
GO
GRANT SELECT ON  [dbo].[LoadTestTransactionSummary] TO [public]
GO
