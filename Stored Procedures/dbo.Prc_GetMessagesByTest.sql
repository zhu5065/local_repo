SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[Prc_GetMessagesByTest]
	@LoadTestRunId int, @ScenarioName nvarchar(64), @TestCaseName nvarchar(64)
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
ScenarioName = @ScenarioName AND
TestCaseName = @TestCaseName
ORDER BY AgentName, ScenarioName, TestCaseName
GO
GRANT EXECUTE ON  [dbo].[Prc_GetMessagesByTest] TO [public]
GO
