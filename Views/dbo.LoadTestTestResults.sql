SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


-- New views

CREATE VIEW [dbo].[LoadTestTestResults] AS 
SELECT
    testSummary.LoadTestRunId, 
    scenario.ScenarioName,
    testCase.TestCaseName,  
    testSummary.TestsRun, 
    testSummary.Minimum, 
    testSummary.Average,
    testSummary.Percentile90, 
    testSummary.Percentile95, 
    testSummary.Maximum
FROM LoadTestTestSummaryData AS testSummary 
INNER JOIN LoadTestCase as testCase
    ON testSummary.LoadTestRunId = testCase.LoadTestRunId
    AND testSummary.TestCaseId = testCase.TestCaseId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
GO
GRANT SELECT ON  [dbo].[LoadTestTestResults] TO [public]
GO
