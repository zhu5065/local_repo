SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[prc_QueryLoadTestReports]    
AS
SET NOCOUNT ON

-- Return Report Info
SELECT ReportId,
       ReportType,
       Name,
       LoadTestName,
       Description,
       SelectNewRuns,
       LastModified,
       LastModifiedBy
FROM   LoadTestReport
WHERE  Name != 'LOADTEST_RUNCOMPARISON_REPORT_DEFAULT'
       AND Name != 'LOADTEST_TREND_REPORT_DEFAULT'
ORDER BY LastModified DESC
GO
GRANT EXECUTE ON  [dbo].[prc_QueryLoadTestReports] TO [public]
GO
