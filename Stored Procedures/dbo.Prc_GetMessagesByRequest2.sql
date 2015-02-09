SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetMessagesByRequest2]
	@LoadTestRunId int, @RequestId int
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
RequestId = @RequestId
ORDER BY AgentName, MessageId
GO
GRANT EXECUTE ON  [dbo].[Prc_GetMessagesByRequest2] TO [public]
GO
