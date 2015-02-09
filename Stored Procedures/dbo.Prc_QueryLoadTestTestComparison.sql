SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_QueryLoadTestTestComparison]
    @Baseline      INT,
    @ComparisonRun INT
AS

SELECT run1.ScenarioName,
       run1.TestCaseName,       
       run1.CumulativeValue AS Baseline,
       run2.CumulativeValue AS ComparisonRun
FROM   LoadTestTestCaseSummary run1
LEFT JOIN   (SELECT * 
             FROM LoadTestTestCaseSummary 
             WHERE LoadTestRunId = @ComparisonRun) run2
ON     run1.ScenarioName = run2.ScenarioName
       AND  run1.TestCaseName = run2.TestCaseName  
       AND  run1.CounterName = run2.CounterName     
WHERE  run1.LoadTestRunId = @Baseline       
       AND run1.CounterName = 'Avg. Test Time'   
       AND run1.TestCaseName != '_Total'   
       
GO
GRANT EXECUTE ON  [dbo].[Prc_QueryLoadTestTestComparison] TO [public]
GO
