SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[prc_QueryPossibleCountersForReport]    
    @runsxml        NVARCHAR(MAX)
AS
SET NOCOUNT ON

DECLARE @docHandle    INT
DECLARE @runs TABLE (
    runId     INT NOT NULL    
)

-- Parse the XML input into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @runsxml

INSERT  @runs        
SELECT  i
FROM OPENXML(@docHandle, N'/runs/r', 0)
    WITH (        
        i INT
    )

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle

-- Return Runs Info
SELECT DISTINCT CategoryName, 
       CounterName
FROM   @runs r
JOIN   LoadTestComputedCounterSummary cat
ON     r.runId = cat.LoadTestRunId
ORDER BY CategoryName,CounterName
GO
GRANT EXECUTE ON  [dbo].[prc_QueryPossibleCountersForReport] TO [public]
GO
