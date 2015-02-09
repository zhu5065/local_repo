CREATE TABLE [dbo].[LoadTestSystemUnderTest]
(
[LoadTestRunId] [int] NOT NULL,
[SystemUnderTestId] [int] NOT NULL,
[MachineName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestSystemUnderTest] ADD CONSTRAINT [PK__LoadTest__EFADAD6520C1E124] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [SystemUnderTestId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestSystemUnderTest] ADD CONSTRAINT [FK__LoadTestS__LoadT__02084FDA] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[LoadTestSystemUnderTest] TO [public]
GRANT INSERT ON  [dbo].[LoadTestSystemUnderTest] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestSystemUnderTest] TO [public]
GO
