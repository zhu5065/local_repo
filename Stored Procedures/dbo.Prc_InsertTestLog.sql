SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_InsertTestLog]
    @LoadTestRunId int,
    @AgentId int,
    @TestCaseId int,
    @TestLogId int,
    @TestLog image      
AS
INSERT INTO LoadTestTestLog
(
    LoadTestRunId,
    AgentId,
    TestCaseId,
    TestLogId,
    TestLog
)
VALUES(
    @LoadTestRunId,
    @AgentId,
    @TestCaseId,
    @TestLogId,
    @TestLog
)
GO
GRANT EXECUTE ON  [dbo].[Prc_InsertTestLog] TO [public]
GO
