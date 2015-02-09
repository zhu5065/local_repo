CREATE TABLE [dbo].[WebLoadTestErrorDetail]
(
[LoadTestRunId] [int] NOT NULL,
[AgentId] [int] NOT NULL,
[MessageId] [int] NOT NULL,
[WebTestRequestResult] [image] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[WebLoadTestErrorDetail] ADD CONSTRAINT [PK__WebLoadT__B8DBD2636D0D32F4] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [AgentId], [MessageId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[WebLoadTestErrorDetail] ADD CONSTRAINT [FK__WebLoadTe__LoadT__7E37BEF6] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[WebLoadTestErrorDetail] TO [public]
GRANT INSERT ON  [dbo].[WebLoadTestErrorDetail] TO [public]
GRANT UPDATE ON  [dbo].[WebLoadTestErrorDetail] TO [public]
GO
