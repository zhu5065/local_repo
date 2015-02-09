CREATE TABLE [dbo].[LoadTestMessage]
(
[LoadTestRunId] [int] NOT NULL,
[AgentId] [int] NOT NULL,
[MessageId] [int] NOT NULL,
[MessageType] [tinyint] NOT NULL,
[MessageText] [nvarchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubType] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StackTrace] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MessageTimeStamp] [datetime] NOT NULL,
[TestCaseId] [int] NULL,
[RequestId] [int] NULL,
[TestLogId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestMessage] ADD CONSTRAINT [PK__LoadTest__B8DBD2635070F446] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [AgentId], [MessageId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestMessage] ADD CONSTRAINT [FK__LoadTestM__LoadT__75A278F5] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[LoadTestMessage] TO [public]
GRANT INSERT ON  [dbo].[LoadTestMessage] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestMessage] TO [public]
GO
