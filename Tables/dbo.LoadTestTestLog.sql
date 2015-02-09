CREATE TABLE [dbo].[LoadTestTestLog]
(
[LoadTestRunId] [int] NOT NULL,
[AgentId] [int] NOT NULL,
[TestCaseId] [int] NOT NULL,
[TestLogId] [int] NOT NULL,
[TestLog] [image] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestTestLog] ADD CONSTRAINT [PK__LoadTest__A3F1E91C117F9D94] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [TestLogId], [AgentId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestTestLog] ADD CONSTRAINT [FK__LoadTestT__LoadT__03F0984C] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[LoadTestTestLog] TO [public]
GRANT INSERT ON  [dbo].[LoadTestTestLog] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestTestLog] TO [public]
GO
