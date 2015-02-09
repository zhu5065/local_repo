SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetUniqueDetailIds]
   @LoadTestRunId  INT,
   @DetailType     TINYINT
   
AS

SET NOCOUNT ON


IF (@DetailType = 0) -- Test
BEGIN
    SELECT DISTINCT TestCaseId
    FROM      LoadTestTestDetail detail    
    WHERE     detail.LoadTestRunId = @LoadTestRunId    
END
ELSE IF (@DetailType = 1) --Transaction
BEGIN
    SELECT DISTINCT TestCaseId,t.TransactionId
    FROM      LoadTestTransactionDetail t     	
	JOIN      WebLoadTestTransaction wt
	ON        t.LoadTestRunId = wt.LoadTestRunId
          AND t.TransactionId = wt.TransactionId
    WHERE     t.LoadTestRunId = @LoadTestRunId    
END
ELSE IF (@DetailType = 2) -- Page 
BEGIN
    SELECT DISTINCT TestCaseId,PageId
    FROM      LoadTestPageDetail p         
    JOIN      WebLoadTestRequestMap map
    ON        p.loadtestrunid = map.loadtestrunid
              AND p.PageId = map.RequestId
    WHERE     p.LoadTestRunId = @LoadTestRunId    
END
GO
GRANT EXECUTE ON  [dbo].[Prc_GetUniqueDetailIds] TO [public]
GO
