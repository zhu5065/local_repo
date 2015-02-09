CREATE TABLE [dbo].[LoadTestSystemUnderTestTag]
(
[LoadTestRunId] [int] NOT NULL,
[SystemUnderTestId] [int] NOT NULL,
[MachineTag] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestSystemUnderTestTag] ADD CONSTRAINT [FK__LoadTestS__LoadT__02FC7413] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[LoadTestSystemUnderTestTag] TO [public]
GRANT INSERT ON  [dbo].[LoadTestSystemUnderTestTag] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestSystemUnderTestTag] TO [public]
GO
