SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetUserTransactionDetail]
    @LoadTestRunId INT,
	@StartTime     DATETIME,
    @EndTime       DATETIME,
    @FilterNoLog   BIT,
    @ItemsXml      NVARCHAR(MAX)
AS

SET NOCOUNT ON

DECLARE @docHandle    INT

--parse the items
DECLARE @items TABLE (
    Test            INT NOT NULL,
    TransactionId   INT NOT NULL
)

-- Parse the XML input into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @ItemsXml

INSERT  @items        
SELECT  t,tt
FROM OPENXML(@docHandle, N'/items/i', 0)
    WITH (                
        t INT,
        tt INT
    )

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle

--Select all transactions active during that time span
SELECT    UserId,
          TransactionDetailId,
          TestCaseName,          
          t.TimeStamp as StartTime,
          t.EndTime,
          ScenarioName,          
          detail.AgentId,
          s.ScenarioId,
          t.ElapsedTime,
          TestType,
          NetworkName,
          ISNULL(TestLogId,-1),
          t.TransactionId,
          wt.TransactionName,
          agent.AgentName
FROM      LoadTestTransactionDetail t     
JOIN      LoadTestTestDetail detail
ON        t.LoadTestRunId = detail.LoadTestRunId
          AND t.TestDetailId= detail.TestDetailId
JOIN      LoadTestCase tc
ON        detail.LoadTestRunId = tc.LoadTestRunId
          AND detail.TestCaseId = tc.TestCaseId
JOIN      LoadTestScenario s
ON        tc.LoadTestRunId = s.LoadTestRunId
          AND tc.ScenarioId = s.ScenarioId
JOIN      LoadTestRunAgent AS agent
ON        detail.LoadTestRunId = agent.LoadTestRunId
          AND detail.AgentId = agent.AgentId     
JOIN      WebLoadTestTransaction wt
ON        t.LoadTestRunId = wt.LoadTestRunId
          AND t.TransactionId = wt.TransactionId
JOIN      @items i
ON        i.Test = tc.TestCaseId          
          AND i.TransactionId = wt.TransactionId
LEFT JOIN LoadTestNetworks n
ON        detail.LoadTestRunId = n.LoadTestRunId
          AND detail.NetworkId = n.NetworkId
LEFT JOIN LoadTestBrowsers b
ON        detail.LoadTestRunId = b.LoadTestRunId
          AND detail.BrowserId = b.BrowserId 
WHERE     detail.LoadTestRunId = @LoadTestRunId
          AND t.EndTime > @StartTime
          AND
          ( 
             (
               t.TimeStamp >=@StartTime 
               AND t.TimeStamp <@EndTime            
             )
             OR
             (
               t.TimeStamp < @StartTime                      
             )
          )
          AND ( 
                (@FilterNoLog = 1 AND TestLogId IS NOT NULL)
                OR
                (@FilterNoLog = 0)
              )
ORDER BY  s.ScenarioId,AgentId,UserId, TransactionDetailId

GO
GRANT EXECUTE ON  [dbo].[Prc_GetUserTransactionDetail] TO [public]
GO
