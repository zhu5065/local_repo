CREATE TABLE [dbo].[LoadTestReportRuns]
(
[ReportId] [int] NOT NULL,
[LoadTestRunId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadTestReportRuns] ADD CONSTRAINT [PK__LoadTest__C776B15C0D7A0286] PRIMARY KEY CLUSTERED  ([ReportId], [LoadTestRunId]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[LoadTestReportRuns] TO [public]
GRANT INSERT ON  [dbo].[LoadTestReportRuns] TO [public]
GRANT UPDATE ON  [dbo].[LoadTestReportRuns] TO [public]
GO
