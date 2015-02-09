SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetErrorDetail]
	@LoadTestRunId int, @AgentName nvarchar(255), @MessageId int
AS
SELECT
WebTestRequestResult
FROM WebLoadTestErrorDetail as detail
LEFT OUTER JOIN LoadTestRunAgent AS agent
    ON detail.LoadTestRunId = agent.LoadTestRunId
    AND detail.AgentId = agent.AgentId
WHERE
detail.LoadTestRunId = @LoadTestRunId AND
AgentName = @AgentName AND
MessageId = @MessageId
GO
GRANT EXECUTE ON  [dbo].[Prc_GetErrorDetail] TO [public]
GO
