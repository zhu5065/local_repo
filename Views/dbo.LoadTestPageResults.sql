SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[LoadTestPageResults] AS 
SELECT
    pageSummary.LoadTestRunId, 
    scenario.ScenarioName,
    testCase.TestCaseName, 
    requestMap.RequestUri, 
    pageSummary.PageCount, 
    pageSummary.Minimum, 
    pageSummary.Average,
    pageSummary.Percentile90, 
    pageSummary.Percentile95, 
    pageSummary.Maximum
FROM LoadTestPageSummaryData AS pageSummary 
INNER JOIN WebLoadTestRequestMap AS requestMap 
    ON pageSummary.LoadTestRunId = requestMap.LoadTestRunId
    AND pageSummary.PageId = requestMap.requestId
INNER JOIN LoadTestCase as testCase
    ON requestMap.LoadTestRunId = testCase.LoadTestRunId
    AND requestMap.TestCaseId = testCase.TestCaseId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
GO
GRANT SELECT ON  [dbo].[LoadTestPageResults] TO [public]
GO
