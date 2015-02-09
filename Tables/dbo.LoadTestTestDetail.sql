CREATE TABLE [dbo].[LoadTestTestDetail]
(
[LoadTestRunId] [int] NOT NULL,
[TestDetailId] [int] NOT NULL,
[TimeStamp] [datetime] NOT NULL,
[TestCaseId] [int] NOT NULL,
[ElapsedTime] [float] NOT NULL,
[AgentId] [int] NOT NULL,
[BrowserId] [int] NULL,
[NetworkId] [int] NULL,
[Outcome] [tinyint] NULL,
[TestLogId] [int] NULL,
[UserId] [int] NULL,
[EndTime] [datetime] NULL,
[InMeasurementInterval] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestTestDetail] ADD CONSTRAINT [PK__LoadTest__53EF100625869641] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [TestDetailId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [LoadTestTestDetail7] ON [dbo].[LoadTestTestDetail] ([LoadTestRunId], [NetworkId]) INCLUDE ([TestDetailId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [LoadTestTestDetail5] ON [dbo].[LoadTestTestDetail] ([LoadTestRunId], [TestCaseId]) INCLUDE ([AgentId], [BrowserId], [NetworkId], [TestDetailId], [TestLogId], [UserId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [LoadTestTestDetail6] ON [dbo].[LoadTestTestDetail] ([LoadTestRunId], [TestCaseId], [EndTime], [Outcome], [TimeStamp], [TestDetailId], [AgentId], [NetworkId], [UserId]) INCLUDE ([ElapsedTime], [TestLogId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [LoadTestTestDetail4] ON [dbo].[LoadTestTestDetail] ([LoadTestRunId], [TestCaseId], [InMeasurementInterval], [ElapsedTime] DESC) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[LoadTestTestDetail] TO [public]
GRANT INSERT ON  [dbo].[LoadTestTestDetail] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestTestDetail] TO [public]
GO
