CREATE TABLE [dbo].[WebLoadTestTransaction]
(
[LoadTestRunId] [int] NOT NULL,
[TransactionId] [int] NOT NULL,
[TestCaseId] [int] NOT NULL,
[TransactionName] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Goal] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[WebLoadTestTransaction] ADD CONSTRAINT [PK__WebLoadT__89EBA63672C60C4A] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [TransactionId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[WebLoadTestTransaction] ADD CONSTRAINT [FK__WebLoadTe__LoadT__00200768] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[WebLoadTestTransaction] TO [public]
GRANT INSERT ON  [dbo].[WebLoadTestTransaction] TO [public]
GRANT UPDATE ON  [dbo].[WebLoadTestTransaction] TO [public]
GO
