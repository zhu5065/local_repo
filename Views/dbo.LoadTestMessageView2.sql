SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[LoadTestMessageView2] AS
SELECT 
message.LoadTestRunId,
agent.AgentName,
scenario.ScenarioName,
testcase.TestCaseName,
requestmap.RequestUri,
message.MessageId,
message.MessageTimeStamp,
message.MessageType,
message.SubType,
message.MessageText,
message.StackTrace,
message.RequestId,
HasWebTestErrorDetail = 
    CASE ISNULL(detail.MessageId,-1)
	WHEN -1 THEN 'false'
	ELSE 'true'
    END,
testLog.TestLogId
FROM LoadTestMessage as message
LEFT OUTER JOIN LoadTestCase AS testcase
    ON message.LoadTestRunId = testcase.LoadTestRunId
    AND message.TestCaseId = testcase.TestCaseId
LEFT OUTER JOIN LoadTestScenario AS scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
LEFT OUTER JOIN LoadTestRunAgent AS agent
    ON message.LoadTestRunId = agent.LoadTestRunId
    AND message.AgentId = agent.AgentId
LEFT OUTER JOIN WebLoadTestRequestMap AS requestmap
    ON message.LoadTestRunId = requestmap.LoadTestRunId
    AND message.RequestId = requestmap.RequestId        
LEFT OUTER JOIN WebLoadTestErrorDetail AS detail
    ON message.LoadTestRunId = detail.LoadTestRunId
    AND message.MessageId = detail.MessageId
    AND message.AgentId = detail.AgentId        
LEFT OUTER JOIN LoadTestTestLog AS testLog
    ON message.LoadTestRunId = testLog.LoadTestRunId
    AND message.AgentId = testLog.AgentId     
    AND message.TestLogId = testLog.TestLogId

GO
GRANT SELECT ON  [dbo].[LoadTestMessageView2] TO [public]
GO
