SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_UpdateTestPercentiles] @LoadTestRunId int, @TestCaseId int
AS
update LoadTestTestSummaryData set 
    Percentile90 =
    (select min(ElapsedTime) from 
    (select top 10 percent ElapsedTime from LoadTestTestDetail 
        where LoadTestRunId = @LoadTestRunId and TestCaseId=@TestCaseId
        order by ElapsedTime desc) as TopElapsedTimes),
    Percentile95 =
    (select min(ElapsedTime) from 
    (select top 5 percent ElapsedTime from LoadTestTestDetail 
        where LoadTestRunId = @LoadTestRunId and TestCaseId=@TestCaseId
        order by ElapsedTime desc) as TopElapsedTimes)
where LoadTestRunId = @LoadTestRunId and TestCaseId=@TestCaseId
GO
GRANT EXECUTE ON  [dbo].[Prc_UpdateTestPercentiles] TO [public]
GO
