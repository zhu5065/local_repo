CREATE TABLE [dbo].[LoadTestTestSummaryData]
(
[LoadTestRunId] [int] NOT NULL,
[TestCaseId] [int] NOT NULL,
[TestsRun] [int] NOT NULL,
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
ALTER TABLE [dbo].[LoadTestTestSummaryData] ADD CONSTRAINT [PK__LoadTest__719FE13934C8D9D1] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [TestCaseId]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[LoadTestTestSummaryData] TO [public]
GRANT INSERT ON  [dbo].[LoadTestTestSummaryData] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestTestSummaryData] TO [public]
GO
