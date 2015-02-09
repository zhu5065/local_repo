SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_InsertSample]
	@LoadTestRunId int,
	@TestRunIntervalId int,
	@InstanceId int,
	@ComputedValue real,
	@RawValue bigint,
	@BaseValue bigint,
	@CounterFrequency bigint,
	@SystemFrequency bigint,
	@SampleTimeStamp bigint,
	@SampleTimeStamp100nSec bigint,
	@CounterType int,
	@ThresholdRuleResult tinyint,
	@ThresholdRuleMessageId int
AS
INSERT INTO LoadTestPerformanceCounterSample
(
	LoadTestRunId,
	TestRunIntervalId,
	InstanceId,
	ComputedValue,
	RawValue,
	BaseValue,
	CounterFrequency,
	SystemFrequency,
	SampleTimeStamp,
	SampleTimeStamp100nSec,
	CounterType,
	ThresholdRuleResult,
	ThresholdRuleMessageId
)
VALUES(
	@LoadTestRunId,
	@TestRunIntervalId,
	@InstanceId,
	@ComputedValue,
	@RawValue,
	@BaseValue,
	@CounterFrequency,
	@SystemFrequency,
	@SampleTimeStamp,
	@SampleTimeStamp100nSec,
	@CounterType,
	@ThresholdRuleResult,
	@ThresholdRuleMessageId
)
GO
GRANT EXECUTE ON  [dbo].[Prc_InsertSample] TO [public]
GO
