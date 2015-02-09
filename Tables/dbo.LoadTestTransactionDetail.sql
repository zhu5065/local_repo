CREATE TABLE [dbo].[LoadTestTransactionDetail]
(
[LoadTestRunId] [int] NOT NULL,
[TransactionDetailId] [int] NOT NULL,
[TestDetailId] [int] NOT NULL,
[TimeStamp] [datetime] NOT NULL,
[TransactionId] [int] NOT NULL,
[ElapsedTime] [float] NOT NULL,
[EndTime] [datetime] NULL,
[InMeasurementInterval] [bit] NULL,
[ResponseTime] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestTransactionDetail] ADD CONSTRAINT [PK__LoadTest__5394B26C2D27B809] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [TransactionDetailId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [LoadTestTransactionDetail5] ON [dbo].[LoadTestTransactionDetail] ([LoadTestRunId], [TransactionId], [EndTime], [TimeStamp], [TestDetailId], [TransactionDetailId]) INCLUDE ([ElapsedTime]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [LoadTestTransactionDetail4] ON [dbo].[LoadTestTransactionDetail] ([LoadTestRunId], [TransactionId], [InMeasurementInterval], [ResponseTime] DESC, [TestDetailId]) INCLUDE ([EndTime], [TimeStamp]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[LoadTestTransactionDetail] TO [public]
GRANT INSERT ON  [dbo].[LoadTestTransactionDetail] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestTransactionDetail] TO [public]
GO
