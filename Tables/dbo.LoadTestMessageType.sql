CREATE TABLE [dbo].[LoadTestMessageType]
(
[LoadTestRunId] [int] NOT NULL,
[MessageTypeId] [int] NOT NULL,
[MessageType] [tinyint] NOT NULL,
[SubType] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestMessageType] ADD CONSTRAINT [PK__LoadTest__95058BBB5629CD9C] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [MessageTypeId]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[LoadTestMessageType] TO [public]
GRANT INSERT ON  [dbo].[LoadTestMessageType] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestMessageType] TO [public]
GO
