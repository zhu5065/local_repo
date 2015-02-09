SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_UpdateTransactionPercentiles] @LoadTestRunId int, @TransactionId int
AS
update LoadTestTransactionSummaryData set 
    Percentile90 =
    (select min(ElapsedTime) from 
    (select top 10 percent ElapsedTime from LoadTestTransactionDetail 
        where LoadTestRunId = @LoadTestRunId and TransactionId=@TransactionId
        order by ElapsedTime desc) as TopElapsedTimes),
    Percentile95 =
    (select min(ElapsedTime) from 
    (select top 5 percent ElapsedTime from LoadTestTransactionDetail 
        where LoadTestRunId = @LoadTestRunId and TransactionId=@TransactionId
        order by ElapsedTime desc) as TopElapsedTimes)
where LoadTestRunId = @LoadTestRunId and TransactionId=@TransactionId
GO
GRANT EXECUTE ON  [dbo].[Prc_UpdateTransactionPercentiles] TO [public]
GO
