CREATE TABLE [dbo].[LoadTestSqlTrace]
(
[LoadTestRunId] [int] NOT NULL,
[TextData] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Duration] [bigint] NULL,
[StartTime] [datetime] NULL,
[EndTime] [datetime] NULL,
[Reads] [bigint] NULL,
[Writes] [bigint] NULL,
[CPU] [int] NULL,
[EventClass] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [LoadTestSqlTraceIndex] ON [dbo].[LoadTestSqlTrace] ([LoadTestRunId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestSqlTrace] ADD CONSTRAINT [FK__LoadTestS__LoadT__01142BA1] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[LoadTestSqlTrace] TO [public]
GRANT INSERT ON  [dbo].[LoadTestSqlTrace] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestSqlTrace] TO [public]
GO
