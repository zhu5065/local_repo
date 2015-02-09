CREATE TABLE [dbo].[LoadTestTransactionSummaryData]
(
[LoadTestRunId] [int] NOT NULL,
[TransactionId] [int] NOT NULL,
[TransactionCount] [int] NOT NULL,
[Average] [float] NOT NULL,
[Minimum] [float] NOT NULL,
[Maximum] [float] NOT NULL,
[Percentile90] [float] NULL,
[Percentile95] [float] NULL,
[Percentile99] [float] NULL,
[Median] [float] NULL,
[StandardDeviation] [float] NULL,
[AvgTransactionTime] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestTransactionSummaryData] ADD CONSTRAINT [PK__LoadTest__89EBA63638996AB5] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [TransactionId]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[LoadTestTransactionSummaryData] TO [public]
GRANT INSERT ON  [dbo].[LoadTestTransactionSummaryData] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestTransactionSummaryData] TO [public]
GO
