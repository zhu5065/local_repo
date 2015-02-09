CREATE TABLE [dbo].[LoadTestPerformanceCounterCategory]
(
[LoadTestRunId] [int] NOT NULL,
[CounterCategoryId] [int] NOT NULL,
[CategoryName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MachineName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StartTimeStamp100nSec] [bigint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestPerformanceCounterCategory] ADD CONSTRAINT [PK__LoadTest__D415D2CC5BE2A6F2] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [CounterCategoryId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [LoadTestCategoryNameIndex] ON [dbo].[LoadTestPerformanceCounterCategory] ([CategoryName]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestPerformanceCounterCategory] ADD CONSTRAINT [FK__LoadTestP__LoadT__787EE5A0] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[LoadTestPerformanceCounterCategory] TO [public]
GRANT INSERT ON  [dbo].[LoadTestPerformanceCounterCategory] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestPerformanceCounterCategory] TO [public]
GO
