SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_UpdatePageByNetworkPercentiles] @LoadTestRunId int, @PageId int, @NetworkId int
AS
update LoadTestPageSummaryByNetwork set 
    Percentile90 =
    (select min(ResponseTime) from 
    (select top 10 percent pageDetail.ResponseTime 
        from LoadTestPageDetail as pageDetail
        INNER JOIN LoadTestTestDetail as testDetail
	    ON pageDetail.LoadTestRunId = testDetail.LoadTestRunId
	    AND pageDetail.TestDetailId = testDetail.TestDetailId
        where pageDetail.LoadTestRunId = @LoadTestRunId and 
              pageDetail.PageId=@PageId and
              testDetail.NetworkId=@NetworkId
        order by pageDetail.ResponseTime desc) as TopResponseTimes),
    Percentile95 =
    (select min(ResponseTime) from 
    (select top 5 percent pageDetail.ResponseTime 
        from LoadTestPageDetail as pageDetail
        INNER JOIN LoadTestTestDetail as testDetail
	    ON pageDetail.LoadTestRunId = testDetail.LoadTestRunId
	    AND pageDetail.TestDetailId = testDetail.TestDetailId
        where pageDetail.LoadTestRunId = @LoadTestRunId and 
              pageDetail.PageId=@PageId and
              testDetail.NetworkId=@NetworkId
        order by pageDetail.ResponseTime desc) as TopResponseTimes),
    PagesMeetingGoal =
       (select count(*)
        from LoadTestPageDetail as pageDetail
	    INNER JOIN LoadTestTestDetail as testDetail
	    ON pageDetail.LoadTestRunId = testDetail.LoadTestRunId
	    AND pageDetail.TestDetailId = testDetail.TestDetailId
        where pageDetail.LoadTestRunId = @LoadTestRunId and 
              pageDetail.PageId=@PageId and
              testDetail.NetworkId=@NetworkId and
              pageDetail.GoalExceeded = 0)
where LoadTestRunId=@LoadTestRunId and PageId=@PageId and NetworkId=@NetworkId           
GO
GRANT EXECUTE ON  [dbo].[Prc_UpdatePageByNetworkPercentiles] TO [public]
GO
