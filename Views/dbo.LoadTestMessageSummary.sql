SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[LoadTestMessageSummary] AS
SELECT 
message.LoadTestRunId,
agent.AgentName,
scenario.ScenarioName,
testcase.TestCaseName,
requestmap.RequestUri,
message.MessageId,
message.MessageTimeStamp,
MessageType = 
    CASE message.MessageType
        WHEN 0 THEN 'TestError'
        WHEN 1 THEN 'Exception'
        WHEN 2 THEN 'HttpError'
        WHEN 3 THEN 'ValidationRuleError'
        WHEN 4 THEN 'ExtractionRuleError'
        WHEN 5 THEN 'Timeout'
        WHEN 6 THEN 'DataCollectionError'
        WHEN 7 THEN 'DataCollectionWarning'
        ELSE 'Unknown'
    END,
message.SubType,
message.MessageText,
message.StackTrace,
message.RequestId,
HasWebTestErrorDetail = 
    CASE ISNULL(detail.MessageId,-1)
      WHEN -1 THEN 'false'
      ELSE 'true'
    END
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
GO
GRANT SELECT ON  [dbo].[LoadTestMessageSummary] TO [public]
GO
