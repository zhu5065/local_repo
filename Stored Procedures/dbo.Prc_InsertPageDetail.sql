SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_InsertPageDetail]
	@LoadTestRunId int,
	@PageDetailId int,
	@TestDetailId int,
	@TimeStamp datetime,
	@PageId int,
	@ResponseTime float,
	@ResponseTimeGoal float,
	@GoalExceeded bit
AS
INSERT INTO LoadTestPageDetail
(
	LoadTestRunId,
	PageDetailId,
	TestDetailId,
	TimeStamp,
	PageId,
	ResponseTime,
	ResponseTimeGoal,
	GoalExceeded
)
VALUES(
	@LoadTestRunId,
	@PageDetailId,
	@TestDetailId,
	@TimeStamp,
	@PageId,
	@ResponseTime,
	@ResponseTimeGoal,
	@GoalExceeded
)
GO
GRANT EXECUTE ON  [dbo].[Prc_InsertPageDetail] TO [public]
GO
