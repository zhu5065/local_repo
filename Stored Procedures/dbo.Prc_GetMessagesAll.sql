SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetMessagesAll]
	@LoadTestRunId int
AS
SELECT 
AgentName,
ScenarioName,
TestCaseName,
RequestUri,
MessageId,
MessageTimeStamp,
MessageType,
SubType,
MessageText,
StackTrace,
HasWebTestErrorDetail
FROM LoadTestMessageView
WHERE
LoadTestRunId = @LoadTestRunId
ORDER BY AgentName, MessageType, SubType
GO
GRANT EXECUTE ON  [dbo].[Prc_GetMessagesAll] TO [public]
GO
