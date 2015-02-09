CREATE TABLE [dbo].[LoadTestThresholdMessage]
(
[LoadTestRunId] [int] NOT NULL,
[TestRunIntervalId] [int] NOT NULL,
[CounterInstanceId] [int] NOT NULL,
[MessageId] [int] NOT NULL,
[MessageText] [nvarchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestThresholdMessage] ADD CONSTRAINT [PK__LoadTest__F0385559534D60F1] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [MessageId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestThresholdMessage] ADD CONSTRAINT [FK__LoadTestT__LoadT__76969D2E] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[LoadTestThresholdMessage] TO [public]
GRANT INSERT ON  [dbo].[LoadTestThresholdMessage] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestThresholdMessage] TO [public]
GO
