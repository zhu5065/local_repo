SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_QueryForMachinesInRun]    
    @Baseline      INT,
    @ComparisonRun INT
AS
SET NOCOUNT ON


SELECT LoadTestRunId   AS LoadTestRunId,
       ControllerName  AS Machine,
       'Controller'    AS MachineRole
FROM   LoadTestRun
WHERE  LoadTestRunId in (@Baseline,@ComparisonRun)
UNION  
SELECT LoadTestRunId   AS LoadTestRunId,
       AgentName       AS Machine,
       'Agent'         AS MachineRole
FROM   LoadTestRunAgent       
WHERE  LoadTestRunId in (@Baseline,@ComparisonRun)
UNION  
SELECT SUT.LoadTestRunId AS LoadTestRunId,
       MachineName       AS Machine,
       MachineTag        AS MachineRole
FROM   LoadTestSystemUnderTest AS SUT
LEFT JOIN   LoadTestSystemUnderTestTag AS Tags
ON     SUT.LoadTestRunId = Tags.LoadTestRunId
       AND SUT.SystemUnderTestId = Tags.SystemUnderTestId 
WHERE  SUT.LoadTestRunId in (@Baseline,@ComparisonRun)
UNION  
SELECT DISTINCT LoadTestRunId   AS LoadTestRunId,
       MachineName              AS Machine,
       NULL                     AS MachineRole
FROM   LoadTestPerformanceCounterCategory    
WHERE  LoadTestRunId in (@Baseline,@ComparisonRun) 
ORDER BY LoadTestRunId, Machine,MachineRole
GO
GRANT EXECUTE ON  [dbo].[prc_QueryForMachinesInRun] TO [public]
GO
