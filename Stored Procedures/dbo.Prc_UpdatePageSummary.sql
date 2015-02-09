SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_UpdatePageSummary] @LoadTestRunId int, @PageId int
AS
UPDATE LoadTestPageSummaryData 
SET 
    Percentile90 =
      (SELECT MIN(ResponseTime) 
       FROM 
           (SELECT TOP 10 PERCENT ResponseTime 
            FROM LoadTestPageDetail 
            WHERE LoadTestRunId = @LoadTestRunId 
                  AND PageId=@PageId
                  AND InMeasurementInterval = 1
            ORDER BY ResponseTime DESC) AS TopResponseTimes),

    Percentile95 =
       (SELECT MIN(ResponseTime) 
        FROM 
            (SELECT TOP 5 percent ResponseTime 
             FROM LoadTestPageDetail 
             WHERE LoadTestRunId = @LoadTestRunId 
                   AND PageId=@PageId
                   AND InMeasurementInterval = 1
             ORDER BY ResponseTime DESC) AS TopResponseTimes),

    Percentile99 =
       (SELECT MIN(ResponseTime) 
        FROM 
            (SELECT TOP 1 percent ResponseTime 
             FROM LoadTestPageDetail 
             WHERE LoadTestRunId = @LoadTestRunId 
                   AND PageId=@PageId
                   AND InMeasurementInterval = 1
             ORDER BY ResponseTime DESC) AS TopResponseTimes),

    Median =
        (SELECT MIN(ResponseTime) FROM 
        (SELECT TOP 50 PERCENT ResponseTime FROM LoadTestPageDetail
         WHERE LoadTestRunId = @LoadTestRunId 
                  AND PageId=@PageId
                  AND InMeasurementInterval = 1
         ORDER BY ResponseTime DESC) AS TopResponseTimes)

WHERE LoadTestRunId = @LoadTestRunId 
      AND PageId=@PageId
GO
GRANT EXECUTE ON  [dbo].[Prc_UpdatePageSummary] TO [public]
GO
