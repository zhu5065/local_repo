SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_QueryLoadTestPageSummary]
	@ReportId     INT,
	@CounterName  NVARCHAR(255)	
AS
SELECT LoadTestName,
       a.LoadTestRunId as LoadTestRunId,
       CounterName,
       ScenarioName,
       TestCaseName, 
       RequestUri,      
       Cumulativevalue
FROM  LoadTestPageSummary a
JOIN  LoadTestReportRuns b
ON    a.LoadTestRunId = B.LoadTestRunId
WHERE b.ReportId = @ReportId
      AND CounterName = @CounterName      
ORDER BY a.LoadTestRunId
GO
GRANT EXECUTE ON  [dbo].[Prc_QueryLoadTestPageSummary] TO [public]
GO
