SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_UpdateTestSummary3] @LoadTestRunId int
AS

If IsNull(object_id('tempdb..#numberedTestDetails'),0) <> 0 DROP TABLE #numberedTestDetails

  SELECT * INTO #numberedTestDetails FROM 
  (
      SELECT ElapsedTime, LoadTestRunId, TestCaseId, 
	   rowNumber=ROW_NUMBER() 
	   OVER (PARTITION BY LoadTestRunId, TestCaseId 
                 ORDER BY ElapsedTime DESC),
	   COUNT(*) 
           OVER (PARTITION BY LoadTestRunId, TestCaseId) AS rCount
      FROM LoadTestTestDetail
      WHERE LoadTestRunId = @LoadTestRunId AND
        InMeasurementInterval = 1) AS allRows
  WHERE allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 100) OR 
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 20)  OR 
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 10)  OR
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 2) 
 
  UPDATE LoadTestTestSummaryData  
  SET Percentile90 = ElapsedTime
  FROM  LoadTestTestSummaryData  JOIN #numberedTestDetails ON
        LoadTestTestSummaryData.LoadTestRunId = #numberedTestDetails.LoadTestRunId AND
        LoadTestTestSummaryData.TestCaseId = #numberedTestDetails.TestCaseId
  WHERE #numberedTestDetails.rowNumber = ceiling(CAST(#numberedTestDetails.rCount AS Float)/10)

  UPDATE LoadTestTestSummaryData  
  SET Percentile95 = ElapsedTime
  FROM  LoadTestTestSummaryData  JOIN #numberedTestDetails ON
        LoadTestTestSummaryData.LoadTestRunId = #numberedTestDetails.LoadTestRunId AND
        LoadTestTestSummaryData.TestCaseId = #numberedTestDetails.TestCaseId
  WHERE #numberedTestDetails.rowNumber = ceiling(CAST(#numberedTestDetails.rCount AS Float)/20)

  UPDATE LoadTestTestSummaryData  
  SET Percentile99 = ElapsedTime
  FROM  LoadTestTestSummaryData  JOIN #numberedTestDetails ON
        LoadTestTestSummaryData.LoadTestRunId = #numberedTestDetails.LoadTestRunId AND
        LoadTestTestSummaryData.TestCaseId = #numberedTestDetails.TestCaseId
  WHERE #numberedTestDetails.rowNumber = ceiling(CAST(#numberedTestDetails.rCount AS Float)/100)

  UPDATE LoadTestTestSummaryData  
  SET Median = ElapsedTime
  FROM  LoadTestTestSummaryData  JOIN #numberedTestDetails ON
        LoadTestTestSummaryData.LoadTestRunId = #numberedTestDetails.LoadTestRunId AND
        LoadTestTestSummaryData.TestCaseId = #numberedTestDetails.TestCaseId
  WHERE #numberedTestDetails.rowNumber = ceiling(CAST(#numberedTestDetails.rCount AS Float)/2)

  DROP TABLE #numberedTestDetails

GO
GRANT EXECUTE ON  [dbo].[Prc_UpdateTestSummary3] TO [public]
GO
