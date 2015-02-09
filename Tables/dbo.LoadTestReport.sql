CREATE TABLE [dbo].[LoadTestReport]
(
[ReportId] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LoadTestName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastRunId] [int] NOT NULL,
[SelectNewRuns] [bit] NOT NULL,
[LastModified] [datetime] NOT NULL,
[LastModifiedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ReportType] [tinyint] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestReport] ADD CONSTRAINT [PK__LoadTest__D5BD480509A971A2] PRIMARY KEY CLUSTERED  ([ReportId]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[LoadTestReport] TO [public]
GRANT INSERT ON  [dbo].[LoadTestReport] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestReport] TO [public]
GO
