SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_UpdateSummaryData2] @LoadTestRunId int, @DeleteDetailTables bit
AS
BEGIN
	INSERT INTO LoadTestTestSummaryData 
	    (LoadTestRunId, TestCaseId, TestsRun, Average, Minimum, Maximum, StandardDeviation)
	   SELECT LoadTestRunId, TestCaseId,
	          count(*) as TestsRun,
	          avg(ElapsedTime) as Average, 
	          min(ElapsedTime) as Minimum,
	          max(ElapsedTime) as Maximum,
              ISNULL(STDEVP(ElapsedTime),0) AS StandardDeviation
	    FROM  LoadTestTestDetail 
		WHERE LoadTestRunId=@LoadTestRunId
		      AND InMeasurementInterval = 1
	    GROUP BY LoadTestRunId, TestCaseId

	DECLARE @TestCaseId int

	DECLARE TestCaseCursor CURSOR FOR
	SELECT DISTINCT(TestCaseId) FROM LoadTestTestDetail WHERE LoadTestRunId = @LoadTestRunId

	OPEN TestCaseCursor
	FETCH NEXT FROM TestCaseCursor INTO @TestCaseId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	   EXEC Prc_UpdateTestSummary @LoadTestRunId, @TestCaseId
	   FETCH NEXT FROM TestCaseCursor INTO @TestCaseId
	END

	CLOSE TestCaseCursor
	DEALLOCATE TestCaseCursor

	INSERT INTO LoadTestTransactionSummaryData 
	    (LoadTestRunId, TransactionId, TransactionCount, Average, Minimum, Maximum,AvgTransactionTime, StandardDeviation)
	    SELECT LoadTestRunId, TransactionId,
	           count(*) as TransactionCount,
	           avg(ResponseTime) as Average, 
	           min(ResponseTime) as Minimum,
                   max(ResponseTime) as Maximum,
                   avg(ElapsedTime) as AverageTransactionTime,
                   ISNULL(STDEVP(ResponseTime),0) AS StandardDeviation
	    FROM LoadTestTransactionDetail 
		WHERE  LoadTestRunId=@LoadTestRunId
		       AND InMeasurementInterval = 1
	    GROUP BY LoadTestRunId, TransactionId

	DECLARE @TransactionId int

	DECLARE TransactionIdCursor CURSOR FOR
	SELECT DISTINCT(TransactionId) FROM LoadTestTransactionDetail WHERE LoadTestRunId = @LoadTestRunId

	OPEN TransactionIdCursor
	FETCH NEXT FROM TransactionIdCursor INTO @TransactionId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	   EXEC Prc_UpdateTransactionSummary @LoadTestRunId, @TransactionId
	   FETCH NEXT FROM TransactionIdCursor INTO @TransactionId
	END

	CLOSE TransactionIdCursor
	DEALLOCATE TransactionIdCursor

	INSERT INTO LoadTestPageSummaryData 
	    (LoadTestRunId, PageId, PageCount, Average, Minimum, Maximum, StandardDeviation)
	    SELECT LoadTestRunId, PageId,
	           count(*) as PageCount,
	           avg(ResponseTime) as Average, 
	           min(ResponseTime) as Minimum,
	           max(ResponseTime) as Maximum,
                   ISNULL(STDEVP(ResponseTime),0) AS StandardDeviation
	    FROM   LoadTestPageDetail 
		WHERE  LoadTestRunId=@LoadTestRunId
		       AND InMeasurementInterval = 1
	    GROUP BY LoadTestRunId, PageId

	DECLARE @PageId int

	DECLARE PageIdCursor CURSOR FOR
	SELECT DISTINCT(PageId) FROM LoadTestPageDetail WHERE LoadTestRunId = @LoadTestRunId

	OPEN PageIdCursor
	FETCH NEXT FROM PageIdCursor INTO @PageId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	   EXEC Prc_UpdatePageSummary @LoadTestRunId, @PageId
	   FETCH NEXT FROM PageIdCursor INTO @PageId
	END

	CLOSE PageIdCursor
	DEALLOCATE PageIdCursor

	INSERT INTO LoadTestPageSummaryByNetwork
	    (LoadTestRunId, PageId, NetworkId, PageCount, Average, Minimum, Maximum, Goal, StandardDeviation)
	    SELECT pageDetail.LoadTestRunId, pageDetail.PageId, testDetail.NetworkId,
	           count(*) as PageCount,
	           avg(ResponseTime) as Average, 
	           min(ResponseTime) as Minimum,
	           max(ResponseTime) as Maximum,
	           avg(ResponseTimeGoal) as Goal,
                   ISNULL(STDEVP(ResponseTime),0) AS StandardDeviation
	    FROM   LoadTestPageDetail as pageDetail
	    INNER JOIN LoadTestTestDetail as testDetail
	    ON pageDetail.LoadTestRunId = testDetail.LoadTestRunId
	          AND pageDetail.TestDetailId = testDetail.TestDetailId
	    WHERE pageDetail.LoadTestRunId = @LoadTestRunId
		      AND pageDetail.InMeasurementInterval = 1
	    GROUP BY pageDetail.LoadTestRunId, PageId, testDetail.NetworkId

	DECLARE @NetworkId int

	DECLARE PageNetworkCursor CURSOR FOR
	SELECT PageId, NetworkId from LoadTestPageSummaryByNetwork WHERE LoadTestRunId = @LoadTestRunId

	OPEN PageNetworkCursor
	FETCH NEXT FROM PageNetworkCursor INTO @PageId, @NetworkId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	   EXEC Prc_UpdatePageSummaryByNetwork @LoadTestRunId, @PageId, @NetworkId
	   FETCH NEXT FROM PageNetworkCursor INTO @PageId, @NetworkId
	END

	CLOSE PageNetworkCursor
	DEALLOCATE PageNetworkCursor

	IF @DeleteDetailTables = 1
	BEGIN
		DELETE from LoadTestTestDetail where LoadTestRunId = @LoadTestRunId
		DELETE from LoadTestTransactionDetail where LoadTestRunId = @LoadTestRunId
		DELETE from LoadTestPageDetail where LoadTestRunId = @LoadTestRunId
	END
END
GO
GRANT EXECUTE ON  [dbo].[Prc_UpdateSummaryData2] TO [public]
GO
