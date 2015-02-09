SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_InsertTransactionDetail2]
	@LoadTestRunId int,
	@TransactionDetailId int,
	@TestDetailId int,
	@TimeStamp datetime,
        @EndTime datetime,
	@TransactionId int,
	@ElapsedTime float,
	@InMeasurementInterval bit,
        @ResponseTime float    
AS
INSERT INTO LoadTestTransactionDetail
(
	LoadTestRunId,
	TransactionDetailId,
	TestDetailId,
	TimeStamp,
        EndTime,
	TransactionId,
	ElapsedTime,
	InMeasurementInterval,
        ResponseTime  
)
VALUES(
	@LoadTestRunId,
	@TransactionDetailId,
	@TestDetailId,
	@TimeStamp,
        @EndTime,
	@TransactionId,
	@ElapsedTime,
	@InMeasurementInterval,
	@ResponseTime
    
)
GO
GRANT EXECUTE ON  [dbo].[Prc_InsertTransactionDetail2] TO [public]
GO
