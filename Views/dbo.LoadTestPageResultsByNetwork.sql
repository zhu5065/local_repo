SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[LoadTestPageResultsByNetwork] AS 
SELECT
    pageSummary.LoadTestRunId,
    scenario.ScenarioName,
    testCase.TestCaseName, 
    requestMap.RequestUri,
    networks.NetworkName,
    pageSummary.PageCount,
    pageSummary.Minimum,
    pageSummary.Average,
    pageSummary.Percentile90,
    pageSummary.Percentile95,
    pageSummary.Maximum,
    pageSummary.Goal,
    pageSummary.PagesMeetingGoal
FROM LoadTestPageSummaryByNetwork AS pageSummary
INNER JOIN WebLoadTestRequestMap AS requestMap 
    ON pageSummary.LoadTestRunId = requestMap.LoadTestRunId
    AND pageSummary.PageId = requestMap.requestId
INNER JOIN LoadTestCase as testCase
    ON requestMap.LoadTestRunId = testCase.LoadTestRunId
    AND requestMap.TestCaseId = testCase.TestCaseId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
INNER JOIN LoadTestNetworks as networks
    ON pageSummary.LoadTestRunId = networks.LoadTestRunId
    AND pageSummary.NetworkId = networks.NetworkId
GO
GRANT SELECT ON  [dbo].[LoadTestPageResultsByNetwork] TO [public]
GO
