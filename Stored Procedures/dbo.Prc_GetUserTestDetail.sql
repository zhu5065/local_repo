SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetUserTestDetail]
   @LoadTestRunId int,
   @StartTime     DATETIME,
   @EndTime       DATETIME,
   @FilterNoLog   BIT,
   @FilterSuccessfulResults BIT,
   @ItemsXml      NVARCHAR(MAX),
   @ErrorsXml     NVARCHAR(MAX)
AS

SET NOCOUNT ON

DECLARE @docHandle    INT

--parse the items
DECLARE @items TABLE (    
    Test           INT NOT NULL
)

--parse the errors
DECLARE @errors TABLE (
    ErrorId           INT NOT NULL    
)

-- Parse the XML input for items into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @ItemsXml

INSERT  @items        
SELECT  t
FROM OPENXML(@docHandle, N'/items/i', 0)
    WITH (                
        t INT
    )

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle

-- Parse the XML input for errors into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @ErrorsXml

INSERT  @errors        
SELECT  t
FROM OPENXML(@docHandle, N'/errors/i', 0)
    WITH (                
        t INT        
    )

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle


IF (@FilterSuccessfulResults=0)
BEGIN

--Select all tests active during that time span
SELECT    UserId,
          detail.TestDetailId,
          TestCaseName,
          TimeStamp as StartTime,
          EndTime,
          ScenarioName,
          Outcome,
          detail.AgentId,          
          s.ScenarioId,
          ElapsedTime,
          TestType,
          NetworkName,
          ISNULL(TestLogId,-1) AS TestLogId,
          agent.AgentName
FROM      LoadTestTestDetail detail
JOIN      LoadTestCase tc
ON        detail.LoadTestRunId = tc.LoadTestRunId
          AND detail.TestCaseId = tc.TestCaseId
JOIN      LoadTestScenario s
ON        tc.LoadTestRunId = s.LoadTestRunId
          AND tc.ScenarioId = s.ScenarioId
JOIN      @items i
ON        i.Test = tc.TestCaseId   
JOIN      LoadTestRunAgent AS agent
ON        detail.LoadTestRunId = agent.LoadTestRunId
          AND detail.AgentId = agent.AgentId 
JOIN      LoadTestDetailMessage dm
ON        detail.LoadTestRunId = dm.LoadTestRunId
          AND detail.TestDetailId = dm.TestDetailId
JOIN      LoadTestMessageType mt
ON        mt.LoadTestRunId = dm.LoadTestRunId
          AND  mt.MessageTypeId = dm.MessageTypeId
JOIN      @errors errors
ON        mt.MessageTypeId = errors.ErrorId      
LEFT JOIN LoadTestNetworks n
ON        detail.LoadTestRunId = n.LoadTestRunId
          AND detail.NetworkId = n.NetworkId
WHERE     detail.LoadTestRunId = @LoadTestRunId
          AND EndTime > @StartTime
          AND
          ( 
             (
               TimeStamp >=@StartTime 
               AND TimeStamp <@EndTime            
             )
             OR
             (
               TimeStamp < @StartTime                           
             )
          )
          AND 
          ( 
             (@FilterNoLog = 1 AND TestLogId IS NOT NULL)
             OR
             (@FilterNoLog = 0)
          )

UNION

-- Add the rows for successful outcomes
SELECT    UserId,
          detail.TestDetailId,
          TestCaseName,
          TimeStamp as StartTime,
          EndTime,
          ScenarioName,
          Outcome,
          detail.AgentId,          
          s.ScenarioId,
          ElapsedTime,
          TestType,
          NetworkName,
          ISNULL(TestLogId,-1) AS TestLogId,
          agent.AgentName
FROM      LoadTestTestDetail detail
JOIN      LoadTestCase tc
ON        detail.LoadTestRunId = tc.LoadTestRunId
          AND detail.TestCaseId = tc.TestCaseId
JOIN      LoadTestScenario s
ON        tc.LoadTestRunId = s.LoadTestRunId
          AND tc.ScenarioId = s.ScenarioId
JOIN      @items i
ON        i.Test = tc.TestCaseId   
JOIN      LoadTestRunAgent AS agent
ON        detail.LoadTestRunId = agent.LoadTestRunId
          AND detail.AgentId = agent.AgentId     
LEFT JOIN LoadTestNetworks n
ON        detail.LoadTestRunId = n.LoadTestRunId
          AND detail.NetworkId = n.NetworkId
WHERE     detail.LoadTestRunId = @LoadTestRunId
          AND EndTime > @StartTime
          AND
          ( 
             (
               TimeStamp >=@StartTime 
               AND TimeStamp <@EndTime            
             )
             OR
             (
               TimeStamp < @StartTime                           
             )
          )
          AND 
          ( 
             (@FilterNoLog = 1 AND TestLogId IS NOT NULL)
             OR
             (@FilterNoLog = 0)
          )
          AND
          (
              Outcome = 10
          )
ORDER BY  s.ScenarioId,AgentId,UserId,TestDetailId
END

ELSE

BEGIN
--Select all tests active during that time span
SELECT    UserId,
          detail.TestDetailId,
          TestCaseName,
          TimeStamp as StartTime,
          EndTime,
          ScenarioName,
          Outcome,
          detail.AgentId,          
          s.ScenarioId,
          ElapsedTime,
          TestType,
          NetworkName,
          ISNULL(TestLogId,-1) AS TestLogId,
          agent.AgentName
FROM      LoadTestTestDetail detail
JOIN      LoadTestCase tc
ON        detail.LoadTestRunId = tc.LoadTestRunId
          AND detail.TestCaseId = tc.TestCaseId
JOIN      LoadTestScenario s
ON        tc.LoadTestRunId = s.LoadTestRunId
          AND tc.ScenarioId = s.ScenarioId
JOIN      @items i
ON        i.Test = tc.TestCaseId   
JOIN      LoadTestRunAgent AS agent
ON        detail.LoadTestRunId = agent.LoadTestRunId
          AND detail.AgentId = agent.AgentId 
JOIN      LoadTestDetailMessage dm
ON        detail.LoadTestRunId = dm.LoadTestRunId
          AND detail.TestDetailId = dm.TestDetailId
JOIN      LoadTestMessageType mt
ON        mt.LoadTestRunId = dm.LoadTestRunId
          AND  mt.MessageTypeId = dm.MessageTypeId
JOIN      @errors errors
ON        mt.MessageTypeId = errors.ErrorId      
LEFT JOIN LoadTestNetworks n
ON        detail.LoadTestRunId = n.LoadTestRunId
          AND detail.NetworkId = n.NetworkId
WHERE     detail.LoadTestRunId = @LoadTestRunId
          AND EndTime > @StartTime
          AND
          ( 
             (
               TimeStamp >=@StartTime 
               AND TimeStamp <@EndTime            
             )
             OR
             (
               TimeStamp < @StartTime                           
             )
          )
          AND 
          ( 
             (@FilterNoLog = 1 AND TestLogId IS NOT NULL)
             OR
             (@FilterNoLog = 0)
          )
ORDER BY  s.ScenarioId,AgentId,UserId,TestDetailId
END
GO
GRANT EXECUTE ON  [dbo].[Prc_GetUserTestDetail] TO [public]
GO
