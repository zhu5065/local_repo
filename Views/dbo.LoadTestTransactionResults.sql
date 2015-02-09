SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[LoadTestTransactionResults] AS 
SELECT
    transactionSummary.LoadTestRunId, 
    scenario.ScenarioName,
    testCase.TestCaseName, 
    transactions.TransactionName,
    transactionSummary.TransactionCount, 
    transactionSummary.Minimum, 
    transactionSummary.Average,
    transactionSummary.Percentile90, 
    transactionSummary.Percentile95, 
    transactionSummary.Maximum
FROM LoadTestTransactionSummaryData AS transactionSummary 
INNER JOIN WebLoadTestTransaction AS transactions 
    ON transactionSummary.LoadTestRunId = transactions.LoadTestRunId
    AND transactionSummary.TransactionId = transactions.TransactionId
INNER JOIN LoadTestCase as testCase
    ON transactions.LoadTestRunId = testCase.LoadTestRunId
    AND transactions.TestCaseId = testCase.TestCaseId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
GO
GRANT SELECT ON  [dbo].[LoadTestTransactionResults] TO [public]
GO
