SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_UpdatePageSummaryByNetwork3] @LoadTestRunId int
AS

If IsNull(object_id('tempdb..#numberedPageAndTestDetails'),0) <> 0 DROP TABLE #numberedPageAndTestDetails

SELECT * INTO #numberedPageAndTestDetails FROM
 (
     SELECT pageDetail.ResponseTime, pageDetail.LoadTestRunId, testDetail.TestCaseId, 
           pageDetail.PageId, testDetail.NetworkId,
	       rowNumber=ROW_NUMBER() 
	       OVER (PARTITION BY pageDetail.LoadTestRunId, pageDetail.PageId , 
	         testDetail.NetworkId ORDER BY pageDetail.ResponseTime DESC),
	       COUNT(*) 
	       OVER (PARTITION BY pageDetail.LoadTestRunId, pageDetail.PageId, 
		     testDetail.NetworkId) AS rCount,
	       SUM(CASE WHEN GoalExceeded=0 THEN 1 ELSE 0 END)
	       OVER (PARTITION BY pageDetail.LoadTestRunId, pageDetail.PageId, 
		   testDetail.NetworkId) AS pagesMeetingGoal
  FROM LoadTestPageDetail AS pageDetail JOIN LoadTestTestDetail AS testDetail
  ON  pageDetail.LoadTestRunId = testDetail.LoadTestRunId AND 
      pageDetail.TestDetailId = testDetail.TestDetailId
  WHERE pageDetail.LoadTestRunId = @LoadTestRunId AND
        pageDetail.InMeasurementInterval = 1) AS allRows
  WHERE allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 100) OR 
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 20)  OR 
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 10)  OR
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 2) 


  UPDATE LoadTestPageSummaryByNetwork 
  SET Percentile90 = ResponseTime
  FROM  LoadTestPageSummaryByNetwork  JOIN #numberedPageAndTestDetails ON
        LoadTestPageSummaryByNetwork.LoadTestRunId = #numberedPageAndTestDetails.LoadTestRunId AND
        LoadTestPageSummaryByNetwork.PageId = #numberedPageAndTestDetails.PageId AND
        LoadTestPageSummaryByNetwork.NetworkId = #numberedPageAndTestDetails.NetworkId
  WHERE #numberedPageAndTestDetails.rowNumber = ceiling(CAST(#numberedPageAndTestDetails.rCount AS Float)/10)

  UPDATE LoadTestPageSummaryByNetwork 
  SET Percentile95 = ResponseTime
  FROM  LoadTestPageSummaryByNetwork  JOIN #numberedPageAndTestDetails ON
        LoadTestPageSummaryByNetwork.LoadTestRunId = #numberedPageAndTestDetails.LoadTestRunId AND
        LoadTestPageSummaryByNetwork.PageId = #numberedPageAndTestDetails.PageId AND
        LoadTestPageSummaryByNetwork.NetworkId = #numberedPageAndTestDetails.NetworkId
  WHERE #numberedPageAndTestDetails.rowNumber = ceiling(CAST(#numberedPageAndTestDetails.rCount AS Float)/20)

  UPDATE LoadTestPageSummaryByNetwork 
  SET Percentile99 = ResponseTime
  FROM  LoadTestPageSummaryByNetwork  JOIN #numberedPageAndTestDetails ON
        LoadTestPageSummaryByNetwork.LoadTestRunId = #numberedPageAndTestDetails.LoadTestRunId AND
        LoadTestPageSummaryByNetwork.PageId = #numberedPageAndTestDetails.PageId AND
        LoadTestPageSummaryByNetwork.NetworkId = #numberedPageAndTestDetails.NetworkId
  WHERE #numberedPageAndTestDetails.rowNumber = ceiling(CAST(#numberedPageAndTestDetails.rCount AS Float)/100)

  UPDATE LoadTestPageSummaryByNetwork 
  SET Median = ResponseTime
  FROM  LoadTestPageSummaryByNetwork  JOIN #numberedPageAndTestDetails ON
        LoadTestPageSummaryByNetwork.LoadTestRunId = #numberedPageAndTestDetails.LoadTestRunId AND
        LoadTestPageSummaryByNetwork.PageId = #numberedPageAndTestDetails.PageId AND
        LoadTestPageSummaryByNetwork.NetworkId = #numberedPageAndTestDetails.NetworkId
  WHERE #numberedPageAndTestDetails.rowNumber = ceiling(CAST(#numberedPageAndTestDetails.rCount AS Float)/2)

 UPDATE LoadTestPageSummaryByNetwork 
  SET PagesMeetingGoal =  results.pagesMeetingGoal
  FROM
  (SELECT  LoadTestRunId, PageId, NetworkId,  pagesMeetingGoal FROM #numberedPageAndTestDetails 
   GROUP BY LoadTestRunId, PageId, NetworkId, pagesMeetingGoal) AS results
   JOIN  LoadTestPageSummaryByNetwork
  ON LoadTestPageSummaryByNetwork.LoadTestRunId = results.LoadTestRunId AND
     LoadTestPageSummaryByNetwork.PageId = results.PageId AND
     LoadTestPageSummaryByNetwork.NetworkId = results.NetworkId
  DROP TABLE #numberedPageAndTestDetails

GO
GRANT EXECUTE ON  [dbo].[Prc_UpdatePageSummaryByNetwork3] TO [public]
GO
