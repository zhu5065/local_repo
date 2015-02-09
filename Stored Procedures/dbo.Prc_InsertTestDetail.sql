SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

-- New stored procedures

CREATE PROCEDURE [dbo].[Prc_InsertTestDetail]
	@LoadTestRunId int,
	@TestDetailId int,
	@TimeStamp datetime,
	@TestCaseId int,
	@ElapsedTime float,
        @AgentId int,
        @BrowserId int,
        @NetworkId int
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
        NetworkId
)
VALUES(
	@LoadTestRunId,
	@TestDetailId,
	@TimeStamp,
	@TestCaseId,
	@ElapsedTime,
        @AgentId,
        @BrowserId,
        @NetworkId
)
GO
GRANT EXECUTE ON  [dbo].[Prc_InsertTestDetail] TO [public]
GO
