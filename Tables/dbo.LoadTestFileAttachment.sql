CREATE TABLE [dbo].[LoadTestFileAttachment]
(
[LoadTestRunId] [int] NOT NULL,
[FileAttachmentId] [int] NOT NULL,
[MachineName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Filename] [nvarchar] (260) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FileSize] [bigint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestFileAttachment] ADD CONSTRAINT [PK__LoadTest__09652F35440B1D61] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [FileAttachmentId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestFileAttachment] ADD CONSTRAINT [FK__LoadTestF__LoadT__05D8E0BE] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[LoadTestFileAttachment] TO [public]
GRANT INSERT ON  [dbo].[LoadTestFileAttachment] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestFileAttachment] TO [public]
GO
