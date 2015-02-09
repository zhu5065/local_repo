CREATE TABLE [dbo].[LoadTestRun]
(
[LoadTestRunId] [int] NOT NULL IDENTITY(1, 1),
[LoadTestName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RunId] [char] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StartTime] [datetime] NULL,
[EndTime] [datetime] NULL,
[RunDuration] [int] NOT NULL,
[WarmupTime] [int] NOT NULL,
[RunSettingUsed] [nvarchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsLocalRun] [bit] NOT NULL,
[ControllerName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Outcome] [nvarchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LoadTest] [image] NULL,
[Comment] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LoadTestSchemaRev] [int] NULL,
[CooldownTime] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestRun] ADD CONSTRAINT [PK__LoadTest__2CBF95904AB81AF0] PRIMARY KEY CLUSTERED  ([LoadTestRunId]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[LoadTestRun] TO [public]
GRANT INSERT ON  [dbo].[LoadTestRun] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestRun] TO [public]
GO
