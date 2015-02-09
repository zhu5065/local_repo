SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_UpdatePagePercentiles] @LoadTestRunId int, @PageId int
AS
update LoadTestPageSummaryData set 
    Percentile90 =
        (select min(ResponseTime) from 
        (select top 10 percent ResponseTime from LoadTestPageDetail 
        where LoadTestRunId = @LoadTestRunId and PageId=@PageId
        order by ResponseTime desc) as TopResponseTimes),
    Percentile95 =
        (select min(ResponseTime) from 
        (select top 5 percent ResponseTime from LoadTestPageDetail 
        where LoadTestRunId = @LoadTestRunId and PageId=@PageId
        order by ResponseTime desc) as TopResponseTimes)
where LoadTestRunId = @LoadTestRunId and PageId=@PageId
GO
GRANT EXECUTE ON  [dbo].[Prc_UpdatePagePercentiles] TO [public]
GO
