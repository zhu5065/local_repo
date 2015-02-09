CREATE TABLE [dbo].[LoadTestPageSummaryData]
(
[LoadTestRunId] [int] NOT NULL,
[PageId] [int] NOT NULL,
[PageCount] [int] NOT NULL,
[Average] [float] NOT NULL,
[Minimum] [float] NOT NULL,
[Maximum] [float] NOT NULL,
[Percentile90] [float] NULL,
[Percentile95] [float] NULL,
[Percentile99] [float] NULL,
[Median] [float] NULL,
[StandardDeviation] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestPageSummaryData] ADD CONSTRAINT [PK__LoadTest__70E9CE803C69FB99] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [PageId]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[LoadTestPageSummaryData] TO [public]
GRANT INSERT ON  [dbo].[LoadTestPageSummaryData] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestPageSummaryData] TO [public]
GO
