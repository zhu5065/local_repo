CREATE TABLE [dbo].[LoadTestScenario]
(
[LoadTestRunId] [int] NOT NULL,
[ScenarioId] [int] NOT NULL,
[ScenarioName] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestScenario] ADD CONSTRAINT [PK__LoadTest__0C60F8886A30C649] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [ScenarioId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestScenario] ADD CONSTRAINT [FK__LoadTestS__LoadT__7D439ABD] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[LoadTestScenario] TO [public]
GRANT INSERT ON  [dbo].[LoadTestScenario] TO [public]
GRANT DELETE ON  [dbo].[LoadTestScenario] TO [public]
GO
