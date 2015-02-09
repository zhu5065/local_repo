SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_QueryLoadTestPageComparison]
    @Baseline      INT,
    @ComparisonRun INT
AS

SELECT run1.ScenarioName,
       run1.TestCaseName,
       run1.RequestUri,
       run1.CumulativeValue AS Baseline,
       run2.CumulativeValue AS ComparisonRun,
       run2.ResponseTimeGoal
FROM   LoadTestPageSummary run1
LEFT JOIN   (SELECT * 
             FROM LoadTestPageSummary 
             WHERE LoadTestRunId =@ComparisonRun )run2     
ON     run1.ScenarioName = run2.ScenarioName
       AND  run1.TestCaseName = run2.TestCaseName
       AND  run1.RequestUri = run2.RequestUri
       AND  run1.CounterName = run2.CounterName 
WHERE  run1.LoadTestRunId = @Baseline       
       AND run1.CounterName = 'Avg. Page Time'   
       AND run1.TestCaseName != '_Total'      
GO
GRANT EXECUTE ON  [dbo].[Prc_QueryLoadTestPageComparison] TO [public]
GO
