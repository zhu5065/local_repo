SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_UpdateTestSummary] @LoadTestRunId int, @TestCaseId int
AS
UPDATE LoadTestTestSummaryData set 

    Percentile90 =
        (SELECT MIN(ElapsedTime) 
         FROM 
        (SELECT TOP 10 percent ElapsedTime FROM LoadTestTestDetail 
         WHERE LoadTestRunId = @LoadTestRunId 
              AND TestCaseId=@TestCaseId
              AND InMeasurementInterval = 1
         ORDER BY ElapsedTime desc) AS TopElapsedTimes),

    Percentile95 =
        (SELECT MIN(ElapsedTime) 
         FROM 
        (SELECT TOP 5 percent ElapsedTime FROM LoadTestTestDetail 
         WHERE LoadTestRunId = @LoadTestRunId 
                  AND TestCaseId=@TestCaseId
                  AND InMeasurementInterval = 1
         ORDER BY ElapsedTime DESC) AS TopElapsedTimes),

    Percentile99 =
        (SELECT MIN(ElapsedTime) 
         FROM 
        (SELECT TOP 1 percent ElapsedTime FROM LoadTestTestDetail 
         WHERE LoadTestRunId = @LoadTestRunId 
                  AND TestCaseId=@TestCaseId
                  AND InMeasurementInterval = 1
         ORDER BY ElapsedTime DESC) AS TopElapsedTimes),

    Median =
        (SELECT MIN(ElapsedTime)
         FROM
        (SELECT TOP 50 PERCENT ElapsedTime FROM LoadTestTestDetail
         WHERE LoadTestRunId = @LoadTestRunId 
                  AND TestCaseId=@TestCaseId
                  AND InMeasurementInterval = 1
         ORDER BY ElapsedTime DESC) AS TopElapsedTimes)

    WHERE LoadTestRunId = @LoadTestRunId 
      AND TestCaseId=@TestCaseId
GO
GRANT EXECUTE ON  [dbo].[Prc_UpdateTestSummary] TO [public]
GO
