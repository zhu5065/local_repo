SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_UpdateTransactionSummary] @LoadTestRunId int, @TransactionId int
AS
UPDATE LoadTestTransactionSummaryData 
SET 
    Percentile90 =
    (SELECT MIN(ResponseTime) 
     FROM 
         (SELECT TOP 10 percent ResponseTime 
          FROM LoadTestTransactionDetail 
          WHERE LoadTestRunId = @LoadTestRunId 
                AND TransactionId=@TransactionId
                AND InMeasurementInterval = 1
          ORDER BY ResponseTime desc) as TopResponseTimes),

    Percentile95 =
    (SELECT MIN(ResponseTime) 
     FROM 
         (SELECT TOP 5 percent ResponseTime 
          FROM   LoadTestTransactionDetail 
          WHERE  LoadTestRunId = @LoadTestRunId 
                 AND TransactionId=@TransactionId
                 AND InMeasurementInterval = 1
          ORDER BY ResponseTime desc) AS TopResponseTimes),

    Percentile99 =
    (SELECT MIN(ResponseTime) 
     FROM 
         (SELECT TOP 1 percent ResponseTime 
          FROM   LoadTestTransactionDetail 
          WHERE  LoadTestRunId = @LoadTestRunId 
                 AND TransactionId=@TransactionId
                 AND InMeasurementInterval = 1
          ORDER BY ResponseTime desc) AS TopResponseTimes),

    Median =
        (SELECT MIN(ResponseTime)
         FROM
             (SELECT TOP 50 PERCENT ResponseTime 
              FROM LoadTestTransactionDetail
              WHERE LoadTestRunId = @LoadTestRunId 
                  AND TransactionId=@TransactionId
                  AND InMeasurementInterval = 1
              ORDER BY ResponseTime DESC) AS TopResponseTimes)

WHERE LoadTestRunId = @LoadTestRunId 
      AND TransactionId=@TransactionId
GO
GRANT EXECUTE ON  [dbo].[Prc_UpdateTransactionSummary] TO [public]
GO
