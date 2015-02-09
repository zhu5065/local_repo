CREATE TABLE [dbo].[WebLoadTestRequestMap]
(
[LoadTestRunId] [int] NOT NULL,
[RequestId] [int] NOT NULL,
[TestCaseId] [int] NOT NULL,
[RequestUri] [nvarchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ResponseTimeGoal] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[WebLoadTestRequestMap] ADD CONSTRAINT [PK__WebLoadT__9F8510876FE99F9F] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [RequestId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ix_WebLoadTestRequestMap_RequestId_LoadTestRunId_TestCaseId] ON [dbo].[WebLoadTestRequestMap] ([RequestId], [LoadTestRunId]) INCLUDE ([TestCaseId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[WebLoadTestRequestMap] ADD CONSTRAINT [FK__WebLoadTe__LoadT__7F2BE32F] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[WebLoadTestRequestMap] TO [public]
GRANT INSERT ON  [dbo].[WebLoadTestRequestMap] TO [public]
GRANT UPDATE ON  [dbo].[WebLoadTestRequestMap] TO [public]
GO
