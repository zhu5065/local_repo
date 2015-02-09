SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_UpdatePageSummaryByNetwork] @LoadTestRunId int, @PageId int, @NetworkId int
AS
UPDATE LoadTestPageSummaryByNetwork 
SET 
    Percentile90 =
    (SELECT MIN(ResponseTime) 
     FROM 
         (SELECT TOP 10 percent pageDetail.ResponseTime 
          FROM LoadTestPageDetail AS pageDetail
          JOIN LoadTestTestDetail AS testDetail
          ON   pageDetail.LoadTestRunId = testDetail.LoadTestRunId
               AND pageDetail.TestDetailId = testDetail.TestDetailId
          where pageDetail.LoadTestRunId = @LoadTestRunId 
                AND pageDetail.PageId=@PageId 
                AND testDetail.NetworkId=@NetworkId
                AND pageDetail.InMeasurementInterval = 1
          ORDER BY pageDetail.ResponseTime DESC) AS TopResponseTimes),

    Percentile95 =
    (SELECT MIN(ResponseTime) 
     FROM 
         (SELECT TOP 5 percent pageDetail.ResponseTime 
          FROM LoadTestPageDetail AS pageDetail
          JOIN LoadTestTestDetail AS testDetail
               ON   pageDetail.LoadTestRunId = testDetail.LoadTestRunId
               AND pageDetail.TestDetailId = testDetail.TestDetailId
          WHERE pageDetail.LoadTestRunId = @LoadTestRunId 
                AND pageDetail.PageId=@PageId 
                AND testDetail.NetworkId=@NetworkId
                AND pageDetail.InMeasurementInterval = 1
          ORDER BY pageDetail.ResponseTime DESC) AS TopResponseTimes),

    Percentile99 =
    (SELECT MIN(ResponseTime) 
     FROM 
         (SELECT TOP 1 percent pageDetail.ResponseTime 
          FROM LoadTestPageDetail AS pageDetail
          JOIN LoadTestTestDetail AS testDetail
               ON   pageDetail.LoadTestRunId = testDetail.LoadTestRunId
               AND pageDetail.TestDetailId = testDetail.TestDetailId
          WHERE pageDetail.LoadTestRunId = @LoadTestRunId 
                AND pageDetail.PageId=@PageId 
                AND testDetail.NetworkId=@NetworkId
                AND pageDetail.InMeasurementInterval = 1
          ORDER BY pageDetail.ResponseTime DESC) AS TopResponseTimes),

    Median =
    (SELECT MIN(ResponseTime) 
     FROM 
         (SELECT TOP 50 percent pageDetail.ResponseTime 
          FROM LoadTestPageDetail AS pageDetail
          JOIN LoadTestTestDetail AS testDetail
               ON  pageDetail.LoadTestRunId = testDetail.LoadTestRunId
               AND pageDetail.TestDetailId = testDetail.TestDetailId
          WHERE pageDetail.LoadTestRunId = @LoadTestRunId 
                AND pageDetail.PageId=@PageId 
                AND testDetail.NetworkId=@NetworkId
                AND pageDetail.InMeasurementInterval = 1
          ORDER BY pageDetail.ResponseTime DESC) AS TopResponseTimes),

    PagesMeetingGoal =
       (SELECT count(*)
        FROM LoadTestPageDetail AS pageDetail
        JOIN LoadTestTestDetail AS testDetail
        ON   pageDetail.LoadTestRunId = testDetail.LoadTestRunId
             AND pageDetail.TestDetailId = testDetail.TestDetailId
        WHERE pageDetail.LoadTestRunId = @LoadTestRunId  
              AND pageDetail.PageId=@PageId 
              AND testDetail.NetworkId=@NetworkId 
              AND pageDetail.GoalExceeded = 0
              AND pageDetail.InMeasurementInterval = 1)

WHERE LoadTestRunId=@LoadTestRunId
      AND PageId=@PageId
      AND NetworkId=@NetworkId
GO
GRANT EXECUTE ON  [dbo].[Prc_UpdatePageSummaryByNetwork] TO [public]
GO
