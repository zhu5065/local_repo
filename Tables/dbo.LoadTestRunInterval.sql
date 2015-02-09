CREATE TABLE [dbo].[LoadTestRunInterval]
(
[LoadTestRunId] [int] NOT NULL,
[TestRunIntervalId] [int] NOT NULL,
[IntervalStartTime] [datetime] NOT NULL,
[IntervalEndTime] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestRunInterval] ADD CONSTRAINT [PK__LoadTest__A57FD6D36754599E] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [TestRunIntervalId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestRunInterval] ADD CONSTRAINT [FK__LoadTestR__LoadT__7C4F7684] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[LoadTestRunInterval] TO [public]
GRANT INSERT ON  [dbo].[LoadTestRunInterval] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestRunInterval] TO [public]
GO
