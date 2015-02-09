SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_QueryLoadTestRunsById]    
    @runsXml            NVARCHAR(MAX)
AS
SET NOCOUNT ON

DECLARE @status       INT
DECLARE @docHandle    INT

DECLARE @runs TABLE (
    runId     INT NOT NULL    
)

-- Parse the XML input into a temporary table
-- Initialize the ProcedureName for error messages.
DECLARE @procedureName SYSNAME
SELECT  @procedureName = @@SERVERNAME + '.' + db_name() + '..' + object_name(@@PROCID)

EXEC sp_xml_preparedocument @docHandle OUTPUT, @runsXml

INSERT  @runs        
SELECT  i
FROM OPENXML(@docHandle, N'/runs/r', 0)
    WITH (        
        i INT
    )

SELECT  @status = @@ERROR

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle

IF (@status <> 0)
BEGIN
    RAISERROR (560500, 16, -1, @procedureName, @status, N'INSERT', N'@runs')
    ROLLBACK TRAN
    RETURN 560500    
END

-- Return Runs Info
SELECT LoadTestRunId, 
       ltr.RunId, 
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
FROM   LoadTestRun ltr
JOIN   @runs r
ON     ltr.LoadTestRunId = r.runId
WHERE  StartTime IS NOT NULL 
       AND EndTime IS NOT NULL 
ORDER BY StartTime DESC
GO
GRANT EXECUTE ON  [dbo].[prc_QueryLoadTestRunsById] TO [public]
GO
