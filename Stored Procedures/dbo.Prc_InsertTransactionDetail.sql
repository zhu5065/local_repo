SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_InsertTransactionDetail]
	@LoadTestRunId int,
	@TransactionDetailId int,
	@TestDetailId int,
	@TimeStamp datetime,
	@TransactionId int,
	@ElapsedTime float
AS
INSERT INTO LoadTestTransactionDetail
(
	LoadTestRunId,
	TransactionDetailId,
	TestDetailId,
	TimeStamp,
	TransactionId,
	ElapsedTime
)
VALUES(
	@LoadTestRunId,
	@TransactionDetailId,
	@TestDetailId,
	@TimeStamp,
	@TransactionId,
	@ElapsedTime
)
GO
GRANT EXECUTE ON  [dbo].[Prc_InsertTransactionDetail] TO [public]
GO
