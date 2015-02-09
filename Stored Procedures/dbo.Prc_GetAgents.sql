SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetAgents] @LoadTestRunId int
AS
SELECT AgentId, AgentName 
FROM LoadTestRunAgent
WHERE LoadTestRunId = @LoadTestRunId
ORDER BY AgentId
GO
GRANT EXECUTE ON  [dbo].[Prc_GetAgents] TO [public]
GO
