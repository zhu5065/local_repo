CREATE TABLE [dbo].[LoadTestFileAttachmentChunk]
(
[LoadTestRunId] [int] NOT NULL,
[FileAttachmentId] [int] NOT NULL,
[StartOffset] [bigint] NOT NULL,
[EndOffset] [bigint] NOT NULL,
[ChunkLength] [bigint] NOT NULL,
[ChunkBytes] [image] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestFileAttachmentChunk] ADD CONSTRAINT [PK__LoadTest__C21E6B1247DBAE45] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [FileAttachmentId], [StartOffset]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestFileAttachmentChunk] ADD CONSTRAINT [FK__LoadTestF__LoadT__06CD04F7] FOREIGN KEY ([LoadTestRunId]) REFERENCES [dbo].[LoadTestRun] ([LoadTestRunId])
GO
GRANT SELECT ON  [dbo].[LoadTestFileAttachmentChunk] TO [public]
GRANT INSERT ON  [dbo].[LoadTestFileAttachmentChunk] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestFileAttachmentChunk] TO [public]
GO
