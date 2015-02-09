SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetMessagesByAgent]
	@LoadTestRunId int, @AgentName nvarchar(255)
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
LoadTestRunId = @LoadTestRunId AND
AgentName = @AgentName
ORDER BY AgentName, MessageId
GO
GRANT EXECUTE ON  [dbo].[Prc_GetMessagesByAgent] TO [public]
GO
