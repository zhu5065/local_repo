SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_QueryLoadTestTransactionSummary]
	@ReportId     INT,
	@CounterName  NVARCHAR(255)	
AS
SELECT LoadTestName,
       a.LoadTestRunId as LoadTestRunId,
       CounterName,
       ScenarioName,
       TestCaseName,
       TransactionName,
       Cumulativevalue
FROM  LoadTestTransactionSummary a
JOIN  LoadTestReportRuns b
ON    a.LoadTestRunId = B.LoadTestRunId
WHERE b.ReportId = @ReportId
      AND CounterName = @CounterName      
ORDER BY a.LoadTestRunId
GO
GRANT EXECUTE ON  [dbo].[Prc_QueryLoadTestTransactionSummary] TO [public]
GO
