CREATE TABLE [dbo].[LoadTestNetworks]
(
[LoadTestRunId] [int] NOT NULL,
[NetworkId] [int] NOT NULL,
[NetworkName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestNetworks] ADD CONSTRAINT [PK__LoadTest__8862C2281CF15040] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [NetworkId]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[LoadTestNetworks] TO [public]
GRANT INSERT ON  [dbo].[LoadTestNetworks] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestNetworks] TO [public]
GO
