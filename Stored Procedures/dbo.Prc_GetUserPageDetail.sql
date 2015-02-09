SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

       
CREATE PROCEDURE [dbo].[Prc_GetUserPageDetail]
    @LoadTestRunId INT,
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
    Test           INT NOT NULL,
    Page           INT NOT NULL
)

--parse the errors
DECLARE @errors TABLE (
    ErrorId           INT NOT NULL    
)


-- Parse the XML input for items into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @ItemsXml

INSERT  @items        
SELECT  t,p
FROM OPENXML(@docHandle, N'/items/i', 0)
    WITH (                
        t INT,
        p INT
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


IF(@FilterSuccessfulResults=0)
BEGIN

--Select all pages active during that time span
SELECT    UserId,
          p.PageDetailId,
          TestCaseName,
          p.TimeStamp as StartTime,
          p.EndTime,
          ScenarioName,
          p.Outcome,
          detail.AgentId,
          s.ScenarioId,
          ResponseTime,
          TestType,
          NetworkName,
          ISNULL(TestLogId,-1),
          PageId,
          RequestUri,
          BrowserName,
          agent.AgentName
FROM      LoadTestPageDetail p     
JOIN      LoadTestTestDetail detail
ON        p.LoadTestRunId = detail.LoadTestRunId
          AND p.TestDetailId= detail.TestDetailId
JOIN      LoadTestCase tc
ON        detail.LoadTestRunId = tc.LoadTestRunId
          AND detail.TestCaseId = tc.TestCaseId
JOIN      LoadTestScenario s
ON        tc.LoadTestRunId = s.LoadTestRunId
          AND tc.ScenarioId = s.ScenarioId
JOIN      LoadTestRunAgent AS agent
ON        detail.LoadTestRunId = agent.LoadTestRunId
          AND detail.AgentId = agent.AgentId              
JOIN      WebLoadTestRequestMap map
ON        p.loadtestrunid = map.loadtestrunid
          AND p.PageId = map.RequestId
JOIN      @items i
ON        i.Test = tc.TestCaseId          
          AND i.Page = map.RequestId
JOIN      LoadTestDetailMessage dm
ON        p.LoadTestRunId = dm.LoadTestRunId
          AND p.TestDetailId = dm.TestDetailId
          AND p.PageDetailId = dm.PageDetailId
JOIN      @errors errors
ON        dm.MessageTypeId = errors.ErrorId     
LEFT JOIN LoadTestNetworks n
ON        detail.LoadTestRunId = n.LoadTestRunId
          AND detail.NetworkId = n.NetworkId
LEFT JOIN LoadTestBrowsers b
ON        detail.LoadTestRunId = b.LoadTestRunId
          AND detail.BrowserId = b.BrowserId 
WHERE     detail.LoadTestRunId = @LoadTestRunId
          AND p.EndTime > @StartTime
          AND
          ( 
             (
               p.TimeStamp >=@StartTime 
               AND p.TimeStamp <@EndTime            
             )
             OR
             (
               p.TimeStamp < @StartTime                         
             )
          )
          AND ( 
                (@FilterNoLog = 1 AND TestLogId IS NOT NULL)
                OR
                (@FilterNoLog = 0)
              )

UNION

SELECT    UserId,
          PageDetailId,
          TestCaseName,
          p.TimeStamp as StartTime,
          p.EndTime,
          ScenarioName,
          p.Outcome,
          detail.AgentId,
          s.ScenarioId,
          ResponseTime,
          TestType,
          NetworkName,
          ISNULL(TestLogId,-1),
          PageId,
          RequestUri,
          BrowserName,
          agent.AgentName
FROM      LoadTestPageDetail p     
JOIN      LoadTestTestDetail detail
ON        p.LoadTestRunId = detail.LoadTestRunId
          AND p.TestDetailId= detail.TestDetailId
JOIN      LoadTestCase tc
ON        detail.LoadTestRunId = tc.LoadTestRunId
          AND detail.TestCaseId = tc.TestCaseId
JOIN      LoadTestScenario s
ON        tc.LoadTestRunId = s.LoadTestRunId
          AND tc.ScenarioId = s.ScenarioId
JOIN      LoadTestRunAgent AS agent
ON        detail.LoadTestRunId = agent.LoadTestRunId
          AND detail.AgentId = agent.AgentId              
JOIN      WebLoadTestRequestMap map
ON        p.loadtestrunid = map.loadtestrunid
          AND p.PageId = map.RequestId
JOIN      @items i
ON        i.Test = tc.TestCaseId          
          AND i.Page = map.RequestId
LEFT JOIN LoadTestNetworks n
ON        detail.LoadTestRunId = n.LoadTestRunId
          AND detail.NetworkId = n.NetworkId
LEFT JOIN LoadTestBrowsers b
ON        detail.LoadTestRunId = b.LoadTestRunId
          AND detail.BrowserId = b.BrowserId 
WHERE     detail.LoadTestRunId = @LoadTestRunId
          AND p.EndTime > @StartTime
          AND
          ( 
             (
               p.TimeStamp >=@StartTime 
               AND p.TimeStamp <@EndTime            
             )
             OR
             (
               p.TimeStamp < @StartTime                         
             )
          )
          AND ( 
                (@FilterNoLog = 1 AND TestLogId IS NOT NULL)
                OR
                (@FilterNoLog = 0)
              )
          AND
          (
              p.Outcome = 0
          )        
ORDER BY  s.ScenarioId,AgentId,UserId, PageDetailId
END

ELSE
BEGIN

SELECT    UserId,
          p.PageDetailId,
          TestCaseName,
          p.TimeStamp as StartTime,
          p.EndTime,
          ScenarioName,
          p.Outcome,
          detail.AgentId,
          s.ScenarioId,
          ResponseTime,
          TestType,
          NetworkName,
          ISNULL(TestLogId,-1),
          PageId,
          RequestUri,
          BrowserName,
          agent.AgentName
FROM      LoadTestPageDetail p     
JOIN      LoadTestTestDetail detail
ON        p.LoadTestRunId = detail.LoadTestRunId
          AND p.TestDetailId= detail.TestDetailId
JOIN      LoadTestCase tc
ON        detail.LoadTestRunId = tc.LoadTestRunId
          AND detail.TestCaseId = tc.TestCaseId
JOIN      LoadTestScenario s
ON        tc.LoadTestRunId = s.LoadTestRunId
          AND tc.ScenarioId = s.ScenarioId
JOIN      LoadTestRunAgent AS agent
ON        detail.LoadTestRunId = agent.LoadTestRunId
          AND detail.AgentId = agent.AgentId              
JOIN      WebLoadTestRequestMap map
ON        p.loadtestrunid = map.loadtestrunid
          AND p.PageId = map.RequestId
JOIN      @items i
ON        i.Test = tc.TestCaseId          
          AND i.Page = map.RequestId
JOIN      LoadTestDetailMessage dm
ON        p.LoadTestRunId = dm.LoadTestRunId
          AND p.TestDetailId = dm.TestDetailId
          AND p.PageDetailId = dm.PageDetailId
JOIN      @errors errors
ON        dm.MessageTypeId = errors.ErrorId     
LEFT JOIN LoadTestNetworks n
ON        detail.LoadTestRunId = n.LoadTestRunId
          AND detail.NetworkId = n.NetworkId
LEFT JOIN LoadTestBrowsers b
ON        detail.LoadTestRunId = b.LoadTestRunId
          AND detail.BrowserId = b.BrowserId 
WHERE     detail.LoadTestRunId = @LoadTestRunId
          AND p.EndTime > @StartTime
          AND
          ( 
             (
               p.TimeStamp >=@StartTime 
               AND p.TimeStamp <@EndTime            
             )
             OR
             (
               p.TimeStamp < @StartTime                         
             )
          )
          AND ( 
                (@FilterNoLog = 1 AND TestLogId IS NOT NULL)
                OR
                (@FilterNoLog = 0)
              )      
ORDER BY  s.ScenarioId,AgentId,UserId, PageDetailId
END
GO
GRANT EXECUTE ON  [dbo].[Prc_GetUserPageDetail] TO [public]
GO
