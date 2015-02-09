SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_QueryLoadTestTransactionComparison]
    @Baseline      INT,
    @ComparisonRun INT
AS

SELECT run1.ScenarioName,
       run1.TestCaseName,  
       run1.TransactionName,     
       run1.CumulativeValue AS Baseline,
       run2.CumulativeValue AS ComparisonRun
FROM   LoadTestTransactionSummary run1
LEFT JOIN   (SELECT * 
             FROM LoadTestTransactionSummary 
             WHERE LoadTestRunId = @ComparisonRun) run2 
ON     run1.ScenarioName = run2.ScenarioName
       AND  run1.TestCaseName = run2.TestCaseName 
       AND  run1.TransactionName = run2.TransactionName 
       AND  run1.CounterName = run2.CounterName     
WHERE  run1.LoadTestRunId = @Baseline       
       AND run1.CounterName = 'Avg. Response Time'  
       AND run1.TransactionName != '_Total'      
       

GO
GRANT EXECUTE ON  [dbo].[Prc_QueryLoadTestTransactionComparison] TO [public]
GO
