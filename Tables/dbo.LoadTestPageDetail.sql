CREATE TABLE [dbo].[LoadTestPageDetail]
(
[LoadTestRunId] [int] NOT NULL,
[PageDetailId] [int] NOT NULL,
[TestDetailId] [int] NOT NULL,
[TimeStamp] [datetime] NOT NULL,
[PageId] [int] NOT NULL,
[ResponseTime] [float] NOT NULL,
[ResponseTimeGoal] [float] NOT NULL,
[GoalExceeded] [bit] NOT NULL,
[EndTime] [datetime] NULL,
[Outcome] [tinyint] NULL,
[InMeasurementInterval] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestPageDetail] ADD CONSTRAINT [PK__LoadTest__97931F3D29572725] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [PageDetailId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [LoadTestPageDetail6] ON [dbo].[LoadTestPageDetail] ([LoadTestRunId], [PageId], [GoalExceeded], [InMeasurementInterval]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [LoadTestPageDetail4] ON [dbo].[LoadTestPageDetail] ([LoadTestRunId], [PageId], [InMeasurementInterval], [ResponseTime] DESC) INCLUDE ([ResponseTimeGoal], [TestDetailId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [LoadTestPageDetail5] ON [dbo].[LoadTestPageDetail] ([LoadTestRunId], [PageId], [TestDetailId], [EndTime], [Outcome], [TimeStamp], [PageDetailId]) INCLUDE ([ResponseTime]) ON [PRIMARY]
GO
CREATE STATISTICS [hind_98099390_1A_3A_5A_6D] ON [dbo].[LoadTestPageDetail] ([LoadTestRunId], [TestDetailId], [PageId], [ResponseTime])
GO
CREATE STATISTICS [hind_98099390_6A] ON [dbo].[LoadTestPageDetail] ([ResponseTime])
GO
GRANT SELECT ON  [dbo].[LoadTestPageDetail] TO [public]
GRANT INSERT ON  [dbo].[LoadTestPageDetail] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestPageDetail] TO [public]
GO
