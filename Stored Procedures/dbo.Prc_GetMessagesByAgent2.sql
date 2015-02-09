SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetMessagesByAgent2]
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
HasWebTestErrorDetail,
TestLogId
FROM LoadTestMessageView2
WHERE
LoadTestRunId = @LoadTestRunId AND
AgentName = @AgentName
ORDER BY AgentName, MessageId
GO
GRANT EXECUTE ON  [dbo].[Prc_GetMessagesByAgent2] TO [public]
GO
