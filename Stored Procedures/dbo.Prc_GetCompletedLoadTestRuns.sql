SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetCompletedLoadTestRuns]
AS
SELECT LoadTestRunId, 
	RunId,
	LoadTestName,
	Description,
	StartTime,
	EndTime,
	IsLocalRun,
	ControllerName
FROM LoadTestRun
WHERE 
LoadTestName IS NOT NULL AND 
StartTime IS NOT NULL AND
EndTime IS NOT NULL
ORDER BY LoadTestRunId

GRANT EXECUTE ON Prc_GetCompletedLoadTestRuns TO PUBLIC
GO
