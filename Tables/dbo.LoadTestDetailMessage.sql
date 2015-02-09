CREATE TABLE [dbo].[LoadTestDetailMessage]
(
[LoadTestRunId] [int] NOT NULL,
[LoadTestDetailMessageId] [int] NOT NULL,
[TestDetailId] [int] NOT NULL,
[PageDetailId] [int] NULL,
[MessageTypeId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestDetailMessage] ADD CONSTRAINT [PK__LoadTest__1473443130F848ED] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [LoadTestDetailMessageId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ix_LoadTestDetailMessage_LoadTestRunId_TestDetailId_PageDetailId__MessageTypeId] ON [dbo].[LoadTestDetailMessage] ([LoadTestRunId], [TestDetailId], [PageDetailId], [MessageTypeId]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[LoadTestDetailMessage] TO [public]
GRANT INSERT ON  [dbo].[LoadTestDetailMessage] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestDetailMessage] TO [public]
GO
