SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_UpdateTransactionSummary3] @LoadTestRunId int
AS
If IsNull(object_id('tempdb..#numberedTransactionDetails'),0) <> 0 DROP TABLE #numberedTransactionDetails

  SELECT * INTO #numberedTransactionDetails FROM 
  (
      SELECT ResponseTime, LoadTestRunId, TransactionId, 
	   rowNumber=ROW_NUMBER() 
	   OVER (PARTITION BY LoadTestRunId, TransactionId 
                 ORDER BY ResponseTime DESC),
	   COUNT(*) 
           OVER (PARTITION BY LoadTestRunId, TransactionId) AS rCount
      FROM LoadTestTransactionDetail
      WHERE LoadTestRunId = @LoadTestRunId AND
        InMeasurementInterval = 1) AS allRows
  WHERE allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 100) OR 
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 20)  OR 
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 10)  OR
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 2) 


  UPDATE LoadTestTransactionSummaryData  
  SET Percentile90 = ResponseTime
  FROM  LoadTestTransactionSummaryData  JOIN #numberedTransactionDetails ON
        LoadTestTransactionSummaryData.LoadTestRunId = #numberedTransactionDetails.LoadTestRunId AND
        LoadTestTransactionSummaryData.TransactionId = #numberedTransactionDetails.TransactionId
  WHERE #numberedTransactionDetails.rowNumber = ceiling(CAST(#numberedTransactionDetails.rCount AS Float)/10)


  UPDATE LoadTestTransactionSummaryData  
  SET Percentile95 = ResponseTime
  FROM  LoadTestTransactionSummaryData  JOIN #numberedTransactionDetails ON
        LoadTestTransactionSummaryData.LoadTestRunId = #numberedTransactionDetails.LoadTestRunId AND
        LoadTestTransactionSummaryData.TransactionId = #numberedTransactionDetails.TransactionId
  WHERE #numberedTransactionDetails.rowNumber = ceiling(CAST(#numberedTransactionDetails.rCount AS Float)/20)


  UPDATE LoadTestTransactionSummaryData  
  SET Percentile99 = ResponseTime
  FROM  LoadTestTransactionSummaryData  JOIN #numberedTransactionDetails ON
        LoadTestTransactionSummaryData.LoadTestRunId = #numberedTransactionDetails.LoadTestRunId AND
        LoadTestTransactionSummaryData.TransactionId = #numberedTransactionDetails.TransactionId
  WHERE #numberedTransactionDetails.rowNumber = ceiling(CAST(#numberedTransactionDetails.rCount AS Float)/100)



  UPDATE LoadTestTransactionSummaryData  
  SET Median = ResponseTime
  FROM  LoadTestTransactionSummaryData  JOIN #numberedTransactionDetails ON
        LoadTestTransactionSummaryData.LoadTestRunId = #numberedTransactionDetails.LoadTestRunId AND
        LoadTestTransactionSummaryData.TransactionId = #numberedTransactionDetails.TransactionId
  WHERE #numberedTransactionDetails.rowNumber = ceiling(CAST(#numberedTransactionDetails.rCount AS Float)/2)

  DROP TABLE #numberedTransactionDetails
GO
GRANT EXECUTE ON  [dbo].[Prc_UpdateTransactionSummary3] TO [public]
GO
