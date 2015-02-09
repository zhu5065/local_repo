SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_QueryForInstanceCount]   
    @categoryName  NVARCHAR(255),
    @counterName   NVARCHAR(255),  
    @runsxml       NVARCHAR(MAX)
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
SELECT TOP 1 run.runId, count(*) as InstanceCount
FROM @runs as run
INNER JOIN LoadTestPerformanceCounterCategory AS category 
    ON run.runId = category.LoadTestRunId
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
WHERE instance.cumulativeValue IS NOT NULL
AND  counter.CounterName = @counterName
AND  category.CategoryName = @categoryName
GROUP BY run.runId
ORDER BY InstanceCount DESC

GRANT EXECUTE ON prc_QueryForInstanceCount TO PUBLIC
GO
