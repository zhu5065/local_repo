CREATE TABLE [dbo].[LoadTestPerformanceCounter]
(
[LoadTestRunId] [int] NOT NULL,
[CounterCategoryId] [int] NOT NULL,
[CounterId] [int] NOT NULL,
[CounterName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[HigherIsBetter] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestPerformanceCounter] ADD CONSTRAINT [PK__LoadTest__73AD120C59063A47] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [CounterId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [LoadTestCounterNameIndex] ON [dbo].[LoadTestPerformanceCounter] ([CounterName]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestPerformanceCounter] ADD CONSTRAINT [FK__LoadTestP__LoadT__778AC167] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[LoadTestPerformanceCounter] TO [public]
GRANT INSERT ON  [dbo].[LoadTestPerformanceCounter] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestPerformanceCounter] TO [public]
GO
