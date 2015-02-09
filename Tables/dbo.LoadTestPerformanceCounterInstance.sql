CREATE TABLE [dbo].[LoadTestPerformanceCounterInstance]
(
[LoadTestRunId] [int] NOT NULL,
[CounterId] [int] NOT NULL,
[InstanceId] [int] NOT NULL,
[LoadTestItemId] [int] NULL,
[InstanceName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CumulativeValue] [real] NULL,
[OverallThresholdRuleResult] [tinyint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestPerformanceCounterInstance] ADD CONSTRAINT [PK__LoadTest__C97A8C045EBF139D] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [InstanceId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [LoadTestInstanceNameIndex] ON [dbo].[LoadTestPerformanceCounterInstance] ([InstanceName]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestPerformanceCounterInstance] ADD CONSTRAINT [FK__LoadTestP__LoadT__797309D9] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[LoadTestPerformanceCounterInstance] TO [public]
GRANT INSERT ON  [dbo].[LoadTestPerformanceCounterInstance] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestPerformanceCounterInstance] TO [public]
GO
