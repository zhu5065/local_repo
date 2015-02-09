CREATE TABLE [dbo].[LoadTestReportPage]
(
[PageId] [int] NOT NULL IDENTITY(1, 1),
[ReportId] [int] NOT NULL,
[CategoryName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CounterName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestReportPage] ADD CONSTRAINT [PK__LoadTest__C565B104114A936A] PRIMARY KEY CLUSTERED  ([PageId]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[LoadTestReportPage] TO [public]
GRANT INSERT ON  [dbo].[LoadTestReportPage] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestReportPage] TO [public]
GO
