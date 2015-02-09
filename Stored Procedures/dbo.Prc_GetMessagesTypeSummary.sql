SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetMessagesTypeSummary]
	@LoadTestRunId int
AS
SELECT DISTINCT MessageType, SubType, COUNT(*) as Count
FROM LoadTestMessage
WHERE LoadTestRunId = @LoadTestRunId
GROUP BY MessageType, SubType
ORDER BY Count DESC

GO
GRANT EXECUTE ON  [dbo].[Prc_GetMessagesTypeSummary] TO [public]
GO
