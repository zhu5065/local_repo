CREATE TABLE [dbo].[LoadTestBrowsers]
(
[LoadTestRunId] [int] NOT NULL,
[BrowserId] [int] NOT NULL,
[BrowserName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestBrowsers] ADD CONSTRAINT [PK__LoadTest__28838DB81920BF5C] PRIMARY KEY CLUSTERED  ([LoadTestRunId], [BrowserId]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[LoadTestBrowsers] TO [public]
GRANT INSERT ON  [dbo].[LoadTestBrowsers] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestBrowsers] TO [public]
GO
