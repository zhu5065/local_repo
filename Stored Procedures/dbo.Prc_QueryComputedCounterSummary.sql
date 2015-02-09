SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_QueryComputedCounterSummary]
	@ReportId     INT,
	@CounterName  NVARCHAR(255),
    @CategoryName  NVARCHAR(255)	
AS
SELECT LoadTestName,
       a.LoadTestRunId as LoadTestRunId,
       MachineName,
       CategoryName,
       CounterName,       
       InstanceName,             
       CumulativeValue
FROM  LoadTestComputedCounterSummary a
JOIN  LoadTestReportRuns b
ON    a.LoadTestRunId = B.LoadTestRunId
WHERE b.ReportId = @ReportId
      AND CategoryName = @CategoryName
      AND CounterName = @CounterName      
ORDER BY a.LoadTestRunId
GO
GRANT EXECUTE ON  [dbo].[Prc_QueryComputedCounterSummary] TO [public]
GO
