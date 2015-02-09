SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[LoadTestScenarioSummary] AS
SELECT run.LoadTestName AS LoadTestName, 
       category.LoadTestRunId AS LoadTestRunId, 
       counter.CounterName AS CounterName,
       CASE instance.InstanceName WHEN '_Total' THEN '_Total' ELSE scenario.ScenarioName END AS ScenarioName,         
       instance.CumulativeValue AS CumulativeValue
FROM       LoadTestRun AS run
INNER JOIN LoadTestScenario As scenario
    ON run.LoadTestRunId = scenario.LoadTestRunId    
INNER JOIN LoadTestPerformanceCounterCategory AS category 
    ON scenario.LoadTestRunId = category.LoadTestRunId
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
    AND (instance.InstanceName = scenario.ScenarioName OR instance.InstanceName = '_Total')
WHERE category.CategoryName = 'LoadTest:Scenario' 
      AND instance.CumulativeValue IS NOT NULL
GROUP BY LoadTestName, category.LoadTestRunId, CounterName,CASE instance.InstanceName WHEN '_Total' THEN '_Total' ELSE scenario.ScenarioName END,CumulativeValue
      
GO
GRANT SELECT ON  [dbo].[LoadTestScenarioSummary] TO [public]
GO
