SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_InsertPageDetail2]
	@LoadTestRunId int,
	@PageDetailId int,
	@TestDetailId int,
	@TimeStamp datetime,
    @EndTime datetime,
	@PageId int,
	@ResponseTime float,
	@ResponseTimeGoal float,
	@GoalExceeded bit,
    @Outcome tinyint,
	@InMeasurementInterval bit
AS
INSERT INTO LoadTestPageDetail
(
	LoadTestRunId,
	PageDetailId,
	TestDetailId,
	TimeStamp,
    EndTime,
	PageId,
	ResponseTime,
	ResponseTimeGoal,
	GoalExceeded,
    Outcome,
	InMeasurementInterval
)
VALUES(
	@LoadTestRunId,
	@PageDetailId,
	@TestDetailId,
	@TimeStamp,
    @EndTime,
	@PageId,
	@ResponseTime,
	@ResponseTimeGoal,
	@GoalExceeded,
    @Outcome,
	@InMeasurementInterval
)
GO
GRANT EXECUTE ON  [dbo].[Prc_InsertPageDetail2] TO [public]
GO
