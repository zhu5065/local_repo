SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_InsertSqlTraceRow] 
	@LoadTestRunId int,
	@TextData ntext,
	@Duration bigint,
	@StartTime datetime,
	@EndTime datetime,
	@Reads bigint,
	@Writes bigint,
	@CPU int,
	@EventClass int
AS
INSERT INTO LoadTestSqlTrace
(
	LoadTestRunId,
	TextData,
	Duration,
	StartTime,
	EndTime,
	Reads,
	Writes,
	CPU,
	EventClass
)
VALUES(
	@LoadTestRunId,
	@TextData,
	@Duration,
	@StartTime,
	@EndTime,
	@Reads,
	@Writes,
	@CPU,
	@EventClass
)
GO
GRANT EXECUTE ON  [dbo].[Prc_InsertSqlTraceRow] TO [public]
GO
