SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[prc_QueryLoadTestRuns]    
    @loadTestName        NVARCHAR(255)
AS
SET NOCOUNT ON

-- Return Runs Info
SELECT LoadTestRunId, 
       RunId, 
       LoadTestName, 
       Description, 
       Comment, 
       IsLocalRun, 
       ControllerName, 
       StartTime, 
       EndTime, 
       WarmupTime, 
       RunDuration, 
       LoadTest, 
       Outcome,
       LoadTestSchemaRev
FROM   LoadTestRun 
WHERE LoadTestName = @loadTestName 
      AND StartTime IS NOT NULL 
      AND EndTime IS NOT NULL 
ORDER BY StartTime DESC
GO
GRANT EXECUTE ON  [dbo].[prc_QueryLoadTestRuns] TO [public]
GO
