SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_QueryLoadTestScenarioSummary]
	@ReportId     INT,
	@CounterName  NVARCHAR(255)	
AS
SELECT LoadTestName,
       a.LoadTestRunId,
       CounterName,
       ScenarioName,
       CumulativeValue
FROM  LoadTestScenarioSummary a
JOIN  LoadTestReportRuns b
ON    a.LoadTestRunId = B.LoadTestRunId
WHERE b.ReportId = @ReportId
      AND CounterName = @CounterName      
ORDER BY a.LoadTestRunId
GO
GRANT EXECUTE ON  [dbo].[Prc_QueryLoadTestScenarioSummary] TO [public]
GO
