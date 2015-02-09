SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetMessagesByType2]
	@LoadTestRunId int, @MessageType tinyint, @SubType nvarchar(64)
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
MessageType = @MessageType AND
SubType = @SubType
ORDER BY AgentName, MessageType, SubType
GO
GRANT EXECUTE ON  [dbo].[Prc_GetMessagesByType2] TO [public]
GO
