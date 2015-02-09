CREATE TABLE [dbo].[LoadTestDataCollectorLog]
(
[LoadTestRunId] [int] NOT NULL,
[DataCollectorLogId] [int] NOT NULL,
[DataCollectorDisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MachineName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TimestampColumnName] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DurationColumnName] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreateTableFormatString] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestDataCollectorLog] ADD CONSTRAINT [PK__LoadTest__682469E415502E78] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [DataCollectorLogId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestDataCollectorLog] ADD CONSTRAINT [FK__LoadTestD__LoadT__04E4BC85] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[LoadTestDataCollectorLog] TO [public]
GRANT INSERT ON  [dbo].[LoadTestDataCollectorLog] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestDataCollectorLog] TO [public]
GO
