CREATE TABLE [dbo].[LoadTestCase]
(
[LoadTestRunId] [int] NOT NULL,
[ScenarioId] [int] NOT NULL,
[TestCaseId] [int] NOT NULL,
[TestCaseName] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TestElement] [image] NULL,
[TestType] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestCase] ADD CONSTRAINT [PK__LoadTest__719FE1394D94879B] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [TestCaseId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestCase] ADD CONSTRAINT [FK__LoadTestC__LoadT__74AE54BC] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[LoadTestCase] TO [public]
GRANT INSERT ON  [dbo].[LoadTestCase] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestCase] TO [public]
GO
