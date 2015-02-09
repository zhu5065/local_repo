SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_InsertTestDetail2]
	@LoadTestRunId int,
	@TestDetailId int,
	@TimeStamp datetime,
	@TestCaseId int,
	@ElapsedTime float,
    @AgentId int,
    @BrowserId int,
    @NetworkId int,
    @Outcome tinyint,
    @TestLogId int,
    @UserId int,
    @EndTime datetime,
	@InMeasurementInterval bit     
AS
INSERT INTO LoadTestTestDetail
(
	LoadTestRunId,
	TestDetailId,
	TimeStamp,
	TestCaseId,
	ElapsedTime,
    AgentId,
    BrowserId,
    NetworkId,
    Outcome,
    TestLogId,
    UserId,
    EndTime,
	InMeasurementInterval
)
VALUES(
	@LoadTestRunId,
	@TestDetailId,
	@TimeStamp,
	@TestCaseId,
	@ElapsedTime,
    @AgentId,
    @BrowserId,
    @NetworkId,
    @Outcome,
    @TestLogId,
    @UserId,
    @EndTime,
	@InMeasurementInterval
)
GO
GRANT EXECUTE ON  [dbo].[Prc_InsertTestDetail2] TO [public]
GO
