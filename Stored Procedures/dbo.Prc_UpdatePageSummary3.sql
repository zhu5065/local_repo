SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_UpdatePageSummary3] @LoadTestRunId int
AS
If IsNull(object_id('tempdb..#numberedPageDetails'),0) <> 0 DROP TABLE #numberedPageDetails

  SELECT * INTO #numberedPageDetails FROM 
  (
      SELECT ResponseTime, LoadTestRunId, PageId, 
	   rowNumber=ROW_NUMBER() 
	   OVER (PARTITION BY LoadTestRunId, PageId 
                 ORDER BY ResponseTime DESC),
	   COUNT(*) 
           OVER (PARTITION BY LoadTestRunId, PageId) AS rCount
      FROM LoadTestPageDetail
      WHERE LoadTestRunId = @LoadTestRunId AND
        InMeasurementInterval = 1) AS allRows
  WHERE allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 100) OR 
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 20)  OR 
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 10)  OR
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 2) 


  UPDATE LoadTestPageSummaryData 
  SET Percentile90 = ResponseTime
  FROM  LoadTestPageSummaryData  JOIN #numberedPageDetails ON
        LoadTestPageSummaryData.LoadTestRunId = #numberedPageDetails.LoadTestRunId AND
        LoadTestPageSummaryData.PageId = #numberedPageDetails.PageId
  WHERE #numberedPageDetails.rowNumber = ceiling(CAST(#numberedPageDetails.rCount AS Float)/10)

  UPDATE LoadTestPageSummaryData 
  SET Percentile95 = ResponseTime
  FROM  LoadTestPageSummaryData  JOIN #numberedPageDetails ON
        LoadTestPageSummaryData.LoadTestRunId = #numberedPageDetails.LoadTestRunId AND
        LoadTestPageSummaryData.PageId = #numberedPageDetails.PageId
  WHERE #numberedPageDetails.rowNumber = ceiling(CAST(#numberedPageDetails.rCount AS Float)/20)

  UPDATE LoadTestPageSummaryData 
  SET Percentile99 = ResponseTime
  FROM  LoadTestPageSummaryData  JOIN #numberedPageDetails ON
        LoadTestPageSummaryData.LoadTestRunId = #numberedPageDetails.LoadTestRunId AND
        LoadTestPageSummaryData.PageId = #numberedPageDetails.PageId
  WHERE #numberedPageDetails.rowNumber = ceiling(CAST(#numberedPageDetails.rCount AS Float)/100)

  UPDATE LoadTestPageSummaryData 
  SET Median = ResponseTime
  FROM  LoadTestPageSummaryData  JOIN #numberedPageDetails ON
        LoadTestPageSummaryData.LoadTestRunId = #numberedPageDetails.LoadTestRunId AND
        LoadTestPageSummaryData.PageId = #numberedPageDetails.PageId
  WHERE #numberedPageDetails.rowNumber = ceiling(CAST(#numberedPageDetails.rCount AS Float)/2)


  DROP TABLE #numberedPageDetails
GO
GRANT EXECUTE ON  [dbo].[Prc_UpdatePageSummary3] TO [public]
GO
