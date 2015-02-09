SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[Prc_GetTestCases] @LoadTestRunId int
AS
SELECT 
testcase.TestCaseId, 
scenario.ScenarioName,
testcase.TestCaseName
FROM LoadTestCase AS testcase 
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
WHERE testcase.LoadTestRunId = @LoadTestRunId
ORDER BY testcase.TestCaseId
GO
GRANT EXECUTE ON  [dbo].[Prc_GetTestCases] TO [public]
GO
