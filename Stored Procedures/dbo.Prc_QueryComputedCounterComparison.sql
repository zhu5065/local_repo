SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_QueryComputedCounterComparison]
    @ReportId      INT,
    @Baseline      INT,
    @ComparisonRun INT
AS


SELECT run.LoadTestRunId AS LoadTestRunId,
       run.MachineName AS MachineName,       
       run.CategoryName AS CategoryName,
       run.CounterName AS CounterName,
       run.HigherIsBetter AS HigherIsBetter,
       run.InstanceName AS InstanceName,
       run.CumulativeValue AS CumulativeValue              
FROM   LoadTestReportPage report
JOIN   LoadTestComputedCounterSummary run
ON     report.CategoryName = run.CategoryName
       AND report.CounterName = run.CounterName     
WHERE  report.ReportId = @ReportId
       AND run.LoadTestRunId in( @Baseline,@ComparisonRun)
       AND (run.CategoryName NOT LIKE 'LoadTest:%'
            OR (run.CategoryName LIKE 'LoadTest:%' AND run.InstanceName = '_Total'))
ORDER BY LoadTestRunId, MachineName, CategoryName, CounterName, InstanceName
GO
GRANT EXECUTE ON  [dbo].[Prc_QueryComputedCounterComparison] TO [public]
GO
