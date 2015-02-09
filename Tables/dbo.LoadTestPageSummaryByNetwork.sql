CREATE TABLE [dbo].[LoadTestPageSummaryByNetwork]
(
[LoadTestRunId] [int] NOT NULL,
[PageId] [int] NOT NULL,
[NetworkId] [int] NOT NULL,
[PageCount] [int] NOT NULL,
[Average] [float] NOT NULL,
[Minimum] [float] NOT NULL,
[Maximum] [float] NOT NULL,
[Percentile90] [float] NULL,
[Percentile95] [float] NULL,
[Percentile99] [float] NULL,
[Goal] [float] NULL,
[PagesMeetingGoal] [int] NULL,
[Median] [float] NULL,
[StandardDeviation] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestPageSummaryByNetwork] ADD CONSTRAINT [PK__LoadTest__FAA41BFB403A8C7D] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [PageId], [NetworkId]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[LoadTestPageSummaryByNetwork] TO [public]
GRANT INSERT ON  [dbo].[LoadTestPageSummaryByNetwork] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestPageSummaryByNetwork] TO [public]
GO
