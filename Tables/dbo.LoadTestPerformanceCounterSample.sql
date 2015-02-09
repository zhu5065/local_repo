CREATE TABLE [dbo].[LoadTestPerformanceCounterSample]
(
[LoadTestRunId] [int] NOT NULL,
[TestRunIntervalId] [int] NOT NULL,
[InstanceId] [int] NOT NULL,
[ComputedValue] [real] NULL,
[RawValue] [bigint] NOT NULL,
[BaseValue] [bigint] NOT NULL,
[CounterFrequency] [bigint] NOT NULL,
[SystemFrequency] [bigint] NOT NULL,
[SampleTimeStamp] [bigint] NOT NULL,
[SampleTimeStamp100nSec] [bigint] NOT NULL,
[CounterType] [int] NOT NULL,
[ThresholdRuleResult] [tinyint] NOT NULL,
[ThresholdRuleMessageId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestPerformanceCounterSample] ADD CONSTRAINT [PK__LoadTest__EB23874A619B8048] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [TestRunIntervalId], [InstanceId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [LoadTestSampleInstanceIndex] ON [dbo].[LoadTestPerformanceCounterSample] ([LoadTestRunId], [InstanceId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestPerformanceCounterSample] ADD CONSTRAINT [FK__LoadTestP__LoadT__7A672E12] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[LoadTestPerformanceCounterSample] TO [public]
GRANT INSERT ON  [dbo].[LoadTestPerformanceCounterSample] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestPerformanceCounterSample] TO [public]
GO
