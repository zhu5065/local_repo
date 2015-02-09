CREATE TABLE [dbo].[LoadTestRunAgent]
(
[LoadTestRunId] [int] NOT NULL,
[AgentId] [int] NOT NULL,
[AgentName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestRunAgent] ADD CONSTRAINT [PK__LoadTest__2513AE6F6477ECF3] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [AgentId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestRunAgent] ADD CONSTRAINT [FK__LoadTestR__LoadT__7B5B524B] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[LoadTestRunAgent] TO [public]
GRANT INSERT ON  [dbo].[LoadTestRunAgent] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestRunAgent] TO [public]
GO
