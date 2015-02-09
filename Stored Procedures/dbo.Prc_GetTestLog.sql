SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetTestLog]
	@LoadTestRunId int, @AgentName nvarchar(255), @TestLogId int
AS
SELECT
testLog.TestLog,
testcase.TestElement
FROM LoadTestTestLog as testLog
LEFT OUTER JOIN LoadTestCase AS testcase
    ON testLog.LoadTestRunId = testcase.LoadTestRunId
    AND testLog.TestCaseId = testcase.TestCaseId
LEFT OUTER JOIN LoadTestRunAgent AS agent
    ON testLog.LoadTestRunId = agent.LoadTestRunId
    AND testLog.AgentId = agent.AgentId
WHERE
testLog.LoadTestRunId = @LoadTestRunId AND
AgentName = @AgentName AND
TestLogId = @TestLogId
GO
GRANT EXECUTE ON  [dbo].[Prc_GetTestLog] TO [public]
GO
